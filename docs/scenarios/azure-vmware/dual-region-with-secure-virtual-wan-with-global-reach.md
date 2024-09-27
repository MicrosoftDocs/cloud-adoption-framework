---
title: Dual-region Azure VMware Solution design with Global Reach, using secure Virtual WAN with routing intent
description: Learn how to configure network connectivity when you deploy Azure VMware Solution private clouds in two Azure regions with secure Virtual WAN and Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/11/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Dual-region deployments using secure Virtual WAN hub with routing intent and global reach

This article outlines best practices for connectivity, traffic flows, and high availability of dual-region Azure VMware Solution. It focuses on using Azure secure Virtual WAN with routing intent and Global Reach. This article breaks down the Virtual WAN with routing intent topology from the perspective of Azure VMware Solution private clouds, on-premises sites, and Azure native. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article. This article assumes that you have a basic understanding of Virtual WAN and secure Virtual WAN with routing intent.
  
## Dual-region with secure Virtual WAN using Global Reach scenario 
 
Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. In the scenario, we have a network topology that spans two regions. There's one Virtual WAN with two hubs, Hub1 and Hub2. Hub1 is in Region 1, and Hub2 is in Region 2. Each hub has its own instance of Azure Firewall deployed(Hub 1 Firewall, Hub 2 Firewall), essentially making them each secure Virtual WAN Hubs. Having secure Virtual WAN hubs is a technical prerequisite to routing intent. Secure Virtual WAN Hub1 and Hub2 have routing intent enabled.    

> [!NOTE]
> When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference).

Each region has its own Azure VMware Solution private cloud and an Azure virtual network. Additionally, there's an on-premises site connecting to both regions. Furthermore, Global Reach connectivity exists within the environment. Global Reach establishes a direct logical link via the Microsoft backbone, connecting Azure VMware Solution to on-premises or regional Azure VMware Solution private clouds. As shown in the diagram, Global Reach connections don't transit Hub Firewall 1 and Hub Firewall 2. So, Global Reach traffic between sites isn't inspected. 

> [!NOTE]
> When you use Global Reach, consider inspecting traffic within the Azure VMware Solution environment's NSX-T or an on-premises firewall, which enhances security between Global Reach sites.

:::image type="content" source="./media/dual-region-virtual-wan-1.png" alt-text="Diagram that shows a dual-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud connection to its local regional hub  |
| A | Azure VMware Solution Region 1 Global Reach connection back to on-premises  |
| B | Azure VMware Solution Region 2 Global Reach connection back to on-premises  |
| C | Azure VMware Solution Global Reach connection between the two private clouds' managed circuits  |
| E | on-premises connectivity via ExpressRoute to both regional hubs  |
| Inter-hub | Inter-hub logical connection between two hubs that are deployed under the same Virtual WAN  |

## Dual-region secure Virtual WAN traffic flows

The following sections cover traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the Internet when using Global Reach.

### Azure VMware Solution cross-region connectivity and traffic flows

This section focuses on only the Azure VMware Solution Cloud Region 1 and Azure VMware Solution Cloud Region 2. Each Azure VMware Solution private cloud has an ExpressRoute connection to its local regional hub (connections labeled as "D").

Each Azure VMware Solution cloud region connects back to an on-premises network via ExpressRoute Global Reach. Azure VMware Solution Cloud Region 1 Global Reach connection is shown as Global Reach (A). The Azure VMware Solution Cloud Region 2 Global Reach connection is shown as Global Reach (B). Both Azure VMware Solution private clouds are connected directly to each other via Global Reach shown as Global Reach (C). Keep in mind that Global Reach traffic will never transit any hub firewalls.  

Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It's imperative to do this step to prevent connectivity issues between Global Reach sites. For more information, see traffic flow section.

The diagram shows traffic flows from the perspective of the Azure VMware Solution private clouds. 

