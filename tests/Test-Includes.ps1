$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Test-Classes.ps1
. $here\Test-MyRepo.ps1

. $here\Test-StringHelpers.ps1
. $here\Test-Helpers.ps1
. $here\Test-Constants.ps1
. $here\Test-Terms.ps1
. $here\Test-Expressions.ps1
. $here\Test-Rules.ps1

