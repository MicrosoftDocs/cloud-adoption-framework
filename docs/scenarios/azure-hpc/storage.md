---
title: Storage for Azure HPC Workloads
description: Learn how to use Azure Storage for high-performance computing (HPC) workloads in energy environments, the finance sector, and for manufacturing.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 12/06/2024
---

# Storage for Azure HPC workloads

Storage access is crucial to plan for HPC workload performance. Large-scale HPC workloads in certain environments can create demands for data storage and access that exceed the capabilities of traditional cloud file systems. This article provides recommendations to help you choose the correct storage for your Azure HPC workloads. It also provides recommendations about storage for HPC energy environments, storage for HPC in the finance sector, and for manufacturing HPC storage.

The following are the factors you need to consider and identify about your application requirement to help decide which storage solution to use:

- Latency
- Input/Output operations per second (IOPS)
- Throughput
- File sizes and count
- Job run time
- Cost associated
- Affinity for storage location – on-premises versus Azure

For more information, see [Understand factors that influence HPC storage selection in Azure](https://learn.microsoft.com/training/modules/hpc-storage-considerations/).

The following diagram shows a decision tree that's for a specific HPC storage system choice.

:::image type="content" alt-text="Diagram that shows a decision tree of considerations when you choose a storage solution." source="../media/storage-selection-flow.png" lightbox="../media/storage-selection-flow.png":::

## HPC considerations

Oil and gas companies must be able to effectively manage and store exabytes of seismic data, well data, maps, leases, and more. To put this data to use, they need a high-performance infrastructure that can process and deliver real-time analytics to help optimize production, reduce environmental risks, and enhance operational safety.

[Data storage](/azure/architecture/topics/high-performance-computing#storage) and access needs vary widely, depending on workload scale. Azure supports several approaches for managing the speed and capacity of HPC applications.

Large-scale Batch and HPC workloads in the energy industry have demands for data storage and access that exceed the capabilities of traditional cloud file systems. The high-performance input/output (I/O) requirements and massive scalability needs of [high-performance computing (HPC)](https://azure.microsoft.com/solutions/high-performance-computing/) introduces unique challenges for data storage and access.

HPC solves complex problems like seismic and reservoir simulations and modeling, which aren't practical or cost-effective to handle with traditional computing techniques. HPC solves these problems through a combination of parallel processing and massive scalability to perform large and complicated computing tasks quickly, efficiently, and reliably.

In Azure HPC clusters, compute nodes are virtual machines (VMs) that you can quickly create to perform jobs that are assigned to the cluster. These nodes distribute computation tasks across the cluster. This distribution helps achieve the high-performance parallel processing that's required to solve complex HPC problems. Compute nodes need to perform read and write operations on shared working storage as they execute jobs. Nodes access this storage a continuum between the following two scenarios:

- **One set of data to many compute nodes.** In this scenario, there's a single data source on the network that all the compute nodes access for working data. Though they're structurally simple, the I/O capacity of the storage location limits the I/O operations.

- **Many sets of data to many compute nodes.** In this scenario, there's a single data source on the network that all the compute nodes access for working data. Though they're structurally simple, the I/O capacity of the storage location limits the I/O operations.

## HPC design recommendations

Choose the solution that's best suited for your unique I/O and capacity requirements.

### Network File System

Network File System (NFS) is often used to provide access to shared storage locations. A server VM that uses NFS shares its local file system. In Azure, this file system is stored on one or more virtual hard disks (VHDs) that are hosted in Azure Storage. Clients can then mount the server's shared files and access the shared location directly.

NFS is often used for home directories and project space mounted across all nodes. It can also often provide a space for research groups sharing data. In general, the throughput workloads are horizontally scalable with little dependency between individual tasks. Job schedulers divvy up the work across nodes and coordinate the activity. NFS is the typical shared storage across the nodes which is accessed via TCP/IP networks.

NFS has the advantage of being easy to set up and maintain and is supported on both Linux and Windows operating systems. Multiple NFS servers can be used to spread storage across a network, but individual files are only accessible through a single server.

For low-scale workloads, consider running NFS on the head node, using a [Storage](/azure/virtual-machines/sizes-storage) optimized VM that has large ephemeral disks, or D-series VMs with Azure Premium Storage, depending on your requirements. This solution suits workloads that have 500 cores or fewer.

In HPC scenarios, the file server can often serve as a bottleneck that throttles overall performance. Attempts to access uncached data from a single NFS server at rates higher than the documented per-VM maximum IOPS and throughput results in throttling.

In a scenario where dozens of clients attempt to work on data stored on a single NFS server, you can easily reach these limits. These limits can cause your entire application's performance to suffer. The closer to a pure one-to-many scenario your HPC application uses, the sooner you encounter these limitations.

### Parallel file systems on Azure

Parallel file systems distribute block-level storage across multiple networked storage nodes. File data is spread among these nodes, which means that file data is spread among multiple storage devices. This distribution pools any individual storage I/O requests across multiple storage nodes that are accessible through a common namespace.

Multiple storage devices and multiple paths to data are used to provide a high degree of parallelism. This approach reduces the number of bottlenecks imposed by accessing only a single node at a time. However, parallel I/O can be difficult to coordinate and optimize if working directly at the level of API or the POSIX I/O Interface. By introducing intermediate data access and coordination layers, parallel file systems provide application developers a high-level interface between the application layer and the I/O layer.

Energy MPI workloads have unique requirements with the need for low-latency communications between nodes. The nodes are connected via high-speed interconnect and aren't easily adaptable for sharing with other workloads. MPI applications use the entire high-performance interconnects using Pass-Through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre that's also accessed via the high-speed interconnect. Lustre and BeeGFS are typically used to handle the large throughput requirements of seismic processing. To a lesser extent, they're also used for reservoir simulation.

Parallel file systems such as Lustre are used for HPC energy workloads that require access to large files, simultaneous access from multiple compute nodes, and massive amounts of data. The implementation of parallel file systems makes it easy to scale in terms of capability and performance. These file systems take advantage of remote direct memory access transfers with large bandwidth and reduced CPU usage. The parallel file system is often used as scratch space and intended for work that requires optimized I/O. Examples include workload setup, preprocessing, running, and post-processing.

An orchestrated parallel file service, such as Azure Managed Lustre, works for 50,000 or more cores, with read/write rates up to 500 GB/s, and 2.5-PB storage. For more information, see [Parallel Virtual File Systems on Microsoft Azure - Part 1: Overview - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-global/parallel-virtual-file-systems-on-microsoft-azure-part-1-overview/ba-p/306487).

- Azure NetApp Files and local disks are typically used to handle the more latency and IOPS sensitive workloads, like seismic interpretation, model preparation, and visualization. Consider using Azure NetApp Files for workloads of up to 4,000 cores, with a throughput up to 6.5 GiB/s, and workloads that benefit from or require multiprotocol (NFS/SMB) access to the same data set.

- Managed Lustre provides faster and higher capacity storage for HPC workloads. This solution works for medium to large workloads and can support 50,000 or more cores, with throughput up to 500 GB/s, and storage capacity up to 2.5 PiB.

- Standard or Premium Blob storage is cost effective because it's the lowest cost cloud offering. This service provides exabyte scale, high throughput, low-latency access where needed, a familiar file system interface, and multi-protocol access (REST, HDFS, NFS). You can use NFS v3.0 at the blob service endpoint for high throughput and read heavy workloads. You can optimize costs by moving to cooler storage tiers. This approach allows for lifecycle management based on the last update or access time and intelligent tiering with customizable policies.

- Oil and Gas energy workloads might require you to transfer large data sizes and volumes between on-premises systems and the cloud. Offline migration uses device-based methods like DataBox. Online migration uses network-based methods like ExpressRoute.

## Finance considerations

To decide which storage solution to use, consider the following application requirements:

- Latency
- IOPS
- Throughput
- File sizes and number
- Job runtime
- Associated costs
- Affinity for on-premises versus Azure storage location

## Design recommendations

- Use [Standard or Premium Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction) for high-throughput, low-latency storage. It provides the following benefits:

  - It provides exabyte-scale, high-throughput, low-latency access, a familiar file system, and multi-protocol access, including REST, HDFS, NFS.

  - It's cost effective.

  - You can mount Blob Storage as a file system by using [BlobFuse](/azure/storage/blobs/storage-how-to-mount-container-linux). Doing so makes it easy to allow multiple nodes to mount the same container for read-only scenarios.

  - It supports NFS 3.0 at the blob service endpoint for high-throughput, read-heavy workloads.

  - You can optimize costs by moving data to cooler storage tiers. This optimization is possible through lifecycle management that's based on the last update or access time and intelligent tiering with customizable policies.

- Use [Azure NetApp Files](/azure/azure-netapp-files) for ReadWriteMany (unique) or write-once, read-once applications. It provides the following benefits:

  - A wide range of file protocols, such as NFSv3, NFSv4.1, and SMB3.

  - Performance that's comparable with on-premises performance, with multiple tiers (Ultra, Premium, Standard).

  - Deploys in minutes and provides a wide range of tiers and flexibility.

  - Flexible capacity pool types and performance, where the QoS per volume is automatically assigned based on the tier of the pool and the volume quota.

The following table provides a comparison of Blob Storage, Azure Files, Managed Lustre, and Azure NetApp Files.

|  | Blob Storage | Azure Files | Managed Lustre | Azure NetApp Files |
| -- | -- | -- | -- | -- |
| Use cases | Best suited for large-scale read-heavy sequential access workloads where data is ingested once and modified minimally. <br><br> Low total cost of ownership (TCO), if there's light maintenance. | A highly available service that's best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support. The built-in CSI driver allows you to easily use it from VM-based platforms and container platforms like Azure Container Instances and Azure Kubernetes Service (AKS). | Managed Lustre is a fully managed parallel file system that's best suited for medium to large HPC workloads. <br><br> Enables HPC applications in the cloud without breaking application compatibility by providing familiar Lustre parallel file system functionality, behaviors, and performance. This approach secures long-term application investments. | A fully managed file service in the cloud, powered by NetApp, that has advanced management capabilities. <br><br> Azure NetApp Files is suited for workloads that require random access. It provides broad protocol support and improved data protection. |
| Available protocols | NFS 3.0 <br><br>REST <br><br> Azure Data Lake Storage  | SMB <br><br> NFS 4.1 <br><br>(No interoperability between either protocol.) | Lustre | NFS 3.0 and 4.1 <br><br> SMB <br><br><br> |
| Key features | Integrated with Azure HPC Cache for low-latency workloads. <br><br> Integrated management, including lifecycle management, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | High storage capacity up to 2.5 PB. <br><br> Low latency, about 2 ms. <br><br> Create new clusters in minutes. <br><br> Supports containerized workloads with AKS. | Extremely low latency, as low as submillisecond. <br><br> Rich NetApp ONTAP management capability, like SnapMirror Cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (per volume) | As much as 20,000 IOPS. As much as 100 GiB/s throughput. | As much as 100,000 IOPS. As much as 80 GiB/s throughput. | As much as 100,000 IOPS, up to 500 GiB/s throughput. | As much as 460,000 IOPS. As much as 36 GiB/s throughput. |
| Scale | As much as 2 PiB for a single volume. <br><br> As much as roughly 4.75 TiB for a single file. <br><br> No minimum capacity requirements. | As much as 100 TiB for a single volume. <br><br> As much as 4 TiB for a single file. <br><br> 100-GiB minimum capacity. | As much as 2.5 PiB for a single volume. <br><br> As much as 32 PB for a single file. <br><br> 4-TiB minimum capacity. | As much as 100 TiB for a single volume. <br><br> As much as 16 TiB for a single file. <br><br> Consistent hybrid cloud experience. |
| Pricing | [Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files) | [Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp) |

## Manufacturing considerations

It's important to ensure that the required data reaches the HPC cluster machines at the right time. You also want to make sure hat results from those individual machines are quickly saved and available for further analysis.

## Distribution of workload traffic

Consider the types of traffic that your HPC environment generates and processes. This step is especially important if you plan to run multiple types of workloads and plan to use the storage for other purposes. Consider and record the following traffic types:

- Single stream versus multiple streams
- Ratio of read traffic to write traffic
- Average file sizes and counts
- Random versus sequential access patterns

## Data locality

The next category accounts for the location of the data. Locality awareness helps you determine whether you can use copying, caching, or synchronization as your data movement strategy. The following are locality items to check beforehand:

- If source data is on-premises, in Azure, or both
- If results data is on-premises, in Azure, or both
- If HPC workloads in Azure need to be coordinated with source-data modification timelines
- If sensitive or Health Insurance Portability and Accountability Act data is included

## Performance requirements

Performance requirements for storage solutions are typically summarized as follows:

- Single-stream throughput (in Gbps)
- Multi-stream throughput (in Gbps)
- Expected maximum IOPS
- Average latency (in milliseconds)

Every factor affects performance, so these numbers serve as a guide for the expected results of a specific solution. For instance, an HPC workload might include extensive file creation and deletion as part of the workflow. Those operations could affect the overall throughput.

## Access methods

Account for the client access protocol required and be clear about what features of the protocol you need. There are different versions of NFS and SMB.

Consider the following requirements:

- Whether NFS/SMB versions are required
- Expected protocol features, such as ACLs or encryption
- Parallel file system solution

## Total capacity requirement

Storage capacity in Azure is the next consideration. It helps to inform the overall cost of the solution. If you plan to store a large amount of data for a long time, you might want to consider tiering as part of the storage solution. Tiering provides lower-cost storage options combined with higher-cost but higher-performance storage in a hot tier. Consider the following capacity requirements:

- Total capacity required
- Total hot-tier capacity required
- Total warm-tier capacity required
- Total cold-tier capacity required

## Authentication and authorization method

For authentication and authorization requirements, such as using an LDAP server or Active Directory, make sure to include the necessary supporting systems in your architecture. If you need to support capabilities like UID/GID mapping to Active Directory users, confirm that the storage solution supports that capability.

Consider the following network requirements:

- Local (UID/GID on file server only)
- Directory (LDAP, Active Directory)
- UID/GID mapping to Active Directory users or not

## Common Azure storage solutions comparison

| Category | Blob Storage | Azure Files| Managed Lustre | Azure NetApp Files |
|--|--|--|--|--|
| Use cases | Blob Storage is best suited for large-scale, read-heavy sequential access workloads where data is ingested one time with few or no further modifications. <br><br> Blob Storage provides the lowest TCO, if there's little or no maintenance. <br><br> Some example scenarios include large scale analytical data, throughput sensitive high-performance computing, backup and archive, autonomous driving, media rendering, and genomic sequencing. | Azure Files is a highly available service that's best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support. You can easily use it from container platforms like Container Instance (ACI) and AKS with the built-in CSI driver, and VM-based platforms. <br><br> Some example scenarios are: Shared files, databases, home directories, traditional applications, ERP, CMS, NAS migrations that don't require advanced management, and custom applications requiring scale-out file storage. | Managed Lustre is a fully managed parallel file system best suited for medium to large HPC workloads. <br><br> Enables HPC applications in the cloud without breaking application compatibility by providing familiar Lustre parallel file system functionality, behaviors, and performance, securing long-term application investments. | Fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities. <br><br> Some example scenarios are: On-premises enterprise NAS migration that requires rich management capabilities, latency sensitive workloads like SAP HANA, latency-sensitive or IOPS intensive high-performance compute, or workloads that require simultaneous multi-protocol access. |
| Available protocols | NFS 3.0 <br><br> REST <br><br> Data Lake Storage Gen2 | SMB <br><br> NFS 4.1 <br><br> (No interoperability between either protocol) | Lustre | NFS 3.0 and 4.1 <br><br> SMB |
| Key features | Integrated with HPC cache for low-latency workloads. <br><br> Integrated management, including lifecycle, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | High storage capacity up to 2.5 PB. <br><br> Low latency, about 2 ms. <br><br> Spin up new clusters in minutes. <br><br> Supports containerized workloads with AKS. | Extremely low latency (as low as sub-ms). <br><br> Rich NetApp ONTAP management capability such as SnapMirror in cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (Per volume) | Up to 20,000 IOPS, up to 100 GiB/s throughput. | Up to 100,000 IOPS, up to 80 GiB/s throughput. | Up to 100,000 IOPS, up to 500 GiB/s throughput. | Up to 460,000 IOPS, up to 36 GiB/s throughput. |
| Pricing | [Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files/) | [Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp/) |

## Roll-your-own parallel file system

Similar to NFS, you can create a multi-node BeeGFS or Lustre file system. The performance of these systems is mostly dependent on the type of VMs that you choose. You can use images found in Azure Marketplace for [BeeGFS](https://azuremarketplace.microsoft.com/marketplace/apps/beegfs.beegfs-ubuntu-free?tab=Overview), or a Lustre implementation by DDN called [Whamcloud](https://whamcloud.com/). Non-Microsoft images from vendors such as [BeeGFS](https://www.beegfs.io/content/) or DDN allows you to purchase their support. You can use BeeGFS and Lustre under their GPL licenses without extra charges, aside from the costs for machines and disks. These tools are easy to roll out by using [Azure HPC scripts](https://github.com/Azure/azurehpc/tree/master/examples) with either ephemeral local disks for scratch or Premium SSD or Ultra SSD for persistent storage.

## Cray ClusterStor

It's a challenge for larger workloads to replicate the "bare-metal" performance of large compute clusters with large Lustre environments. Other challenges include achieving high throughput in terms of TB/s and potentially handling petabytes of storage. You can now run these workloads by using the Azure Cray ClusterStor solution. This approach is a pure bare-metal Lustre deployment that's placed in the relevant Azure datacenter. Parallel file systems such as BeeGFS and Lustre provide the highest performance because of their architecture. But that architecture and the use of these technologies has a high management price.

## Next steps

The following articles provide guidance to help you at various points during your cloud adoption journey.

- [Azure Billing and Microsoft Entra tenants for energy HPC](./azure-billing-active-directory-tenant.md)
- [Identity and access management for Azure HPC in energy](./identity-access-management.md)
- [Management for Azure HPC in energy](./management.md)
- [Network topology and connectivity for Azure HPC in energy](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in energy](./platform-automation-devops.md)
- [Resource organization for HPC in the energy industry](./resource-organization.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Security for Azure HPC in energy](./security.md)
- [Compute large-scale HPC application workloads in Azure VMs](./compute.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
