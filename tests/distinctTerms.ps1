$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Classes.ps1"
. "$here\Test-MyRepo.ps1"
. "$here\Test-Helpers.ps1"
. "$here\Test-Paths.ps1"

# $exp = '(?:\b[a-z]+ )((?:[A-Z][A-Za-z]+\b ?){2})(?![A-Z])'
$exp = '((?:\b[A-Z][A-Za-z]+\b.){2,}|(?:\b[A-Z]{2,}\b))'
$distinct = [System.Collections.Generic.HashSet[string]]::new()

$files = Get-ContentFiles @()
foreach ($file in $files)
{
    Write-Host $file.FullName

    $text = Get-Content $file -Raw
    $text = $text.Replace('&nbsp;', ' ')
    $hits = [Regex]::Matches($text, $exp)

    foreach ($hit in $hits)
    {
        $item = $hit[1] ?? $hit[0]
        
        $chops = @(
            'The '
            'Their '
            'This '
            'If '
            'In '
            'See '
            'Your '
            'Use '
            'Most '
            'Outsource '
            'Onboard '
            'Healthy '
            'As '
            'All '
            'Although '
            'Adopting '
            'Using '
            'With '
            'Sample '
        )

        foreach ($chop in $chops)
        {
            $item = (Get-StringChopStart $item $chop)
        }

        $chops = @(
            ']'
            ','
            '_'
            '.'
            ':'
            '"'
            '*'
            '<'
            ')'
        )

        foreach ($chop in $chops)
        {
            $item = (Get-StringChopEnd $item $chop)
        }

        $item = (Get-StringAfterLast $item '[')

        if ($item.Length -lt 2)
        {
            continue
        }

        $distinct.Add($item.Trim()) | Out-Null
    }
}

$sorted = ($distinct | Sort-Object)
$casing = (Get-CasingExpressions)

$list = [System.Collections.Generic.List[string]]::new()

foreach ($item in $sorted)
{
    $found = $false
    foreach ($casingExp in $casing)
    {
        if ([Regex]::Match($item, $casingExp).Success)
        {
            $found = $true
            break
        }
    }

    if (!($found))
    {
        $list.Add($item) | Out-Null 
    }
}

$list
