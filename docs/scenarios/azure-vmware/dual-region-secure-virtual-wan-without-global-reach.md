---
title: Use a Dual-Region Azure VMware Solution Design That Doesn't Have Global Reach
description: Learn how to configure network connectivity when you deploy Azure VMware Solution private clouds in two Azure regions with secure Virtual WAN without Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/21/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Use a dual-region Azure VMware Solution design that doesn't have Global Reach

This article describes the best practices for connectivity, traffic flows, and high availability when you deploy Azure VMware Solution in two regions and use secure Azure Virtual WAN with routing intent. It provides guidance about using this design without Global Reach. This article describes the Virtual WAN with routing intent topology for Azure VMware Solution private clouds, on-premises sites, and Azure-native resources. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article.  

If you use a region that doesn't support Global Reach or if you have a security requirement to inspect traffic between Azure VMware Solution and on-premises at the hub firewall, you must open a support ticket to enable ExpressRoute-to-ExpressRoute transitivity. Virtual WAN doesn't support ExpressRoute-to-ExpressRoute transitivity by default. For more information, see [Transit connectivity between ExpressRoute circuits with routing intent](/azure/virtual-wan/how-to-routing-policies#expressroute).
  
## Use a dual-region secure Virtual WAN design without Global Reach

Only the Virtual WAN Standard SKU supports secure Virtual WAN with routing intent. Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic (RFC 1918) to a security solution, like Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution.


This scenario's hub has the following configuration:

- The dual-region network has one Virtual WAN instance and two hubs. Each region has one hub.

- Each hub has its own Azure Firewall instance deployed, which makes them secure Virtual WAN hubs.
- The secure Virtual WAN hubs have routing intent enabled.


This scenario also has these components:

- Each region has its own Azure VMware Solution private cloud and an Azure virtual network.

- An on-premises site connects to both regions.

> [!NOTE]
>  If you use non-RFC 1918 prefixes in your connected on-premises resources, virtual networks, or Azure VMware Solution, specify those prefixes in the *Private traffic prefixes* field of the routing intent feature. Enter summarized routes in the *Private traffic prefixes* field to cover your range. Don't enter the exact range that advertises to Virtual WAN because this specification can lead to routing problems. For example, if the Azure ExpressRoute circuit advertises 192.0.2.0/24 from on-premises, enter a /23 Classless Inter-Domain Routing (CIDR) range or larger, for example 192.0.2.0/23. For more information, see [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva).


> [!NOTE]
>  When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preferences](/azure/virtual-wan/about-virtual-hub-routing-preference).

The following diagram shows an example of this scenario.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-1.png" alt-text="Diagram that shows a dual-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud connection to its local regional hub  |
| E | On-premises connectivity via ExpressRoute to both regional hubs  |
| Interhub | Interhub logical connection between two hubs that are deployed under the same Virtual WAN  |

### Dual-region secure Virtual WAN traffic flows

The following sections describe traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

## Azure VMware Solution private cloud connectivity and traffic flows

The following diagram shows traffic flows for both Azure VMware Solution private clouds. 

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-2.png" alt-text="Diagram that shows a dual-region Azure VMware Solution that has private cloud connectivity." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 1| Yes, via the hub 1 firewall|
| 2 | Azure VMware Solution cloud region 1 | &#8594;| On-premises| Yes, via the hub 1 firewall |
| 3 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 2| Yes, via the hub 1 firewall and then via the hub 2 firewall |
| 4 | Azure VMware Solution cloud region 1 | &#8594;| Azure VMware Solution cloud region 2| Yes, via the hub 1 firewall and then via the hub 2 firewall |
| 5 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 1| Yes, via the hub 2 firewall and then via the hub 1 firewall |
| 6 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 2| Yes, via the hub 2 firewall |
| 7 | Azure VMware Solution cloud region 2 | &#8594;| On-premises| Yes, via the hub 2 firewall |

Each Azure VMware Solution private cloud connects to the hub via ExpressRoute connection **D**.

When you enable ExpressRoute-to-ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to Azure VMware Solution over connection **D**. In addition to the default RFC 1918 addresses, Azure VMware Solution learns more specific routes from Azure virtual networks and branch networks, such as S2S VPN, P2S VPN, and SD-WAN, that connect to both hubs. Both Azure VMware Solution private clouds don't learn specific routes from on-premises networks.

