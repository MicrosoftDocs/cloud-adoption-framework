---
title: Select Azure regions for a migration
description: Learn how to select a cloud region for a workload migration to Azure. Find suggested actions for assessment, migration, and other processes.
author: johndowns
ms.author: pnp
ms.reviewer: tozimmergren
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Select Azure regions for a migration

When you migrate an existing environment to Azure, you need to select an Azure region or set of regions to host the migrated components. Region selection involves the following high-level steps:

- **Review the [core Azure region selection guidance](../../ready/azure-setup-guide/regions.md)** to understand how to select Azure regions that meet your requirements.
- **Inventory and document the current state** of your environment.
- **Implement a general approach** to your migration, including whether to run in a single region, use multiple availability zones, or use multiple regions.
- **Assess process changes** that might be required.
- **Plan a migration process**.
- **Optimize and promote process changes**.

This article provides guidance on how to choose Azure regions that meet your migration needs. If you haven't already, you might need to extend your [landing zone regions](/azure/cloud-adoption-framework/ready/considerations/regions) to support multi-region approaches.

> [!NOTE]
> This article covers considerations that are specific to workload migrations. You should also understand general principles for selecting Azure regions for any organization or workload. For more information, see [Select Azure regions](../../ready/azure-setup-guide/regions.md).

## Document your scenario complexity

Determine whether your scenario requires documentation and process alignment. The following approach can help you assess potential challenges and establish a general course of action:

- **Consider a more robust readiness and governance implementation**.
- **Inventory the affected geographies**. Compile a list of the affected countries or regions.
- **Document the user base**. Will the cloud migration affect employees, partners, or customers in the identified country or region?
- **Document datacenters and assets**. Does the migration effort include any assets in the identified country or region?
- **Document regional product version availability and failover requirements**.
- **Document your resiliency requirements** to determine whether availability zones are required. Typically, you consider resiliency requirements for the whole scenario, not for individual regions.
- **Document your sovereignty requirements and data residency requirements**. Workloads that have specific sovereignty or data residency requirements might influence your choice of Azure regions.

Throughout the migration process, consider how to align changes across your various scenarios and inventories. The following table shows an example of how to document various scenarios.

| Region        | Country/region | Local employees | Local external users   | Local datacenters or assets | Data sovereignty requirements |
|---------------|----------------|-----------------|------------------------|-----------------------------|-------------------------------|
| North America | United States  | Yes             | Partners and customers | Yes                         | No                            |
| North America | Canada         | No              | Customers              | Yes                         | Yes                           |
| Europe        | Germany        | Yes             | Partners and customers | No - network only           | Yes                           |
| Asia Pacific  | South Korea    | Yes             | Partners               | Yes                         | No                            |

### Why is the location of users relevant?

Organizations that support users in multiple countries or regions develop technical solutions that address user traffic. In some cases, solutions involve localization of assets. In other scenarios, the organization might choose to implement global wide area network (WAN) solutions to address disparate user bases through network-focused solutions. In either case, the usage profiles of disparate users can affect the migration strategy.

For example, if an organization supports employees, partners, and customers in Germany but doesn't currently have datacenters in Germany, the organization probably implements a *leased-line* solution. This type of solution routes traffic to datacenters in other countries or regions. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting more hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project.

Each of the following sections includes guidance for addressing this complexity across prerequisites and processes of assessing, migrating, and optimizing. Understanding user profiles in each country or region is critical for properly managing this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters can affect a migration strategy. Consider the following factors:

**Architecture decisions**: One of the first steps in migration strategy design is to determine the target region. The location of existing assets often influences this determination. Also, the availability of cloud services and the unit cost of those services can vary between regions. Data residency requirements, including sovereignty requirements, might also influence the architecture decision. Understanding where current and future assets are located affects architecture decisions and can influence budget estimates.

