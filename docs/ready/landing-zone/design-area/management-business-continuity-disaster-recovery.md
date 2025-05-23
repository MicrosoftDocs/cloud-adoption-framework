---
title: Business continuity and disaster recovery
description: Design area guidance for business continuity and disaster recovery
author: Zimmergren
ms.author: pnp
ms.date: 02/27/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Business continuity and disaster recovery

Organization and enterprise application workloads have recovery time objective (RTO) and recovery point objective (RPO) requirements. Effective business continuity and disaster recovery (BCDR) design provides platform-level capabilities that meet these requirements. To design BCDR capabilities, capture platform disaster recovery (DR) requirements.

## Design considerations

Consider the following factors when designing BCDR for application workloads:

- Application and data availability requirements:
  - RTO and RPO requirements for each workload.
  - Support for active-active and active-passive availability patterns.

- BCDR as a service for platform-as-a-service (PaaS) services:
  - Native DR and high-availability (HA) feature support.
  - Geo-replication and DR capabilities for PaaS services.

- Support for multiregion deployments for failover, with component proximity for performance.

- Application operations with reduced functionality or degraded performance during an outage.

- Workload suitability for Availability Zones or availability sets:
  - Data sharing and dependencies between zones.
  - Availability Zones compared to availability sets impact on update domains.
  - Percentage of workloads that can be under maintenance simultaneously.
  - Availability Zones support for specific virtual machine (VM) stock-keeping units (SKUs). For example, Azure Ultra Disk Storage requires using Availability Zones.

- Consistent backups for applications and data:
  - VM snapshots.
  - Azure Backup Recovery Services vaults.
  - Subscription limits restricting the number of Recovery Services vaults and the size of each vault.

- Network connectivity if a failover occurs:
  - Bandwidth capacity planning for Azure ExpressRoute.
  - Traffic routing during a regional, zonal, or network outage.

- Planned and unplanned failovers:
  - IP address consistency requirements, and the potential need to maintain IP addresses after failover and failback.
  - Maintaining engineering DevOps capabilities.
  - Azure Key Vault DR for application keys, certificates, and secrets.

- Data residency:
  - Understand the in-country/region guidance for data residency that specifies whether data should be kept within country or regional borders. This guidance affects your design for cross-region replication.
  - Azure regions that reside within the same geography as their enabled set can help with cross-region replication to meet data residency requirements such as tax and law enforcement requirements. For more information, see [Azure cross-region replication](/azure/reliability/cross-region-replication-azure).


## Design recommendations

The following design practices support BCDR for application workloads:

- Employ Azure Site Recovery for Azure-to-Azure VM DR scenarios.

  Site Recovery uses real-time replication and recovery automation to replicate workloads across regions. Built-in platform capabilities for VM workloads meet low RPO and RTO requirements. You can use Site Recovery to run recovery drills without affecting production workloads. You can also use Azure Policy to enable replication and to audit VM protection.

- Use native PaaS DR capabilities.

  Built-in PaaS features simplify both design and deployment automation for replication and failover in workload architectures. Organizations that define service standards can also audit and enforce the service configuration through Azure Policy.

- Use Azure-native backup capabilities.

  Azure Backup and PaaS-native backup features remove the need for third-party backup software and infrastructure. As with other native features, you can set, audit, and enforce backup configurations with Azure Policy to ensure compliance with organization requirements.

- Use multiple regions and peering locations for ExpressRoute connectivity.

  A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affects an Azure region or peering provider location.

- Avoid using overlapping IP address ranges in production and DR networks.

  Production and DR networks that have overlapping IP addresses require a failover process that can complicate and delay application failover. When possible, plan for a BCDR network architecture that provides concurrent connectivity to all sites.
