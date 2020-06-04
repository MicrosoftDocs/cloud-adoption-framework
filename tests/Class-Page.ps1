using namespace System.Collections.Generic
using namespace System.IO

class Page
{
    Page([FileInfo] $file)
    {
        $this.File = $file
        $this.FilePath = $file.FullName
        $this.Text = (Get-Content $file.FullName -Raw)

        $this.Fix()
        $this.Prevalidate()
    }

    Page([string] $text)
    {
        $this.Text = $text
    }

    hidden [FileInfo] $File
    hidden [string] $FilePath
    hidden [string] $Text
    hidden [string] $TextWithoutMetadata
    hidden [int] $IssueCount

    hidden [List[string]] $IgnoredTerms

    [string] GetText()
    {
        return $this.Text
    }

    [string] GetTextWithoutMetadata()
    {
        $this.TextWithoutMetadata = $this.TextWithoutMetadata `
            ?? ($this.Text -replace '(?s)(?<=[\n])author:.*(?=(---[\r\n]))')

        return $this.TextWithoutMetadata
            
            # $authorIndex = $text.IndexOf("author:")
            # $endIndex = $text.IndexOf("---", 4)

            # try {
            #     $metadata = $text.Substring($authorIndex, $endIndex - $authorIndex)
            #     $result = $text.Replace($metadata, '')
            # }
            # catch {
            #     [TestLog]::WriteError("COULDN'T REMOVE METADATA: $(Get-StringClip $text 100)")
            #     [TestLog]::WriteException($_, $file, $($MyInvocation).MyCommand)
            # }
            # $this.TextWithoutMetadata = $result
        # }        
    }

    [List[string]] GetIgnoredTerms()
    {
        if ($null -eq $this.IgnoredTerms)
        {
            $list = [List[string]]::new()

            $exp = "(?:<!-- ?|# ?)(?:cSpell:ignore |docsTest:ignore )(.*)(?<!-->)"
            $m = [Regex]::new($exp).Matches($this.Text)
            
            foreach ($matchHit in $m)
            {
                $wordList = $matchHit.Groups[1].Value.Trim()
                $wordList = (Get-StringChopEnd $wordList '-->').Trim()

                $exp = '"(?<=")([^"]*)(?=")"|([^ "]+)'
                $wordMatches = [Regex]::new($exp).Matches($wordList)
                foreach ($wordHit in $wordMatches)
                {
                    $word = $wordHit.Groups[1].Value.Trim()
                    if ($word -eq '')
                    {
                        $word = $wordHit.Groups[2].Value.Trim()
                    }

                    if ($word -ne '')
                    {
                        $list.Add($word)
                    }
                }

                # $exp = '"(?<=")([^"]*)(?=")"'
                # $phraseMatches = [Regex]::new($exp).Matches($wordList)
                # foreach ($p in $phraseMatches)
                # {
                #     $phrase = $p.Groups[1].Value.Trim()
                #     $list.Add($phrase)
                #     $wordList = $wordList.Replace("""$phrase""", 'replace-token')
                # }

                # $split = $wordList -split ' ' | Where-Object { $_ -ne 'replace-token' }
                # foreach ($word in $split)
                # {
                #     $list.Add($word)
                # }
            }
        
            $this.IgnoredTerms = $list
        }

        return $this.IgnoredTerms
    }

    hidden [void] Fix()
    {
    }

    hidden [void] Prevalidate()
    {
        # TODO: Add prevalidation checks.

        $checkValue = $null
        $exp = "(?s)\r\n(?:(?:\r\n *- [^\r\n\.]*(\.?))(?=\r\n))+"
        $m = [Regex]::Matches($this.Text, $exp)
        foreach ($item in $m)
        {
            $newValue = $m.Groups[1].Value
            if ($null -eq $checkValue -or $newValue -eq $checkValue)
            {
                $checkValue = $newValue
            }
            else {
                # TODO: Finish this test.
                # [TestLog]::WriteIssue("PERIOD MISMATCH IN BULLETED LIST at index $($item.Index).")
                # $this.IssueCount++
            }
        }
    }
}
