---
title: Azure Data Lake zones
description: This article describes the three Data Lakes accounts that should be provisioned for each Data Landing zone. 
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 07/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Lake zones

You should provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts for each [data landing zone](../architectures/data-landing-zone.md) in the "data lake services" resource group. As data passes through the different stages of transformation, it should be saved in one of the Data Landing Zone's three data lakes and available for the [data products](../architectures/data-landing-zone-data-products.md) in the lake which serves as the enriched and curated data layer. Data products would consume from the enriched and curated data layer only. These data lake accounts should be deployed into a single resource group.

## Overview

The three Data Lakes accounts should align to the typical layers within a data lake.

|Lake #|Layer|
|---|---|
| 1 | Raw Data|
| 2 | Enriched and Curated Data|
| 3 | Workspace Data|

There should be a single container per data lake zone. The exception to this recommendation would be be where immutable or different soft delete policies are required for the data held in the container. These requirements would drive additional containers.

The services should be enabled with the "Hierarchical Name Space" feature to allow efficient file management. [The hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace) allows the collection of objects/files within an account to be organized into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

>[!IMPORTANT]
>The Azure Blob Storage Account must have "hierarchical name space" enabled to allow the efficient file management.

Whilst the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for the Data Landing Zone. Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each lake account. For example you might want your RAW data to be geo-redundant whereas Workspace is used for data exploration and requires locally redundant disaster recovery.

Each **Data Integration** should have two folders on each data lake over which they should have ownership, following best practices for each data lake zone.

The two folders per **Data Integration** should be divided by classification (*confidential or below* and *sensitive (PII)*) with access controlled by ACLs.

>[!IMPORTANT]
>Access to the data is restricted by a combination of ACLs and AAD-groups. These control what can and cannot be accessed by other groups. **Integration Ops teams** should approve or reject access to their data assets.

## Data Lake Zones

With three data lake accounts in use, it is important to understand the context in which they should be used.

### Raw Data (Data Lake One)

Using the water based analogy, think of this layer as a reservoir which stores data in it's natural originating state — unfiltered and unpurified. You may choose to store it in original format (such as json or csv) but there may be scenarios where it makes more sense to store it as a column in compressed format such as avro, parquet or Databricks Delta Lake. 

This data is always immutable -it should be locked down and permissioned as read-only to any consumers (automated or human). The zone may be organised using a folder per source system, each ingestion processes having write access to only their associated folder.

As this layer usually stores the largest amount of data, consider using lifecycle management to reduce long term storage costs. ADLS gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules which run once a day and can be assigned to the account, filesystem or folder level. The feature is free although the operations will incur a cost.

Raw Data from source systems for each **Data Integration** will land into either the General folder, for *confidential or below*, or *sensitive (PII)* folder for each **Data Integration** on Data Lake One.

### RAW Directory Layout

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

For streaming use cases, the data in the raw zone should sometimes also be stored as an aggregated dataset. For example, data is ingested via a message bus such as Azure Event Hub and then aggregated via a real-time processing engine such as Azure Stream Analytics or Spark Streaming before it is stored in the data lake.

Depending on the retention policies of your enterprise, this data is either stored as-is for the period required by the retention policy, or it can be deleted when you think the data is of no more use (*e.g.* raw sales data that is ingested from on-premises systems).

>[!TIP]
>Enterprises need to think about scenarios where they might need to rebuild an analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream Read Data Stores.

### Enriched Data (Data Lake Two)

Enriched data is the version where raw data (as-is or aggregated) has a defined schema, has been cleansed, and is available to analytics engines to extract high-value data. It will follow the same hierarchial directory structure as the raw layer and resides in either the *confidential or below* or *sensitive (PII)* folder for **Data Integration** on Data Lake Two.

#### Enriched Directory Layout

```markdown
Enriched Directory Layout
.
|-Data Integration
|-Data Integration
|--Transactional
|---Confidential
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

>[!NOTE]
>This layer of data can be consider the golden layer and shouldn't have had any other transformations applied apart from aligning data types.

### Curated Data (Data Lake Two)

Data is taken from the golden layer, in Enriched Data, and transformed into high-value **Data Products** that is served to the consumers of the data (BI analysts and the data scientists). This data has structure and can be served to the consumers either as-is (*e.g.* data science notebooks) or through another read data store such as Azure Database for SQL.

#### Curated Directory Layout

```markdown
.
|-Data Product
|-Data Product
|--Transactional
|---Confidential
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

>[!TIP]
>In the case where a decision is made to land the data into another read data store such as Azure Database for SQL, as a high speed serving layer, we would recommend having a copy of the data residing in the curated data. Although users of the **data product** will be guided to the main read data store (Azure Database for SQL), it will allow them to do further data exploration in a wider set of tools if the data is also available in the data lake.

