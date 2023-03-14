---
title: Scale a migration to Azure
description: Use the Cloud Adoption Framework for Azure to learn how to plan for and perform a migration at scale to Azure.
author: martinekuan
ms.author: martinek
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- docutune:casing Y/N None/Some/Severe Rehost/Refactor/Rearchitect/Rebuild -->

# Scale a migration to Azure

This article demonstrates how the fictional company, Contoso, performs a migration at scale to Azure. The company considers how to plan and perform a migration of more than 3,000 workloads, 8,000 databases, and 10,000 virtual machines (VMs).

## Business drivers

The IT leadership team works closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing, which creates pressure on on-premises systems and infrastructure.
- **Increase efficiency.** Contoso needs to remove unnecessary procedures and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, so they can deliver customer requirements quickly.
- **Increase agility.** Contoso IT needs to be more responsive to the needs of the business. They must react faster than the changes in the marketplace to enable success in a global economy. IT can't get in the way or become a business blocker.
- **Scale.** As the business grows successfully, the Contoso IT team must provide systems that can grow at the same pace.
- **Improve cost models.** Contoso wants to lessen capital requirements in the IT budget. Contoso wants to use cloud abilities to scale and reduce the need for expensive hardware.
- **Lower licensing costs.** Contoso wants to minimize cloud costs.

## Migration goals

The Contoso cloud team pins down goals for this migration. It uses these goals to determine the best migration method.

| Requirements | Details |
| --- | --- |
| Move to Azure quickly | Contoso wants to start moving applications and VMs to Azure as quickly as possible. |
| Compile a full inventory | Contoso wants a complete inventory of applications, databases, and VMs in the organization. |
| Assess and classify applications | Contoso wants to take full advantage of the cloud. As a default, Contoso assumes that all services run as platform as a service (PaaS). Contoso uses infrastructure as a service (IaaS) where PaaS isn't appropriate. |
| Train and move to DevOps | Contoso wants to move to a DevOps model. Contoso provides Azure and DevOps training and reorganizes teams as necessary. |

After Contoso establishes goals and requirements, they review the IT footprint and identify the migration process.

## Current deployment

Contoso planned and set up an [Azure infrastructure](./contoso-migration-infrastructure.md) and tried out the proof-of-concept (POC) migration combinations in the previous table. Now it's time to embark on a full migration to Azure at scale. Contoso wants to migrate:

