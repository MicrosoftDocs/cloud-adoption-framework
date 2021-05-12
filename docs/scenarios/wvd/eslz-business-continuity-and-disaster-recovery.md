---
title: Enterprise-scale BCDR for Windows Virtual Desktop
description: Learn how this enterprise-scale scenario can improve Business Continuity and Disaster Recovery (BCDR) of the Windows Virtual Desktop.
author: igorpag
ms.author: brblanch
ms.date: 10/31/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business Continuity and Disaster Recovery (BCDR) for Windows Virtual Desktop Enterprise-scale scenario

Windows Virtual Desktop is a managed service that provides Microsoft a control plane for your desktop virtualization environment. The service is free of charge, and Microsoft doesn't offer a financially backed [service level agreement](https://azure.microsoft.com/support/legal/sla/virtual-desktop) (SLA). Despite having no SLA, we try to achieve at least 99.9% availability for the Windows Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

Windows Virtual Desktop offers BCDR to preserve customer metadata during outages. When an outage happens in a region, the service infrastructure components fail over to the secondary location and continue functioning as normal.

To keep your organization's data safe, you might adopt a BCDR strategy. This strategy is for resources that are deployed in your subscription as part of the Windows Virtual Desktop data plane, like host pools and storage.

A good BCDR strategy keeps your critical apps and workload up and running during planned and unplanned service or Azure outages.

For more information, see [Set up a business continuity and disaster recovery plan](/azure/virtual-desktop/disaster-recovery).

## Design considerations

### Host pool compute strategy

- For Windows Virtual Desktop host pool, both *active-active* and *active-passive* can be good BCDR approaches, depending on the requirements.
  - With *active-active*, a single host pool can have VMs from multiple regions. In this scenario, usage of [Cloud Cache](/fslogix/cloud-cache-resiliency-availability-cncpt) is required to actively replicate the user's FSLogix Profile/Office containers between the regions. For Virtual Machines (VMs) in each region, the Cloud Cache registry entry specifying locations needs to be inverted to give precedence to the local one.
    - This configuration is complex. *active-active* protects against storage outages without requiring the user to log in again. It then enables continuous testing of the disaster recovery location. This configuration isn't considered either a performance or cost optimization.
    - Load balancing of incoming user connection can't take proximity into account; all hosts will be equal, and users may be directed to a remote (not optimal) Windows Virtual Desktop host pool VM.
    - This configuration is limited to a *Pooled* (shared) host pool type. For a *Personal* (dedicated) type, once a desktop is assigned to a user on a certain session host VM, it sticks and doesn't change, even if not available.

  - With *active-passive*, [Azure Site Recovery](/azure/site-recovery/site-recovery-overview), or a secondary host pool (hot stand-by), you can use the disaster recovery region options.
    - Azure Site Recovery is supported for both *Personal* (dedicated) and *Pooled* (shared) host pool types, and lets you maintain a single host pool entity.
    - You can create a new host pool in the failover region while keeping all of the resources turned off. For this method, set up new Application Groups in the failover region and assign users to them. You can then use an Azure Site Recovery *Recovery Plan* to turn on host pools and create an orchestrated process.

- For host pool VM resiliency, different [options](/azure/virtual-machines/availability) are available when creating a new Windows Virtual Desktop host pool. It's important to select the right option based on your requirements during creation. These options can't be changed later.

  - The default resiliency option for Windows Virtual Desktop host pool deployment is **Availability Set**. This option only ensures host pool resiliency at the single Azure datacenter level, with formal 99.95% high-availability ([SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9)).

     > [!NOTE]
     > The maximum number of VMs inside an **Availability Set** is 200, as documented in [Subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).

  - Using [Availability Zones](/azure/availability-zones/az-overview), VMs in the host pool are distributed across different datacenters. VMs are still inside the same region, and have higher resiliency and higher formal 99.99% high-availability ([SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9)). Your capacity planning should take into account enough extra compute capacity to ensure Windows Virtual Desktop continues to operate even if a single zone is lost.

     > [!NOTE]
     > An Azure Resource Manager (ARM) template must be used to specify zones. This option isn't available yet in the Azure Portal.

