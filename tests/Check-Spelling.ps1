$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here\Get-ProcessOutput.ps1"

function Check-Spelling()
{
    $output = Get-ProcessOutput -FileName "$here\check-spelling.cmd" -Args "../docs/strategy/**/*.md"

    $output
} 

Check-Spelling