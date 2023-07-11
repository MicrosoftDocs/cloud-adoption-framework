---
title: Migrate SQL Server databases to Azure
description: Learn how Contoso migrates their on-premises SQL databases to Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/26/2023
ms.topic: conceptual
ms.subservice: migrate
ms.custom: UpdateFrequency2
---

# Migrate SQL Server databases to Azure

This article demonstrates how fictional company Contoso assesses, plans, and migrates their various on-premises SQL Server databases to Azure.

As Contoso considers migrating to Azure, the company needs a technical and financial assessment to determine whether its on-premises workloads are good candidates for cloud migration. In particular, the Contoso team wants to assess machine and database compatibility for migration. Additionally, it wants to estimate capacity and costs for running Contoso's resources in Azure.

## Business drivers

Contoso is having various issues with maintaining the wide array of SQL Server workloads versions that exist on their network. After the latest investor's meeting, the CFO and CTO have made the decision to move all the workloads to Azure. Moving all their workloads to Azure lets Contoso shift from a structured capital expense model to a fluid operating expense model.

The IT leadership team worked closely with business partners to understand the business and technical requirements:

- **Increase security:** Contoso needs to be able to monitor and protect all data resources in a more timely and efficient manner. They would also like to get a more centralized reporting system setup on database access patterns.

- **Optimize compute resources:** Contoso deploys a large, on-premises server infrastructure. They have several SQL Server instances that consume but don't efficiently use the underlying CPU, memory, and disk allocated.

- **Increase efficiency:** Contoso needs to remove unnecessary procedures and streamline processes for developers and users. The business needs their IT to be fast and not waste time or money, thus delivering faster on customer requirements. Database administration should be reduced or minimized after the migration.

- **Increase agility:** Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable success in a global economy. It mustn't get in the way or become a business blocker.

- **Scale:** As the business grows successfully, Contoso IT must provide systems that grow at the same pace. There are several legacy hardware environments that can't be upgraded any further and are past or near end of support.

- **Costs:** Business and applications owners want to know they won't be stuck with high cloud costs as compared to running the applications on-premises.

## Migration goals

The Contoso cloud team identifies its goals for the various migrations. The team uses these goals to determine the best migration methods.

| Requirements | Details |
| --- | --- |
| **Performance** | After migration, applications in Azure should have the same performance capabilities that applications have today in Contoso's on-premises environment. Moving to the cloud doesn't mean that application performance is less critical. |
| **Compatibility** | Contoso needs to understand the compatibility of its applications and databases with Azure. The company also needs to understand its Azure hosting options. |
| **Data sources** | All databases must move to Azure with no exceptions. Based on the database and application analysis of the SQL features in use, they'll move to PaaS, IaaS, or managed instances. |
| **Application** | Applications must move to the cloud wherever possible. If they can't move, they'll be allowed to connect to the migrated database over the Azure network through private connections only. |
| **Costs** | Contoso wants to understand not only its migration options, but also the costs associated with the infrastructure after it moves to the cloud. |
| **Management** | Create resource management groups for the various departments along with resource groups to manage all migrated SQL databases. Tag all resources with department information for chargeback requirements. |
| **Limitations** | Initially, not all branch offices that run applications have a direct ExpressRoute link to Azure, so these offices must connect through virtual network gateways. |

## Solution design

Contoso did a [migration assessment](../../plan/contoso-migration-assessment.md) of their digital estate using [Azure Migrate](/azure/migrate/migrate-services-overview).

The assessment results in multiple workloads spread across multiple departments. The overall size of the migration project requires a full project management office (PMO), to manage the specifics of communication, resources, and schedule planning.

![A diagram that shows the Contoso migration process](./media/contoso-migration-sql-server-db-to-azure/migration-process.png)

### Solution review

Contoso evaluates their proposed design by putting together a pros and cons list.

| Consideration | Details |
| --- | --- |
| **Pros** | Azure provides a single pane of glass into the database workloads. <br><br> You can monitor costs with Azure Cost Management + Billing. <br><br> Azure Billing APIs make business chargeback billing easier. <br><br> Server and software maintenance is reduced to only the IaaS-based environments. |
| **Cons** | Due to the requirement of IaaS-based virtual machines, the team must still manage the software on those machines. |

Further, Contoso reviews the [considerations and recommendations for Azure SQL Database](/azure/well-architected/services/data/azure-sql-database-well-architected-framework) with the Azure Well-Architected Framework.

### Budget and management

Before migration occurs, set up the necessary Azure structure to support the solution's administrative and billing aspects.

For the management requirements, the company creates several [management groups](/azure/governance/management-groups/overview) to support the organizational structure.

For the billing requirements, the company [tags](/azure/azure-resource-manager/management/tag-resources) each of the Azure resources with the appropriate billing tags.

