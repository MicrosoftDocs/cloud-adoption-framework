---
title: Network Topology and Connectivity for Oracle Database@Azure - BCDR Connectivity Design
description: Learn about considerations and recommendations for Oracle Database@Azure BCDR connectivity design, including best practices, optimization, and guidance.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure - BCDR connectivity design

This article focuses on high availability (HA) and disaster recovery (DR) connectivity considerations for Oracle Exadata Database@Azure deployments. It begins by addressing single-region redundancy, then expands to cross-region architectures to help ensure that your environments remain resilient and meet low recovery point objective (RPO) and recovery time objective (RTO) requirements.

You must address the following key requirements:

- **Low latency:** Minimize latency for database traffic for optimal performance.

- **Business continuity and disaster recovery (BCDR):** HA of your Oracle Exadata Database@Azure and related applications is crucial to maintain business operations that have low RTO or RPO.

Network connectivity between primary and standby Oracle Exadata Database@Azure instances can be established via Azure networking and Oracle Cloud Infrastructure (OCI) networking. The default route for this connectivity is through Azure. This article focuses on architecting for networking within Azure. For more information, see [BCDR for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure.md).

## Redundancy within the same region

For single-region redundancy, you need two separate Oracle Exadata Database@Azure deployments. Each deployment should be in a different virtual network and aligned with a different availability zone.

The following diagram illustrates a single-region redundant setup that uses two Oracle Exadata Database@Azure deployments in separate virtual networks to span multiple availability zones.

:::image type="content" source="./media/multiple-availability-zone.svg" alt-text="Diagram that shows in-region redundancy for Oracle Exadata Database@Azure." border="false" lightbox="./media/multiple-availability-zone.svg":::

> [!NOTE]
> Oracle Data Guard uses the underlying Azure network. Data replication occurs through a peered Azure virtual network within the Azure region and doesn't use the OCI network. Data egress charges apply.

## Redundancy across regions

To deploy a redundant network setup across regions, you can configure traffic in Azure or OCI. The following patterns provide guidance for scenarios when traffic must remain within Azure. The following diagram shows a hub-and-spoke topology.

:::image type="content" source="./media/hub-spoke-multiple-region.svg" alt-text="Diagram that shows a hub-and-spoke topology." border="false" lightbox="./media/hub-spoke-multiple-region.svg":::

The following diagram shows an Azure Virtual WAN topology.

:::image type="content" source="./media/virtual-wan-multiple-region.svg" alt-text="Diagram that shows the Virtual WAN topology." border="false" lightbox="./media/virtual-wan-multiple-region.svg":::

## Design considerations

- **Networking options for BCDR:** You can establish network connectivity between the primary and standby Oracle Database@Azure instances via Azure networking and OCI networking. The default route for this connectivity is through Azure.

- **Egress costs:** Consider egress costs between virtual networks when you replicate data.

- **Availability zones:** Ensure that the two Oracle Exadata Database@Azure deployments span different availability zones to isolate failures at the availability zone level.

- **Data Guard configuration:** For DR within the same region or availability zone, Data Guard should be enabled and configured in synchronous mode to minimize your RTO and RPO targets and optimize performance. For more information, see [BCDR considerations for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure.md).

- **Supported network topologies:** Use Virtual WAN-based connectivity and peering with a hub network.

## Design recommendations

- **Network virtual appliances (NVAs):** Minimize the use of NVAs in the network path because each extra hop adds latency that can degrade Data Guard replication performance.

- **Costs and growth:** Evaluate ingress and egress costs, future growth expectations, and potential changes to your network architecture. Align your design with your business continuity goals and budget constraints.

- **Asynchronous replication for cross-region DR:** Because of higher latency between geographically distant regions, consider using asynchronous Data Guard replication. This mode can handle increased latency without affecting production performance. It also provides robust DR capabilities.

## Next step

To prepare for your migration, consider the connection from Oracle Database on-premises to Oracle Exadata Database@Azure. For more information, see [Migration connectivity design](./migration-connectivity-design.md).
