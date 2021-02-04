---
title: Landing zone implementation options
description: Determine which landing zone implementation option best fits your requirements.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Landing zone implementation options

[Azure landing zones](./index.md) provide cloud adoption teams with a well-managed environment for their workloads. Follow the [landing zone design areas](./design-areas.md) guidance to take advantage of these capabilities.

Each of the following implementation options is designed for a specific set of operating model dependencies to support your nonfunctional requirements. Each implementation option includes distinct automation approaches. When available, reference architectures and reference implementations are included to accelerate your cloud adoption journey. While each option is mapped to a different operating model, they share the same design areas. The difference is how you choose to implement them.

## Platform development velocity

In addition to the recommended design areas, your platform development velocity (how fast your platform team can develop the required skills) is a key factor when choosing the best implementation option. Consider two primary modes:

**Start with enterprise scale:** Use this mode if your business requirements necessitate a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start. With this approach, you can use either the Azure Portal or infrastructure-as-code to set up and configure your environment. You can also transition between the Azure Portal and Infrastructure-as-Code (recommended) when your organization is ready. To use the recommended Infrastructure-as-Code approach, your organization will require skills in Azure Resource Manager templates and GitHub.

**Start small and expand:** Use this mode if it's more important to develop these skills and commit to your decisions as you learn more about the cloud. In this approach, the landing zones only focus on implementing the basic landing zones considerations required to start cloud adoption. As your adoption expands, modules in the Govern and Manage methodologies will build on top of your initial landing zones. The design principles of any Azure landing zone outline the specific design areas that will require refactoring over time.

## Implementation options

The Cloud Adoption Framework offers a selection of implementation options based on these two primary modes for deploying Azure landing zones, but you may also want to consider partner delivered solutions. The following sections describe some of these options and the variables that might drive your decision.

### Start with enterprise scale

