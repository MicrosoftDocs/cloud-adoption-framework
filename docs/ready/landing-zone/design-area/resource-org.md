---
title: Resource organization design area overview
description: See an overview of the resource organization design area for cloud deployments.
author: DominicAllen
ms.author: doalle
ms.date: 12/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Resource organization

The critical resource organization design area establishes consistent patterns for organizing resources deployed to the cloud.

## Design area review

**Involved roles or functions:** This design area probably requires support from one or more [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) functions to make and implement decisions.

**Scope:** Resource organization decisions are a foundation for all compliance-related design areas. The goal of resource organization planning is to establish consistent patterns for:

- Naming
- Tagging
- Subscription design
- Management group design

The initial scope of this exercise assumes a subscription design that aligns with the Azure landing zone conceptual architecture. Workload- or application-level subscription and landing zone assignment supports separation of duties and subscription democratization requirements.

**Out of scope:** Alternative subscription design patterns are out of scope for this discussion. For alternative subscription design patterns, see [Subscription design patterns](../../../decision-guides/subscriptions/index.md).

The following assumptions are the basis for workload subscription design pattern guidance:

- Your enterprise is committed to long-term cloud operations.
- You need cloud management, security, and governance tooling to manage Azure, hybrid, or multicloud solutions.
- Management or platform deployments are in separate subscriptions and management groups from workload or application resources.

To start your cloud journey with a small set of subscriptions, see [Create your initial Azure subscriptions](../../azure-best-practices/initial-subscriptions.md).

## Design area overview

Cloud adoption journeys have varying starting points and scale requirements. Some enterprises start with a few applications in the cloud and grow over time. Other enterprises must scale quickly to address business demands like a datacenter migration. In either scenario, resource organization planning should include environment growth to accommodate further applications and services.

A key consideration for resource organization design is to simplify management across the environment for increased workload numbers and scale. Enterprise landing zone design and implementation should consider foundational management group and subscription structure, to avoid creating scaling constraints later.

The resource organization design area explores techniques and technologies that help maintain good resource topologies in cloud environments. The following diagram shows the four scope levels for organizing Azure resources: management groups, subscriptions, resource groups, and resources.

![Diagram that shows the four scope levels for organizing Azure resources.](../../azure-setup-guide/media/organize-resources/scope-levels.png)

## Next steps

Explore the guidance further in the following two sections:

- [Management groups](./resource-org-management-groups.md)
- [Subscriptions](./resource-org-subscriptions.md)
