---
title: Data lake zones and containers
description: Learn about the three Azure Data Lake Storage Gen2 accounts that can be provisioned for each data landing zone.
author: mboswell
ms.author: mboswell
ms.date: 03/02/2023
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data lake zones and containers

It's important to plan your data structure before you land it into a data lake. When you have a plan, you can use security, partitioning, and processing effectively.

For an overview of data lakes, see [Overview of Azure Data Lake Storage for cloud-scale analytics](../../data-management/best-practices/data-lake-overview.md).

## Overview

Your three data lake accounts should align to the typical data lake layers.

| Lake number | Layers      | Container number | Container name |
|-------------|-------------|--------------|-------------------|
| 1           | Raw         | 1            | Landing           |
| 1           | Raw         | 2            | Conformance       |
| 2           | Enriched    | 1            | Standardized      |
| 2           | Curated     | 2            | Data products     |
| 3           | Development | 1            | Analytics sandbox |
| 3           | Development | #            | Synapse primary storage number |

The previous table shows the standard number of containers we recommend per data landing zone. The exception to this recommendation is if different soft delete policies are required for the data in a container. These requirements determine your need for more containers.

> [!NOTE]
> Three data lakes are illustrated in each data landing zone. The data lake sits across three data lake accounts, multiple containers, and folders, but it represents one logical data lake for your data landing zone.
>
> Depending on your requirements, you might want to consolidate raw, enriched, and curated layers into one storage account. Keep another storage account named "development" for data consumers to bring other useful data products.
>
>For more information about separating data lake accounts, see [Storage accounts in a logical data lake](../../data-management/best-practices/data-lake-overview.md#storage-accounts-in-a-logical-data-lake).

Enable Azure Storage with the [hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace), which allows you to efficiently manage files. The hierarchical name space feature organizes objects and files within an account into a hierarchy of directories and nested subdirectories. This hierarchy is organized the same way as the file system on your computer.

When your data agnostic ingestion engine or onboarding application registers a new system of record, it creates required folders in containers in the raw, enriched, and standardized data layers. If a source-aligned data application ingests the data, your data application team needs your data landing zone team to create the folders and security groups. Put a service principle name or managed identity into the correct group, and assign a permission level. Document this process for your data landing zone and data application teams.

For more information on teams, see [Understand roles and teams for cloud-scale analytics in Azure](../organize-roles-teams.md).

Each data product should have two folders in the data products container that your data product team owns.

In a standardized container's enriched layer, there are two folders per source system, divided by classification. With this structure, your team can separately store data that has different security and data classifications, and assign them different security access.

Your standardized container needs a general folder for *confidential or below* data and a *sensitive* folder for personal data. Control access to these folders by using access control lists (ACLs). You can create a dataset with all personal data removed, and store it in your general folder. You can have another dataset that includes all personal data in your *sensitive* personal data folder.

A combination of ACLs and Microsoft Entra groups restrict data access. These lists and groups control what other groups can and can't access. Data owners and data application teams can approve or reject access to their data assets.

For more information, see [Data access management](../../data-management/security-provisioning.md) and [Restricted data](../../data-management/secure-data-privacy.md#restricted-data).

> [!WARNING]
> Some software products don't support mounting the root of a data lake container. Because of this limitation, each data lake container in raw, curated, enriched, and development layers should contain a single folder that branches off to multiple folders. Set up your folder permissions carefully. When you create a new folder from the root, the default ACL on the parent directory determines a child directory's default ACL and access ACL. A child file's ACL doesn't have a default ACL.
>
>For more information, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## Raw layer or data lake one

Think of the raw layer as a reservoir that stores data in its natural and original state. It's unfiltered and unpurified. You might store the data in its original format, such as JSON or CSV. Or it might be cost effective to store the file contents as a column in a compressed file format, like Avro, Parquet, or Databricks Delta Lake.

This raw data is immutable. Keep your raw data locked down, and if you give permissions to any consumers, automated or human, ensure that they're read-only. You can organize this layer by using one folder per source system. Give each ingestion process write access to only its associated folder.

When you load data from source systems into the raw zone, you can choose to do:

- **Full loads** to extract a full data set.
- **Delta loads** to load only changed data.

Indicate your chosen loading pattern in your folder structure to simplify use for your data consumers.

Raw data from source systems for each source-aligned data application or automated ingestion engine source lands in the full folder or the delta folder. Each ingestion process should have write access to only its associated folder.

The differences between full loads and delta loads are:

- **Full load** - Complete data from the source can be onboarded if:
  - The data volume at the source is small.
  - The source system doesn't maintain a timestamp field that identifies if data has been added, updated, or deleted.
  - The source system overwrites the complete data each time.

- **Delta load** - Incremental data from the source can be onboarded if:
  - The data volume at the source is large.
  - The source system maintains a timestamp field that identifies if data has been added, updated, or deleted.
  - The source system creates and updates files on data changes.

Your raw data lake is composed of your landing and conformance containers. Each container uses a 100% mandatory folder structure specific to its purpose.

### Landing container layout

Your landing container is reserved for raw data that's from a recognized source system. Your data agnostic ingestion engine or a source-aligned data application loads the data, which is unaltered and in its original supported format.

```markdown
.
|-Landing
|--Log
|---{Application Name}
|--Master and Reference
|---{Source System}
|--Telemetry
|---{Source System}
|----{Application}
|--Transactional
|---{Source System}
|----{Entity}
|-----{Version}
|------Delta
|-------{date (ex. rundate=2019-08-22)}
|------Full
```

### Raw layer conformance container

Your raw layer contains data quality conformed data. As data is copied to a landing container, data processing and computing is triggered to copy the data from the landing container to the conformance container. In this first stage, data gets converted into the delta lake format and lands in an input folder. When data quality runs, records that pass are copied into the output folder. Records that fail land in an error folder.

```markdown
.
|-Conformance
|--Log
|---{Application Name}
|--Master and Reference
|---{Source System}
|--Telemetry
|---{Source System}
|----{Application}
|--Transactional
|---{Source System}
|----{Entity}
|-----{Version}
|------Delta
|-------Input
|--------{date (ex. rundate=2019-08-22)}
|-------Output
|--------{date (ex. rundate=2019-08-22)}
|-------Error
|--------{date (ex. rundate=2019-08-22)}
|------Full
|-------Input
|--------{date (ex. rundate=2019-08-22)}
|-------Output
|--------{date (ex. rundate=2019-08-22)}
|-------Error
|--------{date (ex. rundate=2019-08-22)}
```

> [!TIP]
> Think about scenarios where you might need to rebuild an analytics platform from scratch. Consider the most granular data you need to rebuild downstream read data stores. Make sure you have a [business continuity and disaster recovery](../../data-management/eslz-business-continuity-and-disaster-recovery.md) plan in place for your key components.

## Enriched layer or data lake two

Think of the enriched layer as a filtration layer. It removes impurities and can also involve enrichment.

Your standardization container holds systems of record and masters. Folders are segmented first by subject area, then by entity. Data is available in merged, partitioned tables that are optimized for analytics consumption.

### Standardized container

```markdown
.
|-Standardized
|--Log
|---{Application Name}
|--Master and Reference
|---{Source System}
|--Telemetry
|---{Source System}
|----{Application}
|--Transactional
|---{Source System}
|----{Entity}
|-----{Version}
|------General
|--------{date (ex. rundate=2019-08-22)}
|-------Sensitive
|--------{date (ex. rundate=2019-08-22)}
```

> [!NOTE]
> This data layer is considered the silver layer or read data source. Data within this layer has had no transformations applied other than data quality, delta lake conversion, and data type alignment.

The following diagram shows the flow of data lakes and containers from source data to a standardized container.

:::image type="content" source="../media/data-flow-high-level.png" alt-text="Diagram that shows a high level data flow." lightbox="../media/data-flow-high-level.png":::

## Curated layer or data lake two

Your curated layer is your consumption layer. It's optimized for analytics rather than data ingestion or processing. The curated layer might store data in denormalized data marts or star schemas.

Data from your standardized container is transformed into high-value data products that are served to your data consumers. This data has structure. It can be served to the consumers as-is, such as data science notebooks, or through another read data store, such as Azure SQL Database.

Use tools, like Spark or Data Factory, to do dimensional modeling instead of doing it inside your database engine. This use of tools becomes a key point if you want to make your lake the single source of truth.

If you do dimensional modeling outside of your lake, you might want to publish models back to your lake for consistency. This layer isn't a replacement for a data warehouse. Its performance typically isn't adequate for responsive dashboards or end user and consumer interactive analytics. This layer is best suited for internal analysts and data scientists who run large-scale, improvised queries or analysis, or for advanced analysts who don't have time-sensitive reporting needs. Because storage costs are lower in your data lake than your data warehouse, it can be cost effective to keep granular, low-level data in your lake. Store aggregated data in your warehouse. Generate these aggregations by using Spark or Azure Data Factory. Persist them to your data lake before loading them into your data warehouse.

Data assets in this zone are typically highly governed and well documented. Assign permissions by department or by function, and organize permissions by consumer group or data mart.

### Data products container

```markdown
.
|-{Data Product}
|---{Entity}
|----{Version}
|-----General
|-------{date (ex. rundate=2019-08-22)}
|------Sensitive
|-------{date (ex. rundate=2019-08-22)}
```

> [!TIP]
> When you land data in another read data store, like Azure SQL Database, ensure that you have a copy of that data located in your curated data. Your data product users are guided to your main read data store or Azure SQL Database instance, but they can also explore data with extra tools if you make the data available in your data lake.

## Development layer or data lake three

Your data consumers can bring other useful data products along with the data ingested into your standardized container.

In this scenario, your data platform can allocate an analytics sandbox area for these consumers. In the sandbox, they can generate valuable insights by using the curated data and data products that they bring. For example, if a data science team wants to determine the best product placement strategy for a new region, they can bring other data products, like customer demographics and usage data, from similar products in that region. The team can use the high-value sales insights from this data to analyze the product market fit and offering strategy.

> [!NOTE]
> The analytics sandbox area is a working area for an individual or a small group of collaborators. The sandbox area's folders have a special set of policies that prevent attempts to use this area as part of a production solution. These policies limit the total available storage and how long data can be stored.

These data products are usually of unknown quality and accuracy. They're still categorized as data products, but are temporary and only relevant to the user group that's using the data.

When these data products mature, your enterprise can promote these data products to your curated data layer. To keep your data product teams responsible for new data products, provide the teams with a dedicated folder on your curated data zone. They can store new results in the folder and share them with other teams across your organization.

> [!NOTE]
> For every Azure Synapse workspace you create, use data lake three to create a container to use as primary storage. This container stops Azure Synapse workspaces from interfering with your curated and enriched zones' throughput limits.

## Example of data flow into products and analytics sandbox

The following diagram compiles the information in this article and shows how data flows through to a data products and analytics sandbox.

:::image type="content" source="../media/data-flow-data-products.png" alt-text="Diagram showing a data flow into product container and analytics sandbox." lightbox="../media/data-flow-data-products.png":::

## Next steps

- [Key considerations for Azure Data Lake Storage](../../data-management/best-practices/data-lake-key-considerations.md)
