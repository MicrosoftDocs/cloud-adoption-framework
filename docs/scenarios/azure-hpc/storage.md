---
title: Storage for Azure HPC Workloads
description: Learn how to use Azure Storage for high-performance computing (HPC) workloads.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 12/05/2024
---

# Storage for Azure HPC workloads

Storage access is crucial to plan for HPC workload performance. Large-scale HPC workloads in certain environments can create demands for data storage and access that exceed the capabilities of traditional cloud file systems. This article provides recommendations to help you choose the correct storage for your Azure HPC workloads. It also provides recommendations about storage for HPC energy environments, storage for HPC in the finance sector, and for manufacturing HPC storage.

The following are the factors you need to consider and identify about your application requirement to decide on what storage solution to use:

- Latency
- IOPS
- Throughput
- File sizes and count
- Job run time
- Cost associated
- Affinity for storage location – on-premises versus Azure

For more information, see [Understand factors that influence HPC storage selection in Azure](https://learn.microsoft.com/training/modules/hpc-storage-considerations/)

The following diagram shows a decision tree that's for a specific HPC storage system choice.

:::image type="content" alt-text="Diagram that shows a decision tree of considerations when you choose a storage solution." source="../media/storage-selection-flow.png" lightbox="../media/storage-selection-flow.png":::

## HPC considerations

Oil and gas companies must be able to effectively manage and store exabytes of seismic data, well data, maps, leases, and more. To put this data to use, they need a high-performance infrastructure that can process and deliver real-time analytics to help optimize production, reduce environmental risks, and enhance operational safety.

[Data storage](/azure/architecture/topics/high-performance-computing#storage) and access needs vary widely, depending on workload scale. Azure supports several approaches for managing the speed and capacity of HPC applications.

Large-scale Batch and HPC workloads in energy industry have demands for data storage and access that exceed the capabilities of traditional cloud file systems. The high-performance I/O requirements and massive scalability needs of [high-performance computing (HPC)](https://azure.microsoft.com/solutions/high-performance-computing/) introduces unique challenges for data storage and access.

HPC is used to solve complex problems, such as Seismic and Reservoir simulation and modeling, that aren't practical or cost effective to handle by using traditional computing techniques. It does this through a combination of parallel processing and massive scalability to perform large and complicated computing tasks quickly, efficiently, and reliably.

Additionally, in Azure HPC clusters, compute nodes are virtual machines that can be spun up, as needed, to perform whatever jobs that the cluster is assigned. These nodes spread computation tasks across the cluster to achieve the high-performance parallel processing required to solve the complex problems HPC is applied to. Compute nodes need to perform read/write operations on shared working storage while executing jobs. The way nodes access this storage falls on a continuum between these two scenarios:

- One set of data to many compute nodes - In this scenario, there's a single data source on the network that all the compute nodes access for working data. While structurally simple, any I/O operations are limited by the I/O capacity of the storage location.

- Many sets of data to many compute nodes - In this scenario, there's a single data source on the network that all the compute nodes access for working data. While structurally simple, any I/O operations are limited by the I/O capacity of the storage location.

## HPC design recommendations

Choose the solution best suited to your unique I/O and capacity requirements.

### Network file system (NFS)

NFS is commonly used to provide access to shared storage locations. With NFS a server VM shares out its local file system, which in the case of Azure is stored on one or more virtual hard disks (VHD) hosted in Azure Storage. Clients can then mount the server's shared files and access the shared location directly.

The Network File System (NFS) is often used for home directories and project space mounted across all nodes. It can also often provide a space for research groups sharing data. In general, the throughput workloads are horizontally scalable with little dependency between individual tasks. Job schedulers divvy up the work across nodes and coordinate the activity. NFS is the typical shared storage across the nodes which is accessed via TCP/IP networks.

NFS has the advantage of being easy to set up and maintain and is supported on both Linux and Windows operating systems. Multiple NFS servers can be used to spread storage across a network, but individual files are only accessible through a single server.

For low-scale workloads, consider running NFS on the head node, using a [Storage](/azure/virtual-machines/sizes-storage) Optimized VM with large ephemeral disks, or D-series VMs with Azure Premium Storage, depending on your requirements. This solution suits workloads that have 500 cores or fewer.

In HPC scenarios, the file server can often serve as a bottleneck, throttling overall performance. Attempts to access uncached data from a single NFS server at rates higher than the documented per-VM maximum IOPS and throughput results in throttling.

In a scenario where dozens of clients are attempting to work on data stored on a single NFS server, these limits can easily be reached, causing your entire application's performance to suffer. The closer to a pure one-to-many scenario your HPC application uses, the sooner you run up against these limitations.

### Parallel file systems on Azure

Parallel file systems distribute block level storage across multiple networked storage nodes. File data is spread among these nodes, which means that file data is spread among multiple storage devices. This distribution pools any individual storage I/O requests across multiple storage nodes that are accessible through a common namespace.

Multiple storage devices and multiple paths to data are utilized to provide a high degree of parallelism, reducing bottlenecks imposed by accessing only a single node at a time. However, parallel I/O can be difficult to coordinate and optimize if working directly at the level of API or POSIX I/O Interface. By introducing intermediate data access and coordination layers, parallel file systems provide application developers a high-level interface between the application layer and the I/O layer.

Energy MPI workloads have unique requirements with the need for low latency communications between nodes. The nodes are connected via high-speed interconnect and aren't amenable to sharing with other workloads. MPI applications leverage the entire high-performance interconnects using Pass-Through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre also accessed via the high-speed interconnect. Lustre/BeeGFS is typically used to handle the large throughput requirements of primarily seismic processing (but also reservoir simulation).

Parallel file systems such as Lustre are used for HPC energy workloads that require access to large files, simultaneous access from multiple compute nodes, and massive amounts of data. The implementation of parallel file systems makes it easy to scale in terms of capability and performance. Such file systems take advantage of RDMA transfers with large bandwidth and reduced CPU usage. The parallel file system is often used as scratch space and intended for work that requires optimized I/O. Examples include workload setup, preprocessing, running, and post-processing.

An orchestrated parallel file service, such as Azure Managed Lustre, works for 50,000 or more cores, with read/write rates up to 500 GB/s, and 2.5-PB storage.

For more information about Parallel Virtual file system on Azure, see [Parallel Virtual File Systems on Microsoft Azure - Part 1: Overview - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-global/parallel-virtual-file-systems-on-microsoft-azure-part-1-overview/ba-p/306487).

- Azure NetApp Files and local disks are typically used to handle the more latency/IOPS sensitive workloads, like seismic interpretation, model preparation, and visualization. Consider using  for workloads of up to 4,000 cores, with a throughput up to 6.5 GiB/s, and workloads that benefit from our require multiprotocol (NFS/SMB) access to the same data set.

- Azure Managed Lustre provides faster and higher capacity storage for HPC workloads. This solution works for medium to large workloads and can support 50,000 or more cores, with throughput up to 500 GB/s, and storage capacity up to 2.5 PiB.

- Standard or Premium Blob is a cost effective being the lowest cost cloud offering. This service provides exabyte scale, high throughput, low latency access where necessary, familiar file system and multi-protocol access (REST, HDFS, NFS). You can make use of the NFS v3.0 at the blob service endpoint for high throughput and read heavy workloads.  You can optimize costs by moving to cooler tiers with the ability to perform lifecycle management with last update/ last access time, intelligent tiering with customizable policies.

- The Oil and Gas energy workloads might also require large data size and volumes transfer mechanism from on-premises to Cloud and vice versa that can be achieved by

    - Offline - device based migration (DataBox)

    - Online - over the network (ExpressRoute) based migration.

## Finance considerations

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

The following table provides a comparison of Blob Storage, Azure Files, Azure Managed Lustre, and Azure NetApp Files.

|  | Blob Storage | Azure Files | Azure Managed Lustre | Azure NetApp Files |
| -- | -- | -- | -- | -- |
| **Use cases** | Best suited for large-scale read-heavy sequential access workloads where data is ingested once and modified minimally. <br><br> Low total cost of ownership, if there's light maintenance. | A highly available service that's best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support. The built-in CSI driver enables you to easily use it from container platforms like Azure Container Instances and Azure Kubernetes Service (AKS), in addition to VM-based platforms. | Azure Managed Lustre is a fully managed parallel file system best suited to medium to large HPC workloads. <br><br> Enables HPC applications in the cloud without breaking application compatibility by providing familiar Lustre parallel file system functionality, behaviors, and performance, securing long-term application investments. | A fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> Azure NetApp Files is suited for workloads that require random access. It provides broad protocol support and improved data protection. |
| **Available protocols** | NFS 3.0 <br><br>REST <br><br>Azure Data Lake Storage  | SMB <br><br> NFS 4.1 <br><br>(No interoperability between either protocol.) | Lustre | NFS 3.0 and 4.1 <br><br> SMB <br><br><br> |
| **Key features** | Integrated with Azure HPC Cache for low-latency workloads. <br><br> Integrated management, including lifecycle management, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | High storage capacity up to 2.5 PB. <br><br> Low (~2ms) latency. <br><br> Spin up new clusters in minutes. <br><br> Supports containerized workloads with AKS. | Extremely low latency (as low as submillisecond). <br><br> Rich NetApp ONTAP management capability, like SnapMirror Cloud. <br><br> Consistent hybrid cloud experience. |
| **Performance (per volume)** | As much as 20,000 IOPS. As much as 100 GiB/s throughput. | As much as 100,000 IOPS. As much as 80 GiB/s throughput. | As much as 100,000 IOPS, up to 500 GiB/s throughput. | As much as 460,000 IOPS. As much as 36 GiB/s throughput. |
| **Scale** | As much as 2 PiB for a single volume. <br><br> As much as ~4.75 TiB for a single file. <br><br> No minimum capacity requirements. | As much as 100 TiB for a single volume. <br><br> As much as 4 TiB for a single file. <br><br> 100-GiB minimum capacity. | As much as 2.5 PiB for a single volume. <br><br> As much as 32 PB for a single file. <br><br> 4-TiB minimum capacity. | As much as 100 TiB for a single volume. <br><br> As much as 16 TiB for a single file. <br><br> Consistent hybrid cloud experience. |
| **Pricing** | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files) | [Azure Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp) |

## Manufacturing considerations

It's important to ensure that the required data gets to the HPC cluster machines at the right time. You also want to make sure results from those individual machines are quickly saved and available for further analysis.

## Distribution of workload traffic

Account for the types of traffic your HPC environment generates and processes. This step is especially important if you plan to run multiple types of workloads and plan to use the storage for other purposes. Consider and record the following traffic types:

- Single stream versus multiple streams
- Ratio of read traffic to write traffic
- Average file sizes and counts
- Random versus sequential access patterns

## Data locality

The next category accounts for the location of the data. Locality awareness helps you determine whether you can use copying, caching, or synchronization as your data movement strategy. The following are locality items to check beforehand:

- Source data on-premises, in Azure, or both?
- Results data on-premises, in Azure, or both?
- HPC workloads in Azure to be coordinated with source-data modification timelines?
- Sensitive/HIPAA data?

## Performance requirements

Performance requirements for storage solutions are generally summarized as follows:

- Single-stream throughput (in Gb/ps)
- Multi-stream throughput (in Gb/ps)
- Expected maximum IOPS
- Average latency (ms)

Every consideration affects performance, so these numbers represent a guide that a particular solution should achieve. For example, you might have an HPC workload that does extensive file creation and deletion as part of the workflow. Those operations could affect the overall throughput.

## Access methods

Account for the client access protocol required and be clear about what features of the protocol you need. There are different versions of NFS and SMB.

Here are some things to consider:

- NFS/SMB versions required
- Expected protocol features (ACLs, encryption)
- Parallel file system solution

## Total capacity requirement

Storage capacity in Azure is the next consideration. It helps to inform the overall cost of the solution. If you plan to store a large amount of data for a long time, you might want to consider tiering as part of the storage solution. Tiering provides lower-cost storage options combined with higher-cost but higher-performance storage in a hot tier. So, evaluate the capacity requirements as follows:

- Total capacity required
- Total hot-tier capacity required
- Total warm-tier capacity required
- Total cold-tier capacity required

## Authentication and authorization method

Regarding authentication and authorization requirements, like using an LDAP server or Active Directory environment, ensures you include the appropriate supporting systems for the architecture. If you need to support capabilities like UID/GID mapping to Active Directory users, confirm that the storage solution supports that capability.

Here are some things to consider:

- Local (UID/GID on file server only)
- Directory (LDAP, Active Directory)
- UID/GID mapping to Active Directory users?

## Common Azure storage solutions comparison

| Category | Azure Blob Storage | Azure Files| Azure Managed Lustre | Azure NetApp Files |
|--|--|--|--|--|
| Use cases | Azure Blob Storage is best suited for large-scale, read-heavy sequential access workloads where data is ingested once with few or no further modifications. <br><br> Blob Storage offers the lowest total cost of ownership, if there's little or no maintenance. <br><br> Some example scenarios are: Large scale analytical data, throughput sensitive high-performance computing, backup and archive, autonomous driving, media rendering, or genomic sequencing. | Azure Files is a highly available service best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support. You can easily use it from container platforms like Azure Container Instance (ACI) and Azure Kubernetes Service (AKS) with the built-in CSI driver, and VM-based platforms. <br><br> Some example scenarios are: Shared files, databases, home directories, traditional applications, ERP, CMS, NAS migrations that don't require advanced management, and custom applications requiring scale-out file storage. | Azure Managed Lustre is a fully managed parallel file system best suited to medium to large HPC workloads. <br><br> Enables HPC applications in the cloud without breaking application compatibility by providing familiar Lustre parallel file system functionality, behaviors, and performance, securing long-term application investments. | Fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities. <br><br> Some example scenarios are: On-premises enterprise NAS migration that requires rich management capabilities, latency sensitive workloads like SAP HANA, latency-sensitive or IOPS intensive high-performance compute, or workloads that require simultaneous multi-protocol access. |
| Available protocols | NFS 3.0 <br><br> REST <br><br> Data Lake Storage Gen2 | SMB <br><br> NFS 4.1 <br><br> (No interoperability between either protocol) | Lustre | NFS 3.0 and 4.1 <br><br> SMB |
| Key features | Integrated with HPC cache for low-latency workloads. <br><br> Integrated management, including lifecycle, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | High storage capacity up to 2.5 PB. <br><br> Low (~2ms) latency. <br><br> Spin up new clusters in minutes. <br><br> Supports containerized workloads with AKS. | Extremely low latency (as low as sub-ms). <br><br> Rich NetApp ONTAP management capability such as SnapMirror in cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (Per volume) | Up to 20,000 IOPS, up to 100 GiB/s throughput. | Up to 100,000 IOPS, up to 80 GiB/s throughput. | Up to 100,000 IOPS, up to 500 GiB/s throughput. | Up to 460,000 IOPS, up to 36 GiB/s throughput. |
| Pricing | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files/) | [Azure Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp/) |

## Roll-your-own parallel file system

As with NFS, you can create a multi-node BeeGFS or Lustre file system. Performance of such systems is largely dependent on the type of Virtual Machines you select. You can use images found in Azure Marketplace for [BeeGFS](https://azuremarketplace.microsoft.com/marketplace/apps/beegfs.beegfs-ubuntu-free?tab=Overview), or a Lustre implementation by DDN called [Whamcloud](https://whamcloud.com/). Using non-Microsoft images from vendors such as [BeeGFS](https://www.beegfs.io/content/) or DDN lets you purchase their support. Otherwise, you can use both BeeGFS and Lustre by way of their GPL licenses without other charges (beyond the machines and disks). These tools are easy to roll out using the [Azure HPC scripts](https://github.com/Azure/azurehpc/tree/master/examples) with either ephemeral local disks (for scratch) or Premium / Ultra SSD for persistent storage.

## Cray ClusterStor

One of the biggest challenges with larger workloads is replicating the pure “bare-metal” performance of large compute clusters working alongside large Lustre environments (in terms of TB/s throughput, and possibly Petabytes of storage). You can now run these workloads with the Azure Cray ClusterStor solution. This approach is a pure bare-metal Lustre deployment placed in the relevant Azure data center. Parallel file systems such as BeeGFS and Lustre provide the highest performance due to their architecture. But that architecture comes with a high management price and so does the use of these technologies.

## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC.

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
- [Security for HPC in the finance sector](./security.md)
