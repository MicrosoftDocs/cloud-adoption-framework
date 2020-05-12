$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"
. "$here\Test-Helpers.ps1"
. "$here\Test-Paths.ps1"

$files = Get-ContentFiles $(Get-ExcludedSubfolders)
Test-AllLocalPaths $files $true 100

