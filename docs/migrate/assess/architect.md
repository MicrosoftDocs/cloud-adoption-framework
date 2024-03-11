---
title: Design workload architectures before migration
description: Use the Cloud Adoption Framework for Azure to learn how to define the new architecture before cloud migration begins.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/04/2024
ms.topic: conceptual
---

# Design workload architectures before migration

This article describes the process of designing a workload's migrated state in the Cloud. It helps you review activities associated with defining the workload's architecture within a given iteration. As discussed in the article on [incremental rationalization](../../digital-estate/rationalize.md), some architectural assumptions are made during any business transformation that requires a migration.

This article clarifies those assumptions. It shares a few roadblocks that can be avoided and identifies opportunities to accelerate business value by challenging those assumptions. This incremental model for architecture allows teams to move faster and to obtain business outcomes sooner.

## Guidelines for planning your architecture

The following assumptions are typical for any migration effort:

- **Assume the workload will be IaaS**. Migrating workloads primarily involves moving servers from a physical datacenter to a cloud datacenter via an IaaS migration. This process typically requires a minimum of redevelopment or reconfiguration. This approach is known as a _lift and shift_ migration.
- **Keep the architecture consistent**. Changes to core architecture during a migration considerably increase complexity. Debugging a changed system on a new platform introduces many variables that can be difficult to isolate. For this reason, workloads should undergo only minor changes during migration and any changes should be thoroughly tested.
- **Plan to resize assets**. Assume few on-premises assets are fully using the given resources. Before or during migration, assets are resized to best fit actual usage requirements. Tools like Azure Migrate will provide sizing based on actual use.
- **Capture business continuity and disaster recovery (BCDR) requirements**. If you have an agreed-on SLA for the workload that has been negotiated with the business, continue to use it after the migration to Azure. If there isn't one, define it prior to designing the workload in the cloud to make sure you're designing appropriately.
- **Plan for migration downtime.** Likewise, downtime to promote the workload to production can have an adverse effect on the business. Sometimes, the solutions that must transition with minimum downtime need architecture changes. Assume that a general understanding of downtime requirements has been established before release planning.
- **Define User and application traffic patterns.** Existing solutions might depend on existing network routing patterns and solutions that exist. Identify the resources that you need to support these.
- **Plan to avoid network conflicts**: When you're consolidating datacenters into a single cloud provider, you're likely to create network, DNS, or other conflicts. During migration, it's important to design to avoid these conflicts to avoid interruptions to production systems hosted in the cloud.
- **Plan for routing tables**: Make sure your project have a plan for modifying routing tables when consolidating networks or datacenters. Consider cross-datacenter routing requirements.

### Architecture design in a landing zone

In the [Ready](../../ready/index.md) phase of the Cloud Adoption Framework, your organization should have deployed shared platform services as part of adopting [Azure landing zones](../../ready/landing-zone/index.md).

In the [Readying your landing zone for migration](../prepare/ready-alz.md), you'll have prepared the landing zone to receive migrated workloads. Because of this, you can assume that the following is in place:

- Hybrid connectivity connecting to your Azure networks to your on-premises networks.
- Network security appliances like Azure Firewall to handle inspection of traffic outside of your workload.
- Azure policies to enforce governance practices, such as logging requirements, allowed regions, disallowed services, and other controls.
- An Azure Log Analytics Workspace to use for shared logging.
- Shared identity resources to support domain joined servers or other identity needs.

If these aren't available, your organization should immediately revisit the ready phase to address these needs. Without them, your migration will likely suffer delays and setbacks and might not be able to be successful.

The workload that you're designing will have a subscription assigned to it, ideally through a [subscription vending process](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending). This subscription might contain several workloads, or just one, depending on how your organization has performed its [resource organization for workloads](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions). If you're migrating a workload with many application environments, you might even have multiple subscriptions based on the [application environments guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments).

### Workload network architecture design

You should plan for deploying out your application specific resources into a specific subscription, and design a dedicated virtual network for the workload. For more information, see [networking architecture design](/azure/architecture/guide/networking/networking-start-here) guidance. You should especially focus on [segmenting virtual networks](/azure/architecture/reference-architectures/hybrid-networking/network-level-segmentation).

Your network likely need resources such as load balancers and other application delivery resources. You can use the [N-tier architecture guide](/azure/architecture/guide/architecture-styles/n-tier) to plan this in Azure.

### Workload dependencies design

