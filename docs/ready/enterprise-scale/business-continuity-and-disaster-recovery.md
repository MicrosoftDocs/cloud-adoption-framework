---
title: CAF enterprise-scale business continuity and disaster recovery
description: Learn about enterprise-scale business continuity and disaster recovery in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# CAF enterprise-scale business continuity and disaster recovery

## Planning for business continuity and disaster recovery

Capture disaster recovery (DR) requirements to design suitable platform-level capabilities that application workloads can consume to meet their specific recovery time objective (RTO) and recovery point objective (RPO) requirements.

**Design considerations:**

- Application and data availability requirements and the use of active-active and active-passive availability patterns (such as workload RTO and RPO requirements).

- Business continuity and DR for platform as a service (PaaS) services and the availability of native DR and high-availability features.

- Support for multiregion deployments for failover purposes, with component proximity for performance reasons.

- Application operations with reduced functionality or degraded performance in the presence of an outage.

- Workload suitability for Availability Zones or availability sets.

  - Data sharing and dependencies between zones.

  - Impact of Availability Zones on update domains compared to availability sets and percentage of workloads that can be under maintenance simultaneously.

  - Support for specific virtual machine (VM) stock-keeping units with Availability Zones.

  - Using Availability Zones is required if Microsoft Azure ultra disk storage is used.

- Consistent backups for applications and data.

  - VM snapshots and using Azure Backup and Recovery Services vaults.

  - Subscription limits restricting the number of Recovery Services vaults and the size of each vault.

  - Geo-replication and DR capabilities for PaaS services.

- Network connectivity if a failover occurs.

  - Bandwidth capacity planning for Azure ExpressRoute.

  - Paired failover regions.

  - Traffic routing if a regional, zonal, or network outage occurs.

- Planned and unplanned failovers.

  - IP address consistency requirements and the potential need to maintain IP addresses after failover and failback.

  - Maintained engineering DevOps capabilities.

- Azure Key Vault DR for application keys, certificates, and secrets.

**Design recommendations:**

- Employ Azure Site Recovery for Azure to Azure Virtual Machines disaster recovery scenarios to replicate workloads across regions.

  Site Recovery provides built-in platform capabilities for VM workloads to meet low RPO/RTO requirements through real-time replication and recovery automation. Additionally, the service provides the ability to run recovery drills without affecting the workloads in production.

- Use native PaaS service disaster recovery capabilities.

  The built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, simplifying both design and deployment automation. An organization that has defined a standard for the services they use can also audit and enforce the service configuration through Azure Policy.

- Use Azure-native backup capabilities.

  Azure Backup and PaaS-native backup features remove the need for managing third-party backup software and infrastructure. As with other native features, backup configurations can be set, audited, and enforced with Azure Policy, ensuring that services remain compliant with the organization's requirements.

- Use multiple regions and peering locations for ExpressRoute connectivity.

  A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity in the event of an outage affecting an Azure region or peering provider location.

- Refer to [Azure region pairs](/azure/best-practices-availability-paired-regions) documentation when selecting locations for your organization's disaster recovery layouts.

- Use Azure paired regions when planning for business continuity and DR.

- Planned Azure system updates are rolled out to paired regions sequentially but not at the same time to minimize downtime, the effect of bugs, and logical failures in the rare event of a bad update.

- In the event of a broad outage, recovering one region is prioritized within of every pair. Applications deployed across paired regions are guaranteed to have one of the regions recovered with priority. If an application is deployed across regions that aren't paired, the worst case scenario is that recovery might delay, and the preferred region may be the last to be recovered.

- Avoid using overlapping IP address ranges for production and DR sites.

  When possible, plan for a business continuity and DR network architect that provides concurrent connectivity to all sites. DR networks using the same classless inter-domain routing blocks such as production networks will require a network failover process that can complicate and delay application failover in the event of an outage.