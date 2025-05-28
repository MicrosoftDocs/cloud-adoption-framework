---
title: Landing zone implementation options
description: Determine which landing zone implementation option best fits your requirements.
author: Zimmergren
ms.author: pnp
ms.date: 01/17/2025
ms.topic: conceptual
ms.custom: internal
---

# Landing zone implementation options

[!INCLUDE [Azure landing zone under construction advisory](~/../includes/landing-zone-under-construction.md)]

An [Azure landing zone](./index.md) provides cloud adoption teams with a well-managed environment to run their workloads. Take advantage of the best practices described in [landing zone design areas](./design-areas.md) to build a strong foundation. You can then extend the foundation by implementing processes related to security, governance, and compliance.

## Environment development approaches

There are two primary approaches. The choice will depend on how fast your teams can develop the required skills.

- **Start with the Azure landing zone accelerator:** If your business requirements call for a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start. If you need to, you can modify using Infrastructure-as-Code (IaC) to set up and configure an environment per your requirements. For IaC, your organization will require skills in Azure Resource Manager templates and GitHub.

- **Customize:** If it's more important to build your environment to meet specific requirements, or develop internal skills. In this approach, focus on the basic landing zones considerations required to start cloud adoption. All technical and business requirements are considered complete when your environment configuration aligns with Azure landing zone conceptual architecture. You can then focus on enhancing your landing zone.

> [!IMPORTANT]
> Of the two approaches, the Azure landing zone accelerator is recommended because it's the quickest way to achieve a scaled-out and mature environment.
>
> [![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)

Beside the use of the Azure landing zone accelerator, there are use cases where organizations have specific business or technical requirements. For those cases, some customization might be needed.

To address the customization use cases, consider the [implementation options](#implementation-options) given in this article. The options are intended for users with strong skills in technologies such as Azure Resource Manager, Azure Policy, DevOps tools, and third-party deployment tools. Those technologies are required for a solid foundation on which to build a landing zone.

> [!CAUTION]
> The best practices used for customization will ultimately be aligned with the [Azure landing zone](./index.md). However, there's added investment in time and effort which might be justified to fit specific business requirements.

Finally, guidance in the [Govern](../../govern/index.md) and [Manage](../../manage/index.md) methodologies will build on top of your initial landing zones. The design of any Azure landing zone outline will likely require refactoring over time.

## Implementation options

Here are some implementation options for landing zones keeping in mind the development approaches described above. Each implementation option in this table is designed for a specific set of operating model dependencies to support your organizations nonfunctional requirements. Every option includes distinct automation approaches and tools. Even though each option is mapped to a different operating model, they have common design areas. The difference is how you choose to implement them and the level of technical experience required.

### Azure landing zone accelerator approach

| Implementation option | Description | Deployment instructions |
|---|---|---|
| [Enterprise-scale foundation](../enterprise-scale/index.md) | Enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, where connectivity can be added later as needed. </br></br> [Design principles](./design-principles.md) </br> [Design areas](design-areas.md) | [![Dta-button]][DTA-WingTip]</br> [Readme: foundation](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md)</br> [Readme: Network topology (Virtual WAN)](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md)</br> [Readme: Network topology (hub-spoke)](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) |
| [Azure landing zones modular](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/Home.md)|Modular approach using Bicep for deploying the core platform capabilities. | [Readme: Bicep modules](https://github.com/Azure/ALZ-Bicep/wiki/ConsumerGuide)
| Enterprise-scale for small enterprises| This reference implementation is meant for organizations that don't have a large IT team and do not require fine grained administration delegation models. | [![Dta-button]][DTA-small-enterprises]</br>[Readme](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md) |
| Enterprise-scale for Azure Government|Reference implementation that can be deployed to Azure Government Cloud. | [![Dta-button]][DTA-AzureGov] </br>[Readme](https://github.com/Azure/Enterprise-Scale#readme)|
| [CAF enterprise-scale landing zone (Azure China 21Vianet regions)](https://github.com/Azure/Enterprise-Scale/tree/main/eslzArm#do-it-yourself-deployment-instructions-for-enterprise-scale-using-azure-powershell) | Reference implementation that can be deployed to Azure clouds in China. | [![Dta-button]][DTA-21Vianet] </br> [Deploy](https://github.com/Azure/Enterprise-Scale/blob/cf46ee50e2720a42bebdd5b43abc08738f349794/eslzArm/README-AzureChina.md) |
| [Terraform Azure Verified Modules for Platform Landing Zones](deploy-landing-zones-with-terraform.md) | Deploys an enterprise-ready platform foundation by using Terraform. Use this option when you manage your platform by using Terraform and need to accelerate delivery of the recommended resource hierarchy and governance model. You can integrate shared services, network connectivity, and application workloads into your deployment or manage them independently. |[Docs](https://aka.ms/alz/tf) |
| [Microsoft Cloud for Sovereignty](/industry/sovereignty/cloud-for-sovereignty) | A sovereign landing zone uses the same code base as the Azure landing zone Bicep approach but has more orchestration and deployment automation capabilities. It also has Azure Policy initiatives and assignments to help meet sovereignty requirements for public-sector customers, partners, and independent software vendors (ISVs). | [Readme](/industry/sovereignty/) |

### Customize approach

| Implementation option | Description | Deployment instructions |
|---|---|---|
| [Partner landing zones](./partner-landing-zone.md) | Partners who provide offerings aligned to the Ready methodology of the Cloud Adoption Framework can provide their own customized implementation option. </br>[Design principles](partner-landing-zone.md) | [Find a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready) |

## Next steps

To proceed, choose one of the implementation options shown in the preceding tables. Each option includes a link to deployment instructions and the specific design principles that guide implementation.

<!-- The following section is used to store references to external images and links to reduce maintenance overhead and enable tooltips -->

[DTA-Button]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy Azure landing zone accelerator."

[DTA-WingTip]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-small-enterprises]: https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-AzureGov]: https://portal.azure.us/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json
[DTA-21Vianet]: https://github.com/Azure/Enterprise-Scale/blob/cf46ee50e2720a42bebdd5b43abc08738f349794/eslzArm/README-AzureChina.md
