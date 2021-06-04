---
title: Enterprise Scale Analytics and AI Teams Data Lake Services
description: Enterprise Scale Analytics and AI Architecture Data Lake Services
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Lake Services

Three [Azure Data Lake Storage Gen2 (ADLS)](/azure/storage/blobs/data-lake-storage-introduction) accounts should be provisioned per [Data Landing Zone](eslz-data-landing-zone.md) in the "data lake services" resource group. As data passes through the different stages of transformation, it should be saved in one of the Data Landing Zone's three data lakes and available for the [data products](eslz-data-landing-zone-data-products.md) in the lake which serves as the enriched and curated data layer. Data products would consume from the enriched and curated data layer only. These data lake accounts should be deployed into a single resource group.

## Overview

The three Data Lakes accounts should align to the typical layers within a data lake.

|Lake #|Layer|
|---|---|
| 1 | Raw Data|
| 2 | Enriched and Curated Data|
| 3 | Workspace Data|

There should be a single container per data lake layer. The exception to this recommendation would be be where immutable or different soft delete policies are required for the data held in the container. These requirements would drive additional containers.

The folders within the containers lakes should be aligned to **Domains**, **Sub-Domains**, and **Data Products** to enable data exploration via an enterprise team's structure.

The services should be enabled with the "Hierarchical Name Space" feature to allow efficient file management. [The hierarchical name space feature](/azure/storage/blobs/data-lake-storage-namespace) allows the collection of objects/files within an account to be organized into a hierarchy of directories and nested subdirectories in the same way that the file system on your computer is organized.

>[!IMPORTANT]
>The Azure Blob Storage Account must have "hierarchical name space" enabled to allow the efficient file management.

Azure Data Lake Storage provides:

* Support for fine-grained [Access Control Lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs), protecting data at the file and folder level, which helps enterprises to implement tight security measures around the datasets being stored in this service.
* The data is encrypted at rest and integrates with Azure Active Directory integration for the authentication and authorization. It helps to store the data securely and to implement access controls for the AD users and security groups.

Whilst the data lake sits across three data lake accounts, multiple containers, and folders, it represents one logical data lake for the Data Landing Zone. Provisioning three data lake accounts allows you to set different redundancy, retention, and access policies for each lake account. For example you might want your RAW data to be geo-redundant whereas Workspace is used for data exploration and requires locally redundant disaster recovery.

Each **Domain** should have two folders on each data lake over which they should have ownership, following best practices for each data lake layer.

The two folders per **Domain** should be divided by classification (non-sensitive and sensitive) with access controlled by ACLs.

>[!IMPORTANT]
>Access to the data is restricted by a combination of ACLs and AAD-groups. These control what can and cannot be accessed by other groups. **Domain teams** should approve or reject access to their data assets.

## Data Lake Layers

With three data lake accounts in use, it is important to understand the context in which they should be used.

### Raw Data (Data Lake One)

Raw Data from source systems for each **Domain** will land into either the non-sensitive or sensitive folder for each **Domain** on Data Lake One.

### RAW Directory Layout

```markdown
.
|-Domain
|-Domain
|--Transactional
|---Subdomain/Dataset
|----Entity
|-----LoadTS=YYMMDDHHMMSS
|       file001.parquet
|       file001.parquet
|--Master Data
|----Subdomain/Dataset
```

This data is stored as-is in the data lake and is consumed by an analytics engine such as Spark to perform cleansing and enrichment operations to generate the curated data.

For batch or micro-batch patterns, the data should be copied from the source system and landed as-is in the data lake without any transformations.

For streaming use cases, the data in the raw zone should sometimes also be stored as an aggregated dataset. For example, data is ingested via a message bus such as Azure Event Hub and then aggregated via a real-time processing engine such as Azure Stream Analytics or Spark Streaming before it is stored in the data lake.

Depending on the retention policies of your enterprise, this data is either stored as-is for the period required by the retention policy, or it can be deleted when you think the data is of no more use (*e.g.* raw sales data that is ingested from on-premises systems).

>[!TIP]
>Enterprises need to think about scenarios where they might need to rebuild an analytics platform from scratch and should always consider the most granular data they would require to rebuild downstream Read Data Stores.

### Enriched Data (Data Lake Two)

Enriched data is the version where raw data (as-is or aggregated) has a defined schema, has been cleansed, and is available to analytics engines to extract high-value data. It will follow the same hierarchial directory structure as the raw layer and resides in either the non-sensitive or sensitive folder for **Domain** on Data Lake Two.

#### Enriched Directory Layout

```markdown
.
|-Domain
|-Domain
|--Transactional
|---Non-Sensitive
|----Subdomain/Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|        file001.parquet
|        file001.parquet
|---Sensitive
|----Subdomain/Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Subdomain/Dataset
```

