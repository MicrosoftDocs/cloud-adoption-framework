---
title: Select Azure regions
description: Choose the right Azure regions for your workloads to ensure compliance, optimize performance, and increase resiliency.
author: stephen-sumner
ms.author: pnp
ms.date: 06/18/2025
ms.topic: conceptual
---

# Select Azure regions

The right Azure region is critical for workload compliance, performance, and resiliency. Region selection affects availability, latency, cost, and regulatory alignment. This article provides guidance to help you make informed decisions.

**Prerequisite:** [Create an Azure account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn). **Startups** see if you qualify for [Azure credits](https://www.microsoft.com/startups).

## Check data residency and compliance

Many countries/regions and industries require data to stay within specific geographic boundaries. Violating these rules can lead to fines or service restrictions.

1. **Identify regulations.** List the laws that apply to your customers and industry, such as GDPR, HIPAA.

1. **Map data to regions.** Document where customer data comes from and identify Azure regions that satisfy legal requirements for that data. Use this mapping to guide your regional deployment strategy.

1. **Verify compliance.** Confirm that your selected Azure regions and services have the right compliance certifications and data residency guarantees. For more info, see [Data residency for Azure geographies and regions](https://azure.microsoft.com//explore/global-infrastructure/data-residency/).

## Choose regions close to your users

Physical distance adds network latency, affecting user experience. Select regions that minimize latency for your primary user base.

1. **Map user and service locations.** Document where your users and systems are located geographically

1. **Check latency.** Use [Azure network round-trip latency statistics](/azure/networking/azure-network-latency) to pick regions that meet your performance goals.

## Validate region capabilities

Azure regions differ in services, pricing, and features. Before deployment:

1. **Check service availability.** Use [Azure products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/) to verify that all required Azure services are available in your selected regions before finalizing deployment plans.

1. **Compare pricing.** Costs vary by region. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to compare service costs between regions.

1. **Use availability zones.** Some Azure regions include availability zones while others don't. Regions with zones offer higher resilience. Check the [Azure regions list](/azure/reliability/regions-list#azure-regions-list-1) to identify regions with availability zones.

1. **Understand region pairs.** Some Azure regions form pairs while others don't. Region pairing can support some disaster recovery strategies and service replication capabilities. You should know whether your selected region form pairs to design appropriate reliability and backup strategies. For more information, see [Azure region pairs and nonpaired regions](/azure/reliability/regions-paired).

1. **Plan for capacity constraints.** Azure regions have quota and capacity limits. These limits can affect your ability to deploy workloads as planned. Review the [subscription constraints per region](/azure/azure-resource-manager/management/azure-subscription-service-limits). For capacity, sometimes capacity constraints can be addressed through quota increases. Use Azure CLI capabilities to check on capacity availability for your services where available. Contact Microsoft support if you anticipate high usage or need quota increases.

## Consider multiple regions

Single-region deployments can limit scalability and resiliency. Multi-region strategies improve performance, compliance, and disaster recovery.

1. **Known when to use multiple regions.** A single Azure region might restrict your ability to scale, meet regulatory requirements, or deliver low-latency services worldwide. Consider multi-region deployment in these scenarios:

    | Scenario | Why it matters | What to do |
    |----------|---------------|------------|
    | Global users & distributed teams | Reduce latency and improve experience. | Deploy in regions near users; use Azure Front Door or Traffic Manager. |
    | Data residency & compliance | Meet legal and regulatory requirements. | Choose compliant regions; enforce with Azure Policy and Purview. |
    | Regional capacity limits | Avoid hitting quotas in one region. | Spread workloads across regions; monitor with Azure Resource Graph. |
    | Cost & resource efficiency | Optimize spend and resource use. | Run noncritical workloads in lower-cost regions; use Pricing Calculator and Cost Management. |
    | Availability & disaster recovery | Improve resilience to outages. | Use active-active or active-passive setups; enable Site Recovery and GRS. |

    For more workload design information, see [Regions and availability zones](/azure/well-architected/reliability/regions-availability-zones).

1. **Pick regions that meet your requirements.** Previous guidance favored paired regions for distance (150+ miles apart), but this is no longer mandatory. Choose more regions based on latency, compliance, and resiliency needs. See [Using multiple Azure regions](/azure/reliability/regions-overview#using-multiple-azure-regions).

## Next steps

> [!div class="nextstepaction"]
> [Build-cloud native](../../cloud-native/plan-cloud-native-solutions.md)

> [!div class="nextstepaction"]
> [Manage access](./manage-access.md)
