---
title: Use a Single-Region Azure VMware Solution Design That Has Virtual WAN and Global Reach
description: Learn how to configure network connectivity for a single-region Azure VMware Solution private cloud that has secure Virtual WAN and Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/21/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Use a single-region Azure VMware Solution design that has Virtual WAN and Global Reach

This article describes best practices for Azure VMware Solution in a single region when you use secure Azure Virtual WAN with routing intent. It provides connectivity and traffic flow recommendations for secure Virtual WAN with routing intent and Azure ExpressRoute Global Reach. This article describes the topology for designs in Azure VMware Solution private clouds, on-premises sites, and Azure-native resources. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article.

## Use secure Virtual WAN in a single region
  
Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. You must have a secure Virtual WAN hub if you use routing intent. 

> [!NOTE]
> When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preferences](/azure/virtual-wan/about-virtual-hub-routing-preference).

This scenario's hub has the following configuration:

- The single-region network has a Virtual WAN instance and one hub.

- The hub has an Azure Firewall instance deployed, which makes it a secure Virtual WAN hub.
- The secure Virtual WAN hub has routing intent enabled.

This scenario also has these components:

- A single region has its own Azure VMware Solution private cloud and an Azure virtual network.

- An on-premises site connects back to the hub.
- The environment has Global Reach connectivity.
- Global Reach establishes a direct logical link via the Microsoft backbone, which connects Azure VMware Solution to on-premises.
- Global Reach connections don't transit the hub firewall. So Global Reach traffic that goes both ways between on-premises and Azure VMware Solution doesn't get inspected.

> [!NOTE]
> To enhance security between Global Reach sites, consider inspecting traffic within the Azure VMware Solution environment's NSX-T or an on-premises firewall.

The following diagram shows an example of this scenario.

:::image type="content" source="./media/single-region-virtual-wan-global-reach/single-region-virtual-wan-1.svg" alt-text="Diagram that shows Azure VMware Solution in a single region." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud-managed ExpressRoute connection to the hub  |
| A | Azure VMware Solution Global Reach connection to on-premises  |
| E | On-premises ExpressRoute connection to the hub  |

## Single-region secure Virtual WAN traffic flows

The following sections describe traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

### Azure VMware Solution private cloud connectivity and traffic flows

The following diagram shows the traffic flows for the Azure VMware Solution private cloud. 

:::image type="content" source="./media/single-region-virtual-wan-global-reach/single-region-virtual-wan-2.svg" alt-text="Diagram that shows a single-region Azure VMware Solution that has a cross-Azure VMware Solution topology." border="false":::
 
The following table describes the traffic flow in the preceding diagram. 

| Traffic flow number | Source | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- |
| 1 | Azure VMware Solution cloud | Virtual network| Yes |
| 2 | Azure VMware Solution cloud | On-premises | No |

The Azure VMware Solution private cloud connects to its hub via ExpressRoute connection **D**. The Azure VMware Solution cloud region establishes a connection to on-premises via ExpressRoute Global Reach connection **A**. Traffic that travels via Global Reach doesn't transit the hub firewall.

For your scenario, configure Global Reach to prevent connectivity problems between on-premises and Azure VMware Solution.

### On-premises connectivity and traffic flow

The following diagram shows the on-premises site connected the hub via ExpressRoute connection **E**. On-premises systems can communicate to Azure VMware Solution via the Global Reach connection **A**.

For your scenario, configure Global Reach to prevent connectivity problems between on-premises and Azure VMware Solution.

:::image type="content" source="./media/single-region-virtual-wan-global-reach/single-region-virtual-wan-3.svg" alt-text="Diagram that shows a single-region Azure VMware Solution that has an on-premises connection." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- |
| 3 | On-premises | Azure VMware Solution cloud | No |
| 4 | On-premises | Virtual network | Yes |

### Azure virtual network connectivity and traffic flow

A secure hub that has routing intent enabled sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16) to peered virtual networks, along with any other prefixes that are added as private-traffic prefixes. For more information, see [Routing intent private-address prefixes](/azure/virtual-wan/how-to-routing-policies#nva). This scenario has routing intent enabled, so all resources in the virtual network possess the default RFC 1918 addresses and use the hub firewall as the next hop. All traffic that enters and exits the virtual network transits the hub firewall.

The following diagram shows how the virtual network peers directly to the hub.

:::image type="content" source="./media/single-region-virtual-wan-global-reach/single-region-virtual-wan-4.svg" alt-text="Diagram that shows a single-region Azure VMware Solution that has a virtual network connection." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- |
| 5 | Virtual network | Azure VMware Solution cloud | Yes |
| 6 | Virtual network | Azure VMware Solution cloud | Yes |

### Internet connectivity

This section describes how to provide internet connectivity to Azure-native resources in a virtual network and in a Azure VMware Solution private cloud. For more information, see [Internet connectivity design considerations](/azure/azure-VMware/concepts-design-public-internet-access). You can use the following options to provide internet connectivity to Azure VMware Solution.

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed Source Network Address Translation (SNAT)  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge  

A single-region secure Virtual WAN design that has routing intent supports all options, but we recommend option 1. The scenario later in this article uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

When you use routing intent, you can generate a default route from the hub firewall. This default route advertises to your virtual network and to Azure VMware Solution.

#### Azure VMware Solution and virtual network internet connectivity

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To help ensure that the default route propagates to Azure VMware Solution from Virtual WAN, you must enable default-route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [Advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

After you enable default-route propagation, connection **D** advertises the default route 0.0.0.0/0 from the hub. Don't enable this setting for on-premises ExpressRoute circuits. Connection **D** advertises the default route 0.0.0.0/0 to Azure VMware Solution, but Global Reach (connection **A**) also advertises the default route to on-premises. As a result, we recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment so that it doesn't learn the default route. This step helps ensure that your configuration doesn't affect on-premises internet connectivity.

:::image type="content" source="./media/single-region-virtual-wan-global-reach/single-region-virtual-wan-5.svg" alt-text="Diagram of a single-region Azure VMware Solution that has an internet connection." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- |
| 7 | Azure VMware Solution cloud | The internet| Yes |
| 8 | Virtual network | The internet | Yes |

When you enable routing intent for internet access, the default route that generates from the secure Virtual WAN hub automatically advertises to the hub-peered virtual network connections. Note that in the virtual machines' network interface cards (NICs) in the virtual network, the 0.0.0.0/0 next hop is the hub firewall. To find the next hop, select *Effective routes* in the NIC. 

## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud Next Generation Firewall in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)


