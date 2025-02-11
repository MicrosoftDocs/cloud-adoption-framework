---
title: Deploy Azure Landing Zones by Using Terraform
description: Learn which of the two Terraform approaches is more suited to your scenario when you deploy Azure landing zones.
author: matt-FFFFFF
ms.author: mawhi
ms.date: 01/17/2025
ms.topic: conceptual
ms.custom: devx-track-terraform
---

# Azure Verified Modules for Platform Landing Zones (ALZ)

Azure provides native services for building your Azure landing zones. Other tools can also help with this effort. One tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

> [!NOTE]
> Deployment of resources to application landing zones is outside the scope of this article. Decisions about the deployment method and tooling are for the team that's responsible for the application.

[Terraform Azure Verified Modules for Platform Landing Zones (ALZ)][alz_tf_docs] provides a rapid implementation of the platform resources that you need to manage [Azure landing zones][msdocs_alz_architecture] at scale by using Terraform. The solution is designed to simplify the deployment of the management group hierarchy, policies, and resources in the connectivity and management subscriptions.

## Azure Verified Modules

[Azure Verified Modules][azure_verified_modules] is an initiative to consolidate and set the standards for what a good infrastructure as code (IaC) module looks like.

Reuse of components is a fundamental principle of IaC. Modules are instrumental in defining standards and consistency across resource deployment within and across environments.

All Azure Verified Modules are published to the official [Terraform Registry][tf_reg_azure] and verified by HashiCorp.

Deploying the module from the Terraform Registry provides:

- An accelerated delivery of Azure landing zones in your environment.
- A tested upgrade path to the latest version of the module and strict version control.

## Azure landing zone accelerator

We recommend that most customers use the [Azure landing zone accelerator][accelerator_docs]. The accelerator is an end-to-end automation solution to deploy your Azure Platform Landing Zones (ALZ). It's based on the [ALZ PowerShell Module][alz_pwsh_module] and uses Terraform to bootstrap the environment. The [bootstrap phase](#bootstrap-phase) ensures that you start right with our best practices.

The following [scenarios][accelerator_scenarios] are supported:

- Multiple-region hub and spoke virtual network with Azure Firewall
- Multiple-region virtual WAN with Azure Firewall
- Multiple-region hub and spoke virtual network with network virtual appliance (NVA)
- Multiple-region virtual WAN with NVA
- Management groups for policy and management resources only
- Single-region hub and spoke virtual network with Azure Firewall
- Single-region virtual WAN with Azure Firewall

### Bootstrap phase

Azure DevOps and GitHub are both supported as source control. If you use another provider or don't want to use source control, you can deploy to the local filesystem.

The bootstrap deploys your DevOps resources (Azure DevOps or GitHub), including repositories, pipelines, and the identities that are required to run the pipelines. Several Azure resources that host the Terraform state file and the supporting compute and networking resources support this.

For more information, see [Phase 2](https://azure.github.io/Azure-Landing-Zones/accelerator/userguide/2_start/) of the user guide.

### Deploy the platform

After the bootstrap, you have a continuous integration and continuous delivery pipeline that deploys the scenario that you chose. If you select the local filesystem option, you can run `terraform apply` manually.

#### Deployed resources

Based on the scenario and configuration, a set of resources are deployed, including:

- Governance resources, such as management groups and Azure Policy.

- Centralized logging and monitoring resources to support the platform.

- Connectivity resources with your selected architecture, whether it's a virtual WAN or a hub and spoke virtual network topology.

### Configuration

The Azure landing zone accelerator is highly configurable. For more information, see [User guide][accelerator_user_guide].

## Advanced scenarios

If you're an advanced user, you can compose your own architecture from the Azure Verified Modules modules. For more information, see [Getting started][alz_tf_getting_started].

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"
[azure_verified_modules]: https://aka.ms/avm "Azure Verified Modules"
[accelerator_docs]: https://azure.github.io/Azure-Landing-Zones/accelerator/ "Accelerator documentation."
[accelerator_scenarios]: https://azure.github.io/Azure-Landing-Zones/accelerator/startermodules/terraform-platform-landing-zone/scenarios/ "Accelerator supported scenarios."
[accelerator_user_guide]: https://azure.github.io/Azure-Landing-Zones/accelerator/userguide/ "Accelerator user guide."
[alz_pwsh_module]: https://www.powershellgallery.com/packages/ALZ "Azure Landing Zones PowerShell Module."
[alz_tf_docs]: https://aka.ms/alz/tf "Azure Verified Modules for Platform Landing Zones Terraform docs."
[alz_tf_getting_started]: https://azure.github.io/Azure-Landing-Zones/terraform/gettingStarted/ "(Advanced) Getting started with Azure Verified Modules for Platform Landing Zones."
[msdocs_alz_architecture]: index.md#azure-landing-zone-architecture "Conceptual architecture for Azure landing zones."
[tf_reg_azure]: https://registry.terraform.io/modules/Azure "Search Azure modules on the Terraform Registry."
