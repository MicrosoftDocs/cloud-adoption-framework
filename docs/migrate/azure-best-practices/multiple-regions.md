---
title: Select Azure regions for a migration
description: Learn about selecting a cloud region for a workload migration to Azure. See suggested actions for assessment, migration, and other processes.
author: johndowns
ms.author: jodowns
ms.reviewer: tozimmergren
ms.date: 10/20/2023
ms.topic: conceptual
ms.custom: internal, engagement-fy23
---

# Select Azure regions for a migration

When you migrate an existing environment to Azure, you need to select an Azure region or set of regions to host the migrated components. Consider the following steps:

- **Review the [core Azure region selection guidance](../../ready/azure-setup-guide/regions.md)** to understand how to select Azure regions that meet your requirements.
- **Inventory and document the current state** of your environment.
- **Implement a general approach** to your migration, including whether to run in a single region, use multiple availability zones, or use multiple regions.
- **Assess process changes** that might be required.
- **Plan a migration process**.
- **Optimize and promote process changes**.

This article provides some guidance on how to choose Azure regions that meet your migration needs.

> [!NOTE]
> This article covers considerations that are specific to workload migrations. You should also understand general principles for selecting Azure regions for any organization or workload. For more information, see [Select Azure regions](../../ready/azure-setup-guide/regions.md).

## Document your scenario complexity

Determine whether documentation and process alignment is required. The following approach can help you assess potential challenges and establish a general course of action:

- Consider a more robust readiness and governance implementation.
- Inventory the affected geographies. Compile a list of the countries/regions that are affected.
- Document data sovereignty requirements. Do the identified countries/regions have compliance requirements that govern data sovereignty?
- Document the user base. Will the cloud migration affect employees, partners, or customers in the identified country/region?
- Document datacenters and assets. Are there assets in the identified country/region that might be included in the migration effort?
- Document regional SKU availability and failover requirements.
- Document your resiliency requirements to determine whether availability zones are required. Typically, resiliency requirements are considered for the whole scenario, not for individual regions.

Align changes throughout the migration process to address the initial inventory. The following table shows example scenarios that can help you document your findings:

| Region        | Country/region | Local employees | Local external users   | Local datacenters or assets | Data sovereignty requirements |
|---------------|----------------|-----------------|------------------------|-----------------------------|-------------------------------|
| North America | United States  | Yes             | Partners and customers | Yes                         | No                            |
| North America | Canada         | No              | Customers              | Yes                         | Yes                           |
| Europe        | Germany        | Yes             | Partners and customers | No - network only           | Yes                           |
| Asia Pacific  | South Korea    | Yes             | Partners               | Yes                         | No                            |

### Why is the location of users relevant?

Organizations that support users in multiple countries/regions have developed technical solutions that address user traffic. In some cases, solutions involve localization of assets. In other scenarios, the organization might choose to implement global wide area network (WAN) solutions to address disparate user bases through network-focused solutions. In either case, the usage profiles of disparate users can affect the migration strategy.

If an organization supports employees, partners, and customers in Germany without currently having datacenters in Germany, the organization probably implements a leased-line solution. This type of solution routes traffic to datacenters in other countries/regions. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting more hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project.

In each of the following processes, guidance for addressing this complexity is included across prerequisites and processes of assessing, migrating, and optimizing. Understanding user profiles in each country/region is critical for properly managing this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters can affect a migration strategy. Consider the following factors:

**Architecture decisions**: One of the first steps in migration strategy design is to determine the target region. The location of existing assets often influences this determination. Also, the availability of cloud services and the unit cost of those services can vary between regions. Understanding where current and future assets are located affects architecture decisions and can influence budget estimates.

