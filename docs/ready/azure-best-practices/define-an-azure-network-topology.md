---
title: Define an Azure network topology
description: Learn about key considerations for designing network topologies in Azure. Get recommendations for network topology designs.
author: JefferyMitchell
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 05/21/2024
ms.topic: conceptual
---

# Define an Azure network topology

Network topology is a critical element of a landing zone architecture because it defines how applications can communicate with one another. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies that are based on Azure Virtual WAN and traditional topologies.

You can use [Virtual WAN to meet large-scale interconnectivity requirements](../azure-best-practices/virtual-wan-network-topology.md). Virtual WAN is a service that Microsoft manages, which reduces overall network complexity and helps to modernize your organization's network. Use a Virtual WAN topology if any of the following requirements apply to your organization:

- Your organization intends to deploy resources across several Azure regions and requires global connectivity between virtual networks in these Azure regions and multiple on-premises locations.

- Your organization intends to use a software-defined WAN (SD-WAN) deployment to integrate a large-scale branch network directly into Azure, or requires more than 30 branch sites for native IPSec termination.

- You require transitive routing between a virtual private network (VPN) and Azure ExpressRoute. For example, if you use a site-to-site VPN to connect remote branches or a point-to-site VPN to connect remote users, you might need to connect the VPN to an ExpressRoute-connected DC through Azure.

[A traditional hub-and-spoke network topology](../azure-best-practices/traditional-azure-networking-topology.md) helps you build customized, enhanced-security, large-scale networks in Azure. With this topology, you manage the routing and security. Use a traditional topology if any of the following requirements apply to your organization:

- Your organization intends to deploy resources across one or several Azure regions. You expect some traffic across Azure regions, such as traffic between two virtual networks across two different Azure regions, but you don't need a full-mesh network across all Azure regions.

- You have a low number of remote or branch locations for each region and require fewer than 30 IPSec site-to-site tunnels.

- You require full control and granularity to manually configure your Azure network routing policy.

The following diagram shows a Microsoft-managed Virtual WAN network topology:

:::image type="content" source="./media/virtual-wan-topology.png" alt-text="Diagram that illustrates a Virtual WAN network topology." lightbox="./media/virtual-wan-topology.png" border="false":::

## Traditional Azure networking topology

:::image type="content" source="./media/customer-managed-topology.png" alt-text="Diagram that illustrates a traditional Azure network topology." lightbox="./media/customer-managed-topology.png" border="false":::

## Next step

[Virtual Network Manager in Azure landing zones](./azure-virtual-network-manager.md)
