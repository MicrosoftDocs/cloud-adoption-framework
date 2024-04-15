---
title: Business continuity and disaster recovery for Azure Virtual Desktop
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for an Azure Virtual Desktop environment.
author: igorpag
ms.author: martinek
ms.date: 08/24/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Business continuity and disaster recovery considerations for Azure Virtual Desktop

Azure Virtual Desktop is a Microsoft managed service that provides a control plane for your desktop virtualization environment. Costs for the service are included as part of eligible licenses, see [Azure Virtual Desktop Pricing](https://azure.microsoft.com/pricing/details/virtual-desktop/). Microsoft doesn't offer a financially backed [service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-desktop) for the services. Despite no SLA, we try to achieve at least 99.9 percent availability for the Azure Virtual Desktop service URLs.

> [!NOTE]
> The availability of the session host virtual machines in your subscription is covered by the [Azure Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

A good business continuity and disaster recovery (BCDR) strategy keeps your critical applications and workload up and running during planned and unplanned service or Azure outages. Your strategy should consider resources that are deployed in your subscription as part of the Azure Virtual Desktop data plane, including host pools and storage.

To ensure business continuity, Azure Virtual Desktop also preserves customer metadata during region outages. If an outage occurs, the service infrastructure components fail over to the secondary location and continue to function as usual.

For more information about BCDR considerations for your Azure resources, see [Azure Virtual Desktop disaster recovery](/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop-multi-region-bcdr).

## Design considerations

As you design your Azure Virtual Desktop infrastructure, consider these design factors.

### Host pool active-active vs. active-passive

For an Azure Virtual Desktop host pool, you can use either an *active-active* or an *active-passive* BCDR approach.

#### Active-active host pool

- Storage outages are mitigated without requiring the user to reauthenticate.
- Continuous testing of the disaster recovery location is enabled.
- A single host pool can contain VMs from multiple regions. In this scenario, you must use [Cloud Cache](/fslogix/cloud-cache-resiliency-availability-cncpt) to actively replicate the user's FSLogix profile and Office containers between regions.
- For virtual machines (VMs) in each region, invert the Cloud Cache registry entry that specifies locations to give precedence to the local cache registry.
- Load balancing incoming user connections can't take proximity into account. All hosts are equal, and users might be directed to a remote (and not optimal) Azure Virtual Desktop host pool VM.
- This configuration is limited to a *pooled* (shared) host pool type. For a *personal* (dedicated) type, when a desktop is assigned to a user on a certain session host VM, the desktop doesn't change, even if the VM isn't available.
- Cloud Cache doesn't improve the users' sign-on and sign out experience when using poor performing storage. It's common for environments using Cloud Cache to have slightly slower sign-on and sign out times, relative to using traditional VHDLocations, using the same storage. [Review the FSLogix Cloud Cache documentation for recommendations regarding local cache storage](/fslogix/cloud-cache-resiliency-availability-cncpt).
- The active-active host pool configuration often is complex. It isn't considered a performance optimization or a cost optimization.

#### Active-passive host pool

- You can use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) or a secondary host pool (hot standby) to maintain a backup environment.
- You can use Site Recovery for both personal (dedicated) and pooled (shared) host pool types, and you can maintain a single host pool entity.
- You can create a new host pool in the failover region and keep all the resources turned off. For this method, set up new application groups in the failover region and assign users to the groups. Then, you can use a recovery plan in Site Recovery to turn on host pools and create an orchestrated process.

### Host pool resiliency

For host pool VM resiliency, consider these factors:

- When you create a new Azure Virtual Desktop host pool, you can choose from different [availability options](/azure/virtual-machines/availability).
- It's important to select the right option for your requirements when you create the VM. You can't later change availability options for the VM.
-  If you plan to deploy a Single VM Instance, the SLA would depend on the type of the Storage Disk it uses: 
   -  Premium SSD, Ultra Disk or Premium SSD v2 - 99.9%
   -  Standard SSD Managed Disks - 99.5%
   -  Standard HDD Managed Disks - 95%   
- The default resiliency option for Azure Virtual Desktop host pool deployment is to use availability zones. 

- Through [availability zones](/azure/availability-zones/az-overview), VMs in the host pool are distributed across different datacenters. VMs are still in the same region, and they have higher resiliency and a higher formal 99.99 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines). Your capacity planning should include sufficient extra compute capacity to ensure that Azure Virtual Desktop continues to operate, even if a single availability zone is lost.

- Availability Sets - This option ensures host pool resiliency only at the single Azure datacenter level. Azure availability sets for virtual machines have a formal 99.95 percent high-availability [SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines).

  > [!NOTE]
  > The maximum number of VMs inside an availability set is 200, as documented in [Subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).


