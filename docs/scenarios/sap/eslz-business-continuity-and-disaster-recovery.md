---
title: Enterprise-scale business continuity and disaster recovery for an SAP migration
description: Learn about enterprise-scale business continuity and disaster recovery for an SAP migration in the Microsoft Cloud Adoption Framework for Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale business continuity and disaster recovery for an SAP migration

Your organization or enterprise needs to design platform-level capabilities that help application workloads to meet their specific requirements. SAP applications running an organization's most critical business processes have the following requirements:

- Service/business process availability

- Recovery time objectives (RTOs) during failure or disaster scenarios; for example, a failure scenario limited to a component of an SAP system or a widespread failure affecting a datacenter or Azure region

- Recovery point objectives (RPOs) for a failure scenario limited to a component of an SAP system or a widespread failure affecting a datacenter or an Azure region

- Operational and lifecycle management tasks can require technology that fills in for failure scenarios. These management tasks include patching guest operating systems and database management systems, cloning, and refreshing SAP systems.

## Scenario and scope

Your architecture factors in many principles and tasks to address business continuity and disaster recovery (BCDR) scenarios on-premises, and these also apply in Azure. The main difference is that Azure might have more hardware capacity than your organization to compensate for a host failure. Even the largest Azure VMs can be service-healed by having them restart on another server. Aside from this, the same conditions apply as with on-premises. Systems that you deployed with automatic failover cluster configurations on-premises or on bare-metal hardware should also be deployed in Azure this way.

This article covers the following aspects of BCDR for an enterprise-scale SAP scenario:

- Cross-regional versus regional DR decision criteria
- High availability (HA) within an Azure region
- Backup/restore considerations
- HA considerations
- Compute and storage considerations

### Cross-regional vs. DR decision criteria

