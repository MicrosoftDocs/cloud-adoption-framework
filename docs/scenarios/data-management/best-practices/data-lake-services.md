---
title: Azure enterprise-scale for analytics and AI teams Azure Data Lake services
description: Learn about the three data lake accounts that should be provisioned for each data landing zone.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data lake landing zones

It's important to pre-plan the structure of your data before you land it into a data lake. This planning then allows security, partitioning, and processing to be used effectively. The [three data lakes](./data-lake-overview.md#the-three-data-lakes) outlines a starting point for enterprise-scale for analytics and AI.

## Overview

The three data lake accounts should align to the typical zones within a data lake.

| Lake number | Zone      | Container |
|--------|-----------|-----------|
| 1      | Raw       | 1         |
| 2      | Enriched  | 1         |
| 2      | Curated   | 2         |
| 3      | Workspace | 1         |

There should be a single container per data lake zone. The exception to this recommendation is where immutable or different soft delete policies are required for the data held in the container. These requirements will drive the need for more containers.

The services should be enabled with the hierarchical name space feature to allow efficient file management. The [hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace) helps you organize objects and files within an account into a hierarchy of directories and nested subdirectories. It's organized in the same way that the file system on your computer is organized.

> [!IMPORTANT]
> The Azure Blob Storage account must have hierarchical name space enabled to allow efficient file management.

While the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for the data landing zone.

Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each lake account. For example, you might want your raw data to be geo-redundant. Workspace might be used for data exploration and require locally redundant disaster recovery.

Each **data integration** should have two folders on the raw and enriched data lake zones over which they should have ownership. Each **data product** should have two folders on the curated data lake zones over which they should have ownership.

The two folders per **data integration** or **data product** should be divided by classification. This classification leads to a general folder, for *confidential or below*, and a *sensitive* personal data folder with access controlled by access control lists (ACLs). By having these two folders below **data integration** or **data product**, you can choose to create a dataset with all the personal data removed located in the general folder. You can then have another dataset with all personal data in the *sensitive* personal data folder.

Access to the data is restricted by a combination of access control lists (ACLs) and Azure Active Directory (Azure AD) groups. These lists and groups control what can and can't be accessed by other groups. Integration operations teams** and data product teams can approve or reject access to their data assets.

