---
title: Discover and assess your migratable estate with Azure Migrate
description: Learn how Contoso sets up an Azure Migrate for discovery and assessment of existing estate.
author: Andrej Kasnik (akasnik)
ms.author: Andrej Kasnik (akasnik)
ms.date: 04/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: azure-fast-track
---

# Discover and assess your migratable estate with Azure Migrate

Migration of workloads to Azure can be a challenging project and good preparation for migration has significant impact on success and reducing overall complexity of migration project.

This article shows how the fictional company Contoso uses Azure Migrate to plan for migration. Contoso performs discovery and assessment of existing environment that is targeted for migration to Azure.

When using this example to help plan your own infrastructure migration efforts, keep in mind that the provided sample plan and deployment is specific to Contoso. Review your organization's business needs, structure, and technical requirements when making important infrastructure migration decisions.

Whether you need all the elements described in this article depends on your migration strategy and needs. For example, you might find it's better to discover workload dependencies using existing network monitoring tools or get recommended VM sizes using Movere or other 3rd party tools.

## Overview

In order for Contoso to prepare for migration to Azure, it's critical to plan for the right set of discovery and assessment tools and activities. Deploying and running discovery tools enables Contoso to gather critical information on environment targeted for migration to Azure.

Gathered information will enable Contoso to:

- Build up-to-date inventory (server and workload) of their datacenter environments
- Identify server readiness for migration to Azure
- Perform assessment to get recommended sizing and storage for Azure VMs
- Get cost estimation for Azure VMs (Compute and Storage)
- Analyze server and workload dependencies
- Assess application compatibility with Azure
- Assess migration options for existing SQL servers
- Assess application migration options to Azure App Services
- Plan for Migration Waves

For successful migration planning Contoso needs to think about following areas:

> [!div class="checklist"]
> - **Step 1: Set up tooling for Discovery & Assessment.** How many discovery appliances will you need? What are the best practices to run discovery of your environments? Do I need dependency mapping and application discovery?
> - **Step 2: Perform Assessment.** How do I select parameters for assessment? How do I know if my servers are ready for migration to Azure? How do I estimate costs of migrated servers?
> - **Step 3: Dependency Analysis and Migration Planning.** Which servers are used for a specific application workload? What other components does workload depend on? What are dependencies between servers and workloads?
> - **Step 4: Plan for Migration Waves.** Are my servers ready for migration to Azure? How do I select servers and workloads for migration waves?

## Before you start

Before diving deep into infrastructure discovery and assessment, consider reading some background information relevant to Azure Migrate discovery and assessment:

