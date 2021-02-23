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

<!-- docutune:casing "Large Instances" -->

# Business continuity and disaster recovery for an SAP enterprise-scale migration

Your organization or enterprise needs to design suitable platform-level capabilities that application workloads can consume to meet their specific requirements. SAP workloads typically run your most critical business processes and have requirements such as:

- Service/business process availability.
- In case of a failure or disaster scenario, recovery time objectives (RTO) for a failure case limited to a component of a SAP system and the case of a widespread failure scenario affecting a datacenter or a region of Azure.
- Recovery point objectives (RPO) for a failure case limited to a component of a SAP system and the case of a widespread failure scenario affecting a datacenter or a region of Azure.
- Often forgotten, but even more likely to be used, operational and lifecycle management tasks that can require technologies usually used to compensate for failure scenarios. These operations include guest OS patching, DBMS patching, cloning, or refreshing of SAP systems.

## Scenario and scope

As you approach the BCDR scenarios that need to be covered by your architecture, we can state that most of the principles and tasks you have on-premises apply in Azure as well. The main difference is that there is likely more hardware capacity in Azure to compensate for a host failure in Azure than you might have at home. So even for the largest Azure VMs, services can be healed by restarting them on another server. That aside, the same rules apply as on-premises. Systems deployed with automatic failover cluster configurations on-premises or on bare-metal hardware should be deployed in Azure with such functionality as well.

As we go through this article, we work our way from top to the bottom by covering these aspects of BCDR:

- Cross-regional or regional disaster recovery
- High availability within an Azure region
- Backup/restore considerations
- Selection of VM and storage components with best high availability

### Cross-regional or disaster recovery