Data assets in this layer should be highly governed and well documented. For example, high-quality sales data might be data in the enriched data zone correlated with other demand forecasting signals such as social media trending patterns for a **Data Integration** that is used for predictive analytics on determining the sales projections for the next fiscal year.

### Workspace Data (Data Lake Three)

In addition to the data that is ingested by the **Data Integration** team from the source, the consumers of the data can also choose to bring other useful datasets.

In this case, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other datasets they bring to generate valuable insights. For example, if a Data Science team is trying to determine the product placement strategy for a new region, they could bring other datasets such as customer demographics and usage data of similar products from that region. These high-value sales insights data could be used to analyze the product market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They are still categorized as a **data product** but are temporary and only relevant to the user group using the data.

Sometimes these datasets mature, and the enterprise should consider how they promote these **Data Products** from the Workspace to the Curated Data Layer. In order to keep Data Product teams responsible for new Data Products, it is recommended to provide these teams a dedicated folder on the Curated Data Layer in which they can then then store the new results and share them with other teams across the organization.

## Data Lake Partitioning

sss

## Lifecycle Management

Azure storage offers different access tiers, which allow you to store blob object data in the most cost-effective manner. The available access tiers include:

* **Hot** - Optimized for storing data that is accessed frequently.
* **Cool** - Optimized for storing data that is infrequently accessed and stored for at least 30 days.
* **Archive** - Optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements (on the order of hours).

The following considerations apply to the different access tiers:

* Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
* Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
* Data in the cool access tier can tolerate slightly lower availability but still requires high durability, retrieval latency, and throughput characteristics similar to hot data. For cool data, a slightly lower availability service-level agreement (SLA) and *higher access costs* compared to hot data are acceptable trade-offs for lower storage costs.
* Archive storage stores data offline and offers the lowest storage costs but also the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential pace. To manage costs for your expanding storage needs, it's helpful to organize your data based on attributes like frequency-of-access and planned retention period to optimize costs. Data stored in the cloud can be different based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

Each of these data access scenarios benefits from a different access tier that is optimized for a particular access pattern. With hot, cool, and archive access tiers, Azure Blob Storage addresses this need for differentiated access tiers with separate pricing models.

The Enterprise Analytics and AI construction set prescribes that you should implement a tiering policy for all three Azure Data Lake accounts.

## Key Considerations

When landing data into a data lake, it is important to pre-plan the structure of the data so that security, partitioning, and processing can be utilized effectively. Many of the following recommendations are applicable for all big data workloads. Every workload has different requirements on how the data is consumed, therefore the list below general recommendation. Please work with your system integrator on the right level of AD groups for your implementation of this construction set.



### Write data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Data Integration(s) | Data Integration(s) | Data Products(s) | Data Products, Data Scientists and BI Analysts|

### Read data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
| Data Integration | Data Integration and read access for others based on approval of Data Integration owner | Data Products, Analysts, Data Scientists, and Users | Data Scientists and Analysts|

### Folder Structure and Hierarchy

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Folder structure to mirror sensitivity followed by source. | Folder structure to mirror data integration followed by data asset | Folder structure mirrors data product structure |Folder structures mirror teams that the workspace is used by.|

>[!WARNING]
>Because some products do not support mounting the root of a data lake container, each data lake container in Raw, Curated and Enriched, and Workspace should have a single folder before branching off to multiple folders. The folder permissions should be carefully set up as during the creation of a new folder, from the root, the default ACL on the parent directory determines a child directory's default ACL and access ACL; a child file's access ACL (files do not have a default ACL). See [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## What data format do I choose?

Data may arrive to your data lake account in a variety of formats – human readable formats such as JSON, CSV or XML files, compressed binary formats such as .tar.gz and a variety of sizes – huge files (a few TBs) such as an export of a SQL table from your on-premise systems or a large number of tiny files (a few KBs) such as real-time events from your IoT solution. While ADLS Gen2 supports storing all kinds of data without imposing any restrictions, it is better to think about data formats to maximize efficiency of your processing pipelines and optimize costs – you can achieve both of these by picking the right format and the right file sizes.
Hadoop has a set of file formats it supports for optimized storage and processing of structured data. Let us look at some common file formats – [Avro](https://avro.apache.org/docs/current/), [Parquet](https://parquet.apache.org/documentation/latest/) and [ORC](https://orc.apache.org/docs/). All of these are machine-readable binary file formats, offer compression to manage the file size and are self-describing in nature with a schema embedded in the file. The difference between the formats is in how data is stored – Avro stores data in a row-based format and Parquet and ORC formats store data in a columnar format.

### Key considerations

* Avro file format is favored where the I/O patterns are more write heavy or the query patterns favor retrieving multiple rows of records in their entirety. E.g. Avro format is favored by message bus such as Event Hub or Kafka writes multiple events/messages in succession.
* Parquet and ORC file formats are favored when the I/O patterns are more read heavy and/or when the query patterns are focused on a subset of columns in the records – where the read transactions can be optimized to retrieve specific columns instead of reading the entire record.
