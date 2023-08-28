---
title: Select Azure regions
description: Learn about cloud platform regions and the factors and characteristics that might affect your Azure region selections.
author: johndowns
ms.author: jodowns
ms.date: 08/28/2023
ms.topic: conceptual
---

# Select Azure regions

When you design your strategy to use Microsoft Azure, you can choose from many Azure regions around the world. Region selection is a key part of your overall cloud adoption strategy. Each [Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) has specific characteristics that make choosing the correct region for your Azure resources essential. 

> [!NOTE]
> If you're migrating existing workloads from an on-premises datacenter into Azure, there are some additional considerations when you select a region. For more information, see [Select Azure regions for a migration](../../migrate/azure-best-practices/multiple-regions.md).

## Understand Azure region topologies

Different Azure regions have different characteristics. Two common ways that Azure regions vary are around their use of availability zones, and whether they have a paired region. Also, some regions are operated by sovereign entities in particular countries. To learn more about how Azure regions work, see [What are Azure regions and availability zones?](/azure/reliability/availability-zones-overview).

### Availability zones

Many Azure regions include availability zones, which are physically separate locations within the region. By using availability zones, you can achieve higher availability and resilence your deployments, with less complexity than a multi-region deployment. For more information about availability zones, including a list of Azure regions and services that support availability zones, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support).

### Paired regions

Some regions are [paired with another region](/azure/reliability/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies), typically located in the same geopolitical area. Region pairing provides resiliency if a catastrophic region failure occurs. Newer regions aren't paired and instead use availability zones for high availability and resiliency.

For more information, see [Azure paired regions](/azure/best-practices-availability-paired-regions).

### Sovereign regions

Some regions are dedicated to specific sovereign entities. Although all regions are Azure regions, these sovereign regions are isolated from the rest of Azure. They aren't necessarily managed by Microsoft, and they might be restricted to certain types of customers. These sovereign regions are:

- [Azure China 21Vianet](https://azure.microsoft.com/global-infrastructure/services/?regions=china-east-2%2cchina-non-regional&products=all)
- [Azure Germany](https://azure.microsoft.com/global-infrastructure/services/?regions=germany-north,germany-west-central&products=all&rar=true)  
    Azure Germany is being deprecated in favor of standard non-sovereign Azure regions in Germany.
- [Azure Government - US](/azure/azure-government/documentation-government-welcome)

## Region services and capacity

The Azure services you can deploy in each region differ depending on various factors. Select a region for the service you need for your workload. For more information, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/).

Each region has a maximum capacity. A region's maximum capacity might affect what types of subscriptions can deploy what types of services and under what circumstances. Regional capacity is different from a subscription quota. If you're planning a deployment or migration to Azure, you might want to consult with your local Azure field team, or your Azure account manager to confirm that you can deploy at the scale you need.

Some Azure regions are recommended for many workloads. Other Azure regions are intended as alternate regions but aren't optimized for primary workloads. For more information, see [Available services by region types and categories](/azure/reliability/availability-service-by-category). In addition, constraints are sometimes placed on the deployment of services in certain regions. For example, some regions are available only for backup or failover, or only for customers with a company presence within a defined country.

## Understand data residency

Around the world, government organizations have begun to establish data sovereignty and data privacy regulations. These types of compliance requirements often require localization in a specific country/region to protect the citizens in that location. In some cases, data that pertains to customers, employees, or partners must be stored on a cloud platform in the same region as the user.

Ensure that you understand your own data residency requirements and that you verify that all Azure regions you use meet those requirements. For more information, see [Enabling Data Residency and Data Protection in Microsoft Azure Regions](https://azure.microsoft.com/resources/achieving-compliant-data-residency-and-security-with-azure/).

Addressing this challenge has been a significant motivation for cloud migrations for organizations that operate on a global scale. To maintain data sovereignty compliance, some organizations have chosen to deploy duplicate IT assets to cloud providers in the region.

## Consider region proximity

Users, or other services, that need to access your Azure services might reside in various geographies globally. Similarly, your Azure services might need to consume services from external sources located in various geographies.

Consider the latency and performance expectations from these external components in relation to the selected Azure region. For more information about latency between Azure regions and other geographic areas, see [Azure network round-trip latency statistics(/azure/networking/azure-network-latency).

## Operate in multiple geographic regions

An organization might operate in multiple geographic regions for several reasons. Common reasons to use multiple Azure regions include:

- **Support a geographically dispersed user base.** For example, if you operate in multiple countries, or if your customers use your services from multiple countries, it might make sense to have Azure resources in each location.
- **Comply with data sovereignty requirements**. Your organization might be subject to limits on the geographic areas where certain data can be stored.
- **Achieve high resiliency**, especially for mission-critical workloads.

If you plan to operate a cloud environment over multiple geographic regions, be aware of the following complexities:

- Asset distribution
- Data synchronization
- User access profiles
- Compliance requirements
- Regional resiliency

## Network considerations

- Azure Backup and Azure Site Recovery work in tandem with your network design to facilitate regional resiliency for your IaaS and data backup needs. Make sure that the network is optimized, so data transfers remain on the Microsoft backbone, and they use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview), if possible. Some larger organizations that have global deployments might instead use [Azure ExpressRoute Premium](/azure/expressroute/expressroute-introduction) to route traffic between regions and potentially save regional egress charges.

- Many platform as a service (PaaS) services in Azure support [service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) or [Azure Private Link](/azure/private-link/private-link-overview). Both these solutions might significantly influence how you design your network as you consider regional resiliency, migration, and governance.

- In addition to deploying to multiple regions to support disaster recovery, many organizations choose to deploy in an active-active pattern to avoid relying on failover. The benefits of using an active-active pattern include global load balancing, increased fault tolerance, and network performance boosts. To take advantage of this pattern, your applications must support running active-active in multiple regions.

## High availability and disaster recovery

Azure regions are highly available. Azure service-level agreements are applied to the services running in specific regions.

> [!WARNING]
> You should never deploy mission-critical workloads within a single-region. For these workloads, always plan for regional failure, and practice recovery and mitigation steps. For more information about mission-critical workloads, see [Mission-critical workloads](/azure/well-architected/mission-critical/mission-critical-overview).

### Understand Azure service deployments

Many PaaS services rely on their own regional resiliency solutions. For example, when you deploy Azure SQL Database and Azure Cosmos DB, you can easily replicate your data to more regions.

Some Azure services, like Azure DNS and Azure Front Door, are deployed globally and don't have regional dependencies.

As you consider which services you'll use in your cloud adoption process, make sure that you clearly understand the failover capabilities and recovery steps that might be required for each Azure service you use.

### Plan Azure resource group deployments

Azure resource groups are deployed to a specific Azure region. But *resources* in a resource group often span multiple regions. If a whole region fails, all management operations against the resources within the resource group might fail. However, resources that are deployed in another region might continue to be available even though they can't be managed. Resource group resiliency by region might affect how you design your resource hierarchy.

> [!TIP]
> Whenever possible, deploy resource groups in a region with availability zones. Availability zones help to minimize the risk of a regional outage causing management operations to be unavailable.

### Use geo-redundant storage in paired regions

If you deploy into a region with a pair, you can consider using a multi-region resiliency strategy with primary and secondary regions.

- Azure Storage supports [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy?branch=main#redundancy-in-a-secondary-region). In Azure Storage GRS, three copies of your data are stored in your primary region, and three more copies are stored in the paired region. You can't change the storage pairing for GRS.
- Services that rely on Azure Storage GRS can take advantage of this paired region capability. Your applications and your network must be configured to support paired regions.
- If you don't plan to use GRS to support your regional resiliency needs, you shouldn't use the paired region as your secondary. If a regional failure occurs, intense pressure is put on resources in the paired region as resources migrate. You can avoid that pressure by recovering to an alternate site and gain speed during your recovery.

> [!WARNING]
> Don't attempt to use Azure Storage GRS for virtual machine backups or recovery. Instead, use [Azure Backup](https://azure.microsoft.com/services/backup/), [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/), and [Azure managed disks](/azure/virtual-machines/managed-disks-overview) to support resiliency for your infrastructure as a service (IaaS) workload.

### Deploy to regions without a pair

Newer Azure regions have no regional pair, and achieve high availability by using availability zones. 

- When you use these regions, you can use locally redundant or zone-redundant storage (LRS/ZRS). Regions without a pair don't support geo-redundant storage (GRS). Such regions follow data residency guidelines allowing the option to keep data resident within the same region. 
- Consider your data resiliency needs. Regardless of where your data is located, you can move, copy, or access their data from any location globally.
- In the rare event that an entire Azure region is unavailable, you need to plan for cross-region disaster recovery. For more information, see [Availability zone service and regional support](/azure/reliability/availability-zones-service-support#azure-services-with-availability-zone-support) and [Azure Resiliency – Business Continuity and Disaster Recovery](https://azure.microsoft.com/mediahandler/files/resourcefiles/resilience-in-azure-whitepaper/resiliency-whitepaper-2022.pdf).

Some services such as Azure Backup have a dependency on geo-redundant storage when configured in geo-redundant mode. With Azure regions without a paired region, services such as Azure Backup will be limited to locally redundant storage (LRS).
