---
title: Collect data and migrate
description: Learn about Azure Database Migration Service and other data migration tools for data modernization for cloud inventions and innovations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: seo-caf-innovate
keywords: collect data, migrate data, data migration, data modernization
---

# Collect data through the migration and data modernization of existing sources

Companies often have different kinds of existing data that they can [democratize](../considerations/data.md). When a customer hypothesis requires the use of existing data to build modern solutions, a first step might be data migration and data modernization to prepare for inventions and innovations. To align with existing migration efforts within a cloud adoption plan, do your migration and modernization by using the [Migrate methodology](../../migrate/index.md).

## Use of this article

This article outlines a series of approaches that align with the Migrate methodology. You can best align these approaches to the standard database migration toolchain.

During the assess workloads phase, a cloud adoption team assesses the current state and future state for the migrated asset. When that process is part of an innovation effort, both cloud adoption teams can use this article to help make those assessments.

## Primary toolset

When you migrate and modernize on-premises data, the most common Azure tool choice is the [Azure Database Migration Service](/azure/dms/). This service is part of the broader [Azure Migrate hub](/azure/migrate/migrate-services-overview). For existing SQL Server data sources, [Data Migration Assistant](/sql/dma/dma-overview) helps you assess and migrate data structures.

To support Oracle and NoSQL data migrations, you can also use Azure Database Migration Service for certain types of source-to-target databases. For example, migrating Oracle databases to PostgreSQL or migrating MongoDB databases to Azure Cosmos DB. More commonly, adoption teams use partner tools or custom scripts to migrate to Azure Cosmos DB, Azure HDInsight, or virtual machine options based on infrastructure as a service (IaaS).

## Considerations and guidance

When you use Azure Database Migration Service for data migration and data modernization, it's important to understand:

- The current platform for hosting the data source.
- The current version.
- The future platform and version that best supports the customer hypothesis or target.

### Data migration type

With an offline migration, application downtime starts when the migration starts. For an online migration, downtime is limited to the time to cut over at the end of migration.

Test an offline migration to determine whether the downtime is acceptable. If the restoration time is unacceptable, do an online migration.

The following data migration type table shows source and target pairs to review with the migration team. Each pair includes a tool choice and a link to a related tutorial.

| Source | Target | Tool | Migration type | Guidance |
|--|--|--|--|--|
| SQL Server | Azure SQL Database | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-sql-server-to-azure-sql) |
| SQL Server | Azure SQL Database | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-sql-server-to-azure-sql) |
| SQL Server | Azure SQL Managed Instance | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-sql-server-to-managed-instance) |
| SQL Server | Azure SQL Managed Instance | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-sql-server-managed-instance-online) |
| RDS SQL Server | Azure SQL Database or Azure SQL Managed Instance | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-rds-sql-server-azure-sql-and-managed-instance-online) |
| MySQL | Azure Database for MySQL | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-mysql-azure-mysql-online) |
| PostgreSQL | Azure Database for PostgreSQL | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-postgresql-azure-postgresql-online) |
| MongoDB | Azure Cosmos DB API for MongoDB | Database Migration Service | Offline | [Tutorial](/azure/dms/tutorial-mongodb-cosmos-db) |
| MongoDB | Azure Cosmos DB API for MongoDB | Database Migration Service | Online | [Tutorial](/azure/dms/tutorial-mongodb-cosmos-db-online) |
