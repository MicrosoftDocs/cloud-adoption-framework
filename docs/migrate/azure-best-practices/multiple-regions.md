---
title: Azure regions decision guide
description: Learn about cloud platform regions and the factors and characteristics that can affect your Azure region selections.
author: doodlemania2
ms.author: dermar
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Azure regions decision guide

Azure comprises many regions around the world. Each [Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) has specific characteristics that make choosing which region to use incredibly important. These include available services, capacity, constraints, and sovereignty:

- **Available services:** Services that are deployed to each region differ, based on various factors. Select a region for your workload that contains your desired service. For more information, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/).
- **Capacity:** Each region has a maximum capacity. This can affect which types of subscriptions can deploy which types of services and under what circumstances. This is different than subscription quotas. If you're planning a large-scale datacenter migration to Azure, you might want to consult with your local Azure field team or account manager to confirm that you can deploy at the scale necessary.
- **Constraints:** Certain constraints are placed on the deployment of services in certain regions. For example, some regions are only available as a backup or failover target. Other constraints that are important to note are [data sovereignty requirements](https://azure.microsoft.com/global-infrastructure/geographies/).
- **Sovereignty:** Certain regions are dedicated to specific sovereign entities. While all regions are Azure regions, these sovereign regions are completely isolated from the rest of Azure. They aren't necessarily managed by Microsoft and might be restricted to certain types of customers. These sovereign regions are:
  - [Azure China 21Vianet](https://azure.microsoft.com/global-infrastructure/geographies/)
  - [Azure Germany](https://azure.microsoft.com/global-infrastructure/geographies/): Azure Germany is being deprecated in favor of standard nonsovereign Azure regions in Germany.
  - [Azure US government](https://azure.microsoft.com/global-infrastructure/government/)
  - Two regions in [Australia](https://azure.microsoft.com/global-infrastructure/geographies/) are managed by Microsoft but are provided for the Australian government and its customers and contractors. Therefore, these regions carry client constraints similar to the other sovereign clouds.

## Operate in multiple geographic regions

When businesses operate in multiple geographic regions, which can be essential for resiliency, this introduces potential complexity in the following forms:

- Asset distribution
- User access profiles
- Compliance requirements
- Regional resiliency

Regional selection is very important to your overall cloud adoption strategy. Let's start with network considerations.

## Network considerations

Any robust cloud deployment requires a well-considered network that takes into account Azure regions. You should account for the following:

- Azure regions are deployed in pairs. In the event of a catastrophic region failure, another region within the same geopolitical boundary is designated as its paired region. Consider deploying into paired regions as a primary and secondary resiliency strategy. One exception to this strategy is `Brazil South`, which is paired with `South Central US`. For more information, see [Azure paired regions](/azure/best-practices-availability-paired-regions).

  - Azure Storage supports [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy). This means that three copies of your data are stored within your primary region, and three additional copies are stored in the paired region. You can't change the storage pairing for GRS.
  - Services that rely on Azure Storage GRS can take advantage of this paired region capability. To do so, your applications and the network must be oriented to support that.
  - If you don't plan to use GRS to support your regional resiliency needs, you shouldn't use the paired region as your secondary. In the event of a regional failure, there will be intense pressure on resources in the paired region as resources migrate. You can avoid that pressure by recovering to an alternate site and gaining additional speed during your recovery.
  > [!WARNING]
  > Do not attempt to use Azure GRS for VM backups or recovery. Instead, use [Azure Backup](https://azure.microsoft.com/services/backup/) and [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/), along with [Azure managed disks](/azure/virtual-machines/managed-disks-overview), to support your infrastructure as a service (IaaS) workload resiliency.

- Azure Backup and Azure Site Recovery work in tandem with your network design to facilitate regional resiliency for your IaaS and data backup needs. Make sure the network is optimized so data transfers remain on the Microsoft backbone and use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview), if possible. Some larger organizations with global deployments might instead use [ExpressRoute Premium](/azure/expressroute/expressroute-introduction), to route traffic between regions and potentially save regional egress charges.

- Azure resource groups are regional specific. It's normal, however, for resources within a resource group to span multiple regions. Consider that in the event of a regional failure, control plane operations against a resource group will fail in the affected region, even though the resources in other regions (within that resource group) will continue to operate. This can affect both your network design and your resource group design.

- Many platform as a service (PaaS) services within Azure Support [service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) or [Azure Private Link](/azure/private-link/private-link-overview). Both of these solutions affect your network considerations substantially with regard to regional resiliency, migration, and governance.

- Many PaaS services rely on their own regional resiliency solutions. For example, both Azure SQL Database and Azure Cosmos DB allow you to easily replicate to additional regions. Services such as Azure DNS don't have regional dependencies. As you consider which services you will use in your adoption process, make sure to clearly understand the failover capabilities and recovery steps that can be required for each Azure service.

- In addition to deploying to multiple regions to support disaster recovery, many organizations choose to deploy in an active-active pattern to not rely on failover. This method offers the additional benefits of global load balancing, additional fault tolerance, and network performance boosts. To take advantage of this pattern, your applications must support running active-active in multiple regions.

> [!WARNING]
> Azure regions are highly available constructs, with SLAs applied to the services running in them. But you should never take a single region dependency on mission-critical applications. Always plan for regional failure, and practice recovery and mitigation steps.

After considering the network topology, you must next look at additional documentation and process alignment that might be necessary. The following approach can help assess the potential challenges and establish a general course of action:

- Consider a more robust readiness and governance implementation.
- Inventory the affected geographies. Compile a list of the regions and countries that are affected.
- Document data sovereignty requirements. Do the countries identified have compliance requirements that govern data sovereignty?
- Document the user base. Will employees, partners, or customers in the identified country be affected by the cloud migration?
- Document datacenters and assets. Are there assets in the identified country that might be included in the migration effort?
- Document regional SKU availability and failover requirements.

Align changes across the migration process to address the initial inventory.

## Document complexity

The following table can aid in documenting the findings from the previous steps:

| Region        | Country     | Local employees | Local external users   | Local datacenters or assets | Data sovereignty requirements |
|---------------|-------------|-----------------|------------------------|-----------------------------|-------------------------------|
| North America | United States         | Yes             | Partners and customers | Yes                         | No                            |
| North America | Canada      | No              | Customers              | Yes                         | Yes                           |
| Europe        | Germany     | Yes             | Partners and customers | No - network only           | Yes                           |
| Asia Pacific  | South Korea | Yes             | Partners               | Yes                         | No                            |

## Relevance of data sovereignty

Around the world, government organizations have begun establishing data sovereignty requirements, like General Data Protection Regulation (GDPR). Compliance requirements of this nature often require localization within a specific region or even within a specific country to protect their citizens. In some cases, data pertaining to customers, employees, or partners must be stored on a cloud platform within the same region as the end user.

Addressing this challenge has been a significant motivation for cloud migrations for companies that operate on a global scale. To maintain compliance requirements, some companies have chosen to deploy duplicate IT assets to cloud providers within the region. In the preceding table, Germany is a good example of this scenario. This example includes customers, partners, and employees but not current IT assents in Germany. This company might choose to deploy some assets to a datacenter within the GDPR area, potentially using the German Azure datacenters. An understanding of the data affected by GDPR would help the cloud adoption team understand the best migration approach in this case.

### Why is the location of end users relevant?

Companies that support end users in multiple countries have developed technical solutions for addressing end-user traffic. In some cases, this involves localization of assets. In other scenarios, the company might choose to implement global wide area network (WAN) solutions to address disparate user bases via network focused solutions. In either case, the migration strategy can be affected by the usage profiles of those disparate end users.

Because the company supports employees, partners, and customers in Germany without currently having datacenters there, this company probably implemented a leased-line solution. This type of solution routes traffic to datacenters in other countries. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting additional hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project.

In each of the following processes, guidance for addressing this complexity is included across prerequisites, assess, migrate, and optimize processes. Understanding user profiles in each country is critical to properly manage this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters can affect a migration strategy. For example:

**Architecture decisions:** The target region is one of the first steps in migration strategy design. This is often influenced by the location of the existing assets. Additionally, the availability of cloud services and the unit cost of those services can vary from one region to the next. Understanding where current and future assets are located affects architecture decisions and can influence budget estimates.

**Datacenter dependencies:** The data in the preceding table shows that dependencies between various global datacenters are likely. Those dependencies might not be documented or understood clearly in many organizations that operate on this type of scale. Your company's approach to evaluating user profiles helps to identify some of these dependencies in your organization. In addition, your team should explore additional assessment steps that can mitigate the risks and complexities that arise from dependencies.

## Implement the general approach

The following approach uses a data-driven model for addressing global migration complexities. When the scope for a migration includes multiple regions, the cloud adoption team should evaluate the following readiness considerations:

- Data sovereignty might require localization of some assets, but many assets might not be governed by those compliance constraints. Things like logging, reporting, network routing, identity, and other central IT services might be eligible to be hosted as shared services across multiple subscriptions, or even multiple regions. The cloud adoption team should evaluate by using a shared service model for those services, as outlined in the [reference architecture for a hub and spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/#hub-spoke-network-topology).
- When you're deploying multiple instances of similar environments, an environment factory can create consistency, improve governance, and accelerate deployment. The [governance guide for complex enterprises](../../govern/guides/complex/index.md) establishes an approach that creates an environment that scales across multiple regions.

When the team is comfortable with the baseline approach and readiness is aligned, you should then consider a few data-driven prerequisites:

- **General discovery:** Complete the [documenting complexity](#document-complexity) table.
- **Perform a user profile analysis on each affected country:** It's important to understand general end-user routing early in the migration process. Changing global lease lines and adding connections like ExpressRoute to a cloud datacenter can require months of networking delays. Address this as early in the process as possible.
- **Initial digital estate rationalization:** Whenever complexity is introduced into a migration strategy, you should complete an initial digital estate rationalization. See the guidance on [digital estate rationalization](../../digital-estate/index.md).
  - **Additional digital estate requirements:** Establish tagging policies to identify any workload affected by data sovereignty requirements. Required tags should begin in the digital estate rationalization and carry through to the migrated assets.
- **Evaluate a hub and spoke model:** Distributed systems often share common dependencies. Those dependencies can often be addressed through the implementation of a hub and spoke model. While such a model is out of scope for the migration process, it should be flagged for consideration during future iterations of the [ready processes](../../ready/index.md).
- **Prioritization of the migration backlog:** When network changes are required to support the production deployment of a workload that supports multiple regions, the cloud strategy team should track and manage escalations regarding those network changes. The higher level of executive support helps to accelerate the change by freeing the strategy team to reprioritize the backlog and ensure that global workloads aren't blocked by network changes. Such workloads should only be prioritized after the network changes are complete.

These prerequisites help establish processes that can address this complexity during execution of the migration strategy.

## Assess process changes

When facing global asset and user base complexities in migration scenarios, you should add a few key activities to assessing your migration candidates. These activities produce data to clarify obstacles and outcomes for global users and assets.

### Suggested action during the assess process

**Evaluate cross-datacenter dependencies:** The [dependency visualization tools in Azure Migrate](/azure/migrate/concepts-dependency-visualization) can help pinpoint dependencies. Using these tools before migration is a best practice. When dealing with global complexity, it becomes a necessary step to the assessment process. Through [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies), the visualization can help identify the IP addresses and ports of any assets required to support the workload.

> [!IMPORTANT]
>
> - A subject matter expert with an understanding of asset placement and IP address schemas is required to identify assets that reside in a secondary datacenter.
> - Evaluate both downstream dependencies and clients in the visualization to understand bidirectional dependencies.

**Identify global user impact:** The outputs from the prerequisite user profile analysis should identify any workload affected by global user profiles. When a migration candidate is in the affected workload list, the architect preparing for migration should consult networking and operations subject matter experts. They help to validate network routing and performance expectations. At a minimum, the architecture should include an ExpressRoute connection between the closest network operations center and Azure. The [reference architecture for ExpressRoute](/azure/architecture/reference-architectures/hybrid-networking/expressroute) connections can aid in the configuration of the necessary connection.

**Design for compliance:** The outputs from the prerequisite user profile analysis should identify any workload affected by data sovereignty requirements. During the architecture activities of the assess process, the assigned architect should consult compliance subject matter experts. They help to understand any requirements for migration and deployment across multiple regions. Those requirements significantly affect design strategies. The reference architectures for [multiregion web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server) can assist design.

> [!WARNING]
> When you're using either of the reference architectures above, it might be necessary to exclude specific data elements from replication processes to adhere to data sovereignty requirements. This will add an additional step to the promotion process.

## Migration process changes

When you're migrating an application that must be deployed to multiple regions, the cloud adoption team must account for a few considerations. These consist of Azure Site Recovery vault design, configuration and process server design, network bandwidth designs, and data synchronization.

### Suggested action during the migration process

**Azure Site Recovery vault design:** Azure Site Recovery is the suggested tool for cloud-native replication and synchronization of digital assets to Azure. Site Recovery replicates data about the asset to a Site Recovery vault, which is bound to a specific subscription in a specific region and Azure datacenter. When you're replicating assets to a second region, you might also need a second Site Recovery vault.

**Configuration and process server design:** Site Recovery works with a local instance of a configuration and process server, which is bound to a single Site Recovery vault. This means that you might need to install a second instance of these servers in the source datacenter to facilitate replication.

**Network bandwidth design:** During replication and ongoing synchronization, you move binary data over the network, from the source datacenter to the Site Recovery vault in the target Azure datacenter. This process consumes bandwidth. Duplication of the workload to a second region doubles the amount of bandwidth consumed. When bandwidth is limited or a workload involves a large amount of configuration or data drift, it can interfere with the time required to complete the migration. More importantly, it can affect the experience of users or applications that still depend on the bandwidth of the source datacenter.

**Data synchronization:** Often the largest bandwidth drain comes from synchronization of the data platform. As defined in the reference architectures for [multiregion web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server), data synchronization is often required to keep the applications aligned. If this is the desired operational state of the application, it might be wise to complete a synchronization between the source data platform and each of the cloud platforms. You should do this before migrating the application and middle tier assets.

**Azure-to-Azure disaster recovery:** An alternative option can reduce complexity further. If timelines and data synchronization approach a two-step deployment, [Azure-to-Azure disaster recovery](/azure/site-recovery/azure-to-azure-architecture) might be an acceptable solution. In this scenario, you migrate the workload to the first Azure datacenter by using a single Site Recovery vault and configuration or process server design. After you test the workload, you can recover it to a second Azure datacenter from the migrated assets. This approach reduces the impact to resources in the source datacenter and takes advantage of faster transfer speeds and high bandwidth limits available between Azure datacenters.

> [!NOTE]
> This approach can increase short-term migration costs through additional egress bandwidth charges.

## Optimize and promote process changes

As you address global complexity during optimization and promotion, you might require duplicated efforts in each of the additional regions. When a single deployment is acceptable, you might still need to duplicate business testing and business change plans.

### Suggested action during the optimize and promote process

**Pretest optimization:** Initial automation testing can identify potential optimization opportunities, as with any migration effort. In the case of global workloads, test the workload in each region independently. Minor configuration changes in the network or the target Azure datacenter can affect performance.

**Business change plans:** For any complex migration scenario, create a business change plan. This ensures clear communication regarding any changes to business processes, user experiences, and the timing of efforts required to integrate the changes. In the case of global migration efforts, the plan should include considerations for end users in each affected geography.

**Business testing:** In conjunction with the business change plan, business testing might be required in each region. This ensures adequate performance and adherence to the modified networking routing patterns.

**Promotion flights:** Often promotion happens as a single activity, rerouting production traffic to the migrated workloads. In the case of global release efforts, you should deliver promotion in flights (or predefined collections of users). This allows the cloud strategy team and the cloud adoption team to better observe performance and improve support of users in each region. Promotion flights are often controlled at the networking level by changing the routing of specific IP ranges from the source workload assets to the newly migrated assets. After a specified collection of end users have been migrated, the next group can be rerouted.

**Flight optimization:** One of the benefits of promotion flights is that it allows for deeper observations and additional optimization of the deployed assets. After a brief period of production usage by the first flight, additional refinement of the migrated assets is suggested, when allowed by IT operation procedures.
