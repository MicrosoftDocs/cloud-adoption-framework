---
title: "Business Continuity and Disaster Recovery"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Business Continuity and Disaster Recovery
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# F. Business continuity and disaster recovery

### 1. Planning for business continuity and disaster recovery (BCDR)

This section strives to help readers capture customer disaster recovery requirements, to design suitable platform level capabilities that application workloads can subsequently consume to meet their specific RTO and RPO requirements.

***Design considerations***

- Application and data availability requirements and the relative use of active-active and active-passive availability patterns (e.g., workload RPO and RTO requirements).

- BCDR for PaaS services and the availability of native disaster recovery (DR) and high-availability features.

- Support for multi-region deployments, such as for failover purposes.

    - Component proximity for performance reasons.

- Application operation with reduced functionality or degraded performance in the presence of an outage.

- Workload suitability for availability zones or availability sets.

    - Data sharing and dependencies between zones.

    - Impact of Availability Zones on update domains compared to Availability Sets; percentage of workload that can be simultaneously under maintenance.

    - Support for specific VM SKUs with availability zones.

    - If ultra disks are used, using vailability Zones is mandatory.

- Consistent backups for application state and data.

    - VM snapshots and the use of Azure backup and Recovery Services vaults.

    - Subscription limits restricting the number of Recovery Services vault and the size of each vault.

    - Geo-replication and disaster recovery capabilities for PaaS services.

- Network connectivity in the case of a failover.

    - Bandwidth capacity planning for ER.

    - Paired failover regions.

    - Traffic routing in the case of region/zone/network outage.

- Planned and unplanned failovers.

    - IP address consistency requirements and the potential need to maintain IP addresses after failover and failback.

    - Maintained engineering capabilities such as DevOps.

- Key Vault DR for application keys, certificates, and secrets.

***Design recommendations***

- Use Azure Site Recovery for Azure to Azure virtual machine disaister recovery scenarios to replicate workloads across regions.

- Utilize native PaaS service DR capabilities, such as geo-replication for Azure Storage.

- Optimize Azure native backup capabilities, such as Azure Backup, to transfer data to Azure Storage.

- Use multiple regions and on-premises peering locations connected using ExpressRoute.

<!-- -->

- Avoid using overlapping IP address range for production and DR sites.

## Next steps

Suggested design for [security, governance, and compliance](./G-Security-Governance-and-Compliance.md)

> [!div class="nextstepaction"]
> [Security, Governance, and Compliance](./G-Security-Governance-and-Compliance.md)
