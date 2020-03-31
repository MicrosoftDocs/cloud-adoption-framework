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

# Describe "Test-Casing" -Tag "Content" {

#     # It "Has no invalid compound words" {

#     # }

#     It "Known phrases are cased properly" {
        
#         $expressions = @(
#             "Next steps"
#             #"management groups",
#             #"role-based"
#         )

#         # Test-AllCasings $files $expressions
#         $file = Get-Item "C:\Repos_Fork\cloud-adoption-framework-pr\docs\reference\networking-vdc.md"
#         Test-Casing $file $expressions
#     }
# }
