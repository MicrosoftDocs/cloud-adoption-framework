---
title: Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about business continuity and disaster recovery (BCDR) for Oracle on Azure Virtual Machines landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/01/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 


# Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator

This article builds on the considerations and recommendations that are defined in the [Azure landing zone design area for business continuity and disaster recovery (BCDR)](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). Following the guidance, this article provides you with design considerations and best practices surrounding BCDR options available for Oracle workload deployments on Azure infrastructure virtual machines (VMs).

Azure provides services that you can use to design highly available and resilient architectures. This guide outlines various options and best practices to help you design high availability and disaster recovery for Oracle databases on Azure Virtual Machines landing zone accelerator. It also describes how accompanying Azure service's configurations can help you achieve high end-to-end availability for your solution.

To build a resilient architecture for your workload environment, determine availability requirements for your solution based on the recovery time objective (RTO) and recovery point objective (RPO) for various levels of failure. RTO is the maximum time that an application remains unavailable after an incident occurs. RPO is the maximum amount of data loss during a disaster. After you determine the requirements for your solution, design your architecture to provide the established levels of resiliency and availability.

Oracle on Azure workloads primarily use Data Guard, which is a built-in Oracle Database Enterprise Edition feature that uses replication technology. You can use Data Guard to fulfill high availability and disaster recovery needs. Data Guard offers three protection modes: maximum performance, maximum availability, and maximum protection. Choose your protection mode based on your architectural design and your specific RPO and RTO requirements.

## High availability of Oracle workloads on Virtual Machines landing zone accelerator

Azure Virtual Machines instances that run Oracle workloads benefit from the Azure Virtual Machine Scale Sets architecture, specifically the flexible orchestration mode. High availability configuration provides near real-time data replication with potentially fast failover capabilities. But high availability configuration doesn't provide protection for Azure datacenter-level or region-level failures.

### Choose the right high availability option

Use the following flow chart to choose the best high availability option for your Oracle database.

:::image type="content" source="media/service-protection-design-process-map.png" alt-text="Diagram showing the service design protection process map of Oracle on Virtual Machines landing zone accelerator." border="false":::

### Use Data Guard in maximum availability mode for high availability