To route traffic back to on-premises networks, Azure VMware Solution uses the default RFC 1918 addresses that it learns via connection **D** from its local regional hub. This traffic transits through the local regional hub firewall. The hub firewall uses the specific routes for on-premises networks to route traffic toward the destinations over connection **E**. Traffic that goes from either Azure VMware Solution private cloud to virtual networks transits the hub firewall.

## On-premises connectivity and traffic flow

The following diagram shows traffic flows for on-premises connectivity. 

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-3.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with on-premises." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 2 | On-premises | &#8594;| Azure VMware Solution cloud region 1 | Yes, via the hub 1 firewall |
| 7 | On-premises | &#8594;| Azure VMware Solution cloud region 2 | Yes, via the hub 2 firewall |
| 8 | On-premises | &#8594;| Virtual network 1 | Yes, via the hub 1 firewall |
| 9 | On-premises | &#8594;| Virtual network 2 | Yes, via the hub 2 firewall |

The on-premises site connects to both hubs via ExpressRoute connection **E**.

When you enable ExpressRoute-to-ExpressRoute transitivity on both secure hubs and you enable routing intent, each secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16) to on-premises over connection **E**. In addition to the default RFC 1918 addresses, on-premises learns more specific routes from Azure virtual networks and branch networks, such as S2S VPN, P2S VPN, and SD-WAN, that connect to both hubs. 

On-premises doesn't learn the specific routes for Azure VMware Solution private clouds. On-premises learns the default RFC 1918 addresses from both hubs via connection **E**. On-premises routes to both Azure VMware Solution private clouds via the default RFC 1918 addresses that it learns over connection **E**. 

> [!NOTE]
>  You must add specific routes on both hubs. If you don't add specific routes on the hubs, you can introduce suboptimal routing because on-premises uses equal-cost multi-path (ECMP) routing between the **E** connections for traffic that goes to an Azure VMware Solution private cloud. As a result, traffic between on-premises and an Azure VMware Solution private cloud might experience latency, performance problems, or packet drops.

To advertise a more specific route down to on-premises, specify those prefixes in the *Private traffic prefixes* field of the routing intent feature. For more information, see [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva). You need to add a summarized route that encompasses both your Azure VMware Solution /22 block and your Azure VMware Solution subnets. If you add the same exact prefix or a more specific prefix instead of a summary route, you introduce routing problems within the Azure environment. Only include summarized routes in the *Private traffic prefixes* field.

As illustrated in the diagram, Azure VMware Solution private cloud 1 includes workload subnets from 10.10.0.0/24 to 10.10.7.0/24. On hub 1, the summary route 10.10.0.0/21 is added to *Private traffic prefixes* because it encompasses all eight subnets. Additionally, on hub 1, the summary route 10.150.0.0/22 is added to *Private traffic prefixes* to cover the Azure VMware Solution management block. Summary routes 10.10.0.0/21 and 10.150.0.0/22 are advertised down to on-premises via connection **E** so that on-premises has a more specific route rather than 10.0.0.0/8.

Azure VMware Solution private cloud 2 includes workload subnets from 10.20.0.0/24 to 10.20.7.0/24. On hub 2, the summary route 10.20.0.0/21 is added to *Private traffic prefixes* because it encompasses all eight subnets. Additionally, on hub 2, the summary route 10.250.0.0/22 is added to *Private traffic prefixes* to cover the Azure VMware Solution management block. Summary routes 10.20.0.0/21 and 10.250.0.0/22 advertise down to on-premises via connection **E** so that on-premises has a more specific route rather than 10.0.0.0/8.

You can add the entire Azure VMware Solution management /22 block in the *Private traffic prefixes* field because Azure VMware Solution doesn't advertise the exact /22 block back to Azure. Azure VMware Solution advertises more specific routes.

When you enable ExpressRoute-to-ExpressRoute transitivity on the hub, it sends the default RFC 1918 addresses to your on-premises network. Don't advertise the exact RFC 1918 prefixes back to Azure. The same exact routes can create routing problems within Azure. Instead, you should advertise more specific routes back to Azure for your on-premises networks.

> [!NOTE]
>  If you advertise the default RFC 1918 addresses from on-premises to Azure and want to continue this practice, you need to split each RFC 1918 range into two equal subranges and advertise these subranges back to Azure. The subranges are 10.0.0.0/9, 10.128.0.0/9, 172.16.0.0/13, 172.24.0.0/13, 192.168.0.0/17, and 192.168.128.0/17.

## Azure virtual network connectivity and traffic flow

The following diagram shows traffic flows for Azure virtual networks.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-4.png" alt-text="Diagram that shows a dual-region Azure VMware Solution that has virtual network connectivity." border="false":::

