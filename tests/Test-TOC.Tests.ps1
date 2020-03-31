$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-TOC.ps1"

Describe "Test-TOC" -Tags "TOC" {

    $tocFile = "$here\..\docs\toc.yml"

    It "No TOC items are orphaned or duplicated" {
        Test-OrphanedFiles $tocFile @("") | Should -Be 0
    }

    It "All links are valid" {
        Test-ExternalLinks $tocFile | Should -Be 0
    }
}

Describe "Test-Links" -Tag "Links" {
    
    It "Broken link is invalid" {
        $uri = "https://docs.microsoft.com/azure/architecture/guide/technology-choices/compute-decision-treeBROKEN"
        Test-Uri $uri | Should -Be -1
    }

    It "EN-US link is invalid" {
        $uri = "https://docs.microsoft.com/en-us/powerapps/maker"
        Test-Uri $uri | Should -Be -1
    }

    It "Querystring redirect link is valid" {
        $uri = "https://docs.microsoft.com/azure/devops/project/feedback"
        Test-Uri $uri | Should -Be 200
    }

    It "Trailing slash link is valid" {
        $uri = "https://docs.microsoft.com/powerapps/maker"
        Test-Uri $uri | Should -Be 200
    }

    It "Docs link is valid" {
        $uri = "https://docs.microsoft.com/azure/architecture"
        Test-Uri $uri | Should -Be 200
    }

    It "External link is valid" {
        $uri = "https://guides.github.com/introduction/git-handbook"
        Test-Uri $uri | Should -Be 200
    }

    It "TempTest link is valid" {
        $uri = "https://docs.microsoft.com/azure/devops/project/feedback"
        Test-Uri $uri | Should -Be 200
    }
}