The [Azure region map](https://azure.microsoft.com/global-infrastructure/geographies/) shows over 60 Azure regions, and not all of them run the same services. During larger SAP software deployments and especially the ones using SAP HANA, look for Azure regions that offer Azure [M-series](/azure/virtual-machines/m-series) and/or [Mv2-series](/azure/virtual-machines/mv2-series) VMs. Azure Storage also pairs different regions to replicate a smaller subset of storage types to another region. For more information, see [Overview of Azure paired regions](/azure/best-practices-availability-paired-regions).

The main challenges of pairing Azure regions for SAP workloads are:

- The pairs aren't always consistent with M-series or Mv2-series VM services. Many customers deploying their SAP systems aren't following Azure paired regions and are following the service availability of required VM families instead.

- Standard storage can be replicated between paired regions, but it can't store your databases or virtual hard disks. You're restricted to replicating backups only between paired regions that you use. For all the other data, perform your own replications with native DBMS features like SQL Server Always On, SAP HANA System Replication, and other services. Use a combination of Azure Site Recovery, `rsync`/`robocopy`, and other third-party software for the SAP application layer.

After defining Azure regions, your organization's second design decision should consider whether you're going to deploy production systems into your primary region, nonproduction SAP systems into the DR region, or if you're using an architecture that groups all SAP systems into the primary region so that the DR region is only used for DR regions. The current SAP customer deployment pattern shows most customers using both regions for SAP systems that are operating. Customers that traditionally run complete copies of their production systems as business regression test systems typically plan to use the SAP product line's business regression test system as a DR target.

Another important design factor for determining which of at least two Azure regions should be the DR region is if you have multiple Azure ExpressRoute circuits connecting to Azure. At least one ExpressRoute circuit should connect to the primary Azure region, and the other(s) should connect to the DR region. This type of architecture should connect you to the Azure network in a different geographic area and guard your connection if a catastrophe impactions another Azure region.

Some customers use a combination HA/DR architecture, which groups HA and with DR within the same Azure region and isn't commonly recommended. [Azure Availability Zones](/azure/availability-zones/az-overview) support this architecture. Since the distance between Availability Zones within one Azure region isn't as large as the distance between two different Azure regions, a natural disaster could jeopardize this architecture in the region where it occurs. Customers choose this architecture because of:

- Sufficient compliance from configurations that support smaller distances between production deployment and a DR target
- Data sovereignty aspects
- Geopolitical factors

Another factor that you should consider when choosing your DR region is the RPO and RTO for failing over to the DR site. The further the distance between the production and DR regions, the larger the network latency. Though you would replicate asynchronously between different Azure regions, a smaller or larger network latency can impact the throughput you're able to replicate and the RPO target. You can often minimize your RPO by using HA/DR architecture but with potential higher risk from large-scale, natural disasters.

### HA within an Azure region

With HA, the focus is to provide availability for SAP software's single point of failure, such as with:

- Database management systems
- Single points of failure in the application, like with ABAP SAP ASCS/SCS (for example, with SAP NetWeaver and S/4HANA architecture).
- Other tools, like SAP Web Dispatcher.

For other scenarios, availability shouldn't be restricted to infrastructure or software failures and should include all necessary lifecycle management tasks, such as patching the OS in the VMs, the DBMS, or SAP software. To minimize outages that can happen during planned downtime and lifecycle management tasks, you can use common tools that protect against unplanned service disruptions.

SAP and SAP databases support automatic failover clusters. The Windows Server Failover Clustering feature achieves this in Windows, whereas Linux Pacemaker or third-party tools like SIOS Protection Suite or Veritas InfoScale are for Linux. With Azure, you can only deploy a subset HA configurations in your own datacenter.

Explore [SAP workload on Azure VM-supported scenarios](/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [supported scenarios for SAP HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-supported-scenario) to learn more about what Azure supports for SAP.

For the DBMS layer, the common architecture pattern is to replicate databases at the same time and with different storage stacks that the primary and secondary VMs are using. Azure doesn't support architectures where the primary and secondary VM share storage for DBMS data, nor does it support transaction/redo logs. The guiding principle is that there must two independent storage stacks, even if they're based on Network File System (NFS) shares, and this is the main limitation when compared to what's possible with on-premises.

Azure does present other options, as the service supports either NFS or Server Message Block sharing. [Azure shared disk](/azure/virtual-machines/disks-shared) can be used in Windows for ASCS/SCS components and specific HA scenarios. Failover clusters should be set up separately for SAP application layer components and the DBMS layer since Azure doesn't support HA architectures that combine SAP application layer components and the DBMS layer into one failover cluster.

Most failover clusters for SAP application layer components and the DBMS layer require a virtual IP address for a failover cluster. One common exception is with Oracle Data Guard, whose functionality doesn't require a virtual IP address. [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) should handle the virtual IP address for all other cases. As a design principle, use one Load Balancer per cluster configuration, the standard version of the load balancer is recommended. For more information, see [Public endpoint connectivity for virtual machines using Azure Standard Load Balancer in SAP high-availability scenarios](/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

Explore [high-availability architecture and scenarios for SAP NetWeaver](/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios) for more information and possibilities.

#### Azure availability sets vs. Availability Zones

Before you deploy your HA infrastructure and depending on the region you've chosen, decide whether you want to deploy through an [Azure availability set](/azure/virtual-machines/availability) or and Availability Zone. The main differences for VMs deployed with an availability set are that:

- The VMs aren't spread across different Availability Zones.

- The type of VMs that can be deployed through a single availability set are restricted since the host is defined by the first VM deployed in the set. One example result is that you won't be able to combine M-series and E-series VMs into one availability set.

One advantage of deploying your HA architecture across different Availability Zones is that your SLA for the VMs could be higher. For details, review [Azure VM SLAs](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/). Depending on the Azure region, you might discover different network latency conditions in network traffic between VMs. For details on SAP workload deployments across different Azure Availability Zones, read the article [SAP workload configurations with Azure Availability Zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

### Backup/restore considerations

Though backup and restore aren't typically considered as adequate HA functionality for a production SAP workload, this technology covers various other areas. Most companies that use SAP applications need to follow compliance regulations that require backups to be stored for many years. There are also other conditions and scenarios where having a backup and being able to restore from it are essential. The assumption is that you're already establishing and following backup and restore best practices for deploying your SAP applications. This means that you can:

- Perform a point-in-time recovery for your production databases at any point and in a time frame that meets your RTO; point-in-time recovery typically includes operator errors deleting data either on the DBMS layer or through SAP, incidentally.

- Maintain a store where you keep your long-term backups to meet compliance regulations.

- Use database backups to clone an SAP system and restore those against another server/VM.

- Use production database data from database backups to refresh nonproduction systems.

- Back up SAP application servers/VMs disks or VM snapshots.

When you can do this on-premises, you need to bring these capabilities to SAP systems in Azure. One solution that isn't recommended is to pull your backups from Azure into your on-premises backup infrastructure. In the past, especially with large databases, customers found this option to intrude on how much bandwidth that their ExpressRoute circuits consumed.

If you're satisfied with your current solution, check if your backup vendor supports Azure deployments or if they've set up a software as a service (SaaS) solution in Azure. If so, test the solution for backup and restore times. Some of the solutions might show fast backup times and throughput with Azure Blob Storage, but they might read from those blobs more slowly, also slowing restore times.

Azure offers a backup SaaS service, [Azure Backup](/azure/backup/backup-overview), which takes VM snapshots and manages streaming [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about) backups. If you're using [Azure NetApp Files](https://azure.microsoft.com/services/netapp/) to store your SAP HANA databases, you can perform backups based on HANA-consistent storage snapshots.

### HA considerations

**Design considerations for HA:**

Consider the following factors:

- You SAP systems could have various components like ASCS, an SAP Web Dispatcher or application, or database servers. Create a different availability set for SAP Web Dispatcher, application servers, SCS, or HANA.

> [!NOTE]
> This document describes single-SID deployment, but Azure also supports multi-SID-cluster deployments. A maximum of five SAP SIDs can be deployed in a Linux cluster running in Azure.

- When designing for HA, protect all single points of failure and designs for resilience. You can use Linux Pacemaker clustering for ASCS and database VMs.

- Keep the database and application layer on separate clusters.

- Optimize Azure NetApp Files for shared storage file systems.

**Design recommendations for HA:**

The following are best practices for your design:

- Do not mix servers with different roles in the same availability set. You should keep central-service VMs, database VMs, and application VMs in their own availability sets.

- Don't combine ASCS and the database in the same Pacemaker cluster; keep them in separate clusters.

- The primary application server instance can be installed on an ASCS cluster to optimize the cost.

- Redundant VMs should be behind in a load balancer.

- VMs must use premium SSD managed disks (including the OS disk) to comply with SLA guidelines for OS and data volumes. Use Azure NetApp Files for shared disks.

- Two Azure NetApp Files accounts should be created within two different regions and with at least a premium service level.

- Azure NetApp Files should be on a separate subnet; one subnet per virtual network (VNet) is allowed.

- Use the same subscription ID across the same landscape; multiple subscriptions could be supported in the future.

- Use Azure Backup to back up SAP application server VMs.

- Use Azure Backup for SAP HANA databases smaller or equal to 2 tebibytes (TiB). Azure Backup currently supports up to 2 TiB, but it doesn't currently support HSR. [This outline](/azure/backup/sap-hana-backup-support-matrix) lists updated Azure Backup restrictions.

- For a HANA database larger than 2 TiB, select a native a HANA database backup, and copy it to Azure Blob Storage requirements. Use [AzCopy](/azure/storage/common/storage-use-azcopy-v10) to copy the backup files to Blob Storage.

- Use Azure ExpressRoute to connect customer sites (on-premises) to primary and secondary (DR) Azure regions. You can also set up a VPN connection between customer sites (on-premises) to primary and secondary (DR) Azure regions.

- For SUSE Linux Enterprise Server (SLES), use either a STONITH Block Device (SBD) with up to three SBDs in different fencing devices or an Azure fence agent. Additional VMs aren't required. Refer to [SLES Pacemaker](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-pacemaker) if you plan to use Azure fence agents.

- Use an Azure fence agent for Red Hat Enterprise Linux.

- For ASCS clusters, use Azure Site Recovery to replicate cluster VMs to the DR site. When you invoke DR, you'll need to reconfigure the Pacemaker cluster on the DR site, such as replacing `VIP`, `corosync.conf`, and others.

- Use Azure Site Recovery to replicate application servers to the DR site. Do not use Azure Site Recovery to replicate database servers.

- Use database-native replication methods like an HSR database DR sync.

- For VNet applications requiring DR network access, make sure that the VNet is peered to the secondary (DR) region. For example, HSR replication will required an SAP HANA database VNet to be peered to the secondary site's SAP HANA database VNet.

- You can also [use VNet to ExpressRoute peering](/azure/expressroute/expressroute-howto-linkVNet-portal-resource-manager) or [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) instead of VNet peering.

- The primary VNet's classless inter-domain routing (CIDR) shouldn't conflict or overlap with the disaster site VNet's CIDR.

- The load balancer configuration should be in front of dual web dispatchers and ASCS and database nodes.

- Make sure that the Floating IP is enabled in the load balancer.

- To take advantage of Azure NetApp Files features like cross-region replication (in public preview), use a paired Azure NetApp Files region. Paired regions in Azure NetApp Files paired regions are different than standard Azure paired regions.

- You can also use the `rsync` utility to sync data from one region to another in Azure NetApp Files (one zone to another if using zonal deployment).

- For resource metadata to be stored in the DR region, deploy the DR resources in a resource group assigned to the same Azure region where DR resources are created. This allows changes to Azure DR resources if the Azure production region is down.

### Compute and storage considerations

**Design considerations for compute:**

![A diagram of Azure compute SKU options.](./media/bcdr-compute-options-1.png#lightbox)

*Figure 1: Azure compute SKU options.*

Consider the following compute options:

- Use a D-series SKU for SAP application servers; the D-series provides 1:4 for CPU memory-mapping. Consider the E-series for memory-intensive workloads.

- Use the most current generation of SKUs where possible, such as v3 or v4. For more information about the certified D-series SKU for an SAP deployment, see [SAP Note 1928533](https://launchpad.support.sap.com/#/notes/1928533).

- Use [E-series](/azure/virtual-machines/sizes-memory) or [M-series](/azure/virtual-machines/m-series) SKUs for SAP third-party databases (AnyDB). E-series and M-series SKUs are optimized for memory and provide a consistent CPU-to-memory ratio.

- Follow the design principle of scaling up, then out. Scale-out deployments can cost less than a scale-up configuration in some scenarios.

- Scale out for SAP application servers rather than scaling up.

- Use the E-series SKU for smaller and cost-constrained production and nonproduction deployments.

- Use input/output operations per second (IOPS) and VM SKU throughput limits for AnyDB production deployments.

**Design recommendations for compute:**

- Use an E-series SKU for SAP NetWeaver Application Server Java. An E-series VM has better memory than a D-series VM with same input, output, and throughput limits. Java application servers require a lot of memory, and the E-series VM provides better CPU memory-mapping. Use [Gen2 VM SKUs](/azure/virtual-machines/generation-2) whenever possible.

- Use an E-series SKU for AnyDB deployments. A database's performance increases with the size of its cache. The two main advantages of E-series SKUs over D-series SKUs are 1:8 memory mapping and constrained core options to help you save on database license costs without compromising input, output, and throughput limits.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the IOPS and throughput limits of the VM. For example, the P50 disk generates 7,500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a Standard_D8s_v3 VM that only supports 192 Mbps, it doesn't allow the P50 disk to maximize its throughput.

- Use an M-series SKU for a HANA production deployment. The M-series support 256 gigabytes to 12 TB of scaling up and 96 TB of scaling out. Visit the [SAP hardware directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html#categories=Microsoft%20Azure) for setup support.

- Ultra disks or Azure NetApp Files should be used for log volumes in production HANA deployments that use E-series SKUs. Azure NetApp Files should be used for log volumes and HANA data volumes.

- Use [HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-overview-architecture) for processing online transactions and scale-up deployments larger than 12 TB.

**Design considerations for storage:**

![A diagram of Azure Storage SKU options.](./media/bcdr-scalability-storage-sku.png#lightbox)

*Figure 2: Azure Storage SKU options.*

- Azure offers a range of storage options; consider the following for running SAP application servers:

  - Standard SSD managed disks
  - Premium SSD managed disks
  - Azure ultra disks
  - Azure NetApp Files

- Consider the following storage options for nonproduction database deployments:

  - Standard SSD managed disks
  - Premium SSD managed disks
  - Azure NetApp Files

- Considered the following storage options for SAP shared file systems, such as `sapmnt` and `trans`:

  - Azure shared disk on Azure premium storage (Windows deployments)
  - Azure NetApp Files (SMB and NFS)
  - Azure Files NFS 4.1 (preview)

- Storage option to be considered for database logs which require a lower latency of < 1 ms

  - Premium SSD managed disks with Write Accelerator enabled (only on M-series VMs)
  - Azure ultra disks
  - Azure NetApp Files (supported for HANA only)

- For a cost-constrained deployment, consider deploying preproduction or test systems on standard SSDs and convert to premium SSDs as needed during test cycles. For example, an E20 disk costs half as much as a P20.

- For cost-conscious deployments, consider:

  - [Disk bursting](/azure/virtual-machines/disk-bursting#disk-level-bursting) for nonproduction workloads

  - [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for HANA deployments

  - [Disk striping](/azure/virtual-machines/premium-storage-performance) instead of using one large disk. Refer back to [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for more information about stripe sizes.

  - [Azure Disk Encryption](/azure/security/fundamentals/azure-disk-encryption-vms-vmss) for data disks on SAP application servers

  - [Azure Storage encryption](/azure/storage/common/customer-managed-keys-overview?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json) with customer-managed keys for database disks

**Design Recommendations for storage:**

- For cost-constrained deployments, use standard SSD managed disks for SAP nonproduction or dev/test environments.

- Do not use infrastructure as a service NFS clusters for SAP shared file systems. Instead, use [Azure shared disks on premium storage](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk#options-for-shared-disk-in-azure-for-sap-workloads) for Windows deployments and [Azure NetApp Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files) or NFS on Azure Files for Linux deployments.

- Use Azure premium SSD managed disks for SAP application servers, such as `usr/sap` file systems.

- Azure premium managed storage must be used for the SAP global transport directory.

- The OS disk size should be at least 128 gigabytes (GB) (P10) in production deployments. Customer experiences show application logging and monitoring agents writing data to the OS disk and driving high input/output requirements; using a smaller disk throttles disk performance.

- For any database deployment, the [ReadOnly cache](/azure/virtual-machines/premium-storage-performance#disk-caching) must be enabled for data disks that contain database data files. The ReadOnly cache can only be enabled on disks smaller than 4,095 GB.

- Use only database-native encryption instead Azure Disk Encryption for database disks. For example, use Transparent Data Encryption (TDE) for Oracle or SQL Server.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the IOPS and throughput limits of the VM. For example, the P50 disk gives 7500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a Standard_D8s_v3 VM that only supports 192 Mbps, the P50 disk cannot maximize its throughput.
