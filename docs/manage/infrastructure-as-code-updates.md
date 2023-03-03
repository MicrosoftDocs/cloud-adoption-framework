---
title: Why use Infrastructure as Code to update your ALZ
description: Learn about the benefits of using Infrastructure as Code to perform updates to your Azure Landing Zone
author: brsteph
ms.author: bstephenson
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.date: 03/03/2023
ms.custom: template-overview
---

# Why use Infrastructure as Code to update your ALZ?

This article explains the benefits of using Infrastructure as Code to update Azure landing zones.  Organizations will need to continue to update their landing zones as they operate, both to ensure configuration is continually correct, and also to respond to needs for changes.

Because Infrastructure as Code can be used to manage the whole life cycle, and excels at managing resources that it has deployed, organizations should plan to deploy their Azure Landing Zones with Infrastructure as Code.  Attempting to bring non-IaC deployed resources in to the management scope of IaC can be a time consuming effort.  

To understand more about why you will want to update your Landing Zone, visit [Keep your Azure landing zone up to date](../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md)

## What does Infrastructure as Code do?

Infrastructure as Code, abbreviated as IaC, refers to the practice and tools for managing the lifecycle of infrastructure resources using machine-readable definition files.  The definition for the infrastructure is written, and then can be versioned, deployed through pipelines, and become a part of the deployment for workloads.

Infrastructure as Code technologies are *declarative* meaning that running it multiple times with the same definition will not change the result beyond the initial application.  Configuring infrastructure through scripts, such as the Azure CLI or Azure PowerShell, are *imperative* meaning that the scripts contain a set of actions that will be repeated each time it is run.

This means that if you have an Infrastructure as Code definition for an Azure resource, you can run that definition as often as you want and it will only create a change if:

- The definition has changed, to add new resources, remove resource previously deployed, or modify resources previously deployed.
- The deployed resource has drifted from the configuration, to reset the configuration to the defined one.

This means that Infrastructure as Code is exceptional at restoring state, removing resources that are no longer needed, and managing the lifecycle of resources through many changes.

For Azure landing zones, there are two main options for Infrastructure as Code:

- Azure Bicep, managed by Microsoft, specifically for ALZ visit [ALZ Bicep repository](https://aka.ms/alz/bicep).
- Terraform, managed by Hashicorp, specifically for ALZ visit [ALZ Terraform registry](https://aka.ms/alz/tf/repo).

You can learn more about planning for automation of Landing Zones by referencing the [Automation](../ready/considerations/automation.md#platform-automation-design-recommendation) article.

## Benefits of updating ALZ with Infrastructure as Code

The following are the key benefits to using Infrastructure as Code to make your Landing Zone Updates.

### Reduces effort

Using Infrastructure as Code to perform updates takes less effort than making changes manually.  The IaC deployment helps answer:

- How are resources configured today?
- How will it be configured by this update?
- What changes will be made to bring it in line with this update?

When an Infrastructure as Code tool set is run, it can be used to produce a comparison or "differential" read out of the changes; this can be used to review prior to committing changes to the environment.

This means that instead of having an operator or engineer compile the information for the change, the tool set can do that.

### Reduced error

Due to the programmatic nature of the deployments, Infrastructure as Code can be used to reduce human error while making changes.  Because it only changes what is defined, and it has preview options, it can reduce outages caused by failed or incomplete changes.  In addition, there are improved options for testing.

### Version control and history

Because Infrastructure as Code deployments are backed by a definition file, you can use source control to manage the versions of your definitions.  Depending on the method of Infrastructure as Code you use, you can also reference Deployments in Azure (for Bicep) or your state file (for Terraform) to review the history of deployments that have previously taken place.

Using source control practices, a new branch of your Infrastructure as Code should be created to add changes and revisions.  This branch's history in your source control system will capture the iterations and changes.  Deployments with it can be done to a test environment (see [Testing approach for Azure landing zones](../ready/enterprise-scale/testing-approach.md)) until the changes are ready to be merged in and deployed to production.  All throughout this cycle, the deployment records will capture what version was used, and what resources were deployed, giving you a highly visible history.

### Testing environments

Because Infrastructure as Code deployments are repeatable, you can use the same definition to deploy a second (or more) environment based on the deployment.  This can be valuable for testing changes.

For example, if you wanted to replace your Azure Firewall with one using the Premium SKU, you could deploy a test environment and validate the changes without changing production.  

### Catch configuration drifts

Infrastructure as Code also provides a unique option to catch configuration drifts during updates.  Not only can the deployment catch changes to the definition file, it can present instances where resources have been configured differently from the definition.

Periodic Landing Zone updates with Infrastructure as Code can help you catch this configuration drift, and allow you to update the code appropriately, address these misconfigurations via the update, or address them in some other way.

When you make a change to resources via the portal, CLI, or other non-Infrastructure as Code method, the change will go through.  When you next run a deployment through Infrastructure as Code, the comparison to the code defined state and the actual state in the portal is able to be flagged (using what-if or plan functions).  This can be used to identify that an environment has been modified outside of the code file.

Once identified, Infrastructure as Code can be run to reset the resources to the correct configuration.  This is the default in Terraform, but requires using a Complete function in Bicep.  This can let you repair unauthorized changes.

Changes that are defined in the portal can be cumbersome to implement back in to Infrastructure as Code.  They require updating the code to match the current state, which often involves reviewing each resource changed and updating its parameters to match the "as is" configuration.

As a result, if you are using Infrastructure as Code to manage your Landing Zone or other resources, you should plan only to make changes outside of Infrastructure as Code only as part of an emergency.  You should take all precautions with accounts who have access to make changes directly, such as using Privileged Identity Management.  See [Security Baseline discipline overview](../govern/security-baseline/index.md) and [Identity Baseline discipline overview](../govern/identity-baseline/index.md) for guidance on this.

You can review [Operational compliance considerations](../ready/landing-zone/design-area/management-operational-compliance.md#operational-compliance-recommendations)

## Next steps

You can learn more about managing Azure Landing Zones with Infrastructure as Code by referencing these two repositories:

- [ALZ Bicep](https://aka.ms/alz/bicep)
- [ALZ Terraform](https://aka.ms/alz/terraform)