**Datacenter dependencies**: The example scenarios in the table in [Document complexity](#document-your-scenario-complexity) show that you likely need to plan for dependencies between various global datacenters. The dependencies might not be documented or understood clearly in many organizations that operate on this scale. Your organization's approach to evaluating user profiles helps you identify some of these dependencies in your organization. Your team should also explore more assessment steps that can help mitigate the risks and complexities that arise from dependencies.

## Implement a general approach

The following approach uses a data-driven model to address global migration complexities. When the scope for a migration includes multiple regions, the cloud adoption team should evaluate the following readiness considerations:

- Determine whether you can meet your business requirements for high availability, resiliency, performance, and cost by using multiple availability zones. If not, determine whether you need to consider a multi-region approach.
- Data sovereignty can require localization of some assets, but many assets aren't governed by those compliance constraints. Services like logging, reporting, network routing, identity, and other central IT services might be eligible to be hosted as shared services across multiple subscriptions or multiple regions. The cloud adoption team should evaluate data sovereignty by using a shared service model for those services. For an outline of this approach, see the [reference architecture for a hub-spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).
- When you deploy multiple instances of similar environments, using an environment factory can help create consistency, improve governance, and accelerate deployment. The [governance guide for complex enterprises](../../govern/guides/complex/index.md) establishes an approach that creates an environment that scales across multiple regions.

### Data-driven prerequisites

When your team is comfortable with the baseline approach and readiness is aligned, consider a few data-driven prerequisites:

- **Complete general discovery**: Complete the table in [Document complexity](#document-your-scenario-complexity) to evaluate the complexity of your cloud adoption strategy.
- **Analyze user profiles on each affected country/region**: It's important to understand general user routing early in the migration process. Changing global lease lines and adding connections like Azure ExpressRoute to a cloud datacenter can result in months of networking delays. Address user routing as early in the process as possible.
- **Complete an initial digital estate rationalization**: When complexity is introduced in a migration strategy, you should complete an initial digital estate rationalization. For more information, see [What is a digital estate?](../../digital-estate/index.md).
- **Use tagging for digital estate requirements**: Establish tagging policies to identify any workload that's affected by data sovereignty requirements. Required tags should begin in digital estate rationalization and carry through to migrated assets.
- **Evaluate a hub-spoke model**: Distributed systems often share common dependencies. Often, you can address shared dependencies by implementing a hub-spoke model. Although implementing a hub-spoke model is out of scope for the migration process, flag the model for consideration during future iterations of the [ready processes](../../ready/index.md).
- **Prioritize the migration backlog**: When network changes are required to support production deployment of a workload that supports multiple regions, the cloud strategy team should track and manage escalations that result from the network changes. The higher level of executive support helps accelerate the change by freeing the strategy team to reprioritize the backlog and ensure that network changes don't block global workloads. Prioritize global workloads only when network changes are finished.

These prerequisites help establish processes that can address complexity during execution of the migration strategy.

## Assess process changes

When your organization faces global asset and user base complexities in a migration scenario, you should add a few key activities to assess your migration candidates. These activities produce data to clarify obstacles and outcomes for global users and assets.

### Suggested actions during the assess process

**Evaluate cross-datacenter dependencies**: The [dependency visualization tools in Azure Migrate and Modernize](/azure/migrate/concepts-dependency-visualization) can help you pinpoint dependencies. A best practice is to use these tools before you begin migration. When global complexity is involved, it becomes a necessary step in the assessment process. Through [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies), dependency visualization can help you identify the IP addresses and ports of any assets that are required to support the workload.

> [!IMPORTANT]
>
> - A subject matter expert (SME) who has an understanding of asset placement and IP address schemas is required to identify assets that are located in a secondary datacenter.
> - Evaluate both downstream dependencies and clients in the visualization to understand bidirectional dependencies.

**Identify global user impact**: The output from the prerequisite user profile analysis should identify any workload that's affected by global user profiles. When a migration candidate is in the list of affected workloads, the migration architect should consult networking and operations SMEs. These experts help validate network routing and performance expectations. At a minimum, the architecture should include an ExpressRoute connection between the closest network operations center and Azure. The [reference architecture for ExpressRoute connections](/azure/architecture/reference-architectures/hybrid-networking/expressroute) can help you configure the necessary network connections.

**Design for compliance**: The output from the prerequisite user profile analysis should also identify any workload that's affected by data sovereignty requirements. During the architecture activities of the assess process, the assigned architect should consult compliance SMEs. These experts can help the architect understand any requirements for migration and deployment across multiple regions. Those requirements significantly affect design strategies. The following reference architectures can help with the design:

- [Zone-redundant web applications](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)
- [Multi-region web applications](/azure/architecture/web-apps/app-service/architectures/multi-region)
- [Multi-region n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server)

> [!WARNING]
> When you use the reference architecture for ExpressRoute or the reference architectures for applications, you might need to exclude specific data elements from replication processes to meet data sovereignty requirements. The task of excluding specific data elements adds a step to the promotion process.

## Migration process changes

When you migrate an application that must be deployed to multiple regions, the cloud adoption team must account for a few more considerations. The design of Azure Site Recovery vaults and configuration and process servers are two of those considerations. Two others are network bandwidth designs and data synchronization.

### Suggested actions during the migration process

**Site Recovery vault design**: Site Recovery is the suggested tool for cloud-native replication and synchronization of digital assets to Azure. Site Recovery replicates data about each asset to a Site Recovery vault, which is bound to a specific subscription in a specific region and Azure datacenter. When you replicate assets to a second region, you might also need a second Site Recovery vault.

**Configuration and process server design**: Site Recovery works with a local instance of a configuration and process server, which is bound to a single Site Recovery vault. When you use the configuration, you might need to install second instances of these servers in the source datacenter to facilitate replication.

**Network bandwidth design**: During replication and ongoing synchronization, you move binary data over the network, from the source datacenter to the Site Recovery vault in the target Azure datacenter. The process of replication and synchronization consumes bandwidth. Duplicating the workload to a second region doubles the amount of bandwidth that's consumed. In some scenarios, bandwidth is limited. In others, a workload involves substantial configuration or data drift. In these cases, replicating data to a second region can interfere with the time that it takes to complete the migration. More importantly, these constraints can affect the experience of users or applications that still depend on the bandwidth that was available in the source datacenter.

**Data synchronization**: Often, the largest bandwidth drain comes from synchronizing the data platform. If you deploy across multiple availability zones, you might be able to use zone-redundant data services that automatically synchronize your data across multiple availability zones. If you deploy across multiple regions, data synchronization is often required to keep applications aligned. This approach is defined in the reference architectures for [multi-region web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multi-region n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server). If keeping applications synchronized is the operational state you want for your applications, you might want to synchronize the source data platform with each cloud platform. You should do this sync before you migrate the application and middle-tier assets.

**Azure-to-Azure disaster recovery**: An alternative option might reduce complexity further. If you use a two-step deployment to meet timeline and data synchronization needs, [Azure-to-Azure disaster recovery](/azure/site-recovery/azure-to-azure-architecture) might be an acceptable solution. In this scenario, you migrate the workload to the first Azure datacenter by using a single Site Recovery vault and configuration or process server design. After you test the workload, you can recover the workload to a second Azure datacenter from the migrated assets. This approach reduces the effect on resources in the source datacenter and takes advantage of fast transfer speeds and high bandwidth limits between Azure datacenters.

> [!NOTE]
> The Azure-to-Azure disaster recovery approach can increase short-term migration costs through higher egress bandwidth charges.

## Optimize and promote process changes

As you address global complexity during optimization and promotion, you might require identical efforts in each region that you deploy to. If you use a single region, you might still need to replicate business testing and business change plans.

### Suggested actions during the optimize and promote process

**Pretest optimization**: Initial automation testing can identify potential optimization opportunities, as with any migration effort. For global workloads, independently test the workload in each region. Minor configuration changes in your network or in the Azure datacenter that you choose can affect performance.

**Business change plans**: For any complex migration scenario, create a business change plan. Using a business change plan helps ensure clear communication about changes to business processes and user experiences. It also helps ensure clear communication about the timing of efforts that are required to integrate changes. In a global migration effort, the plan should include considerations for users in each affected geography.

**Business testing**: In addition to a business change plan, business testing might be required in each region. Business testing helps ensure adequate performance and adherence to modified network routing patterns.

**Promotion flights**: Often, promotion happens as a single activity, and production traffic is immediately rerouted to the migrated workloads. In a global release effort, you should deliver promotion in *flights*, which are predefined collections of users. Using promotion flights gives the cloud strategy team and the cloud adoption team an opportunity to observe performance and improve support for users in each region. You can control promotion flights at the networking level. Specifically, you can change the routing of specific IP ranges from the source workload assets to the newly migrated assets. After a specified collection of users are migrated, the next group can be rerouted.

**Flight optimization**: One of the benefits of using promotion flights is that you have deeper observations and an opportunity to optimize the deployed assets. After the first flight successfully uses production for a brief time, you can refine the migrated assets when IT operation procedures support it.
