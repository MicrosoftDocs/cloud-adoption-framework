$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-AllMatches {
    [CmdletBinding()]    
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]] $files,
        [string[]] $expressions,
        [ValidateSet('Words', 'WordsWithCasing', 'Verbatim', 'LinkValidation', 'PotentialIssues')]
        [string] $validationType,
        [bool] $forceSuccess = $false,
        [bool] $disablePrefixes = $false
    )

    $useWordBoundaries = $false
    $ignoreUrlContents = $false
    $requireCasingMatch = $false
    $testLinks = $false

    switch -Exact ($validationType)
    {
        'Words' 
        { 
            $useWordBoundaries = $true
            $ignoreUrlContents = $true
            break 
        }
        'WordsWithCasing' 
        { 
            $useWordBoundaries = $true
            $ignoreUrlContents = $true
            $requireCasingMatch = $true
            break 
        }
        'Verbatim'
        { 
            break 
        }
        'LinkValidation' 
        { 
            $testLinks = $true
            break 
        }
        Default { throw "validationType is invalid"}
    }

    $count = 0
    $fileCount = 0

    foreach ($file in $files)
    {
        $fileCount++
          [TestLog]::WriteFilename($file, "Testing matches for", $fileCount)

        $result = Test-Match $file $expressions `
            -UseWordBoundaries $useWordBoundaries `
            -IgnoreUrlContents $ignoreUrlContents `
            -RequireCasingMatch $requireCasingMatch `
            -TestLinks $testLinks `
            -DisablePrefixes $disablePrefixes

        try {
            $count += $result
        }
        catch {
            [TestLog]::WriteException($_, $file, $($MyInvocation).MyCommand)
        }
    }

    if ($forceSuccess)
    {
        return 0
    }

    return $count
}

function Test-Match(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions,
    [bool] $useWordBoundaries, 
    [bool] $ignoreUrlContents,
    [bool] $requireCasingMatch,
    [bool] $testLinks,
    [bool] $disablePrefixes
    )
{
    $count = 0

    $page = [Page]::new($file)
    $text = $page.GetText()
    
    if ($testLinks)
    {
        $expressions = @($(Get-RegexForUrl))
    }
    else
    {
        if ($file.Name -like '*.md')
        {
            # TODO: Handle this differently.
            [TestLog]::WriteSuperVerbose("REMOVING METADATA...")
            $text = $page.GetTextWithoutMetadata()
        }
        
        if ($ignoreUrlContents)
        {
            $text = Remove-Urls $text 
        }

        if ($requireCasingMatch)
        {
            $text = Remove-LocalPaths $text
            $text = Remove-LocalBookmarks $text
            $text = Remove-HtmlEntities $text
        }
        elseif ($useWordBoundaries)
        {
            $text = Remove-HtmlEntities $text
        }

          [TestLog]::WriteContents($text)
    }

    foreach ($originalExpression in $expressions)
    {
        if ($originalExpression.Trim().Length -eq 0) {
            continue
        }

        $expression = $originalExpression
        if ($expression.EndsWith('$') -and (-not $expression.EndsWith('\r?$')))
        {
            # Handle nonstandard .NET processing of $ (endline) character.
            $expression = "$($expression.Substring(0, $expression.Length - 1))\r?$"
              [TestLog]::WriteSuperVerbose("FIXED EXPRESSION: $expression")
        }

        if ($requireCasingMatch) 
        {
            #$expression = "(?i)(.{0,3})\b($originalExpression\b)"
            $expression = "(?i)([^\s]* *[\[\(""]?)\b($originalExpression\b)"
        }
        elseif ($useWordBoundaries)
        {
            $expression = "(?i)\b$originalExpression\b"
        }

          [TestLog]::WriteSuperVerbose("FINDING MATCHES FOR: $expression")
        $options = [Text.RegularExpressions.RegexOptions]::Multiline
        $matches = [Regex]::new($expression, $options).Matches($text)

        foreach ($match in $matches)
        {
            if ($testLinks)
            {
                $uri = $match.Value

                  [TestLog]::WriteSuperVerbose($uri)
                $result = Test-Uri $uri
                
                if ($result -ne 200)
                {
                    [TestLog]::WriteIssue("RESULT in $($file.Name): $result - $uri")
                    $count++
                }

                continue
            }

            # TODO: Is this still needed?
            $ignoredTermsMatches = [Regex]::new($(Get-RegexForIgnoredTerms), $options).Matches($text)
            $ignoredTerms = if ($ignoredTermsMatches.Count -gt 0) { $ignoredTermsMatches.Groups[0].Value } else { "" }

            if ($requireCasingMatch)
            {
                $prefix = $match.Groups[1].Value
                $value = $match.Groups[2].Value
                $firstCharacter = $originalExpression.Substring(0,1)
                $isUpper = ($firstCharacter -clike $firstCharacter.ToUpper())
                
                [TestLog]::WriteSuperVerbose("PREFIX: '$prefix'")
                [TestLog]::WriteSuperVerbose("VALUE: '$value'")
                
                if ($ignoredTerms -match "\b$value\b")
                {
                    [TestLog]::WriteSuperVerbose("Ignored match '$($match.Value)' found in $($file.FullName)")
                    continue
                }

                $midSentenceRegex = $(Get-RegexForSentenceMiddlePrefixes)
                $startingRegex = $(Get-RegexForSentenceStartPrefixes)

                if ($disablePrefixes)
                {
                    $midsentenceRegex = 'disablePrefixes'
                    $startingRegex = 'disablePrefixes'
                }

                if ($isUpper -or ($prefix -match $midsentenceRegex))                {
                    
                    # Either already uppercase, or appears midsentence, 
                    # so compare directly.
                    
                    $exp = $originalExpression
               
                }
                elseif (($prefix.Length -eq 0) -or ($prefix -match $startingRegex))
                {
                    $end = $originalExpression.Substring(1)
                    $exp = "$($firstCharacter.ToUpper())$end"
                }
            else
            {
                    [TestLog]::WriteError("UNKNOWN PREFIX '$prefix' IN '$prefix$value' for $($file.FullName)")
                    $count++
                }

                [TestLog]::WriteSuperVerbose("$value -cmatch $exp")
                if (-not ($value -cmatch $exp))
                {
                    if ($prefix -eq 'see [')
                    {
                        [TestLog]::WriteLine("FOUND: see [", 'Red', $false)
                    }
                    
                    [TestLog]::WriteIssue("Case mismatch '$value' in $($file.FullName)")
                    [TestLog]::WriteLine("    '$prefix'", 'DarkGray', $false)
                    $count++
                }
            
                continue                
            }

            if ($useWordBoundaries)
            {
                if ($ignoredTerms -match "\b$value\b")
                {
                    [TestLog]::WriteSuperVerbose("Ignored match '$($match.Value)' found in $($file.FullName)")
                    continue
                }

                Write-MatchInfo $file.FullName $expression $match.Value
                $count++      # TODO: Verify this is correct
            }
            else
            {
                Write-MatchInfo $file.FullName $expression $match.Value
                $count++
            }
        }
    }

    return $count
}

function Write-MatchInfo(
    [string] $fileName, 
    [string] $expression, 
    [string] $value)
{
    if ($value.Length -gt 100)
    {
        $value = "$($value.Substring(0,100))..."
    }
    
    [TestLog]::WriteIssue("Match '$value' found for '$expression' in '$fileName'")
    [TestLog]::WriteSuperVerbose("    EXPRESSION: $expression")
    [TestLog]::WriteSuperVerbose("    VALUE: $value")
}

function Remove-Urls(
    [string]$text) 
{
      [TestLog]::WriteSuperVerbose("REMOVING URLs...")
    return (Remove-MatchesUsingToken $(Get-RegexForUrl) $text)
}

function Remove-LocalPaths(
    [string] $text) 
{
      [TestLog]::WriteSuperVerbose("REMOVING LOCAL PATHS...")

    return (Remove-MatchesUsingToken $(Get-RegexForLocalPath) $text)
}

function Remove-LocalBookmarks(
    [string] $text)
{
      [TestLog]::WriteSuperVerbose("REMOVING LOCAL BOOKMARKS...")

    return (Remove-Matches $(Get-RegexForLocalBookmark) $text)
}

function Remove-MatchesUsingToken(
    [string] $expression,
    [string] $text
)
{
    $token = "replace-match-token"
    $result = $text
    $matches = [Regex]::new($expression).Matches($text)

    foreach ($match in $matches)
    {
        $result = $result.Replace("$($match.Value)", $token)
    }

    $regex = Get-StringChopStart $(Get-RegexForUrlPath) '(?i)' 
    $expression = "(?i)$token/$regex"

    do {
        $text = $result 
        $matches = [Regex]::new($expression).Matches($text)

        foreach ($match in $matches)
        {
            $result = $result.Replace("$($match.Value)", $token)
        }
    } while ($matches.Count -gt 0)

    $result = $result.Replace($token, '')
    return $result
}

function Remove-HtmlEntities(
    [string]$text
)
{
      [TestLog]::WriteSuperVerbose("REMOVING HTML ENTITIES...")

    return Remove-Matches "(&nbsp;|&mdash;|&ndash)" $text $true
}

function Remove-Matches(
    [string] $expression,
    [string] $text,
    [bool] $replaceWithSpace = $false
)
{
    $result = $text
    $matches = [Regex]::new($expression).Matches($text)
    $token = if ($replaceWithSpace) { ' ' } else { '' }

    foreach ($match in $matches)
    {
        $result = $result.Replace($match.Value, $token)
    }

    return $result
}
