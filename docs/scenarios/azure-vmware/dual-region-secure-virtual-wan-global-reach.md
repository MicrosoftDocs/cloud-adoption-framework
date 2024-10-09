---
title: Use a Dual-Region Azure VMware Solution Design That Has Virtual WAN and Global Reach
description: Learn how to configure network connectivity when you deploy Azure VMware Solution private clouds in two Azure regions with secure Virtual WAN and Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/21/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Use a dual-region Azure VMware Solution design that has Virtual WAN and Global Reach

This article outlines best practices for connectivity, traffic flows, and high availability when you deploy Azure VMware Solution in two regions. It provides guidance for secure Azure Virtual WAN with routing intent and Azure ExpressRoute Global Reach. This article describes the Virtual WAN with routing intent topology for Azure VMware Solution private clouds, on-premises sites, and Azure-native resources.

The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article. This article assumes that you have a basic understanding of Virtual WAN and secure Virtual WAN with routing intent.
  
## Use secure Virtual WAN and Global Reach in two regions 
 
Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. You must have a secure Virtual WAN hub if you use routing intent.

This scenario's hub has the following configuration:

- The dual-region network has one Virtual WAN and two hubs. Each region has one hub.

- Each hub has its own Azure Firewall instance deployed, which makes them secure Virtual WAN hubs.
- The secure Virtual WAN hubs have routing intent enabled.

This scenario also has these components:

- Each region has its own Azure VMware Solution private cloud and an Azure virtual network.

- An on-premises site connects to both regions.
- The environment has Global Reach connectivity.
- Global Reach establishes a direct logical link via the Microsoft backbone, which connects Azure VMware Solution to on-premises or to regional Azure VMware Solution private clouds.
- Global Reach connections don't transit the hub firewalls. So Global Reach traffic between sites doesn't get inspected.   

> [!NOTE]
> To enhance security between Global Reach sites, consider inspecting traffic within the Azure VMware Solution environment's NSX-T or an on-premises firewall.

The following diagram shows an example of this scenario.

:::image type="content" source="./media/dual-region-virtual-wan-1.png" alt-text="Diagram that shows Azure VMware Solution in two regions." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| A | Azure VMware Solution region 1 Global Reach connection back to on-premises  |
| B | Azure VMware Solution region 2 Global Reach connection back to on-premises  |
| C | Azure VMware Solution Global Reach connection between the two private clouds' managed circuits  |
| D | Azure VMware Solution private cloud connection to its local regional hub  |
| E | On-premises connectivity via ExpressRoute to both regional hubs  |
| Interhub | Interhub logical connection between two hubs that are deployed under the same Virtual WAN  |

> [!NOTE]
> When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preferences](/azure/virtual-wan/about-virtual-hub-routing-preference).

## Dual-region secure Virtual WAN traffic flows

The following sections describe traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet when you use Global Reach.

### Azure VMware Solution private cloud cross-region connectivity and traffic flows

The following diagram shows traffic flows for two Azure VMware Solution private clouds in two regions. 

:::image type="content" source="./media/dual-region-virtual-wan-2.png" alt-text="Diagram that shows a dual-region Azure VMware Solution design that has a cross-Azure VMware Solution topology." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 1| Yes, via the hub 1 firewall|
| 2 | Azure VMware Solution cloud region 1 | &#8594;| On-premises | No, traffic bypasses the firewall and transits Global Reach connection A|
| 3 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 2| Yes, via the hub 2 firewall|
| 4 | Azure VMware Solution cloud region 1 | &#8594;| Azure VMware Solution cloud region 2| No, traffic bypasses the firewall and transits Global Reach connection C|
| 5 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 1| Yes, via the hub 1 firewall
| 6 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 2| Yes, via the hub 2 firewall|
| 7 | Azure VMware Solution cloud region 2 | &#8594;| On-premises | No, traffic bypasses the firewall and transits Global Reach connection B |

Each Azure VMware Solution private cloud connects to its local regional hub via ExpressRoute connection **D**.

Each Azure VMware Solution cloud region connects back to an on-premises network via ExpressRoute Global Reach. Each Azure VMware Solution cloud region has its own Global Reach connection (connection **A** and **B**). And the Azure VMware Solution private clouds connect directly to each other via Global Reach connection **C**. Global Reach traffic never transits any hub firewalls.  

Configure all three Global Reach connections. You must do this step to prevent connectivity problems between Global Reach sites.

### On-premises connectivity and traffic flow

The following diagram shows traffic flows for the on-premises site.

:::image type="content" source="./media/dual-region-virtual-wan-3.png" alt-text="Diagram of dual-region Azure VMware Solution with on-premises." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 2 | On-premises | &#8594;| Azure VMware Solution cloud region 1 | No, traffic bypasses firewall and transits Global Reach (A)|
| 7 | On-premises | &#8594;| Azure VMware Solution cloud region 2 | No, traffic bypasses firewall and transits Global Reach (B)|
| 8 | On-premises | &#8594;| Virtual network 1 | Yes, traffic is inspected at hub 1 firewall|
| 9 | On-premises | &#8594;| Virtual network 2 | Yes, traffic is inspected at hub 2 firewall|

The on-premises site connects to both region 1 and region 2 hubs via ExpressRoute connection **E**.

On-premises systems can communicate with Azure VMware Solution cloud region 1 via Global Reach connection **A** and with Azure VMware Solution cloud region 2 via Global Reach connection **B**. 

Configure all three Global Reach connections. You must do this step to prevent connectivity problems between Global Reach sites.

### Azure virtual network connectivity and traffic flow

The following diagram shows traffic flows for the virtual networks.

