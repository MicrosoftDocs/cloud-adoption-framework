$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Test-MyRepo.ps1

. $here\Test-Terms.ps1
. $here\Test-Expressions.ps1
. $here\Test-Helpers.ps1
. $here\Test-Paths.ps1
. $here\Test-Words.ps1
. $here\Test-TOC.ps1

function Get-PotentialIssuesForReviewExpressions
{
    return @(
        # "# [A-Za-z-]*ing"
        "\.\.\."                          # Don't use ellipses
        "^#*( [A-Z]\w*){2,}"              # Use sentence casing in headings
        "^( >)*(?!title|description|author|ms.|New-|-<!--)[^\|#:\[][ -]*.{25,}[a-fh-z][a-z,]$"     # Sentences should end with periods.
        " [A-Za-z]/[A-Za-z] "               # Use 'and' or 'or'
        "[A-Za-z]\(s\)"
        # TODO: What does this expression do?
        "(^#+ )(?!\[)[\w \(\)'\.,:/\?-]*.(?<=[^\w \(\)'\.,:/\?-])"
        "([A-Z][A-Za-z]*)[^,\.\|:\?'-]{200,},"     # Review long sentences.
        "<endoflist>"
    )
}

Describe Test-DisplayPotentialIssues -Tags @("Review") {

    It "Review results for potential issues" {

        $files = Get-ContentFiles $(Get-ExcludedSubfolders)

        Test-AllMatches $files $(Get-PotentialIssuesForReviewExpressions) `
            Verbatim -ForceSuccess $true -ColorOverride DarkGray `
                | Should -Be 0
    }
} 
