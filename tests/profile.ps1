using namespace System.Collections.Generic

$here = $global:herePath = Split-Path -Parent $MyInvocation.MyCommand.Path

$Chronometer = @{
    Path = '.\Test-Paths.ps1'
    Script = { .\one.ps1 }
}

Get-Chronometer @Chronometer | Format-Chronometer

$Chronometer = $null

# $script = Get-ChildItem C:\workspace\PSGraph\PSGraph -Recurse -Filter *.ps1
# $Chronometer = @{
#     Path = $script.fullname
#    Script = {Invoke-Pester C:\workspace\PSGraph}
# }
# $results = Get-Chronometer @Chronometer 
# $results | Format-Chronometer
