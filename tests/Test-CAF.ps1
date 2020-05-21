using namespace System.IO

function Get-SpecificFilesToTest
{
    return @(
        # 'get-started\org-alignment.md'
    )
}

function Get-ExcludedSubfolders
{
    return @(
        # 'organize/archive'
        '_bread'
        '_images'
        'context'
         'decision-guides'
        'digital-estate'
#        'get-started'
         'govern'
         'infrastructure'
         'innovate'
         'manage'
         'migrate'
             'operating-model'
#         'organize'
             'plan'
         'ready'
         'reference'
         'strategy'

        #,
        # 'get-started',
        # 'organize'
    )
}

# TODO: Update this.
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

function Get-MyDomain { 
    return 'https://docs.microsoft.com'
}

function Get-MyUrlRoot {
    return '/azure/cloud-adoption-framework'
}

function Get-MyTocUrl {
    $path = (Join-Uri $(Get-MyDomain) $(Get-MyUrlRoot)) 
    $path = (Join-Uri $path 'toc.json')
    return $path
}
