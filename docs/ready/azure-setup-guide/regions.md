---
title: Select Azure regions
description: Learn about cloud platform regions and the factors and characteristics that might affect your Azure region selections.
author: johndowns
ms.author: jodowns
ms.date: 09/01/2023
ms.topic: conceptual
---

# Select Azure regions

When you design your strategy to use Microsoft Azure, you can choose from many Azure regions around the world. Region selection is a key part of your overall cloud adoption strategy. Each [Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) has specific characteristics, so it's essential to choose the best regions for your Azure resources.

> [!NOTE]
> If you're migrating existing workloads from an on-premises datacenter into Azure, there are some additional considerations when you select a region. For more information, see [Select Azure regions for a migration](../../migrate/azure-best-practices/multiple-regions.md).

## Understand Azure region types

Different Azure regions have different characteristics. Two common ways that Azure regions vary are around their use of availability zones, and whether they have a paired region. Also, some regions are operated by sovereign entities in particular countries. To learn more about how Azure regions work, see [What are Azure regions and availability zones?](/azure/reliability/availability-zones-overview).

### Availability zones

Many Azure regions include availability zones, which are physically separate locations within the region. By using availability zones, you can achieve higher availability and resilence in your deployments. For more information about availability zones, including a list of Azure regions and services that support availability zones, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support).

### Paired regions

Some regions are [paired with another region](/azure/reliability/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies), typically located in the same geopolitical area. Region pairing provides resiliency if a catastrophic region failure occurs. Newer regions aren't paired and instead use availability zones for high availability and resiliency.

For more information, see [Azure paired regions](/azure/best-practices-availability-paired-regions).

### Sovereign regions

Some regions are dedicated to specific sovereign entities. Although all regions are Azure regions, these sovereign regions are isolated from the rest of Azure. They aren't necessarily managed by Microsoft, and they might be restricted to certain types of customers. These sovereign regions are:

- [Azure China 21Vianet](https://azure.microsoft.com/global-infrastructure/services/?regions=china-east-2%2cchina-non-regional&products=all)
- [Azure Germany](https://azure.microsoft.com/global-infrastructure/services/?regions=germany-north,germany-west-central&products=all&rar=true)  
    Azure Germany is being deprecated in favor of standard non-sovereign Azure regions in Germany.
- [Azure Government - US](/azure/azure-government/documentation-government-welcome)

## Consider region service availability and capacity

Some Azure regions are recommended for many workloads. Other Azure regions are intended as alternate regions but aren't optimized for primary workloads. Sometimes, constraints are placed on the deployment of services in certain regions. For example, some regions are available only for backup or failover, or only for customers with a company presence within a defined country. For more information, see [Available services by region types and categories](/azure/reliability/availability-service-by-category).

Additionally, the Azure services you can deploy in each region differ depending on various factors. For more information, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/).

Each region has a maximum capacity. A region's maximum capacity might affect which types of subscriptions can deploy what types of services and under what circumstances. Regional capacity is different from a subscription quota. If you're planning a deployment or migration to Azure, it's a good idea to speak with your local Azure field team or your Azure account manager to confirm that you can deploy at the scale you need.

Some regions are reserved for customers who need in-country disaster recovery. To request access to reserved access regions, [create a new support request](/troubleshoot/azure/general/region-access-request-process#reserved-access-regions).

## Understand data residency

Around the world, government organizations have begun to establish data sovereignty and data privacy regulations. These types of compliance requirements often require localization in a specific country or region to protect the citizens in that location. In some cases, data that pertains to customers, employees, or partners must be stored on a cloud platform in the same region as the user.

Ensure that you understand your own data residency requirements. Also, verify that the Azure regions you select are in geographic locations that meet your requirements. For more information, see [Enabling Data Residency and Data Protection in Microsoft Azure Regions](https://azure.microsoft.com/resources/achieving-compliant-data-residency-and-security-with-azure/).

Addressing data residency challenges has been a significant motivation for cloud migrations for organizations that operate on a global scale. To maintain data sovereignty compliance, some organizations have chosen to deploy duplicate IT assets to cloud providers in the region.

## Consider region proximity

Users, or other services, that need to access your Azure services might reside in various geographies globally. Similarly, your Azure services might need to consume services from external sources located in various geographies, or they might need to connect to your on-premises systems.

Proximity is an important factor when you select an Azure region. If you use Azure ExpressRoute to connect to your on-premises systems, then by using a region close to your on-premises systems you can optimize network connectivity and reduce latency. Subsequent connections between Azure regions use the high-speed Microsoft global network.

For more information about latency between Azure regions and other geographic areas, see [Azure network round-trip latency statistics](/azure/networking/azure-network-latency).

## Operate in multiple geographic regions

It's common for an organization to operate in multiple geographic regions. Common reasons to use multiple Azure regions include:

- **Run different workloads in different regions**, such as to be close to a specific customer base or business partner, or to use Azure services that aren't available in your primary Azure region.
- **Support a geographically dispersed user base.** For example, if you operate in multiple countries, or if your customers use your services from multiple countries, it might make sense to have Azure resources in each location. Alternatively, you can consider using a single region and then use [Azure Front Door](/azure/frontdoor/front-door-overview) to accelerate global traffic to that region.
- **Comply with data sovereignty requirements**. Your organization might be subject to limits on the geographic areas where certain data can be stored.
- **Achieve high resiliency**, especially for mission-critical workloads. Mission-critical workloads require the high availability provided by availability zones as well as protection from region-wide outages and disasters.
- **Optimize costs**. Different Azure resource types can have different prices in different regions. When you use tools like the [Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) and the [Azure service pricing information](https://azure.microsoft.com/pricing/), ensure that you select the correct region to view accurate pricing information.
- **Scale beyond resource quotas**. Some Azure resources have [quotas and limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) that restrict how many instances of a resource can be created in each region by each subscription. To scale beyond these limits, you might need to consider using additional subscriptions or multiple regions.

When you plan to operate a cloud environment over multiple geographic regions, be aware of the following considerations:

- **Resource distribution and management.** When you have multiple resources in different regions, you accept a higher operational burden. You also have to pay for each resource.
- **Data synchronization.** Understand whether you need to synchronize or replicate data between regions, and if you do, whether to do it asynchronously or synchronously. Configuring a multi-region data storage tier can be complex and can result in tradeoffs between resiliency, performance, and cost.
- **Global networking topology.** Azure provides many different networking services, and supports the implementation of various global networking topologies to meet different requirements and provide different tradeoffs. For example, you can expand Azure networking to multiple regions by using [Azure Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or you can use a [traditional hub and spoke model](../azure-best-practices/traditional-azure-networking-topology.md) with some additional effort.
- **User access profiles.** If a single user works with components in multiple regions, understand how you'll manage their identities and access profiles across regions.
- **Compliance requirements.** Verify that each region satisfies your compliance requirements, including for data sovereignty.
- **Regional resiliency.** Even when you use a multi-region architecture, you should ensure that you design your solution to be highly available within the region as well. Use availability zones where you can, and ensure that you have considered how to achieve high resiliency within the region.
- **Failover.** When you use multiple regions for resiliency purposes, you might design your solution to use an active-passive approach, which requires you to detect a regional outage and fail over traffic between regions. It can take time for a failover process to detect an outage and complete traffic routing, which might result in downtime for your services. Some organizations instead choose to deploy in an active-active pattern to avoid relying on failover. The benefits of using an active-active pattern include global load balancing, increased fault tolerance, and network performance boosts. To take advantage of this pattern, your applications must support running simultaneously in multiple regions.

## High availability and disaster recovery across regions

Azure regions are highly available. Azure service-level agreements are applied to the services running in specific regions. This section provides some considerations that apply if you choose to deploy across multiple regions to increase your resiliency.

> [!WARNING]
> When you design mission-critical workloads, always plan for regional failure, and avoid deploying within a single region. You should also practice recovery and mitigation steps. For more information, see [Mission-critical workloads](/azure/well-architected/mission-critical/mission-critical-overview).

### Understand Azure service deployments

Many PaaS services rely on their own regional resiliency solutions. For example, when you deploy Azure SQL Database and Azure Cosmos DB, you can easily replicate your data to more regions.

Some Azure services, like Azure DNS and Azure Front Door, are deployed globally and don't have regional dependencies.

As you consider which services you'll use in your cloud adoption process, make sure that you clearly understand the failover capabilities and recovery steps that might be required for each Azure service you use.

### Plan Azure resource group deployments

Azure resource groups are deployed to a specific Azure region. But *resources* in a resource group often span multiple regions. If a whole region fails, all management operations against the resources within the resource group might fail. However, resources that are deployed in another region might continue to be available even though they can't be managed. Resource group resiliency by region might affect how you design your resource hierarchy.

> [!TIP]
> Whenever possible, deploy resource groups in a region with availability zones. Availability zones help to minimize the risk of a regional outage that might cause management operations to be unavailable.

### Use geo-redundant storage in paired regions

If you deploy into a region that has an associated paired region, you can use the paired region as part of your multi-region resiliency strategy. Paired regions enable you to [use primary and secondary regions](#operate-in-multiple-geographic-regions).

Azure Storage supports [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy?branch=main#redundancy-in-a-secondary-region). In Azure Storage GRS, three copies of your data are stored in your primary region, and three more copies are stored in the paired region. You can't change the storage pairing for GRS. Other Azure services that rely on Azure Storage often take advantage of this paired region capability. Your applications and your network must be configured to support paired regions and to use GRS storage appropriately.

You might choose not to use GRS to support your regional resiliency needs, and instead have your application tier access multiple regions, or use another multi-region approach. In this situation, it's a good practice not to use the paired region as your secondary region. If a regional failure occurs, intense pressure is put on resources in the paired region as resources migrate. You can avoid that pressure by recovering to an alternate region, gaining speed during your recovery.

> [!WARNING]
> Don't attempt to use Azure Storage GRS for virtual machine backups or recovery. Instead, use [Azure Backup](https://azure.microsoft.com/services/backup/), [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/), and [Azure managed disks](/azure/virtual-machines/managed-disks-overview) to support resiliency for your infrastructure as a service (IaaS) workloads.

### Deploy to regions without a pair

Newer Azure regions have no regional pair, and achieve high availability by using availability zones. Such regions follow data residency guidelines allowing the option to keep data resident within the same region. 

When you use these regions, you can use locally redundant or zone-redundant storage (LRS/ZRS). Regions without a pair don't support geo-redundant storage (GRS). Services like Azure Backup that have a dependency on Azure Storage might also require that you use ZRS or LRS storage. Where possible, it's a good practice to use ZRS to improve your resiliency within the region.

In the rare event that an entire Azure region is unavailable, you need to plan for cross-region disaster recovery. At a minimum, it's a good practice to deploy your infrastructure by using automation approaches, and to back up your data across regions. If a full region outage occurs, you can manually redeploy your resources and restore your backups. For some scenarios, you might need to consider other alternatives to reduce your potential recovery time and data loss. For more information, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support#azure-services-with-availability-zone-support) and [Azure Resiliency – Business Continuity and Disaster Recovery](https://azure.microsoft.com/mediahandler/files/resourcefiles/resilience-in-azure-whitepaper/resiliency-whitepaper-2022.pdf).

Consider your data resiliency needs. Regardless of where your data is located, you can move, copy, or access your data from any location globally.

Some Azure services enable you to store or replicate your data in multiple regions even without the regions being paired. For example, [Azure Cosmos DB provides global data distribution](/azure/cosmos-db/distribute-data-globally), [Azure SQL Database provides active geo-replication to another Azure region](/azure/azure-sql/database/active-geo-replication-overview), and [Azure NetApp Files provides cross-region replication](/azure/azure-netapp-files/cross-region-replication-introduction#supported-region-pairs).

### Consider networking for backups

Azure Backup and Azure Site Recovery work in tandem with your network design to facilitate regional resiliency for your IaaS and data backup needs. Be sure that the network is optimized so that data transfers remain on the Microsoft backbone, and use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) if possible. Some larger organizations that have global deployments might instead use [Azure ExpressRoute Premium](/azure/expressroute/expressroute-introduction) to route traffic between regions and potentially save regional egress charges. These considerations are particularly important when you transfer data across regions.
