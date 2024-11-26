---
title: Migration planning for Oracle on Azure
description: Learn how to migrate your existing Oracle workloads to the cloud as part of the cloud adoption process.
author: jessiehaessler
ms.author: jhaessler
ms.reviewer: tozimmergren
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Migrate Oracle workloads to Azure

As part of your cloud adoption journey, you must migrate your existing workloads to the cloud. Oracle workloads are similar to other workloads and require a methodical approach to ensure a successful migration. For more information about migration methodology, see [Cloud migration in the Cloud Adoption Framework](../../migrate/index.md). This article describes unique constraints and considerations that are specific to Oracle workloads.

## The Oracle migration scenarios

Migrating Oracle workloads involves transitioning both databases and applications. This article specifically discusses the lift-and-shift approach for application and database migrations, which involves deploying Oracle applications on Azure Virtual Machines (VMs). For database migration, several options are available.

- Applications on Azure Virtual Machines: Run Oracle enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications on Azure infrastructure. 

- Oracle Standard Edition or Enterprise Edition Databases on Azure Virtual Machines. Thereby you deploy your Oracle Database on a Virtual Machine. There are several options available from self-managed to managed Databases. 

- Oracle Database@Azure: Oracle Database@Azure is an Oracle database service running on Oracle Cloud Infrastructure (OCI), colocated in Microsoft data centers.

> Note!
> for supported operating systems for your specific Database version, please visit [supported databases and operating systems](https://docs.oracle.com/en/cloud/paas/db-backup-cloud/csdbb/supported-databases-and-operating-systems.html).

## The Oracle migration process

You should continually reassess your infrastructure requirements to improve performance and reduce costs by using the relevant type of service for your workload. For example, for all scenarios mentioned above, please ensure that sufficient bandwidth is available for your migration. We highly encourage you to review the needed bandwidth while conducting a Proof-of-Concept.

If you move your workload to Oracle on Azure Virtual Machines, ensure that the virtual machine (VM) sizes meet your requirements. For more information, see [Capacity planning for migrating Oracle workloads to Azure landing zones](./oracle-capacity-planning.md).

Review the migration resources to define your Oracle to Azure migration process. You can also:

- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes that you choose if you migrate to Oracle on Azure Virtual Machines.

>Note!
> If you host your workload on Oracle Database@Azure and need a quota increase, please consult your Oracle contact person. 

- **Identify a deployment model**: Automate the deployment of solution components as much as possible by using infrastructure as code (IaaS), continuous integration and continuous delivery (CI/CD) pipelines, and other DevOps practices.

- **Determine application dependencies**: Ensure that migration activities are minimally disruptive.

- **Identify data capacity**: Identify the amount of data to migrate and assess the current available network connectivity capacity from on-premises environments to Azure. Use this information to determine if you can copy the data directly from on-premises environments to Azure. You might need a physical data transfer appliance like [Azure Data Box](/azure/databox/data-box-overview) for the initial data load.

- **Determine availability requirements**: Determine the workload availability requirements because they might affect the migration tools that you can use.
Thereby please define your Recovery Point Objective (RPO) and Recovery Time Objective (RTO) as well as your maximum acceptable downtime. These metrics will help you to define your migration tooling and approach.
The acceptable downtime will help you to define if you should rather perform an online or offline migration. This equally applies to your application. If you cannot accept a disruption in your day-to-day operations, you will need to perform an online migration.

- **Determine your tooling**:

There are two paths to migrate: 

| Offline Migration | Online Migration |
|---|---|
| One-time direct copy of the database | Initial copy of the database followed by changed data capture during migration |
| Requires affected application to be offline during migration | Application can stay online during migration
| **Tools used** : Data Box, DataPump, RMAN | **Tools used**: DataGuard, RMAN, Goldengate |

>! Note:
If you decide to perform an online migration, make sure that you configure firewall rules to allow for data transfer.

>! Note: If you decide to use Goldengate, please review if required license is available.


For Oracle Database@Azure, make sure to:

- **Verify that the Oracle Database@Azure solution is available** in the region where you want to deploy the solution. For more information, see [Available regions](/azure/oracle/oracle-db/database-overview#available-regions).

- **Consider using Oracle Zero Downtime Migration** for the migration process. Evaluate the migration strategies to determine the most suitable approach for your specific migration requirements. For more information, see [Zero Downtime Migration](https://www.oracle.com/database/zero-downtime-migration/).

> Note!
> Make sure to have the ability to establish a bi-directional SSH connectivity between the on-premises Oracle Database and the Oracle Exadata which relies in the Azure VNet.

## Oracle migration workload-specific activities

The following section describes the migration process in more detail. The steps aren't necessarily sequential. You can perform some steps in parallel.

- **Assess the source and destination system versions**: Assess whether the on-premises operating system (OS) versions, application versions, and database versions are the same on on-premise and on Azure.

  - If you need to update one or more resources, update them before migration to avoid complicating the migration process.
  
  - If your on-premises database runs on a big-endian OS, such as Oracle Solaris, IBM Advanced Interactive eXecutive, or Hewlett Packard Unix, the database migration process includes an endian conversion. Azure supports only little-endian operating systems. This limitation reduces the number of available tools for the migration. Specifically, you can't use Oracle Data Guard or any other file copy method. Migration methods that are compatible with endian conversion include Oracle Data Pump Export or Import, Oracle cross-platform transportable tablespaces (XTTS), or data replication utilities such as Oracle GoldenGate, Quest SharePlex, and Striim.
  
  - You can modernize or migrate on-premises application servers depending on requirements and compatibility. For more information, see [Cloud adoption scenarios](../index.md).

- **Assess the workload availability requirements during the migration process**: If you need to minimize workload downtime, then migration methods such as Data Pump Export or Import might not suit your workload. In that case, you can follow this four-step process:

  - Use Oracle Recovery Manager (RMAN) to back up and then restore the entire database in Azure. Perform an endian conversion through XTTS if necessary. The result is a database that's a point-in-time copy of the on-premises source database. For more information, see [Transporting data across platforms](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/transporting-data.html#GUID-FE3003B9-605A-4269-B167-005AC778C870).
  
  - Use Oracle Data Guard to synchronize the newly restored database in Azure with the source database if both sources are little-endian format. You can't use Data Guard if the migration involves big-endian to little-endian conversion. Instead, use a SQL-based data replication utility such as Oracle GoldenGate, Quest SharePlex, or Striim to synchronize the newly restored database in Azure with the source database.
  
  - After you synchronize the target database in Azure with the source on-premises database, you can schedule a *cutover*. A cutover shuts down the source on-premises database and flushes the last few transactions to the target database in Azure. Then you can open the target database in Azure as the new source database. A cutover can take as little as a few minutes, depending on the sync method that you use.
  
  - Depending on the migration approach that you choose for application services, you might need to complete several application service tasks before you fully migrate the application to Azure.

- **Assess required licenses**: Your database might require various licenses depending on the migration tooling. For instance:

  - Oracle Data Guard requires Oracle Database Enterprise Edition.
  
  - Oracle GoldenGate requires Oracle GoldenGate licenses.
  
  For more information about Oracle licensing on Azure, see [Licensing Oracle software in the cloud computing environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf).
  
## Next steps

> [!div class="nextstepaction"]
> [Oracle database migration to Azure](/azure/architecture/solution-ideas/articles/reference-architecture-for-oracle-database-migration-to-azure)
>
> [Oracle on Azure IaaS landing zone accelerator](oracle-landing-zone-accelerator.md)
