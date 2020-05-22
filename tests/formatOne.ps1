. .\Test-Includes.ps1
. .\Test-Paths.ps1

# $file = $(Get-Item "../docs\ready\enterprise-scale\implementation\contoso\design.md") 
# Test-AllLocalPaths @($file) $true $true

$filename = "../docs/migrate/azure-best-practices/contoso-migration-infrastructure.md"
$filename = "../docs/ready/considerations/storage-options.md"
cmd /c "markdownlint $filename -c ..\docs\.markdownlint.json --fix"

$files = @( (Get-Item $fileName) )
#$files = $(Get-ChildItem -Recurse -Path "../docs/ready/enterprise-scale/*.md") 
Test-AllLocalPaths $files $true $true
