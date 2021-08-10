---
title: Azure enterprise-scale data lake key considerations
description: Learn about key considerations for enterprise-scale for analytics and AI architecture for Azure Data Lake Storage.
author: mboswell
ms.author: mboswell
ms.date: 08/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Key considerations for Azure Data Lake Storage

Learn about important considerations for your Azure data lakes.

## Lifecycle management

Azure Storage offers different access tiers, which allow you to store blob object data in the most cost-effective manner. The available access tiers include:

- **Hot:** Optimized for storing data that's accessed frequently.
- **Cool:** Optimized for storing data that's infrequently accessed, and stored for at least 30 days.
- **Archive:** Optimized for storing data that's rarely accessed. The data is stored for at least 180 days with flexible latency requirements, on the order of hours.

The following considerations apply to the different access tiers:

- Only the hot and cool access tiers can be set at the account level. The archive access tier isn't available at the account level.
- Hot, cool, and archive tiers can be set at the blob level during upload or after upload.
- Data in the cool access tier can tolerate slightly lower availability. But this data still requires high durability, retrieval latency, and throughput characteristics similar to hot data. For cool data, a slightly lower availability service-level agreement (SLA) and *higher access costs* compared to hot data are acceptable trade-offs for lower storage costs.
- Archive storage stores data offline and offers the lowest storage costs. However, it also has the highest data rehydrate and access costs.

Data stored in the cloud grows at an exponential rate. To manage costs for your expanding storage needs, it's helpful to organize your data based on attributes like frequency-of-access and planned retention period to optimize costs. Data stored in the cloud can be different based on how it's generated, processed, and accessed over its lifetime. Some data is actively accessed and modified throughout its lifetime. Some data is accessed frequently early in its lifetime, with access dropping drastically as the data ages. Some data remains idle in the cloud and is rarely, if ever, accessed after it's stored.

These data access scenarios benefits from a different access tier that's optimized for a particular access pattern. With hot, cool, and archive access tiers, Azure Blob Storage addresses this need for differentiated access tiers with separate pricing models.

Enterprise-scale for analytics and AI recommends that you implement a tiering policy for all three Data Lake Storage accounts.

Lifecycle management uses a rule-based policy. Use this policy to transition your data to the appropriate access tiers or to expire at the end of the data's lifecycle.

With the lifecycle management policy, you can:

- Transition blobs from cool to hot immediately if accessed to optimize for performance.
- Transition blobs, blob versions, and blob snapshots to a cooler storage tier to optimize for cost. This transition is useful if the blobs are not accessed or modified for a period of time. For example, hot to cool, hot to archive, or cool to archive.
- Delete blobs, blob versions, and blob snapshots at the end of their lifecycle.
- Define rules to be run once per day at the storage account level.
- Apply rules to containers or a subset of blobs by using name prefixes or blob index tags as filters.

For example, suppose a system has data that's used frequently during the first stages of the lifecycle, but then only occasionally after a month. After two months, the dataset is rarely used. In this scenario, hot storage is best during the first month. Cool storage is the most cost optimal for occasional access. Archive storage is the best tier option after the data gets old. You can use a lifecycle management policy rule to automatically move aging data to cooler tiers.

## Data lakes connectivity

Each of the data lakes should use private endpoints injected into the virtual network of the data landing zone. To provide access across landing zones, we propose connecting data landing zones through virtual network peering. This connection provides the optimal solution from both a cost perspective and an access control perspective.

For more information, see [Private endpoints](../eslz-network-topology-and-connectivity.md#private-endpoints) and [data management landing zone to data landing zone](../eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone).

> [!IMPORTANT]
> Data from a data landing zone can be accessed from another data landing zone over the virtual network peering between the zones. This is done using the private endpoints associated with each data lake account. We recommend turning off all public access to the lakes and using private endpoints. Network connectivity across data landing zones, like private links, are controlled by the platform operations team.

## Soft delete for containers (preview)

Soft delete for containers (preview) protects your data from being accidentally or maliciously deleted. When container soft delete is enabled for a storage account, any deleted containers and their contents are retained in Azure Storage for the period that you specify. During the retention period, you can restore previously deleted containers. Restoring a container restores any blobs within that container when it was deleted.

For end-to-end protection of your blob data, we recommend enabling the following data protection features:

- Container soft delete, to restore a container that has been deleted. To learn how to enable container soft delete, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).
- Blob soft delete, to restore a blob or version that has been deleted. To learn how to enable blob soft delete, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> Deleting a storage account can't be undone. Container soft delete does not protect against the deletion of a storage account, but only against the deletion of containers in that account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information about locking Azure Resource Manager resources, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Store business-critical blob data with immutable storage (preview)

Store business-critical data objects in a write once, read many (WORM) state with Azure Blob Storage. This state makes the data non-erasable and non-modifiable for a user-specified interval. During the retention interval, blobs can be created and read but can't be modified or deleted. Immutable storage is available for general-purpose v1, general-purpose v2, BlobStorage, and BlockBlobStorage accounts in all Azure regions.

For information about how to set and clear legal holds or create a time-based retention policy using the Azure portal, PowerShell, or Azure CLI, see [Set and manage immutability policies for Blob Storage](/azure/storage/blobs/immutable-policy-configure-version-scope).

Immutable storage helps healthcare organizations, financial institutions, and related industries. Particularly for broker-dealer organizations to store data securely. Immutable storage can also be used in any scenario to protect critical data against modification or deletion.

For more information, see [How immutable storage for Azure Blob Storage works](/azure/storage/blobs/immutable-storage-overview#about-immutable-blob-storage#about-immutable-blob-storage).

Depending on your industry, we recommend that you assess immutable storage for use in the raw layer of the data lake.

## Monitoring

In a data landing zone, all the monitoring should be sent to the [enterprise-scale management subscription](../../../ready/enterprise-scale/management-and-monitoring.md) for analysis.

Learn how Azure Storage collects the same kinds of monitoring data as other Azure resources in [Monitoring Azure resources with Azure Monitor](/azure/azure-monitor/essentials/monitor-azure-resource). For more information on the logs and metrics created by Azure Storage, see [Monitoring Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage).

Log entries are created only if there are requests made against the service endpoint.

The types of authenticated requests logged are:

- Successful requests.
- Failed requests, including timeout, throttling, network, authorization, and other errors.
- Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests.
- Requests to analytics data like classic log data in the `$logs` container, and class metric data in the `$metric` tables.

Requests made by the storage service itself, like log creation or deletion, aren't logged.

The types of anonymous requests logged are:

- Successful requests.
- Server errors.
- Time out errors for both client and server.
- Failed GET requests with the error code 304, Not Modified.

All other failed anonymous requests aren't logged.

> [!IMPORTANT]
> Set your default monitoring policy to audit storage and send logs to the enterprise-scale management subscription.

## Next steps

- [Understanding access control and data lake configurations in Azure Data Lake Storage Gen2](./data-lake-access.md)
