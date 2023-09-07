---
title: Resource organization design area overview
description: See an overview of the resource organization design area for cloud deployments.
author: martinekuan
ms.author: martinek
ms.date: 06/22/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Resource organization

The critical resource organization design area establishes consistent patterns for organizing resources deployed to the cloud.

## Design area review

**Involved roles or functions:** This design area probably requires support from one or more [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) functions to make and implement decisions.

**Scope:** Resource organization decisions are a foundation for all compliance-related design areas. The goal of resource organization planning is to establish consistent patterns for the following areas:

- Naming
- Tagging
- Subscription design
- Management group design

The initial scope of this exercise assumes a subscription design that aligns with the Azure landing zone conceptual architecture. Workload- or application-level subscription and landing zone assignment supports separation of duties and subscription democratization requirements.

The following assumptions are the basis for workload subscription design pattern guidance:

- Your enterprise is committed to long-term cloud operations.
- You need cloud management, security, and governance tooling to manage Azure, hybrid, or multicloud solutions.
- Management or platform deployments are in separate subscriptions and management groups from workload or application resources.

**New cloud environment:** To start your cloud journey with a small set of subscriptions, see [Create your initial Azure subscriptions](../../azure-best-practices/initial-subscriptions.md).

**Existing cloud environment:** Consider the following if you are interested in applying the principles from the resource organization design area to existing Azure environments:

- If your current environment does not use management groups, consider them. Management groups are key to managing policies, access, and compliance across subscriptions at scale. [Management groups](resource-org-management-groups.md) can help guide your implementation.
- If your current environment does use management groups, consider using the guidance in [management groups](resource-org-management-groups.md) when evaluating your implementation.
- If you have existing subscriptions in your current environment, consider using the guidance in [subscriptions](resource-org-subscriptions.md) to see if you are using them effectively. Subscriptions act as policy and management boundaries and are scale units.
- If you have existing resources in your current environment, consider using the guidance in [naming and tagging](../../azure-best-practices/naming-and-tagging.md) to influence your tagging strategy and your naming conventions going forward.
- [Azure Policy](/azure/azure-resource-manager/management/tag-policies) is useful in establishing and enforcing consistency with regard to taxonomic tags.

## Design area overview

Cloud adoption journeys have varying starting points and scale requirements. Some enterprises start with a few applications in the cloud and grow over time. Other enterprises must scale quickly to address business demands like a datacenter migration. In either scenario, resource organization planning should include environment growth to accommodate further applications and services.

A key consideration for resource organization design is to simplify management across the environment for increased workload numbers and scale. Azure landing zone design and implementation should consider foundational management group and subscription structure, to avoid creating scaling constraints later.

The resource organization design area explores techniques and technologies that help maintain good resource topologies in cloud environments. The following diagram shows the four scope levels for organizing Azure resources: management groups, subscriptions, resource groups, and resources.

![Diagram that shows the four scope levels for organizing Azure resources.](../../azure-setup-guide/media/organize-resources/scope-levels.png)

## Next steps

Explore the guidance further in the following two sections:

- [Management groups](./resource-org-management-groups.md)
- [Subscriptions](./resource-org-subscriptions.md)
