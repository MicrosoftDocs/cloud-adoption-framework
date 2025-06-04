---
title: Storage disciplines for Azure Arc-enabled SQL Managed Instance
description: Learn design considerations and recommendations for Storage disciplines with Azure Arc-enabled SQL Managed Instance.
author: Zimmergren
ms.author: pnp
ms.date: 09/27/2022
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Storage disciplines for Azure Arc-enabled SQL Managed Instance

Storage is a critical component in an Azure Arc-enabled SQL Managed Instance (Arc-enabled SQL Managed Instance) deployment. Understanding how the storage-related concepts described in this document affect the functioning of Kubernetes clusters is an important aspect of the storage design choices and management.

Rather than directly interacting with underlying storage, Kubernetes provides an abstraction layer to various storage technologies through storage classes. Cloud providers, hardware vendors, and other Kubernetes-managed platforms offer varying StorageClass options to suit specific environments and implementation scenarios.

Arc-enabled SQL Managed Instance doesn't limit or enforce using any storage classes, so it's important to choose the correct storage design and configuration. The storage design for Arc-enabled SQL Managed Instance is as important as if you were choosing the backing storage devices for a SQL Server when running on bare metal or virtual machines. These choices ultimately represent your requirements surrounding RPO, RTO, capacity, and performance.

For Arc-enabled SQL Managed Instance deployments, effectively planning for storage capabilities and configuration is crucial to operate successfully. Read on to learn about the storage-related factors to consider, followed by recommendations for configuring Arc-enabled SQL Managed Instance.

## Architecture

The following architecture diagram shows the logical design of Azure Arc-enabled data services components. These components include a required Azure Arc Data Controller and one or more Arc-enabled SQL Managed Instance(s) that contain databases provisioned for reference. Both the Azure Arc Data Controller and Arc-enabled SQL Managed Instance provide options for backing storage devices, which are dependent upon Kubernetes distribution and storage infrastructure providers.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-storage-logical.png" alt-text="A screenshot showing the Azure Arc-enabled data services logical architecture diagram." lightbox="./media/arc-enabled-data-svc-sql-mi-storage-logical.png":::

## Design considerations

The following are considerations for your storage design and configuration.

### Storage Classes

Choosing the right Kubernetes StorageClass and configuration for your Azure Arc-enabled data services components is important for your data storage performance, resiliency, and capacity.

