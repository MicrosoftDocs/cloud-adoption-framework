---
title: Azure enterprise-scale for analytics and AI teams data lake services zones
description: Enterprise-scale for analytics and AI architecture data lake services zones
author: mboswell
ms.author: 'mboswell # Microsoft employees only'
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data lake landing zones

When landing zone data into a data lake, it's important to pre-plan the structure of the data so that security, partitioning, and processing can be used effectively. As outlined in the [three data lakes](best-practices/data-lake-overview.md#the-three-data-lakes) we have three data lakes as a starting point for enterprise-scale for analytics and AI.

## Overview

The three data lakes accounts should align to the typical zones within a data lake.

|Lake #|Zone| Container |
|---|---| -- |
| 1 | Raw | Container 1 |
| 2 | Enriched| Container 1 |
| 2 | Curated | Container 2 |
| 3 | Workspace | Container 1 |

There should be a single container per data lake zone. The exception to this recommendation would be where immutable or different soft delete policies are required for the data held in the container. These requirements would drive additional containers.

The services should be enabled with the "hierarchical name Space" feature to allow efficient file management. The [hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace) allows the collection of objects/files within an account to be organized into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

> [!IMPORTANT]
> The Azure Blob Storage account must have "hierarchical name space" enabled to allow the efficient file management.

Whilst the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for the data landing zone.

Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each lake account. For example you might want your raw data to be geo-redundant whereas workspace is used for data exploration and requires locally redundant disaster recovery.

Each **Data Integration** or **Data Product** should have two folders on each data lake zone over which they should have ownership, following best practices for each data lake zone.

The two folders per **Data Integration** or **Data Product** should be divided by classification. This leads to a general folder, for *confidential or below*, and a *sensitive (PII)* folder with access controlled by ACLs. By having these two folders below the **Data Integration** or **Data Product** you can choose to create a dataset with all the PII data removed, located in the general folder, and then have another dataset with all PII data, in the *sensitive (PII)* folder.

Access to the data is restricted by a combination of ACLs and Azure AD-groups. These control what can and cannot be accessed by other groups. **Integration Ops teams** and **Data Product teams** should approve or reject access to their data assets.

