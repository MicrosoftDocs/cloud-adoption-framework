---
title: Storage considerations for AKS
description: Storage considerations for Azure Kubernetes Service (AKS)
author: nillsf
ms.author: nilfran
ms.date: 11/15/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Storage considerations for Azure Kubernetes Service (AKS)

This article explains how to choose and implement the most effective storage options for your Azure Kubernetes Service (AKS) workloads. Selecting the right storage solution is critical for achieving optimal application performance, reliability, and cost efficiency in your Kubernetes environment.

Azure Kubernetes Service supports both stateless and stateful workloads. When deploying stateful applications, you need appropriate storage solutions to maintain application state. AKS integrates with multiple native storage options, including managed databases, disks (block storage), files, and blob (object) storage. Each option provides different performance characteristics, availability guarantees, and cost structures to address various workload requirements.

## Select the right storage service

Choosing the right storage solution for your AKS workloads impacts performance, reliability, and cost efficiency. Use these guidelines to select the appropriate storage service based on your data requirements:

| Data type | Recommended storage service | When to use this service |
|-----------|---------------------------|--------------------------|
| Structured data | Managed databases ([Azure SQL](/azure/azure-sql/database/), [Azure Database for MySQL](/azure/mysql/), [Azure Database for PostgreSQL](/azure/postgresql/), [Azure Cosmos DB](/azure/cosmos-db/)) | For relational or NoSQL data that requires built-in high availability, automatic backups, and scalability without managing the underlying infrastructure |
| Unstructured data | [Azure Blob Storage](/azure/storage/blobs/) | For large volumes of object data like media files, documents, and logs that need HTTP/REST-based access through SDKs, NFS protocol, or [BlobFuse](/azure/storage/blobs/blobfuse2-what-is) |
| Shared file data (high performance) | [Azure NetApp Files](/azure/azure-netapp-files/) or [Azure Files Premium](/azure/storage/files/) | For shared file access with submillisecond latency (Azure NetApp Files) or consistent single-digit millisecond latency (Azure Files Premium) requirements |
| Shared configuration data | [Azure Files Standard](/azure/storage/files/) | For configuration files, shared application state, and other data with moderate performance requirements |
| Database and transactional workloads | [Azure Managed Disks](/azure/virtual-machines/disks-types) (Premium SSD, Premium SSD v2, Ultra Disk) | For stateful applications requiring dedicated, high-performance block storage with specific IOPS and throughput guarantees |
| Ephemeral, temporary data | [Ephemeral disks](/azure/virtual-machines/ephemeral-os-disks) | For temporary data that doesn't need to persist between pod or node restarts |

Before making your final storage decision, evaluate performance requirements through proof-of-concept testing with realistic workloads. Remember that all storage traffic in AKS travels over the network, so ensure your nodes have sufficient network bandwidth to handle both application and storage traffic.

## Design considerations

The following considerations are for designing storage for AKS. Consider where storage is required in your AKS environment, and determine the best solution for each requirement.

### Operating system (OS) disks

For operating system (OS) disks, consider the following factors:

