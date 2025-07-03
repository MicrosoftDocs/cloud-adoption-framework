---
title: Data standardization
description: Understand data standardization in cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 04/08/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data standardization

Data arrives in data lake accounts in various formats. These formats include human readable formats, such as JSON, .CSV, or XML files, and compressed binary formats, such as .tar or .gz. Arriving data also comes in many sizes, from a few edited files to an export of an entire SQL table. Data can also come as a large number of small files that are a few kbs apiece, such as real-time events from an IoT solution.

While Azure Data Lake Storage Gen2 does support storage for all kinds of data without restrictions, you should carefully consider your data formats to ensure processing pipeline efficiency and optimize costs.

Many organizations now standardize their ingest format and separate compute from storage. Because of this, the Delta Lake format has become the preferred standard for data ingestion through to the enrichment layer. From the enrichment layer, your data application team can serve data into a format that reflects their use case.

> [!NOTE]
> Use Delta Lake to support both batch and streaming use cases for initial data ingestion through to enrichment layer.

This article provides an overview of Delta Lake, its performance, and how it helps you achieve compliance support, and how to standardize your data as it flows from source to enrichment layer.

## Delta Lake

Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to big data workloads and Apache Spark. Azure Databricks is compatible with Linux Foundation Delta Lake.

## Delta Lake key features

| Feature | Description |
| --- | --- |
| **ACID Transactions** | Data lakes are typically populated via multiple processes and pipelines, some of which write data concurrently with reads. Data engineers used to go through a manual, error-prone process to ensure data integrity before Delta lake and transactions came into use. Delta Lake brings familiar ACID transactions to data lakes. It provides the strongest isolation level, serializability. For more information, see [Diving into Delta Lake: Unpacking the Transaction Log](https://databricks.com/blog/2019/08/21/diving-into-delta-lake-unpacking-the-transaction-log.html).|
| **Scalable Metadata Handling** | In big data, even metadata can be "big data". Delta Lake treats metadata the same as other data. It uses Spark's distributed processing power to handle all metadata. Because of this, Delta Lake can easily handle petabyte-scale tables with billions of partitions and files. |
| **Time Travel (data versioning)** | The ability to "undo" a change or go back to a previous version is a key feature of transactions. Delta Lake provides snapshots of data enabling you to revert to earlier versions of data for audits, rollbacks or to reproduce experiments. Learn more in [Introducing Delta Lake Time Travel for Large Scale Data Lakes](https://databricks.com/blog/2019/02/04/introducing-delta-time-travel-for-large-scale-data-lakes.html). |
| **Open Format** | Apache Parquet, the baseline format for Delta Lake, lets you apply efficient compression and encoding schemes. |
| **Unified Batch and Streaming Source and Sink** | A table in Delta Lake is simultaneously a batch table and a streaming source and sink. Data ingest streaming, batch historic backfill, and interactive queries all work out of the box. |
| **Schema Enforcement** | Schema enforcement helps you ensure you have correct data types and required columns, which prevents data inconsistency from bad data. For more information, see [Diving Into Delta Lake: Schema Enforcement & Evolution](https://databricks.com/blog/2019/09/24/diving-into-delta-lake-schema-enforcement-evolution.html) |
| **Schema Evolution** | Delta Lake lets you make automatically applied changes to a table schema, without needing to write migration DDL. For more information, see [Diving Into Delta Lake: Schema Enforcement & Evolution](https://databricks.com/blog/2019/09/24/diving-into-delta-lake-schema-enforcement-evolution.html) |
| **Audit History** | The Delta Lake transaction log records details about every change made to your data. These records provide a complete audit trail of all changes. |
| **Updates and Deletes** | Delta Lake supports Scala, Java, Python, and SQL APIs for various functionalities. Merge, update, and delete operations support helps you meet compliance requirements. For more information, see [Announcing the Delta Lake 0.6.1 Release](https://github.com/delta-io/delta/releases/tag/v0.6.1),  [Announcing the Delta Lake 0.7 Release](https://github.com/delta-io/delta/releases/tag/v0.7.0), and [Simple, Reliable Upserts and Deletes on Delta Lake Tables using Python APIs](https://databricks.com/blog/2019/10/03/simple-reliable-upserts-and-deletes-on-delta-lake-tables-using-python-apis.html) (which includes code snippets for merge, update, and delete DML commands). |
| **100% Compatible with Apache Spark API** | Your developers can use Delta Lake with minimal change to their existing data pipelines, since it's fully compatible with existing Spark implementations. |

For more information, see [Delta Lake Project](https://github.com/delta-io/delta).

For full documentation, visit the [Delta Lake Documentation Page](https://docs.delta.io/latest/delta-intro.html)

## Performance

Using lots of small files often results in suboptimal performance and higher costs from increased read/list operations. Azure Data Lake Storage Gen2 is optimized for larger files that allow your analytics jobs to run faster and with lower cost.

Delta Lake includes many features that can help you [Optimize performance with file management](/azure/databricks/delta/file-mgmt).

Examples include:

- The transaction log minimizes expensive LIST operations.
- Z-Ordering (multi-dimensional clustering) enables optimized predicate pushdown for your query filters.
- Native caching and query optimizations reduce the amount of storage scanning you require. For more information, see [Optimize performance with caching](/azure/databricks/optimizations/disk-cache).
- OPTIMIZE coalesces small files into larger ones.

Make these optimizations part of your data loading process to maintain data freshness and performance.

## Data lake partitioning

Data partitioning involves organizing data in your data store so you can manage large-scale data and control data access. Partitioning can improve scalability, reduce contention, and optimize performance. 

When partitioning your data lake, ensure your setup:

- Doesn't compromise security
- Has clear isolation and aligns with your data authorization model
- Fits your data ingestion process well
- Has a well-defined path for optimal data access
- Supports management and maintenance tasks

### General practices

The general practices for data partitioning design are:

- Focus on your security implication early, and design your data partitions together with authorization.
- You might want to allow data redundancy in exchange for security.- Define a naming convention and adhere to it.
- You can nest multiple folders, but always keep them consistent.
- Include a time element in your folder structures and file names.
- Don't start your folder structure with date partitions. It's better to keep dates at the lower folder level.
- Don't combine mixed file formats or different data products in a single folder structure.

> [!TIP]
> Your folder structures should have partitioning strategies that can optimize access patterns and appropriate file sizes. In the curated zones, plan the structure based on optimal retrieval, be cautious of choosing a partition key with high cardinality, which leads to over partitioning, which in turn leads to suboptimal file sizes.

For more information on data lake zones, see [Data lake zones and containers](../best-practices/data-lake-zones.md)

## Compliance support

Delta Lake adds a transactional layer to provide structured data management on top of your data lake. This addition can dramatically simplify and speed up your ability to locate and remove personal information (also known as "personal data") upon consumer request. The transactional layer supports operations like DELETE, UPDATE, and MERGE. For more information, see [Best practices: GDPR compliance using Delta Lake](/azure/databricks/security/privacy/gdpr-delta).

## Summary

Apply the data standardizations listed in this article to your platform. Begin with Delta Lake format, then start adding processes for optimization and compliance. You might decide to create a service that runs some of your optimization routes on a schedule, or create a compliance service that removes personal information.

## Next steps

- [Common Data Model & Industry Data Models](common-industry-data-models.md)
