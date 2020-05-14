. .\Test-Includes.ps1
. .\Test-Paths.ps1

$file = $(Get-Item "../docs/organize/central-it.md") 
Test-AllLocalPaths @($file) $true
