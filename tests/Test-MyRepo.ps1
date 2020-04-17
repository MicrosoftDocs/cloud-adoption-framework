function Get-Subfolders {
    return @(
        # "decision-guides",
        # "digital-estate",
        # "getting-started"
        #,
        # "govern",
        # "infrastructure",
        # "innovate",
        # "manage",
        # "migrate",
        # "operating-model",
        # "organize",
        # "plan",
        # "ready",
        # "reference",
        # "strategy"
    )
}

function Get-UrlForToc {
    return "https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json"
}
function Get-UrlPrefixesToIgnore {
    return @(
        "aka.ms",
        "https://youtube.com"
    )
}

function Get-TocFilesToIgnore {
    return @(
        ## TODOBACKLOG: Split data classification into two files using INCLUDEs.
        "govern/policy-compliance/data-classification.md",
        "migrate/azure-migration-guide/prerequisites.md",
        "migrate/azure-migration-guide/secure-and-manage.md",
        "reference/migration-with-enterprise-scaffold.md"
    )
}
