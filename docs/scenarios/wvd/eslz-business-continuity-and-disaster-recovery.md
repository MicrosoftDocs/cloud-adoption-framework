---
title: "Enterprise-Scale business continuity and disaster recovery for Windows Virtual Desktop (WVD)"
description: Describe how this enterprise-scale scenario can improve business continuity and disaster recovery of Windows Virtual Desktop (WVD)
author: igorpag
ms.author: brblanch
ms.date: 10/31/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business Continuity and Disaster Recovery (BCDR) for Windows Virtual Desktop (WVD) Enterprise-Scale Scenario

Windows Virtual Desktop (WVD) is a managed service aiming to provide Microsoft control plane for your desktop virtualization environment.
WVD is a service free of charge, Microsoft does not offer a financially backed [service level agreement](https://azure.microsoft.com/support/legal/sla/virtual-desktop) (SLA) but strive to attain at least 99.9% availability for the Windows Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

Windows Virtual Desktop offers Business Continuity and Disaster Recovery (BCDR) to preserve customer metadata during outages. When an outage occurs in a region, the service infrastructure components will fail over to the secondary location and continue functioning as normal.
To keep your organization's data safe, you may need to adopt a BCDR strategy for resources that will be deployed in your subscription as part of the WVD data plane (Host Pools, Storage, etc.).

A sound BCDR strategy keeps your critical apps and workload up and running during planned and unplanned service or Azure outages.

Windows Virtual Desktop (WVD) main article on BCDR is available [here](https://docs.microsoft.com/azure/virtual-desktop/disaster-recovery)

## Design considerations

### Host Pool Compute Strategy

- For WVD Host Pool, both *active-active* and *active-passive* can be viable BCDR approaches, depending on the requirements.
  - With *active-active*, a single Host Pool can have VMs from multiple regions. In this scenario, usage of [Cloud Cache](https://docs.microsoft.com/fslogix/cloud-cache-resiliency-availability-cncpt) would be required to actively replicate the user's FSLogix Profile/Office containers between the regions. For VMs in each region, the Cloud Cache registry entry specifying locations need to be inverted to give precedence to the local one.
    - This is a complex configuration. If active-active is chosen, it protects against storage outages without requiring the user to log in again and enables continuous testing of the DR location. It is not considered either a performance or cost optimization.  
    - Load balancing of incoming user connection cannot take into account proximity: all hosts will be equal, and users may be directed to a remote, not optimal, WVD Host Pool VM.
    - This configuration is limited to *Pooled* (shared) Host Pool type. For *Personal* (dedicated) type, once a desktop is assigned to a user on a certain Session Host VM, it sticks and will not change, even if not available.

  - With *active-passive*, [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) (Azure Site Recovery) or a secondary Host Pool (hot stand-by) in the DR region options can be used.
    - Azure Site Recovery is supported for both *Personal* (dedicated) and *Pooled* (shared) Host Pool types, and will permit to maintain a single Host Pool entity.
    - Creating a new Host Pool in the failover region is also possible, while keeping all those resources  turned off. For this method, you would need to set up new Application Groups in the failover region and assign users to them. You can then use an Azure Site Recovery “*Recovery Plan*” to turn on host pools and create an orchestrated process.

- Host Pool VM Resiliency
  
    Different [options](https://docs.microsoft.com/azure/virtual-machines/availability) for VM resiliency are available when creating a new WVD Host Pool. It is important to select the right one based on requirements at creation time since cannot be changed later.

  - Default resiliency option for WVD Host Pool deployment is Availability Set: it will only ensure Host Pool resiliency at the single Azure datacenter level, with formal 99.95% high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9).
  
     > [!NOTE]
     > The maximum number of VMs inside an Availability Set is 200, as documented in [this article](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager)

  - With [Availability Zones](https://docs.microsoft.com/azure/availability-zones/az-overview) instead, VMs in the Host pool will be allocated across different datacenters, still inside the same region, with higher resiliency and higher formal 99.99% high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). Capacity planning should take into account enough additional compute capacity to ensure WVD will continue to operate even if a single zone will be lost.

     > [!NOTE]
     > ARM template must be used at the moment to specify zones; this option is not yet available in the Azure Portal.

- Critical Applications and Multiple Host Pools
  - Before approaching Windows Virtual Desktop BCDR planning and design, it is important to initially consider which applications are consumed through WVD are critical. You may want to separate them from non-critical apps and use a separate Host Pool with a different disaster recovery approach and capabilities.

### Optimal Storage for Profile and Office containers

- Location of storage used for FSLogix containers is critical to ensure the lowest latency from the Host Pool VM.

- In a BCDR situation, it is possible to reduce the time taken to backup, restore and replicate data, with the separation of user Profile and the Office container disks. FSLogix offers the possibility to allocate them in separate storage locations. In normal usage the Office disk can consume many GB more than the profile. Backup, replication, and restore of the profile disk will be far quicker without the inclusion of the cache data. The Office disk is not required to be made resilient as this is just a cache of data and can be re-downloaded as the data it contains is already present, in full, inside Office 365 on-line services.

  > [!NOTE]
  > The FSLogix Cloud Cache feature is 'write back' by design to increase performance characteristics to high latency targets, thus using asynchronous replication.

- OneDrive can be used to redirect [well known folders](https://docs.microsoft.com/onedrive/redirect-known-folders) (Desktop, Documents, Pictures, Screenshots, and Camera Roll) if present. This would enable the resilience of these special folders to be handled by OneDrive rather than needing special consideration in a BCDR scenario.

- Azure offers multiple storage solutions that you can use to store your FSLogix Profile and Office container. The article [Storage options for FSLogix profile containers in Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions Azure offers for Windows Virtual Desktop FSLogix user profile containers. Storage Spaces Direct (S2D) is supported in conjunction with FSLogix and Windows Virtual Desktop as well. It is a self-managed storage solution that is out of scope for this article. Customers can get most value out of either Azure Files or Azure NetApp Files while simplifying management of Windows Virtual Desktop, and as such are the recommended storage solutions for this workload.

- The FSLogix agent can support multiple profile locations for higher resiliency if you configure the VHDLocations registry entry. In this case, proper [replication mechanism](https://docs.microsoft.com/azure/virtual-desktop/disaster-recovery#fslogix-configuration) needs to be in place, based on the storage type used, or Cloud Cache should be used.

#### User Data Storage Replication and Resiliency

- In WVD, multiple replication mechanisms and strategies can be used for user data residing in [FSLogix](https://docs.microsoft.com/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix) containers:

  1. **Profile Pattern #1**: Native Azure storage replication mechanisms, for example Azure Files Standard [GRS replication](https://docs.microsoft.com/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region), Azure NetApp Files [Cross Region Replication](https://docs.microsoft.com/azure/azure-netapp-files/cross-region-replication-introduction), or Azure [Files Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide) for VM-based file servers

  2. **Profile Pattern #2**: FSLogix [Cloud Cache](https://docs.microsoft.com/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#using-cloud-cache) is built in automatic mechanism to replicate containers between different (up to 4) storage accounts.

  3. **Profile Pattern #3**: Only set up geo disaster recovery for application data and not for user data/profile containers: store important application data in separate storages, like OneDrive or other external storage with its own built-in DR mechanism.

### Golden Image Availability

  - If custom images are used to deploy WVD Host Pool VMs, it is important to ensure those artifacts are available in all regions, even if in case of a major disaster. [Azure Shared Image Gallery](https://docs.microsoft.com/azure/virtual-machines/windows/shared-image-galleries) service can be used to replicate images across all regions where a Host Pool is deployed, with redundant storage and in multiple copies.

### Backup Protection

  - Preventing data loss for critical user data is important, first step is to assess which data need to be saved and protected.
    - If using OneDrive or other external storage, saving user Profile and/or Office Containers data maybe not necessary.
  - Appropriate mechanism must be considered to provide protection for critical user data:
    - [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview) service can be used to protect Profile and Office Containers data when stored on Azure Files Standard and Premium tiers.
    - Azure NetApp Files [Snapshots](https://docs.microsoft.com/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [Policies](https://docs.microsoft.com/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies) can be used for Azure NetApp Files (all tiers).
  - Azure Backup can be used also to protect Host Pool VMs, this practice is supported, even if Host Pool VMs should be stateless.

### Infrastructure & Application Dependencies

- If users of the WVD infrastructure need on-premises resource access, high availability of network infrastructure required to connect is also critical and should be considered.
- Resiliency of authentication infrastructure needs to be assessed and evaluated.
- BCDR aspects for dependent applications and other resources need to be considered to ensure availability in the secondary DR location.

## Design recommendations

The following are best practices for your design:

- For WVD Host Pool compute deployment model BCDR, use *active-passive* option if it will satisfy your requirements for Recovery Point Objective (RPO) and Recovery Time Objective (RTO).

- Azure Site Recovery is recommended for Personal (*dedicated*) Host Pools. Target region should be aligned with the disaster recovery of the storage backend used by FSLogix.
  - Azure Site Recovery is also supported for Pooled (*shared*) Host Pools. This option can be evaluated and compared to the deployment of another Host Pool in the secondary DR region.

- When maximum resiliency of the Host Pool is required in a single region, Availability Zones should be used.
  - Customers need to verify Availability Zones feature availability in the specific region, and availability of specific VM SKU inside all the zones.

- We recommend storing FSLogix user Profile and Office Containers on Azure Files or Azure NetApp Files for most customer scenarios.
  - It is recommended to split user Profile and Office Containers.
  - Recommended options for container storage types are (in order): Azure Files Premium, Azure NetApp Files Standard and Azure NetApp Files Premium, depending on the resources and latency required by the specific workload.
  - For optimal performance, FSLogix containers should be located on storage as close as possible to the VM which the user is logged on to, preferably in the same datacenter.
  
- Azure storage built-in replication mechanisms should be used for BCDR when possible for less critical environment:
  - Use Zone Replicated Storage (ZRS) or Geo replicated storage (GRS) for Azure Files is recommended.
  - LRS with local only resiliency can be used if no zone/region protection is required.
  
> [!NOTE]
> With Azure File Share Premium tier, or Azure File Share Standard tier with Large File Support enabled, GRS is not available.

- Cloud Cache should be used only when:
  - User Profile or Office containers data availability requires high-availability, an SLA is critical and need to be resilient to region failure.
  - Selected storage option is not able to satisfy BCDR requirements. For example, with Azure File Share Premium tier, or Azure File Share Standard with Large File Support enabled, GRS is not available.
  - When replication between disparate storage is required.

- When Cloud Cache is used, below is recommended:
  - Use SSD for the Managed Disk of the WVD Host Pool VMs.
  - A backup solution must be in place to protect user Profile and Office Containers.
  - Consideration of the size of the local VM managed disk in order to accomodate the local cache of all users FSLogix Profile/Office containers.

- Use Azure Shared Image Gallery to replicate golden images to different regions.
  - Storage used for image creation should be Zone Replicated Storage (ZRS), and at least two copies per region should be maintained.

- Use Azure Backup to protect critical user data from data loss, or logical corruption, when Azure File Share Standard or Premium tiers are used.
  - Use Snapshots and Policies when Azure NetApp Files service is used.
  - Even if supported, using Azure Backup to save VM state in the Host Pool is not recommended since should be stateless.

- Carefully review your resiliency and BCDR plans for dependent resources (networking, authentication, applications, and other internal services either in Azure or on-premises).
  - Network infrastructure, as part of Hub & Spoke or virtual WAN architecture, must be available also in the secondary region.
  - Hybrid connectivity must be highly available in both the primary and secondary regions.
  - Active Directory authentication must be available in the disaster recovery region, or connectivity to on-premises domain must be guaranteed.
