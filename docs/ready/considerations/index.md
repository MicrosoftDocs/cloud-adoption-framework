---
title: Azure landing zone considerations
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2019
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Landing zone considerations

Once a first landing zone has been deployed, it is important to evaluate the configuration based on lessons learned and the overall cloud adoption plan. This article expands on the definition, considerations, and components within a landing zone.

![Landing zone considerations](../../_images/ready/landing-zone-considerations.png)

This image shows the major considerations for implementing any landing zone deployment. The considerations can be broken into three categories or types of considerations: hosting, Azure fundamentals, and governance.

## Defining a landing zone

**Scope:** A landing zone is the basic building block of any cloud adoption environment. The term *landing zone* refers to a logical construct capturing everything that must be true to enable the desired cloud adoption. A fully functioning landing zone considers all platform resources that are required to support the customer’s adoption needs and does not necessarily differentiate between IaaS or PaaS adoption.

**Refactoring:** A functioning landing zone is the final deliverable of any iteration of the Cloud Adoption Framework's Ready methodology. During each iteration, the codebase which defines the landing zone will be refactored and/or expanded. After refactoring, the landing zone may be modified (or redeployed) allowing for new cloud adoption needs.

**Goal:** The goal of the landing zone approach is to create a common set of consistent platform implementations. Those consistent implementations must be in place to ensure that your applications have access to requisite components when deployed. Each landing zone iteration must consequently be designed and deployed in accordance with the requirements of the cloud adoption plan and the subscription design strategy.

**Principle purpose:** The principle purpose of the landing zone is therefore to ensure that when an application lands on Azure, the required "plumbing" is already in place. 

The purpose and scope of the overall cloud adoption plan will define what "plumbing" is required. Additional governance, compliance, security, and operational management requirements will likely add to the initial landing zone scope. During early stages of adoption, landing zones may include less "plumbing" as a result of defined requirements and acceptable risks. The following considerations outline the types of plumbing that are likely to be found in all landing zones.

> [!IMPORTANT]
> One example of an expanded principle purpose, is the [CAF Northstar](../../getting-started/northstar/index.md). The CAF NorthStar approach focuses on adoption teams who have mid-term objective (within 24 months) to more than 1,000 assets (apps, infra, or data assets) in the cloud. For those teams, the scope and principle purpose of landing zones is much richer, as seen in the [CAF Northstar architecture article](../../getting-started/northstar/architecture.md#landing-zone---expanded-definition).

## Hosting considerations

All landing zones provide structure for hosting options. The structure is created explicitly through governance controls or organically through the adoption of services within the landing zone. The following articles can help you make decisions that will be reflected in the automation scripts that create your landing zone:

- **[Compute decisions](./compute-options.md)**. To minimize operational complexity, align compute options with the purpose of the landing zone. This decision can be enforced by using automation toolchains, like Azure Policy initiatives.
- **[Storage decisions](./storage-options.md)**. Choose the right Azure Storage solution to support your workload requirements.
- **[Networking decisions](./networking-options.md)**. Choose networking services, tools, and architectures to support your organization's workload, governance, and connectivity requirements.
- **[Database decisions](./data-options.md)**. Determine which database technology is best suited for your workload requirements.

## Azure fundamentals

Each landing zone is part of a broader solution for organizing resources across a cloud environment. Azure fundamentals are the foundational building blocks for an organization.

- **[Azure fundamental concepts](./fundamental-concepts.md)**. Learn fundamental concepts and terms that are used to organize resources in Azure, and how the concepts relate to one another.
- **[Resource consistency decision guide](../../decision-guides/resource-consistency/index.md)**. When you understand each of the fundamentals, the resource organization decision guide can help you make decisions that shape the landing zone.

## Governance considerations

The Cloud Adoption Framework's Govern methodologies establish a process for governing the environment as a whole. However, there are many use cases that might require you to make governance decisions on a per landing zone basis. In many scenarios, governance baselines are enforced on a per landing zone basis, even though the baselines are established holistically. It's true for the first few landing zones that an organization deploys.

The following articles can help you make governance-related decisions about your landing zone. You can factor each decision into your governance baselines.

- **Cost requirements**. Based on an organization's motivation for cloud adoption and operational commitments made about its environment, various cost management configurations might need to be changed for the landing zone.
- **Monitoring decisions**. Depending on the operational requirements for a landing zone, various monitoring tools can be deployed. The monitoring decisions article can help you determine the most appropriate tools to deploy.
- **Using role-based access control**. Azure [role-based access control (RBAC)](../considerations/roles.md) offers fine-grained, group-based access management for resources that are organized around user roles.
- **Policy decisions**. [Azure Blueprints samples](https://docs.microsoft.com/azure/governance/blueprints/samples) provide premade compliance blueprints, each with predefined policy initiatives. Policy decisions help inform a selection of the best blueprint or policy initiative based on your requirements and constraints.
- **[Create hybrid cloud consistency](./hybrid-consistency.md)**. Create hybrid cloud solutions that give your organization the benefits of cloud innovation while maintaining many of the conveniences of on-premises management.
