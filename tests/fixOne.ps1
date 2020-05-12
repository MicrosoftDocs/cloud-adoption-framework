. .\Test-Includes.ps1
. .\Test-Paths.ps1

$file = $(Get-Item "..\docs\reference\fundamental-concepts\hierarchy-azure-tools.md") 
Test-AllLocalPaths @($file) $true