:::image type="content" source="./media/dual-region-virtual-wan-4.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with virtual networks." border="false"::: 

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 1| Yes, via the hub 1 firewall|
| 3 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 1| Yes, via the hub 2 firewall|
| 5 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 2| Yes, via the hub 1 firewall
| 6 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 2| Yes, via the hub 2 firewall|
| 8 | Virtual network 1 | &#8594;| On-premises | Yes, via the hub 1 firewall|
| 9 | Virtual network 2 | &#8594;| On-premises | Yes, via the hub 2 firewall|
| 10 | Virtual network 1 | &#8594;| Virtual network 2 | Yes, via the hub 1 firewall. Traffic then goes over the interhub connection and then is inspected via the hub 2 firewall. |

Both virtual networks directly peer to their local regional hub.

A secure hub that has routing intent sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered virtual networks, along with any other prefixes that are added as private-traffic prefixes. For more information, see [Routing intent private-address prefixes](/azure/virtual-wan/how-to-routing-policies#nva).

This scenario has routing intent enabled, so all resources in virtual network 1 and virtual network 2 possess the default RFC 1918 addresses and use their local regional hub firewall as the next hop. All traffic that ingresses and egresses the virtual networks transit the hub firewalls.

## Internet connectivity

This section describes how to provide internet connectivity for Azure-native resources in virtual networks and Azure VMware Solution private clouds in both regions. For more information, see [Internet connectivity design considerations](/azure/azure-VMware/concepts-design-public-internet-access). You can use the following options to provide internet connectivity to Azure VMware Solution.

- *Option 1:* Azure-hosted internet service
- *Option 2:* VMware Solution-managed Source Network Address Translation (SNAT)  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge  

A dual-region Virtual WAN design that has routing intent supports all options, but we recommend option 1. The scenario later in this article uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

When you use routing intent, you can generate a default route from the hub firewall. This default route advertises to your virtual networks and Azure VMware Solution private clouds. 

### Azure VMware Solution and virtual network internet connectivity

The following diagram shows the internet connectivity for Azure VMware Solution instances and virtual networks.

:::image type="content" source="./media/dual-region-virtual-wan-5.png" alt-text="Diagram that shows a dual-region Azure VMware Solution design that has internet connectivity." border="false"::: 

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? | The internet breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 11 | Azure VMware Solution cloud region 1 | &#8594;| The internet| Yes, via the hub 1 firewall| Via the hub 1 firewall
| 12 | Azure VMware Solution cloud region 2 | &#8594;| The internet | Yes, via the hub 2 firewall| Via the hub 2 firewall
| 15 | Virtual network 1 | &#8594;| The internet | Yes, via the hub 1 firewall| Via the hub 1 firewall|
| 16 | Virtual network 2 | &#8594;| The internet | Yes, via the hub 2 firewall| Via the hub 2 firewall|

The following traffic flows are only active if you have an outage that affects a local regional hub. For instance, if the local regional hub of Azure VMware Solution experiences an outage, internet traffic reroutes to the cross-regional hub for internet connectivity.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? | The internet breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 13 | Azure VMware Solution cloud region 1 | &#8594;| The internet | Yes, traffic transits via Global Reach connection C, and the hub 2 firewall inspects it. | Via the hub 2 firewall|
| 14 | Azure VMware Solution cloud region 2 | &#8594;| The internet | Yes, traffic transits via Global Reach connection C, and the hub 1 firewall inspects it.| Via the hub 1 firewall|

The Azure VMware Solution private cloud learns the default internet connectivity route from both its local regional hub and its cross-regional hub, so you can achieve internet connectivity redundancy. The Azure VMware Solution private cloud prioritizes the local regional hub for primary internet-access connectivity. The cross-regional hub serves as an internet backup if the local regional hub fails. This setup provides internet-access redundancy for outbound traffic only. For inbound internet traffic to Azure VMware Solution workloads, consider using Azure Front Door or Azure Traffic Manager for regional high availability.

The Azure VMware Solution private cloud receives the preferred default route *∞ 0.0.0.0/0* via connection **D** from its local regional hub. And the Azure VMware Solution private cloud receives a backup default route *△ 0.0.0.0/0*, which originates on the cross-regional hub and advertises across Global Reach connection **C**. But if you enable default-route propagation on your on-premises ExpressRoute connections **E**, cross-regional internet traffic directs through this path as well. 

For example, cross-regional internet traffic that goes from Azure VMware private cloud 1 to hub 2 is distributed via equal-cost multipath (ECMP) routing across Global Reach connection **C** to connection **D** and across Global Reach connection **A** to connection **E**. Similarly, return traffic that goes from hub 2 to private cloud region 1 traverses the same paths via ECMP. Configure all three Global Reach connections. You must do this step to prevent connectivity problems between Global Reach sites.

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To help ensure that the default route propagates to Azure VMware Solution from Virtual WAN, you must enable default-route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [Advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

Don't enable this setting for on-premises ExpressRoute circuits. Connection **D** advertises the default route "∞ 0.0.0.0/0" to the Azure VMware Solution private clouds, but the default route also advertises to on-premises via Global Reach connection **A** and Global Reach connection **B**. As a result, we recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment to exclude learning the default route. This step ensures that your configuration doesn't affect on-premises internet connectivity.

Each virtual network egresses to the internet via its local regional hub firewall. When you enable routing intent for internet access, the default route that the secure Virtual WAN hub generates automatically advertises to the hub-peered virtual network connections. But this default route doesn't advertise across regional hubs over the interhub link. So virtual networks use their local regional hub for internet access and have no backup internet connectivity to the cross-regional hub.



## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud Next Generation Firewall in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