Before you begin your BCDR planning and design for Azure Virtual Desktop, consider which applications accessed via Azure Virtual Desktop are critical. You might want to separate them from non-critical applications so that you can provision multiple host pools with different disaster recovery approaches and capabilities.

### Optimal storage for profile and Office containers

The storage location you use for your FSLogix containers is critical to ensure the lowest latency from the host pool VM. If you configure the `VHDLocations` registry entry, the FSLogix agent can support multiple profile locations for higher resiliency. You can use Cloud Cache or ensure that a proper [replication mechanism](/azure/virtual-desktop/disaster-recovery#fslogix-configuration) is in place based on the type of storage you use.

Azure offers multiple storage solutions that you can use to store your FSLogix profile and Office containers.

- [Storage options for FSLogix profile containers in Azure Virtual Desktop](/azure/virtual-desktop/store-fslogix-profile) compares the different managed storage solutions that are available.
- Azure Files or Azure NetApp Files for enterprises offer the most value to customers. The Azure services simplify management for Azure Virtual Desktop and are the preferred storage solutions for this workload.
- Storage Spaces Direct also is supported for FSLogix and Azure Virtual Desktop. It's a self-managed storage solution that's out of scope for this article.

#### User data storage replication and resiliency

You can reduce the time it takes to back up, restore, and replicate data after an outage.

- Separate user profile and Office container disks. FSLogix offers the option to place disks in separate storage locations.
- Don't make the Office disk resilient. In normal usage, the Office disk might consume many more gigabytes than the profile disk. It's a cache of data that you can download again from Microsoft 365 online services.
- Use OneDrive to redirect [standard folders](/onedrive/redirect-known-folders) like *Desktop*, *Documents*, *Pictures*, *Saved Pictures*, and *Camera Roll*. The redirection ensures the resilience of this data without special consideration in a BCDR scenario.
- Don't include cache data for the profile disk, so that you can more quickly back up, replicate, and restore the disk.

  > [!NOTE]
  > The FSLogix Cloud Cache feature is *write back* by design. This design uses asynchronous replication, which increases performance characteristics to high-latency targets.

You can use multiple replication mechanisms and strategies for user data in [FSLogix](/fslogix/concepts-configuration-examples) containers.

- **Profile pattern #1:** Use native Azure Storage replication mechanisms. For example, use [geo-redundant storage (GRS)](/azure/storage/common/storage-redundancy#redundancy-in-a-secondary-region) for standard file shares. You can use [cross-region replication](/azure/azure-netapp-files/cross-region-replication-introduction) for Azure NetApp Files, or use [Azure File Sync](/azure/storage/file-sync/file-sync-deployment-guide) for VM-based file servers.

- **Profile pattern #2:** FSLogix [Cloud Cache](/fslogix/concepts-configuration-examples#example-2-standard--high-availability-cloud-cache) has a built-in automatic mechanism to replicate containers between up to four different storage accounts.

- **Profile pattern #3:** Set up geo-disaster recovery only for application data and not for user data or profile containers. Store important application data in separate storage locations, like OneDrive or another external storage option that has a built-in disaster recovery mechanism.

### Golden image availability

If you use custom images to deploy Azure Virtual Desktop host pool VMs, it's important to ensure that those artifacts are available in all regions if a major disaster occurs. Use the [Azure Compute Gallery](/azure/virtual-machines/shared-image-galleries) service to replicate images in all regions where a host pool is deployed with redundant storage and multiple copies.

### Backup protection

Preventing data loss in critical user data is important. For backup protection, consider these factors:

- Assess which data you need to save and protect. If you use OneDrive or another external storage option, you might not need to save the user profile or Office container data.
- Consider the optimal way to protect critical user data.
- You can use the [Azure Backup](/azure/backup/backup-overview) service to protect profile and Office container data when it's stored in the Azure Files Standard tier or Premium tier.
- You can use Azure NetApp Files [snapshots](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots) and [policies](/azure/azure-netapp-files/azure-netapp-files-manage-snapshots#manage-snapshot-policies) for Azure NetApp Files on all tiers.
- You can use Azure Backup to protect host pool VMs. This practice is supported even if host pool VMs are stateless.

### Infrastructure and application dependencies

If Azure Virtual Desktop users need access to on-premises resources, it's critical that you consider high availability in the network infrastructure that's required to connect to the resources. Assess and evaluate the resiliency of your authentication infrastructure, and consider BCDR aspects for dependent applications and other resources. These considerations will help ensure availability in the secondary disaster recovery location.

### Data Locations for Azure Virtual Desktop

Azure Virtual Desktop stores various information for service objects, such as host pool names, application group names, workspace names, and user principal names. Data is categorized into different types, such as customer input, customer data, diagnostic data, and service-generated data. For more information, see [Data locations for Azure Virtual Desktop](/azure/virtual-desktop/data-locations#data-locations).

Stored information is encrypted at rest, and geo-redundant mirrors are maintained within the geography. Data generated by the Azure Virtual Desktop service is replicated within the Azure geography for disaster recovery purposes.

User-created or app-related information, such as app settings and user data, resides in the Azure region you choose and isn't managed by the Azure Virtual Desktop service.


## Design recommendations

We recommend that you incorporate these best practices into your infrastructure design:

- For the Azure Virtual Desktop host pool compute deployment model BCDR, use the active-passive option if it satisfies your requirements for recovery point objective (RPO) and recovery time objective (RTO).
- We recommend Azure Site Recovery for personal (*dedicated*) host pools. The target region should be aligned with the disaster recovery of the storage back end that FSLogix uses.
- Azure Site Recovery is also supported for pooled (*shared*) host pools. This option can be evaluated and compared to the deployment of another host pool in the secondary disaster recovery region.
- When maximum resiliency of the host pool is required in a single region, use availability zones. Verify that the availability zones feature is available in the specific region. Verify that the specific VM SKU is available in all your availability zones.

For most scenarios, we recommend that you use Azure Files or Azure NetApp Files to store FSLogix user profile and Office containers.

- Split user profile and Office containers.
- We recommend these options for container storage types, in this order: 

   1. Azure Files Premium tier
   1. Azure NetApp Files Standard tier
   1. Azure NetApp Files Premium tier
- The optimum storage type depends on the resources and latency that your workload requires.
- For optimal performance, place FSLogix containers in storage that's close to the VM the user is signed in to. It's best to keep the containers in the same datacenter.

- When possible, use Azure Storage built-in replication mechanisms for BCDR for environments that are less critical.
  - Use zone-redundant storage (ZRS) or GRS for Azure Files.
  - Use local redundant storage (LRS) with local-only resiliency if no zone or region protection is required.

  > [!NOTE]
  > GRS isn't available with the Azure Files Premium tier or Standard tier if large file support is enabled.

- Use Cloud Cache only in these circumstances:
  - The user profile or Office container data availability requires high availability or an SLA is critical and must be resilient to region failure.
  - The selected storage option can't satisfy BCDR requirements. For example, GRS isn't available with the Azure Files Premium tier or Standard tier with large file support enabled.
  - Replication between disparate storage is required.

- We recommend that you follow these guidelines if you use Cloud Cache:
  - Use a solid-state drive (SSD) for the managed disk of the Azure Virtual Desktop host pool VMs.
  - Have a backup solution in place to protect user profile and Office containers.
  - Make sure that the managed disk for the local VM is large enough to accommodate the local cache of all users' FSLogix profile and Office containers.

- Use Azure Compute Gallery to replicate golden images to different regions.
  - Golden images don't participate in providing users the ability to connect to their session host VM. However, they play a critical role in how quickly you are able to run the provisioning process of new virtual machines on a host pool and therefore must be backed up and available.
  - Use ZRS to create the image. Maintain at least two copies of the image per region.

- Use Azure Backup to protect critical user data from data loss or logical corruption when you use the Azure Files Standard tier or Premium tier.
  - Use snapshots and policies when you use the Azure NetApp Files service.
  - We recommend that you don't use Azure Backup to save your VM state in the host, even if the option is supported. The VM that's saved in the host pool should be stateless.

- Carefully review your resiliency and BCDR plans for dependent resources. These resources include networking, authentication, applications, and other internal services in Azure or in your on-premises environment.
  - Network infrastructure, as part of a hub-and-spoke architecture or as a virtual wide area network (virtual WAN) architecture must be available in the secondary region.
  - Hybrid connectivity must be highly available in both the primary region and the secondary region.
  - Active Directory authentication must be available in the disaster recovery region or connectivity to the on-premises domain must be guaranteed.


## Next steps

- Carefully review your resiliency and BCDR plans for dependent resources. These resources include networking, authentication, applications, and other internal services in Azure or on-premises.
  - Network infrastructure, as part of a hub-and-spoke or virtual wide area network (WAN) architecture, must be available in the secondary region.
  - Hybrid connectivity must be highly available in the primary and secondary regions.
  - Active Directory authentication must be available in the disaster recovery region, or connectivity to the on-premises domain must be guaranteed.

- Learn about security, governance, and compliance for an Azure Virtual Desktop enterprise-scale scenario.

  > [!div class="nextstepaction"]
  > [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
