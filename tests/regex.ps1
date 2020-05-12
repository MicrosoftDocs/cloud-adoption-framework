param([string] $expression, [string] $text)

Write-Host "EXPRESSION: $expression"
Write-Host "EXPRESSION: $text"

$regex = [Regex]::new($expression)
$matches = $regex.Matches($text)

Write-Host "COUNT: $($matches.Count)"
Write-Host "VALUE: $($matches.Value)"

$groups = $matches.Groups
if ($null -eq $matches.Groups)
{
    Write-Host "GROUPS: null"
}

for ($i = 0; $i -lt $groups.Count; $i++)
{
    Write-Host $groups[$i].Value
}

foreach ($capture in $matches.Captures)
{
    Write-Host $capture
}