> [!NOTE]
> For handling restricted data see [Restricted data](secure-data-privacy.md#restricted-data).

## Raw zone (data lake one)

Using the water-based analogy, think of this layer as a reservoir which stores data in it's natural originating state - unfiltered and unpurified. You may choose to store it in original format (such as json or CSV) but there may be scenarios where it makes more sense to store it as a column in compressed format such as avro, Parquet or Databricks delta lake.

This data is always immutable -it should be locked down and permissioned as read-only to any consumers (automated or human). The zone may be organized using a folder per source system, each ingestion processes having write access to only their associated folder.

As this layer usually stores the largest amount of data, consider using lifecycle management to reduce long term storage costs. Adls Gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules which run once a day and can be assigned to the account, filesystem or folder level. The feature is free although the operations will incur a cost.

Raw data from source systems for each **Data Integration** (also known as source) will land into either the general folder, for *confidential or below*, or *sensitive (PII)* folder for each **Data Integration** on data lake one. Each ingestion processes should have write access to only their associated folder.

### Raw directory layout

```markdown
.
|-General
|--Source
|--Source
|---Entity
|---LoadTS=YYMMDDHHMSS
|       file001.parquet
|       file001.parquet
|-Sensitive
|--Source
|---Entity
|---LoadTS=YYMMDDHHMSS
|       file001.parquet
|       file001.parquet
```

This data is stored as-is in the data lake and is consumed by an analytics engine such as Spark to perform cleansing and enrichment operations to generate the curated data.

For batch or micro-batch patterns, the data should be copied from the source system and landed as-is in the data lake without any transformations.

For streaming use cases, the data in the raw zone should sometimes also be stored as an aggregated dataset. For example, data is ingested via a message bus such as Azure event hub and then aggregated via a real-time processing engine such as Azure Stream Analytics or Spark streaming before it's stored in the data lake.

As this layer usually stores the largest amount of data, consider using lifecycle management to reduce long term storage costs. At the time of writing adls Gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules which run once a day and can be assigned to the account, filesystem or folder level.

> [!TIP]
> Enterprises need to think about scenarios where they might need to rebuild an analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream read data stores.

## Enriched zone (data lake two)

The next layer can be thought of as a filtration zone which removes impurities but may also involve enrichment.

Typical activities found in this layer are schema and data type definition, removing of unnecessary columns, and application of cleaning rules whether it be validation, standardization, harmonization. Enrichment processes may also combine data sets to further improve the value of insights.

The organization of this zone is usually more business-driven rather than by source system - typically this could be a folder per department or project. Some may also consider this as a staging zone which is normally permissioned by the automated jobs which run against it. Should data analysts or scientists need access to the data in this form, they could be granted read-only access only.

It will follow the same hierarchical directory structure as the raw zone and resides in either the general folder, for *confidential or below*, or *sensitive (PII)* folder for each **Data Integration** * folder on data lake two.

### Enriched directory layout

```markdown
Enriched Directory Layout
.
|-Data Integration
|-Data Integration
|--Transactional
|---General
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|        file001.parquet
|        file001.parquet
|---Sensitive (PII)
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Dataset
```

> [!NOTE]
> This layer of data can be consider the golden layer and shouldn't have had any other transformations applied apart from aligning data types.

## Curated zone (data lake two)

This is the consumption layer, which is optimized for analytics rather than data ingestion or data processing. It may store data in denormalized data marts or star schemas.

Data is taken from the golden layer, in enriched data, and transformed into high-value **Data Products** that is served to the consumers of the data (BI analysts and the data scientists). This data has structure and can be served to the consumers either as-is (*e.g.* Data science notebooks) or through another read data store such as Azure database for SQL.

The dimensional modeling is preferably done using tools like Spark or Data Factory rather than inside the database engine. Should you wish to make the lake the single source of truth then this becomes a key point.

If the dimensional modeling is done outside of the lake I.e. In the data warehouse then you may wish to publish the model back to the lake for consistency. Either way, a word of caution though; don't expect this layer to be a replacement for a data warehouse. Typically the performance is not adequate for responsive dashboards or end-user/consumer interactive analytics. It's best suited for internal analysts or data scientists who want run large-scale ad hoc queries, analysis or advanced analytics who do not have strict time-sensitive reporting needs. As storage costs are generally lower in the lake compared to the data warehouse, it may be more cost effective to keep granular, low level data in the lake and store only aggregated data in the warehouse. These aggregations can be generated by Spark or Data Factory and persisted to the lake prior to loading the data warehouse.

Data assets in this zone are typically highly governed and well documented. Permission is usually assigned by department or function and organized by consumer group or by data mart.

### Curated directory layout

```markdown
.
|-Data Product
|-Data Product
|--Transactional
|---General
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|        file001.parquet
|        file001.parquet
|---Sensitive(PII)
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Dataset
```

> [!TIP]
> In the case where a decision is made to land the data into another read data store such as Azure database for SQL, as a high speed serving layer, we would recommend having a copy of the data residing in the curated data. Although users of the **data product** will be guided to the main read data store (Azure database for SQL), it will allow them to do further data exploration in a wider set of tools if the data is also available in the data lake.

Data assets in this zone should be highly governed and well documented. For example, high-quality sales data might be data in the enriched data zone correlated with other demand forecasting signals such as social media trending patterns for a **Data Integration** that is used for predictive analytics on determining the sales projections for the next fiscal year.

## Workspace zone (data lake three)

In addition to the data that is ingested by the **Data Integration** team from the source, the consumers of the data can also choose to bring other useful datasets.

In this case, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other datasets they bring to generate valuable insights. For example, if a data science team is trying to determine the product placement strategy for a new region, they could bring other datasets such as customer demographics and usage data of similar products from that region. These high-value sales insights data could be used to analyze the product market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They are still categorized as a **Data Product** but are temporary and only relevant to the user group using the data.

Sometimes these datasets mature, and the enterprise should consider how they promote these **Data Products** from the workspace to the curated data zone. In order to keep data product teams responsible for new data products, it's recommended to provide these teams a dedicated folder on the curated data zone in which they can then store the new results and share them with other teams across the organization.

> [!NOTE]
> For every synapse workspace, which is created, we prescribe that data lake three is used to create a container which can be used as the primary storage. This is to stop synapse workspaces interfering with the curated and enriched zones throughput limits.

## Data lake partitioning

Data partitioning is the process of organizing data in the data store so that large-scale data can be managed, and data access can be controlled. In addition, partitioning can improve scalability, reduce contention, and optimize performance. This section describes guideline and strategy for partitioning data in the Data Lake Storage.

When partitioning the data lake, the main drivers are to have a data lake setup that must support the followings:

- Do not compromise security
- Clear isolation and align with data authorization model
- Fit well with data ingestion process
- Has well-defined path for optimal data access
- Support management and maintenance tasks

### General practices

Below are general practices for data partitioning design.

- Focus on security implication early and design data partition together with authorization
- Data redundancy may be allowed in exchange for security.
- Multiple nesting of folders is acceptable but ensure to keep it consistent
- Do not combine mixed file formats or different datasets in a single folder structure
- Do not start the folder structure with date partitions. It's better to keep dates at the lower folder level.
- Define a naming convention and adhere to it
- Include time element in both the folder structure and file name

> [!TIP]
> Folder structures should have partitioning strategies which can optimize access patterns and appropriate file sizes. Particularly in the curated zones, plan the structure based on optimal retrieval but be cautious of choosing a partition key with high cardinality which leads to over partitioning which in turn leads to suboptimal file sizes.

## Alignment of personas to write and reading of data

:::image type="content" source=`images/data-lake-zones.png` alt-text="Example Data Lake Zones" lightbox=`images/data-lake-zones.png`:::

Figure 1, visualizes the end-to-end flow of data, the personas involved, the tools and concepts.

### Write data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Data integration(s) | Data integration(s) | Data products(s) | Data products, data scientists and BI analysts|

### Read data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
| Data integration | Data integration and read access for others based on approval of data integration owner | Data products, analysts, data scientists, and users | Data scientists and analysts|

> [!WARNING]
> Because some products do not support mounting the root of a data lake container, each data lake container in raw, curated and enriched, and workspace should have a single folder before branching off to multiple folders. The folder permissions should be carefully set up as during the creation of a new folder, from the root, the default ACL on the parent directory determines a child directory's default ACL and access ACL; a child file's access ACL (files do not have a default ACL). For more information, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## What data format and file size do I choose?

### File format

Data may arrive to your data lake account in a variety of formats - human readable formats such as JSON, CSV or XML files, compressed binary formats such as .tar.gz and a variety of sizes - huge files (a few tbs) such as an export of a SQL table from your on-premises systems or a large number of tiny files (a few kbs) such as real-time events from your IoT solution. While adls Gen2 supports storing all kinds of data without imposing any restrictions, it's better to think about data formats to maximize efficiency of your processing pipelines and optimize costs - you can achieve both of these by picking the right format and the right file sizes. Hadoop has a set of file formats it supports for optimized storage and processing of structured data. Let us look at some common file formats - [avro](https://avro.apache.org/docs/current/), [Parquet](https://parquet.apache.org/documentation/latest/) and [orc](https://orc.apache.org/docs/). All of these are machine-readable binary file formats, offer compression to manage the file size and are self-describing in nature with a schema embedded in the file. The difference between the formats is in how data is stored - avro stores data in a row-based format and Parquet and orc formats store data in a columnar format.

- Avro file format is favored where the I/O patterns are more write heavy or the query patterns favor retrieving multiple rows of records in their entirety. Such as. Avro format is favored by message bus such as event hub or Kafka writes multiple events/messages in succession.
- **Parquet and orc file formats are favored when the I/O patterns are more read heavy or when the query patterns are focused on a subset of columns in the records:** Where the read transactions can be optimized to retrieve specific columns instead of reading the entire record.

### File size

Lots of small files (kbs) generally lead to suboptimal performance and potentially higher costs due to increased read/list operations. Azure Data Lake Storage Gen2 is optimized to perform better on larger files. Analytics jobs will run faster and at a lower cost.

Costs are reduced due to the shorter compute (Spark or Data Factory) times but also due to optimal read operations. For example, files greater than 4 MB in size incur a lower price for every 4 MB block of data read beyond the first 4 MB. For example, to read a single file that is 16 MB is cheaper than reading 4 files that are 4 MB each.

When processing data with Spark the typical guidance is around 64 MB - 1 GB per file. It's well known in the Spark community that thousands of small files (KB in size) are a performance nightmare. In the raw zone this can be a challenge, particularly for streaming data which will typically have smaller files/messages at high velocity. Files will need to be regularly compacted/consolidated. For those using Delta format then OPTIMIZE or AUTO OPTIMIZE can help.
