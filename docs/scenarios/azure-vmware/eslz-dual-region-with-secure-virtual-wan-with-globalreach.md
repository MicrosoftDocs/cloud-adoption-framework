---
title: Dual-Region Azure VMware Solution design with Global Reach, using Secure Virtual WAN with Routing-Intent
description: Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions with Secure Virtual WAN and Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 04/02/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Dual-region deployments using Secure Virtual WAN Hub with Routing-Intent and Global Reach

This article outlines best practices for connectivity, traffic flows, and high availability of dual-region Azure VMware Solution. It focuses on using Azure Secure Virtual WAN with Routing Intent and Global Reach. This article breaks down Virtual WAN with Routing Intent topology from the perspective of Azure VMware Solution private clouds, on-premises sites, and Azure native. The implementation and configuration of Secure Virtual WAN with Routing Intent are beyond the scope and are not discussed in this document.

The document assumes readers have a basic understanding of Virtual WAN and Secure Virtual WAN with Routing Intent.

**Virtual WAN**  
[What is Virtual WAN?](/azure/virtual-wan/virtual-wan-about)

**Virtual WAN Routing Intent**  
[How to configure Virtual WAN Hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies)
  
## Dual-region with Secure Virtual WAN using Global Reach scenario  
Secure Virtual WAN with Routing Intent is only supported with Virtual WAN Standard SKU. Secure Virtual WAN with Routing Intent provides the capability to send all Internet traffic and Private network traffic to a security solution like Azure Firewall, a third-party Network Virtual Appliance (NVA), or SaaS solution. In the scenario, we have a network topology that spans two regions. There's one Virtual WAN with two Hubs, Hub1 and Hub2. Hub1 is in Region 1, and Hub2 is in Region 2. Each Hub has its own instance of Azure Firewall deployed(Hub 1 Firewall, Hub 2 Firewall), essentially making them each Secure Virtual WAN Hubs. Having Secure Virtual WAN hubs is a technical prerequisite to Routing Intent. Secure Virtual WAN Hub1 and Hub2 have Routing Intent enabled.    

>[!NOTE]
>  When configuring Azure VMware Solution with Secure Virtual WAN Hubs, ensure optimal routing results on the hub by setting the Hub Routing Preference option to "AS Path." - see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference)
>

Each region has its own Azure VMware Solution Private Cloud and an Azure Virtual Network. Additionally, there's an on-premises site connecting to both regions. Furthermore, Global Reach connectivity exists within the environment. Global Reach establishes a direct logical link via the Microsoft backbone, connecting Azure VMware Solution to on-premises or regional Azure VMware Solution Private Clouds. As shown in the diagram, Global Reach connections do not transit Hub Firewall 1 and Hub Firewall 2. So, Global Reach traffic between sites is not inspected. 

> [!NOTE]
> When utilizing Global Reach, consider enhancing security between Global Reach sites by inspecting traffic within the Azure VMware Solution environment’s NSX-T or an on-premises firewall.
>

![Diagram of Dual-Region Azure VMware Solution Scenario](./media/dual-region-virtual-wan-1.png)

### Understanding Topology Connectivity 

| Connection | Description  |
|:-------------------- |:--------------------  |
| Connections (D) | Azure VMware Solution private cloud connection to its local regional hub.  |
| Connection (A) | Azure VMware Solution Region 1 Global Reach connection back to on-premises.  |
| Connection (B) | Azure VMware Solution Region 2 Global Reach connection back to on-premises.  |
| Connection (C) | Azure VMware Solution Global Reach connection between the two private clouds' managed circuits.  |
| Connections (E) | on-premises connectivity via ExpressRoute to both regional hubs.  |
| Inter-Hub | Inter-Hub logical connection between two hubs that are deployed under the same Virtual WAN.  |

## Dual-region Secure Virtual WAN Traffic Flows

The following sections cover traffic flows and connectivity for Azure VMware Solution, on-premises, Azure Virtual Networks, and the Internet when using Global Reach.

### Azure VMware Solution cross-region connectivity & traffic flows

This section focuses on only the Azure VMware Solution Cloud Region 1 and Azure VMware Solution Cloud Region 2. Each Azure VMware Solution private cloud has an ExpressRoute connection to its local regional hub (connections labeled as "D").

Each Azure VMware Solution Cloud Region connects back to an on-premises via ExpressRoute Global Reach. Azure VMware Solution Cloud Region 1 Global Reach connection is shown as Global Reach (A). The Azure VMware Solution Cloud Region 2 Global Reach connection is shown as Global Reach (B). Both Azure VMware Solution private clouds are connected directly to each other via Global Reach shown as Global Reach (C). Keep in mind that Global Reach traffic will never transit any hub firewalls. 

Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It is imperative to do this step to prevent connectivity issues between Global Reach sites. For more information, see traffic flow section.


The diagram illustrates traffic flows from the perspective of the Azure VMware Solution Private Clouds. 

