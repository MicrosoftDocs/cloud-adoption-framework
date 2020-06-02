using namespace System.Collections.Generic
using namespace System.Collections.Specialized
using namespace System.IO
using namespace System.Text.RegularExpressions

. $here\Test-Includes.ps1

function Test-AllLocalPaths(
    [FileInfo[]] $files,
    [bool] $fixIssues = $false,
    [bool] $fixFormattingOnly = $false,
    [int] $maxDocumentsFailed = 10000
    )
{
    $global:termsNotFound = $null
    
    $fileCount = 0
    $failureCount = 0
    
    $watch = [System.Diagnostics.Stopwatch]::StartNew()

    foreach ($file in $files) {

        $fileCount++
        Write-Host "TEST: $file" -ForegroundColor Cyan
        [TestLog]::WriteFilename($file, 'Testing local paths in ', $fileCount)
        
        $success = Test-Paths $file $fixIssues $fixFormattingOnly
        # $count += $result
        if (!($success))
        {
            $failureCount++
            if ($failureCount -ge $maxDocumentsFailed)
            {
                break
            }
        }
    }

    $watch.Stop()

    [TestLog]::WriteLine('')
    [TestLog]::WriteLine('POTENTIAL ADDITIONS FOR TERM LIST:')

    foreach ($item in $global:termsNotFound.Keys)
    {
        [TestLog]::WriteLine("'$item'  # $($global:termsNotFound[$item])")
    }

    # [TestLog]::WriteLine("")
    # [TestLog]::WriteLine("FIRST WORDS:")

    # foreach ($item in $global:firstWords.Keys)
    # {
    #     [TestLog]::WriteLine("'$item'  # $($global:firstWords[$item])")
    # }

    [TestLog]::WriteLine("")
    [TestLog]::WriteLine("COUNT OF TERMS: $($global:termsNotFound.Count)")

    [TestLog]::WriteLine("")
    [TestLog]::WriteLine("DURATION FOR Test-AllLocalPaths: $($watch.Elapsed) ms")

    # [TestLog]::WriteLine("")
    # [TestLog]::WriteLine("AVERAGE COUNT PER PAGE: $($count / $fileCount)")

    return $failureCount
}

