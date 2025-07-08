---
title: Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about business continuity and disaster recovery (BCDR) for Oracle on Azure Virtual Machines landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/05/2024
ms.topic: conceptual
ms.custom: e2e-oracle
--- 


# Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator

This article builds on the considerations and recommendations that are defined in the [Azure landing zone design area for business continuity and disaster recovery (BCDR)](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). This article follows that guidance and describes design considerations and best practices about BCDR options for Oracle workload deployments on Azure infrastructure virtual machines (VMs).

Azure provides services that you can use to design highly available and resilient architectures. This guide outlines various options and best practices to help you design high availability and disaster recovery for Oracle databases on Azure Virtual Machines landing zone accelerator. It also describes how to configure accompanying Azure services to help you achieve high end-to-end availability for your solution.

## Get started

To build a resilient architecture for your workload environment, determine availability requirements for your solution based on the recovery time objective (RTO) and recovery point objective (RPO) for various levels of failure. RTO is the maximum time that an application remains unavailable after an incident occurs. RPO is the maximum amount of data loss during a disaster. After you determine the requirements for your solution, design your architecture to provide the established levels of resiliency and availability.

Oracle on Azure workloads primarily use Oracle Data Guard, which is a built-in Oracle Database Enterprise Edition feature that uses replication technology. You can use Data Guard to fulfill high availability and disaster recovery needs. Data Guard offers three protection modes: maximum performance, maximum availability, and maximum protection. Choose your protection mode based on your architectural design and your specific RPO and RTO requirements.

## Configure your workload for high availability

Azure Virtual Machines instances that run Oracle workloads benefit from the Azure Virtual Machine Scale Sets architecture, specifically the flexible orchestration mode. A high availability configuration provides near real-time data replication with potentially fast failover capabilities. A high availability configuration doesn't provide protection for Azure datacenter-level or region-level failures.

### Choose the right high availability option

Use the following flow chart to choose the best high availability option for your Oracle database.

:::image type="content" source="media/service-protection-design-process-map.png" alt-text="Diagram that shows the service design protection process map of Oracle on Virtual Machines landing zone accelerator." border="false" lightbox="media/service-protection-design-process-map.png":::

### Use Data Guard in maximum availability mode for high availability

