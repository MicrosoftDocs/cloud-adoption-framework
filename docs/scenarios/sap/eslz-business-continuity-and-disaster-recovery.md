---
title: Enterprise-scale business continuity and disaster recovery for an SAP migration
description: Learn about enterprise-scale business continuity and disaster recovery for an SAP migration in the Microsoft Cloud Adoption Framework for Azure. 
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Business continuity and disaster recovery for an SAP enterprise-scale migration

Your organization or enterprise needs to design suitable, platform-level capabilities that application workloads can consume to meet their specific requirements. Specifically, these application workloads have requirements pertaining to a recovery time objective (RTO) and a recovery point objective (RPO). Be sure to capture recovery (DR) requirements for these workloads to appropriately design their capabilities.

## Scenario and Scope

The recommendations and considerations factor in the following criteria. These recommendations and considerations might need to be reexamined if a scenario changes:

- Compute: Virtual machines (VMs); not SAP HANA on Azure (Large Instances)
- Storage: Premium SSD Managed Disks
- VM SLA: 99.95 percent for deploying an availability set
- SAP S/4HANA deployment: ABAP SAP Central Service (ASCS) cluster; HANA System Replication (HSR) cluster
- Single security identifier (SID) deployment
- Network file system (NFS): Azure NetApp Files for cluster-shared file systems
- Operating system: Linux
- HANA database memory size: 2 terabytes (TB)
- RTO: 24 hours, RPO: 4 hours
- Backup: Long-term retention required; a full backup must finish in eight hours.
- Cost-optimization deployment: QA instance on DR region running the production instance
- Reference architecture: [SAP S/4HANA in Linux on Azure](/azure/architecture/reference-architectures/sap/sap-s4hana)

**Design considerations:**

Consider the following factors:

- You SAP systems could have various components like ASCS, an SAP Web dispatcher or application, or database servers. Create a different availability set for Web dispatcher, SAP application servers, SCS, or HANA.

> [!NOTE]
> This document describes single-SID deployment, but Azure also supports multi-SID-cluster deployments. A maximum of five SAP SIDs can be deployed in a Linux cluster running in Azure.

- When designing for high availability, protect all single points of failure and designs for resilience. You can use Linux Pacemaker clustering for the ASCS (central service) and database VMs.

- Keep the database and application layer on separate clusters. 

- Optimize Azure NetApp Files for shared storage file systems.

**Design recommendations:**

The following are best practices for your design:

- Do not mix servers with different roles in the same availability set. You should keep central-service VMs, database VMs, and application VMs in their own availability sets.

- Don’t combine ASCS and the database in the same Pacemaker cluster; keep them in separate clusters.

- Primary Application Server (PAS) instance can be installed on an ASCS cluster to optimize the cost.
    (Coordinate with JT team before we make it public.)

- Redundant VMs should be behind in a load balancer.

- VMs must use Premium SSD Managed Disks (including the operating system [OS] disk) to comply with SLA guidelines for OS and data volumes. Use Azure NetApp Files for shared disks.

- Two Azure NetApp Files accounts should be created  within two different regions and with at least a premium service level.

- Azure NetApp Files Should be on a separate subnet; one  subnet per virtual network (VNet) is allowed.

- Use the same subscription ID across the same landscape; multiple subscriptions could be supported in the future.

- Use Azure Backup to back up SAP application server VMs.

- Use Azure Backup for SAP HANA databases smaller or equal to 2 tebibytes (TiB). Azure Backup currently supports up to 2 TiB, but it doesn't currently support HSR. [This outline](/azure/backup/sap-hana-backup-support-matrix) lists updated Azure Backup restrictions.

- For a HANA database larger than 2 TiB, select a native a HANA database backup, and copy it to Azure Blob Storage requirements. Use the 'AzCopy' utility to copy the backup files to Blob Storage.

- Use Azure ExpressRoute to connect customer sites (on-premises) to primary and secondary (DR) Azure regions. You can also set up a VPN connection between customer sites (on-premises) to primary and secondary (DR) Azure regions.

