$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-Helpers.ps1"
. "$here\Test-Content.ps1"
. "$here\Test-Words.ps1"

Describe "Test-LocalLinkPaths" -Tags "Content" {

    It "All local links exist" {
        Test-LocalLinkPaths $(Get-ContentFiles) | Should -Be 0
    }
}

Describe "Test-Casing" -Tag "Content" {

    It "Known phrases are cased properly" {
        
        $expressions = @(
            "ext steps"
            "anagement groups",
            "ole-based",
            "[^\/\.-]GitHub[^-]",
            "[^\/-]PolyBase[^-]"
        )

        # $file = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\reference\networking-vdc.md"
        # Test-Casing $file $expressions | Should -Be 0
        Test-AllCasings $(Get-ContentFiles) $expressions | Should -Be 0
    }
}

Describe "Test-CompoundWords" -Tag "Content" {

    It "No invalid compound words exist" {
        
        $expressions = @(
            "a number of",
            "ad-hoc",
            "business'[^s]",
            "carry out",
            "check list",
            "cSpell:disable",
            "express route",
            "git hub",
			"life cycle",
            "multi-(?!factor|model|shard)",
            "off-site",
            "on-board",
            "on going",
            "on-going",
            "on-premise\b",
            "skillset"
        )

#        Test-AllMatches @(Get-Item 'C:\Repos_Fork\cloud-adoption-framework-pr\docs\reference\vdc.md') $expressions $true | Should -Be 0
        Test-AllMatches $(Get-ContentFiles) $expressions -IgnoreUrlContents $true | Should -Be 0
    }
}

Describe Test-Acronyms -Tag "Content" {

    It "No invalid acronyms exist" {
        
        $expressions = @(
            "CAF",
            "MFA"
        )

        Test-AllMatches $(Get-ContentFiles) $expressions $true | Should -Be 0
    }
}

Describe "Test-WellFormedLinks" -Tag "Links" {
    
    It "All links are well-formed" {
        
        $expressions = @(
            ": \/azure\/architecture",
            "\(\/azure\/architecture",
            "\(\/",
            "\/\)",
           # "``` ?[A-Z]"
			"<endoflist>"
        )

        Test-AllMatches $(Get-ContentFiles) $expressions | Should -Be 0
    }
}

Describe Test-Punctuation -Tags "Style" {
    
    It "Punctuation style is correct" {
        $expressions = @(
            "^ *\*\s"           ## Use hyphens for bullet lists
        )

        Test-AllMatches $(Get-ContentFiles) $expressions | Should -Be 0
    }
}
