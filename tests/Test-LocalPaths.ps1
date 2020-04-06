$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-AllLocalPaths(
    [System.IO.FileInfo[]] $files
    )
{
    $count = 0

    foreach ($file in $files) {
        try {
            $result = Test-LocalPath $file
            $count += $result
        }
        catch {
            write-host "EXCEPTION IN $($file.FullName)"
        }
    }

    return $count
}

function Test-LocalPath([System.IO.FileSystemInfo] $file)
{
    $expressions = @(
        "\([a-zA-Z0-9-\/\._]*\.(md|png)[\)#]",
        "\]\(\.[a-zA-Z0-9-\/\._]*[a-ce-fh-z]\)",
        "\[[a-zA-Z0-9-\/\._]*\]: [a-zA-Z0-9-\/\.:_]*",
        "<a href=""\.[a-zA-Z0-9-\/\._]*",
        "<img src=""\.[a-zA-Z0-9-\/\._]*",
        "redirect_url"": ""https:\/\/docs.microsoft.com\/azure\/cloud-adoption-framework\/.*""",
        "href: [a-zA-Z0-9-\/\._]*\.md"
    )

    $text = Get-FileContents $file
    $count = 0

    foreach ($expression in $expressions) {
        
        if ($expression.Trim().Length -gt 0) {

            $regex = [regex]::new($expression)

            foreach ($match in ($regex.Matches($text))) {   
                
                $relativePath = $match.Value
                $relativePath = Get-StringChopStart $relativePath "<a href="""
                $relativePath = Get-StringChopStart $relativePath "<img src="""
                
                if ($relativePath.StartsWith("["))
                {
                    if ((-not $relativePath.Contains("/")))
                    {
                        continue
                    }

                    $linkName = $relativePath.Substring(0, $relativePath.IndexOf(":"))
                    $selection = ($text | select-string -Pattern $linkName.Replace('[', '\[').Replace(']', '\]') -AllMatches)
                    if ($selection.Matches.Count -lt 2)
                    {
                        write-host "ORPHANED LINK IN $($file.FullName):  $linkName"
                        $count++
                    }

                    if ($relativePath.Contains("https:"))
                    {
                        continue
                    }

                    $relativePath = $relativePath.Substring($relativePath.IndexOf(":") + 2)
                }
                elseif ($relativePath.StartsWith('(') -and ($relativePath.EndsWith(')') -or $relativePath.EndsWith('#') ))
                {
                    $relativePath = $($relativePath.Substring(1, $relativePath.Length - 2))
                }
                elseif ($relativePath.StartsWith('redirect_url'))
                {
                    $relativePath = $($relativePath.Substring(74, $relativePath.Length - 75)) + ".md"
                }
                
                $relativePath = Get-StringChopStart $relativePath 'href: '
                $relativePath = Get-StringChopStart $relativePath '"'

                $absolutePath = join-path $($file.DirectoryName) $relativePath

                if ((test-path $absolutePath) -eq $false)
                {
                    write-host "COULDN'T FIND IN $($file.FullName):  $absolutePath" 
                    $count++
                }
            }
        }
    }

    return $count
}
