---
title: "Accelerate migration with a SQL migration"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Accelerate migration with a SQL migration
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Accelerate migration with a SQL migration

Migrating entire SQL Server instances can accelerate workload migration efforts. The following guidance will expand the scope of the [Azure migration guide](../azure-migration-guide/index.md) by migrating a SQL Server outside of a workload-focused migration effort. This approach can seed the migration of multiple workloads with a single data-platform migration.

## General scope expansion

Most of the effort required in this scope expansion will occur during the prerequisites, assessment, migration, and optimization processes of a migration effort.

<!-- markdownlint-disable MD026 -->

## Is this expanded scope right for you?

The recommended approach outlined in the [Azure migration guide](../azure-migration-guide/index.md) is to migrate each data structure alongside associated workloads as part of a single migration effort. The iterative approach to migration reduces discovery, assessment, and other tasks that can create blockers and slow business value returns.

However, some data structures can be migrated more effectively through a separate data-platform migration. The following are a few examples that may lead to the use of this expanded scope guidance:

- **End of service:** Quickly moving a SQL Server instance to avoid end-of-service challenges can justify use of this guide outside of standard migration efforts.
- **SQL Server services:** The data structure is part of a broader solution that requires SQL Server running on a virtual machine. This is common for solutions that leverage SQL Server services such as SQL Server Reporting Services, SQL Server Integration Services, or SQL Server Analysis Services.
- **High density, low usage databases:** The SQL Server has a high density of databases. Each of those databases has low transaction volumes and require little compute resources. Other more modern solutions should be considered, but an IaaS approach could result in significantly reduced operating cost.
- **Total cost of ownership:** When applicable, [Azure Hybrid Benefits](https://azure.microsoft.com/pricing/hybrid-benefit) can be applied to the list price creating the lowest cost of ownership for SQL Servers. This is especially common for customers who host SQL Server in multicloud scenarios.
- **Migration accelerator:** Lift and shift migration of a SQL Server instance can move several databases in one iteration. This approach sometimes allows future iterations to focus more specifically on applications and VMs, migrating more workloads in a single iteration.
- **VMWare migration:** A common on-premises architecture includes applications and VMs on a virtual host and databases on bare metal. When migrating this common architecture, the migration of the VMWare host to Azure VMWare Service (AVS) can be complimented by this guide to migrate entire SQL Server instances to support those virtual hosts. For complimentary guidance, see [VMWare host migration](./vmware-host.md).

If none of the above criteria apply to this migration, it may be best to continue with the [standard migration process](../index.md). In the standard process, data structures are migrated iteratively alongside each workload.

If this guide aligns with your criteria, continue with this expanded scope guide as an effort within the [standard migration process](../index.md). During the prerequisites phase, the effort can be integrated into the overall adoption plan.

## Suggested prerequisites

Before performing a SQL Server migration, start with an expansion of the **digital estate** by including a data estate. The data estate records an inventory of the data assets being considered for migration. The following tables outline an approach to recording the data estate.

### Server inventory

The following is an example of a server inventory for SQL servers:

|SQL Server|Purpose|Version|[Criticality](../../manage/considerations/criticality.md)|[Sensitivity](../../govern/policy-compliance/data-classification.md)|Database count|SSIS|SSRS|SSAS|Cluster|Number of nodes|
|---------|---------|---------|---------|---------|---------|---------|---------|
|sql-01|Core apps|2016|Mission Critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-02|Core apps|2016|Mission Critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-03|Core apps|2016|Mission Critical|Highly confidential|40|N/A|N/A|N/A|Yes|3|
|sql-04|BI|2012|High|XX|6|N/A|Confidential|Yes - Multidimensional Cube|No|1|
|sql-05|Integration|2008 R2|Low|General|20|Yes|N/A|N/A|No|1|

### Database inventory

The following is an example of a database inventory for one of the SQL Servers above:

|Server|Database|[Criticality](../../manage/considerations/criticality.md)|[Sensitivity](../../govern/policy-compliance/data-classification.md)|DMA results|DMA remediation|Target platform|
|---------|---------|---------|---------|---------|---------|---------|
|sql-01|DB-1|Mission Critical|Highly Confidential|Compatible|N/A|Azure SQL Database|
|sql-01|DB-2|High|Confidential|Schema change required|Changes implemented|Azure SQL Database|
|sql-01|DB-1|High|General|Compatible|N/A|Azure SQL Managed Instance|
|sql-01|DB-1|Low|Highly Confidential|Schema change required|Changes scheduled|Azure SQL Managed Instance|
|sql-01|DB-1|Mission Critical|General|Compatible|N/A|Azure SQL Managed Instance|
|sql-01|DB-2|High|Confidential|Compatible|N/A|Azure SQL Database|

### Integration with the cloud adoption plan

After discovery is complete, the plan can be included in the [cloud adoption plan](../../plan/template.md). Within the cloud adoption plan, add each SQL Server instance to be migrated as a [distinct workload](../../plan/workloads.md). Within each workload, the databases and services (SSIS, SSAS, SSRS) can each be added as [assets](../../plan/workloads.md). To add workloads and assets in bulk to the adoption plan, see [adding and editing work items with Excel](https://docs.microsoft.com/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel?view=azure-devops).

Once the workloads and assets are included in the plan, the team can continue with a standard migration process using the adoption plan to guide efforts. When the adoption team moves into assessment, migration, and optimization processes, the following changes should be factored into the efforts.

## Assessment process changes

If any database in the plan can be migrated to a platform as a service (PaaS) data platform, use Data Migration Assistant to evaluate compatibility of the selected database. When the database requires schema conversions, it is suggested that those conversions be completed as part of the assessment process to avoid disruptions to the migration pipeline.

### Suggested action during the assessment process

For databases that can be migrated to a PaaS solution, the following actions would be completed during the assessment process.

- **Assess with Data Migration Assistant:** Use Data Migration Assistant to detect compatibility issues that can impact database functionality in your target Azure SQL Database managed instance, to recommend performance and reliability improvements, and to move the schema, data, and uncontained objects from your source server to your target server. For more information, see [Data Migration Assistant](/sql/dma/dma-overview).
- **Remediate and convert:** Based on the output of Data Migration Assistant, convert the source data schema to remediate compatibility issues. Test the converted data schema with the dependent applications.

## Migrate process changes

During migration, there are multiple tooling and approach options. But each approach follows a simple process: migrate schema, data, and objects. Sync data to the target data source.

The target and source of the data structure and services can make these two steps rather complicated. See each of the following sections below to understand the best tooling choice based on your migration decisions.

### Suggested action during the migrate process

The suggested path for migration and synchronization uses a combination of the following three tools. The following sections outline more complex migration and synchronization options that allow for a broader variety of target and source solutions.

|Migration option|Purpose|
|---------|---------|
|[Azure Database Migration Service](/sql/dma/dma-overview)|Azure DMS supports online (minimal downtime) and offline (one time) migrations at scale to an Azure SQL Database managed instance from SQL Server 2005, SQL Server 2008 and SQL Server 2008 R2, SQL Server 2012, SQL Server 2014, SQL Server 2016, and SQL Server 2017.|
|[Transactional replication](/sql/relational-databases/replication/administration/enhance-transactional-replication-performance)|Transactional replication to an Azure SQL Database managed instance is supported for migrations from: SQL Server 2012 (SP2 CU8, SP3, or later), SQL Server 2014 (RTM CU10 or later, or SP1 CU3 or later), SQL Server 2016, SQL Server 2017|
|[Bulk load](/sql/t-sql/statements/bulk-insert-transact-sql)|Use bulk load to an Azure SQL Database managed instance for data stored in SQL Server 2005, SQL Server 2008 and SQL Server 2008 R2, SQL Server 2012, SQL Server 2014, SQL Server 2016, and SQL Server 2017.|

### Guidance and tutorials for suggested migration process

Choosing the best guidance for migration using DMS is contingent on the source and target platform of choice. The following table outlines tutorials for each of the standard approaches for migrating a SQL database using DMS.

|Source  |Target  |Tool  |Migration Type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server|Azure SQL Database|DMS|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql)|
|SQL Server|Azure SQL Database|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-azure-sql-online)|
|SQL Server|Azure SQL Database Managed Instance|DMS|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance)|
|SQL Server|Azure SQL Database Managed Instance|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online)|
|RDS SQL Server|Azure SQL Database (or Managed Instance)|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-rds-sql-server-azure-sql-and-managed-instance-online)|

