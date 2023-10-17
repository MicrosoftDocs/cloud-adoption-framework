---
title: Improve policy management
description: Improve policy management using Enterprise Policy As Code.
author: anwather
ms.author: anwather
ms.date: 10/26/2023
ms.topic: conceptual
ms.custom: internal
---

# Improving Azure Policy management

Policy driven governance is one the design principles for Azure Landing Zones to ensure applications you deploy comply with your organization's platform. The management of policy objects across an environment can take considerable effort to test and maintain to ensure this compliance is met. The Azure Landing Zone accelerators deploy a large number of custom policy definitions and assignments designed to provide a secure baseline for your platform however your organization may have further requirements to enhance compliance through deployment of other policies. This article provides a way to manage Azure Policy at scale using infrastructure as code.   

## What is Enterprise Policy As Code (EPAC)

[Enterprise Policy as Code](https://aka.ms/epac) (EPAC) is an open source project designed to manage Azure Policy using infrastructure as code. It contains a set of features designed to enhance the policy management experience including:
- A stateful policy deployment experience. The objects defined in the code become the source of truth for policy objects deployed in Azure.
- Enables complex policy management scenarios such as multi-tenant and sovereign cloud deployments.
- Incorporate existing time spent developing custom policies prior to Azure Landing Zone deployment by exporting and integrating policies. 
- Create and manage policy exemption and policy documentation.
- Integrate with GitHub Actions and Azure Pipelines.
- Export non-compliance reports and create and manage remediation.

## Why and when should you use EPAC to manage Azure Landing Zone deployed policies?

EPAC can be used to both deploy and manage Azure Landing Zone deployed policies. Some reasons you may want to consider using EPAC to manage policy are:
- You have existing unmanaged policies in a brownfield environment that you want to deploy in the new ALZ environment. [Export the existing policies](https://azure.github.io/enterprise-azure-policy-as-code/extract-existing-policy-resources/) and manage them with EPAC alongside the ALZ policy objects.
- You have ALZ deployed in a non standard way e.g. multiple management group structures for testing, non-conventional management group structure. The default assignment structure provided by other ALZ deployment methods may not fit your strategy.
- A team that is not responsible for infrastructure deployment e.g. a security team may want to deploy and manage policies.
- You require features from policy not available in the ALZ deployments e.g. policy exemptions, documentation, assignment customization.
- Non-compliance reporting and remediation task management.

## Getting Started

The EPAC repository provides detailed steps on getting started with managing Azure Policy. Some decisions need to be considered when determining if the project is a good fit for your environment:
- Environment topology - multiple tenancies and complicated management group structures are supported. You should think about how you want to structure your policy as code deployments to fit the topology to allow for multiple teams to manage policy and for testing of new policy deployments.
- Permissions - consider how you will manage permissions for the deployment in particular for roles and identities. EPAC uses multiple stages to deploy both the policies and role assignments so separate identities can be used.
- Existing policy deployments - in a brownfield scenario you might have existing policies which must remain in place while EPAC is being deployed. You can use the [Desired State strategy](https://azure.github.io/enterprise-azure-policy-as-code/desired-state-strategy/) to ensure that EPAC manages only the policies it knows about.
- Deployment methodology - EPAC supports both Azure DevOps, GitHub Actions and a PowerShell module to help deploy policies. Sample pipelines are provided in the [EPAC Starter Kit](https://github.com/Azure/enterprise-azure-policy-as-code/tree/main/StarterKit) and can be adapted for your environment and requirements.

Follow the [quick start](https://azure.github.io/enterprise-azure-policy-as-code/quick-start/#epac-quick-start) guide to begin by exporting policy objects in your environment to gain familiarity with how EPAC manages Azure Policy.

For issues with the code or documentation please raise an [issue](https://github.com/Azure/enterprise-azure-policy-as-code/issues) in the GitHub repository. 

## References

- [Enterprise Policy As Code](https://aka.ms/epac)