. .\Test-Includes.ps1
. .\Test-Paths.ps1

$file = "..\docs\toc.yml"
# $file = "..\docs\overview.md"

Test-AllLocalPaths $(Get-Item $file)
