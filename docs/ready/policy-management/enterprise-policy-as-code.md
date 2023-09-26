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

Enterprise Policy as Code (EPAC) is an open source project designed to manage Azure Policy using infrastructure as code. It contains a set of features designed to enhance the policy management experience including:
- A stateful policy deployment experience. The objects defined in the code become the source of truth for policy objects deployed in Azure.
- Enables complex policy management scenarios such as multi-tenant and sovereign cloud deployments.
- Incorporate existing time spent developing custom policies prior to Azure Landing Zone deployment by exporting and integrating policies. 
- Create and manage policy exemption and policy documentation.
- Integrate with GitHub Actions and Azure DevOps
- Export non-compliance reports and create and manage remediation.

## Why and when should you use EPAC to manage Azure Landing Zone deployed policies?

EPAC can be used to both deploy and manage Azure Landing Zone deployed policies.

## Getting Started

## Learn more