---
title: Network considerations for Azure VMware Solution dual-region deployments with Secure Virtual WAN Hub
description: Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions with Secure Virtual WAN.
author: jasonmedina
ms.author: jasonmedina
ms.date: 04/02/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Dual-region deployments using Secure Virtual WAN Hub with Routing-Intent

This article describes the best practices for connectivity, traffic flows, and high availability of dual-region Azure VMware Solution when using Azure Secure Virtual WAN with Routing Intent. This article breaks down Virtual WAN with Routing Intent topology from the perspective of Azure VMware Solution private clouds, on-premises sites, and Azure native. The implementation and configuration of Secure Virtual WAN with Routing Intent are beyond the scope and are not discussed in this document.

The document assumes readers have a basic understanding of Virtual WAN and Secure Virtual WAN with Routing Intent.

**Virtual WAN**  
[What is Virtual WAN?](/azure/virtual-wan/virtual-wan-about)

**Virtual WAN Routing Intent**  
[How to configure Virtual WAN Hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies)
  
## Dual-region with Secure Virtual WAN scenario  
Secure Virtual WAN with Routing Intent is only supported with Virtual WAN Standard SKU. Secure Virtual WAN with Routing Intent provides the capability to send all Internet traffic and Private network traffic (RFC 1918) to a security solution like Azure Firewall, a third-party Network Virtual Appliance (NVA), or SaaS solution. In the scenario, we have a network topology that spans two regions. There is one Virtual WAN with two Hubs, Hub1 and Hub2. Hub1 is in Region 1, and Hub2 is in Region 2. Each Hub has its own instance of Azure Firewall deployed(Hub1Fw, Hub2Fw), essentially making them each Secure Virtual WAN Hubs. Having Secure Virtual WAN hubs is a technical prerequisite to Routing Intent. Secure Virtual WAN Hub1 and Hub2 have Routing Intent enabled.    

Each region has its own Azure VMware Solution Private Cloud and an Azure Virtual Network. There is also an on-premises site connecting to both regions, which we review in more detail later in this document.  
![Diagram of Dual-Region Azure VMware Solution Scenario](./media/dual-region-virtual-wan-1.png)

### Understanding Topology Connectivity 

| Connection | Description  |
|:-------------------- |:--------------------  |
| Connections (D) | Azure VMware Solution private cloud connection to its local regional hub.  |
| Connection (A) | Azure VMware Solution Region 1 Global Reach connection back to on-premises.  |
| Connection (B) | Azure VMware Solution Region 2 Global Reach connection back to on-premises.  |
| Connection (C) | Azure VMware Solution Global Reach connection between the two private clouds' managed circuits.  |
| Connections (E) | on-premises connectivity via ExpressRoute to both regional hubs.  |
| Inter-Hub Connection | When two hubs are deployed under the same Virtual WAN  |

## Dual-region Secure Virtual WAN Traffic Flows

The following sections cover traffic flows and connectivity for Azure VMware Solution, on-premises, Azure Virtual Networks, and the Internet.

### Azure VMware Solution cross-region connectivity & traffic flows

This section focuses on only the Azure VMware Solution Cloud Region 1 and Azure VMware Solution Cloud Region 2. Each Azure VMware Solution private cloud has an ExpressRoute connection to its local regional hub (connections labeled as "D").

Each Azure VMware Solution Cloud Region connects back to an on-premises via ExpressRoute Global Reach. Azure VMware Solution Cloud Region 1 Global Reach connection is shown as "Global Reach (A)". The Azure VMware Solution Cloud Region 2 Global Reach connection is shown as "Global Reach (B)". Both Azure VMware Solution private clouds are connected directly to each other via Global Reach shown as Global Reach (C). Keep in mind that Global Reach traffic will never transit any hub firewalls. See traffic flow section for more information.  

The diagram below illustrates traffic flows from the perspective of the Azure VMware Solution Private Clouds. 

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

On-premises systems can communicate to Azure VMware Solution Cloud Region 1 via connection "Global Reach (A)". On-premises systems are also able to communicate with Azure VMware Solution Cloud Region 2 via connection "Global Reach (B)". See traffic flow section for more information.  

The diagram below illustrates traffic flows from an on-premises perspective.

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

