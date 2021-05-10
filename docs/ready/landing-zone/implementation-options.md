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

**Start with enterprise scale:** Use this mode if your business requirements necessitate a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start. With this approach, you can use either the Azure portal or infrastructure-as-code to set up and configure your environment. You can also transition between the Azure portal and infrastructure as code (recommended) when your organization is ready. To use the recommended infrastructure-as-code approach, your organization will require skills in Azure Resource Manager templates and GitHub.

**Start small and expand:** Use this mode if it's more important to develop these skills and commit to your decisions as you learn more about the cloud. In this approach, the landing zones only focus on implementing the basic landing zones considerations required to start cloud adoption. As your adoption expands, modules in the Govern and Manage methodologies will build on top of your initial landing zones. The design principles of any Azure landing zone outline the specific design areas that will require refactoring over time.

## Implementation options

The following table describes some of the implementation options for landing zones and the variables that might drive your decision.

| Implementation option | Description | Deployment velocity | Deeper design principles | Deployment instructions |
|---|---|---|---|---|
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Deploys the basic foundation for migrating low risk assets. | Start small | [Design principles](./migrate-landing-zone.md#design-principles) | [Deploy](./migrate-landing-zone.md) |
| [CAF Foundation blueprint](./foundation-blueprint.md) | Adds the minimum tools need to begin developing a governance strategy. | Start small | [Design principles](./foundation-blueprint.md#design-principles) | [Deploy](./foundation-blueprint.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with Virtual WAN)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, including hybrid connectivity (Virtual WAN). | Enterprise-scale | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with hub and spoke)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, including hybrid connectivity (hub and spoke). | Enterprise-scale | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) |
| [CAF enterprise-scale landing zone (foundation)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, where connectivity can be added later as needed. | Enterprise-scale | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md) |
| [CAF enterprise-scale landing zone (small and midsize enterprise)](../enterprise-scale/index.md) | This reference implementation is meant for organizations that do not have a large IT team and do not require fine grained administration delegation models. | Enterprise-scale | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md) |
| [Terraform module for Cloud Adoption Framework enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md) | Deploys an enterprise-ready platform foundation using Terraform. Use this option when managing your platform using Terraform and need to accelerate delivery of the recommended resource hierarchy and governance model. This module is officially verified on the Terraform registry. Shared services, network connectivity, and application workloads can be integrated into your deployment or managed independently. | Enterprise-scale | [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |
| [CAF Terraform modules](./terraform-landing-zone.md) | Third-party path for multicloud operating models. This path can limit Azure-first operating models. | Start small | [Design principles](./terraform-landing-zone.md#design-decisions) | [Deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |
| [Partner landing zones](./partner-landing-zone.md) | Partners who provide offerings aligned to the Ready methodology of the Cloud Adoption Framework can provide their own customized implementation option. | Variable | [Design principles](./partner-landing-zone.md) | [Find a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready) |

The following table looks at some of these implementation options from a slightly different perspective to guide more technical decision processes.

| Implementation option | Hub | Spoke | Deployment technology | Deployment instructions |
|---|---|---|---|---|
| [Cloud Adoption Framework enterprise-scale landing zone](../enterprise-scale/index.md) | Included | Included | Azure Resource Manager templates, Azure portal, Azure Policy and GitHub | [Deploy](../enterprise-scale/implementation.md) |
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Refactor required | Included | Azure Resource Manager templates, Azure portal, and Azure Blueprints | [Deploy](./migrate-landing-zone.md) |
| [CAF Terraform modules](./terraform-landing-zone.md) | Included in virtual datacenter module | Included | Terraform | [Deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |
| [Terraform module for Cloud Adoption Framework enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md)  | Excluded | Excluded | Terraform | [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |

## Next steps

To proceed, choose one of the implementation options shown in the preceding tables. Each option includes a link to deployment instructions and the specific design principles that guide implementation.
