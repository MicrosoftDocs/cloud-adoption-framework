---
title: Migration Planning for Oracle on Azure
description: Learn how to migrate your existing Oracle workloads to the cloud as part of the cloud adoption process.
author: jessiehaessler
ms.author: jhaessler
ms.reviewer: tozimmergren
ms.date: 01/06/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Migrate Oracle workloads to Azure

As part of your cloud adoption journey, you must migrate your existing workloads to the cloud. Oracle workloads are similar to other workloads and require a methodical approach to help ensure a successful migration. For more information about migration methodology, see [Cloud migration in the Cloud Adoption Framework for Azure](../../migrate/index.md). This article describes constraints and considerations that are specific to Oracle workloads.

## Oracle migration scenarios

When you migrate Oracle workloads, you have to transition databases and applications. This article discusses the lift-and-shift approach for application and database migrations. The lift-and-shift approach includes the deployment of Oracle applications on Azure Virtual Machines. For database migration, several options are available. This article provides guidance that applies to [Oracle Database@Azure](/azure/oracle/oracle-db/database-overview).

- **Applications on Virtual Machines:** Run Oracle enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications on Azure infrastructure.

- **Oracle Standard Edition or Enterprise Edition Databases on Virtual Machines:** In this scenario, you deploy your Oracle Database on a Virtual Machine. There are several options available, from self-managed to managed Databases. If you prefer a managed database solution, review [Tessell](https://marketplace.microsoft.com/marketplace/apps/tessellinc1655919615020.tessell_database_service?tab=overview).

- **Oracle Database@Azure:** Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and that's colocated in Microsoft datacenters.

> [!NOTE]
> To determine supported operating systems for your specific database version, see [supported databases and operating systems](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=366138251488223&id=742060.1&_afrWindowMode=0&_adf.ctrl-state=cgm96remu_193).

## The Oracle migration process

You should continually reassess your infrastructure requirements to improve performance and reduce costs by using the relevant type of service for your workload. For example, for all scenarios mentioned previously, ensure that sufficient bandwidth is available for your migration. We highly encourage you to review the bandwidth needed when you conduct a proof of concept (PoC).

If you move your workload to Oracle on Virtual Machines, ensure that the virtual machine (VM) sizes meet your requirements. For more information, see [Capacity planning for migrating Oracle workloads to Azure landing zones](./oracle-capacity-planning.md).

Review the migration resources to define your Oracle to Azure migration process. You can also:

- **Verify Azure subscription quota limits:** Ensure that the quota limits in your Azure subscription can accommodate the target VM sizes that you choose if you migrate to Oracle on Virtual Machines.

> [!NOTE]
> If you host your workload on Oracle Database@Azure and need a quota increase, consult your Oracle contact.

- **Identify a deployment model:** Automate the deployment of solution components as much as possible by using infrastructure as code, continuous integration and continuous delivery pipelines, and other DevOps practices.

- **Determine application dependencies:** Ensure that migration activities are as non-disruptive as possible.

- **Identify data capacity:** Identify the amount of data to migrate and assess the current available network connectivity capacity from on-premises environments to Azure. Use this information to determine if you can copy the data directly from on-premises environments to Azure. You might need a physical data transfer appliance like [Azure Data Box](/azure/databox/data-box-overview) for the initial data load.

- **Determine availability requirements:** Determine the workload availability requirements because they might affect the migration tools that you can use. Define your maximum acceptable downtime. This metric helps you define your migration tooling and approach.

This consideration equally applies to your application. If you can't accept a disruption in your day-to-day operations, you need to perform an online migration.

- **Determine your tooling for migrating your workload to Oracle on Azure virtual machines:** The two primary migration paths are offline and online.

| Offline migration | Online migration |
|---|---|
| One-time direct copy of the database. | Initial copy of the database followed by change-data capture during migration. |
| Requires the affected application to be offline during migration. | Application can stay online during migration. |
| **Tools used:** Data Box, DataPump, Oracle Recovery Manager (RMAN) | **Tools used:** DataGuard, Oracle Recovery Manager (RMAN), GoldenGate |

> [!NOTE]
> If you decide to perform an online migration, make sure that you configure firewall rules to allow data transfer.

## Oracle migration workload-specific activities

The following section describes the migration process in more detail. The steps aren't necessarily sequential. You can perform some steps in parallel.

- **Assess the source and destination system versions:** Assess whether the on-premises operating system (OS) versions, application versions, and database versions are the same on-premises and on Azure.

  - If you need to update one or more resources, update them before migration to simplify the migration process.
  
  - If your on-premises database runs on a big-endian OS, such as Oracle Solaris, IBM Advanced Interactive eXecutive, or Hewlett Packard Unix, the database migration process includes an endian conversion. Azure supports only little-endian operating systems. This limitation reduces the number of available tools for the migration. Specifically, you can't use Oracle Data Guard or any other file copy method. Migration methods that are compatible with endian conversion include Oracle Data Pump Export or Oracle Data Pump Import, Oracle cross-platform transportable tablespaces (XTTS), or data replication utilities such as Oracle GoldenGate, Quest SharePlex, and Striim.
  
  - You can modernize or migrate on-premises application servers, depending on requirements and compatibility. For more information, see [Cloud adoption scenarios](../index.md).

- **Assess the workload availability requirements during the migration process:** If you need to minimize workload downtime, migration methods such as Data Pump Export or Data Pump Import might not suit your workload. In that case, follow this four-step process:

  - Use RMAN to back up and then restore the entire database in Azure. Perform an endian conversion through XTTS if necessary. The result is a database that's a point-in-time copy of the on-premises source database. For more information, see [Transporting data across platforms](https://docs.oracle.com/en/database/oracle/oracle-database/23/admin/transporting-data.html#GUID-FE3003B9-605A-4269-B167-005AC778C870).
  
  -  If both sources are little-endian format, use Oracle Data Guard to synchronize the newly restored database in Azure with the source database. You can't use Data Guard if the migration includes big-endian to little-endian conversion. Instead, use a SQL-based data replication utility such as Oracle GoldenGate, Quest SharePlex, or Striim to synchronize the newly restored database in Azure with the source database.
  
  - After you synchronize the target database in Azure with the source on-premises database, you can schedule a *cutover*. A cutover shuts down the source on-premises database and flushes the last few transactions to the target database in Azure. Then you can open the target database in Azure as the new source database. A cutover can take as little as a few minutes, depending on the synchronization method that you use.
  
  - Depending on the migration approach that you choose for application services, you might need to complete several application service tasks before you fully migrate the application to Azure.

- **Assess required licenses:** Your database might require various licenses, depending on the migration tooling. For instance:

  - Oracle Data Guard requires Oracle Database Enterprise Edition.
  
  - Oracle GoldenGate requires Oracle GoldenGate licenses.
  
  For more information about Oracle licensing on Azure, see [Licensing Oracle software in the cloud computing environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf).

## Oracle Database@Azure migration guidance

- **Verify that the Oracle Database@Azure solution is available** in the region where you want to deploy the solution. For more information, see [Available regions](/azure/oracle/oracle-db/database-overview#available-regions).

- **Consider using Oracle Zero Downtime Migration** for the migration process. Evaluate the migration strategies to determine the most suitable approach for your specific migration requirements. For more information, see [Zero Downtime Migration (ZDM)](https://www.oracle.com/database/zero-downtime-migration/). ZDM provides the ability to choose either logical or physical migration scenarios. For more information, see [ZDM migration](https://www.oracle.com/a/otn/docs/database/zdm-physical-migration-to-oracle-at-azure.pdf).

> [!NOTE]
> If you choose Autonomous Database Service (ADB-S), keep in mind that only logical migration scenarios are supported.

## Other guidance

The following section can help you to choose the right migration option for your requirements and data sizes.

### ExpressRoute-based migration duration reference

The following table only serves as a baseline. It doesn't consider other production workloads that run through the same Azure ExpressRoute connection.

VMware might need more bandwidth than indicated. Assess your bandwidth needs during your PoC phase. If you need support, reach out to your local contact.

| Data size   | Bandwidth of 1 Gbps  | Bandwidth of 10 Gbps  |
|-------------|-------------|-------------|
| 1 TB | 3 hours | 15 min |
| 10 TB| 1 day | 3 hours |
| 35 TB | 4 days | 9 hours |
| 80 TB | 8 days | 20 hours |
| 100 TB | 11 days | 1 day |
| 200 TB | 21 days | 2 days |
| 500 TB | 53 days | 5 days |

If you plan to use ExpressRoute for your migration, ensure that its [resilience meets your requirements](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/azure-resources/Network/expressRouteCircuits/).

## Next steps

> [!div class="nextstepaction"]
> [Oracle database migration to Azure](/azure/architecture/databases/idea/topic-migrate-oracle-azure)
>
> [!div class="nextstepaction"]
> [Oracle on Azure IaaS landing zone accelerator](oracle-landing-zone-accelerator.md)