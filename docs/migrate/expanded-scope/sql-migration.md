---
title: "Accelerate migration by migrating an instance of SQL Server"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Migrating entire SQL Server instances can accelerate workload migration efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Accelerate migration by migrating an instance of SQL Server

Migrating entire SQL Server instances can accelerate workload migration efforts. The following guidance expands the scope of the [Azure migration guide](../azure-migration-guide/index.md) by migrating an instance of SQL Server outside of a workload-focused migration effort. This approach can seed the migration of multiple workloads with a single data-platform migration. Most of the effort required in this scope expansion occurs during the prerequisites, assessment, migration, and optimization processes of a migration effort.

<!-- markdownlint-disable MD026 -->

## Is this expanded scope right for you?

The approach recommended in the [Azure migration guide](../azure-migration-guide/index.md) is to migrate each data structure alongside associated workloads as part of a single migration effort. The iterative approach to migration reduces discovery, assessment, and other tasks that can create blockers and slow business value returns.

However, some data structures can be migrated more effectively through a separate data-platform migration. The following are a few examples:

- **End of service:** Quickly moving a SQL Server instance to avoid end-of-service challenges can justify the use of this guide outside of standard migration efforts.
- **SQL Server services:** The data structure is part of a broader solution that requires SQL Server running on a virtual machine. This is common for solutions that use SQL Server services such as SQL Server Reporting Services, SQL Server Integration Services, or SQL Server Analysis Services.
- **High density, low usage databases:** The instance of SQL Server has a high density of databases. Each of those databases has low transaction volumes, and requires little in the way of compute resources. You should consider other, more modern solutions, but an infrastructure as a service (IaaS) approach might result in significantly reduced operating cost.
- **Total cost of ownership:** When applicable, you can apply [Azure Hybrid Benefits](https://azure.microsoft.com/pricing/hybrid-benefit) to the list price creating the lowest cost of ownership for instances of SQL Server. This is especially common for customers who host SQL Server in multicloud scenarios.
- **Migration accelerator:** "Lift-and-shift" migration of a SQL Server instance can move several databases in one iteration. This approach sometimes allows future iterations to focus more specifically on applications and VMs, meaning that you can migrate more workloads in a single iteration.
- **VMWare migration:** A common on-premises architecture includes applications and VMs on a virtual host, and databases on bare metal. In this scenario, you can migrate entire SQL Server instances to support your migration of the VMWare host to Azure VMWare Service. For more information, see [VMWare host migration](./vmware-host.md).

If none of the above criteria apply to this migration, it might be best to continue with the [standard migration process](../index.md). In the standard process, data structures are migrated iteratively, alongside each workload.

If this guide aligns with your criteria, continue with this expanded scope guide as an effort within the [standard migration process](../index.md). During the prerequisites phase, you can integrate the effort into the overall adoption plan.

## Suggested prerequisites

Before performing a SQL Server migration, start with an expansion of the digital estate by including a data estate. The data estate records an inventory of the data assets you're considering for migration. The following tables outline an approach to recording the data estate.

### Server inventory

The following is an example of a server inventory:

|SQL Server|Purpose|Version|[Criticality](../../manage/considerations/criticality.md)|[Sensitivity](../../govern/policy-compliance/data-classification.md)|Database count|SSIS|SSRS|SSAS|Cluster|Number of nodes|
|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
|sql-01|Core apps|2016|Mission-critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-02|Core apps|2016|Mission-critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-03|Core apps|2016|Mission-critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-04|BI|2012|High|XX|6|N/A|Confidential|Yes - multidimensional cube|No|1|
|sql-05|Integration|2008 R2|Low|General|20|Yes|N/A|N/A|No|1|

### Database inventory

The following is an example of a database inventory for one of the servers above:

|Server|Database|[Criticality](../../manage/considerations/criticality.md)|[Sensitivity](../../govern/policy-compliance/data-classification.md)|Data Migration Assistant (DMA) results|DMA remediation|Target platform|
|---------|---------|---------|---------|---------|---------|---------|
|sql-01|DB-1|Mission-critical|Highly Confidential|Compatible|N/A|Azure SQL Database|
|sql-01|DB-2|High|Confidential|Schema change required|Changes implemented|Azure SQL Database|
|sql-01|DB-1|High|General|Compatible|N/A|Azure SQL managed instance|
|sql-01|DB-1|Low|Highly Confidential|Schema change required|Changes scheduled|Azure SQL managed instance|
|sql-01|DB-1|Mission-critical|General|Compatible|N/A|Azure SQL managed instance|
|sql-01|DB-2|High|Confidential|Compatible|N/A|Azure SQL Database|

### Integration with the cloud adoption plan

After this discovery process is complete, you can include it in the [cloud adoption plan](../../plan/template.md). Within the cloud adoption plan, add each SQL Server instance to be migrated as a [distinct workload](../../plan/workloads.md). Within each workload, the databases and services (SSIS, SSAS, SSRS) can each be added as [assets](../../plan/workloads.md). To add workloads and assets in bulk to the adoption plan, see [adding and editing work items with Excel](https://docs.microsoft.com/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel?view=azure-devops).

After the workloads and assets are included in the plan, you and your team can continue with a standard migration process by using the adoption plan. When the adoption team moves into the assessment, migration, and optimization processes, factor in the changes discussed in the following sections.

## Assessment process changes

If any database in the plan can be migrated to a platform as a service (PaaS) data platform, use DMA to evaluate the compatibility of the selected database. When the database requires schema conversions, you should complete those conversions as part of the assessment process, to avoid disruptions to the migration pipeline.

### Suggested action during the assessment process

For databases that can be migrated to a PaaS solution, the following actions are completed during the assessment process.

- **Assess with DMA:** Use Data Migration Assistant to detect compatibility issues that can affect database functionality in your target Azure SQL Database managed instance. Use DMA to recommend performance and reliability improvements, and to move the schema, data, and uncontained objects from your source server to your target server. For more information, see [Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview).
- **Remediate and convert:** Based on the output of DMA, convert the source data schema to remediate compatibility issues. Test the converted data schema with the dependent applications.

## Migrate process changes

During migration, you can choose from among many different tools and approaches. But each approach follows a simple process: migrate schema, data, and objects. Then sync data to the target data source.

The target and source of the data structure and services can make these two steps rather complicated. The following sections help you understand the best tooling choice based on your migration decisions.

### Suggested action during the migrate process

The suggested path for migration and synchronization uses a combination of the following three tools. The following sections outline more complex migration and synchronization options that allow for a broader variety of target and source solutions.

|Migration option|Purpose|
|---------|---------|
|[Azure Database Migration Service](https://docs.microsoft.com/sql/dma/dma-overview)|Supports online (minimal downtime) and offline (one time) migrations at scale to an Azure SQL Database managed instance. Supports migration from: SQL Server 2005, SQL Server 2008 and SQL Server 2008 R2, SQL Server 2012, SQL Server 2014, SQL Server 2016, and SQL Server 2017.|
|[Transactional replication](https://docs.microsoft.com/sql/relational-databases/replication/administration/enhance-transactional-replication-performance)|Transactional replication to an Azure SQL Database managed instance is supported for migrations from: SQL Server 2012 (SP2 CU8, SP3, or later), SQL Server 2014 (RTM CU10 or later, or SP1 CU3 or later), SQL Server 2016, SQL Server 2017.|
|[Bulk load](https://docs.microsoft.com/sql/t-sql/statements/bulk-insert-transact-sql)|Use bulk load to an Azure SQL Database managed instance for data stored in: SQL Server 2005, SQL Server 2008 and SQL Server 2008 R2, SQL Server 2012, SQL Server 2014, SQL Server 2016, and SQL Server 2017.|

### Guidance and tutorials for suggested migration process

Choosing the best guidance for migration by using Database Migration Service is contingent on the source and target platform of choice. The following table links to tutorials for each of the standard approaches for migrating a SQL database by using Database Migration Service.

|Source  |Target  |Tool  |Migration Type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server|Azure SQL Database|Database Migration Service|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql)|
|SQL Server|Azure SQL Database|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-azure-sql-online)|
|SQL Server|Azure SQL Database managed instance|Database Migration Service|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance)|
|SQL Server|Azure SQL Database managed instance|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online)|
|RDS SQL Server|Azure SQL Database (or managed instance)|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-rds-sql-server-azure-sql-and-managed-instance-online)|

