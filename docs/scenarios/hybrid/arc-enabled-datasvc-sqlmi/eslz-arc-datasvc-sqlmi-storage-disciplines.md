---
title: Storage Disciplines for Azure Arc-enabled SQL Managed Instance
Learn design considerations and recommendations for storage for Azure Arc-Enabled SQL Managed Instance.
author: jpocloud
ms.author: johnpoole
ms.date: 08/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank, e2e-Arc-Enabled-kubernetes
---

# Storage Disciplines for Azure Arc-Enabled SQL Managed Instance

Storage is a critical component in an Azure Arc-Enabled SQL Managed Instance (MI) deployment.  Understanding how the storage-related concepts described in this document affect the functioning of Kubernetes clusters is an important aspect of the storage design choices and management.

Rather than directly interacting with underlying storage, Kubernetes provides an abstraction layer to a variety of storage technologies through Storage Classes. Cloud providers, hardware vendors, and other Kubernetes managed platforms offer varying Storage Class options to suit specific environments and implementation scenarios.

It is important to understand that the impact of choosing a storage design or configuration is as relevant for a SQL Server deployment when running on bare metal or virtual machines as it is to an Arc-Enabled Arc SQL MI deployment. These choices will ultimately represent your requirements surrounding RPO, RTO, capacity & performance.

For Azure Arc-Enabled Arc SQL MI deployments, effectively planning for storage capabilities and configuration is crucial to operate successfully.  Read on to learn about the storage-related factors to consider, followed by recommendations for configuring Azure Arc-Enabled Arc SQL MI.

## Architecture

The following architecture diagram shows the logical design of Arc-Enabled Data Services components. These components includes a required Data Controller and one or more SQL Managed Instance Server which contain databases provisioned for reference. Both the Data Controller and Arc SQL MI Server have various options of backing storage devices which will be dependent upon Kubernetes distribution and storage infrastructure providers.

![Arc-Enabled Data Services Logical Diagram.](../media/Arc-Enabled-datasvc-sqlmi-storage-logical.PNG)

## Design considerations

### Storage Classes

