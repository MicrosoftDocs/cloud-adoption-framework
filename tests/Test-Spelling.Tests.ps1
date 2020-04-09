$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Test-MyRepo.ps1"

. "$here\Test-Helpers.ps1"
. "$here\Test-Spelling.ps1"

Describe "Test-Spelling" -Tags "Spelling" {

    It "Shouldn't have spelling errors" {
        
        $subfolders = Get-Subfolders
        if ($subfolders.Count -eq 0)
        {
            write-host "Checking all subfolders"
            Test-Spelling $(Get-DocsPath) | Should -Be 0
        }
        else {
            foreach ($item in $subfolders)
            {
                write-host "Checking '$item'"
                Test-Spelling $(Get-DocsPath) $item | Should -Be 0
            }
        }
    }
}


## TODO: TESTS TO ADD

## Describe "Test-Breadcrumbs" {}

## Describe "Test-NextSteps" {}
