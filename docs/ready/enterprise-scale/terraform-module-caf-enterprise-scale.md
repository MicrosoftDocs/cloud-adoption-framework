---
title: Terraform module for Cloud Adoption Framework enterprise-scale
description: Learn how to use the Terraform module for Cloud Adoption Framework enterprise-scale.
author: krowlandson
ms.author: brblanch
ms.date: 02/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- cSpell:ignore eastasia southeastasia vCPUs lalogs tfvars NetworkMonitoring ADAssessment ADReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->
<!-- docutune:casing NetworkMonitoring AdAssessment AdReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->

# Terraform module for Cloud Adoption Framework enterprise-scale

Azure provides native services for deploying your landing zones. Other third-party tools can also help with this effort. One such tool that customers and partners often use to deploy landing zones is Terraform by HashiCorp.

This section shows how to use the [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) to deploy the recommended resource hierarchy and governance model for managing governance and security capabilities across multiple Azure subscriptions at scale.

## Purpose of enterprise scale landing zones

The [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) provides a simplified method to implement the enterprise scale foundations using Terraform, covering:

1. Managing the deployment of a resource hierarchy using Management Groups.
1. Configuring _Azure Policy_ and _Access Control (IAM)_ to build a scalable governance model across multiple Subscriptions. 
1. Ensuring Subscriptions are placed in the correct Management Group to inherit mandatory governance models.

By packaging these resources into a Terraform module, it becomes easier to build and enforce consistency across you Azure platform resources.

## Use standard modules

Reuse of components is a fundamental principle of Infrastructure-as-Code. Modules are instrumental in defining standards and consistency across resource deployment within and across environments. This module is published to the official [Terraform registry](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) and is official verified by HashiCorp so you can be confident of its origins.

## Architecture diagram

The [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) deploys the following enterprise scale components in your Azure tenant:

![Overview of resources deployed by the Terraform Module for Cloud Adoption Framework Enterprise-scale](media/terraform-caf-enterprise-scale-overview.png)
_Figure 1: Overview of resources deployed by the Terraform Module for Cloud Adoption Framework Enterprise-scale._

## Capabilities

The components deployed and their purpose include the following:

| Component | Responsibility |
|---|---|
| Management groups | Core Management Groups provide the resource hierarchy foundations of the enterprise scale reference architecture:<ul><li>Optional Management Groups for demo landing zones (SAP, Corp and Online)</li><li>Optional Management Groups for custom landing zones (define your own)</li></ul> |
| Azure Policy | Azure Policy to provide governance and security across the platform: <ul><li>Custom Policy Definitions and Policy Set Definitions to cover common governance patterns not covered by the built-in policies.</li><li>Create and assign policies at any scope within the Management Group hierarchy to ensure compliance is enforced through inheritance</li><li>Expand with your own custom definitions to meet your specific governance and security requirements:</li></ul> |
| Access control (IAM) settings | Create and assign Roles in the resource hierarchy to ensure compliance with RBAC policies:<ul><li>Create custom Role Definitions to ensure principle of least privilege</li><li>Create Role Assignments at the right scope to ensure platform and application teams have the right permissions</li></ul> |
| Subscriptions | Subscriptions are assigned to Management Groups:<ul><li>Enables policy and RBAC inheritance</li><li>Ensures compliance with platform security and governance requirements</li></ul> |

## Customize and deploy

To simplify getting started with this module, it has been published to the Terraform Registry. This allows you to consume it directly from the registry as a re-usable module and can benefit from updates as they get released.

The only dependencies for this module are as follows:

- Terraform version 0.13.x and later
- AzureRM Provider 2.31.1 and later

> [!NOTE]
> There are known issues with some combinations of Terraform and AzureRM Provider versions. Some of these are due to new bugs being introduced which have since been remediated, whilst others are transient errors which can be resolved by re-running your deployment. We generally advise you to pin to a specific version of both the Terraform and AzureRM Provider, and test thoroughly before upgrading. As each new version of the module is released, we plan to rebase support to ensure compatibility with the latest Terraform and AzureRM Provider versions.

### Simple Example

Although the module only requires a value set for the mandatory  `root_parent_id` variable to get started, we recommend specifying a value for `root_id`. This is to prevent the need to initiate a full redeployment if you decide to change this value later.

As such, a simple starting configuration should look like the following:

```hcl
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Use the azurerm_client_config data resource to dynamically extract the
# current Tenant ID from your connection settings.
data "azurerm_client_config" "current" {
}

# Call the caf-enterprise-scale module directly from the Terraform Registry
# pinning to the latest version
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "0.0.8"

  root_parent_id = data.azurerm_client_config.current.tenant_id
  root_id        = "demo"

}
```

This example code will deploy the default enterprise scale resources and provides a great starting point for building out your resource hierarchy in line with the recommended design guidelines for [Management Group and Subscription organization](./management-group-and-subscription-organization.md).

> [!Note]
> If you are new to Terraform, please refer to this tutorial on HashiCorp Learn covering installation and use of Terraform:<br>
> https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started

## Next steps

The Terraform Module for Cloud Adoption Framework Enterprise-scale provides an accelerated path to building out your enterprise scale landing zones. It also provides a great deal of flexibility to expand and customize your deployment whilst retaining a simplified approach to managing the configuration of each landing zone.

To find out more, review the module on Terraform Registry, and explore the [GitHub Wiki](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki) where we will post more examples and tutorials covering how to customize your deployment.

> [!div class="nextstepaction"]
> [Review the module on Terraform Registry](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest)
