---
title: Single-region Azure VMware Solution design with Global Reach, using secure Virtual WAN with routing intent
description: Learn how to configure network connectivity when a single-region Azure VMware Solution private cloud is deployed with secure Virtual WAN and Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/11/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Single-region deployment using secure Virtual WAN Hub with routing intent and Global Reach

This article describes the best practices for connectivity and traffic flows with single-region Azure VMware Solution when you use Azure secure Virtual WAN with routing intent. You learn the design details of using secure Virtual WAN with routing intent, when you use Global Reach. This article breaks down Virtual WAN with routing intent topology from the perspective of an Azure VMware Solution private cloud, on-premises sites, and Azure native. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article.

## Single-region with secure Virtual WAN scenario
  
Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. You must have a secure Virtual WAN hub if you use routing intent. 

> [!NOTE]
> When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference).

This scenario's hub has the following configuration:

- The single-region network and a Virtual WAN has one hub.

- The hub has an Azure Firewall instance deployed, which makes it a secure Virtual WAN hub.
- The secure Virtual WAN hub has routing intent enabled.

This scenario also consists of the following components:

- The single region consists of its own Azure VMware Solution private cloud and an Azure virtual network.

- An on-premises site connects back to the hub.
- Global Reach connectivity exists within the environment.
- Global Reach establishes a direct logical link via the Microsoft backbone, which connects Azure VMware Solution to on-premises.
- Global Reach connections don't transit the hub firewall, as shown in the following diagram. So Global Reach traffic that goes both ways between on-premises and Azure VMware Solution remains uninspected.

> [!NOTE]
> When you use Global Reach, consider inspecting traffic within the Azure VMware Solution environment's NSX-T or an on-premises firewall, which enhances security between Global Reach sites.

:::image type="content" source="./media/single-region-virtual-wan-1.png" alt-text="Diagram that shows single-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud-managed ExpressRoute connection to the hub  |
| A | Azure VMware Solution Global Reach connection back to on-premises  |
| E | On-premises ExpressRoute connection to the hub  |

### Single-region secure Virtual WAN traffic flows

The following sections describe traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

## Azure VMware Solution connectivity and traffic flows

This section focuses only on the Azure VMware Solution Cloud perspective. Azure VMware Solution private cloud has an ExpressRoute connection to its hub (connection labeled as "D").

The Azure VMware Solution cloud region establishes a connection to on-premises via ExpressRoute Global Reach, depicted as Global Reach (A) in the diagram. Traffic that travels via Global Reach doesn't transit the hub firewall.

Ensure that you explicitly configure Global Reach (A). You must do this step to prevent connectivity problems between on-premises and Azure VMware Solution. For more information, see the traffic flow section.

The following diagram shows the traffic flows from the perspective of the Azure VMware Solution private cloud. 

:::image type="content" source="./media/single-region-virtual-wan-2.png" alt-text="Diagram that shows the single-region Azure VMware Solution with cross Azure VMware Solution topology." border="false":::
 
The following table describes the traffic flow in the preceding diagram. 

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud | &#8594;| Virtual network| Yes |
| 2 | Azure VMware Solution cloud | &#8594;| On-premises | No, traffic bypasses firewall and transits Global Reach (A)|

## On-premises connectivity and traffic flow

This section focuses only on the on-premises site. As shown in the diagram, the on-premises site has an ExpressRoute connection to the hub (connections labeled as "E"). On-premises systems can communicate to Azure VMware Solution via connection Global Reach (A).

Ensure that you explicitly configure Global Reach (A). It's imperative to do this step to prevent connectivity issues between on-premises and Azure VMware Solution. For more information, see traffic flow section.

The diagram illustrates traffic flows from an on-premises perspective.

:::image type="content" source="./media/single-region-virtual-wan-3.png" alt-text="Diagram that shows a single-region Azure VMware Solution with on-premises.":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 3 | On-premises | &#8594;| Azure VMware Solution cloud | No, traffic bypasses firewall and transits Global Reach (A) |
| 4 | On-premises | &#8594;| Virtual network | Yes |

## Azure virtual network connectivity and traffic flow

This section focuses only on connectivity from the Azure virtual network perspective. As depicted in the diagram, the virtual network peers directly to the hub.

A secure hub with enabled routing intent always sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered virtual networks, plus any other prefixes that are added as *private traffic prefixes*. For more information, see [Routing intent private address prefixes](/azure/virtual-wan/how-to-routing-policies#nva). In this scenario, with routing intent enabled, all resources in the virtual network currently possess the default RFC 1918 addresses and use the hub firewall as the next hop. All traffic that ingresses and egresses the virtual network always transits the hub firewall. For more information, see the traffic flow section.

:::image type="content" source="./media/single-region-virtual-wan-4.png" alt-text="Diagram that shows a single-region Azure VMware Solution with virtual networks." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 5 | Virtual network | &#8594;| Azure VMware Solution cloud | Yes |
| 6 | Virtual network | &#8594;| Azure VMware Solution cloud | Yes |

## Internet connectivity

This section focuses only on how internet connectivity is provided for Azure native resources in the virtual network and the Azure VMware Solution private cloud. Choose from several options to provide internet connectivity to Azure VMware Solution. For more information, see [Internet access concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access).

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed SNAT  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge  

You can use all three options with single-region secure Virtual WAN with routing intent. But when you use secure Virtual WAN with routing intent, you should use option 1. This scenario also uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

When you use routing intent, you can generate a default route from the hub firewall. This default route is advertised to your virtual network and to Azure VMware Solution. This section is broken into two sections, one that explains internet connectivity from an Azure VMware Solution perspective and another from the virtual network perspective.

#### Azure VMware Solution internet connectivity

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To ensure the default route is propagated to the Azure VMware Solution from the Azure Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [To advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

After changes are complete, the default route 0.0.0.0/0 is then advertised via connection "D" from the hub. Don't enable this setting for on-premises ExpressRoute circuits. Even though connection "D" advertises the default route 0.0.0.0/0 to Azure VMware Solution, the default route is also advertised to on-premises via Global Reach (A). As a result, we recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment to exclude learning the default route. This step ensures that your configuration doesn't affect on-premises internet connectivity.

#### Virtual network internet connectivity

When you enable routing intent for internet access, the default route generated from the secure Virtual WAN hub is automatically advertised to the hub-peered virtual network connections. Under *Effective Routes* for the virtual machines' NICs in the virtual network, the 0.0.0.0/0 next hop is the hub firewall.

For more information, see the traffic flow section.

:::image type="content" source="./media/single-region-virtual-wan-5.png" alt-text="Diagram of single-region Azure VMware Solution with internet.":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 7 | Azure VMware Solution cloud | &#8594;| The internet| Yes |
| 8 | Virtual network | &#8594;| The internet | Yes |


## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud NGFW in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)


