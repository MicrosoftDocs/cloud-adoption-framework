---
title: Business continuity and disaster recovery for Azure Virtual Desktop
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for an Azure Virtual Desktop environment.
author: igorpag
ms.author: brblanch
ms.date: 08/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Business continuity and disaster recovery considerations for Azure Virtual Desktop

Azure Virtual Desktop is a Microsoft managed service that provides a control plane for your desktop virtualization environment. The service is free of charge. Microsoft doesn't offer a financially backed [service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-desktop) for the services. Despite no SLA, we try to achieve at least 99.9 percent availability for the Azure Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

A good business continuity and disaster recovery (BCDR) strategy keeps your critical applications and workload up and running during planned and unplanned service or Azure outages. Your strategy should consider resources that are deployed in your subscription as part of the Azure Virtual Desktop data plane, including host pools and storage.

To ensure business continuity, Azure Virtual Desktop also preserves customer metadata during region outages. If an outage occurs, the service infrastructure components fail over to the secondary location and continue to function as usual.

For more information about BCDR considerations for your Azure resources, see [Set up a business continuity and disaster recovery plan](/azure/virtual-desktop/disaster-recovery).

## Design considerations

As you design your Azure Virtual Desktop infrastructure, consider these design factors.

### Host pool active-active vs. active-passive

For an Azure Virtual Desktop host pool, you can use either an *active-active* or an *active-passive* BCDR approach.

#### Active-active host pool

- Storage outages are mitigated without requiring the user to reauthenticate.
- Continuous testing of the disaster recovery location is enabled.
- A single host pool can contain VMs from multiple regions. In this scenario, you must use a [cloud cache](/fslogix/cloud-cache-resiliency-availability-cncpt) to actively replicate the user's FSLogix profile and Office containers between regions.
- For virtual machines (VMs) in each region, the cloud cache registry entry that specifies locations needs to be inverted to give precedence to the local cache registry.
- Load balancing incoming user connections can't take proximity into account. All hosts are equal, and users might be directed to a remote (not optimal) Azure Virtual Desktop host pool VM.
- This configuration is limited to a *pooled* (shared) host pool type. For a *personal* (dedicated) type, when a desktop is assigned to a user on a certain session host VM, it doesn't change, even if the VM isn't available.
- This configuration often is complex. It isn't considered a performance optimization or a cost optimization.

#### Active-passive host pool

- You can use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) or a secondary host pool (hot standby) to maintain a backup environment.
- You can use Azure Site Recovery for both personal (dedicated) and pooled (shared) host pool types, and you can maintain a single host pool entity.
- You can create a new host pool in the failover region and keep all the resources turned off. For this method, set up new application groups in the failover region and assign users to the groups. Then, you can use a recovery plan in Azure Site Recovery to turn on host pools and create an orchestrated process.

### Host pool resiliency

For host pool VM resiliency:

- When you create a new Azure Virtual Desktop host pool, you can choose from different [options](/azure/virtual-machines/availability).
- It's important to select the right option based on your requirements when you create the VM. You can't change the options later.
- The default resiliency option for Azure Virtual Desktop host pool deployment is an availability set. This option only ensures host pool resiliency at the single Azure datacenter level, with a formal 99.95 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

  > [!NOTE]
  > The maximum number of VMs inside an availability set is 200, as documented in [Subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).

- By using [availability zones](/azure/availability-zones/az-overview), VMs in the host pool are distributed across different datacenters. VMs are still inside the same region, and have higher resiliency and a higher formal 99.99 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines). Your capacity planning should include sufficient extra compute capacity to ensure that Azure Virtual Desktop continues to operate, even if a single zone is lost.

  > [!NOTE]
  > You must use an Azure Resource Manager template (ARM template) to specify zones. This option isn't available yet in the Azure portal.

Before you begin your BCDR planning and design for Azure Virtual Desktop, consider which applications your organization accesses via Azure Virtual Desktop are critical. You might want to separate critical applications from non-critical applications so that you can provision multiple host pools with different disaster recovery approaches and capabilities.

### Optimal storage for profile and Office containers

