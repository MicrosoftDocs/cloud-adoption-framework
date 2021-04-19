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

Migration of workloads to Azure can be a challenging project and good preparation for migration has big impact on success and complexity of migration.

This article shows how the fictional company Contoso uses Azure Migrate to plan for migration. Contoso performs discovery and assessment of existing environment that is targeted for migration to Azure.

When you use this example to help plan your own infrastructure migration efforts, keep in mind that the provided sample plan and deployment is specific to Contoso. Review your organization's business needs, structure, and technical requirements when making important infrastructure migration decisions.

Whether you need all the elements described in this article depends on your migration strategy and needs. For example, you might find it's better to discover workload dependencies using existing network monitoring tools or get recommended VM sizes using Movere or existing performance monitoring tools.

## Overview

In order for Contoso to plan migration to Azure, it's critical to plan for the right set of discovery and assessment toolset and activities. Deploying and running discovery tools enables Contoso to gather critical information on environment targeted for migration to Azure.

Gathered information will enable Contoso to:

- Build up-to date inventory of their datacenter - server and application estate
- Identify server readiness for migration to Azure.
- Perform assessment to get recommended sizing for Azure VMs
- Get cost estimation for Azure VMs and their storage requirements
- Analyze server dependencies to better plan migration waves
- Assess application compatibility with Azure
- Assess migration options for existing SQL servers
- Assess application migration options to Azure App Services

For successful migration planning Contoso needs to think about following areas:
> [!div class="checklist"]
> - **Step 1: Set up tooling for Discovery & Assessment.** How many discovery appliances will you need? What are the best practices to run discovery of your environments? Do I need dependency mapping and application discovery?
> - **Step 2: Perform Assessment.** How do I select parameters for assessment? How do I analyze dependencies and group servers?
> - **Step 3: Plan for migration waves.** Are my servers ready for migration to Azure? How do I select servers/groups for migration waves?

## Before you start

Before diving deep in infrastructure discovery and assessment, consider reading some background information relevant to Azure Migrate discovery and assessment:

- Review the deployment scenarios and requirements for lightweight Azure Migrate appliance that performs discovery [Azure Migrate appliance](https://docs.microsoft.com/azure/migrate/migrate-appliance#deployment-scenarios).
- Review Azure Migrate [Assessment overview](https://docs.microsoft.com/azure/migrate/concepts-assessment-calculation).
- Optionally, walkthrough MS Learn's [Migrate virtual machines and apps using Azure Migrate](https://docs.microsoft.com/learn/paths/m365-azure-migrate-virtual-machine/) Training.

## Step 1: Set up tooling for Discovery & Assessment

Contoso needs to figure out considerations on the type and number of appliances needed for discovery and assessment.

### Discovery Tooling - Planning and Implementation

To start gathering data required for assessment, Contoso needs to prepare to deploy the appliances and/or agents needed for discovery of their on-premises server infrastructure.

Using the below workflow, Contoso is able to define the server discovery tools required to gather information from on-premises servers and their dependencies.

![Concept Diagram](./media/contoso-migration-assess-servers/discovery-workflow.png)

*Figure 1: Discovery Appliances and Agents Workflow.*

Further details can be found in the reference links below from the Azure Migrate documentation:

- [Ref Link A - Discover VMWare VMs](https://docs.microsoft.com/azure/migrate/tutorial-discover-vmware#set-up-the-appliance)
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

Based on workflow above and following relevant Azure Migrate documentation, Contoso deploys required appliances and agents for discovery. During deployment Contoso will need to specify server credentials used to perform software inventory, agentless dependency analysis and discovery of SQL Server instances and databases if this data needs to be collected during discovery. Collaborate with server administration and SQL server administration teams to prepare required credentials for discovery. After deployment and configuration, Contoso regularly validates that data is being collected in Azure Migrate project.

As best practice Contoso gathers data over longer period of time, for example 5 weeks. This is to gather server performance data and dependencies over a period which might have specific peaks only once per month like a month end transaction (payroll) or weekly batch process or data import/export etc.

## Step 2: Perform Assessment

After discovery is running for at least a day, Contoso can start performing assessments in Azure Migrate project through Azure Portal. Contoso can choose to run Azure VM assessment or Azure SQL assessment. First, Contoso will run Azure VM assessment and execute Azure SQL assessment later. As discovery source, Contoso chooses Servers discovered from Azure Migrate Appliance.

> [!NOTE]
> In case Contoso would not be able to deploy Azure Migrate discovery appliance to collect data, they could provide CSV file with required data to Azure Migrate. [**Learn more**](https://docs.microsoft.com/azure/migrate/concepts-assessment-calculation#how-do-i-assess-with-imported-data) on how to import discovery data using CSV file.

#### Assessment properties

Contoso wants to specify [custom parameters](https://docs.microsoft.com/azure/migrate/how-to-modify-assessment) for assessment. They specify their primary Azure region as target location, leave storage type set to Automatic and discuss with business on selecting Reserved capacity (compute) option.

For VM size properties Contoso selects Performance-based sizing criteria and sets Performance history to 1 Month. This will enable Contoso to find recommended VM sizes based on actual server requirements that were gathered during discovery phase. Azure Migrate assessment will recommend VM size based on CPU and memory utilization. Disk type recommendation will be based on IOPS and throughput of the existing disks in servers assessed. As Contoso expected existing workloads to slightly increase in future usage, they select 1.1x as Comfort factor. This will add 10% more resources to VM requirements based on gathered performance data and recommend VM size including this 10% buffer.

Based on Microsoft Azure offer associated with Contoso's Azure subscription, appropriate Offer/Licensing program and Currency is selected. Contoso is eligible for [Azure Hybrid Benefit](http://go.microsoft.com/fwlink/?LinkId=859786), so they set 'Already have a Windows Server license' to 'Yes'.

After saving assessment properties Contoso needs to select servers to assess. Contoso creates a new server group that includes all discovered servers from all discovery appliances and creates assessment.

> [!NOTE]
> Contoso can run multiple assessments. Contoso can specifying different assessment properties and use different server groups per each assessment. All assessments will be stored in Azure Migrate project. This allows Contoso to compare different assessments and decide what migration options are best for their needs and business case (VM sizing, storage type, reserved capacity, etc.).

#### Azure readiness

Azure Migrates calculates assessment results in a few minutes after creating the assessment. When assessment results are available, Contoso reviews Azure readiness of all servers that were assessed. Azure Migrate provides the visualization that enables Contoso to drill down to servers readiness details for each server. Assessment details include recommended VM size, storage and networking configuration and Azure readiness.

Contoso reviews reasons why some servers are conditionally ready for migration to Azure and why some servers are not ready for migration to Azure. List of [assessment readiness issues](https://docs.microsoft.com/azure/migrate/troubleshoot-assessment#assessment-readiness-issues) helps Contoso understand steps to mitigate Azure readiness issues. Contoso prepares plan of actions to fix readiness issues where possible (upgrade OS, change boot type, remove unused disks, etc.) and decides to take different migration approach for servers where issues can not be easily mitigated (replatform, modernize, replace, retire, etc.).

> [!NOTE]
> Although the server is marked as "Ready" and Azure Infrastructure will support the necessary configuration, the replication appliance may not always support the replication of the server (eg. Windows Server Failover Clustering with shared disks).

As best practice Contoso reviews server assessment results with owners of workloads/applications that run on assessed servers. During review, Contoso will:

- Validate assessment sizing recommendations (VM size, storage configuration, etc.)
- Identify any components that will need optimization or replacement in Azure (eg. Load balancers, clusters...)
- SLA requirements
- Review costs estimation

#### Azure cost details

Azure Migrate assessment results include cost estimation for assessed servers. Contoso can estimate total compute and storage costs for migration, or drill down to estimation for compute and storage costs per individual server. Contoso understands that after migration to Azure, server might incur other costs related to networking, monitoring, backup, etc. Those additional costs are not part of assessment cost details.

## Step 3: Cutover and Post-Go-Live

As a final step, Contoso is now ready and confident to perform the production migrations. The envision that during Cutover all hands on deck will be required to ensure end-to-end support. Furthermore, after the soak period concludes, Contoso is looking forward to close-out and call for a successful migration to Azure.

### Cutover

With the migration activities and workflow defined, Contoso irons out the final plans for cutover by:

- Identifying more specific cutover window, which they have planned for a Friday evening or weekend. Each cutover window will last at a minimum for 4 hours.
- Announce to the business and those impacted by the migration of the maintenance window. The maintenance window should include a meeting invite that includes the migration plan and a conference bridge to discuss any open items during the migration.
- Reached out to the Network Admins, Backup Admins, Server Admins, Identity Admins, App Owners,   Microsoft support and resources and partner to ensure they are available during cutover.
- Ensure a backup of the server has been committed prior to cutover.
- Ensure rollback plan is defined and ready for execution if needed
- Ensure migration handover to operations team by settings expectations that day 2 operations must commence with regards to Azure server backup, patching, monitoring, etc.

### Post-Go Live

Once the cutover successfully concludes, Contoso prepares for decommission of the source servers. Contoso decides that server decommissioning will be executed after the soak period timeline is concluded.

After each migration wave, Contoso also has a brief retrospective to discuss what went well and what could be improved for future migration waves. Contoso understands these incremental learnings and improvements will ensure a smoother migration for all subsequent migration waves.

## Conclusion

In this article, Contoso sets up Azure Migrate Server Migration tools and plans for their infrastructure migration activities and workflow.

Not every step taken here is required for a server migration. In this case, Contoso planned for a migration workflow, test plans and pre/post migration activities which can be accomplished by  pro-active and reliable replication.