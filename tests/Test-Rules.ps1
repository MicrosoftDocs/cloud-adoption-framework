using namespace System.Collections.Generic

function Get-RegexForSentence
{
    [OutputType([List[string]])]
    Param()

    $exp = @(
        '(?m)(|" ?|[\.\?!] |#+ ||\[|\*\*|\): |\[!|!\[|</?|<!-- |<br> ?\[?|<li> ?|::: )([A-Za-z](.+?)(?=[\.\?!](\*\*|")? |:\*\*|\): | ?\||>| (<[a-z]+>){1,2}|\n)[\.\?:\*]*)(?<sentence>.?)'
# 5/5/20                '(?m)(|" ?|[\.\?!] |#+ ||\[|\*\*|\): |\[!|!\[|</?|<!-- |<br> ?|<li> ?)([A-Za-z](.+?)(?=[\.\?!](\*\*|")? |:\*\*|\): | ?\|| ?<br> ?|\n)[\.\?:\*]*)(?<sentence>.?)'
# 5/5/20        '(?m)(|" ?|[\.\?!] |#+ ||\[|\*\*|\): |\[!|!\[|</?|<!-- |<br> ?|<li> ?)([A-Za-z](.+?)(?=[\.\?!](\*\*|")? |:\*\*|\): | ?\||\n)[\.\?:\*]*)(?<sentence>.?)'
# 5/1/20        '(?m)(|[\.\?!]"? |#+ ||\[|\*\*|\[!|!\[|</?|<!-- |<br> ?|<li> ?)([A-Za-z](.+?)(?=[\.\?!](\*\*)? |:\*\*| ?\||\n)[\.\?:\*]*)(?<sentence>.?)'    
# 5/1/20         '(?m)((?:(?:\[!|!\[|\[|\*\*|#+ )?)?(?<=(?:|[\.\?!#] |\*\*|!\[))|<!-- )([A-Za-z](.+?)(?=[\.\?!](\*\*)? |:\*\*| ?\||\n)[\.\?:\*]*)(?<sentence>.?)'
#        '(?m)((?:(?:\[!|!\[|\[|\*\*|#+ )?)?(?<=(?:|[\.\?!#] |\*\*!\[)))([A-Za-z](.+?)(?=[\.\?!](\*\*)? |:\*\*| ?\||\n)[\.\?:\*]*)(?<sentence>.?)'
#        '(?m)((?:(?:\[!|!\[|\[|\*\*|#+ )?)?(?<=(?:|[\.\?!#] |\*\*!\[)))([A-Za-z](.+?)(?=[\.\?!](\*\*)? |:\*\*| ?\||\n)[\.\?:\*]*)'
#        '(?m)((?:(?:\[!|!\[|\[|\*\*|#+ )?)?(?<=(?:|[\.\?!#] |\*\*!\[)))([A-Za-z](.+?)(?=[\.\?!](\*\*)? | ?\||\n)[\.\?\*]*)'
#        '(\[:\.]\*\* |[\.\?!] |\." |["\)]\. |<li> |Step \d\d?: |title: "?|description: "?|name: |[A-Za-z])(.+?)([:\.]\*\* |\. |\."" |\? |! |\n)'
#        '^(?<= ?)[A-Z][A-Za-z].+?[\.\?!](?=[ \n])'      ' First sentences of a regular paragraph only.

        # '(title:|summary:|description:|text:) ([^\.\n]+)'       # Metadata sentences
        # '^(([^$A-Za-z]*)([A-Za-z])[^\.\?!:]+[\.\?!:])'
        # '([\.\?!] +)([^\.\?!]+)[\.\?!]'                         # Additional sentences in a paragraph.
        '<endoflist>'
    )

    return $exp
}

function Get-RegexForSentenceStartPrefixes
{
    [OutputType([List[string]])]
    Param()

    $exp = [List[string]] @(
        '[\.\?!] +'
        '#+ '
        '^\*\*\[?'
        '[:\.]\*\* '
        '[>-] \[?'
        '[A-Za-z]\]\(\): ' 
        '\bsee \['
        '<li> ?\[?'
        '<br />|<br/>'
        ': \['
        '\| ?\[?'
        '!\['
        'name: "?'
        'text: "?'
        'title: "?'
        
        # '\*\*[\w\[]'
        # ' \*\*'
        # '## '
        # '# '
        # 'h\d>'
        # 't="'
        # '\['
        # '.?\|.?'
        # 'A '
        # '[\w\)]. '
        # 't: '
        '<endoflist>'    
        )

    return $exp -join '|'
}

function Get-RegexForSentenceMiddlePrefixes
{
    [OutputType([List[string]])]
    Param()

    $exp = [List[string]] @(
        '[\(\[]?[\w,;\(\)'']+-? ([\(\["_]|\*\*)?'
# TODO               '[\w'']+-'
        # '[\w ''][\w,] '
        # '[\w,] [\[\("]'
        # '\), '
        '<endoflist>'    
        )
    
    return $exp -join '|'
}

function Get-RegexForLink
{
    [OutputType([List[string]])]
    Param()
    
    $exp = [List[string]] @(
        "(\[[^\[]*\])\(([^\)\n]+)\)"       # Markdown-style links: [aaa](bbb)
        "(?m)^(\[[\w-]*\]:) +([^ \r\n]*)"  # [link-name]: ./path/file.md
        '(a href) *= *"([^"\r\n]*)"'       # <a ref="./path/file.md">
        '(href:) +([^ \n]+)'               # href: path/file.md
        '(url:|imageSrc:) +([^ \n]+)'      # url:, imageSrc:
        '(?m)^ *(::: +image .* +source=")([^"\r\n]*)"'      # ::: image 
        # '(="|: |\]\())+([a-zA-Z0-9-/\._]*\.(md|yml|png|jpg|svg))'   # Find markdown links.
        # "\([a-zA-Z0-9-/\._]*\.(md|yml|png|jpg|svg)[\)#]"
        # "<a href=""\.[a-zA-Z0-9-/\._]*"
        # "<img src=""\.[a-zA-Z0-9-/\._]*"
        
        # "^(\[[a-zA-Z0-9-/\._]*\]): ([a-zA-Z0-9-/\.:_]*) *"      # Find link references.
        # "\[[a-zA-Z0-9-/\._]*\]: [a-zA-Z0-9-/\.:_]*"      
        # """(redirect_url)"": ""($(Get-MyUrlRoot)/.*)"
        # "(href:) ([a-zA-Z0-9-/\._]*\.(md|yml))"
    )

    return $exp
}
