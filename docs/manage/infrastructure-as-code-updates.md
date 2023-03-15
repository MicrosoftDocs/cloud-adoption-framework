---
title: Why use Infrastructure as Code to update your ALZ
description: Learn about the benefits of using Infrastructure as Code to perform updates to your Azure Landing Zone
author: brsteph
ms.author: bstephenson
ms.reviewer: tozimmergren
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.date: 03/03/2023
---

# Why use Infrastructure as Code to update your ALZ?

This article explains the benefits of using Infrastructure as Code to update Azure landing zones.  Organizations need to continue to update their landing zones as they operate to ensure configurations are continually correct and respond to needs for changes.

Because Infrastructure as Code can manage the whole life cycle and excels at managing resources that it has deployed, organizations should plan to deploy their Azure Landing Zones with Infrastructure as Code.  Attempting to bring non-IaC deployed resources in to the management scope of IaC will involve some additional effort.  Most organizations are better served starting with IaC deployments to reduce effort later.

To understand more about why you'll want to update your Landing Zone, visit [Keep your Azure landing zone up to date](../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md)

## What does Infrastructure as Code do?

Infrastructure as Code, abbreviated as IaC, refers to the practice and tools for managing the lifecycle of infrastructure resources using machine-readable definition files.  The definition for the infrastructure is written and then can be versioned, deployed through pipelines, and become a part of the deployment for workloads.

Infrastructure as Code technologies are *declarative* meaning that when it runs, it sets the configuration to what is described in the code, regardless of its current state.  Configuring infrastructure through scripts, such as the Azure CLI or Azure PowerShell, are *imperative* meaning that the scripts perform a set of actions; the result will depend on the current state plus the state after the actions.

This means that if you have an Infrastructure as Code definition for an Azure resource, you can run that definition as often as you want, and it will only create a change if:

- The definition has changed to add new resources, remove resources previously deployed, or modify resources previously deployed.
- The deployed resource has drifted from the configuration to reset the configuration to the defined one.

This means that Infrastructure as Code can be used to restore state by removing resources that are no longer needed, and managing the lifecycle of resources through many changes.

>[!NOTE]
>The specific mechanics for IaC removing resources can vary.  For example, Bicep requires the use of a `complete` deployment type to remediate out of scope resources, and that only works in specific scopes.  For Terraform, resources have a `lifecycle` meta-argument that provide instructions for how Terraform should handle resources.

For Azure landing zones, there are two main options for Infrastructure as Code:

- Azure Bicep, which is domain-specific language used to deploy Azure resources developed by Microsoft.
- Terraform, which is a product produced by Hashicorp to deploy infrastructure to both cloud and on-prem.  Terraform has specific resource providers produced by Microsoft for the deployment of Azure resources.

## Benefits of updating ALZ with Infrastructure as Code

The following are the key benefits of using Infrastructure as Code to make your Landing Zone Updates.

### Reduces effort

Using Infrastructure as Code to perform updates takes less effort than making changes manually.  The IaC deployment helps answer the following:

- How are resources configured today?
- How will it be configured by this update?
- What changes will be made to bring it in line with this update?

When an Infrastructure as Code toolset runs, it can produce a comparison or "differential" read out of the changes; use this to review before committing changes to the environment.

This means that instead of having an operator or engineer compile the information for the change, the toolset can do that.

### Reduced error

Due to the programmatic nature of the deployments, Infrastructure as Code can be used to reduce human error while making changes.  Because it only changes what is defined and it has preview options, it can reduce outages caused by failed or incomplete changes.  In addition, there are improved options for testing.

### Version control and history

Because Infrastructure as Code deployments are backed by a definition file, you can use source control to manage the versions of your definitions.  Depending on the method of Infrastructure as Code you use, you can also reference Deployments in Azure (for Bicep) or your state file (for Terraform) to review the history of deployments that have previously taken place.

