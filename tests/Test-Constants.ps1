function Get-RegexForUrl
{
    return '(?i)https?:\/\/[a-zA-Z0-9-\.]*\/?[a-zA-Z0-9\/\-:\.&=_%\+\?#,]*'
}

function Get-RegexForDocsUrl
{
    return '(?i)https?:\/\/docs.microsoft.com\/[a-zA-Z0-9\/\-:\.&=_%\]*'
}

function Get-RegexForImagePath
{
    return '(?i)[a-zA-Z0-9\/\-:\.&=_%\+]*\.(png|jpg)'
}

function Get-RegexForWordBoundaryPrefix
{
    return '[^\.\/]'
}

function Get-RegexForWordBoundarySuffix
{
    return '[^-0-9\.]'
}

function Get-RegexForIgnoredTerms
{
    return "<!-- cSpell:ignore [A-Za-z' ]* -->"
}

function Get-FileContents(
    [System.IO.FileInfo] $file
)
{
    $text = Get-Content -Path $file.FullName -Raw
    return $text
}
