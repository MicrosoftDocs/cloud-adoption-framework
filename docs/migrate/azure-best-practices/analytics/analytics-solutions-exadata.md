---
title: Azure Synapse Analytics migration for Oracle data warehouse
description: Use the Cloud Adoption Framework for Azure to learn about migrating an Oracle data warehouse schema to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Azure Synapse Analytics solutions and migration for an Oracle data warehouse

An Oracle data warehouse schema is different from Azure Synapse Analytics in several ways. The differences include databases, data types, and a range of Oracle Database object types that aren't supported in Azure Synapse.

Like other database management systems, when you migrate an Oracle data warehouse to Azure Synapse, you'll find that Oracle has multiple, separate databases and Azure Synapse has only one database. You might need to use a new naming convention, such as concatenating Oracle schema and table names, to move tables and views in your Oracle data warehouse staging database, production database, and data mart databases to Azure Synapse.

Several Oracle Database objects aren't supported in Azure Synapse. Database objects that aren't supported in Azure Synapse include Oracle bit-mapped indexes, function-based indexes, domain indexes, Oracle clustered tables, row-level triggers, user-defined data types, and PL/SQL stored procedures. You can identify these objects by querying various Oracle system catalog tables and views. In some cases, you can use workarounds. For example, you can use partitioning or other index types in Azure Synapse to work around the unsupported index types in Oracle. You might be able to use materialized views instead of Oracle clustered tables, and migration tools like SQL Server Migration Assistant (SSMA) for Oracle can translate at least some PL/SQL.

When you migrate an Oracle data warehouse schema, you also must take into account data type differences on columns. To find the columns in your Oracle data warehouse and data mart schemas that have data types that don't map to data types in Azure Synapse, query the Oracle catalog. You can use workarounds for several of these instances.

To maintain or improve performance of your schema after migration, consider performance mechanisms, like Oracle indexing, that you currently have in place. For example, bit-mapped indexes that Oracle queries frequently use might indicate that creating a nonclustered index in the migrated schema on Azure Synapse would be advantageous.

A good practice in Azure Synapse includes using data distribution to colocate data to be joined onto the same processing node. Another good practice in Azure Synapse is ensuring that data types of columns to be joined are identical. Using identical joined columns optimizes join processing by reducing the need to transform data for matching. In Azure Synapse, often it isn't necessary to migrate every Oracle index because other features provide high performance. You can instead use parallel query processing, in-memory data, and result set caching and data distribution options that reduce I/O.

SSMA for Oracle can help you migrate an Oracle data warehouse or data mart to Azure Synapse. SSMA is designed to automate the process of migrating tables, views, and data from an existing Oracle environment. Among other features, SSMA recommends index types and data distributions for target Azure Synapse tables, and it applies data type mappings during migration. Although SSMA isn't the most efficient approach for very high volumes of data, it's useful for smaller tables.