- **Ephemeral disks for OS**. Each virtual machine (VM) in Azure requires a disk for its OS. Because Kubernetes nodes are ephemeral, AKS defaults to using ephemeral OS disks on supported VM sizes. For more information about ephemeral OS disks, see [Ephemeral OS](/azure/aks/concepts-storage#ephemeral-os-disk).

- **Managed disks for OS**. If your workload requires them, you can instead use regular managed disks for the nodes in your AKS cluster. Doing so supports workloads that require persistent data on the OS drive. For more information about options for persistent storage, see [Storage options for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-storage).

- **Sizing managed disks**. If you select a managed disk as the OS disk, ensure you size it to support the requirements of the OS, the Kubernetes system, and your workload. For more information about options and differences, see [Azure managed disk types](/azure/virtual-machines/disks-types).

### Application data

Some workloads need a consistent data store for storage of application data. If your application requires a database, consider exploring the managed databases in Azure, which include the following options: 

- [Azure SQL](https://azure.microsoft.com/products/azure-sql/)
- [Azure Database for MySQL](https://azure.microsoft.com/products/mysql/)
- [Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/)
- [Azure Cosmos DB](https://azure.microsoft.com/products/cosmos-db/)

### Storage solutions in AKS

If a managed database doesn't meet the needs of your application, consider using another storage option that's available to AKS to store consistent data. Options include disk-based solutions, ephemeral disks, files-based solutions, blob storage, and other options that aren't covered in this article.

#### Disk-based solutions

Disks, or block storage, are ideal for storing data directly on a raw, block-based device. Disk-based storage is ideal for storing data for databases that your Kubernetes cluster hosts. In Azure, managed disks are the solution to get block-based storage.

- **Static or dynamically created disk storage**. You must use a static disk that you create outside of AKS or the disk storage AKS dynamically creates as a pod or pods require it. Storage that is created dynamically can also be deleted dynamically. For more information, see:

  - [Create a static volume with Azure disks](/azure/aks/azure-disk-volume)
  - [Dynamically create and use a persistent volume with Azure Disks](/azure/aks/azure-disks-dynamic-pv)

- **Redundancy and performance**. Consider the storage redundancy and performance that your workload requires. For more information, see:

  - [Redundancy options for managed disks](/azure/virtual-machines/disks-redundancy)
  - [Azure disk performance type and size](/azure/virtual-machines/disks-scalability-targets)

- **Shared disk**. Consider whether you need a shared disk. For more information about options, see [Share an Azure managed disk](/azure/virtual-machines/disks-shared).

- **Size of node for disks and throughput**. Consider the size of your Kubernetes node. It must be large enough to support both the number of disks and the aggregate throughput requirements. For information about sizes and characteristics, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

- **Disk size and required performance**. Consider whether your managed disk is sized appropriately for your workload's performance requirements. Performance increases as the disk size increases for Standard *HDD*, Standard SSD, and Premium SSD v1. For more information about managed disks, see [Azure managed disk types](/azure/virtual-machines/disks-types).

#### Ephemeral disks solutions

Consider whether your application requires non-persistent, temporary storage or where you want to use the high-performance drives in the [storage-optimized VMs](/azure/virtual-machines/sizes-storage). To connect to an ephemeral volume, you can use either the [**emptyDir** option](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) in Kubernetes or the driver for a [CSI ephemeral local volume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#csi-ephemeral-volumes). We recommend **emptyDir** for ephemeral data, such as scratch space. For storage on the storage-optimized VM series, we recommend using CSI with an ephemeral local volume. For more information about CSI drivers, see [Container Storage Interface (CSI) drivers on Azure Kubernetes Service (AKS)](/azure/aks/csi-storage-drivers).

#### Azure Container Storage

Azure Container Storage is a cloud-based volume management, deployment, and orchestration service built natively for containers. If you plan to use block-based storage with ReadWriteOnce mode, using Azure Disks, Ephemeral Disk, or Azure Elastic SAN, Azure Container Storage offers advantages over direct use of the CSI drivers:

- Better price-performance: Share a single disk across multiple PVs to reduce overprovisioning and lower costs.
- Higher PV scale: Supports up to 75 PVs per node superseding the 64-PV limit with CSI drivers.
- Local NVMe with replication: Enables submillisecond latency and resiliency for ephemeral disks, ideal for workloads with built-in replication such as Cassandra.
- Faster provisioning and scaling: Batch operations speed up volume provisioning and scaling compared to serial CSI driver operations.

For more information, see [What is Azure Container Storage?](/azure/storage/container-storage/container-storage-introduction)

#### Files-based solutions

Determine if your pods require access to a shared file system. Use a shared file system for application and configuration data that multiple pods in your Kubernetes cluster must read and share. File storage provides a shared file system through either NFS or SMB/Common Internet File System (CIFS) protocols. Azure offers two solutions for file-based storage: Azure Files and Azure NetApp Files.

##### Azure Files

For Azure Files, consider the following options:

- **Static or dynamically created file share**. Consider using a static file share that you create outside of AKS or a file share that AKS creates dynamically on your behalf. For more information, see:

  - [Manually create and use a volume with Azure Files share](/azure/aks/azure-files-volume)
  - [Dynamically create and use a persistent volume with Azure Files](/azure/aks/azure-files-dynamic-pv)

- **Standard or premium performance**. Evaluate if standard performance is sufficient or if you need premium performance from Azure Files.

- **SMB/CIFS or NFS**. For access to Azure Files, evaluate whether your workload should use the API for the default protocol, SMB/CIFS, or if your workload requires NFS support.

- **Network model for access**. Consider the network model that you want to use to access Azure Files: access via direct public IP address, a service endpoint, or a private link.

##### Azure NetApp Files

For Azure NetApp Files, consider the following options:

- **Static or dynamically created Azure NetApp Files share**. Consider using a static Azure NetApp Files share that you create outside of AKS or the file share AKS creates dynamically via Astra Control. For more information, see:

  - [Provision Azure NetApp Files volumes statically](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-statically)
  - [Provision Azure NetApp Files volumes dynamically](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-dynamically)

- **Evaluate for performance**. Evaluate which performance tier is required for your workload. For more information, see [Performance considerations for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-performance-considerations).

- **Plan your network**. Explore the networking recommendations for Azure NetApp Files. For more information, see [Guidelines for Azure NetApp Files network planning](/azure/azure-netapp-files/azure-netapp-files-network-topologies).

#### Blob storage

Consider the amount of unstructured data that your application needs to store. Azure Blob storage is accessible via an HTTP API or through the SDKs. Mounting blob storage as a file system into a container or pod is ideal for application workloads that have massive amounts of unstructured data, such as log files, images, documents, streaming media, and disaster-recovery data.

- **Data redundancy**. Consider which data redundancy suits your application. For more information, see [Azure Storage redundancy](/azure/storage/common/storage-redundancy). Data redundancy is selected at the level of the storage account. 

- **Performance tier**. Consider which performance tier of blob storage your application requires. For more information, see [Hot, cool, and archive access tiers for blob data](/azure/storage/blobs/access-tiers-overview).

- **Authentication method for access**. Consider which authentication method that your application should use for access to blob storage: storage key, SAS, or Microsoft Entra ID. For more information, see [Authorize access to data in Azure Storage](/azure/storage/common/authorize-data-access).

- **API to abstract blob storage**. Consider which API to use. Typically, applications that access blob storage use the API in the application through one of the SDKs, which abstracts the interaction with blob storage from the Kubernetes cluster. For more information about libraries for various programming languages, see [Introduction to Azure Blob storage](/azure/storage/blobs/storage-blobs-introduction).

- **Static or dynamically created blob storage**. Consider using a static blob storage container that you create outside of AKS or the blob storage container AKS creates dynamically on your behalf. For more information, see:

  - [Create and use a static volume with Azure Blob storage](/azure/aks/azure-csi-blob-storage-static)
  - [Dynamically create and use a persistent volume with Azure Blob storage](/azure/aks/azure-csi-blob-storage-dynamic)

- **Driver for accessing storage**. Consider how your application should access blob storage. To access it as a file system, you can use the [blob CSI driver](https://github.com/kubernetes-sigs/blob-csi-driver) in Kubernetes. This driver allows access to blob storage through either the [NFSv3 protocol](/azure/storage/blobs/network-file-system-protocol-support) or through a [fuse driver](https://github.com/Azure/azure-storage-fuse).

#### Other storage solutions

There are multiple specialized storage solutions in Azure that can integrate with Kubernetes. This article doesn't cover these specialized storage solutions, but the following list identifies possible solutions:

- **Azure HPC cache**. HPC Cache speeds access to your data for high-performance computing (HPC) tasks. By caching files in Azure, Azure HPC Cache brings the scalability of cloud computing to your existing workflow. For more information, see [Integrate Azure HPC Cache with Azure Kubernetes Service](/azure/aks/azure-hpc-cache).

- **Azure Data Lake Storage Gen2**. Data Lake Storage Gen2 is a special type of blob storage that's optimized for big data workloads like Hadoop and Spark. For more information, see [Introduction to Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction).

## Design recommendations

This section provides recommendations that are effective for Azure customers.

- **Use Azure Private Link**. For security, we recommend using Azure Private Link for all storage solutions that support it. Azure Private Link enables access to Azure Services, such as Azure Storage and SQL Database, and Azure-hosted services over a private endpoint in your virtual network. For more information, see [What is Azure Private Link?](/azure/private-link/private-link-overview)

- **Use ephemeral disks for OS**. For OS disks, we recommend using ephemeral disks. To benefit from this feature, select a VM size that has an adequately sized temporary disk. For more information, see [Ephemeral OS disks for Azure VMs](/azure/virtual-machines/ephemeral-os-disks).

- **Use managed databases**. For application data, we recommend using managed databases. For a list of database options, see [Types of Databases on Azure](https://azure.microsoft.com/products/category/databases/).

The following sections describe more recommendations for Azure disks, Azure Files, and blob storage.

### Use Azure Container Storage

The following sections contain recommendations for using Azure Container Storage with AKS.

#### Azure Container Storage requirements

- **AKS cluster prerequisites**: Deploy an AKS cluster with at least three virtual machines in your node pool, each with a minimum of four vCPUs.
- **Access mode limitations**: Azure Container Storage only supports ReadWriteOnce access mode. For workloads requiring ReadWriteMany access, use Azure Files instead. For more information on access modes, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

#### Choose the correct Azure Container Storage type

- **Azure Disks**: Use for tier 1 and general purpose databases like MySQL, MongoDB, and PostgreSQL. When using UltraSSD_LRS or PremiumV2_LRS disks, specify performance parameters (IOPS and throughput) directly in your storage pool definition with the [IOPSReadWrite and MBpsReadWrite parameters](/azure/storage/container-storage/use-container-storage-with-managed-disks#create-a-dynamic-storage-pool). This approach ensures Azure Container Storage provisions optimal disk resources for your performance needs.

- **Azure Ephemeral Disks**: Best for applications requiring ultra-low latency (submillisecond) with either no data durability requirements or with built-in application-level data replication (such as Cassandra). Data on ephemeral disks doesn't persist through VM reboots. While Azure Container Storage with NVMe supports volume replication for resilience against single-node failures, you lose data if all replicas reboot simultaneously. Assess this risk carefully for your specific workload. NVMe is available on [storage optimized L-Family VM SKUs](/azure/virtual-machines/sizes/overview?tabs=breakdownseries%2Cgeneralsizelist%2Ccomputesizelist%2Cmemorysizelist%2Cstoragesizelist%2Cgpusizelist%2Cfpgasizelist%2Chpcsizelist#storage-optimized).

#### Configure Azure Container Storage resiliency

When designing for resiliency with Azure Container Storage, choose one of these approaches for high availability:

|Resiliency approach|Description|Best for|
|-------------------|-----------|---------|
|Zone-redundant storage (ZRS)|Replicates data across two or more availability zones automatically to protect against zone failures.|Workloads requiring automatic data protection from zone-level failures without application-level replication.|
|Multi-zone storage pools|Distributes storage capacity equally across availability zones, with each zone maintaining its own distinct storage resources.|Workloads with application-level replication (like Cassandra) that already manage their own data redundancy.|

>[!Note]
> You can't use both ZRS and multi-zone storage pools simultaneously as they serve similar purposes through different mechanisms. Implement regular [volume snapshots](/azure/storage/container-storage/volume-snapshot-restore) as part of your backup and disaster recovery strategy regardless of which approach you choose.

### Azure disks

For Azure disks, we recommend the following design options:

  - **Use Premium or Ultra disks**. In most cases, we recommend Premium or Ultra disks to ensure adequate performance. For more information, see [Azure Disk Storage](https://azure.microsoft.com/products/storage/disks/).

  - **Size the node for disks and throughput**. We recommend ensuring that the size of your Kubernetes node is large enough to support the number of disks and the amount of aggregate throughput. For information about sizes and characteristics, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

  - **Create snapshots of persistent volumes**. Take snapshots of persistent volumes to back up data or restore volumes to a previous state by using the Azure Disks CSI driver. For more information, see [Volume snapshots](/azure/aks/azure-disk-csi#volume-snapshots).

  - **Avoid disk striping across disks**. We recommend that you avoid striping across multiple disks in Kubernetes.

  - **Use PV/PVC**. We recommend using PV and PVC in Kubernetes to dynamically create disks where required. For more information about persistent storage, see [Storage options for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-storage).

### Azure Files

For Azure Files, we recommend the following design options:

  - **Choose Premium**. If performance is critical, we recommend using the Premium tier.

  - **Create dedicated storage accounts**. We recommend providing dedicated storage accounts for your file shares.

  - **Choose static or dynamically created file shares**. We recommend careful consideration of whether you want AKS to create the file shares or if you want to create them statically outside of Kubernetes. Storage that is created dynamically can also be deleted dynamically. For more information about letting AKS dynamically create file shares, see [Dynamically create and use a persistent volume with Azure Files](/azure/aks/azure-files-dynamic-pv).

### Azure NetApp Files

For Azure NetApp Files, we recommend the following design options:

  - **Choose a performance tier based on the application requirements.** Azure NetApp Files offers three performance tiers that offer varying classes of performance. For more information, see [Performance considerations for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-performance-considerations).
  
  - **Create capacity pools in the same Azure region as the AKS cluster.** For more information, see [Create a capacity pool for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-set-up-capacity-pool).

  - **Use the Auto QoS type for capacity pools.** 

  - **Plan your network.** Two options exist for network design: 
    1. If you use the same virtual network for AKS and Azure NetApp Files, create a dedicated subnet for Azure NetApp Files and [delegate the subnet](/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) to Microsoft.NetApp/Volumes.
    2. If you use different VNets, establish virtual network peering between them.

### Blob storage

For blob storage, we recommend the following design options:

  - **Use an SDK to interface with storage**. We recommend using an application-level SDK to interface with blob storage.

  - **Use CSI with NFS to interface with storage**. If you can't use an application-level SDK to interface with blob storage, we recommend using the NFS v3 option in the blob CSI driver. For more information, see [Use Azure Blob storage Container Storage Interface (CSI) driver](/azure/aks/azure-blob-csi).

  - **Use Microsoft Entra ID for access**. We recommend using Microsoft Entra ID for authorizing access to blob storage. Avoid using a shared storage account key. For more information, see [Authorize access to blobs using Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory).

  - **Adjust tier levels**. We recommend using lifecycle management policies to move infrequently accessed data to a cooler access tier. For more information, see [Hot, cool, and archive access tiers for blob data](/azure/storage/blobs/access-tiers-overview).

## Next steps

Learn how to scope cost allocation to a deployment, a service, a label, a pod, or a namespace in AKS by using Kubecost.

> [!div class="nextstepaction"]
> [Cost governance with Kubecost](./cost-governance-with-kubecost.md)