A Secure Hub with enabled Routing Intent always sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered Virtual Networks, plus any other prefixes that have been added as "Private Traffic Prefixes" - see [Routing Intent Private Address Prefixes](/azure/virtual-wan/how-to-routing-policies#azurefirewall). In our scenario, with Routing Intent enabled, all resources in Virtual Network 1 and Virtual Network 2 currently possess the default RFC 1918 addresses and use their local regional hub firewall as the next hop. All traffic ingressing and egressing the Virtual Networks will always transit the Hub Firewalls. See traffic flow section for more information.  

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
| 10 | Virtual Network 1 | &#8594;| Virtual Network 2 | Yes, traffic is inspected at Hub 1 and Hub 2 firewalls and flows across the inter-hub connection|

### Internet connectivity

This section focuses only on how internet connectivity is provided for Azure native resources in Virtual Networks and Azure VMware Solution Private Clouds in both regions. There are several options to provide internet connectivity to Azure VMware Solution. - see [Internet Access Concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access)

Option 1: Internet Service hosted in Azure  
Option 2: VMware Solution Managed SNAT  
Option 3: Azure Public IPv4 address to NSX-T Data Center Edge  

Although you can use all three options with Dual Region Secure Virtual WAN with Routing Intent,  "Option 1: Internet Service hosted in Azure" is the best option when using Secure Virtual WAN with Routing Intent and is the option that is used to provide internet connectivity in the scenario.  

As mentioned earlier, when you enable Routing Intent on the Secure Hub, it advertises RFC 1918 to all peered Virtual Networks. However, you can also advertise a default route 0.0.0.0/0 for internet connectivity to downstream resources. 

From an Azure VMware Solution Private Cloud perspective, it can use its local regional hub for primary internet access and its cross-regional hub as an internet backup in the event the local regional hub is down. This gives you internet access redundancy for outbound traffic only. For inbound internet traffic to Azure VMware Solution workloads, you should consider using Azure Front Door or Traffic Manager in the event of a regional outage.

The preferred default route is received via connection “D” from its local regional hub, and the backup default route is received from the cross-regional hub via Global Reach A, B, and C connections. Since Global Reach (C) is only one hop away, it becomes the preferred route over the two hops required for Global Reach (A) and Global Reach (B). In the event that Global Reach (C) is not configured or is down, internet traffic will transit through Global Reach (A) and Global Reach (B).

 Each Virtual Network will egress to the internet using its local regional hub firewall. The default route is never advertised across regional hubs over the "inter-hub" link. Therefore, Virtual Networks can only use their local regional hub for internet access and will have no backup internet connectivity to the cross-regional hub. 

In summary, Azure VMware Solution Private Clouds prioritize internet access via regional local hubs, using the cross-regional hub as a backup during local hub outages. Virtual Networks, on the other hand, only use their regional hub for internet access and do not rely on the cross-regional hub for internet backup. For further details, refer to the traffic flow section. Another important point is that with Routing Intent, you can choose not to advertise the default route over specific ExpressRoute connections. If you do not want to learn the default route from Azure, we recommend not advertising the default route to your on-premises ExpressRoute connections, ensuring that on-premises internet connectivity is not impacted.

![Diagram of Dual-Region Azure VMware Solution with Internet](./media/dual-region-virtual-wan-5.png)
**Traffic Flow Chart**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? | Internet Breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 11 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet| Yes, traffic is inspected at Hub 1 firewall| Via Hub 1 firewall
| 12 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic is inspected at Hub 2 firewall| Via Hub 2 firewall
| 15 | Virtual Network 1 | &#8594;| Internet | Yes, traffic is inspected at Hub 1 firewall| Via Hub 1 firewall|
| 16 | Virtual Network 2 | &#8594;| Internet | Yes, traffic is inspected at Hub 2 firewall| Via Hub 2 firewall|

**The traffic flow described below is only valid if there is an outage affecting a hub. For instance, if the local regional hub of Azure VMware Solution experiences an outage, internet traffic will be rerouted to the cross-regional hub for connectivity.**

| Traffic Flow Number | Source |   Direction | Destination | Traffic Inspected on Secure Virtual WAN hub firewall? | Internet Breakout |
| - | -------------- | -------- | ---------- | ---------- | ---------- |
| 13 | Azure VMware Solution Cloud Region 1 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at Hub 2 firewall| Via Hub 2 firewall|
| 14 | Azure VMware Solution Cloud Region 2 | &#8594;| Internet | Yes, traffic will transit Global Reach (C) and inspected at Hub 1 firewall| Via Hub 1 firewall|


## Next steps

- For more information on Azure VMware Solution network features, see [Azure VMware Solution networking and interconnectivity concepts](/azure/azure-VMware/concepts-networking).
- For more information on internet connectivity for Azure VMware Solution, see [Internet connectivity design considerations](/azure/azure-VMware/concepts-design-public-internet-access).
- For more information on Azure VMware Solution network topologies, see [Example architectures for Azure VMware Solutions](/azure/cloud-adoption-framework/scenarios/azure-VMware/example-architectures)
