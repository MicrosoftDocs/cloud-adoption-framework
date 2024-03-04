---
title: Evaluate workload readiness
description: Understand what it takes to evaluate the readiness of a workload to migrate to the cloud. You learn how to validate all assets and associated dependencies.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/27/2024
ms.topic: conceptual
---

# Evaluate workload readiness

This activity focuses on evaluating readiness of a workload to migrate to the cloud.

During this activity, the cloud adoption team validates that all assets and associated dependencies are compatible with the chosen deployment model and cloud provider. The team documents any efforts required to [remediate](../deploy/remediate.md) compatibility issues.

## Evaluation assumptions

Most of the content discussing principles in the Cloud Adoption Framework are cloud agnostic. However, the readiness evaluation process must be specific to each specific cloud platform and the migration tools you selected in the [Prepare](../prepare/index.md) phase.

Whatever assessment tools you have selected should provide information on any blockers for migration.

Common blockers include operating system support, server size, and data change rates that might impact replication.

Some organizations also face issues with virtualization-based security, dynamic disks, third party applications licenses, data source configurations, certificates, and other configurations of virtual machines meant to take advantage of the source hypervisor platform.

This article doesn't capture all possible evaluation activities. It's assumed that each environment and business outcome will dictate specific requirements.

To help accelerate the creation of those requirements, the remainder of this article shares a few common evaluation activities related infrastructure, databases, and networks.

## Example scenario: Common evaluation activities for Azure Migrate

The following guidance assumes an intention to migrate to Azure. It also assumes use of Azure Migrate for [replication activities](../deploy/replicate.md).

You can use your Azure Migrate project to assess workloads and calculate the cost of operating in Azure. See [Azure VM assessments in Azure Migrate](/azure/migrate/concepts-assessment-calculation). 

This allows you to assess readiness to migration, translate server size to Azure SKUs based on actual use, and calculate costs. You can refine those costs more by [building a business case](/azure/migrate/concepts-business-case-calculation).

Be sure to document any discrepancies in host configuration, replicated VM configuration, storage requirements, or network configuration.

You can then use the information provided to estimate the bandwidth considerations for your migration. Common steps for this include:

- **Total storage**: Calculate the total storage for all VMs to be replicated during the iterations leading up to a release.
- **Drift or change rate**: Calculate the drift or change rate of storage for all VMs to be replicated during the iterations leading up to a release.
- **Bandwidth requirements**: Calculate the bandwidth requirements needed for each iteration by summing total storage and drift.
- **Unused bandwidth**: Calculate unused bandwidth available on the current network to validate per iteration alignment.
- **Migration velocity bandwidth**: Document bandwidth needed to reach anticipated migration velocity. If any remediation is required to provide necessary bandwidth, notify the team responsible for [remediation activities](../deploy/remediate.md).

> [!NOTE]
> Total storage directly affects bandwidth requirements during initial replication. However, storage drift continues from the point of replication until release. This means that drift has a cumulative effect on available bandwidth.
>
> You can also see common questions for migration and modernization tooling for guidance on gauging bandwidth requirements (Common questions about the Migration and modernization tool - Azure Migrate | Microsoft Learn).

## Example scenario: Common database evaluation activities

As part of your migration of servers, you might also look at migrating SQL servers or other database servers.  

- **Document RPOs and RTOs**: Ensure you document the recovery point objectives (RPOs) and recovery time objectives (RTOs) of the current database deployment. These are used during [architecture activities](./architect.md) to aid in decision-making.
- **Document high-availability requirements**: Ensure high-availability configuration requirements are documented. For assistance understanding SQL Server requirements, see the [SQL Server high availability solutions guide](/sql/database-engine/sql-server-business-continuity-dr).
- **Evaluate PaaS**: Evaluate PaaS compatibility. The Azure [data migration guide](/data-migration/) maps on-premises databases to compatible Azure PaaS solutions, like Azure Cosmos DB, Azure SQL Database Azure Database for MySQL, Azure Database for PostgreSQL, or Azure Database for MariaDB.
  - **PaaS compatibility without remediation**: When PaaS compatibility is an option without the need for any remediation, consult the team responsible for architecture activities. PaaS migrations can produce significant time savings and reductions in the total cost of ownership (TCO) of most cloud solutions.
  - **PaaS compatibility but remediation is required**: Consult the teams responsible for [architecture](../assess/architect.md) and [remediation](../deploy/remediate.md) activities. In many scenarios, the advantages of PaaS migrations for database solutions can outweigh the increase in remediation time.
- **Document size and rate of change**: Document the size and rate of change for each database to be migrated.
- **Document application and database dependencies**: When possible, document any applications or other assets that make calls to each database.

> [!NOTE]
> Synchronization of any asset consumes bandwidth during the replication processes. A very common pitfall is to overlook the bandwidth consumption required to keep assets synchronized between the point of replication and release. Databases are common consumers of bandwidth during release cycles, and databases with large storage footprints or a high rate of change are especially concerning.
>
> Consider an approach of replicating the data structure with controlled updates before user acceptance testing (UAT) and release. In such scenarios, alternatives to Azure Site Recovery might be more appropriate. For more information, see the [Azure Database Migration Guides](/data-migration/).

## Next steps

After the evaluation of a system is complete, the outputs feed the development of a new [cloud architecture](./architect.md).

> [!div class="nextstepaction"]
> [Architect workloads prior to migration](./architect.md)
