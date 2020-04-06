$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$here/Test-Constants.ps1"

function Test-AllCasings(
    [System.IO.FileInfo[]] $files,
    [string[]] $expressions
)
{
    $count = 0
    
    foreach ($file in $files)
    {
        $result = Test-Casing $file $expressions
        $count += $result
    }

    return $count
}

function Test-AllMatches {
    [CmdletBinding()]    
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]] $files,
        [Parameter(Mandatory)]
        [string[]] $expressions,
        [bool] $ignoreUrlContents = $false
    )

    $count = 0
    
    foreach ($file in $files)
    {
        $result = Test-Match $file $expressions $ignoreUrlContents
        $count += $result
    }

    return $count
}

function Test-Casing(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions)
{
    $count = 0
    $text = Get-Content -Path $file.FullName -Raw
    $text = Remove-Urls $text

    foreach ($expression in $expressions) {
        
        if ($expression.Trim().Length -gt 0) {

            $regex = "(?i)$expression"

            foreach ($match in ([regex]$regex).Matches($text)) {   
            
                if (-not ($match.Value -clike $expression))
                {
                    write-host "Case mismatch '$($match.Value)' in $($file.FullName)"
                    $count++
                }
            }
        }
    }

    return $count
}

function Test-Match(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions, 
    [bool] $ignoreUrlContents = $false)
{
    $count = 0
    $text = Get-FileContents $file
    if ($ignoreUrlContents -eq $true)
    {
        $text = Remove-Urls $text 
    }

    foreach ($expression in $expressions) {
        
        if ($expression.Trim().Length -gt 0) {

            $options = [Text.RegularExpressions.RegexOptions]::Multiline
            $regex = [regex]::new($expression, $options)

            foreach ($match in $regex.Matches($text)) {
            
                write-host "Match '$($match.Value)' found in $($file.FullName)"
                $count++

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
