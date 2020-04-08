$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"

. "$here\Test-Helpers.ps1"

Describe "Test-Helpers" -Tags "Helpers" {

    It "HerePath exists" {
        write-host $(Get-HerePath)
        Test-Path $(Get-HerePath) | Should -Be $true
    }

    It "DocsPath exists" {
        write-host $(Get-DocsPath)
        Test-Path $(Get-DocsPath) | Should -Be $true
    }

    It "TocFilePath exists" {
        write-host $(Get-TocFilePath)
        Test-Path $(Get-TocFilePath) | Should -Be $true
    }

    It "GetFiles returns results" {
        $files = Get-Files @("*.md", "*.yml")
        $files.Count | Should -BeGreaterThan 100
    }

    It "GetContentFiles with subfolder returns results" {
        $files = Get-ContentFiles "reference"
        $files.Count | Should -BeGreaterThan 0
        $files.Count | Should -BeLessThan 20
    }

    It "GetContentFiles returns results" {
        $files = Get-ContentFiles
        $files.Count | Should -BeGreaterThan 100
    }

    It "StringChopStart chops the string" {
            Get-StringChopStart "ThisIsMyString" "thisis"| Should -Be "MyString"
    }

    It "StringChopStart leaves the string alone" {
        Get-StringChopStart "ThisIsMyString" "test"| Should -Be "ThisIsMyString"
    }
}
