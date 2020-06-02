$here = $global:herePath

function Get-RelativeDocsPath
{
    return '../docs'
}

# Change the lines below to include your repo test files.
. "$here/Test-CAF.ps1"
. "$here/Test-CAFTerms.ps1"
. "$here/Test-CAFExpressions.ps1"
