---
title: Terraform Module for Cloud Adoption Framework Enterprise-scale
description: Learn how to use the Terraform Module for Cloud Adoption Framework Enterprise-scale.
author: KevinRowlandson
ms.author: brblanch
ms.date: 02/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- cSpell:ignore eastasia southeastasia vCPUs lalogs tfvars NetworkMonitoring ADAssessment ADReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->
<!-- docutune:casing NetworkMonitoring AdAssessment AdReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->

# Terraform Module for Cloud Adoption Framework Enterprise-scale

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

![Foundational landing zone using Terraform](media/terraform-caf-enterprise-scale-overview.png)
_Figure 1: A foundation landing zone using Terraform._

## Capabilities

The components deployed and their purpose include the following:

| Component | Responsibility |
|---|---|
| Management groups | Core Management Groups needed for the foundation enterprise scale reference architecture.<ul><li>Optional Management Groups for demo landing zones (SAP, Corp and Online)</li><li>Optional Management Groups for custom landing zones (define your own)</li></ul> |
| Azure Policy | Azure Policy to provide governance and security across the platform: <ul><li>Custom Policy Definitions and Policy Set Definitions to cover common governance patterns not covered by the built-in policies.</li><li>Create and assign policies at any scope within the Management Group hierarchy to ensure compliance is enforced through inheritance.</li><li>Expand with your own custom definitions to meet your specific governance and security requirements.</li></ul> |
| Access control (IAM) settings | Create and assign Roles in the resource hierarchy to ensure compliance with RBAC policies.<ul><li>Create custom Role Definitions to ensure principle of least privilege</li><li>Create Role Assignments at the right scope to ensure platform and application teams have the right permissions.</li></ul> |


