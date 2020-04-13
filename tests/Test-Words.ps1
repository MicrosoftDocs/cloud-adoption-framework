$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-AllMatches {
    [CmdletBinding()]    
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]] $files,
        [string[]] $expressions,
        [bool] $ignoreUrlContents = $false,
        [bool] $requireCasingMatch = $false,
        [bool] $testLinks = $false
    )

    $count = 0
    
    foreach ($file in $files)
    {
        $result = Test-Match $file $expressions $ignoreUrlContents $requireCasingMatch $testLinks
        $count += $result
    }

    return $count
}

function Test-Match(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions, 
    [bool] $ignoreUrlContents = $false,
    [bool] $requireCasingMatch = $false,
    [bool] $testLinks = $false
    )
{
    $count = 0
    $text = Get-FileContents $file
    
    if ($testLinks)
    {
        $expressions = @($(Get-RegexForUrl))
    }
    elseif ($ignoreUrlContents)
    {
        $text = Remove-MarkdownUrls $text 
        $text = Remove-OtherUrls $text
        $text = Remove-ImagePaths $text
    }

    $text = Remove-NonbreakingSpaces $text

    foreach ($originalExpression in $expressions) {
    
        if ($originalExpression.Trim().Length -gt 0) {

            if ($requireCasingMatch) 
            {
                $expression = "(?i)$originalExpression"
            }
            elseif ($testLinks)
            {
                $expression = $originalExpression
            }
            else 
            {
                $expression = "(?i)\b$originalExpression\b"
            }

            $options = [Text.RegularExpressions.RegexOptions]::Multiline
            $matches = [regex]::new($expression, $options).Matches($text)

            foreach ($match in $matches) {
            
                if ($testLinks)
                {
                    $uri = $match.Value
                    $result = Test-Uri $uri

                    if ($result -ne 200)
                    {
                        Write-Host "RESULT in $($file.Name): $result - $uri"
                        $count++
                    }
                }
                elseif ($requireCasingMatch)
                {
                    if (-not ($match.Value -clike $originalExpression))
                    {
                        write-host "Case mismatch '$($match.Value)' in $($file.FullName)"
                        $count++
                    }
                }
                else
                {
                    $options = [Text.RegularExpressions.RegexOptions]::Multiline
                    $ignoredTermsMatches = [regex]::new($(Get-RegexForIgnoredTerms), $options).Matches($text)
                    $ignoredTerms = if ($ignoredTermsMatches.Count -gt 0) { $ignoredTermsMatches.Groups[0].Value } else { "" }

                    if ($ignoredTerms -notlike "* $($match.Value) *")
                    {
                        write-host "Match '$($match.Value)' found in $($file.FullName)"
                        $count++
                    }
                    else 
                    {
                        write-host "Ignored match '$($match.Value)' found in $($file.FullName)"
                    }
                }
            }
        }
    }

    return $count
}

function Remove-MarkdownUrls(
    [string]$text) 
{
    $result = $text
    $matches = [regex]::new($(Get-RegexForUrl)).Matches($text)

    foreach ($match in $matches)
    {
        $result = $result.Replace("$($match.Value))", ")")
    }

    return $result
}

function Remove-OtherUrls(
    [string]$text
)
{
    return Remove-Matches $(Get-RegexForUrl) $text
}

function Remove-ImagePaths(
    [string]$text) 
{
    return Remove-Matches $(Get-RegexForImagePath) $text
}

function Remove-NonbreakingSpaces(
    [string]$text
)
{
    return Remove-Matches "&nbsp;" $text
}
function Remove-Matches(
    [string] $expression,
    [string] $text
)
{
    $result = $text
    $matches = [regex]::new($expression).Matches($text)

    foreach ($match in $matches)
    {
        $result = $result.Replace($match.Value, "")
    }

    return $result
}
