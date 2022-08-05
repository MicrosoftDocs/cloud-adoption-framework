---
title: Storage Disciplines for Azure Arc-enabled Data Services
description: Learn design considerations and recommendations for cost governance for Azure Arc-enabled Kubernetes.
author: jpocloud
ms.author: johnpoole
ms.date: 08/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank, e2e-arc-enabled-kubernetes
---

# Storage Disciplines for Azure Arc-enabled SQL Managed Instance

Storage is a critical component in an Azure Arc-enabled SQL Managed Instance (MI) deployment.  Understanding how the storage-related concepts described in this document affect the functioning of Kubernetes clusters is an important aspect of the planning, design, and deployment.

Rather than directly interacting with underlying storage, Kubernetes provides an abstraction layer to a variety of storage technologies through Storage Classes.  Cloud providers, hardware vendors, and other Kubernetes managed platforms offer varying Storage Class options to suit specific environments and implementation scenarios.

By way of example, consider how Storage Classes are used in Azure Kubernetes Service (AKS). [Azure storage services](/azure/aks/concepts-storage#storage-classes) have options such as Managed Disks, NetApp Files or Azure Files shares. These all can be used to provide pods with volumes for persistent data storage.

For Azure Arc-enabled SQL MI deployments, effectively planning for storage capabilities and configuration is crucial to operate successfully.  Read on to learn about the storage-related factors to consider, followed by recommendations for configuring Azure Arc-enabled SQL MI.

## Architecture

The following architecture diagram shows the logical design of Arc-Enabled Data Services. This includes the Data Controller component and SQL MI Server along with databases provisioned for reference. Both the Data Controller and SQL Managed Instance Server have various options of backing storage devices which will be dependent upon Kubernetes distribution and infrastructure provider.

![Arc-Enabled Data Services Logical Diagram.](../media/arc-enabled-datasvc-sqlmi-storage-logical.PNG)

## Design considerations

### Storage Classes

Choosing the right Kubernetes Storage Class and configuration for your Arc-enabled data services is important for your data services performance, resiliency, and capacity. [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/), [Persistent Volumes (PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/), and [Persistent Volume Claims (PVC)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) are Kubernetes resource objects that are created in your Kubernetes cluster when provisioning the Azure Arc-Enabled Data Services components. The Storage Class options will vary depending upon what your cloud provider, hardware vendor offers, and what the Kubernetes Administrator has configured. The Persistent Volume Claim will request a Persistent Volume be created for the desired Storage Class and size requested. The following diagram shows is a reference of the relationship of these Kubernetes resources.

![Kubernetes storage concepts with options of Storage Classes](../media/arc-enabled-datasvc-sqlmi-storage-k8srelationship.PNG)

Configuration of the PV and PVC Kubernetes resources occurs when provisioning the Arc-enabled Data Controller extension and SQL Managed Instance respectively.

There are two different storages types to choose from:

- **Local**. This is storage that is attached to the disk of the local Kubernetes node which provides  lower latency compared to Remote/Shared storage.
- **Remote/Shared Storage**. These are network-attached storage devices that tend to come with built-in redundancy. Common options for this are NAS and SAN devices.

The following should be taken into account when choosing a Storage Class, this criteria would also hold true for any database server you would build:

- **Performance**. The storage device I/O throughput and IOPS should meet your database needs.
- **Read/Write Ratio**. Understanding the workload can help choose the backing hardware to best meet the needs with appropriate costs. Heavy write workloads can take advantage of RAID 0 configurations, whereas infrequently accessed data might be best served using SAN device storage.
- **Database isolation and co-location**. Consider the multiple databases and volumes required for each database, which will require data, logs, and backups. Each storage volume should land on different underlying physical devices to avoid contention on Disk I/O. All databases on an instance of SQL MI share Persistent Volume, so you can choose to move databases to separate instances of SQL MI to avoid storage resource contention.
- **Capacity**. The defined storage size should meet the future capacity of your data controller and database instances to avoid having to re-size a PVC.
- **Access Mode**. Storage Class providers have different Access Modes, allowing different capabilities for how a storage can be mounted and read or written by pods. RWX (Read Write Many) is required for the SQL Backups volume.

### Data Controller

The data controller will have 4 different stateful pods running in the Kubernetes cluster: Controller SQL, Controller API, Logs DB, Metrics DB. Each pod will require two Persistent Volumes for the data and logs component. All Data Controller components require a remote Storage Class to ensure data durability, as the data controller components themselves do not natively provide data durability. Be sure to consider the [compute and memory resources](/azure/azure-arc/data/sizing-guidance#data-controller-sizing-details) the Data Controller requires.

The Data Controller default volume sizing is the recommended minimum. The storage used will be dependent on amount of database, usage, and logs generated. The data controller Storage Class is not sensitive to low latency, but users might see benefit in the Grafana and Kibana interfaces with faster performing storage if you have a large number of database instances.

#### Data Controller Installing and Uninstalling

When provisioning the data controller, you can configure the Storage Class and the storage capacity for both Logs and Data, this will apply to all 8 PVs created for the Data Controller pods. During the provisioning, you can specify a [custom deployment template](/azure/azure-arc/data/create-custom-configuration-template) that can override default parameters such as log retention and items related to security, service types used. Once the provisioning is complete, Persistent Volume (PV) and Persistent Volume Claims (PVC) Kubernetes objects will be created.

It is important to understand that the Storage Class for the Data Controller cannot be changed once it is provisioned. Without specifying a Storage Class, the data Controller will use the Kubernetes default Storage Class, which can vary dependent on your Kubernetes instance or provider.

When uninstalling the Data Controller, all Persistent Volumes associated with the Data Controller will be deleted. Take into consideration archiving any control-plane level logs that might be required to be saved by your organization before uninstalling the Data Controller.

### SQL Managed Instance

Azure Arc-enabled SQL MI offers two different tiers depending on business requirements: General Purpose and Business Critical. For both tiers, it is important to review the minimum and maximum [SQL Managed Instance limits](/azure/azure-arc/data/sizing-guidance#sql-managed-instance-sizing-details) that can be configured, and ensure the deployed Kubernetes cluster has the appropriate compute and memory capacity. In scenarios with multiple databases on a given database instance, all of the databases will use the same Storage Class, Persistent Volume Claim, Persistent Volume that has been specified for the SQL MI Instance. It is possible to have multiple instances of SQL MI in a single cluster, which allows for independent Persistent Volumes and can help separate IO contention from different databases by deploying the databases to different instances of SQL MI.

The following table describes the different Persistent Volumes used by each SQL MI pod and its purpose.

| Persistent Volume       | Description           | Storage Class Requirements |
| ------------- |:-------------:| -----:|
| Data      | SQL Data (.mdf files) | Depends on tier |
| DataLogs     | SQL log (.ldf files)      |   Depends on tier |  
| Logs  | SQL agent, error logs, trace files, health logs      |   Depends on tier  |
| Backups  | SQL Server Backup files including Full, Diff, Transactional Log      |    Remote, ReadWriteMany Access Mode |

#### General Purpose Tier

The general Purpose tier SQL MI must use remote storage for the database instance so that, upon failure of a pod, the data remains available to newly created pods. Failover is managed by Kubernetes pod & node orchestration. This is a simpler configuration compared to Business Critical which uses Availiblity Groups and multiple SQL Managed Instance replicas (pods). The single pod configuration with General purpose means that you can minimize the amount of storage due to not having to duplicate storage capacity for other replicas.

![SQL MI General Purpose Storage](../media/arc-enabled-datasvc-sqlmi-storage-gp.PNG)

#### Business Critical Tier

Business Critical tier uses a multiple pod model where data and log volumes can be stored on local or remote Storage Classes. Local Storage Classes typically perform better in terms of latency and throughput.  Remote storage typically offers more simple redundancy but often has lower throughput compared with local storage.  Keep in mind that with Business Critical, additional replicas will also require additional Persistent Volumes for Data, Logs, and DataLogs. This means more total storage capacity is required.

Business Critical allows for configuration of 2 or 3 secondary replicas, and failover is managed by [SQL always On Availability Group](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server), which will provide less downtime for upgrades and failures than the General Purpose tier. Configuring multiple replicas with synchronous data replication can ensure data is preserved incase of a failed pod, node, or storage hardware as there will be multiple copies of the data on the replicas. Consider utilizing secondary replicas as read scale-out instances.

Below is a diagram to illustrate the Business Critical storage configuration for Arc-Enabled SQL MI.

![SQL MI Business Critical Storage](../media/arc-enabled-datasvc-sqlmi-storage-bc.PNG)

#### SQL Managed Instance Provisioning and Removing

When provisioning Azure SQL Managed Instance, you have the flexibility to assign different Storage Classes to each of the required SQL Managed Instance Persistent Volumes. Higher performance storage options could be desired for Data and DataLogs, but the Logs and Backup volumes could use some form of shared storage to save on costs. In scenarios where local storage is used, ensure that the volumes are able to land on different nodes and physical storage devices to avoid contention on disk I/O.

When deleting a SQL Managed Instance, this does not remove its associated PVs and PVCs. This ensures that you can access the database files in case the deletion was accidental.

## Design recommendations

### Storage Classes

For public clouds, the recommended Storage Classes for production workloads in the following table.

| Provider    | Storages Validated & Recommended |
| ------------- |:-------------:|
| Azure (AKS)      | Managed Premium (Azure Disks Premium tier) |
| AWS (EKS)     | EBS CSI storage driver    |
| Google (GKE)  | GCE Persistent disks     |

When choosing a Storage Class in On-premise or vendor storage infrastructure scenarios, ensure the Storage Class is capable of meeting your intended storage capacity, IOPS, and throughput. The following sections provide additional recommendations for these scenarios.

### Data Controller

Choose a remote, shared Storage Class to ensure data durability in the event a pod or node is removed, the pod is brought back up and can connect again to the Persistent Volume. The underline Storage Class needs to be durable and highly available.

It is recommended to use a custom deployment template when creating your data storage, which allows fine tuning of Storage Classes for data and logs, storage size for data and logs, security, service type. This can be customized to your environment and enterprise needs.

It is recommended to choose a low latency Storage Class in the event your cluster will have many databases and SQL MI deployments. This will improve user experience in Grafana and Kibana interfaces.

The data controller requires a total of 8 Persistent Volumes, which vary in size. The default minimum configuration allows for 15Gi for data and 10Gi for logs. Configure capacity that not only meets minimum recommendation but supports additional data acquisition and retention configuration. This will prevent the need of re-sizing PVC's in the future.

### SQL Managed Instance

It is recommended to plan and account for all of the instances of SQL MI and SQL Databases that will be required on each Kubernetes cluster. This will prevent needing to move databases between instances at a later time. When configuring multiple database instances on a cluster, be sure to separate busy databases to their own instance to avoid I/O contention. Use node labels  to ensure that database instances are put onto separate nodes to distribute the overall I/O traffic across multiple nodes. If operating in a virtualized environment, ensure that I/O is appropriately distributed at the physical host-level.

Plan the capacity for SQL MI to have adequate storage sizes for Data, Logs, DataLogs, and Backups that accommodates both current needs and projected growth for all the databases that will live on the instance. This will prevent having to resize the PVCs in the future.

While there are several non-storage factors that might dictate a deployment of the Business Critical or General Purpose tier of Azure Arc-enabled SQL MI, Business Critical using local storage will provide the lowest latency and highest availability. For on-premise storage infrastructure options, use the following recommendations:

#### General Purpose

Choose a low latency remote Storage Class for the Data and DataLogs Persistent Volumes.

#### Business Critical

For lowest possible latency requirements and best-performing SQL MI, choose the local storage if this is an option for your Kubernetes infrastructure. The local storage volumes should land on different underlying storage devices to avoid contention on disk I/O and maximize performance.

For read intensive workloads and high availability, configure multiple replicas and configure your applications or clients to use secondary replicas as read scale-out instances.

### Monitoring

It is recommended to monitor all PVCs created by Azure Arc-Enabled Data Services, including the Data Controller and all instances of SQL MI in a cluster. Set alerts to be notified when a PVC is approaching near capacity. This will allow you to do re-sizing to the PVC as needed. [Monitoring of PVCs](/azure/azure-monitor/containers/container-insights-persistent-volumes) and Alerting can be done by Azure Monitor and Container Insights.

## Next steps

For more information on your hybrid and multicloud cloud journey, see the following articles:

- Review the [storage configuration](/azure/azure-arc/data/storage-configuration) for Azure Arc-enabled Data Services
- Review the [validated Kubernetes distributions](/azure/azure-arc/data/validation-program) for Azure Arc-enabled Data Services.
- Review the [Sizing Guidance](/azure/azure-arc/data/sizing-guidance) of Azure Arc-enabled Data Services.
- Experience Azure Arc-enabled SQL Managed Instance automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
