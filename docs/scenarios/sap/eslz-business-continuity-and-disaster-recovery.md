---
title: Business continuity and disaster recovery for an SAP migration
description: Learn about business continuity and disaster recovery for an SAP migration.
author: JeffreyMitchell
ms.author: brblanch
ms.date: 3/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Business continuity and disaster recovery (BCDR) for an SAP migration

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [enterprise-scale design area for BCDR](../../ready/enterprise-scale/business-continuity-and-disaster-recovery.md). Following the guidance in this article will help understand the unique constraints required for any landing zone to support the SAP platform. However, since SAP is an mission-critical platform, the guidance on the enterprise-scale design areas should also be included in your design.

## Scenario and scope

Your organization or enterprise needs to design platform-level capabilities that help application workloads to meet their specific requirements. SAP applications running an organization's most critical business processes have the following requirements:

- Service/business process availability

- Recovery time objectives (RTOs) during failure or disaster scenarios; for example, a failure scenario limited to a component of an SAP system or a widespread failure affecting a datacenter or Azure region.

- Recovery point objectives (RPOs) for a failure scenario limited to a component of an SAP system or a widespread failure affecting a datacenter or an Azure region
- Operational and lifecycle management tasks can require technology that fills in for failure scenarios. These management tasks include patching guest operating systems and database management systems, cloning, and refreshing SAP systems.

Your architecture factors in many principles and tasks to address business continuity and disaster recovery (BCDR) scenarios on-premises, and these also apply in Azure. The main difference is that Azure might have more hardware capacity than your organization to compensate for a host failure. Even the largest Azure VMs can be service-healed by having them restart on another server. Aside from this, the same conditions apply as with on-premises. Systems that you deployed with automatic failover cluster configurations on-premises or on bare-metal hardware should also be deployed in Azure this way.

This article covers the following aspects of BCDR for an enterprise-scale SAP scenario:

- High availability (HA) within an Azure region
- Backup/restore considerations
- Cross-regional vs. regional disaster recovery decision criteria

### High availability (HA) within an Azure region

**Design Considerations for HA:**

With HA, the focus is to provide availability for SAP software's single point of failure, such as with:

- Database management systems
- Single points of failure in the application, like with ABAP SAP ASCS/SCS (for example, with SAP NetWeaver and S/4HANA architecture)
- Other tools, like SAP Web Dispatcher

For other scenarios, availability shouldn't be restricted to infrastructure or software failures and should include all necessary lifecycle management tasks, such as patching the OS in the VMs, the DBMS, or SAP software. To minimize outages that can happen during planned downtime and lifecycle management tasks, you can use common tools that protect against unplanned service disruptions.

SAP and SAP databases support automatic failover clusters. The Windows Server Failover Clustering feature achieves this in Windows, whereas Linux Pacemaker or third-party tools like SIOS Protection Suite or Veritas InfoScale are for Linux. With Azure, you can only deploy a subset HA configurations in your own datacenter.

