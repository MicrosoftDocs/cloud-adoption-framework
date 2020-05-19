. .\Test-Includes.ps1
. .\Test-Paths.ps1

# $file = $(Get-Item "../docs\ready\enterprise-scale\implementation\contoso\design.md") 
# Test-AllLocalPaths @($file) $true $true

$files = $(Get-ChildItem -Recurse -Path "../docs/ready/enterprise-scale/*.md") 
Test-AllLocalPaths $files $true $true