function Test-Paths(
    [FileSystemInfo] $file, 
    [bool] $fixIssues = $false,
    [bool] $fixFormattingOnly = $false,
    [string] $textOverride = '')
{
    if ($null -eq $global:termsNotFound)
    {
        $global:termsNotFound = [SortedDictionary[string, int]]::new()
        $global:firstWords = [SortedDictionary[string, int]]::new()
    }

    $page = (!$textOverride) ? [Page]::new($file) : [Page]::new($textOverride)

    $updatedText = $text = $page.GetText()

    $casingExpressions = [TestContext]::CasingExpressions
    $casingExpressionJoined = "\b(" + ($casingExpressions -join '|') + ")\b"

    $ignoredExpressions = [TestContext]::IgnoredCasingExpressions
    $ignoredExpressions.AddRange($page.GetIgnoredTerms())
    $ignoredExpressionJoined = "\b(" + ($ignoredExpressions -join '|') + ")\b|(?<=[A-Za-z,:]) (\*\*[^\*]+\*\*)"

    $ignoredExpressions.Add('(?<=[A-Za-z,:]) (\*\*[^\*]+\*\*)') | Out-Null

    $invalidTermExpressions = [TestContext]::InvalidTermExpressions
    $invalidTermExpressionJoined = "(?<![-'])\b(" + ($invalidTermExpressions -join '|') + ")\b(?!['-])"
    $invalidTermLookup = [TestContext]::InvalidTermLookup

    $prefixExpression = $([TestContext]::CasingPrefixExpressions) -join '|' 
    $prefixExpression = "($prefixExpression)(.)(.*)"

    $invalidFormattingExpressions = [TestContext]::InvalidFormattingExpressions
    $invalidFormattingExpressionJoined = ($invalidFormattingExpressions -join '|')
    $invalidFormattingLookup = [TestContext]::InvalidFormattingLookup

    $ruleExpressions = [TestContext]::RuleExpressions

    $linkExpressionJoined = Get-RegexForLink

    $count = 0

    $localLinks = [ordered]@{}
    $externalLinks = [ordered]@{}

    $hitCollection = [PageHitCollection]::new($ruleExpressions, $file.Extension, $text)

    ### CORRECT OR REPORT INVALID FORMATTING

    $t = $updatedText
    $updatedText = Get-FixIssuesInSentence `
        $hitCollection $null $updatedText `
        $invalidFormattingExpressions $invalidFormattingExpressionJoined $invalidFormattingLookup

    if ($t -cne $updatedText)
    {
        [TestLog]::WriteSuperVerbose("INVALID FORMATTING HANDLED.")
        $count++
    }

    # REINITIALIZE THE HIT COLLECTION, BECAUSE THE TEXT HAS CHANGED.
    $hitCollection.Initialize($updatedText)

#    $pageHits = ($fixFormattingOnly) ? [List[PageHit]]::new() : $hitCollection.GetHits()
    $pageHits = $hitCollection.GetHits()

    for ($pageHitIndex = $pageHits.Count - 1; $pageHitIndex -ge 0; $pageHitIndex--)
    {
        $pageHit = $pageHits[$pageHitIndex]

        $content = $pageHit.GetContent()
        if ($content.Trim() -eq '')
        {
            continue
        }

        $header = $pageHit.GetHeader()
        $hitType = $pageHit.GetHitType()

        [TestLog]::WriteSuperVerbose("CONTENT:  '$content'")
        [TestLog]::WriteSuperVerbose("HEADER:   '$header'")
        [TestLog]::WriteSuperVerbose("HIT TYPE: '$hitType'")

        $skipTypes = @(
            'LocalBookmark',
            'ImageLink'
            'Directive',
            'Html', 
            'Callout', 
            'Metadata',
            'CodeBlock',
            'Comment',
            'Disabled'
        )

        if ($skipTypes -contains $hitType)
        {
            [TestLog]::WriteSuperVerbose("$($hitType.ToUpper()): $header$content")
            continue
        }

        if ($hitType -eq 'TODO')
        {
            [TestLog]::WriteIssue("TODO IN '$($file.FullName)'")
            $count++
            continue
        }

        if ($hitType -eq 'Link')
        {
            # TODO: Also save all the links and compare the header values.

            $externalLinks[$pageHit.Content] = $pageHit.Header.Trim()
            continue
        }

        if ($hitType -eq 'LocalLink')
        {
            $localLinks[$pageHit.Content] = $pageHit.Header.Trim()
            continue
        }

        if (@('Sentence', 'Title') -notcontains $hitType)
        {
            [TestLog]::WriteError("UNINITIALIZED PAGE HIT in '$($page.FilePath)':")
            [TestLog]::WriteError("    CONTENT:  '$($content)'")
            [TestLog]::WriteError("    HEADER:   '$($header)'")
            [TestLog]::WriteError("    HIT TYPE: '$($hitType)'")

            $count++
            continue
        }

        $correctedSentence = $sentence = $content
    
        if (! $fixFormattingOnly)
        {
            $correctedSentence = $correctedSentence.Substring(0,1).ToUpper() + $correctedSentence.Substring(1).ToLower()

            ### FIX CASING ISSUES

            $s = $correctedSentence
            $correctedSentence = Get-FixIssuesInSentence `
                $hitCollection $pageHit $correctedSentence $casingExpressions $casingExpressionJoined

            if ($s -cne $correctedSentence)
            {
                [TestLog]::WriteSuperVerbose("CASING HANDLED in '$correctedSentence'")
            }

            ### REVERT LINKS

            $m = [Regex]::Matches($sentence, "(\[?[^\[]*\])\(([^\)\n]+)\)")
            foreach ($item in $m)
            {
                $correctedSentence = [TestString]::ReplaceAtPosition($correctedSentence, $item.Groups[2].Index, $item.Groups[2].Value)
            }

            ### REVERT INLINE CODE

            $m = [Regex]::Matches($sentence, '(?<!`)`([^`]+)`')
            foreach ($item in $m)
            {
                $correctedSentence = [TestString]::ReplaceAtPosition($correctedSentence, $item.Groups[1].Index, $item.Groups[1].Value)
            }

            ### FIX ADDITIONAL TITLE CASING ISSUES

            $s = $correctedSentence
            if ($hitType -eq 'Title')
            {
                $index = $correctedSentence.IndexOf(': ')
                if ($index -gt 0)
                {
                    $value = $correctedSentence.Substring($index, 3).ToUpper()
                    $correctedSentence = [TestString]::ReplaceAtPosition($correctedSentence, $index, $value)
                }
            }

            ### FIX PREFIX ISSUES.

            $s = $correctedSentence

            # TODO: ReplaceAtPosition instead?
            $correctedSentence = $correctedSentence -creplace $prefixExpression, `
                { $_.Groups[1].Value + $_.Groups[2].Value.ToUpper() + $_.Groups[3].Value }
            if ($s -cne $correctedSentence)
            {
                [TestLog]::WriteSuperVerbose("CASING PREFIX HANDLED in '$correctedSentence'")
            }
        
            ### FOR IGNORED TERMS, REVERT TO THE ORIGINAL VALUE FROM THE DOCUMENT. 

            $exp = "(?i)$ignoredExpressionJoined|(?<=[A-Za-z,:]) (\*\*[^\*]+\*\*)"

            if ($correctedSentence -imatch $ignoredExpressionJoined)
            {
                foreach ($exp in $ignoredExpressions)
                {
                    if ($exp -match '^[A-Za-z]')
                    {
                        $exp = "(?i)\b$exp\b"
                    }

                    $m = [Regex]::Matches($sentence, $exp)
                    foreach ($item in $m)
                    {
                        $originalValue = $sentence.Substring($item.Index, $item.Length)
                        try {
                            $correctedSentence = [TestString]::ReplaceAtPosition($correctedSentence, $item.Index, $originalValue)
                        }
                        catch
                        {
                            WriteError("ReplaceAtPosition failed for '$correctedSentence'.")
                        }

                        [TestLog]::WriteSuperVerbose("IGNORED MATCH '$item' IN: '$correctedSentence'")
                    }
                }
            }
        }

        ### CORRECT OR REPORT INVALID TERMS.

        $s = $correctedSentence
        $correctedSentence = Get-FixIssuesInSentence `
            $hitCollection $pageHit $correctedSentence `
            $invalidTermExpressions $invalidTermExpressionJoined $invalidTermLookup

        if ($s -cne $correctedSentence)
        {
            [TestLog]::WriteSuperVerbose("INVALID TERMS HANDLED in '$correctedSentence'")
        }

        ### DISPLAY THE CORRECTIONS.

        if ($correctedSentence -cne $sentence)
        {
            if ($sentence.IndexOf("  ") -ge 0 -or $correctedSentence.IndexOf("  ") -ge 0)
            {
                [TestLog]::WriteError("    MULTIPLE CONSECUTIVE SPACES FOUND IN '$sentence'")
                $count++
            }

            $words = $sentence.Split(' ')
            $correctedWords = $correctedSentence.Split(' ')

            $wordCount = $words.Count

            $dl = [DisplayList]::new()
            for ($i = 0; $i -lt $wordCount; $i++)
            {
                $dl.AddItem($words[$i], $correctedWords[$i])
            }
            
            $dl.Write()

            [TestHelper]::AddTerms($dl.List)
            [TestLog]::WriteLine("    $correctedSentence", 'DarkGray', $false)
            [TestLog]::WriteSuperVerbose("    $header")
            [TestLog]::WriteLine('')
            
            $count++

            $updatedText = [TestString]::ReplaceAtPosition($updatedText, $pageHit.Index, $sentence.Length, $correctedSentence)
        }
    }

    ### SAVE THE FILE

    $fileChanged = ($text -cne $updatedText)
    if ($fixIssues -and $fileChanged)
    {
        $updatedText = $updatedText.TrimEnd([System.Environment]::NewLine.ToCharArray())
        Set-Content -Path $file -Value $updatedText
    }

    
    # Test local links.

    $linkIssueCount = 0
    foreach ($item in $localLinks.Keys)
    {
        $path = Get-StringBefore $item '#'
        $path = Get-StringBefore $path "?"

        if ($path -eq '')
        {
            $path = $item
        }

        try {
            $absolutePath = $(Join-Path $($file.DirectoryName) $path)
            [TestLog]::WriteSuperVerbose("TESTING PATH '$absolutePath IN '$($file.FullName)':")

            if ((Test-Path $absolutePath) -eq $false)
            {
                [TestLog]::WriteIssue("COULDN'T FIND PATH '$absolutePath' IN '$($file.FullName)'")
                $linkIssueCount++
                $count++
            }
        }
        catch {
            [TestLog]::WriteException($_, $file, $($MyInvocation).MyCommand)
            $linkIssueCount++
        }
    }

    return ($linkIssueCount -eq 0 -and !($fileChanged))
}

