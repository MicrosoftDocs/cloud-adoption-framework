---
title: Enterprise-scale business continuity and disaster recovery
description: Learn about enterprise-scale business continuity and disaster recovery in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale business continuity and disaster recovery

For effective business continuity and disaster recovery, your organization or enterprise needs to design suitable, platform-level capabilities that application workloads can consume to meet their requirements. Specifically, these application workloads have requirements related to the recover time objective (RTO) and recovery point objective (RPO). To design capabilities appropriately for these workloads, ensure that you capture disaster recovery (DR) requirements.

## Design considerations

Consider the following factors:

- Application and data availability requirements, and the use of active-active and active-passive availability patterns. For example, workload RTO and RPO requirements.

- Business continuity and DR for platform as a service (PaaS) services, and the availability of native DR and high-availability features.

- Support for multi-region deployments for failover purposes, with component proximity to increase performance.

- Application operations with reduced functionality, or degraded performance in the presence of an outage.

- Workload suitability for Availability Zones or availability sets. Specific factors include:

  - Data sharing and dependencies between zones.

  - The effect of Availability Zones on update domains compared to availability sets.
  
  - The percentage of workloads that can be under maintenance simultaneously.

  - Support for specific virtual machine (VM) stock-keeping units with Availability Zones.

  - Availability Zones required when using Microsoft Azure ultra disk storage.

- Consistent backups for applications and data. Specific factors include:

  - VM snapshots and using Azure Backup and Recovery Services vaults.

  - Subscription limits restricting the number of Recovery Services vaults and the size of each vault.

  - Geo-replication and DR capabilities for PaaS services.

- Network connectivity if a failover occurs. Specific factors include:

  - Bandwidth capacity planning for Azure ExpressRoute.

  - Traffic routing if a regional, zonal, or network outage occurs.

- Planned and unplanned failovers. Specific factors include:

  - IP address consistency requirements and the potential need to maintain IP addresses after failover and failback.

  - Maintained engineering DevOps capabilities.

- Azure Key Vault DR for application keys, certificates, and secrets.

## Design recommendations

Best practices for your design are as follows:

- Employ Azure Site Recovery for Azure-to-Azure VM disaster recovery scenarios. Doing so enables you to replicate workloads across regions.

  Azure Site Recovery provides built-in platform capabilities for VM workloads to meet low RPO and RTO requirements through real-time replication and recovery automation. Additionally, the service supports you to run recovery drills without affecting the workloads in production. Use Azure Policy to enable replication and audit the protection of your VMs.

- Use native PaaS service disaster recovery capabilities.

  Built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, which simplifies both design and deployment automation. An organization that defines a standard for the services it uses can also audit and enforce its service configuration through Azure Policy.

- Use Azure-native backup capabilities.

  Azure Backup and PaaS-native backup features remove the need to manage third-party backup software and infrastructure. As with other native features, you can set, audit, and enforce backup configuration with Azure Policy. Doing so ensures that services remain compliant with the organization's requirements.

- Use multiple regions and peering locations for ExpressRoute connectivity.

  A redundant hybrid network architecture helps ensure uninterrupted cross-premises connectivity if an outage affects an Azure region or peering provider location.

- Avoid using overlapping IP address ranges for production and DR sites.

  When possible, plan for a business continuity and DR network architecture that provides concurrent connectivity to all sites. If an outage occurs, DR networks that use the same classless inter-domain routing blocks, like production networks, require a network failover process that can complicate and delay application failover.
