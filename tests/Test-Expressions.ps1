using namespace System.Collections.Generic

function Get-CasingPrefixExpressions
{
    try { $myList = Get-MyCasingPrefixExpressions } catch { }

    $list = [List[string]] @(
        '^[a-z]+(?:\.[a-z]+)?: "?'
        '^[A-Z]\. '                     # TODO: Supports A-H headings for Enterprise-scale landing zone content
        '\bsee \['
        '\Go to \['
        '\barticle, \['
        '\] and \['
        '\bFigure \d\d?: '
    )

    $list = Add-ToList $list $myList
    return $list
}

function Get-IgnoredCasingExpressions
{
    try { $myList = Get-MyIgnoredCasingExpressions } catch { }

    $list = [List[string]] @(
        # '(?<=[A-Za-z,:]) (\*\*\w)'
        # 'br'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'HTTP'
        'HTTPS'
        'IT'
        'JSON'
        'machine learning'
        'PR'
        'US'
        '<endoflist>'
    )

    $list = Add-ToList $list $myList
    return $list
}

function Get-MalformedLinkExpressions
{
    try { $myList = Get-MyMalformedLinkExpressions } catch { }

    $list = [List[string]] @(
            "$(Get-RegexForDocsUrl)\.(md|yml)"
            "\([^~\.][^\)]*\.(md|yml)\)"
            "\]\(\.[a-zA-Z0-9-/\._]*\)(?<!(md|ml|ng|vg|pg)\))"
            "\[[^\]]*\]\(/azure"
            "(?<!social_image_url): /azure/architecture"
            "\(/azure/architecture"
            "\(/"
            # "/\)"                            # TODO: Re-evaluate.
            "(?<!portal|account|cloudapp|cosmos|notebooks)[\./]azure\.com(?!mands)"      # Use 'azure.microsoft.com'
            "ms\.portal"                                       # Don't use internal "ms." prefix
            "toc=[^/]"                                         # Use a relative reference for a contextual TOC.
            "toc=/azure/(?!cloud-adoption-framework)"           # Currently, no expected contextual TOCs other than AAC and CAF.
            # "href: https://docs.microsoft.com/(?!cloud-adoption-framework/|learn/|/assessments).*[^n]$"   # TODO: Use TOC redirects for other Docs content
            "(?i)http://[a-z]*\.microsoft\.com"                      # Use HTTPS for all Microsoft URLs.
            "href: /"
            "href: https://(?!docs\.microsoft\.com/).*toc="       # Don't use a contextual TOC for non-Docs content
            "href: https://docs.microsoft.com/learn/.*toc="   # Don't use a contextual TOC for Learn content
            "app.pluralsight.com"                              # Use www.pluralsight.com/courses/...
            "www.pluralsight.com/library"                     # Ibid
            # "``` ?[A-Z]"
            "\]\(\.[^ \)#]*[\)#](?<!\.md[\)#]|\.(yml|png|jpg|svg)[\)#])"    # Local links require a known extension.
            "url: ([^\.])(?!ttps)"
            "<ul>"
            "<br ?/>"
            '\.Net\b'
            
            "<endoflist>"
    )

    $list = Add-ToList $list $myList
    return $list
}

function Get-PunctuationExpressions
{
    try { $myList = Get-MyPunctuationExpressions } catch { }

    $list = [List[string]] @(
        
        # "^ *[a-z][\w]*[^:] (?<!osTicket, )"   # TODO: Reinstate after using code blocks
        
        # "(?<!vs)[\.\?!] [\[\(]?[a-z]"       # Capitalize sentences
        
        # "(?i)[a-z]( {2,})[a-z]!! "                      # One space between words
        # "(?<=[a-z])(\. {2,})(?=[A-Z])!!. "              # Use only one space after a sentence
        # "(?<=[\.\?!\)])( {2,})[A-Za-z\d]!! "            # Use only one space after a sentence
        # "^ *\*\s"                                       # Use hyphens for bullet lists
        # "(?m)^ *?(?:>)? *?(- {2,})!!- "                 # Fix spacing for bullet lists       
        # "^[^#-].*(vs\.) !!versus"                       # Use "versus" in non-headings
        # "(\))(?![\.\?,:_\*\]\\ \r\n])!!) "              # Include space after parentheses.
        # "( & )(?![A-Z])!! and "                         # Don't use ampersands.
        # " &/or!!and/or"                                 # Don't use ampersands.
        # "(?<!:)//!!/"                                   # Don't use double-slashes.
        
        # " \* "
        # "([a-z ]{2,}, )([a-z ]{1,6}, )+(?!and|or)([a-z ]+)\."   # Missing 'and' or 'or' in series.
        # "[A-Za-z\d '-]{2,}, [\w]+, (?!and |or)[A-Za-z\d '-]+\.[ \r\n]"      # Either a missing Oxford comma, or a weird use of commas.

        "But, !!But" 
        "However,? !!But " 

        "At times "
        # "^ *[^a-z#:$`].*[a-z]$"           # TODO: Sentences should end with periods.
        "<endoflist>"
    )

    $list = Add-ToList $list $myList
    return $list
}

