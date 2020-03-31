---
title: Innovation tools to migrate data
description: Learn about the Azure Database Migration Service and other tools that migrate and modernize data to prepare for cloud inventions and innovations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Collect data through the migration and modernization of existing data sources

Companies often have different kinds of existing data that they can [democratize](../considerations/data.md). When a customer hypothesis requires the use of existing data to build modern solutions, a first step might be the migration and modernization of data to prepare for inventions and innovations. To align with existing migration efforts within a cloud adoption plan, you can more easily do the migration and modernization within the [Migrate methodology](../../migrate/index.md).

## Use of this article

This article outlines a series of approaches that align with the Migrate process. You can best align these approaches to the standard Migrate toolchain.

During the Assess process within the Migrate methodology, a cloud adoption team assesses the current state and desired future state for the migrated asset. When that process is part of an innovation effort, both cloud adoption teams can use this article to help make those assessments.

## Primary toolset

When you migrate and modernize on-premises data, the most common Azure tool choice is [Azure Database Migration Service](https://docs.microsoft.com/azure/dms). This service is part of the broader [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) toolchain. For existing SQL Server data sources, [Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview) can help you assess and migrate a small number of data structures.

To support Oracle and NoSQL migrations, you can also use [Database Migration Service](https://docs.microsoft.com/azure/dms) for certain types of source-to-target databases. Examples include Oracle to PostgreSQL and MongoDB to Cosmos DB. More commonly, adoption teams use partner tools or custom scripts to migrate to Azure Cosmos DB, Azure HDInsight, or virtual machine options based on infrastructure as a service (IaaS).

## Considerations and guidance

When you use Azure Database Migration Service for migration and modernization of data, it's important to understand:

- The current platform for hosting the data source.
- The current version.
- The future platform and version that best supports the customer hypothesis or target.

The following table shows source and target pairs to review with the migration team. Each pair includes a tool choice and a link to a related guide.

### Migration type

With an offline migration, application downtime starts when the migration starts. With an online migration, downtime is limited to the time to cut over at the end of migration.

We suggest that you decide your acceptable business downtime and test an offline migration. You do so to check if the restoration time meets the acceptable downtime. If the restoration time is unacceptable, do an online migration.

|Source  |Target  |Tool  |Migration type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server|Azure SQL Database|Database Migration Service|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql)|
|SQL Server|Azure SQL Database|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-azure-sql-online)|
|SQL Server|Azure SQL Database managed instance|Database Migration Service|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance)|
|SQL Server|Azure SQL Database managed instance|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online)|
|RDS SQL Server|Azure SQL Database or Azure SQL Database managed instance|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-rds-sql-server-azure-sql-and-managed-instance-online)|
|MySQL|Azure Database for MySQL|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mysql-azure-mysql-online)|
|PostgreSQL|Azure Database for PostgreSQL|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online)|
|MongoDB|Azure Cosmos DB Mongo API|Database Migration Service|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mongodb-cosmos-db)|
|MongoDB|Azure Cosmos DB Mongo API|Database Migration Service|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mongodb-cosmos-db-online)|
