---
title: Why use Infrastructure as Code to update your ALZ
description: Learn about the benefits of using Infrastructure as Code to perform updates to your Azure Landing Zone
author: brsteph
ms.author: bstephenson
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.date: 1/11/2022
ms.custom: template-overview
---

# Why use Infrastructure as Code to update your ALZ?

This article explains the benefits of using Infrastructure as Code to update Azure Landings Zones.  Organizations will need to continue to update their Landing Zones as they operate, both to ensure configuration is continually correct, and also to respond to needs for changes.

To understand more about why you will want to update your Landing Zone, visit [PLACEHOLDER - Article on WHY update ALZ Environment](./why-update-poc.md)

<!-- The below can be removed if it is covered in the above area.
Updates to the Landing Zone can be based on a variety of triggers, such as:

- New technologies may become available and need to be deployed as part of the Connectivity, Identity, or Management platform services
- There might be changes to Azure Policies, based on refinements on the defined Policies by Microsoft or changing use cases for customer created policies
- There may be the need to expand the Landing Zone to more regions
- There may be the need to broaden the management group structure to accommodate new architecture patterns or to address acquisitions
- Some other business event.

Ultimately, these changes will lead to updates driven either by customer changes, or by new solutions and recommendations that needs to be aligned to.
-->

## What does Infrastructure as Code do?

Infrastructure as Code, abbreviated as IaC, refers to the practice and tools for managing the lifecycle of infrastructure resources using machine-readable definition files.  The definition for the infrastructure is written, and then can be versioned, deployed through pipelines, and become a part of the deployment for workloads.

Infrastructure as code technologies is *idempotent* meaning that running it multiple times with the same definition will not change the result beyond the initial application.  Configuring infrastructure through scripts, such as the Azure CLI or Azure PowerShell, are *declarative* meaning that the scripts contain a set of actions that will be repeated each time it is run.

This means that if you have an Infrastructure as Code definition for an Azure resource, you can run that definition as often as you want and it will only create a change if:

- The definition has changed, to add, remove, or modify resources.
- The deployed resource has drifted from the configuration, to reset the configuration to the defined one.

This means that Infrastructure as Code is exceptional at restoring state, removing resources that are no longer needed, and managing the life cycle of resources through many changes.

For Azure, there are two main options for Infrastructure as Code:

- Azure Bicep, managed by Microsoft.
- Terraform, managed by  Hashicorp.

## Benefits of updating ALZs with Infrastructure as Code

The following are the key benefits to using Infrastructure as Code to make your Landing Zone Updates.

### Reduces Effort

Using Infrastructure as Code to perform updates takes less effort than making changes manually.  The IaC deployment helps answer:

- How are resources configured today?
- How will it be configured by this update?
- What changes will be made to bring it in line with this update?

When an Infrastructure as Code tool set is run, it can be used to produce a comparison or "differential" read out of the changes; this can be used to review prior to committing changes to the environment.

This means that instead of having an operator or engineer compile the information for the change, the tool set can do that.

### Reduced Error

Due to the programmatic nature of the deployments, Infrastructure as Code can be used to reduce human error while making changes.  Because it only changes what is defined, and it has preview options, it can reduce outages caused by failed or incomplete changes.  In addition, there are improved options for testing.

### Version Control

Because Infrastructure as Code deployments are backed by a definition file, you can use source control to manage the versions of your definitions.

For example, you could create a new branch of the code to add changes, and be able to keep those separate from the "production" deployment definition until you are ready to make changes.

### Testing Environments

Because Infrastructure as Code deployments are repeatable, you can use the same definition to deploy a second (or more) environment based on the deployment.  This can be valuable for testing changes.

For example, if you wanted to replace your Azure Firewall with one using the Premium SKU, you could deploy a test environment and validate the changes without impacting production.  

### Catch Configuration Drifts

Infrastructure as Code also provides a unique option to catch configuration drifts during updates.  Not only will the deployment catch changes to the definition file, it will present instances where resources have been configured differently from the definition.

Periodic Landing Zone updates with Infrastructure as Code will help you catch this configuration drift, and allow you to update the code appropriately, address these misconfigurations via the update, or address them in some other way.

You can review [Operational compliance considerations](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-operational-compliance) for additional guidance on monitoring configuration drift.

## Next steps

You can learn more about managing Azure Landing Zones with Infrastructure as code by referencing these two repositories:

- [ALZ Bicep](https://github.com/Azure/ALZ-Bicep)
- [ALZ Terraform](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale)