Explore [SAP workload on Azure VM-supported scenarios](/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [supported scenarios for SAP HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-supported-scenario) to learn more about what Azure supports for SAP.

For the DBMS layer, the common architecture pattern is to replicate databases at the same time and with different storage stacks that the primary and secondary VMs are using. Azure doesn't support architectures where the primary and secondary VM share storage for DBMS data, nor does it support transaction/redo logs. The guiding principle is that there must two independent storage stacks, even if they're based on Network File System (NFS) shares, and this is the main limitation when compared to what's possible with on-premises.

Azure does present other options, as the service supports either NFS or Server Message Block sharing. [Azure shared disk](/azure/virtual-machines/disks-shared) can be used in Windows for ASCS/SCS components and specific HA scenarios. Failover clusters should be set up separately for SAP application layer components and the DBMS layer since Azure doesn't support HA architectures that combine SAP application layer components and the DBMS layer into one failover cluster.

Most failover clusters for SAP application layer components and the DBMS layer require a virtual IP address for a failover cluster. One common exception is with Oracle Data Guard, whose functionality doesn't require a virtual IP address. [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) should handle the virtual IP address for all other cases. As a design principle, use one Load Balancer per cluster configuration; the standard version of the load balancer is recommended. For more information, see [Public endpoint connectivity for virtual machines using Azure Standard Load Balancer in SAP HA scenarios](/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

Explore [HA architecture and scenarios for SAP NetWeaver](/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios) for more information and possibilities.

#### Azure availability sets vs. Availability Zones

Before you deploy your HA infrastructure and depending on the region you've chosen, decide whether you want to deploy through an [Azure availability set](/azure/virtual-machines/availability) or an Availability Zone. The main differences for VMs deployed with an availability set are that:

- The VMs aren't spread across different Availability Zones.

- The type of VMs that can be deployed through a single availability set are restricted since the host is defined by the first VM deployed in the set. One example result is that you won't be able to combine an M-series and E-series VMs into one availability set.

One advantage of deploying your HA architecture across different Availability Zones is that your SLA for the VMs could be higher. For details, review [Azure VM SLAs](https://azure.microsoft.com/support/legal/sla/virtual-machines). Depending on the Azure region, you might discover different network latency conditions in network traffic between VMs. Read through [SAP workload configurations with Azure Availability Zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones) for more information about SAP workload deployments across different Availability Zones.

**Design recommendations for HA:**

- Azure offers several options to help your applications meet their infrastructure SLAs. You should choose the same option for all the three SAP components (central services, application server, and database).

  - A single VM SLA offers 99.9 percent.
  - Availability set deployment offers 99.95 percent.
  - Availability Zones offer 99.99 percent.

- In an availability set deployment, each component of an SAP system has to be in its own availability set. SAP central services, database, and application VMs should be grouped in their availability sets.

- When using Azure proximity placement groups in an availability set deployment, all the three SAP components (central services, application server, and database) should be in the same proximity placement group.

- Use one proximity placement group per SAP SID. Groups don't span across Availability Zones or Azure regions.

- Azure doesn't currently support combining ASCS and db HA in the same Linux Pacemaker cluster; separate them into individual clusters. However, you can combine up to five [multiple central-services clusters](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-multi-sid) into a pair of VMs.

- Use a Standard Load Balancer SKU in front of ASCS and DB clusters.

- All production systems should run on premium-managed SSDs and use Azure NetApp Files or Ultra Disk Storage. At least the OS disk should be Premium tier to achieve better performance and the best SLA.

- Both VMs in the HA pair should be deployed in an availability set, or Availability Zones should be the same size and have the same storage configuration.

- Native database replication technology should be used to synchronize the database in a HA pair.

- One of the following services should be selected for running SAP central-services clusters on different operating systems:

  - [SUSE Linux Enterprise Server Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files): Supports up to three STONITH block devices (SBDs) or Azure Fence Agent.
  - [Red Hat Enterprise Linux Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-rhel-netapp-files): SBD isn't supported yet; only Azure Fence Agent is supported.
  - [Windows cluster](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk)
  - SAP-certified third-party cluster software

- You should set up the cluster timeout parameters recommended in the documentation for central-services and database clusters.

### Backup/restore

**Design Considerations for backup/restore:**

Though backup and restore aren't typically considered as adequate HA functionality for a production SAP workload, this technology covers various other areas. Most companies that use SAP applications need to follow compliance regulations that require backups to be stored for many years. There are also other conditions and scenarios where having a backup and being able to restore from it are essential. The assumption is that you're already establishing and following backup and restore best practices for deploying your SAP applications. This means that you can:

- Perform a point-in-time recovery for your production databases at any point and in a time frame that meets your RTO; point-in-time recovery typically includes operator errors deleting data either on the DBMS layer or through SAP, incidentally.

- Maintain a store where you keep your long-term backups to meet compliance regulations.

- Use database backups to clone an SAP system and restore those against another server/VM.

- Use production database data from database backups to refresh nonproduction systems.

- Back up SAP application servers/VMs, disks, or VM snapshots.

When you can do this on-premises, you need to bring these capabilities to SAP systems in Azure.

If you're satisfied with your current solution, check if your backup vendor supports Azure deployments or if they've set up a software as a service (SaaS) solution in Azure.

Azure offers a backup SaaS service, [Azure Backup](/azure/backup/backup-overview), which takes VM snapshots and manages streaming [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about) backups. If you're using [Azure NetApp Files](https://azure.microsoft.com/services/netapp/) to store your SAP HANA databases, you can perform backups based on HANA-consistent storage snapshots.

**Design Recommendations for Backup/Restore:**

- You can use Azure Backup to back up SAP application server and central-services VMs.

- An SAP HANA backup can be used for HANA deployments up to 8 TB. For more information, explore the support matrix for [backing up SAP HANA databases on Azure VMs](/azure/backup/sap-hana-backup-support-matrix).

- Test the backup and recovery times to verify if they meet your RTO.

- It isn't recommended to pull your backups from Azure into your on-premises backup infrastructure, especially with large databases. This option impacts how much bandwidth that ExpressRoute circuits consume.

### DR

**Design considerations for DR:**

The [Azure region map](https://azure.microsoft.com/global-infrastructure/geographies/) shows over 60 Azure regions, and not all of them run the same services. During larger SAP software deployments and especially the ones using SAP HANA, look for Azure regions that offer Azure [M-series](/azure/virtual-machines/m-series) and/or [Mv2-series](/azure/virtual-machines/mv2-series) VMs. Azure Storage also pairs different regions to replicate a smaller subset of storage types to another region. For more information, see [Overview of Azure paired regions](/azure/best-practices-availability-paired-regions).

The main challenges of pairing Azure regions for SAP workloads are:

- The pairs aren't always consistent with M-series or Mv2-series VM services. Many customers deploying their SAP systems aren't following Azure paired regions and are following the service availability of required VM families instead.

- Standard storage can be replicated between paired regions, but it can't store your databases or virtual hard disks. You're restricted to replicating backups only between paired regions that you use. For all the other data, perform your own replications with native DBMS features like SQL Server Always On, SAP HANA System Replication, and other services. Use a combination of Azure Site Recovery, `rsync`/`robocopy`, and other third-party software for the SAP application layer.

After defining Azure regions, your organization's second design decision should consider whether you're going to deploy production systems into your primary region, nonproduction SAP systems into the DR region, or if you're using an architecture that groups all SAP systems into the primary region so that the DR region is only used for DR regions. The current SAP customer deployment pattern shows most customers using both regions for SAP systems that are operating. Customers that traditionally run complete copies of their production systems as business regression test systems typically plan to use the SAP product line's business regression test system as a DR target.

Another important design factor for determining which of at least two Azure regions should be the DR region is if you have multiple Azure ExpressRoute circuits connecting to Azure. At least one ExpressRoute circuit should connect to the primary Azure region, and the other(s) should connect to the DR region. This type of architecture should connect you to the Azure network in a different geographic area and guard your connection if a catastrophe impactions another Azure region.

Some customers use a combination HA/DR architecture, which groups HA with DR in the same Azure region and isn't commonly recommended. [Azure Availability Zones](/azure/availability-zones/az-overview) support this architecture. Since the distance between Availability Zones within one Azure region isn't as large as the distance between two different Azure regions, a natural disaster could jeopardize this architecture in the region where it occurs. Customers choose this architecture because of:

- Sufficient compliance from configurations that support smaller distances between production deployment and a DR target
- Data sovereignty aspects
- Geopolitical factors

Another factor that you should consider when choosing your DR region is the RPO and RTO for failing over to the DR site. The further the distance between the production and DR regions, the larger the network latency. Though you would replicate asynchronously between different Azure regions, a smaller or larger network latency can impact the throughput you're able to replicate and the RPO target. You can often minimize your RPO by using HA/DR architecture but with potential higher risk from large-scale, natural disasters.

**Design recommendations for DR:**

- The CIDR for the primary virtual network (VNet) shouldn't conflict or overlap with the CIDR of the DR site's VNet.

- Set up ExpressRoute connections from on-premises to the primary and secondary Azure DR region.

- An alternative to using ExpressRoute is to set up VPN connections from on-premises to the primary and secondary Azure DR region.

- Use Site Recovery to replicate an application server to a DR site. Site Recovery can also help with replicating central-services cluster VMs to the DR site. When you invoke DR, you'll need to reconfigure the Linux Pacemaker cluster on the DR site (for example, replace the VIP or SBD, run `corosync.conf`, and more).

- Use [cross-region replication in Azure NetApp Files](/azure/azure-netapp-files/cross-region-replication-introduction) (currently in public preview) to synchronize file volumes between the primary region and the DR region.

- Native database replication should be used to synchronize data to the DR site, rather than Azure Site Recovery.

- Peer the primary and DR VNets. For example, for HANA System Replication, an SAP HANA DB VNet needs to be peered to the DR site's SAP HANA DB VNet.

- You should create two Azure NetApp Files accounts in two different regions at the Premium tier, at least, if you use Azure NetApp Files storage for your SAP deployments.