**Datacenter dependencies**: In the table in the [Document your scenario complexity](#document-your-scenario-complexity) section, the example scenarios show that you probably need to plan for dependencies between various global datacenters. Organizations that operate on this scale might not document or clearly understand these dependencies. Your organization's approach to evaluating user profiles helps you identify some of these dependencies in your organization. Your team should also explore more assessment steps that can help mitigate the risks and complexities that arise from dependencies.

## Implement a general approach

The following approach uses a data-driven model to address global migration complexities. If the migration scope includes multiple regions, the cloud adoption team should evaluate the following readiness considerations:

- **Determine whether you can meet your business requirements**: Use multiple availability zones to determine requirements for high availability, resiliency, performance, and cost. If these requirements aren't met, consider whether you need a multi-region approach.

- **Evaluate data sovereignty**: Data sovereignty can require localization of some assets, but many assets aren't governed by those compliance constraints. Services like logging, reporting, network routing, identity, and other central IT services might be eligible to be hosted as shared services across multiple subscriptions or regions. Evaluate data sovereignty by using a shared service model for those services. For an outline of this approach, see the [reference architecture for a hub-spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

- **Ensure that your environment scales**: If you deploy multiple instances of similar environments, you can establish a dedicated team for the environment's migrations to help create consistency, improve governance, and accelerate deployment. The [governance guide for complex enterprises](../../govern/guides/complex/index.md) establishes an approach that creates an environment that scales across multiple regions.

### Data-driven prerequisites

When your team is comfortable with the baseline approach and readiness is aligned, consider these data-driven prerequisites:

- **Complete general discovery**: Complete the table in [Document complexity](#document-your-scenario-complexity) to evaluate the complexity of your cloud adoption strategy.

- **Analyze user profiles for each affected country or region**: It's important to understand general user routing early in the migration process. Changing global lease lines and adding connections like Azure ExpressRoute to a cloud datacenter can result in months of networking delays. Address user routing as early in the process as possible.

- **Complete an initial digital estate rationalization**: If you introduce complexity into a migration strategy, complete an initial digital estate rationalization. For more information, see [What is a digital estate?](../../digital-estate/index.md).

- **Use tagging for digital estate requirements**: Establish tagging policies to identify any workload that's affected by data sovereignty requirements. Ensure that required tags begin in digital estate rationalization and carry through to migrated assets.

- **Evaluate a hub-spoke model**: Distributed systems often share common dependencies. You can often address shared dependencies by implementing a hub-spoke model. Although implementing a hub-spoke model is out of scope for the migration process, flag the model for consideration during future iterations of the [ready processes](../../ready/index.md).

- **Prioritize the migration backlog**: If you require network changes to support production deployment of a workload that supports multiple regions, the cloud strategy team should track and manage escalations that result from the network changes. This higher level of executive support helps accelerate the change by freeing the strategy team to reprioritize the backlog and ensure that network changes don't block global workloads. Prioritize global workloads only when network changes are finished.

These prerequisites help establish processes that can address complexity during execution of the migration strategy.

## Assess process changes

If your migration scenario involves global asset and user-base complexities, add key activities to assess your migration candidates. These activities produce data to help you clarify obstacles and outcomes for global users and assets.

### Suggested actions during the assess process

**Evaluate cross-datacenter dependencies**: The [dependency analysis tools in Azure Migrate](/azure/migrate/concepts-dependency-visualization) can help you pinpoint dependencies. Use these tools before you begin migration. If your scenario involves global complexity, evaluating dependencies is a necessary step in the assess process. You can use [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies) to visualize dependencies and identify the IP addresses and ports of any assets that are required to support the workload.

> [!IMPORTANT]
>
> - You need a subject matter expert (SME) who understands asset placement and IP address schemas to identify assets that are located in a secondary datacenter.
> - Evaluate downstream dependencies and clients in the visualization to understand bidirectional dependencies.

**Identify global user impact**: The output from the prerequisite user-profile analysis should identify any workload that's affected by global user profiles. If a migration candidate is in the list of affected workloads, the migration architect should consult networking and operations SMEs. These experts help validate network routing and performance expectations. At a minimum, the architecture should include an ExpressRoute connection between the closest network operations center and Azure. The [reference architecture for ExpressRoute connections](/azure/architecture/reference-architectures/hybrid-networking/expressroute) can help you configure the necessary network connections.

**Design for compliance**: The output from the prerequisite user-profile analysis should also identify any workload that's affected by data sovereignty requirements. During the architecture activities of the assess process, the assigned architect should consult compliance SMEs. These experts can help the architect understand any requirements for migration and deployment across multiple regions. Those requirements significantly affect design strategies. The following reference architectures can help with the design:

- [Zone-redundant web applications](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)
- [Multi-region web applications](/azure/architecture/web-apps/app-service/architectures/multi-region)
- [Multi-region n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server)
- [Workload templates for a sovereign landing zone](/industry/sovereignty/workload-templates)

> [!WARNING]
> If you use the reference architecture for ExpressRoute or the reference architectures for applications, you might need to exclude specific data elements from replication processes to meet data sovereignty requirements. The task of excluding specific data elements adds a step to the promotion process.

## Migration process changes

If you migrate an application that must be deployed to multiple regions, the cloud adoption team must account for a few more considerations. The design of Azure Site Recovery vaults and configuration and process servers are two of those considerations. Two other considerations are network-bandwidth designs and data synchronization.

### Suggested actions during the migration process

**Site Recovery vault design**: Site Recovery is the suggested tool for cloud-native replication and synchronization of digital assets to Azure. Site Recovery replicates data about each asset to a Site Recovery vault. This vault is bound to a specific subscription in a specific region and Azure datacenter. If you replicate assets to a second region, you might also need a second Site Recovery vault.

**Configuration and process server design**: Site Recovery works with a local instance of a configuration and process server that's bound to a single Site Recovery vault. When you use this configuration, you might need to install second instances of these servers in the source datacenter to facilitate replication.

**Network bandwidth design**: During replication and ongoing synchronization, you move binary data over the network from the source datacenter to the Site Recovery vault in the target Azure datacenter. The replication and synchronization process consumes bandwidth. Duplicating the workload to a second region doubles the amount of consumed bandwidth.

In some scenarios, bandwidth is limited. In others, a workload involves substantial configuration or data drift. In these cases, replicating data to a second region can interfere with the time that it takes to complete the migration. More importantly, these constraints can affect the experience of users or applications that still depend on the bandwidth that was available in the source datacenter.

**Data synchronization**: The largest bandwidth drain often comes from synchronizing the data platform. If you deploy across multiple availability zones, you might be able to use zone-redundant data services that automatically synchronize your data across multiple availability zones. Deployment across multiple regions often requires data synchronization to keep applications aligned. This approach is defined in the reference architectures for [multi-region web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multi-region n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server).

If keeping applications synchronized is the operational state you want for your applications, you might want to synchronize the source data platform with each cloud platform. Perform this sync before you migrate the application and middle-tier assets.

**Azure-to-Azure disaster recovery**: An alternative option might further reduce complexity. If you use a two-step deployment to meet timeline and data-synchronization needs, [Azure-to-Azure disaster recovery](/azure/site-recovery/azure-to-azure-architecture) might be an acceptable solution. In this scenario, you migrate the workload to the first Azure datacenter by using a single Site Recovery vault and configuration and process server design. After you test the workload, you can recover the workload to a second Azure datacenter from the migrated assets.

This approach reduces the effect on resources in the source datacenter. Azure-to-Azure disaster recovery also takes advantage of fast transfer speeds and high bandwidth limits between Azure datacenters.

> [!NOTE]
> The Azure-to-Azure disaster recovery approach can increase short-term migration costs through higher egress bandwidth charges.

## Release process changes

As you address global complexity during optimization and promotion, you might require identical efforts in each region that you deploy to. If you use a single region, you might still need to replicate business testing and business change plans.

### Suggested actions during the release process

**Pretest optimization**: Initial automation testing can identify potential optimization opportunities, as with any migration effort. For global workloads, independently test the workload in each region. Minor configuration changes in your network or in the chosen Azure datacenter can affect performance.

**Business change plans**: Create a business change plan for any complex migration scenario. A business change plan helps ensure clear communication about changes to business processes and user experiences. The plan also helps ensure clear communication about the timing of efforts that are required to integrate changes. In a global migration effort, the plan should include considerations for users in each affected geography.

**Business testing**: Each region might also require business testing. Business testing helps ensure adequate performance and adherence to modified network routing patterns.

**Promotion flights**: Promotion often happens as a single activity, and production traffic is immediately rerouted to the migrated workloads. In a global release effort, you should deliver promotion in predefined collections of users called *flights*. Promotion flights give the cloud strategy team and cloud adoption team an opportunity to observe performance and improve support for users in each region. You can control promotion flights at the networking level. Specifically, you can change the routing of specific IP ranges from the source workload assets to the newly migrated assets. After you migrate a specified collection of users, you can reroute the next group.

**Flight optimization**: One benefit of promotion flights is that they give you deeper observations and an opportunity to optimize the deployed assets. After the first flight successfully uses production for a brief time, you can refine the migrated assets when IT operation procedures support it.
