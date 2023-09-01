---
title: Key considerations for Azure Data Lake Storage
description: Understand key Azure Data Lake Storage considerations for cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 04/04/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Azure Data Lake Storage key considerations

Learn about key storage considerations for your Azure data lakes.

## Lifecycle management

Azure Storage offers different access tiers, which allows you to store blob object data in the most cost-effective manner possible. The available access tiers include:

- **Hot:** Optimized for storing data that's accessed frequently.
- **Cool:** Optimized for storing data that's infrequently accessed. Data is stored for at least 30 days.
- **Archive:** Optimized for storing data that's rarely accessed. The data is stored for at least 180 days with flexible latency requirements, on the order of hours.

Consider the following information when using access tiers:

- Only the Hot and Cool access tiers can be set at the account level. The Archive access tier isn't available at the account level.

- Hot, Cool, and Archive tiers can all be set at the blob level during upload or after upload.

- Data in the Cool tier has slightly lower availability, but offers the same high durability, retrieval latency, and throughput characteristics as Hot tier data. For data in the Cool tier, slightly lower availability and higher access costs can be acceptable trade-offs for lower overall storage costs compared to the Hot tier.

- Archive storage stores data offline and offers the lowest storage costs. However, it also carries the highest data rehydration and access costs.

For more information, see [Hot, Cool and Archive access tiers for blob data](/azure/storage/blobs/access-tiers-overview).

> [!CAUTION]
> For cloud-scale analytics, we recommend that you implement [lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md) using a custom microservice and carefully consider the impact of moving user discoverable data to cool storage.
>
> You should only move sections of your data lake to cool tier for well understood workloads.

## Data lakes connectivity

Each of your data lakes should use private endpoints injected into the virtual network of your data landing zone. To provide access across landing zones, connect your data landing zones through virtual network peering. This connection provides an optimal solution from both a cost and access control perspective.

For more information, see [Private endpoints](../eslz-network-topology-and-connectivity.md#private-endpoints) and [Data management landing zone to data landing zone](../eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone).

> [!IMPORTANT]
> Data from a data landing zone can be accessed from another data landing zone over virtual network peering between the zones. This is done using the private endpoints associated with each data lake account. We recommend turning off all public access to your lakes and using private endpoints. Your platform operations team should control network connectivity across your data landing zones.

## Soft delete for containers

Soft delete for containers protects your data from accidental or malicious deletion. If you enable container soft delete for your storage account, deleted containers and their contents are retained in Azure Storage for a length of time you choose. During the data retention period, you can restore previously deleted containers. Restoring a container also restores any blobs that were within that container when it was deleted.

Enable the following data protection features to achieve end-to-end blob data protection:

- Container soft delete, to restore a container that has been deleted. To learn how to enable container soft delete, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).
- Blob soft delete, to restore a blob or version that has been deleted. To learn how to enable blob soft delete, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> Deleting a storage account can't be undone. Container soft delete does not protect against storage account deletion, only against the deletion of containers within an account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information about locking Azure Resource Manager resources, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Monitoring

In a data landing zone, all monitoring should be sent to your [enterprise-scale management subscription](../../../ready/landing-zone/design-area/management.md) for analysis.

To learn about the monitoring data Azure Storage uses, see [Monitoring Azure resources with Azure Monitor](/azure/azure-monitor/essentials/monitor-azure-resource). For more information on the logs and metrics Azure Storage creates, see [Monitoring Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage).

Log entries are only created if requests are made against the service endpoint. The types of authenticated requests logged are:

- Successful requests
- Failed requests, including timeout, throttling, network, authorization, and other errors
- Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests
- Requests to analytics data, like classic log data in the `$logs` container and class metric data in the `$metric` tables

Requests made by the storage service itself, like log creation or deletion, aren't logged. The types of anonymous requests logged are:

- Successful requests
- Server errors
- Time out errors for both client and server
- Failed HTTP GET requests with the error code 304 (`Not Modified`)

All other failed anonymous requests aren't logged.

> [!IMPORTANT]
> Set your default monitoring policy to audit storage and send logs to your enterprise-scale management subscription.

## Next steps

- [Access control and data lake configurations in Azure Data Lake Storage Gen2](./data-lake-access.md)
