---
title: Select Azure regions
description: Choose the right Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency.
author: stephen-sumner
ms.author: pnp
ms.date: 06/18/2025
ms.topic: conceptual
---

# Select Azure regions

This article helps you select the Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency. Proper region selection directly impacts workload availability, performance, and regulatory compliance. You must evaluate data sovereignty requirements, user proximity, and reliability needs to make informed regional deployment decisions.

## Define data requirements

Data sovereignty laws mandate where organizations store and process data based on customer locations and industry regulations. Organizations face legal penalties and compliance violations when data resides outside approved geographic boundaries. You need to identify your organization's data residency requirements and choose Azure regions in geographic locations that satisfy these compliance obligations. Here's how:

1. **Identify applicable data sovereignty laws.** Review the regulatory requirements for your industry and customer locations. Different sectors have specific mandates for data storage and processing locations that affect region selection.

1. **Map customer data to compliant regions.** Document where customer data originates and identify Azure regions that satisfy legal requirements for that data. Use this mapping to guide your regional deployment strategy.

1. **Validate region compliance capabilities.** Confirm that your selected Azure regions and preferred Azure services offer the necessary compliance certifications and data residency guarantees for your specific regulatory requirements. For more info, see [Data residency for Azure geographies and regions](https://azure.microsoft.com//explore/global-infrastructure/data-residency/).

## Choose regions close to your users

Geographic distance between users and Azure resources affects application performance and user experience through increased latency. Users expect fast response times regardless of their global location. You need to select Azure regions that minimize distance to your primary user to reduce latency and maximize application performance. Here's how:

1. **Map user and service locations.** Document where your users, on-premises systems, and external services are located geographically. Create a visual distribution map to identify proximity requirements and inform region selection decisions.

1. **Evaluate latency requirements.** Review [Azure network round-trip latency statistics](/azure/networking/azure-network-latency) to understand expected performance between regions and your geographic areas. Use these metrics to validate that your selected regions meet application performance requirements.

## Pick regions for reliability

Operational uptime depends on regional redundancy and disaster recovery capabilities during unexpected events or failures. Single-region deployments create single points of failure that can result in complete service outages. You need to select a region that supports your reliability requirements. Here's how:

1. **Prefer paired.** Choose regions [paired with another region](/azure/reliability/cross-region-replication-azure#azure-paired-regions) within the same geopolitical area. Paired regions provide automatic failover capabilities, geo-redundant storage replication, and coordinated maintenance schedules that enhance workload resilience.

1. **Ensure non-paired region reliability.** Nonparied regions rely on availability zones to provide reliability. Use all availability zones in a nonpaired region. This distribution protects against localized failures and maintains service availability during infrastructure maintenance. Implement cross-region backup strategies by storing recovery data in geographically separated regions. Use infrastructure as code templates to automate disaster recovery deployments and reduce recovery time objectives. Learn more about Azure region architecture in [What are Azure regions and availability zones?](/azure/reliability/availability-zones-overview).

## Review region capabilities

Different Azure regions have different capacity, quota, pricing, and available services. You already reviewed its data residency specifications. Now, You need to review the capabilities of each region before selecting.

1. **Ensure service availability in your region.** See [Azure products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

1. **Compare regional pricing.** Pricing of services differs across regions. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to compare costs. Identify lower-cost regions for noncritical workloads.

1. **Evaluate regional capacity.** For large environments, review [subscription constraints per region](/azure/azure-resource-manager/management/azure-subscription-service-limits) and capacity, especially for [virtual machines](/azure/virtual-machines/capacity-reservation-overview), in your shortlisted regions. To ensure it's available, test deploying an needed Azure service to that region. Contact Microsoft support if you anticipate high usage or need quota increases.

## Know when to use multiple regions

Relying on a single Azure region can limit your organization's ability to scale, meet compliance requirements, and deliver high-performance services globally. Use the same selection criteria when choosing other regions as you would for your primary region. Consider multi-region deployment in the following scenarios:

| Scenario | Why it matters | Implementation guidance |
|----------|----------------|------------------------|
| Support global users and distributed teams | Improve performance and user experience by reducing latency for users across continents. | Deploy services in regions closest to your users. Use Azure Front Door or Traffic Manager to route traffic to the nearest healthy endpoint. |
| Meet data residency and compliance requirements | To comply with legal and regulatory mandates, ensure data is stored and processed within specific geographic boundaries. | Choose regions that align with jurisdictional requirements. Use Azure Policy and Compliance Manager to enforce data residency rules. |
| Scale beyond regional capacity limits | Avoid hitting resource quotas or service limits in a single region. | Distribute workloads across multiple regions to balance demand and ensure availability. Monitor regional capacity trends using Azure Resource Graph. |
| Optimize for cost and resource efficiency | Take advantage of regional pricing differences and resource availability. | Run noncritical workloads (dev/test, batch jobs) in lower-cost regions. Use the Azure Pricing Calculator and Cost Management tools to evaluate options. |
| Enhance availability and disaster recovery | Increase resilience against regional outages or failures. | Implement active-active or active-passive architectures across regions. Use Azure Site Recovery and geo-redundant storage (GRS) for business continuity. |

For more workload design information, see [Regions and availability zones](/azure/well-architected/reliability/regions-availability-zones).

## Use Azure tools to evaluate regional options

| Category | Tool | Description |
|----------|------|-------------|
| Regional Planning | [Azure Geo Map](https://azure.microsoft.com/global-infrastructure/geographies/) | Interactive map that displays Azure region locations, capabilities, and compliance certifications to support regional planning decisions |
| Service Availability | [Products available by region](https://azure.microsoft.com/global-infrastructure/services/) | Comprehensive list of Azure services offered in each region to validate service availability for workload requirements |
| Cost Optimization | [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) | Cost comparison tool that evaluates regional pricing differences to optimize deployment expenses across regions |
| Performance Testing | [Azure Latency Test](https://www.azurespeed.com/Azure/Latency) | Network performance tool that measures latency between your location and Azure regions to validate performance requirements |

## Next steps

> [!div class="nextstepaction"]
> [Manage access](./manage-access.md)
