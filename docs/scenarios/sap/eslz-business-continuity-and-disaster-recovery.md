---
title: Business continuity and disaster recovery for an SAP migration
description: Learn how to incorporate principles that address business continuity and disaster recovery (BCDR) for SAP migrations on Azure.
author: PmeshramPM
ms.author: pameshra
ms.date: 08/13/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

<!-- docutune:ignore DB -->

# Business continuity and disaster recovery for an SAP migration

This article builds on the considerations and recommendations in the [Azure landing zone design area for BCDR](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). That article describes unique constraints on landing zones that support an SAP platform. SAP is a mission-critical platform, so you should also incorporate other [mission-critical guidance](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-landing-zone#key-design-strategies) into your design.

## Scenario and scope

Incorporate principles into your architecture that address on-premises business continuity and disaster recovery (BCDR) scenarios. These principles also apply on Azure. But Azure might have more hardware capacity than your on-premises environment to compensate for a host failure. To automatically recover even the largest Azure virtual machines (VMs), you can configure them to restart on another server. Set up your Azure deployments to use the same conditions as your on-premises deployments. If you use automatic failover cluster configurations to deploy on-premises systems or bare-metal hardware, deploy them the same way on Azure. SAP applications that run your organization's most critical business processes require:
- Service and business process availability.

- Recovery time objectives (RTOs) for failure scenarios or disaster scenarios. 
- Recovery point objectives (RPOs) for failure scenarios. 
- Operational and lifecycle management tasks, and technology that runs during failure scenarios. These management tasks include patching guest operating systems and database management systems, cloning, and refreshing SAP systems.

> [!TIP]
> Determine a high availability and disaster recovery (HADR) solution for each of the archetypes in your SAP landscape early on. Ensure that the solution covers all SAP components.
> 
> Configure an HADR solution on Azure early, in least one landscape, and keep it active. Then your teams can get experience with the solution's technologies, which might differ from existing technologies. Configure HADR early to help develop and evolve your standard operating procedures (SOPs).
> 
> Plan to have complete high availability, disaster recovery, and backup protection for production workloads as soon as the system is live.

This article covers the following aspects of BCDR for an enterprise-scale SAP scenario:

- High availability within an Azure region

- Backup and restore considerations
- Criteria to decide between cross-regional and regional disaster recovery

## High availability within an Azure region

The following sections provide design considerations and recommendations for high availability within an Azure region for an SAP enterprise scenario.

### Design considerations for high availability

When you implement high availability, the goal is to provide availability for SAP software's single point of failure, such as:

- Database management systems.

- Single points of failure in an application, like SAP Advanced Business Application Programming (ABAP), ABAP SAP Central Services (ASCS), and SAP Central Services (SCS). High availability examples include SAP NetWeaver and the SAP S/4HANA architecture.
- Other tools, like SAP Web Dispatcher.

For other scenarios, don't restrict availability to infrastructure failures or software failures. Apply availability to all necessary lifecycle management tasks. For example, you can patch the OS in the VMs, the database management system (DBMS), and the SAP software. To minimize outages that might happen during planned downtime and lifecycle management operations, use common tools that help protect your systems against unplanned service disruptions.

SAP and SAP databases support automatic failover clusters. In Windows, the Windows Server 2022 failover clustering feature supports failover. In Linux, Linux Pacemaker or partner tools like SIOS Protection Suite and Veritas InfoScale support failover. In Azure, you can deploy only a subset high availability configuration in your own datacenter.

For more information, see [Supported scenarios for SAP workloads on Azure VMs](/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [Supported scenarios for SAP HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-supported-scenario).

For the DBMS layer, the common architecture pattern is to replicate databases at the same time and with different storage stacks than the ones that the primary VMs and secondary VMs use. Azure doesn't support architectures in which the primary VMs and secondary VMs share storage for DBMS data. Azure also doesn't support transaction logs or redo logs. The guiding principle is to use two independent storage stacks, even if they're based on Network File System (NFS) shares. These limitations are exclusive to Azure solutions and not on-premises solutions.

Azure provides other options because it supports NFS and Server Message Block sharing. You can use [Azure shared disks](/azure/virtual-machines/disks-shared) in Windows for ASCS and SCS components and specific high availability scenarios. Set up your failover clusters separately for SAP application-layer components and the DBMS layer. Azure doesn't support high availability architectures that combine SAP application-layer components and the DBMS layer into one failover cluster.

Most failover clusters for SAP application-layer components and the DBMS layer require a virtual IP address for a failover cluster. A common exception is when you use Oracle Data Guard, which doesn't require a virtual IP address. [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) should handle the virtual IP address for all other cases. You can use one load balancer for each cluster configuration. We recommend that you use the standard version of the load balancer. For more information, see [Public endpoint connectivity for VMs by using Standard Azure Load Balancer in SAP high availability scenarios](/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

For more information, see [high availability architecture and scenarios for SAP NetWeaver](/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios).

The following table shows the platform-level service-level agreements (SLAs) for various high availability deployment options. The partners that provide the managed services also provide the application-level SLA.

| Tier | High availability scenario | Platform SLA |
|---|---|---|
| 1 | Availability zone | 99.99% |
| 2 | Availability set | 99.95% |
| 3 | Single VM (self-healing) | 99.90% |

### Azure availability sets vs. availability zones

Before you deploy your high availability infrastructure, determine whether to deploy with an [Azure availability set or an availability zone](/azure/virtual-machines/availability) depending on the region that you choose. The main differences for VMs that you deploy with an availability set are:

- The VMs aren't spread across different availability zones.

- The type of VMs that you can deploy through a single availability set are restricted because the first VM that you deploy in the set defines the host. For example, you can't combine M-series VMs and E-series VMs into one availability set.

When you deploy your high availability architecture across different availability zones, you can have a higher SLA for the VMs. For more information, see [Azure VM SLAs](https://azure.microsoft.com/support/legal/sla/virtual-machines). Depending on the Azure region, you might discover different network latency conditions in network traffic between VMs. For more information, see [SAP workload configurations with Azure availability zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

If you choose a zonal deployment approach, consider how cross-zone latency for the chosen Azure region might affect performance and architecture design choices. Consider the latency between the application server and the database and between the two database nodes.

If you use an active/passive zonal deployment for the application server tier in which application servers must connect to the database in the same availability zone, configure automation and create an SOP to enable quick and automated recovery if a database failover occurs.

If you use availability zones in your SAP solution, design all other Azure services and infrastructure components in your SAP landscape for zone redundancy too so that you can achieve true zone redundancy. Examples of services and components to take into account include Azure ExpressRoute gateways, Load Balancer, Azure Files, Azure NetApp Files, reverse proxies, firewalls, antivirus services, and backup infrastructure.

### Design recommendations for high availability

- Azure provides several options to help you meet your application's infrastructure SLAs. You should choose the same option for all three SAP components: central services, the application server, and the database. For more information about SLAs for VMs, availability sets, and availability zones, see [SLAs for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

- When you deploy VMs in an availability set, the alignment with fault and update domains prevents the VMs from being on the same host hardware, which provides protection against hardware failure. When you deploy VMs via availability zones and use different zones, you create the VMs across different physical locations. This configuration provides extra protection against power, cooling, or networking problems that affect the datacenters of the zone as a whole. But you can't deploy Azure availability sets within an Azure availability zone unless you use [proximity placement groups](/azure/virtual-machines/co-location). 

    If you choose a zonal deployment approach, the SAP DBMS, central services, and application layers run in different availability zones. But each availability zone most likely has multiple application servers. In this scenario, the application servers in each zone don't automatically benefit from fault domains and update domains. You can use availability sets to get those benefits. For more information, see [Azure proximity placement groups for optimal network latency with SAP](/azure/virtual-machines/workloads/sap/sap-proximity-placement-scenarios).

- When you create availability sets, use the maximum number of fault domains and update domains available. For example, if you deploy more than two VMs in one availability set, use the maximum number of fault domains (three). And use enough update domains to limit the effect of potential physical hardware failures, network outages, or power interruptions, in addition to Azure planned maintenance. The default number of fault domains is two, and you can't change it online later.

- In an availability set deployment, each component of an SAP system needs to be in its own availability set. SAP central services, the database, and application VMs should be in their own availability sets.

- When you use Azure proximity placement groups in an availability set deployment, ensure that all three SAP components (central services, the application server, and the database) are in the same proximity placement group.

- If you use proximity placement groups, use one for each SAP System Identification (SID). Groups don't span across availability zones or Azure regions.

- When you use Azure proximity placement groups in an availability zones deployment, ensure that the two SAP components (central services and the application server) are in the same proximity placement group. The database VMs in the two zones are no longer a part of the proximity placement groups. The proximity placement groups for each zone are scoped with the deployment of the VM that runs the SAP ASCS and SCS instances. The advantage of this configuration is that you have more flexibility to resize VMs. You can also easily switch to new VM types in either the DBMS layer or the application layer of the SAP system.

- Azure doesn't support combining ASCS and database high availability in a single Linux Pacemaker cluster. Separate them into individual clusters. You can combine as many as five [multiple central services clusters](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-multi-sid) in a pair of VMs.

- Use Standard Load Balancer in front of ASCS and database clusters.
- Run all production systems on Azure Premium SSDs, and use Azure NetApp Files or Azure Ultra Disk Storage. At a minimum, ensure that the OS disk is on the Premium tier so that you can improve performance and get the best SLA.
- Deploy both VMs in the high availability pair in an availability set or in availability zones. Ensure that these VMs are the same size and have the same storage configuration.
- Use native database replication technology to synchronize the database in a high availability pair.
- Use one of the following services to run SAP central services clusters, depending on the OS:

  - A [SUSE Linux Enterprise Server Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files) supports an Azure fence agent and as many as three node isolation devices.

  - A [Red Hat Enterprise Linux Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-rhel-netapp-files) supports an Azure fence agent and doesn't support node isolation devices.
  - A [Windows cluster](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk).
  - SAP-certified non-Microsoft cluster software.

- Set up the cluster timeout parameters as recommended in the documentation for central services and database clusters.

### Storage for SAP workloads

- Choose the right storage options when you design for resiliency in your SAP workload. Proper Azure storage design for SAP workloads can minimize latency and maximize throughput. Consider your implementation and how the following guidance can help you make architectural decisions for your SAP on Azure implementation. For more information, see [Azure storage types for SAP workloads](/azure/virtual-machines/workloads/sap/planning-guide-storage).

- You should run SAP HANA on Azure only on SAP-certified types of storage. You must run certain volumes on certain disk configurations. For example, configurations might enable Write Accelerator or use Premium SSD storage. You also need to ensure that the file system that runs on storage is compatible with the DBMS that runs on the machine. For more information, see [Storage configurations for SAP HANA](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage).

- In addition to Azure managed data disks that are attached to VMs, various Azure-native shared storage solutions run SAP applications on Azure. Your high availability configuration might differ because Azure Site Recovery doesn't support some storage services that are available on Azure. Use the following storage types for SAP workloads.

  |Storage type|High availability configuration support|
  | :------------------------------ | :------------------------------------------- |
  | Azure shared disks (locally redundant storage (LRS) or zone-redundant storage (ZRS))  | Windows Server 2022 failover cluster. For configuration details, see [Design SAP high availability with Windows Server 2022 failover clustering](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk). | 
  | NFS on Azure Files (LRS or ZRS) | Pacemaker-based cluster on Linux environments. Be sure to check the [availability of NFS in various regions](https://azure.microsoft.com/global-infrastructure/services/). |
  | NFS on Azure NetApp Files       | Pacemaker-based cluster on Linux environments. For more information, see [Azure NetApp Files for SAP VMs](/azure/virtual-machines/workloads/sap/hana-vm-operations-netapp).  |
  | SMB on Azure Files (LRS or ZRS) | Windows Server 2022 failover cluster. For configuration details, see [Install high availability SAP NetWeaver with Azure Files SMB](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-azure-files-smb).  |
  | SMB on Azure NetApp Files       | Windows Server 2022 failover cluster. For configuration details, see [High availability for SAP NetWeaver with Azure NetApp Files (SMB) for SAP applications](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-netapp-files-smb). |

- Instead of Azure-native shared storage services, you can use traditional NFS clusters (based on Distributed Replicated Block Device replication), GlusterFS, or a cluster shared volume with Storage Spaces Direct as an alternative shared storage solution to run SAP workloads on Azure. These choices are especially useful when Azure-native shared storage services are either not available in the targeted Azure region or don't support the target architecture. For more information about storage service availability, see [Azure products by region](https://azure.microsoft.com/global-infrastructure/services/).
- For information about storage options that are available for SAP workloads on Azure, see [Storage recommendations and guidelines to set up disaster recovery](/azure/virtual-machines/workloads/sap/disaster-recovery-overview-guide#storage). 

## Backup and restore

The following sections describe design considerations and recommendations for backup and restore in an SAP scenario.

Although backup and restore isn't typically considered an adequate high availability solution for a production SAP workload, the technology provides other benefits. Most companies that use SAP applications need to follow compliance regulations that require long-term storage of backups. In other scenarios, you also need to have a backup that you can restore from. This guidance assumes that you already established backup and restore and follow best practices for SAP applications, which means that you can:

- Perform a point-in-time recovery for your production databases at any point, in a time frame that meets your RTO. Point-in-time recovery typically provides protection from operator errors like deleting data, either on the DBMS layer or through SAP.

- Maintain a store to keep your long-term backups in order to meet compliance regulations.
- Use database backups to clone the SAP system and restore the backups against another server or VM.
- Use production database data from database backups to refresh nonproduction systems.
- Back up SAP application servers and VMs, disks, or VM snapshots.
- Back up an SAP HANA system with replication enabled.
- Back up SAP HANA database instance snapshots.
- Back up SAP ASE (Sybase) database.

If you back up and restore on-premises, you need to bring these capabilities to SAP systems in Azure. If you like your current solution, check whether your backup vendor supports Azure deployments or whether it has a software as a service (SaaS) solution for Azure.

Azure provides a backup SaaS service called [Azure Backup](/azure/backup/backup-overview), which takes VM snapshots and manages streaming [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about) backups. If you use [Azure NetApp Files](https://azure.microsoft.com/services/netapp) to store your SAP HANA databases, you can run backups based on HANA-consistent storage snapshots. 

You can also use Azure Backup to back up databases that have SAP HANA system replication (HSR) enabled. Azure Backup automatically manages backups when a failover occurs and eliminates the need for manual intervention. Backup also provides:

- Immediate protection with no remedial full backups, so you can protect HANA instances or HSR setup nodes as a single HSR container. 

- The benefit of instant backup and instant restore. 
- A HANA-consistent, snapshot-based approach that integrates with Backint for SAP HANA. You can use Backup as a single product for your entire HANA landscape and for any database size.  

For more information, see [SAP HANA database system with replication enabled](/azure/backup/sap-hana-database-about#back-up-a-hana-system-with-replication-enabled) and [SAP HANA instance snapshot backup](/azure/backup/sap-hana-database-about#back-up-database-instance-snapshots).

Azure Backup also supports SAP ASE (Sybase) database backups on Azure VMs, ensuring secure storage with [Immutability](/azure/backup/backup-azure-immutable-vault-concept?), [Soft Delete](/azure/backup/backup-azure-security-feature-cloud), [Multi-user Authorization](/azure/backup/multi-user-authorization-concept), and [CMK](/azure/backup/encryption-at-rest-with-cmk) in a managed vault. Data is isolated for protection, with 15-minute log backups enabling Point-In-Time recovery. Restore options include Alternate Location, Original Location, or as Files. Cost-effective policies optimize storage, while [Multi-SID](/azure/backup/sap-ase-backup-support-matrix#support-for-multiple-sap-ase-instances-on-a-single-host) and [Cross Subscription Restore](/azure/backup/sap-ase-database-about#cross-subscription-restore-for-sap-ase-sybase-database) enhance flexibility. Learn about [SAP ASE (Sybase) database backup](/azure/backup/sap-ase-database-about).

Moreover, Azure Business Continuity Center enables [protection](/azure/backup/sap-ase-database-backup-tutorial), [monitoring](/azure/business-continuity-center/tutorial-monitor-operate), and [alert configuration](/azure/business-continuity-center/tutorial-monitor-alerts-metrics) for SAP ASE backups. Learn about [Azure Business Continuity Center](/azure/business-continuity-center/business-continuity-center-overview).

### Design recommendations for backup and restore

- You can use Azure Backup to back up the SAP application server and central services VMs.

- You can use an SAP HANA backup for HANA deployments that are up to 8 TB. For more information, see [Support matrix for backup of SAP HANA databases on Azure VMs](/azure/backup/sap-hana-backup-support-matrix).

- If you use an infrastructure as a service backup solution, size the backup infrastructure to ensure that it can back up all production-sized systems simultaneously or, like in a real-life scenario, within expected time frames. Use a production setup or a similar setup for areas like networking and security.

- Test the backup and recovery times to verify that they meet your RTO requirements to restore all systems simultaneously after a disaster.

- Ideally, avoid pulling your backups from Azure into your on-premises backup infrastructure, especially for large databases. This approach can affect how much bandwidth the ExpressRoute circuits use.

- Load test the backup and recovery tools as part of the performance test plan.

## Disaster recovery

The following sections describe design considerations and recommendations for disaster recovery in an SAP scenario. 

### Design considerations for disaster recovery

The [Azure region map](https://azure.microsoft.com/global-infrastructure/geographies/) includes more than 65 Azure regions, and not all of them run the same services. For larger SAP software deployments, especially those that use SAP HANA, look for Azure regions that offer Azure [M-series VMs](/azure/virtual-machines/m-series) or [Mv2-series VMs](/azure/virtual-machines/mv2-series). Azure Storage also pairs different regions to replicate a smaller subset of storage types to another region. For more information, see [Overview of Azure paired regions](/azure/best-practices-availability-paired-regions).

The main challenges of pairing Azure regions for SAP workloads are:

- The pairs aren't always consistent with M-series or Mv2-series VM services. Many organizations that deploy their SAP systems don't use Azure paired regions. Instead, they choose regions based on the availability of required VM types.
- You can replicate standard storage between paired regions, but you can't use standard storage to store your databases or virtual hard disks. You can replicate backups only between paired regions that you use. For all other data, run your replication by using native DBMS features like SQL Server Always On or SAP HANA system replication. Use a combination of Site Recovery, tools like `rsync` or `robocopy`, and other non-Microsoft software for the SAP application layer.

- If a disaster occurs, multiple affected customers in an Azure region fail over to the corresponding paired disaster recovery region. This situation leads to competition of resources to bring up dormant VMs in the disaster recovery region. The workaround is to run nonproduction systems in the disaster recovery region and use the same resources to host disaster recovery replicas of production systems. This dual-purpose use of Azure infrastructures in the disaster recovery region helps you avoid resource capacity constraints.

Another important consideration is to secure the required operating capacity in the disaster region. If a disaster occurs, you might need to run the SAP application for a minimal window of time with minimal IT capacity and by critical human resources only while you work to recover normal operation in the primary region. This strategy requires that you have minimal IT infrastructure available in the disaster recovery region.  

After you define your Azure regions, you need to choose a deployment pattern:

- Will you deploy production systems into your primary region?

- Will you deploy nonproduction SAP systems into the disaster recovery region?
- Will you use an architecture that groups all SAP systems into the primary region? This configuration ensures that the disaster recovery region is used only for disaster recovery.

Most organizations use both regions for operating SAP systems. Organizations that run complete copies of production systems as business-regression test systems typically plan to use the SAP product line's business-regression test system as a disaster recovery target.

When you choose a disaster recovery region, be sure to have ExpressRoute connectivity to that region. If you have multiple ExpressRoute circuits connecting to Azure, at least one of those circuits must connect to the primary Azure region. The others should connect to the disaster recovery region. This type of architecture connects you to the Azure network in a different geographic or geopolitical area and helps protect your connection if a catastrophe affects one of the Azure regions.

Some organizations use a combination high availability and disaster recovery architecture, which groups high availability with disaster recovery in the same Azure region. But grouping high availability with disaster recovery isn't ideal. [Azure availability zones](/azure/reliability/availability-zones-overview) support this architecture. The distance between availability zones within one Azure region isn't as large as the distance between two Azure regions, so a natural disaster could jeopardize the application services in the region where it occurs. You also need to consider the latency between SAP application servers and database servers. According to [SAP note 1100926](https://launchpad.support.sap.com/#/notes/1100926), a roundtrip time of less than or equal to 0.3 ms is a good value, and a time of less than or equal to 0.7 ms is a moderate value. So for zones with high latencies, have operational procedures to ensure that SAP application servers and database servers always run in the same zone. Organizations choose this architecture for the following reasons:

- Compliance is sufficient with configurations that support smaller distances between production deployment and a disaster recovery target.

- Data sovereignty is a factor.
- Geopolitical factors are involved.
- It's a low-cost option that supports zonal failures, sometimes combined with backup transfer to the secondary region for natural catastrophes that affect a large radius.

Another factor to consider when you choose your disaster recovery region is the RPO and RTO for failing over to the disaster recovery site. The greater the distance between the production region and disaster recovery regions, the higher the network latency. You replicate asynchronously between Azure regions, but network latency can affect the throughput that you can replicate and the RPO target. To minimize your RPO, you can use a combined high availability and disaster recovery architecture. But this configuration poses a potentially higher risk from large-scale natural disasters.

### Design recommendations for disaster recovery

- Ensure that the classless inter-domain routing (CIDR) for the primary virtual network doesn't conflict or overlap with the CIDR of the disaster recovery site's virtual network.

- Set up ExpressRoute connections from on-premises to the primary and secondary Azure disaster recovery regions.
- Consider setting up VPN connections from on-premises to the primary and secondary Azure disaster recovery regions. Use this method as an alternative to using ExpressRoute.
- Use Site Recovery to replicate an application server to a disaster recovery site. Site Recovery can also help you replicate central services cluster VMs to the disaster recovery site. When you invoke disaster recovery, you need to reconfigure the Linux Pacemaker cluster on the disaster recovery site. For example, you might need to replace the virtual IP address or SBD or run corosync.conf.
- Replicate key vault contents like certificates, secrets, or keys across regions so that you can decrypt data in the disaster recovery region.
- Use [cross-region replication in Azure NetApp Files](/azure/azure-netapp-files/cross-region-replication-introduction) to synchronize file volumes between the primary region and the disaster recovery region.
- Use native database replication, rather than Site Recovery, to synchronize data to the disaster recovery site.
- Peer the primary and disaster recovery virtual networks. For example, for HANA system replication, you need to peer an SAP HANA DB virtual network needs to the disaster recovery site's SAP HANA DB virtual network.
- If you use Azure NetApp Files storage for your SAP deployments, at a minimum, create two Azure NetApp Files accounts in the Premium tier, in two regions.
- Consider grouping systems based on their business importance and proximity dependency based on application performance. To minimize the business effect of a regional outage, deploy each group to a separate region in a paired region construct. For example, to minimize the effect of a regional outage, you can deploy two critical ERP Central Component systems that serve two different business units, in UK South and UK West.

## Next step

[Deployment options for SAP in Azure](eslz-platform-automation-and-devops.md)
