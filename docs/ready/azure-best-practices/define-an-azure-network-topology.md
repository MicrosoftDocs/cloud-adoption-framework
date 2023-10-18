---
title: Define an Azure network topology
description: Examine key design considerations and recommendations surrounding network topologies within Azure.
author: JefferyMitchell
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 10/10/2023
ms.topic: conceptual
---

# Define an Azure network topology

Network topology is a critical element of the landing zone architecture because it defines how applications can communicate with each other. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

[Virtual WAN is used to meet large-scale interconnectivity requirements](../azure-best-practices/virtual-wan-network-topology.md). Because it's a Microsoft-managed service, it also reduces overall network complexity and helps to modernize your organization's network. A Virtual WAN topology might be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across several Azure regions and requires global connectivity between VNets in these Azure regions and multiple on-premises locations.
- Your organization intends to integrate a large-scale branch network directly in to Azure, either via a software-defined WAN (SD-WAN) deployment or requires more than 30 branch sites for native IPsec termination.
- You require transitive routing between VPN and ExpressRoute, such as remote branches connected via Site-to-Site VPN or remote users connected via Point-to-Site VPN, require connectivity to an ExpressRoute connected DC, via Azure.

[A traditional hub-and-spoke network topology](../azure-best-practices/traditional-azure-networking-topology.md) helps you build customized secure large-scale networks in Azure with routing and security managed by the customer. A traditional topology might be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across one or several Azure regions and while some traffic across Azure regions is expected (for example, traffic between two virtual networks across two different Azure regions), a full mesh network across all Azure regions isn't required.
- You have a low number of remote or branch locations per region. That is, you need fewer than 30 IPsec Site-to-Site tunnels.
- You require full control and granularity for manually configuring your Azure network routing policy.

## Virtual WAN network topology (Microsoft-managed)

![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)

*Figure 1: Virtual WAN network topology.*

## Traditional Azure networking topology

![Diagram that illustrates a traditional Azure network topology.](./media/customer-managed-topology.png)

*Figure 2: A traditional Azure network topology.*

## Azure Virtual Network Manager in Azure Landing Zones

The Azure Landing Zones conceptual architecture recommends one of two networking topologies: an Azure Virtual WAN-based network topology or a network topology based on a traditional hub and spoke architecture. As the business requirements change over time (for example, migration of on-premises applications to Azure that requires hybrid connectivity), AVNM allows you to expand and implement networking changes, in many cases, without disrupting what is already deployed in Azure.  

Azure Virtual Network Manager allows you to create three types of [topologies](/azure/virtual-network-manager/concept-connectivity-configuration) across subscriptions for both existing and new virtual networks:

- Hub and spoke topology
- Hub and spoke topology with direct connectivity
- Mesh topology (Preview)

![Diagram that shows Azure Virtual Network topologies.](../../_images/azure-best-practices/azure-virtual-network-manager-network-topologies.png)

>[!NOTE]
> Azure Virtual Network Manager does not support Azure Virtual WAN hubs as part of a network group or as the hub in a topology. For more information, see [Azure Virtual Network Manager FAQ](/azure/virtual-network-manager/faq).

