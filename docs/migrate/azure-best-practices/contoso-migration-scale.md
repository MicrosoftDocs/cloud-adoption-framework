---
title: Scale a migration to Azure
description: Learn how to use the Cloud Adoption Framework for Azure to plan for and perform a migration at scale to Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/12/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal, UpdateFrequency2
---

<!-- docutune:casing Y/N None/Some/Severe Rehost/Refactor/Rearchitect/Rebuild -->

# Scale a migration to Azure

This article demonstrates how the fictional company, Contoso, performs a migration at scale to Azure. The company considers how to plan and perform a migration of more than 3,000 workloads, 8,000 databases, and 10,000 virtual machines (VMs).

## Business drivers

The IT leadership team works closely with business partners to understand what they want to achieve with this migration. They plan to:

- **Address business growth.** Contoso is growing, which creates pressure on on-premises systems and infrastructure.
- **Increase efficiency.** Contoso needs to remove unnecessary procedures and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, so they can deliver customer requirements quickly.
- **Increase agility.** Contoso IT needs to be responsive to the needs of the business. They must react faster than the changes in the marketplace to enable success in a global economy. IT can't get in the way or become a business blocker.
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
| Workloads | > 3,000 applications | - Applications run on VMs <br> - Application platforms, including Windows, SQL Server, and [LAMP](https://wikipedia.org/wiki/LAMP_software_bundle) |
| Databases | Approximately 8,500 databases | Databases, including SQL Server, MySQL, and PostgreSQL |
| VMs | > 35,000 VMs | vCenter servers manage VMs that are run on VMware hosts |

## Migration process

Now that Contoso has established business drivers and migration goals, it can align to the [Migrate methodology](../index.md). It can build on the application of migration waves and migration sprints to iteratively plan and execute migration efforts.

## Step 1: Plan

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

Contoso identifies common categories to classify assets in the inventory. These classifications are crucial to Contoso's decision making for migration. The classification list helps to establish migration priorities and identify complex issues.

| Category | Assigned value | Details |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can Contoso use the application as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the application communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the application? Does the application use unencrypted data or out-of-date platforms? |

### Discover application dependencies

As part of the assessment process, Contoso identifies where applications are running. It determines the dependencies and connections between application servers. Contoso maps the environment in steps:

1. Contoso discovers how servers and machines map to individual applications, network locations, and groups.
1. Contoso identifies applications that have few dependencies and are suitable for a quick migration.
1. Contoso uses mapping to identify complex dependencies and communications between application servers. Contoso can group these servers logically to represent applications and plan a migration strategy based on these groups.

With mapping completed, Contoso ensures that all application components are identified and accounted for when building the migration plan.

[![Diagram of an example dependency mapping.](./media/contoso-migration-scale/dependency-map.png)](./media/contoso-migration-scale/dependency-map.png#lightbox)

### Evaluate applications

As the last step in the discovery and assessment process, Contoso evaluates assessment and mapping results to determine how to migrate each application in the service catalog.

Contoso adds classifications to the inventory to capture the evaluation process.

| Category | Assigned value | Details |
| --- | --- | --- |
| Business group | List of business group names | Which group is responsible for the inventory item? |
| POC candidate | Y/N | Can the application be used as a POC or early adopter for cloud migration? |
| Technical debt | None/Some/Severe | Is the inventory item running or using an out-of-support product, platform, or operating system? |
| Firewall implications | Y/N | Does the application communicate with the internet or outside traffic? Does it integrate with a firewall? |
| Security issues | Y/N | Are there known security issues with the application? Does the application use unencrypted data or out-of-date platforms? |
| Migration strategy | Rehost/Refactor/Rearchitect/Rebuild | What kind of migration is needed for the application? How is the application deployed in Azure? [Learn more](./contoso-migration-overview.md#migration-patterns). |
| Technical complexity | 1-5 | How complex is the migration? Contoso DevOps and relevant partners define this value. |
| Business criticality | 1-5 | How important is the application for the business? For example, a small workgroup application might be assigned a score of one, and a critical application that's used across the organization might be assigned a score of five. This score affects the migration priority level. |
| Migration priority | 1/2/3 | What's the migration priority for the application? |
| Migration risk | 1-5 | What's the risk level for migrating the application? Contoso DevOps and relevant partners should agree on this value. |

### Determine costs

To determine the costs and potential savings of Azure migration, Contoso uses the [total cost of ownership (TCO) calculator](https://azure.microsoft.com/pricing/tco/calculator/). Contoso compares the TCO calculations for Azure to a similar on-premises deployment.

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

- In vCenter to organize VMs into folders. This arrangement makes it easy for the admins to focus as they run an assessment against VMs in a specific folder.
- To assess dependencies between machines. This action requires agents to be installed on the VMs to be assessed.

Contoso uses automated scripts to install the required Windows or Linux agents. By scripting, Contoso can push the installation to VMs within a vCenter folder.

#### Database tools

Contoso focuses on using tools specifically for database assessment. Tools such as [Data Migration Assistant](/sql/dma/dma-overview) assess SQL Server databases for migration.

Data Migration Assistant helps Contoso determine if on-premises databases are compatible with a range of Azure database solutions. These solutions include Azure SQL Database, SQL Server running on an Azure IaaS VM, and Azure SQL Managed Instance.

Contoso has some scripts that it uses to discover and document the SQL Server databases. These scripts are located in the GitHub repo.

#### Partner assessment tools

Many other partner tools can help Contoso assess the on-premises environment for migration to Azure. Learn more about [Azure migration partners](https://azure.microsoft.com/resources/azure-migrate-isv-playbook).

## Step 2: Migrate

With the assessment complete, Contoso identifies the tools to move its applications, data, and infrastructure to Azure.

### Migration strategies

Contoso considers four broad migration strategies.

| Strategy | Details | Usage |
| --- | --- | --- |
| Rehost | - This strategy, often called a *lift-and-shift* migration, is a no-code option that migrates existing applications to Azure quickly. <br> - An application is migrated as is with the benefits of the cloud and without the risks or costs associated with code changes. | - Contoso can rehost less-strategic applications that require no code changes. |
| Refactor | - This strategy, also called *repackaging*, requires minimal application code or configuration changes to connect the application to Azure PaaS and takes advantage of cloud capabilities. | - Contoso can refactor strategic applications to retain the same basic functionality but move them to run on an Azure platform, such as Azure App Service. <br> - This strategy requires minimum code changes. <br> - Contoso has to maintain a VM platform because Microsoft doesn't manage it. |
| Rearchitect | - This strategy modifies or extends an application code base to optimize the application architecture for cloud capabilities and scale. <br> - It modernizes an application into a resilient, highly scalable, independently deployable architecture. <br> - Azure services can accelerate the process, scale applications with confidence, and manage applications with ease. |
| Rebuild | - This approach rebuilds an application from scratch by using cloud-native technologies. <br> - Azure PaaS provides a complete development and deployment environment in the cloud. It eliminates some expense and complexity of software licenses. It removes the need for an underlying application infrastructure, middleware, and other resources. | - Contoso can rewrite critical applications to take advantage of cloud technologies, such as serverless compute or microservices. <br> - Contoso manages the application and services that it develops, and Azure manages everything else. |

Data must be considered, especially because Contoso has a high volume of databases. Contoso's default approach is to use PaaS services such as Azure SQL Database to take full advantage of cloud features. When Contoso moves to a PaaS service for databases, they only have to maintain data. Microsoft maintains the underlying platform.

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

#### Azure Database Migration Service

Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms with minimal downtime. Azure Database Migration Service:

- Integrates the functionality of existing tools and services. It uses Data Migration Assistant to generate assessment reports that pinpoint recommendations about database compatibility and required modifications.
- Uses a simple, self-guided migration process with intelligent assessment to address potential issues before the migration.
- Can migrate at scale from multiple sources to the target Azure database.
- Provides support from SQL Server 2005 to SQL Server 2017.

Azure Database Migration Service isn't the only Microsoft database migration tool. Get a [comparison of tools and services](https://azure.microsoft.com/resources/azure-migrate-isv-playbook).

##### Use Azure Database Migration Service at scale

Contoso uses Azure Database Migration Service when they migrate from SQL Server.

When Contoso provisions Azure Database Migration Service, they size it correctly and set it to optimize performance for data migrations. Contoso selects the Business Critical service tier with four vCores. This option allows the service to take advantage of multiple vCPUs for parallelization and faster data transfer.

![Screenshot that shows Database Migration Service scaling, with the Business Critical option selected.](./media/contoso-migration-scale/dms.png)

Contoso can also temporarily scale up the Azure SQL Database or Azure Database for MySQL target instance to the Premium pricing tier during data migration. This option minimizes database throttling that might affect data transfer activities when an organization uses lower tiers.

##### Use other tools

Contoso can use other tools and services to identify VM information, like:

- Scripts to help with manual migrations. The scripts are available in the GitHub repo.
- [Partner tools](https://azure.microsoft.com/resources/azure-migrate-isv-playbook) for migration.

<!-- docutune:ignore "cost management tools" -->

## Step 3: Ready for production

After Contoso moves resources to Azure, it streamlines them to improve performance and maximize ROI with cost management tools. Because Azure is a pay-for-use service, it's important for Contoso to understand how systems are performing and to ensure they're sized properly.

### Azure Cost Management + Billing

To make the most of their cloud investment, Contoso takes advantage of the free Azure Cost Management + Billing tool. This solution allows Contoso to manage cloud spending with transparency and accuracy. It provides tools to monitor, allocate, and trim cloud costs.

Azure Cost Management + Billing provides dashboard reports to help with cost allocation, showbacks, and chargebacks. The tool can help optimize cloud spending by identifying underutilized resources that Contoso can manage and adjust.

For more information, see [Overview of Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview).

[![Screenshot of an example graph of cost over time in Azure Cost Management and Billing.](./media/contoso-migration-scale/cost-management.png)](./media/contoso-migration-scale/cost-management.png#lightbox)

### Native tools

Contoso uses scripts to locate unused resources.

During large migrations, there are often leftover pieces of data, such as virtual hard drives, which incur a charge but provide no value to the company. Scripts are available in the [GitHub repo](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

Contoso takes advantage of the work done by Microsoft's IT department and considers implementing the Azure Resource Optimization (ARO) toolkit. The toolkit is in the GitHub repo.

Contoso saves money by deploying an Azure Automation account with preconfigured runbooks and schedules to its subscription. Resource optimization happens automatically on a subscription after a schedule is enabled or created, including optimization on new resources. This account provides decentralized automation capabilities, which reduce costs. With an Azure Automation account, you can:

- Autosnooze Azure VMs based on low CPU utilization.
- Schedule Azure VMs to snooze and unsnooze.
- Schedule Azure VMs to snooze or unsnooze in ascending and descending order by using Azure tags.
- Bulk-delete resource groups on demand.

### Partner optimization tools

Contoso can use partner tools, such as [Hanu](https://hanu.com/insight/) and [Scalr](https://www.scalr.com/pricing).

## Step 4: Secure and manage

Contoso uses Azure security and management resources to govern, secure, and monitor cloud applications in Azure. These resources help an organization run a secure and well-managed environment while using products that are available in the Azure portal.

Contoso begins using these services during migration. With Azure hybrid support, Contoso continues using many of the services for a consistent experience across the hybrid cloud.

### Security

Contoso relies on Microsoft Defender for Cloud for unified security management and Microsoft Defender for Identity across hybrid cloud workloads.

Defender for Cloud provides full visibility into and control over the security of cloud applications in Azure. Contoso can quickly detect and take action in response to threats and enable adaptive threat protection to reduce security exposure.

For more information, see [Microsoft Defender for Cloud](https://azure.microsoft.com/services/security-center/).

### Monitor

Contoso needs visibility into the health and performance of the newly migrated applications, infrastructure, and data that runs in Azure. Contoso uses built-in Azure cloud monitoring tools, such as Azure Monitor, a Log Analytics workspace, and Application Insights.

Contoso can use these tools to collect data from sources and gain insights. For example, Contoso can gauge CPU disk and memory utilization for VMs, view applications and network dependencies across multiple VMs, and track application performance. Contoso uses these cloud monitoring tools to take action and integrate with service solutions.

For more information, see [Azure Monitor overview](/azure/azure-monitor/overview).

### Business continuity and disaster recovery

Contoso needs a business continuity and disaster recovery (BCDR) strategy for its Azure resources.

Azure provides [built-in BCDR features](/azure/architecture/framework/resiliency/backup-and-recovery) to help protect data and keep applications and services running.

Contoso wants to ensure that it can recover from failures, avoid costly business disruptions, meet compliance goals, and protect data against ransomware and human errors. Contoso decides to:

- Deploy Azure Backup as a cost-efficient solution for backup of Azure resources. Because it's built in, Contoso can set up cloud backups in a few simple steps.
- Set up disaster recovery for Azure VMs by using Azure Site Recovery for replication, failover, and failback between Azure regions that it specifies. Applications that run on Azure VMs remain available in a secondary region of Contoso's choosing if an outage occurs in the primary region. For more information, see [Set up disaster recovery to a secondary Azure region for an Azure VM](/azure/site-recovery/azure-to-azure-quickstart).

## Conclusion

In this article, Contoso planned for an Azure migration at scale. It divided the migration process into four stages from assessment and migration to optimization, security, and management after the migration was complete.

It's important for an organization to plan a migration project as a whole process and to migrate its systems by breaking down sets into classifications and numbers that make sense for the business. Assess data and apply classifications for projects to break them down into a series of smaller migrations, which can run safely and rapidly. The sum of these smaller migrations quickly turns into a large successful migration to Azure.