The following table describes the traffic flow in the preceding diagram. 

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 1 | Yes, via the hub 1 firewall |
| 3 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 1| Yes, via the hub 2 firewall and then the hub 1 firewall |
| 5 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 2| Yes, via the hub 1 firewall then the hub 2 firewall |
| 6 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 2| Yes, via the hub 2 firewall |
| 8 | Virtual network 1 | &#8594;| On-premises| Yes, via the hub 1 firewall |
| 9 | Virtual network 2 | &#8594;| On-premises| Yes, via the hub 2 firewall |
| 10 | Virtual network 1 | &#8594;| Virtual network 2| Yes, via the hub 1 firewall and then the hub 2 firewall |
| 10 | Virtual network 2 | &#8594;| Virtual network 1| Yes, via the hub 2 firewall and then the hub 1 firewall |

Each virtual network directly peers to its regional hub.

The diagram shows how all Azure-native resources in both virtual networks learn their effective routes. When you enable routing intent, hub 1 and hub 2 send the default RFC 1918 addresses to their peered virtual networks. Azure-native resources in the virtual networks don't learn specific routes from outside their virtual network.

When you enable routing intent, all resources in the virtual network learn the default RFC 1918 address and use their regional hub firewall as the next hop. Azure VMware Solution private clouds communicate with each other via connection **D** over their local regional hub firewall. From there, they traverse the Virtual WAN interhub and undergo inspection at the cross-regional hub firewall. Azure VMware Solution private clouds also communicate with on-premises via connection **D** over their local regional hub firewall. All traffic that enters and exits the virtual networks transit their regional hub firewalls.

## Internet connectivity

This section describes how to provide internet connectivity for Azure-native resources in virtual networks and Azure VMware Solution private clouds in both regions. For more information, see [Internet connectivity design considerations](/azure/azure-VMware/concepts-design-public-internet-access). You can use the following options to provide internet connectivity to Azure VMware Solution.

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed Source Network Address Translation (SNAT)  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge   

A dual-region Virtual WAN design that has routing intent supports all options, but we recommend option 1. The scenario later in this article uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

When you enable routing intent on both secure hubs, it advertises RFC 1918 to directly peered virtual networks. But you can also advertise a default route 0.0.0.0/0 for internet connectivity to downstream resources. When you enable routing intent, you can generate a default route from both hub firewalls. This default route advertises to its directly peered virtual networks and to its directly connected Azure VMware Solution.  

### Azure VMware Solution and virtual network internet connectivity

