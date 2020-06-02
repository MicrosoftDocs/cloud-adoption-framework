using namespace System.Collections.Generic
using namespace System.Collections.Specialized

$here = $global:herePath

. $here\Test-Terms.ps1
. $here\Test-Expressions.ps1
. $here\Test-Rules.ps1

class TestContext
{
    static TestContext()
    {
        [TestContext]::Initialize()
    }
    
    [void] hidden static Initialize()
    {
        [TestContext]::CasingExpressions = Get-CasingExpressions
        [TestContext]::IgnoredCasingExpressions = Get-IgnoredCasingExpressions
        [TestContext]::CasingPrefixExpressions = Get-CasingPrefixExpressions

        $expressions = Get-InvalidTermExpressions
        [TestContext]::InvalidTermLookup = $lookup = [TestContext]::GetLookup($expressions)
        [TestContext]::InvalidTermExpressions = [TestContext]::GetListFromLookup($lookup)

        $expressions = Get-InvalidFormattingExpressions
        [TestContext]::InvalidFormattingLookup = $lookup = [TestContext]::GetLookup($expressions)
        [TestContext]::InvalidFormattingExpressions = [TestContext]::GetListFromLookup($lookup)

        [TestContext]::RuleExpressions = Get-RegexForLink
        $items = Get-RegexForSentence
        foreach ($item in $items)
        {
            [void] [TestContext]::RuleExpressions.Add($item)
        }
    }

    [List[string]] static $CasingExpressions
    [List[string]] static $IgnoredCasingExpressions
    [List[string]] static $CasingPrefixExpressions
    [List[string]] static $InvalidTermExpressions
    [List[string]] static $InvalidFormattingExpressions

    [List[string]] static $RuleExpressions

    [OrderedDictionary] static $invalidTermLookup 
    [OrderedDictionary] static $invalidFormattingLookup 

    [OrderedDictionary] hidden static GetLookup(
            [List[string]] $expressions
    )
    {
        $lookup = [ordered]@{}

        foreach ($item in $expressions)
        {
            $split = $item -split '!!'
            $correction = ($split.Length -eq 2) ? $split[1] : 'NULL'
            $lookup[$split[0]] = $correction
        }

        return $lookup
    }

    [List[string]] hidden static GetListFromLookup(
        [OrderedDictionary] $lookup
    )
    {
        $list = [List[string]]::new()
        foreach ($key in $lookup.Keys)
        {
            $list.Add($key)
        }

        return $list
    }
}

# class Rules
# {
#     [List[string]] static $RegexForSentence
#     [string] static $RegexForSentenceStartPrefixes
#     [string] static $RegexForSentenceMiddlePrefixes
#     [List[string]] static $RegexForLink

#     static Rules()
#     {
#         [Rules]::RegexForSentence = [List[string]] @(
#                 '(?m)((?:(?:\[!|!\[|\[|\*\*|#+ )?)?(?<=(?:|[\.\?!#] |\*\*!\[)))([A-Za-z](.+?)(?=[\.\?!](\*\*)? | ?\||\n)[\.\?\*]*)'
#         #        '(\[:\.]\*\* |[\.\?!] |\." |["\)]\. |<li> |Step \d\d?: |title: "?|description: "?|name: |[A-Za-z])(.+?)([:\.]\*\* |\. |\."" |\? |! |\n)'
#         #        '^(?<= ?)[A-Z][A-Za-z].+?[\.\?!](?=[ \n])'      ' First sentences of a regular paragraph only.

#                 # '(title:|summary:|description:|text:) ([^\.\n]+)'       # Metadata sentences
#                 # '^(([^$A-Za-z]*)([A-Za-z])[^\.\?!:]+[\.\?!:])'
#                 # '([\.\?!] +)([^\.\?!]+)[\.\?!]'                         # Additional sentences in a paragraph.
#             )

#             # $known = @(
#             #                 '. '
#             #                 '? '
#             #                 '. '
#             #                 '." '
#             #                 'title: '
#             #                 'description: '
#             #                 'summary: '
#             #                 'text: ')

#         [Rules]::RegexForSentenceStartPrefixes = @(
#             '[\.\?!] +'
#             '#+ '
#             '^\*\*\[?'
#             '[:\.]\*\* '
#             '[>-] \[?'
#             '[A-Za-z]\]\(\): ' 
#             'see \['
#             '<li> ?\[?'
#             '<br ?/?> ?\[?'
#             ': \['
#             '\| ?\[?'
#             '!\['
#             'name: "?'
#             'text: "?'
#             'title: "?'
            
#             # '\*\*[\w\[]'
#             # ' \*\*'
#             # '## '
#             # '# '
#             # 'h\d>'
#             # 't="'
#             # '\['
#             # '.?\|.?'
#             # 'A '
#             # '[\w\)]. '
#             # 't: '
#             '<endoflist>'    
#             )  -join '|'
        

#         [Rules]::RegexForSentenceMiddlePrefixes = @(

#             '[\(\[]?[\w,;\(\)'']+-? ([\(\["_]|\*\*)?'
#             # TODO               '[\w'']+-'
#             # '[\w ''][\w,] '
#             # '[\w,] [\[\("]'
#             # '\), '
#             '<endoflist>'    
#             ) -join '|'

#         [Rules]::RegexForLink = [List[string]] @(
#             "(\[[^\[]*\])\(([^\)\n]+)\)"       # Markdown-style links: [aaa](bbb)
#             "^(\[[\w-]*\]:) +([^ \n]*)"        # [link-name]: ./path/file.md
#             '(a href) *= *"([^"\n]*)"'         # <a ref="./path/file.md">
#             '(href:) +([^ \n]+)'               # href: path/file.md
#             '(url:|imageSrc:) +([^ \n]+)'      # url:, imageSrc:

#             # '(="|: |\]\())+([a-zA-Z0-9-/\._]*\.(md|yml|png|jpg|svg))'   # Find markdown links.
#             # "\([a-zA-Z0-9-/\._]*\.(md|yml|png|jpg|svg)[\)#]"
#             # "<a href=""\.[a-zA-Z0-9-/\._]*"
#             # "<img src=""\.[a-zA-Z0-9-/\._]*"
            
#             # "^(\[[a-zA-Z0-9-/\._]*\]): ([a-zA-Z0-9-/\.:_]*) *"      # Find link references.
#             # "\[[a-zA-Z0-9-/\._]*\]: [a-zA-Z0-9-/\.:_]*"      
#             # """(redirect_url)"": ""($(Get-MyUrlRoot)/.*)"
#             # "(href:) ([a-zA-Z0-9-/\._]*\.(md|yml))"
#             )
#     }
# }
