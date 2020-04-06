$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-MatchTocToFiles([string] $tocFile, [string[]] $ignoreFiles)
{
    if (-not ($tocFile.Trim().EndsWith("toc.yml"))) {
        "TOC file not specified."
        exit
    }

    $tocText = Get-Content $tocFile

    $path = Split-Path -Path $tocFile
    $path = Resolve-Path $path

    $files = Get-ChildItem $path -Recurse -Include *.md

    $count = 0

    foreach ($file in $files)
    {
        $fileName = $file.FullName.Replace("$($path)\", '').Replace('\', '/')
        if ($ignoreFiles -contains $fileName)
        {
            continue
        }

        $fileName = " $fileName"

        $hits = ([regex]$fileName).Matches($tocText)
        if ($hits.Count -lt 1)
        {
            Write-Host "ORPHANED: $fileName"
            $count++
        }
        elseif ($hits.Count -gt 1)
        {
            Write-Host "DUPLICATED: $fileName"
            $count++
        }
    }

    return $count
}

function Test-PageLinks([System.IO.FileInfo[]] $files)
{
    $result = Test-AllMatches $files -TestLinks $true
    return $result
}

function Test-Uri([string] $uri)
{
    if ($uri.StartsWith("https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json"))
    {
        return 200
    }

    $uri = $uri.Replace('https://docs.microsoft.com/', 'https://docs.microsoft.com/en-us/')
    $uri = $uri.Replace('https://azure.microsoft.com/', 'https://azure.microsoft.com/en-us/')
    $uri = $uri.Replace('https://developer.amazon.com/', 'https://developer.amazon.com/en-US/')
    
    $uriObject = New-Object System.Uri $uri

    try {
        $request = Invoke-WebRequest $uri -MaximumRedirection 0 -ErrorAction Ignore
    }
    catch {
        $result = -1
        return $result
    }
    
    if ($request.StatusCode -eq 200)
    {
        $result = 200
    }
    else
    {
        if ($request.StatusCode -eq 301 -or $request.StatusCode -eq 302)
        {
            $absolutePath = $uriObject.AbsolutePath
            $prefix = "$($uriObject.Scheme)://$($uriObject.Host)"
            $location = $request.Headers.Location.Replace($prefix, "")
            
            if (($location -eq "$absolutePath/") -or ($location.StartsWith("$($absolutePath)?")))
            {
                $result = 200
            }
            else 
            {
                $result = $request.StatusCode
            }
        }
        else 
        {
            $result = $request.StatusCode
        }
    }

    return $result
}
