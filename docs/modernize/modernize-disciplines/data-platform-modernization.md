---
title: Modernize your database in the cloud
description: Understand and evaluate options for maturing your underlying data platforms for modernization.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: seo-caf-modernize
keywords: collect data, migrate data, data migration, data modernization
---
# Modernize your database in the cloud

Learn how to modernize any database in the cloud with IaaS and platform-as-a-service (PaaS) solutions.

:::image type="content" source="../../_images/modernize/db-platforms/db-platforms-small-2.png" alt-text="image showing database platform options in the cloud, moving from most control to most productivity. On the bottom there is an on-premises starting point. Two paths emerge, one for SQL database and another for open-source and NoSQL databases":::

## Modernize SQL databases

Modernize your SQL databases with a variety of options. Find the balance of control and productivity that meets your needs. For each need, the table identifies a solution,

| Control vs. productivity | What is the Solution | Why would you want this solution | How you can implement the solution |
| --- | --- | --- | --- |
| *Control* | SQL Server on [Windows](/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-what-is-overview) or [Linux](/azure/azure-sql/virtual-machines/linux/sql-server-on-linux-vm-what-is-iaas-overview) virtual machines (VMs) | <ul><li>Require access to OS</li><li>Move to cloud fast as possible</li></ul> | Database origin: <ul><li>[SQL Server](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview)<li>[Oracle](/azure/azure-sql/migration-guides/virtual-machines/oracle-to-sql-on-azure-vm-guide)</li><li>[Db2](/azure/azure-sql/migration-guides/virtual-machines/db2-to-sql-on-azure-vm-guide)</li></ul>
| *Balance of control & <br> productivity* | [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) | <ul><li> Reduce management overhead </li><li> Need instance-scoped features (Service Broker, SQL Server Agent, etc.) </li></ul> | Database origin: <ul><li>[SQL Server](/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-overview)</li><li>[Oracle](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide)</li><li>[Db2](/azure/azure-sql/migration-guides/managed-instance/db2-to-managed-instance-guide)</li></ul>
| *Productivity* | [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview) | <ul><li>Multi-tenant SaaS application</li><li>Elasticity</li><li>Scale compute independent from storage</li></ul> | Database origin: <ul><li>[SQL Server](/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-overview)</li><li>[Oracle](/azure/azure-sql/migration-guides/database/oracle-to-sql-database-guide)</li><li>[Db2](/azure/azure-sql/migration-guides/database/db2-to-sql-database-guide)</li><li>[Access](/azure/azure-sql/migration-guides/database/access-to-sql-database-guide)</li><li>[SAP ASE](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database)</li></ul> |
|

## Modernize open-source & NoSQL databases

Modernize your open-source databases and NoSQL databases with a variety of options. Find the balance of control and productivity that meets your needs.

| Control vs. productivity | What is the Solution | Why would you want this solution | How you can implement the solution |
| --- | --- | --- | --- |
| *Control* | Open-source databases hosted on virtual machines (VMs) <br> <br> Supported database: <ul><li> [MySQL](/azure/mysql/single-server/overview) </li><li> [MariaDB](/azure/mariadb/overview)</li><li> [PostgreSQL](/azure/postgresql/single-server/overview) </li></ul> | <ul><li> Control OS version </li> <li> Zone redundancy </li></ul> | [Use guidance from Azure Database Migration Service](/azure/dms/) <br><br> [Use SQL migration guidance](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview)|
| *Control & <br> productivity* | [Azure Cosmos DB](/azure/cosmos-db/introduction) <br><br> [Azure Managed instance for Apache Cassandra](/azure/managed-instance-apache-cassandra/introduction)| Azure Cosmos DB <ul><li>Fully managed NoSQL</li><li>Simplified app development</li></ul> <br> Apache Cassandra <ul><li> Hybrid deployments</li> <li>Simplified PaaS solution | [Azure Cosmos DB migrate](/azure/cosmos-db/cosmosdb-migrationchoices) <br><br> [Apache Cassandra migrate](/azure/managed-instance-apache-cassandra/dual-write-proxy-migration) |
| *Productivity* | [Azure Database for MySQL](/azure/mysql/single-server/overview) <br><br> [Azure Database for MariaDB](/azure/mariadb/overview) <br><br> [Azure Database for PostgreSQL](/azure/postgresql/single-server/overview) </li></ul> | Fully managed PaaS solution | [Azure Database for MySQL migrate](/azure/dms/tutorial-mysql-azure-mysql-offline-portal)<br><br>[Azure Database for MariaDB migrate](/azure/mariadb/howto-migrate-dump-restore)<br><br>[Azure Database for PostreSQL migrate](/azure/dms/tutorial-postgresql-azure-postgresql-online-portal) | Fully managed PaaS solution

