---
title: Advanced Azure Policy management
description: Learn how to manage Azure Policy at scale by using the Enterprise Policy as Code (EPAC) open-source project and integrating IaC into your environment.
author: anwather
ms.author: anwather
ms.date: 01/04/2023
ms.topic: conceptual
ms.custom: internal
---

# Advanced Azure Policy management

This article describes how to manage Azure Policy at scale by using infrastructure as code (IaC). Policy-driven governance is a design principle for Azure landing zones. It helps to ensure that the applications you deploy comply with your organization's platform. It can take considerable effort to manage and test policy objects across an environment to ensure that compliance is met. [Azure landing zone accelerators](/azure/architecture/landing-zones/landing-zone-deploy) help to establish a secure baseline, but your organization might have further compliance requirements that you must meet by deploying other policies.

## What is Enterprise Policy as Code (EPAC)?

[EPAC](https://azure.github.io/enterprise-azure-policy-as-code) is an open-source project that you can use to integrate IaC and manage Azure Policy. EPAC is built upon a PowerShell module and published to the PowerShell Gallery. You can use the features of this project to:

- Create stateful policy deployments. The objects that are defined in the code become the source of truth for policy objects deployed in Azure.

- Implement complex policy management scenarios, such as multitenant and sovereign-cloud deployments.
- Export and integrate policies to incorporate existing custom policies that were developed prior to the Azure landing zone deployment.
- Create and manage policy exemptions and policy documentation.
- Use sample workflows to demonstrate Azure Policy deployments with GitHub Actions or Azure Pipelines.
- Export noncompliance reports and create remediation tasks.

## Reasons to use EPAC

You can use EPAC to deploy and manage Azure landing zone policies. You might want to consider implementing EPAC to manage policies if:

- You have unmanaged policies in an existing brownfield environment that you want to deploy in a new Azure landing zone environment. [Export the existing policies](https://azure.github.io/enterprise-azure-policy-as-code/start-extracting-policy-resources/), and manage them with EPAC alongside the Azure landing zone policy objects.

- You have an Azure deployment that doesn't fully align to an Azure landing zone, for example multiple management group structures for testing or a nonconventional management group structure. The default assignment structure that other Azure landing zone deployment methods provide might not fit your strategy.
- You have a team that's not responsible for infrastructure deployment, for example a security team that might want to deploy and manage policies.
- You require features from policies that aren't available in the Azure landing zone accelerator deployments, for example policy exemptions and documentation.

## Get started

The EPAC GitHub repository provides detailed steps to start managing Azure Policy. Consider the following factors when determining whether the project is a good fit for your environment:

- *Environment topology*: Multiple tenancies and complicated management group structures are supported. Consider how you want to structure your policy as code deployments to fit the topology, so multiple teams can manage policies and test new policy deployments.

- *Permissions*: Consider how you manage permissions for the deployment, especially for roles and identities. EPAC provides multiple stages to deploy both the policies and role assignments, so separate identities can be used.
- *Existing policy deployments*: In a brownfield scenario, you might have existing policies that must remain in place while EPAC is deployed. You can use the [desired state strategy](https://azure.github.io/enterprise-azure-policy-as-code/settings-desired-state/) to ensure that EPAC manages only the defined policies and preserves existing policies.
- *Deployment methodology*: EPAC supports Azure DevOps, GitHub Actions, and a PowerShell module to help deploy policies. You can use the [sample pipelines in the EPAC starter kit](https://github.com/Azure/enterprise-azure-policy-as-code/tree/main/StarterKit) and adapt them to your environment and requirements.

Follow the [quickstart guide](https://azure.github.io/enterprise-azure-policy-as-code/start-implementing/) to export policy objects in your environment and get familiar with how EPAC manages Azure Policy.

For issues with the code or documentation, [submit an issue in the GitHub repository](https://github.com/Azure/enterprise-azure-policy-as-code/issues).

## Replace existing policy deployment solutions

EPAC replaces the policy deployment capabilities of the Azure landing zone accelerators. When you use these accelerators, you shouldn't use them to deploy Azure Policy because EPAC is the source of truth for policy in the environment.

For more information, see the following resources for policy management with Bicep and Terraform Azure landing zone accelerators:

- [How Does ALZ-Bicep implement Azure policies?](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive)
- [Archetype definitions](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Archetype-Definitions)

## Next steps

- [Enterprise Policy as Code](https://azure.github.io/enterprise-azure-policy-as-code)