The [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/), [PersistentVolume (PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/), and [PersistentVolumeClaim (PVC)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) are Kubernetes resource objects that the system creates in your Kubernetes cluster when provisioning the Azure Arc-enabled data services components.

StorageClass options vary depending on what your cloud provider, hardware vendor offers and what the Kubernetes Administrator has configured. The PersistentVolumeClaim requests a PersistentVolume to be created for the StorageClass and the size requested. The following diagram is a reference of the relationship between these Kubernetes resources and potential options for the storage classes.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-storage-k8s-relationship.png" alt-text="A screenshot showing Kubernetes storage concepts with the storage classes options." lightbox="./media/arc-enabled-data-svc-sql-mi-storage-k8s-relationship.png":::

The PV and PVC Kubernetes resources are configured when provisioning the Azure Arc Data Controller and Arc-enabled SQL Managed Instance, respectively.

There are two different storages types to choose from:

- **Local:** A volume that's mounted on a local storage device attached to the Kubernetes node where the pod is running. This type of storage usually provides lower latency along with higher input/output operations per second (IOPS) and throughput compared to Remote/Shared storage.
- **Remote/Shared storage:** Network-attached storage devices that tend to come with built-in redundancy. Common storage options are NAS and SAN devices.

Consider the following standards when choosing a StorageClass. These criteria would also hold true for any database server you'd build:

- **Performance:** The storage device input/output (I/O) throughput and IOPS should meet your database needs.
- **Read/Write ratio:** Understanding the workload can help you choose the backing hardware to best meet your needs with appropriate costs. Heavy write workloads can take advantage of RAID 0 configurations, whereas infrequently accessed data might be best served using a SAN device storage.
- **Database isolation and co-location:** All databases on an instance of Arc-enabled SQL Managed Instance share PV, so you can choose to move databases to separate instances of Arc-enabled SQL Managed Instance and avoid storage resource contention.
- **Capacity:** The defined storage size should meet the future capacity of your data controller and database instances to avoid having to resize a PVC. Consider any storage limitations that your chosen StorageClass might have.
- **Access mode:** Storage Class providers have different access modes, supporting different capabilities for how storage can be mounted and read or written by pods. RWX (Read Write Many) is required for the SQL Backup volume.
- **Redundancy:** Replication of the data at the physical storage layer (RAID) to support seamless failover if hardware disk failure happens, which is separate from the database level redundancy done by Availability Groups (AG).

Both the Azure Arc Data Controller and Arc-enabled SQL Managed Instance Arc data services provide granular options for configuring different storage classes for database data. These data services also provide logs, which allow for flexibility in choosing storage classes to meet needs.

### Data controller

A single Azure Arc Data Controller is required for a Kubernetes Cluster as a pre-requisite for creating instances of Arc-enabled SQL Managed Instance. More than one data controller running in a cluster isn't supported.

The Azure Arc Data Controller will have four different stateful pods running in the Kubernetes cluster: Controller SQL, Controller API, Logs DB, and Metrics DB. Each pod requires two Persistent Volumes for the data and logs volumes. All data controller components require a remote StorageClass to ensure data durability, as the data controller components themselves don't natively provide data durability.

Be sure to consider the [compute and memory resources](/azure/azure-arc/data/sizing-guidance#data-controller-sizing-details) that the Azure Arc Data Controller requires. The following diagram represents the data controller storage, PV, and PVC Kubernetes resources.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-storage-data-controller.png" alt-text="A screenshot showing the Azure Arc Data Controller storage." lightbox="./media/arc-enabled-data-svc-sql-mi-storage-data-controller.png":::

The data controller default volume sizing is the recommended minimum. The storage you use depends on the number of databases, how you use the databases, and the number of logs generated. The Azure Arc Data Controller StorageClass isn't sensitive to low latency. Even so, users might see benefits in the Grafana and Kibana interfaces with faster-performing storage if you have many Arc-enabled SQL Managed Instance deployments in a cluster. Grafana and Kibana are open source monitoring visualization tools deployed with the data controller and provisioned with dashboards for [viewing metrics and logs](/azure/azure-arc/data/monitor-grafana-kibana) for Arc-enabled SQL Managed Instance.  

#### Data controller provisioning

When you provision the Azure Arc Data Controller, configure the StorageClass and the storage capacity for both logs and data. Configuring storage for both logs and data then applies to all eight PVs you create for the data controller pods. During the provisioning, you can specify a [custom deployment template](/azure/azure-arc/data/create-custom-configuration-template) that overrides default parameters such as capacity, log retention, and items related to security such as Kubernetes Service Types. Once the provisioning completes, PV and PVC Kubernetes objects are created.

It's important to understand that the StorageClass for the data controller can't be changed once it's provisioned. If you don't specify a StorageClass, the data controller uses the Kubernetes default StorageClass, which can vary depending on your Kubernetes instance or provider.

When you uninstall the Azure Arc Data Controller, all Persistent Volumes associated with it are deleted. Archive any Azure Arc-enabled data services control-plane level logs that your organization needs to save before uninstalling the data controller.

### Azure Arc-enabled SQL Managed Instance

Arc-enabled SQL Managed Instance offers two different tiers depending on business requirements: General Purpose and Business Critical. For both tiers, it's important to review the minimum and maximum [Arc-enabled SQL Managed Instance limits](/azure/azure-arc/data/sizing-guidance#sql-managed-instance-sizing-details), which are configurable, and ensure that the deployed Kubernetes cluster has the appropriate compute and memory capacity.

In scenarios with multiple databases on a given database instance, all the databases use the same StorageClass, PVC, and PV specified for the Arc-enabled SQL Managed Instance. It's possible to have multiple instances of Arc-enabled SQL Managed Instance in a single Kubernetes cluster. This configuration allows for independent Persistent Volumes and can help separate IO contention from different databases by deploying the databases to different instances of Arc-enabled SQL Managed Instance.

The following table describes the different Persistent Volumes used by each Arc-enabled SQL Managed Instance pod and its purpose.

| Persistent Volume       | Description           | Storage Class requirements |
| ------------- |:-------------:| -----:|
| Data      | SQL Database data files (.mdf files) | Depends on tier |
| DataLogs     | SQL Database log files (.ldf files)      |   Depends on tier |  
| Logs  | SQL agent, error logs, trace files, health logs      |   Depends on tier  |
| Backups  | SQL Server Backup files including Full, Diff, Transactional Log      |    Remote, ReadWriteMany Access Mode |

#### General Purpose service tier

The General Purpose tier of Arc-enabled SQL Managed Instance must use remote storage for the database instance so that, upon failure of a pod, the data remains available to newly created pods. Failover is managed by Kubernetes pod and node orchestration. This configuration is less complex compared to Business Critical, which uses [SQL Availability Groups](/azure/azure-arc/data/managed-instance-high-availability) and multiple Arc-enabled SQL Managed Instance replicas. The single pod configuration of the General Purpose tier means that you can minimize the amount of storage because you don't have to duplicate storage capacity for other replicas.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-storage-general-purpose-tier.png" alt-text="A screenshot showing Arc-enabled SQL Managed Instance General Purpose storage." lightbox="./media/arc-enabled-data-svc-sql-mi-storage-general-purpose-tier.png":::

#### Business Critical service tier

Business Critical tier uses a multiple pod model where data and log volumes can be stored on local or remote storage classes. Local storage classes typically perform better in terms of latency and throughput because the storage device is directly attached to the node. Remote storage typically offers built-in redundancy but often has lower latency and throughput compared with local storage. Keep in mind that using more Business Critical database replicas requires extra Persistent Volumes for *Data*, *Logs*, and *DataLogs*. The required total storage capacity is much higher.

The following diagram shows the Business Critical storage configuration for Arc-Enabled SQL Managed Instance with two replicas.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-storage-business-critical-tier.png" alt-text="A screenshot showing Arc-enabled SQL Managed Instance Business Critical storage." lightbox="./media/arc-enabled-data-svc-sql-mi-storage-business-critical-tier.png":::

Business Critical lets you configure two or three secondary replicas. Failover is managed by the [SQL Always On Availability Group](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server), which provides less downtime for upgrades and failures than the General Purpose tier.

Configuring multiple replicas with synchronous-commit mode data replication ensures better protection against failures, such as a failed pod, node, or storage hardware. It protects against failures because there are multiple copies of the data on the replicas. Consider configuring secondary replicas as read scale-out instances, which clients can connect to when using the secondary listener endpoint.

#### Azure Arc SQL Managed Instance provisioning and uninstalling

When provisioning Arc-enabled SQL Managed Instance, you have the flexibility to assign different storage classes to each of the required Arc-enabled SQL Managed Instance Persistent Volumes. You might want higher-performance storage options for *Data* and *DataLogs*, but the *Logs* and *Backup* volumes could use more cost-efficient StorageClass options to save on costs. In scenarios where you use local storage, ensure that the volumes are able to land on different nodes and physical storage devices to avoid contention on disk I/O. Placing the *Data* and *DataLogs* on the same physical drive can cause contention for that storage drive, resulting in poor performance. Instead, consider placing the *Data* and *DataLogs* on separate storage drives to parallelize I/O for both database data and logs.

When you delete Arc-enabled SQL Managed Instance, its associated PVs and PVCs aren't removed. This behavior ensures that you can access the database files in case the deletion was accidental.

## Design recommendations

The following are recommendations for your storage design and configuration.

### Storage Classes for production workloads

For specific public clouds, the recommended storage classes for production workloads are shown in the following table.

| Provider    | Validated and recommended storage |
| ------------- |:-------------:|
| Azure Kubernetes Service (AKS)      | Azure Managed Disks (Premium tier) |
| Amazon Elastic Kubernetes Service (EKS)     | EBS CSI storage driver    |
| Google (GKE)  | GCE Persistent disks     |

When choosing a production StorageClass in on-premises or multicloud scenarios, ensure that it's capable of meeting your intended storage capacity, IOPS, redundancy, and throughput needs. The following sections provide more recommendations for these scenarios.

### Data controller design

Choose a remote, shared StorageClass to ensure data durability. In the event a pod or node is removed, you can bring the pod back up and connect again to the Persistent Volume. The underline StorageClass must provide redundancy and high availability.

We recommend using a custom deployment template when you create your Arc-enabled data services data controller. A custom template lets you fine-tune storage classes, storage size for data and logs, security, and Kubernetes Service Types. You can customize them for your environment and enterprise needs. The Azure Arc Data Controller requires a total of eight Persistent Volumes. The default minimum configuration allows for 15Gi for data and 10Gi for logs on the PVs. Configure capacity that not only meets minimum recommendations but supports higher growth from having many Arc-enabled SQL Managed Instance implementations running in a cluster. This configuration will prevent the need for resizing PVCs in the future.

We recommend you choose a lower-latency StorageClass in the event your cluster has many databases and Arc-enabled SQL Managed Instance deployments. Lower latency improves the user experience in Grafana and Kibana interfaces.

### Azure Arc-enabled SQL Managed Instance migration

We recommend you plan and account for all new and existing databases involved in the migration and deployment of your Arc-enabled SQL Managed Instance. Planning prevents the need to move databases between instances at a later time.

Depending on your Kubernetes cluster organization, provision Arc-enabled SQL Managed Instance deployments to different Kubernetes clusters based on the need to separate environments (non-prod, prod), regions, and other business factors. Review the [Resource organization](./eslz-arc-data-service-sql-managed-instance-resource-organization.md) design area for more recommendations. When configuring multiple database instances on a cluster, be sure to separate busy databases into their own instance to avoid I/O contention.

Use node labels to ensure that database instances are put onto separate nodes to distribute the overall I/O traffic across multiple nodes, see Kubernetes [Node Labels](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#built-in-node-labels) along with Kubernetes [Node affinity and anti-affinity labels](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) for configuring the labels. If operating in a virtualized environment, ensure that the I/O is appropriately distributed at the physical host-level.

Plan the capacity for Arc-enabled SQL Managed Instance to include adequate storage sizes for *Data*, *Logs*, *DataLogs*, and *Backups*. When you plan capacity to accommodate both current needs and projected growth for all databases that will live on the instances of Arc-enabled SQL Managed Instance, it prevents having to resize the PVCs in the future. Choose separate physical drives for *Data* and *DataLogs* to allow parallel I/O activity to occur. Parallel I/O activity results in improved performance by avoiding the possible contention caused when using a shared drive.

While there are several factors that might dictate a deployment of the Business Critical or General Purpose tier of Arc-enabled SQL Managed Instance, Business Critical using local storage provides the lowest latency and highest availability. Review the [Arc-enabled SQL Managed Instance business continuity](./eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md) design area for recommendations surrounding point-in-time restore, high availability, and disaster recovery. Additionally, review the [Arc-enabled SQL Managed Instance cost governance](./eslz-arc-data-service-sql-managed-instance-cost-governance.md) design area to learn more about the cost implications between tiers.

The following subsections provide more specific recommendations for each tier:

#### General Purpose service tier recommendations

It's recommended to choose a low latency remote StorageClass for the *Data* and *DataLogs* Persistent Volumes for optimal performance. Avoid using a StorageClass that introduces network partitions, such as having an on-premises cluster configured to use an internet-provided StorageClass for the *Backup* and *Logs* Persistent Volumes.

#### Business Critical service tier recommendations

It's recommended to review the [Availability mode differences](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups), which will require different configuration for each chosen mode.

For the lowest possible latency requirement scenarios, choose local storage if it's an option for your Kubernetes infrastructure. The local storage volumes should land on different underlying storage devices to avoid contention on disk I/O and maximize performance. The storage device shouldn't have multiple functions, such as hosting the Operating System partition.

For read-intensive workloads and high availability, configure multiple replicas and configure your applications or clients to use secondary replicas as Read Scale-Out instances. Secondary replicas aren't readable by default; you can configure the setting.

### Monitoring

It's recommended to monitor all PVCs created by Arc-enabled data services, including the Azure Arc Data Controller and all instances of Arc-enabled SQL Managed Instance in a cluster. Set alerts to notify you when a PVC is approaching near capacity. Notification lets you resize the PVC prior to reaching capacity. For Directly Connected clusters, [monitoring of PVCs](/azure/azure-monitor/containers/container-insights-persistent-volumes) and alerting is done by Azure Monitor and Container Insights. When you use Indirect Connected clusters, do the monitoring and alerting in Grafana and Kibana. The Grafana installation includes dashboards for Arc-enabled SQL Managed Instance metrics and Kubernetes resources.

Review the [Arc-enabled SQL Managed Instance governance disciplines](./eslz-arc-data-service-sql-managed-instance-cost-governance.md) for more recommendations on monitoring Arc-enabled SQL Managed Instance.

## Next steps

For more information on your hybrid and multicloud cloud journey, see the following articles:

- Review the [storage configuration](/azure/azure-arc/data/storage-configuration) for Azure Arc-enabled data services.
- Review the [validated Kubernetes distributions](/azure/azure-arc/data/validation-program) for Azure Arc-enabled data services.
- Review the [sizing guidance](/azure/azure-arc/data/sizing-guidance) of Azure Arc-enabled data services.
- Review [monitoring with Grafana and Kibana](/azure/azure-arc/data/monitor-grafana-kibana) of an Arc-enabled SQL Managed Instance.
- Experience Arc-enabled SQL Managed Instance automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
