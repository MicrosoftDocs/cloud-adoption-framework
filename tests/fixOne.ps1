. .\Test-Includes.ps1
. .\Test-Paths.ps1

$file = $(Get-Item "..\docs\ready\landing-zone\terraform-landing-zone.md") 
Test-AllLocalPaths @($file) $true
