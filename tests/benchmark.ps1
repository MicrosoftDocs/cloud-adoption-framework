$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"
. "$here\Test-Helpers.ps1"
. "$here\Test-Paths.ps1"

$file = Get-Item "$here\..\docs\toc.yml"
$casing = (Get-CasingExpressions)
$times = @{}

foreach ($exp in $casing)
{
    $text = Get-Content $file -Raw

    $watch = [System.Diagnostics.Stopwatch]::StartNew()
    $result = [Regex]::Matches($text, $exp)
    $watch.Stop()

    $times[$exp] = $watch.Elapsed
}

$sorted = ($times.GetEnumerator() | Sort-Object -Property Value )

foreach ($item in $sorted)
{
    Write-Host ($item.Key + ' :: ' + $item.Value)
}