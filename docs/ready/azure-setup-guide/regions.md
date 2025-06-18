---
title: Select Azure regions
description: Learn how to choose the right Azure regions for your workloads based on compliance, proximity, and resiliency requirements.
author: stephen-sumner
ms.author: pnp
ms.date: 06/18/2025
ms.topic: conceptual
---

# Select Azure regions

This article helps you choose the Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency. Azure offers numerous regions worldwide with distinct capabilities that directly impact your workload performance and availability.

## Comply with data sovereignty regulations

Understand your organization's data residency requirements and select Azure regions in geographic locations that satisfy these requirements. Determine which data sovereignty laws apply to your organization based on your customer locations and industry. Different industries have varying requirements for data storage and processing locations.

## Ensure proximity to users

Users and services that access your Azure resources exist in various global locations. Proximity affects performance and user experience. Select regions close to your users and systems to minimize latency and maximize throughput. Follow these steps:

1. **Map your user and service locations.** Identify where your users, on-premises systems, and external services are located. Create a geographic distribution map to visualize proximity requirements.

1. **Connect to on-premises systems efficiently.** If you use Azure ExpressRoute, select a region close to your on-premises systems to optimize network connectivity and reduce latency. Connections between Azure regions travel over Microsoft's high-speed global network.

1. **Evaluate latency requirements.** Review [Azure network round-trip latency statistics](/azure/networking/azure-network-latency) to understand expected performance between regions and other geographic areas.

## Ensure reliability

Reliability ensures workloads remain operational during unexpected events or failures. Use Azure's paired regions and availability zones to enhance resiliency and maintain high availability. Follow these steps:

1. **Select paired regions for resiliency.** Choose regions that are [paired with another region](/azure/reliability/cross-region-replication-azure#azure-paired-regions) within the same geopolitical area. Paired regions enhance reliability by supporting geo-redundant storage (GRS) replication and providing failover capabilities during catastrophic events.

1. **Deploy backups in a secondary region.** For regions without pairing, distribute workloads across all availability zones to improve resiliency. Store backups in a secondary region and use infrastructure as code to automate disaster recovery deployments. Learn more about Azure region architecture in [What are Azure regions and availability zones?](/azure/reliability/availability-zones-overview).

## Use multiple regions in your Azure environment

Consider deploying resources across multiple regions when your organization needs to support global operations, meet regulatory requirements, or build a resilient and scalable infrastructure. Here are key scenarios where using multiple regions is recommended:

| Scenario | Implementation |
|----------|----------------|
| **Ensure high availability and disaster recovery.** | Deploy workloads across multiple regions to protect your services from regional outages and natural disasters. Use Azure paired regions and services like Azure Site Recovery and geo-redundant storage (GRS) to enable failover and business continuity. |
| **Support global users and distributed teams.** Deploy resources in multiple regions to reduce latency and improve performance when your users or teams span continents. | Use Azure Front Door or Traffic Manager to route users to the nearest regional instance for optimal performance. |
| **Meet data residency and compliance requirements.** | Deploy across multiple regions to store and process data within specific geographic boundaries as mandated by industries and jurisdictions. Multiple regions allow you to comply with regulations while maintaining centralized management and control. |
| **Scale beyond regional capacity limits.** | Distribute workloads across regions to avoid resource quotas and capacity constraints that exist in each Azure region. Multiple regions help you avoid hitting limits and support continued growth without service disruption. |
| **Optimize for cost and resource efficiency.** | Use regional pricing differences to reduce operational costs for your workloads. Run non-critical workloads such as development, testing, or batch processing in lower-cost regions. Use the Azure Pricing Calculator to compare regional pricing. |
| **Avoid capacity constraints.** | Deploy workloads in alternate regions when you encounter temporary capacity limitations in your primary region. Multiple regions provide flexibility to find available resources for your workloads when capacity issues arise. |

For more information, see [Regions and availability zones](/azure/well-architected/reliability/regions-availability-zones).

## Regional selection tools

| Category | Tool | Description |
|----------|------|-------------|
| Regional Planning | [Azure Geo Map](https://azure.microsoft.com/global-infrastructure/geographies/) | Interactive map showing Azure region locations and capabilities |
| Service Availability | [Products available by region](https://azure.microsoft.com/global-infrastructure/services/) | Complete list of services offered in each Azure region |
| Cost Management | [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) | Comparison tool for regional price differences |
| Performance | [Azure Latency Test](https://www.azurespeed.com/Azure/Latency) | Tool to measure latency between regions and your location |

## Next steps

> [!div class="nextstepaction"]
> [Manage access](../../)