![Diagram of Dual-Region Azure VMware Solution with Cross Azure VMware Solution Topology](./media/dual-region-virtual-wan-2.png)  

**Traffic Flow Chart**  

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution Cloud Region 1 | &#8594;| Virtual Network 1| Yes, traffic is inspected at Hub 1 firewall|
| 2 | Azure VMware Solution Cloud Region 1 | &#8594;| on-premises | No, traffic bypasses firewall and transits Global Reach (A)|
| 3 | Azure VMware Solution Cloud Region 1 | &#8594;| Virtual Network 2| Yes, traffic is inspected at Hub 2 firewall|
| 4 | Azure VMware Solution Cloud Region 1 | &#8594;| Azure VMware Solution Cloud Region 2| No, traffic bypasses firewall and transits Global Reach (C)|
| 5 | Azure VMware Solution Cloud Region 2 | &#8594;| Virtual Network 1| Yes, traffic is inspected at Hub 1 firewall
| 6 | Azure VMware Solution Cloud Region 2 | &#8594;| Virtual Network 2| Yes, traffic is inspected at Hub 2 firewall|
| 7 | Azure VMware Solution Cloud Region 2 | &#8594;| on-premises | No, traffic bypasses firewall and transits Global Reach (B)|


### on-premises connectivity & traffic flow

This section focuses only on the on-premises site. As shown in the diagram, the on-premises site has an ExpressRoute connection to both Region 1 and Region 2 hubs (connections labeled as "E").

On-premises systems can communicate to Azure VMware Solution Cloud Region 1 via connection Global Reach (A). On-premises systems are also able to communicate with Azure VMware Solution Cloud Region 2 via connection Global Reach (B). 

Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It is imperative to do this step to prevent connectivity issues between Global Reach sites. For more information, see traffic flow section.

The diagram illustrates traffic flows from an on-premises perspective.

![Diagram of Dual-Region Azure VMware Solution with on-premises](./media/dual-region-virtual-wan-3.png)  

**Traffic Flow Chart**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? |
| - | -------------- | -------- | ---------- | ---------- |
| 2 | on-premises | &#8594;| Azure VMware Solution Cloud Region 1 | No, traffic bypasses firewall and transits Global Reach (A)|
| 7 | on-premises | &#8594;| Azure VMware Solution Cloud Region 2 | No, traffic bypasses firewall and transits Global Reach (B)|
| 8 | on-premises | &#8594;| Virtual Network 1 | Yes, traffic is inspected at Hub 1 firewall|
| 9 | on-premises | &#8594;| Virtual Network 2 | Yes, traffic is inspected at Hub 2 firewall|

### Azure Virtual Network connectivity & traffic flow

This section focuses only on connectivity from an Azure Virtual Network perspective. As depicted in the diagram, both Virtual Network1 and Virtual Network2 have a Virtual Network peering directly to their local regional hub.

