---
title: Business continuity and disaster recovery (BCDR) for Oracle on Azure IaaS
description: Learn about business continuity and disaster recovery (BCDR) for Oracle on Azure IaaS.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 08/31/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 


# Business continuity and disaster recovery (BCDR) for Oracle on Azure IaaS

This article builds on the considerations and recommendations that are defined in the [Azure landing zone design area for BCDR](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery). Following the guidance, this article provides you with design considerations and best practices surrounding business continuity and disaster recovery (BCDR) options available for Oracle workload deployments on Azure Infrastructure virtual machines(VMs).

The first step to building a resilient architecture for your workload environment is to determine availability requirements for your solution by the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failure. RTO is the maximum time an application is unavailable after an incident and RPO is the maximum amount of data loss during a disaster. After you determine the  requirements for your solution, the next step is to design your architecture to provide the established levels of resiliency and availability.

Oracle on Azure workloads primarily use Data Guard, the built-in replication technology of Oracle databases (as a feature of Enterprise Edition), to fulfill both high availability and disaster recovery needs. Data Guard offers three protection modes: Maximum Performance, Availability, and Protection. The choice of protection mode depends on the architectural design and the specific RPO and RTO requirements.

## High availability of Oracle workloads on Azure IaaS

Azure VM instances that run Oracle workloads benefit from Availability Set architecture. High availability configuration provides near real-time data replication with potentially fast failover capabilities but doesn't provide protection for Azure data center level or region level failures.

### Choose the right high availability option

Use the following flowchart to choose the best high availability option for your Oracle database.

:::image type="content" source="media/service-protection-design-process-map.png" alt-text="Diagram showing the service design protection process map of Oracle on Azure Iaas.":::

 
### High availability using Data Guard in maximum availability mode

Data Guard in maximum availability mode provides the highest availability with zero data loss promise (RPO=0). For highly available configuration of two Oracle database servers created within an availability set, Azure provides 99.95% SLA for service availability.

:::image type="content" source="media/high-availability-configuration-data-guard.png" alt-text="Diagram showing high availability configuration with Data Guard for Oracle on Azure Iaas.":::

See [Implement Oracle Data Guard on an Azure Linux virtual machine](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard) for a step-by-step configuration of Data Guard on Azure.

### High availability using Data Guard in maximum protection mode

If you always require a transactionally consistent copy of your database, then you can consider using Data Guard in maximum protection mode. However, maximum protection mode doesn't allow transactions to continue when standby database isn't available. Therefore, despite using availability sets, your SLA is reduced to 99.9%x99.9%=99.8% when you use maximum protection mode. This configuration is more for ensuring consistent copy of data rather than increasing availability.

Other attributes of this architecture are the same as maximum availability mode (that is, RPO=0, RTO<=2 mins).

### Special usage considerations for high availability

#### Use availability zones versus availability sets for high availability

Azure availability zones are Azure datacenters within the same Azure region that is guaranteed to have <2 ms roundtrip latency. Although normally used for disaster recovery purposes as discussed later, it's possible to use them for high availability instead of availability sets. However, you must make sure that your solution can run with the latency and throughput provided between availability zones you use.

One advantage of using availability zones over availability sets is that your SLA will increase from 99.95% to 99.99%.

#### Shared storage clustering for high availability

Shared storage clustering technologies provide unique attributes that can help achieve your business goals. One such technology you can adapt on Azure is Pacemaker/Corosync (PCS) cluster with shared storage. You can use managed disks or Azure NetApp Files as shared storage for PCS Cluster instances. Using PCS cluster doesn't duplicate data and provides a virtual IP service with a static IP address/network name that doesn't change across failovers.

:::image type="content" source="media/reference-architecture-pacemaker-cluster.png" alt-text="Diagram showing high availability configuration with Pacemaker for Oracle on Azure Iaas.":::

Use the following links to learn more on how to configure Pacemaker cluster:

