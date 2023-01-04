---
title: Azure Arc-enabled SQL Managed Instance business continuity
description: Learn how to implement business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance.
author: sebassem
ms.author: sebassem
ms.date: 09/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank, ignite-2022
---

# Business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance provides capabilities for business continuity and disaster recovery (BCDR) that helps businesses to recover from disruptions and continue operating with minimal downtime.

This article provides key design considerations and recommendations for configuring and managing business continuity capabilities like point-in-time restore, high availability, and disaster recovery.

## Architecture

The following architecture diagrams show the [high-availability capabilities](/azure/azure-arc/data/managed-instance-high-availability) of the Arc-enabled SQL Managed Instance in the Business Critical service tier, which supports failover with near-zero downtime. If the primary instance fails, the load balancer stops sending traffic to that instance. Then one of the secondary instances is promoted to primary, and the newly promoted instance starts receiving read-write traffic from the load balancer. After the failed instance comes back online, it's added as a secondary instance.

:::image type="content" alt-text="A diagram that shows the operational state of a highly available business critical instance." source="./media/arc-enabled-data-svc-sql-mi-ha-01.png" lightbox="./media/arc-enabled-data-svc-sql-mi-ha-01.png":::

:::image type="content" alt-text="A diagram that shows a failure in the primary replica and promoting a secondary replica to primary." source="./media/arc-enabled-data-svc-sql-mi-ha-02.png" lightbox="./media/arc-enabled-data-svc-sql-mi-ha-02.png":::

:::image type="content" alt-text="A diagram that shows the primary replica failure." source="./media/arc-enabled-data-svc-sql-mi-ha-03.png" lightbox="./media/arc-enabled-data-svc-sql-mi-ha-03.png":::

:::image type="content" alt-text="A diagram that shows the operational state restored." source="./media/arc-enabled-data-svc-sql-mi-ha-04.png" lightbox="./media/arc-enabled-data-svc-sql-mi-ha-04.png":::

The following architecture diagram shows how Arc-enabled SQL Managed Instance can be deployed on two separate Kubernetes clusters in two different sites for disaster recovery.

:::image type="content" alt-text="A diagram that shows Azure Arc-enabled SQL Managed Instance deployed in a Disaster recovery setup across two clusters." source="./media/arc-enabled-data-svc-sql-mi-dr-01.png" lightbox="./media/arc-enabled-data-svc-sql-mi-dr-01.png":::

The following architecture diagram shows how Arc-enabled SQL Managed Instance responds when a disaster recovery failover is initiated.

:::image type="content" alt-text="A diagram that shows initiating the Azure Arc-enabled SQL Managed Instance disaster recovery failover across two clusters." source="./media/arc-enabled-data-svc-sql-mi-dr-02.png" lightbox="./media/arc-enabled-data-svc-sql-mi-dr-02.png":::

## Design considerations

To assess the effect of Azure Arc-enabled SQL Managed Instance on your overall BCDR model, review the BCDR recommendations for landing zones in [Business continuity and disaster recovery](../../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). Note that the focus of [Business continuity and disaster recovery](../../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md) is on design recommendations for business continuity only, but the high availability and resiliency of your instance is also dependent on the availability of the underlying Kubernetes infrastructure.

### Point-in-time restore

