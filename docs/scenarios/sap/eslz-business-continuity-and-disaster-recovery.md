---
title: "Enterprise-Scale business continuity and disaster recovery for an SAP enterprise-scale scenario"
description: Describe how this enterprise-scale scenario can improve business continuity and disaster recovery of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business continuity and disaster recovery for SAP Enterprise-Scale scenario

Your organization or enterprise needs to design suitable, platform-level capabilities that application workloads can consume to meet their specific requirements. Specifically SAP application which usually run your most critical business processes have requirements in the areas of:

- Service/business process availability
- In case of a failure or disaster scenarios recovery time objectives (RTO) for a failure case that is limited to a component of a SAP system and the case of a widespread failure scenario affecting a datacenter or a region of Azure
- Recovery point objectives (RPO) for a failure case that is limited to a component of a SAP system and the case of a widespread failure scenario affecting a datacenter or a region of Azure. 
- Often forgotten, but even more likely to be used, operational and life-cycle management tasks that can require technologies usually used to compensate for failure scenarios. A few of such operations can be listed as guest OS patching, DBMS patching, cloning, or refreshing of SAP systems. 

## Scenario and Scope
As you approach the BCDR scenarios that need to be covered by your architecture, we can state that most of the principles and tasks you have on-premise are applying in Azure as well. The main difference may be that there is more hardware capacity in Azure to compensate for a host failure in Azure than you might have at home. So even for the largest Azure VMs, those can be service healed by restarting them on another server. But other than that the same rules apply as on-premise. Systems that you deployed with automatic failover cluster configurations on-premise or on bare metal hardware should be deployed in Azure with such a functionality as well.

As we go through this document, we work our way from top to the bottom by covering these aspects of BCDR:

- Cross regional or regional disaster recovery
- High availability within an Azure region
- Backup/restore considerations
- Selection of VM and storage components with best high availability

