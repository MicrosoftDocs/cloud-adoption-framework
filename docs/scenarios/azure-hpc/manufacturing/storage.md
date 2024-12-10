---
title: 'Manufacturing HPC storage in Azure'
description: Learn about storage access, various storage solution capabilities, and how to streamline your storage decision process as a part of planning for HPC workload performance.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/16/2022
---

# Manufacturing HPC storage

Storage access is an important part of planning for HPC workload performance. The following materials help to streamline your decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).

## Design considerations

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
| Key features | Integrated with HPC cache for low-latency workloads. <br><br> Integrated management, including lifecycle, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | High storage capacity up to 12.5 PiB upon request. <br><br> Low (~2ms) latency. <br><br> Spin up new clusters in minutes. <br><br> Supports containerized workloads with AKS. | Extremely low latency (as low as sub-ms). <br><br> Rich NetApp ONTAP management capability such as SnapMirror in cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (Per volume) | Up to 20,000 IOPS, up to 100 GiB/s throughput. | Up to 100,000 IOPS, up to 80 GiB/s throughput. | Up to 1M IOPS, up to 500 GiB/s throughput. | Up to 460,000 IOPS, up to 36 GiB/s throughput. |
| Pricing | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files/) | [Azure Managed Lustre pricing](https://azure.microsoft.com/pricing/details/managed-lustre) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp/) |

## Roll-your-own parallel file system

As with NFS, you can create a multi-node BeeGFS or Lustre file system. Performance of such systems is largely dependent on the type of Virtual Machines you select. You can use images found in the Azure Marketplace for [BeeGFS](https://azuremarketplace.microsoft.com/marketplace/apps/beegfs.beegfs-ubuntu-free?tab=Overview), or a Lustre implementation by DDN called [Whamcloud](https://whamcloud.com/). Using third-party images from vendors such as [BeeGFS](https://www.beegfs.io/content/) or DDN lets you purchase their support. Otherwise, you can use both BeeGFS and Lustre by way of their GPL licenses without other charges (beyond the machines and disks). These tools are easy to roll out using the [Azure HPC scripts](https://github.com/Azure/azurehpc/tree/master/examples) with either ephemeral local disks (for scratch) or Premium / Ultra SSD for persistent storage.

## Cray ClusterStor

One of the biggest challenges with larger workloads is replicating the pure “bare-metal” performance of large compute clusters working alongside large Lustre environments (in terms of TB/s throughput, and possibly Petabytes of storage). You can now run these workloads with the Azure Cray ClusterStor solution. This approach is a pure bare-metal Lustre deployment placed in the relevant Azure data center. Parallel file systems such as BeeGFS and Lustre provide the highest performance due to their architecture. But that architecture comes with a high management price and so does the use of these technologies.

## Next steps

The following articles provide guidance on each step in the cloud adoption journey for manufacturing HPC environments.

- [Manufacturing HPC Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Azure identity and access management for HPC in manufacturing](./identity-access-management.md)
- [Management for HPC in the manufacturing industry](./management.md)
- [Manufacturing HPC network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in the manufacturing industry](./platform-automation-devops.md)
- [Manufacturing HPC resource organization](./resource-organization.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
