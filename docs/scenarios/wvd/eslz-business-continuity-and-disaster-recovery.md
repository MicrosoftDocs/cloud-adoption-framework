---
title: "Enterprise-Scale business continuity and disaster recovery for Windows Virtual Desktop (WVD)"
description: Describe how this enterprise-scale scenario can improve business continuity and disaster recovery of Windows Virtual Desktop (WVD)
author: igorpag
author: jimmoyle
ms.author: igorpag
ms.date: 10/31/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business Continuity and Disaster Recovery (BCDR) for Windows Virtual Desktop (WVD) Enterprise-Scale scenario

Enterprise-Scale in this instance refers to organizations with approximately 500-2000 WVD users.

Windows Virtual Desktop (WVD) is a managed service aiming to provide Microsoft control plane for your desktop virtualization environment.
WVD is a service free of charge, Microsoft does not offer a financially backed [service level agreement](https://azure.microsoft.com/support/legal/sla/virtual-desktop) (SLA) but strive to attain at least 99.9% availability for the Windows Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

Windows Virtual Desktop offers Business Continuity and Disaster Recovery (BCDR) to preserve customer metadata during outages. When an outage occurs in a region, the service infrastructure components will fail over to the secondary location and continue functioning as normal.
To keep your organization's data safe, you may need to adopt a BCDR strategy for resources that will be deployed in your subscription as part of the WVD data plane (Host Pools, Storage, etc.).
A sound BCDR strategy keeps your apps and workload up and running during planned and unplanned service or Azure outages.

Windows Virtual Desktop (WVD) main article on BCDR is available [here](https://docs.microsoft.com/azure/virtual-desktop/disaster-recovery)

To keep the service available to your users during an outage, you'll need to do consider the following points:

- How and where to keep Virtual Machines in the WVD Host Pool running and accessible.
- How to ensure FSLogix Profile and Office Containers have the appropriate level of availability and protection.
- Make sure that user identities which you have set up in the primary location are available in the secondary location.
- Ensure Azure connectivity and resiliency design is adequate to provide access to users to all necessary resources also in case of a major disaster.
- Make sure any line-of-business applications relying on data in your primary location are failed over to the secondary location.

## Design considerations

- For WVD Host Pool, both *active-active* and *active-passive* can be viable approaches, depending on the requirements.
  - With *active-active*, a single Host Pool can have VMs from multiple regions (geo-paired and proximity recommended). In this case usage of [Cloud Cache](https://docs.microsoft.com/fslogix/cloud-cache-resiliency-availability-cncpt) is required to actively replicate the Profile/Office containers between the regions. For VMs in each region, the Cloud Cache registry entry specifying locations need to be inverted to give precedence to the local one. This is a complex configuration, should be used only if necessary and justified by requirements.  If *active-active* is chosen it gives protection against storage outages without the need to re-log the user and also enables continuous testing of the DR location.  It is not considered either a performance or cost optimization.  This configuration is also limited to Pooled VMs.
  - With *active-passive*, [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) or a secondary Host Pool (hot stand-by) in the DR region options can be used.
    - Azure Site Recovery is supported for both Personal (dedicated) and Pooled (shared) Host Pools, and will permit to maintain a single Host Pool.  However it is recommended only for Personal VMs.
    - Create a new Host Pool in the failover region is also possible, while keeping all resources in your failover location turned off. For this method, you’d need to set up new App Groups and Workspaces in the failover region.  This is recommended for Pooled VMs

- Usage of *active-passive* availability pattern in a multi-region deployment.
  - For Personal (*dedicated*) Host Pool, it is recommended to use ASR to replicate Host Pool VMs in a secondary DR region (*Active-Passive* with Cold Stand-By). Region should be aligned with DR of the storage backend used by FSLogix.
  - For Pooled (*shared*) Host Pool, ASR can still be used. You can also and eventually create a new host pool in the failover region while keeping all resources in your failover location turned off. For this method, will be necessary to set up new App Groups and Workspaces in the failover region. You can then use an Azure Site Recovery “*Recovery Plan*” to turn on host pools and arrange an orchestrated process.

- Host Pool VM Resiliency
  - Different [options](https://docs.microsoft.com/azure/virtual-machines/availability) for VM resiliency are available when creating a new WVD Host Pool. It is important to select the right one based on requirements at creation time since cannot be changed later.

  - Default resiliency option for WVD Host Pool deployment is Availability Set: it will only ensure VM resiliency at the single Azure datacenter level, with formal 99.95% high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9).

  - With [Availability Zones](https://docs.microsoft.com/azure/availability-zones/az-overview) instead, VM in the Host pool will be allocated across different datacenters, still inside the same region, with higher resiliency and higher formal 99.99% high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9).

     > [!NOTE]
     > ARM template must be used at the moment to specify zones, this option is not yet available in the Azure Portal.

### Optimal Storage for Profile and Office containers

For optimal performance FSLogix containers should be located on storage which is as close as possible to the VM which the user is logged onto, preferably in the same datacenter.  If some or all of the users log on to VMs with different latency characteristics to the main profile storage location, FSLogix Cloud Cache is advised over other replication mechanisms.

In a BCDR situation it is preferable to reduce the time taken to backup, restore and replicate data, with this in mind separation of profile and cache data is advantageous. Both the Profile disk and the O365 disk should be used and located on separate SMB shares. In normal usage the Office disk can consume many GB more than the profile. Backup, replication and restore of the profile disk will be far quicker without the inclusion of the cache data. The O365 disk is not required to be made resilient as this can be re-downloaded and the data it contains is already present, in full, inside O365.

  > [!NOTE]
  > The FSLogix Cloud Cache feature is 'write back' by design to increase performance characteristics to high latency targets. This means that if FSLogix Cloud Cache is used for replication, the profile disks **must** also be backed up to ensure no data loss occurs.

The [well known folders](https://docs.microsoft.com/onedrive/redirect-known-folders) (Desktop, Documents, Pictures, Screenshots, and Camera Roll) should all be moved to OneDrive, if present. This enables the resilience of these special folders to be handled by OneDrive rather than needing special consideration in a BCDR scenario.

Differentiate when users really need to save and make Profile containers data highly available and resilient to region failure. If critical, then usage of Cloud Cache is recommended. Otherwise, for less critical environment, usage of Zone Replicated Storage (ZRS) or Geo replicated storage (GRS) for Azure Files is recommended. LRS with local only resiliency can be used if no zone/region protection is required.

Azure offers multiple storage solutions that you can use to store your FSLogix Profile and Office container. The article [Storage options for FSLogix profile containers in Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions Azure offers for Windows Virtual Desktop FSLogix user profile containers. Storage Spaces Direct (S2D) is supported in conjunction with FSLogix and Windows Virtual Desktop as well. It is a self-managed storage solution that is out of scope for this article. Customers can get most value out of either Azure Files or Azure NetApp Files while simplifying management of Windows Virtual Desktop.

The FSLogix agent can support multiple profile locations for higher resiliency, if you configure the registry entries for FSLogix. Proper [replication mechanism](https://docs.microsoft.com/azure/virtual-desktop/disaster-recovery#fslogix-configuration) must be in place, based on the storage type used, or Cloud Cache should be used.

#### User Data Storage Replication and Resiliency

A suitable replication strategy should be put in place for user data residing in [FSLogix](https://docs.microsoft.com/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix) Profile containers:

  1. **Profile Pattern #1**: Native Azure storage replication mechanisms, for example Azure Files Standard [GRS replication](https://docs.microsoft.com/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region), Azure NetApp Files [Cross Region Replication](https://docs.microsoft.com/azure/azure-netapp-files/cross-region-replication-introduction), or Azure [Files Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide) for VM-based file servers

  2. **Profile Pattern #2**: FSLogix [Cloud Cache](https://docs.microsoft.com/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#using-cloud-cache) is built in automatic mechanism to replicate containers between different (up to 4) storage accounts.

  3. **Profile Pattern #3**: Only set up geo disaster recovery for application data and not for user data/profile: store important application data in separate storages, like OneDrive or other external storage with its own built-in DR mechanism.

### Golden Image Availability

  If a custom image is used to deploy WVD Host Pool VMs, [Azure Shared Image Gallery](https://docs.microsoft.com/azure/virtual-machines/windows/shared-image-galleries) should be used to replicate the image across all regions where WVD is used, and in at least two regions. Storage used for image creation should be Zone Replicated Storage (ZRS), and at least two copies per region should be maintained. If DevOps techniques are used and a build pipeline used, the produced artifact should be imported in Azure Shared Image Gallery and replicated to the secondary region.

### Backup Protection

  [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview) is the recommended solution for data protection for Azure Files Standard and Premium tiers, while Azure NetApp Files [Snapshots](https://docs.microsoft.com/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [Policies](https://docs.microsoft.com/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies)  should be used for Azure NetApp Files (all tiers).

### Infrastructure & application dependencies

  If users of the WVD infrastructure require on-premises resource access, resiliency of network infrastructure required to connect is also critical and should be considered.

- A disaster recovery virtual network, as part of Hub & Spoke or virtual WAN architecture, need to be available in a secondary region, recommended in the same geography.
- Active Directory authentication must be available also in the secondary disaster recovery region, directly with Domain Controllers deployed in the DR Virtual Network (recommended) or indirectly with connectivity to on-premises domain.
- Applications, and other resources that users need to access once connected to WVD Host Pool, need to be available also in the secondary DR location.

## Design recommendations

The following are best practices for your design:

- For WVD deployment model BCDR, use active-passive option if will satisfy your requirements for Recovery Point Objective (RPO) and Recovery Time Objective (RTO).
- Azure Site Recovery is recommended for Personal (*dedicated*) Host Pools.
- Azure Site Recovery is also supported for Pooled (*shared*) Host Pools. This option can be evaluated and compared to the deployment of an additional Host Pool in the secondary DR region.
- When maximum resiliency of the Host Pool is required in a single region, Availability Zones should be used when deploying a new Host Pool.
- Customers need to verify Availability Zones feature availability in the specific region, and availability of specific VM SKU inside all the zones.
- We recommend storing FSLogix profile containers on Azure Files or Azure NetApp Files for most customer scenarios.
  - Recommended options for container storage types are (in order): Azure Files Premium, Azure NetApp Files Standard and Azure NetApp Files Premium, depending on the resources and latency required by the specific workload.
- Azure storage built-in replication mechanisms should be used for BCDR when possible:
  - GRS with account failover for Azure File Share Standard tier (with no Large File Support enabled).
  - Cross Region Replication for Azure NetApp Files.
- Cloud Cache should be used only when:
  - Selected storage option is not able to provide the required BCDR capabilities, for example with Azure File Share Premium tier, or Azure File Share Standard with Large File Support enabled.
  - When RPO and RTO for Profile and Office containers need to be low/aggressive.
  - When replication between disparate storage is required.
- When Cloud Cache is used, it is recommended:
  - Use SSD for the Managed Disk of the WVD Host Pool VMs.
  - A backup solution must be in place to protect Profile containers.
- Minimize the data stored in Profile and Office containers.
  - Assess and review the type of data that need to be saved, protected, and eventually made available in a secondary DR region: not all data need to be saved nor replicated.
  - For Office and user data, One Drive solution is recommended, along with other external corporate authorized storage repositories.
- Use Azure Shared Image Gallery to replicate Golden Image to different regions.
- Use Azure Backup to protect user data from data loss or logical corruption, when Azure File Share Standard or Premium tiers are used.
- Use Azure NetApp Files Snapshots and Policies when Azure NetApp Files service is used.
- Carefully review your resiliency and BCDR for dependent resources: networking, authentication, application, and other internal resources either in Azure or on-premises.
