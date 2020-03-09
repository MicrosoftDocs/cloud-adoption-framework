$file = ".\.vscode\settings.json"

$stream = New-Object System.IO.StreamReader ($file)

$text = $stream.ReadToEnd()

$stream.Close()

$text = $text.Replace('"cSpell.enabled": true,', '')
$text = $text.Replace('cSpell.', '')

Set-Content -Path ".\.cspell.json" -Value $text.ToString()
