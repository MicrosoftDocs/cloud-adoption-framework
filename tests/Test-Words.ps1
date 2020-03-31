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

function Test-Casing(
    [System.IO.FileInfo] $file, 
    [string[]] $expressions)
{
    $count = 0
    $text = Get-Content -Path $file.FullName -Raw

    foreach ($expression in $expressions) {
        
        $regex = "(?i)$expression"

        if ($regex.Trim().Length -gt 0) {

            foreach ($match in ([regex]$regex).Matches($text)) {   
            
                $regexHash[$regex] += 1
                Write-Host $markdownFile.FullName
            
                $count++

                # $outStream.WriteLine("{0},{1}",$match.Value, $markdownFile.FullName )  
            }
        }
    }

    return $count
}
