---
title: Network Topology and Connectivity for Oracle Database@Azure - Migration Connectivity Design
description: Learn about key migration connectivity design considerations and detailed recommendations for Oracle Database@Azure, including best practices.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure - Migration connectivity design

A successful Oracle Exadata Database@Azure migration depends on secure, high-bandwidth connectivity between your source environment and Azure. This article outlines foundational networking strategies to support your migration. For more information about comprehensive migration steps and methodologies, see [Migrate Oracle workloads to Azure](./oracle-migration-planning.md).

The following diagram illustrates how Oracle Exadata Database@Azure can connect to on-premises networks and other source environments.

:::image type="content" source="./media/migration.svg" alt-text="Diagram that shows connectivity to Oracle Exadata Database@Azure from on-premises environments or other sources." border="false" lightbox="./media/migration.svg":::

> [!NOTE] 
> The virtual network in the diagram includes both an Azure Storage account and Azure NetApp Files for illustration purposes. Deployments usually use only one storage solution depending on workload and migration requirements.

## Design considerations

- **High throughput requirements:** Migrations often require large data transfers. Ensure that the selected network path can support sustained high throughput to minimize migration time.

- **Connectivity options:** Both Azure ExpressRoute and VPN tunnels can be used to connect on-premises environments to Oracle Exadata Database@Azure. ExpressRoute provides more predictable performance and lower latency.

- **Shared connectivity effects:** If the same ExpressRoute or VPN connection is used by multiple services, ensure adequate bandwidth to prevent contention or performance degradation.

## Design recommendations

- **Prefer ExpressRoute over VPN:** For on-premises to Oracle Exadata Database@Azure connectivity, we recommend ExpressRoute because of its dedicated bandwidth, predictable performance, lower latency, and higher levels of security.

- **Capacity planning:** Ensure that your chosen ExpressRoute or VPN connection has adequate bandwidth available to support migration workloads and avoid service impact. If necessary, use bandwidth limiting.

## Next step

After you plan and establish your network connectivity, proceed to [Migrate Oracle workloads to Azure](./oracle-migration-planning.md) to begin or refine your migration strategy.
