---
title: Azure management - business continuity and disaster recovery
description: Design area guidance for business continuity and disaster recovery
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Management - business continuity and disaster recovery

For effective business continuity and disaster recovery, your organization or enterprise needs to design suitable, platform-level capabilities that application workloads can consume to meet their requirements. Specifically, these application workloads have requirements related to the recover time objective (RTO) and recovery point objective (RPO).

## Business continuity and disaster recovery - design considerations

 To design capabilities appropriately for these workloads, ensure that you capture disaster recovery (DR) requirements.

Consider the following factors:

|Scope|Context|
|-|-|
|Application and data availability requirements| Using active-active and active-passive availability patterns (such as workload RTO and RPO requirements)|
|Business continuity and DR for platform as a service (PaaS) services |Availability of native DR and high-availability features <br> Geo-replication and DR capabilities for PaaS services|
|Support for multiregion deployments for failover purposes| With component proximity for performance reasons|
|Application operations with reduced functionality or degraded performance in the presence of an outage| |
|Workload suitability for Availability Zones or availability sets|  - Data sharing and dependencies between zones <br>   - The impact of Availability Zones on update domains compared to availability sets and the percentage of workloads that can be under maintenance simultaneously <br> -  Support for specific virtual machine (VM) stock-keeping units with Availability Zones. <br>   - Using Availability Zones is required if Microsoft Azure Ultra Disk Storage is used.|
|Consistent backups for applications and data| - VM snapshots and using Azure Backup and Recovery Services vaults <br>   - Subscription limits restricting the number of Recovery Services vaults and the size of each vault <br> |
|Network connectivity if a failover occurs|  - Bandwidth capacity planning for Azure ExpressRoute. <br>  - Traffic routing if a regional, zonal, or network outage occurs|
|Planned and unplanned failovers |  - IP address consistency requirements and the potential need to maintain IP addresses after failover and failback. <br>   - Maintained engineering DevOps capabilities. <br> - Azure Key Vault DR for application keys, certificates, and secrets|

## Business continuity and disaster recovery - design recommendations

The following are best practices for your design:

|Scope|Context|
|-|-|
|Employ Azure Site Recovery for Azure-to-Azure Virtual Machines disaster recovery scenarios| This enables you to replicate workloads across regions. <br> Site Recovery provides built-in platform capabilities for VM workloads to meet low RPO/RTO requirements through real-time replication and recovery automation. Additionally, the service supports you to run recovery drills without affecting the workloads in production. You can use Azure Policy to enable replication and also audit the protection of your VMs.|
|Use native PaaS service disaster recovery capabilities|  The built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, simplifying both design and deployment automation. An organization that has defined a standard for the services they use can also audit and enforce the service configuration through Azure Policy.|
|Use Azure-native backup capabilities.| Azure Backup and PaaS-native backup features remove the need for managing third-party backup software and infrastructure. As with other native features, you can set, audit, and enforce backup configurations with Azure Policy. This ensures that services remain compliant with the organization's requirements.|
|Use multiple regions and peering locations for ExpressRoute connectivity| A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affects an Azure region or peering provider location.|
|Avoid using overlapping IP address ranges for production and DR sites.| When possible, plan for a business continuity and DR network architecture that provides concurrent connectivity to all sites. DR networks that use the same classless interdomain routing blocks like production networks require a network failover process that can complicate and delay application failover if an outage occurs.|
