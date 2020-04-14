$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"

. "$here\Test-Expressions.ps1"
. "$here\Test-Helpers.ps1"
. "$here\Test-LocalPaths.ps1"
. "$here\Test-Words.ps1"
. "$here\Test-TOC.ps1"

Describe "Test-LocalPaths" -Tags "Content" {

    It "All local links exist" {
        Test-AllLocalPaths $(Get-ContentFiles) `
            | Should -Be 0
    }
}

Describe "Test-WellFormedLinks" -Tag "Links" {
    
    It "All links are well-formed" {
        Test-AllMatches $(Get-ContentFiles) $(Get-LinkExpressions) `
            | Should -Be 0
    }
}

Describe "Test-PageLinks" -Tag @("Links", "LongRunning") {

    It "All external page links are valid" {
        Test-PageLinks $(Get-ContentFiles) `
            | Should -Be 0
    }
}

# Describe "Test-SpecificPageLinks" -Tag "Links" {

#     It "All Page1 links are valid" {
#         $item = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\innovate\kubernetes\cluster-design-operations.md"
#         Test-PageLinks @($item) | Should -Be 0
#     }
# }

Describe "Test-Casing" -Tag "Content" {

    It "Known phrases are cased properly" {
        
        $files = Get-ContentFiles

        ## TODO: Use word boundaries.

        # $files = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\govern\cost-management\best-practices.md"
        # $files = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\reference\networking-vdc.md"
        Test-AllMatches @($files) $(Get-CasingExpressions) -IgnoreUrlContents $true -RequireCasingMatch $true `
           | Should -Be 0

    }
}

Describe "Test-InvalidTerms" -Tag "Content" {

    It "All terms are valid" {
        
        Test-AllMatches @(Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\innovate\best-practices\data-dms.md") $(Get-InvalidTermExpressions) -IgnoreUrlContents $true `
            | Should -Be 0

        Test-AllMatches $(Get-ContentFiles) $(Get-InvalidTermExpressions) -IgnoreUrlContents $true `
            | Should -Be 0
    }
}

Describe "Test-Punctuation" -Tags "Style" {
    
    It "All punctuation style is correct" {

        Test-AllMatches $(Get-ContentFiles) $(Get-PunctuationExpressions) `
            | Should -Be 0

    }
}
