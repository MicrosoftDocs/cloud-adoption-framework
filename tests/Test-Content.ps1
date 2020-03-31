function Test-LinkPaths([string] $folder)
{
    $count = 0
    $files = Get-ChildItem $folder -Include @('*.md','*.yml') -Recurse

    foreach ($file in $files) {
        try {
            $result = Test-ContentLinks $file
            $count += $result
        }
        catch {
            write-host "EXCEPTION IN $($file.FullName)"
        }
    }

    return $count
}

function Test-ContentLinks([System.IO.FileSystemInfo] $file)
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

    $fileName = $file.FullName
    $text = Get-Content $fileName -Raw
    $count = 0

    foreach ($expression in $expressions) {
        
        $regex = $expression

        if ($regex.Trim().Length -gt 0) {

            $matches = ([regex]$regex).Matches($text)
            if ($matches.Count -gt 0)
            {
                ## write-host "Found matches in $fileName."
            }

            foreach ($match in ([regex]$regex).Matches($text)) {   
                
                ## write-host $match.Value

                $relativePath = $match.Value
                
                if ($relativePath.StartsWith("<a href="""))
                {
                    $relativePath = $relativePath.Substring(9, $relativePath.Length - 9)
                }
                elseif ($relativePath.StartsWith("<img src="""))
                {
                    $relativePath = $relativePath.Substring(9, $relativePath.Length - 9)
                }
                elseif ($relativePath.StartsWith("["))
                {
                    if ((-not $relativePath.Contains("/")))
                    {
                        continue
                    }

                    $linkName = $relativePath.Substring(0, $relativePath.IndexOf(":"))
                    $selection = ($text | select-string -Pattern $linkName.Replace('[', '\[').Replace(']', '\]') -AllMatches)
                    if ($selection.Matches.Count -lt 2)
                    {
                        write-host "ORPHANED LINK IN $($fileName):  $linkName"
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
                elseif ($relativePath.StartsWith('href: '))
                {
                    $relativePath = $($relativePath.Substring(6, $relativePath.Length - 6))
                }

                if ($relativePath.StartsWith('"'))
                {
                    $relativePath = $($relativePath.Substring(1, $relativePath.Length - 1))
                }

                $absolutePath = join-path $($file.DirectoryName) $relativePath

                if ((test-path $absolutePath) -eq $false)
                {
                    write-host "COULDN'T FIND IN $($fileName):  $absolutePath" 
                    $count++
                }
            }
        }
    }

    return $count
}
