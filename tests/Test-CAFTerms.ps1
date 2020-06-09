function Get-MyCasingExpressions
{
    return @(
        
        'Central IT'
        'COTS'
        'Five Disciplines of Cloud Governance'
        'five Rs of rationalization'
        'five Rs of cloud rationalization'
        'Cost Management (discipline|governance discipline|phase|policy|policies|sample policy|strategy|toolchain|tools)'
        'Deployment Acceleration (discipline|governance discipline|phase|policy|policies|sample policy|strategy|toolchain|tools)'
        'Identity Baseline (discipline|governance discipline|phase|policy|policies|sample policy|strategy|toolchain|tools)'
        'Resource Consistency (discipline|governance discipline|phase|policy|policies|sample policy|strategy|toolchain|tools)'
        'Security Baseline (discipline|governance discipline|phase|policy|policies|sample policy|strategy|toolchain|tools)'

        'Adopt methodolog(y|ies)'
        'Adopt phase'
        'Govern methodolog(y|ies)'
        'Govern phase'
        'Innovate methodolog(y|ies)'
        'Innovate phase'
        'Manage methodolog(y|ies)'
        'Manage phase'
        'Migrate methodolog(y|ies)'
        'Migrate phase'


        'Organize methodolog(y|ies)'
        'Organize phase'
        'Plan methodolog(y|ies)'
        'Plan phase'
        'Ready methodolog(y|ies)'
        'Ready phase'
        'Strategy methodolog(y|ies)'
        'Strategy phase'
        
        'get-started guide!!getting started guide'
        'get-started guides!!getting started guides'
        'getting-started guide!!getting started guide'
        'getting-started guides!!getting started guides'
        
        'Microsoft Azure Well-Architected Framework'
        'Microsoft Azure Well-Architected Review'
        'C-level'
        'C-suite'
        'CCoE'
        'Power of 10'
        'RACI'
        
        # TODO: Temporary or verify
        'CAF'
        'Assess phase'
        'CAF landing zone'
        'CAF landing zones'
        'CAF Migrate landing zone'
        'CAF Migrate landing zone'
        'CAF Terraform landing zone'
        'CAF Terraform landing zones'
        'Govern and Manage methodologies'
        'Identity Baseline, Security Baseline, and Deployment Acceleration disciplines'
        'VDC'
    )
}

function Get-MyInvalidTermExpressions {
    return @(

        '5 Rs!!five Rs'
        'Governance methodology!!Govern methodology'
        'Innovation methodology!!Innovate methodology'
        'Management methodology!!Manage methodology'
        'Migration methodology!!Migrate methodology'
        'Organization methodology!!Organize methodology'
        'Planning methodology!!Plan methodology'
        'Readiness methodology!!Ready methodology'

        'operations excellence!!operational excellence'
        'hosting hierarchy!!portfolio hierarchy'
        'SCM!!~~Spell out "source code management"'
        ' vs (?!Code)!! versus '
        'For more information see!!For more information, see'
        'For more information (?!about|and)'
        'For more,'
        'For more (?=details|about|on)'

        'NorthStar!!enterprise-scale'
        'North Star!!enterprise-scale'
        'enterprise scale architecture!!enterprise-scale architecture'
        'thought out!!considered'
        'go with!!use'

        'leverage!!use'
        'leverages!!uses'
        'leveraging!!using'
        'artefact!!artifact'
        'artefacts!!artefacts'
        'maximise!!maximize'
        'minimize!!minimize'
        'neighbour!!neighbor'
        'organisation!!organization'
        'organisations!!organizations'
        'organisational!!organizational'
        'sumary!!summary'
        'prereqs!!prerequisites'
        'recomendations!!recommendations'
        'subsciption!!subscription'
        'subsciptions!!subscriptions'
    )
}
