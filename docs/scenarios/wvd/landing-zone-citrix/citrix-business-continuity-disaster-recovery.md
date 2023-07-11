---
title: Business continuity and disaster recovery for Citrix on Azure
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for a Citrix on Azure environment.
author: BenMartinBaur 
ms.author: martinek
ms.date: 02/06/2023
ms.topic: conceptual
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Business continuity and disaster recovery considerations for Citrix on Azure

This article describes how you can improve business continuity and disaster recovery (BDCR) for a Citrix on Azure environment. 

## Citrix design considerations

Design considerations for Citrix technologies are summarized in [Design Decision: Disaster Recovery Planning](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/cvad-disaster-recovery.html#overview) on Citrix Tech Zone. This guide assists with BCDR architecture planning and considerations for both on-premises and Azure deployments of Citrix DaaS.

When you deploy Citrix on Azure, we recommended that you follow the same design considerations for [optimal storage for profile and Office containers](../eslz-business-continuity-and-disaster-recovery.md#optimal-storage-for-profile-and-office-containers), [golden image availability](../eslz-business-continuity-and-disaster-recovery.md#golden-image-availability), and [infrastructure and application dependencies](../eslz-business-continuity-and-disaster-recovery.md#infrastructure-and-application-dependencies) that you would follow for Azure Virtual Desktop.

Because Azure VM availability isn't guaranteed by default (including for reserved instances), we recommend that you use the Azure [on-demand capacity reservation](/azure/virtual-machines/capacity-reservation-overview) feature to ensure sufficient availability within the required regions when it's most needed. 

Additional design factors for Citrix on Azure deployments are highlighted in the following sections.

## Machine catalog availability strategies

You can deploy Citrix machine catalogs in an active/active or active/passive configuration by using a combination of Azure and on-premises workloads. 

The following lists aren't inclusive. They contain key highlights. For more information, see [Citrix TechZone - Disaster Recovery Options](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/cvad-disaster-recovery.html).

### Active/active

-	Continuous testing of the disaster recovery location (storage and network) is enabled.
-	A single delivery group can contain VMs from multiple regions. However, active/active business continuity strategies are complex. You need to have a detailed understanding of the associated use cases, data, and applications. Mapping users or apps to regions by using [zone preference](https://docs.citrix.com/en-us/citrix-daas/manage-deployment/zones.html#zone-preference) can help ensure that they're directed to an optimal region if capacity is available.
-	To simplify the use of active/active DR with personal desktops, users are often segmented and aligned to primary and secondary datacenters. In the primary datacenter, a user's active machine is persistent. In the secondary datacenter, a pooled non-persistent machine is on standby with core applications that are required for DR. You can use ephemeral disks on this pooled machine to reduce storage costs. You can use  capabilities like [OneDrive known-folder redirection](/sharepoint/redirect-known-folders) to enable access to critical user data from both machines.
 
### Active/passive

-	Citrix supports the deployment of persistent and non-persistent workloads. For active/passive deployments, you can use a hot standby machine catalog with non-persistent workloads and [ephemeral disks](https://docs.citrix.com/en-us/citrix-daas/install-configure/resource-location/azure-resource-manager.html#azure-ephemeral-disk) to dramatically reduce the cost of the deployment.
-	You can map an active and passive catalog to the same [delivery group](https://docs.citrix.com/en-us/citrix-daas/install-configure/delivery-groups-manage.html) and present it to users as a single app or desktop. [Zone preference](https://docs.citrix.com/en-us/citrix-daas/manage-deployment/zones.html#zone-preference) can then set preference for the users or application to the active region. When capacity is unavailable, workloads in the passive region start based on the unavailable capacity in the active region. You can automate this switch by using functionality like [Autoscale](https://docs.citrix.com/en-us/citrix-daas/manage-deployment/autoscale.html), or you can switch regions manually by placing the passive workloads in maintenance mode and enabling them when a DR event occurs. The method that you use should align with the RTO of your organization's BCDR plan.
-	Cloud bursting from on-premises to Azure is possible. [Autoscale](https://docs.citrix.com/en-us/citrix-daas/manage-deployment/autoscale/autoscale-tagged-machines.html) can help you with this process. You can use the [Citrix image portability service](https://docs.citrix.com/en-us/citrix-daas/migrate-workloads.html#use-the-image-portability-service) to maintain both an on-premises image and an Azure image for two machine catalogs from a single image.

## Azure feature considerations

| Azure feature or service| What is it? | Why is it important? |
|----|----|----|
| [Regions](/azure/availability-zones/az-overview) | A set of datacenters that's deployed within a latency-defined perimeter and connected through a dedicated regional low-latency network. | Your [selection of an Azure region](https://azure.microsoft.com/global-infrastructure/geographies/) should be based on proximity to existing datacenters, users, or required back-end data. You also need to be aware of which services are available in the regions you choose. For Citrix deployments, organizations often start with a single region. However, you should consider using two or more regions in the long term for geographic redundancy in a BCDR strategy. |
| [Azure ExpressRoute](/azure/expressroute/expressroute-faqs) | An Azure service that you can use to create private connections between Microsoft datacenters and infrastructure that's on your premises or in a colocation facility. | ExpressRoute is an essential infrastructure component for bridging a Microsoft datacenter and your organization's datacenter or colocation facility. It's often a prerequisite for an enterprise-scale Citrix deployment. <br> ExpressRoute is a shared service. You should conduct bandwidth capacity planning to determine overall bandwidth needs for the enterprise. If you don't have enough available bandwidth, the user experience or access to key services in the datacenter can be affected. Additionally, Independent Computing Architecture (ICA) performance is affected if sessions cross ExpressRoute to get to the datacenter. |
 | [Availability zones](/azure/availability-zones/az-region) | Unique physical locations within a region. Each zone is made up of one or more datacenters that's equipped with independent power, cooling, and networking. | Availability zones provide a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). You should use them for all applicable Citrix infrastructure and [machine catalogs](https://docs.citrix.com/en-us/citrix-daas/install-configure/resource-location/azure-resource-manager.html#provision-machines-into-specified-availability-zones) to provide datacenter redundancy within a region. Not all regions support availability zones, so you should plan accordingly. |
| [Availability sets](/azure/virtual-machines/availability-set-overview) | A set of VMs that are spread across several fault domains. A *fault domain* is a group of VMs that share a common power source and network switch.  | Availability sets provide a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). You should use them for Citrix infrastructure only if availability zones aren't available in the region. Availability sets only provide hardware redundancy (like hypervisor anti-affinity rules). Therefore, you should use a multiregion strategy to provide datacenter and geographic redundancy if your chosen regions don't have availability zones. |
| [Managed disks](/azure/virtual-machines/managed-disks-overview) | Disks that are managed by Azure and automatically placed in different storage scale units to limit the effects of hardware failure. | You should use managed disks for all Citrix infrastructure and Virtual Delivery Agents (VDAs). We don't recommend the use of unmanaged disks. For information about SLAs for single-instance virtual machines, like a user's VDI or a published application server, see [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). <br> Each type of disk provides different performance and has different associated costs. We recommend Premium  for Citrix infrastructure machines. When determining the disk type for VDAs, factor in cost, performance, and availability needs.|
| [Azure Backup](/azure/backup/backup-overview) | A service that provides cost-effective solutions for backing up your data and recovering it from the Azure cloud. | We recommend Azure Backup for Citrix infrastructure, master image VMs, and persistent desktops. |
| [Resource locks](/azure/azure-resource-manager/management/lock-resources) | A technology that you can use to prevent other users in your organization from accidentally deleting or modifying critical resources. | You should apply resource locks to all Citrix infrastructure and master image VMs. <br>- At a minimum,  you should apply **Delete** to prevent accidental deletion of critical machines. <br>- You should apply **ReadOnly** to Citrix infrastructure machines. These objects are static. Changes should be applied only during appropriate change control windows. |	

## Citrix design recommendations
  
Design guidance for Citrix DaaS on Azure is available on [Citrix TechZone - Design Guidance for Citrix DaaS on Microsoft Azure](https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/design-guidance.html). The article highlights the system, workload, user, and network considerations for aligning Citrix deployments with Cloud Adoption Framework design principles. 
  
You can improve the overall resilience of some Citrix components, like the App Layering ELM appliance, by using [Azure Site Recovery](https://azure.microsoft.com/products/site-recovery). Note that core infrastructure components, like Cloud Connectors and NetScalers, should always be deployed full-time throughout other regions.