### Cross regional or disaster recovery
Azure has over 60 Azure regions as you can see in the [Azure Region Map](https://azure.microsoft.com/global-infrastructure/geographies/). Not all regions are running the same services. Looking at larger SAP software deployments, especially the ones using SAP HANA, you need to look for Azure regions that offer Azure [M-Series VMs](https://docs.microsoft.com/azure/virtual-machines/m-series) and/or [Mv2-Series VMs](https://docs.microsoft.com/azure/virtual-machines/mv2-series). Azure storage also has pairing between different regions that allow Azure storage to replicate a smaller subset of storage types to such another region. The mapping can be found [here](https://docs.microsoft.com/azure/best-practices-availability-paired-regions). The principle problem around the Azure region pairing for SAP workload is:

- In quite some cases, the pairs are not consistent with M/Mv2 VM services. Therefore we are observing many customers deploying their SAP systems **NOT** following our paired regions, but following service availability of the required VM families
- The storage type that can be replicated between the region pairs is Azure standard storage that can't be used as storage for your databases, or based VHDs. So, you are restricted to e.g. having backups replicated between paired region that you use. For all the other data, you need to provide your own replications, which in the database space is usually native DBMS functionality, like SQL Server AlwaysOn, HANA System replication, etc. And for the SAP application layer, a mixture of Azure Site recovery, rsync/robocopy, or other third party software 

As you defined the Azure regions, the second big design decision circles around the question whether you are going to deploy production systems into your primary region and non-production SAP systems into the 'DR region'. Or are you going with an architecture that puts all SAP systems into the primary region, so, that the DR region is only used for DR regions. Looking at the current SAP customer deployment pattern, one can state that most customers use both regions for SAP systems that are in operations. Customers that traditionally run complete copies of their production systems as business regression test systems, are usually planning for using the business regression test system of the specific SAP product line as DR target.

An important design criteria when using at least two Azure regions of which should be the disaster recovery region is that you need to have multiple ExpressRoute circuits connecting to Azure. The minimum should be one ExpressRoute circuit to the primary Azure region and the other ExpressRoute circuit should go to the disaster recovery region. Such an architecture should give you a second entry point into the Azure network in a different area or geography. So, that a catastrophe that impacts one Azure regions does not cut your connectivity into Azure.

Though not necessarily recommended, but used by quite a few customers, is an architecture that we call a combined HA/DR architecture. Such an architecture combines the high availability within an Azure region with disaster recovery within the same region. The underlying Azure construct used are [Azure Availability Zones](https://docs.microsoft.com/azure/availability-zones/az-overview). the distance of different Availability Zones within one Azure region is by far not as large as the distance between two different Azure regions. Huge regional natural catastrophes could jeopardize such an architecture eventually. Reasons for customers choosing such an option can be: 

- Compliance rules sufficient with such a configuration of smaller distance between production deployment and disaster recovery target
- Data sovereignty aspects
- Geopolitical considerations  

Another aspect you need to consider choosing your DR region is e.g. RPO and RTO for for the specific case of failing over to the DR site. The further the distance between the production region and DR region, the larger the network latency. Though you would replicate asynchronously between different Azure regions, a smaller or larger network latency can have impact on the throughput you are able to replicate and with that on the RPO target. Using the 'combined' HA/DR architecture, you are often able to minimize your RPO. But at the costs of a higher risk to be affected by large scale natural disasters.

 

### High availability within an Azure region
Thinking of high availability, you are mainly looking into providing availability for the single point of failures of SAP software that can be listed like:

- DBMS
- Single point of failure in the application, like ASCS/SCS as with the SAP NetWeaver and S/4HANA architecture
- Eventual other components, like Webdispatcher

In all those cases, the discussion of availability should not be restricted on the case of infrastructure or software failures, but need to include all the life-cycle management tasks that you need to perform, like patching the OS in the VMs. Patching of the DBMS or SAP software. Common technology used for protecting against larger unplanned service disruption can be used for minimizing the outages due to planned downtime and life-cycle management tasks

Common technologies that SAP and SAP supported DBMS provider support are automatic failover clusters. In the case of Windows, this is the Windows Failover Cluster Server functionality. In the case of Linux, this is Linux Pacemaker or third party products like SIOS Protection Suite for Linux or Veritas Infoscale. Keep in mind that only a subset of the scenarios you can deploy as high availability configurations in your own datacenter are supported in Azure as well. 

What is supported, what is not supported? Check the articles [SAP workload on Azure virtual machine supported scenarios](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-planning-supported-configurations) and [Supported scenarios for HANA Large Instances](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/hana-supported-scenario) for scenarios that are supported. 

For the DBMS layer the common architecture pattern is to use synchronous DBMS replication functionality in combination with different storage stacks the two VMs (primary/secondary) are using. Architectures where the primary and secondary VM are using a shared storage for the DBMS data and transaction/redo log is not supported on Azure. The guiding principle is always that there are two independent storage stacks, even if those are based on NFS shares. This is the biggest restriction compared to what is possible on-premise.

As of the single point of failure of SAP, there are various possibilities. In opposite to the DBMS layer, the usage of a single NFS or SMB share is supported. For Windows in particular [Azure shared disk](https://docs.microsoft.com/azure/virtual-machines/disks-shared) can be used for a specific high availability scenario for SAP's ASCS/SCS components.

High availability architectures that include the integration of SAP application layer components and DBMS layer in a single failover cluster are not supported on Azure. The DBMS layer and SAP application layer components require different failover cluster setups.

As you create failover clusters for SAP application layer components and DBMS layer, you are required to work with a virtual IP address for the cluster resources in most of the cases. One well known exception is the case of Oracle Data Guard, where Oracle functionality does not require a virtual IP address. In all other cases, the virtual IP address needs to be handled by an [Azure Load Balancer](https://docs.microsoft.com/azure/load-balancer/load-balancer-overview). As a design principle, we use one Load Balancer per cluster configuration. There are two different versions of the Azure Load Balancer. The one recommended to be used is the 'Standard' Load Balancer. Using the 'Standard' Load Balancer, you should make yourself familiar with the article [Public endpoint connectivity for Virtual Machines using Azure Standard Load Balancer in SAP high-availability scenarios](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-standard-load-balancer-outbound-connections).

For details and possibilities, start with the document [High-availability architecture and scenarios for SAP NetWeaver](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-high-availability-architecture-scenarios) 

#### Availability sets or Azure Availability Zones
Before you deploy your high availability infrastructure, you need, dependent on your chosen region, decide whether you want to deploy through an  [Azure availability set](https://docs.microsoft.com/azure/virtual-machines/availability) or Azure Availability Zone. The biggest differences is that deploying DVM through an availability set, the VMs will:

- The VMs deployed are not spread across different Availability Zones
- The type of VMs that can be deployed through a single availability set are restricted since the type of host is defined with the first VM that is deployed in the set. As a result, you can't.e.g. have a M-series VM and an E-Series VM combined in one availability set

Advantage of deploying your high availability architecture across different Availability Zones is that your SLA for the VMS might be slightly higher. For details, check [Azure VM SLAs](https://azure.microsoft.com/en-us/support/legal/sla/virtual-machines/). However, dependent on the Azure region, you might encounter different network latency conditions in network traffic between VMs. For details on SAP workload deployments across different Azure Availability Zones, read the article [SAP workload configurations with Azure Availability Zones](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

### Backup and restore
Though backup and restore are mostly not considered an adequate high availability functionality for production SAP workload, it is a technology that covers various other areas. Besides the fact that most companies using SAP applications are under compliance regulations that require backups being stored for many years, there are other cases where having a backup and being able to restore from it are essential. The assumption is that you are having solid backup and restore practices established for yoru current deployment of SAP applications already. Means you:

- Are able to perform a point-in-time recovery for your production databases at any point in time in a time frame that meets your RTO. Point-in-time recovery usually covers the case of operator errors deleting data either on the DBMS layer or through SAP incidentally
- Have a store where you keep your long term backups to meet your compliance regulations
- Have the ability to clone a SAP system by using database backups and restore those against another server/VM
- Have the ability to use database backups to refresh non-production systems with data of production databases
- Have the ability to either backup the disks of he SAP application servers/VMs or snapshot the VMs

As you have that all on-premise, you now need to see how you can get these capabilities for the SAP systems you have in Azure as well. One solution that for sure is not recommended is to pull your backups from Azure into your on-premise backup infrastructure. In the past customers found this too intrusive on the bandwidth consumption of their Expressroute circuits. Especially with very large databases.

If you are very satisfied with your current solution you have in place, check with your backup vendor whether they support deployment in Azure or whether they even have a SaaS solution established in Azure. If that is the case, test the solution for backup but also for restore times. Some of the solutions might show great backup times and throughput using Azure Blob storage. But might be significantly slower in reading from those Blobs and as a result have significant lower restore throughput. 

Azure itself has a Azure backup SaaS service as well, that has its strengths in taking VM snapshots and managing streaming backups of [SQL Server](https://docs.microsoft.com/azure/backup/backup-azure-sql-database) and [SAP HANA](https://docs.microsoft.com/azure/backup/sap-hana-db-about). If you are using Azure NetApp Files storage for your SAP HANA databases, you have other possibilities to perform backups that are based on HANA consistent storage snapshots.


## Design considerations
Consider the following factors:
- You SAP systems may have various components like Web dispatcher, application servers, ASCS servers, database servers etc. Create a different Availability Set for Web Dispatcher, SAP application servers, Central Services, and HANA
Note: Though, this document illustrates the single SID deployment, Azure supports multi SID clusters deployment as well. Max of 5 SAP SIDs can be deployed in the Linux cluster running in Azure
- While designing for high availability protect all the SPOF’s (Single Point Of Failures) and design for resiliency. You can use linux pacemaker clustering for the ASCS (Central service) and Database VMs 
- Keep the database and application layer on separate clusters. 
- Leverage ANF for shared storage file system 

## Design recommendations
The following are best practices for your design:
- Do not mix servers of different roles in the same availability set. You should keep central services VMs, database VMs, application VMs in their own availability sets.
- Don’t combine ASCS  and DB in the same pacemaker cluster. Keep them in separate clusters  
- Primary Application Server (PAS) instance can be installed on ASCS cluster to optimize the cost. (Coordinate with JT team before we make it public)
- Redundant VMs should be behind in a load Standard balancer.
- VMs must be using premium disks (including OS disk) to be compliant with SLA guidelines for OS and data volumes. for shared disks, you will use ANF for this design
- Two ANF accounts needs to be created in two different regions with atleast premium service level
- ANF Should be on a separate subnet, one  subnet per VNET is allowed
- Use of same subs ID across the same landscape (multiple subs may be supported in future)
- For backups of SAP application server VMs: Use Azure Backup 
- For SAP HANA DB smaller or equal to 2TiB in size, use Azure backup. *As of now, Az backup only support up to 2TiB. Az backup does not support HSR yet. Please see restrictions [here.](https://docs.microsoft.com/en-us/azure/backup/sap-hana-backup-support-matrix) 
- For HANA DB >2TiB, use native HANA DB backup and copy it to blob requirements. You will need to use utilities like AZCOPY to copy the backup files to blob.
- Setup an express route connectivity between customer site (on-prem) to primary and secondary (DR) regions of Azure 
- You can also setup VPN connection between customer site (on-prem) to primary and secondary (DR) regions of Azure
- SLES: Either use SBD device (Up to 3 SBD devices in different FD’s) or use Azure fence agent (No additional VM’s required). In case if you are going to use Fence agents then ensure to refer the doc: https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-suse-pacemaker 
- For RHEL: Use Azure Fencing agent  
- For ASCS cluster: Use ASR to replicate teh cluster VMs to the DR site. When you  invoke DR, you will need to reconfigure  the pacemaker cluster on the DR site (Ex: replace VIP, corosync config etc)
- Use ASR for Application server replication to DR site
- Do NOT use ASR for DB server replication
- Use DB native replication method like HSR (HANA) DB DR sync
- Make sure VNET application requiring DR network access, that VNET is peered to the secondary (DR) region. For ex: HANA HSR replication will required SAP/HANADB VNET peered to the SAP/HANADB VNET of the secondary site - The best recommended
- You can also use VNET to ER peering - https://docs.microsoft.com/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager
- You can also use GlobalReach instead of VNET peerign 
- CIDR for the primary VNET should not conflict/overlap CIDR for the disaster site VNET 
- Load balancer configuration in front of dual web dispatchers, ASCS nodes and DB nodes
- Make sure the Floating IP is enabled on the Load balancer
- For ANF, ensure that you are using ANF paired region so you can take advantage of ANF features like CRR (in public preview). ANF paired regions are different than the Azure standard paired regions
- You can also use rsync utility to sync the data from one region to another in ANF, (One zone to another if using Zonal deployment)
- Deploy the DR resources in a RG, assigned to the same Azure region, where the DR  resources are created, so that the resource metadata is stored in the DR region. That will allow changes to the DR Azure resources, in case the production Azure region is down.

## Scalability for Compute and Storage in Azure for SAP Enterprise-Scale scenario.

### Design Considerations for Compute

![AzureComputeSKUOptions](./media/BCDR_Compute_Options2.jpg)

- Consider using D-Series SKU for SAP application servers, D-Series provide 1:4 for CPU: Memory mapping, for memory intensive workloads consider E-series.
- Consider using latest Generation of SKU's where possible eg: V3 or V4.
  Please refer the SAP note [1928533](https://launchpad.support.sap.com/#/notes/1928533) for certified D-series SKU for SAP deployment.
- Consider using [E-series](https://docs.microsoft.com/azure/virtual-machines/ev3-esv3-series?toc=/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json) or [M-Series](https://docs.microsoft.com/azure/virtual-machines/m-series?toc=/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json) SKU for AnyDB.  M & E series SKUs are memory optimized provide better CPU:Memory ratio.
- Consider design principle of scale-up first then scale-out. However, from cost perspective in some scenarios scale-out deployments could be cheaper compared to scale-up setup.
- Consider Scale-out for SAP application server over scale-up.
- Consider using E-series SKU for smaller production and non-prod cost-conscious deployments.
- For AnyDB production deployment consider IOPS and throughput limits of VM SKUs.

### Design Recommendations for Compute

- Use E-series SKU for SAP Java application servers. E-series has better memory compared to a D-series SKU with same IO and throughput limits. Java application servers are memory intensive and E-series will provide a better CPU: Memory mapping.It is recommended to use [Gen2 VM SKU’s](https://docs.microsoft.com/azure/virtual-machines/generation-2) where possible.
- Use E-series SKU for SAP AnyDB deployment compared to D-series. Bigger the cache better the performance of database. E-series SKUs have the following advantages over D-series:
  - 1:8 Memory mapping
  - Constrained core options available to save DB license costs without a compromise on IO and throughput limits.
- Combined IOPS/throughput of all the disks attached to a VM should be less than or equal IOPS and Throughput limits of VM. eg: P50 disk give 7500 IOPS with 250MBps throughput when this is attached to a Standard D8s_v3 which can only support 192 MBps doesn’t help realize throughput of P50 disk.
- Use M series SKU for HANA Production deployment. M series support 256GB to 12TB scale-up and 96TB of scale out.Refer to SAP [Hardware directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html#categories=Microsoft%20Azure) for supported setup.
- Ultra-SSD or ANF should be used for log volumes in Production HANA deployments while using  E-series SKUs. Whilst using ANF for log volumes, ANF should also be used  HANA data volumes.
- [HANA Large Instances (HLI)](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-overview-architecture) for scale-up deployments larger than 12TB for OLTP.

### Design Considerations for Storage

![AzureStorageSKUOptions](./media/BCDR_Scalability_Storage_SKU.jpg)

- Azure has plethora of storage options to choose from, however for running SAP application servers consider the following storage options.
  - Standard SSD
  - Premium SSD
  - Ultra SSD
  - Azure Netapp Files (ANF)

- Storage options to consider for non-prod database deployments:
  - Standard SSD
  - Premium SSD
  - ANF
- Storage options to be considered for SAP Shared file systems eg: SAPMNT, TRANS
  - Azure Shared Disk on Azure Premium storage  (windows deployments)
  - Azure NetApp files (SMB & NFS)
  - Azure Files NFS4.1 (preview)
- Storage option to be considered for database logs which require a lower latency of <1ms
  - Premium Storage with WA (only on M-series VM’s)
  - Ultra SSD
  - Azure Netapp Files (supported for HANA only)
- In a cost-conscious deployment consider deploying Pre-Production or test systems on standard SDD and convert to Premium for the period of test cycles as required. Eg: E20 disk is half the cost of a P20.
- In cost-conscious deployments consider [disk bursting](https://docs.microsoft.com/azure/virtual-machines/linux/disk-bursting#disk-level-bursting) feature for non-production workloads or [document](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) in case of HANA deployment.
- Every Azure premium disk comes with IOPS and throughout limit, consider striping disk instead of using single large disk for a cost-conscious deployment. Further details about stripe sizes can be found [here](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations-storage).
- Consider using [Azure Disk encryption](https://docs.microsoft.com/azure/security/fundamentals/azure-disk-encryption-vms-vmss) for data disk on SAP application servers.
- Consider using [Azure Storage Service encryption](https://docs.microsoft.com/azure/storage/common/encryption-customer-managed-keys?toc=/azure/storage/blobs/toc.json) with customer managed keys(CMK) for database disks.


### Design Recommendations for Storage

- In a cost-conscious deployment use Standard SSD storage for SAP Non-Production (dev/test).
- Do not use IaaS NFS clusters for SAP Shared file systems, use [Azure shared disk on premium storage](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk) for Windows deployment, in Linux deployment use NFS on Azure Files or [Azure NetApp Files](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files).
- Use Azure premium managed SSD disks for SAP application servers e.g.: usr/sap file systems.
- Azure premium managed storage must be used for the SAP Global Transport directory.  
- In Production deployments the OS disk size should be minimum of 128GB (P10), from our customer experiences all the application logging and monitoring agents actively write data on OS disk driving high IO requirement using a smaller disk will throttle  the disk performance.
- [Read-Only](https://docs.microsoft.com/azure/virtual-machines/premium-storage-performance#disk-caching) cache must be enabled for the data disks holding database data files for AnyDB deployment. Read-Only cache can only be enabled on disks smaller than 4095GB.
- Do not use Azure disk encryption for database disk, use only DB native encryption for databases. Example - Transparent Data Encryption (TDE) for Oracle or SQL server.
- Combined IOPS/throughput of all the disks attached to a VM should be less than or equal IOPS and Throughput limits of VM. eg: P50 disk give 7500 IOPS with 250MBps throughput when this is attached to a Standard D8s_v3 which can only support 192 MBps doesn’t help realize throughput of P50 disk.

