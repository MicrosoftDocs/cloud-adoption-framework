$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Test-Constants.ps1
. $here\Test-Helpers.ps1
. $here\Test-Terms.ps1
. $here\Test-Expressions.ps1

Describe "Test-Expressions" -Tags "Expressions" {

    It "All expression functions return at least one value." {
        
        $all = @(
            $(Get-CasingExpressions),
            $(Get-InvalidTermExpressions),
            $(Get-MalformedLinkExpressions),
            $(Get-PunctuationExpressions),
            $(Get-InvalidFormattingExpressions)
        )

        foreach ($item in $all.GetEnumerator())
        {
            $item.Count | Should -BeGreaterThan 0
        }
    }
}
