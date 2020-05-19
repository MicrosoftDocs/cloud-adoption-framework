---
title: What is a landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- markdownlint-disable MD026 -->

# What is a landing zone?

Infrastructure as code is a common requirement for most cloud adoption efforts. The shift to code-first environment creation can add a learning curve for team members and require changes to aspects of operations, security, governance, and compliance. Deployment of discrete purpose-built landing zones helps to flatten those curves and let the team stay on track with adoption plans. This article will define the term _landing zone_ and other related terms. Other articles in this series will guide the creation of landing zones.

## Prerequisite to landing zone deployment

Before defining landing zones, it's important to understand a related term: _platform foundation_. In any environment (cloud, on-premises, or hybrid), you will find a collection of _foundation utilities_ that supports all of the various workloads. The business needs the workloads to operate. IT needs those foundational utilities to manage, govern, and secure the full _portfolio_ of workloads. For more information on these related terms and how they fit together, see [Portfolio hierarchy](../../reference/fundamental-concepts/hosting-hierarchy.md).

**Platform foundation:** Before deploying landing zones, it is assumed that centralized controls for identity, security, operations, compliance, and governance are provided to the landing zone from a shared _platform foundation_ that supports all workloads in that specific cloud platform. All workloads within each landing zone will be governed by these central controls to establish a consistent baseline across the _shared-architectural pillars_ of security, reliability, performance, cost, and cloud operations.

**Separation of duties:** There should be a clear separation of duties between the workload-focused work happening within a landing zone and the operation of the utilities that are managed outside of the landing zone. This separation of duties ensures proper governance and compliance. It also ensures that each team discusses and considers any exceptions to corporate policy to avoid quickly creating workarounds that could compromise your environment.

> [!CAUTION]
> Separation of duties should not discourage teams from using this best practice solely based on current staffing allocation or team structures. During early stage adoption of the cloud, a single adoption team may temporarily hold all of the responsibilities of adopting cloud technology and providing governance, security, and operations for a small number of workloads. If the forward-looking plan includes separation of duties, or even isolation of tasks, then this approach is still the suggested best practice.

**Shared responsibilities:** _Platform foundation_ provides centralized controls to govern the cloud platform. There is still a shared responsibility across all members of the team to consider identity, security, operations, compliance, and governance requirements. Before adopting any technology in a landing zone, understand what utilities are provided by the _platform foundation_ and what you will need to implement within the landing zone to fulfill your shared responsibilities.

> [!IMPORTANT]
> Developers and architects who are deploying solutions within a landing zone can reference [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/framework/) to incorporate and build on these shared-architectural pillars when designing, building, or supporting workloads that run within a landing zone.

## Landing zone definition

A _landing zone_ is a segment of a cloud environment, that has been preprovisioned through code, and is dedicated to the support of **one or more workloads**. Landing zones provide access to foundational tools and controls to establish a compliant place to innovate and build new workloads in the cloud, or to migrate existing workloads to the cloud. Landing zones use defined sets of cloud services and best practices to set you up for success.

More specifically, a landing zone is the basic building block of any cloud adoption environment. The term _landing zone_ refers to a logical construct that enables workloads to coexist on top of a _platform foundation_. Together, landing zones and the platform foundation capture everything that must be in place and ready to enable cloud adoption across the IT portfolio.

**Scope:** A fully functional landing zone considers all platform utilities that are required to support the customer's adoption needs.

**Refactoring:** A fully functional landing zone is the final deliverable of any iteration of the Cloud Adoption Framework's Ready methodology. During each iteration, the code base that defines the landing zone will be refactored or expanded. After refactoring, the landing zone may be modified or redeployed to allow for new cloud adoption needs.

**Goal:** The goal of the landing zone approach is to create a common set of consistent platform implementations that allow adoption teams to build on a centrally managed _platform foundation_. Those consistent implementations must be in place to ensure that your applications have access to requisite components when deployed. Consequently, each landing zone iteration must be designed and deployed in accordance with the requirements of the cloud adoption plan and the subscription design strategy.

**Principle purpose:** The principle purpose of the landing zone is to ensure that when an application lands in the cloud, that the required "plumbing" or other utilities are already in place.

**Benefits:** Together, landing zones and a common platform foundation create consistency in the _shared-architectural pillars_ of security, reliability, performance, cost, and cloud operations. This combination also reduces the overhead required to maintain operations, governance, and compliance across the IT portfolio. As adoption requirements grow, landing zones minimize the refactoring and deployment required to scale your adoption needs.

## Landing zone usage

Landing zones do not necessarily differentiate between IaaS or PaaS adoption. But landing zones are purpose built to support the adoption plan by fulfilling the subscription strategy. Supporting the adoption plan may require multiple landing zones with a mixture of required components.

The purpose and scope of the overall cloud adoption plan will define what "plumbing" is required. Additional governance, compliance, security, and operational management requirements will likely add to the initial landing zone scope. During early stages of adoption, landing zones may include less "plumbing" as a result of defined requirements and acceptable risks. When multiple landing zones exist, it is common for each landing zone to be dependent on hubs that provide the required controls through a shared service model.

## Decentralized operations

In some decentralized organizations, adoption designs call for workload teams that are **solely responsible** for their own implementation and operation of each isolated workload, including security, governance, operations management, and other functions. For those teams, a workload may have its own segregated environment, with no dependencies on a platform foundation. Those workload-specific environments would have inconsistent implementations of security, reliability, performance, cost, and cloud operations. As such they should not be referred to as landing zones. These teams should look to guidance from [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/framework/) to design, build, and optimize each workload independently.

> [!IMPORTANT]
> Similar but distinct: early in the cloud adoption lifecycle, smaller teams may perform like decentralized organizations due to necessity. If those teams are decentralized by circumstance (as opposed to decentralized by design), then the best practice of landing zone should still be followed.

## Portfolio hierarchy

Landing zones are one layer of the overall portfolio hierarchy as described in the prerequisites. The existence of landing zones is an indicator that the company is supporting a broader portfolio, with the help of various supporting teams, processes, and a centralized _platform foundation_. For more context on how landing zones fit into the bigger portfolio design, see the article on [portfolio hierarchy](../../reference/fundamental-concepts/hosting-hierarchy.md). For more information about products in Azure that can be used to manage the various layers of the portfolio hierarchy, see [Azure hierarchy support](../../reference/fundamental-concepts/hierarchy-azure-tools.md).

## Next steps

Before establishing your first landing zone, it is important to understand the [refactoring principles](./refactor.md) that guide this approach.

> [!div class="nextstepaction"]
> [Refactor landing zones](./refactor.md)
