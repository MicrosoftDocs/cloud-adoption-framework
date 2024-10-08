---
title: Use a single-region Azure VMware Solution design that doesn't have Global Reach
description: Learn how to configure network connectivity for a single-region Azure VMware Solution private cloud that has secure Virtual WAN and doesn't have Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/21/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Use a single-region Azure VMware Solution design that doesn't have Global Reach

This article describes best practices for Azure VMware Solution in a single region when you use secure Azure Virtual WAN with routing intent. It provides connectivity and traffic flow recommendations for secure Virtual WAN with routing intent. This article describes the topology for designs in Azure VMware Solution private clouds, on-premises sites, and Azure-native resources when you don't use Azure ExpressRoute Global Reach. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article.

If you use a region that doesn't support Global Reach or if you have a security requirement to inspect traffic between Azure VMware Solution and on-premises at the hub firewall, you must open a support ticket to enable ExpressRoute-to-ExpressRoute transitivity. Virtual WAN doesn't support ExpressRoute-to-ExpressRoute transitivity by default. For more information, see [Transit connectivity between ExpressRoute circuits with routing intent](/azure/virtual-wan/how-to-routing-policies#expressroute).

## Use secure Virtual WAN without Global Reach
 
Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic (RFC 1918) to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution.

This scenario's hub has the following configuration:

- The single-region network and a Virtual WAN has one hub.

- The hub has an Azure Firewall instance deployed, which makes it a secure Virtual WAN hub.
- The secure Virtual WAN hub has routing intent enabled.

This scenario also has these components:

- A single region has its own Azure VMware Solution private cloud and an Azure virtual network.

- An on-premises site connects back to the hub.

> [!NOTE]
>  If you use non-RFC 1918 prefixes in your connected on-premises resources, virtual networks, or Azure VMware Solution, specify those prefixes in the *Private Traffic Prefixes* field for routing intent. Enter summarized routes only in the *Private Traffic Prefixes* field to cover your range. Don't enter the exact range that advertises to Virtual WAN because this specification can lead to routing problems. For example, if the ExpressRoute circuit advertises 40.0.0.0/24 from on-premises, enter a /23 Classless Inter-Domain Routing (CIDR) range or larger, for example 40.0.0.0/23, in the *Private Traffic Prefix* field. For more information, see [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva).

> [!NOTE]
>  When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preferences](/azure/virtual-wan/about-virtual-hub-routing-preference).

The following diagram shows an example of this scenario.

:::image type="content" source="./media/single-region-without-globalreach-1.png" alt-text="Diagram that shows a single-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud-managed ExpressRoute connection to the hub  |
| E | On-premises ExpressRoute connection to the hub  |

## Traffic flows for single-region Virtual WAN without Global Reach

The following sections describe traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

### Azure VMware Solution private cloud connectivity and traffic flows

The following diagram shows traffic flows for an Azure VMware Solution private cloud. 

:::image type="content" source="./media/single-region-without-globalreach-2.png" alt-text="Diagram that shows a single-region Azure VMware Solution that has Azure VMware Solution private cloud connectivity." border="false":::

The following table describes the traffic flow in the preceding diagram.  

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud | &#8594;| Virtual network| Yes |
| 2 | Azure VMware Solution cloud | &#8594;| On-premises | Yes |

The Azure VMware Solution private cloud has an ExpressRoute connection to the hub (connection **D**).

When you enable ExpressRoute-to-ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to Azure VMware Solution over connection **D**. In addition to the default RFC 1918 addresses, Azure VMware Solution learns more specific routes from Azure virtual networks and branch networks, such as S2S VPN, P2S VPN, and SD-WAN, that connect to the hub. Azure VMware Solution doesn't learn specific routes from on-premises networks. To route traffic back to on-premises networks, Azure VMware Solution uses the default RFC 1918 addresses that it learned from connection **D**. This traffic transits through the hub firewall. The hub firewall uses the specific routes for on-premises networks to route traffic toward the destinations over connection **E**. Traffic that goes from Azure VMware Solution to virtual networks transits the hub firewall.

### On-premises connectivity and traffic flow

The following diagram shows traffic flows for on-premises connectivity. 

