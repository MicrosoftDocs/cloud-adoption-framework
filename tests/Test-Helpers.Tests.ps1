$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"

. "$here\Test-Helpers.ps1"

Describe "Test-Helpers" -Tags "Helpers" {

    It "Paths exists" {
        Write-Host "HerePath = $(Get-HerePath)" -ForegroundColor DarkGray
        Write-Host "DocsPath = $(Get-DocsPath)" -ForegroundColor DarkGray
        Write-Host "TocFilePath = $(Get-TocFilePath)" -ForegroundColor DarkGray

        Test-Path $(Get-HerePath) | Should -Be $true
        Test-Path $(Get-DocsPath) | Should -Be $true
        Test-Path $(Get-TocFilePath) | Should -Be $true
    }

    It "Join-Uri returns a URI" {
        $path = Join-Uri "https://docs.microsoft.com" "azure"
        Write-Host "Path1 = $path"
        $path = Join-Uri $path "cosmos-db"
        Write-Host "Path2 = $path"
        $path | Should -Be "https://docs.microsoft.com/azure/cosmos-db"
    }

    It "GetFiles returns results" {
        $files = Get-Files @("*.md", "*.yml")
        $files.Count | Should -BeGreaterThan 100
    }

    It "GetContentFiles returns results" {
        $files = Get-ContentFiles
        $files.Count | Should -BeGreaterThan 100
    }

    It "StringChopStart chops the string" {
            Get-StringChopStart "ThisIsMyString" "ThisIs" | Should -Be "MyString"
    }

    It "StringChopStart leaves the string alone" {
        Get-StringChopStart "ThisIsMyString" "Test" | Should -Be "ThisIsMyString"
    }
}