> [!NOTE]
> For more information about handling restricted data, see [Restricted data](../secure-data-privacy.md#restricted-data).

## Raw zone or data lake one

Using the water-based analogy, think of this layer as a reservoir that stores data in its natural and original state. It's unfiltered and unpurified. You might choose to store the data in its original format, such as JSON or .CSV. But there might be scenarios where it makes sense to store it as a column in compressed format such as Avro, Parquet, or Databricks Delta Lake.

This data is always immutable. It should be locked down and the permissions given to any consumers, whether they're automated or human, should be read-only. The zone might be organized by using a folder per source system. Each ingestion process has write access to only its associated folder.

Consider using lifecycle management to reduce long-term storage costs. This recommendation is because this layer usually stores the largest amount of data. Azure Data Lake Storage Gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules that run once a day and can be assigned to the account, filesystem, or folder level. The feature is free although the operations will incur a cost.

Raw data from source systems for each **data integration** or source will land into either the general folder, for *confidential or below*, or *sensitive* personal data folder for each **data integration** on data lake one. Each ingestion process should have write access to only their associated folder.

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
|-Sensitive(Personal data)
|--Source
|---Entity
|---LoadTS=YYMMDDHHMSS
|       file001.parquet
|       file001.parquet
```

This data is stored as-is in the data lake. It's consumed by an analytics engine such as Spark to do cleansing and enrichment operations to generate the curated data.

For batch or micro-batch patterns, the data should be copied from the source system and landed as-is in the data lake without any transformations.

For streaming use cases, the data in the raw zone should sometimes be stored as an aggregated dataset. For example, data is ingested via a message bus such as Azure event hub. It's then aggregated via a real-time processing engine such as Azure Stream Analytics or Spark Streaming before it's stored in the data lake.

As this layer usually stores the largest amount of data, consider using lifecycle management to reduce long-term storage costs. At the time of writing Azure Data Lake Storage Gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules that run once a day and can be assigned to the account, filesystem, or folder level.

> [!TIP]
> Enterprises need to think about scenarios where they might need to rebuild an analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream read data stores.

## Enriched zone or data lake two

The next layer can be thought of as a filtration zone that removes impurities but may also involve enrichment.

Typical activities found in this layer are schema and data type definition, removal of unnecessary columns, and application of cleaning rules whether it be validation, standardization, harmonization. Enrichment processes may also combine data sets to further improve the value of insights.

The organization of this zone is more business-driven rather than by source system. Typically, it might be a folder per department or project. Some consider this zone a staging zone where you grant permissions only to the automated jobs that run against it. If data analysts or scientists need access to the data in this form, you can grant them read-only access only.

The enriched zone follows the same hierarchical directory structure as the raw zone and is located in either the general folder, for *confidential or below*, or *sensitive* personal data folder for each **data integration** * folder on data lake two.

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
|---Sensitive (Personal data)
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Dataset
```

> [!NOTE]
> This layer of data is considered the golden layer or read data source. It shouldn't have had any other transformations applied other than to align data types.

## Curated zone or data lake two

The curated zone or data lake two is the consumption layer. It's optimized for analytics rather than data ingestion or data processing. It might store data in de-normalized data marts or star schemas.

Data is taken from the golden layer, in enriched data, and transformed into high-value **data products** that are served to the consumers of the data. Consumers of the data might include BI analysts and data scientists. This data has structure and can be served to the consumers either as-is such as data science notebooks, or through another read data store such as Azure SQL Database.

The dimensional modeling is preferably done by using tools like Spark or Data Factory rather than inside the database engine. If you want to make the lake the single source of truth, then this use of tools becomes a key point.

If the dimensional modeling is done outside of the lake, for example, in the data warehouse, then you might want to publish the model back to the lake for consistency. Don't expect this layer to be a replacement for a data warehouse. Typically, the performance isn't adequate for responsive dashboards or end-user and consumer interactive analytics. It's best suited for internal analysts or data scientists who run large-scale ad hoc queries, analysis, or advanced analytics who don't have strict time-sensitive reporting needs. As storage costs are lower in the lake compared to the data warehouse, it might be more cost effective to keep granular, low-level data in the lake, and store only aggregated data in the warehouse. These aggregations can be generated by Spark or Azure Data Factory and persisted to the lake prior to loading the data warehouse.

Data assets in this zone are typically highly governed and well-documented. Permission is assigned by department or function and organized by consumer group or by data mart.

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
|---Sensitive(Personal data)
|----Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Dataset
```

> [!TIP]
> When a decision is made to land the data into another read data store such as Azure SQL database, as a high speed serving layer, we recommend to have a copy of the data located in the curated data. Although users of the **data product** will be guided to the main read data store or Azure SQL database, it will allow them to do further data exploration using a wider set of tools if the data is also available in the data lake.

Data assets in this zone should be highly governed and well-documented. For example, high-quality sales data might be data in the enriched data zone correlated with other demand forecasting signals such as social media trending patterns for a **data integration** that's used for predictive analytics on determining the sales projections for the next fiscal year.

## Workspace zone or data lake three

Along with the data that's ingested by the **data integration** team from the source, the consumers of the data can also bring other useful datasets.

In this scenario, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other datasets they bring, to generate valuable insights. For example, if a data science team wants to determine the product placement strategy for a new region, they can bring other datasets such as customer demographics and usage data of similar products from that region. This high-value sales insights data can be used to analyze the product market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They're still categorized as a **data product**, but are temporary and only relevant to the user group using the data.

Sometimes these datasets mature, and the enterprise should consider how they promote these **data products** from the workspace to the curated data zone. In order to keep data product teams responsible for new data products, it's recommended to provide these teams a dedicated folder on the curated data zone. Here they can store the new results and share them with other teams across the organization.

> [!NOTE]
> For every Azure Synapse workspace, which is created, we recommend to use data lake three to create a container that can be used as the primary storage. This is to stop Azure Synapse workspaces from interfering with the curated and enriched zones throughput limits.

## Data lake partitioning

Data partitioning is the process of organizing data in the data store so that large-scale data can be managed, and data access can be controlled. Partitioning can improve scalability, reduce contention, and optimize performance. This section describes guideline and strategy for partitioning data in the Data Lake Storage. When partitioning the data lake, have a setup that:

- Doesn't compromise security
- Has clear isolation and aligns with the data authorization model
- Fits well with data ingestion process
- Has a well-defined path for optimal data access
- Supports management and maintenance tasks

### General practices

Below are general practices for data partitioning design.

- Focus on security implication early and design data partitions together with authorization
- Data redundancy might be allowed in exchange for security
- Multiple nesting of folders is acceptable, but keep it consistent
- Don't combine mixed file formats or different datasets in a single folder structure
- Don't start the folder structure with date partitions. It's better to keep dates at the lower folder level.
- Define a naming convention and adhere to it
- Include time element in the folder structure and file name

> [!TIP]
> Folder structures should have partitioning strategies that can optimize access patterns and appropriate file sizes. In the curated zones, plan the structure based on optimal retrieval, be cautious of choosing a partition key with high cardinality, which leads to over partitioning, which in turn leads to suboptimal file sizes.

## Alignment of personas to write and reading of data

:::image type="content" source="../images/data-lake-zones-quality.png" alt-text="Diagram showing an example of data lake zones." lightbox="../images/data-lake-zones-quality.png":::

### Write data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
|Data integrations | Data integrations | Data products | Data products, data scientists, and BI analysts|

### Read data

|Raw data |Enriched data |Curated data| Workspace data|
|---------|---------|---------|---------|
| Data integration | Data integration and read access for others based on approval of data integration owner | Data products, analysts, data scientists, and users | Data scientists and analysts|

> [!WARNING]
> Some products don't support mounting the root of a data lake container. Because of this, each data lake container in raw, curated, enriched, and workspace should have a single folder before branching off to multiple folders. Set up the folder permissions carefully. During the creation of a new folder from the root, the default access control list (ACL) on the parent directory determines a child directory's default access control list (ACL) and access ACL. A child file's access control list (ACL) files don't have a default ACL. For more information, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## What data format and file size do I choose?

### File format

Data might arrive to your data lake account in different kinds of formats. Human readable formats might be used like JSON, .CSV, or XML files. Or compressed binary formats might be used like .tar or .gz. The data might be in variety of sizes that includes large files that are TB's in size, such as an export of a SQL table from your on-premises systems. Or the data might be in a large number of small files that are a few kbs like real-time events from your IoT solution. While Azure Data Lake Storage Gen2 supports storing all kinds of data without imposing any restrictions, it's better to think about data formats to maximize efficiency of your processing pipelines and optimize costs. You can achieve both by picking the right format and the right file sizes. Hadoop has a set of file formats it supports for optimized storage and processing of structured data.

- [Avro](https://avro.apache.org/docs/current/)
- [Parquet](https://parquet.apache.org/documentation/latest/)
- [ORC](https://orc.apache.org/docs/)

All of these formats are machine-readable binary file formats, offer compression to manage the file size, and are self-describing in nature with a schema embedded in the file. The difference between the formats is in how data is stored. Avro stores data in a row-based format and Parquet and ORC formats store data in a columnar format.

- Avro file format is best where the I/O patterns are write heavy or the query patterns favor retrieving multiple rows of records in their entirety. For example, the Avro format is favored by message bus such as Azure Event Hub or Apache Kafka writes multiple events or messages in succession.
- Parquet and ORC file formats are best when the I/O patterns are more read heavy and when the query patterns are focused on a subset of columns in the records. For example, where the read transactions can be optimized to retrieve specific columns instead of reading the entire record.

### File size

Lots of small files generally lead to suboptimal performance and potentially higher costs because of increased read/list operations. Azure Data Lake Storage Gen2 is optimized to perform better on larger files. Analytics jobs will run faster and at a lower cost.

Costs are reduced because of the shorter compute (Spark or Data Factory) times but also because of optimal read operations. For example, files greater than 4 MB in size incur a lower price for every 4-MB block of data read beyond the first 4 MB. For example, to read a single file that is 16 MB is cheaper than reading four files that are 4 MB each.

When processing data with Apache Spark, the typical guidance is around 64 MB to 1 GB per file. It's well known in the Spark community that thousands of small files, or files KB in size, are a challenge to performance. In the raw zone, streaming data will typically have smaller files and messages at high velocity. Files will need to be regularly compacted and consolidated. If you're using the Delta format, then OPTIMIZE or AUTO OPTIMIZE can help.

## Next steps

The next step is to review considerations for your data lakes.  

> [!div class="nextstepaction"]
> [Data lake considerations](./data-lake-key-considerations.md)