Using source control practices, a new branch of your Infrastructure as Code should be created to add changes and revisions.  This branch's history in your source control system captures the iterations and changes.  Deployments with it can be done to a test environment (see [Testing approach for Azure landing zones](../ready/enterprise-scale/testing-approach.md)) until the changes are ready to be merged in and deployed to production.  Throughout this cycle, the deployment records capture what version was used and what resources were deployed, giving you a highly visible history.

The article on [Testing Terraform code](https://learn.microsoft.com/azure/developer/terraform/best-practices-testing-overview) provides guidance on performing integration testing, unit testing, compliance testing, and end-to-end testing.  These methods allow you to perform testing even before you deploy the code, as well as to test in non-production environments from your branch.  These testing methods can also be used with Bicep.

### Testing environments

Because Infrastructure as Code deployments are repeatable, you can use the same definition to deploy a second (or more) environment based on the deployment.  This can be valuable for testing changes.

For example, if you wanted to replace your Azure Firewall with one using the Premium SKU, you could deploy a test environment and validate the changes without changing production.  

### Catch configuration drifts

Infrastructure as Code provides a unique option to catch configuration drifts during updates.  The deployment can catch changes to the definition file and present instances where resources have been configured differently from the definition.

Periodic Landing Zone updates with Infrastructure as Code can help you catch this configuration drift and allow you to update the code appropriately, address these misconfigurations via the update, or address them in some other way.

When you make a change to resources via the portal, CLI, or other non-Infrastructure as Code method, the change goes through.  When you next run a deployment through Infrastructure as Code, the comparison to the code-defined state and the actual state in the portal can be flagged (using what-if or plan functions).  This can be used to identify that an environment has been modified outside of the code file.

Once identified, Infrastructure as Code can be run to attempt to align the deployment with the definition.  This can be used to identify issues and remediate many scenarios, depending on the nature of the issues, the nature of the run, and how the changes were made.  For example, Terraform will attempt to restore the baseline to resources it has deployed previously, and a `Complete` mode deployment in Bicep will remove resources in a resource group that are not part of the definition.  These can be excellent tools to detect and repair configuration drift, even if they might not be able to address all issues.

To understand how Terraform and Bicep handle out of band changes, read the following:

- [Comparing Out of Band Changes - Out of Band Changes](https://learn.microsoft.com/azure/developer/terraform/comparing-terraform-and-bicep?tabs=comparing-bicep-terraform-integration-features#out-of-band-changes)

To learn more about how Terraform can detect and manage configuration drift, read the following:

- [Detecting and Managing Drift with Terraform](https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform)

Changes that are defined in the portal can be cumbersome to implement back in to Infrastructure as Code.  They require updating the code to match the current state, often involving reviewing each resource change and updating its parameters to match the "as is" configuration.

As a result, if you're using Infrastructure as Code to manage your Landing Zone or other resources, you should plan only to make changes outside of Infrastructure as Code only as part of an emergency.  You should take all precautions with accounts that have access to make changes directly, such as using Privileged Identity Management.

You can review general automation and security practices in the following articles:

- [Security Baseline discipline overview](../govern/security-baseline/index.md)
- [Identity Baseline discipline overview](../govern/identity-baseline/index.md)
- [Operational compliance considerations](../ready/landing-zone/design-area/management-operational-compliance.md#operational-compliance-recommendations)
- [Platform Automation Design Recommendations](../ready/considerations/automation.md#platform-automation-design-recommendation)

## Next steps

You can explore an introduction to the Infrastructure as Code tools in the following articles:

- [What is Bicep?](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [What is Terraform?](https://developer.hashicorp.com/terraform/intro)

You can learn more about deploying and operating Azure Landing Zones with Infrastructure as Code in the following articles:

- [Azure landing zones - Bicep modules design considerations](https://learn.microsoft.com/azure/architecture/landing-zones/bicep/landing-zone-bicep)
- [Azure landing zones - Terraform module design considerations](https://learn.microsoft.com/azure/architecture/landing-zones/terraform/landing-zone-terraform)