:::image type="content" source="./media/dual-region-virtual-wan-2.png" alt-text="Diagram that shows dual-region Azure VMware Solution with cross Azure VMware Solution topology." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution Cloud Region 1 | &#8594;| Virtual network 1| Yes, traffic is inspected at hub 1 firewall|
| 2 | Azure VMware Solution Cloud Region 1 | &#8594;| on-premises | No, traffic bypasses firewall and transits Global Reach (A)|
| 3 | Azure VMware Solution Cloud Region 1 | &#8594;| Virtual network 2| Yes, traffic is inspected at hub 2 firewall|
| 4 | Azure VMware Solution Cloud Region 1 | &#8594;| Azure VMware Solution Cloud Region 2| No, traffic bypasses firewall and transits Global Reach (C)|
| 5 | Azure VMware Solution Cloud Region 2 | &#8594;| Virtual network 1| Yes, traffic is inspected at hub 1 firewall
| 6 | Azure VMware Solution Cloud Region 2 | &#8594;| Virtual network 2| Yes, traffic is inspected at hub 2 firewall|
| 7 | Azure VMware Solution Cloud Region 2 | &#8594;| on-premises | No, traffic bypasses firewall and transits Global Reach (B)|

### on-premises connectivity & traffic flow

This section focuses only on the on-premises site. As shown in the diagram, the on-premises site has an ExpressRoute connection to both Region 1 and Region 2 hubs (connections labeled as "E").

On-premises systems can communicate to Azure VMware Solution Cloud Region 1 via connection Global Reach (A). On-premises systems are also able to communicate with Azure VMware Solution Cloud Region 2 via connection Global Reach (B). 

Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It's imperative to do this step to prevent connectivity issues between Global Reach sites. For more information, see traffic flow section.

The diagram illustrates traffic flows from an on-premises perspective.

:::image type="content" source="./media/dual-region-virtual-wan-3.png" alt-text="Diagram of dual-region Azure VMware Solution with on-premises." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 2 | On-premises | &#8594;| Azure VMware Solution Cloud Region 1 | No, traffic bypasses firewall and transits Global Reach (A)|
| 7 | On-premises | &#8594;| Azure VMware Solution Cloud Region 2 | No, traffic bypasses firewall and transits Global Reach (B)|
| 8 | On-premises | &#8594;| Virtual network 1 | Yes, traffic is inspected at hub 1 firewall|
| 9 | On-premises | &#8594;| Virtual network 2 | Yes, traffic is inspected at hub 2 firewall|

### Azure virtual network connectivity and traffic flow

This section focuses only on connectivity from an Azure virtual network perspective. As depicted in the diagram, both virtual network1 and virtual network2 have a virtual network peering directly to their local regional hub.

