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

1. **Map customer data to compliant regions.** Document where customer data comes from and identify Azure regions that satisfy legal requirements for that data. Use this mapping to guide your regional deployment strategy.

1. **Validate region compliance capabilities.** Confirm that your selected Azure regions and preferred Azure services offer the necessary compliance certifications and data residency guarantees for your specific regulatory requirements. For more info, see [Data residency for Azure geographies and regions](https://azure.microsoft.com//explore/global-infrastructure/data-residency/).

## Choose regions close to your users

Geographic distance between users and Azure resources affects application performance and user experience through increased latency. Users expect fast response times regardless of their global location. You need to select Azure regions that minimize distance to your primary user to reduce latency and maximize application performance. Here's how:

1. **Map user and service locations.** Document where your users, on-premises systems, and external services are located geographically. Create a visual distribution map to identify proximity requirements and inform region selection decisions.

1. **Evaluate latency requirements.** Review [Azure network round-trip latency statistics](/azure/networking/azure-network-latency) to understand expected performance between regions and your geographic areas. Use these metrics to validate that your selected regions meet application performance requirements.

## Validate region capabilities

Azure regions offer different service availability, pricing models, and infrastructure features that affect workload performance and cost. You need to verify that your selected regions provide the necessary services, capacity, and infrastructure features for your specific requirements. Here's how:

1. **Confirm service availability in your target region.** Service availability varies between Azure regions. You must verify that all required Azure services are available in your selected regions before finalizing deployment plans. To confirm service availability for your target regions, see [Azure products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

1. **Compare pricing across regions.** Service pricing differs between Azure regions. You should evaluate pricing differences between regions to optimize costs and identify opportunities for savings, especially for noncritical workloads like development and testing environments. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to compare service costs between regions.

1. **Select regions with availability zones.** Some Azure regions include availability zones while others don't. You need to check the [Azure regions list](/azure/reliability/regions-list#azure-regions-list-1) to identify regions with availability zones. Use this information to prioritize regions that meet your workload reliability requirements.

1. **Understand region pairing implications.** Some Azure regions form pairs while others don't. Region pairing affects your disaster recovery strategies and service replication capabilities. You should know whether your selected region form pairs to design appropriate reliability and backup strategies. For more information, see [Azure region pairs and nonpaired regions](/azure/reliability/regions-paired).

1. **Understand Azure region capacity constraints.** Azure regions are subject to quota and capacity limits. These limits can affect your ability to deploy workloads as planned. Review the [subscription constraints per region](/azure/azure-resource-manager/management/azure-subscription-service-limits). For capacity, sometimes capacity constraints can be addressed through quota increases. Use Azure CLI capabilities to check on capacity availability for your services where available. Contact Microsoft support if you anticipate high usage or need quota increases.

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

## Azure resources for region selection

| Category | Resource | Description |
|----------|------|-------------|
| Data residency | [Data residency for Azure geographies and regions](https://azure.microsoft.com//explore/global-infrastructure/data-residency/) | Details on data residency for each Azure geography and region |
| Reliability workload design | [Regions and availability zones](/azure/well-architected/reliability/regions-availability-zones) | Design guidance for workloads using multiple regions and availability zones |
| Regional Planning | [Azure Geo Map](https://azure.microsoft.com/global-infrastructure/geographies/) | Interactive map that displays Azure region locations, capabilities, and compliance certifications to support regional planning decisions |
| Service availability | [Products available by region](https://azure.microsoft.com/global-infrastructure/services/) | Comprehensive list of Azure services offered in each region to validate service availability for workload requirements |
| Cost Optimization | [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) | Cost comparison tool that evaluates regional pricing differences to optimize deployment expenses across regions |
| Latency testing | [Azure latency test](https://www.azurespeed.com/Azure/Latency) | Network performance tool that measures latency between your location and Azure regions to validate performance requirements |

## Next steps

> [!div class="nextstepaction"]
> [Manage access](./manage-access.md)
