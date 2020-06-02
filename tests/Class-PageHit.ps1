using namespace System.Collections.Generic
using namespace System.Text.RegularExpressions 

class PageHitCollection
{
    PageHitCollection( 
        [List[string]] $expressions,
        [string] $fileExtension,
        [string] $text)
    {
        $this.RuleExpressions = $expressions
        $this.FileExtension = $fileExtension
        $this.Initialize($text)
    }

    [void] Initialize(
        [string] $text
    )
    {
        $this.Hits = [List[PageHit]]::new()
        $this.LinkRange = [HashSet[int]]::new()

        $this.CodeBlocks = [List[PageBlock]]::new()
        $this.DisabledBlocks = [List[PageBlock]]::new()

#        $metadataExpression = '(?s)(?:description: .+?\r?\n)(.*?(?:---|highlightedContent:))'
        $metadataExpression = '(?s)metadata:.*?(?=highlightedContent:)|(?<=\ndescription:.+\r?\n).*---'
        $m = [Regex]::Match($text, $metadataExpression)

        # $metadataStart = $text.IndexOf("landingContent:")
        # $metadataEnd = 0

        # if ($metadataStart -ge 0) {
        #     $metadataEnd = $text.IndexOf("metadata:", $metadataStart)
        # }
        # else
        # {
        #     $metadataStart = $text.IndexOf("author:")
        #     if ($metadataStart -ge 0)
        #     {    
        #         $metadataEnd = $text.IndexOf("---", $metadataStart)
        #     }
        #     else {
        #         $metadataStart = 0
        #         $metadataEnd = 0
        #     }
        # }

        # $m = [Regex]::Match($text, '(?s)(?:description: .+?\r?\n)(.*?(?:---|highlightedContent:))')
        $this.MetadataBlock = [PageBlock]::new($m)

        $m = [Regex]::Matches($text, '((?s)```.*?```|(?<!`)`[^`]+`)')
        foreach ($match in $m)
        {
            $this.CodeBlocks.Add([PageBlock]::new($match))
        }

        $startIndex = -1
        $m = [Regex]::Matches($text, '(?s)<!-- *docsTest:(disable|enable) .*?-->')
        foreach ($match in $m)
        {
            $setting = $match.Groups[1].Value
            $endIndex = $match.Index + $match.Length

            if ($setting -eq 'enable') {
                if ($startIndex -ge 0) {
                    $this.DisabledBlocks.Add([PageBlock]::new($startIndex, $endIndex))
                    $startIndex = -1
                }
                else {
                    # Already enabled.
                }
            }
            else
            {
                if ($startIndex -lt 0) {
                    $startIndex = $match.Index
                }
                else {
                    # Already disabled.
                }
            }
        }

        if ($startIndex -ge 0)
        {
            $this.DisabledBlocks.Add([PageBlock]::new($startIndex, $text.Length - 1))
        }

        foreach ($exp in $this.RuleExpressions)
        {
            $regex = [Regex]::new($exp)
            $matchHits = $regex.Matches($text)
            foreach ($m in $matchHits)
            {
                if ($this.IsIndexInMetadata($m.Index))
                {
                    continue
                }

                $pageHit = [PageHit]::new($this, $regex, $m, $this.FileExtension)
                $this.Hits.Add($pageHit)
                $pageHit.LinkRange `
                    | ForEach-Object { $this.LinkRange.Add($_) }
            }
        }
    }

    hidden [List[string]] $RuleExpressions
    hidden [string] $FileExtension
    hidden [List[PageHit]] $Hits
    hidden [Hashset[int]] $LinkRange
    hidden [PageBlock] $MetadataBlock
    hidden [List[PageBlock]] $CodeBlocks
    hidden [List[PageBlock]] $DisabledBlocks

    [List[PageHit]] GetHits()
    {
        return $this.Hits
    }    

    [bool] IsIndexInLink([int] $index)
    {
        return ($this.LinkRange.Contains($index))
    }

    [bool] IsIndexInMetadata([int] $index)
    {
        return ($index -ge $this.MetadataBlock.Index `
            -and $index -le ($this.MetadataBlock.Index + $this.MetadataBlock.Length))
    }

    [bool] IsIndexInDisabledBlock([int] $index)
    {
        foreach ($block in $this.DisabledBlocks)
        {
            if ($index -ge $block.Index -and $index -le ($block.Index + $block.Length))
            {
                return $true
            }
        }

        return $false
    }

    [bool] IsIndexInCodeBlock([int] $index)
    {
        foreach ($block in $this.CodeBlocks)
        {
            if ($index -ge $block.Index -and $index -le ($block.Index + $block.Length))
            {
                return $true
            }
        }

        return $false
    }
}

class PageHit
{
    PageHit(
        [PageHitCollection] $collection,
        [Regex] $regex,
        [Match] $m,
        [string] $extension)
    {
        $this.FileExtension = $extension

        # TODO: Can the header be trimmed here?
        $h = $m.Groups[1].Value
        $c = $m.Groups[2].Value.Trim()
        $this.Index = $m.Groups[2].Index
        $this.Length = $c.Length

        if ($regex.GetGroupNames() -contains 'sentence') {
            
            if ($collection.IsIndexInDisabledBlock($m.Index))
            {
                $this.HitType = 'Disabled'
            }
            elseif ($collection.IsIndexInCodeBlock($m.Index))
            {
                $this.HitType = 'CodeBlock'
            }
            elseif ($c -match '\bTODO\b')
            {
                $this.HitType = 'TODO'
            }
            elseif ($c -match '^(?:markdownlint-|cSpell:|docsTest:)' `
                -or $c -match 'div class="nextstepaction"' `
                -or $h -match '^:::')
            {
                $this.HitType = 'Directive'
            }
            elseif ($this.FileExtension -eq '.md' -and $h.Trim() -eq '<!--')
            {
                $this.HitType = 'Comment'
            }
            elseif ($this.FileExtension -eq '.yml' -and $h.Trim() -eq '#')
            {
                $this.HitType = 'Comment'
            }
            elseif ($h -match '^</?$' -or $c -match "div class=|div>|a>|li>|ul class=|li style=|img alt=|img src=") {
                # Write-Error 'HTML - INDEX IS NOW MISALIGNED!'
                $this.HitType = 'Html'
                $newIndex = $c.IndexOf('>') + 1
                $h = $h + (Get-StringBefore $c '>') + '>'
                if ($newIndex -eq 0) {
                    $c = ''
                }
                else {
                $c = (Get-StringAfter $c '>')
            }

                $this.Index = $this.Index + $newIndex
            }
            elseif ($h.Trim() -eq '[!') 
            {
                $this.HitType = 'Callout'  
            }
            elseif ($h.Trim() -eq '![')
            {
                $this.HitType = 'ImageLink'
            }
            else {
                $this.HitType = 'Sentence'
                if ($h -match '^[A-Za-z]$')
                {
                    Write-Error 'LETTER AT HEADER START - INDEX IS NOW MISALIGNED!'
                    $c = "$h$c"
                    $h = ""
                }

                $m = [Regex]::Match($c.Trim(), '(^>? *\d+\. ?[^A-Za-z]*)(.*)')
                if ($m.Success)
                {
                    # Write-Error 'NUMBERED LIST - INDEX IS NOW MISALIGNED!'
                    $h = $m.Groups[1].Value.Trim('"')
                    $c = $m.Groups[2].Value
                    $this.Index = $this.Index + $m.Groups[2].Index
                }

                $m = [Regex]::Match($c.Trim(), '^([a-z][A-Za-z\._]+[:>] ?"?)(.*)')
                if ($m.Success)
                {
                    # Write-Error 'LOWERCASE LETTER - INDEX IS NOW MISALIGNED!'
                    $h = $m.Groups[1].Value.Trim('"')
                    $c = $m.Groups[2].Value
                    $this.Index = $this.Index + $m.Groups[2].Index
                }

                $exp = '^(?:title:|name:|#+ |\[|\*\*|\*\*\[|- |- \*\*\[|\[|: ")'
                if ($c -match $exp -or $h -match $exp)
                {
                    $this.HitType = 'Title'
                    if ($c -notmatch '^[a-z]')
                    {
                        Write-Host ("UNEXPECTED CHARACTER AT START OF CONTENT: HEX '{0:x}'" -f [int][char]($c.Substring(0,1)) ) -ForegroundColor Red
                    }
                }
                elseif ($h.Trim() -cmatch '^[a-z][A-Za-z\._]+\: ?')
                {
                    $this.HitType = 'Metadata'
                }
            }
        }
        else {      # These are links.

            if ($c -match '^http')
            {
                $this.HitType = "Link"
            }
            elseif ($c -match '^\.\.?/')
            {
                $this.HitType = "LocalLink"
            }
            elseif ($h.Trim() -eq 'href:')
            {
                $this.HitType = "LocalLink"
                $c = './' + $c
            }
            elseif ($c -match '(?i)^#[a-z]')
            {
                $this.HitType = "LocalBookmark" 
            }
            else {
                $this.HitType = "Unknown"
            }

            $this.LinkRange = $m.Groups[2].Index..($m.Groups[2].Index + $m.Groups[2].Length)
        }

        $this.Header = $h
        $this.Content = $c.Trim()
    }

    [string] GetHeader()
    {
        return $this.Header
    }

    [string] GetContent()
    {
        return $this.Content
    }

    [string] GetHitType()
    {
        return $this.HitType
    }

    [string] GetIndex()
    {
        return $this.Index
    }

    hidden [string] $FileExtension
    hidden [string] $Header
    hidden [string] $Content
    hidden [HitType] $HitType
    hidden [int] $Index
    hidden [int] $Length
    hidden [int[]] $LinkRange
}

class PageBlock
{
    PageBlock([Match] $m)
    {
        $this.Initialize($m)
    }

    PageBlock([int] $startIndex, [int] $endIndex)
    {
        $this.Index = $startIndex
        $this.Length = $endIndex - $startIndex
    }

    [void] Initialize([Match] $m)
    {
        $this.Index = $m.Groups[1].Index
        $this.Length = $m.Groups[1].Length
        $this.Text = $m.Groups[1].Value
    }

    [int] $Index
    [int] $Length
    [string] $Text
}

Enum HitType
{
    Link = 1
    LocalLink
    ImageLink
    LocalBookmark
    Sentence
    Title
    Callout
    CodeBlock
    Html
    Metadata
    Directive
    Comment
    TODO
    Disabled
    Unknown = 100
}
