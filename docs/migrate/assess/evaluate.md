---
title: Evaluate workload readiness
description: Understand how to evaluate the readiness of a workload to migrate to the cloud. Learn how to validate all assets and associated dependencies.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Evaluate workload readiness

This article focuses on how to evaluate the readiness of a workload to migrate to the cloud.

When you want to migrate a workload, the cloud adoption team ensures that all assets and associated dependencies are compatible with your deployment model and cloud provider. The team documents any required efforts to [remediate](../deploy/remediate.md) compatibility problems.

## Evaluation assumptions

Most of the content that discusses principles in the Cloud Adoption Framework for Azure is cloud agnostic. However, the readiness evaluation process must be specific to each cloud platform and to the migration tools that you selected in the [Prepare](../prepare/index.md) phase.

The assessment tools that you selected should provide information about any blockers for migration. Common blockers include operating system support, server size, and data change rates that might affect replication.

Some organizations also face problems with configurations of virtual machines (VMs) that take advantage of the source hypervisor platform. These configurations include virtualization-based security, dynamic disks, non-Microsoft applications licenses, data source configurations, and certificates.

This article doesn't capture all possible evaluation activities because each environment and business outcome dictates specific requirements. To help you determine what those requirements are, here are a few common evaluation activities that are related to infrastructure, databases, and networks.

## Evaluate cross-datacenter dependencies

If you're migrating workloads from multiple datacenters, you must assess any dependencies between those datacenters.

Consider the following capabilities to evaluate your cross-datacenter dependencies:

- **Visualize dependencies**: Use the [dependency visualization](/azure/migrate/concepts-dependency-visualization) capability in Azure Migrate and Modernize to pinpoint dependencies.
- **Group dependencies**: Use [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies) when you're dealing with global complexity. This capability helps you identify the IP addresses and ports of any assets that are required to support the workload.

> [!IMPORTANT]
> - You need a subject matter expert who understands asset placement and IP address schemas to identify assets that reside in a secondary datacenter.
> - You need to evaluate downstream dependencies and clients in the visualization to understand bidirectional dependencies.

## Example scenarios

The following sections provide guidance for evaluating readiness to migrate workloads and databases to the cloud.

### Common evaluation activities for Azure Migrate and Modernize

The following guidance assumes that you intend to migrate a workload to Azure. It also assumes that you're using Azure Migrate and Modernize for [replication activities](../deploy/replicate.md).

You can use your Azure Migrate and Modernize project to assess workloads and calculate the cost of operating in Azure. For more information, see [Azure VM assessments in Azure Migrate and Modernize](/azure/migrate/concepts-assessment-calculation).

You can also use your Azure Migrate and Modernize project to assess readiness for migration, translate server size to Azure subscriptions based on actual use, and calculate costs. Further refine your cost calculations by [building a business case](/azure/migrate/concepts-business-case-calculation).

Be sure to document any discrepancies in host configuration, replicated VM configuration, storage requirements, or network configuration. Use that information to estimate the bandwidth considerations for your migration. Common components of bandwidth estimation include:

- **Total storage**: Calculate the total storage that replicated VMs need during the iterations that lead up to a release.
- **Drift or change rate**: Calculate the drift or change rate of storage that replicated VMs need during the iterations that lead up to a release.
- **Bandwidth requirements**: Calculate the bandwidth requirements that each iteration needs by summing the total storage and drift.
- **Unused bandwidth**: Calculate the available unused bandwidth on the current network to validate per-iteration alignment.
- **Migration velocity bandwidth**: Document the bandwidth that you need to reach the anticipated migration velocity. If you need any remediation to provide the necessary bandwidth, notify the team that's responsible for [remediation activities](../deploy/remediate.md).

> [!NOTE]
> Total storage directly affects bandwidth requirements during the initial replication. However, storage drift continues from the point of replication until release. This means that drift has a cumulative effect on available bandwidth.
>
> For guidance on gauging bandwidth requirements, see [Common questions for migration and modernization tooling](/azure/migrate/common-questions-server-migration).

### Common database evaluation activities

As part of your server migration, you might also look at migrating SQL Server instances or other database servers.  

- **Document RPOs and RTOs**: Document the recovery point objectives (RPOs) and the recovery time objectives (RTOs) of the current database deployment. Use this information to help you make decisions during [architecture activities](./architect.md).
- **Document high-availability requirements**: Document high-availability configuration requirements. For more information about SQL Server requirements, see the [SQL Server high availability solutions guide](/sql/database-engine/sql-server-business-continuity-dr).
- **Evaluate PaaS**: Evaluate platform as a service (PaaS) compatibility. The [Azure Database Migration Service guides](/data-migration/) map on-premises databases to compatible Azure PaaS solutions, like Azure Cosmos DB, Azure SQL Database, Azure Database for MySQL, or Azure Database for PostgreSQL.
  - **PaaS compatibility without remediation**: When PaaS compatibility is an option without the need for any remediation, consult the team that's responsible for architecture activities. PaaS migrations can save time and reduce the total cost of ownership (TCO) of most cloud solutions.
  - **PaaS compatibility when remediation is required**: Consult the teams that are responsible for [architecture](../assess/architect.md) and [remediation](../deploy/remediate.md) activities. In many scenarios, the advantages of PaaS migrations for database solutions outweigh the increase in remediation time.
- **Document size and rate of change**: Document the size and rate of change for each database that you plan to migrate.
- **Document application and database dependencies**: When possible, document any applications or other assets that make calls to each database.

> [!NOTE]
> Synchronization of any asset consumes bandwidth during the replication processes. A common pitfall is to overlook how much bandwidth you need to keep assets synchronized between the points of replication and release. Databases are common consumers of bandwidth during release cycles, and databases with large storage footprints or a high rate of change are especially concerning.
>
> Consider replicating the data structure with controlled updates before user acceptance testing (UAT) and release. In these scenarios, alternatives to Azure Site Recovery might be more appropriate. For more information, see [Azure Database Migration Service guides](/data-migration/).

## Next step

After you evaluate a system, the outputs feed the development of a new cloud architecture.

> [!div class="nextstepaction"]
> [Architect workloads prior to migration](./architect.md)
