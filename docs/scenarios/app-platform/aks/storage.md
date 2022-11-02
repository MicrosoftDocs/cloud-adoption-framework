---
title: Storage considerations for AKS
description: Storage considerations for Azure Kubernetes Service (AKS)
author: nillsf
ms.author: brblanch
ms.date: 11/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Storage considerations for Azure Kubernetes Service

To run specific application workloads, your organization or enterprise needs to design suitable Azure Kubernetes Service (AKS) platform-level capabilities. These workloads likely have different storage requirements. When choosing the right storage solution for your application, you have multiple considerations, including performance, availability, recoverability, security, and cost. The goal of this article is to guide you to choose the right option or combination of options for your workload.

Kubernetes can run both stateless and stateful workloads. Stateful workloads often require a storage solution for storing state. AKS supports multiple, integrated options for native storage, which include managed databases, disks (or blocks), and files and blob (or object) storage. Each of these options offer different SKUs, sizes, and performance characteristics. Selecting the right option requires careful consideration.

This article describes the types of storage and SKUs that are available for your workloads in [Design considerations](#design-considerations) and [Design recommendations](#design-recommendations). 

## How to select the right storage service

Choosing the right SKUs and sizes for your initial deployments requires some evaluations and, potentially, a proof-of-concept or test environment. Following are the high-level guidelines to help you get started with storage for AKS:

- For structured data that your application can store in a managed database that is available on the platform (for example, [AzureSQL](/azure/azure-sql/database/?view=azuresql)), we recommend using a managed database.

- If your application needs consistently low latency that is coupled with high I/O operations per second and high throughput to run your own databases and messaging applications on Kubernetes, use disks for storage. Consider using either [Azure Premium SSD](/azure/virtual-machines/disks-types#premium-ssds), [Azure Premium SSD v2](/azure/virtual-machines/disks-types#premium-ssd-v2), or [Azure Ultra Disk Storage](/azure/virtual-machines/disks-types#ultra-disks) for the best performance.

- For shared application data that requires high performance, use either [Azure NetApp Files](/azure/azure-netapp-files/) or the *premium* tier of [Azure Files](/azure/storage/files/). 

- Ensure that your nodes have sufficient network bandwidth to handle both application requests and storage requests. Storage traffic goes over the network stack, whether the transfers use SMB or NFS.

- For shared configuration data that requires only limited performance, use the *standard* tier of [Azure Files](/azure/storage/files/).

- For unstructured data—such as photos, videos, and text documents—use blob storage. Your application can do this by using blobs that are mounted as files via NFS or accessed as a virtual file system by using [BlobFuse](/azure/storage/blobs/blobfuse2-what-is). Alternatively, your application can read from and write to blob storage directly.

## Design considerations

The following considerations are for designing storage for AKS. Consider where storage is required in your AKS environment, and determine the best solution for each requirement.

- **Operating system (OS) disks**: Each virtual machine (VM) in Azure requires a disk for its OS. Because Kubernetes nodes are ephemeral, AKS defaults to using [ephemeral OS drives](/azure/aks/cluster-configuration#ephemeral-os) on supported VM sizes.

  - If required, you can instead use regular managed disks for the nodes in your AKS cluster. Doing so supports applications that need persistent data on the OS drive.

  - If you select a [managed disk](/azure/virtual-machines/disks-types) as the OS disk, ensure that it's sized appropriately to support the requirements of the OS, the Kubernetes system, and your workload.

- **Application data**: Some applications need a consistent data store for storage of application data. If your application requires a database, consider exploring the managed database options in Azure, such as [Azure SQL](/products/azure-sql/), [Azure Database by MySQL](/services/mysql/), [Azure Database for PostGres](/services/postgresql/), and [Cosmos DB](/services/cosmos-db/).

- **Storage solutions in AKS**: If a managed database doesn't meet the needs of your application, use another storage option that's available to AKS to store consistent data:

  - **Disk-based solutions**: Disks, or block storage, are ideal for storing data directly on a raw, block-based device. Disk-based storage is ideal for storing data for databases that your Kubernetes cluster hosts. In Azure, managed disks are the solution to get block-based storage.

    - Consider whether you want to use a [static disk created outside of AKS](/azure/aks/azure-disk-volume), or if you want [AKS to dynamically create the disk on your behalf](/azure/aks/azure-disks-dynamic-pv).

    - Consider [data redundancy](/azure/virtual-machines/disks-redundancy) and which [Azure disk performance type and size](/azure/virtual-machines/disks-scalability-targets) is required for your workload.

    - Consider whether you need a [shared disk](/azure/virtual-machines/disks-shared-enable).

    - Ensure that your [Kubernetes node size](/azure/virtual-machines/sizes) is large enough to support both the number of disks and the aggregate throughput requirements.

    - Ensure that your [managed disk](/azure/virtual-machines/disks-types) is sized appropriately for your workload's performance requirements. For Standard HDD, Standard SSD, and Premium SSD v1, performance increases as the disk size increases.

  - **Ephemeral disks solutions**: There are cases where you need either non-persistent, temporary storage or where you want to use the high-performance drives in the [storage-optimized VM-series](/azure/virtual-machines/sizes-storage). To connect to an ephemeral volume, you can use either the `emptydir` [option](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) in Kubernetes or the driver for a [CSI ephemeral local volume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#csi-ephemeral-volumes). We recommend `emptydir` for ephemeral data, such as a scratch space. For storage on the storage-optimized VM-series, we recommend a CSI ephemeral local volume.

  - **Files-based solutions**: File storage exposes a shared file system via either NFS or SMB/CIFS. A shared file system is ideal for application and configuration data that is read and shared by multiple pods in your Kubernetes cluster. Azure has two solutions for file-based storage: 

    - Azure Files:

      - Consider whether you want to use a [static file share that's created outside of AKS](/azure/aks/azure-files-volume), or if you want [AKS to create the file share dynamically on your behalf](/azure/aks/azure-files-dynamic-pv).

      - Evaluate if standard performance is sufficient or if you need premium performance from Azure Files.

      - Evaluate whether you want to use the default SMB/CIFS API to access Azure Files or if you need NFS support.

      - Consider the network model that you want to use to access Azure Files: access via direct public IP address, a service endpoint, or a private link.

    - Azure NetApp Files (ANF):

      - Consider whether you want to use a [static ANF share that's created outside of AKS](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-statically), or if you want [AKS to create the file share dynamically](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-dynamically) on your behalf via Astra Control.

      - Evaluate which performance tier is required for your workload.

      - Explore the [networking recommendations for ANF](/azure/azure-netapp-files/azure-netapp-files-network-topologies).

  - **Blob**: Azure blob storage is Microsoft's object storage platform. It's accessible via an HTTP API or through the SDKs. Mounting Azure Blob storage as a file system into a container or pod is ideal for application workloads that have massive amounts of unstructured data, such as log files, images, documents, streaming media, and disaster-recovery data.

    - Evaluate which [data redundancy](/azure/storage/common/storage-redundancy) that your application requires. Data redundancy is defined at the level of the storage account. Also evaluate which [performance tier](/azure/storage/blobs/access-tiers-overview) of blob storage your application requires.

    - Consider which [authentication method](/azure/storage/common/authorize-data-access) for access to blob storage that you want to use: storage key, SAS, or Azure Active Directory.

    - Typically, applications that access blob storage use the API in the application through [one of the SDKs](/azure/storage/blobs/storage-blobs-introduction), which abstracts the interaction with blob storage from the Kubernetes cluster.

    - Consider whether you want to use a [static blob storage container that's created outside of AKS](/azure/aks/azure-csi-blob-storage-static?tabs=secret) or if you want [AKS to create the blob storage container dynamically on your behalf](/azure/aks/azure-csi-blob-storage-dynamic).

    - If you want to access blob storage as a file system, you can use the [blob CSI driver](https://github.com/kubernetes-sigs/blob-csi-driver) in Kubernetes. This driver allows access to blob storage through either the [NFSv3 protocol](/azure/storage/blobs/network-file-system-protocol-support) or through a [fuse driver](https://github.com/Azure/azure-storage-fuse).

  - **Other**: There are multiple specialized storage solutions in Azure that can integrate with Kubernetes. This article does not cover those in depth, but the following list identifies possible solutions:

    - [HPC cache](/azure/aks/azure-hpc-cache): Azure HPC Cache speeds access to your data for high-performance computing (HPC) tasks. By caching files in Azure, Azure HPC Cache brings the scalability of cloud computing to your existing workflow.

    - [ADLS Gen 2](/azure/storage/blobs/data-lake-storage-introduction): A special type of Azure blob storage that's optimized for big data workloads like Hadoop and Spark.

## Design recommendations

- For OS disks, we recommend ephemeral disks. To benefit from this feature, select a VM size that has an adequately sized temporary disk.

- For application data, we recommend managed databases.

- For all storage solutions that support this, we recommend Private Link for access to storage.

- For Azure disks:

  - In most cases, we recommend Premium or Ultra disks to ensure adequate performance.

  - Ensure that your Kubernetes node size is large enough to support the number of disks and the amount of aggregate throughput.

  - Consider taking snapshots of persistent volumes either to provision a new volume (which are pre-populated with the snapshot data) or to restore the existing volume to a previous state by using the snapshot capability of the Azure Disks CSI driver.

  - Avoid striping across multiple disks in Kubernetes.

  - Use persistent volumes (PV) and persistent volume claims (PVC) in Kubernetes to dynamically create disks where required.

- For Azure Files:

  - If performance is critical, we recommend the premium tier.

  - Provide dedicated storage accounts for your file shares.

  - Consider carefully whether you want Kubernetes to create the file shares or if you want to create them statically outside of Kubernetes.

- For Azure Blob:

  - Use an application-level SDK to interface with blob storage.

  - Use AAD-integrated authorization for blob storage. Avoid using the shared storage account key.

  - Use lifecycle management policies to move infrequently accessed data to a cooler access tier.

  - If you can't use an application-level SDK to interface with blob storage, consider using the NFSv3 option in the blob CSI driver.