>[!NOTE]
>This layer of data can be consider the golden layer and shouldn't have had any other transformations applied apart from aligning data types.

### Curated Data (Data Lake Two)

Data is taken from the golden layer, in Enriched Data, and transformed into high-value **Domain** or **Data Products** that is served to the consumers of the data (BI analysts and the data scientists). This data has structure and can be served to the consumers either as-is (*e.g.* data science notebooks) or through another read data store such as Azure Database for SQL.

#### Curated Directory Layout

```markdown
.
|-Domain
|-Domain
|--Transactional
|---Non-Sensitive
|----Subdomain/Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|        file001.parquet
|        file001.parquet
|---Sensitive
|----Subdomain/Dataset
|-----Entity
|------LoadTS=YYMMDDHHMMSS
|--Master Data
|----Subdomain/Dataset
```

>[!TIP]
>In the case where a decision is made to land the data into another read data store such as Azure Database for SQL, as a high speed serving layer, we would recommend having a copy of the data residing in the curated data. Although users of the **data product** will be guided to the main read data store (Azure Database for SQL), it will allow them to do further data exploration in a wider set of tools if the data is also available in the data lake.

Data assets in this layer should be highly governed and well documented. For example, high-quality sales data might be data in the enriched data zone correlated with other demand forecasting signals such as social media trending patterns for a **Domain** that is used for predictive analytics on determining the sales projections for the next fiscal year.

### Workspace Data (Data Lake Three)

In addition to the data that is ingested by the **Domain** team from the source, the consumers of the data can also choose to bring other useful datasets.

In this case, the data platform should allocate a workspace for these consumers so they can use the curated data along with the other datasets they bring to generate valuable insights. For example, if a Data Science team is trying to determine the product placement strategy for a new region, they could bring other datasets such as customer demographics and usage data of similar products from that region. These high-value sales insights data could be used to analyze the product market fit and the offering strategy.

These datasets are usually of unknown quality and accuracy. They are still categorized as a **data product** but are temporary and only relevant to the user group using the data.

Sometimes these datasets mature, and the enterprise should consider how they promote these **Data Products** from the Workspace to the Curated Data Layer. In order to keep Data Product teams responsible for new Data Products, it is recommended to provide these teams a dedicated folder on the Curated Data Layer in which they can then then store the new results and share them with other teams across the organization.

## Lifecycle Management

Azure storage offers different access tiers, which allow you to store blob object data in the most cost-effective manner. The available access tiers include:

* **Hot** - Optimized for storing data that is accessed frequently.
* **Cool** - Optimized for storing data that is infrequently accessed and stored for at least 30 days.
* **Archive** - Optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements (on the order of hours).

The following considerations apply to the different access tiers:

* Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
* Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
* Data in the cool access tier can tolerate slightly lower availability but still requires high durability, retrieval latency, and throughput characteristics similar to hot data. For cool data, a slightly lower availability service-level agreement (SLA) and higher access costs compared to hot data are acceptable trade-offs for lower storage costs.
* Archive storage stores data offline and offers the lowest storage costs but also the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential pace. To manage costs for your expanding storage needs, it's helpful to organize your data based on attributes like frequency-of-access and planned retention period to optimize costs. Data stored in the cloud can be different based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

Each of these data access scenarios benefits from a different access tier that is optimized for a particular access pattern. With hot, cool, and archive access tiers, Azure Blob Storage addresses this need for differentiated access tiers with separate pricing models.

The Enterprise Analytics and AI solution pattern prescribes that you should implement a tiering policy for all three Azure Data Lake accounts.

## Key Considerations

When landing data into a data lake, it is important to pre-plan the structure of the data so that security, partitioning, and processing can be utilized effectively. Many of the following recommendations are applicable for all big data workloads. Every workload has different requirements on how the data is consumed.
|Consideration | Raw data |Enriched data |Curated data| Workspace data|
|-- | ----- | -- | -- | -- |
|Write Data| Domains | Domains | Data Products | Data Scientists and BI Analysts|
|Read Data| Domains | Domain and read access for others based on approval of Domain owner | Data Products, Analysts, Data Scientists, and Users | Data Scientists and Analysts|
|Data Lifecycle Management |Once enriched data is generated, can be moved to a cooler tier of storage to manage costs.| Older data can be moved to a cooler tier. |Older data can be moved to a cooler tier.| While the end consumers have control of this workspace, ensure that there are processes and policies to clean up data that is not necessary. |
|Folder Structure and Hierarchy| Folder structure to mirror Domain followed by source. | Folder structure to mirror Domain followed by sub-Domain | Folder structure mirrors data product structure |Folder structures mirror teams that the workspace is used by.|

