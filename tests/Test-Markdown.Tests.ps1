$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Helpers.ps1"
. "$here\Test-Markdown.ps1"

Describe "Test-Markdown" -Tags "Markdown" {

    It "shouldn't have markdownlint errors" {
        Test-Markdown $(Get-DocsPath) "md" | Should -Be 0
    }
}
