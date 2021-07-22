---
title: Enterprise-scale BCDR for Azure Virtual Desktop
description: Learn how this enterprise-scale scenario can improve business continuity and disaster recovery (BCDR) of the Azure Virtual Desktop.
author: igorpag
ms.author: brblanch
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business continuity and disaster recovery (BCDR) for Azure Virtual Desktop enterprise-scale scenario

Azure Virtual Desktop is a managed service that provides Microsoft a control plane for your desktop virtualization environment. The service is free of charge, and Microsoft doesn't offer a financially backed [service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-desktop). Despite having no SLA, we try to achieve at least 99.9% availability for the Azure Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

Azure Virtual Desktop offers BCDR to preserve customer metadata during outages. When an outage happens in a region, the service infrastructure components fail over to the secondary location and continue functioning as normal.

To keep your organization's data safe, you might adopt a BCDR strategy. This strategy is for resources that are deployed in your subscription as part of the Azure Virtual Desktop data plane, like host pools and storage.

A good BCDR strategy keeps your critical applications and workload up and running during planned and unplanned service or Azure outages.

For more information, see [Set up a business continuity and disaster recovery plan](/azure/virtual-desktop/disaster-recovery).

## Design considerations

### Host pool compute strategy

- For Azure Virtual Desktop host pool, both *active-active* and *active-passive* can be good BCDR approaches, depending on the requirements.
  - With *active-active*, a single host pool can have VMs from multiple regions. In this scenario, usage of [cloud cache](/fslogix/cloud-cache-resiliency-availability-cncpt) is required to actively replicate the user's FSLogix profile and office containers between the regions. For virtual machines (VMs) in each region, the cloud cache registry entry specifying locations needs to be inverted to give precedence to the local one.
    - This configuration is complex. *active-active* protects against storage outages without requiring the user to log in again. It then enables continuous testing of the disaster recovery location. This configuration isn't considered either a performance or cost optimization.
    - Load balancing of incoming user connection can't take proximity into account; all hosts will be equal, and users may be directed to a remote (not optimal) Azure Virtual Desktop host pool VM.
    - This configuration is limited to a *Pooled* (shared) host pool type. For a *Personal* (dedicated) type, once a desktop is assigned to a user on a certain session host VM, it sticks and doesn't change, even if not available.

  - With *active-passive*, [Azure Site Recovery](/azure/site-recovery/site-recovery-overview), or a secondary host pool (hot stand-by), you can use the disaster recovery region options.
    - Azure Site Recovery is supported for both *Personal* (dedicated) and *Pooled* (shared) host pool types, and lets you maintain a single host pool entity.
    - You can create a new host pool in the failover region while keeping all of the resources turned off. For this method, set up new application groups in the failover region and assign users to them. You can then use a recovery plan in Azure Site Recovery to turn on host pools and create an orchestrated process.

- For host pool VM resiliency, different [options](/azure/virtual-machines/availability) are available when creating a new Azure Virtual Desktop host pool. It's important to select the right option based on your requirements during creation. These options can't be changed later.

  - The default resiliency option for Azure Virtual Desktop host pool deployment is **Availability Set**. This option only ensures host pool resiliency at the single Azure datacenter level, with formal 99.95 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

     > [!NOTE]
     > The maximum number of VMs inside an **Availability Set** is 200, as documented in [Subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).

  - Using [Availability Zones](/azure/availability-zones/az-overview), VMs in the host pool are distributed across different datacenters. VMs are still inside the same region, and have higher resiliency and higher formal 99.99 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines). Your capacity planning should take into account enough extra compute capacity to ensure Azure Virtual Desktop continues to operate even if a single zone is lost.

     > [!NOTE]
     > An Azure Resource Manager (ARM) template must be used to specify zones. This option isn't available yet in the Azure portal.

- Critical applications and multiple host pools
  - Before approaching Azure Virtual Desktop BCDR planning and design, it's important to consider which applications consumed through Azure Virtual Desktop are critical. You might want to separate them from non-critical applications. After separating them, use another host pool with a different disaster recovery approach and capabilities.

### Optimal storage for profile and office containers

- The location of storage used for FSLogix containers is critical to ensure the lowest latency from the host pool VM.

- In a BCDR situation, it's possible to reduce the time taken to back up, restore, and replicate data by separating the user profile and office container disks. FSLogix offers the possibility to place them in separate storage locations. In normal usage, the office disk can consume many more gigabytes than the profile. Backup, replication, and restore of the profile disk is quicker without the inclusion of the cache data. The office disk isn't required to be resilient, as it's just a cache of data and can be downloaded again. The data it contains is already entirely inside Microsoft 365 online services.

  > [!NOTE]
  > The FSLogix cloud cache feature is *write back* by design. This design uses asynchronous replication, which increases performance characteristics to high latency targets.

- OneDrive can be used to redirect [well known folders](/onedrive/redirect-known-folders) (`Desktop`, `Documents`, `Pictures`, `Screenshots`, and `Camera Roll`) if present. This redirection enables the resilience of these special folders. The folders can be handled by OneDrive rather than need special consideration in a BCDR scenario.

