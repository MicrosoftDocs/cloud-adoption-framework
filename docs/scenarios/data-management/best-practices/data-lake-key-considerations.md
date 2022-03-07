---
title: Key considerations for Azure Data Lake Storage
description: Understand key Azure Data Lake Storage considerations for cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Azure Data Lake Storage key considerations

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

Data in the Cool tier has slightly lower availability, but offers the same high durability, retrieval latency, and throughput characteristics as the Hot tier. For data in the Cool tier, slightly lower availability and higher access costs could be acceptable trade-offs for lower overall storage costs, as compared to the Hot tier

For more information, see [Hot, Cool and Archive access tiers for blob data](/azure/storage/blobs/access-tiers-overview).

> [!CAUTION]
> For cloud-scale analytics we recommend that you implement [lifecycle management](../govern-lifecycle.md) using a custom microservice and carefully consider the impact of moving user discoverable data to cool storage.
>
>It is recommended to only move sections of the lake to cool tier for well understood workloads.

## Data lakes connectivity

Each of the data lakes should use private endpoints injected into the virtual network of the data landing zone. To provide access across landing zones, we propose connecting data landing zones through virtual network peering. This connection provides the optimal solution from both a cost perspective and an access control perspective.

For more information, see [Private endpoints](../eslz-network-topology-and-connectivity.md#private-endpoints) and [data management landing zone to data landing zone](../eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone).

> [!IMPORTANT]
> Data from a data landing zone can be accessed from another data landing zone over the virtual network peering between the zones. This is done using the private endpoints associated with each data lake account. We recommend turning off all public access to the lakes and using private endpoints. Network connectivity across data landing zones, like private links, are controlled by the platform operations team.

## Soft delete for containers

Soft delete for containers protects your data from being accidentally or maliciously deleted. When container soft delete is enabled for a storage account, any deleted containers and their contents are retained in Azure Storage for the period that you specify. During the retention period, you can restore previously deleted containers. Restoring a container restores any blobs within that container when it was deleted.

For end-to-end protection of your blob data, we recommend enabling the following data protection features:

- Container soft delete, to restore a container that has been deleted. To learn how to enable container soft delete, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).
- Blob soft delete, to restore a blob or version that has been deleted. To learn how to enable blob soft delete, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> Deleting a storage account can't be undone. Container soft delete does not protect against the deletion of a storage account, but only against the deletion of containers in that account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information about locking Azure Resource Manager resources, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Store business-critical blob data with immutable storage

Store business-critical data objects in a write once, read many (WORM) state with Azure Blob Storage. This state makes the data non-erasable and non-modifiable for a user-specified interval. During the retention interval, blobs can be created and read but can't be modified or deleted. Immutable storage is available for general-purpose v1, general-purpose v2, BlobStorage, and BlockBlobStorage accounts in all Azure regions.

For information about how to set and clear legal holds or create a time-based retention policy using the Azure portal, PowerShell, or Azure CLI, see [Set and manage immutability policies for Blob Storage](/azure/storage/blobs/immutable-policy-configure-version-scope).

Immutable storage helps healthcare organizations, financial institutions, and related industries. Particularly for broker-dealer organizations to store data securely. Immutable storage can also be used in any scenario to protect critical data against modification or deletion.

For more information, see [How immutable storage for Azure Blob Storage works](/azure/storage/blobs/immutable-storage-overview#about-immutable-blob-storage).

Depending on your industry, we recommend that you assess immutable storage for use in the raw layer of the data lake.

## Monitoring

In a data landing zone, all the monitoring should be sent to the [enterprise-scale management subscription](../../../ready/landing-zone/design-area/management.md) for analysis.

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
- Failed HTTP GET requests with the error code 304 (`Not Modified`).

All other failed anonymous requests aren't logged.

> [!IMPORTANT]
> Set your default monitoring policy to audit storage and send logs to the enterprise-scale management subscription.

## Next steps

[Access control and data lake configurations in Azure Data Lake Storage Gen2](./data-lake-access.md)
