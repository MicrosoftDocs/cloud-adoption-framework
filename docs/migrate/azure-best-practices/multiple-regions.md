---
title: Select Azure regions for a migration
description: Learn about selecting an Azure cloud region when you are migrating into Azure.
author: doodlemania2
ms.author: dermar
ms.reviewer: tozimmergren
ms.date: 11/18/2022
ms.topic: conceptual
ms.custom: internal, engagement-fy23
---

# Select Azure regions for a migration

TODO

> [!NOTE]
> This article covers considerations that are specific to workload migrations. To learn about general principles for selecting Azure regions for any organization or workload, see [Select Azure region](../../ready/azure-setup-guide/regions.md).

## Document your scenario complexity

After you consider network topology, determine whether more documentation and process alignment is required. The following approach can help you assess potential challenges and establish a general course of action:

- Consider a more robust readiness and governance implementation.
- Inventory the affected geographies. Compile a list of the countries/regions that are affected.
- Document data sovereignty requirements. Do the identified countries/regions have compliance requirements that govern data sovereignty?
- Document the user base. Will employees, partners, or customers in the identified country/region be affected by the cloud migration?
- Document datacenters and assets. Are there assets in the identified country/region that might be included in the migration effort?
- Document regional SKU availability and failover requirements.
- Document your resiliency requirements to determine if availability zones are required.

Align changes throughout the migration process to address the initial inventory. The following table shows example scenarios that can help you document your findings:

| Region        | Country     | Local employees | Local external users   | Local datacenters or assets | Data sovereignty requirements |
|---------------|-------------|-----------------|------------------------|-----------------------------|-------------------------------|
| North America | United States         | Yes             | Partners and customers | Yes                         | No                            |
| North America | Canada      | No              | Customers              | Yes                         | Yes                           |
| Europe        | Germany     | Yes             | Partners and customers | No - network only           | Yes                           |
| Asia Pacific  | South Korea | Yes             | Partners               | Yes                         | No                            |

### Why is the location of users relevant?

Organizations that support users in multiple countries/regions have developed technical solutions that address user traffic. In some cases, solutions involve localization of assets. In other scenarios, the organization might choose to implement global wide area network (WAN) solutions to address disparate user bases through network-focused solutions. In either case, the migration strategy might be affected by the usage profiles of disparate users.

If an organization supports employees, partners, and customers in Germany without currently having datacenters in Germany, the organization probably implemented a leased-line solution. This type of solution routes traffic to datacenters in other countries/regions. This existing routing presents a significant risk to the perceived performance of migrated applications. Injecting more hops in an established and tuned global WAN can create the perception of underperforming applications after migration. Finding and fixing those issues can add significant delays to a project.

In each of the following processes, guidance for addressing this complexity is included across prerequisites and processes of assessing, migrating, and optimizing. Understanding user profiles in each country/region is critical to properly manage this complexity.

### Why is the location of datacenters relevant?

The location of existing datacenters might affect a migration strategy. Consider the following factors:

**Architecture decisions**: Determining the target region is one of the first steps in migration strategy design. This determination often is influenced by the location of existing assets. Also, the availability of cloud services and the unit cost of those services might vary between regions. Understanding where current and future assets are located affects architecture decisions, and it might influence budget estimates.

