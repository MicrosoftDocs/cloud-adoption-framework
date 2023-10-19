---
title: Migration planning for Oracle on Azure
description: Learn about migration planning for Oracle workloads on Azure IaaS.
author: Jfaurskov
ms.author: janfaurs
ms.date: 09/11/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Migrate Oracle workloads to Azure IaaS

A crucial part of your cloud adoption journey is migrating your existing workloads to the cloud. This is no different for Oracle workloads, which similar to other workloads require a methodical approach to ensure a successful migration. For application services the guidance in the [The One Migrate approach to migrating the IT portfolio](../index.md) can be leveraged, but for Oracle database workloads there are some unique constraints and considerations. This article describes those constraints and considerations in more details.  modernize existing workloads.

## Oracle Migration process details

You should continually reassess your infrastructure requirements to improve performance and reduce costs by using the relevant type of Azure Virtual Machine. How to go about this is described in more detail in [Capacity planning for Oracle on Azure](./oracle-capacity-planning.md).

Review the migration resources to define your Oracle to Azure migration process and in addition:

- Verify Azure subscription quota limits: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes you choose.
- Identify the deployment model: Automate deployment of Virtual Machines and supporting services as much as possible by leveraging Infrastructure-as-Code, CI-CD pipelines and other DevOps practices.
- Determine application dependencies to ensure that migration activities have minimal disruptive impact.
- Identify current available network connectivity capacity from on-premises to Azure.
- Identify the amount of data to migrate, and determine if the data can be copied directly from on-premises to Azure or if a physical data transfer appliance such as [Azure DataBox](/azure/databox/data-box-overview) should be leveraged.
- Determine what the workload availability requirements are, as those will affect the palette of migration tools that could be used.

Consider also getting assistance to accelerate your Oracle to Azure migration efforts.

## Oracle Migration workload specific activities

In the following the different high-level steps of the migration process are described in more detail. Note that the steps are not necessarily sequential and can to some extent be performed in parallel.

- Assess whether the on-premises Operating System versions and application and database versions are the same as what will be used on Azure.
  - If one ore more versions need to be updated this should be done prior to migration, to avoid introducing additional complexity into the migration process.
  - If your on-premises database is running on a big endian OS (eg. Solaris, AIX, HP-UX), the database migration process will include an endian conversion, since Azure only supports little endian operating systems. From a tooling perspective this limits the number of options when considering what tool to use for the migration. Specifically it will not be possible to use Oracle DataGuard, Azure Migrate or any other file copy method. Migration methods compatible with endian conversion includes Oracle DataPump Export/Import, Oracle Cross Platform Transportable Tablespaces (XTTS) or data replication utilities such as Oracle GoldenGate, Quest SharePlex, Striim and others.
  - On-premises application servers can be modernized or migrated depending on requirements/compatibility. For more details please refer to [The One Migrate approach to migrating the IT portfolio](../index.md).
- Assess workload availability requirements during the migration process. If workload downtime needs to be minimized then migration methods such as DataPump Export/Import or Azure Migrate might not be suitable. In that case a three-step process would be required as follows:
  - Use Oracle RMAN to backup then restore the entire database in Azure (performing endian conversion through XTTS if necessary, see [Transporting Data Across Platforms](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/transporting-data.html#GUID-FE3003B9-605A-4269-B167-005AC778C870)). This will result in a database that is a point-in-time copy of the source database on-prem.
  - Use Oracle DataGuard if the migration is little endian to little endian synchronize the newly-restored database in Azure with the source database. If the migration involves big-endian to little-endian conversion as mentioned previously DataGuard cannot be used. Instead use a SQL-based data replication utility such as Oracle GoldenGate, Quest SharePlex or Striim to synchronize the newly-restored database in Azure with the source database.
  - Once the target database in Azure is synchronized with the source database on-prem, a "cutover" can be scheduled at a convenient time. The "cutover" will mean shutting down the source database on-prem, flushing the last few transactions to the target database in Azure, and then opening the target database in Azure as the new source database. This cutover can happen in as little time as a few minutes, depending on the sync method used.
  - Depending on the migration approach determined for application services as specified previously there will be a number of activities required for application services, before the application is fully migrated to Azure.
- Depending on what migration tooling is required for database and potentially application services migration be mindful that for instance Oracle DataGuard requires Oracle Enterprise Edition, and Oracle GoldenGate requires Oracle GoldenGate licenses. For more details on Oracle licensing on Azure please refer to [Licensing Oracle Software in the Cloud Computing Environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf).

In connection with the inital data loading from on-premises to Azure, depending on database size and network bandwidth, instead of copying files over Express Route or VPN, it might be more efficient to use a physical data transfer appliance such as Azure DataBox. For more details please refer to [Azure DataBox](/azure/databox/data-box-overview).

## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

For a more detailed on how to migrate your workload once the above concerns has been addressed see [Oracle database migration to Azure](/azure/architecture/solution-ideas/articles/reference-architecture-for-oracle-database-migration-to-azure).
