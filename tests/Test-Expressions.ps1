function Get-CasingExpressions
{
    return @(
        "ext steps"
        "anagement groups",
        "ole-based",
        "GitHub",
        "PolyBase"
    )
}

function Get-CompoundWordExpressions {

    return @(
        "a number of",
        "ad-hoc",
        "business'[^s]",
        "carry out",
        "check list",
        "cSpell:disable",
        "express route",
        "git hub",
        "life cycle",
        "multi-(?!factor|model|shard)",
        "off-site",
        "on-board",
        "on going",
        "on-going",
        "on-premise\b",
        "skillset"
    )
}

function Get-AbbreviationExpressions
{        
    return @(
        "CAF",
        "MFA",
        "e\.g\.",
        "i\.e\.",
        "w\/\b"
    )
}

function Get-LinkExpressions
{
    return @(

            ": \/azure\/architecture",
            "\(\/azure\/architecture",
            "\(\/",
            "\/\)",
           # "``` ?[A-Z]"
			"<endoflist>"
    )
}

function Get-PunctuationExpressions
{
    return @(
        "^ *\*\s"           ## Use hyphens for bullet lists
    )
}
