$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Content.ps1"
. "$here\Test-Words.ps1"

$docsPath = Resolve-Path "$here\..\docs"
$files = Get-ChildItem -Path $docsPath -Include "*.md" -Recurse

Describe "Test-Content" -Tags "Content" {

    It "All local links exist" {
        Test-LinkPaths $docsPath | Should -Be 0
    }
}

Describe "Test-Casing" -Tag "Content" {

    # It "Has no invalid compound words" {

    # }

    It "Known phrases are cased properly" {
        
        $expressions = @(
            "ext steps"
            "anagement groups",
            "ole-based",
            "GitHub"
        )

        # $file = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\reference\networking-vdc.md"
        # Test-Casing $file $expressions | Should -Be 0
        Test-AllCasings $files $expressions | Should -Be 0
    }
}

Describe "Test-CompoundWords" -Tag "Content" {

    # It "Has no invalid compound words" {

    # }

    It "No invalid compound words exist" {
        
        $expressions = @(
            "a number of",
            "ad-hoc",
            "business'\b",
            "carry out",
            "check list",
            "life cycle",
            "multi-(?!factor|model|shard)",
            "off-site",
            "on going",
            "on-going",
            "on-premise\b",
            "skillset"
        )

        Test-AllMatches $files $expressions | Should -Be 0
    }

    It "No invalid acronyms exist" {
        
        $expressions = @(
            "CAF",
            "MFA"
        )

        Test-AllMatches $files $expressions | Should -Be 0
    }

    It "All links are well-formed" {
        
        $expressions = @(
            "\(\/",
            "\/\)",
            "``` ?[A-Z]"
        )

        Test-AllMatches $files $expressions | Should -Be 0
    }
}
