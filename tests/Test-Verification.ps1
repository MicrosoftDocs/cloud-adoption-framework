function Get-Rule(
    [string] $regexForRule)
{
    $rule = $regexForRule
    Write-Host 'RULE: '
    Write-Host $rule
    return $rule
}
