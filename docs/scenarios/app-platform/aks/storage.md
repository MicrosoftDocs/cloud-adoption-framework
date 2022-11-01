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

Choosing the right SKUs and sizes to start with requires some evaluations and potentially a proof-of-concept or test environment. Following are the high-level guidelines to help you kickstart with storage for AKS:

- For structured application data that can use a specific managed database (for example, AzureSQL) available on the platform, this is the recommended option.

- If your application needs low consistent latency coupled with high IOPS and throughput to run your own databases, messaging applications on Kubernetes, use disks. Consider using either Premium SSD, Premium SSD v2 or Ultra Disks for the best performance.

- For shared application data with high performance needs, use either Azure Files premium or Azure NetApp Files. 

- Ensure your nodes have sufficient network bandwidth to handle application requests and storage requests (given SMB or NFS traffic goes over the network stack).

- For shared configuration data with limited performance requirement, use Azure Files standard.

- For unstructured data like photos, videos, and text documents, use blob storage. You can do this by using blobs that are mounted as files via NFS or blobfuse or by reading/writing to blob directly from within your application.

## Design considerations

The following is a list of design considerations when it comes to storage in AKS. Consider where storage is required in your AKS environment, and determine the best solution for each requirement.

- **Operating system disks**: Each virtual machine (VM) in Azure requires a disk for its operating system. Because Kubernetes nodes are ephemeral, AKS defaults to using [ephemeral OS drives](/azure/aks/cluster-configuration#ephemeral-os) on supported VM sizes.

  - If required, you can use regular managed disks instead for the nodes in your AKS cluster, in case you need to persist certain data that you store on the OS drive.

  - If you select a [managed disk](/azure/virtual-machines/disks-types) as the operating system disk, ensure that it's sized appropriately to support the requirements of the operating system, Kubernetes system and your workload.

- **Application data**: Some applications need a consistent data store for storage of application data. If your application requires a database, consider exploring the managed database options in Azure, such as [Azure SQL](/products/azure-sql/), [Azure Database by MySQL](/services/mysql/), [Azure Database for PostGres](/services/postgresql/), and [Cosmos DB](/services/cosmos-db/).

- **Storage solutions in AKS**: If a managed database doesn't meet the needs of your application, AKS has multiple storage options available to store consistent data:

  - **Disk-based solutions**: Disks, or block storage, are ideal for storing data directly on a raw block-based device, which is ideal for storing data for databases you would host in your Kubernetes cluster. In Azure, managed disks are the solution to get block-based storage.

    - Consider whether you want to use a [static disk created outside of AKS](/azure/aks/azure-disk-volume), or if you want [AKS to dynamically create the disk on your behalf](/azure/aks/azure-disks-dynamic-pv).

    - Consider [data redundancy](/azure/virtual-machines/disks-redundancy) and which [Azure disk performance type and size](/azure/virtual-machines/disks-scalability-targets) is required for your workload.

    - Consider whether you need a [shared disk](/azure/virtual-machines/disks-shared-enable).

    - Ensure that your [Kubernetes node size](/azure/virtual-machines/sizes) is large enough to support both the number of disks and the aggregate throughput requirements.

    - Ensure that your [managed disk](/azure/virtual-machines/disks-types) is sized appropriately for your workload's performance requirements. For standard HDD, standard SSD, and premium v1 disks, the performance increases as the disk size increases.

  - **Ephemeral disks solutions**: There are cases where you need either a non-persistent temporary storage location or where you want to use the high-performance drives in the [storage-optimized VM-series](/azure/virtual-machines/sizes-storage). To connect to an ephemeral volume, you can either use the `emptydir` [option](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) in Kubernetes, or use the [CSI ephemeral local volume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#csi-ephemeral-volumes) driver. `emptydir` is recommended for ephemeral data such as a scratch space, whereas the CSI ephemeral local volume is recommended for storage on the storage-optimized VM-series.

  - **Files-based solutions**: File storage exposes a shared file-system either via NFS or via SMB/CIFS, which is ideal for shared application data and configuration data that is read by multiple pods in your Kubernetes cluster. Azure has two solutions for file based storage: 

    - Azure Files:

      - Consider whether you want to use a [static file share created outside of AKS](/azure/aks/azure-files-volume), or if you want [AKS to create the file share dynamically on your behalf](/azure/aks/azure-files-dynamic-pv).

      - Evaluate if standard performance is sufficient, or if you need premium performance from Azure Files.

      - Evaluate whether you want to use the default SMB/CIFS API to access Azure Files, or if you need NFS support.

      - Consider the network model you want to use to access Azure Files: either via direct public IP address, via a service endpoint or via private link.

    - Azure NetApp Files (ANF):

      - Consider whether you want to use a [static ANF share created outside of AKS](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-statically), or if you want [AKS to create the file share dynamically](/azure/aks/azure-netapp-files#provision-azure-netapp-files-volumes-dynamically) on your behalf via Astra Control.

      - Evaluate which performance tier is required for your workload.

      - Explore the [networking recommendations for ANF](/azure/azure-netapp-files/azure-netapp-files-network-topologies).

  - **Blob**: Azure blob storage is Microsoft's object storage platform. It's accessible via an HTTP API or through the SDKs. Mounting Azure Blob storage as a file system into a container or pod is ideal for application workloads that have massive amounts of unstructured data, such as log files, images, documents, streaming media, and disaster-recovery data.

    - Evaluate which [data redundancy](/azure/storage/common/storage-redundancy) (defined at storage account level) is required and which [performance tier](/azure/storage/blobs/access-tiers-overview) of blob storage is needed.

    - Consider which [authentication method](/azure/storage/common/authorize-data-access) to blob you want to use: storage key, SAS or AAD-integrated.

    - Typically, applications accessing blob storage make use of the API in the application through [one of the SDKs](/azure/storage/blobs/storage-blobs-introduction); making the interaction with blob abstracted from the Kubernetes cluster.

    - Consider whether you want to use a [static blob storage container created outside of AKS](/azure/aks/azure-csi-blob-storage-static?tabs=secret) or if you want [AKS to create the blob storage container dynamically on your behalf](/azure/aks/azure-csi-blob-storage-dynamic).

    - If you want to access blob storage like a file system, you can use the [blob CSI driver](https://github.com/kubernetes-sigs/blob-csi-driver) in Kubernetes. This driver will allow you to access blob through either an [NFSv3 protocol](/azure/storage/blobs/network-file-system-protocol-support) or through a [fuse driver](https://github.com/Azure/azure-storage-fuse).

  - **Other**: There are multiple specialized storage solutions in Azure that can also be integrated with Kubernetes, which won't be explored in depth in this document.

    - [HPC cache](/azure/aks/azure-hpc-cache): Azure HPC Cache speeds access to your data for high-performance computing (HPC) tasks. By caching files in Azure, Azure HPC Cache brings the scalability of cloud computing to your existing workflow.

    - [ADLS Gen 2](/azure/storage/blobs/data-lake-storage-introduction): A special type of Azure blob storage optimized for big data workloads like Hadoop and Spark.

## Design recommendations

- For OS disks, ephemeral disks are recommended. In order to benefit from this feature, make sure to select a VM size with an adequately sized temporary disk.

- For application data, managed databases are recommended.

- For all storage solutions that support this, Private Link is the recommended solution to access storage.

- For Azure disks:

  - In most cases, Premium or Ultra disks are recommended to ensure adequate performance.

  - Ensure your Kubernetes node size is large enough to support the amount of disks and aggregate throughput.

  - Consider taking snapshots of persistent volumes either to provision a new volume (pre-populated with the snapshot data) or to restore the existing volume to a previous state using the Azure Disks CSI driver snapshot capability.

  - Avoid striping across multiple disks in Kubernetes.

  - Use PVC/PV in Kubernetes to dynamically create disks where required.

- For Azure Files:

  - In case performance is critical, the premium tier is recommended.

  - Have dedicated storage accounts for your file shares.

  - Consider carefully whether you want Kubernetes to create the file shares or if you want to create them statically outside of Kubernetes.

- For Azure Blob:

  - Use an application-level SDK to interface with blob storage.

  - Use AAD-integrated authorization for blob storage. Avoid using the shared storage account key.

  - Use lifecycle management policies to tier infrequently accessed data to a cooler access tier.

  - If you can't use an application-level SDK to interface with blob, consider using the NFSv3 option in the blob CSI driver.