Your assessment tools should give you a way to perform dependency analysis, such as Azure Migrate's [dependency analysis](/azure/migrate/concepts-dependency-visualization). This lets you identify interdependencies between servers.

In addition to planning architecture for the workload itself, you might need to consider workload to workload dependencies. For example, some workloads might need frequent communication to operate. If so, planning your migration waves and dependencies to take this under consideration will help your migrations be more successful.

You can use guidance in the architecture center, such as [spoke-to-spoke](/azure/architecture/networking/spoke-to-spoke-networking) networking to build designs for how interconnected workloads will work after migration.

## Updating your initial cloud estimate

As you complete your architecture, you should revisit your cloud estimate to make sure that you're still within the planned budget. As you add supporting services like load balancers or backups, the cost can change. While tools like [Azure Migrate business cases](/azure/migrate/concepts-business-case-calculation) can be used to perform detailed cost management exercises, you should periodically revisit these as you adjust your architecture.

If you're familiar with traditional Information Technology (IT) procurement processes, estimation in the cloud might seem foreign. When adopting cloud technologies, acquisition shifts from a rigid, structured capital expense model to a fluid operating expense model. Migrations are often the first time that customers encounter this change in practice.

In the traditional capital expense model, the IT team would attempt to combine buying power for multiple workloads across various programs, which centralizes a pool of shared IT assets that could support each of those solutions. In the operating expenses cloud model, costs can be directly attributed to the support needs of individual workloads, teams, or business units. This approach allows for a more direct attribution of costs to the supported internal customer.

This more dynamic approach to financial management is often referred to as FinOps. While not an Azure specific consideration, you can learn more about FinOps. See [What is FinOps?](/azure/cost-management-billing/finops/overview-finops).

When designing your workload architecture for migration, you can use the [Pricing calculator](https://azure.microsoft.com/pricing/calculator/) along with your assessment information to understand the price of the whole workload.

Also, once your workload has been migrated, you should continue to work to optimize its costs. See [Improve the cost management discipline](/azure/cloud-adoption-framework/govern/guides/standard/cost-management-improvement) for more information on how organizations can mature their cost management skills.

## Knowing when to change your architecture

Migrations tend to be focused on maintaining the existing architecture but transitioning to your cloud platform. However, there are times that you might need to rearchitect your workload even for migration. This list gives examples of when you might need to make architectural changes:

- **Paying for technical debt**. Some aging workloads carry with them a high amount of technical debt. Technical debt can lead to long-term challenges by increasing hosting costs with any cloud provider. When technical debt unnaturally increases hosting costs, alternative architectures should be evaluated.
- **Improving reliability**. Standard operations baselines provide a degree of reliability and recovery in the cloud. Some workload teams might require higher SLAs, which could lead to architectural changes.
- **High-cost workloads**. During migration, all assets should be optimized to align sizing with actual usage. Some workloads might require architectural modifications to address specific cost concerns.
- **Performance requirements**. When workload performance directly affects business, extra architectural consideration might be required.
- **Secure applications**. Security requirements tend to be implemented centrally and applied to all workloads in the portfolio. Some workloads might have specific security requirements that could lead to architectural changes.

Each of the above criteria serves as indicators of potential migration roadblocks if not addressed. In most cases, you can address this after the workload has been migrated by right sizing servers, adding new servers, or making other changes. However, if any of those criteria are required before you migrate a workload, remove the workload from the migration wave and evaluate it individually.

[The Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) and [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review) can help guide those conversations with the technical owner of a specific workload to consider alternative options for deploying the workload. Those workloads would then be classified as a rearchitecture or modernization effort in your cloud adoption plan. Given the extra time that's required to rearchitect a workload, these alternative workload adoption paths shouldn't be considered part of the migration process.

## Architecture checklist

You can use the following checklist to make sure you're covering critical architectural considerations:

- Confirm your SLAs for availability, disaster recovery, and data recovery are met by your architecture.
- Confirm that you have applied network segmentation practices to your network design.
- Confirm that you have planned for monitoring and log capturing.
- Confirm that you have your VMs sized appropriately for the actual compute needed.
- Confirm that you have your disks sized appropriately for the actual size and performance needed.
- Confirm that you have planned for any load balancing services, like Azure load balancers, Application Gateways, Azure Front Door, or Azure Traffic Manager.

## Next steps

> [!div class="nextstepaction"]
> [Deploy workloads](../deploy/index.md)