**Datacenter dependencies**: The example scenarios in the table in [Document complexity](#document-your-scenario-complexity) show that you'll likely need to plan for dependencies between various global datacenters. The dependencies might not be documented or understood clearly in many organizations that operate on this scale. Your organization's approach to evaluating user profiles helps you identify some of these dependencies in your organization. Your team also should explore more assessment steps that can help mitigate the risks and complexities that arise from dependencies.

## Implement a general approach

The following approach uses a data-driven model to address global migration complexities. When the scope for a migration includes multiple regions, the cloud adoption team should evaluate the following readiness considerations:

- Data sovereignty might require localization of some assets, but many assets might not be governed by those compliance constraints. Things like logging, reporting, network routing, identity, and other central IT services might be eligible to be hosted as shared services across multiple subscriptions or multiple regions. The cloud adoption team should evaluate data sovereignty by using a shared service model for those services as outlined in the [reference architecture for a hub-spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).
- When you're deploying multiple instances of similar environments, using an environment factory can help create consistency, improve governance, and accelerate deployment. The [governance guide for complex enterprises](../../govern/guides/complex/index.md) establishes an approach that creates an environment that scales across multiple regions.

### Data-driven prerequisites

When the team is comfortable with the baseline approach and readiness is aligned, consider a few data-driven prerequisites:

- **Complete general discovery**: Complete the table in [Document complexity](#document-your-scenario-complexity) to evaluate the complexity of your cloud adoption strategy.
- **Analyze user profiles on each affected country/region**: It's important to understand general user routing early in the migration process. Changing global lease lines and adding connections like ExpressRoute to a cloud datacenter can require months of networking delays. Address user routing as early in the process as possible.
- **Complete an initial digital estate rationalization**: When complexity is introduced in a migration strategy, you should complete an initial digital estate rationalization. For more information, see [What is a digital estate?](../../digital-estate/index.md)
- **Use tagging for digital estate requirements**: Establish tagging policies to identify any workload that's affected by data sovereignty requirements. Required tags should begin in digital estate rationalization and carry through to migrated assets.
- **Evaluate a hub-spoke model**: Distributed systems often share common dependencies. Often, you can address shared dependencies by implementing a hub-spoke model. Although implementing a hub-spoke model is out of scope for the migration process, flag the model for consideration during future iterations of the [ready processes](../../ready/index.md).
- **Prioritize the migration backlog**: When network changes are required to support production deployment of a workload that supports multiple regions, the cloud strategy team should track and manage escalations that result from the network changes. The higher level of executive support helps accelerate the change by freeing the strategy team to reprioritize the backlog and ensure that global workloads aren't blocked by network changes. Prioritize global workloads only when network changes are finished.

These prerequisites help establish processes that can address complexity during execution of the migration strategy.

## Assess process changes

When your organization faces global asset and user base complexities in a migration scenario, you should add a few key activities to assess your migration candidates. These activities produce data to clarify obstacles and outcomes for global users and assets.

### Suggested action during the assess process

**Evaluate cross-datacenter dependencies**: The [dependency visualization tools in Azure Migrate](/azure/migrate/concepts-dependency-visualization) can help you pinpoint dependencies. A best practice is to use these tools before you begin migration. When global complexity is involved, it becomes a necessary step in the assessment process. Through [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies), dependency visualization can help you identify the IP addresses and ports of any assets that are required to support the workload.

> [!IMPORTANT]
>
> - A subject matter expert who has an understanding of asset placement and IP address schemas is required to identify assets that are located in a secondary datacenter.
> - Evaluate both downstream dependencies and clients in the visualization to understand bidirectional dependencies.

**Identify global user impact**: The outputs from the prerequisite user profile analysis should identify any workload that's affected by global user profiles. When a migration candidate is in the list of affected workloads, the migration architect should consult networking and operations subject matter experts. These experts help validate network routing and performance expectations. At a minimum, the architecture should include an ExpressRoute connection between the closest network operations center and Azure. The [reference architecture for ExpressRoute connections](/azure/architecture/reference-architectures/hybrid-networking/expressroute) can help you configure the necessary network connections.

**Design for compliance**: The outputs from the prerequisite user profile analysis also should identify any workload that's affected by data sovereignty requirements. During the architecture activities of the assess process, the assigned architect should consult compliance subject matter experts. These experts can help the architect understand any requirements for migration and deployment across multiple regions. Those requirements significantly affect design strategies. The reference architectures for [multiregion web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server) can help with the design.

> [!WARNING]
> When you're using the reference architecture for ExpressRoute or the reference architectures for applications, you might need to exclude specific data elements from replication processes to meet data sovereignty requirements. The task of excluding specific data elements adds a step in the promotion process.

## Migration process changes

When you migrate an application that must be deployed to multiple regions, the cloud adoption team must account for a few more considerations. The considerations consist of Azure Site Recovery vault design, configuration and process server design, network bandwidth designs, and data synchronization.

### Suggested action during the migration process

**Azure Site Recovery vault design**: Azure Site Recovery is the suggested tool for cloud-native replication and synchronization of digital assets to Azure. Site Recovery replicates data about the asset to a Site Recovery vault, which is bound to a specific subscription in a specific region and Azure datacenter. When you're replicating assets to a second region, you might also need a second Site Recovery vault.

**Configuration and process server design**: Site Recovery works with a local instance of a configuration and process server, which is bound to a single Site Recovery vault. The configuration means that you might need to install a second instance of these servers in the source datacenter to facilitate replication.

**Network bandwidth design**: During replication and ongoing synchronization, you move binary data over the network, from the source datacenter to the Site Recovery vault in the target Azure datacenter. The process of replication and synchronization consumes bandwidth. Duplicating the workload to a second region doubles the amount of bandwidth that's consumed. If bandwidth is limited or if a workload involves substantial configuration or data drift, replicating data to a second region might interfere with the time it takes to complete the migration. More importantly, these constraints might affect the experience of users or applications that still depend on the bandwidth that was available in the source datacenter.

**Data synchronization**: Often, the largest bandwidth drain comes from synchronizing the data platform. As defined in the reference architectures for [multiregion web applications](/azure/architecture/reference-architectures/app-service-web-app/multi-region) and [multiregion n-tier applications](/azure/architecture/reference-architectures/n-tier/multi-region-sql-server), data synchronization often is required to keep applications aligned. If keeping applications synchronized is the operational state you want for your applications, you might want to synchronize the source data platform with each cloud platform. You should do this before you migrate the application and middle-tier assets.

**Azure-to-Azure disaster recovery**: An alternative option might reduce complexity further. If timelines and data synchronization mean you might need to do a two-step deployment, [Azure-to-Azure disaster recovery](/azure/site-recovery/azure-to-azure-architecture) might be an acceptable solution. In the scenario, you migrate the workload to the first Azure datacenter by using a single Site Recovery vault and configuration or process server design. After you test the workload, you can recover the workload to a second Azure datacenter from the migrated assets. The approach reduces the effect on resources in the source datacenter and takes advantage of faster transfer speeds and high bandwidth limits between Azure datacenters.

> [!NOTE]
> The Azure-to-Azure disaster recovery approach might increase short-term migration costs through higher egress bandwidth charges.

## Optimize and promote process changes

As you address global complexity during optimization and promotion, you might require identical efforts in each of the other regions. When a single deployment is acceptable, you might still need to replicate business testing and business change plans.

### Suggested action during the optimize and promote process

**Pretest optimization**: Initial automation testing can identify potential optimization opportunities, as with any migration effort. For global workloads, independently test the workload in each region. Minor configuration changes in your network or in the Azure datacenter you choose might affect performance.

**Business change plans**: For any complex migration scenario, create a business change plan. Using a business change plan helps ensure clear communication about any changes to business processes and user experiences, and about the timing of efforts required to integrate the changes. In a global migration effort, the plan should include considerations for users in each affected geography.

**Business testing**: In addition to a business change plan, business testing might be required in each region. Business testing in each region helps ensure adequate performance and adherence to modified network routing patterns.

**Promotion flights**: Often, promotion happens as a single activity, and production traffic is immediately rerouted to the migrated workloads. In a global release effort, you should deliver promotion in *flights*, which are predefined collections of users. Using promotion flights gives the cloud strategy team and the cloud adoption team an opportunity to observe performance and improve support for users in each region. Promotion flights often are controlled at the networking level by changing the routing of specific IP ranges from the source workload assets to the newly migrated assets. After a specified collection of users are migrated, the next group can be rerouted.

**Flight optimization**: One of the benefits of using promotion flights is that you have deeper observations and an opportunity to optimize the deployed assets. After the first flight successfully uses production for a brief time, you can refine the migrated assets when IT operation procedures support it.
