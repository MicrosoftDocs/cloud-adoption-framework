---
title: Resource organization design area overview
description: See an overview of the resource organization design area for cloud deployments.
author: Zimmergren
ms.author: pnp
ms.date: 02/27/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Resource organization

Use the resource organization design area to establish consistent patterns when you organize resources that you deploy to the cloud.

## Design area review

**Involved roles or functions:** This design area requires support from one or more [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) functions to make and implement decisions.

**Scope:** Resource organization decisions provide a foundation for all compliance-related design areas. When you plan your resource organization, you can establish consistent patterns for the following areas:

- Naming
- Tagging
- Subscription design
- Management group design

The initial scope of this exercise assumes a subscription design that aligns with the Azure landing zone conceptual architecture. Workload-level or application-level subscription and landing zone assignment supports separation of duties and subscription democratization requirements.

The following assumptions are the basis for workload subscription design pattern guidance:

- Your enterprise commits to long-term cloud operations.

- You need cloud management, security, and governance tooling to manage Azure, hybrid, or multicloud solutions.
- You have management or platform deployments in subscriptions and management groups that are separate from workload or application resources.

**Multiple regions:** The performance, reliability, and compliance of your cloud-based applications rely on Azure regions. Use the Azure global infrastructure to scale your applications when you need to. Regions provide the capacity to handle varying workloads. Whether you launch a new product or expand your user base, you must have the right resources in the right region to ensure agility, scalability, and high resiliency.

Use multiple regions for critical applications and services that require geo-disaster recovery capabilities. Multiple regions provide maximum resiliency. For information about how to select and operate in multiple regions, see [Select Azure regions](/azure/cloud-adoption-framework/ready/considerations/regions).

Also consider the following factors when you deploy your workload in multiple regions:

- You can initially deploy in a single region and then expand to [multiple regions](../../considerations/regions.md) in the future.

- To ensure consistency and manageability, properly organize resources when you adopt a multiregion design.  
- Depending on your requirements and desired governance model, you can organize multiregion resources at various levels, such as the [management group](resource-org-management-groups.md), [subscription and resource group](resource-org-subscriptions.md), [naming convention](../../azure-best-practices/resource-naming.md), and [tagging](../../azure-best-practices/resource-tagging.md) levels.

**New cloud environment:** Start your cloud journey with a small set of subscriptions. For more information, see [Create your initial Azure subscriptions](../../azure-best-practices/initial-subscriptions.md).

**Existing cloud environment:** If you have an existing cloud environment, consider the following guidance:

- If your current environment doesn't use [management groups](resource-org-management-groups.md), consider incorporating them. You can use management groups to manage policies, access, and compliance across subscriptions at scale.

- If your current environment uses management groups, see [Management groups](resource-org-management-groups.md). Use this guidance to help evaluate your implementation.
- If you have existing subscriptions in your current environment, ensure that you use them effectively. Subscriptions act as policy and management boundaries and scale units. For more information, see [Subscriptions](resource-org-subscriptions.md).
- If you have existing resources in your current environment, see [Define a naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) and [tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging). Use this guidance to influence your tagging strategy and your naming conventions going forward.
- Use [Azure Policy](/azure/azure-resource-manager/management/tag-policies) to establish and enforce consistency with taxonomic tags.

## Design area overview

Cloud adoption journeys have various starting points and scale requirements. Some enterprises start with a few applications in the cloud and grow over time. Other enterprises must scale quickly to address business demands like a datacenter migration. In both scenarios, when you plan your resource organization, you must factor in environment growth to accommodate more applications and services.

Simplify resource management across your environment to prepare for increased workload numbers and scale. Consider the foundational management groups and the subscription structure in your Azure landing zone design and implementation. Plan in advance to prevent future scaling constraints.

The resource organization design area explores techniques and technologies that help maintain proper resource topologies in cloud environments. The following diagram shows the four scope levels to organize Azure resources: management groups, subscriptions, resource groups, and resources.

![Diagram that shows the four scope levels for organizing Azure resources.](../../azure-setup-guide/media/organize-resources/scope-levels.png)

## Next steps

- [Management groups](./resource-org-management-groups.md)
- [Subscriptions](./resource-org-subscriptions.md)
