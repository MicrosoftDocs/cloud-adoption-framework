---
title: Select Azure regions
description: Choose the right Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency.
author: stephen-sumner
ms.author: pnp
ms.date: 06/18/2025
ms.topic: conceptual
---

# Select Azure regions

This article helps you select Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency. Proper region selection directly impacts workload availability, performance, and regulatory compliance. You must evaluate data sovereignty requirements, user proximity, and reliability needs to make informed regional deployment decisions.

## Define data requirements

Identify data residency requirements to ensure compliance with legal and industry regulations. This step prevents violations and ensures data is stored in approved geographic locations. To achieve this, you must map data origins, review laws, and validate region capabilities.

1. **Identify applicable data sovereignty laws.** Review regulatory requirements for your industry and customer locations. Different sectors mandate specific data storage and processing locations.
2. **Map customer data to compliant regions.** Document data origins and identify Azure regions that satisfy legal requirements. Use this mapping to guide deployment strategy.
3. **Validate region compliance capabilities.** Confirm selected Azure regions and services meet compliance certifications and residency guarantees. See [Data residency for Azure geographies and regions](https://azure.microsoft.com/explore/global-infrastructure/data-residency/).

## Choose regions close to your users

Select Azure regions near your users to reduce latency and improve application performance. This step ensures fast response times and enhances user experience. To achieve this, you must map user locations and evaluate latency metrics.

1. **Map user and service locations.** Document user, on-premises systems, and external service locations. Create a visual map to identify proximity requirements.
2. **Evaluate latency requirements.** Review [Azure network round-trip latency statistics](/azure/networking/azure-network-latency) to validate performance between regions and user areas.

## Pick regions for reliability

Select regions that support redundancy and disaster recovery to ensure workload availability. This step prevents outages and enhances resilience. To achieve this, you must choose paired regions and configure availability zones.

1. **Prefer paired regions.** Choose regions [paired with another region](/azure/reliability/cross-region-replication-azure#azure-paired-regions) for failover capabilities and geo-redundant storage.
2. **Ensure non-paired region reliability.** Use availability zones in non-paired regions to protect against localized failures. Implement cross-region backup strategies and automate disaster recovery deployments.

## Review region capabilities

Evaluate region capabilities to ensure they meet workload requirements. This step prevents deployment constraints and optimizes resource allocation. To achieve this, you must verify service availability, compare pricing, and assess capacity.

1. **Ensure service availability in your region.** See [Azure products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).
2. **Compare regional pricing.** Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to evaluate costs and identify lower-cost regions for noncritical workloads.
3. **Evaluate regional capacity.** Review [subscription constraints per region](/azure/azure-resource-manager/management/azure-subscription-service-limits) and test deployments to ensure availability. Contact Microsoft support for quota increases if needed.

## Use multiple regions for global scale

Deploy workloads across multiple regions to scale globally and meet compliance requirements. This step enhances performance, availability, and cost efficiency. To achieve this, you must distribute workloads and implement global traffic management.

| Scenario | Why it matters | Implementation guidance |
|----------|----------------|------------------------|
| Support global users and distributed teams | Improve performance and user experience by reducing latency for users across continents. | Deploy services in regions closest to your users. Use Azure Front Door or Traffic Manager to route traffic to the nearest healthy endpoint. |
| Meet data residency and compliance requirements | Comply with legal mandates by storing and processing data within specific geographic boundaries. | Choose regions that align with jurisdictional requirements. Use Azure Policy and Compliance Manager to enforce data residency rules. |
| Scale beyond regional capacity limits | Avoid hitting resource quotas or service limits in a single region. | Distribute workloads across multiple regions to balance demand and ensure availability. Monitor regional capacity trends using Azure Resource Graph. |
| Optimize for cost and resource efficiency | Take advantage of regional pricing differences and resource availability. | Run noncritical workloads (dev/test, batch jobs) in lower-cost regions. Use the Azure Pricing Calculator and Cost Management tools to evaluate options. |
| Enhance availability and disaster recovery | Increase resilience against regional outages or failures. | Implement active-active or active-passive architectures across regions. Use Azure Site Recovery and geo-redundant storage (GRS) for business continuity. |

For more workload design information, see [Regions and availability zones](/azure/well-architected/reliability/regions-availability-zones).

## Use Azure tools to evaluate regional options

| Category | Tool | Description |
|----------|------|-------------|
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
> [Manage access](../../)
