---
title: "Scale a migration to Azure"
description: Use the Cloud Adoption Framework for Azure to learn how to plan for and perform a migration at scale to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/08/2018
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- docsTest:ignore ARO POC Y/N None/Some/Severe Rehost/Refactor/Rearchitect/Rebuild -->

<!-- cSpell:ignore VHDs autosnooze unsnooze Hanu Scalr -->

# Scale a migration to Azure

This article demonstrates how the fictional company Contoso performs a migration at scale to Azure. They consider how to plan and perform a migration of more than 3000 workloads, 8000 databases, and over 10,000 VMs.

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing, causing pressure on on-premises systems and infrastructure.
- **Increase efficiency.** Contoso needs to remove unnecessary procedures, and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering faster on customer requirements.
- **Increase agility.** Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable the success in a global economy. It mustn't get in the way, or become a business blocker.
- **Scale.** As the business grows successfully, the Contoso IT team must provide systems that are able to grow at the same pace.
- **Improve cost models.** Contoso wants to lessen capital requirements in the IT budget. Contoso wants to use cloud abilities to scale and reduce the need for expensive hardware.
- **Lower licensing costs.** Contoso wants to minimize cloud costs.

## Migration goals

The Contoso cloud team has pinned down goals for this migration. These goals were used to determine the best migration method.

| **Requirements** | **Details** |
| --- | --- |
| Move to Azure quickly | Contoso wants to start moving apps and VMs to Azure as quickly as possible. |
| Compile a full inventory | Contoso wants a complete inventory of all apps, databases, and VMs in the organization. |
| Assess and classify apps | Contoso wants fully take advantage of the cloud. As a default Contoso assumes that all services will run as PaaS. IaaS will be used where PaaS isn't appropriate. |
| Train and move to DevOps | Contoso wants to move to a DevOps model. Contoso will provide Azure and DevOps training, and reorganize teams as necessary. |

After pinning down goals and requirements, Contoso reviews the IT footprint, and identifies the migration process.

## Current deployment

After planning and setting up an [Azure infrastructure](./contoso-migration-infrastructure.md) and trying out different proof-of-concept (POC) migration combinations as detailed in the table above, Contoso is ready to embark on a full migration to Azure at scale. Here's what Contoso wants to migrate.

<!-- markdownlint-disable MD033 -->

| **Item** | **Volume** | **Details** |
| --- | --- | --- |
| Workloads | > 3,000 apps | <li> Apps run on VMs. <li> Apps are Windows, SQL-based, and OSS LAMP. |
| Databases | ~ 8,500 databases | Databases include SQL Server, MySQL, and PostgreSQL. |
| VMs | > 35,000 VMs | VMs run on VMware hosts and managed by vCenter servers. |

<!--markdownlint-enable MD033 -->

## Migration process

Now that Contoso has pinned down business drivers and migration goals, it can align to the [Migrate methodology](../index.md), building on the application of migration waves and migration sprints to iteratively plan and execute migration efforts.

## Plan

Contoso kicks off the planning process by discovering and assessing on-premises apps, data, and infrastructure. Here's what Contoso will do:

- Contoso needs to discover apps, maps dependencies across apps, and decide on migration order and priority.
- As Contoso assesses, it will build out a comprehensive inventory of apps and resources. Along with the new inventory, Contoso will use and update the existing configuration management database (CMDB) and service catalog.
  - The CMDB holds technical configurations for Contoso apps.
  - The service catalog documents the operational details of apps, including associated business partners, and service level agreements (SLAs).

### Discover apps

Contoso runs thousands of apps across a range of servers. In addition to the CMDB and service catalog, Contoso needs discovery and assessment tools.

- The tools must provide a mechanism that can feed assessment data into the migration process.
- Assessment tools must provide data that helps build up an intelligent inventory of Contoso's physical and virtual resources. Data should include profile information, and performance metrics.
- When discovery is complete, Contoso should have a complete inventory of assets, and metadata associated with them. This inventory will be used to define the migration plan.

### Identify classifications

