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

You should provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts for each [data landing zone](../architectures/data-landing-zone.md) in the `data lake services` resource group. As data passes through the stages of transformation, it should be saved in one of the data landing zone's three data lakes and available for the [data products](../architectures/data-landing-zone-data-products.md) in the lake, which serves as the enriched and curated data layer. Data products will consume from the enriched and curated data layer only. You should deploy these Data Lake accounts into a single resource group.

## Overview

The three Data Lakes accounts should align to the typical layers in a data lake:

|Lake number |Layer|
|---|---|
| 1 | Raw data|
| 2 | Enriched and curated data|
| 3 | Workspace data|

There should be a single container per Data Lake zone. There are  exceptions to this recommendation: when immutable or soft delete policies are required for the data held in the container. These requirements would indicate a need for more containers.

To allow efficient file management, you should enable hierarchical namespace on services. [Hierarchical namespace](/azure/storage/blobs/data-lake-storage-namespace) allows the collection of objects and files in an account to be organized into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

>[!IMPORTANT]
>To allow efficient file management, you need to enable hierarchical namespace on the Azure Blob Storage account.

Although the data lake spans three data lake accounts and multiple containers and folders, it represents one logical data lake for the data landing zone. Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each account. For example, you might want your raw data to be geo-redundant but use the workspace layer for data exploration that requires locally redundant disaster recovery.

Each data integration should have two folders on each data lake over which they have ownership. Follow best practices for each data lake zone. 

Divide these two folders by classification: *confidential or below* and *sensitive (PII)*. Use ACLs to control access.

>[!IMPORTANT]
>Use a combination of ACLs and Azure Active Directory groups to restrict access to the data. These tools control what can be accessed by other groups. Integration ops teams should approve or reject access to their data assets.

## Data Lake zones

It's important to understand the context in which you should use the three Data Lake accounts.

### Raw data (Data Lake One)

We'll use an analogy in which we compare data to water. Think of this layer as a reservoir that stores data in it's natural state, unfiltered and unpurified. You might choose to store it in original format (like JSON or CSV) but it might make more sense to store it as a column in a compressed format like Avro, Parquet, or Azure Databricks Delta Lake. 

This data is always immutable. You should lock it down and make it read-only to automated and human consumers. You can organize the zone by using one folder per source system, which each ingestion process having write access to only the associated folder.

Because this layer usually stores the most data, consider using lifecycle management to reduce long-term storage costs. Azure Data Lake Storage Gen2 supports moving data to the cool-access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules that run once a day and can be assigned at the account, file system, or folder level. This feature is free, although the operations will incur a cost.

Raw data from source systems for each data integration will land into either the General folder, for *confidential or below*, or the *sensitive (PII)* folder for each data integration on Data Lake One.

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

This data is stored as-is in the data lake and is consumed by an analytics engine like Spark, which cleanses and enriches the data to generate the curated data.

For batch or micro-batch patterns, you should copy the data from the source system and move it as-is to the data lake without any transformations.

For streaming use cases, you should sometimes also store the data in the raw zone as an aggregated dataset. For example, you could ingest data via a message bus like Azure Event Hubs and then aggregate it via a real-time processing engine like Azure Stream Analytics or Spark Streaming before storing it in the data lake.

Depending on your company's retention policies, this data might be stored as-is for the period required by the retention policy. Or it might be deleted when you think it's no longer useful. (For example, raw sales data that's ingested from on-premises systems.)

>[!TIP]
>You need to think about scenarios in which you might need to rebuild an analytics platform from scratch. You should always consider the most granular data you'd need to rebuild downstream read data stores.

### Enriched data (Data Lake Two)

Enriched data (as-is or aggregated) has a defined schema, is cleansed, and is available to analytics engines for extraction of high-value data. It has the same hierarchial directory structure as the raw layer. It resides in either the *confidential or below* or *sensitive (PII)* folder for data integration on Data Lake Two.

#### Enriched directory layout

```markdown
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
>You can consider this layer of data the golden layer. It shouldn't have had any other transformations applied, apart from aligning data types.

### Curated data (Data Lake Two)

You take data from the golden layer, in the enriched data layer, and transform it into high-value data products that are served to consumers of the data (BI analysts and data scientists). This data has structure and can be served to consumers either as-is (for example, data science notebooks) or through another read data store, like Azure SQL Database.

#### Curated directory layout

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
>If you decide to move the data into another read data store like Azure SQL Database, as a high-speed serving layer, we recommend that you have a copy of the data located in the curated data. Users of the data product will be guided to the main read data store (Azure SQL Database). But they'll be able to do further data exploration by using a wider set of tools if the data is also available in the data lake.

Data assets in this layer should be highly governed and well documented. For example, high-quality sales data might be data in the enriched data zone that's correlated with other demand-forecasting signals like social media trending patterns. This data integration could be used for predictive analytics to determine the sales projections for the next fiscal year.

### Workspace data (Data Lake Three)

In addition to data that's ingested by the data integration team from the source, consumers of the data can also choose to incorporate other useful datasets.

In this case, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other datasets they bring. For example, if a data science team is trying to determine the product placement strategy for a new region, the team could use other datasets, like customer demographics and usage data for similar products from the region. This data could be used to analyze the product-market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They're still categorized as a data products but are temporary and only relevant to the group that's using the data.

Sometimes these datasets mature, and the enterprise should consider how to promote these data products from the workspace layer to the curated data layer. To keep data product teams responsible for new data products, we recommend that you provide these teams a dedicated folder on the curated data layer. They can use this folder to store the new results and share them with other teams across the organization.

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
