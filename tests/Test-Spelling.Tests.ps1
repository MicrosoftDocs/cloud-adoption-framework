$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Spelling.ps1"

Describe -Tags "Spelling" "Test-Spelling" {

    It "should have cSpell installed" {
        Test-Spelling | Should -BeGreaterOrEqual 0
    }
    
    It "should return 0 results" {
        Test-Spelling '$here\..\docs\**.*.md' | Should -Be 0
    }
}
