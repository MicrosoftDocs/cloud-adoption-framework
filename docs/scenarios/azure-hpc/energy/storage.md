---
title: Storage for Azure HPC in the energy industry
description: 'Large-scale HPC energy workloads have demands for data storage and access that exceed the capabilities of traditional cloud file systems.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Storage for HPC energy environments

Large-scale HPC workloads have demands for data storage and access that exceed the capabilities of traditional cloud file systems.

Below are the factors you would need to consider and identify about your application requirement to decide on what storage solution to use

 - Latency,
 - IOPS,
 - Throughput,
 - File sizes and count,
 - Job run time
 - Cost associated
 - Affinity for storage location – on-premises vs Azure

For further understanding of the factors that influence HPC storage selected in Azure please see “Understand factors that influence HPC storage selection in Azure”.

Decision tree for specific HPC storage system choice.

:::image type="content" alt-text="HPC storage system." source="../media/hpc-storage.png" lightbox="../media/hpc-storage.png":::

## HPC Design considerations

Oil and gas companies must be able to effectively manage and store exabytes of seismic data, well data, maps, leases, and more. To put this data to use, they need a high-performance infrastructure that can process and deliver real-time analytics to help optimize production, reduce environmental risks, and enhance operational safety.

[Data storage](/azure/architecture/topics/high-performance-computing#storage) and access needs vary widely, depending on workload scale. Azure supports several approaches for managing the speed and capacity of HPC applications.

Large-scale Batch and HPC workloads in Energy industry have demands for data storage and access that exceed the capabilities of traditional cloud file systems. The high-performance I/O requirements and massive scalability needs of [high-performance computing (HPC)](https://azure.microsoft.com/solutions/high-performance-computing/) introduces unique challenges for data storage and access.

HPC is used to solve complex problems, such as Seismic and Reservoir simulation and modeling, that are not practical or cost effective to handle with traditional computing techniques. It does this through a combination of parallel processing and massive scalability to perform large and complicated computing tasks quickly, efficiently, and reliably.

Additionally, in Azure HPC clusters, compute nodes are virtual machines that can be spun up, as needed, to perform whatever jobs the cluster has been assigned. These nodes spread computation tasks across the cluster to achieve the high-performance parallel processing needed to solve the complex problems HPC is applied to. Compute nodes need to perform read/write operations on shared working storage while executing jobs. The way nodes access this storage falls on a continuum between these two scenarios:

 - One set of data to many compute nodes - In this scenario, there is a single data source on the network that all the compute nodes access for working data. While structurally simple, any I/O operations are limited by the I/O capacity of the storage location.
 - Many sets of data to many compute nodes - In this scenario, there is a single data source on the network that all the compute nodes access for working data. While structurally simple, any I/O operations are limited by the I/O capacity of the storage location.

## HPC Design Recommendations

Choose the solution best suited to your unique I/O and capacity requirements.

### Network file system (NFS)

NFS is commonly used to provide access to shared storage locations. With NFS a server VM shares out its local file system, which in the case of Azure is stored on one or more virtual hard disks (VHD) hosted in Azure Storage. Clients can then mount the server's shared files and access the shared location directly.

The Network File System (NFS) is often used for home directories and project space mounted across all nodes. It can also often provide a space for research groups sharing data. In general, the throughput workloads are horizontally scalable with little dependency between individual tasks. Job schedulers divvy up the work across nodes and coordinate the activity. NFS is the typical shared storage across the nodes which is accessed via TCP/IP networks.

NFS has the advantage of being easy to set up and maintain and is supported on both Linux and Windows operating systems. Multiple NFS servers can be used to spread storage across a network, but individual files are only accessible through a single server.

For low-scale workloads, consider running NFS on the head node, using a [Storage](/azure/virtual-machines/sizes-storage) Optimized VM with large ephemeral disks, or D-series VMs with Azure Premium Storage, depending on your requirements. This solution suits workloads with 500 cores or fewer.

In HPC scenarios, the file server can often serve as a bottleneck, throttling overall performance. Attempts to access uncached data from a single NFS server at rates higher than the documented per-VM maximum IOPS and throughput  will result in throttling.

In a scenario where dozens of clients are attempting to work on data stored on a single NFS server, these limits can easily be reached, causing your entire application's performance to suffer. The closer to a pure one-to-many scenario your HPC application uses, the sooner you will run up against these limitations.

### Parallel file systems on Azure

Parallel file systems distribute block level storage across multiple networked storage nodes. File data is spread among these nodes, meaning file data is spread among multiple storage devices. This pools any individual storage I/O requests across multiple storage nodes that are accessible through a common namespace.

Multiple storage devices and multiple paths to data are utilized to provide a high degree of parallelism, reducing bottlenecks imposed by accessing only a single node at a time. However, parallel I/O can be difficult to coordinate and optimize if working directly at the level of API or POSIX I/O Interface. By introducing intermediate data access and coordination layers, parallel file systems provide application developers a high-level interface between the application layer and the I/O layer.

Energy MPI workloads have unique requirements with the need for low latency communications between nodes. The nodes are connected via high-speed interconnect and are not very amenable to sharing with other workloads. MPI applications leverage the entire high-performance interconnects using Pass-Through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre also accessed via the high-speed interconnect. Lustre/BeeGFS is typically used to handle the large throughput requirements of primarily seismic processing (but also reservoir simulation).

Parallel file systems such as Lustre are used for HPC Energy workloads that require access to large files, simultaneous access from multiple compute nodes, and massive amounts of data. The implementation of parallel file systems makes it easy to scale in terms of capability and performance. Such file systems take advantage of RDMA transfers with large bandwidth and reduced CPU usage. The parallel file system is usually used as scratch space and intended for work that requires optimized I/O. Examples include workload setup, pre-processing, running, and post-processing.

When using an orchestrated parallel file service, such as Lustre or BeeGFS, works for up to 50,000 cores, with read/write rates up to 50 GiB/s, and 500 TB storage. For even larger clusters, a bare-metal approach may be more cost-effective. For example, Cray ClusterStor is a managed HPC storage solution with the flexibility to support larger elastic clusters on the fly with more than 50,000 cores, read/write rates more than 30 GiB/s and more than 500 TB data storage.

For more information on Parallel Virtual file system on Azure, see [Parallel Virtual File Systems on Microsoft Azure - Part 1: Overview - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-global/parallel-virtual-file-systems-on-microsoft-azure-part-1-overview/ba-p/306487).

 - Azure NetApp Files and local disks are typically used to handle the more latency/IOPS sensitive workloads, like seismic interpretation, model preparation, and visualization. Consider using  for workloads of up to 4,000 cores, with a throughput up to 6.5 GiB/s, and workloads that benefit from our require multiprotocol (NFS/SMB) access to the same data set.

 - Avere vFXT for faster, more accessible data storage for high-performance computing at the edge. Consider using Avere vFXT for Azure (6 to 24 nodes). This solution works for workloads of up to 50,000 cores, throughput up to 2 GiB/s for writes and up to 14 GiB/s for reads, a cache of up to 192 TB, and a file server of up to 2 petabytes (PB).

 - HPC Cache is also very useful in the hybrid scenario, when there is a requirement to sync data between on premises and the cloud, with a ready-heavy or high-read I/O pattern for energy workloads.
 - Standard or Premium Blob is a cost effective being the lowest cost cloud offering. provides exabyte scale, high throughput, low latency access where necessary, familiar file system and multi-protocol access (REST, HDFS, NFS). You can make use of the NFS v3.0 at the blob service endpoint for high throughput and read heavy workloads.  You can optimize costs by moving to cooler tiers with the ability to perform lifecycle management with last update/ last access time, intelligent tiering with customizable policies.

 - The Oil and Gas Energy workloads may also require large data size and volumes transfer mechanism from on-premises to Cloud and vice versa that can be achieved by
     - Offline - device based migration (DataBox)
     - Online - over the network (ExpressRoute) based migration.


## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.

- [Azure Billing and Azure Active Directory Tenants for Energy HPC](./azure-billing-active-directory-tenant.md)
- [Azure Identity and Access Management for Energy HPC](./identity-access-management.md)
- [Management for Energy HPC](./management.md)
- [Network Topology and Connectivity for Energy HPC](./network-topology-connectivity.md)
- [Platform automation and DevOps for Energy HPC](./platform-automation-devops.md)
- [Resource Organization for Energy HPC](./resource-organization.md)
- [Governance for Energy HPC](./security-governance-compliance.md)
- [Security for Energy HPC](./security.md)
- [Compute for Energy HPC](./compute.md)
- [Landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