A secure hub with enabled routing intent always sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered virtual networks, plus any other prefixes that are added as "Private Traffic Prefixes" - see [Routing Intent Private Address Prefixes](/azure/virtual-wan/how-to-routing-policies#nva). In our scenario, with routing intent enabled, all resources in virtual network 1, and virtual network 2 currently possess the default RFC 1918 addresses and use their local regional hub firewall as the next hop. All traffic ingressing and egressing the virtual networks will always transit the hub Firewalls. For more information, see traffic flow section.  

:::image type="content" source="./media/dual-region-virtual-wan-4.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with virtual networks." border="false"::: 

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Virtual network 1 | &#8594;| Azure VMware Solution Cloud Region 1| Yes, traffic is inspected at hub 1 firewall|
| 3 | Virtual network 2 | &#8594;| Azure VMware Solution Cloud Region 1| Yes, traffic is inspected at hub 2 firewall|
| 5 | Virtual network 1 | &#8594;| Azure VMware Solution Cloud Region 2| Yes, traffic is inspected at hub 1 firewall
| 6 | Virtual network 2 | &#8594;| Azure VMware Solution Cloud Region 2| Yes, traffic is inspected at hub 2 firewall|
| 8 | Virtual network 1 | &#8594;| on-premises | Yes, traffic is inspected at hub 1 firewall|
| 9 | Virtual network 2 | &#8594;| on-premises | Yes, traffic is inspected at hub 2 firewall|
| 10 | Virtual network 1 | &#8594;| Virtual network 2 | Yes, traffic is inspected at the hub 1 firewall, then flows over the inter-hub connection to be inspected by hub 2 firewall|

## Internet connectivity

This section focuses only on how internet connectivity is provided for Azure native resources in virtual networks and Azure VMware Solution private clouds in both regions. There are several options to provide internet connectivity to Azure VMware Solution. For more information, see [Internet access concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access).

- *Option 1:* Azure-hosted internet service
- *Option 2:* VMware Solution-managed SNAT  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge  

You can use all three options with single-region secure Virtual WAN with routing intent. But when you use secure Virtual WAN with routing intent, you should use option 1. This scenario also uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it makes security inspection, deployment, and manageability easy.

When you use routing intent, you can generate a default route from the hub firewall. This default route is advertised to your virtual networks and Azure VMware Solution private clouds. This section is broken into two sections, one that explains internet connectivity from an Azure VMware Solution perspective and another from the virtual network perspective.

#### Azure VMware Solution internet connectivity

From an Azure VMware Solution private cloud perspective, you have the availability to achieve internet connectivity redundancy because it learns the default route from both its local regional hub and its cross-regional hub. The Azure VMware Solution private cloud always prioritizes the local regional hub for primary internet access connectivity. The cross-regional hub serves as an internet backup if the local regional hub is down. This setup provides internet access redundancy for outbound traffic only. For inbound internet traffic to Azure VMware Solution workloads, consider using Azure Front Door or Azure Traffic Manager for regional high availability.

Going into more detail, the Azure VMware Solution private cloud's preferred default route "∞ 0.0.0.0/0" is received via connection "D" from its local regional hub. Additionally, the Azure VMware Solution private cloud receives a backup default route "△ 0.0.0.0/0," which originates on the cross-regional hub and advertised across the Global Reach (C) connection. However, if you enable default route propagation on your on-premises ExpressRoutes for connection "E", cross-regional internet traffic is directed through this path as well. For example, cross-regional internet traffic from Azure VMware private cloud 1 to Hub 2 is distributed using Equal-Cost Multipath (ECMP) routing across Global Reach (C) to connection "D" and Global Reach (A) to connection "E". Similarly, return traffic from Hub 2 to private cloud Region 1 traverses the same paths using Equal-Cost Multipath (ECMP). Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It's imperative to do this step to prevent connectivity issues between Global Reach sites. 

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To ensure the default route is propagated to the Azure VMware Solution from the Azure Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [To advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints). Don't enable this setting for on-premises ExpressRoute circuits. Even though connection "D" advertises the default route "∞ 0.0.0.0/0" to the Azure VMware Solution private clouds, the default route is also advertised to on-premises via Global Reach (A) and Global Reach (B). As a result, the recommendation is to implement a Border Gateway Protocol (BGP) filter on your on-premises equipment to exclude learning the default route. This step ensures that your configuration doesn't affect on-premises internet connectivity.

#### Virtual network internet connectivity

Each virtual network egresses to the internet via its local regional hub firewall. When you enable routing intent for internet access, the default route generated from the secure VWAN hub is automatically advertised to the hub-peered virtual network connections. But this default route is never advertised across regional hubs over the *inter-hub* link. So virtual networks use their local regional hub for internet access and have no backup internet connectivity to the cross-regional hub.

For more information, see the traffic flow section.

:::image type="content" source="./media/dual-region-virtual-wan-5.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with internet." border="false"::: 

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? | Internet breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 11 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet| Yes, traffic is inspected at hub 1 firewall| Via hub 1 firewall
| 12 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic is inspected at hub 2 firewall| Via hub 2 firewall
| 15 | Virtual network 1 | &#8594;| Internet | Yes, traffic is inspected at hub 1 firewall| Via hub 1 firewall|
| 16 | Virtual network 2 | &#8594;| Internet | Yes, traffic is inspected at hub 2 firewall| Via hub 2 firewall|

**The traffic flow 13 and 14 is only valid if there is an outage affecting a local regional hub. For instance, if the local regional hub of Azure VMware Solution experiences an outage, internet traffic will be rerouted to the cross-regional hub for internet connectivity.**

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? | Internet breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 13 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at hub 2 firewall| Via hub 2 firewall|
| 14 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at hub 1 firewall| Via hub 1 firewall|

## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings).
- For more information on how to configure Azure Firewall in a Virtual Hub, see [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall).
- For more information on how to configure the Palo Alto Next Generation SAAS firewall on Virtual WAN, see [Configure Palo Alto Networks Cloud NGFW in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw).
- For more information on Virtual WAN hub routing intent configuration, see [Configure routing intent and policies through Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva).
