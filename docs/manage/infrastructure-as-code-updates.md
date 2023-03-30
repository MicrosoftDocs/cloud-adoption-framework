---
title: Use infrastructure as code to update Azure landing zones
description: Learn about the benefits of using infrastructure as code to update your Azure landing zone to ensure configurations are correct.
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

IaC can manage the whole life cycle, and it excels at managing the resources that it deploys. Organizations should plan to deploy their Azure landing zones with IaC. It requires planning to align existing non-IaC resources with IaC resources that are backed with state management. You need to map the existing resources to the desired state.

For more information, see [Keep your Azure landing zone up to date](../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md).

## How infrastructure as code works

IaC refers to the practice and tools for managing the lifecycle of infrastructure resources by using machine-readable definition files. The definition for the infrastructure is written, versioned, deployed through pipelines, and then it becomes a part of the deployment for workloads.

IaC technologies are *declarative*, which means when IaC runs, it sets the configuration to what's described in the code, regardless of its current state. When you configure infrastructure through scripts, such as the Azure CLI or Azure PowerShell, they're *imperative*. Imperative scripts perform a set of actions, and the result depends on the current state plus the state after the actions.

So, if you have an infrastructure as code definition for an Azure resource, you can run that definition as often as you want, and it only creates a change if:

- The definition changes to add new resources, remove resources previously deployed, or modifies resources that were previously deployed.
- The deployed resource drifts from the configuration to reset the configuration to the defined one.

You can use IaC to restore the state by removing resources that are no longer needed and managing the lifecycle of resources through many changes.

> [!NOTE]
> The specific mechanics to remove resources with IaC varies. For example, Azure Bicep requires the use of a `complete` deployment type to remediate out of scope resources. This command only works in specific scopes. For Terraform, resources have a `lifecycle` meta-argument that provides instructions for how Terraform should handle resources.

For Azure landing zones, there are two main options for infrastructure as code:

- Azure Bicep, which is a domain-specific language that's used to deploy Microsoft developed Azure resources. For more information, see [Azure landing zones - Bicep modules design considerations](/azure/architecture/landing-zones/bicep/landing-zone-bicep).
- Terraform, a product produced by Hashicorp, to deploy infrastructure to the cloud and on-premises. Terraform has specific Microsoft produced resource providers for the deployment of Azure resources. For more information, see [Azure landing zones - Terraform module design considerations](/azure/architecture/landing-zones/terraform/landing-zone-terraform).

## The benefits of updating ALZ with infrastructure as code

The following benefits describe why you should use infrastructure as code to make your landing zone updates.

### Reduce effort

It takes less effort to use infrastructure as code to perform updates compared to making manual changes. The IaC deployment helps answer the following questions:

- How are resources configured today?
- How will it be configured by this update?
- What changes will be made to bring it in line with this update?

When an infrastructure as code toolset runs, it can produce a comparison or "differential" readout of the changes. Review this readout before you commit changes to the environment.

The toolset can compile the information for the change rather than an operator or an engineer.

### Reduce error

Due to the programmatic nature of the deployments, infrastructure as code reduces human error while it makes changes. It only changes what's defined, and it has preview options, so it reduces outages that are caused by failed or incomplete changes. It also has improved testing options.

### Version control and history

Infrastructure as code deployments are backed by a definition file, so you can use source control to manage the versions of your definitions. Depending on the method of IaC that you use, you can reference the deployments in Azure for Bicep or your state file for Terraform to review the history of previous deployments.

When you use source control practices, it creates a new branch of your IaC to add changes and revisions. The branch's history in your source control system captures the iterations and changes. You can use it to deploy changes to a test environment until you’re ready to merge and deploy the changes to production. For more information, see [Testing approach for Azure landing zones](../ready/enterprise-scale/testing-approach.md). Throughout this cycle, the deployment records capture the version that's used and the resources that are deployed, which provides a highly visible history.

Use these testing methods with Bicep for general testing purposes.

For information about performing tests, such as integration tests, unit tests, canary release tests, and fault injection tests, see [Testing your application and Azure environment](/azure/architecture/framework/devops/release-engineering-testing). With these methods, you can perform testing before you deploy the code, and you can test in non-production environments from your branch.  

### Testing environments

IaC deployments are repeatable, so you can use the same definition to deploy a second (or more) environment based on the deployment. This method is valuable for testing changes.

For example, if you want to replace your Azure Firewall by using the Premium SKU, you can deploy a test environment and validate the changes without changing production.  

### Catch configuration drifts

IaC provides a unique option to catch configuration drifts during updates. The deployment catches changes to the definition file and presents instances where the resource configuration differs from the definition.

Landing zone updates with IaC can help you catch this configuration drift and allow you to update the code appropriately, address these misconfigurations via the update, or address them in another way.

When you make a change to resources via the portal, CLI, or a non-IaC method, the change is implemented. The next time you run a deployment through IaC, it flags the comparison between the code-defined state and the actual state in the portal by using what-if or plan functions. Use this method to identify if an environment is modified outside of the code file.

After the misalignment is identified, you can run IaC to attempt to align the deployment with the definition. Use this method to identify issues and remediate scenarios depending on the nature of the issues, the nature of the run, and how the changes were made. For example, Terraform attempts to restore the baseline to resources it has deployed, and a `Complete` mode deployment in Bicep removes resources in a resource group that aren't part of the definition. These tools detect and repair configuration drift, but they might not address all issues.

For more information, see [Out-of-band changes](/azure/developer/terraform/comparing-terraform-and-bicep?tabs=comparing-bicep-terraform-integration-features#out-of-band-changes) and [Detecting and managing drift with Terraform](https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform).

Changes that are defined in the portal are cumbersome to implement back in to IaC. You must update the code to match the current state, which often involves reviewing each resource change and updating its parameters to match the "as is" configuration.

If you use IaC to manage your landing zone or other resources, you should only make changes outside of IaC as part of an emergency. Take precautions with accounts that have access to make changes directly, such as Privileged Identity Management.

Review general automation and security practices in the following articles:

- [Security Baseline discipline overview](../govern/security-baseline/index.md)
- [Identity Baseline discipline overview](../govern/identity-baseline/index.md)
- [Operational compliance recommendations](../ready/landing-zone/design-area/management-operational-compliance.md#operational-compliance-recommendations)
- [Platform automation design recommendations](../ready/considerations/automation.md#platform-automation-design-recommendation)

## Next steps

Explore an introduction to the IaC tools in the following articles:

- [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [What is Terraform?](https://developer.hashicorp.com/terraform/intro)
- [Testing Terraform code](/azure/developer/terraform/best-practices-testing-overview)