### Guidance and tutorials for various services to equivalent PaaS solutions

After moving databases from a SQL server to DMS, the schema and data could be rehosted in a number of PaaS solutions. However, other required services may still be running on that server. The following three tutorials will aid in moving SSIS, SSAS, and SSRS to equivalent PaaS services on Azure.

|Source  |Target  |Tool  |Migration Type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server Integration Service|Data Factory Integration Runtime|Azure Data Factory|Offline|[Tutorial](https://docs.microsoft.com/azure/data-factory/create-azure-ssis-integration-runtime)|
|SQL Server Analysis Service - Tabular Model|Azure Analysis Service|SSDT|Offline|[Tutorial](https://docs.microsoft.com/azure/analysis-services/analysis-services-deploy)|
|SQL Server Reporting Service|Power BI Reporting Server|Power BI|Offline|[Tutorial](/power-bi/report-server/migrate-report-server)|

### Guidance and tutorials for migration from SQL Server to an IaaS instance of SQL Server

After migrating databases and services to PaaS instances, there may still be data structures and services that are not PaaS-compatible. When existing constraints prevent migrating data structures or services, the following tutorial can help with migrating various assets in the data portfolio to Azure IaaS solutions.

This approach can be used to migrate databases on the SQL Server, or other services running on the source SQL server.

|Source  |Target  |Tool  |Migration Type  |Guidance  |
|---------|---------|---------|---------|---------|
|Single instance SQL Server|SQL Server on IaaS|Varied|Offline|[Tutorial](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-migrate-sql)|

## Optimization process changes

During optimization, each data structure, service, or SQL Server instance can be tested, optimized, and promoted to production. This is the greatest impact of deviating from a per workload migration model.

Ideally, the dependent workloads, applications, and VMs will be migrated within the same iteration as the SQL Server instance. When that ideal scenario occurs, the workload can be tested along with the data source. Once tested, the data structure can be promoted to production and the synchronization process can be terminate.

Unfortunately, the biggest change to the optimization process during a non-workload-driven migration, comes when there is a significant time gap between database migration and workload migration. When multiple databases are migrated as part of a SQL Server migration, those databases may coexist in both the cloud and on-premises for multiple iterations. During that time frame, there is a need to maintain data synchronization until those dependent assets are migrated, tested, and promoted.

Until all dependent workloads are promoted, the team will be responsible for supporting the synchronization of data from the source system to the target system. This synchronization consumes network bandwidth, cloud costs, and most importantly, peoples time. Proper alignment of the adoption plan across the SQL Server migration "workload" and all dependent workloads/applications, will reduce this costly overhead.

### Suggested action during the Optimization process

During optimization processes, the following tasks should be completed every iteration until all data structures and services have been promoted to production.

1. Validate synchronization of data.
2. Test any migrated applications.
3. Optimize the application and data structure to tune costs.
4. Promote the applications to production.
5. Test for continued on-premises traffic against the on-premises database.
6. Terminate the synchronization of any data promoted to production.
7. Terminate the original source database.

Until step 5 passes, databases and synchronization cannot be terminated. Until all databases on a SQL Server have gone through steps 1 - 7, the on-premises SQL Server should be treated as production and all synchronization should be maintained.

## Next steps

Return to the [expanded scope checklist](./index.md) to ensure your migration method is fully aligned.

> [!div class="nextstepaction"]
> [Expanded scope checklist](./index.md)
