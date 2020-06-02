using namespace System.Collections.Generic
using namespace System.Collections.Specialized
using namespace System.Text.RegularExpressions

class TestMatch
{
    TestMatch(
        [Match] $m, 
        [string] $expression,
        [PageHit] $hit,
        [OrderedDictionary] $correctionLookup)
    {
        if ($m.Groups.Count -gt 1) {
            $this.Index = $m.Groups[1].Index
            $this.Length = $m.Groups[1].Length
            $this.Value = $m.Groups[1].Value
        }
        else {
            $this.Index = $m.Index
            $this.Length = $m.Length
            $this.Value = $m.Value
        }

        $this.Expression = $expression
        $this.Correction = 'NULL'

        $this.PageIndex = ($null -eq $hit) ? $this.Index : ($hit.Index + $this.Index)
        
        if ($null -eq $correctionLookup)
        {
            $this.Correction = $this.Expression
        }
        else
        {
            $this.Correction = $correctionLookup[$this.Expression] ?? 'NULL'
            $this.Suggestion = 'NULL'

            if ($this.Correction -match '\$\d')
            {
                for ($g = 1; $g -lt $m.Groups.Count; $g++)
                {   
                    $found = $m.Groups[$g].Value
                    $this.Correction = $this.Correction.Replace("`$$g", $found)
                }
            }
            
            $suggestionMatch = [Regex]::Match($this.Correction, '^~~(.*)')
            if ($suggestionMatch.Success)
            {
                $this.Suggestion = $suggestionMatch.Groups[1].Value
                $this.Correction = 'NULL'
            }
        }
    }

    static [List[TestMatch]] BuildCollection(
        [MatchCollection] $collection,
        [string] $expression,
        [PageHit] $hit,
        [OrderedDictionary] $correctionLookup
    )
    {
        $list = [List[TestMatch]]::new()
        foreach ($match in $collection)
        {   
            $list.Add([TestMatch]::New($match, $expression, $hit, $correctionLookup))
        }

        $sorted = ($list | Sort-Object -Descending -Property Index)
        return $sorted
    }

    [int] $Index
    [int] $PageIndex
    [int] $Length
    [string] $Value
    [string] $Expression
    [string] $correction
    [string] $Suggestion
}