- Critical applications and Multiple host pools
  - Before approaching Windows Virtual Desktop BCDR planning and design, it's important to consider which applications consumed through Windows Virtual Desktop are critical. You might want to separate them from non-critical apps. After separating them, use another host pool with a different disaster recovery approach and capabilities.

### Optimal storage for Profile and Office Containers

- The location of storage used for FSLogix containers is critical to ensure the lowest latency from the host pool VM.

- In a BCDR situation, it's possible to reduce the time taken to back up, restore, and replicate data by separating the user Profile and Office Container disks. FSLogix offers the possibility to place them in separate storage locations. In normal usage, the Office disk can consume many more GB's than the Profile. Backup, replication, and restore of the Profile disk is quicker without the inclusion of the cache data. The Office disk isn't required to be resilient, as it's just a cache of data and can be downloaded again. The data it contains is already present, in full, inside Office 365 on-line services.

  > [!NOTE]
  > The FSLogix Cloud Cache feature is 'write back' by design. This design uses asynchronous replication, which increases performance characteristics to high latency targets.

- OneDrive can be used to redirect [well known folders](/onedrive/redirect-known-folders) (Desktop, Documents, Pictures, Screenshots, and Camera Roll) if present. This redirection enables the resilience of these special folders. The folders can be handled by OneDrive rather than need special consideration in a BCDR scenario.

