$here = $global:herePath

. "$here\Test-Helpers.ps1"

function Test-Markdown([String] $docsPath, [String] $fileType)
{
    $commandPath = "$env:APPDATA\npm\markdownlint.cmd"
    $pathToCheck = Join-Path $docsPath "\**\*.$fileType"
    $configFile = Join-Path $docsPath ".markdownlint.json"
    $arguments = "/c $commandPath $pathToCheck -c $configFile"

    $output = Get-ProcessStream "StandardError" -FileName $env:ComSpec -Args $arguments

    $expression = " MD[0-9][0-9][0-9]"
    
    $matches = ([regex]$expression).Matches($output)
    return $matches.Count
}
