---
title: Select Azure regions
description: Learn how to select regions for your Azure solutions.
author: johndowns
ms.author: jodowns
ms.date: 08/28/2023
ms.topic: conceptual
---

# Select Azure regions

When you design your strategy to use Microsoft Azure, you can choose from many Azure regions around the world. Each [Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) has specific characteristics that make choosing the correct region for your Azure resources essential. Considerations include available services, capacity, constraints, and sovereignty:

- **Available services**: The Azure services you can deploy in each region differ depending on various factors. Select a region for the service you need for your workload. For more information, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/).
- **Capacity**: Each region has a maximum capacity. A region's maximum capacity might affect what types of subscriptions can deploy what types of services and under what circumstances. Regional capacity is different from a subscription quota. If you're planning a large-scale datacenter migration to Azure, you might want to consult with your local Azure field team, or your Azure account manager to confirm that you can deploy at the scale you need.
- **Constraints**: Certain constraints are placed on the deployment of services in certain regions. For example, some regions are available only for backup or failover. Other constraints that are important to note are [data sovereignty requirements](https://azure.microsoft.com/resources/achieving-compliant-data-residency-and-security-with-azure/).
- **Sovereignty**: Certain regions are dedicated to specific sovereign entities. Although all regions are Azure regions, these sovereign regions are isolated from the rest of Azure. They aren't necessarily managed by Microsoft, and they might be restricted to certain types of customers. These sovereign regions are:
  - [Azure China 21Vianet](https://azure.microsoft.com/global-infrastructure/services/?regions=china-east-2%2cchina-non-regional&products=all)
  - [Azure Germany](https://azure.microsoft.com/global-infrastructure/services/?regions=germany-north,germany-west-central&products=all&rar=true)  
     Azure Germany is being deprecated in favor of standard nonsovereign Azure regions in Germany.
  - [Azure Government - US](/azure/azure-government/documentation-government-welcome)

> [!NOTE]
> If you're migrating existing workloads from an on-premises datacenter into Azure, there are some additional considerations when you select a region. For more information, see [Select Azure regions for a migration](../../migrate/azure-best-practices/multiple-regions.md).

## Operate in multiple geographic regions

An organization might operate in multiple geographic regions to achieve resiliency that's essential to its operations. Having operations in multiple geographic regions introduces potential complexity in the following forms:

- Asset distribution
- User access profiles
- Compliance requirements
- Regional resiliency

Region selection is a key part of your overall cloud adoption strategy. Begin with network considerations.

## Network considerations

Any robust cloud deployment requires a well-considered network that takes into account differences in Azure regions. You should account for the following factors:

- [Azure paired regions](/azure/reliability/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies). Each region is paired with another region in the same geopolitical boundary to provide resiliency if a catastrophic region failure occurs. One exception is `Brazil South`, which is paired with `South Central US`. 

  Consider deploying to paired regions as a primary and secondary resiliency strategy. Here's more information to consider:

  - Azure Storage supports [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy?branch=main#redundancy-in-a-secondary-region). In Azure Storage GRS, three copies of your data are stored in your primary region, and three more copies are stored in the paired region. You can't change the storage pairing for GRS.
  - Services that rely on Azure Storage GRS can take advantage of this paired region capability. Your applications and your network must be configured to support paired regions.
  - If you don't plan to use GRS to support your regional resiliency needs, you shouldn't use the paired region as your secondary. If a regional failure occurs, intense pressure is put on resources in the paired region as resources migrate. You can avoid that pressure by recovering to an alternate site and gain speed during your recovery.

  > [!WARNING]
  > Don't attempt to use Azure Storage GRS for virtual machine backups or recovery. Instead, use [Azure Backup](https://azure.microsoft.com/services/backup/), [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/), and [Azure managed disks](/azure/virtual-machines/managed-disks-overview) to support resiliency for your infrastructure as a service (IaaS) workload.

  For more information, see [Azure paired regions](/azure/best-practices-availability-paired-regions).

- Azure Backup and Azure Site Recovery work in tandem with your network design to facilitate regional resiliency for your IaaS and data backup needs. Make sure that the network is optimized, so data transfers remain on the Microsoft backbone, and they use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview), if possible. Some larger organizations that have global deployments might instead use [Azure ExpressRoute Premium](/azure/expressroute/expressroute-introduction) to route traffic between regions and potentially save regional egress charges.

- Azure resource groups are specific to Azure regions. But *resources* in a resource group often span multiple regions. In a regional failure, control plane operations against a resource group fail in the affected region, but the resources in other regions in that resource group continue to operate. Resource group resiliency by region might affect how you design your network and your resource group.

- Many platform as a service (PaaS) services in Azure support [service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) or [Azure Private Link](/azure/private-link/private-link-overview). Both these solutions might significantly influence how you design your network as you consider regional resiliency, migration, and governance.

- Many PaaS services rely on their own regional resiliency solutions. For example, in deployments for Azure SQL Database and Azure Cosmos DB, you can easily replicate to more regions. Some Azure services, like Azure DNS, don't have regional dependencies. As you consider which services you'll use in your cloud adoption process, make sure that you clearly understand the failover capabilities and recovery steps that might be required for each Azure service you use.

- In addition to deploying to multiple regions to support disaster recovery, many organizations choose to deploy in an active-active pattern to avoid relying on failover. The benefits of using an active-active pattern include global load balancing, increased fault tolerance, and network performance boosts. To take advantage of this pattern, your applications must support running active-active in multiple regions.

> [!WARNING]
> Azure regions are highly available constructs. Azure service-level agreements are applied to the services running in specific regions. You should never deploy with a single-region dependency on mission-critical applications. Always plan for regional failure, and practice recovery and mitigation steps.

## Document your scenario complexity

After you consider network topology, determine whether more documentation and process alignment is required. The following approach can help you assess potential challenges and establish a general course of action:

- Consider a more robust readiness and governance implementation.
- Inventory the affected geographies. Compile a list of the countries/regions that are affected.
- Document data sovereignty requirements. Do the identified countries/regions have compliance requirements that govern data sovereignty?
- Document the user base. Will employees, partners, or customers in the identified country/region be affected by the cloud migration?
- Document datacenters and assets. Are there assets in the identified country/region that might be included in the migration effort?
- Document regional SKU availability and failover requirements.

Align changes throughout the migration process to address the initial inventory. The following table shows example scenarios that can help you document your findings:

| Region        | Country     | Local employees | Local external users   | Local datacenters or assets | Data sovereignty requirements |
|---------------|-------------|-----------------|------------------------|-----------------------------|-------------------------------|
| North America | United States         | Yes             | Partners and customers | Yes                         | No                            |
| North America | Canada      | No              | Customers              | Yes                         | Yes                           |
| Europe        | Germany     | Yes             | Partners and customers | No - network only           | Yes                           |
| Asia Pacific  | South Korea | Yes             | Partners               | Yes                         | No                            |

## Know data sovereignty requirements

Around the world, government organizations have begun to establish data sovereignty and data privacy regulations. These types of compliance requirements often require localization in a specific country/region to protect the citizens in that location. In some cases, data that pertains to customers, employees, or partners must be stored on a cloud platform in the same region as the user.

Addressing this challenge has been a significant motivation for cloud migrations for organizations that operate on a global scale. To maintain data sovereignty compliance, some organizations have chosen to deploy duplicate IT assets to cloud providers in the region. In the preceding table, the Germany scenario is a good example. The scenario includes customers, partners, and employees, but not current IT assents in Germany. This organization might choose to deploy some assets to a datacenter within a data sovereignty regulation area, potentially using the German Azure datacenters. An understanding of the data that's affected by regional data sovereignty regulations would help the cloud adoption team understand the best migration approach for the organization.

### Why is the location of users relevant?

Organizations that support users in multiple countries/regions have developed technical solutions that address user traffic. In some cases, solutions involve localization of assets. In other scenarios, the organization might choose to implement global wide area network (WAN) solutions to address disparate user bases through network-focused solutions. In either case, the migration strategy might be affected by the usage profiles of disparate users.

If an organization supports employees, partners, and customers in Germany without currently having datacenters in Germany, the organization probably implemented a leased-line solution. This type of solution routes traffic to datacenters in other countries/regions. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting more hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project.

In each of the following processes, guidance for addressing this complexity is included across prerequisites and processes of assessing, migrating, and optimizing. Understanding user profiles in each country/region is critical to properly manage this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters might affect a migration strategy. Consider the following factors:

**Architecture decisions**: Determining the target region is one of the first steps in migration strategy design. This determination often is influenced by the location of existing assets. Also, the availability of cloud services and the unit cost of those services might vary between regions. Understanding where current and future assets are located affects architecture decisions, and it might influence budget estimates.

**Datacenter dependencies**: The example scenarios in the table in [Document complexity](#document-your-scenario-complexity) show that you'll likely need to plan for dependencies between various global datacenters. The dependencies might not be documented or understood clearly in many organizations that operate on this scale. Your organization's approach to evaluating user profiles helps you identify some of these dependencies in your organization. Your team also should explore more assessment steps that can help mitigate the risks and complexities that arise from dependencies.