>[!WARNING]
>Because some products do not support mounting the root of a data lake container, each data lake container in Raw, Curated and Enriched, and Workspace should have a single folder before branching off to multiple folders. The folder permissions should be carefully set up as during the creation of a new folder, from the root, the default ACL on the parent directory determines a child directory's default ACL and access ACL; a child file's access ACL (files do not have a default ACL). See [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

## Data Lakes Connectivity

Each of the data lakes should use Private Endpoints injected into the VNet of the Data Landing Zone. To allow access across landing zones, we propose connecting Data Landing Zones through VNet peering. This provides the optimal solution from both a cost perspective and an access control perspective.

See [Private Endpoints](./eslz-network-topology-and-connectivity.md#private-endpoints) and [Data Management Landing Zone to Data Landing Zone](./eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone)

>[!IMPORTANT]
>Data from a Data Landing Zone can be accessed from another Data Landing Zone over the VNet Peering between the Data Landing Zones using the private endpoints associated with each data lake account. We recommend turning off all public access to the lakes and using private endpoints. Network connectivity across Data Landing Zones (*e.g.* private links) are controlled by the Platform Ops team.

## Soft delete for containers (preview)

Soft delete for containers (preview) protects your data from being accidentally or maliciously deleted. When container soft delete is enabled for a storage account, any deleted containers and their contents are retained in Azure Storage for the period that you specify. During the retention period, you can restore previously deleted containers. Restoring a container restores any blobs within that container when it was deleted.

For end-to-end protection for your blob data, Microsoft recommends enabling the following data protection features:

* Container soft delete, to restore a container that has been deleted. To learn how to enable container soft delete, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).
* Blob soft delete, to restore a blob or version that has been deleted. To learn how to enable blob soft delete, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> Deleting a storage account cannot be undone. Container soft delete does not protect against the deletion of a storage account but only against the deletion of containers in that account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information about locking Azure Resource Manager resources, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Store business-critical blob data with immutable storage (preview)

Immutable storage for Azure Blob storage enables users to store business-critical data objects in a WORM (Write Once, Read Many) state. This state makes the data non-erasable and non-modifiable for a user-specified interval. For the duration of the retention interval, blobs can be created and read but cannot be modified or deleted. Immutable storage is available for general-purpose v1, general-purpose v2, BlobStorage, and BlockBlobStorage accounts in all Azure regions.

For information about how to set and clear legal holds or create a time-based retention policy using the Azure portal, PowerShell, or Azure CLI, see [Set and manage immutability policies for Blob storage](/azure/storage/blobs/storage-blob-immutability-policies-manage).

Immutable storage helps healthcare organization, financial institutions and related industries&mdash;particularly broker-dealer organizations&mdash;to store data securely. Immutable storage can also be leveraged in any scenario to protect critical data against modification or deletion.

For further information see [How Immutable storage for Azure Blob storage works](https://docs.microsoft.comazure/storage/blobs/storage-blob-immutable-storage#about-immutable-blob-storage)

Depending on your industry, it is recommended that immutable storage is assessed for use in the RAW Layer of the Data Lake.

## Multi-Region Deployments

Data Residency rules or the requirement to have data close to a user base will sometimes drive the requirement to create Azure Data Lake accounts in other Azure regions. It is recommended that you create a Data Landing Zone in the region and replicate global data using third-party products, azcopy or Azure Data Factory to copy the deltas between the regions. Thus this would allow local data to remain in region whilst global data could be replicated around for us by Data Product teams.

## Monitoring

In a Data Landing Zone all the monitoring should be sent to the Data Management Landing Zone for analysis.

Azure Storage collects the same kinds of monitoring data as other Azure resources, which are described in [Monitoring Azure resources with Azure Monitor](/azure/azure-monitor/insights/monitor-azure-resource). For more information on the logs and metrics created by Azure Storage, see [Monitoring Azure Blob storage](/azure/storage/blobs/monitor-blob-storage).

Log entries are created only if there are requests made against the service endpoint.

The following types of authenticated requests are logged:

* Successful requests
* Failed requests, including timeout, throttling, network, authorization, and other errors
* Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests
* Requests to analytics data (classic log data in the `$logs` container and class metric data in the `$metric` tables)

Requests made by the storage service itself, such as log creation or deletion, are not logged.

The following types of anonymous requests are logged:

* Successful requests
* Server errors
* Time-out errors for both client and server
* Failed GET requests with the error code 304 (Not Modified)

All other failed anonymous requests are not logged.

In a Data Landing Zone, all the monitoring is sent to the Data Management Landing Zone for analysis.

>[!IMPORTANT]
>Set default monitoring policy to audit storage and send logs to the Enterprise Scale Management Subscription.
