# . "$here/Test-Constants.ps1"

#Update-TypeData -TypeName System.String -MemberType ScriptMethod `
#    -MemberName ChopStart  -Value { return "Text"" }

function Get-HerePath {
    return $global:herePath
}

function Get-DocsPath {
    $path = Resolve-Path (Join-Path $(Get-HerePath) "\..\docs")
    return $path
}

function Get-TocFilePath {
    $path = Resolve-Path (Join-Path $(Get-DocsPath) "toc.yml")
    return $path
}

function Get-ContentFiles(
    [string] $subfolder = ''
) {
    return $(Get-Files @("*.md", "*.yml") $subfolder)
}

# function Get-MarkdownFiles(
#     [string] $subfolder = ''
# )
# {
#         return $(Get-Files @("*.md") $subfolder)
# }

function Get-Files (
    [string[]] $include,
    [string] $subfolder = ''
)
{
    $path = Resolve-Path (Join-Path $(Get-DocsPath) $subfolder)
    return $(Get-ChildItem -Path $path -Include $include -Recurse)
}

function Get-ProcessStream
{
    Param (
                [Parameter(Mandatory=$true)]$Stream,
                [Parameter(Mandatory=$true)]$FileName,
                $Args
    )
    
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.RedirectStandardOutput = ($Stream -eq 'StandardOutput')
    $process.StartInfo.RedirectStandardError = ($Stream -eq 'StandardError')
    $process.StartInfo.FileName = $FileName
    if($Args) { $process.StartInfo.Arguments = $Args }
    
    $process.Start()
    
    if ($Stream -eq "StandardOutput")
    {
        $output = $process.StandardOutput.ReadToEnd()
    }
    elseif ($Stream -eq "StandardError")
    {
        $output = $process.StandardError.ReadToEnd()
    }

    $output
}

function Get-StringChopStart(
    [string] $text,
    [string] $textToChop
)
{
    if ($text.StartsWith($textToChop, 'CurrentCultureIgnoreCase'))
    {
        return $text.Substring($textToChop.Length, $text.Length - $textToChop.Length)
    }
    else
    {
        return $text
    }
}