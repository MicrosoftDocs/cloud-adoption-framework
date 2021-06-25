---
title: Azure Enterprise Scale Analytics and AI Teams Data Lake Key Considerations
description: Enterprise Scale Analytics and AI Architecture Data Lake Key Considerations
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 06/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Data Lake Key Considerations

When landing data into a data lake, it is important to pre-plan the structure of the data so that security, partitioning, and processing can be utilized effectively. Many of the following recommendations are applicable for all big data workloads. Every workload has different requirements on how the data is consumed, therefore the list below general recommendation. Please work with your system integrator on the right level of AD groups for your implementation of this construction set.

## Lifecycle Management

Azure storage offers different access tiers, which allow you to store blob object data in the most cost-effective manner. The available access tiers include:

- **Hot** - Optimized for storing data that is accessed frequently.
- **Cool** - Optimized for storing data that is infrequently accessed and stored for at least 30 days.
- **Archive** - Optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements (on the order of hours).

The following considerations apply to the different access tiers:

- Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
- Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
- Data in the cool access tier can tolerate slightly lower availability but still requires high durability, retrieval latency, and throughput characteristics similar to hot data. For cool data, a slightly lower availability service-level agreement (SLA) and *higher access costs* compared to hot data are acceptable trade-offs for lower storage costs.
- Archive storage stores data offline and offers the lowest storage costs but also the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential pace. To manage costs for your expanding storage needs, it's helpful to organize your data based on attributes like frequency-of-access and planned retention period to optimize costs. Data stored in the cloud can be different based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

Each of these data access scenarios benefits from a different access tier that is optimized for a particular access pattern. With hot, cool, and archive access tiers, Azure Blob Storage addresses this need for differentiated access tiers with separate pricing models.

The Enterprise Analytics and AI construction set prescribes that you should implement a tiering policy for all three Azure Data Lake accounts.

Lifecycle management uses a rule-based policy. You should use the policy to transition your data to the appropriate access tiers or to expire at the end of the data's lifecycle.

The lifecycle management policy lets you:

- Transition blobs from cool to hot immediately if accessed to optimize for performance.
- Transition blobs, blob versions, and blob snapshots to a cooler storage tier (hot to cool, hot to archive or cool to archive) if not accessed or modified for a period of time to optimize for cost.
- Delete blobs, blob versions, and blob snapshots at the end of their lifecycle.
- Define rules to be run once per day at the storage account level.
- Apply rules to containers or a subset of blobs (using name prefixes or blob index tags as filters).

For example, suppose a system has data that is used frequently during the first stages of the lifecycle but only occasionally after a month. After two months, the dataset is rarely used. In this scenario, hot storage is best during the first month. Cool storage is most cost optimal for occasional access. Archive storage is the best tier option after the data gets old. Use a lifecycle management policy rule to automatically move aging data to cooler tiers.

## Data Lakes Connectivity

Each of the data lakes should use Private Endpoints injected into the VNet of the Data Landing Zone. To allow access across landing zones, we propose connecting Data Landing Zones through VNet peering. This provides the optimal solution from both a cost perspective and an access control perspective.

See [Private Endpoints](./eslz-network-topology-and-connectivity.md#private-endpoints) and [Data Management Landing Zone to Data Landing Zone](./eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone)

>[!IMPORTANT]
>Data from a Data Landing Zone can be accessed from another Data Landing Zone over the VNet Peering between the Data Landing Zones using the private endpoints associated with each data lake account. We recommend turning off all public access to the lakes and using private endpoints. Network connectivity across Data Landing Zones (*e.g.* private links) are controlled by the Platform Ops team.

## Soft delete for containers (preview)

Soft delete for containers (preview) protects your data from being accidentally or maliciously deleted. When container soft delete is enabled for a storage account, any deleted containers and their contents are retained in Azure Storage for the period that you specify. During the retention period, you can restore previously deleted containers. Restoring a container restores any blobs within that container when it was deleted.

For end-to-end protection for your blob data, Microsoft recommends enabling the following data protection features:

- Container soft delete, to restore a container that has been deleted. To learn how to enable container soft delete, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).
- Blob soft delete, to restore a blob or version that has been deleted. To learn how to enable blob soft delete, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> Deleting a storage account cannot be undone. Container soft delete does not protect against the deletion of a storage account but only against the deletion of containers in that account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information about locking Azure Resource Manager resources, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Store business-critical blob data with immutable storage (preview)

Immutable storage for Azure Blob storage enables users to store business-critical data objects in a WORM (Write Once, Read Many) state. This state makes the data non-erasable and non-modifiable for a user-specified interval. For the duration of the retention interval, blobs can be created and read but cannot be modified or deleted. Immutable storage is available for general-purpose v1, general-purpose v2, BlobStorage, and BlockBlobStorage accounts in all Azure regions.

For information about how to set and clear legal holds or create a time-based retention policy using the Azure portal, PowerShell, or Azure CLI, see [Set and manage immutability policies for Blob storage](/azure/storage/blobs/storage-blob-immutability-policies-manage).

Immutable storage helps healthcare organization, financial institutions and related industries; particularly broker-dealer organizations; to store data securely. Immutable storage can also be leveraged in any scenario to protect critical data against modification or deletion.

For further information see [How Immutable storage for Azure Blob storage works](/azure/storage/blobs/storage-blob-immutable-storage#about-immutable-blob-storage)

Depending on your industry, it is recommended that immutable storage is assessed for use in the RAW Layer of the Data Lake.

## Multi-Region Deployments

Data Residency rules or the requirement to have data close to a user base will sometimes drive the requirement to create Azure Data Lake accounts in other Azure regions. It is recommended that you create a Data Landing Zone in the region and replicate global data using third-party products, azcopy or Azure Data Factory to copy the deltas between the regions. Thus this would allow local data to remain in region whilst global data could be replicated around for us by Data Product teams.

## Monitoring

In a Data Landing Zone, all the monitoring should be sent to the [Enterprise-Scale Management Subscription](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring?branch=scenario-data-management) for analysis.

Azure Storage collects the same kinds of monitoring data as other Azure resources, which are described in [Monitoring Azure resources with Azure Monitor](/azure/azure-monitor/insights/monitor-azure-resource). For more information on the logs and metrics created by Azure Storage, see [Monitoring Azure Blob storage](/azure/storage/blobs/monitor-blob-storage).

Log entries are created only if there are requests made against the service endpoint.

The following types of authenticated requests are logged:

- Successful requests
- Failed requests, including timeout, throttling, network, authorization, and other errors
- Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests
- Requests to analytics data (classic log data in the `$logs` container and class metric data in the `$metric` tables)

Requests made by the storage service itself, such as log creation or deletion, are not logged.

The following types of anonymous requests are logged:

- Successful requests
- Server errors
- Time-out errors for both client and server
- Failed GET requests with the error code 304 (Not Modified)

All other failed anonymous requests are not logged.

>[!IMPORTANT]
>Set default monitoring policy to audit storage and send logs to the Enterprise Scale Management Subscription.