Data Guard in maximum availability mode provides the highest availability with a zero data loss promise (RPO=0) for normal operations. For a highly available configuration of two Oracle database servers that are created within a Virtual Machine Scale Sets flexible orchestration, Azure provides 99.95% service availability for a service-level agreement (SLA) for instances that are spread across fault domains. Azure provides 99.99% service availability for instances that are spread across [availability zones](/azure/reliability/availability-zones-overview). For more information, see [High availability for Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#high-availability).

:::image type="content" source="media/high-availability-configuration-data-guard.png" alt-text="Diagram that shows a high availability configuration with Data Guard for Oracle on Virtual Machines landing zone accelerator." border="false" lightbox="media/high-availability-configuration-data-guard.png":::

For a step-by-step configuration of Data Guard on Azure, see [Implement Oracle Data Guard on a Linux-based Azure VM](/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard).

### Use Data Guard in maximum protection mode for high availability

If you require a transactionally consistent copy of your database, consider using Data Guard in maximum protection mode. However, maximum protection mode doesn't allow transactions to continue when the standby database isn't available. Therefore, despite using Virtual Machines Scale Sets flexible orchestration, your SLA is reduced to 99.9% x 99.9% = 99.8% when you use maximum protection mode. This configuration ensures a consistent copy of data but doesn't necessarily increase availability.

Other attributes of this architecture are the same as the maximum availability mode. For example, the RPO is zero, and the RTO is less than or equal to two minutes.

### Consider other ways to implement high availability

The following sections describe special considerations for high availability.

#### Use availability zones for improved high availability

[Azure availability zones](/azure/reliability/availability-zones-overview) are Azure datacenters that are within the same Azure region. Availability zones have a roundtrip latency of less than two milliseconds. You typically use availability zones for disaster recovery purposes, but you can use them to improve high availability. If you do, you must make sure that your solution can run with the amount of latency and throughput that your availability zones provide.

An advantage of availability zones with a Virtual Machine Scale Sets flexible orchestration is that your VM availability SLA increases to 99.99%.

#### Use shared storage clustering for high availability

Shared storage clustering technologies provide unique attributes that can help you achieve your business goals. For example, you can implement a Pacemaker and Corosync (PCS) cluster with shared storage. You can use managed disks or Azure NetApp Files as shared storage for PCS cluster instances. A PCS cluster doesn't duplicate data. It provides a virtual IP service with a static IP address or IP network name that doesn't change across failovers.

> [!NOTE]
> A PCS cluster isn't an Oracle-certified solution. Keep this factor in mind when you choose your high availability architecture.

:::image type="content" source="media/reference-architecture-pacemaker-cluster.png" alt-text="Diagram that shows a high availability configuration with Pacemaker for Oracle on Virtual Machines landing zone accelerator." border="false" lightbox="media/reference-architecture-pacemaker-cluster.png":::

#### Use proximity placement groups

To provide the lowest possible latency, place VMs as close as possible. You can deploy them within a [proximity placement group](/azure/virtual-machines/co-location). A proximity placement group is a logical grouping that ensures that Azure compute resources are physically located close to each other. Proximity placement groups are useful for workloads that require low latency. 

## Configure your workload for disaster recovery

A disaster recovery architecture provides resiliency against failures that affect Azure datacenters or regions or against failures that hinder application functionality across an entire region. In such a scenario, you should move your entire workload to a different datacenter or region.

Choose your disaster recovery architecture based on your solution requirements. You determine your requirements based on your RTO and RPO. Disaster recovery architectures are for exceptional failure cases, so failover processes are manual. In the high availability design, failover processes are automatic. In a disaster recovery architecture, you should have more relaxed requirements for RTO and RPO, which saves money.

This article focuses on scenarios in which the primary server and secondary servers are both on Azure. You can also have a primary server on-premises and a secondary server on Azure for disaster recovery purposes. For more information, see [Primary site on-premises and disaster recovery site on Azure](/azure/virtual-machines/workloads/oracle/oracle-disaster-recovery#scenario-2-primary-site-on-premises-and-dr-site-on-azure).

### Choose the right disaster recovery option

Use the following flow chart to choose the best disaster recovery option for your Oracle database.

:::image type="content" source="media/data-protection-design-process-map.png" alt-text="Diagram that shows the data protection design process map of Oracle on Virtual Machines landing zone accelerator." border="false" lightbox="media/data-protection-design-process-map.png":::

### Use Data Guard for disaster recovery

You can use Data Guard to replicate data to your disaster recovery site. Use that site as another availability zone in the same region or in a different region depending on your requirements for data protection. Your configuration also depends on the availability zone structure on your production site. A Data Guard implementation in a disaster recovery scenario is similar to the high availability scenario discussed earlier, with a few important differences. For example:

- When you fail over to a secondary replica in the high availability scenario, you configure Azure Load Balancer to redirect requests to the new primary database instance.

- When you fail over to the disaster recovery site, you fail over the *entire* solution to the new site. To avoid latency challenges, you typically need to configure failover for application services. 

If the disaster recovery site is in another region, you need to design the site for the failover depending on your requirements.

The latency within a single datacenter is less than the latency between datacenters that are separated far from each other and much less than the latency between different regions. Therefore, the least complex and least expensive option is to use Data Guard in maximum performance mode for disaster recovery purposes. If the potential data loss in maximum performance mode is too high, you can use maximum availability mode with the Oracle Data Guard Far Sync mechanism. But a Far Sync instance triggers Active Data Guard licensing on the primary environment and standby environment. For more information, see [Oracle license details](https://apex.oracle.com/pls/apex/features/r/dbfeatures/licenses).

Additionally, when you send data across Azure regions or datacenters, you pay egress costs for data, like redo logs, that's sent to a disaster recovery site. If you don't need to replicate all the data in your database, you can use Oracle Golden Gate-based replication to replicate only partial data as needed, which reduces egress costs.

For a step-by-step configuration of Data Guard on Azure, see [Implement Data Guard on a Linux-based Azure Linux VM](/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard).

### Use Golden Gate for disaster recovery

Golden Gate is a logical replication software that you can use for real-time replication, filtering, and transformation of data from a source database to a target database or between multiple primary databases. This feature ensures that changes in the source database are replicated in near real time so that the target database is up to date with the latest data.

You can use Golden Gate to replicate data from a primary database to a secondary database in a disaster recovery configuration. Golden Gate is especially practical if you need to protect only some of your data. To avoid replication of unnecessary data, use Golden Gate to selectively replicate tables and to filter out table rows during replication.

For a step-by-step guide about how to implement Golden Gate on Azure, see [Implement Golden Gate on a Linux-based Azure VM](/azure/virtual-machines/workloads/oracle/configure-oracle-golden-gate).

### Use backup for disaster recovery

Backup and restore is a traditional method for a disaster recovery architecture. There are two main components for backup as a disaster recovery method for Oracle databases on Azure:

- Extract and move the backup of data from a database to ensure that the disaster recovery site has up-to-date data.

- Ensure an up-to-date deployment at the disaster recovery site. To update the site, replicate the same deployment of all network components, application servers, and configurations to the disaster recovery site.

There are several backup options that you can use to replicate data. For more information, see [Backup strategies for Oracle Database on Azure](/azure/virtual-machines/workloads/oracle/oracle-database-backup-strategies).

Consider using one of the following approaches to maintain a disaster recovery site:

**Approach 1:** To avoid the extra maintenance effort and cost, don't maintain any physical deployment at the disaster recovery site. You can use infrastructure as code and site reliability engineering practices to develop and maintain a repository. This repository can replicate the deployment as configuration to a disaster recovery site at the time of the failover. This method optimizes cost because it doesn't use any physical resources until the failover occurs.

> [!IMPORTANT]
> If you create an entire deployment from scratch during a failover, you must ensure that your deployment can meet the solution's RTO requirements. To ensure that deployment code isn't broken, you must routinely simulate and test the disaster recovery scenario.

**Approach 2:** Deploy and maintain a scaled version of your production environment. Have a version that can properly function for a small workload and that you can potentially scale up as necessary during a failover to serve for production load. This method is commonly used, especially for complex deployments in which you don't want to risk creating an entire environment or if you want to fail over quickly to provide a low RTO.

**Approach 3:** Deploy and maintain your entire solution in the disaster recovery site for the fastest RTO and failover times. This method increases cost due to running a fully redundant infrastructure.

### Consider other ways to implement disaster recovery

The following sections describe special considerations for disaster recovery.

#### Use Far Sync

Far Sync doesn't improve high availability capabilities, but you can use it to achieve zero data loss protection capabilities for Oracle databases. Your workload might require zero data loss if your primary database fails. For more information, see [Oracle reference architectures on Azure](/azure/virtual-machines/workloads/oracle/oracle-reference-architecture#oracle-data-guard-far-sync).

#### Choose the right data replication technology

In addition to the technologies in this article, you can use any technology that facilitates data replication across two Oracle databases to maintain a high availability replica and a disaster recovery replica for your Oracle databases on Azure. The technology that you choose must serve your solution requirements across these categories.

**Latency:** The amount of time that it takes to replicate an update from a primary database to secondary databases for high availability and disaster recovery should comply with your solution's requirements.

**Bandwidth:** The amount and cost of bandwidth that you need to replicate data to secondary databases for high availability and disaster recovery. Azure provides a high-speed network infrastructure between availability zones. When you consider replication to other Azure regions for disaster recovery purposes, consider the amount of bandwidth and the egress costs for data that leaves the Azure datacenter.

**Impact:** The level of impact that replication has on transaction processing on the primary database should comply with your solution's requirements.

**Data loss:** The amount of data loss that you expect during an abrupt failure of the primary database should comply with your solution's requirements.

**Total cost of ownership:** Consider the cost of acquisition for a non-Microsoft replication solution and the amount of effort that you need to configure and maintain the replication solution. Verify that these factors comply with your solution's requirements.

### Optimize a failover instance

When you use Data Guard in high availability mode or high protection mode, you can configure for automatic failover so that when the primary server fails, the secondary server is brought up automatically. When you properly configure application servers, you can ensure that you have almost no application downtime during a failover.

In this implementation, a database must run the same after a failover. So you need to configure a secondary server with the same CPU, memory, and input/output (I/O) capacity as the primary server. You need to maintain a high capacity with a secondary server, which increases your Azure costs and Oracle Database license costs. The secondary server usually doesn't process user requests.

Azure provides 99.9% availability for VMs in an availability zone. For more information, see [VM uptime SLA](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services). When you use a data replication technology to maintain a secondary replica of your database in the same availability zone, a different availability zone, or a different region, you can optimize the secondary capacity.

With this approach, the secondary database is configured with the capacity that it needs to remain up to date. When a failure occurs, the secondary database is resized to the same capacity as the primary database. This operation occurs only if there's a failure. So during normal operation, you only pay for a fraction of the cost of the primary server. The primary database isn't operational during the failure, so you don't need other Oracle database licenses.

The capacity that you need to operate a secondary database as a replication destination depends on the replication technology that you use. Essentially, a workload that's on a transactional online transaction processing (OLTP) system has mainly read requests. For example, 90% read and 10% write operations or 95% read and 5% write operations are common in OLTP applications. Data replication essentially replicates the result of writing requests in the source database. With this setup, you can expect the secondary database to operate with 1/10th (if you have a 90% read and 10% write ratio) of the capacity of the primary database.

Automate failover procedures to ensure that you meet enterprise standards during the failover process. You can configure the failover procedures to include server resizing operations that streamline the end-to-end process.

### Configure your network topology for service protection and data protection

To achieve high availability and disaster recovery, you need to make financial and business decisions that balance the recovery time, or RTO, and the potential data loss, or RPO, against other Oracle licensing, VM servicing, and data transfer costs. When you host a workload on a single Azure VM, you get basic protection for common hardware failures at a low cost. But a failure on a single VM likely causes downtime and data loss. So, in your production environments, include at least one secondary Oracle database that's hosted on a separate VM with Data Guard. Depending on your requirements, use one or more of the following Data Guard configurations for data replication:

- **Optimal RTO and RPO**. To minimize latency, incorporate a secondary Oracle database on a separate VM within the same Virtual Machine Scale Sets flexible orchestration and in the same availability zone as the primary database. This configuration provides high availability and protection against a single-instance failure.

- **Data protection from a datacenter failure**. Place the secondary Oracle database in a second availability zone to provide a high availability setup and to provide protection if an entire availability zone fails. This configuration can have up to two milliseconds of latency between the primary and secondary database, which can affect performance, RTOs, and RPOs.
- **Data protection from a regional failure**. To help protect against potential data loss due to an Azure regional failure, you can place the secondary database in a different region. This configuration can have between 30 milliseconds and 300 milliseconds of latency between regions, so you might not meet your RTO and RPO targets. This solution is best for regional disaster recovery rather than high availability. 

Business continuity requires an integrated approach that includes all components of a workload. Network infrastructure is a primary component for any workload on Azure. Your network infrastructure needs to align with your high availability or disaster recovery architecture. Consider the following network infrastructure factors:

- Data Guard provides high availability and, in most scenarios, provides sufficient support for common failures. You can place VMs in a Virtual Machine Scale Sets flexible orchestration. To reduce network latency, all services in a single solution should reside within the same availability zone, and the services should share the same virtual network.

  For further protection, you can strategically place VMs in separate availability zones rather than a single availability zone. This approach can prevent downtime during a datacenter failure.
- For maximum protection, you can place a secondary database in a different Azure region from the primary database region. To apply continuous updates, you can use Data Guard to implement global virtual network peering. Use this approach to apply data updates to the secondary region privately through the Microsoft backbone. Resources communicate directly without gateways, extra hops, or transit over the public internet.

  This networking option provides a high-bandwidth, low-latency connection across peered virtual networks in different regions. You can use global virtual network peering to connect your primary site to a disaster recovery site in a different region through a high-speed network.

## Summary of resiliency against various failure types

| Failure scenario | Oracle on Azure high availability or disaster recovery scenario | RPO/RTO  |
|:-----------|:-----------|:-----------|
| Single component failure, like a host, rack, cooling, networking, or power failure | Data Guard with two nodes in the same Virtual Machine Scale Sets flexible orchestration in the same datacenter:<br><br>  - Protects against a single instance failure. <br> - Causes downtime if an entire datacenter fails. | If you use Observer for fast-start failover and MAX_AVAILABILITY or MAX_PROTECTION mode for Data Guard:<br>- RPO is zero.<br> - RTO is less than or equal to 2 min. <br>    |
| Datacenter failure | Data Guard with two nodes in separate availability zones: <br><br> - Protects against a datacenter failure. <br> - Causes downtime if a whole region fails. <br> - Requires more failover configuration for app servers to manage network latency.  | - RPO is less than or equal to 5 min. <br> - RTO is less than or equal to 5 min.<br><br> If you use MAX_PERFORMANCE mode and MAX_AVAILABILITY mode for Data Guard: <br> - RPO is zero. <br> - RTO is less than or equal to 5 min. |
|Regional failure | Data Guard with two nodes in separate Azure regions:<br><br> - Protects against regional failures. <br> - Requires more failover configuration for app servers to manage network latency.  |  If you use MAX_PERFORMANCE mode for Data Guard: <br> - RPO is greater than or equal to 10 min. <br> - RTO is greater than or equal to 15 min. |
| All scenarios: a single component, datacenter, and region failure |Backups that are shipped to a different Azure region: <br><br> - Protect against regional failures.<br> - Require an entire Azure environment to be set up in the target region during a failover.   | - RPO is greater than or equal to 24 h. <br> - RTO is greater than or equal to 4 h.   |

## Next step

Learn about design considerations for Oracle on Virtual Machines landing zone accelerator security in an enterprise-scale scenario.

[Security guidelines for Oracle on Virtual Machines landing zone accelerator](./oracle-security-overview-iaas.md)
