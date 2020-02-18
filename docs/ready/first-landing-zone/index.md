---
title: Azure landing zone considerations
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2019
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# First landing zone

TODO: Intro text here

## Defining a landing zone

**Scope:** A landing zone is the basic building block of any cloud adoption environment. The term *landing zone* refers to a logical construct capturing everything that must be true to enable the desired cloud adoption. A fully functioning landing zone considers all platform resources that are required to support the customer’s adoption needs and does not necessarily differentiate between IaaS or PaaS adoption.

**Refactoring:** A functioning landing zone is the final deliverable of any iteration of the Cloud Adoption Framework's Ready methodology. During each iteration, the codebase which defines the landing zone will be refactored and/or expanded. After refactoring, the landing zone may be modified (or redeployed) allowing for new cloud adoption needs.

**Goal:** The goal of the landing zone approach is to create a common set of consistent platform implementations. Those consistent implementations must be in place to ensure that your applications have access to requisite components when deployed. Each landing zone iteration must consequently be designed and deployed in accordance with the requirements of the cloud adoption plan and the subscription design strategy.

**Principle purpose:** The principle purpose of the landing zone is therefore to ensure that when an application lands on Azure, the required "plumbing" is already in place. 

The purpose and scope of the overall cloud adoption plan will define what "plumbing" is required. Additional governance, compliance, security, and operational management requirements will likely add to the initial landing zone scope. During early stages of adoption, landing zones may include less "plumbing" as a result of defined requirements and acceptable risks. The following considerations outline the types of plumbing that are likely to be found in all landing zones.

> [!IMPORTANT]
> One example of an expanded principle purpose, is the [CAF Northstar](../../getting-started/northstar/index.md). The northstar approach focuses on adoption teams who have mid-term objective (within 24 months) to more than 1,000 assets (apps, infra, or data assets) in the cloud. For those teams, the scope and principle purpose of landing zones is much richer, as seen in the [CAF Northstar architecture article](../../getting-started/northstar/architecture.md#landing-zone---expanded-definition).

## Choosing a landing zone

TODO: Pull from current landing zone article here...