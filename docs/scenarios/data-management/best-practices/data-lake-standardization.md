---
title: Data Standardization in data management and analytics scenario.
description: Understand data Standardization in data management and analytics scenario.
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data Standardization

Today, many organizations are standardizing their ingest format and focussing on separating compute from storage. This has led to the emergence of format called Delta lake as a preferred standard for the initial data ingestion through to enrichment. From the enrichment layer, data application team can serve the data into a format which reflects there use case.

The section introduces what is delta lake, performance, how it can be used to assist with compliance support and how to standardize data as it flow from source data into the enriched layer.

> [!TIP]
> Delta lake support both batch and streaming use cases.

## What is Delta Lake?

Azure Synapse Analytics and Azure Databricks is compatible with Linux Foundation Delta Lake. Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to Apache Spark and big data workloads.

The current version of Delta Lake included with Azure Synapse has language support for Scala, PySpark, and .NET. There are links at the bottom of the page to more detailed examples and documentation.

## Key features

| Feature | Description |
| --- | --- |
| **ACID Transactions** | Data lakes are typically populated via multiple processes and pipelines, some of which are writing data concurrently with reads. Prior to Delta Lake and the addition of transactions, data engineers had to go through a manual error prone process to ensure data integrity. Delta Lake brings familiar ACID transactions to data lakes. It provides serializability, the strongest level of isolation level. Learn more at [Diving into Delta Lake: Unpacking the Transaction Log](https://databricks.com/blog/2019/08/21/diving-into-delta-lake-unpacking-the-transaction-log.html).|
| **Scalable Metadata Handling** | In big data, even the metadata itself can be "big data". Delta Lake treats metadata just like data, leveraging Spark's distributed processing power to handle all its metadata. As a result, Delta Lake can handle petabyte-scale tables with billions of partitions and files at ease. |
| **Time Travel (data versioning)** | The ability to "undo" a change or go back to a previous version is one of the key features of transactions. Delta Lake provides snapshots of data enabling you to revert to earlier versions of data for audits, rollbacks or to reproduce experiments. Learn more in [Introducing Delta Lake Time Travel for Large Scale Data Lakes](https://databricks.com/blog/2019/02/04/introducing-delta-time-travel-for-large-scale-data-lakes.html). |
| **Open Format** | Apache Parquet is the baseline format for Delta Lake, enabling you to leverage the efficient compression and encoding schemes that are native to the format. |
| **Unified Batch and Streaming Source and Sink** | A table in Delta Lake is both a batch table, as well as a streaming source and sink. Streaming data ingest, batch historic backfill, and interactive queries all just work out of the box. |
| **Schema Enforcement** | Schema enforcement helps ensure that the data types are correct and required columns are present, preventing bad data from causing data inconsistency. For more information, see [Diving Into Delta Lake: Schema Enforcement & Evolution](https://databricks.com/blog/2019/09/24/diving-into-delta-lake-schema-enforcement-evolution.html) |
| **Schema Evolution** | Delta Lake enables you to make changes to a table schema that can be applied automatically, without having to write migration DDL. For more information, see [Diving Into Delta Lake: Schema Enforcement & Evolution](https://databricks.com/blog/2019/09/24/diving-into-delta-lake-schema-enforcement-evolution.html) |
| **Audit History** | Delta Lake transaction log records details about every change made to data providing a full audit trail of the changes. |
| **Updates and Deletes** | Delta Lake supports Scala / Java / Python and SQL APIs for a variety of functionality. Support for merge, update, and delete operations helps you to meet compliance requirements. For more information, see [Announcing the Delta Lake 0.6.1 Release](https://delta.io/news/delta-lake-0-6-1-released/),  [Announcing the Delta Lake 0.7 Release](https://delta.io/news/delta-lake-0-7-0-released/) and [Simple, Reliable Upserts and Deletes on Delta Lake Tables using Python APIs](https://databricks.com/blog/2019/10/03/simple-reliable-upserts-and-deletes-on-delta-lake-tables-using-python-apis.html), which includes code snippets for merge, update, and delete DML commands. |
| **100% Compatible with Apache Spark API** | Developers can use Delta Lake with their existing data pipelines with minimal change as it is fully compatible with existing Spark implementations. |

For full documentation, see the [Delta Lake Documentation Page](https://docs.delta.io/latest/delta-intro.html)

For more information, see [Delta Lake Project](https://github.com/delta-io/delta).

## Performance

Lots of small files generally lead to suboptimal performance and potentially higher costs because of increased read/list operations. Azure Data Lake Storage Gen2 is optimized to perform better on larger files. Analytics jobs will run faster and at a lower cost. Delta Lake include a number of features to [Optimize performance with file management](/azure/databricks/delta/optimizations/file-mgmt).

Examples are:

- Delta Lake uses its transaction log to minimize expensive LIST operations.
- Z-Ordering (multi-dimensional clustering) enables optimized predicate pushdown for query filters. Z-Ordering is a technique to colocate related information in the same set of files. This co-locality is automatically used by Delta Lake to enable data-skipping algorithms, in Azure Databricks and Azure Synapse Spark to dramatically reduce the amount of data that needs to be read.
- It includes native caching and query optimizations to reduce the amount of storage scanning. For more information, see [Optimize performance with caching](/azure/databricks/delta/optimizations/delta-cache).
- OPTIMIZE which coalesces small files into larger ones.

These optimizations should be part of your data loading process to maintain data freshness and performance.

## Compliance support

Delta Lake adds a transactional layer that provides structured data management on top of your data lake, it can dramatically simplify and speed up your ability to locate and remove personal information (also known as "personal data") in response to consumer requests. It supports operations such as DELETE, UPDATE, and MERGE. For more information, see Best practices: Compliance using Delta Lake

## Next steps

[Provision three Azure Data Lake Storage Gen2 accounts for each data landing zone](./data-lake-zones.md)