Choosing the right Kubernetes Storage Class and configuration for your Arc-Enabled Data Services components is important for your data storage performance, resiliency, and capacity. [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/), [Persistent Volumes (PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/), and [Persistent Volume Claims (PVC)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) are Kubernetes resource objects that are created in your Kubernetes cluster when provisioning the Azure Arc-Enabled Data Services components. The Storage Class options will vary depending upon what your cloud provider, hardware vendor offers, and what the Kubernetes Administrator has configured. The Persistent Volume Claim will request a Persistent Volume be created for the desired Storage Class and size requested. The following diagram is a reference of the relationship of these Kubernetes resources and potential options for Storage Classes.

![Kubernetes storage concepts with options of Storage Classes](../media/Arc-Enabled-datasvc-sqlmi-storage-k8srelationship.PNG)

Configuration of the PV and PVC Kubernetes resources occurs when provisioning the Arc-Enabled Data Controller extension and Arc SQL MI respectively.

There are two different storages types to choose from:

- **Local:**. This is a volume that is mounted on a local storage device attached to the Kubernetes node where the pod is running on. This type of storage usually provides lower latency along with higher IOPS and throughput compared to Remote/Shared storage.
- **Remote/Shared Storage**. These are network-attached storage devices that tend to come with built-in redundancy. Common options for this are NAS and SAN devices.

The following should be taken into account when choosing a Storage Class, this criteria would also hold true for any database server you would build:

- **Performance**. The storage device I/O throughput and IOPS should meet your database needs.
- **Read/Write Ratio**. Understanding the workload can help choose the backing hardware to best meet the needs with appropriate costs. Heavy write workloads can take advantage of RAID 0 configurations, whereas infrequently accessed data might be best served using a SAN device storage.
- **Database isolation and co-location**. All databases on an instance of Arc SQL MI share Persistent Volume, so you can choose to move databases to separate instances of Arc SQL MI to avoid storage resource contention.
- **Capacity**. The defined storage size should meet the future capacity of your data controller and database instances to avoid having to re-size a PVC. Consider any storage limitations that your chosen Storage Class might have.
- **Access Mode**. Storage Class providers have different Access Modes, allowing different capabilities for how a storage can be mounted and read or written by pods. RWX (Read Write Many) is required for the SQL Backup volume.
- **Performance:** The storage device I/O throughput and IOPS should meet your database needs.
- **Read/Write Ratio:** Understanding the workload can help choose the backing hardware to best meet the needs with appropriate costs. Heavy write workloads can take advantage of RAID 0 configurations, whereas infrequently accessed data might be best served using a SAN device storage.
- **Database isolation and co-location:** All databases on an instance of SQL MI share Persistent Volume, so you can choose to move databases to separate instances of SQL MI to avoid storage resource contention.
- **Capacity:** The defined storage size should meet the future capacity of your data controller and database instances to avoid having to re-size a PVC. Consider any storage limitations that your chosen Storage Class might have.
- **Access Mode:** Storage Class providers have different Access Modes, allowing different capabilities for how a storage can be mounted and read or written by pods. RWX (Read Write Many) is required for the SQL Backup volume.
### Data Controller

The data controller will have 4 different stateful pods running in the Kubernetes cluster: Controller SQL, Controller API, Logs DB, Metrics DB. Each pod will require two Persistent Volumes for the data and logs volumes. All Data Controller components require a remote Storage Class to ensure data durability, as the data controller components themselves do not natively provide data durability. Be sure to consider the [compute and memory resources](/azure/azure-arc/data/sizing-guidance#data-controller-sizing-details) the Data Controller requires. The following diagram represents the Data Controller Storage, PV and PVC Kubernetes resources.

![Temp Placeholder](../)

The Data Controller default volume sizing is the recommended minimum. The storage used will be dependent on amount of databases, usage, and logs generated. The data controller Storage Class is not sensitive to low latency, but users might see benefit in the Grafana and Kibana interfaces with faster performing storage if you have a large number of Arc SQL MI deployments in a cluster.

#### Data Controller Installing and Uninstalling

When provisioning the data controller, you can configure the Storage Class and the storage capacity for both Logs and Data, this will apply to all 8 PVs created for the Data Controller pods. During the provisioning, you can specify a [custom deployment template](/azure/azure-arc/data/create-custom-configuration-template) that can override default parameters such as capacity, log retention and items related to security such as Kubernetes Service Types used. Once the provisioning is complete, PV and PVC Kubernetes objects will be created.

It is important to understand that the Storage Class for the Data Controller cannot be changed once it is provisioned. Without specifying a Storage Class, the data Controller will use the Kubernetes default Storage Class, which can vary dependent on your Kubernetes instance or provider.

When uninstalling the Data Controller, all Persistent Volumes associated with the Data Controller will be deleted. Take into consideration archiving any Arc-Enabled Data Services control-plane level logs that might be required to be saved by your organization before uninstalling the Data Controller.

### Azure Arc-enabled SQL Managed Instance

Azure Arc-Enabled Arc SQL MI offers two different tiers depending on business requirements: General Purpose and Business Critical. For both tiers, it is important to review the minimum and maximum [Arc SQL MI limits](/azure/azure-arc/data/sizing-guidance#sql-managed-instance-sizing-details) which can be configured, and ensure the deployed Kubernetes cluster has the appropriate compute and memory capacity. In scenarios with multiple databases on a given database instance, all of the databases will use the same Storage Class, PVC, and PV that has been specified for the Arc SQL MI Server. It is possible to have multiple instances of Arc SQL MI in a single Kubernetes cluster, this allows for independent Persistent Volumes and can help separate IO contention from different databases by deploying the databases to different instances of Arc SQL MI.

The following table describes the different Persistent Volumes used by each Arc SQL MI pod and its purpose.

| Persistent Volume       | Description           | Storage Class Requirements |
| ------------- |:-------------:| -----:|
| Data      | SQL Data (.mdf files) | Depends on tier |
| DataLogs     | SQL log (.ldf files)      |   Depends on tier |  
| Logs  | SQL agent, error logs, trace files, health logs      |   Depends on tier  |
| Backups  | SQL Server Backup files including Full, Diff, Transactional Log      |    Remote, ReadWriteMany Access Mode |

#### General Purpose Tier

The General Purpose tier of Arc SQL MI must use remote storage for the database instance so that, upon failure of a pod, the data remains available to newly created pods. Failover is managed by Kubernetes pod & node orchestration. This is a simpler configuration compared to Business Critical which uses Availability Groups and multiple Arc SQL MI replicas. The single pod configuration with General purpose means that you can minimize the amount of storage due to not having to duplicate storage capacity for other replicas.

![Arc SQL MI General Purpose Storage](../media/Arc-Enabled-datasvc-sqlmi-storage-gp.PNG)

#### Business Critical Tier

Business Critical tier uses a multiple pod model where data and log volumes can be stored on local or remote Storage Classes. Local Storage Classes typically perform better in terms of latency and throughput because the storage device is directly attached to the node.  Remote storage typically offers built-in redundancy but often has lower latency and throughput compared with local storage.  Keep in mind that with Business Critical, additional replicas will also require additional Persistent Volumes for Data, Logs, and DataLogs. This means the total storage capacity required is significantly higher.

Below is a diagram to illustrate the Business Critical storage configuration for Arc-Enabled Arc SQL MI with two replicas.

![Arc SQL MI Business Critical Storage](../media/Arc-Enabled-datasvc-sqlmi-storage-bc.PNG)

Business Critical allows for configuration of 2 or 3 secondary replicas, and failover is managed by [SQL always On Availability Group](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server), which will provide less downtime for upgrades and failures than the General Purpose tier. Configuring multiple replicas with synchronous data replication can ensure better protection against failures such as a failed pod, node, or storage hardware as there will be multiple copies of the data on the replicas. Consider utilizing secondary replicas as read scale-out instances. Review the [Business Continuity and Disaster Recovery](./eslz-arc-datasvc-sqlmi-bcdr.md) section for more information in these areas.

#### Arc SQL MI Provisioning and Uninstalling

When provisioning Arc SQL MI, you have the flexibility to assign different Storage Classes to each of the required Arc SQL MI Persistent Volumes. Higher performance storage options could be desired for Data and DataLogs, but the Logs and Backup volumes could use a more cost-efficient Storage Class options to save on costs. In scenarios where local storage is used, ensure that the volumes are able to land on different nodes and physical storage devices to avoid contention on disk I/O.

When deleting Arc SQL MI, this does not remove its associated PVs and PVCs. This ensures that you can access the database files in case the deletion was accidental.

## Design recommendations

### Storage Classes

For public clouds, the recommended Storage Classes for production workloads are shown in the following table.

| Provider    | Storages Validated & Recommended |
| ------------- |:-------------:|
| Azure (AKS)      | Managed Premium (Azure Disks Premium tier) |
| AWS (EKS)     | EBS CSI storage driver    |
| Google (GKE)  | GCE Persistent disks     |

When choosing a Storage Class in On-premise and vendor storage infrastructure scenarios, ensure the Storage Class is capable of meeting your intended storage capacity, IOPS, and throughput needs. The following sections provide additional recommendations for these scenarios.

### Data Controller

Choose a remote, shared Storage Class to ensure data durability in the event a pod or node is removed, the pod is brought back up and can connect again to the Persistent Volume. The underline Storage Class needs to be provide redundancy and high availability.

It is recommended to use a custom deployment template when creating your Arc-Enabled Data Services Data Controller, which allows fine tuning of Storage Classes, storage size for data and logs, security, and Kubernetes Service Types. This can be customized to your environment and enterprise needs. The data controller requires a total of 8 Persistent Volumes. The default minimum configuration allows for 15Gi for data and 10Gi for logs on the PVs. Configure capacity that not only meets minimum recommendation but supports higher growth from having many Arc SQL MI implementations running in a cluster. This will prevent the need of re-sizing PVC's in the future.

It is recommended to choose a lower latency Storage Class in the event your cluster will have many databases and Arc SQL MI deployments. This will improve user experience in Grafana and Kibana interfaces.

### Azure Arc-enabled SQL Managed Instance

It is recommended to plan and account for all of the instances of Arc SQL MI and corresponding SQL Databases that will be required on each Kubernetes cluster. This will prevent needing to move databases between instances at a later time. Provision ARC SQL MI deployments to different Kubernetes clusters to separate environments, create security boundaries, and avoid having all databases rely on the scale and performance of a single Kubernetes cluster. When configuring multiple database instances on a cluster, be sure to separate busy databases to their own instance to avoid I/O contention. Use node labels to ensure that database instances are put onto separate nodes to distribute the overall I/O traffic across multiple nodes. If operating in a virtualized environment, ensure that I/O is appropriately distributed at the physical host-level.

Plan the capacity for Arc SQL MI to have adequate storage sizes for Data, Logs, DataLogs, and Backups that can accommodate both current needs and projected growth for all the databases that will live on the instances of Arc SQL MI. This will prevent having to resize the PVCs in the future.

While there are several factors that might dictate a deployment of the Business Critical or General Purpose tier of Azure Arc-Enabled Arc SQL MI, Business Critical using local storage will provide the lowest latency and highest availability. For on-premise storage infrastructure options, use the following recommendations:

#### General Purpose

It is recommended to choose a low latency remote Storage Class for the Data and DataLogs Persistent Volumes to have optimal performance. Avoid using a Storage Class that can introduce network partitions, such as having an on-premises cluster configured to use an internet provided Storage Class for the Backups and Logs Persistent Volumes.

#### Business Critical

For lowest possible latency requirement scenarios, it is recommended to choose local storage if this is an option for your Kubernetes infrastructure. The local storage volumes should land on different underlying storage devices to avoid contention on disk I/O and maximize performance. The storage device should not have multiple functions, such as hosting the Operating System partition.

For read intensive workloads and high availability, configure multiple replicas and configure your applications or clients to use secondary replicas as read scale-out instances.

### Monitoring

It is recommended to monitor all PVCs created by Azure Arc-Enabled Data Services, including the Data Controller and all instances of Arc SQL MI in a cluster. Set alerts to be notified when a PVC is approaching near capacity. This will allow you to do re-sizing to the PVC prior to reaching capacity. For Directly Connected Clusters, [monitoring of PVCs](/azure/azure-monitor/containers/container-insights-persistent-volumes) and Alerting can be done by Azure Monitor and Container Insights.

## Next steps

For more information on your hybrid and multicloud cloud journey, see the following articles:

- Review the [storage configuration](/azure/azure-arc/data/storage-configuration) for Azure Arc-Enabled Data Services
- Review the [validated Kubernetes distributions](/azure/azure-arc/data/validation-program) for Azure Arc-Enabled Data Services.
- Review the [Sizing Guidance](/azure/azure-arc/data/sizing-guidance) of Azure Arc-Enabled Data Services.
- Experience Azure Arc-Enabled Arc SQL MI automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
