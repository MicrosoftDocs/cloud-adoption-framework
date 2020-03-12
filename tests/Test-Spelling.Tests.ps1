$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Spelling.ps1"

Describe -Tags "Spelling" "Test-Spelling" {

    It "shouldn't have spelling errors" {
        Test-Spelling $here 'decision-guides' | Should -Be 0
    }
    
    It "shouldn't have spelling errors" {
        Test-Spelling $here 'digital-estate' | Should -Be 0
    }
    
    It "shouldn't have spelling errors" {
        Test-Spelling $here 'getting-started' | Should -Be 0
    }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'govern' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'infrastructure' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'innovate' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'manage' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'operating-model' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'organize' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'plan' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'ready' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'reference' | Should -Be 0
    # }
    
    # It "shouldn't have spelling errors" {
    #     Test-Spelling $here 'strategy' | Should -Be 0
    # }
}

Describe -Tags "Markdown" "Test-Markdown" {

    It "shouldn't have markdownlint errors" {
        Test-Markdown $here "md" | Should -Be 0
    }
}

## TESTS TO ADD:

## Describe -Tag Navigation "BreadCrumbs" "Test-Breadcrumbs" {}

## Describe -Tag Navigation "NextSteps" "Test-NextSteps" {}
