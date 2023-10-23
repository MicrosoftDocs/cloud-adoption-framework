---
title: Select Azure regions
description: Learn about cloud platform regions. Understand factors like availability zones, paired regions, and data residency that affect region selection in Azure.
author: johndowns
ms.author: jodowns
ms.date: 10/20/2023
ms.topic: conceptual
---

# Select Azure regions

When you design your strategy to use Microsoft Azure, you can choose from many Azure regions around the world. Region selection is a key part of your overall cloud adoption strategy. Each [Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) has specific characteristics, so it's essential to choose the best regions for your Azure resources.

## Understand Azure region architectures and resilience

Different Azure regions have different characteristics. Two common ways that Azure regions vary involve availability zones and paired regions. Also, some regions are operated by sovereign entities in particular countries. The *region architecture* refers to how a specific region is designed and the overall regional capabilities that it provides.

To learn more about how Azure regions work, see [What are Azure regions and availability zones?](/azure/reliability/availability-zones-overview).

### Availability zones

Many Azure regions include availability zones, which are physically separate locations within a region. By using availability zones, you can achieve higher availability and resilience in your deployments. For more information about availability zones, and for a list of Azure regions and services that support availability zones, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support).

### Paired regions

Some regions are [paired with another region](/azure/reliability/cross-region-replication-azure#azure-paired-regions), with both regions typically located in the same geopolitical area. Region pairing provides resiliency during catastrophic region failures. Region pairing is mostly used for [geo-redundant storage (GRS)](#use-grs-in-paired-regions) and by other Azure services that depend on Azure Storage for replication.

Newer regions aren't paired. Instead, they use availability zones for high availability and resiliency. Later in this article, you learn more about how to use these region types.

> [!TIP]
> To learn how to design a workload that uses regions and availability zones, see [Recommendations for using availability zones and regions](/azure/well-architected/resiliency/regions-availability-zones).

### Sovereign regions

Some regions are dedicated to specific sovereign entities. Although all regions are Azure regions, these sovereign regions are isolated from the rest of Azure. Microsoft doesn't necessarily manage them, and they can be restricted to certain types of customers. These sovereign regions are [Azure China 21Vianet](https://azure.microsoft.com/global-infrastructure/services/?regions=china-east-2%2cchina-non-regional&products=all) and [Azure Government - US](/azure/azure-government/documentation-government-welcome). Sovereign regions are built to the same standards of resiliency as other Azure regions.

## Consider region service availability and capacity

Azure offers two types of regions:

- *Recommended* regions are suitable for most workloads.
- *Alternate* regions aren't optimized for primary workloads. Instead, alternate regions are available only for backup or failover, or only for customers with a company presence within a defined country/region.

The services that you can deploy in a region depend on the region's type, among other factors. For more information, see the following resources:

- [Available services by region types and service categories](/azure/reliability/availability-service-by-category)
- [Products available by region](https://azure.microsoft.com/global-infrastructure/services/)

Some regions are reserved for customers who need disaster recovery within their country/region. To request access to these reserved access regions, [create a new support request](/troubleshoot/azure/general/region-access-request-process#reserved-access-regions).

Azure is a massively scalable platform, but each region has a maximum capacity. A region's maximum capacity can affect which types of subscriptions can deploy what types of services and under what circumstances. Regional capacity is different from a subscription quota. If you're planning a deployment or migration to Azure, it's a good idea to speak with your local Azure field team or your Azure account manager. Ask for confirmation that you can deploy at the scale that you need.

When you use regions for disaster recovery purposes, consider whether the destination region provides the capacity that you need to support your workloads. For workloads that are based on virtual machines (VMs), consider using [capacity reservations](/azure/virtual-machines/capacity-reservation-overview) to guarantee the availability of capacity in the regions that you use.

## Understand data residency

Around the world, government organizations have begun to establish data sovereignty and data privacy regulations. These types of compliance requirements often require localization in a specific country/region to protect the citizens in that location. In some cases, data that pertains to customers, employees, or partners must be stored on a cloud platform in the same region as the user.

Ensure that you understand your own data residency requirements. Also, verify that the Azure regions that you select are in geographic locations that meet your requirements. For more information, see [Enabling Data Residency and Data Protection in Microsoft Azure Regions](https://azure.microsoft.com/resources/research/search/?term=Enabling+Data+Residency+and+Data+Protection+in+Microsoft+Azure+Regions&type=WhitePaperResource).

Addressing data residency challenges is a significant motivation for organizations that operate on a global scale to migrate to the cloud. To maintain data sovereignty compliance, some organizations choose to deploy duplicate IT assets to cloud providers in their selected region.

## Consider region proximity

Users or services that need to access your Azure services might reside in various geographies globally. Similarly, your Azure services might need to consume services from external sources that are located in various geographies. Or your services might need to connect to your on-premises systems.

Proximity is an important factor to consider when you select an Azure region. If you use Azure ExpressRoute to connect to your on-premises systems, you can optimize network connectivity and reduce latency by using a region that's close to your on-premises systems. Subsequent connections between Azure regions use the high-speed Microsoft global network.

For more information about latency between Azure regions and other geographic areas, see [Azure network round-trip latency statistics](/azure/networking/azure-network-latency).

## Operate in multiple geographic regions

It's common for an organization to operate in multiple geographic regions. An organization can get the following benefits by using multiple Azure regions:

- **Run different workloads in different regions**. This reason applies when you want to be close to a specific customer base or business partner. It's also relevant when you want to use Azure services that aren't available in a specific Azure region.
- **Support a geographically dispersed user base**. If you operate in multiple countries, or if your customers use your services from multiple countries, it can make sense to have Azure resources in each location. Alternatively, you can consider using a single region and then using [Azure Front Door](/azure/frontdoor/front-door-overview) to accelerate global traffic to that region.
- **Comply with data sovereignty requirements**. Your organization might be subject to limits on the geographic areas where you can store certain data.
- **Achieve high resiliency**, especially for business-critical workloads. Business-critical workloads require the benefits that availability zones provide, such as high availability and protection from region-wide outages and disasters.
- **Improve network connectivity and performance**. In a hybrid or multicloud scenario, using multiple Azure regions can help improve your network performance. Traffic can enter and exit the high-speed Microsoft backbone network at locations that are close to your on-premises systems, or to another cloud provider's locations. To learn more about multicloud solutions, see [Connectivity to other cloud providers](../../ready/azure-best-practices/connectivity-to-other-providers.md).
- **Optimize costs**. Different Azure resource types can have different prices in different regions. When you use tools like the [Pricing calculator](https://azure.microsoft.com/pricing/calculator/) and the [Azure service pricing information](https://azure.microsoft.com/pricing/), ensure that you select the correct region to view accurate pricing information. Sometimes you can reduce costs by deploying your development and test environments into a different region. But you need to ensure that the region provides the capabilities and services that you use in your production region.
- **Scale beyond resource quotas**. Some Azure resources have [quotas and limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) that restrict the number of instances of a resource that you can create in each region under each subscription. To scale beyond these limits, you might need to use extra subscriptions or multiple regions.
- **Avoid capacity restrictions.** Occasionally, regions have capacity restrictions applied to them. If you use multiple regions, it's probably going to be easier for you to find and use a region that supports the services you want to deploy. If you use a single region and need to expand to a second region just to avoid capacity restrictions, it might take more time for you to prepare and deploy your resources.

When operating a cloud environment that's spread over multiple geographic regions, consider the following factors:

- **Operational complexity**. When you have multiple resources in different regions, there might be additional operational overhead. You might also have to pay extra costs when you duplicate resources across regions.
- **Data synchronization**. Understand whether you need to synchronize or replicate data between regions. If you do, understand whether to do it asynchronously or synchronously. Configuring a multi-region data storage tier can be complex. You need to consider tradeoffs between resiliency, performance, and cost.
- **Global networking topology**. Azure provides many different networking services. Azure also supports the implementation of various global networking topologies to meet different requirements and provide different tradeoffs. For example, you can expand Azure networking to multiple regions by using [Azure Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or you can use a [traditional hub-and-spoke model](../azure-best-practices/traditional-azure-networking-topology.md) with some extra effort.
- **User access profiles**. If a single user works with components in multiple regions, understand how to manage their identities and access profiles across regions.
- **Compliance requirements**. Verify that each region satisfies your compliance requirements, including requirements for data sovereignty.
- **Regional resiliency**. Even though using a multi-region architecture helps to increase resiliency, you should also design your solution to be highly available within each region. Use availability zones where you can, and ensure that you consider how to achieve high resiliency within each region.
- **Failover**. When you use multiple regions for resiliency purposes, you can design your solution to use an active-passive approach. This approach requires you to detect regional outages and fail over traffic between regions. It can take time for a failover process to detect an outage and complete traffic routing, which can result in downtime for your services. Some organizations instead choose to deploy in an active-active pattern to avoid relying on failover. The benefits of using an active-active pattern include global load balancing, increased fault tolerance, and network performance boosts. To take advantage of this pattern, your applications must support running simultaneously in multiple regions.

## Relocate across regions

Occasionally, you might need to relocate resources or workloads from one Azure region to another. Changes in business requirements, company acquisitions, data residency laws, and other factors are reasons for needing to relocate.

> [!TIP]
> Relocating resources across regions can be complex. When possible, aim to deploy your resources into the correct region from the start.

Azure provides several tools and various relocation capabilities, but the details vary for each Azure service. Some resource types can be [directly moved across regions](/azure/azure-resource-manager/management/move-support-resources), and others can be moved by using [Azure Resource Mover](/azure/resource-mover/overview). Some resource types can't be moved and must be redeployed.

To learn more about relocating across regions, see [Relocate cloud workloads](../../relocate/index.md).

## High availability and disaster recovery across regions

Azure regions are highly available. Azure service-level agreements are applied to the services that run in specific regions. This section provides some considerations that apply if you choose to deploy across multiple regions to increase your resiliency.

> [!WARNING]
> When you design business-critical workloads, always plan for regional failures, and avoid deploying within a single region. You should also practice recovery and mitigation steps. For more information, see [Mission-critical workloads](/azure/well-architected/mission-critical/mission-critical-overview).

### Understand Azure service resiliency features

Many platform as a service (PaaS) services rely on their own regional resiliency solutions. For example, when you deploy Azure SQL Database and Azure Cosmos DB, you can easily replicate your data to more regions. Other services are deployed to a single region, and you need to manually deploy them to other regions. Also, some Azure services, like Azure DNS and Azure Front Door, are deployed globally and don't have regional dependencies.

For each Azure service that you consider for your cloud adoption process, understand the required failover capabilities and recovery steps.

### Plan Azure resource group deployments

Azure resource groups are deployed to a specific Azure region. But *resources* in a resource group often span multiple regions. If a whole region is unavailable, all management operations that involve resources within the unavailable region's resource groups can fail. But resources that are deployed in another region might continue to be available even though they can't be managed. Keep in mind these points about resource group resiliency by region when you design your resource hierarchy.

> [!TIP]
> Whenever possible, deploy resource groups in a region that has multiple availability zones. Availability zones help to minimize the risk of regional outages that reduce the availability of your resource and also make management operations unavailable.

### Use GRS in paired regions

If you deploy into a region that has an associated paired region, you can use the paired region as part of your multi-region resiliency strategy. Paired regions enable you to [use primary and secondary regions](#operate-in-multiple-geographic-regions).

[Azure Storage supports GRS](/azure/storage/common/storage-redundancy?branch=main#redundancy-in-a-secondary-region). In Storage GRS, three copies of your data are stored in your primary region, and three more copies are stored in the paired region. You can't change the storage pairing for GRS. Other Azure services that rely on Storage often take advantage of this paired region capability. Your applications and your network must be configured to support paired regions and to use GRS storage appropriately.

Don't attempt to use Storage with GRS replication for your VM backups. Instead, use [Azure Backup](https://azure.microsoft.com/services/backup/), [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/), and [Azure managed disks](/azure/virtual-machines/managed-disks-overview) to support resiliency for your infrastructure as a service (IaaS) workloads.

> [!TIP]
> Multi-region solutions don't have to use Storage GRS. Instead, several other options are available:
>
> - Run your application tier access multiple regions.
> - Use a globally distributed database service like [Azure Cosmos DB](/azure/cosmos-db/distribute-data-globally) or [SQL Database](/azure/azure-sql/database/active-geo-replication-overview).
> - Use [blob object replication](/azure/storage/blobs/object-replication-overview).
> - Use another multi-region deployment approach.
>
> In these scenarios, when you select a secondary region, consider using a region that isn't the paired region. If a regional failure occurs in your primary region, intense pressure is put on resources in the paired region when resources are migrated and cross-region failover occurs. You can avoid that pressure by recovering to an alternate region, which means you gain speed during your recovery.

### Deploy to regions without a pair

Newer Azure regions have no regional pair. They achieve high availability by using availability zones. Such regions follow data residency guidelines that provide the option of storing data in the region.

When you use these regions, you can use locally redundant storage (LRS) or zone-redundant storage (ZRS). Regions without a pair don't support GRS. Services like Backup that have a dependency on Storage might also require that you use ZRS or LRS storage. When possible, it's a good practice to use ZRS to improve your resiliency within your region.

To prepare for the rare event that an entire Azure region is unavailable, you need to plan for cross-region disaster recovery. At a minimum, it's a good practice to deploy your infrastructure by using automation approaches, and to back up your data across regions. If a full-region outage occurs, you can manually redeploy your resources and restore your backups. For some scenarios, you might need to consider other alternatives to reduce your potential recovery time and data loss. For more information, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support#azure-services-with-availability-zone-support) and [Azure Resiliency – Business Continuity and Disaster Recovery](https://azure.microsoft.com/mediahandler/files/resourcefiles/resilience-in-azure-whitepaper/resiliency-whitepaper-2022.pdf).

Consider your data resiliency needs. Regardless of where your data is located, you can move, copy, or access your data from any location globally.

Some Azure services provide a way for you to store or replicate your data in multiple regions without the regions being paired. For example:

- [Azure Cosmos DB provides global data distribution](/azure/cosmos-db/distribute-data-globally).
- [SQL Database provides active geo-replication to another Azure region](/azure/azure-sql/database/active-geo-replication-overview).
- [Site Recovery supports recovery to any region](/azure/site-recovery/azure-to-azure-quickstart).
- [Azure NetApp Files provides cross-region replication](/azure/azure-netapp-files/cross-region-replication-introduction#supported-region-pairs).

## Next steps

When you migrate existing workloads from an on-premises datacenter to Azure, there are some other region-selection considerations that you should also keep in mind. For more information, see [Select Azure regions for a migration](../../migrate/azure-best-practices/multiple-regions.md).
