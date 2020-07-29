---
title: Azure Synapse Analytics solutions and migration for an Oracle data warehouse
description: Use the Cloud Adoption Framework for Azure to learn about migrating an Oracle data warehouse schema to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore Exadata SSMA -->

# Azure Synapse Analytics solutions and migration for an Oracle data warehouse schema

In terms of schema, an Oracle data warehouse differs from Azure Synapse Analytics in several ways. The differences include databases, data types, and a range of Oracle database object types that aren't supported in Azure Synapse.

Like other database management systems, when you migrate an Oracle data warehouse to Azure Synapse, you'll find that Oracle has multiple separate databases and Azure Synapse has only one database. You might need to use a new naming convention, such as concatenating Oracle schema and table names, to move tables and views in your Oracle data warehouse staging database, production database, and data mart databases to Azure Synapse.

Also, several Oracle database objects aren't supported in Azure Synapse. Database objects that aren't supported in Azure Synapse include Oracle bit-mapped indexes, Oracle function-based indexes, Oracle domain indexes, Oracle clustered tables, row-level triggers, Oracle user-defined data types, and PL/SQL stored procedures. You can identify these objects by querying various Oracle system catalog tables and views. You can use workarounds, in some cases. For example, other index types or partitioning can be used in Azure Synapse to work around the unsupported index types in Oracle. Materialized views may also be able to be used instead of Oracle clustered tables while migration tools like SQL Server Migration Assistant for Oracle can translate at least some PL/SQL.

You also must take into account data type differences on columns when you migrate an Oracle data warehouse schema. To find the columns in your Oracle data warehouse and data mart schemas that have data types that don't have a mapping to data types in Azure Synapse, query the Oracle catalog. You can use workarounds for several of these instances.

To maintain or improve performance of your schema after migration, consider the performance mechanisms, like Oracle indexing, that you currently have in place. For example, bit-mapped indexes that Oracle queries use frequently might indicate that a nonclustered index should be created in the migrated schema on Azure Synapse. 

Good practices in Azure Synapse include using data distribution to colocate data to be joined onto the same processing node and ensuring that data types of columns to be joined are identical to optimize join processing by reducing the need to transform data for matching. With Azure Synapse, often it's not necessary to migrate every Oracle index, because other features provide high performance. You can use parallel query processing, in-memory data, and result set caching and data distribution options that reduce I/O instead.

SQL Server Migration Assistant (SSMA) for Oracle is a tool that can help you migrate an Oracle data warehouse or data mart to Azure Synapse. SSMA is designed to automate migrating tables, views, and data from existing Oracle environments. Among other features, SSMA recommends index types and data distributions for target Azure Synapse tables and applies data type mappings during migration. Although SSMA isn't the most efficient approach for very high volumes of data, it's useful for smaller tables.

