---
title: Migration planning for Oracle on Azure
description: Learn about migration planning for Oracle workloads on Azure.
author: Jfaurskov
ms.author: janfaurs
ms.reviewer: tozimmergren
ms.date: 04/26/2024
ms.topic: conceptual
---

# Migrate Oracle workloads to Azure

A crucial part of your cloud adoption journey is to migrate your existing workloads to the cloud. Oracle workloads are similar to other workloads and require a methodical approach to ensure a successful migration. For more information about migration methodology, see [Cloud migration in the Cloud Adoption Framework](../../migrate/index.md). This article describes unique constraints and considerations specific to Oracle workloads.

## Oracle migration process details

You should continually reassess your infrastructure requirements to improve performance and reduce costs using the relevant type of service for your workload. For example, if you're planning to move to Oracle Database@Azure, ensure that the SKU meets your requirements. Similarly, if you're moving to Oracle on Azure Virtual Machines, ensure that the virtual machines (VMs) sizes meet your requirements. For more information, see [Capacity planning for migrating Oracle workloads to Azure landing zones](./oracle-capacity-planning.md).

Review the migration resources to define your Oracle to Azure migration process, and in addition:

- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target virtual machine (VM) sizes that you choose if migrating to Oracle on Azure Virtual Machines.
- **Identify the deployment model**: Automate the deployment of solution components as much as possible by using infrastructure-as-code, CI/CD pipelines, and other DevOps practices.
- **Determine application dependencies**: Ensure that migration activities are minimally disruptive.
- **Identify data capacity**: Identify the amount of data to migrate and assess the current available network connectivity capacity from on-premises to Azure. Use this information to determine if you can copy the data directly from on-premises to Azure. You might need a physical data transfer appliance like [Azure DataBox](/azure/databox/data-box-overview) for the initial data load.
- **Determine availability requirements**: Determine the workload availability requirements since they affect the migration tools that you can use.

For Oracle Database@Azure, make sure to:

- **Verify that the Oracle Database@Azure solution is available** in the region where you want to deploy the solution. For more information, see [Overview - Oracle Database@Azure](/azure/oracle/oracle-db/database-overview#available-regions).
- **Consider required database changes** when moving from on-premises to Oracle Database@Azure. Migration might involve some changes to the database tablespaces and schema. For more information, see [Migrating Oracle Databases to Exadata Cloud Service](https://docs.oracle.com/en/cloud/paas/database-dbaas-cloud/csdbi/considerations-migrating-premises-database-dbcs.html#GUID-5F6B4B4F-5B1C-4F1C-9F1A-5F6F6F6F6F6F).

## Oracle migration workload specific activities

The following section describes the migration process in more detail. The steps aren't necessarily sequential. You can perform some steps in parallel.

- **Assess the source and destination system versions**: Assess whether the on-premises operating system versions, application, and database versions are the same as the versions that you plan to use on Azure.
  - If you need to update one or more versions, update the versions before migration to avoid complicating the migration process.
  - If your on-premises database is running on a large endian operating system (for example, Solaris, AIX, HP-UX), the database migration process includes an endian conversion. Azure only supports little endian operating systems. From a tooling perspective, this support limits the number of options when you consider what tool to use for the migration. Specifically, it isn't possible to use Oracle DataGuard, Azure Migrate, or any other file copy method. Migration methods compatible with endian conversion include Oracle DataPump Export/Import, Oracle Cross Platform Transportable Tablespaces (XTTS) or data replication utilities such as Oracle GoldenGate, Quest SharePlex, and Striim.
  - On-premises application servers can be modernized or migrated depending on requirements and compatibility. For more information, see [The One Migrate approach to migrating the IT portfolio](../index.md).

- **Assess the workload availability requirements during the migration process**: If workload downtime needs to be minimized, then migration methods such as DataPump Export/Import or Azure Migrate might not be suitable. In that case, a three-step process would be required as follows:
  - Use Oracle RMAN to back up and then restore the entire database in Azure. Perform an endian conversion through XTTS if necessary. For more information, see [Transporting Data Across Platforms](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/transporting-data.html#GUID-FE3003B9-605A-4269-B167-005AC778C870). The result is a database that is a point-in-time copy of the on-premises source database.
  - Use Oracle DataGuard if the migration is little endian to little endian to synchronize the newly restored database in Azure with the source database. You can't use DataGuard if the migration involves big-endian to little-endian conversion. Instead, use a SQL-based data replication utility such as Oracle GoldenGate, Quest SharePlex, or Striim to synchronize the newly restored database in Azure with the source database.
  - Once the target database in Azure is synchronized with the source database on-premises, a *cutover* can be scheduled conveniently. The cutover means shutting down the source database on-premises and flushing the last few transactions to the target database in Azure. Then you can open the target database in Azure as the new source database. This cutover can happen in as little time as a few minutes, depending on the sync method used.
  - Depending on the migration approach you chose for application services, you might need to complete several application service tasks before the application is fully migrated to Azure.
  - Consider using Oracle Zero Downtime Migration (ZDM) for the migration process. For more information, see [Zero Downtime Migration](https://www.oracle.com/database/zero-downtime-migration/).

- **Assess required licenses**: Different licenses might be required depending on the migration tooling for your database. For instance:

  - Oracle DataGuard requires Oracle Enterprise Edition.
  - Oracle GoldenGate requires Oracle GoldenGate licenses.
  - For more information on Oracle licensing on Azure, see [Licensing Oracle Software in the Cloud Computing Environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf).
  
## Next step

> [!div class="nextstepaction"]
> [Oracle database migration to Azure](/azure/architecture/solution-ideas/articles/reference-architecture-for-oracle-database-migration-to-azure).