The following implementation options for enterprise scale provide a proven path for accelerating deployment of Azure landing zones in large organizations, where [Policy-driven governance](../enterprise-scale/design-principles.md#policy-driven-governance) is used to allow application workloads to be rapidly deployed safely at scale using [subscription democratization](../enterprise-scale/design-principles.md#subscription-democratization) as a unit of management and scale.

All enterprise scale implementation options are based on a common set of [design principles](../enterprise-scale/design-principles.md), allowing you to build your environment at scale and with confidence.

| Implementation option | Description | |
|---|---|---|---|
| [CAF enterprise-scale landing zone (foundations)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to operate in a cloud-native operating model using Internet connectivity to connect to your services, or plan to add hybrid connectivity later when needed. | [![DTA-Button-WingTip]][DTA-WingTip] |
| [CAF enterprise-scale landing zone (hybrid connectivity with hub and spoke)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to implement hybrid connectivity using a "hub and spoke" network topology to allow optimal flexibility and scale in Azure. Includes full coverage of the foundations solution. | [![DTA-Button-AdventureWorks]][DTA-AdventureWorks] |
| [CAF enterprise-scale landing zone (hybrid connectivity with Virtual WAN)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to implement hybrid connectivity using a "Virtual WAN" network topology to simplify management of more complex hybrid connectivity scenarios, including SD-WAN integration, or to enable native transitive connectivity between spoke networks. Includes full coverage of the foundations solution. | [![DTA-Button-Contoso]][DTA-Contoso] |
| [Terraform module for CAF enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md) | Deploys an enterprise-ready platform foundation using Terraform. Use this option when managing your platform using Terraform and need to accelerate delivery of the recommended resource hierarchy and governance model. This module is officially verified on the Terraform Registry. Shared services, network connectivity, and application workloads can be integrated into your deployment or managed independently. | [Deployment instructions][ESTF-Registry] |

<!-- Consider updating "Deployment instructions" link for "Terraform module for CAF enterprise-scale" to point to Wiki page once available -->

### Start small and expand

The following implementation options for start small and expand provide a proven path for organizations who want to focus on getting started in Azure and iterate your design as needed. Each option follows a unique set of design principles, allowing you to pick the one which best fits your requirements and preferred approach.

| Implementation option | Description | | |
|---|---|---|---|
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Deploys the basic foundation for migrating low risk assets. | [Design principles](./migrate-landing-zone.md#design-principles) | [Deployment instructions](./migrate-landing-zone.md) |
| [CAF Foundation blueprint](./foundation-blueprint.md) | Adds the minimum tools need to begin developing a governance strategy. | [Design principles](./foundation-blueprint.md#design-principles) | [Deployment instructions](./foundation-blueprint.md) |
| [CAF Terraform landing zones](./terraform-landing-zone.md) | Open Source project providing a collection of reference Terraform modules and DevOps tooling for delivering Azure landing zones. Use this option when you plan to use Terraform to manage your platform and application workloads across multiple Subscriptions, and need a prescriptive framework for orchestrating Terraform deployments and state file management. | [Design principles](./terraform-landing-zone.md#design-decisions) | [Deployment instructions](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |

## Partner solutions

Whether you just need help to get started, or are looking for a fully managed support option for your Azure landing zones, use our guidance to help you decide which partner is right for you. Partners who provide offerings aligned to the Ready methodology of the Cloud Adoption Framework can help deliver Azure landing zones.

Whether you want to start with enterprise scale, start small and expand, or use a customized implementation option, use our [partner guidance](./partner-landing-zone.md) to find the right partner for your organization. Our guidance will help you ask the right questions to ensure the partner can help you select the right approach and deliver successfully.

You can also search our full list of [Cloud Adoption Framework partners][CAF-Ready-Partners] directly.

## Technical decision making

The following table looks at some of these implementation options from a slightly different perspective to guide more technical decision processes.

| Implementation option | Hub | Spoke | Deployment technology | |
|---|---|---|---|---|
| [CAF enterprise-scale landing zone (foundations)](../enterprise-scale/index.md) | Excluded | Excluded | Azure Resource Manager templates, Azure Portal, Azure Policy and GitHub | [![DTA-Button-WingTip]][DTA-WingTip] |
| [CAF enterprise-scale landing zone (hybrid connectivity with hub and spoke)](../enterprise-scale/index.md) | Included (Hub with VNet Peering) | Included | Azure Resource Manager templates, Azure Portal, Azure Policy and GitHub | [![DTA-Button-AdventureWorks]][DTA-AdventureWorks] |
| [CAF enterprise-scale landing zone (hybrid connectivity with Virtual WAN)](../enterprise-scale/index.md) | Included (Virtual WAN Hub) | Included | Azure Resource Manager templates, Azure Portal, Azure Policy and GitHub | [![DTA-Button-Contoso]][DTA-Contoso] |
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Refactor required | Included | Azure Resource Manager templates, Azure Portal, and Azure Blueprints | [Deployment instructions](./migrate-landing-zone.md) |
| [CAF Terraform reference deployment](./terraform-landing-zone.md)  | Included in virtual datacenter module | Included | Terraform, and [rover][AZTFMOD-Rover] (custom DevOps toolset) | [Deployment instructions](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |
| [Terraform module for CAF enterprise-scale](../enterprise-scale/terraform-es-landing-zone.md)  | Excluded | Excluded | Terraform | [Deployment instructions][ESTF-Registry] |

<!-- Table missing CAF Foundation blueprint -->

## Next steps

To proceed, choose one of the implementation options shown in the preceding tables. Each option includes a link to deployment instructions and the specific design principles that guide implementation.

<!-- The following section is used to store references to external images and links to reduce maintenance overhead-->

 [//]: # (*******************************)
 [//]: # (EXTERNAL IMAGE REFERENCES BELOW)
 [//]: # (*******************************)

 [DTA-Button-WingTip]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy WingTip implementation option (foundation) to Azure."
 [DTA-Button-AdventureWorks]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy AdventureWorks implementation option (hybrid connectivity with hub and spoke) to Azure."
 [DTA-Button-Contoso]: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true "Deploy WingTip implementation option (hybrid connectivity with virtual wan) to Azure."

 [//]: # (**************************)
 [//]: # (EXTERNAL LINK LABELS BELOW)
 [//]: # (**************************)

 [ESTF-Registry]: https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest

 [DTA-WingTip]: https://ms.portal.azure.com/?feature.customportal=false#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fes-foundation.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fportal-es-foundation.json

 [DTA-AdventureWorks]: https://ms.portal.azure.com/?feature.customportal=false#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-hubspoke.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fportal-es-hubspoke.json

 [DTA-Contoso]: https://ms.portal.azure.com/?feature.customportal=false#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fes-vwan.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fportal-es-vwan.json

 [CAF-Ready-Partners]: https://www.microsoft.com/azure/partners/adopt?filters=ready

 [AZTFMOD-Rover]: https://github.com/aztfmod/rover