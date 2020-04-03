$here = $global:herePath

. "$here\Test-Helpers.ps1"

function Test-Spelling([string] $docsPath, [string] $folder)
{
    Copy-SpellingDictionary "$docsPath\.."

    $commandPath = "$env:APPDATA\npm\cspell.cmd"
    $pathToCheck = "$docsPath\$folder\**\*.md"
    $configFile = "$docsPath\..\.cspell.json"
    $arguments = "/c $commandPath $pathToCheck -c $configFile"

    $output = Get-ProcessStream "StandardError" -FileName $env:ComSpec -Args $arguments

    $expression = "Issues found: (?<issues>[0-9]*) in "
    $hits = ([regex]$expression).Matches($output)
    if ($hits.Count -gt 0)
    {
        $issues = $hits.Groups[1].Value
    }
    else
    {
        throw "Unexpected process output: '$output'"
    }

    return $issues
} 

function Copy-SpellingDictionary(
    [String] $repoPath)
{
    $stream = New-Object System.IO.StreamReader "$repoPath\.vscode\settings.json"

    $text = $stream.ReadToEnd()

    $stream.Close()

    $text = $text.Replace('"cSpell.enabled": true,', '')
    $text = $text.Replace('cSpell.', '')

    Set-Content -Path "$repoPath\.cspell.json" -Value $text.ToString()
}
