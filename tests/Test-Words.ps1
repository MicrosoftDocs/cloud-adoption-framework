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

function Test-AllMatches(
    [System.IO.FileInfo[]] $files,
    [string[]] $expressions
)
{
    $count = 0
    
    foreach ($file in $files)
    {
        $result = Test-Match $file $expressions
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
    [string[]] $expressions)
{
    $count = 0
    $text = Get-Content -Path $file.FullName -Raw

    foreach ($expression in $expressions) {
        
        if ($expression.Trim().Length -gt 0) {

            $regex = $expression
            $options = [Text.RegularExpressions.RegexOptions]::Multiline
            $obj = [regex]::new($regex, $options)

            foreach ($match in $obj.Matches($text)) {
            
                write-host "Match '$($match.Value)' found in $($file.FullName)"
                $count++

            }
        }
    }

    return $count
}
