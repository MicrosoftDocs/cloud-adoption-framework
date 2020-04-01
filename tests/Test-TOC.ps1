function Test-OrphanedFiles([string] $tocFile, [string[]] $ignoreFiles)
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

    $expression = '(?i)href: https:\/\/[a-zA-Z0-9-\.]*\/[a-zA-Z0-9\/\-:\.&=_]*'

    $text = Get-Content $tocFile

    $hits = ([regex]$expression).Matches($text)

    $count = 0

    if ($hits.Count -gt 0)
    {
        for ($i = 0; $i -lt $hits.Groups.Count; $i++)
        {
            $uri = $hits.Groups[$i].Value.Replace('href: ', '')
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
    $expression = '(?i)https:\/\/[a-zA-Z0-9-\.]*\/[a-zA-Z0-9\/\-:\.&=_]*'

    $text = Get-Content $filePath

    $hits = ([regex]$expression).Matches($text)

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
        if ($request.StatusCode -eq 301)
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
