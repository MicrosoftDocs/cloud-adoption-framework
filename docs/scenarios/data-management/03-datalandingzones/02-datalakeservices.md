---
title: Enterprise Scale Analytics and AI Teams Data Lake Services
description: Enterprise Scale Analytics and AI Architecture Data Lake Services
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Lake Services

Three [Azure Data Lake Storage Gen V2 (ADLS)](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-introduction) should be provisioned, per Data Landing Zone, in the Data Lake Services Resource Group. The data transformed at different stages should be saved on one of the Data Landing Zones three data lakes and available for the **Data Products**. These data lake accounts should be deployed into a single resource group.

## Overview

The three Data Lakes accounts should align to the typical layers within a data lake.

|Lake #|Layer|
|---|---|
|1| Raw Data|
|2 |Enriched and Curated Data|
|3| Workspace Data|

The containers within these lakes should be aligned to **Domains**, **Sub-Domains** and **Data Products** to enable data exploration via an enterprise teams' structure.

The service should be enabled with the 'hierarchical name space' to allow the efficient file management. [The hierarchical name space feature](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-namespace) allows the collection of objects/files within an account to be organized into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

>[!IMPORTANT]
>The Azure Blob Storage Account must have 'hierarchical name space' enabled to allow the efficient file management.

Azure Data Lake Storage is providing: -

* Support for fine-grained [Access Control Lists](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control) (ACLs), protecting data at the file and folder level which helps enterprises to implement tight security measures around the data sets being stored in this service.
* The data is encrypted at-rest storage and Azure Active Directory integration for the authentication. It helps to store the data securely and to implement access controls for the AD users and security groups.

Whilst the data lake sits across three data lake accounts, multiple containers, and folders it represents one logical data lake for the Data Landing Zone. The purposes of provisioning three data lake accounts is related to being able to set different redundancy, retention and policies for each lake account. For example you might want you RAW data to be geo-redundant whereas Workspace is used for data exploration and requires locally redundant disaster recovery.

Each **Domain** should have two containers on each Data Lake for which they should have ownership over following best practices for each Data Lake layers.

The two containers, per **Domain**, should be divided into classification (internal and sensitive) with Data Lake access to be controlled by RBAC and ACLs.

>[!IMPORTANT]
>Access to the data is restricted by use a combination of ACLs and AAD-groups enable groups what can and cannot be accessed by other groups. **Domain teams** should approve/reject access to their data-assets.

## Data Lakes Connectivity

Each of the data lakes should use Private Endpoints which are injected into the VNet of the Data Landing Zone. To allow cross-land-zone data access, we propose connecting Data Landing Zones through VNet peering. This solution is not only optimal from a cost, but also from an access control perspective.

