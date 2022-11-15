---
title: 'Finance HPC Storage | Microsoft Docs'
description: 'Large-scale HPC workloads in finance have demands for data storage and access that exceed the capabilities of traditional cloud file systems.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Storage for finance HPC

Large-scale HPC workloads have demands for data storage and access that exceed the capabilities of traditional cloud file systems.

## Design considerations:

Below are the factors you would need to consider and identify about your application requirement to decide on what storage solution to use

 - Latency,
 - IOPS,
 - Throughput,
 - File sizes and count,
 - Job run time
 - Cost associated
 - Affinity for storage location – on-premises vs Azure

## Design recommendations:

[Standard or premium blob storage](/azure/storage/blobs/storage-blobs-introduction) for high throughput /low latency storage.

 - It provides exabyte scale, high throughput, low latency access where necessary, familiar file system and multi-protocol access (REST, HDFS, NFS)
 - It is cost effective being the lowest cost cloud offering.
 - You can mount the blob storage as a file system using [Blobfuse driver](/azure/storage/blobs/storage-how-to-mount-container-linux) making it easy to allow multiple nodes to mount the same container for read-only scenarios.
 - You can make use of the NFS v3.0 at the blob service endpoint for high throughput and read heavy workloads.
 - You can optimize costs by moving to cooler tiers with the ability to perform lifecycle management with last update/ last access time, intelligent tiering with customizable policies

[Azure NetApp Files](/azure/azure-netapp-files/) for Read/write-many (unique), Write-once, read-once applications

 - Provides the widest choice of file protocols (NFSv3, NFSv4.1, SMB3) in the public cloud.
 - On-premises class performance with multiple tiers (Ultra, Premium, Standard).
 - Deploys in minutes and offers wide range of tiers and flexibility.
 - You can use it when you require flexible capacity pool types and performance, where the QoS per volume is automatically assigned based on the Tier of the Pool and the volume quota.

| Category | Azure Blob Storage | Azure Files | Azure NetApp Files |
| -- | -- | -- | -- |
| Use cases | Blob Storage is best suited for large scale read-heavy sequential access workloads where data is ingested once and minimally modified further. <br><br> Blob Storage offers the lowest total cost of ownership, if there is little or no maintenance. | Azure Files is a highly available service best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support and can easily be used from container platforms like Azure Container Instance (ACI) and Azure Kubernetes Service (AKS) with the built-in CSI driver, in addition to VM-based platforms. | Fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities. |
| Available protocols | NFS 3.0 <br><br>REST <br><br>Data Lake Storage Gen2 | SMB <br><br> NFS 4.1 <br><br>(No interoperability between either protocol) | NFS 3.0 and 4.1 <br><br> SMB <br><br><br> |
| Key features | Integrated with HPC cache for low latency workloads. <br><br> Integrated management, including lifecycle, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | Extremely low latency (as low as sub-ms). <br><br> Rich NetApp ONTAP management capability such as SnapMirror in cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (Per volume) | Up to 20,000 IOPS, up to 100 Gib/s throughput. | Up to 100,000 IOPS, up to 80 Gib/s throughput. | Up to 460,000 IOPS, up to 36 Gib/s throughput. |
| Scale | Up to 2 PiB for a single volume. <br><br> Up to ~4.75 TiB max for a single file. <br><br> No minimum capacity requirements. | Up to 100 TiB for a single file share. <br><br> Up to 4 TiB for a single file. <br><br> 100 GiB min capacity. | Up to 100 TiB for a single volume. <br><br> Up to 16 TiB for a single file. <br><br> Consistent hybrid cloud experience. |
| Pricing | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files/) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp/) |


## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