:::image type="content" source="./media/single-region-without-globalreach-3.png" alt-text="Diagram that shows a single-region Azure VMware Solution that has on-premises connectivity." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 3 | On-premises | &#8594;| Azure VMware Solution cloud | Yes |
| 4 | On-premises | &#8594;| Virtual network | Yes |

The on-premises site has an ExpressRoute connection to the hub (connection **E**).

When you enable ExpressRoute to ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses to on-premises over connection **E**. In addition to the default RFC 1918 addresses, on-premises learns more specific routes from Azure virtual networks and branch networks that connect to the hub. On-premises doesn't learn specific routes from Azure VMware Solution networks. To route traffic back to Azure VMware Solution networks, Azure VMware Solution uses the default RFC 1918 addresses that it learned from connection **E**. This traffic transits through the hub firewall. The hub firewall uses the specific routes for Azure VMware Solution networks to route traffic toward the destinations over connection **D**. Traffic that goes from on-premises to virtual networks transits the hub firewall.

When you enable ExpressRoute-to-ExpressRoute transitivity on the hub, it sends the default RFC 1918 addresses to your on-premises network. So you shouldn't advertise the exact RFC 1918 prefixes back to Azure. Advertising the same exact routes creates routing problems within Azure. Instead, you should advertise more specific routes back to Azure for your on-premises networks.

> [!NOTE]
>  If you advertise the default RFC 1918 addresses from on-premises to Azure and want to continue this practice, you need to split each RFC 1918 range into two equal sub-ranges and advertise these sub-ranges back to Azure. The sub-ranges are 10.0.0.0/9, 10.128.0.0/9, 172.16.0.0/13, 172.24.0.0/13, 192.168.0.0/17, and 192.168.128.0/17.

### Azure virtual network connectivity and traffic flow

The following diagram shows traffic flows for Azure virtual network connectivity.

:::image type="content" source="./media/single-region-without-globalreach-4.png" alt-text="Diagram that shows a single-region Azure VMware Solution with virtual networks." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 5 | Virtual network | &#8594;| Azure VMware Solution cloud | Yes |
| 6 | Virtual network | &#8594;| On-premises | Yes |

In this scenario, the virtual network peers directly to the hub. The diagram shows how Azure-native resources in the virtual network learn the routes that are in their **Effective Routes** field. A secure hub that has routing intent enabled sends the default RFC 1918 addresses to peered virtual networks. Azure-native resources in the virtual network don't learn specific routes from outside their virtual network. When you enable routing intent, all resources in the virtual network possess the default RFC 1918 address and use the hub firewall as the next hop. All traffic that ingresses and egresses the virtual networks transit the hub firewall.

### Internet connectivity

This section describes how to provide internet connectivity for Azure-native resources in virtual networks and Azure VMware Solution private clouds in a single region. For more information, see [Internet connectivity design considerations](/azure/azure-VMware/concepts-design-public-internet-access). You can use the following options to provide internet connectivity to Azure VMware Solution.

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed Source Network Address Translation (SNAT)  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge   

A single-region secure Virtual WAN design that has routing intent supports all options, but we recommend option 1. The scenario later in this article uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

When you enable routing intent on the secure hub, it advertises RFC 1918 to all peered virtual networks. BUt you can also advertise a default route 0.0.0.0/0 for internet connectivity to downstream resources. When you use routing intent, you can generate a default route from the hub firewall. This default route advertises to your virtual network and to Azure VMware Solution.