- Define your targets for [recovery point objective](../../../manage/considerations/protect.md#recovery-point-objectives-rpo) (RPO) and [recovery time objective](../../../manage/considerations/protect.md#recovery-time-objectives-rto) (RTO).

- Determine how long you want to retain and restore your backups within the supported retention limits.

- Consider the implications for storage and the cost of increasing the retention period of your backups. The default retention is seven days. With this duration, you can restore for up to seven days, and you get one full backup, a daily differential, and backups of transactional logs about every five minutes.

- Consider which [storage class](/azure/azure-arc/data/storage-configuration#database-instance-storage-configuration) to use for the persistent volume for backups. For guidance, see [Storage disciplines for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-storage-disciplines.md).

- Consider the size of the persistent volume for backups in the context of the expected data size and the configured retention period.

- For best practices for storage, see the [Storage disciplines for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-storage-disciplines.md).

- Backups are always performed on the primary replica. Consider the performance effects of the backup and restore processes when identifying the resources that are allocated to your instance.

- Take into account that point-in-time restores of a database can't overwrite an existing database. However, they can restore data to a new database on the same instance.

- Consider the additional steps that are required to fully recover your database if your application is online during the restore process.

- Consider the extra steps that are required to restore a database onto a multi-replica instance, as described in [Restoring a database onto a multi-replica instance](/azure/azure-arc/data/managed-instance-high-availability#restoring-a-database-onto-a-multi-replica-instance).

- Determine the tools that database administrators use to configure and restore backups. For more information, see [Connect to Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/connect-managed-instance).

### High availability

- Review the availability requirements of your workload and decide on the service tier that is best for your deployment of Arc-enabled SQL Managed Instance:

  - In the General Purpose service tier, there's a single replica available, and the high availability is achieved via Kubernetes orchestration.
  - In the Business Critical service tier, Azure Arc-enabled SQL Managed Instance provides a contained availability group, in addition to what is natively provided by Kubernetes orchestration.

- Consider the potential business effects of downtime in the General Purpose service tier that could result due to the existence of only one replica.

- Consider how many replicas—one to three—to deploy in the Business Critical service tier.

- When deploying an instance in a Business Critical service tier with two or more replicas, you can configure the secondary replicas as readable. Decide on the number of secondary replicas to deploy in the Business Critical service tier. For information on changing the number, see [Configure readable secondaries](/azure/azure-arc/data/configure-managed-instance#configure-readable-secondaries).

- Decide on prioritizing consistency over availability through the number of secondary replicas that are required to commit a transaction in the Business Critical service tier by using the [optional parameter](/cli/azure/sql/mi-arc#az-sql-mi-arc-update-optional-parameters) **--sync-secondary-to-commit**. If there are connectivity problems between the replicas, the primary might not commit any transactions: 

  - In a two-replica configuration, a transaction must be committed on both replicas for the primary to receive a success message. 
  - In a three-replica configuration, at least two of the three replicas must commit a transaction to return a success message.

- Decide if you need to designate a specific replica as the primary. For information about specifying a primary replica, see [Preferred primary replica](/azure/azure-arc/data/managed-instance-high-availability#preferred-primary-replica).

- Decide which Kubernetes service type you'll use, *LoadBalancer* or *NodePort*. If you use the load balancer, then applications can reconnect to the same primary endpoint, and Kubernetes will redirect the connection to the new primary. If you use the node port, then applications must reconnect to the new IP address.

### Disaster recovery

- The instances of Azure Arc-enabled SQL Managed Instance in both geo-primary and geo-secondary sites must be identical in compute and capacity, as well as deployed to the same service tiers.

- Decide on a location in which to store the mirroring certificates when you create the disaster recovery configuration that is accessible by both clusters that host the instance.

- Consider how to monitor the downtime of the primary instance to decide when to perform a failover to the secondary instance.

- Each instance has its own endpoints. Consider how your applications will access the primary endpoint with minimum disruption in case of failover.

## Design recommendations

The following sections list design recommendations for point-in-time restore, high availability, and disaster recovery.

### Point-in-time restore

- When deploying a new instance of Arc-enabled SQL Managed Instance, always define the [storage class](/azure/azure-arc/data/storage-configuration#database-instance-storage-configuration) for backups to avoid defaulting to the data storage class.

- Use a storage class that supports *ReadWriteMany* (RWX) for the backups volume. For guidance, see the [Storage disciplines for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-storage-disciplines.md).

- Before starting a restore operation, use [optional parameter](/cli/azure/sql/mi-arc#az-sql-mi-arc-update-optional-parameters) **--dry-run** to first validate whether the operation would be successful. For more information, see [Create a database from a point-in-time using az CLI](/azure/azure-arc/data/point-in-time-restore#create-a-database-from-a-point-in-time-using-az-cli).

- Create a process to send backups that need longer retention periods to Azure or other on-premises cold storage.

- Monitor the storage that is consumed by your backups to determine if you can accommodate longer retention, if needed.

### High availability

- Perform regular drills to validate the high availability of your instance of Arc-enabled SQL Managed Instance. Examples of drills include deletion of a pod in a General Purpose instance and failure of a replica in a Business Critical instance.

- In the Business Critical tier, deploy an instance in a three-replica configuration instead of a two-replica configuration to achieve near-zero data loss.

- For better availability, use LoadBalancer as the service type when deploying an instance.

- Review the [high-availability limitations](/azure/azure-arc/data/managed-instance-high-availability#limitations) of Azure Arc-enabled SQL Managed Instance.

- Review the [supported availability modes](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups) to decide which mode to use based on your high-availability needs.

- When deploying a Business Critical instance with multiple replicas, use one of the secondary replicas for *Read* workloads. Your application connection string must specify the secondary endpoint as service listener for redirection to the secondary replicas. For information about endpoints, see [Get the primary and secondary endpoints and AG status](/azure/azure-arc/data/managed-instance-high-availability#get-the-primary-and-secondary-endpoints-and-ag-status).

- To understand the best practices for monitoring the availability of your instances, see [Management and monitoring for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-management-disciplines.md).

### Disaster recovery

- Ensure that your instances of Arc-enabled SQL Managed Instance have different names for primary and secondary sites, and that the shared-name value for the sites is identical.

- Perform regular disaster recovery drills to validate the failover process.

- Create a process for initiating both manual and forced failovers.

- To understand the best practices to monitor the health of the clusters, and to understand when a failover is required, see [Management and monitoring for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-management-disciplines.md).

- Define the DNS record for the shared name of the [distributed availability group](/sql/database-engine/availability-groups/windows/distributed-availability-groups) in your DNS servers to avoid needing to manually create DNS records during the failover.

## Next steps

For more information on your hybrid and multicloud cloud journey, see the following articles:

- [What are Azure Arc-enabled data services?](/azure/azure-arc/data/overview)
- [Overview: Azure Arc-enabled SQL Managed Instance business continuity](/azure/azure-arc/data/managed-instance-business-continuity-overview)
- [Azure Arc-enabled data services Kubernetes validation](/azure/azure-arc/data/validation-program)
- [Manage your portfolio across hybrid and multicloud operations](../manage.md)
- [Azure Arc-enabled data services](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/) for automated scenarios with Azure Arc Jumpstart
- [Bring Azure innovation to your hybrid environments with Azure Arc](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/), a learning path from Microsoft Learn