Data Guard in maximum availability mode provides the highest availability with a zero data loss promise (RPO=0) for normal operations. For a highly available configuration of two Oracle database servers that are created within a Virtual Machine Scale Sets flexible orchestration, Azure provides 99.95% service availability for a service-level agreement (SLA) for instances that are spread across fault domains. Azure provides 99.99% service availability for instances that are spread across [availability zones](/azure/reliability/availability-zones-overview). For more information, see [High availability for Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#high-availability).

:::image type="content" source="media/high-availability-configuration-data-guard.png" alt-text="Diagram showing a high availability configuration with Data Guard for Oracle on Virtual Machines landing zone accelerator." border="false":::

For a step-by-step configuration of Data Guard on Azure, see [Implement Oracle Data Guard on a Linux-based Azure VM](/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard).

### Use Data Guard in maximum protection mode for high availability

If you require a transactionally consistent copy of your database, consider using Data Guard in maximum protection mode. However, maximum protection mode doesn't allow transactions to continue when standby database isn't available. Therefore, despite using Virtual Machines Scale Sets flexible orchestration, your SLA is reduced to 99.9% x 99.9% = 99.8% when you use maximum protection mode. This configuration ensures a consistent copy of data but doesn't necessarily increase availability.

Other attributes of this architecture are the same as maximum availability mode. For example the RPO is zero, and the RTO is less than or equal to two minutes.

### Special usage considerations for high availability

The following sections describe special considerations for high availability.

#### Use availability zones for improved high availability

[Azure availability zones](/azure/reliability/availability-zones-overview) are Azure datacenters that are within the same Azure region. Availability zones have a roundtrip latency of less than 2 milliseconds (ms). You typically use them for disaster recovery purposes, but you can use availability zones to improve high availability. If you do, you must make sure that your solution can run with the amount of latency and throughput between the availability zones that you use.

An advantage of availability zones with a Virtual Machine Scale Sets flexible orchestration is that your VM availability SLA increases to 99.99%.

#### Use shared storage clustering for high availability

Shared storage clustering technologies provide unique attributes that can help you achieve your business goals. For example, you can implement a Pacemaker and Corosync (PCS) cluster with shared storage. You can use managed disks or Azure NetApp Files as shared storage for PCS cluster instances. A PCS cluster doesn't duplicate data and provides a virtual IP service with a static IP address or IP network name that doesn't change across failovers.

> [!NOTE]
> A PCS cluster isn't an Oracle-certified solution. Consider this factor when you determine your high availability architecture.

:::image type="content" source="media/reference-architecture-pacemaker-cluster.png" alt-text="Diagram showing a high availability configuration with Pacemaker for Oracle on Virtual Machines landing zone accelerator.":::

#### Use proximity placement groups

To get VMs as close as possible, which provides the lowest possible latency, you can deploy them within a [proximity placement group](/azure/virtual-machines/co-location). A proximity placement group is a logical grouping that ensures that Azure compute resources are physically located close to each other. Proximity placement groups are useful for workloads that require low latency. 

### Disaster recovery for Oracle on Azure workloads

A disaster recovery architecture provides resiliency against failures that affect Azure datacenters or regions or failures that hinder application functionality across an entire region. In such a scenario, you should move your entire workload to another datacenter or region.

As stated earlier, you should choose your disaster recovery architecture based on your solution requirements. And you determine your requirements based on your RTO and RPO. Disaster recovery architectures are meant for exceptional failure cases, so failover processes are manual. Failover processes are automatic in the high availability design. In a disaster recovery architecture, you should have more relaxed requirements for RTO and RPO, which saves money.

This article focuses on scenarios in which the primary and secondary servers are both on Azure. You can also have a primary server on-premises and a secondary server on Azure for disaster recovery purposes. For more information, see [Primary site on-premises and disaster recovery site on Azure](/azure/virtual-machines/workloads/oracle/oracle-disaster-recovery#scenario-2-primary-site-on-premises-and-dr-site-on-azure).

### Choose the right disaster recovery option

Use the following flow chart to decide the best disaster recovery option for your Oracle database.

:::image type="content" source="media/data-protection-design-process-map.png" alt-text="Diagram showing the data protection design process map of Oracle on Virtual Machines landing zone accelerator." border="false":::

### Use Data Guard for disaster recovery

You can use Data Guard to replicate data to your disaster recovery site. You can use that site as another availability zone in the same region or in a different region depending on your requirements for data protection. Your configuration also depends on the availability zone structure on your production site. Data Guard implementation in a disaster recovery scenario is similar to the high availability scenario discussed earlier, with a few important differences. For example:

- When you failover to a secondary replica in the high availability scenario, you configure Azure Load Balancer to redirect requests to the new primary database instance.

- When you failover to the disaster recovery site, you failover the *entire* solution to the new site. To avoid latency challenges, you typically also need to configure failover for application services. 

If the disaster recovery site is in another region, you need to design the site for the failover depending on your requirements.

The latency within a single datacenter is less than the latency between datacenters that are separated far from each other and much less than the latency between different regions. Therefore, the least complex and least expensive option is to use Data Guard in maximum performance mode for disaster recovery purposes. If the potential data loss in maximum performance mode is too high, you can use maximum availability mode with the FarSync mechanism. But a FarSync instance triggers Active Data Guard licensing on the primary environment and standby environment. For more information, see [Oracle license details](https://apex.oracle.com/pls/apex/features/r/dbfeatures/licenses).

Additionally, when you send data across Azure regions or datacenters, you pay egress costs for data, like redo logs, that's sent to a disaster recovery site. If you don't need to replicate all data in your database, you can use Golden Gate-based replication to replicate only partial data as needed, which reduces egress costs.

:::image type="content" source="media/disaster-recovery-data-guard.png" alt-text="Diagram showing a disaster recovery configuration with Data Guard for Oracle on Virtual Machines landing zone accelerator." border="false":::

For a step-by-step configuration of Data Guard on Azure, see [Implement Oracle Data Guard on a Linux-based Azure Linux VM](/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard).

### Use Golden Gate for disaster recovery

Golden Gate is a logical replication software that you can use for real-time replication, filtering, and transformation of data from a source database to a target database or between multiple primary databases. This feature ensures that changes in the source database are replicated in near real time so that the target database is up to date with the latest data.

You can use Golden Gate to replicate data from a primary database to a secondary database in a disaster recovery configuration. Golden Gate is especially practical if you need to protect only some of your data. To avoid replication of unnecessary data, use Golden Gate to selectively replicate tables and filter out table rows during replication.

For a step-by-step guide on how to implement Golden Gate on Azure, see [Implement Oracle Golden Gate on a Linux-based Azure VM](/azure/virtual-machines/workloads/oracle/configure-oracle-golden-gate).

### Use backup for disaster recovery

Backup and restore is a traditional method for a disaster recovery architecture. There are two main components of using backup as a disaster recovery method for Oracle databases on Azure:

- Extract and move the backup of data from a database to ensure that the disaster recovery site has up-to-date data.

- Ensure up to date deployment at the disaster recovery site. You update the site by replicating the same deployment of all network components, application servers and configuration to the disaster recovery site.

There are several backup options that you can use to replicate data. For more information, see [Backup strategies for Oracle Databases on Azure](/azure/virtual-machines/workloads/oracle/oracle-database-backup-strategies).

Consider using one of the following approaches to maintain the disaster recovery site:

- Approach 1: To avoid the extra maintenance effort and cost, don't maintain physical deployment at the disaster recovery site. You can use infrastructure as code (IaC) and site reliability engineering practices to develop and maintain a repository that can replicate deployment as configuration with one click at the time of the failover to a disaster recovery site. This method optimizes cost because it doesn't use any physical resources until the failover occurs.

> [!IMPORTANT]
> You must ensure the solution's RTO requirements can be met if you create an entire deployment from scratch during a failover. To ensure that deployment code isn't broken, you must routinely simulate and test the disaster recovery scenario.

- Approach 2: Deploy and maintain a scaled version of your production environment. Have a version that can function accurately for a small workload and that you can potentially scale up as necessary during a failover to serve for production load. This method is commonly used, especially for complex deployments in which you don't want the risk of creating an entire environment or if you want to failover quickly to provide a low RTO.

- Approach 3: Deploy and maintain your entire solution to the disaster recovery site for the fastest RTO and failover times. This method increases cost due to running a fully redundant infrastructure.

### Special considerations for disaster recovery

The following sections describe special considerations for disaster recovery.

#### Use FarSync

Oracle Data Guard Far Sync doesn't help with the high availability capabilities, but you can use it to achieve zero data loss protection capabilities for Oracle databases. Your workload might require zero data loss when your primary database fails. For more information, see [Oracle reference architectures on Azure](/azure/virtual-machines/workloads/oracle/oracle-reference-architecture#oracle-data-guard-far-sync).

#### Choose the right data replication technology

In addition to the technologies in this article, you can use any technology that facilitates data replication across two Oracle databases to maintain a high availability replica and a disaster recovery replica for your Oracle databases on Azure. The technology that you choose must serve your solution requirements across these pillars.

**Latency:** The amount of time that it takes to replicate an update from a primary database to secondary databases for high availability and disaster recovery should comply with your solution's requirements.

**Bandwidth:** The amount and cost of bandwidth that you need to replicate data to secondary databases for high availability and disaster recovery should be provided. Azure already provides a high-speed network infrastructure between availability zones. When you consider replication to other Azure regions for disaster recovery purposes, consider the amount of bandwidth that can be achieved and the egress costs for data that leaves the Azure datacenter.

**Impact:** The level of impact that replication has on transaction processing on the primary database should comply with your solution's requirements.

**Data loss:** The amount of data loss that you expect during an abrupt failure of the primary database should comply with your solution's requirements.

**Total cost of ownership:** Consider the cost of acquisition (of a non-Microsoft replication solution) and the amount of effort that you need to configure and maintain the replication solution. Verify that these factors comply with your solution's requirements.

### Optimize failover instance

When you use data guard in high availability or high protection mode, it's also possible to configure for automatic failover so that when the primary server fails, the secondary server is brought up automatically. By configuring application servers accordingly, you can ensure that application downtime is close to zero during failover.

 In this implementation, since the database is supposed to serve the same way after failover, a secondary server needs to be configured with the same CPU, memory, and I/O capacity as the primary server. In that case, you would need to maintain a high capacity with a secondary server that would increase your Azure costs and Oracle database license costs. The secondary server won't process user requests most of the time.

Azure already provides 99.9% availability for VMs in an availability zone as indicated in [Virtual Machine uptime SLA](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services). When you maintain a secondary replica of your database in the same availability zone, another availability zone or another region using any data replication technology, it's possible to optimize the secondary capacity.

With this approach, the secondary database(s) are configured with the capacity they need to keep up to date. When a failure occurs, the secondary database is resized to bring it up to the same capacity as the original primary. This operation is done only on failure, so during normal operation you only pay for a fraction of the cost of the original server. Since the primary database isn't operational at that moment, you won’t require other Oracle database licenses.

Capacity needed to operate secondary database as a replication destination depends on the replication technology you use. Essentially, workload on a transactional OLTP system is composed mostly of read requests. For example, 90%-10% or 95%-5% read-write rations are common in OLTP application. Data replication essentially replicates the result of writing requests in the source database. With this setup, it's reasonable to expect secondary database to operate with 1/10th (if 90%-10% read-write ratio) or even 1/10th of capacity of primary database.

It's also recommended to automate failover procedures to ensure  enterprise standards during the failover process. The same process can be developed to include server resizing operations, that streamline the end-to-end process.

### Network topology for service protection and data protection

Achieving high availability and disaster recovery requires a financial and business decision that balances the recovery time (RTO) and the potential data loss (RPO) against the other Oracle licensing, VM servicing and data transfer costs to implement. Hosting a workload on a single Azure VM offers basic protection for common hardware failure and delivers the least costly solution. However, because a failure on a single VM is likely to cause downtime and data loss, production environments should include, at the minimum, one secondary Oracle database hosted on a separate VM with Oracle Data Guard. Configure the data guard properly for data replication with one or more of the following architectures, depending on your requirements.

- **Optimal RTO and RPO**. To minimize latency, incorporate a secondary Oracle database on a separate VM within the same Virtual Machine Scale Sets flexible orchestration and same availability zone as the primary database. This achieves high availability with protection against a single instance failure.

- **Data protection from a datacenter failure**. Placing the secondary Oracle database in a second availability zone provides a high availability set-up with protection in the event an entire availability zone fails. Latency between the primary and secondary database can be as much as 2 ms, which could affect performance, RTO and RPO.
- **Data protection from a regional failure**. To help protect against potential data loss from an Azure regional failure, the secondary database can be placed in another region. As latency between regions can be between 30 ms and 300 ms, the RTO and RPO targets may not be supportable. So, this solution is best used for regional disaster recovery rather than high availability. 

Business continuity requires an integrated approach that includes all components of the workload. Network infrastructure is a primary component for any workload on Azure and it needs to align with the high availability and disaster recovery architecture.

- Oracle Data Guard provides high availability and (in most scenarios) provides sufficient support for common failures. VMs can be placed in a Virtual Machine Scale Sets flexible orchestration, and all services in a single solution should reside within the same availability zone to reduce network latency. For the same reason, the services should share the same virtual network.

- For further protection, VMs can be strategically placed in separate availability zones rather than a single availability zone. This approach can prevent downtime during a datacenter failure.
- For extreme protection, a secondary database can be placed in another Azure region with continuous updates applied with Oracle Data Guard using Global virtual network peering. This protection enables data updates to be applied to the secondary region privately through the Microsoft backbone. Resources communicate directly, without gateways, extra hops, or transit over the public internet. This networking option allows a high-bandwidth, low-latency connection across peered virtual networks in different regions. You can use Global virtual network peering to connect your primary site to disaster recovery site in another region through a high-speed network.

## Summary of resiliency against different failure types

| Failure scenario | Oracle on Azure HA/DR scenario | RPO/RTO  |
|:-----------|:-----------|:-----------|
| Single component failure (host, rack, cooling, networking, power) | Data Guard with two nodes in the same Virtual Machine Scale Sets flexible orchestration in the same datacenter.<br>  - Protects against single instance failure. <br> - Will cause downtime if entire datacenter is down. | RPO=0 RTO<=2 mins <br> - Using Observer for Fast Failover <br> - Using MAX_AVAILABILITY or MAX_PROTECTION mode for Data Guard.   |
| Datacenter failure | Data Guard with two nodes in separate availability zones. <br> - Protects against datacenter failure. <br> - Will cause downtime if whole region is down. <br> - Requires more failover configuration for app servers to manage network latency.  | RPO<=5 mins RTO<=5 mins<br> - Using MAX_PERFORMANCE mode for Data Guard <br> RPO=0 RTO<=5 mins <br> - Using MAX_AVAILABILITY mode for Data Guard  |
|Region failure | Data Guard with two nodes in separate Azure regions:<br> - Protects against regional failures <br> - Requires more failover configuration for app servers to manage network latency.  |  RPO>=10 mins RTO>=15 mins<br> - Using MAX_PERFORMANCE mode for Data Guard.  |
| All above scenarios |Backups shipped to a different Azure region: <br> - Protects against regional failures.<br> - Requires entire Azure environment to be set up in the target region during failover.   | RPO>=24 hrs RTO>=4 hrs   |

## Next step

Learn about design considerations for Oracle on Virtual Machines landing zone accelerator security in an enterprise-scale scenario.

See [Security guidelines for Oracle on Virtual Machines landing zone accelerator](./oracle-security-guideline-landing-zone.md).