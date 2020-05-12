# TODO: Investigate extension methods with parameters.
#Update-TypeData -TypeName System.String -MemberType ScriptMethod `
#    -MemberName ChopStart  -Value { return "Text"" }

using namespace System.Collections.Generic

$here = $global:herePath

. $here\Test-MyRepo.ps1

. $here\Class-TestLog.ps1
. $here\Class-TestContext.ps1
. $here\Class-TestString.ps1
. $here\Class-Page.ps1

. $here\Test-Constants.ps1
. $here\Test-StringHelpers.ps1

function Get-HerePath {
    return $global:herePath
}

function Get-DocsPath {
    $path = Resolve-Path (Join-Path $(Get-HerePath) $(Get-RelativeDocsPath))
    if (-not (Test-Path $path))
    {   
        [TestLog]::WriteLine("PATH NOT FOUND: $path")
    }

    return $path
}

function Get-TocFilePath {
    $path = Resolve-Path (Join-Path $(Get-DocsPath) "toc.yml")
    if (-not (Test-Path $path))
    {   
        [TestLog]::WriteLine("PATH NOT FOUND: $path")
    }
    
    return $path
}

function Get-RedirectFilePath {
    $path = Resolve-Path (Join-Path $(Get-DocsPath) "..\.openpublishing.redirection.json")
    if (-not (Test-Path $path))
    {   
        [TestLog]::WriteLine("PATH NOT FOUND: $path")
    }
    
    return $path
}

function Get-MyUrl()
{
    return "$(Get-MyDomain)$(Get-MyUrlRoot)"
}

function Join-Uri([string]$path, [string]$childPath)
{
    $path = (Get-StringMustEndWith $path '/')
    $uri = [System.Uri]::new($path)

    $childPath = (Get-StringChopStart $childPath '/')
    $childPath = (Get-StringMustEndWith $childPath '/')
    
    try
    {
        $uri2 = [System.Uri]::new($uri, $childPath)
    }
    catch
    {
        Write-LogError($_, "EXCEPTION in Join-Uri", $file, $($MyInvocation).MyCommand)
        Write-Host($_)
    }
    
    return $(Get-StringChopEnd $uri2.ToString() '/')
}

function Get-Subfolders(
    [string[]] $excludedSubfolders,
    [bool] $addRootReference = $false
) {

    $subfolders = [List[string]](`
        Get-ChildItem ..\docs\* -Directory `
        | ForEach-Object { $_.Name } `
        | Where-Object { $excludedSubfolders -notcontains $_ })
    
    # TODO: Does this still fail with all but one subfolder excluded?

    if ($addRootReference)
    {
        [void]$subfolders.Add("ROOT")
    }

    return $subfolders
}

function Get-FileContents(
    [System.IO.FileInfo] $file
)
{
    #TODO: Convert to StreamReader for improved performance.
    # https://docs.microsoft.com/windows-server/administration/performance-tuning/powershell/script-authoring-considerations
    # https://docs.microsoft.com/archive/blogs/ashleymcglone/slow-code-top-5-ways-to-make-your-powershell-scripts-run-faster

    $text = Get-Content -Path $file.FullName -Raw
    return $text
}

function Get-ContentFiles(
    [string[]] $excludedSubfolders =@(),
    [string[]] $includedFileTypes = @("*.md", "*.yml")
)
{
    $specificFilesToTest = Get-SpecificFilesToTest
    if ($specificFilesToTest.Count -gt 0)
    {
        $files = $specificFilesToTest | ForEach-Object `
            { Get-Item (Join-Path $(Get-DocsPath) $_) }
    }
    else
    {
        $files = Get-Files $includedFileTypes $excludedSubfolders
    }
    
    [TestLog]::WriteLine("FILE COUNT = $($files.Count)")
    return $files
}

function Get-Files (
    [string[]] $include,
    [string[]] $excludedSubfolders = @()
)
{
    
    [TestLog]::WriteLine("GETTING FILES...")
    $docsPath = Get-DocsPath

    $files = $(Get-ChildItem -Path $docsPath -Include $include -Recurse)

    if ($excludedSubfolders.Count -eq 0)
    {
        return $files
    }

    [TestLog]::WriteLine("IGNORING SUBFOLDERS: $($excludedSubfolders)")
    
    $excludedPaths = [List[string]]::new()
    foreach ($item in $excludedSubfolders)
    {
        $path = Resolve-Path (Join-Path $docsPath $item)
        [void]$excludedPaths.Add($path)
    }
    
    $includedFiles = [List[string]]::new()

    foreach ($file in $files)
    {
        $included = $true
        foreach ($item in $excludedPaths)
        {
            if ($file.FullName.StartsWith($item))
            {
                [TestLog]::WriteSuperVerbose("SKIPPING: $($file.FullName)")
                $included = $false
                break
            }
        }

        if ($included)
        {
            [void]$includedFiles.Add($file)
        }
    }

    return $includedFiles
}

function Invoke-ExternalChecker(
    [string] $processName,
    [string] $folder,
    [string] $extension,
    [string] $additionalArguments = ''
)
{
    $commandPath = "$env:APPDATA\npm\$processName.cmd"
    $includePath = ($folder -eq 'ROOT') ? "*.$extension" : "$folder\**\*.$extension"
    $pathToCheck = Join-Path $docsPath $includePath
    $configFile = Join-Path $docsPath ".$processName.json"
    $arguments = "/c $commandPath $pathToCheck -c $configFile $additionalArguments"

    $output = Get-ProcessStream "StandardError" -FileName $env:ComSpec -Args $arguments
    return $output
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
    if ($Args) { $process.StartInfo.Arguments = $Args }
    
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