Contoso identifies some common categories to classify assets in the inventory. These classifications are critical to Contoso's decision making for migration. The classification list helps to establish migration priorities, and identify complex issues.

| **Category** | **Assigned value** | **Details** |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can the app be used as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the app communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the app? Does the app use unencrypted data or out-of-date platforms? |

### Discover app dependencies

As part of the assessment process, Contoso needs to identify where apps are running, and figure out the dependencies and connections between app servers. Contoso maps the environment in steps.

1. As a first step, Contoso discovers how servers and machines map to individual apps, network locations, and groups.
2. With this information, Contoso can clearly identify apps that have few dependencies and are suitable for a quick migration.
3. Contoso can use mapping to help them identify more complex dependencies and communications between app servers. Contoso can then group these servers logically to represent apps, and plan a migration strategy based on these groups.

With mapping completed, Contoso can ensure that all app components are identified and accounted for when building the migration plan.

![Dependency mapping](./media/contoso-migration-scale/dependency-map.png)

### Evaluate apps

As the last step in the discovery and assessment process, Contoso can evaluate assessment and mapping results to figure out how to migrate each app in the service catalog.

To capture this evaluation process, they add a couple of additional classifications to the inventory.

| **Category** | **Assigned value** | **Details** |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can the app be used as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the app communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the app? Does the app use unencrypted data or out-of-date platforms? |
| Migration strategy | Rehost/Refactor/Rearchitect/Rebuild | What kind of migration is needed for the app? How will the app be deployed in Azure? [Learn more](./contoso-migration-overview.md#migration-patterns). |
| Technical complexity | 1-5 | How complex is the migration? This value should be defined by Contoso DevOps and relevant partners. |
| Business criticality | 1-5 | How important is the app for the business? For example, a small workgroup app might be assigned a score of one, while a critical app used across the org might be assigned a score of five. This score will affect the migration priority level. |
| Migration priority | 1/2/3 | What the migration priority for the app? |
| Migration risk | 1-5 | What's the risk level for migrating the app? This value should be agreed on by Contoso DevOps and relevant partners. |

### Determine costs

To determine costs and the potential savings of Azure migration, Contoso can use the [total cost of ownership (TCO) calculator](https://azure.microsoft.com/pricing/tco/calculator) to calculate and compare the TCO for Azure to a comparable on-premises deployment.

### Identify assessment tools

Contoso decides which tool to use for discovery, assessment, and building the inventory. Contoso identifies a mix of Azure tools and services, native app tools and scripts, and partner tools. In particular, Contoso is interested in how Azure Migrate can be used to assess at scale.

#### Azure Migrate

The Azure Migrate service helps you to discover and assess on-premises VMware VMs, in preparation for migration to Azure. Here's what Azure Migrate does:

1. **Discover:** Discover on-premises VMware VMs.
    - Azure Migrate supports discovery from multiple vCenter servers (serially), and can run discoveries in separate Azure Migrate projects.
    - Azure Migrate performs discovery via a VMware VM running the Azure Migrate Collector. The same collector can discover VMs on different vCenter servers, and send data to different projects.

2. **Assess readiness:** Assess whether on-premises machines are suitable for running in Azure. Assessment includes:
    - **Size recommendations:** Get size recommendations for Azure VMs, based on the performance history of on-premises VMs.
    - **Estimated monthly costs:** Get estimated costs for running on-premises machines in Azure.

3. **Identify dependencies:** Visualize dependencies of on-premises machines, to create optimal machines groups for assessment and migration.

![Azure Migrate](./media/contoso-migration-scale/azure-migrate.png)

**Migrate at scale:**

Contoso needs to use Azure Migrate correctly given the scale of this migration.

- Contoso will do an app-by-app assessment with Azure Migrate. This ensures that Azure Migrate returns timely data to the Azure portal.
- Contoso admins learn how to [deploy Azure Migrate at scale](https://docs.microsoft.com/azure/migrate/scale-hyper-v-assessment).
- Contoso notes the Azure Migrate limits summarized in the following table.

| **Action** | **Limit** |
| --- | --- |
| Create Azure Migrate project | 10,000 VMs |
| Discovery | 10,000 VMs |
| Assessment | 10,000 VMs |

Contoso will use Azure Migrate as follows:

- In vCenter Contoso will organize VMs into folders. This will make it easy for them to focus as they run an assessment against VMs in a specific folder.
- Azure Migrate uses Azure Service Map to assess dependencies between machines. This requires agents to be installed on VMs to be assessed.
  - Contoso will use automated scripts to install the required Windows or Linux agents.
  - By scripting, Contoso can push the installation to VMs within a vCenter folder.

#### Database tools

In addition to Azure Migrate, Contoso will focus on using tools specifically for database assessment. Tools such as the [Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview?view=sql-server-2017) will help assess SQL Server databases for migration.

The Data Migration Assistant (DMA) can help Contoso to figure out whether on-premises databases are compatible with a range of Azure database solutions, such as Azure SQL Database, SQL Server running on an Azure IaaS VM, and Azure SQL Managed Instance.

In addition to DMS, Contoso has some other scripts that they use to discover and documenting the SQL Server databases. These are located in the GitHub repo.

#### Partner assessment tools

There are several other partner tools that can help Contoso in assessing the on-premises environment for migration to Azure. Learn more about [Azure migration partners](https://azure.microsoft.com/migration/partners).

## Phase 2: Migrate

With their assessment complete Contoso needs to identify tools to move their apps, data, and infrastructure to Azure.

### Migration strategies

There are four broad migration strategies that Contoso can consider.

<!-- markdownlint-disable MD033 -->

| **Strategy** | **Details** | **Usage** |
| --- | --- | --- |
| Rehost | <li> Often referred to as a _lift and shift_ migration, this is a no-code option for migrating existing apps to Azure quickly. <li> An app is migrated as-is, with the benefits of the cloud, without the risks or costs associated with code changes. | <li> Contoso can rehost less-strategic apps, requiring no code changes. |
| Refactor | <li> Also referred to as "repackaging", this strategy requires minimal app code or configuration changes need to connect the app to Azure PaaS, and take better advantage of cloud capabilities. | <li> Contoso can refactor strategic apps to retain the same basic functionality, but move them to run on an Azure platform such as Azure App Service. <li> This requires minimum code changes. <li> On the other hand, Contoso will have to maintain a VM platform since this won't be managed by Microsoft. |
| Rearchitect | <li> This strategy modifies or extends an app code base to optimize the app architecture for cloud capabilities and scale. <li> It modernizes an app into a resilient, highly scalable, independently deployable architecture. <li> Azure services can accelerate the process, scale applications with confidence, and manage apps with ease. |
| Rebuild | <li> This approach rebuilds an app from scratch using cloud-native technologies. <li> Azure platform as a service (PaaS) provides a complete development and deployment environment in the cloud. It eliminates some expense and complexity of software licenses, and removes the need for an underlying app infrastructure, middleware, and other resources. | <li> Contoso can rewrite critical apps from the ground up, to take advantage of cloud technologies such as serverless compute or microservices. <li> Contoso will manage the app and services it develops, and Azure manages everything else. |

<!--markdownlint-enable MD033 -->

Data must also be considered, especially with the volume of databases that Contoso has. Contoso's default approach is to use PaaS services such as Azure SQL Database to take full advantage of cloud features. By moving to a PaaS service for databases, Contoso will only have to maintain data, leaving the underlying platform to Microsoft.

### Evaluate migration tools

Contoso is primarily using a couple of Azure services and tools for the migration:

- **[Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview):** Service for migrating on-premises virtual machines and other resources to Azure.
- **[Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview):** Orchestrates disaster recovery, and migrates on-premises VMs to Azure.
- **[Azure Database Migration Service](https://docs.microsoft.com/azure/dms/dms-overview):** Migrates on-premises databases such as SQL Server, MySQL, and Oracle to Azure.

<!-- markdownlint-disable MD024 -->

#### Azure Migrate

Azure Migrate is the primary Azure service for orchestrating migration from within Azure, and from on-premises sites to Azure.

1. Azure Migrate orchestrates replication from your on-premises locations to Azure.
2. When replication is set up and running, on-premises machines can be failed over to Azure, completing the migration.

Contoso already [completed a POC](./contoso-migration-rehost-vm.md) to see how Azure Migrate can help them to migrate to the cloud.

##### Use Azure Migrate at scale

Contoso plans to perform multiple lift-and-shift migrations. To ensure this works, Azure Migrate will replicate batches of around 100 VMs at a time. To determine how this will work, Contoso must perform capacity planning for the proposed migration.

- Contoso needs to gather information about their traffic volumes. In particular:
  - Contoso needs to determine the rate of change for VMs it wants to replicate.
  - Contoso also needs to take network connectivity from the on-premises site to Azure into account.
- In response to capacity and volume requirements, Contoso will need to allocate sufficient bandwidth based on the daily data change rate for the required VMs, to meet its recovery point objective (RPO).
- Lastly, they must determine how many servers are needed to run the Azure Migrate components needed for the deployment.

###### Gather on-premises information

Contoso can use Azure Migrate:

- Contoso can use the tool to remotely profile VMs without an impact on the production environment. This helps pinpoint bandwidth and storage requirements for replication and failover.
- Contoso can run the tool without installing any Site Recovery components on-premises.
- The tool gathers information about compatible and incompatible VMs, disks per VM, and data churn per disk. It also identifies network bandwidth requirements, and the Azure infrastructure needed for successful replication and failover.
- Contoso needs to ensure that then run the planner tool on a Windows Server machine that matches the minimum requirements for the Site Recovery configuration server. The configuration server is a Site Recovery machine that's needed in order to replicate on-premises VMware VMs.

###### Identify Site Recovery requirements

In addition to the VMs being replicated, Site Recovery requires several components for VMware migration.

<!-- markdownlint-disable MD033 -->

| **Component** | **Details** |
| --- | --- |
| Configuration server | <li> Usually a VMware VM configured using an OVF template. <li> The configuration server component coordinates communications between on-premises and Azure, and manages data replication. |
| Process server | <li> Installed by default on the configuration server. <li> The process server component receives replication data; optimizes it with caching, compression, and encryption; and sends it to Azure storage. <li> The process server also installs Azure Site Recovery Mobility Service on VMs you want to replicate, and performs automatic discovery of on-premises machines. <li> Scaled deployments need additional, standalone process servers to handle large volumes of replication traffic. |
| Mobility service | <li> The mobility service agent is installed on each VMware VM that will be migrated with Azure Site Recovery. |

<!--markdownlint-enable MD033 -->

Contoso needs to figure out how to deploy these components, based on capacity considerations.

<!-- markdownlint-disable MD033 -->

<br>

| **Component** | **Capacity requirements** |
| --- | --- |
| Maximum daily change rate | <li> A single process server can handle a daily change rate up to 2 TB. Since a VM can only use one process server, the maximum daily data change rate that's supported for a replicated VM is 2 TB. |
| Maximum throughput | <li> A standard Azure storage account can handle a maximum of 20,000 requests per second, and I/O operations per second (IOPS) across a replicating VM should be within this limit. For example, if a VM has 5 disks, and each disk generates 120 IOPS (8K size) on the VM, then it will be within the Azure per disk IOPS limit of 500. <li> The number of storage accounts needed equals the total source machine IOPS, divided by 20,000. A replicated machine can belong to only a single storage account in Azure. |
| Configuration server | Based on Contoso's estimate of replicating 100-200 VMs together, and the [configuration server sizing requirements](https://docs.microsoft.com/azure/site-recovery/site-recovery-plan-capacity-vmware#size-recommendations-for-the-configuration-server-and-inbuilt-process-server), Contoso estimate it needs a configuration server machine as follows: <li> CPU: 16 vCPUs (2 sockets &#215; 8 cores @ 2.5 GHz) <li> Memory: 32 GB <li> Cache disk: 1 TB <li> Data change rate: 1 TB to 2 TB. <br> in addition to sizing requirements, Contoso must ensure that the configuration server is optimally located, on the same network and LAN segment as the VMs to be migrated. |
| Process server | Contoso will deploy a standalone dedicated process server with the ability to replicate 100-200 VMs: <li> CPU: 16 vCPUs (2 sockets &#215; 8 cores @ 2.5 GHz) <li> Memory: 32 GB <li> Cache disk: 1 TB <li> Data change rate: 1 TB to 2 TB. <br> the process server will be working hard, so it's located on an ESXi host that can handle the disk I/O, network traffic, and CPU required for the replication. Contoso will consider a dedicated host for this purpose. |
| Networking | <li> Contoso has reviewed the current site-to-site VPN infrastructure, and decided to implement Azure ExpressRoute. The implementation is critical because it will lower latency, and improve bandwidth to Contoso's primary East US 2 Azure region. <li> Contoso will need to carefully monitor data flowing from the process server. If the data overloads the network bandwidth, Contoso will consider [throttling the process server bandwidth](https://docs.microsoft.com/azure/site-recovery/site-recovery-plan-capacity-vmware#control-network-bandwidth). |
| Azure Storage | <li> For migration, Contoso must identify the right type and number of target Azure Storage accounts. Site Recovery replicates VM data to Azure Storage. <li> Site Recovery can replicate to standard or premium SSD storage accounts. <li> To decide about storage, Contoso must review [storage limits](https://docs.microsoft.com/azure/virtual-machines/windows/disks-types) and consider expected growth and future increased usage. Given the speed and priority of migrations, Contoso has decided to use premium SSDs. <li> Contoso has decided to use managed disks for all VMs deployed to Azure. The IOPS required will help determine if the disks will be standard HDD, standard SSD, or premium SSD. |

<!--markdownlint-enable MD033 -->

#### Azure Database Migration Service

The Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms with minimal downtime.

- DMS integrates functionality of existing tools and services. It uses the Data Migration Assistant (DMA), to generate assessment reports that pinpoint recommendations about database compatibility and any required modifications.
- DMS uses a simple, self-guided migration process, with intelligent assessment that helps address potential issues before the migration.
- DMS can migrate at scale from multiple sources to the target Azure database.
- DMS provides support from SQL Server 2005 to SQL Server 2017.

DMS isn't the only Microsoft database migration tool. Get a [comparison of tools and services](https://blogs.msdn.microsoft.com/datamigration/2017/10/13/differentiating-microsofts-database-migration-tools-and-services).

##### Use DMS at scale

Contoso will use DMS when migrating from SQL Server.

- When provisioning DMS, Contoso needs to size it correctly and set it to optimize performance for data migrations. Contoso will select the "business-critical tier with 4 vCores" option, thus allowing the service to take advantage of multiple vCPUs for parallelization and faster data transfer.

    ![DMS scaling](./media/contoso-migration-scale/dms.png)

- Another scaling tactic for Contoso is to temporarily scale up the Azure SQL or MySQL database target instance to the premium tier SKU during the data migration. This minimizes database throttling that could affect data transfer activities when using lower-level SKUs.

##### Use other tools

In addition to DMS, Contoso can use other tools and services to identify VM information.

- They have scripts to help with manual migrations. These are available in the GitHub repo.
- Various [partner tools](https://azure.microsoft.com/migration/partners) can also be used for migration.

## Ready for production

After Contoso moves resources to Azure, they need to streamline them to improve performance, and maximize ROI with cost management tools. Given that Azure is a pay-for-use service, it's critical for Contoso to understand how systems are performing, and to ensure they're sized properly.

### Azure Cost Management

To make the most of their cloud investment, Contoso will take advantage of the free Azure Cost Management tool.

- This solution allows Contoso to manage cloud spending with transparency and accuracy. It provides tools to monitor, allocate, and trim cloud costs.
- Azure Cost Management provides simple dashboard reports to help with cost allocation, showbacks, and chargebacks.
- Azure Cost Management can optimize cloud spending by identifying underutilized resources that Contoso can then manage and adjust.
- Learn more about [Azure Cost Management](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview).

![Azure Cost Management](./media/contoso-migration-scale/cost-management.png)

### Native tools

Contoso will also use scripts to locate unused resources.

- During large migrations, there are often leftover pieces of data such as virtual hard drives (VHDs), which incur a charge, but provide no value to the company. Scripts are available in the GitHub repo.
- Contoso will take advantage of work done by Microsoft's IT department, and consider implementing the Azure resource optimization (ARO) toolkit.
- Contoso can deploy an Azure Automation account with preconfigured runbooks and schedules to its subscription, and start saving money. Azure resource optimization happens automatically on a subscription after a schedule is enabled or created, including optimization on new resources.
- This provides decentralized automation capabilities to reduce costs. Features include:
  - Autosnooze Azure VMs based on low CPU.
  - Schedule Azure VMs to snooze and unsnooze.
  - Schedule Azure VMs to snooze or unsnooze in ascending and descending order using Azure tags.
  - Bulk deletion of resource groups on-demand.
- Get started with the ARO toolkit in this [GitHub repo](https://github.com/azure/azure-quickstart-templates/tree/master/azure-resource-optimization-toolkit).

### Partner optimization tools

Partner tools such as [Hanu](https://hanu.com/insight) and [Scalr]( https://www.scalr.com/cost-optimization) can be used.

## Phase 4: Secure and manage

In this phase, Contoso uses Azure security and management resources to govern, secure, and monitor cloud apps in Azure. These resources help you run a secure and well-managed environment while using products available in the Azure portal. Contoso begins using these services during migration and, with Azure hybrid support, continues using many of them for a consistent experience across the hybrid cloud.

### Security

Contoso will rely on the Azure Security Center for unified security management and advanced threat protection across hybrid cloud workloads.

- The Security Center provides full visibility into, and control over, the security of cloud apps in Azure.
- Contoso can quickly detect and take action in response to threats, and reduce security exposure by enabling adaptive threat protection.

[Learn more](https://azure.microsoft.com/services/security-center) about the Security Center.

### Monitoring

Contoso needs visibility into the health and performance of the newly migrated apps, infrastructure, and data now running Azure. Contoso will use built-in Azure cloud monitoring tools such as Azure Monitor, Log Analytics workspace, and Application Insights.

- Using these tools, Contoso can easily collect data from sources and gain rich insights. For example, Contoso can gauge CPU disk and memory utilization for VMs, view applications and network dependencies across multiple VMs, and track application performance.
- Contoso will use these cloud monitoring tools to take action and integrate with service solutions.
- Learn more about [Azure monitoring](https://docs.microsoft.com/azure/azure-monitor/overview).

### Business continuity and disaster recovery

Contoso will need a business continuity and disaster recovery (BCDR) strategy for their Azure resources.

- Azure provides [built-in BCDR features](https://docs.microsoft.com/azure/architecture/resiliency/disaster-recovery-azure-applications) to keep data safe and apps/services up and running.
- In addition to built-in features, Contoso wants to ensure that it can recover from failures, avoid costly business disruptions, meet compliance goals, and protect data against ransomware and human errors. To do this:
  - Contoso will deploy Azure Backup as a cost-efficient solution for backup of Azure resources. Because it's built-in, Contoso can set up cloud backups in a few simple steps.
  - Contoso will set up disaster recovery for Azure VMs using Azure Site Recovery for replication, failover, and failback between Azure regions that it specifies. This ensures that apps running on Azure VMs will remain available in a secondary region of Contoso's choosing if an outage occurs in the primary region. [Learn more](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-quickstart).

## Conclusion

In this article, Contoso planned for an Azure migration at scale. They divided the migration process into four stages. From assessment and migration, through to optimization, security, and management after migration was complete. Mostly, it's important to plan a migration project as a whole process, but to migrate systems within an organization by breaking down sets into classifications and numbers that make sense for the business. By assessing data and applying classifications, and project can be broken down into a series of smaller migrations, which can run safely and rapidly. The sum of these smaller migrations quickly turns into a large successful migration to Azure.