The following diagram shows traffic flows for Azure VMware Solution private clouds and virtual networks.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-5.png" alt-text="Diagram that shows a dual-region Azure VMware Solution that has internet connectivity." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 11 | Azure VMware Solution cloud region 1 | &#8594;| The internet| Yes, via the hub 1 firewall
| 12 | Virtual network 2 | &#8594;| The internet | Yes, via the hub 2 firewall
| 13 | Virtual network 1 | &#8594;| The internet | Yes, via the hub 1 firewall
| 14 | Azure VMware Solution cloud region 2 | &#8594;| The internet | Yes, via the hub 2 firewall

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To help ensure that the default route propagates to its directly connected Azure VMware Solution from Virtual WAN, you must enable default-route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [Advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

After you enable default-route propagation, connection **D** advertises the default route 0.0.0.0/0 from the hub. Don't enable this setting for on-premises ExpressRoute circuits. We recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment to exclude learning the default route. A BGP filter adds an extra layer of protection and helps ensure that your configuration doesn't affect on-premises internet connectivity.

When you enable routing intent for internet access, both regional hubs generate a default route and advertise it to their hub-peered virtual network connections. Note that in the virtual machines' network interface cards (NICs) in the virtual network, the 0.0.0.0/0 next hop is the hub firewall. To find the next hop, select *Effective routes* in the NIC. The default route doesn't advertise across regional hubs over the interhub link. Therefore, virtual networks use their local regional hub for internet access, and they don't have backup internet connectivity to the cross-regional hub. 

### Internet access resiliency for Azure VMware Solution

When you don't use Global Reach in a dual-region design, outbound internet connectivity doesn't have redundancy because each Azure VMware Solution private cloud learns the default route from its local regional hub and isn't directly connected to its cross-regional hub. If a regional outage affects the local regional hub, use one of the following manual configurations to achieve internet redundancy.

#### Option 1

Use this option for outbound internet access only. During a local regional outage, if you need outbound internet access for your Azure VMware Solution workload, use Azure VMware Solution-managed SNAT. This solution provides simple and quick access. For more information, see [Turn on managed SNAT for Azure VMware Solution workloads](/azure/azure-vmware/enable-managed-snat-for-workloads).

#### Option 2

Use this option for inbound and outbound internet access. During a local regional outage, if you need both inbound and outbound internet access for your Azure VMware Solution cloud, use the following method.

1. Remove the connection that goes from Azure VMware Solution to your local regional hub (connection **D** in the diagrams).

1. In the Azure portal, select Azure VMware Solution, and remove the authorization key that you created for connection **D**.
1. Create a new connection to the cross-regional hub.

To handle inbound traffic, consider using Azure Front Door or Azure Traffic Manager to maintain regional high availability.

## Use VMware HCX Mobility Optimized Networking (MON) without Global Reach

You can enable HCX Mobility Optimized Networking (MON) when you use HCX Network Extension. MON provides optimal traffic routing in certain scenarios to prevent networks from overlapping or looping between the on-premises-based and cloud-based resources on extended networks.

### Egress traffic from Azure VMware Solution   

When you enable MON for a specific extended network and a virtual machine, the traffic flow changes. After you implement MON, egress traffic from the virtual machine doesn't loop back to on-premises. Instead, it bypasses the Network Extension IPSec tunnel. Traffic for the virtual machine exits out of the Azure VMware Solution NSX-T Tier-1 gateway, goes to the NSX-T Tier-0 gateway, and then goes to Virtual WAN.

### Ingress traffic to Azure VMware Solution 
 
When you enable MON for a specific extended network and a virtual machine, you introduce the following changes. From Azure VMware Solution NSX-T, MON injects a /32 host route back to Virtual WAN. Virtual WAN advertises this /32 route back to on-premises, virtual networks, and branch networks. This /32 host route ensures that traffic from on-premises, virtual networks, and branch networks doesn't use the Network Extension IPSec tunnel when the traffic goes to the MON-enabled virtual machine. Traffic from source networks goes straight to the MON-enabled virtual machine because it learns the /32 route. 

### HCX MON limitation for secure Virtual WAN without Global Reach
 
When you enable ExpressRoute-to-ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses to both on-premises and Azure VMware Solution. In addition to the default RFC 1918 addresses, both on-premises and Azure VMware Solution learn more specific routes from Azure virtual networks and branch networks that connect to the hub.

But on-premises networks don't learn specific routes from Azure VMware Solution, and Azure VMware Solution doesn't learn specific routes from on-premises networks. Instead, both environments rely on the default RFC 1918 addresses to facilitate routing back to one another via the hub firewall. Therefore, more specific routes, such as MON host routes, don't advertise from the Azure VMware Solution ExpressRoute to the on-premises-based ExpressRoute circuit. The reverse is also true. The inability to learn specific routes introduces asymmetric traffic flows. Traffic egresses Azure VMware Solution via the NSX-T Tier-0 gateway, but returning traffic from on-premises returns over the Network Extension IPSec tunnel.

### Correct the traffic asymmetry 

To correct traffic asymmetry, you need to adjust the MON policy routes. MON policy routes determine which traffic goes back to the on-premises gateway via an L2 extension. They also decide which traffic goes through the Azure VMware Solution NSX Tier-0 gateway.

If a destination IP matches and you set it to *allow* in the MON policy configuration, then two actions occur. First, the system identifies the packet. Second, the system sends the packet to the on-premises gateway through the Network Extension appliance.

If a destination IP doesn't match or you set it to *deny* in the MON policy, the system sends the packet to the Azure VMware Solution Tier-0 gateway for routing.

The following table describes HCX policy routes. 
  
| Network |Redirect to peer | Note |  
| - | -------------- | -------- |
| Azure virtual network address space | Deny | Explicitly include the address ranges for all your virtual networks. Traffic that's intended for Azure directs outbound via Azure VMware Solution and doesn't return to the on-premises network.|
| Default RFC 1918 address spaces | Allow | Add the default RFC 1918 addresses. This configuration ensures that any traffic that doesn't match the preceding criteria reroutes back to the on-premises network. If your on-premises setup uses addresses that aren't part of RFC 1918, you must explicitly include those ranges.|
| 0.0.0.0/0 address space | Deny | Addresses that RFC 1918 doesn't cover, such as internet-routable IPs, or traffic that doesn't match the specified entries, exit directly through the Azure VMware Solution and don't redirect back to the on-premises network. |

## Next steps

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud Next Generation Firewall in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
