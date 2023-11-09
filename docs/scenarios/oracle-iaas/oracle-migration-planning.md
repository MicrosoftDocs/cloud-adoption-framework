---
title: Migration planning for Oracle on Azure
description: Learn about migration planning for Oracle workloads on Azure IaaS.
author: Jfaurskov
ms.author: janfaurs
ms.reviewer: tozimmergren
ms.date: 09/11/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Migrate Oracle workloads to Azure IaaS

A crucial part of your cloud adoption journey is migrating your existing workloads to the cloud. This is no different for Oracle workloads, which, similar to other workloads, require a methodical approach to ensure a successful migration. For more information about the migration methodology, see [Cloud migration in the Cloud Adoption Framework](../../migrate/index.md). For Oracle database workloads, specifically, there are some unique constraints and considerations which this article addresses.

## Oracle migration process details

You should continually reassess your infrastructure requirements to improve performance and reduce costs using the relevant type of Azure Virtual Machine. For more information, see [Capacity planning for migrating Oracle workloads to Azure landing zones](./oracle-capacity-planning.md).

Review the migration resources to define your Oracle to Azure migration process, and in addition:

- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes you choose.
- **Identify the deployment model**: Automate deployment of Virtual Machines and supporting services as much as possible using Infrastructure-as-Code, CI-CD pipelines, and other DevOps practices.
- **Determine application dependencies**: Ensure that migration activities have a minimal disruptive impact.
- **Identify data capacity**: Identify the amount of data to migrate and assess the current available network connectivity capacity from on-premises to Azure. Use this information to determine if the data can be copied directly from on-premises to Azure or if a physical data transfer appliance such as [Azure DataBox](/azure/databox/data-box-overview) should be used for initial data load.
- **Determine availability requirements**: Determine what the workload availability requirements are, as those affect the palette of migration tools that could be used.

## Oracle migration workload specific activities

In the following section, different high-level steps of the migration process are described in more detail. The steps aren't necessarily sequential and can to some extent be performed in parallel.

- **Assess the source and destination system versions**: Assess whether the on-premises operating system versions, application, and database versions are the same as what will be used on Azure.
  - If one or more versions need to be updated, do this before migration to avoid introducing additional complexity into the migration process.
  - If your on-premises database is running on a big endian OS (for example, Solaris, AIX, HP-UX), the database migration process includes an endian conversion since Azure only supports little endian operating systems. From a tooling perspective, this limits the number of options when considering what tool to use for the migration. Specifically, it will not be possible to use Oracle DataGuard, Azure Migrate, or any other file copy method. Migration methods compatible with endian conversion include Oracle DataPump Export/Import, Oracle Cross Platform Transportable Tablespaces (XTTS), or data replication utilities such as, for example, Oracle GoldenGate, Quest SharePlex, and Striim.
  - On-premises application servers can be modernized or migrated depending on requirements/compatibility. For more information, see [The One Migrate approach to migrating the IT portfolio](../index.md).

- **Assess the workload availability requirements during the migration process**: If workload downtime needs to be minimized, then migration methods such as DataPump Export/Import or Azure Migrate might not be suitable. In that case, a three-step process would be required as follows:
  - Use Oracle RMAN to backup and then restore the entire database in Azure (performing endian conversion through XTTS if necessary. For more information, see [Transporting Data Across Platforms](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/transporting-data.html#GUID-FE3003B9-605A-4269-B167-005AC778C870)). This results in a database that is a point-in-time copy of the source database on-premises.
  - Use Oracle DataGuard if the migration is little endian to little endian synchronize the newly restored database in Azure with the source database. If the migration involves big-endian to little-endian conversion as mentioned previously, you can't use DataGuard. Instead, use a SQL-based data replication utility such as Oracle GoldenGate, Quest SharePlex, or Striim to synchronize the newly restored database in Azure with the source database.
  - Once the target database in Azure is synchronized with the source database on-premises, a "cutover" can be scheduled conveniently. The "cutover" will mean shutting down the source database on-premises, flushing the last few transactions to the target database in Azure, and then opening the target database in Azure as the new source database. This cutover can happen in as little time as a few minutes, depending on the sync method used.
  - Depending on the migration approach determined for application services, there will be several activities required for application services before the application is fully migrated to Azure.

- **Assess required licenses**: Depending on what migration tooling is required for database, various licenses might be required., be mindful that, for instance:

  - Oracle DataGuard requires Oracle Enterprise Edition.
  - Oracle GoldenGate requires Oracle GoldenGate licenses.
  - For more information on Oracle licensing on Azure, see [Licensing Oracle Software in the Cloud Computing Environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf).
  
## Next steps

The following list of articles takes you to the guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

For a more detailed on how to migrate your workload once the above concerns are addressed, see [Oracle database migration to Azure](/azure/architecture/solution-ideas/articles/reference-architecture-for-oracle-database-migration-to-azure).
