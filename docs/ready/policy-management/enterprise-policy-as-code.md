---
title: Improve policy management
description: Improve policy management using Enterprise Policy As Code.
author: anwather
ms.author: anwather
ms.date: 26/09/2023
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
- Integrate with GitHub Actions and Azure DevOps
- Export non-compliance reports and create and manage remediation.

## Why and when should you use EPAC to manage Azure Landing Zone deployed policies?

EPAC can be used to both deploy and manage Azure Landing Zone deployed policies. Some reasons you may want to consider using EPAC to manage policy are:
- You have existing unmanaged policies in a brownfield environment that you want to deploy in the new ALZ environment. [Export the existing policies](https://azure.github.io/enterprise-azure-policy-as-code/extract-existing-policy-resources/) and manage them with EPAC alongside the ALZ policy objects.
- You have ALZ deployed in a non standard way e.g. multiple management group structures for testing, non-conventional management group structure. The default assignment structure provided by other ALZ deployment methods may not fit your strategy.
- A team that is not responsible for infrastructure deployment e.g. a security team may want to deploy and manage policies.
- You require features from policy not available in the ALZ deployments e.g. policy exemptions, documentation, assignment customization.
- Non-compliance reporting and remediation task management.

## Getting Started



## References

- [Enterprise Policy As Code](https://aka.ms/epac)