cls
$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Test-Helpers.ps1
. $here\Test-Paths.ps1
. $here\Test-CAF.ps1

$files = Get-ContentFiles $(Get-ExcludedSubfolders) @("*.md")

Test-AllLocalPaths $files $false