- Azure offers multiple storage solutions that you can use to store your FSLogix profile and office container. [Storage options for FSLogix profile containers in Azure Virtual Desktop](/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions Azure offers for the Azure Virtual Desktop FSLogix user profile container. Storage Spaces Direct is also supported with FSLogix and Azure Virtual Desktop. It's a self-managed storage solution that's out of scope for this article. Customers can get the most value out of either Azure Files or Azure NetApp Files while simplifying management of Azure Virtual Desktop. They're the recommended storage solutions for this workload.

- The FSLogix agent can support multiple profile locations for higher resiliency if you configure the `VHDLocations` registry entry. In this case, a proper [replication mechanism](/azure/virtual-desktop/disaster-recovery#fslogix-configuration) must be in place based on the storage type used. You can use cloud cache instead.

#### User data storage replication and resiliency

In Azure Virtual Desktop, multiple replication mechanisms and strategies can be used for user data in [FSLogix](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix) containers:

- **Profile pattern #1:** Native Azure Storage replication mechanisms. For example [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region) for standard file shares, [cross-region replication](/azure/azure-netapp-files/cross-region-replication-introduction) of Azure NetApp Files, or [Azure File Sync](/azure/storage/file-sync/file-sync-deployment-guide) for VM-based file servers.

- **Profile pattern #2:** FSLogix [cloud cache](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#using-cloud-cache) has a built-in automatic mechanism to replicate containers between up to four different storage accounts.

- **Profile pattern #3:** Only set up geo-disaster recovery for application data and not for user data or profile containers. Store important application data in separate storages, like OneDrive or other external storage with its own built-in disaster recovery mechanism.

### Golden image availability

If you use custom images to deploy Azure Virtual Desktop host pool VMs, it's important to ensure those artifacts are available in all regions if there's a major disaster. Use the [Azure Shared Image Gallery](/azure/virtual-machines/shared-image-galleries) service to replicate images across all regions where a host pool is deployed with redundant storage and multiple copies.

### Backup protection

Preventing data loss for critical user data is important.

- Assess which data needs to be saved and protected. If you're using OneDrive or some other external storage, saving the user profile or office container data might not be necessary.

- Consider the appropriate mechanism to provide protection for critical user data.

  - You can use the [Azure Backup](/azure/backup/backup-overview) service to protect profile and office container data when stored in either Azure Files Standard tier or Premium tier.
  - You can use Azure NetApp Files [snapshots](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [policies](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies) for Azure NetApp Files on all tiers.
  - You can use Azure Backup to protect host pool VMs. This practice is supported even if host pool VMs are stateless.

### Infrastructure and application dependencies

- If users of the Azure Virtual Desktop infrastructure need on-premises resource access, it's critical that you consider the high availability of network infrastructure required to connect.
- Assess and evaluate the resiliency of authentication infrastructure.
- Consider BCDR aspects for dependent applications and other resources. These aspects ensure availability in the secondary disaster recovery location.

## Design recommendations

The following are best practices for your design:

- For the Azure Virtual Desktop host pool compute deployment model BCDR, use the *active-passive* option if it satisfies your requirements for recovery point objective (RPO) and recovery time objective (RTO).

- Azure Site Recovery is recommended for personal (*dedicated*) host pools. The target region should be aligned with the disaster recovery of the storage backend used by FSLogix.
  - Azure Site Recovery is also supported for pooled (*shared*) host pools. This option can be evaluated and compared to the deployment of another host pool in the secondary disaster recovery region.

- When maximum resiliency of the host pool is required in a single region, use *Availability Zones*.
  - Verify the *Availability Zones* feature availability in the specific region, and availability of the specific VM SKU inside all the zones.

- We recommend storing FSLogix user profile and office containers on Azure Files or Azure NetApp Files for most scenarios.
  - We recommended that you split user profile and office containers.
  - The recommended options for container storage types are (in order): Azure Files Premium tier, Azure NetApp Files Standard tier, and Azure NetApp Files Premium tier. The recommended storage type depends on the resources and latency required by the specific workload.
  - For optimal performance, place FSLogix containers on storage close to the VM the user is logged on to. Keeping the containers in the same datacenter is best.

- Use Azure Storage built-in replication mechanisms for BCDR when possible for less critical environments.
  - Use zone-redundant storage (ZRS) or GRS for Azure Files.
  - Use LRS with local only resiliency if no zone/region protection is required.

> [!NOTE]
> GRS isn't available with Azure Files Premium tier or Standard tier with large file support enabled.

- Only use cloud cache when:
  - The user profile or office container data availability requires high-availability, or an SLA is critical and must be resilient to region failure.
  - The selected storage option can't satisfy BCDR requirements. For example, GRS isn't available with Azure Files Premium tier or Standard tier with large file support enabled.
  - Replication between disparate storage is required.

- We recommend the following guidelines when using cloud cache:
  - Use a solid-state drive (SSD) for the managed disk of the Azure Virtual Desktop host pool VMs.
  - Have a backup solution in place to protect user profile and office containers.
  - Make sure that the managed disk for the local VM is large enough to accommodate the local cache of all user's FSLogix profile and office containers.

- Use an Azure Shared Image Gallery to replicate golden images to different regions.
  - The storage used for image creation should be zone-redundant storage (ZRS). At least two copies per region should be maintained.

- Use Azure Backup to protect critical user data from data loss or logical corruption when using either Azure Files Standard tier or Premium tier.
  - Use snapshots and policies when using the Azure NetApp Files service.
  - Even if supported, using Azure Backup to save your VM state in the host pool isn't recommended since it should be stateless.

- Carefully review your resiliency and BCDR plans for dependent resources. These resources include networking, authentication, applications, and other internal services in Azure or on-premises.
  - Network infrastructure, as part of hub and spoke or virtual wide area network (WAN) architecture, must be available in the secondary region.
  - Hybrid connectivity must be highly available in both the primary and secondary regions.
  - Active Directory authentication must be available in the disaster recovery region, or connectivity to the on-premises domain must be guaranteed.
