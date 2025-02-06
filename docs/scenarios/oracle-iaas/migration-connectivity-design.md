---
title: Network Topology and Connectivity for Oracle Database@Azure - Migration Connectivity Design
description: Learn about key migration connectivity design considerations and detailed recommendations for Oracle Database@Azure, including best practices.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/10/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network Topology and Connectivity for Oracle Database@Azure - Migration connectivity design

Preparing for a successful Oracle Database@Azure - Exadata Database Service migration often requires you to establish secure, high-bandwidth connectivity between your current source environment and Azure. This article describes foundational networking connectivity strategies for migration. For more information about comprehensive migration steps and methodologies, see [Migrate Oracle workloads to Azure](./oracle-migration-planning.md).

The following architecture diagram describes the connectivity between Oracle Database@Azure - Exadata Database Service and an on-premises or other source site:

:::image type="content" source="./media/on-premises-connectivity.svg" alt-text="Diagram that shows connectivity to Oracle Database@Azure - Exadata Database Service from on-premises environments or other sources." border="false" lightbox="./media/on-premises-connectivity.svg":::

*Figure 1: The previous diagram shows connectivity to Oracle Database@Azure - Exadata Database Service from on-premises environments or other sources.*

> [!NOTE]
> Because of limitations on connectivity from Oracle Database@Azure - Exadata Database Service to Private Endpoints, connectivity to a Private Endpoint requires an intermediate hop through a routing device such as a network virtual appliance (NVA). This appliance can be a Hub NVA such as an Azure Firewall or non-Microsoft NVA. For nonproduction environments, a dedicated [virtual machine can used for IP address forwarding](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/creating-a-local-network-virtual-appliance-in-azure-for-oracle-databaseazure/4218101).

The following diagram includes Azure NetApp Files and doesn't require an intermediate hop for connectivity.

:::image type="content" source="./media/migration-azure-netapp-files.svg" alt-text="Diagram that shows connectivity to other sources and Azure NetApp Files." border="false" lightbox="./media/migration-azure-netapp-files.svg":::

*Figure 2: The previous diagram shows connectivity to other sources and Azure NetApp Files.*

## Design considerations

- **High throughput requirements:** Migrations often require large data transfers. Ensure that network paths support sustained high throughput.

- **Connectivity options:** Both Azure ExpressRoute and VPN tunnels can be used to connect on-premises environments to Oracle Database@Azure - Exadata Database Service. ExpressRoute provides more predictable performance and lower latency.

- **Shared connectivity effects:** If the same ExpressRoute or VPN connection is used by other services, ensure that increased migration traffic doesn't negatively affect their performance.

## Design recommendations

- **Prefer ExpressRoute over VPN:** For on-premises to Oracle Database@Azure - Exadata Database Service connectivity, we recommend ExpressRoute because of its dedicated bandwidth, predictable performance, lower latency, and higher levels of security.

- **Capacity planning:** Confirm that your chosen ExpressRoute circuit has sufficient bandwidth headroom for the migration phase. Ensure that your choice doesn't affect other workloads. If necessary, use bandwidth limiting.

## Next step

After you plan and establish your network connectivity, proceed to [Migrate Oracle workloads to Azure](./oracle-migration-planning.md) to begin or refine your migration strategy.
