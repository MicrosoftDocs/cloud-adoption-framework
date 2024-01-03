---
title: Advanced Azure Policy management
description: Improve policy management using Enterprise Policy As Code.
author: anwather
ms.author: anwather
ms.date: 01/04/2023
ms.topic: conceptual
ms.custom: internal
---

# Advanced Azure Policy management

Policy-driven governance is one of the design principles for Azure landing zones. It helps to ensure that the applications you deploy comply with your organization's platform. It can take considerable effort to manage and test policy objects across an environment to ensure that compliance is met.

[Azure landing zone accelerators](/azure/architecture/landing-zones/landing-zone-deploy) help to establish a secure baseline. And your organization might have further requirements to help enhance compliance via the deployment of other policies. This article describes how to manage Azure Policy at scale by using infrastructure as code (IaaC).

## What is Enterprise Policy As Code (EPAC)?

[EPAC](https://azure.github.io/enterprise-azure-policy-as-code) is an open-source project that you can use to manage Azure Policy by using IaaC. EPAC is built upon a PowerShell module and published to the PowerShell Gallery. You can use the features of this project to help manage policies:

- Create stateful policy deployments. The objects that are defined in the code become the source of truth for policy objects deployed in Azure.

- Use complex policy management scenarios, such as multitenant and sovereign cloud deployments.
- Incorporate existing time spent developing custom policies prior to Azure landing zone deployment by exporting and integrating policies.
- Create and manage policy exemptions and policy documentation.
- Use sample workflows to demonstrate Azure Policy deployment by using GitHub Actions or Azure Pipelines.
- Export noncompliance reports and create remediation tasks.

## Reasons to use EPAC

You can use EPAC to deploy and manage Azure landing zone policies. You might want to consider using EPAC to manage policies if:

- You have unmanaged policies in an existing brownfield environment that you want to deploy in a new Azure landing zone environment. [Export the existing policies](https://azure.github.io/enterprise-azure-policy-as-code/extract-existing-policy-resources) and manage them with EPAC alongside the Azure landing zone policy objects.

- You have an Azure deployment that doesn't fully align to an Azure landing zone, for example multiple management group structures for testing or a nonconventional management group structure. The default assignment structure that other Azure landing zone deployment methods provide might not fit your strategy.
- You have a team that's not responsible for infrastructure deployment, for example a security team that might want to deploy and manage policies.
- You require features from policies that aren't available in the Azure landing zone accelerator deployments, for example policy exemptions and documentation.

## Get started

The EPAC GitHub repository provides detailed steps on getting started with managing Azure Policy. Some decisions need to be considered when determining if the project is a good fit for your environment:

- Environment topology: Multiple tenancies and complicated management group structures are supported. You should think about how you want to structure your policy as code deployments to fit the topology to allow for multiple teams to manage policy and for testing of new policy deployments.

- Permissions: Consider how you manage permissions for the deployment in particular for roles and identities. EPAC uses multiple stages to deploy both the policies and role assignments so separate identities can be used.
- Existing policy deployments: In a brownfield scenario you might have existing policies that must remain in place while EPAC is being deployed. You can use the [Desired State strategy](https://azure.github.io/enterprise-azure-policy-as-code/desired-state-strategy) to ensure that EPAC manages only the policies it knows about.
- Deployment methodology: EPAC supports both Azure DevOps, GitHub Actions and a PowerShell module to help deploy policies. Sample pipelines are provided in the [EPAC Starter Kit](https://github.com/Azure/enterprise-azure-policy-as-code/tree/main/StarterKit) and can be adapted for your environment and requirements.

Follow the [quick start](https://azure.github.io/enterprise-azure-policy-as-code/quick-start/#epac-quick-start) guide to begin by exporting policy objects in your environment to gain familiarity with how EPAC manages Azure Policy.

For issues with the code or documentation, raise an [issue](https://github.com/Azure/enterprise-azure-policy-as-code/issues) in the GitHub repository.

## Replace existing policy deployment solutions

EPAC replaces the policy deployment parts of the Azure landing zone accelerators. When using these accelerators, you should not deploy Azure Policy due to EPAC being the source of truth for policy in the environment.

For more information, see the links below for policy management using Bicep and Terraform ALZ accelerators.

- [How Does ALZ-Bicep implement Azure policies?](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive)
- [Archetype definitions](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Archetype-Definitions)

## References

- [Enterprise Policy As Code](https://azure.github.io/enterprise-azure-policy-as-code)
