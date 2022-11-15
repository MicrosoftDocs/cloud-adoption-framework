---
title: 'Manufacturing HPC Storage | Microsoft Docs'
description: 'Storage access is an important part of planning for HPC workload performance.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Storage for manufacturing HPC

## Design Considerations

Storage access is an important part of planning for HPC workload performance. You need to make sure that the required data gets to the HPC cluster machines at the right time. You also need to make sure results from those individual machines are quickly saved and available for further analysis. Therefore, the following checklist will help to streamline the decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).

## Distribution of workload traffic

Account for the types of traffic your HPC environment will generate and process. This step is especially important if you plan to run multiple types of workloads and plan to use the storage for other purposes. The following traffic types should be recorded in your checklist:

 - Single stream versus multiple stream
 - Ratio of read traffic to write traffic
 - Average file sizes and counts
 - Random versus sequential access patterns

## Data locality

The next category accounts for the location of the data. Locality awareness will help you determine whether you can use copying, caching, or synchronization as your data movement strategy. Following some locality items which need to be checked beforehand:

 - Source data on-premises, in Azure, or both?
 - Results data on-premises, in Azure, or both?
 - Will HPC workloads in Azure be coordinated with source-data modification timelines?
 - Sensitive/HIPAA data?

## Performance requirements

Performance requirements for storage solutions can be generally summarized as followed:

 - Single-stream throughput (in GBps)
 - Multi-stream throughput (in GBps)
 - Expected maximum IOPS
 - Average latency (ms)

Every consideration affects performance, so these numbers represent a guide that a particular solution should achieve. For example, you might have an HPC workload that does extensive file creation and deletion as part of the workflow. Those operations could affect the overall throughput.

## Access methods

Account for the client access protocol required and be clear about what features of the protocol are required. There are different versions of NFS and SMB.

Here some items to be considered:

 - NFS/SMB versions required
 - Expected protocol features (ACLs, encryption)
 - Parallel file system solution

## Total capacity requirement

Storage capacity in Azure is the next consideration. It helps to inform the overall cost of the solution. If you plan to store a large amount of data for a long time, you might want to consider tiering as part of the storage solution. Tiering provides lower-cost storage options combined with higher-cost but higher-performance storage in a hot tier. Therefore the capacity requirements should be evaluated as followed:

 - Total capacity required
 - Total hot-tier capacity required
 - Total warm-tier capacity required
 - Total cold-tier capacity required

## Authentication/authorization method

Considering authentication/authorization requirements ensures to include the appropriate supporting systems, like an LDAP server or Active Directory environment, to the architecture. But if you need to support capabilities like UID/GID mapping to Active Directory users, you need to confirm that the storage solution supports that capability.

To  be considered:

 - Local (UID/GID on file server only)
 - Directory (LDAP, Active Directory)
 - UID/GID mapping to Active Directory users?

## Comparison of common Azure Storage solutions

| Category | Azure Blob Storage | Azure Files | Azure NetApp Files |
| -- | -- | -- | -- |
| Use cases | Blob Storage is best suited for large scale read-heavy sequential access workloads where data is ingested once and minimally modified further. <br><br> Blob Storage offers the lowest total cost of ownership, if there is little or no maintenance. <br><br> Some example scenarios are: Large scale analytical data, throughput sensitive high-performance computing, backup and archive, autonomous driving, media rendering, or genomic sequencing. | Azure Files is a highly available service best suited for random access workloads. <br><br> For NFS shares, Azure Files provides full POSIX file system support and can easily be used from container platforms like Azure Container Instance (ACI) and Azure Kubernetes Service (AKS) with the built-in CSI driver, in addition to VM-based platforms. <br><br> Some example scenarios are: Shared files, databases, home directories, traditional applications, ERP, CMS, NAS migrations that don't require advanced management, and custom applications requiring scale-out file storage. | Fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br> NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities. <br><br> Some example scenarios are: On-premises enterprise NAS migration that requires rich management capabilities, latency sensitive workloads like SAP HANA, latency-sensitive or IOPS intensive high performance compute, or workloads that require simultaneous multi-protocol access. |
| Available protocols | NFS 3.0 <br><br> REST <br><br> Data Lake Storage Gen2 | SMB <br><br> NFS 4.1 <br><br>  (No interoperability between either protocol) | NFS 3.0 and 4.1 <br><br> SMB |
| Key features | Integrated with HPC cache for low latency workloads. <br><br> Integrated management, including lifecycle, immutable blobs, data failover, and metadata index. | Zonally redundant for high availability. <br><br> Consistent single-digit millisecond latency. <br><br> Predictable performance and cost that scales with capacity. | Extremely low latency (as low as sub-ms). <br><br> Rich NetApp ONTAP management capability such as SnapMirror in cloud. <br><br> Consistent hybrid cloud experience. |
| Performance (Per volume) | Up to 20,000 IOPS, up to 100 Gib/s throughput. | Up to 100,000 IOPS, up to 80 Gib/s throughput. | Up to 460,000 IOPS, up to 36 Gib/s throughput. |
| Pricing | [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/) | [Azure Files pricing](https://azure.microsoft.com/pricing/details/storage/files/) | [Azure NetApp Files pricing](https://azure.microsoft.com/pricing/details/netapp/) |

## Roll-Your-Own Parallel File System

Just as with NFS, you can create a multi-node BeeGFS or Lustre file system. Performance of such systems is largely dependent on the type of Virtual Machines you select. You can leverage images found in the Azure Marketplace for [BeeGFS](https://azuremarketplace.microsoft.com/marketplace/apps/beegfs.beegfs-ubuntu-free?tab=Overview), or a Lustre implementation by DDN called [Whamcloud](https://azuremarketplace.microsoft.com/marketplace/apps/ddn-whamcloud-5345716.lustre_on_azure?tab=Overview). Leveraging third party images from vendors such as BeeGFS (found [here](https://www.beegfs.io/content/)) or DDN allows you to purchase their support. Otherwise both BeeGFS and Lustre can be used via their GPL licenses without additional charges (beyond the machines and disks) and easy to roll-out with the scripts provided [here](https://github.com/Azure/azurehpc/tree/master/examples) with either ephemeral local disks (for scratch) or Premium / Ultra SSD for persistent storage.

## Cray Cluster

One of the biggest challenges with the largest workloads is replicating the pure “bare-metal” performance of very large compute clusters working alongside very large Lustre environments (in terms of TB/s throughput, and perhaps in terms of Petabytes of storage). These workloads can now be run in Azure by leveraging the Cray ClusterStor solution. This is a pure bare-metal Lustre deployment placed in the relevant Azure data center. 
Parallel file systems such as BeeGFS and Lustre provide the highest performance due to their architecture. However, that architecture comes with a high management price and so the use of these technologies.

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
