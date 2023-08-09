---
title: Define an Azure network topology
description: Examine key design considerations and recommendations surrounding network topologies within Azure .
author: JefferyMitchell
ms.author: martinek
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Define an Azure network topology

Network topology is a critical element of the landing zone architecture because it defines how applications can communicate with each other. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

[Virtual WAN is used to meet large-scale interconnectivity requirements](../azure-best-practices/virtual-wan-network-topology.md). Because it's a Microsoft-managed service, it also reduces overall network complexity and helps to modernize your organization's network. A Virtual WAN topology may be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across several Azure regions and requires global connectivity between VNets in these Azure regions and multiple on-premises locations.
- Your organization intends to integrate a large-scale branch network directly in to Azure, either via a software-defined WAN (SD-WAN) deployment or requires more than 30 branch sites for native IPsec termination.
- You require transitive routing between VPN and ExpressRoute, such as remote branches connected via Site-to-Site VPN or remote users connected via Point-to-Site VPN, require connectivity to an ExpressRoute connected DC, via Azure.

[A traditional hub-and-spoke network topology](../azure-best-practices/traditional-azure-networking-topology.md) helps you build customized secure large-scale networks in Azure with routing and security managed by the customer. A traditional topology may be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across one or several Azure regions and while some traffic across Azure regions is expected (for example, traffic between two virtual networks across two different Azure regions), a full mesh network across all Azure regions is not required.
- You have a low number of remote or branch locations per region. That is, you need fewer than 30 IPsec Site-to-Site tunnels.
- You require full control and granularity for manually configuring your Azure network routing policy.

## Virtual WAN network topology (Microsoft-managed)

![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)

*Figure 1: Virtual WAN network topology.*

## Traditional Azure networking topology

![Diagram that illustrates a traditional Azure network topology.](./media/customer-managed-topology.png)

*Figure 2: A traditional Azure network topology.*

# Azure Virtual Network Manager in Azure Landing Zones

Azure Landing Zones conceptual architecture recommends one of two networking topologies: an Azure Virtual WAN-based network topology, or a network topology based on a hub and spoke architecture.  

As the business requirements change over time (e.g., migration of on-prem applications to Azure that requires hybrid connectivity), AVNM allows you to expand and implement networking changes without disruption to what is already in Azure.  

Azure Virtual Network Manager allows you to create three types of topologies across subscriptions, for both existing and new virtual networks:
- Hub and spoke with spokes that aren't connected to each other.
- Hub and spoke with spokes that are directly connected to each other, without any hops in the middle.
- A meshed group of virtual networks that are interconnected.

![Diagram that shows Azure Virtual Network topologies](../../_images/azure-best-practices/avnm-network-topologies.png)

When you create a hub-and-spoke topology with Azure Virtual Network Manager in which spokes are connected to each other, direct connectivity between spoke virtual networks in the same [network group](/azure/virtual-network-manager/concept-network-groups)are automatically created bi-directionally. By using Azure Virtual Network Manager, you can statically or dynamically make spoke virtual networks members of a specific network group, which automatically creates the connectivity for any virtual network.

You can create multiple network groups to isolate clusters of spokes virtual networks from direct connectivity. Each network group provides the same region and multi-region support for spoke-to-spoke connectivity. Be sure to stay below the maximum limits for Azure Virtual Network Manager that are described in the [Azure Virtual Network Manager FAQ](/azure/virtual-network-manager/faq#limits)


**Design considerations:**

- Compared to traditional Hub and Spoke deployment (where VNet peering connections are manually created and maintained), Virtual Network Manager introduces a layer of automation for virtual network peering, making large and complex network topologies like mesh easier to manage at scale.
- The security requirements of different business functions determine the need for creating network groups. A network group is a set of virtual networks selected manually or by using conditional statements as described previously. When a network group is created, the user must specify a policy, or AVNM can create a policy if the user explicitly allows it. This allows Azure Network Manager to get notified about changes, updating of existing Azure policy initiatives require deploying changes to the network group within the Azure Virtual Network Manager resource.	
- Evaluate which parts of your network share common security characteristics to design the appropriate network group.
For example, you can create network groups for Corp- connected and online etc. to manage their connectivity and security rules at scale.
- When multiple Virtual Networks across your organization’s subscription share security attributes, Virtual Network Manager allows you to apply those in an efficient way. 
For example, all the systems used by a Business unit like HR or Finance would belong in a separate network group because they need different sets of admin rules to be applied.
- Virtual Network Manager can be used to centrally apply security admin rules, which have higher priority than NSG rules applied at the subnet level. This enables the network and security teams to effectively enforce company policies and create security guard rails at scale, while product teams can simultaneously maintain control of NSGs within their landing zone subscriptions.
- Virtual Network Manager provides the ability to permit specific inbound connectivity to all resources even when NSG rules would otherwise block it (security posture independently of NSG) – known as always allow rules.


**Design recommendations:**

- Enable direct connectivity between spokes when selected spokes need to communicate frequently with each other in addition to access common services or NVA in the hub.
- Enable Global Mesh when all the spokes need to communicate frequently with each other.  
- Assign priority to each rule, a lower priority takes precedence over higher values.
- Use deny rules in the [security admin](/azure/virtual-network-manager/concept-security-admins) rule for traffic that is restricted by the ALZ owner, network administrator cannot override these in NSG rule
    - Use always allow when traffic must be permitted regardless of NSG rules. This is useful in scenarios where management and security agents always require specific ports and IPs to be allowed through rules
- Use allows rules in the security admin rule when the policing of traffic must be delegated to the network administrator who can define rules in their NSG.
