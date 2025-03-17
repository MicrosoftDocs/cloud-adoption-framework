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

Storage access is a crucial factor to consider when you plan for high-performance computing (HPC) workload performance. Large-scale HPC workloads in specific environments can create demands for data storage and access that exceed the capabilities of traditional cloud file systems. This article provides recommendations to help you choose the correct storage for your Azure HPC workloads.

To help decide which storage solution to use, consider the following factors related to your application's requirements:

- Latency
- Input/output operations per second (IOPS)
- Throughput
- File sizes and file count
- Job runtime
- Cost
- Storage location (on-premises versus Azure)

For more information, see [Understand factors that influence HPC storage selection in Azure](/training/modules/hpc-storage-considerations).

The following diagram shows a decision tree that's for a specific HPC storage system choice.

:::image type="content" source="media/storage-selection-flow.svg" alt-text="Diagram that shows a decision tree of considerations when you choose a storage solution." lightbox="media/storage-selection-flow.svg" border="false":::

*Download a [Visio file](https://archcenter.blob.core.windows.net/cdn/storage-selection-flow.vsdx) of this architecture.

## HPC considerations

- [Data storage](/azure/architecture/topics/high-performance-computing#storage) and access needs vary widely, depending on workload scale.

- The high-performance input/output (I/O) requirements and massive scalability needs of [HPC](https://azure.microsoft.com/solutions/high-performance-computing/) introduce unique challenges for data storage and access.

- HPC uses parallel processing and massive scalability to quickly and reliably perform large and complicated computing tasks that aren't practical or cost-effective to handle by using traditional computing techniques.

### Compute node distribution in HPC clusters

In Azure HPC clusters, you can create compute nodes as virtual machines (VMs) to perform jobs that are assigned to a cluster. To help achieve the high-performance parallel processing that's required to solve complex HPC problems, the compute nodes distribute those jobs across the cluster.

When you run jobs, compute nodes must perform read and write operations on a shared data source. Nodes access this data source in a range of scenarios that lie between the two following extremes.

- **One data source to many compute nodes:** In this scenario, there's a single data source on the network that all the compute nodes access for working data. Though the compute nodes are structurally simple, the I/O capacity of the storage location limits the I/O operations.

- **Many data sources to many compute nodes:** In this scenario, there are many data sources on the network that all the compute nodes access for working data. Despite the structural simplicity of the compute nodes, the I/O capacity of the storage location limits the I/O operations.

### Workload traffic distribution

Consider the types of traffic that your HPC environment generates and processes. This step is especially important if you plan to run multiple types of workloads and plan to use the storage for other purposes. Consider and record the following traffic types:

- Single stream versus multiple streams
- Ratio of read traffic to write traffic
- Average file size and file count
- Random access patterns versus sequential access patterns

### Data locality

This category considers the location of the data. Locality awareness helps you determine whether you can use copying, caching, or synchronization as your data-movement strategy. Check the following locality items in advance:

- If source data is on-premises, in Azure, or both
- If results data is on-premises, in Azure, or both
- If HPC workloads in Azure need to be coordinated with source-data modification timelines
- If sensitive or Health Insurance Portability and Accountability Act data is included

### Performance requirements

The performance requirements for storage solutions are typically summarized as:

- Single-stream throughput.
- Multiple-stream throughput.
- Expected maximum IOPS.
- Average latency.

Each factor affects performance, so these numbers serve as a guide for the expected results of a specific solution. For instance, an HPC workload might include extensive file creation and deletion as part of the workflow. Those operations can affect the overall throughput.

### Access methods

Consider the client access protocol that you need and specify the required features. There are different versions of network file system (NFS) and server message block (SMB).

Consider the following requirements:

- Whether NFS or SMB versions are required
- The protocol features you require, such as access control lists or encryption
- Whether a parallel file system solution is required

### Total capacity requirement

The storage capacity in Azure affects the overall cost of the solution. If you plan to store a large amount of data for a long time, you might want to consider tiering as part of the storage solution. Tiering combines lower-cost storage options with higher-cost, higher-performance storage in a hot tier. Consider the following capacity requirements:

- Total capacity required
- Total hot-tier capacity required
- Total warm-tier capacity required
- Total cold-tier capacity required

### Authentication and authorization method

For authentication and authorization requirements, such as using a lightweight directory access protocol (LDAP) server or Windows Server Active Directory, make sure to include the necessary supporting systems in your architecture. If you need to support capabilities like user ID (UID) or group ID (GID) mapping to Windows Server Active Directory users, confirm that the storage solution supports that capability.

Consider the following network requirements:

- Local requirements (UID or GID on the file server only)
- Directory requirements (LDAP or Windows Server Active Directory)
- Whether UID or GID mapping to Windows Server Active Directory users is needed

## HPC design recommendations

Choose the solution that's best suited for both your unique I/O and capacity requirements.

- **For high-throughput, low-latency storage**, consider using [Standard or Premium Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction). Standard or Premium Blob Storage provides the following benefits:

  - Provides exabyte-scale, high-throughput, low-latency access, a familiar file system, and multiple-protocol access, including REST, HDFS, and NFS.

  - Optimizes costs by handling petabytes (PB) of data and employing lifecycle management features that streamline data archival and deletion. This approach reduces storage expenses over time.

  - Supports the ability to mount Blob Storage as a file system by using [BlobFuse](/azure/storage/blobs/storage-how-to-mount-container-linux). This method makes it easier for multiple nodes to mount the same container for read-only scenarios.

  - Supports NFS 3.0 at the blob service endpoint for high-throughput, read-heavy workloads.

  - Supports cost optimization by allowing you to move data to cooler storage tiers. This optimization is possible through lifecycle management that's based on the last update or access time and intelligent tiering with customizable policies.

- **For ReadWriteMany (unique) or write-once, read-once applications**, consider using [Azure NetApp Files](/azure/azure-netapp-files). Azure NetApp Files provides the following benefits:

  - A wide range of file protocols, such as NFSv3, NFSv4.1, and SMB3

  - Performance that's comparable with on-premises performance and has multiple tiers (Ultra, Premium, Standard)

  - Deploys in minutes and provides a wide range of tiers and flexibility

  - Flexible capacity pool types and performance, where the quality of service per volume is automatically assigned based on the tier of the pool and the volume quota

### NFS

NFS is often used to provide access to shared storage locations over Transmission Control Protocol or Internet Protocol networks. A server VM that uses NFS shares its local file system. In Azure, this file system is stored on one or more virtual hard disks that are hosted in Azure Storage. Clients can then mount the server's shared files and access the shared location directly.

NFS is often used for home directories and project spaces that require access across all nodes. It can provide a space for research groups that share data. In general, the throughput workloads are horizontally scalable and have little dependency between individual tasks. Job schedulers divide the work across nodes and coordinate the activity.

NFS is simple to set up and maintain and is supported on both Linux and Windows operating systems. You can use multiple NFS servers to spread storage across a network, but individual files are only accessible through a single server.

For low-scale workloads, consider running NFS on the head node by using a [storage optimized VM](/azure/virtual-machines/sizes-storage) that has large ephemeral disks or D-series VMs with Azure Premium Storage, depending on your requirements. This solution suits workloads that have 500 cores or fewer.

In HPC scenarios, the file server can often serve as a bottleneck that throttles overall performance. Attempts to access uncached data from a single NFS server at rates higher than the documented maximum IOPS per VM and throughput results in throttling.

In a scenario where multiple clients try to work on data that's stored on a single NFS server, you can quickly reach performance limits. These limits can cause your entire application's performance to suffer. The more your HPC application resembles a pure one-to-many scenario, the sooner you encounter these limitations.

### Parallel file systems on Azure

Parallel file systems distribute block-level storage across multiple networked storage nodes. File data is spread among these nodes, which means that the data is spread among multiple storage devices. This distribution pools any individual storage I/O requests across multiple storage nodes that are accessible through a common namespace.

Multiple storage devices and multiple paths to data are used to provide a high degree of parallelism. This approach reduces the number of bottlenecks imposed by accessing only a single node at a time. However, parallel I/O can be difficult to coordinate and optimize if you work directly at the level of the API or POSIX I/O interface. Parallel file systems provide application developers with a high-level interface between the application layer and the I/O layer via intermediate data access and coordination layers.

Tightly coupled workloads that use the Message Passing Interface (MPI) might have unique requirements for low-latency communications between nodes. The nodes connect via high-speed interconnect and aren't easily adaptable for sharing with other workloads. MPI applications use the entire high-performance interconnects via passthrough mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like [Lustre](https://www.lustre.org/) that's also accessed via the high-speed interconnect.

Parallel file systems such as Lustre are used for HPC workloads that require access to large files, simultaneous access from multiple compute nodes, and massive amounts of data. The implementation of parallel file systems makes it easy to scale in terms of capability and performance. These file systems take advantage of remote direct memory access transfers that have large bandwidth and reduced CPU usage. The parallel file system is often used as scratch space and is intended for work that requires optimized I/O.

### Roll-your-own parallel file system

Similar to NFS, you can create a multiple-node BeeGFS or Lustre file system. The performance of these systems is mostly dependent on the type of VMs that you choose. You can use images located in [Azure Marketplace for BeeGFS](https://azuremarketplace.microsoft.com/marketplace/apps/beegfs.beegfs-ubuntu-free) or a Lustre implementation by DataDirect Networks called [Whamcloud](https://whamcloud.com/). If you use non-Microsoft images from vendors such as [BeeGFS](https://www.beegfs.io/c/) or DataDirect Networks, you can purchase their support services. You can use BeeGFS and Lustre under their General Public License licenses without incurring extra charges, aside from the costs for machines and disks. These tools are easy to roll out by using [Azure HPC scripts](https://github.com/Azure/azurehpc/tree/master/examples) with either ephemeral local disks for scratch or Azure Premium SSD or Azure Ultra Disk Storage for persistent storage.

## HPC components

- Azure NetApp Files and local disks are typically used to handle the latency-sensitive and IOPS-sensitive workloads. Consider using Azure NetApp Files for workloads up to 4,000 cores, with a throughput up to 12.8 gibibytes per second (GiBps), and workloads that benefit from or require multiple-protocol NFS and SMB access to the same data source.

- Azure Managed Lustre provides faster and higher capacity storage for HPC workloads. This solution works for medium to large workloads and can support 50,000 or more cores, with throughput up to 500 gigabits per second (Gbps) and storage capacity up to 2.5 pebibytes (PiB).

- Standard or Premium Blob Storage is cost-effective because it provides the lowest-cost cloud solution. This service provides exabyte-scale, high-throughput, low-latency access when needed and a familiar file system interface. It also supports multiple-protocol access, which includes REST, HDFS, and NFS. You can use NFS v3.0 at the blob service endpoint for high-throughput and read-heavy workloads. You can optimize costs by moving to cooler storage tiers. This approach enables intelligent tiering with customizable policies and lifecycle management based on the last update or access time.

- Data transfers between on-premises systems and the cloud might be required to achieve the best performance for the workload that runs against the compute instances in the cloud. Offline migration uses device-based services like Azure Data Box. Online migration uses network-based services like Azure ExpressRoute.

The following table provides a comparison of Blob Storage, Azure Files, Managed Lustre, and Azure NetApp Files.

| Category | Blob Storage | Azure Files | Managed Lustre | Azure NetApp Files |
|--|--|--|--|--|
| Use cases | - Best suited for large-scale, read-heavy sequential access workloads where data is ingested one time and modified minimally. <br><br> - Provides low total cost of ownership with light maintenance. <br><br> - Example scenarios include large-scale analytical data, throughput-sensitive high-performance computing, data backup and archive, autonomous driving, media rendering, and genomic sequencing. | - A highly available service best suited for random-access workloads. <br><br> - Provides full POSIX file system support for NFS shares. The built-in CSI driver allows easy use from VM-based platforms and container platforms like Azure Container Instances and Azure Kubernetes Service (AKS). <br><br> - Example scenarios include shared files, databases, home directories, traditional applications, enterprise resource planning, content management systems, and network attached storage (NAS) migrations that don't require advanced management. It also includes custom applications that require scale-out file storage. | - A fully managed parallel file system best suited for medium to large HPC workloads. <br><br> - Enables HPC applications in the cloud without breaking application compatibility by providing familiar Lustre parallel file system functionality, behaviors, and performance. This service helps secure long-term application investments. | - A fully managed file service in the cloud, powered by NetApp, that has advanced management capabilities. <br><br> - Designed for workloads that require random access. It provides broad protocol support and improved data protection. <br><br> - Example scenarios include on-premises enterprise NAS migration that requires rich management capabilities, latency-sensitive workloads like SAP HANA, latency-sensitive or IOPS-intensive high-performance compute, or workloads that require simultaneous multiple-protocol access. |
| Available protocols | - NFS 3.0 <br><br> - REST <br><br> - Azure Data Lake Storage | - SMB <br><br> - NFS 4.1 <br><br> - (No interoperability between either protocol) | - Lustre | - NFS 3.0 and 4.1 <br><br> - SMB |
| Key features | - Integrated management, including lifecycle management, immutable blobs, data failover, and metadata index. | - Zone redundancy support for high availability. <br><br> - Consistent single-digit millisecond latency. <br><br> - Predictable performance and cost that scales with capacity. | - High storage capacity up to 2.5 PB. <br><br> - Low latency, about 2 milliseconds. <br><br> - Create new clusters in minutes. <br><br> - Supports containerized workloads by using AKS. | - Extremely low latency, as low as a submillisecond. <br><br> - Rich NetApp ONTAP management capability, like SnapMirror Cloud. <br><br> - Consistent hybrid cloud experience. |
| Performance (per volume) | - As much as 40,000 IOPS. <br><br> - As much as 60-Gbps ingress throughput and 200-Gbps egress. | - As much as 100,000 IOPS. <br><br> - As much as 80 GiBps throughput. | - As much as 100,000 IOPS. <br><br> - As much as 500 GiBps throughput. | - As much as 460,000 IOPS. <br><br> - As much as 12.8 GiBps throughput. |
| Scale | - As much as 5 PiB for a single volume. <br><br> - As much as roughly 4.75 tebibyte (TiB) for a single file. <br><br> - No minimum capacity requirements. | - As much as 100 TiB for a single volume. <br><br> - As much as 4 TiB for a single file. <br><br> - 100-GiB minimum capacity. | - As much as 2.5 PiB for a single volume. <br><br> - Managed Lustre File System aligns with [Lustre's file limit specifications](https://doc.lustre.org/lustre_manual.xhtml#idm139831582679776) and supports a maximum file size of up to 32 PB. <br><br>- 4-TiB minimum capacity. | - As much as 1,024 TiB for a single volume. <br><br> - As much as 16 TiB for a single file. <br><br> - Consistent hybrid cloud experience. |
| Pricing | - [Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs) | - [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files) | - [Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | - [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp) |

## Next steps

The following articles provide guidance to help you at various points during your cloud adoption journey.

- [Introduction to the Azure HPC scenario](/azure/cloud-adoption-framework/scenarios/azure-hpc/)
- [Identity and access management for Azure HPC](/azure/cloud-adoption-framework/scenarios/azure-hpc/identity-access-management)
- [Network topology and connectivity for Azure HPC](/azure/cloud-adoption-framework/scenarios/azure-hpc/network-topology-connectivity)
- [Resource organization for Azure HPC](/azure/cloud-adoption-framework/scenarios/azure-hpc/resource-organization)
- [Compute large-scale HPC application workloads in Azure VMs](/azure/cloud-adoption-framework/scenarios/azure-hpc/compute)
- [Azure HPC landing zone accelerator](/azure/cloud-adoption-framework/scenarios/azure-hpc/azure-hpc-landing-zone-accelerator)
