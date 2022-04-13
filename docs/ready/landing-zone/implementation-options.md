---
title: Landing zone implementation options
description: Determine which landing zone implementation option best fits your requirements.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/31/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Landing zone implementation options

An [Azure landing zone](./index.md) provides cloud adoption teams with a well-managed environment to run their workloads. Take advantage of the best practices described in [landing zone design areas](./design-areas.md) to build a strong foundation. You can then extend the foundation by implementing processes related to security, governance, and compliance.

## Environment development approaches

There are two primary approaches. The choice will depend on how fast your teams can develop the required skills.     

- **Start with the Azure landing zone accelerator:** If your business requirements call for a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start. You can customize the implementation used as part of the Azure landing zone accelerator, using Infrastructure-as-Code (IaC) to set up and configure your environment. For IaC, your organization will require skills in Azure Resource Manager templates and GitHub.

- **Customize:** If it's more important to build your environment to meet specific requirements, or develop internal skills. In this approach, focus on the basic landing zones considerations required to start cloud adoption. All technical and business requirements are considered complete when your adoption aligns with Azure landing zone. You can then focus on enhancing your landing zone.

> [!IMPORTANT]
> Of the two approaches, the Azure landing zone accelerator is recommended because it's the quickest way to achieve a scaled-out and mature environment. 
>
> [![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)

Beside the use of the Azure landing zone accelerator, there are use cases where organizations have specific business or technical requirements. For those cases, some customization might be needed.

To address the customization use cases, consider the [implementation options](#implementation-options) given in this article. The options are intended for users with strong skills in technologies such as Azure Resource Manager, Azure Policy, DevOps tools, and third-party deployment tools. Those technologies are required for a solid foundation on which to build a landing zone.

> [!CAUTION]
> The best practices used for customization will ultimately be aligned with the [Azure landing zone](./index.md). However, there's added investment in time and effort which might be justified to  to fit specific business requirements.

Finally, guidance in the [Govern](/azure/cloud-adoption-framework/govern/) and [Manage](/azure/cloud-adoption-framework/manage/) methodologies will build on top of your initial landing zones. The design of any Azure landing zone outline will likely require refactoring over time.

## Implementation options

This table describes some implementation options for landing zones and the variables that might drive your decision. Each implementation option in this table is designed for a specific set of operating model dependencies to support your organizations nonfunctional requirements. Every option includes distinct automation approaches and tools. Even though each option is mapped to a different operating model, they have common design areas. The difference is how you choose to implement them and the level of technical experience required.

| Implementation option | Description | Development approach | Deeper design principles | Deployment instructions |
|---|---|---|---|---|
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Deploys the basic foundation for migrating low risk assets. | Customize | [Design principles](./migrate-landing-zone.md#design-principles) | [Deploy](./migrate-landing-zone.md) |
| [CAF Foundation blueprint](./foundation-blueprint.md) | Adds the minimum tools need to begin developing a governance strategy. | Customize | [Design principles](./foundation-blueprint.md#design-principles) | [Deploy](./foundation-blueprint.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with Virtual WAN)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, including hybrid connectivity (Virtual WAN). |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md) |
| [CAF enterprise-scale landing zone (hybrid connectivity with hub and spoke)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, including hybrid connectivity (hub and spoke). |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) |
| [CAF enterprise-scale landing zone (foundation)](../enterprise-scale/index.md) | Deploys an enterprise-ready platform foundation with all the necessary shared services to support the full IT portfolio, where connectivity can be added later as needed. |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md) |
| [CAF enterprise-scale landing zone (small and midsize enterprise)](../enterprise-scale/index.md) | This reference implementation is meant for organizations that don't have a large IT team and do not require fine grained administration delegation models. |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md) |
| [CAF enterprise-scale landing zone (Azure Gov)](../enterprise-scale/index.md) | Reference implementation that can be deployed to Azure Government Cloud. |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://portal.azure.us/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2FeslzArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2FeslzArm%2Feslz-portal.json) |
| [Terraform module for Cloud Adoption Framework enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md) | Deploys an enterprise-ready platform foundation using Terraform. Use this option when managing your platform using Terraform and need to accelerate delivery of the recommended resource hierarchy and governance model. This module is officially verified on the Terraform registry. Shared services, network connectivity, and application workloads can be integrated into your deployment or managed independently. |Azure landing zone accelerator| [Design principles](../enterprise-scale/design-principles.md) | [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |
| [CAF Terraform modules](./terraform-landing-zone.md) | Third-party path for multicloud operating models. This path can limit Azure-first operating models. | Customize | [Design principles](./terraform-landing-zone.md#design-decisions) | [Deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) |
| [Partner landing zones](./partner-landing-zone.md) | Partners who provide offerings aligned to the Ready methodology of the Cloud Adoption Framework can provide their own customized implementation option. | Variable | [Design principles](./partner-landing-zone.md) | [Find a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready) |

The following table looks at some of these implementation options from a slightly different perspective to guide more technical decision processes.

| Implementation option | Hub | Spoke | Deployment technology | Deployment instructions |
|---|---|---|---|---|
| [Cloud Adoption Framework enterprise-scale landing zone](../enterprise-scale/index.md) | Included | Included | Azure Resource Manager templates, Azure portal, Azure Policy and GitHub | [Deploy](../enterprise-scale/implementation.md) |
| [CAF Migration landing zone blueprint](./migrate-landing-zone.md) | Refactor required | Included | Azure Resource Manager templates, Azure portal, and Azure Blueprints | [Deploy](./migrate-landing-zone.md) |
| [CAF Terraform modules](./terraform-landing-zone.md) | Included in virtual datacenter module | Included | Terraform | [Deploy](./terraform-landing-zone.md) |
| [ALZ Terraform module](terraform-module.md)  | Excluded | Excluded | Terraform | [Deploy](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) |

## Next steps

To proceed, choose one of the implementation options shown in the preceding tables. Each option includes a link to deployment instructions and the specific design principles that guide implementation.