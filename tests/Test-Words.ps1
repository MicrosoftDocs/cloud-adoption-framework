$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-AllMatches {
    [CmdletBinding()]    
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]] $files,
        [string[]] $expressions,
        [bool] $ignoreUrlContents = $false,
        [bool] $requireCasingMatch = $false,
        [bool] $testLinks = $false
    )

    $count = 0
    
    foreach ($file in $files)
    {
        $result = Test-Match $file $expressions $ignoreUrlContents $requireCasingMatch $testLinks
        $count += $result
    }

    return $count
}

function Test-Match(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions, 
    [bool] $ignoreUrlContents = $false,
    [bool] $requireCasingMatch = $false,
    [bool] $testLinks = $false
    )
{
    $count = 0
    $text = Get-FileContents $file
    
    if ($testLinks)
    {
        $expressions = @($(Get-RegexForUrl))
    }
    elseif ($ignoreUrlContents)
    {
        $text = Remove-Urls $text 
    }

    foreach ($originalExpression in $expressions) {
    
        if ($originalExpression.Trim().Length -gt 0) {

            if ($requireCasingMatch)             {
                $expression = "(?i)$originalExpression"
            }
            else {
                $expression = $originalExpression
            }

            $options = [Text.RegularExpressions.RegexOptions]::Multiline
            $regex = [regex]::new($expression, $options)

            foreach ($match in $regex.Matches($text)) {
            
                if ($testLinks)
                {
                    $uri = $match.Value
                    $result = Test-Uri $uri

                    if ($result -ne 200)
                    {
                        Write-Host "RESULT: $result - $uri"
                        $count++
                    }
                }
                elseif ($requireCasingMatch)
                {
                    if (-not ($match.Value -clike $originalExpression))
                    {
                        write-host "Case mismatch '$($match.Value)' in $($file.FullName)"
                    }
                }
                else
                {
                    write-host "Match '$($match.Value)' found in $($file.FullName)"
                    $count++
                }
            }
        }
    }

    return $count
}

function Remove-Urls(
    [string]$text) 
{

    $expression = Get-RegexForUrl
    $regex = [regex]::new($expression)

    foreach ($match in $regex.Matches($text))
    {
        $text = $text.Replace($match.Value, "")
    }

    return $text
}
