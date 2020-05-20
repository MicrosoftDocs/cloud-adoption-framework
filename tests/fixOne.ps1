. .\Test-Includes.ps1
. .\Test-Paths.ps1
. .\Test-Spelling.ps1

$filename = "../docs/govern/cost-management/policy-statements.md"
cmd /c "markdownlint $filename -c ..\docs\.markdownlint.json --fix"

$file = $(Get-Item $filename) 
Test-AllLocalPaths @($file) $true