Azure has over 60 Azure regions as you can see in the [Azure region map](https://azure.microsoft.com/global-infrastructure/geographies/). Not all regions are running the same services. Looking at larger SAP software deployments, especially the ones using SAP HANA, you need to look for Azure regions that offer Azure [M-series VMs](/azure/virtual-machines/m-series) and/or [Mv2-series VMs](/azure/virtual-machines/mv2-series). Azure Storage also has pairing between different regions that allow Azure Storage to replicate a smaller subset of storage types to such another region. The mapping can be found [here](/azure/best-practices-availability-paired-regions). The principle problem around the Azure region pairing for SAP workload is:

- In quite some cases, the pairs are not consistent with m/mv2 VM services. Therefore we are observing many customers deploying their SAP systems **not** following our paired regions, but following service availability of the required VM families.
- The storage type that can be replicated between the region pairs is Azure standard storage that can't be used as storage for your databases, or-based VHDs. So, you are restricted to e.g. Having backups replicated between paired region that you use. For all the other data, you need to provide your own replications, which in the database space is usually native DBMS functionality, like SQL Server Always On, HANA System Replication, and so on. And for the SAP application layer, a mixture of Azure Site Recovery, rsync/robocopy, or other third-party software.

As you defined the Azure regions, the second big design decision circles around the question whether you are going to deploy production systems into your primary region and non-production SAP systems into the 'DR region'. Or are you going with an architecture that puts all SAP systems into the primary region, so, that the DR region is only used for DR regions. Looking at the current SAP customer deployment pattern, one can state that most customers use both regions for SAP systems that are in operations. Customers that traditionally run complete copies of their production systems as business regression test systems, are usually planning for using the business regression test system of the specific SAP product line as DR target.

An important design criteria when using at least two Azure regions of which should be the disaster recovery region is that you need to have multiple ExpressRoute circuits connecting to Azure. The minimum should be one ExpressRoute circuit to the primary Azure region and the other ExpressRoute circuit should go to the disaster recovery region. Such an architecture should give you a second entry point into the Azure network in a different area or geography. So, that a catastrophe that impacts one Azure regions does not cut your connectivity into Azure.

Though not necessarily recommended, but used by quite a few customers, is an architecture that we call a combined HA/DR architecture. Such an architecture combines the high availability within an Azure region with disaster recovery within the same region. The underlying Azure construct used are [Azure Availability Zones](/azure/availability-zones/az-overview). The distance of different Availability Zones within one Azure region is by far not as large as the distance between two different Azure regions. Huge regional natural catastrophes could jeopardize such an architecture eventually. Reasons for customers choosing such an option can be:

- Compliance rules sufficient with such a configuration of smaller distance between production deployment and disaster recovery target
- Data sovereignty aspects
- Geopolitical considerations

Another aspect you need to consider choosing your DR region is e.g. RPO and RTO for the specific case of failing over to the DR site. The further the distance between the production region and DR region, the larger the network latency. Though you would replicate asynchronously between different Azure regions, a smaller or larger network latency can have impact on the throughput you are able to replicate and with that on the RPO target. Using the combined HA/DR architecture, you are often able to minimize your RPO. But at the costs of a higher risk to be affected by large scale natural disasters.

### High availability within an Azure region

Thinking of high availability, you are mainly looking into providing availability for the single point of failures of SAP software that can be listed like:

- DBMS
- Single point of failure in the application, like ASCS/SCS as with the SAP NetWeaver and S/4HANA architecture
- Eventually other components, like SAP Web Dispatcher

In all those cases, the discussion of availability should not be restricted on the case of infrastructure or software failures, but need to include all the lifecycle management tasks that you need to perform, like patching the OS in the VMs. Patching of the DBMS or SAP software. Common technology used for protecting against larger unplanned service disruption can be used for minimizing the outages due to planned downtime and lifecycle management tasks.

Common technologies that SAP and SAP supported DBMS provider support are automatic failover clusters. In the case of Windows, this is the Windows failover cluster server functionality. In the case of Linux, this is Linux Pacemaker or third-party products like SIOS Protection Suite for Linux or Veritas Infoscale. Keep in mind that only a subset of the scenarios you can deploy as high availability configurations in your own datacenter are supported in Azure as well.

What is supported, what is not supported? Check the articles [SAP workload on Azure virtual machine supported scenarios](/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [supported scenarios for HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-supported-scenario) for scenarios that are supported.

For the DBMS layer the common architecture pattern is to use synchronous DBMS replication functionality in combination with different storage stacks the two VMs (primary/secondary) are using. Architectures where the primary and secondary VM are using a shared storage for the DBMS data and transaction/redo log is not supported on Azure. The guiding principle is always that there are two independent storage stacks, even if those are based on NFS shares. This is the biggest restriction compared to what is possible on-premises.

As of the single point of failure of SAP, there are various possibilities. In opposite to the DBMS layer, the usage of a single NFS or SMB share is supported. For Windows in particular [Azure shared disk](/azure/virtual-machines/disks-shared) can be used for a specific high availability scenario for SAP's ASCS/SCS components.

High availability architectures that include the integration of SAP application layer components and DBMS layer in a single failover cluster are not supported on Azure. The DBMS layer and SAP application layer components require different failover cluster setups.

As you create failover clusters for SAP application layer components and DBMS layer, you are required to work with a virtual IP address for the cluster resources in most of the cases. One well known exception is the case of Oracle Data Guard, where Oracle functionality does not require a virtual IP address. In all other cases, the virtual IP address needs to be handled by an [Azure Load Balancer](/azure/load-balancer/load-balancer-overview). As a design principle, we use one load balancer per cluster configuration. There are two different versions of the Azure Load Balancer. The Standard Load Balancer is recommended. If you're using the Standard Load Balancer, you should make yourself familiar with the article [public endpoint connectivity for virtual machines using Azure Standard Load Balancer in SAP high-availability scenarios](/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

For details and possibilities, start with the document [High-availability architecture and scenarios for SAP NetWeaver](/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios)

#### Availability sets or Azure Availability Zones

Before you deploy your high availability infrastructure, you need, dependent on your chosen region, decide whether you want to deploy through an [Azure availability set](/azure/virtual-machines/availability) or Azure Availability Zone. The biggest differences is that deploying dvm through an availability set, the VMs will:

- The VMs deployed are not spread across different Availability Zones
- The type of VMs that can be deployed through a single availability set are restricted since the type of host is defined with the first VM that is deployed in the set. As a result, you can't.e.g. Have an m-series VM and an E-series VM combined in one availability set.

Advantage of deploying your high availability architecture across different Availability Zones is that your SLA for the VMs might be slightly higher. For details, check [Azure VM SLAs](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/). However, dependent on the Azure region, you might encounter different network latency conditions in network traffic between VMs. For details on SAP workload deployments across different Azure Availability Zones, read the article [SAP workload configurations with Azure Availability Zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

### Backup and restore

Though backup and restore are mostly not considered an adequate high availability functionality for production SAP workload, it is a technology that covers various other areas. Besides the fact that most companies using SAP applications are under compliance regulations that require backups being stored for many years, there are other cases where having a backup and being able to restore from it are essential. The assumption is that you are having solid backup and restore practices established for your current deployment of SAP applications already. Means you:

- Are able to perform a point-in-time recovery for your production databases at any point in time in a time frame that meets your RTO. Point-in-time recovery usually covers the case of operator errors deleting data either on the DBMS layer or through SAP incidentally
- Have a store where you keep your long term backups to meet your compliance regulations
- Have the ability to clone a SAP system by using database backups and restore those against another server/VM
- Have the ability to use database backups to refresh non-production systems with data of production databases
- Have the ability to either backup the disks of he SAP application servers/VMs or snapshot the VMs

As you have that all on-premises, you now need to see how you can get these capabilities for the SAP systems you have in Azure as well. One solution that for sure is not recommended is to pull your backups from Azure into your on-premises backup infrastructure. In the past customers found this too intrusive on the bandwidth consumption of their ExpressRoute circuits. Especially with very large databases.

If you are very satisfied with your current solution you have in place, check with your backup vendor whether they support deployment in Azure or whether they even have a SaaS solution established in Azure. If that is the case, test the solution for backup but also for restore times. Some of the solutions might show great backup times and throughput using Azure Blob Storage. But might be significantly slower in reading from those blobs and as a result have significant lower restore throughput.

Azure itself has an Azure Backup SaaS service as well, that has its strengths in taking VM snapshots and managing streaming backups of [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about). If you are using Azure NetApp Files storage for your SAP HANA databases, you have other possibilities to perform backups that are based on HANA consistent storage snapshots.

The recommendations and considerations factor in the following criteria. These recommendations and considerations might need to be reexamined if a scenario changes:

- Compute: Virtual machines (VMs) ; not SAP HANA on Azure (Large Instances)
- Storage: Premium SSD managed disks
- VM SLA: 99.95 percent for deploying an availability set
- SAP S/4HANA deployment: ABAP SAP central service (ASCS) cluster; HANA System Replication (HSR) cluster
- Single security identifier (sid) deployment
- Network File System (NFS): Azure NetApp Files for cluster-shared file systems
- Operating system: Linux
- HANA database memory size: 2 terabytes (TB)
- RTO: 24 hours, RPO: 4 hours
- Backup: Long-term retention required; a full backup must finish in eight hours.
- Cost-optimization deployment: QA instance on DR region running the production instance
- Reference architecture: [SAP S/4HANA in Linux on Azure](/azure/architecture/reference-architectures/sap/sap-s4hana)

**Design considerations:**

Consider the following factors:

- You SAP systems could have various components like ASCS, an SAP Web Dispatcher or application, or database servers. Create a different availability set for web dispatcher, SAP application servers, scs, or HANA.

> [!NOTE]
> This document describes single-sid deployment, but Azure also supports multi-SID-cluster deployments. A maximum of five SAP SIDs can be deployed in a Linux cluster running in Azure.

- When designing for high availability, protect all single points of failure and designs for resilience. You can use Linux Pacemaker clustering for the ASCS (central service) and database VMs.

- Keep the database and application layer on separate clusters.

- Optimize Azure NetApp Files for shared storage file systems.

**Design recommendations:**

The following are best practices for your design:

- Do not mix servers with different roles in the same availability set. You should keep central-service VMs, database VMs, and application VMs in their own availability sets.

- Don't combine ASCS and the database in the same Pacemaker cluster; keep them in separate clusters.

- Primary application server (pas) instance can be installed on an ASCS cluster to optimize the cost. (Coordinate with jt team before we make it public.)

- Redundant VMs should be behind in a load balancer.

- VMs must use premium SSD managed disks (including the operating system [OS] disk) to comply with SLA guidelines for OS and data volumes. Use Azure NetApp Files for shared disks.

- Two Azure NetApp Files accounts should be created within two different regions and with at least a premium service level.

- Azure NetApp Files should be on a separate subnet; one subnet per virtual network (VNet) is allowed.

- Use the same subscription ID across the same landscape; multiple subscriptions could be supported in the future.

- Use Azure Backup to back up SAP application server VMs.

- Use Azure Backup for SAP HANA databases smaller or equal to 2 tebibytes (TiB). Azure Backup currently supports up to 2 TiB, but it doesn't currently support HSR. [This outline](/azure/backup/sap-hana-backup-support-matrix) lists updated Azure Backup restrictions.

- For a HANA database larger than 2 TiB, select a native a HANA database backup, and copy it to Azure Blob Storage requirements. Use the 'AzCopy' utility to copy the backup files to Blob Storage.

- Use Azure ExpressRoute to connect customer sites (on-premises) to primary and secondary (DR) Azure regions. You can also set up a VPN connection between customer sites (on-premises) to primary and secondary (DR) Azure regions.

- For Suse Linux Enterprise Server (SLES), use a STONITH Block Device (SBD) (up to three SBDs in different fencing devices) or an Azure fence agent; additional VMs aren't required. Refer to [SLES Pacemaker](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-pacemaker) if you plan to use Azure fence agents.

- Use an Azure fence agent for Red Hat Enterprise Linux.

- For ASCS clusters, use Azure Site Recovery to replicate cluster VMs to the DR site. When you invoke DR, you'll need to reconfigure the Pacemaker cluster on the DR site; for example, replace 'vip', `corosync.conf`, and so on.

- Use Azure Site Recovery to replicate application servers to the DR site. Do not use Azure Site Recovery to replicate database servers.

- Use database-native replication methods like an HSR database DR sync.

- For VNet applications requiring DR network access, make sure that the VNet is peered to the secondary (DR) region. For example, HSR replication will required an SAP HANA database VNet to be peered to the secondary site's SAP HANA database VNet.

- You can also [use VNet to ExpressRoute peering](/azure/expressroute/expressroute-howto-linkVNet-portal-resource-manager) or [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) instead of VNet peering.

- The primary VNet's classless inter-domain routing (CIDR) shouldn't conflict or overlap with the disaster site VNet's CIDR.

- The load balancer configuration should be in front of dual web dispatchers and ASCS and database nodes.

- Make sure that the Floating IP is enabled in the load balancer.

- To take advantage of Azure NetApp Files features like cross-region replication (in public preview), use a paired Azure NetApp Files region. Azure NetApp Files paired regions are different than standard Azure paired regions.

- You can also use the 'rsync' utility to sync data from one region to another in Azure NetApp Files (one zone to another if using zonal deployment).

- For resource metadata to be stored in the DR region, deploy the DR resources in a resource group assigned to the same Azure region where DR resources are created. This allows changes to Azure DR resources if the Azure production region is down.

## Scalability for compute and storage in an SAP enterprise-scale scenario

**Design considerations for compute:**

![A diagram of Azure compute SKU options.](./media/bcdr-compute-options-2.png#lightbox)

*Figure 1: Azure compute SKU options.*

Consider the following compute options:

- Use a D-series SKU for SAP application servers; the D-series provides 1:4 for CPU memory-mapping. Consider E-series VMs for memory-intensive workloads.

- Use the most current generation of SKUs where possible; for example, v3 or 4. Refer to SAP note [1928533](https://launchpad.support.sap.com/#/notes/1928533) for information about the certified D-series SKU for an SAP deployment.

- Use the [E-series](/azure/virtual-machines/sizes-memory) or [m-series](/azure/virtual-machines/m-series) SKU for AnyDB. E-series and m-series SKUs are optimized for memory and provide a consistent CPU-to-memory ratio.

- Follow the design principle of scaling up and then out. From a cost perspective, scale-out deployments could cost less than a scale-up setup in some scenarios.

- Scale out for SAP application servers versus scaling up.

- Use the E-series SKU for smaller and cost-conscious production and nonproduction deployments.

- Use input/output operations per second (IOPS) and throughput limits of VM SKUs for SAP third-party database (AnyDB) production deployments.

**Design recommendations for compute:**

- Use an E-series SKU for SAP NetWeaver application server Java. An E-series SKU has better memory than a D-series with same input, output, and throughput limits. Java application servers require a lot of memory, and the E-series will provide better CPU memory-mapping. It is recommended to use [Gen2 VM SKUs](/azure/virtual-machines/generation-2), when possible.

- Use an E-series SKU for AnyDB deployments. A database's performance increases with the size of its cache. The two main advantages of E-series SKUs over D-series are 1:8 memory mapping and constrained core options to help you save on database license costs without compromising input, output, and throughput limits.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the VM's IOPS and throughput limits. For example, the p50 disk generates 7,500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a standard d8s_v3 that only supports 192 Mbps, it doesn't help the p50 disk to achieve its throughput.

- Use an m-series SKU for a HANA production deployment. The m-series support 256 gigabytes to 12 TB of scaling up and 96 TB of scaling out. Visit the [SAP hardware directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html#categories=Microsoft%20Azure) for setup support.

- Ultra-SSD or Azure NetApp Files should be used for log volumes in production HANA deployments that use E-series SKUs. Azure NetApp Files should be used for log volumes and HANA data volumes.

- Use [Large Instances](/azure/virtual-machines/workloads/sap/hana-overview-architecture) for processing online transactions and scale-up deployments larger than 12 TB.

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

- Considered the following storage options for SAP shared file systems, such as, `sapmnt` and `trans`
  - Azure shared disk on Azure premium storage (Windows deployments)
  - Azure NetApp Files (Server Message Block and NFS)
  - Azure Files nfs4.1 (preview)

- Storage option to be considered for database logs which require a lower latency of <1ms

  - Premium SSD managed disks with write accelerator (only on M-series VMs)
  - Azure ultra disks
  - Azure NetApp Files (supported for HANA only)

- For a cost-conscious deployment, consider deploying preproduction, or test systems on standard SSDs and convert to premium for the test cycle period, as needed; for example, an e20 disk costs half as much as a p20.

- For cost-conscious deployments, consider:

  - [Disk bursting](/azure/virtual-machines/disk-bursting#disk-level-bursting) for nonproduction workloads

  - [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for HANA deployments

  - [Disk striping](/azure/virtual-machines/premium-storage-performance) instead of using one large disk. Refer back to [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for more information about stripe sizes.

- [Azure Disk Encryption](/azure/security/fundamentals/azure-disk-encryption-vms-vmss) for data disks on SAP application servers

- [Azure Storage encryption](/azure/storage/common/customer-managed-keys-overview?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json) with customer-managed keys for database disks

**Design recommendations for storage:**

- For cost-conscious deployments, use standard SSD managed disks storage for SAP nonproduction (development/testing).

- Do not use infrastructure as a service NFS clusters for SAP shared file systems. Instead, use [Azure shared disk on premium storage](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk#options-for-shared-disk-in-azure-for-sap-workloads) for Windows deployments and [Azure NetApp Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files) or NFS on Azure Files for Linux deployments.

- Use Azure premium SSD managed disks for SAP application servers; for example, usr/SAP file systems.

- Azure premium managed storage must be used for the SAP global transport directory.

- The OS disk size should be at least 128 gigabytes (GB) (p10) in production deployments. Customer experiences show application logging and monitoring agents writing data to the OS disk and driving high input/output requirements; using a smaller disk throttles disk performance.

- For any database deployment, the [readonly cache](/azure/virtual-machines/premium-storage-performance#disk-caching) must be enabled for data disks that contain database data files. The readonly cache can only be enabled on disks smaller than 4,095 GB.

- Use only database-native encryption instead Azure Disk Encryption for database disks; for example, Transparent Data Encryption, TDE, for Oracle or SQL Server.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the VM's IOPS and throughput limits. For example, the P50 disk gives 7500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a standard d8s_v3 that only supports 192 Mbps, it doesn't help realize the P50 disk's throughput.
