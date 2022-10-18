---
title: Data lake zones and containers
description: Learn about the three Azure Data Lake Storage Gen2 accounts that should be provisioned for each data landing zone.
author: mboswell
ms.author: mboswell
ms.date: 04/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data lake zones and containers

It's important to plan your data structure before you land it into a data lake. Having a plan helps you use security, partitioning, and processing effectively. 

[Overview of Azure Data Lake Storage for cloud-scale analytics](../../data-management/best-practices/data-lake-overview.md) outlines a starting point for data lakes.

## Overview

Your three data lake accounts should align to the typical data lake layers.

| Lake number | Layers        | Container No | Container Name    |
|-------------|-------------|--------------|-------------------|
| 1           | Raw         | 1            | Landing           |
| 1           | Raw         | 2            | Conformance       |
| 2           | Enriched    | 1            | Standardized      |
| 2           | Curated     | 2            | Data Products     |
| 3           | Development | 1            | Analytics Sandbox |
| 3           | Development | #           | Synapse Primary Storage #  |

In the previous table, you can find the standard number of containers we recommend per data landing zone. The exception to this recommendation is if different soft delete policies are required for the data in a container. These requirements determine your need for more containers.

> [!NOTE]
> Three data lakes are illustrated in each data landing zone. While the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for your data landing zone.
>
> Depending on your requirements, you might want to consolidate raw, enriched and curated layers into one storage account, and keep another storage account named "development" for data consumers to bring other useful data products.
>
>For more information on separating data lake accounts, see [Storage accounts in a logical data lake](../../data-management/best-practices/data-lake-overview.md#storage-accounts-in-a-logical-data-lake).

Azure storage should be enabled with the [hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace), which allows you to efficiently manage files. The hierarchical name space feature helps you organize objects and files within an account into a hierarchy of directories and nested subdirectories. This hierarchy is organized the same way as the file system on your computer.

When your data agnostic ingestion engine or onboarding application registers a new system of record, it creates required folders in containers in the raw, enriched, and standardized data layers. If a data application (source-aligned) is ingesting the data, your data application team needs your data landing zone team to create the folders and security groups. Put a service principle name or managed identity into the correct group, then assign a permission level. Document this process for your data landing zone and data application teams.

For more information on teams, see [Understand roles and teams for cloud-scale analytics in Azure](../organize-roles-teams.md).

Each data product should have two folders in the data products container, which your data product team should own.

In a standardized container's enriched layer, there are two folders per source system, divided by classification. This allows your team to store data with different security and data classifications separately and assign them different security access.

Your standardized container needs a general folder for *confidential or below* data and a *sensitive* folder for personal data. Control access to these folders using access control lists (ACLs). You can create a dataset with all personal data removed and store it in your general folder. You can then have another dataset that includes all personal data in your *sensitive* personal data folder.

A combination of access control lists (ACLs) and Azure Active Directory (Azure AD) groups restrict data access. These lists and groups control what other groups can and can't access. Data owners and data application teams can approve or reject access to their data assets.

For more information, see [Data access management](../../data-management/security-provisioning.md) and [Restricted data](../../data-management/secure-data-privacy.md#restricted-data).

> [!WARNING]
> Some software products do not support mounting the root of a data lake container. Because of this, each data lake container in raw, curated, enriched, and development layers should contain a single folder that then branches off to multiple folders. Set up your folder permissions carefully. When a new folder is created from the root, the default access control list (ACL) on the parent directory determines a child directory's default access control list (ACL) and access ACL. A child file's access control list (ACL) does not have a default ACL.
>
>For more information, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## Raw layer or data lake one

Think of the raw layer as a reservoir that stores data in its natural and original state. It's unfiltered and unpurified. You might choose to store the data in its original format, such as JSON or CSV, but you might also encounter scenarios where it's more cost effective to store the file contents as a column in a compressed file format like Avro, Parquet, or Databricks Delta Lake.

This raw data is always immutable. You should keep your raw data locked down, and if you give permissions to any consumers, automated or human, you should ensure they're read-only. You can organize this layer using one folder per source system. Give each ingestion process write access to only its associated folder.

When you load data from source systems into the raw zone, you can choose to do either:

- **Full loads**, where you extract a full data set
- **Delta loads**, where you load only changed data

Indicate your chosen loading pattern in your folder structure. This simplifies use for your data consumers.

Raw data from source systems for each data application (source-aligned) or automated ingestion engine source lands in either the full or delta folder. Each ingestion process should have write access to only its associated folder.

We define full loads and delta loads as:

- Full load:
  - Complete data from source can be onboarded in the following scenarios.
    - Data volume at source is small.
    - The source system doesn't maintain any timestamp field that identifies if data has been added, updated or deleted.
    - The source system overwrites the complete data each time.

- Delta load:
  - Incremental data from source can be onboarded in the following scenarios.
    - Data volume at source is large.
    - The source system maintains a timestamp field that identifies if data has been added/updated or deleted
    - The source system creates and updates files on data changes.

Your raw data lake is composed of your landing and conformance containers, each using a 100% mandatory folder structure specific to its purpose.

### Landing container layout

Your landing container is reserved for raw data from a recognized source system, loaded by your data agnostic ingestion engine or a data application (source-aligned), unaltered and in its original supported format.

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

### Raw Layer conformance container

Your raw layer contains data quality conformed data. As data is copied to a landing container, data processing and compute should be triggered to copy the data from the landing container to the conformance container. In this first stage, data gets converted into the delta lake format and lands in an input folder. When data quality is run, all records that pass get copied into the output folder. Any records that fail land in an error folder.

As part of this first stage data is converted into the delta lake format and land in to input folder. Data quality is run and those records that pass are copied into the output folder. Failed records land into the error folder.

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
> Think about scenarios where you might need to rebuild an analytics platform from scratch, and always consider the most granular data you'd need to rebuild downstream read data stores. Make sure you have a [business continuity and disaster recovery](../../data-management/eslz-business-continuity-and-disaster-recovery.md) plan in place for your key components.

## Enriched layer or data lake two

Think of the enriched layer as a filtration layer. It removes impurities and can also involve enrichment.

Your standardization container holds systems of record and masters. Folders are segmented first by subject area, then by entity. Data is available in merged, partitioned tables optimized for analytics consumption.

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
> This data layer is considered the silver layer or read data source. Data within it has had no transformations applied other than data quality, delta lake conversion, and data type alignment.

The following diagram shows the flow of data lakes and containers from source data to a standardized container.

:::image type="content" source="../media/data-flow-high-level.png" alt-text="High level data flow" lightbox="../media/data-flow-high-level.png":::

## Curated layer or data lake two

Your curated layer is your consumption layer. It's optimized for analytics, rather than data ingestion or processing. The curated layer might store data in de-normalized data marts or star schemas.

Data is taken from your standardized container and transformed into high-value data products that are served to your data consumers. This data has structure, and can be served to the consumers either as-is (such as data science notebooks) or through another read data store (such as Azure SQL Database).

Use tools like Spark or Data Factory to do dimensional modeling instead of doing it inside your database engine. This use of tools becomes a key point if you want to make your lake the single source of truth.

If you do dimensional modeling outside of your lake, you might want to publish models back to your lake for consistency. Don't view this layer as a replacement for a data warehouse. Its performance typically isn't adequate for responsive dashboards or end-user and consumer interactive analytics. This layer is best suited for internal analysts and data scientists who run large-scale improvised queries, analysis, or for advanced analysts who don't have strict time-sensitive reporting needs. Since storage costs are lower in your data lake than your data warehouse, it can be more cost effective to keep granular, low-level data in your lake and store only aggregated data in your warehouse. You can generate these aggregations using Spark or Azure Data Factory, and persist them to your data lake before loading them into your data warehouse. 

Data assets in this zone are typically highly governed and well-documented. Assign permissions by department or function and organize permissions by consumer group or data mart.

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
> When you land data in another read data store like Azure SQL Database, ensure you have a copy of that data located in your curated data. Although users of your data product are guided to your main read data store or Azure SQL Database instance, they can also do further data exploration with extra tools if you make the data also available in your data lake.

## Development layer or data lake three

Your data consumers can bring other useful data products along with the data ingested into your standardized container.

In this scenario, your data platform should allocate an analytics sandbox area for these consumers. There, they can generate valuable insights using the curated data and data products they bring. For example, if a data science team wants to determine the best product placement strategy for a new region, they can bring other data products like customer demographics and usage data from similar products from that region. They team can use the high-value sales insights from this data to analyze the product market fit and offering strategy.

> [!NOTE]
> The analytics sandbox area is intended to be a working area for an individual or a small group of collaborators. The sandbox area's folders have a special set of policies that prevent attempts to use this area as part of a production solution. These policies can include limits on total available storage and limits on how long data can be stored.

These data products are usually of unknown quality and accuracy. They're still categorized as data products, but are temporary and only relevant to the user group using the data.

Sometimes these data products mature, and your enterprise should consider how to promote these data products to your curated data layer. To keep your data product teams responsible for new data products, provide the teams with a dedicated folder on your curated data zone. They can store new results in it and share them with other teams across your organization.

> [!NOTE]
> For every Azure Synapse workspace you create, use data lake three to create a container you can use as primary storage. This stops Azure Synapse workspaces from interfering with your curated and enriched zones' throughput limits.

## Example of data flow into products and analytics sandbox

The following diagram joins this article's sections together and shows how data flows through to a data products and analytic sandbox.

:::image type="content" source="../media/data-flow-data-products.png" alt-text="Data flow into product container and analytics sandbox" lightbox="../media/data-flow-data-products.png":::

## Next steps

- [Key considerations for Azure Data Lake Storage](../../data-management/best-practices/data-lake-key-considerations.md)