A Secure Hub with enabled Routing Intent always sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered Virtual Networks, plus any other prefixes that have been added as "Private Traffic Prefixes" - see [Routing Intent Private Address Prefixes](/azure/virtual-wan/how-to-routing-policies#nva). In our scenario, with Routing Intent enabled, all resources in Virtual Network 1, and Virtual Network 2 currently possess the default RFC 1918 addresses and use their local regional hub firewall as the next hop. All traffic ingressing and egressing the Virtual Networks will always transit the Hub Firewalls. For more information, see traffic flow section.  

![Diagram of Dual-Region Azure VMware Solution with Virtual Networks](./media/dual-region-virtual-wan-4.png)  

**Traffic Flow Chart**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Virtual Network 1 | &#8594;| Azure VMware Solution Cloud Region 1| Yes, traffic is inspected at Hub 1 firewall|
| 3 | Virtual Network 2 | &#8594;| Azure VMware Solution Cloud Region 1| Yes, traffic is inspected at Hub 2 firewall|
| 5 | Virtual Network 1 | &#8594;| Azure VMware Solution Cloud Region 2| Yes, traffic is inspected at Hub 1 firewall
| 6 | Virtual Network 2 | &#8594;| Azure VMware Solution Cloud Region 2| Yes, traffic is inspected at Hub 2 firewall|
| 8 | Virtual Network 1 | &#8594;| on-premises | Yes, traffic is inspected at Hub 1 firewall|
| 9 | Virtual Network 2 | &#8594;| on-premises | Yes, traffic is inspected at Hub 2 firewall|
| 10 | Virtual Network 1 | &#8594;| Virtual Network 2 | Yes, traffic is inspected at the Hub 1 firewall, then flows over the inter-hub connection to be inspected by Hub 2 firewall|

### Internet connectivity

This section focuses only on how internet connectivity is provided for Azure native resources in Virtual Networks and Azure VMware Solution Private Clouds in both regions. There are several options to provide internet connectivity to Azure VMware Solution. - see [Internet Access Concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access)

Option 1: Internet Service hosted in Azure  
Option 2: VMware Solution Managed SNAT  
Option 3: Azure Public IPv4 address to NSX-T Data Center Edge  

Although you can use all three options with Dual Region Secure Virtual WAN with Routing Intent,  "Option 1: Internet Service hosted in Azure" is the best option when using Secure Virtual WAN with Routing Intent and is the option that is used to provide internet connectivity in the scenario.  

With Routing Intent, you have the option to generate a default route from the hub firewall. This default route is advertised to your Virtual Networks and Azure VMware Solution private clouds. This section is broken into two sections, one that explains internet connectivity from an Azure VMware Solution perspective and another from the Virtual Network perspective.

#### Azure VMware Solution Internet Connectivity
From an Azure VMware Solution Private Cloud perspective, you have the availability to achieve internet connectivity redundancy because it learns the default route from both its local regional hub and its cross-regional hub. The Azure VMware Solution private cloud always prioritizes the local regional hub for primary internet access connectivity. The cross-regional hub serves as an internet backup in the event that the local regional hub is down. This setup provides internet access redundancy for outbound traffic only. For inbound internet traffic to Azure VMware Solution workloads, consider using Azure Front Door or Traffic Manager for regional high availability.

Going into more detail, the Azure VMware Solution private cloud's preferred default route "∞ 0.0.0.0/0" is received via connection "D" from its local regional hub. Additionally, the Azure VMware Solution private cloud receives a backup default route "△ 0.0.0.0/0," which originates on the cross-regional hub and advertised across the Global Reach (C) connection. However, if you enable default route propagation on your on-premises ExpressRoutes for connection “E”, cross-regional internet traffic is directed through this path as well. For example, cross-regional internet traffic from Azure VMware Private Cloud 1 to Hub 2 is distributed using Equal-Cost Multipath (ECMP) routing across Global Reach (C) to connection “D” and Global Reach (A) to connection “E”. Similarly, return traffic from Hub 2 to Private Cloud Region 1 will traverse the same paths utilizing Equal-Cost Multipath (ECMP). Ensure that you explicitly configure Global Reach (A), Global Reach (B), and Global Reach (C). It is imperative to do this to prevent connectivity issues between Global Reach sites. 

When Routing Intent is enabled for internet traffic, the default behavior of the Secure Virtual WAN Hub is to not advertise the default route across ExpressRoute circuits. To ensure the default route is propagated to the Azure VMware Solution from the Azure Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits - see [To advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints). It is important to note that this setting should not be enabled for on-premises ExpressRoute circuits. Even though connection "D" advertises the default route "∞ 0.0.0.0/0" to the Azure VMware Solution private clouds, the default route will also be advertised to on-premises via Global Reach (A) and Global Reach (B). As a result, it is recommended to implement a BGP Filter on your on-premises equipment to exclude learning the default route. This step ensures that on-premises internet connectivity is not impacted.

#### Virtual Network Internet Connectivity
Each Virtual Network will egress to the internet using its local regional hub firewall. When Routing Intent for internet access is enabled, the default route generated from the Secure VWAN Hub is automatically advertised to the hub-peered Virtual Network connections. However, this default route is never advertised across regional hubs over the ‘inter-hub’ link. Therefore, Virtual Networks use their local regional hub for internet access and have no backup internet connectivity to the cross-regional hub.

For more information, see the traffic flow section.

![Diagram of Dual-Region Azure VMware Solution with Internet](./media/dual-region-virtual-wan-5.png)  

**Traffic Flow Chart**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? | Internet Breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 11 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet| Yes, traffic is inspected at Hub 1 firewall| Via Hub 1 firewall
| 12 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic is inspected at Hub 2 firewall| Via Hub 2 firewall
| 15 | Virtual Network 1 | &#8594;| Internet | Yes, traffic is inspected at Hub 1 firewall| Via Hub 1 firewall|
| 16 | Virtual Network 2 | &#8594;| Internet | Yes, traffic is inspected at Hub 2 firewall| Via Hub 2 firewall|

**The traffic flow 13 and 14 is only valid if there is an outage affecting a local regional hub. For instance, if the local regional hub of Azure VMware Solution experiences an outage, internet traffic will be rerouted to the cross-regional hub for internet connectivity.**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? | Internet Breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 13 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at Hub 2 firewall| Via Hub 2 firewall|
| 14 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at Hub 1 firewall| Via Hub 1 firewall|


## Next steps

- For more information on Virtual WAN hub configuration, see [About virtual hub settings](/azure/virtual-wan/hub-settings).
- For more information on how to configure Azure Firewall in a Virtual Hub, see [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall).
- For more information on how to configure the Palo Alto Next Generation SAAS firewall on Virtual WAN, see [Configure Palo Alto Networks Cloud NGFW in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw).
- For more information on Virtual WAN hub routing intent configuration, see [Configure routing intent and policies through Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva).
