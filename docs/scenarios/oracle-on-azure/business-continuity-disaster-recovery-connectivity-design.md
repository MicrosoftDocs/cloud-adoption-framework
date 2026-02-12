---
title: Network Topology and Connectivity for Oracle Exadata Database@Azure - BCDR Connectivity Design
description: Learn about considerations and recommendations for Oracle Database@Azure BCDR connectivity design, including best practices, optimization, and guidance.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/08/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Exadata Database@Azure - BCDR connectivity design

This article focuses on high availability (HA) and disaster recovery (DR) connectivity considerations for Oracle Exadata Database@Azure deployments. It begins with single-region redundancy and then expands to cross-region architectures. The goal is to sustain operation during localized faults while separately meeting low recovery point objective (RPO) and recovery time objective (RTO) targets through properly engineered failover and replication paths.

You must address the following key requirements:

- **Low latency:** Minimize latency for database traffic for optimal performance.

- **Business continuity and disaster recovery (BCDR):** HA of your Oracle Exadata Database@Azure and related applications is crucial to maintain business operations that have low RTO or RPO.

Network connectivity between primary and standby Oracle Exadata Database@Azure instances uses Azure networking and Oracle Cloud Infrastructure (OCI) networking. The default route for this connectivity is through Azure. This article covers networking within Azure to meet BCDR requirements. For more information, see [BCDR for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure-autonomous.md).

## Redundancy within the same region

For single-region redundancy, you need two separate Oracle Exadata Database@Azure deployments. Each deployment should be in a different virtual network and aligned with a different availability zone.

The following diagram shows a single-region redundant setup with two Oracle Exadata Database@Azure deployments in separate virtual networks spanning multiple availability zones.

:::image type="content" source="./media/multiple-availability-zone.svg" alt-text="Diagram that shows in-region redundancy for Oracle Exadata Database@Azure." border="false" lightbox="./media/multiple-availability-zone.svg":::

> [!NOTE]
> Oracle Data Guard uses the underlying Azure network. Data replication occurs through a peered Azure virtual network within the Azure region and doesn't use the OCI network. Azure Virtual Network peering costs apply.

## Redundancy across regions

To achieve cross-region redundancy with Oracle Database@Azure, deploy your primary and standby Exadata infrastructures in separate virtual networks in different Azure regions. You can establish direct connectivity using global virtual network peering, which enables low-latency, high-throughput replication between regions.

The following diagram shows the recommended cross-region configuration that uses global virtual network peering.

:::image type="content" source="./media/cross-region-data-guard.svg" alt-text="Diagram that shows Oracle Database@Azure deployed in two regions connected via global virtual network peering." border="false" lightbox="./media/cross-region-data-guard.svg":::

## Design considerations

- **Networking options for BCDR:** You can establish network connectivity between the primary and standby Oracle Database@Azure instances via Azure networking and OCI networking. The default route for this connectivity is through Azure.

- **Availability zones:** Ensure that the two Oracle Exadata Database@Azure deployments span different availability zones to isolate failures at the availability zone level.

## Design recommendations

- **Network virtual appliances (NVAs):** Minimize the use of NVAs and other appliances in the network path because each extra hop adds latency that can degrade Data Guard replication performance.

- **Asynchronous replication for cross-region DR:** Due to higher cross-region latency, consider using asynchronous Data Guard replication. This mode can handle increased latency without affecting production performance.

## Next step

To prepare for your migration, consider the connection from Oracle Database on-premises to Oracle Exadata Database@Azure. For more information, see [Migration connectivity design](./migration-connectivity-design.md).