- For SUSE Linux Enterprise Server (SLES), use a STONITH Block Device (SBD) (up to three SBDs in different FDs) or an Azure fence agent; additional VMs aren't required. Refer to [SLES Pacemaker](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-pacemaker) if you plan to use Azure fence agents.

- Use an Azure fence agent for Red Hat Enterprise Linux.  

- For ASCS clusters, use Azure Site Recovery to replicate cluster VMs to the DR site. When you invoke DR, you'll need to reconfigure the Pacemaker cluster on the DR site; for example, replace 'VIP', 'corosync.conf', etc.

- Use Azure Site Recovery to replicate application servers to the DR site. Do not use Azure Site Recovery to replicate database servers.

- Use database-native replication methods like an HSR database DR sync.

- For VNet applications requiring DR network access, make sure that that the VNet is peered to the secondary (DR) region. For example, HSR replication will required an SAP/HANA database VNet to be peered to the secondary site's SAP/HANA database VNet.

- You can also [use VNet to ExpressRoute peering](/azure/expressroute/expressroute-howto-linkVNet-portal-resource-manager) or [ExpressRoute GlobalReach](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-global-reach) instead of VNet peering.

- The primary VNet's classless inter-domain routing (CIDR) shouldn't conflict or overlap with the disaster site VNet's CIDR.

- The load balancer configuration should be in front of dual web dispatchers and ASCS and database nodes.

- Make sure that the Floating IP is enabled in the load balancer.

- To take advantage of Azure NetApp Files features like cross-region replication (in public preview), use a paired Azure NetApp Files region. Azure NetApp Files paired regions are different than standard Azure paired regions.

- You can also use the 'rsync' utility to sync data from one region to another in Azure NetApp Files (one zone to another if using zonal deployment).

- For resource metadata to be stored in the DR region, deploy the DR resources in a resource group assigned to the same Azure region where DR resources are created. This allows changes to Azure DR resources if the Azure production region is down.

## Scalability for compute and storage in an SAP enterprise-scale scenario

**Design considerations for compute:**

