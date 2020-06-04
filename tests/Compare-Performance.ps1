param
(
    [ScriptBlock] $script1,
    [ScriptBlock] $script2,
    [ScriptBlock] $script3,
    [int] $times = 100
)

. ./Test-CAF.ps1

$watch1 = [System.Diagnostics.Stopwatch]::StartNew()
for ($i = 1; $i -le $times; $i++) { & $script1 }
$watch1.Stop()

if ($null -ne $script2)
{
    $watch2 = [System.Diagnostics.Stopwatch]::StartNew()
    for ($i = 1; $i -le $times; $i++) { & $script2 }
    $watch2.Stop()
}

if ($null -ne $script3)
{
    $watch3 = [System.Diagnostics.Stopwatch]::StartNew()
    for ($i = 1; $i -le $times; $i++) { & $script3 }
    $watch3.Stop()
}

Write-Host "DURATION: $($watch1.Elapsed)"
Write-Host "DURATION: $($watch2.Elapsed)"
Write-Host "DURATION: $($watch3.Elapsed)"
