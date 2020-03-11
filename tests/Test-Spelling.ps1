$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Get-ProcessOutput.ps1"

function Test-Spelling([String] $spellingArgs = '')
{
    $output = Get-ProcessOutput -FileName "cmd" -Args "/c $here\test-spelling.cmd $spellingArgs"

    if ($spellingArgs.Length -eq 0)
    {
        $result = If ($output -match "Options:") { 0 } else { -1 }
        return $result
    }
    else
    {
        $expression = "Issues found: (?<issues>[0-9]*) in "
        $hits = ([regex]$expression).Matches($output.StandardError)
        if ($hits.Count -gt 0)
        {
            $issues = $hits.Groups[1].Value
        }
        else
        {
            throw "Unexpected process output: '$($output.StandardError)'"
        }

        return $issues
    }
} 
