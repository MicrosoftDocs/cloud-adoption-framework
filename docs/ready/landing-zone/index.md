---
title: What is a landing zone?
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- markdownlint-disable MD026 -->

# What is a landing zone?

Infrastructure as code is a natural transition during most cloud adoption efforts. Deployment of your first landing zones in the cloud is a common starting point to transition into code-first environment creation. This article will aid in understanding the term _landing zone_ and other related terms.

## Landing zone definition

A landing zone is the basic building block of any cloud adoption environment. The term _landing zone_ refers to a logical construct capturing everything that must be true to enable the desired cloud adoption.

**Scope:** A fully functional landing zone considers all platform resources that are required to support the customer's adoption needs.

**Refactoring:** A fully functional landing zone is the final deliverable of any iteration of the Cloud Adoption Framework's Ready methodology. During each iteration, the code base that defines the landing zone will be refactored or expanded. After refactoring, the landing zone may be modified or redeployed to allow for new cloud adoption needs.

**Goal:** The goal of the landing zone approach is to create a common set of consistent platform implementations. Those consistent implementations must be in place to ensure that your applications have access to requisite components when deployed. Each landing zone iteration must consequently be designed and deployed in accordance with the requirements of the cloud adoption plan and the subscription design strategy.

**Principle purpose:** The principle purpose of the landing zone is to ensure that when an application lands on Azure, the required "plumbing" is already in place.

## Landing zone usage

Landing zones do not necessarily differentiate between IaaS or PaaS adoption. However, landing zones are purpose built to support the adoption plan by fulfilling the subscription strategy. Supporting the adoption plan may require multiple landing zones with a mixture of required components.

The purpose and scope of the overall cloud adoption plan will define what "plumbing" is required. Additional governance, compliance, security, and operational management requirements will likely add to the initial landing zone scope. During early stages of adoption, landing zones may include less "plumbing" as a result of defined requirements and acceptable risks.  When multiple landing zones exist, it is very common for each landing zone to be dependent on hubs that provide the required controls through a shared service model.

## Related terms

- **Shared services:** Workloads often have shared dependencies which are used by many different workloads. The shared services approach moves many of those common dependencies into one logical construct.

- **Hub and spoke model:** One implementation of the shared services approach is a hub and spoke model. In this model, the hub is a single logical construct for hosting all shared services. Landing zones then act as spokes radiating out of the hub, based on common dependencies.

- **Independent landing zone:** Some approaches to landing zones do not specifically call for a dedicated hub. This is most commonly seen when all production assets (apps, data, and VMs) in the cloud adoption plan can be safely hosted, managed, and governed in a single environment.

## Next steps

To start using landing zones, [choose your first landing zone](./first-landing-zone.md).

> [!div class="nextstepaction"]
> [Choose your first landing zone](./first-landing-zone.md)