function Get-FixIssuesInSentence(
    [PageHitCollection] $collection,
    [PageHit] $hit,
    [string] $sentence,
    [List[string]] $expressions,
    [string] $expressionJoined,
    [OrderedDictionary] $correctionLookup = $null
)
{
    if ($sentence -imatch $expressionJoined)
    {
        foreach ($exp in $expressions)
        {
            $checkExpression = ($null -eq $hit) ? $exp : "(?i)\b$exp\b"

            $m = [Regex]::Matches($sentence, $checkExpression)
            if ($m.Count -eq 0)
            {   
                continue
                }

            $sorted = [TestMatch]::BuildCollection($m, $exp, $hit, $correctionLookup)

            # foreach ($match in $m)
            # {   
            #     $matchCollection.Add([TestMatch]::New($match, $exp, $correctionLookup))
            # }
            # $sorted = ($matchCollection | Sort-Object -Descending -Property Index)
        
            # for ($i = $m.Count - 1; $i -ge 0; $i--)
            foreach ($item in $sorted)
            {   
        #        $item = $m[$i]
                # if ($null -eq $hit) {
                #     $index = $item.Index
                # }
                # else {
                #     $index = $hit.Index + $item.Index

                if ($collection.IsIndexInLink($item.PageIndex))
                {
                    WriteLink $sentence $item
                    continue
                }
                # }
                
                if ($collection.IsIndexInCodeBlock($item.PageIndex))
                {
                    # Write-Host "IGNORED CODE BLOCK"
                    continue
                }

                # if ($item.Correction -eq 'NULL' -and $item.Suggestion -eq 'NULL')
                # {
                #     $sentence = [TestString]::ReplaceAtPosition($sentence, $item.Index, $item.Expression)
                #     continue
                # }

                # $correction = $correctionLookup[$item.Expression] ?? 'NULL'
                # $suggestion = ''

                # for ($g = 1; $g -lt $item.Groups.Count; $g++)
                # {   
                #     $value = $item.Groups[$g].Value
                #     $correction = $correction.Replace("`$$g", $value)
                # }

                # if ($correction -match '^~~(.*)') {
                #     $suggestion = $matches[1]
                #     $correction = ''
                # }

                if ($item.Correction -ne 'NULL') {
                    
                    # TODO: Handle casing variations here?
                    $sentence = [TestString]::ReplaceAtPosition($sentence, $item.Index, $item.Value.Length, $item.Correction)
                    [TestLog]::WriteSuperVerbose("MATCH HANDLED in '$correctedSentence'")
                    continue
                }

                if ($suggestion -ne 'NULL') {
                    
                    # TODO: Handle casing variations here?
    #                     $sentence = [TestString]::ReplaceAtPosition($sentence, $item.Index, $item.Value.Length, `
                    #    " <-- TODO (I): $suggestion --> $($item.Value)")
                    [TestLog]::WriteSuperVerbose("INVALID TERM HANDLED in '$correctedSentence'")
                    continue
                }
                
                if ($null -eq $hit) {
                    [TestLog]::WriteLine("(I-PAGE) '$($item.Expression)'")
                }
                else {
                    [TestLog]::Write("(I) '")
                    [TestLog]::Write($sentence.Substring(0, $sentence.IndexOf($item.Value)), 'Yellow')
                    [TestLog]::Write($item.Value, 'Red')
                    [TestLog]::Write($sentence.Substring($sentence.IndexOf($item.Value) + $item.Value.Length), 'Yellow')
                    [TestLog]::WriteLine("'")
                }

                if ($suggestion -ne '') {
                    [TestLog]::WriteLine("    SUGGESTION: $suggestion") 
                }
            }

            if ($null -eq $hit)
            {
                $collection.Initialize($sentence)
            }
        }
    }

    return $sentence
}

function WriteLink([string] $link, [TestMatch] $matchItem)
{
    if ([TestLog]::SuperVerbose)
    {
        $start = $link.Substring(0, $matchItem.Index)
        [TestLog]::Write("POSSIBLE LINK: '$start", 'DarkGray')
        [TestLog]::Write($matchItem.Value, 'Red')
        
        $end = $link.Substring($matchItem.Index + $matchItem.Length)
        [TestLog]::WriteLine("$end'", 'DarkGray')
    }
}


# $file = Get-Item "$here\..\docs\ready\considerations\compute-options.md"
# [TestLog]::WriteException($_, $file, "func")
# Test-Paths $file

# TODO: Add this function for displaying line numbers.
# public int LineFromPos(string input, int indexPosition)
#     {
#         int lineNumber = 1;
#         for (int i = 0; i < indexPosition; i++)
#         {
#             if (input[i] == '\n') lineNumber++;
#         }
#         return lineNumber;
#     }
