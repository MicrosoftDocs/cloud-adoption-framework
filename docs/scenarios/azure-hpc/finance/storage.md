---
title: Storage for Azure HPC in the finance sector   
description: This article provides recommendations for implementing storage in HPC environments for the finance sector.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/15/2022
---

# Storage for HPC in the finance sector

This article provides recommendations for implementing storage in HPC environments for the finance sector. Large-scale HPC workloads in finance environments create demands for data storage and access that exceed the capabilities of traditional cloud file systems.

## Design considerations

To decide which storage solution to use, you need to take into account the following application requirements.

 - Latency
 - IOPS
 - Throughput
 - File sizes and number
 - Job runtime
 - Associated costs
 - Affinity for storage location: on-premises versus Azure

## Design recommendations

- Use [Standard or Premium Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction) for high-throughput, low-latency storage. It offers these benefits: 

   - It provides exabyte-scale, high-throughput, low-latency access where necessary, a familiar file system, and multi-protocol access (REST, HDFS, NFS).
   - It's cost effective.
   - You can mount Blob Storage as a file system by using [BlobFuse](/azure/storage/blobs/storage-how-to-mount-container-linux). Doing so makes it easy to allow multiple nodes to mount the same container for read-only scenarios.
   - It supports NFS 3.0 at the blob service endpoint for high-throughput, read-heavy workloads.
   - You can  optimize costs by moving data to cooler tiers via the ability to perform lifecycle management with last update/access time intelligent tiering, with customizable policies.

- Use [Azure NetApp Files](/azure/azure-netapp-files) for ReadWriteMany (unique) or write-once, read-once applications. It provides these benefits: 

   - A wide choice of file protocols (NFSv3, NFSv4.1, SMB3).
   - Performance that's comparable with on-premises performance, with multiple tiers (Ultra, Premium, Standard).
   - Deploys in minutes and offers a wide range of tiers and flexibility.
   - Flexible capacity pool types and performance, where the QoS per volume is automatically assigned based on the tier of the pool and the volume quota.

The following table provides a comparison of Blob Storage, Azure NetApp Files, and Azure Files. 

|  | Blob Storage | Azure Files | Azure NetApp Files |
| -- | -- | -- | -- |
| **Use cases** | Best suited for large-scale read-heavy sequential access workloads where data is ingested once and minimally modified. <br><br> Low total cost of ownership, if there's light maintenance. | A highly available service that's best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support. The built-in CSI driver enables you to easily use it from container platforms like Azure Container Instances and Azure Kubernetes Service (AKS), in addition to VM-based platforms. | A fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> Azure NetApp Files is suited for workloads that require random access. It provides broad protocol support and improved data protection. |
| **Available protocols** | NFS 3.0 <br><br>REST <br><br>Azure Data Lake Storage  | SMB <br><br> NFS 4.1 <br><br>(No interoperability between either protocol.) | NFS 3.0 and 4.1 <br><br> SMB <br><br><br> |
| **Key features** | Integrated with Azure HPC Cache for low-latency workloads. <br><br> Integrated management, including lifecycle management, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | Extremely low latency (as low as sub-millisecond). <br><br> Rich NetApp ONTAP management capability, like SnapMirror Cloud. <br><br> Consistent hybrid cloud experience. |
| **Performance (per volume)** | As much as 20,000 IOPS. As much as 100 GiBps throughput. | As much as 100,000 IOPS. As much as 80 GiBps throughput. | As much as 460,000 IOPS. As much as 36 GiBps throughput. |
| **Scale** | As much as 2 PiB for a single volume. <br><br> As much as ~4.75 TiB for a single file. <br><br> No minimum capacity requirements. | As much as 100 TiB for a single volume. <br><br> As much as 4 TiB for a single file. <br><br> 100 GiB minimum capacity. | As much as 100 TiB for a single volume. <br><br> As much as 16 TiB for a single file. <br><br> Consistent hybrid cloud experience. |
| **Pricing** | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp) |


## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC in the finance sector.

- [Azure billing offers and Active Directory tenants for finance HPC](./azure-billing-active-directory-tenant.md)
- [Finance HPC Azure identity and access management](./identity-access-management.md)
- [Management for HPC in the finance sector](./management.md)
- [Network topology and connectivity for HPC in the finance sector](./network-topology-connectivity.md)
- [Platform automation and DevOps for HPC in the finance sector](./platform-automation-devops.md)
- [Resource organization for Azure HPC in the finance sector](./resource-organization.md)
- [Governance for finance HPC](./security-governance-compliance.md)
- [Security for HPC in the finance sector](./security.md)
- [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)