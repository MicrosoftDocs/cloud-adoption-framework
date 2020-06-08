. .\Test-Includes.ps1
. .\Test-Paths.ps1
. .\Test-Spelling.ps1

$filename = "c:\repos_fork\cloud-adoption-framework-pr\docs\ready\enterprise-scale\contoso\index.md"
cmd /c "markdownlint $filename -c c:\repos_fork\cloud-adoption-framework-pr\docs\.markdownlint.json --fix"

$files = @( $(Get-Item $filename) )
$files = dir -recurse c:\repos_fork\cloud-adoption-framework-pr\docs\ready\enterprise-scale\*.md

Test-AllLocalPaths $files $true
