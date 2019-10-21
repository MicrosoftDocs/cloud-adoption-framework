---
title: "Regions decision guide"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn about cloud platform region selections.
author: doodlemania2
ms.author: dermar
ms.date: 10/17/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: governance
---

# Azure regions

Azure is comprised of many regions around the world. Each of the [Azure regions](https://azure.microsoft.com/global-infrastructure/regions) have a specific set of characteristics that make selecting which region to use incredibly important.

1. **Available services:** Services that are deployed to each region differ based on a variety of factors. You will need to select a region to deploy your workload to that contains your desired service. For more information about which services are available in which regions, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services).
1. **Capacity:** Each region has a maximum capacity. While this is typically abstracted away from the end user, it can impact which types of subscriptions are able to deploy which types of services and under what circumstances. This is different that subscription quotas. If you are planning a massive datacenter migration to Azure, you may want to consult with your local Azure field team or account manager to confirm you are able to deploy at the scale necessary.
1. **Constraints:** Certain constraints are placed on the deployment of services in certain regions. For example, some regions are only available as a backup or failover target. Other constraints that are important to note are [data sovereignty requirements](https://azure.microsoft.com/global-infrastructure/geographies).
1. **Sovereignty:** There are specific regions dedicated to specific sovereign entities. While all regions are Azure regions, these sovereign regions are completely isolated from the rest of Azure, are not necessarily managed by Microsoft, and may carry customer type constraints. These sovereign regions are:
    1. [Azure China](https://azure.microsoft.com/global-infrastructure/china)
    1. [Azure Germany](https://azure.microsoft.com/global-infrastructure/germany) (deprecating in favor of standard Azure German regions (nonsovereign))
    1. [Azure US Government](https://azure.microsoft.com/global-infrastructure/government)
    1. Note: there are two regions in [Australia](https://azure.microsoft.com/global-infrastructure/australia) that are managed by Microsoft but are provided for the Australian government and its customers and contractors, and therefore carry similar client constraints to the other sovereign clouds.

## Operating in multiple geographic regions

When businesses operate in multiple geographic regions, while essential for resiliency, additional complexity can be introduced. These complexities manifest in four primary forms:

- Asset distribution
- User access profiles
- Compliance requirements
- Regional resiliency

As we consider the above complexities further, you will begin to understand how important regional selection is to your overall cloud adoption strategy. Let's start with network considerations.

## Networking considerations

Any robust cloud deployment requires a well-considered network that takes into account Azure regions. After considering the above characteristics for which regions to deploy to, the network must be deployed. While an exhaustive discussion on networking is beyond the scope of this article, some considerations must be accounted for:

1. Azure regions are deployed in pairs. In the event of a catastrophic failure of a region, another region within the same geopolitical boundary* is designated as its paired region. Thought should be given to deployment into paired regions as a primary and secondary resiliency strategy. *Azure Brazil is a notable exception whose paired region happens to be US South Central. For more, see [here](https://docs.microsoft.com/en-us/azure/best-practices-availability-paired-regions).
    1. Azure Storage supports [Geographically Redundant Storage (GRS)](https://docs.microsoft.com/azure/storage/common/storage-redundancy-grs) which means three copies of your data are stored within your primary region and three additional copies are stored in the paired region. You cannot change the storage pairing for GRS.
    1. Services that rely on Azure Storage GRS can take advantage of this paired region capability. To do so, your applications and the network must be oriented to support that.
    1. If you don't plan to leverage GRS to support your regional resiliency needs, it is suggested that you do _NOT_ leverage the paired region as your secondary. In the event of a regional failure, there will be intense pressure on resources in the paired region as resources migrate. Avoiding that pressure can provide you with additional speed during your recovery by recovering to an alternate site.
    > [!WARNING]
    > Do not attempt to leverage Azure GRS for VM backups or recovery. Instead, leverage [Azure Backup](https://azure.microsoft.com/services/backup) and [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery) along with [Managed Disks](https://docs.microsoft.com/azure/virtual-machines/windows/managed-disks-overview) to support your IaaS workload resiliency.
2. Azure Backup and Azure Site Recovery work in tandem with your network design to facilitate regional resiliency for your IaaS and data backup needs. Make sure the network is optimized so data transfers remain on the Microsoft backbone and leverage [VNet Peering](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview) if possible. Some larger organizations with global deployments may instead use [ExpressRoute Premium](https://docs.microsoft.com/azure/expressroute/expressroute-introduction) to route traffic between regions which can save regional egress charges.
3. Azure resource groups are regional specific constructs. It is normal, however, for resources within a resource group to span multiple regions. When doing so, it is important to consider that in the event of a regional failure, control plane operations against a resource group will fail in the affected region, even though the resources in other regions (within that resource group) will continue to operate. This can impact both your network and your resource group design.
4. Many PaaS services within Azure support [Service Endpoints](https://docs.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview) or [Private Link](https://docs.microsoft.com/azure/private-link/private-link-overview). Both of these solutions impact your network considerations substantially when considering regional resiliency, migration and governance.
5. Many PaaS services rely on their own regional resiliency solutions. For example, Azure SQL Database allows you to easily replicate to N additional regions as does Cosmos DB. Some services carry no region dependency like Azure DNS. As you consider which services you will be leveraging in your adoption process, make sure to clearly understand the failover capabilities and recovery steps that may be required for each Azure service.
6. In addition to deploying into multiple regions to support disaster recovery, many organizations choose to deploy in an Active-Active pattern so that no failover is necessary. This has the added benefit of providing global load balancing and additional fault tolerance and network performance boosts. To take advantage of this pattern, your applications must support running Active-Active in multiple regions.

> [!WARNING]
> Azure regions are highly available constructs with SLAs applied to the services running in them. However, you should never take a single region dependency on mission critical applications. Always plan for regional failure and practice recovery and mitigation steps.

After considering the network topology that will be required to keep you up and running, additional documentation and process alignment will be necessary. The following approach can help assess the potential challenges and establish a general course of action:

- Consider a more robust readiness and governance implementation.
- Inventory the affected geographies. Compile a list of the regions and countries that are affected.
- Document data sovereignty requirements. Do the countries identified have compliance requirements that govern data sovereignty?
- Document the user base. Will employees, partners, or customers in the identified country be affected by the cloud migration?
- Document datacenters and assets. Are there assets in the identified country that might be included in the migration effort?
- Document regional SKU availability and failover requirements.

Align changes across the migration process to address the initial inventory.

## Documenting complexity

The following table can aid in documenting the findings from the steps above:

|Region  |Country  |Local Employees  |Local External Users  |Local Datacenters or Assets |Data Sovereignty Requirements  |
|---------|---------|---------|---------|---------|---------|
|North America     |USA         |Yes         |Partners and customers         |Yes         |No         |
|North America     |Canada         |No         |Customers         |Yes         |Yes         |
|Europe     |Germany         |Yes         |Partners and customers         |No - Network only         |Yes         |
|Asia Pacific     |South Korea         |Yes         |Partners         |Yes         |No         |

<!-- markdownlint-disable MD026 -->

## Data sovereignty relevancy

Around the world, government organizations have begun establishing data sovereignty requirements, like General Data Protection Regulation (GDPR). Compliance requirements of this nature often require localization within a specific region or even within a specific country to protect their citizens. In some cases, data pertaining to customers, employees, or partners must be stored on a cloud platform within the same region as the end user.

Addressing this challenge has been a significant motivation for cloud migrations for companies that operate on a global scale. To maintain compliance requirements, some companies have chosen to deploy duplicate IT assets to cloud providers within the region. In the example table above, Germany would be a good example of this scenario. In this example, there are customer, partners, and employees in Germany, but no existing IT assets. This company may choose to deploy some assets to a datacenter within the GDPR area, potentially even using the German Azure datacenters. An understanding of the data affected by GDPR would help the cloud adoption team understand the best migration approach in this case.

### Why is the location of end users relevant?

Companies that support end users in multiple countries have developed technical solutions for addressing end-user traffic. In some cases, this involves localization of assets. In other scenarios, the company may choose instead to implement global WAN solutions to address disparate user bases via network focused solutions. In either case, the migration strategy could be affected by the usage profiles of those disparate end users.

Since the company supports employees, partners, and customers in Germany but there are no datacenters currently in that country, it's likely that this company has implemented some form of leased-line solution to route that traffic to datacenters in other countries. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting additional hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project. In each of the processes below, guidance for addressing this complexity is included across prerequisites, assess, migrate, and optimize processes. Understanding user profiles in each country is critical to properly manage this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters can affect a migration strategy. THe following are a few of the most common impacts:

**Architecture decisions:** Target region/location is one of the first steps in migration strategy design. This is often influenced by the location of the existing assets. Additionally, the available of cloud services and the unit cost of those services can vary from one region to the next. As such, understanding the current and future location of assets affects the architecture decisions and can also affect budget estimates.

**Datacenter dependencies:** Based on the data in the table above, it's likely that dependencies exist between the various datacenters around the globe. In many organizations that operate on this type of scale, those dependencies may not be documented or well understood. The approaches used to evaluate user profiles will help identify some of these dependencies. However, additional steps are suggested during the assess process to mitigate risks associated with this complexity.

## Implementing the general approach

This approach is driven by quantifiable information. As such, the following approach will follow a data-driven model for addressing the global migration complexities.

When scope for a migration includes multiple regions, the following readiness considerations should be evaluated by the cloud adoption team:

- Data sovereignty might require localization of some assets, but there are a many assets that may not be governed by those compliance constraints. Things like logging, reporting, network routing, identity, and other central IT services may be eligible to be hosted as shared services across multiple subscriptions or even multiple regions. It is advised that the cloud adoption team evaluate a share service model to those services, as outlined in the [reference architecture for a hub and spoke topology with shared services](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/shared-services)
- When deploying multiple instances of similar environments, an environment factory could create consistency, improve governance, and accelerate deployment. The [governance guide for complex enterprises](../../govern/guides/complex/index.md) establishes an approach that creates an environment that scales across multiple regions.

Once the team is comfortable with the baseline approach and readiness is aligned, there are a few data-driven prerequisites to consider:

- **General discovery:** Complete the [Documenting complexity](#documenting-complexity) table above.
- **Perform a user profile analysis on each affected country:** It is important to understand general end-user routing early in the migration process. Changing global lease lines and adding connections like ExpressRoute to a cloud datacenter can require months of networking delays. Address this as early in the process as possible.
- **Initial digital estate rationalization:** Whenever complexity is introduced into a migration strategy, an initial digital estate rationalization should be completed. See the guidance on [digital estate rationalization](../../digital-estate/index.md) for assistance.
  - **Additional digital estate requirements:** Establish tagging policies to identify any workload affected by data sovereignty requirements. Required tags should begin in the digital estate rationalization and carry through to the migrated assets.
- **Evaluate a hub and spoke model:** Distributed systems often share common dependencies. Those dependencies can often be addressed through the implementation of a hub and spoke model. While such a model is out of scope for the migration process, it should be flagged for consideration during future iterations of the [Ready processes](../../ready/index.md).
- **Prioritization of the migration backlog:** When network changes are required to support the production deployment of a workload that supports multiple regions, it is important for the cloud strategy team to track and manage escalations regarding those network changes. The higher level of executive support will aid in accelerating the change. However, the more important impact is that it gives the strategy team an ability to reprioritize the backlog to ensure that global workloads aren't blocked by network changes. Such workloads should only be prioritized, after the network changes are complete.

These prerequisites will help establish processes that can address this complexity during execution of the migration strategy.

## Assess process changes

When dealing with global asset and user base complexities, there are a few key activities that should be added to the assessment of any migration candidate. Each of these changes will bring clarity to the impact on global users and assets, through a data driven approach.

### Suggested action during the assess process

**Evaluate cross datacenter dependencies:** The [dependency visualization tools in Azure Migrate](https://docs.microsoft.com/azure/migrate/concepts-dependency-visualization) can help pinpoint dependencies. Use of this tool set prior to migration is a good general best practice. However, when dealing with global complexity it becomes a necessary step to the assessment process. Through [dependency grouping](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies), the visualization can help identify the IP addresses and ports of any assets required to support the workload.

> [!IMPORTANT]
> Two important notes: First, a subject matter expert with an understanding of asset placement and IP address schemas is required to identify assets that reside in a secondary datacenter. Second, it is important to evaluate both downstream dependencies and Clients in the visual to understand bidirectional dependencies.

**Identify global user impact:** The outputs from the prerequisite user profile analysis should identify any workload affected by global user profiles. When a migration candidate is in the affected workload list, the architect preparing for migration should consult networking and operations subject matter experts to validate network routing and performance expectations. At minimum, the architecture should include an ExpressRoute connection between the closest network operations center (NOC) and Azure. The [reference architecture for ExpressRoute](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/expressroute) connections can aid in configuration of the necessary connection.

**Design for compliance:** The outputs from the prerequisite user profile analysis should identify any workload affected by data sovereignty requirements. During the architecture activities of the Assess process, the assigned architect should consult compliance subject matter experts to understand any requirements for migration/deployment across multiple regions. Those requirements will significantly affect design strategies. The reference architectures for [multiregion web applications](https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](https://docs.microsoft.com/azure/architecture/reference-architectures/n-tier/multi-region-sql-server) can aid in design.

> [!WARNING]
> When using either of the reference architectures above, it may be necessary to exclude specific data elements from replication processes to adhere to data sovereignty requirements. This will add an additional step to the promotion process.

## Migrate process changes

When migrating an application that must be deployed to multiple regions, there are a few considerations the cloud adoption team must take into account. These considerations consist of Azure Site Recovery vault design, configuration/process server design, network bandwidth designs, and data synchronization.

### Suggested action during the migrate process

**Azure Site Recovery vault design:** Azure Site Recovery is the suggested tool for cloud-native replication and synchronization of digital assets to Azure. Site Recovery replicates data about the asset to a Site Recovery vault, which is bound to a specific subscription in a specific region and Azure datacenter. When replicating assets to a second region, a second Site Recovery vault may be required.

**Configuration/process server design:** Site Recovery works with a local instance of a configuration and process server, which is bound to a single Site Recovery vault. This means that a second instance of these servers may need to be installed in the source datacenter to facilitate replication.

**Network bandwidth design:** During replication and ongoing synchronization, binary data is moved over the network from the source datacenter to the Site Recovery vault in the target Azure datacenter. This process consumes bandwidth. Duplication of the workload to a second region will double the amount of bandwidth consumed. When bandwidth is limited or a workload involves a large amount of configuration or data drift, it can interfere with the time required to complete the migration. More importantly, it could affect the experience of users or applications that still depend on the bandwidth of the source datacenter.

**Data synchronization:** Often the largest bandwidth drain comes from synchronization of the data platform. As defined in the reference architectures for [multiregion web applications](https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](https://docs.microsoft.com/azure/architecture/reference-architectures/n-tier/multi-region-sql-server), data synchronization is often required to keep the applications aligned. If this is the desired operational state of the application, it may be wise to complete a synchronization between the source data platform and each of the cloud platforms before migrating the application and middle tier assets.
**Data synchronization:** Often the largest bandwidth drain comes from synchronization of the data platform. As defined in the reference architectures for [multiregion web applications](https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](https://docs.microsoft.com/azure/architecture/reference-architectures/n-tier/multi-region-sql-server), data synchronization is often required to keep the applications aligned. If this is the desired operational state of the application, it may be wise to complete a synchronization between the source data platform and each of the cloud platforms before migrating the application and middle tier assets.

**Azure to Azure disaster recovery:** There is an alternative option that may reduce complexity further. If timelines and data synchronization approaches approach a two-step deployment, [Azure to Azure disaster recovery](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-architecture) could be an acceptable solution. In this scenario, the workload is migrated to the first Azure datacenter using a single Site Recovery vault and configuration or process server design. Once the workload is tested, it can then be recovered to a second Azure datacenter from the migrated assets. This approach reduces the impact to resources in the source datacenter and takes advantage of faster transfer speeds and high bandwidth limits available between Azure datacenters.

> [!NOTE]
> This approach may increase the short-term cost of migration, because it could result in additional egress bandwidth charges.

## Optimize and promote process changes

Addressing global complexity during optimization and promotion could require duplicated efforts in each of the additional regions. When a single deployment is acceptable, duplication of business testing and business change plans may still be required.

### Suggested action during the optimize and promote process

**Pretest optimization:** Initial automation testing can identify potential optimization opportunities, as with any migration effort. In the case of global workloads, it is important to test the workload in each region independently, as minor configuration changes in the network or the target Azure datacenter could affect performance.

**Business Change Plans:** For any complex migration scenario, it is advised that a business change plan be created to ensure clear communication regarding any changes to business processes, user experiences, and timing of the efforts required to integration the changes. In the case of global migration efforts, the plan should include considerations for end users in each affected geography.

**Business testing:** In conjunction with the business change plan, business testing may be required in each region to ensure adequate performance and adherence to the modified networking routing patterns.

**Promotion flights:** Often promotion happens as a single activity, rerouting production traffic to the migrated workloads. In the case of global release efforts, it is advised that promotion be delivered in flights (or predefined collections of users). This allows the cloud strategy team and the cloud adoption team to better observe performance and improve support of users in each region. Promotion flights are often controlled at the networking level by changing the routing of specific IP ranges from the source workload assets to the newly migrated assets. After a specified collection of end users have been migrated, the next group can be rerouted.

**Flight optimization:** One of the benefits of promotion flights, is that it allows for deeper observations and additional optimization of the deployed assets. After a brief period of production usage by the first flight, additional refinement of the migrated assets is suggested, when allowed by IT operation procedures.