## Extra Content

Companies often have different kinds of existing data that they can [democratize](../../innovate/considerations/data.md). When a customer hypothesis requires the use of existing data to build modern solutions, a first step might be data modernization, and data migration to prepare for inventions and innovations. To align with existing migration efforts within a cloud adoption plan, do your modernization by using the [Modernize methodology](index.md).

This article outlines a series of data platform modernization approaches that align with the Modernize methodology. You can best align these approaches to the standard [database migration toolchain](/data-migration/).

During the assess workloads phase, a cloud adoption team assesses the current state and future state for the migrated asset. When that process is part of an innovation effort, both cloud adoption teams can use this article to help make those assessments.

## Primary toolset

When you migrate and modernize on-premises data, the most common Azure tool choice is the [Azure Database Migration Service](/azure/dms/). This service is part of the broader [Azure Migrate hub](/azure/migrate/migrate-services-overview). For existing SQL Server data sources, [Data Migration Assistant](/sql/dma/dma-overview) helps you assess and migrate data structures.

:::image type="content" source="../../_images/modernize/migration-journey-tools-and-services.png" alt-text="Diagram showing the tools and services for your migration journey.":::

To support Oracle and NoSQL data migrations, you can also use [Azure Database Migration Service](/azure/dms/) for certain types of source-to-target databases, like migrating Oracle databases to [Azure Database for PostgreSQL](/azure/postgresql/single-server/overview) and MongoDB databases to [Azure Cosmos DB](/azure/cosmos-db/cosmosdb-migrationchoices). More commonly, adoption teams use partner tools or custom scripts to migrate to Azure Cosmos DB, Azure HDInsight, or virtual machine (VM) options based on infrastructure as a service (IaaS).

## Considerations and guidance

Before you use the [Azure Database Migration Service](/azure/dms/) for data migration and modernization, it's important to understand and weigh the following factors:

- Current platform for hosting the data source
- Platform version
- Number of servers and databases
- Size of databases
- Acceptable business downtime during the migration pro
- Future platform and version that best supports your hypothesis or target

:::image type="content" source="../../_images/modernize/automate-database-modernization.png" alt-text="Graphic showing the Database Migration Service works with PowerShell to automatically modernize a list of databases.":::

### Data migration types

With an offline migration, application downtime starts when the migration starts. For an online migration, downtime is limited to the time to cut over at the end of migration.

Test an offline migration to determine whether the downtime is acceptable. If the restoration time is unacceptable, do an online migration.

The following data migration type table shows source and target pairs to review with the migration team. Each pair includes a tool choice and a link to a related tutorial.

| Source | Target | Tool | Migration type | Guidance |
|--|--|--|--|--|
| SQL Server | Azure SQL Database | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-sql-server-to-azure-sql) |
| SQL Server | Azure SQL Database | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-sql-server-to-azure-sql) |
| SQL Server | Azure SQL Managed Instance | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-sql-server-to-managed-instance) |
| SQL Server | Azure SQL Managed Instance | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-sql-server-managed-instance-online) |
| MySQL | Azure Database for MySQL | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-mysql-azure-mysql-offline-portal) |
| PostgreSQL | Azure Database for PostgreSQL | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-postgresql-azure-postgresql-online) |
| MongoDB | Azure Cosmos DB API for MongoDB | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-mongodb-cosmos-db) |
| MongoDB | Azure Cosmos DB API for MongoDB | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-mongodb-cosmos-db-online) |

:::image type="content" source="../../_images/modernize/database-migration-process-overview.png" alt-text="Graphic showing process overview for database migration.":::
