---
title: Azure Data Lake landing zones
description: This article describes the three data lake accounts that should be provisioned for each data landing zone. 
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 07/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---


# Data lake landing zones

You should provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts for each [data landing zone](../architectures/data-landing-zone.md) in the `data lake services` resource group. As data passes through the stages of transformation, it should be saved in one of the data landing zone's three data lakes and available for the [data products](../architectures/data-landing-zone-data-products.md) in the lake that serves as the enriched and curated data layer. Data products will consume from the enriched and curated data layer only. Deploy these data lake accounts into a single resource group.

## Overview

The three data lake accounts should align to the typical layers in a data lake:

|Lake number|Layer|
|---|---|
| 1 | Raw data|
| 2 | Enriched and curated data|
| 3 | Workspace data|

There should be a single container per data lake zone. There are  exceptions to this recommendation: when immutable or soft delete policies are required for the data held in the container. These requirements would indicate a need for more containers.

To allow efficient file management, you should enable hierarchical namespace on services. [Hierarchical namespace](/azure/storage/blobs/data-lake-storage-namespace) allows you to organize the collection of objects and files in an account into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

>[!IMPORTANT]
>To allow efficient file management, you need to enable hierarchical namespace on the Azure Blob Storage account.

The data lake spans three data lake accounts, and multiple containers and folders, but it represents one logical data lake for the data landing zone. Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each account. For example, you might want your raw data to be geo-redundant but use the workspace layer for data exploration that requires locally redundant disaster recovery.

Each data integration should have two folders on each data lake over which they have ownership. Follow best practices for each data lake zone. 

Divide these two folders by classification: *confidential or below* and *sensitive (personal data)*. Use ACLs to control access.

>[!IMPORTANT]
>Use a combination of ACLs and Azure Active Directory groups to restrict access to the data. These tools control what can be accessed by other groups. Integration ops teams should approve or reject access to their data assets.

## Data lake zones

It's important to understand the context in which you should use the three Data Lake accounts.

### Raw data (data lake one)

We'll use an analogy in which we compare data to water. Think of this layer as a reservoir that stores data in its natural state, unfiltered and unpurified. You might choose to store it in its original format, like JSON or CSV. But it might make more sense to store it as a column in a compressed format like Avro, Parquet, or Azure Databricks Delta Lake. 

This data is always immutable. Lock it down and make it read-only to automated and human consumers. You can organize the zone by using one folder per source system, with each ingestion process having write access to only the associated folder.

Because this layer usually stores the most data, consider using lifecycle management to reduce long-term storage costs. Azure Data Lake Storage Gen2 supports moving data to the cool-access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules that run once a day and can be assigned at the account, file system, or folder level. This feature is free, although the operations will incur a cost.

Raw data from source systems for each data integration will land into one of these folders:

- The General folder, for *confidential or below* 
- The *sensitive (personal data)* folder for each data integration on data lake one

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

This data is stored as-is in the data lake. It's consumed by an analytics engine like Spark, which cleanses and enriches the data to generate the curated data.

For batch or micro-batch patterns, you should copy the data from the source system and move it as-is to the data lake without any transformations.

For streaming use cases, you should sometimes also store the data in the raw zone as an aggregated dataset. For example, you could ingest data via a message bus like Azure Event Hubs and then aggregate it via a real-time processing engine like Azure Stream Analytics or Spark Streaming before storing it in the data lake.

