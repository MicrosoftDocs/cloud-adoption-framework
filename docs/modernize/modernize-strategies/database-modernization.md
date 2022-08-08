---
title: Modernize your SQL database in the cloud
description: Understand and evaluate options for maturing your underlying data platforms for modernization.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: seo-caf-modernize
keywords: collect data, migrate data, data migration, data modernization
---
# Modernize database in the cloud

Modernize your databases in the cloud. The path you choose depends on where you're starting from and where you want to go. Below, you will find guidance on what to do and how to do it.

There are solutions for Azure SQL, open-source SQL, and NoSQL databases. Depending on the amount of control you want, we provide solutions with infrastructure-as-a-service (IaaS) and platform-as-a-service (PaaS) offerings.

:::image type="content" source="../../_images/modernize/db-platforms/db-modernize-531.png" alt-text="image showing database platform options in the cloud, moving from most control to most productivity. On the bottom there is an on-premises starting point. Two paths emerge, one for SQL database and another for open-source and NoSQL databases":::

## Modernize with Azure SQL

Modernize your SQL Server databases with Azure SQL.

In the table, find your desired level of control vs. productivity. Then, see if the solution meets your needs. Follow the implementation guidance for your use case.

| Control vs. Productivity | Solution | Your Needs | Implementation guidance |
| --- | --- | --- | --- |
| *Most control* | SQL Server on [Windows](/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-what-is-overview) or [Linux](/azure/azure-sql/virtual-machines/linux/sql-server-on-linux-vm-what-is-iaas-overview) virtual machines (VMs) | <ul><li>OS control</li> <li>Quick modernization</li></ul> | [SQL Server](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/virtual-machines/oracle-to-sql-on-azure-vm-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/virtual-machines/db2-to-sql-on-azure-vm-guide) <br><br> Using the [Azure Database Migration Service](/azure/dms/)|
| *Balance control & <br>productivity*| [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) | <ul><li> Near 100% compatibility with SQL Server (Enterprise Edition)</li> <li>Automated patching </li> <li>Native high availability</li> <li> Instance-scoped features (Service Broker, SQL Server Agent, etc.) </li> </ul> | [SQL Server](/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/managed-instance/db2-to-managed-instance-guide)
| *Most productivity*| [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview) | <ul><li>A multi-tenant SaaS application</li><li>Elasticity</li><li>To scale compute independent from storage</li></ul> | [SQL Server](/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/database/oracle-to-sql-database-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/database/db2-to-sql-database-guide) <br><br> [Access](/azure/azure-sql/migration-guides/database/access-to-sql-database-guide) <br><br> [SAP ASE](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database) |
|

## Modernize open-source SQL & NoSQL databases

Modernize your open-source databases and NoSQL databases and find the balance of control and productivity that meets your needs.

In the table, find your desired level of control vs. productivity. Then, see if the solution meets your needs. Follow the implementation guidance for your use case.

| Control vs. Productivity | Solution | Your Needs | Implementation guidance |
| --- | --- | --- | --- |
| *Most control* | Open-source databases on virtual machines - [MySQL](/azure/mysql/single-server/overview),  [MariaDB](/azure/mariadb/overview), [PostgreSQL](/azure/postgresql/single-server/overview) | <ul><li>OS control </li> <li> Zone redundancy </li></ul> | Using the [Azure Database Migration Service](/azure/dms/) <br><br> [Installing a database on a VM](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview)|
| *Balance control & productivity* | [Azure Managed instance for Apache Cassandra](/azure/managed-instance-apache-cassandra/introduction)| <ul><li> Hybrid deployment </li> <li>Automated deployment & scaling for Apache Cassandra datacenters</li> <li>Automated patching</li> <li>Automated health checks</li> </ul> | [Apache Cassandra](/azure/managed-instance-apache-cassandra/dual-write-proxy-migration) |
| *Most productivity* | [Azure Cosmos DB](/azure/cosmos-db/introduction) | <ul><li> A fully-managed NoSQL database</li><li>Cost-efficiency</li><li>Support for MongoDB & Gremlin</ul> | [Azure Cosmos DB](/azure/cosmos-db/cosmosdb-migrationchoices) |
| *Most productivity* | [Azure Database for MySQL](/azure/mysql/single-server/overview) | <ul><li>A fully-managed SQL solution</li><li>Cost and performance efficiency</li></ul> | [Azure Database for MySQL](/azure/dms/tutorial-mysql-azure-mysql-offline-portal) <br><br> Using the [Azure Database Migration Service](/azure/dms/)|
| *Most productivity* | [Azure Database for MariaDB](/azure/mariadb/overview) | <ul><li>A fully-managed SQL solution</li><li>Cost and performance efficiency</li></ul> | [Azure Database for MariaDB](/azure/mariadb/howto-migrate-dump-restore) |
| *Most productivity* | [Azure Database for PostgreSQL](/azure/postgresql/single-server/overview) | <ul><li>A fully-managed SQL solution</li><li>Cost and performance efficiency</li></ul>| [Azure Database for PostreSQL](/azure/dms/tutorial-postgresql-azure-postgresql-online-portal) |
|

## Next Steps

>[!div class="nextstepaction"]
> [Learn how to Innovate in the cloud](../../innovate/index.md)