See [Private Endpoints](../01-overview/05-networking.md#private-endpoints) and [Data Management Subscription to Data Landing Zone](../01-overview/05-networking.md#data-management-subscription-to-data-landing-zone)

>[!IMPORTANT]
>Data from a Data Landing Zone can be accessed from another Data Landing Zone over the VNet Peering between the Data Landing Zones using the private endpoints associated with each data lake account. We recommend turning off all public access to the lakes and using private endpoints. Network connectivity across Data Landing Zones, i.e. private links, are controlled by the platform ops team.

## Data Lake Layers

With three data lake accounts in use it is important to understand the context in which they should be used.

### Raw Data (Data Lake One)

Raw Data from source systems, for each **Domain**, will land into either the internal or sensitive container for each **Domain** on Data Lake One.

This data is stored as is in the data lake and is consumed by an analytics engine such as Spark to perform cleansing and enrichment operations to generate the curated data.

For batch or micro-batch the data should be copied from the source system and landed as is into the data lake without any transformations.

For streaming use cases the data in the raw zone should sometimes also stored as an aggregated data set. For example, data is ingested via message bus such as Event Hub, and then aggregated via a real time processing engine such as Azure Stream analytics or Spark Streaming before storing in the data lake.

Depending on the retention policies of your enterprise, this data is either stored as is for the period required by the retention policy or it can be deleted when you think the data is of no more use e.g. this could be raw sales data that is ingested from on-prem systems.

>[!TIP]
>Enterprises need to think about scenarios where they might need to rebuild a analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream Read Data Stores.

### Enriched Data (Data Lake Two)

Enriched Data is is the version where raw data (as is or aggregated) has a defined schema and, the data is cleansed, and is available to analytics engines to extract high value data. it will follow the same hierarchial directory structure as the raw layer and resides in either the internal or sensitive container for **Domain** on Data Lake Two.

>[!NOTE]
>This layer of data can be consider the golden layer and shouldn't have had any other transformations applied apart from aligning data types.

### Curated Data (Data Lake Two)

Data is been taken from the golden layer, in Enriched Data, and transformed into high value information **Data Products** that is served to the consumers of the data (BI analysts and the data scientists). This data has structure and can be served to the consumers either as is (e.g. data science notebooks) or through another read data store such as Azure Database for SQL.

>[!TIP]
>In the case where a decision is made to land the data into another read data store such as Azure Database for SQL, as a high speed serving layer, we would recommend having a copy of the data residing in the curated data. Although users of the **data product** will be guided to the main read data store (Azure Database for SQL), it will allow them to do further data exploration in a wider set of tools if the data is also available in the data lake.

Data assets in this layer should be highly governed and well documented e.g. high-quality sales data (that is data in the enriched data zone correlated with other demand forecasting signals such as social media trending patterns) for a **Domain** that is used for predictive analytics on determining the sales projections for the next fiscal year.

### Workspace Data (Data Lake Three)

In addition to the data that is ingested by the **Domain** team from the source, the consumers of the data can also choose to bring other data sets that could be valuable.

In this case, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other data sets they bring to generate valuable insights. e.g. a Data Science team is trying to determine the product placement strategy for a new region, they could bring other data sets such as customer demographics and data on usage of other similar products from that region and use the high value sales insights data to analyse the product market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They are still categorized as a **data product** but are temporary and only relevant to the user group using the data.

Sometimes these datasets mature and the enterprise should consider how they promote these **Data Products** from the Workspace to the Curated Data Layer.

## Lifecycle Management

Azure storage offers different access tiers, which allow you to store blob object data in the most cost-effective manner. The available access tiers include:

* **Hot** - Optimized for storing data that is accessed frequently.
* **Cool** - Optimized for storing data that is infrequently accessed and stored for at least 30 days.
* **Archive** - Optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements (on the order of hours).

The following considerations apply to the different access tiers:

* Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
* Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
* Data in the cool access tier can tolerate slightly lower availability, but still requires high durability, retrieval latency, and throughput characteristics similar to hot data. For cool data, a slightly lower availability service-level agreement (SLA) and higher access costs compared to hot data are acceptable trade-offs for lower storage costs.
* Archive storage stores data offline and offers the lowest storage costs but also the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential pace. To manage costs for your expanding storage needs, it's helpful to organize your data based on attributes like frequency-of-access and planned retention period to optimize costs. Data stored in the cloud can be different based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

Each of these data access scenarios benefits from a different access tier that is optimized for a particular access pattern. With hot, cool, and archive access tiers, Azure Blob Storage addresses this need for differentiated access tiers with separate pricing models.

The Enterprise Analytics and AI solution pattern prescribes that you should implement a tiering policy for Raw, Enriched and Curated, Workspace Azure Data Lake accounts.

## Key Considerations

When landing data into a data lake, it is important to pre-plan the structure of the data so that security, partitioning, and processing can be utilized effectively. Many of the following recommendations are applicable for all big data workloads. Every workload has different requirements on how the data is consumed.

|Consideration | Raw data |Enriched data |Curated data| Workspace data|
|-- | ----- | -- | -- | -- |
|Write Data| Domains | Domains | Data Products | Data Scientists and BI analysts|
|Read Data| Domains | Domain and read access for others based on approval of Domain owner | Data Products, Analysts, Data Scientists and Users | Data Scientists and  Analysts|
|Data Lifecycle Management |Once enriched data is generated, can be moved to a cooler tier of storage to manage costs.| Older data can be moved to a cooler tier. |Older data can be moved to a cooler tier.| While the end consumers have control of this workspace, ensure that there are processes and policies to clean up data that is not necessary |
|Folder Structure and Hierarchy| Folder structure to mirror Domain followed by source. | Folder structure to mirror Domain followed by sub-Domain | Folder structure mirrors data product structure |Folder structures mirror teams that the workspace is used by.|

>[!WARNING]
>As some products do not support mounting the root of a data lake container; each data lake container in Raw, Curated and Enriched, and Workspace should have a a single folder before branching off to multiple folders. The folder permissions should be carefully set up as during the creation of a new folder, from the root, the default ACL on the parent directory determines a child directory's default ACL and access ACL; a child file's access ACL (files do not have a default ACL).  See [Access control lists (ACLs) in Azure Data Lake Storage Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control).

## Industry Specific Data Models and Common Data Model with Data Lake

An industry data model enables organizations to more holistically capture and define business concepts, refine and integrate processes, and build interoperability in their ecosystem. [Microsoft acquired ADRM Software, leader in large-scale, industry-specific data models](https://blogs.microsoft.com/blog/2020/06/18/microsoft-acquires-adrm-software-leader-in-large-scale-industry-specific-data-models/)  to support this requirement on Azure.

With the Common Data Model (CDM), organizations can use a data format that provides semantic consistency across applications and deployments. With the evolution of the Common Data Model metadata system, the model brings the same structural consistency and semantic meaning to the data stored in Microsoft Azure Data Lake Storage Gen2 with hierarchical namespaces and folders that contain schematized data in standard Common Data Model format. The standardized metadata and self-describing data in an Azure data lake facilitates metadata discovery and interoperability between data producers and data consumers such as Power BI, Azure Data Factory, Azure Databricks, and Azure Machine Learning. When combined, these elements provide compelling centralized data, structured data, fine-grained access control, and semantic consistency for apps and initiatives across the enterprise. See [Use the Common Data Model to optimize Azure Data Lake Storage Gen2](https://docs.microsoft.com/common-data-model/data-lake).

>[!NOTE]
>Industry Specific Data Models and Common Data Models would pre-dominantly be created in the curated data lake layer by product teams for downstream consumption. The folder structure should still sit under a data product folder.

## Monitoring

In a Data Landing Zone all the monitoring should be sent to the management subscription for analysis.

Azure Storage collects the same kinds of monitoring data as other Azure resources, which are described in [Monitoring Azure resources with Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/insights/monitor-azure-resource). For more information on the logs and metrics created by Azure Storage, see [Monitoring Azure Blob storage](https://docs.microsoft.com/azure/storage/blobs/monitor-blob-storage).

Log entries are created only if there are requests made against the service endpoint.

The following types of authenticated requests are logged:

* Successful requests
* Failed requests, including timeout, throttling, network, authorization, and other errors
* Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests
* Requests to analytics data (classic log data in the $logs container and class metric data in the $metric tables)

Requests made by the storage service itself, such as log creation or deletion, aren't logged.

The following types of anonymous requests are logged:

* Successful requests
* Server errors
* Time-out errors for both client and server
* Failed GET requests with the error code 304 (Not Modified)

All other failed anonymous requests are not logged.

In a Data Landing Zone all the monitoring is sent to the management subscription for analysis.

>[!IMPORTANT]
>Set default monitoring policy to audit storage and send logs to the Enterprise Scale Management Subscription.

>[!div class="step-by-step"]
>[Previous](01-datalandingzone.md)
>[Next](03-databricks.md)
