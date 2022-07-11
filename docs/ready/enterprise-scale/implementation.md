---
title: Cloud Adoption Framework enterprise-scale landing zones in Azure
description: Review options you can use to implement the Cloud Adoption Framework for Azure enterprise-scale architecture.
author: JefferyMitchell
ms.author: brblanch
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Implement Cloud Adoption Framework enterprise-scale landing zones in Azure

Does your business require an initial implementation of landing zones? And do these landing zones need fully integrated governance, security, and an operations control plane from the start? With the following examples, you can use the Azure portal or infrastructure as code to set up and configure your Azure environment. It's also possible to transition between the portal and infrastructure as code (recommended) when your organization is ready.

## Reference implementation

The following table lists example reference implementations based on the recommended enterprise-scale architecture.

| Example deployment | Description | GitHub repo | Deploy to Azure |
|---------|---------|---------|---------|
| Enterprise-scale foundation | The suggested foundation for enterprise-scale adoption. | [Example in GitHub][GitHub-WingTip] | [![Dta-button-wingtip]][dta-wingtip] |
| Enterprise-scale hub and spoke | Add a [hub and spoke](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) network module to the enterprise-scale foundation. | [Example in GitHub][GitHub-AdventureWorks] | [![Dta-button-adventureworks]][dta-adventureworks] |
| Enterprise-scale Virtual WAN | Add a [Virtual WAN](/azure/virtual-wan/virtual-wan-global-transit-network-architecture) network module to the enterprise-scale foundation. | [Example in GitHub][GitHub-Contoso] | [![Dta-button-Contoso]][dta-Contoso] |
| Enterprise-scale for small enterprises | Add a [hub and spoke](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) network architecture for small organizations. | [Example in GitHub][GitHub-TreyResearch] | [![Dta-button-treyresearch]][dta-treyresearch] |
| Enterprise-scale for Azure Government | Reference implementation that can be deployed to Azure Government and includes all options in a converged portal experience. | [Example in GitHub][GitHub-AzureGov] | [![Dta-button-azuregov]][dta-azuregov] |

Each reference implementation deploys platform resources to the selected target environment. Deployment details and an overview of the deployed resources can be found using the GitHub link in the table above.

## Next steps

These examples provide an easy deployment option to support continued learning for the enterprise-scale approach. Before you use these examples in a production version of enterprise-scale, review the enterprise-scale architecture.

> [!div class="nextstepaction"]
> [Review the enterprise-scale architecture](../landing-zone/index.md)

<!-- The following section is used to store references to external images and links to reduce maintenance overhead and enable tooltips -->

[/]: # (*******************************)
[/]: # (External image references below)
[/]: # (*******************************)

[DTA-Button-WingTip]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy WingTip reference implementation (foundation) to Azure."
[DTA-Button-AdventureWorks]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy AdventureWorks reference implementation (hybrid connectivity with hub and spoke) to Azure."
[DTA-Button-Contoso]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy Contoso reference implementation (hybrid connectivity with virtual wan) to Azure."
[DTA-Button-TreyResearch]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy TreyResearch reference implementation for small organizations to Azure."
[DTA-Button-AzureGov]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy Enterprise-scale reference implementation for Azure Government."

[/]: # (**************************)
[/]: # (External link labels below)
[/]: # (**************************)

[GitHub-WingTip]: https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md
[GitHub-AdventureWorks]: https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md
[GitHub-Contoso]: https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md
[GitHub-TreyResearch]: https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md
[Github-AzureGov]: https://aka.ms/enterprisescale

[DTA-WingTip]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-AdventureWorks]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-Contoso]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-TreyResearch]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Ftreyresearch%2FarmTemplates%2Fes-lite.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Ftreyresearch%2FarmTemplates%2Fes-portal.json
[DTA-AzureGov]: https://portal.azure.us/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
