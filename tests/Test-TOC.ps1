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


function Test-ExternalLinks([string] $tocFile = '')
{

    if (-not ($tocFile.Trim().EndsWith("toc.yml"))) {
        "TOC file not specified."
        exit
    }

    $text = Get-Content $tocFile

    $expression = Get-RegexForUrl
    $regex = [regex]::new($expression)
    $matches = $regex.Matches($text)

    $count = 0

    if ($matches.Count -gt 0)
    {
        for ($i = 0; $i -lt $matches.Groups.Count; $i++)
        {
            $uri = $matches.Groups[$i].Value
            $result = Test-Uri $uri

            if ($result -ne 200)
            {
                Write-Host "RESULT: $result - $uri"
                $count++
            }       
        }
    }

    return $count
}

function Test-PageLinks([string] $filePath)
{

    $text = Get-Content $filePath

    $regex = [regex]::new($expression)
    $expression = Get-RegexForUrl

    $hits = $regex.Matches($text)

    $count = 0

    if ($hits.Count -gt 0)
    {
        for ($i = 0; $i -lt $hits.Groups.Count; $i++)
        {
            $uri = $hits.Groups[$i].Value
            $result = Test-Uri $uri

            if ($result -ne 200)
            {
                Write-Host "RESULT: $result - $uri"
                $count++
            }       
        }
    }

    return $count
}

function Test-Uri([string] $uri)
{
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