### Guidance and tutorials for various services to equivalent PaaS solutions

After moving databases from an instance of SQL Server to Database Migration Service, the schema and data can be rehosted in a number of PaaS solutions. However, other required services might still be running on that server. The following three tutorials aid in moving SSIS, SSAS, and SSRS to equivalent PaaS services on Azure.

|Source  |Target  |Tool  |Migration type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server Integration Services|Azure Data Factory integration runtime|Azure Data Factory|Offline|[Tutorial](https://docs.microsoft.com/azure/data-factory/create-azure-ssis-integration-runtime)|
|SQL Server Analysis Services - tabular model|Azure Analysis Services|SQL Server Data Tools|Offline|[Tutorial](https://docs.microsoft.com/azure/analysis-services/analysis-services-deploy)|
|SQL Server Reporting Services|Power BI Report Server|Power BI|Offline|[Tutorial](https://docs.microsoft.com/power-bi/report-server/migrate-report-server)|

### Guidance and tutorials for migration from SQL Server to an IaaS instance of SQL Server

After migrating databases and services to PaaS instances, you might still have data structures and services that are not PaaS-compatible. When existing constraints prevent migrating data structures or services, the following tutorial can help with migrating various assets in the data portfolio to Azure IaaS solutions.

Use this approach to migrate databases or other services on the instance of SQL Server.

|Source  |Target  |Tool  |Migration type  |Guidance  |
|---------|---------|---------|---------|---------|
|Single instance SQL Server|SQL Server on IaaS|Varied|Offline|[Tutorial](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-migrate-sql)|

## Optimization process changes

During optimization, you can test, optimize, and promote to production each data structure, service, or SQL Server instance. This is the greatest impact of deviating from a per-workload migration model.

Ideally, you migrate the dependent workloads, applications, and VMs within the same iteration as the SQL Server instance. When that ideal scenario occurs, you can test the workload along with the data source. After testing, you can promote the data structure to production, and terminate the synchronization process.

Now let's consider the scenario in which there's a significant time gap between database migration and workload migration. Unfortunately, this can be the biggest change to the optimization process during a non-workload-driven migration. When you migrate multiple databases as part of a SQL Server migration, those databases might coexist in both the cloud and on-premises, for multiple iterations. During that time, you need to maintain data synchronization until those dependent assets are migrated, tested, and promoted.

Until all dependent workloads are promoted, you and your team are responsible for supporting the synchronization of data from the source system to the target system. This synchronization consumes network bandwidth, cloud costs, and most importantly, people's time. Proper alignment of the adoption plan across the SQL Server migration workload, and all dependent workloads and applications, can reduce this costly overhead.

### Suggested action during the optimization process

During optimization processes, complete the following tasks every iteration, until all data structures and services have been promoted to production.

1. Validate synchronization of data.
2. Test any migrated applications.
3. Optimize the application and data structure to tune costs.
4. Promote the applications to production.
5. Test for continued on-premises traffic against the on-premises database.
6. Terminate the synchronization of any data promoted to production.
7. Terminate the original source database.

Until step 5 passes, you can't terminate databases and synchronization. Until all databases on an instance of SQL Server have gone through all seven steps, you should treat the on-premises instance of SQL Server as production. All synchronization should be maintained.

## Next steps

Return to the [expanded scope checklist](./index.md) to ensure your migration method is fully aligned.

> [!div class="nextstepaction"]
> [Expanded scope checklist](./index.md)
