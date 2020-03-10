$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Check-Spelling.ps1"

Describe -Tags "Example" "Check-Spelling" {

    It "should have cSpell installed" {
        Check-Spelling | Should -Match "Options:"
    }
    
    #It "should return 0 results" {
    #    Check-Spelling | Should -Be 0
    #}

}
