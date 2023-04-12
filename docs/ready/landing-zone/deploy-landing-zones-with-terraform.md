---
title: Deploy Azure landing zones by using Terraform
description: Learn which of the two Terraform approaches is more suited to your scenario when you're deploying Azure landing zones.
author: matt-FFFFFF
ms.author: mawhi
ms.date: 04/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: devx-track-terraform
---

# Deploy Azure landing zones by using Terraform

Azure provides native services for building your Azure landing zones. Other tools can also help with this effort. One tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

The [Azure landing zones Terraform module][alz-tf-mod] is the official Terraform module for deploying the platform resources from the [conceptual architecture for Azure landing zones][alz-conceptual-arch]. The module is designed to simplify the deployment of the management group hierarchy, policies, and resources in the connectivity and management subscriptions.

Deployment of resources to application landing zones is outside the scope of the module. Decisions on the deployment method and tooling are for the team that's responsible for the application.

[Cloud Adoption Framework Terraform landing zones][caf-terraform-landingzones] provide an abstracted, opinionated implementation of Terraform to provide deployment automation in Azure. The set of tools in this approach allows customers to deploy resources into application landing zones by using Terraform, along with providing a mechanism to deploy subscriptions.

The Cloud Adoption Framework approach can also deploy the conceptual architecture for Azure landing zones. It does so by implementing the Azure landing zones Terraform module.

The following diagram illustrates the coverage of the two approaches.

![Diagram that compares Terraform modules.](media/tf-module-compare.png)

## Selecting the right approach for Terraform

For most organizations, we recommend the [Azure landing zones Terraform module][alz-tf-mod] approach. It provides an accelerated way to deploy, manage, and extend the recommended conceptual architecture for Azure landing zones. It can be incorporated into new or existing Terraform infrastructure as code (IaC) automation.

If your organization wants to manage both platform and application resources by using consistent automation tooling, then you should consider [Cloud Adoption Framework Terraform landing zones][caf-terraform-landingzones]. This community-led solution combines multiple Terraform modules (including the Azure landing zones Terraform module), a custom provider, open-source automation for Terraform (Rover), and reference deployment templates within a "starter" template repository.

> [!NOTE]
> The approach of Cloud Adoption Framework Terraform landing zones is abstracted from Terraform's normal [HCL][terraform_language_syntax] language. Instead, inputs consist of YAML files that are then used to generate Terraform variable files.

<!-- Common links -->

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"
[alz-tf-mod]: terraform-module.md "Azure landing zones terraform module"
[alz-conceptual-arch]: index.md
[azurerm-terraform-provider]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
[caf-terraform-landingzones]: terraform-landing-zone.md "CAF Terraform landing zones"
[terraform_language_syntax]: https://www.terraform.io/language/syntax/configuration
