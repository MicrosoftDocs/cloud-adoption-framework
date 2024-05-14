---
title: Define an Azure network topology
description: Learn about key considerations for designing network topologies in Azure. Get recommendations for network topology designs.
author: JefferyMitchell
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 10/10/2023
ms.topic: conceptual
---

# Define an Azure network topology

Network topology is a critical element of a landing zone architecture because it defines how applications can communicate with each other. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies that are based on Azure Virtual WAN, and traditional topologies.

[Virtual WAN is used to meet large-scale interconnectivity requirements](../azure-best-practices/virtual-wan-network-topology.md). Because it's a Microsoft-managed service, it also reduces overall network complexity and helps to modernize your organization's network. A Virtual WAN topology might be most appropriate if any of the following requirements apply to your organization:

- Your organization intends to deploy resources across several Azure regions and requires global connectivity between virtual networks in these Azure regions and multiple on-premises locations.
- Your organization intends to integrate a large-scale branch network directly into Azure via a software-defined WAN (SD-WAN) deployment or requires more than 30 branch sites for native IPSec termination.
- You require transitive routing between a virtual private network (VPN) and Azure ExpressRoute. For example, remote branches connected via site-to-site VPN or remote users connected via point-to-site VPN require connectivity to an ExpressRoute-connected DC via Azure.

[A traditional hub-and-spoke network topology](../azure-best-practices/traditional-azure-networking-topology.md) helps you build customized, enhanced-security, large-scale networks in Azure. With this topology, you manage the routing and security. A traditional topology might be most appropriate if any of the following requirements apply to your organization:

- Your organization intends to deploy resources across one or several Azure regions and, while some traffic across Azure regions is expected (for example, traffic between two virtual networks across two different Azure regions), a full mesh network across all Azure regions isn't required.
- You have a low number of remote or branch locations per region. That is, you need fewer than 30 IPSec site-to-site tunnels.
- You require full control and granularity to manually configure your Azure network routing policy.

## Virtual WAN network topology (Microsoft-managed)

:::image type="content" source="./media/virtual-wan-topology.png" alt-text="Diagram that illustrates a Virtual WAN network topology." lightbox="./media/virtual-wan-topology.png" border="false":::

## Traditional Azure networking topology

:::image type="content" source="./media/customer-managed-topology.png" alt-text="Diagram that illustrates a traditional Azure network topology." lightbox="./media/customer-managed-topology.png" border="false":::

## Next steps
Azure Virtual Netowrk Manager provides powerful capabilities for managing virtual networks at scale, see
[Azure Virtual Network Manager in Azure Landing Zone](../azure-best-practices/azure-virtual-network-manager.md)
for more information.