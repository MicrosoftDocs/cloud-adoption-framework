$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"
. "$here\Test-Helpers.ps1"
. "$here\Test-Paths.ps1"

# $exp = '(?:\b[a-z]+ )((?:[A-Z][A-z]+\b ?){2})(?![A-Z])'
$exp = '(?<!. \[?)([A-Z][A-z]+ )*'
$distinct = [System.Collections.Generic.HashSet[string]]::new()

$files = Get-ContentFiles @()
foreach ($file in $files)
{
    $text = Get-Content $file -Raw
    $result = $text -cmatch $exp
    foreach ($hit in $matches)
    {
        $item = $hit[1] ?? $hit[0]
        $distinct.Add($item.Trim()) | Out-Null
    }
}

$sorted = ($distinct | Sort-Object)
$casing = (Get-CasingExpressions)

foreach ($item in $sorted)
{
    if ($casing -notcontains $item)
    {
        Write-Host $item
    }
}
