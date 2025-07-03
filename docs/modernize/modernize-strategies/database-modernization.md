---
title: Modernize databases in the cloud
description: Adopt database PaaS and infrastructure-as-a-service (IaaS) solutions to modernize any databases. Find the implementation guidance that gives you right balance of control and productivity
author: stephen-sumner
ms.author: pnp
ms.date: 09/02/2022
ms.topic: conceptual
keywords: collect data, migrate data, data migration, data modernization
---
# Modernize any database in the cloud

Modernizing your databases can improve how you store, process, and feed data. The goal of database transformation is to improve the reliability, performance, and cost of your data. Adopt platform-as-a service (PaaS) and infrastructure-as-a-service (IaaS) solutions to modernize any database in the cloud.  

**Two categories of database solutions:**

We have two categories of database solutions. These two categories allow you to modernize any type of database in the cloud.

- "*Azure SQL*" is a category of database solutions for SQL Server and other closed-source SQL databases.
- "*Open-source and NoSQL*" is a category of database solutions for open-source SQL databases and NoSQL databases.

:::image type="content" source="../../_images/modernize/db-platforms/db-modernize.png" alt-text="Diagram that shows database platform options in the cloud, moving from most control to most productivity. The bottom has on-premises as the starting point. Two paths emerge, one for SQL database and another for open-source and NoSQL databases." border="false":::

**PaaS and IaaS solutions:**

There are two PaaS and one IaaS solution to choose from in each database category. Each option provides a different balance of control and productivity. We include infrastructure-as-a-service (IaaS) solutions to accommodate the different database origins customers start with.

*Azure SQL:*

- SQL Server on virtual machines (IaaS)
- Azure SQL Managed Instance (PaaS)
- Fully managed Azure SQL database (PaaS)

*Open-source SQL & NoSQL:*

- MySQL, MariaDB, or PostgreSQL on virtual machines (IaaS)
- Azure Cosmos DB and Azure Managed Instance for Apache Casandra (PaaS)
- Fully managed MySQL and PostgreSQL databases (PaaS)

Use the tables below to find implementation guidance on modernizing your database.

## Option 1 - Modernize your SQL Server and other SQL databases

Modernize your SQL Server and other SQL databases. Azure SQL supports SQL Server and other proprietary SQL databases like Oracle and Db2.

Finding the right balance of control and productivity is a main consideration in database modernization. Use the following table to find the right balance. Check to see if the solution listed meets your needs.

When you find the right solution, follow the implementation guidance to modernize your application.

| Control vs. Productivity | Solution | Your needs | Implementation guidance |
| --- | --- | --- | --- |
| *Most control* | SQL Server on [Windows](/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-what-is-overview) or [Linux](/azure/azure-sql/virtual-machines/linux/sql-server-on-linux-vm-what-is-iaas-overview) virtual machines (VMs) | <ul><li>OS control</li> <li>Quick modernization</li></ul> | Database origin:<br><br>[SQL Server](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/virtual-machines/oracle-to-sql-on-azure-vm-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/virtual-machines/db2-to-sql-on-azure-vm-guide) <br><br> [Azure Database Migration Service](/azure/dms/)|
| *Balance control & <br>productivity*| [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) | <ul><li> Near 100% compatibility with SQL Server (Enterprise Edition)</li> <li>Automated patching </li> <li>Native high availability</li> <li> Instance-scoped features (such as Service Broker or SQL Server Agent) </li> </ul> | Database origin:<br><br>[SQL Server](/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/managed-instance/db2-to-managed-instance-guide)
| *Most productivity*| [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview) | <ul><li>A multi-tenant SaaS application</li><li>Elasticity</li><li>To scale compute independent from storage</li></ul> |Database origin:<br><br> [SQL Server](/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-overview) <br><br> [Oracle](/azure/azure-sql/migration-guides/database/oracle-to-sql-database-guide) <br><br> [Db2](/azure/azure-sql/migration-guides/database/db2-to-sql-database-guide) <br><br> [Access](/azure/azure-sql/migration-guides/database/access-to-sql-database-guide) <br><br> [SAP ASE](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database) |

## Option 2 - Modernize your open-source SQL & NoSQL databases

Modernize your open-source SQL databases and NoSQL databases. Finding the right balance of control and productivity is a main consideration in database modernization. Use the table to find the right balance. Check to see if the solution listed meets your needs.

When you find the right solution, follow the implementation guidance to modernize your application.

| Control vs. Productivity | Solution | Your needs | Implementation guidance |
| --- | --- | --- | --- |
| *Most control* | Open-source databases on virtual machines - [MySQL](/azure/mysql/single-server/overview),  [MariaDB](/azure/mariadb/overview), [PostgreSQL](/azure/postgresql/single-server/overview) | <ul><li>OS control </li> <li> Zone redundancy </li></ul> | Using the [Azure Database Migration Service](/azure/dms/) <br><br> [Installing a database on a VM](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-migration-overview)|
| *Balance control & productivity* | [Azure Managed Instance for Apache Cassandra](/azure/managed-instance-apache-cassandra/introduction)| <ul><li> Hybrid deployment </li> <li>Automated deployment & scaling for Apache Cassandra datacenters</li> <li>Automated patching</li> <li>Automated health checks</li> </ul> | [Apache Cassandra](/azure/managed-instance-apache-cassandra/dual-write-proxy-migration) |
| *Most productivity* | [Azure Cosmos DB](/azure/cosmos-db/introduction) | <ul><li> A fully managed NoSQL database</li><li>Cost-efficiency</li><li>Support for MongoDB & Gremlin</ul> | [Azure Cosmos DB](/azure/cosmos-db/cosmosdb-migrationchoices) |
| *Most productivity* | [Azure Database for MySQL](/azure/mysql/single-server/overview) | <ul><li>A fully managed SQL solution</li><li>Cost and performance efficiency</li></ul> | [Azure Database for MySQL](/azure/dms/tutorial-mysql-azure-mysql-offline-portal) <br><br> Using the [Azure Database Migration Service](/azure/dms/)|
| *Most productivity* | [Azure Database for PostgreSQL](/azure/postgresql/single-server/overview) | <ul><li>A fully managed SQL solution</li><li>Cost and performance efficiency</li></ul>| [Azure Database for PostgreSQL](/azure/dms/tutorial-postgresql-azure-postgresql-online-portal)|

## Next steps

Get more guidance with the [Azure Migration and Modernization Program](https://azure.microsoft.com/migration/migration-modernization-program)

>[!div class="nextstepaction"]
> [Learn how to Innovate in the cloud](../../innovate/index.md)