Depending on your company's retention policies, this data can be stored as-is for the period required by the retention policy. Or it can be deleted when you think it's no longer useful. (For example, sales data that's ingested from on-premises systems.)

>[!TIP]
>You need to think about scenarios in which you might need to rebuild an analytics platform from scratch. You should consider the most granular data you'd need to rebuild downstream read data stores.

### Enriched data (data lake two)

Enriched data (as-is or aggregated) has a defined schema, is cleansed, and is available to analytics engines for extraction of high-value data. It has the same hierarchical directory structure as the raw layer. It's located in either the *confidential or below* or *sensitive (personal data)* folder for data integration on data lake two.

#### Enriched directory layout

```markdown
.
|-Data integration
|-Data integration
|--Transactional
|---Confidential
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|        file001.parquet
|        file001.parquet
|---Sensitive (personal data)
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Dataset
```

>[!NOTE]
>You can consider this layer of data the golden layer. It shouldn't have had any other transformations applied, apart from aligning data types.


### Curated data (data lake two)

You take data from the golden layer, in the enriched data layer, and transform it into high-value data products. These data products are served to consumers of the data, like BI analysts and data scientists. This data has structure and can be served to consumers either as-is (for example, data science notebooks) or through another read data store, like Azure SQL Database.

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

### Workspace data (data lake three)

Consumers of the data can also choose to incorporate other useful datasets in addition to data that's ingested by the data integration team from the source.

In this case, the data platform should provide a workspace for these consumers so they can use the curated data along with the other datasets they bring. For example, assume a data science team is trying to determine the product placement strategy for a new region. The team could use other datasets, like customer demographics and usage data for similar products from the region. This data could be used to analyze the product-market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They're still categorized as data products but are temporary and relevant only to the group that's using the data.

Sometimes these datasets mature, and the enterprise should consider how to promote these data products from the workspace layer to the curated data layer. To keep data product teams responsible for new data products, we recommend that you provide these teams a dedicated folder on the curated data layer. They can use this folder to store the new results and share them with other teams across the organization.

## Data lake partitioning

## Lifecycle management

Azure storage provides various access tiers that allow you to store blob object data in the most cost-effective way. The available access tiers include:

* **Hot.** Optimized for storing data that's frequently accessed.
* **Cool.** Optimized for storing data that's infrequently accessed and stored for at least 30 days.
* **Archive.** Optimized for storing data that's rarely accessed and stored for at least 180 days, with flexible latency requirements (on the order of hours).

These considerations apply access tiers:

* Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
* Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
* Data in the cool access tier can tolerate slightly lower availability. But it still requires high durability, retrieval latency, and throughput characteristics similar to the characteristics of hot data. For cool data, a slightly lower availability service-level agreement (SLA) and higher access costs compared to hot data are acceptable tradeoffs for lower storage costs.
* Archive storage stores data offline and offers the lowest storage costs but also the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential pace. To manage costs for your expanding storage needs, it helps to organize your data based on attributes like *frequency of access* and *planned retention period* to optimize costs. Data stored in the cloud can differ based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

Each of these data access scenarios benefits from a different access tier that's optimized for a particular access pattern. The hot, cool, and archive access tiers of Azure Blob Storage address the need for differentiated access tiers with separate pricing models.

The Enterprise analytics and AI construction set prescribes that you should implement a tiering policy for all three Azure Data Lake accounts.

## Considerations

When you move data into a data lake, it's important to pre-plan the structure of the data so that security, partitioning, and processing can be used effectively. Many of the following recommendations are applicable for all big data workloads. Every workload has different requirements for how data is consumed. The following considerations provide general recommendations. Work with your system integrator to determine the right level of Active Directory groups for your implementation of this construction set.

### Write data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Data integrations | Data integrations | Data products | Data products, data scientists, and BI analysts|

### Read data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
| Data integration | Data integration and read access for others, based on approval of the data integration owner | Data products, analysts, data scientists, and users | Data scientists and analysts|

### Folder structure and hierarchy

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Folder structure mirrors sensitivity followed by the source | Folder structure mirrors data integration followed by the data asset | Folder structure mirrors data product structure |Folder structures mirror teams that use the workspace|

>[!WARNING]
>Because some products don't support mounting the root of a data lake container, each data lake container in raw, curated, and enriched, and workspace should have a single folder before branching off to multiple folders. 
>
>You should carefully set up the folder permissions. When you create a new folder from the root, the default ACL on the parent directory determines: 
>* A child directory's default ACL and access ACL. 
>* A child file's access ACL (files don't have a default ACL). 
>
> See [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## Which data format should I use?

Data can arrive in your data lake account in various formats. These formats include human-readable formats like JSON, CSV, and XML files and compressed binary formats like .tar.gz. The files can also arrive in different sizes: 
* Huge files (a few TBs). For example, an export of a SQL table from your on-premises systems. 
* A large number of tiny files (a few KBs). For example, real-time events from your IoT solution. 

Azure Data Lake Storage Gen2 supports storing all kinds of data without imposing any restrictions. But you should think about data formats to maximize the efficiency of your processing pipelines and optimize costs. You can achieve both of these goals by picking the right format and the right file sizes.

Hadoop supports a set of file formats for the optimized storage and processing of structured data. Let's look at some common file formats: [Avro](https://avro.apache.org/docs/current/), [Parquet](https://parquet.apache.org/documentation/latest/), and [ORC](https://orc.apache.org/docs/). These formats are all machine-readable binary file formats. They all provide compression to manage file size, are self-describing, and have schemas embedded in the files. The formats differ in how data is stored. Avro stores data in a row-based format. Parquet and ORC store data in a columnar format.

### Considerations

* Avro is preferred when I/O patterns are more write heavy or when query patterns favor retrieving multiple rows of records in their entirety. For example, Avro is preferred by message bus services like Azure Event Hubs or Kafka, which write multiple events/messages in succession.
* Parquet and ORC are preferred when I/O patterns are more read heavy or when query patterns are focused on a subset of columns in the records, when the read transactions can be optimized to retrieve specific columns instead of reading the entire record.