When you create a Hub and spoke topology with direct connectivity in Azure Virtual Network Manager where the spokes are connected to each other directly, direct connectivity between spoke virtual networks in the same [network group](/azure/virtual-network-manager/concept-network-groups) is automatically enabled, bi-directionally, via the [Connected group](/azure/virtual-network-manager/concept-connectivity-configuration#connected-group) feature. 

Azure Virtual Network Manager allows you to statically or dynamically add virtual networks to become members of a specific [network groups](/azure/virtual-network-manager/concept-network-groups), which defines and creates the desired topology based on your connectivity configuration within Azure Virtual Network Manager.

You can create multiple network groups to isolate groups of different virtual networks from direct connectivity. Each network group provides the same region and multi-region support for spoke-to-spoke connectivity. Ensure you stay within the limits defined for Azure Virtual Network Manager that are described in the [Azure Virtual Network Manager FAQ](/azure/virtual-network-manager/faq#limits)

From a security perspective, Azure Virtual Network Manager provides an efficient way of applying [security admin rules](/azure/virtual-network-manager/concept-security-admins) to deny/allow traffic flows centrally, outside of what is defined in NSGs. This allows network security administrators to enforce access controls and empower application owners to manage their own lower-level rules within NSGs.

AVNM allows grouping of Virtual Networks to apply configurations to these groups rather than on an individual virtual network.
This allows more efficient management of connectivity, configuration and topology, security rules, and deployment to one or more regions simultaneously while maintaining fine-grained control.

Networks can be segmented to suit your needs by environment, teams, location, line of business, or some other function. Network groups can be defined statically or dynamic by defining a set of conditions that govern group membership.

AVNM allows you to implement the design principles of Azure Landing Zone to accommodate all application migration, modernization, and innovation at scale.

**Design considerations:**

- Compared to traditional Hub and Spoke deployment (where virtual network peering connections are manually created and maintained), Virtual Network Manager introduces a layer of automation for virtual network peering, making large and complex network topologies like mesh easier to manage at scale. For more information, see [AVNM network group overview](/azure/virtual-network-manager/concept-network-groups).
- The security requirements of different business functions determine the need for creating network groups. A network group is a set of virtual networks selected manually or by using conditional statements as described previously. When a network group is created, the user must specify a policy, or AVNM can create a policy if the user explicitly allows it. This allows Azure Network Manager to get notified about changes, updating of existing Azure policy initiatives require deploying changes to the network group within the Azure Virtual Network Manager resource.
- Evaluate which parts of your network share common security characteristics to design the appropriate network group.
For example, you can create network groups for corp and online to manage their connectivity and security rules at scale.
- When multiple Virtual Networks across your organization's subscriptions share the same security attributes, Virtual Network Manager allows you to apply those efficiently. 
For example, all the systems used by a Business unit like HR or Finance would belong in a separate network group because they need different admin rules to be applied.
- Virtual Network Manager can centrally apply security admin rules, which have higher priority than NSG rules applied at the subnet level (still in preview). This enables the network and security teams to effectively enforce company policies and create security guard rails at scale, while product teams can simultaneously maintain control of NSGs within their landing zone subscriptions.
- Virtual Network Manager's [Security Admin Rules (preview)](/azure/virtual-network-manager/concept-security-admins) feature provides the ability to explicitly allow or deny specific network flows regardless of NSG configurations at subnet or network interface levels. This is useful, as an example, for allowing management services network flows to always be permitted; NSGs controlled by application teams can't override that.
- A virtual network can be part of up to only two connected groups

**Design recommendations:**

- Define the [scope of AVNM](/azure/virtual-network-manager/concept-network-manager-scope), apply Security Admin rules that enforce organizational level rules at the Root Management Group (tenant), which hierarchically applies automatically to existing and new resources and to all associated Management Groups
- Create an AVNM instance in the connectivity subscription with the [scope](/azure/virtual-network-manager/concept-network-manager-scope) of the intermediate root management group (for example, "contoso") with the Security Admin feature enabled.
  - This allows an organization to define security admin rules that will be applied across all vNets and subnets within their ALZ hierarchy and assist them in democratizing NSGs to application landing zone owners and teams
- Networks can be segmented by grouping VNets either statically (manual) or dynamically (policy-based)
- Enable direct connectivity between spokes when selected spokes need to communicate frequently, with low-latency and high throughput requirements, with each other, in addition to accessing common services or NVAs in the hub.
- Enable Global Mesh when all the virtual networks across regions need to communicate with each other.  
- Assign a priority to each security admin rule within rule collections. A lower priority takes precedence over higher values.
- Use [security admin rules](/azure/virtual-network-manager/concept-security-admins) to explicitly allow or deny network flows outside of NSG configurations controlled by application teams.
  - This further allows you to fully delegate the control of NSGs and their rules to application teams.
