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