#### Azure VMware Solution and virtual network internet connectivity

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To ensure the default route propagates to Azure VMware Solution from Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [Advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

The diagram shows traffic flows for virtual network and Azure VMware Solution internet connectivity.

:::image type="content" source="./media/single-region-without-globalreach-5.png" alt-text="Diagram that shows single-region Azure VMware Solution that has internet connectivity." border="false":::

The following table describes the traffic flow in the preceding diagram.  

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 7 | Virtual network | &#8594;| The internet| Yes
| 8 | Azure VMware Solution cloud | &#8594;| The internet | Yes

After you enable default route propagation, connection **D** advertises the default route 0.0.0.0/0 from the hub. Don't enable this setting for on-premises ExpressRoute circuits. We recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment. A BGP filter prevents resources from inadvertently learning the default route, adds an extra layer of precaution, and ensures that your configuration doesn't affect on-premises internet connectivity.

When you enable routing intent for internet access, the default route that generates from the secure Virtual WAN hub automatically advertises to the hub-peered virtual network connections. Note that in the virtual machines' network interface cards (NICs) in the virtual network, the 0.0.0.0/0 next hop is the hub firewall. To find the next hop, select *Effective routes* in the NIC.

## Use VMware HCX Mobility Optimized Networking (MON) without Global Reach

HCX Mobility Optimized Networking (MON) is an optional feature that you can enable when you use HCX Network Extension. MON provides optimal traffic routing in certain scenarios to prevent networks from overlapping or looping between the on-premises-based and cloud-based resources on extended networks.

### Egress traffic from Azure VMware Solution
 
When you enable MON for a specific extended network and a virtual machine, you change the traffic flow. After you implement MON, egress traffic from the virtual machine doesn't loop back to on-premises. Instead, it bypasses the Network Extension IPSec tunnel. Traffic for the virtual machine egresses out of the Azure VMware Solution NSX-T Tier-1 gateway, goes to the NSX-T Tier-0 gateway, and then goes to Virtual WAN.

### Ingress traffic to Azure VMware Solution

When you enable MON for a specific extended network and a virtual machine, you introduce the following changes. From Azure VMware Solution NSX-T, MON injects a /32 host route back to Virtual WAN. Virtual WAN advertises this /32 route back to on-premises, virtual networks, and branch networks. This /32 host route ensures that traffic from on-premises, virtual networks, and branch networks doesn't use the Network Extension IPSec tunnel when the traffic goes to the MON-enabled virtual machine. Traffic from source networks goes straight to the MON-enabled virtual machine because it learned the /32 route.

### HCX MON limitation for secure Virtual WAN without Global Reach

When you enable ExpressRoute-to-ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses to both on-premises and Azure VMware Solution. In addition to the default RFC 1918 addresses, both on-premises and Azure VMware Solution learn more specific routes from Azure virtual networks and branch networks that connect to the hub.

But on-premises networks don't learn specific routes from Azure VMware Solution, and Azure VMware Solution doesn't learn specific routes from on-premises networks. Instead, both environments rely on the default RFC 1918 addresses to facilitate routing back to one another via the hub firewall. Therefore, more specific routes, such as HCX MON host routes, don't advertise from the Azure VMware Solution ExpressRoute to the on-premises-based ExpressRoute circuit and vice-versa. The inability to learn specific routes introduces asymmetric traffic flows. Traffic egresses Azure VMware Solution via the NSX-T Tier-0 gateway, but returning traffic from on-premises returns over the Network Extension IPSec tunnel.

### Correct traffic asymmetry

To correct traffic asymmetry, you need to adjust the HCX MON policy routes. MON policy routes determine which traffic goes back to the on-premises gateway via an L2 extension. They also decide which traffic goes through the Azure VMware Solution NSX Tier-0 gateway.

If a destination IP matches and you set it to *allow* in the MON policy configuration, then two actions occur. First, the packet is identified. Second, the system sends the packet to the on-premises gateway through the HCX Network Extension appliance.

If a destination IP doesn't match or you set it to *deny* in the MON policy, the system sends the packet to the Azure VMware Solution Tier-0 gateway for routing.

The following table describes HCX policy routes. 
  
| Network |Redirect to peer | Note |  
| - | -------------- | -------- |
| Azure virtual network address space | Deny | Explicitly include the address ranges for all your virtual networks. Traffic that's intended for Azure directs outbound via Azure VMware Solution and doesn't return to the on-premises network.|
| Default RFC 1918 address spaces | Allow | Add in the default RFC 1918 addresses. This configuration ensures that any traffic that doesn't match the preceding criteria reroutes back to the on-premises network. If your on-premises setup uses addresses that aren't part of RFC 1918, you must explicitly include those ranges.|
| 0.0.0.0/0 address space | Deny | Addresses that RFC 1918 doesn't cover, such as internet-routable IPs, or traffic that doesn't match the specified entries, exit directly through the Azure VMware Solution and don't redirect back to the on-premises network.|
  
## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud Next Generation Firewall in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
