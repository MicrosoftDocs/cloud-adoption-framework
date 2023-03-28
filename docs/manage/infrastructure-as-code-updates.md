---
title: Use infrastructure as code to update Azure landing zones
description: Learn about the benefits of using Infrastructure as Code to perform updates to your Azure landing zone
author: brsteph
ms.author: bstephenson
ms.reviewer: tozimmergren
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.date: 03/03/2023
---

# Use infrastructure as code to update Azure landing zones

This article describes the benefits of using infrastructure as code (IaC) to update Azure landing zones. Organizations need to update their landing zones as they operate to ensure that configurations are correct and they respond to the need for changes.

Because IaC can manage the whole life cycle and excels at managing resources that it has deployed, organizations should plan to deploy their Azure landing zones with IaC. Aligning existing non-IaC resources with IaC resources backed with state management will require planning, in order to map the existing resources to the desired state.

To understand more about why you'll want to update your landing zone, visit [Keep your Azure landing zone up to date](../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md)

## What does infrastructure as code do?

IaC refers to the practice and tools for managing the lifecycle of infrastructure resources using machine-readable definition files. The definition for the infrastructure is written and then can be versioned, deployed through pipelines, and become a part of the deployment for workloads.

IaC technologies are *declarative* meaning that when it runs, it sets the configuration to what is described in the code, regardless of its current state. Configuring infrastructure through scripts, such as the Azure CLI or Azure PowerShell, are *imperative* meaning that the scripts perform a set of actions; the result will depend on the current state plus the state after the actions.

This means that if you have an infrastructure as code definition for an Azure resource, you can run that definition as often as you want, and it will only create a change if:

- The definition has changed to add new resources, remove resources previously deployed, or modify resources previously deployed.
- The deployed resource has drifted from the configuration to reset the configuration to the defined one.

This means that IaC can be used to restore state by removing resources that are no longer needed, and managing the lifecycle of resources through many changes.

> [!NOTE]
> The specific mechanics for IaC removing resources can vary. For example, Bicep requires the use of a `complete` deployment type to remediate out of scope resources. This command only works in specific scopes. For Terraform, resources have a `lifecycle` meta-argument that provide instructions for how Terraform should handle resources.

For Azure landing zones, there are two main options for infrastructure as code:

- Azure Bicep, which is domain-specific language used to deploy Azure resources developed by Microsoft. You can read more about deploying landing zones with Bicep in the article: [Azure landing zones - Bicep modules design considerations](https://learn.microsoft.com/azure/architecture/landing-zones/bicep/landing-zone-bicep)
- Terraform, which is a product produced by Hashicorp to deploy infrastructure to both cloud and on-prem. Terraform has specific resource providers produced by Microsoft for the deployment of Azure resources. You can read more about deploying landing zones with Terraform in the article: [Azure landing zones - Terraform module design considerations](https://learn.microsoft.com/azure/architecture/landing-zones/terraform/landing-zone-terraform)

## Benefits of updating ALZ with infrastructure as code

The following are the key benefits of using infrastructure as code to make your landing zone updates.

### Reduces effort

Using infrastructure as code to perform updates takes less effort than making changes manually. The IaC deployment helps answer the following:

- How are resources configured today?
- How will it be configured by this update?
- What changes will be made to bring it in line with this update?

When an infrastructure as code toolset runs, it can produce a comparison or "differential" read out of the changes; use this to review before committing changes to the environment.

This means that instead of having an operator or engineer compile the information for the change, the toolset can do that.

### Reduced error

Due to the programmatic nature of the deployments, infrastructure as code can be used to reduce human error while making changes. Because it only changes what is defined and it has preview options, it can reduce outages caused by failed or incomplete changes. In addition, there are improved options for testing.

### Version control and history

Because infrastructure as code deployments are backed by a definition file, you can use source control to manage the versions of your definitions. Depending on the method of IaC you use, you can also reference deployments in Azure (for Bicep) or your state file (for Terraform) to review the history of deployments that have previously taken place.

Using source control practices, a new branch of your IaC should be created to add changes and revisions. This branch's history in your source control system captures the iterations and changes. Deployments with it can be done to a test environment (see [Testing approach for Azure landing zones](../ready/enterprise-scale/testing-approach.md)) until the changes are ready to be merged in and deployed to production. Throughout this cycle, the deployment records capture what version was used and what resources were deployed, giving you a highly visible history.

For general testing guThese testing methods can also be used with Bicep.

The article on [Testing your application and Azure environment](https://learn.microsoft.com/azure/architecture/framework/devops/release-engineering-testing) provides guidance on performing different kinds of tests, such as integration testing, unit testing, canary release testing, and fault injection. These methods allow you to perform testing even before you deploy the code, as well as to test in non-production environments from your branch.  

### Testing environments

Because IaC deployments are repeatable, you can use the same definition to deploy a second (or more) environment based on the deployment.  This can be valuable for testing changes.

For example, if you wanted to replace your Azure Firewall with one using the Premium SKU, you could deploy a test environment and validate the changes without changing production.  

### Catch configuration drifts

IaC provides a unique option to catch configuration drifts during updates. The deployment can catch changes to the definition file and present instances where resources have been configured differently from the definition.

Periodic landing zone updates with IaC can help you catch this configuration drift and allow you to update the code appropriately, address these misconfigurations via the update, or address them in some other way.

When you make a change to resources via the portal, CLI, or other non-IaC method, the change goes through. When you next run a deployment through IaC, the comparison to the code-defined state and the actual state in the portal can be flagged (using what-if or plan functions). This can be used to identify that an environment has been modified outside of the code file.

Once identified, IaC can be run to attempt to align the deployment with the definition. This can be used to identify issues and remediate many scenarios, depending on the nature of the issues, the nature of the run, and how the changes were made. For example, Terraform will attempt to restore the baseline to resources it has deployed previously, and a `Complete` mode deployment in Bicep will remove resources in a resource group that are not part of the definition. These can be excellent tools to detect and repair configuration drift, even if they might not be able to address all issues.

To understand how Terraform and Bicep handle out of band changes, read the following:

- [Comparing Out of Band Changes - Out of Band Changes](https://learn.microsoft.com/azure/developer/terraform/comparing-terraform-and-bicep?tabs=comparing-bicep-terraform-integration-features#out-of-band-changes)

To learn more about how Terraform can detect and manage configuration drift, read the following:

- [Detecting and Managing Drift with Terraform](https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform)

Changes that are defined in the portal can be cumbersome to implement back in to IaC. They require updating the code to match the current state, often involving reviewing each resource change and updating its parameters to match the "as is" configuration.

As a result, if you're using IaC to manage your landing zone or other resources, you should plan only to make changes outside of IaC only as part of an emergency. You should take all precautions with accounts that have access to make changes directly, such as using Privileged Identity Management.

You can review general automation and security practices in the following articles:

- [Security Baseline discipline overview](../govern/security-baseline/index.md)
- [Identity Baseline discipline overview](../govern/identity-baseline/index.md)
- [Operational compliance considerations](../ready/landing-zone/design-area/management-operational-compliance.md#operational-compliance-recommendations)
- [Platform Automation Design Recommendations](../ready/considerations/automation.md#platform-automation-design-recommendation)

## Next steps

You can explore an introduction to the IaC tools in the following articles:

- [What is Bicep?](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [What is Terraform?](https://developer.hashicorp.com/terraform/intro)
- [Testing Terraform code](https://learn.microsoft.com/azure/developer/terraform/best-practices-testing-overview)
