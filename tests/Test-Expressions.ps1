function Get-CasingExpressions
{
    return @(
        "cSpell",
        # "ext steps",
        # "anagement groups",       # TODO: Handle before and after conditions.
        # "ole-based",
        "GitHub",
        "PolyBase",
        "Pluralsight",
        "SKU"
    )
}

function Get-InvalidTermExpressions {

    return @(
        "a number of",
        "ad-hoc",
        "adhoc",
        "auto-(?!enroll)"       # 'auto-enroll' is allowed.
        "business'[^s]",
        "CAF",
        "carry out",
        "check list",
        "Cosmos-DB",
        "CosmosDB",
        "cSpell:disable",
        "data center",
        "data centers",
        "e\.g\.",
        "express route",
        "git hub",
        "hte",
        "i\.e\.",
        "in case of",
        "infra",
        "life cycle",
        "Maria.DB",
        "MFA",
        "multi-(?!factor|model|shard)",
        "off-site",
        "on-board",,
        "on-boarded",
        "on-boarding"
        "on going",
        "on-going",
        "on-prem",
        "on-premise",
        "planing",
        "pre-(?!CCoE)",
        "skillset",
        "skillsets",
        "teh",
        "w\/"
    )
}

function Get-LinkExpressions
{
    return @(

            ": \/azure\/architecture",
            "\(\/azure\/architecture",
            "\(\/",
            "\/\)",
            "href: https:\/\/docs\.microsoft\.com\/(?!cloud-adoption-framework\/|learn\/).*[^n]$",   # Use TOC redirects for other Docs content
            "href: https:\/\/(?!docs\.microsoft\.com\/).*toc=",       # Don't use TOC redirects for non-Docs content
            "href: https:\/\/docs\.microsoft\.com\/learn\/.*toc=",   # Don't use TOC redirects for Learn content
            "app.pluralsight.com",                              # Use www.pluralsight.com/courses/...
            "www.pluralsight.com\/library",
            # "``` ?[A-Z]"
            # "\]\([^h][^/# ]*\/[^# \)\?]*[^dg][#\)]"    # TODO: Local links require MD extension.
            "<endoflist>"
    )
}

function Get-PunctuationExpressions
{
    return @(
        "[a-z]\.  [A-Z]",   # Use only one space after a sentence
        "^ *\*\s"           # Use hyphens for bullet lists
        # ^ *[^a-z#:$`].*[a-z]$         # TODO: Sentences should end with periods.
    )
}