function Get-InvalidFormattingExpressions
{
    try { $myList = Get-MyInvalidFormattingExpressions } catch { }

    $list = [List[string]] @(
        
        '\u00A0!! '                         # Fix unicode spaces
        '\u202F!! '                         # Fix unicode spaces
        '[\u2018\u2019]!!'''                # Fix unicode quotes
        '\u201c!!"'                         # Fix unicode quotes
        '\u201d!!"'                         # Fix unicode quotes
        '\u2026!!...'                       # Fix unicode elipses
        '[\u2002-\u200B]!! '                # Fix weird unicode spaces
        '(?<=\d)\u2013(?=\d)!!&ndash;'      # Fix unicode dashes
        ' \u2013 !!&mdash;'                 # Fix unicode dashes
        '(?<=[a-z])\u2013(?=[a-z])!!-'      # Fix unicode dashes

        "( +)\r?\n!!"                                   # Trim blank lines
        "(?m)^ *\d+(\.?\)\.? )!!. "                     # Fixed numbered lists
        "(?m)^ *?(?:>)? *?(- {2,})!!- "                 # Fix spacing for bullet lists       
        "(?m)^[^#-].*(vs\.) !!versus"                   # Use "versus" in non-headings
        "(?s)(?<![\r\n])(\r?\n)#!!`r`n`r`n"             # Blank line before headings.
        "(?s)\n#+[^\n]*?(\r?\n)(?!\r?\n)!!`r`n`r`n"     # Blank line after heading.
        "(?s)((?:\r?\n){3,})!!`r`n`r`n"             # Remove extraneous blank lines



        "(?i)[a-z]( {2,})[a-z]!! "                  # One space between words
        "(?<=[a-z])(\. {2,})(?=[A-Z])!!. "          # Use only one space after a sentence
        "(?<=[\.\?!\)])( {2,})[A-Za-z\d]!! "        # Use only one space after a sentence
        "(?m)^ *(\*)\s!!-"                          # Use hyphens for bullet lists
        "(\))(?![\.\?,:_\*\]\\ \r\n])!!) "          # Include space after parentheses
        "( & )(?![A-Z])!! and "                     # Don't use ampersands
        " &/or!!and/or"                             # Don't use ampersands
        "(?<!:)//!!/"                               # Don't use double-slashes

        '(?m)(?<=^ *- \*\*.+)\*\*:!!:**'            # Include colon in boldface for bullet list headings
        '(?m)(?<=^ *- \*\*.+)\*\*\.!!.**'           # Include period in boldface for bullet list headings
        '(?m)^ *>? *(\* )!!- '                      # Use hyphens for bullets instead of asterisks

        '[\u0100-\uFFFF]!!~~Remove unicode characters'



        #        "(?s)(?<![\r\n])(\r?\n)``````[a-z]+!!`r`n`r`n"  # Blank line before code block.
#        "(?s)``````(\r?\n)(?![\r\n])!!`r`n`r`n`r`n`r`n" # Blank line after code block.
        
        " \* "
        "(?:[a-z ]{2,}, )(?:[a-z ]{1,6}, )+(?!and|or)(?:[a-z ]+)\."   # Missing 'and' or 'or' in series.
        "[A-Za-z\d '-]{2,}, [\w]+, (?!and |or)[A-Za-z\d '-]+\.[ \r\n]"      # Either a missing Oxford comma, or a weird use of commas.
        '(?m)^( *\*{3,})[A-Za-z]!!**'
        '(?m)[A-Za-z](\*{3,} *)\r?\n!!:**'
        '\(https://docs.microsoft.com(?=/)[^\(]*?(/en-us/)[^\(]*?\)!!/'
        "(?m)^ *_?Figure \d+( *(?:-|&mdash;) *)!!: "         # Format diagram labels.
        "(?m)^( *_?)Figure \d+: *!!_"                        # Format diagram labels.
        '(?m)^_Figure \d+[^\r\n]*?(\.?_?)\r?\n!!._'         # Format diagram labels.
        '( *\[!\[(.*?)\]\((.*?)(?: ".*?")\)\](?:\(#\))?)!!![$2]($3)'
        
        "But, !!But " 
        "However,? !!But " 
        "do'?s and don'?t'?s!!do's and don'ts"
        '\.\.\.!!~~Don''t use ellipses'

        '\*\*([A-Z0-9-]{3,}|[a-z]+-[a-z]+)(?<!\*\*(?:CIDR|TFVC))\*\*!!`$1`'     # Use tickmarks for resource names.
        # '(?m) +(?=\r?$)!!'                      # No spaces at the end of a line.
        # '(?<=- \*\*.+)\*\*\. !!.**'
        # '(?<=- \*\*.+)\*\*\: !!.**'
        # "[\u0100-\uFFFF]"           # Remove Unicode characters
        # "\[[a-z][^\]]*$"            # Fix link descriptions split across lines.
        # "[a-z]\) - "                # TODO: Use colons after parentheses?
        # "[\(\.]\.\\"                # Don't use backslashes for local references. 
        # " \*([^\*])+\* "            # Use italics for _terms_ and backticks for `tags`, etc.
        # "[\x01-\x08\x10-\x19\x7F-\xE6\xE8-\xFF]"           # Remove ASCII special characters
        # "[\x01-\x08\x10-\x19\x7F-\xE6\xE8-\xFF].{20}"      # Gives more context to remove ASCII special characters
        # " ?- \*\*$(Get-RegexForTitle)\*\* ?[:\.-]"
        # "toc=.*%2[Ff]"
        # "^\|(?![- ])"               # Table cells should have at least one space around pipes for readability.
        # "(?<![- ])\|$"              # ibid
        # #"[^ -]\|"                  # ibid
        # #"\|[^ -]"                  # ibid
        # # "\|([^\|]){600,}\|""      # TODO: Find bullet lists and long sentences in tables
        # # TODO REINSTATE        "^ *- .*: \[.*\):"     # End these headings with a period instead.
        # "(?<!- )\*\*\["             # TODO: Don't bold inline links.
        # # TODO REINSTATE     "- \["         # Standardize bolding links as bullet point headers.
        # "\) \("
        # "^[^\[]+\]|\[[^\]]*$"       # Brackets don't match.
        # "^[^\(]+\)|\([^\)]*$"       # Parentheses don't match.
        # "\] \("                     # Space between bracket and link.
        # "\]\( "                     # Space between parenthesis and link.
        # "-w-"
        # "\b(cspell)\b"
        # "[^ ](cSpell)!! cSpell"
        # '<ul>'
        '<br >!!<br>'
        '<br ?/>!!<br>'
        '</br ?>!!(?![\r\n])'
        # '(?<![ >\n])(<br>)!! <br>'
        # '(<br>)(?! <)!!<br> '
        # '</ ?li>[^\n]'
        # '[^ ]<li>|<li>[^ ]'
        # '\][^\(\["]}'                   # Limit use of square brackets. 
        # '(?!\[!div )\[![^A-Z]+\]'       # Callouts should be capitalized.
        #TODO REINSTATE:        "^--- *\|"          # Use pipes at start of tables.

        #TODO: Test formatting without code blocks.
        #TODO REVISE:        '^ *\|(?! where| distinct).*$(?<!\|)'           # Use pipes at end of tables.

        #TODO REINSTATE:        "^ ?\|-"          # Respace tables.
#        '<endoflist>'

        # TODO REINSTATE        "description: [A-Za-z-]*ing"
# TODO REINSTATE        'title: "?[A-Za-z-]*ing'

)

    $list = Add-ToList $list $myList
    return $list
}

function Get-PrevalidationExpressions
{
    try { $myList = Get-MyPrevalidationExpressions } catch { }

    # FORMAT: Regex to match, 
    # with a capture group for the value to autocorect,
    # followed by two bangs (!!), then the correct value to use.
    # If the correct value is preceded by two tildes (~~),
    # it's displayed as a suggestion and not made as a correction.

    $list = [List[string]] @(
        # '(\u2019)!!'''
        # '(\u201c)!!"'
        # '(\u201d)!!"'
        # '(\u2026)!!...'
        # '(?<!FIPS) \d+[\u2013\u2014-]\d+!!&ndash;'
        )

    $list = Add-ToList $list $myList
    return $list
}
