---
title: Business continuity and disaster recovery for an SAP migration
description: Learn about business continuity and disaster recovery for SAP migrations.
author: pankajmeshramCSA
ms.author: pameshra
ms.date: 12/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Business continuity and disaster recovery for an SAP migration

This article builds on some of the considerations and recommendations that are defined in the [Azure landing zone design area for BCDR](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). The article can help you understand the unique constraints on any landing zone that supports an SAP platform. Because SAP is a mission-critical platform, you should also refer to the guidance presented in the Azure landing zone Design areas section of this documentation and incorporate it into your design.

## Scenario and scope

Your organization needs to design platform-level capabilities that can help application workloads meet their requirements. SAP applications that run an organization's most critical business processes require:

- Service and business process availability.
- Recovery time objectives (RTOs) for failure or disaster scenarios. For example, you might encounter a failure scenario that's limited to a component of the SAP system or a widespread failure that affects a datacenter or Azure region.
- Recovery point objectives (RPOs) for a failure scenario that's limited to a component of an SAP system or a widespread failure that affects a datacenter or an Azure region.
- Operational and lifecycle management tasks, with technology that fills gaps during failure scenarios. These management tasks include patching guest operating systems and database management systems, cloning, and refreshing the SAP systems.

Your architecture needs to incorporate principles that address on-premises business continuity and disaster recovery (BCDR) scenarios. These principles also apply on Azure. The main difference is that Azure might have more hardware capacity than your on-premises environment to compensate for a host failure. You can auto-recover even the largest Azure VMs by setting them up to restart on another server. Set up your Azure deployments to use the same conditions as your on-premises deployments. If you deployed on-premises systems or bare-metal hardware by using automatic failover cluster configurations, deploy them the same way on Azure.

> [!TIP]
> Agree on a high availability and disaster recovery (HADR) solution for each of the archetypes in your SAP landscape early on. Ensure that all SAP components are covered with an appropriate solution.
> 
> Configure HADR on Azure early, in least one landscape, and keep it running there. Doing so gives your teams the time and opportunity that's needed to acquire experience on the technologies that are involved, which might be different from existing technologies. Configuring HADR early can also help you develop and evolve your standard operating procedures (SOP).
> 
> Plan to have complete high availability, disaster recovery, and backup protection for production workloads as soon as the system is live.

This article covers the following aspects of BCDR for an enterprise-scale SAP scenario:

- High availability within an Azure region.
- Backup and restore considerations.
- Cross-regional versus regional disaster recovery decision criteria.

## High availability within an Azure region

The following sections provide design considerations and recommendations for high availability within an Azure region for an SAP enterprise scenario.

### Design considerations for high availability

For high availability, the focus is to provide availability for SAP software's single point of failure, such as:

- Database management systems.
- Single points of failure in the application, like SAP ABAP and ASCS + SCS. Examples include SAP NetWeaver and the SAP S/4HANA architecture.
- Other tools, like SAP Web Dispatcher.

For other scenarios, don't restrict availability to infrastructure or software failures. Apply availability to all necessary lifecycle management tasks, like patching the OS in the VMs, the DBMS, and the SAP software. To minimize outages that might happen during planned downtime and lifecycle management operations, use common tools that help protect your systems against unplanned service disruptions.

SAP and SAP databases support automatic failover clusters. In Windows, Windows Server Failover Clustering supports failover. In Linux, Linux Pacemaker or third-party tools like SIOS Protection Suite and Veritas InfoScale support failover. With Azure, you can deploy only a subset high-availability configuration in your own datacenter.