![A diagram of Azure compute SKU options.](./media/bcdr-compute-options-2.png#lightbox)

_Figure 1: Azure compute SKU options._

Consider the following compute options:

- Use a D-series SKU for SAP application servers; the D-series provides 1:4 for CPU memory-mapping. Consider the E-series for memory-intensive workloads.

- Use the most current generation of SKUs where possible; for example, V3 or 4. Refer to SAP note [1928533](https://launchpad.support.sap.com/#/notes/1928533) for information about the certified D-series SKU for an SAP deployment.

- Use the [E-series](/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json) or [M-series](/azure/virtual-machines/m-series?toc=/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json) SKU for AnyDB. E- and M-series SKUs are optimized for memory and provide a consistent CPU-to-memory ratio.

- Follow the design principle of scaling up and then out. From a cost perspective, scale-out deployments could cost less than a scale-up setup in some scenarios.

- Scale out for SAP application servers versus scaling up.

- Use the E-series SKU for smaller and cost-conscious production and nonproduction deployments.

- Use input/output operations per second (IOPS) and throughput limits of VM SKUs for SAP third-party database (AnyDB) production deployments.

**Design recommendations for compute:**

- Use an E-series SKU for SAP NetWeaver Application Server Java. An E-series SKU has better memory than a D-series with same input, output, and throughput limits. Java application servers require a lot of memory, and the E-series will provide better CPU memory-mapping. It is recommended to use [Gen2 VM SKUs](https://docs.microsoft.com/azure/virtual-machines/generation-2), when possible.

- Use an E-series SKU for AnyDB deployments. A database's performance increases with the size of its cache. The two main advantages of E-series SKUs over D-series are 1:8 memory mapping and constrained core options to help you save on database license costs without compromising input, output, and throughput limits.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the VM's IOPS and throughput limits. For example, the P50 disk generates 7,500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a Standard D8s_v3 that only supports 192 Mbps, it doesn’t help the P50 disk to achieve its throughput.

- Use an M-series SKU for a HANA production deployment. The M-series support 256 gigabytes to 12 TB of scaling up and 96 TB of scaling out. Visit the [SAP Hardware Directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html#categories=Microsoft%20Azure) for setup support.

- Ultra-SSD or Azure NetApp Files should be used for log volumes in production HANA deployments that use E-series SKUs. Azure NetApp Files should be used for log volumes and HANA data volumes.

- Use [Large Instances](/azure/virtual-machines/workloads/sap/hana-overview-architecture) for processing online transactions and scale-up deployments larger than 12 TB.

**Design considerations for storage:**

![A diagram of Azure Storage SKU options.](./media/bcdr-scalability-storage-sku.png#lightbox)

_Figure 2: Azure Storage SKU options._

- Azure offers a range of storage options; consider the following for running SAP application servers:

  - Standard SSD Managed Disks
  - Premium SSD Managed Disks
  - Ultra SSD
  - Azure Netapp Files

- Consider the following storage options for nonproduction database deployments:

  - Standard SSD Managed Disks
  - Premium SSD Managed Disks
  - Azure NetApp Files
  
- Considered the following storage options for SAP shared file systems; for example, 'SAPMNT' and 'TRANS':

  - Azure Shared Disk on Azure Premium storage  (windows deployments)
  - Azure NetApp files (server message block and NFS)
  - Azure Files NFS4.1 (preview)
  
- Storage option to be considered for database logs which require a lower latency of <1ms

  - Premium SSD Managed Disks with WA (only on M-series VMs)
  - Ultra SSD
  - Azure Netapp Files (supported for HANA only)

- For a cost-conscious deployment, consider deploying preproduction, or test systems on standard SSDs and convert to premium for the test cycle period, as needed; for example, an E20 disk costs half as much as a P20.

- For cost-conscious deployments, consider:

 - [Disk bursting](/azure/virtual-machines/linux/disk-bursting#disk-level-bursting) for nonproduction workloads 

 - [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for HANA deployments

 - [Disk striping](/azure/virtual-machines/premium-storage-performance) instead of using one large disk. Refer back to [SAP HANA Azure virtual machine storage configurations](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for more information about stripe sizes.

- [Azure Disk encryption](/azure/security/fundamentals/azure-disk-encryption-vms-vmss) for data disks on SAP application servers

- [Azure Storage encryption](/azure/storage/common/encryption-customer-managed-keys?toc=/azure/storage/blobs/toc.json) with customer-managed keys for database disks

**Design Recommendations for storage:**

- For cost-conscious deployments, use Standard SSD Managed Disks storage for SAP nonproduction (development/testing).

- Do not use infrastructure as a service NFS clusters for SAP shared file systems. Instead, use [Azure shared disk on premium storage](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk#options-for-shared-disk-in-azure-for-sap-workloads) for Windows deployments and [Azure NetApp Files](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files) or NFS on Azure files for Linux deployments.

- Use Azure Premium SSD Managed Disks disks for SAP application servers; for example, USR/SAP file systems.

- Azure premium managed storage must be used for the SAP Global Transport directory.  

- The OS disk size should be at least 128 gigabytes (GB) (P10) in production deployments. Customer experiences show application logging and monitoring agents writing data to the OS disk and driving high input/output requirements; using a smaller disk throttles disk performance.

- For any database deployment, the [ReadOnly cache](/azure/virtual-machines/premium-storage-performance#disk-caching) must be enabled for data disks that contain database data files. The ReadOnly cache can only be enabled on disks smaller than 4,095 GB.

- Use only database-native encryption instead Azure disk encryption for database disks; for example, Transparent Data Encryption, TDE, for Oracle or SQL server.

- The combined IOPS/throughput of all disks attached to a VM should be less than or equal to the VM's IOPS and throughput limits. For example, the P50 disk gives 7500 IOPS and a 250 megabits per second (Mbps) throughput. When this is attached to a Standard D8s_v3 that only supports 192 Mbps, it doesn’t help realize the P50 disk's throughput.