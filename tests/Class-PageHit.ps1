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
        $this.MetadataRange = [HashSet[int]]::new()

        $this.PageCodeBlocks = [List[PageCodeBlock]]::new()
        
        $metadataStart = $text.IndexOf("landingContent:")
        $metadataEnd = 0

        if ($metadataStart -ge 0) {
            $metadataEnd = $text.IndexOf("metadata:", $metadataStart)
        }
        else
        {
            $metadataStart = $text.IndexOf("author:")
            if ($metadataStart -ge 0)
            {    
                $metadataEnd = $text.IndexOf("---", $metadataStart)
            }
            else {
                $metadataStart = 0
                $metadataEnd = 0
            }
        }

        $metadataStart..$metadataEnd `
            | ForEach-Object { $this.MetadataRange.Add($_) }

        $m = [Regex]::Match($text, '(?s)(?:description: .+?\r?\n)(.*?---)')
        $this.MetadataBlock = [PageCodeBlock]::new($m)
            
        $codeMatches = [Regex]::Matches($text, '((?s)```.*?```)')
        foreach ($m in $codeMatches)
        {
            $this.PageCodeBlocks.Add([PageCodeBlock]::new($m))
        }

        foreach ($exp in $this.RuleExpressions)
        {
            $regex = [Regex]::new($exp)
            $matchHits = $regex.Matches($text)
            foreach ($m in $matchHits)
            {
#                if ($this.MetadataRange.Contains($m.Index))
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
    hidden [Hashset[int]] $MetadataRange
    hidden [PageCodeBlock] $MetadataBlock
    hidden [List[PageCodeBlock]] $PageCodeBlocks

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

    [bool] IsIndexInCodeBlock([int] $index)
    {
        foreach ($block in $this.PageCodeBlocks)
        {
            if ($index -ge $block.Index -and $index -le ($block.Index + $block.Length))
            {
                return $true
            }
        }

        return $false
    }

    # [int[]] GetLinkRange()
    # {
    #     return $this.LinkRange
    # }
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

        #TODO: Can the header be trimmed here?
        $h = $m.Groups[1].Value
        $c = $m.Groups[2].Value.Trim()
        $this.Index = $m.Groups[2].Index
        $this.Length = $c

        if ($regex.GetGroupNames() -contains 'sentence') {
            
            # if ($h -match '^</?$')
            # {
            #     $h = $h + (Get-StringBefore $c '>') + '>'
            #     $c = (Get-StringAfter $c '>')
            # }

            if ($collection.IsIndexInCodeBlock($m.Index))
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
                $this.HitType = 'Html'
                $h = $h + (Get-StringBefore $c '>') + '>'
                $c = (Get-StringAfter $c '>')
            }
            elseif ($h.Trim() -eq '[!') 
            {
                $this.HitType = 'Callout'  
            }
            else {
                $this.HitType = 'Sentence'
                if ($h -match '^[A-Za-z]$')
                {
                    $c = "$h$c"
                    $h = ""
                }

                $m = [Regex]::Match($c.Trim(), '^([a-z][A-z\._]+[:>] ?"?)(.*)')
                if ($m.Success)
                {
                    $h = $m.Groups[1].Value.Trim('"')
                    $c = $m.Groups[2].Value
                }

                $exp = '^(?:title:|name:|#+ |\[|\*\*|\*\*\[|- |- \*\*\[|\[|: ")'
                if ($c -match $exp -or $h -match $exp)
                {
                    $this.HitType = 'Title'
                    if ($c -notmatch '^[a-z]')
                    {
                        Write-Host "UNEXPECTED CHARACTER AT START OF CONTENT: $c" -ForegroundColor Red
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

class PageCodeBlock
{
    PageCodeBlock([Match] $m)
    {
        $this.Initialize($m)
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
    Sentence
    Title
    Metadata
    CodeBlock
    Directive
    Html
    TODO
    Callout
    Comment
    LocalBookmark
    Unknown = 100
}
