$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Test-MyRepo.ps1

. $here\Test-Helpers.ps1
. $here\Test-Terms.ps1
. $here\Test-Expressions.ps1
. $here\Test-Rules.ps1
. $here\Test-Paths.ps1
. $here\Test-Words.ps1
. $here\Test-TOC.ps1

Describe Test-ValidateCasing -Tags @('TestVerification') {
    It "Run casing validation" {

        $files = @( $(Get-Item "$here\casing-tests.md"))       

         # -DisablePrefixes $true `
        Test-AllMatches $files $(Get-CasingExpressions) WordsWithCasing `
            | Should -Be 0
    }
}

Describe Test-ListRules -Tags @('TestVerification') {
    It "Can list all rules" {

        $rule = Get-Rule $(Get-RegexForSentenceStartPrefixes)
        $rule.Length | Should -BeGreaterThan 0
    }
}
