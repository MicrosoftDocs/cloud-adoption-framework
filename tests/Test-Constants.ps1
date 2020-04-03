function Get-RegexForUrl
{
    return '(?i)https?:\/\/[a-zA-Z0-9-\.]*\/[a-zA-Z0-9\/\-:\.&=_%\+]*'
    
}

function Get-RegexForDocsUrl
{
    return '(?i)https?:\/\/docs.microsoft.com\/[a-zA-Z0-9\/\-:\.&=_%\]*'
}

function Get-RegexForWordBoundaryPrefix
{
    return '[^\.\/]'
}

function Get-RegexForWordBoundarySuffix
{
    return '[^-0-9\.]'
}

function Get-FileContents(
    [System.IO.FileInfo] $file
)
{
    $text = Get-Content -Path $file.FullName -Raw
    return $text
}
