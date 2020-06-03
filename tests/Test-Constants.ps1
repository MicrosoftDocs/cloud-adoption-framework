$global:testProperties = [TestProperties]::new

class TestProperties {
    [TestRegex]$regex

    TestConstants() {
        $this.Regex = [TestRegex]::new()
    }
}

class TestRegex {

    [string] ForUrl() { return Get-RegexForUrl }
    [string] ForDocsUrl() { return Get-RegexForDocsUrl }
    [string] ForDomainName() { return Get-RegexForDomainName }
    [string] ForUrlPath() { return Get-RegexForUrlPath }
    [string] ForLocalPath() { return Get-RegexForLocalPath }
    [string] ForWordBoundaryPrefix() { return Get-RegexForWordBoundaryPrefix }
    [string] ForIgnoredTerms() { return Get-RegexForIgnoredTerms }

}

function Get-RegexForUrl
{
    $regexForUrlPath = Get-StringChopStart $(Get-RegexForUrlPath) '(?i)'
    return "(?i)$(Get-RegexForDomainName)$regexForUrlPath"
}

function Get-RegexForDocsUrl
{
    $regexForUrlPath = Get-StringChopStart $(Get-RegexForUrlPath) '(?i)'
    return "(?i)https?://docs\.microsoft\.com/$regexForUrlPath"
}

function Get-RegexForDomainName
{
    return '(?i)https?://[a-zA-Z0-9-\.]*/?'
}

function Get-RegexForUrlPath
{
    return '(?i)[a-zA-Z0-9/\-:\.&=_%\+\?#,]*'
}

function Get-RegexForLocalBookmark
{
    return '(?<=\()#[^\)]*(?<!\))'
}

function Get-RegexForLocalPath
{
    '(?<=(="|: |\]\())[a-zA-Z0-9-/\._]*\.(md|yml|png|jpg|svg)(#[\w-]+)?'
}


# function Get-RegexForImagePath
# {
#     return '(?i)[a-zA-Z0-9/\-:\.&=_%\+]*\.(png|jpg|svg)'
# }

function Get-RegexForPageHeading
{
    return "(^#+ )$(Get-RegExForTitle)"
}

function Get-RegexForLinkTitle
{
    return "\[$(Get-RegexForTitle)\]"
}

function Get-RegexForBulletHeading
{
    return "- \*\*$(Get-RegexForTitle)\][:\.]\*\*"
}

function Get-RegexForTitle
{
    return "[\w \(\)'""\.,:/\?_-]*"
}

function Get-RegexForWordBoundaryPrefix
{
    return '[^\./]'
}

function Get-RegexForWordBoundarySuffix
{
    return '[^-0-9\.]'
}

function Get-RegexForIgnoredTerms
{
    return "cSpell:ignore [A-Za-z' ]*"
}

function Get-RegexForCapitalizedPhrase
{
    # TODO: Build this.
    # [^\w][a-z]\w* ([A-Z]\w* )+[a-z]\w*[^\w]
}