- [Setting up Pacemaker on SUSE Linux Enterprise Server in Azure](https://learn.microsoft.com/azure/sap/workloads/high-availability-guide-suse-pacemaker)
- [Setting up Pacemaker on Red Hat Enterprise Linux in Azure](https://learn.microsoft.com/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi)
- [Sample script to configure Pacemaker/Corosync (PCS) cluster for an Oracle database](https://github.com/Azure/Oracle-Workloads-for-Azure/tree/main/orapcs)

#### Use proximity placement groups

Consider using [proximity placement groups](https://learn.microsoft.com/azure/virtual-machines/co-location) to ensure minimum latency between database servers in the same availability set and between database servers and application servers.  This proximity placement is important when using Pacemaker/Corosync with shared managed disk, or it can be useful to minimize network latency when running Oracle Data Guard in MAX_PROTECTION or MAX_AVAILABILITY mode within a single Azure availability set.

### Disaster recovery for Oracle on Azure workloads

Disaster recovery architecture provides resilience against failures that impact Azure datacenter or region or that hinder application functionality across entire region. In any case, you would want to move your entire workload to another datacenter or region.

As stated earlier, disaster recovery architecture should be based on your solution requirements as indicated by RTO and RPO. Since disaster recovery architecture is built for exceptional failure cases, failover process is manual as opposed to high availability design. Generally you should have more relaxed requirements for RTO and RPO, which can enable more cost-effective designs.

This document focuses on scenarios where primary and secondary servers are both on Azure. It's also possible to have a primary server on-premises and secondary server on Azure for disaster recovery purposes. Learn more about this scenario in [Disaster recovery for an Oracle database 12c database in an Azure environment](oracle-disaster-recovery-iaas.md).

### Choose the right disaster recovery option

Use the flowchart in figure 4 to decide the best disaster recovery option for your Oracle database.

:::image type="content" source="media/data-protection-design-process-map.png" alt-text="Diagram showing the data protection design process map of Oracle on Azure Iaas.":::

### Disaster recovery using Data Guard

Data Guard can be used to replicate data to your disaster recovery site. That site could be another availability zone in the same region or could be a different region depending on your requirements for data protection and on the availability zone structure provided on your production site. Using Data Guard in a disaster recovery scenario is similar to the high availability scenario discussed earlier with a few important differences.

- When you fail over to secondary replica in high availability scenario, you send Azure Load Balancer to redirect requests to new primary.
- When you fail over to disaster recovery site, you fail over the **entire** solution to the new site.

If the disaster recovery site is in another region, you'll need to design it for the failover depending on your requirements.

Latency between Azure datacenters that are separated far from each other and latency between regions or datacenters is higher than latency within the same datacenter. For that reason, the least complex and least expensive recommendation is to use Data Guard in maximum performance mode for disaster recovery purposes.  If maximum performance mode is too risky, then it's possible to use maximum availability mode in conjunction with the FarSync mechanism. However, use of a FarSync instance triggers Active Data Guard licensing on both the primary and standby environments. For more detailed information, review the [License details](https://apex.oracle.com/pls/apex/features/r/dbfeatures/licenses?license_id=20).

Additionally, when you send data across Azure regions or data centers, you face egress costs for data (ex: redo logs) that's sent to a disaster recovery site. If you don't need to replicate all data in your database, you can replicate only partial data as needed using Golden Gate based replication and save on egress costs.

:::image type="content" source="media/disaster-recovery-data-guard.png" alt-text="Diagram showing disaster recovery configuration with Data Guard for Oracle on Azure Iaas.":::

For a step-by-step configuration of Data Guard on Azure, see [Implement Oracle Data Guard on an Azure Linux virtual machine](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard) .

### Disaster recovery using Golden Gate

Golden Gate is a logical replication software that enables real-time replication, filtering, and transformation of data from a source database to a target database or between multiple primary databases. This feature ensures that changes in the source database are replicated near real-time, making it possible for the target database to be up-to-date with the latest data.

Golden Gate can be used to replicate data from a primary database to secondary in a disaster recovery configuration. Golden Gate can be more practical for instance, when not all data if your data needs to be protected. Golden Gate allows you to selectively replicate tables and even filter out table rows during replication to avoid replicating unnecessary data.

For a step-by-step guide on how to implement Golden Gate on Azure, see [Implement Oracle Golden Gate on an Azure Linux VM](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/configure-oracle-golden-gate.md).

### Disaster recovery using backup

Backup and restore have been a traditional method for disaster recovery architecture. There are two main components of using backup as a disaster recovery method for Oracle databases on Azure:

- Ensure up to date data at the disaster recovery site by extracting and moving backup of data from database.

- Ensure up to date deployment at the disaster recovery site. This is achieved by replicating the same deployment of all network components, application servers and configuration to the disaster recovery site.

When it comes to replicating data using backup, you have several different options you can explore as explained in [Backup strategies for Oracle Databases on Azure](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-database-backup-strategies.md).

Consider using one of the following approaches to maintain the disaster recovery site:

- One approach is you don't maintain any physical deployment at the disaster recovery site, thereby avoiding the maintenance effort and cost for it. You can use infrastructure-as-code (IaC) and site reliability engineering practices to develop and maintain a repository that can replicate deployment as configuration with one-click at the time of failover to a disaster recovery site. This method optimizes cost as it doesn't use any physical resources until the time of failover.

> [!IMPORTANT]
> You must ensure the solution's RTO requirements can be met if you create entire deployment from scratch during failover. Routine simulation and testing of disaster recovery scenario is needed to ensure the deployment code is not broken.

- A second approach is to deploy and maintain a scaled version of your production environment, that can function accurately for a small workload and can potentially be scaled up as necessary during failover to serve for production load. This is the most used method, especially for complex deployments where you don't want to take the risk of creating the entire environment or when you would like to failover quickly in order to provide a lower RTO.

A third approach is you deploy and maintain your entire solution to the disaster recovery site for the fastest RTO and failover times at the expense of potentially doubling your cost.

### Special considerations for disaster recovery

#### Use FarSync

Oracle Data Guard Far Sync doesn't help with the high availability capabilities but it allows you to achieve zero data loss protection capability replication for Oracle Databases. If your workload requires zero data loss if primary server failure, refer to the [Oracle reference architectures on Azure](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-reference-architecture#oracle-data-guard-far-sync) for more information on how to use Far Sync on Azure.

#### Choose the right data replication technology

Apart from native technologies described in this document, you can use any technology that facilitates data replication across two Oracle databases to maintain a high availability replica and a disaster recovery replica for your Oracle databases on Azure. It's important that the technology you choose serves your solution requirements across these pillars.

**Latency:** Amount of time it takes to replicate an update from primary to secondaries for high availability and disaster recovery should comply with your solution requirements.

**Bandwidth:** Amount and cost of bandwidth you need to replicate data to secondaries for high availability and disaster recovery should be provided. Azure already provides a high-speed network infrastructure between availability zones. When considering replication to other Azure regions for disaster recovery purposes, consider the amount of bandwidth that can be achieved as well as egress costs for data leaving the Azure datacenter.

**Impact:** Amount of impact replication imposes on transactions on primary database should comply with your solution requirements.

**Data loss:** Amount of data loss expected in an abrupt failure of primary database should comply with your solution requirements.

**Total cost of ownership:** Cost of acquisition (in the case of a third party replication solution) and amount of effort required to configure and maintain the replication solution should also be considered and verified to be within solution requirements.

### Optimize failover instance

When you use Data Guard in high availability or high protection mode, it's also possible to configure for automatic failover so that when the primary server fails, the secondary server is brought up automatically. By configuring application servers accordingly, you can ensure that application downtime is close to zero during failover.

 In this implementation, since the database is supposed to serve the same way after failover, a secondary server needs to be configured with the same CPU, memory, and I/O capacity as the primary server. In that case, you would need to maintain a high capacity with a secondary server, which will increase your Azure costs and Oracle database license costs and secondary server will not be serving user requests most of the time.

Azure already provides 99.9% availability for virtual machines in an availability zone as indicated in [VM uptime service-level agreement (SLA)](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services). When you maintain a secondary replica of your database in the same availability zone, another availability zone or another region using any data replication technology, it's possible to optimize the secondary capacity.

In this approach, the secondary database(s) are configured with just the capacity they need to keep up to date. When a failure occurs, the secondary database is resized to bring it up to the same capacity as the original primary. This operation is done only on failure so during normal operation you only pay for a fraction of the cost of the original server. Since the primary database isn't operational at that moment you won’t need other Oracle database licenses.

Capacity needed to operate secondary database as a replication destination depends on the replication technology you use. Essentially, workload on a transactional OLTP system is composed mostly of read requests. For example, 90%-10% or 95%-5% read-write rations are common in OLTP application. Data replication essentially replicates the result of writing requests in the source database. With this, it's reasonable to expect secondary database to operate with 1/10th (in case of 90%-10% read-write ratio) or even 1/10th of capacity of primary database.

It's also possible and recommended to implement failover procedures as IaC (infrastructure as code) so  enterprise standards can be ensured during failover process. The same process can be developed to include server resizing operations, which will streamline the end-to-end process.

### Network topology for service protection and data protection

Achieving high availability and disaster recovery requires a financial and business decision that balances the recovery time (RTO) and the potential data loss (RPO) against the other Oracle licensing, virtual machine servicing and data transfer costs to implement. Hosting a workload on a single Azure virtual machine offers basic protection for common hardware failure and delivers the least costly solution. However, because a failure on a single virtual machine  likely experiences downtime and data loss, production environments should include a secondary Oracle database hosted on a separate virtual machine with Oracle Data Guard properly configured for data replication with one of the following designs.

- **Optimal RTO and RPO**. To minimize latency, incorporate a secondary Oracle database on a separate virtual machine within the same availability set and within a proximity placement group as the primary database.
- **Data protection from a data center failure**. Placing the secondary virtual machine in a second database increases data protection in the event an entire data center fails. Latency between the primary and secondary database may be as much as 2 ms, which could impact performance, RTO and RPO.
- **Data protection from a regional failure**. To extend protection to prevent data loss from an Azure regional failure, the secondary database can be placed in another region. As latency between regions can be between 30 ms and 300 ms, the impact on the production workload and RTO and RPO can increase and should be estimated in advance.

Business continuity requires an integrated approach that includes all components of the workload. Network infrastructure is a primary component for any workload on Azure and it needs to align with the high availability and disaster recovery architecture.

- Oracle Data Guard provides high availability and (in most scenarios) provides sufficient support for common failures. While virtual machines should be placed in separate availability sets, all virtual machines should reside within a single availability zone to reduce network latency.
- For other protection, virtual machines can be strategically placed in separate availability zones rather than a single availability zone. This approach can prevent downtime in the event of a data center failure.
- For extreme protection, a secondary database can be placed in another Azure region with continuous updates applied with Oracle Data Guard using Global VNet peering. This enables data updates to be applied to the secondary region privately through the Microsoft backbone. Resources communicate directly, without gateways, extra hops, or transit over the public internet. This allows a high-bandwidth, low-latency connection across peered virtual networks in different regions. You can use Global VNet peering to connect your primary site to disaster recovery site in another region through a high-speed network.
- Azure Load Balancer is a layer-4 load balancer that can be employed to route Oracle calls to the Primary database under normal conditions. A health probe can detect when the Primary becomes unavailable to route calls to the Secondary database. A manual configuration update should be done to route database calls to a Secondary database in another region.

## Summary of resiliency against different failure types

| Failure Scenario | Oracle on Azure HA/DR Scenario | RPO/RTO |
|------|------|------|
| Single component failure (host, rack, cooling, networking, power) | Data Guard with two nodes in the same availability set in the same data center:   - Protects against single instance failure.   Causes downtime if entire data center is down | PO=0 RTO<=2mins    - Using Observer for Fast Failover - Using MAX_AVAILABILITY or MAX_PROTECTION mode for Data Guard|
| Data  Center failure | Data Guard with two nodes in separate availability zones:   - Protects against data center failure
- Will cause downtime if whole region is down
- Requires additional failover configuration for app servers to manage network latency. | RPO<=5mins RTO<=5mins  
- Using MAX_PERFORMANCE mode for Data Guard
RPO=0 RTO<=5mins  
- Using MAX_AVAILABILITY mode for Data Guard  |

| Region failure | Data Guard with two nodes in separate Azure regions:

- Protects against regional failures
- Requires additional failover configuration for app servers to manage network latency. | RPO>=10mins RTO>=15mins  
- Using MAX_PERFORMANCE mode for Data Guard|
| Region failure  | Backups shipped to a different Azure region:
- Protects against regional failures.
- Requires entire Azure environment to be setup in the target region during failover. | RPO>=24hrs RTO>=4hrs |

## Summary

Azure provides services and capabilities to design highly available and resilient architecture. This guide outlines various options and best practices designing high availability and disaster recovery for Oracle databases on Azure IaaS. It also describes how accompanying Azure services are configured to achieve high end-to-end availability for your solution.

## Next steps

Learn about design considerations for Oracle on Azure IaaS security in an enterprise-scale scenario. 

[**Security guidelines for Oracle on Azure IaaS**](https://microsofteur.sharepoint.com/:w:/t/DataMod/EcSpeXRTMBlHqYhoi-NF7_YBvq3CvuyF93DyG4fNFyVDQg?e=bMnwx2)