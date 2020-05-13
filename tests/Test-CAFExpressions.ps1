function Get-MyIgnoredCasingExpressions
{
    return @(
        # 'CloudAdoptionFramework'
        # 'Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template'
        # 'CAF%20Readiness%20Naming%20and%20Tagging%20tracking%20template'
        'SMART'
    )
}

function Get-MyCasingPrefixExpressions
{
    return @(
        '\bGet started: '
        '\b[Ii]n \['
        '\bJump to: \['
        '\bStep \d\d?: '
    )
}

function Get-MyMalformedLinkExpressions
{
    return @(
        'toc=/azure/(?!cloud-adoption-framework)'   # Currently, no expected contextual TOCs other than AAC and CAF.
    )
}

function Get-MyPunctuationExpressions
{
    return @(
        '(?<!vs)[\.\?!] [\[\(]?[a-z]'           # Sentences should be uppercase.
        '[^\*]\*\w+\*[^\*]'
    )
}

function Get-MyInvalidFormattingExpressions
{
    return @(
        '/\)!!)'
        '- \[Learn more\]\((.*)\) about (the )?(.*?)(?=[\.,])!!- Learn more about $2[$3]($1)'
        'See \[(.*?)\]\((.*)\) for more (?:details?|information)\.!!For more information, see [$1]($2).'

        # '[a-z](?<!Microsoft|Az|Registration)\.[A-Z][a-z]* '
        # '[^ \n-]\|'       # TODO: Include spacing around table pipes.
        # '\|[^ \r\n-]'       # TODO: Include spacing around table pipes.
        
        # '[^ >`\\\n-]<(?!/(h3|p|a|i)>)'    # TODO: Include spacing around HTML tags.
        #     #  '(?<![ >`\\\n-])<(?![a-z]+>)'
        
        # 'the following.*: (?!.*<li>)[A-Za-z]'   # TODO: Use a bulleted list.
    )
}

function Get-MyPrevalidationExpressions
{
    # FORMAT: Regex to match, 
    # with a capture group for the value to autocorect,
    # followed by two bangs (!!), then the correct value to use.
    # If the correct value is preceded by two tildes (~~),
    # it's displayed as a suggestion and not made as a correction.

    return @(
        # '(?<!FIPS) \d+[\u2013\u2014-]\d+!!&ndash;'
        )

    $list = Add-ToList $list $myList
    return $list
}
