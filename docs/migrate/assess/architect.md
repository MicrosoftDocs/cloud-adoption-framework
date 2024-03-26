---
title: Design a workload architecture before migration
description: Learn how to use the Azure Cloud Adoption Framework to define your cloud architecture before you begin migration.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/15/2024
ms.topic: conceptual
---

# Design a workload architecture before migration

This article describes the process of designing a workload's migrated state in the cloud. It helps you review activities that are associated with defining the workload's architecture within a specific iteration.

As described in the article on [incremental rationalization](../../digital-estate/rationalize.md), some architectural assumptions are made during any business transformation that requires a migration. This article clarifies those assumptions. It shares a few roadblocks that you can avoid, and it identifies opportunities to accelerate business value by challenging architectural assumptions. This incremental model for architecture helps teams move faster and obtain business outcomes sooner.

## Guidelines for planning your architecture

The following assumptions are typical for any migration effort:

- **Assume that an infrastructure as a service (IaaS) workload**. Migrating workloads primarily involves moving servers from a physical datacenter to a cloud datacenter via an IaaS migration. The process typically requires a minimum of redevelopment or reconfiguration. This approach is known as a _lift and shift_ migration.
- **Keep the architecture consistent**. Making changes to core architecture during a migration considerably increase complexity. Debugging a changed system on a new platform introduces many variables that can be difficult to isolate. Workloads should undergo only minor changes during migration, and any changes should be thoroughly tested.
- **Plan to resize assets**. Assume that few on-premises assets fully use any resource. Before or during migration, assets are resized to best fit actual usage requirements. Tools like Azure Migrate and Modernize provide sizing based on actual use.
- **Capture business continuity and disaster recovery (BCDR) requirements**. If you have an agreed-on service-level agreement (SLA) for the workload negotiated with the business, continue to use the SLA after the migration to Azure. If an SLA isn't already set, define one before you design the workload in the cloud to make sure you design appropriately.
- **Plan for migration downtime**. Similar to SLA, downtime to promote the workload to production can have an adverse effect on the business. Sometimes the solutions that must transition with minimum downtime need architecture changes. Before you begin release planning, assume that a general understanding of downtime requirements is established.
- **Define user and application traffic patterns**. Existing solutions might depend on existing network routing patterns and solutions. Identify the resources that you need to support them.
- **Plan to avoid network conflicts**. When you consolidate datacenters into a single cloud provider, you're likely to create network, DNS, or other conflicts. During migration, it's important to design to avoid these conflicts to avoid interruptions to production systems that are hosted in the cloud.
- **Plan for routing tables**. Make sure that your project includes a plan for modifying routing tables if you consolidate networks or datacenters. Consider cross-datacenter routing requirements.

### Architecture design in a landing zone

In the [Ready](../../ready/index.md) phase of the Cloud Adoption Framework, your organization deployed shared platform services as part of adopting [Azure landing zones](../../ready/landing-zone/index.md). In [Ready your landing zone for migration](../prepare/ready-azure-landing-zone.md), you prepared the landing zone to receive migrated workloads.

Because you finished this planning, you can assume that the following migration components are in place:

- Hybrid connectivity connects your Azure networks to your on-premises networks.
- Network security appliances like Azure Firewall handle inspection of traffic outside your workload.
- Azure policies to enforce governance practices like logging requirements, allowed regions, disallowed services, and other controls are active.
- A Log Analytics workspace is set up in Azure Monitor for shared logging.
- Shared identity resources to support domain-joined servers or other identity needs are established.

If these migration essentials aren't available, your organization should immediately revisit the Ready phase to address these needs. Without these components, your migration likely will have delays and setbacks and be less successful.

The workload that you're designing has a subscription assigned to it, ideally through a [subscription vending process](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending). The subscription might contain several workloads or just one depending on how your organization completed its [resource organization for workloads](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions). If you migrate a workload that has many application environments, you might even have multiple subscriptions based on [application environments guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments).

### Workload network architecture design

You should plan to deploy application-specific resources to a specific subscription, and plan to design a dedicated virtual network for the workload. For more information, see guidance for [designing your networking architecture](/azure/architecture/guide/networking/networking-start-here). You should especially focus on [segmenting virtual networks](/azure/architecture/reference-architectures/hybrid-networking/network-level-segmentation).

Your network likely needs resources like load balancers and other application-delivery resources. You can use the [N-tier architecture guide](/azure/architecture/guide/architecture-styles/n-tier) to plan these resources in Azure.

### Workload dependencies design