- Review Azure Migrate [Discovery and assessment tool overview](https://docs.microsoft.com/azure/migrate/migrate-services-overview#azure-migrate-discovery-and-assessment-tool).
- Review the deployment scenarios and requirements for lightweight Azure Migrate appliance that performs discovery [Azure Migrate appliance](https://docs.microsoft.com/azure/migrate/migrate-appliance#deployment-scenarios).
- Review Azure Migrate [Assessment overview](https://docs.microsoft.com/azure/migrate/concepts-assessment-calculation).
- Optionally, walkthrough MS Learn's [Migrate virtual machines and apps using Azure Migrate](https://docs.microsoft.com/learn/paths/m365-azure-migrate-virtual-machine/) training.

## Step 1: Set up tooling for Discovery & Assessment

Contoso first needs to figure out the Azure Migrate appliance(s) needed for discovery and assessment.
### Discovery Tooling - Planning and Implementation

To start gathering data required for assessment, Contoso needs to prepare to deploy the appliances and/or agents needed for discovery of their on-premises server infrastructure.

Using the below workflow, Contoso can define the server discovery tools required to gather information from on-premises servers and their dependencies.

![Concept Diagram](./media/contoso-migration-assess-servers/discovery-workflow.png)

*Figure 1: Discovery Appliances and Agents Workflow.*

Further details can be found in the reference links below from the Azure Migrate documentation:

- [Ref Link A - Discover VMware VMs](https://docs.microsoft.com/azure/migrate/tutorial-discover-vmware#set-up-the-appliance)
- [Ref Link B - Discover Hyper-V VMs](https://docs.microsoft.com/azure/migrate/tutorial-discover-hyper-v#set-up-the-appliance)
- Ref Link C -
  - [Discover Physical/Other hypervisors](https://docs.microsoft.com/azure/migrate/tutorial-discover-physical#set-up-the-appliance)
  - [Discover AWS VMs](https://docs.microsoft.com/azure/migrate/tutorial-discover-aws#set-up-the-appliance)
  - [Discover GCP VMs](https://docs.microsoft.com/azure/migrate/tutorial-discover-gcp#set-up-the-appliance)
- Ref Link D -
  - [Dependency analysis (Azure Migrate/Agentless)](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies-agentless)
  - [Application Discovery](https://docs.microsoft.com/azure/migrate/how-to-discover-applications)
  - [SQL Server Discovery](https://docs.microsoft.com/azure/migrate/how-to-discover-sql-existing-project)
- [Ref Link E - Dependency analysis (Service Map/Agent-based)](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies)

> [!NOTE]
> You can discover up to 10,000 servers from VMware environment, up to 5,000 servers from Hyper-V environment, and up to 1000 physical servers by using a single appliance. If you have more servers, read about [scaling a Hyper-V assessment](https://docs.microsoft.com/azure/migrate/scale-hyper-v-assessment), [scaling a VMware assessment](https://docs.microsoft.com/azure/migrate/scale-vmware-assessment), or [scaling a physical server assessment](https://docs.microsoft.com/azure/migrate/scale-physical-assessment).

Based on the workflow above and following relevant Azure Migrate documentation, Contoso deploys required appliance(s) and/or agents for discovery. During deployment, Contoso will need to provide server credentials that are used to perform software inventory (installed applications, roles and features), agentless dependency analysis, discovery of SQL Server instances and databases. Contoso migration team will collaborate with server and SQL DBA teams to prepare required credentials for discovery. After deployment and configuration, Contoso regularly validates that data is being collected in Azure Migrate project.

As best practice, Contoso gathers data over longer period of time, for example 5 weeks. Goal is to gather server performance data and dependencies over a period, which might have specific peaks only once per month like a month end transaction (payroll), weekly batch process or data import/export.

## Step 2: Perform Assessment

After discovery is running for at least a day, Contoso can start performing assessments in Azure Migrate project through Azure Portal. Contoso can choose to run various assessments like [Azure VM assessment](https://docs.microsoft.com/en-us/azure/migrate/concepts-assessment-calculation), [Azure SQL assessment](https://docs.microsoft.com/en-us/azure/migrate/concepts-azure-sql-assessment-calculation) or [AVS assessment](https://docs.microsoft.com/en-us/azure/migrate/concepts-azure-vmware-solution-assessment-calculation).

Contoso starts with VM assessment following [assessment best practices](https://docs.microsoft.com/en-us/azure/migrate/best-practices-assessment) and executes Azure SQL assessment later. As discovery source, Contoso chooses servers discovered through Azure Migrate appliance.

> [!NOTE]
> In case Contoso is not be able to deploy Azure Migrate discovery appliance to collect data, they can provide a CSV file with required data to Azure Migrate. [**Learn more**](https://docs.microsoft.com/azure/migrate/tutorial-discover-import) on how to import discovery data using CSV file.

### Assessment properties

Contoso wants to specify [custom parameters](https://docs.microsoft.com/azure/migrate/how-to-modify-assessment) for assessment. They specify their primary Azure region as target location, leave storage type set to Automatic and discuss with business on selecting right Reserved capacity (compute) option.

For VM size properties Contoso selects Performance-based sizing criteria and sets Performance history to one month. This will enable Contoso to find recommended VM sizes based on actual server requirements that were gathered during discovery phase. Azure Migrate assessment will recommend VM size based on CPU and memory utilization. Disk type recommendation will be based on IOPS and throughput of the existing disks in servers assessed. As Contoso expects existing workloads to slightly increase on their resource usage in future, they select 1.1x as Comfort factor. This will add 10% more resources to VM requirements based on gathered performance data and recommend VM size including this 10% buffer.

Based on Microsoft Azure offer associated with Contoso's Azure subscription, appropriate Offer/Licensing program and Currency is selected. Contoso is eligible for [Azure Hybrid Benefit](http://go.microsoft.com/fwlink/?LinkId=859786), so they set 'Already have a Windows Server license' to 'Yes'.

After saving assessment properties, Contoso needs to select servers to assess. Contoso creates a new [server group](https://docs.microsoft.com/azure/migrate/how-to-create-a-group) that includes all discovered servers from all discovery appliances and creates assessment.

> [!NOTE]
> Contoso can create multiple assessments. Each assessment can have different assessment properties and different group of servers. Multiple assessments can be run against the same set of servers/groups. All assessments will be stored in Azure Migrate project. This allows Contoso to compare different assessments and decide what migration options are best for their needs and business case (VM sizing, storage type, reserved capacity, etc.) and estimate the monthly cost.

### Azure readiness

Azure Migrates calculates assessment results in a few minutes after creating the assessment. When assessment results are available, Contoso reviews Azure readiness of all servers that were assessed. Azure Migrate provides the visualization that enables Contoso to drill down to servers readiness details for each server. Assessment details include recommended VM size, storage, and networking configuration and Azure readiness.

Contoso reviews reasons why some servers are conditionally ready for migration to Azure and why some servers are not ready for migration to Azure. List of [assessment readiness issues](https://docs.microsoft.com/azure/migrate/troubleshoot-assessment#assessment-readiness-issues) helps Contoso understand steps to mitigate Azure readiness issues. Contoso prepares plan of actions to fix readiness issues where possible (upgrade OS, change boot type, remove unused disks, etc.) and decides to take different migration approach for servers where issues can't be easily mitigated (replatform, modernize, replace, retire, etc.).

> [!NOTE]
> Although the server is marked as "Ready" and Azure Infrastructure will support the necessary configuration, the replication appliance may not always support the replication of the server (eg. Windows Server Failover Clustering with shared disks).

### Azure SQL Server assessment

Contoso is running SQL Server in existing environment. As part of migration to Azure, Contoso would like to understand options for migrating SQL Server workloads to Azure SQL database or Managed Instance. Azure Migrate supports creating Azure SQL assessment and Contoso runs this assessment. For target location Contoso chooses their primary Azure region and for Target deployment type Contoso selects 'Recommended' as they would like to know if Azure SQL DB or Azure SQL MI is better fit for their databases. Contoso specifies comfort factor to 1.1 to account for planned future workload growth. In pricing section Contoso chooses options that are aligned with their Azure offer and licensing programs. Contoso creates a new group for all discovered SQL Servers and runs assessment for this group.

### Azure cost details

Azure Migrate assessment results include cost estimation for assessed servers. Contoso can estimate total compute and storage costs for migration, or drill down to estimation for compute and storage costs per individual server. Contoso understands that after migration to Azure, server might incur other costs related to networking, monitoring, backup, etc. Those additional costs are not part of assessment cost details.

## Step 3: Dependency analysis and Migration planning

To perform successful migration to Azure, it is critical for Contoso to understand workload details and their dependencies during migration planning. As a best practice, Contoso migration team needs to identify application owners of workloads running on each server that is being assessed for migration. Contoso uses their CMDB data to link discovered servers to various business applications and identify respective applications owners, their development and support teams. After application owners are identified, Contoso migration team schedules review meetings (interviews) with them.

The migration team [group machines](https://docs.microsoft.com/azure/migrate/how-to-create-a-group) for workload specific assessment based on the application tiers and their dependencies. During further analysis and application owner discussions, the idea is to further refine the group. This will also help later in finalizing migration batches.

### Dependency analysis

To plan for migration waves Contoso needs to understand dependencies between servers and workloads. Contoso uses results of [dependency analysis](https://docs.microsoft.com/azure/migrate/concepts-dependency-visualization) that ran during assessment. Contoso exports dependency results and uses [Power BI to visualize network connections](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi).

To perform effective dependency analysis, Contoso takes following steps:

- Cleans up dependency mapping scan to show unique dependencies based on the longest time by using PowerShell script as [described in the documentation.](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi)
- Filters out noise from dependency mapping scan by removing well-known dependencies such as
  - Known system processes
  - Known internet-based endpoints (non-RFC 1918)
  - Known internal endpoints (RFC 1918) such as Domain controllers, File servers, network appliances (for example Load Balancers), management infrastructure (for example SCCM, SCOM, backup, anti-malware, etc.)
- Integrate dependency scan into visualization tooling like Power BI. Helpful visualizations include:
  - [Sankey](https://powerbi.microsoft.com/blog/visual-awesomeness-unlocked-sankey-diagram/)
  - [Network Navigator Chart](https://appsource.microsoft.com/product/power-bi-visuals/WA104380795)
  - [Tassels Parallel Sets Slicer](https://appsource.microsoft.com/product/power-bi-visuals/WA200000311)

### Review data collected with Application Owners

As Contoso team prepares for migrations they need to gather workload details from application owners. Based on gathered information, migration team will review complexity, criticality and dependencies of each workload and finalizes the migration strategy accordingly. As Contoso schedules interview with application owners they use assessment questionnaire which includes following points:

- Business criticality
- Workload architecture (all servers and other components such as load balancers that are required for workload to run)
- Number and type of users (internal, external)
- Data classification
- SLA requirements
- Downtime window
- Backup mechanism
- Monitor mechanism
- Patching mechanism
- Licensing mechanism (OS and Software, dependency on MAC/IP address)
- Firewall Rules (Host and Network): Ports and Protocols
- Impact of changing servers IP

As best practice Contoso reviews server assessment results with application owners. During review, Contoso will:

- Validate assessment sizing recommendations (VM size, storage configuration, etc.)
- Identify any components that will need optimization or replacement in Azure (for example Load balancers, clusters...)
- Verify all dependencies are discovered and validated with application owner
- Confirm SLA requirements are met
- Review SQL assessment results and review options for re-platforming SQL server to Azure SQL Database or Managed Instance
- Review cost estimation

### Document Migration Plan

Based on the final assessment results and application owner interviews, Contoso Migration team finalizes the migration approach. They document the migration steps incl. details from assessment, dependency analysis and inputs from the application owner interviews. This captures additional configurations like load balancer, dns updates, db connection string, licenses and any additional steps the application team or vendor might need to execute as part of post migration steps.

## Step 4: Plan for Migration Waves

Contoso is now ready with server and application inventory, performed required assessments, captured server/application dependencies, completed application owner interviews and finalized the migration plan. Now they need to finalize the migration batches and order based on workload criticality, dependencies, business requirements, priority, etc.

Contoso already [completed a POC](./contoso-migration-rehost-vm.md) to see how Azure Migrate can help to migrate to the cloud. The POC also helped Contoso in finalizing couple of things:
- Identify any infrastructure issues/dependencies like firewall, agents, antivirus, that could potentially impact migrations.
- Evaluate the network bandwidth available for replication and make some calculations on the # of VMs that can be replicated at the same time/batch. Daily data churn (rate of change) on the VMs was also factored in.
Contoso will need to allocate sufficient bandwidth based on the daily data change rate for the required VMs, to meet its recovery point objective (RPO).

### Server Grouping

Based on the assessment, Contoso groups servers based on the application architecture (multi-tier) and server dependencies.
Example:
- Migration Batch/Group 1: 5 Servers
- Migration Batch/Group 2: 30 Servers
- Migration Batch/Group 3: 50 Servers

### Migration Wave Planning

Contoso plans to start with smaller migration batches which includes standalone servers and workloads which are not business critical. With smaller initial batch it is easier to resolve any issues, verify migration process end-to-end and build confidence in migration strategy. On the second migration batch, Contoso plans to include multiple non-production workloads. Typically a migration batch is a single large business application (multiple servers - web, app and database servers) or couple of smaller, independent workloads. However in tightly coupled environments, a migration batch may include multiple applications and their servers that have cross dependencies at different application tiers (eg. shared database or web servers, file servers).

Contoso uses following [documented guidance](https://docs.microsoft.com/azure/migrate/concepts-migration-planning#prioritize-workloads) to prioritize workloads when assigning them to migration waves. Other best practices includes:

- Start with Migration Batch/Groups with least number of interdependent servers.
- Start with Migration Batch/Groups based on lowest business criticality. For example:
  - Prioritize environments with lower business impact (Non-Prod vs. Prod).
  - Prioritize workloads with lower SLA and higher RTO/RPO.
  - Prioritize workloads with less restrictive Data Classification.
  - Prioritize workloads with newer operating system as older operating systems tend to have more issues booting in Azure or in supporting Azure management extensions.

Contoso understands that some migration waves will change as they progress through migration, therefore migration team reviews and modifies waves periodically. Migration team incorporates learnings from executed waves to improve assessment and migration planning (such as capturing any missing network requirements, pre-migration testing, post-migration tweaks, review permissions, etc.). In case migration wave has to be split and not all servers are migrated as planed in a wave, Contoso will:

- Identify which are the most latency sensitive connections to dependencies and prioritize these dependencies for the migration wave.
- Re-schedule the left-out servers to be migrated on the next migration wave or as part of an interim migration batch.

## Conclusion

In this article, Contoso sets up Azure Migrate tools for discovery and assessment and executes steps required to build migration plan with migration waves.

Not every step taken here is required for building a migration plan. However, as good migration planning is often key to successful migration project, Contoso invests time in developing a proper migration plan by executing all steps as described above. It's also important to review and continuously improve the process based on previous migration wave and feedbacks from project team.

### Next steps

As next step Contoso will start implementing infrastructure required to execute migration. Best practices for migration execution are documented in article [Plan and Deploy Azure Migrate for Servers](./contoso-migration-rehost-server-replication.md).