To learn more about how Azure supports SAP, see [Supported scenarios for SAP workloads on Azure VMs](/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [Supported scenarios for SAP HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-supported-scenario).

For the DBMS layer, the common architecture pattern is to replicate databases at the same time and with different storage stacks than the ones that the primary and secondary VMs use. Azure doesn't support architectures in which the primary and secondary VM share storage for DBMS data. Nor does Azure support transaction or redo logs. The guiding principle is to use two independent storage stacks, even if they're based on Network File System (NFS) shares. This approach is the main limitation when you compare what's possible on-premises with what's possible on Azure.

Azure provides other options because it supports either NFS or Server Message Block sharing. You can use [Azure shared disks](/azure/virtual-machines/disks-shared) in Windows for ASCS + SCS components and specific high-availability scenarios. Set up your failover clusters separately for SAP application layer components and the DBMS layer. Azure doesn't support high-availability architectures that combine SAP application layer components and the DBMS layer into one failover cluster.

Most failover clusters for SAP application layer components and the DBMS layer require a virtual IP address for a failover cluster. One common exception is when you use Oracle Data Guard. It doesn't require a virtual IP address. [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) should handle the virtual IP address for all other cases. One design principle is to use one load balancer per cluster configuration. We recommend that you use the standard version of the load balancer. For more information, see [Public endpoint connectivity for virtual machines using Azure Standard Load Balancer in SAP high-availability scenarios](/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

For more information and options, see [High-availability architecture and scenarios for SAP NetWeaver](/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios).

### Azure availability sets vs. availability zones

Before you deploy your high-availability infrastructure, and depending on the region you choose, determine whether to deploy with an [Azure availability set](/azure/virtual-machines/availability) or an availability zone. The main differences for VMs deployed with an availability set are:

- The VMs aren't spread across different availability zones.
- The type of VMs that you can deploy through a single availability set are restricted because the host is defined by the first VM that's deployed in the set. One example result is that you won't be able to combine M-series and E-series VMs into one availability set.

An advantage of deploying your high-availability architecture across different availability zones is that your service level agreement (SLA) for the VMs can be higher. For details, see [Azure VM SLAs](https://azure.microsoft.com/support/legal/sla/virtual-machines). Depending on the Azure region, you might discover different network latency conditions in network traffic between VMs. For more information, see [SAP workload configurations with Azure availability zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

If you choose a zonal deployment approach, consider the effects of cross-zone latency for the chosen Azure region, between application server and database and between the two database nodes, on performance and architecture design choices.

If you use an active/passive zonal deployment approach for the application server tier (application servers must connect to the database in the same availability zone), build automation and an SOP to enable quick and automated recovery if there's a database failover.

If you use availability zones in your SAP solution, design all other Azure services and infrastructure components in your SAP landscape for zone redundancy too so that you can achieve true zone redundancy. Examples of services and components to take into account are Azure ExpressRoute gateways, Azure Load Balancer, Azure Files, Azure NetApp Files, reverse proxy, firewalls, antivirus, and backup infrastructure.

### Design recommendations for high availability

- Azure provides several options to help you meet your application's infrastructure SLAs. You should choose the same option for all three SAP components: central services, application server, and database. For information about SLAs for VMs, availability sets, and availability zones, see [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9).

- When you deploy VMs in an availability set, the alignment with fault and update domains prevents the VMs from being on the same host hardware, which provides protection against hardware failure. When you deploy VMs via availability zones and use different zones, the VMs are created across different physical locations. This configuration provides additional protection from power, cooling, or networking issues that affect the datacenters of the zone as a whole. However, you can't deploy Azure availability sets within an Azure availability zone unless you use [proximity placement groups](/azure/virtual-machines/co-location). 

    If you choose a zonal deployment approach, the SAP DBMS, central services, and application layers run in different availability zones. However, each availability zone will most likely have multiple application servers. In this scenario, the application servers in each zone don't automatically benefit from fault domains and update domains. You can achieve those benefits by using availability sets as described in [Azure proximity placement groups for optimal network latency with SAP](/azure/virtual-machines/workloads/sap/sap-proximity-placement-scenarios).

- When you create availability sets, use the maximum number of fault domains and update domains available. For example, if you deploy more than two VMs in one availability set, use the maximum number of fault domains (three) and enough update domains to limit the effect of potential physical hardware failures, network outages, or power interruptions, in addition to Azure planned maintenance. The default number of fault domains is two, and you can't change it online later.

- In an availability set deployment, each component of an SAP system needs to be in its own availability set. SAP central services, the database, and application VMs should be in their own availability sets.

- When you use Azure proximity placement groups in an availability set deployment, all three SAP components (central services, application server, and database) should be in the same proximity placement group.

- Use one proximity placement group per SAP SID. Groups don't span across availability zones or Azure regions.

- When you use Azure proximity placement groups in an availability zones deployment, the two SAP components (central services and application server) should be in the same proximity placement group. The database VMs in the two zones are no longer a part of the proximity placement groups. The proximity placement groups per zone are scoped with the deployment of the VM that runs the SAP ASCS + SCS instances. The advantage of this configuration is that you have more flexibility in resizing VMs. It's also easier to move to new VM types in either the DBMS layer or the application layer of the SAP system.

- Azure doesn't currently support combining ASCS and database high availability in a single Linux Pacemaker cluster. Separate them into individual clusters. You can combine as many as five [multiple central services clusters](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-multi-sid) into a pair of VMs.

- Use a Standard Load Balancer SKU in front of ASCS and database clusters.
- Run all production systems on Premium managed SSDs and use Azure NetApp Files or Ultra Disk Storage. At least the OS disk should be on the Premium tier so you can achieve better performance and the best SLA.
- You should deploy both VMs in the high-availability pair in an availability set, or availability zones should be the same size and have the same storage configuration.
- Use native database replication technology to synchronize the database in a high-availability pair.
- Use one of the following services to run SAP central services clusters.

  - [SUSE Linux Enterprise Server Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files). Azure fence agent and as many as three STONITH block devices (SBDs) are supported.
  - [Red Hat Enterprise Linux Pacemaker cluster](/azure/virtual-machines/workloads/sap/high-availability-guide-rhel-netapp-files). SBD isn't currently supported. Only Azure fence agent is supported.
  - [Windows cluster](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk).
  - SAP-certified third-party cluster software.

- Set up the cluster timeout parameters as recommended in the documentation for central services and database clusters.


### Storage for SAP workloads

- Choosing the right storage options is a part of designing for resiliency for your SAP workload. The design for SAP workloads on Azure storage is intended to keep latency to a minimum and maximize throughput. Consider your implementation and how the following guidance can help you make architectural decisions for your SAP on Azure implementation. For information on the various types of storage and their usability with SAP workloads and components, see [Azure Storage types for SAP workloads](/azure/virtual-machines/workloads/sap/planning-guide-storage).

- SAP HANA on Azure should be run only on the types of storage that are certified by SAP. Note that you must run certain volumes on specific disk configurations, where applicable. These configurations can include enabling Write Accelerator and using Premium storage. You also need to ensure that the file system that runs on the storage type is compatible with the DBMS that runs on the machine. For more information, see [Storage configurations for SAP HANA](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage).

- Azure NetApp Files is one option for NFS shares when you run SAP workloads on Azure. Take into account the Azure NetApp Files throughput and sizing considerations. For more information, see [Azure NetApp Files for SAP virtual machines](/azure/virtual-machines/workloads/sap/hana-vm-operations-netapp).

## Backup and restore

The following sections describe design considerations and recommendations for backup and restore in an SAP scenario.

### Design considerations for backup and restore

Although backup and restore isn't typically considered an adequate high-availability solution for a production SAP workload, the technology provides other benefits. Most companies that use SAP applications need to follow compliance regulations that require the storage of backups for many years. It's also essential to have a backup and be able to restore from it in other scenarios. The assumption is that you've already established and are following backup and restore best practices for SAP applications, which means that you can:

- Perform a point-in-time recovery for your production databases at any point, in a time frame that meets your RTO. Point-in-time recovery typically provides protection from operator errors like deleting data, either on the DBMS layer or through SAP.

- Maintain a store to keep your long-term backups in order to meet compliance regulations.
- Use database backups to clone the SAP system and restore the backups against another server or VM.
- Use production database data from database backups to refresh nonproduction systems.
- Back up SAP application servers and VMs, disks, or VM snapshots.

When you back up and restore on-premises, you need to bring these capabilities to SAP systems in Azure.

If you're satisfied with your current solution, check whether your backup vendor supports Azure deployments or whether it has a software as a service (SaaS) solution for Azure.

Azure provides a backup SaaS service, [Azure Backup](/azure/backup/backup-overview), which takes VM snapshots and manages streaming [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about) backups. If you use [Azure NetApp Files](https://azure.microsoft.com/services/netapp) to store your SAP HANA databases, you can run backups based on HANA-consistent storage snapshots.

### Design recommendations for backup and restore

- You can use Azure Backup to back up SAP application server and central services VMs.

- You can use an SAP HANA backup for HANA deployments of up to 8 TB. For more information, see the support matrix for [backing up SAP HANA databases on Azure VMs](/azure/backup/sap-hana-backup-support-matrix).

- If you use an IaaS backup solution, size the backup infrastructure to ensure that it can back up all production-sized systems simultaneously or as in a real-life scenario, within expected time frames and by using a production setup or a similar setup in terms of networking, security, and so on.

- Test the backup and recovery times to verify that they meet your RTO requirements for restoring all systems simultaneously after a disaster.

- Ideally, avoid pulling your backups from Azure into your on-premises backup infrastructure, especially for large databases. Doing so affects how much bandwidth the ExpressRoute circuits use.

## Disaster recovery

The following sections describe design considerations and recommendations for disaster recovery in an SAP scenario. 

### Design considerations for disaster recovery

The [Azure region map](https://azure.microsoft.com/global-infrastructure/geographies) shows more than 60 Azure regions, and not all of them run the same services. In larger SAP software deployments, and especially those that use SAP HANA, look for Azure regions that offer Azure [M-series](/azure/virtual-machines/m-series) or [Mv2-series](/azure/virtual-machines/mv2-series) VMs. Azure Storage also pairs different regions to replicate a smaller subset of storage types to another region. For more information, see [Overview of Azure paired regions](/azure/best-practices-availability-paired-regions).

The main challenges of pairing Azure regions for SAP workloads are:

- The pairs aren't always consistent with M-series or Mv2-series VM services. Many organizations that deploy their SAP systems don't use Azure paired regions. Instead, they follow the service availability of required VM families.
- You can replicate standard storage between paired regions, but you can't use standard storage to store your databases or virtual hard disks. You can replicate backups only between paired regions that you use. For all your other data, run your own replication by using native DBMS features like SQL Server Always On or SAP HANA System Replication. Use a combination of Azure Site Recovery, `rsync` or `robocopy`, and other third-party software for the SAP application layer.

After you define your Azure regions, you need to choose a deployment pattern:

- Will you deploy production systems into your primary region?
- Will you deploy nonproduction SAP systems into the disaster recovery region?
- Will you use an architecture that groups all SAP systems into the primary region? This configuration ensures that the disaster recovery region is used only for disaster recovery.

Most organizations use both regions for operating SAP systems. Organizations that run complete copies of production systems as business-regression test systems typically plan to use the SAP product line's business-regression test system as a disaster recovery target.

Here's another important factor for determining which of at least two Azure regions should be the disaster recovery region: do you have multiple ExpressRoute circuits connecting to Azure? At least one ExpressRoute circuit must connect to the primary Azure region. The others should connect to the disaster recovery region. This type of architecture connects you to the Azure network in a different geographic area and helps guard your connection if a catastrophe affects another Azure region.

Some organizations use a combination high availability and disaster recovery architecture that groups high availability with disaster recovery in a single Azure region. [Azure availability zones](/azure/availability-zones/az-overview) support this architecture. But grouping high availability with disaster recovery isn't ideal.  Because the distance between availability zones within an Azure region isn't as large as the distance between two Azure regions, a natural disaster could jeopardize the architecture. An organization might use this architecture because of the following factors:

- Compliance is sufficient with configurations that support smaller distances between production deployment and a disaster recovery target.
- Data sovereignty.
- Geopolitical factors.

Another factor to consider when you choose your disaster recovery region is the RPO and RTO for failing over to the disaster recovery site. The greater the distance between the production and disaster recovery regions, the higher the network latency. Although you replicate asynchronously between Azure regions, network latency can affect the throughput you can replicate and the RPO target. You can often minimize your RPO by using a combined high availability and disaster recovery architecture. But this configuration poses a potentially higher risk from large-scale natural disasters.

### Design recommendations for disaster recovery

- Ensure that the classless inter-domain routing (CIDR) for the primary virtual network doesn't conflict or overlap with the CIDR of the disaster recovery site's virtual network.
- Set up ExpressRoute connections from on-premises to the primary and secondary Azure disaster recovery region.
  - An alternative to using ExpressRoute is to set up VPN connections from on-premises to the primary and secondary Azure disaster recovery region.
- Use Site Recovery to replicate an application server to a disaster recovery site. Site Recovery also helps with replicating central services cluster VMs to the disaster recovery site. When you invoke disaster recovery, you need to reconfigure the Linux Pacemaker cluster on the disaster recovery site. For example, you need to replace the VIP or SBD, run `corosync.conf`, and so on.
- Use [cross-region replication in Azure NetApp Files](/azure/azure-netapp-files/cross-region-replication-introduction) to synchronize file volumes between the primary region and the disaster recovery region.
- Use native database replication, rather than Site Recovery, to synchronize data to the disaster recovery site.
- Peer the primary and disaster recovery virtual networks. For example, for HANA System Replication, an SAP HANA DB virtual network needs to be peered to the disaster recovery site's SAP HANA DB virtual network.
- If you use Azure NetApp Files storage for your SAP deployments, at a minimum, create two Azure NetApp Files accounts in the Premium tier, in two different regions.

## Next steps

[Deployment options for SAP in Azure](eslz-platform-automation-and-devops.md)
