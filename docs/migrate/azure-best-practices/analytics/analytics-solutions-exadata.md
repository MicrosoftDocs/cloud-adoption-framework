---
title: "Analytics solutions for Exadata"
description: Use the Cloud Adoption Framework for Azure to learn about analytic solutions with Exadata.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore Exadata SSMA -->

# Analytics solutions for Exadata

## Migrating an Oracle data warehouse schema to Azure Synapse Analytics

In terms of schema, Oracle data warehouse differs from Azure Synapse Analytics in several ways. This includes in terms of databases, data types, and a range of Oracle database object types that are not supported in Azure Synapse Analytics.

Like other database management systems, when migrating an Oracle data warehouse to Azure Synapse, you will find that multiple separate databases exist in Oracle and only one database in Azure Synapse. Therefore, it may be necessary to use a new naming convention (such as concatenating Oracle schema and table names) to move tables and views in your Oracle data warehouse staging database, production database, and data mart databases to Azure Synapse.

Also, there are several Oracle database objects that are not supported. For example, Oracle bit-mapped indexes, function-based indexes, and domain indexes are not supported. The same is true for Oracle clustered tables, row-level triggers, user-defined data types, and PL/SQL stored procedures. You can identify these objects by querying various Oracle system catalog tables and views. Workarounds are possible in several cases. For example, other index types or partitioning can be used in Azure Synapse to work around the unsupported index types in Oracle. Materialized views may also be able to be used instead of Oracle clustered tables while migration tools like SQL Server Migration Assistant for Oracle can translate at least some PL/SQL.

There are also data type differences on columns that you will have to take into account when migrating schema. You can find the columns in your Oracle data warehouse and data mart schemas with data types that do not have a mapping to data types in Azure Synapse by querying the Oracle catalog. There are workarounds for several of these instances.

In terms of maintaining or improving performance of your schema after migration, you should take a note of what performance mechanisms you currently have in place such as Oracle indexing. For example, bit-mapped indexes frequently used by queries in Oracle may indicate that a non-clustered index should be created within the migrated schema on Azure Synapse. Good practices on Azure Synapse include using data distribution to colocate data to be joined onto the same processing node and ensuring data types of columns to be joined are identical in order to optimize join processing by reducing the need to transform data for matching. With Azure Synapse, it's often not necessary to migrate every Oracle index, since other features are used to provide high performance. Parallel query processing, in-memory data, and result set caching and data distribution options that reduce I/O can all be used instead.

There are several tools to help you migrate an Oracle data warehouse or data mart to Azure Synapse. These tools include SQL Server Migration Assistant (SSMA) for Oracle, which is designed to automate migration of tables, views, and data from existing Oracle environments. Among other features, SSMA recommends index types and data distributions for target Azure Synapse tables and applies data type mappings during migration. Although SSMA will not be the most efficient approach for very-high-volume data, it is useful for smaller tables.

## Next steps

<!-- TODO: Add actionable next step -->