To better understand the cost of various services in Azure, use the [Pricing calculator](https://azure.microsoft.com/pricing/calculator/).

### Migration process

Data migrations follow a standard repeatable pattern. This process involves the following steps based on [Microsoft best practices](/data-migration/):

- Pre-migration:
  - **Discovery:** Inventory database assets and application stack.
  - **Assess:** Assess workloads and fix recommendations.
  - **Convert:** Convert source schema to work in the target.
- Migration:
  - **Migrate:** Migrate the source schema, source data, and objects to target.
  - **Sync data:** Sync data (for minimal downtime).
  - **Cutover:** Cut over the source to target.
- Post-migration:
  - **Remediate applications:** Iteratively make the necessary changes to the applications.
  - **Perform tests:** Iteratively run functional and performance tests.
  - **Optimize:** Based on tests, address performance issues and then retest to confirm performance improvements.
  - **Retire assets:** Back up and retire old VMs and hosting environments.

#### Step 1: Discovery

Contoso uses Azure Migrate to surface the dependencies across the Contoso environment. Azure Migrate automatically discovers application components on Windows and Linux systems and maps the communication between services. Azure Migrate also surfaces the connections between Contoso servers, processes, inbound and outbound connection latency, and ports across their TCP-connected architecture.

Contoso also adds Data Migration Assistant to their Azure Migrate project. With Data Migration Assistant, Contoso can assess their databases for migration to Azure.

![A screenshot that shows the Data Migration Assistant selection page.](./media/contoso-migration-sql-server-db-to-azure/add-dma.png)

#### Step 2: Application assessment

<!-- docutune:casing "mainly .NET-based" "non-.NET-based" -->

The assessment determines that Contoso uses mainly .NET-based applications. But some projects use other technologies such as PHP and Node.js. Vendor-purchased systems also introduced applications that aren't based on .NET. Contoso identifies the following applications:

- ~800 Windows .NET applications
- ~50 PHP applications
- 25 Node.js applications
- 10 Java applications

Further, learn how to [Assess an application's data access layer with Data Migration Assistant](/sql/dma/dma-assess-app-data-layer).

#### Step 3: Database assessment

As Azure Migrate discovers each database, the Data Migration Assistant (DMA) runs and determines which features the team uses. DMA helps Contoso assess their database migrations to Azure by detecting compatibility issues that can affect database functionality in a new version of SQL Server or Azure SQL Database.

Contoso follows these steps to assess their databases and then uploads the results data to Azure Migrate:

1. Download DMA.
1. Create an assessment project.
1. In DMA, sign into the Azure Migrate project and sync the assessment summary.

![A screenshot that show the Azure Migrate and DMA download page.](./media/contoso-migration-sql-server-db-to-azure/azure-migrate-dma.png)

DMA recommends performance and reliability improvements for your target environment and allows them to move their schema, data, and uncontained objects from a source server to a target server.

Learn more about [Data Migration Assistant](/sql/dma/dma-assesssqlonprem).

Contoso uses the DMA to run the assessment and then uploads the data directly to Azure Migrate.

![A screenshot that shows the option to upload DMA to Azure Migrate](./media/contoso-migration-sql-server-db-to-azure/upload-db-data.png)

With the database information now loaded into Azure Migrate, Contoso identifies over 1,000 database instances that must be migrated. Of these instances, the company can move roughly 40 percent to SQL Database for Azure. The company must move the remaining 60 percent to either SQL Server running on Azure Virtual Machines or Azure SQL Managed Instance. Of those 60 percent, about 10 percent require a virtual machine-based approach. The remaining instances can move to Azure SQL Managed Instance.

When you couldn't run DMA on a data source, the following guidelines were what teams used for the database migrations.

> [!NOTE]
> Contoso discovered various open-source databases during the assessment phase. Separately, they followed the guidance in [Migrate open-source databases to Azure](./contoso-migration-oss-db-to-azure.md) for their migration planning.

<!-- docutune:casing "custom .NET" -->

#### Step 4: Migration planning

With the information at hand, Contoso uses the following guidelines to determine which migration method to use for each database.

| Target | Database usage | Details | Online migration | Offline migration | Max size | Migration guide |
| --- | --- | --- | --- | ---| --- | --- |
| Azure SQL Database (PaaS) | SQL Server (data only) | These databases use basic tables, columns, stored procedures, and functions | [Data Migration Assistant](/sql/dma/dma-overview), [transactional replication](/azure/azure-sql/managed-instance/replication-transactional-overview) | [BACPAC](/sql/relational-databases/data-tier-applications/import-a-bacpac-file-to-create-a-new-user-database), [bcp](/sql/tools/bcp-utility) | 1 TiB | [Link](/azure/dms/tutorial-sql-server-to-azure-sql) |
| Azure SQL Managed Instance | SQL Server (advanced features) | These databases use triggers and other [advanced concepts](/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server#service-broker) such as custom .NET types, service brokers, and so on. | [Data Migration Assistant](/sql/dma/dma-overview), [transactional replication](/azure/azure-sql/managed-instance/replication-transactional-overview) | [BACPAC](/sql/relational-databases/data-tier-applications/import-a-bacpac-file-to-create-a-new-user-database), [bcp](/sql/tools/bcp-utility), [native backup/restore](/azure/azure-sql/managed-instance/restore-sample-database-quickstart) | 2 TiB - 8 TiB | [Link](/azure/dms/tutorial-sql-server-managed-instance-online) |
| SQL Server on Azure Virtual Machines (IaaS) | SQL Server (third-party integrations) | The SQL Server must have [non-supported SQL Managed Instance features](/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server#service-broker), such as cross-instance service brokers, cryptographic providers, buffer pool, compatibility levels below 100, database mirroring, FILESTREAM, PolyBase, anything that requires access to file shares, external scripts, extended stored procedures, and others. Or the server must have third-party software installed to support the activities of the database. | [Transactional replication](/azure/azure-sql/managed-instance/replication-transactional-overview) | [BACPAC](/sql/relational-databases/data-tier-applications/import-a-bacpac-file-to-create-a-new-user-database), [bcp](/sql/tools/bcp-utility), [snapshot replication](/azure/azure-sql/managed-instance/replication-transactional-overview), [native backup/restore](/azure/azure-sql/managed-instance/restore-sample-database-quickstart), convert physical machine to VM | 4 GiB - 64 TiB | [Link](/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server) |

Due to the large number of databases, Contoso creates a project management office (PMO) to keep track of every database migration instance. The PMO assigns [Accountability and responsibilities](../migration-considerations/assess/index.md) to each business and application team.

Contoso also performs a [workload readiness review](../migration-considerations/assess/evaluate.md). This review examines the infrastructure, database, and network components.

#### Step 5: Test migrations

The first part of the migration preparation involves a test migration of all databases to the pre-setup environments. In order to save time, the team scripts all of the operations for the migrations and records the timings for each. In order to speed up the migration, they identify the migration operations that can run concurrently.

Any rollback procedures are identified for each of the database workloads if unexpected failures occur.

For the IaaS-based workloads, the company sets up all the required third-party software beforehand.

After the test migration, Contoso can use the various Azure [cost estimation tools](../migration-considerations/assess/estimate.md) to get a more accurate picture of future operational costs on their migration.

#### Step 6: Migration

For the production migration, Contoso identifies the time frames for all database migrations and what can be sufficiently run in a weekend window (midnight Friday through midnight Sunday) with minimal downtime to the business.

Based on their documented test procedures, they run each migration via scripting as much as possible, limiting manual tasks to minimize errors.

If any migrations fail during the window, they're rolled back and rescheduled in the next migration window.

### Clean up after migration

Contoso identifies the archival window for all database workloads. As the window expires, the company retires resources from the on-premises infrastructure.

Retiring resources includes:

- Removing the production data from on-premises servers.
- Retiring the hosting server when the last workload window expires.

### Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure their new infrastructure.

#### Security

- Contoso needs to ensure that their new Azure database workloads are secure. [Learn more](/azure/azure-sql/database/security-overview).
- In particular, Contoso should review the firewall and virtual network configurations.
- Setup [Private Link](/azure/azure-sql/database/private-endpoint-overview) so that all database traffic is kept inside Azure and the on-premises network.
- Enable [Microsoft Defender for Identity](/azure/azure-sql/database/threat-detection-overview) for Azure SQL Database.

#### Backups

- Contoso needs to ensure that they back up the Azure databases using geo-restore. Backing up the databases supports using the backups in a paired region if there's a regional outage.
- **Important:** Ensure that the Azure resource has a [resource lock](/azure/azure-resource-manager/management/lock-resources) to prevent it from being deleted. Deleted servers can't be restored.

#### Licensing and cost optimization

- You can scale many Azure database workloads up or down, so performance monitoring of the server and databases is important to ensure you're meeting your needs but also keeping costs at a minimum.
- Both CPU and storage have costs associated. There are several pricing tiers to select from. Be sure to select the appropriate pricing plan for the data workloads.
- Implement [Elastic pools](/azure/azure-sql/database/service-tiers-dtu) for databases that have compatible resource utilization patterns.
- Each read replica bills based on the compute and storage you select.
- Use reserved capacity to save on costs.

## Considerations

**Blocked migrations:** If Contoso is currently blocked for migrations for specific SQL Servers, they can evaluate using [Azure Arc-enabled SQL Servers](/sql/sql-server/azure-arc/overview) as a workaround. This solution involves using the existing Software Assurance SQL license with additional benefits by enabling Azure Arc SQL server.

## Next steps

In this article, Contoso assessed, planned, and migrated their Microsoft SQL Server workloads to Azure.

An Azure DevOps project is available for you to study in your SQL migration journey, and it aligns with the Cloud Adoption Framework. This project guides you through the key decisions to make. For more information, see the [Azure DevOps project](https://azuredevopsdemogenerator.azurewebsites.net/?name=sqlmigration).
