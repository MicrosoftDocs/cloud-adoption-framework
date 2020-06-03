using namespace System.Collections.Generic

class DisplayList
{
    DisplayList()
    {
        $this.Initialize()
    }
    
    hidden [List[KeyValuePair[string, string]]] $List

    hidden [void] Initialize()
    {
        $this.List = [List[KeyValuePair[string, string]]]::new()
    }

    [void] AddItem([string] $word, [string] $correctedWord)
    {
        $split = $word.Split(']')
        $correctedSplit = $correctedWord.Split(']')

        $value1 = $split[0]
        $value2 = ($split.Count -gt 1) ? $split[1] : ''
        $correctedValue1 = $correctedSplit[0]
        $correctedValue2 = ($correctedSplit.Count -gt 1) ? $correctedSplit[1] : ''

        if ($this.List.Count -eq 0)
        {
            $this.List.Add([KeyValuePair[string, string]]::new($word, 'Yellow'))
            $firstCount = $global:firstWords[$value1] ?? 0
            $firstCount++
            $global:firstWords[$value1] = $firstCount
            return
        }

        $previousWord = $this.List[$this.List.Count - 1].Key
        if ($value2 -eq '') {
            $color = ($word -ceq $correctedWord) ? 'Yellow' : 'Red'
        }
        else {
            $color = ($value1 -ceq $correctedValue1) ? 'Yellow' : 'Red' `
             + ',' + ($value2 -ceq $correctedValue2) ? 'Yellow' : 'Red'     
        }

        if ($this.List.Count -eq 1)
        {
            $this.UpdateListValue(0, (Get-StringBefore $color ','))
        }
        
        $ignore = @('a', 'about', 'add', 'adopt', 'adoption', 'align' ,'allow', 'an', 'the', 'use', 'using')

        if ($ignore.Contains($previousWord))
        {
            $this.UpdateListValue($this.List.Count - 1, 'Yellow')
        }
        elseif ($color -match '^Red' `
            -and @('Azure', 'Microsoft').Contains($previousWord))
        {
            $this.UpdateListValue($this.List.Count - 1, 'Red')
        }

        $this.List.Add([KeyValuePair[string, string]]::new($word, $color))
    }

    [void] UpdateListValue(
        [int] $index, 
        [string] $newValue)
    {
        $this.List[$index] = [KeyValuePair[string, string]]::new($this.List[$index].Key, $newValue)
    }

    [void] Write()
    {
        [TestLog]::Write('(C)')

        for ($i = 0; $i -lt $this.List.Count; $i++)
        {
            $item = $this.List[$i]

            $split = $item.Key.Split(']')
            $value1 = " $($split[0])"
            $value2 = ($split.Count -gt 1) ? "]$($split[1])" : ''
    
            $split = $item.Value.Split(',')
            $color1 = $split[0]
            $color2 = ($split.Count -gt 1) ? $split[1] : ''

            [TestLog]::Write($value1, $color1)
            [TestLog]::Write($value2, $color2)
        }
        
        [TestLog]::WriteLine('')
    }
}
