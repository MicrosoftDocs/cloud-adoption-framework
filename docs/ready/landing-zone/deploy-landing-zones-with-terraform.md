---
title: Deploy Azure landing zones by using Terraform
description: Learn which of the two Terraform approaches is more suited to your scenario when you're deploying Azure landing zones.
author: matt-FFFFFF
ms.author: mawhi
ms.date: 01/15/2025
ms.topic: conceptual
ms.custom: devx-track-terraform
---

# Azure Verified Modules for Platform Landing Zones (ALZ)

Azure provides native services for building your Azure landing zones. Other tools can also help with this effort.
One tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

> [!NOTE]
> Deployment of resources to application landing zones is outside the scope of the article. Decisions on the deployment method and tooling are for the team that's responsible for the application.

[Terraform Azure Verified Modules for Platform Landing Zones (ALZ)][alz_tf_docs] provides a rapid implementation of the platform resources that you need to manage [Azure landing zones][msdocs_alz_architecture] at scale by using Terraform.
The solution is designed to simplify the deployment of the management group hierarchy, policies, and resources in the connectivity and management subscriptions.

## Importance of using Azure Verified Modules

[Azure Verified Modules][azure_verified_modules] (AVM) is an initiative to consolidate and set the standards for what a good Infrastructure-as-Code module looks like.

Reuse of components is a fundamental principle of infrastructure as code. Modules are instrumental in defining standards and consistency across resource deployment within and across environments.

All Azure Verified Modules are published to the official [Terraform Registry][tf_reg_azure] and is verified by HashiCorp.

Deploying the module from the Terraform Registry provides:

- An accelerated delivery of Azure landing zones in your environment.
- A tested upgrade path to the latest version of the module, along with strict version control.

## The Accelerator

For most customers we recommend using the [accelerator][accelerator_docs].
The accelerator is an end-to-end automation solution to deploy your Azure Platform Landing Zones (ALZ).
It is based on the [ALZ PowerShell Module][alz_pwsh_module] and uses Terraform to bootstrap the environment.
The [bootstrap phase](#bootstrap-phase), ensures you start right with our best practices.

The following [scenarios][accelerator_scenarios] are supported:

- Multi-Region Hub and Spoke Virtual Network with Azure Firewall
- Multi-Region Virtual WAN with Azure Firewall
- Multi-Region Hub and Spoke Virtual Network with Network Virtual Appliance (NVA)
- Multi-Region Virtual WAN with Network Virtual Appliance (NVA)
- Management Groups, Policy and Management Resources Only
- Single-Region Hub and Spoke Virtual Network with Azure Firewall
- Single-Region Virtual WAN with Azure Firewall

### Bootstrap phase

We support both Azure DevOps and GitHub as source control.
If you use another provider, or don't want to use source control, you can deploy to the local filesystem.

The bootstrap deploys your DevOps resources (Azure DevOps or GitHub), including repositories, pipelines, and the identities required to run the pipelines.

Supporting this are several Azure resources that host the Terraform state file and the supporting compute and networking resources.

### Deploying the Platform

After the bootstrap, you will have a CI/CD pipeline that will deploy the scenario you selected.
In the case that you have selected the local filesystem option, you can run terraform apply manually.

#### Resources Deployed

Depending on the scenario and the configuration, you will have a set of resources deployed.

Governance resources in teh form of management groups and Azure Policy.
Centralized logging and monitoring resources to support the platform.

Also connectivity resources with your selected architecture, either a Virtual WAN or a Hub and Spoke Virtual Network topology.

### Configuration

The accelerator is highly configurable, please refer to the [user guide][accelerator_user_guide] for further information.

## Advanced Scenarios

If you are an advanced user, you can compose your own architecture from the AVM modules.
Please refer to the [getting started][alz_tf_getting_started] guide for more information.

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"

[azure_verified_modules]: https://aka.ms/avm "Azure Verified Modules"
[accelerator_docs]: https://azure.github.io/Azure-Landing-Zones/accelerator/ "Accelerator documentation."
[accelerator_scenarios]: https://azure.github.io/Azure-Landing-Zones/accelerator/startermodules/terraform-platform-landing-zone/scenarios/ "Accelerator supported scenarios."
[accelerator_user_guide]: https://azure.github.io/Azure-Landing-Zones/accelerator/userguide/ "Accelerator user guide."

[alz_pwsh_module]: https://www.powershellgallery.com/packages/ALZ "Azure Landing Zones PowerShell Module."
[alz_tf_docs]: https://aka.ms/alz/tf "Azure Verified Modules for Platform Landing Zones Terraform docs."
[alz_tf_getting_started]: https://azure.github.io/Azure-Landing-Zones/terraform/gettingStarted/ "(advanced) Getting started with Azure Verified Modules for Platform Landing Zones."

[msdocs_alz_architecture]: index.md#azure-landing-zone-architecture "Conceptual architecture for Azure landing zones."

[tf_reg_azure]: https://registry.terraform.io/modules/Azure "Search Azure modules on the Terraform Registry."
