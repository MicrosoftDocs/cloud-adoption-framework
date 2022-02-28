---
title: Provision three Azure Data Lake Storage Gen2 accounts for each data landing zone
description: Learn about the three Azure Data Lake Storage Gen2 accounts that should be provisioned for each data landing zone.
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data lake zones and containers

It's important to plan the structure of your data before you land it into a data lake. This planning then allows security, partitioning, and processing to be used effectively. The [three data lakes](./data-lake-overview.md#the-three-data-lakes) outlines a starting point for data management and analytics scenario.

## Overview

The three data lake accounts should align to the typical layers within a data lake.

| Lake number | Layers        | Container No | Container Name    |
|-------------|-------------|--------------|-------------------|
| 1           | Raw         | 1            | Landing           |
| 1           | Raw         | 2            | Conformance       |
| 2           | Enriched    | 1            | Standardized      |
| 2           | Curated     | 2            | Data Products     |
| 3           | Development | 1            | Analytics Sandbox |
| 3           | Development | #           | Synapse Primary Storage #  |

Above are the standard number of containers we would recommend per data landing zone. The exception to this recommendation is where immutable or different soft delete policies are required for the data held in the container. These requirements will drive the need for more containers.

The services should be enabled with the hierarchical name space feature to allow efficient file management. The [hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace) helps you organize objects and files within an account into a hierarchy of directories and nested subdirectories. It's organized in the same way that the file system on your computer is organized.

> [!IMPORTANT]
> While the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for the data landing zone.

When a new system of record is registered via the data agnostic or onboarding application, it should create the required folders on the containers in the raw, enriched and standardized data layers. If the data is being ingested using a data application (source-aligned),** then the data application team would require the data landing zone team to create the folders, security groups. Place either a Service principle name or managed identity into the correct group and then give the correct level of permissions - this process would be documented as a process to data landing zone and data application teams. For information on teams, see [Understand the roles and teams for data management and analytics in Azure](../organize-roles-and-teams.md).

Each **data product** should have two folders in the curated data lake layer over which the data product team should have ownership.

At the standardized container, in the enriched zone, there would be two folders per source system divided by classification. This will allow the team to store data with different security and data classification separately and different security access can be assigned to them.
The container would contain a general folder, for *confidential or below*, and a *sensitive* personal data folder. Access will be controlled, by access control lists (ACLs). By having these two folders, you can choose to create a dataset with all the personal data removed located in the general folder. You can then have another dataset with all personal data in the *sensitive* personal data folder.

