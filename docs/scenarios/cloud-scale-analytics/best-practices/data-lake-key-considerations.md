---
title: Key Considerations for Azure Data Lake Storage
description: Understand key Azure Data Lake Storage considerations for cloud-scale analytics so that you can choose the appropriate access tier for your workload.
author: stephen-sumner
ms.author: pnp
ms.date: 1/7/2025
ms.topic: concept-article
ms.custom: e2e-data-management, think-tank
---

# Key considerations for Azure Data Lake Storage

Azure Storage offers a variety of storage options for your data. This article provides considerations to help you choose the appropriate access tier so that you can balance cost and performance. It also describes the lifecycle management of Storage, including features and best practices to help you use the access tiers effectively.

## Lifecycle management

Azure Storage offers various access tiers that you can use to store blob object data. Choose the tier that best suits your workload to optimize cost.

- Use a **hot tier** to store frequently accessed data.

- Use a **cool tier** to store infrequently accessed data. This tier stores data for at least 30 days.
- Use a **cold tier** to store infrequently accessed or modified data. This tier stores data for at least 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.
- Use an **archive tier** to store rarely accessed data. This tier stores data for at least 180 days. Access to this data can have flexible latency requirements, which means that it can take hours to retrieve data.

> [!IMPORTANT]
> The online access tiers (hot, cool, and cold) don't have reliability, security, operational excellence, or performance efficiency trade-offs. Therefore, you should base your decision on the cost for each blob. Consider your workload access data size, operational interactions, and the time before the blob is deleted. [Select the appropriate tier](https://azure.github.io/Storage/docs/application-and-user-data/code-samples/estimate-block-blob) for each blob based on these factors. For more information, see [Plan and manage costs for Azure Blob Storage ](/azure/storage/common/storage-plan-manage-costs).

Consider the following factors when you use access tiers:

- Set only the hot and cool access tiers at the account level. The account level doesn't support the archive access tier.

- Set the hot, cool, and archive tiers at the blob level during upload or after upload.

- Data in the cool and cold tiers has slightly lower availability, but these tiers offer features that are similar to those of the hot tier, such as high durability, retrieval latency, and throughput. For data in the cool or cold tiers, lower availability and higher access costs are acceptable trade-offs for reduced storage costs compared to the hot tier.

- Archive storage stores data offline and offers the lowest storage costs. But it also incurs the highest data rehydration and access costs.

For more information, see [Access tiers for blob data](/azure/storage/blobs/access-tiers-overview).

> [!IMPORTANT]
> For cloud-scale analytics, use a custom microservice to implement [lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md). Carefully consider the impact of moving user-discoverable data to cool storage. Move sections of your data lake to the cool tier only for well-understood workloads.

## Data lake connectivity

Each data lake should use private endpoints that you integrate into the virtual network of your data landing zone. To provide access across landing zones, connect your data landing zones through virtual network peering. This connection provides an optimal solution from both a cost and access-control perspective.

For more information, see [Private endpoints](../eslz-network-topology-and-connectivity.md#private-endpoints) and [Data management landing zone to data landing zone](../eslz-network-topology-and-connectivity.md#data-management-landing-zone-to-data-landing-zone).

> [!IMPORTANT]
> A data landing zone can access data in a different data landing zone via virtual network peering. Private endpoints establish the connection associated with each data lake account. We recommend that you turn off all public access to your lakes and use private endpoints. Your platform operations team should control network connectivity across your data landing zones.

## Soft delete for containers

Soft delete for containers helps protect your data from accidental or malicious deletion. If you enable container soft delete for your storage account, Storage retains deleted containers and their contents for a specified length of time. During the data-retention period, you can restore previously deleted containers. This action also restores blobs that were in that container when it was deleted.

Enable the following data-protection features to enhance end-to-end blob data protection:

- Use container soft delete to restore a deleted container. For more information, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).

- Use blob soft delete to restore a deleted blob or version. For more information, see [Enable and manage soft delete for blobs](/azure/storage/blobs/soft-delete-blob-enable).

> [!WARNING]
> After you delete a storage account, you can't undo the deletion. Container soft delete doesn't protect against storage account deletion, only against the deletion of containers within an account. To protect a storage account from deletion, configure a lock on the storage account resource. For more information, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

## Monitoring

In a data landing zone, send all monitoring to your [Azure landing zone management subscription](../../../ready/landing-zone/design-area/management.md) for analysis.

For more information, see [Monitor Azure resources with Azure Monitor](/azure/azure-monitor/platform/monitor-azure-resource) and [Monitor Blob Storage](/azure/storage/blobs/monitor-blob-storage).

Log entries are created only for requests against the service endpoint. The following types of authenticated requests are logged:

- Successful requests
- Failed requests, including timeouts, throttling, network problems, authorization problems, and other errors
- Requests that use a shared access signature (SAS) or OAuth, including failed and successful requests
- Requests to analytics data, like classic log data in the `$logs` container and classic metric data in the `$metric` tables

Requests made by the storage service itself, like log creation or deletion, aren't logged. The following types of anonymous requests are logged:

- Successful requests
- Server errors
- Time out errors for both client and server
- Failed HTTP GET requests that have the error code 304 (`Not Modified`)

Other failed anonymous requests aren't logged.

> [!IMPORTANT]
> Set your default monitoring policy to audit storage and send logs to your enterprise-scale management subscription.

## Data lake zone security

We recommend the following security patterns for data lake zones:

- **Raw usage** allows access to data by using security principal names (SPNs) only. We recommend that you use managed identities.

- **Enriched usage** allows access to data by using SPNs only. We recommend that you use managed identities.
- **Curated usage** allows access to data by using SPNs and user principal names (UPNs).

For more information, see [Access control model in Data Lake Storage](/azure/storage/blobs/data-lake-storage-access-control-model).

## Next step

- [The ingest process with cloud-scale analytics in Azure](data-ingestion.md)