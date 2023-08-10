---
title: Network considerations for Azure VMware Solution dual-region deployments with Secure Virtual WAN Hub
description: Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions with Secure Virtual WAN.
author: jasonmedina
ms.author: jasonmedina
ms.date: 08/09/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Network considerations for Azure VMware Solution dual-region deployments using Secure Virtual WAN Hub with Routing-Intent

This article describes the best practices for connectivity, traffic flows, and high availability of dual-region Azure VMWare Solution when using Azure Secure Virtual WAN with Routing Intent. This article will break down Virtual WAN with Routing Intent topology from the perspective of Azure VMWare Solution private clouds, On-premise sites, and Azure native. How to implement and configure Secure Virtual WAN with Routing Intent is out of the scope and will not be discussed in this document.

The document assumes readers have a basic understanding of Virtual WAN and Secure Virtual WAN with Routing Intent.

**Virtual WAN**  
[What is Virtual WAN?](/azure/virtual-wan/virtual-wan-about)

**Virtual WAN Routing Intent**  
[How to configure Virtual WAN Hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies)
  
## Dual-region with Secure Virtual WAN scenario  
Secure Virtual WAN with Routing Intent is only supported with Virtual WAN Standard SKU. Secure Virtual WAN with Routing Intent provides the capability to send all Internet traffic and Private network traffic (RFC 1918) to a security solution like Azure Firewall, a third-party NVA, or SaaS. In the scenario, we have a network topology that spans two regions. There is one Virtual WAN with two Hubs, Hub1 and Hub2. Hub1 is in Region 1, and Hub2 is in Region 2.Each Hub in both regions has its instance of Azure Firewall deployed(Hub1Fw, Hub2Fw), essentially making them Secure Virtual WAN Hubs. Having Secure Virtual WAN hubs is a technical prerequisite to Routing Intent. Secure Virtual WAN Hub1 and Hub2 have Routing Intent enabled.  

Each region has its own Azure VMWare Solution Private Cloud and an Azure Virtual Network. There is also an on-premise site connecting to both regions, which we will review in more detail later in this document.  
![Diagram of Dual-Region Azure VMWare Solution Scenario](./media/dual-region-virtual-wan-1.png)

### Understanding Topology Connectivity 
Connection Color | Description  |
|:-------------------- |:--------------------  |
| Brown Connections | Azure VMWare Solution private cloud connection to its local regional hub.  |
| Pink Connections | Azure VMWare Solution private cloud connection to its cross-regional hub.  |
| Orange Connection | Azure VMWare Solution Region 1 Global Reach connection back to on-premise.  |
| Green Connection | Azure VMWare Solution Region 2 Global Reach connection back to on-premise.  |
| Purple Connection | Azure VMWare Solution Global Reach connection between the two private clouds' managed circuits.  |
| Black Connections | On-premise connectivity via ExpressRoute to both regional hubs.  |
| Inter-Hub Connection | When two hubs are deployed under the same Virtual WAN  |

## Dual-region Secure Virtual WAN Traffic Flows

The following sections below will discuss traffic flows and connectivity for Azure VMWare Solution, On-Premise, Azure Virtual Networks, and the Internet. 

### Azure VMware Solution cross-region connectivity & traffic flows

This section will focus on only the Azure VMWare Solution Cloud Region 1 and Azure VMWare Solution Cloud Region 2. Each Azure VMWare Solution private cloud will have an ExpressRoute connection to its local regional hub (brown connections) and an ExpressRoute connection to the cross-regional hub (pink connections).

Each Azure VMWare Solution Cloud Region connects back to on-premise via Global Reach. Azure VMWare Solution Cloud Region 1 Global Reach connection is shown in orange as "Global Reach (A)". Azure VMWare Solution Cloud Region 2 Global Reach connection is shown in green as "Global Reach (B)". Both Azure VMWare Solution private clouds are connected directly to each other via Global Reach shown in purple as Global Reach (C). Keep in mind that Global Reach traffic will never transit any hub firewalls. See traffic flow section below for more information.  

The diagram depicts how each Azure VMWare Solution Cloud will learn routes from their local and cross-regional hubs. All blue routes are from Region 1, and all red routes are from Region 2. 