Your assessment tools should give you a way to perform dependency analysis, like [dependency analysis](/azure/migrate/concepts-dependency-visualization) in Azure Migrate and Modernize. The tool helps you identify interdependencies between servers.

In addition to planning architecture for the workload itself, you might need to consider workload-to-workload dependencies. For example, some workloads might need frequent communication. If so, planning your migration waves and dependencies to account for this requirement helps make your migration successful.

You can use guidance in the architecture center, such as for [spoke-to-spoke](/azure/architecture/networking/spoke-to-spoke-networking) networking, to design how interconnected workloads work after migration.

## Updating your initial cloud estimate

As you complete your architecture, you should revisit your cloud estimate to make sure that you're still within the planned budget. As you add supporting services like load balancers or backups, the cost can change. Although you can use tools like [Azure Migrate business cases](/azure/migrate/concepts-business-case-calculation) to do detailed cost management exercises, you should periodically revisit your estimates as you adjust your architecture design.

If you're familiar with traditional IT procurement processes, estimating resources in the cloud might seem foreign. When you adopt cloud technologies, acquisition shifts from a rigid, structured capital expense model to a fluid operating expense model. Planning a migration to the cloud often is the first time an organization or IT team encounters this change.

In the traditional capital expense model, an IT team would attempt to combine buying power for multiple workloads across various programs. This approach centralizes a pool of shared IT assets that can support each of those solutions. In the operating expense cloud model, costs can be directly attributed to the support needs of individual workloads, teams, or business units. This approach gives an organization a more direct attribution of costs to each supported internal customer.

This more dynamic approach to financial management is often referred to as financial operations (FinOps). Although FinOps isn't an Azure-specific consideration, it can be helpful to have an expanded understanding of FinOps. For more information, see [What is FinOps?](/azure/cost-management-billing/finops/overview-finops).

When you design your workload architecture for migration, you can use the [pricing calculator](https://azure.microsoft.com/pricing/calculator/) with your assessment information to understand the price of the entire workload.

Also, after your workload is migrated, you should continue to work to optimize workload costs. For more information on how organizations can mature their cost management skills, see  See [Improve the cost management discipline](/azure/cloud-adoption-framework/govern/guides/standard/cost-management-improvement).

## When to change your architecture

Migrations tend to be focused on maintaining the existing architecture and transitioning it to your cloud platform. However, there are times that you might need to rearchitect your workload even for migration. This list gives examples of when you might need to make architectural changes before you migrate:

- **Paying for technical debt**. Some aging workloads carry a high amount of technical debt. Technical debt can lead to long-term challenges by increasing hosting costs with any cloud provider. When technical debt unnaturally increases hosting costs, alternative architectures should be evaluated.
- **Improving reliability**. Standard operation baselines provide a degree of reliability and recovery in the cloud. Some workload teams might require higher SLAs, which could lead to architectural changes.
- **High-cost workloads**. During migration, you should optimize all assets to align sizing with actual usage. Some workloads might require architectural modifications to address specific cost concerns.
- **Performance requirements**. When workload performance directly affects business, extra architectural consideration might be required.
- **Secure applications**. Security requirements tend to be implemented centrally and applied to all workloads in a portfolio. Some workloads might have specific security requirements that can lead to architectural changes.

Each of these criteria serves as an indicator of a potential migration roadblock. In most cases, you can address the criterion after you migrate the workload by right-sizing servers, adding new servers, or making other changes. However, if any of those criteria are required before you migrate a workload, remove the workload from the migration wave and evaluate it individually.

The [Azure Well-Architected Framework](/azure/architecture/framework/) and the [Azure Well-Architected Review](/assessments/?id=azure-architecture-review) can help guide those conversations with the technical owner of a specific workload to help them consider alternative options for deploying the workload.

The workload is then classified as a rearchitecture or modernization effort in your cloud adoption plan. Because of the extra time that is required to rearchitect a workload, consider these alternative workload adoption paths separate from the migration process.

## Architecture checklist

You can use the following checklist to make sure you cover critical architectural considerations:

- Confirm that your architecture meets your SLAs for availability, disaster recovery, and data recovery.
- Confirm that you applied network segmentation practices to your network design.
- Confirm that you planned for monitoring and log capturing.
- Confirm that your VMs are sized appropriately for the actual compute you need.
- Confirm that your disks are sized appropriately for the actual size and performance you need.
- Confirm that you planned for any load balancing services. The services might include instances of Azure Load Balancer, Azure Application Gateway, Azure Front Door, or Azure Traffic Manager.

## Next step

> [!div class="nextstepaction"]
> [Deploy workloads](../deploy/index.md)
