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

**Start with enterprise scale:** Use this mode if your business requirements necessitate a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start. With this approach, you can use either the Azure portal or infrastructure-as-code to set up and configure your environment. You can also transition between the portal and infrastructure-as-code (recommended) when your organization is ready. Infrastructure-as-code approaches require skills in Azure Resource Manager templates and GitHub.

**Start small and expand:** Use this mode if it's more important to develop these skills and commit to your decisions as you learn more about the cloud. In this approach, the landing zones only focus on implementing the basic landing zones considerations required to start cloud adoption. As your adoption expands, modules in the Govern and Manage methodologies will build on top of your initial landing zones. The design principles of any Azure landing zone outline the specific design areas that will require refactoring over time.

## Implementation options

The Cloud Adoption Framework offers a selection of implementation options based on these two primary modes for deploying Azure landing zones, but you may also want to consider partner delivered solutions. The following sections describe some of these options and the variables that might drive your decision.

### Start with enterprise scale

The following implementation options for enterprise scale provide a proven path for accelerating deployment of Azure landing zones in large organizations, where [Policy-driven governance](../enterprise-scale/design-principles.md#policy-driven-governance) is used to allow application workloads to be rapidly deployed safely at scale using [subscription democratization](../enterprise-scale/design-principles.md#subscription-democratization) as a unit of management and scale.

| Implementation option | Description | Design principles | Deployment instructions |
|---|---|---|---|
| [CAF enterprise-scale landing zone (foundations)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to operate in a cloud-native operating model using Internet connectivity to connect to your services, or plan to add hybrid connectivity later when needed. | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with hub and spoke)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to implement hybrid connectivity using a "hub and spoke" network topology to allow optimal flexibility and scale in Azure. Includes full coverage of the foundations solution. | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with Virtual WAN)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with shared services to support the full IT portfolio. Use this option when you need to implement hybrid connectivity using a "Virtual WAN" network topology to simplify management of more complex hybrid connectivity scenarios, including SD-WAN integration, or to enable native transitive connectivity between spoke networks. Includes full coverage of the foundations solution. | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md) |
| [Terraform Module for CAF Enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md) | Deploys an enterprise-ready platform foundation using Terraform. Use this option when you need to use Terraform to manage your platform as part of a 3rd party tooling or multicloud operating strategy. Delivered as a verified module through the Terraform Registry, this module provides an accelerated delivery path for building the recommended resource hierarchy and governance model, where shared services, network connectivity, and application workloads can be added later as needed. | [Design principles](../enterprise-scale/design-principles.md)| [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |

### Start small and expand

The following implementation options for start small and expand provide a proven path for organizations who want to focus on 

| Implementation option | Description | Design principles | Deployment instructions |
|---|---|---|---|
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Deploys the basic foundation for migrating low risk assets. | [Design principles](./migrate-landing-zone.md#design-principles) | [Deploy](./migrate-landing-zone.md) |
| [CAF Foundation blueprint](./foundation-blueprint.md) | Adds the minimum tools need to begin developing a governance strategy. | [Design principles](./foundation-blueprint.md#design-principles) | [Deploy](./foundation-blueprint.md) |
| [CAF Terraform landing zones](./terraform-landing-zone.md) | Open Source project providing a reference deployment model and DevOps tooling for delivering Azure landing zones. Use this option when you need to use Terraform to manage your platform and to bootstrap application workload solutions across multiple Subscriptions, using a 3rd party tooling or multicloud operating strategy. | [Design principles](./terraform-landing-zone.md#design-decisions) | [Deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |

### Partner solutions

Whether you need help to get started, or full operational support for your Azure environment, use our guidance to help you decide which partner is right for you.

| Implementation option | Description | Design principles | Deployment instructions |
|---|---|---|---|
| [Partner landing zones](./partner-landing-zone.md) | Partners who provide offerings aligned to the Ready methodology of the Cloud Adoption Framework can provide their own customized implementation option. | [Design principles](./partner-landing-zone.md) | [Find a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready) |

## Technical decision making

The following table looks at some of these implementation options from a slightly different perspective to guide more technical decision processes.

| Implementation option | Hub | Spoke | Deployment technology | Deployment instructions |
|---|---|---|---|---|
| [Cloud Adoption Framework enterprise-scale landing zone](../enterprise-scale/index.md) | Included  | Included | Azure Resource Manager templates, Azure portal, Azure Policy and GitHub | [Deploy](../enterprise-scale/implementation-guidelines.md) |
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Refactor required | Included | Azure Resource Manager templates, Azure portal, and Azure Blueprints | [Deploy](./migrate-landing-zone.md) |
| [CAF enterprise-scale landing zone Terraform module](../enterprise-scale/terraform-es-landing-zone.md)  | Excluded | Excluded | Terraform | [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |
| [CAF Terraform reference deployment](./terraform-landing-zone.md)  | Included in virtual datacenter module | Included | Terraform, and [rover](https://github.com/aztfmod/rover) (custom DevOps toolset) | [Deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |

## Next steps

To proceed, choose one of the implementation options shown in the preceding tables. Each option includes a link to deployment instructions and the specific design principles that guide implementation.