![Diagram of Dual-Region Azure VMWare Solution with Cross Azure VMWare Solution Topology](./media/dual-region-virtual-wan-2.png)

**Traffic Flow**
| From |   To |  Hub 1 Virtual Networks | On-Premise | Hub 2 Virtual Networks | Cross-Regional Azure VMWare Solution Private Cloud|
| -------------- | -------- | ---------- | ---| ---| ---|
| Azure VMWare Solution Cloud Region 1    | &#8594;| Hub1Fw>Virtual Network1|  GlobalReach(A)>OnPremise   | Hub2Fw>Virtual Network2 | Global Reach(C)>Azure VMWare Solution Cloud Region 2|
| Azure VMWare Solution Cloud Region 2   | &#8594;|  Hub1Fw>Virtual Network1 |  GlobalReach(B)>OnPremise   | Hub2Fw>Virtual Network2 | Global Reach(C)>Azure VMWare Solution Cloud Region 1|

### On-Premise connectivity & traffic flow

This section will focus only on the on-premise site. As shown in the diagram below, the On-Premise site will have an ExpressRoute connection to both Region 1 and Region 2 hubs (black connections).

On-Premise can communicate to Azure VMWare Solution Cloud Region 1 via orange connection "Global Reach (A)". On-Premise will also be able to communicate with Azure VMWare Solution Cloud Region 2 via green connection "Global Reach (B)".

The diagram shows how On-Premise will learn routes from both regional hubs and both Azure VMWare Solution Private clouds. All blue routes are from Region 1, and all red routes are from Region 2. Black routes are on-premise routes and are advertised back to Azure.

![Diagram of Dual-Region Azure VMWare Solution with On-Premise](./media/dual-region-virtual-wan-3.png)

**Traffic Flow**
| From |   To |  Hub 1 Virtual Networks | Hub 2 Virtual Networks | Azure VMWare Solution Region 1| Azure VMWare Solution Region 2| 
| -------------- | -------- | ---------- | ---| ---| ---|
| On-Premise    | &#8594;| Hub1Fw>Virtual Network1|  Hub2Fw>Virtual Network2  | Global Reach(A)>Azure VMWare Solution Cloud Region 1 | Global Reach(B)>Azure VMWare Solution Cloud Region 2| 

### Azure Virtual Network connectivity & traffic flow

This section will focus only on connectivity from an Azure Virtual Network perspective. As shown in the diagram below, both Virtual Network1 and Virtual Network2 will have a Virtual Network peering directly to its local regional hub. 