| Item | Volume | Details |
| --- | --- | --- |
| Workloads | > 3,000 applications | <li> Applications run on VMs <li> Application platforms, including Windows, SQL Server, and [LAMP](https://wikipedia.org/wiki/LAMP_software_bundle) |
| Databases | Approximately 8,500 databases | Databases, including SQL Server, MySQL, and PostgreSQL |
| VMs | > 35,000 VMs | VMs that are run on VMware hosts and are managed by vCenter servers |

## Migration process

Now that Contoso has established business drivers and migration goals, it can align to the [Migrate methodology](../index.md). It can build on the application of migration waves and migration sprints to iteratively plan and execute migration efforts.

## Plan

Contoso kicks off the planning process by discovering and assessing on-premises applications, data, and infrastructure. Contoso:

- Discovers applications, maps dependencies across applications, and decides on the migration order and priority.
- Builds out a comprehensive inventory of applications and resources as it assesses. Along with the new inventory, Contoso uses and updates:
  - The configuration management database (CMDB), which holds technical configurations for Contoso applications.
  - The service catalog, which documents the operational details of applications, including associated business partners and service-level agreements.

### Discover applications

Contoso runs thousands of applications across a range of servers. Contoso uses the CMDB and service catalog but needs more discovery and assessment tools.

The tools must provide a mechanism that can feed assessment data into the migration process. Assessment tools must provide data that helps build up an intelligent inventory of Contoso's physical and virtual resources. Data should include profile information and performance metrics.

When discovery is complete, Contoso has a full inventory of assets and the metadata associated with them. The company uses this inventory to define the migration plan.

### Identify classifications

Contoso identifies some common categories to classify assets in the inventory. These classifications are critical to Contoso's decision making for migration. The classification list helps to establish migration priorities and identify complex issues.

| Category | Assigned value | Details |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can the application be used as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the application communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the application? Does the application use unencrypted data or out-of-date platforms? |

### Discover application dependencies

As part of the assessment process, Contoso identifies where applications are running. It determines the dependencies and connections between application servers. Contoso maps the environment in steps:

1. Contoso discovers how servers and machines map to individual applications, network locations, and groups.
2. Contoso identifies applications that have few dependencies and are suitable for a quick migration.
3. Contoso uses mapping to identify complex dependencies and communications between application servers. Contoso can group these servers logically to represent applications and plan a migration strategy based on these groups.

With mapping completed, Contoso ensures that all application components are identified and accounted for when building the migration plan.

[![Diagram of an example dependency mapping.](./media/contoso-migration-scale/dependency-map.png)](./media/contoso-migration-scale/dependency-map.png#lightbox)

### Evaluate applications

As the last step in the discovery and assessment process, Contoso evaluates assessment and mapping results to determine how to migrate each application in the service catalog.

Contoso adds classifications to the inventory.

| Category | Assigned value | Details |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can the application be used as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the application communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the application? Does the application use unencrypted data or out-of-date platforms? |
| Migration strategy | Rehost/Refactor/Rearchitect/Rebuild | What kind of migration is needed for the application? How will the application be deployed in Azure? [Learn more](./contoso-migration-overview.md#migration-patterns). |
| Technical complexity | 1-5 | How complex is the migration? This value should be defined by Contoso DevOps and relevant partners. |
| Business criticality | 1-5 | How important is the application for the business? For example, a small workgroup application might be assigned a score of one, and a critical application that's used across the organization might be assigned a score of five. This score affects the migration priority level. |
| Migration priority | 1/2/3 | What's the migration priority for the application? |
| Migration risk | 1-5 | What's the risk level for migrating the application? Contoso DevOps and relevant partners should agree on this value. |

### Determine costs

To determine costs and the potential savings of Azure migration, Contoso uses the [total cost of ownership (TCO) calculator](https://azure.microsoft.com/pricing/tco/calculator/) to calculate and compare the TCO for Azure to a comparable on-premises deployment.

### Identify assessment tools

Contoso decides which tool to use for discovery, assessment, and building the inventory. Contoso identifies a mix of Azure tools and services, native application tools and scripts, and partner tools. Contoso is interested in how Azure Migrate can be used to assess at scale.

#### Azure Migrate

The Azure Migrate service discovers and assesses on-premises VMware VMs in preparation for migration to Azure. Azure Migrate can:

1. **Discover:** Discover on-premises VMware VMs.

   Azure Migrate supports discovery from multiple vCenter servers (serially) and can run discoveries in separate Azure Migrate projects.

   Azure Migrate performs discovery via a VMware VM that runs the Azure Migrate Collector. The same collector can discover VMs on different vCenter servers and send data to different projects.

2. **Assess readiness:** Assess if on-premises machines are suitable for running in Azure. An assessment includes:
   - **Size recommendations:** Get size recommendations for Azure VMs based on the performance history of on-premises VMs.
   - **Estimated monthly costs:** Get estimated costs for running on-premises machines in Azure.

3. **Identify dependencies:** Visualize dependencies of on-premises machines to create optimal machine groups for assessment and migration.

[![Diagram of how the Azure Migrate service works.](./media/contoso-migration-scale/azure-migrate.png)](./media/contoso-migration-scale/azure-migrate.png#lightbox)

Contoso must use Azure Migrate correctly because of the scale of this migration:

- Contoso assesses each application via Azure Migrate. This assessment ensures that Azure Migrate returns timely data to the Azure portal.
- Contoso admins learn how to [deploy Azure Migrate at scale](/azure/migrate/scale-hyper-v-assessment).
- Contoso notes the Azure Migrate limits summarized in the following table.

| Action | Limit |
| --- | --- |
| Create Azure Migrate project | 10,000 VMs |
| Discovery | 10,000 VMs |
| Assessment | 10,000 VMs |

Contoso uses Azure Migrate:

- In vCenter to organize VMs into folders. This organization makes it easy for the admins to focus as they run an assessment against VMs in a specific folder.
- To assess dependencies between machines. This action requires agents to be installed on the VMs to be assessed.

Contoso uses automated scripts to install the required Windows or Linux agents. By scripting, Contoso can push the installation to VMs within a vCenter folder.

#### Database tools

In addition to Azure Migrate, Contoso focuses on using tools specifically for database assessment. Tools such as [Data Migration Assistant](/sql/dma/dma-overview) assess SQL Server databases for migration.

Data Migration Assistant helps Contoso determine if on-premises databases are compatible with a range of Azure database solutions. These solutions include Azure SQL Database, SQL Server running on an Azure IaaS VM, and Azure SQL Managed Instance.

In addition to Database Migration Service, Contoso has some scripts that it uses to discover and document the SQL Server databases. These scripts are located in the GitHub repo.

#### Partner assessment tools

Many other partner tools can help Contoso assess the on-premises environment for migration to Azure. Learn more about [Azure migration partners](https://azure.microsoft.com/migration/migration-center-partners/).

## Step 2: Migrate

With the assessment complete, Contoso identifies the tools to move its applications, data, and infrastructure to Azure.

### Migration strategies

Contoso considers four broad migration strategies.

| Strategy | Details | Usage |
| --- | --- | --- |
| Rehost | <li> Often called a *lift-and-shift* migration, this strategy is a no-code option that migrates existing applications to Azure quickly. <li> An application is migrated as is with the benefits of the cloud and without the risks or costs associated with code changes. | <li> Contoso can rehost less-strategic applications that require no code changes. |
| Refactor | <li> Also called *repackaging*, this strategy requires minimal application code or configuration changes to connect the application to Azure PaaS and takes advantage of cloud capabilities. | <li> Contoso can refactor strategic applications to retain the same basic functionality but move them to run on an Azure platform, such as Azure App Service. <li> This strategy requires minimum code changes. <li> Contoso has to maintain a VM platform because Microsoft doesn't manage it. |
| Rearchitect | <li> This strategy modifies or extends an application code base to optimize the application architecture for cloud capabilities and scale. <li> It modernizes an application into a resilient, highly scalable, independently deployable architecture. <li> Azure services can accelerate the process, scale applications with confidence, and manage applications with ease. |
| Rebuild | <li> This approach rebuilds an application from scratch by using cloud-native technologies. <li> Azure PaaS provides a complete development and deployment environment in the cloud. It eliminates some expense and complexity of software licenses. It removes the need for an underlying application infrastructure, middleware, and other resources. | <li> Contoso can rewrite critical applications to take advantage of cloud technologies, such as serverless compute or microservices. <li> Contoso manages the application and services that it develops, and Azure manages everything else. |

Data must be considered, especially when Contoso has a high volume of databases. Contoso's default approach is to use PaaS services such as Azure SQL Database to take full advantage of cloud features. When Contoso moves to a PaaS service for databases, they only have to maintain data. The underlying platform is maintained by Microsoft.

### Evaluate migration tools

Contoso is primarily using these Azure services and tools for the migration:

- [Azure Migrate](/azure/migrate/migrate-services-overview): Migrates on-premises virtual machines and other resources to Azure.
- [Azure Database Migration Service](/azure/dms/dms-overview): Migrates on-premises databases, such as SQL Server, MySQL, and Oracle, to Azure.

<!-- markdownlint-disable MD024 -->

#### Azure Migrate

Azure Migrate is the primary Azure service for orchestrating migration from within Azure and from on-premises sites to Azure.

Azure Migrate orchestrates replication from on-premises locations to Azure. When replication is set up and running, on-premises machines can be failed over to Azure, which completes the migration.

Contoso [completed a POC](./contoso-migration-rehost-vm.md) to see how Azure Migrate can help it migrate to the cloud.

##### Use Azure Migrate at scale

Contoso plans to perform multiple lift-and-shift migrations. To ensure that this strategy works, Azure Migrate replicates batches of around 100 VMs at a time. Contoso must perform capacity planning for the proposed migration.

Contoso gathers information about their traffic volumes. Contoso:

- Determines the rate of change for VMs that it wants to replicate.
- Takes into account the network connectivity from the on-premises site to Azure.

In response to capacity and volume requirements, Contoso allocates bandwidth based on the daily data change rate for the required VMs to meet its recovery point objective (RPO). It determines how many servers are needed to run the Azure Migrate components for the deployment.

##### Gather on-premises information

Contoso uses Azure Migrate:

- To remotely profile VMs without an effect on the production environment. This action pinpoints bandwidth and storage requirements for replication and failover.
- Without installing any Site Recovery components on-premises.

The tool gathers information about compatible and incompatible VMs, disks per VM, and data churn per disk. It identifies network bandwidth requirements and the Azure infrastructure needed for successful replication and failover.

Contoso runs the planner tool on a Windows Server machine that matches the minimum requirements for the Site Recovery configuration server. The configuration server is a Site Recovery machine that's needed to replicate on-premises VMware VMs.

##### Identify Site Recovery requirements

- In addition to the VMs being replicated, Site Recovery requires several components for VMware migration.

   | Component | Details |
   | --- | --- |
   | Configuration server | <li> Usually a VMware VM that's configured through an OVF template. <li> The configuration server component coordinates communications between on-premises and Azure, and it manages data replication. |
   | Process server | <li> Installed by default on the configuration server. <li> The process server component receives replication data; optimizes it with caching, compression, and encryption; and sends it to Azure Storage. <li> The process server also installs the Azure Site Recovery Mobility service on VMs that you want to replicate and performs automatic discovery of on-premises machines. <li> Scaled deployments need extra standalone process servers to handle large volumes of replication traffic. |
   | Mobility service | <li> The Mobility service agent is installed on each VMware VM that's migrated with Azure Site Recovery. |

- Contoso determines how to deploy these components based on capacity considerations.

   <br>

   | Component | Capacity requirements |
   | --- | --- |
   | Maximum daily change rate | <li> A single process server can handle a daily change rate up to 2 terabytes (TB). Because a VM can only use one process server, the maximum daily data change rate that's supported for a replicated VM is 2 TB. |
   | Maximum throughput | <li> A standard Azure Storage account can handle a maximum of 20,000 requests per second. I/O operations per second (IOPS) across a replicating VM should be within this limit. For example, if a VM has 5 disks and each disk generates 120 IOPS (8K size) on the VM, it's within the Azure per-disk IOPS limit of 500. <li> The number of storage accounts needed equals the total source machine IOPS divided by 20,000. A replicated machine can belong to only a single storage account in Azure. |
   | Configuration server | Based on Contoso's estimate of replicating 100 to 200 VMs together and the [configuration server sizing requirements](/azure/site-recovery/site-recovery-plan-capacity-vmware#size-recommendations-for-the-configuration-server-and-inbuilt-process-server), Contoso estimates that it needs the server machine configuration: <li> CPU: 16 vCPUs (2 sockets &#215; 8 cores @ 2.5 GHz) <li> Memory: 32 GB <li> Cache disk: 1 TB <li> Data change rate: 1 to 2 TB <br> Contoso must ensure that the configuration server is optimally located on the same network and LAN segment as the VMs to be migrated. |
   | Process server | Contoso deploys a standalone dedicated process server that can replicate 100 to 200 VMs: <li> CPU: 16 vCPUs (2 sockets &#215; 8 cores @ 2.5 GHz) <li> Memory: 32 GB <li> Cache disk: 1 TB <li> Data change rate: 1 to 2 TB <br> The process server works hard, so it's located on an ESXi host that can handle the disk I/O, network traffic, and CPU required for the replication. Contoso considers a dedicated host for this purpose. |
   | Networking | <li> Contoso reviewed the current Site-to-Site VPN infrastructure and decided to implement Azure ExpressRoute. The implementation is critical because it lowers latency and improves bandwidth to Contoso's primary Azure region (`East US 2`). <li> Contoso carefully monitors data that flows from the process server. If the data overloads the network bandwidth, Contoso considers [throttling the process server bandwidth](/azure/site-recovery/site-recovery-plan-capacity-vmware#control-network-bandwidth). |
   | Azure Storage | <li> For migration, Contoso identifies the right type and number of target Azure Storage accounts. Site Recovery replicates VM data to Azure Storage. <li> Site Recovery can replicate to Standard SSD or Premium SSD storage accounts. <li> Contoso reviews [storage limits](/azure/virtual-machines/disks-types) and considers the expected growth and future increased usage. Given the speed and priority of migrations, Contoso decides to use Premium SSDs. <li> Contoso decides to use managed disks for VMs deployed to Azure. The IOPS required helps determine if the disks are Standard HDD, Standard SSD, or Premium SSD. |

#### Azure Database Migration Service

Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms with minimal downtime. Azure Database Migration Service:

- Integrates the functionality of existing tools and services. It uses Data Migration Assistant to generate assessment reports that pinpoint recommendations about database compatibility and required modifications.
- Uses a simple, self-guided migration process with intelligent assessment to address potential issues before the migration.
- Can migrate at scale from multiple sources to the target Azure database.
- Provides support from SQL Server 2005 to SQL Server 2017.

Azure Database Migration Service isn't the only Microsoft database migration tool. Get a [comparison of tools and services](https://techcommunity.microsoft.com/t5/microsoft-data-migration/bg-p/microsoftdatamigration).

##### Use Azure Database Migration Service at scale

Contoso uses Azure Database Migration Service when they migrate from SQL Server.

When Contoso provisions Azure Database Migration Service, they size it correctly and set it to optimize performance for data migrations. Contoso selects the Business Critical service tier with four vCores. This option allows the service to take advantage of multiple vCPUs for parallelization and faster data transfer.

![Screenshot that shows Database Migration Service scaling, with the Business Critical option selected.](./media/contoso-migration-scale/dms.png)

Contoso can also temporarily scale up the Azure SQL Database or Azure Database for MySQL target instance to the Premium pricing tier during data migration. This option minimizes database throttling that might affect data transfer activities when an organization uses lower tiers.

##### Use other tools

Contoso can use other tools and services to identify VM information, like:

- Scripts to help with manual migrations. The scripts are available in the GitHub repo.
- [Partner tools](https://azure.microsoft.com/migration/migration-center-partners/) for migration.

<!-- docutune:ignore "cost management tools" -->

## Ready for production

After Contoso moves resources to Azure, it streamlines them to improve performance and maximize ROI with cost management tools. Because Azure is a pay-for-use service, it's important for Contoso to understand how systems are performing and to ensure they're sized properly.

### Azure Cost Management + Billing

To make the most of their cloud investment, Contoso takes advantage of the free Azure Cost Management + Billing tool. This solution allows Contoso to manage cloud spending with transparency and accuracy. It provides tools to monitor, allocate, and trim cloud costs.

Azure Cost Management + Billing provides dashboard reports to help with cost allocation, showbacks, and chargebacks. The tool can help optimize cloud spending by identifying underutilized resources that Contoso can manage and adjust.

For more information, see [overview of Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview).

[![Screenshot of an example graph of cost over time in Azure Cost Management and Billing.](./media/contoso-migration-scale/cost-management.png)](./media/contoso-migration-scale/cost-management.png#lightbox)

### Native tools

Contoso uses scripts to locate unused resources.

During large migrations, there are often leftover pieces of data, such as virtual hard drives, which incur a charge but provide no value to the company. Scripts are available in the [GitHub repo](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

Contoso takes advantage of the work done by Microsoft's IT department and considers implementing the Azure Resource Optimization (ARO) toolkit. The toolkit is in the GitHub repo.

Contoso saves money by deploying an Azure Automation account with preconfigured runbooks and schedules to its subscription. Resource optimization happens automatically on a subscription after a schedule is enabled or created, including optimization on new resources. This provides decentralized automation capabilities, which reduces costs. With an Azure Automation account, you can:

- Autosnooze Azure VMs based on low CPU utilization.
- Schedule Azure VMs to snooze and unsnooze.
- Schedule Azure VMs to snooze or unsnooze in ascending and descending order by using Azure tags.
- Bulk-delete resource groups on demand.

### Partner optimization tools

Contoso can use partner tools, such as [Hanu](https://hanu.com/insight/) and [Scalr](https://www.scalr.com/pricing).

## Step 4: Secure and manage

Contoso uses Azure security and management resources to govern, secure, and monitor cloud applications in Azure. These resources help an organization run a secure and well-managed environment while using products available in the Azure portal.

Contoso begins using these services during migration. With Azure hybrid support, Contoso continues using many of them for a consistent experience across the hybrid cloud.

### Security

Contoso will rely on Microsoft Defender for Cloud for unified security management and Microsoft Defender for Identity across hybrid cloud workloads.

Defender for Cloud provides full visibility into and control over the security of cloud applications in Azure. Contoso can quickly detect and take action in response to threats, and reduce security exposure by enabling adaptive threat protection.

Learn more about [Defender for Cloud](https://azure.microsoft.com/services/security-center/).

### Monitoring

Contoso needs visibility into the health and performance of the newly migrated applications, infrastructure, and data now running in Azure. Contoso will use built-in Azure cloud monitoring tools such as Azure Monitor, a Log Analytics workspace, and Application Insights.

By using these tools, Contoso can easily collect data from sources and gain insights. For example, Contoso can gauge CPU disk and memory utilization for VMs, view applications and network dependencies across multiple VMs, and track application performance. Contoso will use these cloud monitoring tools to take action and integrate with service solutions.

Learn more about [Azure monitoring](/azure/azure-monitor/overview).

### Business continuity and disaster recovery

Contoso will need a business continuity and disaster recovery (BCDR) strategy for its Azure resources.

Azure provides [built-in BCDR features](/azure/architecture/framework/resiliency/backup-and-recovery) to help protect data and keep applications and services running.

In addition to built-in features, Contoso wants to ensure that it can recover from failures, avoid costly business disruptions, meet compliance goals, and protect data against ransomware and human errors. To do this:

- Contoso will deploy Azure Backup as a cost-efficient solution for backup of Azure resources. Because it's built in, Contoso can set up cloud backups in a few simple steps.
- Contoso will set up disaster recovery for Azure VMs by using Azure Site Recovery for replication, failover, and failback between Azure regions that it specifies. This ensures that applications running on Azure VMs remain available in a secondary region of Contoso's choosing if an outage occurs in the primary region. [Learn more](/azure/site-recovery/azure-to-azure-quickstart).

## Conclusion

In this article, Contoso planned for an Azure migration at scale. It divided the migration process into four stages. The stages ran from assessment and migration, through to optimization, security, and management after migration was complete.

It's important for an organization to plan a migration project as a whole process and to migrate its systems by breaking down sets into classifications and numbers that make sense for the business. By assessing data and applying classifications, projects can be broken down into a series of smaller migrations, which can run safely and rapidly. The sum of these smaller migrations quickly turns into a large successful migration to Azure.
