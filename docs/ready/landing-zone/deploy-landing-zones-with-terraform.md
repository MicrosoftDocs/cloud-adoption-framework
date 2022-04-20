---
title: Deploy Azure landing zones by using Terraform
description: Learn which of the two Terraform approaches is most suited to your scenario when you're deploying Azure landing zones.
author: matt-FFFFFF
ms.author: mawhi
ms.date: 04/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Deploy Azure landing zones by using Terraform

Azure provides native services for building your Azure landing zones.
Other partner tools can also help with this effort.
One such tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

The [Terraform Module for Cloud Adoption Framework Enterprise-scale][alz-tf-mod] is the official Terraform module for deploying the platform resources from the [conceptual architecture for Azure landing zones][alz-conceptual-arch]. The module is designed to simplify the deployment of the management group hierarchy, policies, and resources in the connectivity and management subscriptions.

Deployment of resources to application landing zones is outside the scope of the module. Decisions on the deployment method and tooling are for the team that's responsible for the application.

The [Cloud Adoption Framework Terraform landing zones approach][caf-terraform-landingzones] is a set of tools that provides an abstracted, opinionated implementation of Terraform to provide deployment automation in Azure. It allows customers to deploy resources into application landing zones by using Terraform, along with providing a mechanism to deploy subscriptions.

This approach can also deploy the conceptual architecture for Azure landing zones. It does so by implementing the Terrafrom module for Azure landing zones.

The following diagram illustrates the coverage of the two approaches:

![Diagram that compares Terraform modules.](media/tf-module-compare.png)

## Selecting the right approach for Terraform

The recommended approach is to use the [ALZ Terraform module][alz-tf-mod]. It's consumed like a conventional Terraform module and can be incorporated into new or existing Terraform IaC automation.

If your organization wants to manage both platform and application resources by using centralized automation, or has complex infrastructrue architectures not supported by the ALZ Terraform module, then you should consider [CAF Terraform landing zones][caf-terraform-landingzones].

> [!NOTE]
> The [CAF Terraform landing zones][caf-terraform-landingzones] approach is abstracted from Terraform's normal [HCL][terraform_language_syntax] language. Instead, inputs consist of YAML files that are then used to generate Terraform variable files.

<!-- Common links -->

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"
[alz-tf-mod]: terraform-module.md "Azure landing zones terraform module"
[alz-conceptual-arch]: index.md
[azurerm-terraform-provider]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
[caf-terraform-landingzones]: terraform-landing-zone.md "CAF terraform landingzones"
[terraform_language_syntax]: https://www.terraform.io/language/syntax/configuration