The diagram shows how all Azure native resources in Virtual Network1 and Virtual Network2 will learn routes under their "Effective Routes". A Secure Hub with Routing Intent enabled will always send the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered Virtual Networks, plus any additional prefixes that have been added as "Private Traffic Prefixes" - see [Routing Intent Private Address Prefixes](/azure/virtual-wan/how-to-routing-policies#azurefirewall). In our case, since Routing Intent is enabled, all resources within Virtual Network1 and Virtual Network2 will have the default RFC 1918 address with a next-hop of their local regional hub firewall. All traffic ingressing and egressing the Virtual Networks will always transit the Hub Firewalls. Please see the traffic flow below for more detailed information.

![Diagram of Dual-Region Azure VMWare Solution with Virtual Networks](./media/dual-region-virtual-wan-4.png)

**Traffic Flow**
| From |   To |  On-Premise | Azure VMWare Solution Region 1 | Azure VMWare Solution Region 2| Cross-Region Virtual Network| 
| -------------- | -------- | ---------- | ---| ---| ---|
| Virtual Network1    | &#8594;| Hub1Fw>OnPremise|  Hub1Fw>Azure VMWare Solution Cloud Region 1  | Hub1Fw>Azure VMWare Solution Cloud Region 2 | Hub1Fw>Hub2Fw>Virtual Network2 |
| Virtual Network2    | &#8594;| Hub2Fw>OnPremise|  Hub2Fw>Azure VMWare Solution Cloud Region 1  | Hub2Fw>Azure VMWare Solution Cloud Region 2 | Hub2Fw>Hub1Fw>Virtual Network1 |

### Internet connectivity

This section will focus only on how internet connectivity will be provided for Azure native resources in Virtual Networks and Azure VMWare Solution Private Clouds in both regions. There are several options to provide internet connectivity to Azure VMWare Solution. - see [Internet Access Concepts for Azure VMWare Solution](/azure/azure-vmware/concepts-design-public-internet-access)

Option 1: Internet Service hosted in Azure  
Option 2: VMWare Solution Managed SNAT  
Option 3: Azure Public IPv4 address to NSX-T Data Center Edge  

Although you can use all three options with Dual Region Secure Virtual WAN with Routing Intent,  "Option 1: Internet Service hosted in Azure" is the best option when using Secure Virtual WAN with Routing Intent and is the option that is used to provide internet connectivity in the scenario.  

As mentioned earlier, when you enable Routing Intent on the Secure Hub, it will advertise RFC 1918 to all peered Virtual Networks. However, you also have the option to advertise a default route 0.0.0.0/0 to provide internet connectivity for downstream resources. The blue default route originated in Hub1 with a next hop of HubFw1 and the red default route originated in Hub2 with a next hop of HubFw2.

 Each Virtual Network will egress to the internet using its local regional hub firewall. The default route is never advertised across regional hubs over the "inter-hub" link. Therefore, Virtual Networks can only use their local regional hub for internet access. 

From an Azure VMWare Solution Private Cloud perspective, when advertising the default route across regional connections (pink connections), you need to configure route maps with BGP prepending on the Secure Virtual WAN hubs. If you do not use BGP prepending Azure VMWare Solution Cloud regions will load balance internet traffic between its local and regional hub. This load balance would introduce asymmetric traffic and impact internet performance. 

Before we continue, let's go over what BGP prepending is. BGP prepending is a technique in inter-domain routing where an AS artificially extends the AS Path by adding its own AS number multiple times to influence inbound traffic. By making the path appear longer, the AS aims to divert traffic away from the prepended route and towards other potentially more favorable paths. You can use any BGP Private AS when using BGP prepending. 

The goal here is to use BGP prepending for only the default routes across cross regional ExpressRoute links (pink connections) down to Azure VMWare Solution Private clouds. We will not prepend the default route across local ExpressRoute links (brown connections) down the Azure VMWare Solution Private Clouds. There is a new feature in Virtual WAN called Route Maps where you can configure a Route Map and apply the Route Map to the ExpressRoute connection of your choosing. 

In conclusion, you will have Azure VMWare Solution Private Clouds using internet access to their regional local hubs as the preferred route and using the cross regional hub as a backup in the event there is an outage within the local regional hub. Please see below for traffic flow for internet. 

Another thing to keep note is with Routing Intent you have the option to disable advertising the default route over any ExpressRoute of your choosing. We recommend not to advertise the default route to your on-premise ExpressRoute connections. 

![Diagram of Dual-Region Azure VMWare Solution with Internet](./media/dual-region-virtual-wan-5.png)

**Traffic Flow**
| From |   To |  Primary Internet Route | Backup Internet Route
| -------------- | -------- | ---------- | ---------- |
| Virtual Network1    | &#8594;| Hub1Fw>Internet| None|
| Virtual Network2    | &#8594;| Hub2Fw>Internet| None|
| Azure VMWare Solution Cloud Region 1    | &#8594;| Hub1Fw>Internet| Hub2Fw>Internet|
| Azure VMWare Solution Cloud Region 2    | &#8594;| Hub2Fw>Internet| Hub1Fw>Internet|


## Next steps

- For more information on Azure VMware Solution network features, see [Azure VMware Solution networking and interconnectivity concepts](/azure/azure-vmware/concepts-networking).
- For more information on internet connectivity for Azure VMware Solution, see [Internet connectivity design considerations](/azure/azure-vmware/concepts-design-public-internet-access).
- For more information on Azure VMware Solution network topologies, see [Example architectures for Azure VMware Solutions](/azure/cloud-adoption-framework/scenarios/azure-vmware/example-architectures)
