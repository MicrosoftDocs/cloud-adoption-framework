using namespace System.Collections.Generic

# $here = $global:herePath
# . $here/Test-Includes.ps1

class TestHelper
{
    [void] static AddTerms([List[KeyValuePair[string, string]]] $list)
    {
        $term = ''
        for ($i = 0; $i -lt $list.Count; $i++)
        {
            $item = $list[$i]
            $word = $item.Key.Split(']')
            $color = $item.Value.Split(',')

            if ($color -eq 'Yellow')
            {
                if ($term -ne '') {
                    [TestHelper]::AddTerm($term)
                }
                $term = ''
                continue
            }

            $new = Get-StringChopStart $word '_'
            $new = Get-StringChopEnd $word '_'
            $new = [Regex]::Match($new, "^[A-Za-z0-9'-]+")
            $term = "$term $new".TrimStart()

            if ($word -match '[^\w]$' -or $i -eq $list.Count - 1)
            {
                if ($term -ne '') {
                    [TestHelper]::AddTerm($term)
                }
                $term = ''
                continue
            }
        }
    }

    [void] static AddTerm([string] $term)
    {
        $trim = $term.Trim()
        $count = $global:termsNotFound[$trim] ?? 0
        $count++
        $global:termsNotFound[$trim] = $count
        [TestLog]::WriteSuperVerbose("TERM FOUND: $term")
    }

    [void] static AddToList(
        [List[KeyValuePair[string, string]]] $list, 
        [string] $key, 
        [string] $value)
    {
        $list.Add([KeyValuePair[string, string]]::new($key, $value))
    }

    [bool] static AnyMatch(
        [string[]] $list,
        [string] $expression)
    {
        foreach ($item in $list)
        {
            if ([Regex]::Match($item, $expression).Success)
            {
                return $true
            }
        }

        return $false
    }

    # [void] static UpdateListValue(
    #     [List[KeyValuePair[string, string]]] $list, 
    #     [int] $index, 
    #     [string] $newValue)
    # {
    #     $list[$index] = [KeyValuePair[string, string]]::new($list[$index].Key, $newValue)
    # }
}