- Azure offers multiple storage solutions that you can use to store your FSLogix Profile and Office Container. [Storage options for FSLogix profile containers in Windows Virtual Desktop](/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions Azure offers for the Windows Virtual Desktop FSLogix user Profile Container. Storage Spaces Direct (S2D) is also supported with FSLogix and Windows Virtual Desktop. It's a self-managed storage solution that's out of scope for this article. Customers can get the most value out of either Azure Files or Azure NetApp Files while simplifying management of Windows Virtual Desktop. They're the recommended storage solutions for this workload.

- The FSLogix agent can support multiple profile locations for higher resiliency if you configure the VHDLocations registry entry. In this case, a proper [replication mechanism](/azure/virtual-desktop/disaster-recovery#fslogix-configuration) must be in place based on the storage type used. You can use Cloud Cache instead.

#### User Data Storage Replication and Resiliency

In Windows Virtual Desktop, multiple replication mechanisms and strategies can be used for user data in [FSLogix](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix) containers:

- **Profile Pattern #1:** Native Azure storage replication mechanisms. For example, Azure Files Standard [Geo Replicated Storage (GRS) replication](/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region), Azure NetApp Files [Cross Region Replication](/azure/azure-netapp-files/cross-region-replication-introduction), or Azure [Files Sync](/azure/storage/files/storage-sync-files-deployment-guide) for VM-based file servers.

- **Profile Pattern #2:** FSLogix [Cloud Cache](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#using-cloud-cache) has a built-in automatic mechanism to replicate containers between different (up to 4) storage accounts.

- **Profile Pattern #3:** Only set up geo disaster recovery for application data and not for user data or profile containers. Store important application data in separate storages, like OneDrive or other external storage with its own built-in disaster recovery mechanism.

### Golden image availability

If you use custom images to deploy Windows Virtual Desktop Host Pool VMs, it's important to ensure those artifacts are available in all regions if there's a major disaster. Use the [Azure Shared Image Gallery](/azure/virtual-machines/windows/shared-image-galleries) service to replicate images across all regions where a host pool is deployed with redundant storage and multiple copies.

### Backup protection

Preventing data loss for critical user data is important.

1. Assess which data needs to be saved and protected. If you're using OneDrive or some other external storage, saving the user Profile or Office Containers data might not be necessary.

2. Consider the appropriate mechanism to provide protection for critical user data.

   - You can use the [Azure Backup](/azure/backup/backup-overview) service to protect Profile and Office Containers data when it's stored on Azure Files Standard and Premium tiers.
   - You can use Azure NetApp Files [Snapshots](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [Policies](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies) for Azure NetApp Files on all tiers.
   - You can use Azure Backup to protect host pool VMs. This practice is supported even if host pool VMs are stateless.

### Infrastructure and application dependencies

- If users of the Windows Virtual Desktop infrastructure need on-premises resource access, it's critical that you consider the high availability of network infrastructure required to connect.
- Assess and evaluate the resiliency of authentication infrastructure.
- Consider BCDR aspects for dependent applications and other resources. These aspects ensure availability in the secondary disaster recovery location.

## Design recommendations

The following are best practices for your design:

- For the Windows Virtual Desktop host pool compute deployment model BCDR, use the *active-passive* option if it satisfies your requirements for Recovery Point Objective (RPO) and Recovery Time Objective (RTO).

- Azure Site Recovery is recommended for Personal (*dedicated*) host pools. The target region should be aligned with the disaster recovery of the storage backend used by FSLogix.
  - Azure Site Recovery is also supported for Pooled (*shared*) host pools. This option can be evaluated and compared to the deployment of another host pool in the secondary disaster recovery region.

- When maximum resiliency of the host pool is required in a single region, use *Availability Zones*.
  - Verify the *Availability Zones* feature availability in the specific region, and availability of the specific VM SKU inside all the zones.

- We recommend storing FSLogix user Profile and Office Containers on Azure Files or Azure NetApp Files for most scenarios.
  - We recommended that you split user Profile and Office Containers.
  - The recommended options for container storage types are (in order): Azure Files Premium, Azure NetApp Files Standard, and Azure NetApp Files Premium. The recommended storage type depends on the resources and latency required by the specific workload.
  - For optimal performance, place FSLogix containers on storage close to the VM the user is logged on to. Keeping the containers in the same datacenter is best.

- Use Azure storage built-in replication mechanisms for BCDR when possible for less critical environments.
  - Use Zone Replicated Storage (ZRS) or GRS for Azure Files.
  - Use LRS with local only resiliency if no zone/region protection is required.

> [!NOTE]
> GRS isn't available with Azure File Share Premium tier or Azure File Share Standard tier with Large File Support enabled.

- Only use Cloud Cache when:
  - The user Profile or Office Containers data availability requires high-availability, or an SLA is critical and must be resilient to region failure.
  - The selected storage option can't satisfy BCDR requirements. For example, GRS isn't available with Azure File Share Premium tier or Azure File Share Standard with Large File Support enabled.
  - Replication between disparate storage is required.

- We recommend the following guidelines when using Cloud Cache:
  - Use a Solid State Drive (SSD) for the managed disk of the Windows Virtual Desktop host pool VMs.
  - Have a backup solution in place to protect user Profile and Office Containers.
  - Make sure that the local VM managed disk is large enough to accommodate the local cache of all user's FSLogix Profile and Office Containers.

- Use an Azure Shared Image Gallery to replicate golden images to different regions.
  - The storage used for image creation should be Zone Replicated Storage (ZRS). At least two copies per region should be maintained.

- Use Azure Backup to protect critical user data from data loss or logical corruption when using Azure File Share Standard or Premium tiers.
  - Use Snapshots and Policies when using the Azure NetApp Files service.
  - Even if supported, using Azure Backup to save your VM state in the host pool isn't recommended since it should be stateless.

- Carefully review your resiliency and BCDR plans for dependent resources. These resources include networking, authentication, applications, and other internal services in Azure or on-premises.
  - Network infrastructure, as part of Hub & Spoke or virtual wide area network (WAN) architecture, must be available in the secondary region.
  - Hybrid connectivity must be highly available in both the primary and secondary regions.
  - Active Directory authentication must be available in the disaster recovery region, or connectivity to the on-premises domain must be guaranteed.
