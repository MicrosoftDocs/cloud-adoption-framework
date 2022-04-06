---
title: Deploy Azure Landing Zones with Terraform
description: Learn which of the two Terraform approaches is most suited to your scenario when deploying Azure landing zones.
author: matt-FFFFFF
ms.author: mawhi
ms.date: 02/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Use Terraform to deploy Azure Landing Zones

Azure provides native services for building your Azure landing zones.
Other third-party tools can also help with this effort.
One such tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

The [Azure landing zones (ALZ) Terraform module][alz-tf-mod] is the official Terraform module for deploying the platform resources from the [Azure landing zones conceptual architecture][alz-conceptual-arch].
The module is designed to simplify the deployment of the management group hierarchy, policies and the resources in the connectivity and management subscriptions.
Deployment of resources to application landing zones is outside the scope of the module, leaving decisions on the deployment method and tooling to the team responsible for the application.

The [CAF Terraform landing zones approach][caf-terraform-landingzones] is a set of tools that provides an abstracted, opinionated implementation of Terraform to provide deployment automation in Azure.
This approach can deploy the Azure landing zones conceptual architecture, it does so by implementing the Azure landing zones Terraform module.
In addition to platform services it allows customers to deploy resources into application landing zones using Terraform, as well as providing a mechanism to deploy subscriptions.

The diagram below illustrates the coverage of the two approaches:

![Terraform module comparison](media/tf-module-compare.png)

## Selecting the right approach for Terraform

If your organization has no current investment in Terraform, the [CAF Terraform landing zones][caf-terraform-landingzones] approach provides a prescriptive implementation of Terraform on Azure that is open source and community driven.
However, this approach is more complex than the standalone ALZ Terraform module.

You should be aware that the [CAF Terraform landing zones][caf-terraform-landingzones] approach uses a 'supermodule' and resource creation does not follow the standard model of the [azurerm][azurerm-terraform-provider] Terraform provider by Hashicorp.
This approach increases complexity and is typically suited for larger customers with strong regulatory requirements around segregation of duties, or complex infrastructure architectures not supported by the ALZ Terraform module.

If your organization has an existing investment in Terraform or would like to implement Terraform in a more conventional module-based approach, then the [ALZ Terraform module][alz-tf-mod] is the best option.

<!-- Common links -->

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"
[alz-tf-mod]: alz-terraform-module.md "Azure landing zones terraform module"
[alz-conceptual-arch]: index.md
[azurerm-terraform-provider]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
[caf-terraform-landingzones]: caf-terraform-landingzones.md "CAF terraform landingzones"
