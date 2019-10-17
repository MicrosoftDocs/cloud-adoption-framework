---
title: "Cloud innovation: Data Migration Service"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Cloud innovation - Data Migration Service
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/24/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Collect data through the migration and modernization of existing data sources

Companies often have a variety of existing data that can be [democratized](../considerations/data.md). When the customer hypothesis requires the use of existing data to build modern solutions, a first step may be the migration and modernization of data to prepare for inventions and innovations. To align with existing migration efforts within a cloud adoption plan, the migration and modernization could be more easily executed within the [Migrate methodology](../../migrate/index.md).

## Use of this article

This article outlines a series of approaches that align with the Migrate process, but could be best aligned to the standard Migrate toolchain. During the Assess process within the migrate methodology, the cloud adoption team would assess the current state and desire the future state for the asset to be migrated. When that process is part of an innovation effort, both cloud adoption teams could use this article to make those decisions.

## Primary toolset

When migrating and modernizing data that current resides on-prem, the most common Azure tool choice is [Data Migration Service (DMS)](https://docs.microsoft.com/azure/dms) which is part of the broader [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) toolchain. For existing SQL Server data sources, the [Data Migration Assistant (DMA)](/sql/dma/dma-overview) could also provide assistance in assessing and migrating a smaller number of data structures.

To support Oracle and NoSQL migrations, the [Data Migration Service (DMS)](https://docs.microsoft.com/azure/dms) can also be used for certain types of source to target databases, such as Oracle to PostgreSQL or MongoDB to Cosmos DB. It is more common for adoption teams to leverage third-party tools or custom migration scripts to migrate to Cosmos DB, HDInsight, or IaaS-based VM options.

## Considerations and guidance

When leveraging DMS for migration and modernization of data, it's important to understand the current platform for hosting the data (source), version, and the future platform and version that would best support the customer hypothesis (target). The following is a list of source and target pairs to review with the migration team. Each includes a tool choice and a link to a guide based on those considerations.

**Migrate type:** With an offline migration, application downtime starts when the migration starts. With an online migration, downtime is limited to the time to cut over at the end of migration. We suggest that you understand what is the acceptable business downtime and test an offline migration to determine if the restoration time meets this; if not, do an online migration.

|Source  |Target  |Tool  |Migration Type  |Guidance  |
|---------|---------|---------|---------|---------|
|SQL Server|Azure SQL Database|DMS|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql)|
|SQL Server|Azure SQL Database|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-azure-sql-online)|
|SQL Server|Azure SQL Database Managed Instance|DMS|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance)|
|SQL Server|Azure SQL Database Managed Instance|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online)|
|RDS SQL Server|Azure SQL Database (or Managed Instance)|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-rds-sql-server-azure-sql-and-managed-instance-online)|
|MySQL|Azure Database for MySQL|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mysql-azure-mysql-online)|
|PostgreSQL|Azure Database for PostgreSQL|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online)|
|MondoDB|Azure Cosmos DB Mongo API|DMS|Offline|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mongodb-cosmos-db)|
|MongoDB|Azure Cosmos DB Mongo API|DMS|Online|[Tutorial](https://docs.microsoft.com/azure/dms/tutorial-mongodb-cosmos-db-online)|
|Oracle|Range of PaaS & IaaS options|Third party or Azure Migrate|Various|[Decision Tree](../considerations/data-oracle-migration.md)|
|Various NoSQL DBs|Cosmo DB or IaaS options|Procedural migrations or Azure Migrate|Various|[Decision Tree](../considerations/data-no-sql-migration.md)|