Access to the data is restricted by a combination of access control lists (ACLs) and Azure Active Directory (Azure AD) groups. These lists and groups control what can and cannot be accessed by other groups. Data owners and data application teams can approve or reject access to their data assets. For more information, [Data Access Management](../security-provisioning.md) and [Restricted data](../secure-data-privacy.md#restricted-data).

> [!WARNING]
> Some software products do not support mounting the root of a data lake container. Because of this, each data lake container in raw, curated, enriched, and development should have a single folder before branching off to multiple folders. Set up the folder permissions carefully. During the creation of a new folder from the root, the default access control list (ACL) on the parent directory determines a child directory's default access control list (ACL) and access ACL. A child file's access control list (ACL) files do not have a default ACL. For more information, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## Raw layer or data lake one

Using the water-based analogy, think of this layer as a reservoir that stores data in its natural and original state. It is unfiltered and unpurified. You might choose to store the data in its original format, such as JSON or .CSV. But there might be scenarios where it makes sense to store it as a column in compressed format such as Avro, Parquet, or Databricks Delta Lake.

This data is always immutable. It should be locked down and the permissions given to any consumers, whether they are automated or human, should be read-only. The zone might be organized by using a folder per source system. Each ingestion process has write access to only its associated folder.

Consider using [data lifecycle management](../govern-lifecycle.md) to reduce long-term storage costs. This recommendation is because this layer usually stores the largest amount of data. Azure Data Lake Storage Gen2 supports moving data to the cool access tier either programmatically or through a lifecycle management policy. The policy defines a set of rules that run once a day and can be assigned to the account, filesystem, or folder level. The feature is free although the operations will incur a cost.

When you load data from source systems into the raw zone you can either choose to do full loads from systems meaning that the full data set is extracted every time, or delta loads meaning that you load only the changed data every time. It is good practice to indicate the loading pattern in the folder structure. This will simplify the use for the data consumers.

Raw data from source systems for each **data application (source-aligned)** or data agnostic engine source will land into either the full or delta folder. Each ingestion process should have write access to only their associated folder.

We define full load and delta loads as:

- Full Load
  - The complete data from source can be onboarded under the below scenarios
    - The volume of data at source is small.
    - The source system doesn't maintain any timestamp field to identify if the data has been added, updated or deleted.
    - The source system overwrites the complete data each time.

- Delta Load
  - The incremental data from source can be onboarded under the below scenarios
    - The volume of data at source is huge
    - The source system maintains a timestamp field to identify if the data has been added/updated or deleted
    - The source system creates/updates files on data changes.

The raw data lake is composed of the landing and conformance containers, each with a 100% mandatory folder structure specific to its purpose.

### Landing container layout

The landing container is reserved for raw data loaded by the data agnostic ingestion engine or a **data application (source-aligned)**, from a recognized source system of record, unaltered, and in its original supported format.

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

This layer is containing data quality conformed data. As the data is copied to landing container the data processing and compute should be triggered to copy the data from the landing container to the conformance container. As part of this first stage data is converted into the delta lake format and land in to input folder. Data quality is run and those records that pass are copied into the output folder. Failed records land into the error folder.

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
> Businesses need to think about scenarios where they might need to rebuild an analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream read data stores. It is recommended to have a [business continuity and disaster recovery](../eslz-business-continuity-and-disaster-recovery.md) plan in place for key components.

## Enriched layer or data lake two

The next layer can be thought of as a filtration layer that removes impurities but could also involve enrichment.

The standardization container hold systems of record and masters.  Folders are segmented first by subject area, and then by entity.  Data is available in merged, partitioned tables optimized for analytics consumption.

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
> This layer of data is considered the silver layer or read data source. It shouldn't have had any other transformations applied other than data quality, conversion to delta lake and alignment of data types.

:::image type="content" source="../images/data-flow-high-level.png" alt-text="High level data flow" lightbox="../images/data-flow-high-level.png":::

The above diagram brings together the flow of the data lakes and containers from source data through to the standardized container.

## Curated layer or data lake two

The curated layer or data lake two is the consumption layer. It's optimized for analytics rather than data ingestion or data processing. It might store data in de-normalized data marts or star schemas.

Data is taken from the standardized container and transformed into high-value **data products** that are served to the consumers of the data. Consumers of the data might include BI analysts and data scientists. This data has structure and can be served to the consumers either as-is such as data science notebooks, or through another read data store such as Azure SQL Database.

The dimensional modeling is preferably done by using tools like Spark or Data Factory rather than inside the database engine. If you want to make the lake the single source of truth, then this use of tools becomes a key point.

If the dimensional modeling is done outside of the lake, for example, in the data warehouse, then you might want to publish the model back to the lake for consistency. Do not expect this layer to be a replacement for a data warehouse. Typically, the performance is not adequate for responsive dashboards or end-user and consumer interactive analytics. It is best suited for internal analysts or data scientists who run large-scale ad hoc queries, analysis, or advanced analytics who do not have strict time-sensitive reporting needs. As storage costs are lower in the lake compared to the data warehouse, it might be more cost effective to keep granular, low-level data in the lake, and store only aggregated data in the warehouse. These aggregations can be generated by Spark or Azure Data Factory and persisted to the lake prior to loading the data warehouse.

Data assets in this zone are typically highly governed and well-documented. Permission is assigned by department or function and organized by consumer group or by data mart.

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
> When a decision is made to land the data into another read data store such as Azure SQL Database, as a high-speed serving layer, we recommend to have a copy of the data located in the curated data. Although users of the **data product** will be guided to the main read data store or Azure SQL Database instance, allowing them to do further data exploration using a wider set of tools if the data is also available in the data lake.

Data assets in this layer should be highly governed and well-documented. For example, high-quality sales data might be data in the enriched data layer correlated with other demand forecasting signals such as social media trending patterns for a **data application** that's used for predictive analytics on determining the sales projections for the next fiscal year.

## Development layer or data lake three

Along with the data that's ingested to the standardized container, the consumers of the data can also bring other useful data products.

In this scenario, the data platform should allocate an analytics sandbox area for these consumers so they can use the curated data along with the other data products they bring, to generate valuable insights. For example, if a data science team wants to determine the product placement strategy for a new region, they can bring other data products such as customer demographics and usage data of similar products from that region. This high-value sales insights data can be used to analyze the product market fit and the offering strategy.

> [!NOTE]
> The analytics sandbox area is intended as a working area for individual, or a small group of collaborators.  The sandbox folders will have a special set of policies intended to prevent using this area as part of a production solution.  This would include limits on total available storage and how long data can be stored.

These data products are usually of unknown quality and accuracy. They're still categorized as a **data product**, but are temporary and only relevant to the user group using the data.

Sometimes these data products mature, and the enterprise should consider how they promote these **data products** to the curated data layer. In order to keep data product teams responsible for new data products, it is recommended to provide these teams a dedicated folder on the curated data zone. Here they can store the new results and share them with other teams across the organization.

> [!NOTE]
> For every Azure Synapse workspace, which is created, we recommend to use data lake three to create a container that can be used as the primary storage. This is to stop Azure Synapse workspaces from interfering with the curated and enriched zones throughput limits.

## Example of data flow into products and analytics sandbox

The follow diagram brings together the previous sections and illustrates how data would flow through to the data products and analytic sandbox.

:::image type="content" source="../images/data-flow-data-products.png" alt-text="data flow into product container and analytics sandbox" lightbox="../images/data-flow-data-products.png":::

## Next steps

[Key considerations for Azure Data Lake Storage](./data-lake-key-considerations.md)
