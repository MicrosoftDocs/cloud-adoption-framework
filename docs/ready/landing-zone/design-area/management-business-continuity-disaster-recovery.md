---
title: Business continuity and disaster recovery
description: Design area guidance for business continuity and disaster recovery
author: DominicAllen
ms.author: doalle
ms.date: 12/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Business continuity and disaster recovery

For effective business continuity and disaster recovery, 

your organization or enterprise needs to design 

suitable, platform-level capabilities that application workloads can consume to meet their requirements.

 Specifically, these application workloads have requirements related to the recover time objective (RTO) and recovery point objective (RPO).

To design BCDR capabilities, make sure to capture disaster recovery (DR) requirements.

## Design considerations

Consider the following factors when designing BCDR for your workloads:

- Application and data availability requirements:
  - Consider workload RTO and RPO requirements.
  - Use *active-active* and *active-passive* availability patterns.

- BCDR as a service for *platform-as-a-service (PaaS)* services:
  - Native DR and high-availability (HA) features include geo-replication and DR capabilities for PaaS services.

- Support for multiregion deployments for failover purposes, with component proximity for performance.

- Application operations with reduced functionality or degraded performance during an outage.

- Workload suitability for Availability Zones or availability sets:
  - Data sharing and dependencies between zones.
  - Impact of Availability Zones compared to availability sets on update domains.
  - Percentage of workloads that can be under maintenance simultaneously.
  - Availability Zones support for specific virtual machine (VM) stock-keeping units (SKUs). Azure Ultra Disk Storage requires using Availability Zones.

- Consistent backups for applications and data:
  - VM snapshots.
  - Azure Backup and Recovery Services vaults.
  - Subscription limits restricting the number of Recovery Services vaults and the size of each vault.

- Network connectivity if a failover occurs:
  - Bandwidth capacity planning for Azure ExpressRoute.
  - Traffic routing if a regional, zonal, or network outage occurs.

- Planned and unplanned failovers:
  - IP address consistency requirements, and the potential need to maintain IP addresses after failover and failback.
  - Maintaining engineering DevOps capabilities.
  - Azure Key Vault DR for application keys, certificates, and secrets.

## Design recommendations

The following design practices support BCDR for your workloads:

- Employ Azure Site Recovery for Azure-to-Azure VM DR scenarios.
  - This enables you to replicate workloads across regions.
  - Site Recovery provides built-in platform capabilities for VM workloads to meet low RPO and RTO requirements through real-time replication and recovery automation. Additionally, the service supports you to run recovery drills without affecting the workloads in production. You can use Azure Policy to enable replication and also audit the protection of your VMs.

- Use native PaaS service disaster recovery capabilities.
  - The built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, simplifying both design and deployment automation. An organization that has defined a standard for the services they use can also audit and enforce the service configuration through Azure Policy.

- Use Azure-native backup capabilities.
  - Azure Backup and PaaS-native backup features remove the need for managing third-party backup software and infrastructure. As with other native features, you can set, audit, and enforce backup configurations with Azure Policy. This ensures that services remain compliant with the organization's requirements.

- Use multiple regions and peering locations for ExpressRoute connectivity.
  - A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affects an Azure region or peering provider location.

- Avoid using overlapping IP address ranges for production and DR sites.
  - When possible, plan for a BCDR network architecture that provides concurrent connectivity to all sites. DR networks that use the same classless interdomain routing blocks like production networks require a network failover process that can complicate and delay application failover if an outage occurs.
