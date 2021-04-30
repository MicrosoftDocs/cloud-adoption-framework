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

Migration of workloads to Azure can be a challenging project, therefore good preparation for a migration project has a significant impact towards success and in reducing overall complexity of the migration project.

This article shows how the fictional company Contoso uses Azure Migrate to plan for migration. Contoso performs discovery and assessment of their existing environment that is targeted for migration to Azure.

When using this example to help plan your own infrastructure migration efforts, keep in mind that the provided sample plan and deployment is specific to Contoso. Review your organization's business needs, structure, and technical requirements when making important infrastructure migration decisions.

Whether you need all the elements described in this article depends on your migration strategy and needs. For example, you might find it's better to discover workload dependencies using existing network monitoring tools or get recommended VM sizes using Movere or other 3rd party tools.

## Overview

In order for Contoso to prepare for migration to Azure, it's critical to plan for the right set of discovery and assessment tools and activities. Deploying and running discovery tools enables Contoso to gather critical information on the environment targeted for migration to Azure.

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
> - **Step 1: Set up tooling for Discovery & Assessment.** How many discovery appliances and/or agents will you need? What are the best practices to run discovery of your environments? Do I need dependency mapping and application discovery?
> - **Step 2: Perform Assessment.** How do I select parameters for assessment? How do I know if my servers are ready for migration to Azure? How do I estimate costs of migrated servers?
> - **Step 3: Dependency Analysis and Migration Planning.** Which servers are used for a specific application workload? What other components does the workload depend on? What are the dependencies between servers and its workloads?
> - **Step 4: Plan for Migration Waves.** Are my servers ready for migration to Azure? How do I prioritize and group servers and its workloads across migration waves?

## Before you start

Before diving deep into infrastructure discovery and assessment, consider reading some background information relevant to Azure Migrate discovery and assessment:

- Review Azure Migrate [Discovery and assessment tool overview](https://docs.microsoft.com/azure/migrate/migrate-services-overview#azure-migrate-discovery-and-assessment-tool).
- Review the deployment scenarios and requirements for the Azure Migrate appliance which performs discovery [Azure Migrate appliance](https://docs.microsoft.com/azure/migrate/migrate-appliance#deployment-scenarios).
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
> You can discover up to 10,000 servers from a VMware environment, up to 5,000 servers from a Hyper-V environment, and up to 1000 physical servers by using a single appliance. If you have more servers, read about [scaling a Hyper-V assessment](https://docs.microsoft.com/azure/migrate/scale-hyper-v-assessment), [scaling a VMware assessment](https://docs.microsoft.com/azure/migrate/scale-vmware-assessment), or [scaling a physical server assessment](https://docs.microsoft.com/azure/migrate/scale-physical-assessment).

Based on the workflow above and following relevant Azure Migrate documentation, Contoso deploys the required appliance(s) and/or agents for discovery. During deployment, Contoso will need to provide server credentials that are used to perform software inventory (installed applications, roles and features), agentless dependency analysis, agent-based dependency analysis, and discovery of SQL Server instances and databases. Contoso's migration team will collaborate with the server infrastructure and SQL DBA teams to prepare required credentials for discovery. After deployment and configuration, Contoso regularly validates that data is being collected by the appliance and visible in the Azure Migrate project.

As a best practice, Contoso gathers data over a prolonged period of time, for example 5 weeks. The goal is to gather server performance data and dependencies over a period of time which ensures collection of behavior such as: monthly infrastructure consumption spikes, like a month end transaction (payroll application), weekly batch process, and data import/export.

## Step 2: Perform Assessment

After discovery of the on-premises servers has been running for at least a day, Contoso can start creating assessments in the Azure Migrate project through the Azure Portal. Their plan will be to create an assessment per environment (Non-Prod and Prod). 

Contoso can choose to run various assessments such as [Azure VM assessment](https://docs.microsoft.com/azure/migrate/concepts-assessment-calculation), [Azure SQL assessment](https://docs.microsoft.com/azure/migrate/concepts-azure-sql-assessment-calculation), or [AVS assessment](https://docs.microsoft.com/azure/migrate/concepts-azure-vmware-solution-assessment-calculation). Contoso starts with the VM assessment following the [assessment best practices](https://docs.microsoft.com/azure/migrate/best-practices-assessment) and executes Azure SQL assessment later. As a discovery source, Contoso chooses servers discovered through the Azure Migrate appliance.

Contoso understands that the Azure Migrate appliance will continue to collect performance data of their on-premises infrastructure and send it over to Azure Migrate, therefore Contoso has the opportunity to re-calculate Azure Migrate assessment at any future point in time to ensure the latest data sets are being included as migration execution approximates. 

> [!NOTE]
> For server infrastructure which Contoso is not be able to discover via the Azure Migrate appliance, they plan to create a CSV file with the required data and upload it to Azure Migrate. [**Learn more**](https://docs.microsoft.com/azure/migrate/tutorial-discover-import) on how to import discovery data using CSV file.

### Assessment properties

Contoso plans to tune their assessments and plans to specify [custom parameters](https://docs.microsoft.com/azure/migrate/how-to-modify-assessment). For both assessments, prod and non-prod, they specify their primary Azure region as the target location, as well as, same Sizing criteria, Comfort factor, Pricing and Licensing. However, in terms of compute and storage, Contoso plans to have VM SKUs and storage types specified differently in the assessments. 

For production, Contoso un-checks VM SKU options for the A-series (in the future B-series) and sets storage type to Standard SSD and Premium managed disks. For non-production, Contoso leaves checked all VM-series and storage type set to Automatic. 

Contoso plans to migrate to Azure and observe behavior for at least a few months before making purchase arrangements for Reserved Instances. If Contoso were to want to purchase Reserved Instances in advanced, then for the assessments, after discussing with business on selecting right Reserved capacity (compute) option, Contoso would have selected VM series or specific VM SKUs which are within the reserved instances purchased scope.

Contoso selects Performance-based sizing criteria and sets Performance history to one month. This will enable Contoso to find recommended VM sizes and managed disks based on actual server requirements that were gathered during the discovery phase. Thus, resulting in optimization of infrastructure as a result of the migration. Contoso understands that Azure Migrate assessment will recommend VM SKUs based on CPU and memory utilization. For disk types, Azure Migrate will base the recommendations on IOPS and throughput of the existing disks in the on-premises servers assessed. 

Further, as Contoso expects existing workloads to slightly increase on their resource utilization in the future, they select 1.1x as the Comfort factor. This will add 10% more resources to VM requirements based on the gathered performance data and recommend VM sizes which include this 10% buffer.

Based on the Microsoft Azure offer associated with Contoso's Azure subscription, appropriate Offer/Licensing program and Currency is selected. Contoso is eligible for [Azure Hybrid Benefit](http://go.microsoft.com/fwlink/?LinkId=859786), so they set 'Already have a Windows Server license' to 'Yes'. Contoso understands that by not setting the AHUB benefit, this may result in additional billing of already purchased Windows Server licenses. Contoso also understand that the AHUB benefit primarily applies to Windows Operating Systems and therefore for any Linux-based or other type of Operating System, Contoso will need to consult on license portability separately.

After saving assessment properties, Contoso needs to select servers to assess. Contoso creates a new [server group](https://docs.microsoft.com/azure/migrate/how-to-create-a-group) that includes all discovered servers from all discovery appliances and creates assessments for each specific environment. Although Contoso considered creating a server group and assessment for each specific application, while the ideal scenario, it was decided to create server groups at a later stage, closer to wave migration planning, as more time is needed to analyze dependencies between servers.

> [!NOTE]
> Contoso can create multiple assessments. Each assessment can have different assessment properties and different group of servers. Multiple assessments can be ran against the same set of servers/groups. All assessments will be stored in Azure Migrate project. This allows Contoso to compare different assessments and decide what migration options are best for their needs and business case (VM sizing, storage type, reserved capacity, etc.) and estimate the monthly cost.

### Azure readiness

Azure Migrate is able to calculate assessment results in a few minutes after creating the assessment. Once the assessment results are available, Contoso reviews Azure readiness for all servers that were assessed. Azure Migrate provides visualization that enables Contoso to drill down on servers readiness details for each server. Assessment details include recommended VM SKU, storage type, networking configuration, and most importantly, Azure readiness.

Contoso spends some time reviewing the reasons why some servers are conditionally ready for migration to Azure and why some servers are not ready for migration to Azure. Contoso refers to the list of [assessment readiness issues](https://docs.microsoft.com/azure/migrate/troubleshoot-assessment#assessment-readiness-issues) which provides insights on the steps needed to mitigate Azure readiness issues. After a throughout review, Contoso prepares a plan of action to fix readiness issues where possible (upgrade OS, change boot type, remove unused disks, etc.). For servers where issues can't be easily mitigated, Contoso decides to take different migration approach such as: replatform, modernize, replace, retire, etc.

> [!NOTE]
> Although the server is marked as "Ready" and Azure Infrastructure will support the necessary configuration, the replication appliance or agents may not always support the replication of the server (eg. Windows Server Failover Clustering with shared disks). It's important to additionally review the [Azure Migrate Appliance (VMWare agentless)](https://docs.microsoft.com/en-us/azure/migrate/migrate-support-matrix-vmware-migration#vm-requirements-agentless), Replication appliance ([VMWare agent-based](https://docs.microsoft.com/en-us/azure/migrate/migrate-support-matrix-vmware-migration#vm-requirements-agent-based), [physical and other Clouds](https://docs.microsoft.com/en-us/azure/migrate/migrate-support-matrix-physical-migration#physical-server-requirements)), and [replication agents (Hyper-V)](https://docs.microsoft.com/en-us/azure/migrate/migrate-support-matrix-hyper-v-migration#hyper-v-vms) supported VM configurations. If an unsupported VM configuration is identified and confirmed, consider a different migration approach such as redeployment of the application or database in a net new Azure VM.

### Azure SQL Server assessment

Contoso is running SQL Server in their on-premises environment. As part of the migration project to Azure, Contoso would like to understand additional options and modernization approaches for migrating SQL Server workloads to Azure SQL database or SQL Managed Instance. Although, Contoso's primary migration approach is rehost to Azure VMs via server replication using Azure Migrate, Contoso would like to explore what modernization is possible given their current server configurations. This is exploratory at this stage for Contoso in order to keep focus on the current migration strategy.

Azure Migrate supports creating assessments for migration to Azure SQL and SQL MI, which Contoso finds as insightful assessments to create. For the target location Contoso chooses their primary Azure region and for Target deployment type Contoso selects 'Recommended' as they would like to know if Azure SQL DB or Azure SQL MI is a better fit for their databases. Contoso specifies comfort factor to 1.1 to account for planned future workload growth. In the pricing section Contoso chooses options that are aligned with their Azure offer and licensing programs. Contoso re-uses the prior groups created and runs assessment for this group.

### Azure cost details

Azure Migrate assessment results include cost estimation for assessed servers. Contoso can estimate total compute and storage costs for migration, or drill down for compute and storage cost estimation per individual server. Contoso understands that after migration to Azure, the server might incur other costs related to networking, monitoring, backup, etc. Those additional costs are not part of the assessment cost details. For these cost details scenarios, Contoso resorts to using the [Azure calculator](https://azure.microsoft.com/en-us/pricing/calculator/).

## Step 3: Dependency analysis and Migration planning

To perform a successful migration to Azure, it is critical for Contoso to understand workload details in the context of their dependencies during migration planning. As a best practice, Contoso migration team needs to identify application owners of the workloads running on each of the server assessed for the migration. Contoso uses their CMDB data to link discovered servers to various business applications and identify respective applications owners, their development and support teams. After application owners are identified, Contoso migration team schedules review meetings (interviews) with them.

The migration team is now better prepared to [group servers](https://docs.microsoft.com/azure/migrate/how-to-create-a-group) for workload specific assessment based on the application tiers and initial dependencies given the application owner interviews and analysis.

### Dependency analysis

To further validate server groups and plan for migration waves Contoso needs to understand dependencies between workloads and its servers. Contoso uses the results of the [dependency analysis](https://docs.microsoft.com/azure/migrate/concepts-dependency-visualization) which were ran during the assessment phase. Contoso exports dependency results and uses [Power BI to visualize network connections](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi).

To perform effective dependency analysis, Contoso takes the following steps:

1. Clean up dependency mapping scan to show unique dependencies based on a one-month period of time by using the PowerShell script as [described in the documentation.](https://docs.microsoft.com/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi). This script works as-is for agentless dependency mapping, however for agent-based dependency mapping, KQL queries must be created in order to perform the same task. With agent-based dependency mapping, the longest period of time available for is one-hour. 

2. Filter out the noise from the dependency mapping scan by removing well-known dependencies such as:
  - Known system processes
  - Known internet-based endpoints (non-RFC 1918)
  - Known internal endpoints (RFC 1918) such as Domain controllers, File servers, network appliances (for example Load Balancers), management infrastructure (for example SCCM, SCOM, backup, anti-malware, etc.)

3. Integrate dependency scan into visualization tooling like Power BI. Helpful visualizations include:
  - [Sankey](https://powerbi.microsoft.com/blog/visual-awesomeness-unlocked-sankey-diagram/)
  - [Network Navigator Chart](https://appsource.microsoft.com/product/power-bi-visuals/WA104380795)
  - [Tassels Parallel Sets Slicer](https://appsource.microsoft.com/product/power-bi-visuals/WA200000311)

### Review data collected with Application Owners

As Contoso continues to prepare for the migration, Contoso realizes they need to gather additional workload details from application owners. Based on the gathered information, the migration team will review complexity, criticality, and dependencies of each server group/workload and finalize the prioritization of server groups for their migration waves schedules. As Contoso schedules additional interviews with application owners they ensure collection of the following data points:

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

As a best practice, Contoso reviews server assessment results with application owners. During review, Contoso will:

- Validate assessment sizing recommendations (VM size, storage configuration, etc.)
- Identify any components that will need optimization or replacement in Azure (for example Load balancers, clusters...)
- Verify all dependencies are discovered and validated with application owners
- Confirm SLA requirements are met
- Review SQL assessment results and review options for re-platforming SQL server to Azure SQL Database or Managed Instance
- Review cost estimation

### Document Migration Plan

Based on the final assessment results and application owner interviews, the Contoso Migration team finalizes the migration approach. They document the migration steps including details from assessment, dependency analysis, and inputs from the application owner interviews. This captures additional configurations like load balancers, DNS updates, database connection strings, licenses and any additional steps the application team or vendor might need to execute as part of pre and post migration steps.

## Step 4: Plan for Migration Waves

Contoso now needs to finalize prioritization of the migration waves based on workload criticality, dependencies, business requirements, etc.

### Server Grouping

Based on the interviews and dependency mapping data, Contoso continues to refine their server groups based on the application architecture (multi-tier) and server dependencies. Contoso's initial server groups are as follows:

- Server Group 1 (LOB App 1): 5 Servers
- Server Group 2 (LOB App 2): 30 Servers
- Server Group 3 (LOB App 3): 50 Servers

### Migration Wave Planning

Contoso plans to start with smaller migration waves which includes standalone servers and workloads which are not business critical. Starting with single-instance servers as part of the initial migration wave, it will be easier to resolve any issues, verify migration process end-to-end, and build confidence in migration strategy. On subsequent migration waves, Contoso plans to include multiple non-production workloads. Once finalized with non-production, Contoso's migration waves will include production workloads. The most complex production workloads will be left towards the end within the last migration waves schedules. 

A migration wave can be a single large business application (multiple servers - web, app and database servers) or a couple of smaller, independent workloads. In tightly coupled environments, server groups may need to be split into different migration waves, for example a server group of 100+ servers, where because it contains shared servers cross multiple applications (eg. shared databases, shared web servers, shared file servers) the number of interdependent servers is large.

In the scenario where a server group (interdependent servers) has to be split and not all servers are migrated in a single wave, Contoso will ensure to:

- Identify which are the most latency sensitive connections to dependencies and prioritize these dependencies for the migration wave.
- Re-schedule the left-out servers to be migrated on the next immediate migration wave or as part of an interim migration wave.

Contoso uses the following [documented guidance](https://docs.microsoft.com/azure/migrate/concepts-migration-planning#prioritize-workloads) to prioritize server groups/workloads when assigning them to migration waves. In summary, best practices includes:

- Start with server groups with the least number of servers.
- Start with server groups based on lowest business criticality. For example:
  - Prioritize environments with lower business impact (Non-Prod vs. Prod).
  - Prioritize workloads with lower SLA and highest RTO/RPO.
  - Prioritize workloads with less restrictive Data Classification.
  - Prioritize workloads with newer operating system as older operating systems tend to have more issues booting in Azure or in supporting Azure management extensions.

Contoso understands that some migration waves will change as they progress through migration execution, therefore the migration team reviews and modifies waves periodically. The migration team incorporates learnings from executed waves to improve assessment and migration planning (such as capturing any missing network requirements, pre-migration testing, post-migration tweaks, review permissions, etc.). 

## Conclusion

In this article, Contoso sets up Azure Migrate tools for discovery and assessment and executes steps required to build a migration plan, server groups, and prioritization of server groups in migration waves.

Not every step taken here is required for building a migration plan. However, as good migration planning is often key to successful migration project, Contoso invests time in developing a proper migration plan by executing all steps as described above. It's also important to review and continuously improve the process based on previous migration wave and feedbacks from key stakeholders teams.

### Next steps

As next step Contoso will start implementing infrastructure required to execute migration. Best practices for migration execution are documented in the article [Plan and Deploy Azure Migrate for Servers](./contoso-migration-rehost-server-replication.md).