The location of storage that you use for FSLogix containers is critical to ensure the lowest latency from the host pool VM. The FSLogix agent can support multiple profile locations for higher resiliency if you configure the `VHDLocations` registry entry. You can use cloud cache or ensure that a proper [replication mechanism](/azure/virtual-desktop/disaster-recovery#fslogix-configuration) is in place based on the storage type you use.

Azure offers multiple storage solutions that you can use to store your FSLogix profile and Office container:

- [Storage options for FSLogix profile containers in Azure Virtual Desktop](/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions available.
- Azure Files or Azure NetApp Files offers the most value to customers and simplify management of Azure Virtual Desktop. It's the preferred storage solution for this workload.
- Storage Spaces Direct is also supported with FSLogix and Azure Virtual Desktop. It's a self-managed storage solution that's out of scope for this article.

#### User data storage replication and resiliency

You can reduce the time it takes to back up, restore, and replicate data after an outage:

- Separate the user profile and Office container disks. FSLogix offers the option to place disks in separate storage locations.
- Don't make the Office disk resilient. In normal usage, the Office disk can consume many more gigabytes than the profile disk. It's a cache of data that you can download again from Microsoft 365 online services, so don't make the disk resilient.
- Use OneDrive to redirect [standard folders](/onedrive/redirect-known-folders) like Desktop, Documents, Pictures, Screenshots, and Camera Roll. The redirection ensures the resilience of this data without special consideration in a BCDR scenario.
- Don't include cache data for the profile disk so that you can more quickly back up, replicate, and restore the disk.

  > [!NOTE]
  > The FSLogix cloud cache feature is *write-back* by design. This design uses asynchronous replication, which increases performance characteristics to high latency targets.

You can use multiple replication mechanisms and strategies for user data in [FSLogix](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix) containers.

- **Profile pattern #1:** Native Azure Storage replication mechanisms. For example [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region) for standard file shares, [cross-region replication](/azure/azure-netapp-files/cross-region-replication-introduction) of Azure NetApp Files, or [Azure File Sync](/azure/storage/file-sync/file-sync-deployment-guide) for VM-based file servers.

- **Profile pattern #2:** FSLogix [cloud cache](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#using-cloud-cache) has a built-in automatic mechanism to replicate containers between up to four different storage accounts.

- **Profile pattern #3:** Set up geo-disaster recovery only for application data and not for user data or profile containers. Store important application data in separate storages, like OneDrive or another external storage option that has a built-in disaster recovery mechanism.

### Golden image availability

If you use custom images to deploy Azure Virtual Desktop host pool VMs, it's important to ensure those artifacts are available in all regions if there's a major disaster. Use the [Azure Shared Image Gallery](/azure/virtual-machines/shared-image-galleries) service to replicate images across all regions where a host pool is deployed with redundant storage and multiple copies.

### Backup protection

Preventing data loss in critical user data is important.

- Assess which data you need to save and protect. If you're using OneDrive or another external storage option, you might not need to save the user profile or Office container data.
- Consider the optimal way to protect critical user data.
- You can use the [Azure Backup](/azure/backup/backup-overview) service to protect profile and Office container data when it's stored in the Azure Files Standard tier or Premium tier.
- You can use Azure NetApp Files [snapshots](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [policies](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies) for Azure NetApp Files on all tiers.
- You can use Azure Backup to protect host pool VMs. This practice is supported even if host pool VMs are stateless.

### Infrastructure and application dependencies

If users of the Azure Virtual Desktop infrastructure need on-premises resource access, it's critical that you consider the high availability of the network infrastructure that's required to connect. Assess and evaluate the resiliency of your authentication infrastructure, and consider BCDR aspects for dependent applications and other resources. These considerations will help ensure availability in the secondary disaster recovery location.

## Design recommendations

We recommend that you use these best practices as you design your infrastructure:

- For the Azure Virtual Desktop host pool compute deployment model BCDR, use the *active-passive* option if it satisfies your requirements for recovery point objective (RPO) and recovery time objective (RTO).
- Azure Site Recovery is recommended for personal (*dedicated*) host pools. The target region should be aligned with the disaster recovery of the storage backend used by FSLogix.
- Azure Site Recovery is also supported for pooled (*shared*) host pools. This option can be evaluated and compared to the deployment of another host pool in the secondary disaster recovery region.
- When maximum resiliency of the host pool is required in a single region, use availability zones. Verify that the availability zones feature is available in the specific region. Verify that the specific VM SKU is available inside all your availability zones.

For most scenarios, we recommend that you store FSLogix user profile and Office containers on Azure Files or Azure NetApp Files.

- Split user profile and Office containers.
- The recommended options for container storage types are (in order): Azure Files Premium tier, Azure NetApp Files Standard tier, and Azure NetApp Files Premium tier.
- The recommended storage type depends on the resources and latency required by the specific workload.
- For optimal performance, place FSLogix containers on storage close to the VM the user is signed in to. It's best to keep the containers in the same datacenter.

- When possible, use Azure Storage built-in replication mechanisms for BCDR for environments that are less critical.
  - Use zone-redundant storage (ZRS) or GRS for Azure Files.
  - Use LRS with local-only resiliency if no zone or region protection is required.

  > [!NOTE]
  > GRS isn't available with the Azure Files Premium tier or Standard tier if large file support is enabled.

- Use a cloud cache only in these circumstances:
  - The user profile or Office container data availability requires high availability or an SLA is critical and must be resilient to region failure.
  - The selected storage option can't satisfy BCDR requirements. For example, GRS isn't available with the Azure Files Premium tier or Standard tier with large file support enabled.
  - Replication between disparate storage is required.

- We recommend that you follow these guidelines if you use a cloud cache:
  - Use a solid-state drive (SSD) for the managed disk of the Azure Virtual Desktop host pool VMs.
  - Have a backup solution in place to protect user profile and Office containers.
  - Make sure that the managed disk for the local VM is large enough to accommodate the local cache of all user's FSLogix profile and Office containers.

- Use an Azure Shared Image Gallery to replicate golden images to different regions.
  - Use ZRS to create the image. Maintain at least two copies of the image per region.

- Use Azure Backup to protect critical user data from data loss or logical corruption when you use the Azure Files Standard tier or Premium tier.
  - Use snapshots and policies when you use the Azure NetApp Files service.
  - We recommend that you don't use Azure Backup to save your VM state in the host, even if the option is supported. The VM saved in the host pool should be stateless.

- Carefully review your resiliency and BCDR plans for dependent resources. These resources include networking, authentication, applications, and other internal services in Azure or in your on-premises environment.
  - Network infrastructure, as part of a hub-and-spoke architecture or as a virtual wide area network (WAN) architecture must be available in the secondary region.
  - Hybrid connectivity must be highly available in both the primary region and the secondary region.
  - Active Directory authentication must be available in the disaster recovery region or connectivity to the on-premises domain must be guaranteed.

## Next steps

- [Platform automation and DevOps considerations for Azure Virtual Desktop](eslz-platform-automation-and-devops.md)
