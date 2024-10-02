---
title: Single-Region Azure VMware Solution design without Global Reach, using secure Virtual WAN with routing intent
description: Learn how to configure network connectivity when a single-region Azure VMware Solution private cloud is deployed with secure Virtual WAN without Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/11/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Single-region deployment without Global Reach, using secure Virtual WAN hub with routing intent

This article describes the best practices for connectivity and traffic flows with single-region Azure VMware Solution when using Azure secure Virtual WAN with routing intent. You learn the design details of using secure Virtual WAN with Routing-Intent without Global Reach. This article breaks down Virtual WAN with routing intent topology from the perspective of an Azure VMware Solution private cloud, on-premises sites, and Azure native. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope and aren't discussed in this document.

In regions without Global Reach support or with a security requirement to inspect traffic between Azure VMware Solution and on-premises at the hub firewall, a support ticket must be opened to enable ExpressRoute to ExpressRoute transitivity. ExpressRoute to ExpressRoute transitivity isn't supported by default with Virtual WAN. - see [Transit connectivity between ExpressRoute circuits with routing intent](/azure/virtual-wan/how-to-routing-policies#expressroute)

## Single-region scenario: Secure Virtual WAN without Global Reach
 
Secure Virtual WAN with routing intent is only supported with Virtual WAN Standard SKU. Secure Virtual WAN with routing intent provides the capability to send all Internet traffic and Private network traffic (RFC 1918) to a security solution like Azure Firewall, a third-party Network Virtual Appliance (NVA), or SaaS solution. In the scenario, we have a network topology that spans a single region. There's one Virtual WAN with a single hub located in the Region. The hub has its own instance of an Azure Firewall deployed, essentially making it a secure Virtual WAN hub. Having a secure Virtual WAN hub is a technical prerequisite to routing intent. The secure Virtual WAN hub has routing intent enabled.    

The single region also has an Azure VMware Solution Private Cloud and an Azure virtual network. There's also an on-premises site connecting to the region, which we review in more detail later in this document. 

>[!NOTE]
>  If you use non-RFC1918 prefixes in your connected on-premises, virtual networks, or Azure VMware Solution, specify those prefixes in the *Private Traffic Prefixes* text box for routing intent. Always enter summarized routes only in the *Private Traffic Prefixes* section to cover your range. Don't input the exact range that's advertised to Virtual WAN because this action can lead to routing problems. For example, if the ExpressRoute circuit is advertising 40.0.0.0/24 from on-premises, put a /23 CIDR range or larger, for example 40.0.0.0/23, in the *Private Traffic Prefix* text box. For more information, see [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva).
>

>[!NOTE]
>  When you configure Azure VMware Solution with secure Virtual WAN hubs, set the hub routing preference option to **AS Path** to ensure optimal routing results on the hub. For more information, see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference).
>

:::image type="content" source="./media/single-region-without-globalreach-1.png" alt-text="Diagram that shows a single-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud-managed ExpressRoute connection to the hub  |
| E | On-premises ExpressRoute connection to the hub  |

### Traffic flows for single-region Virtual WAN without Global Reach

The following sections cover traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

## Azure VMware Solution connectivity and traffic flows

This section focuses on only the Azure VMware Solution private cloud. The Azure VMware Solution private cloud has an ExpressRoute connection to the hub (connections labeled as "D").

When you enable ExpressRoute to ExpressRoute transitivity enabled on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to Azure VMware Solution over connection "D". In addition to the default RFC 1918 addresses, Azure VMware Solution learns more specific routes from Azure virtual networks and branch networks (S2S VPN, P2S VPN, SDWAN) that are connected to the hub. Azure VMware Solution doesn't learn specific routes from on-premises networks. For routing traffic back to on-premises networks, it uses the default RFC 1918 addresses that it learned from connection "D". This traffic transits through the hub firewall, as shown in the diagram. The hub firewall has the specific routes for on-premises networks and routes traffic toward the destination over connection "E". Traffic from Azure VMware Solution, heading towards virtual networks, transits the hub firewall. For more information, see the traffic flow section.

The following diagram shows traffic flows from the perspective of the Azure VMware Solution private cloud. 

:::image type="content" source="./media/single-region-without-globalreach-2.png" alt-text="Diagram that shows a single-region Azure VMware Solution with an Azure VMware Solution topology." border="false":::

The following table describes the traffic flow in the preceding diagram.  

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud | &#8594;| Virtual network| Yes |
| 2 | Azure VMware Solution cloud | &#8594;| On-premises | Yes |

## On-premises connectivity and traffic flow

This section focuses only on the on-premises site. As shown in the diagram, the on-premises site has an ExpressRoute connection to the hub (connection labeled as "E").

When you enable ExpressRoute to ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to on-premises over connection "E". In addition to the default RFC 1918 addresses, on-premises learns more specific routes from Azure virtual networks and branch networks (S2S VPN, P2S VPN, SDWAN) that are connected to the hub. On-premises doesn't learn specific routes from Azure VMware Solution networks. For routing traffic back to Azure VMware Solution networks, it uses the default RFC 1918 addresses that it learned from connection "E". This traffic transits through the hub firewall, as shown in the diagram. The hub firewall has the specific routes for Azure VMware Solution networks and routes traffic toward the destination over connection "D". Traffic from on-premises, heading towards virtual networks, transits the hub firewall. For more information, see the traffic flow section for more detailed information.

As mentioned earlier, when you enable ExpressRoute to ExpressRoute transitivity on the hub, it sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to your on-premises network. Therefore, you shouldn't advertise the exact RFC 1918 prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Advertising the same exact routes creates routing problems within Azure. Instead, you should advertise more specific routes back to Azure for your on-premises networks.

>[!NOTE]
>  If you currently advertise the default RFC 1918 addresses from on-premises to Azure and want to continue this practice, you need to split each RFC 1918 range into two equal sub-ranges and advertise these sub-ranges back to Azure. The sub-ranges are 10.0.0.0/9, 10.128.0.0/9, 172.16.0.0/13, 172.24.0.0/13, 192.168.0.0/17, and 192.168.128.0/17.
>

The following diagram shows traffic flows from the perspective of on-premises. 

:::image type="content" source="./media/single-region-without-globalreach-3.png" alt-text="Diagram that shows a single-region Azure VMware Solution with on-premises.":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 3 | On-premises | &#8594;| Azure VMware Solution cloud | Yes |
| 4 | On-premises | &#8594;| Virtual network | Yes |

## Azure virtual network connectivity and traffic flow

This section focuses only on connectivity from an Azure virtual network perspective. As depicted in the diagram, the virtual network has a virtual network peering directly to the hub.

The diagram illustrates how all Azure native resources in the virtual network learn routes under their "Effective Routes". A secure hub with routing intent enabled always sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to peered virtual networks. Azure native resources in the virtual network don't learn specific routes from outside of their virtual network. With routing intent enabled, all resources in the virtual network currently possess the default RFC 1918 address and use the hub firewall as the next hop. All traffic ingressing and egressing the virtual networks will always transit the hub Firewall. For more information, see the traffic flow section for more detailed information.

The following diagram shows traffic flows from an Azure virtual network perspective.

:::image type="content" source="./media/single-region-without-globalreach-4.png" alt-text="Diagram that shows a single-region Azure VMware Solution with virtual networks." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 5 | Virtual network | &#8594;| Azure VMware Solution cloud | Yes |
| 6 | Virtual network | &#8594;| On-premises | Yes |

## Internet connectivity

This section focuses only on how internet connectivity is provided for Azure native resources in virtual networks and Azure VMware Solution Private Clouds in a single region. There are several options to provide internet connectivity to Azure VMware Solution. For more information, see [Internet access concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access).

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed SNAT  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge   

You can use all three options with single-region secure Virtual WAN with routing intent. But when you use secure Virtual WAN with routing intent, you should use option 1. This scenario also uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it makes security inspection, deployment, and manageability easy.

When you enable routing intent on the secure hub, it advertises RFC 1918 to all peered virtual networks. BUt you can also advertise a default route 0.0.0.0/0 for internet connectivity to downstream resources. When you use routing intent, you can generate a default route from the hub firewall. This default route is advertised to your virtual network and to Azure VMware Solution. This section is broken into two sections, one that explains internet connectivity from an Azure VMware Solution perspective and another from the virtual network perspective.  

#### Azure VMware Solution internet connectivity

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To ensure the default route is propagated to the Azure VMware Solution from the Azure Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [To advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints). After changes are complete, the default route 0.0.0.0/0 is then advertised via connection "D" from the hub. Don't enable this setting for on-premises ExpressRoute circuits. As a best practice, we recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment. A BGP filter prevents the inadvertent learning of the default route, adds an extra layer of precaution, and ensures that uour configuration doesn't affect on-premises internet connectivity.

#### Virtual network internet connectivity

When you enable routing intent for internet access, the default route generated from the secure Virtual WAN hub is automatically advertised to the hub-peered virtual network connections. Under *Effective Routes* for the virtual machines' NICs in the virtual network, the 0.0.0.0/0 next hop is the hub firewall.

For more information, see the traffic flow section.

The diagram illustrates traffic flows from a virtual network and Azure VMware Solution perspective.

:::image type="content" source="./media/single-region-without-globalreach-5.png" alt-text="Diagram that shows single-region Azure VMware Solution with internet." border="false":::

The following table describes the traffic flow in the preceding diagram.  

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 7 | Virtual network | &#8594;| The internet| Yes
| 8 | Azure VMware Solution cloud | &#8594;| The internet | Yes

## Use VMware HCX Mobility Optimized Networking (MON) without Global Reach

HCX Mobility Optimized Networking (MON) is an optional feature that you can enable when you use HCX Network Extension. MON provides optimal traffic routing in certain scenarios to prevent network tromboning between the on-premises-based and cloud-based resources on extended networks.

### Egress traffic from Azure VMware Solution
 
Enable MON for a specific extended network and a virtual machine to change the traffic flow. After you implement MON, egress traffic from that virtual machine doesn't trombone back to on-premises. Instead, it bypasses the Network Extension IPSEC tunnel. Traffic for that virtual machine egresses out of the Azure VMware Solution NSX-T Tier-1 Gateway> NSX-T Tier-0 Gateway>Azure Virtual WAN.

### Ingress traffic to Azure VMware Solution

Enabling MON for a specific extended network and a virtual machine results in a change. From Azure VMware Solution NSX-T, it injects a /32 host route back to Azure Virtual WAN. Azure Virtual WAN advertises this /32 route back to on-premises, virtual networks, and branch networks (S2S VPN, P2S VPN, SDWAN). This /32 host route ensures that traffic from on-premises, virtual networks, and branch networks doesn't use the Network Extension IPSEC tunnel when it goes to the MON-enabled virtual machine. Traffic from source networks is directed straight to the MON-enabled virtual machine due to the /32 route that is learned.

### HCX MON limitation with secure Virtual WAN without Global Reach

With ExpressRoute to ExpressRoute transitivity enabled on the secure hub and routing intent enabled, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to both the on-premises and Azure VMware Solution. In addition to the default RFC 1918 addresses, both on-premises and Azure VMware Solution learn more specific routes from Azure virtual networks and branch networks that are connected to the hub. But on-premises networks don't learn specific routes from Azure VMware Solution, and Azure VMware Solution doesn't learn specific routes from on-premises networks. Instead, both environments rely on the default RFC 1918 addresses to facilitate routing back to one another via the hub firewall. Therefore, more specific routes, such as HCX MON host routes, aren't advertised from the Azure VMware Solution ExpressRoute to the on-premises-based ExpressRoute circuit and vice-versa. The inability to learn specific routes introduces asymmetric traffic flows. Traffic egresses Azure VMware Solution via the NSX-T Tier-0 gateway, but returning traffic from on-premises returns over the Network Extension IPSEC tunnel.

### Resolution

To correct traffic asymmetry, you need to adjust the HCX MON policy routes. MON policy routes determine which traffic goes back to the on-premises gateway via an L2 extension. They also decide which traffic goes through the Azure VMware Solution NSX Tier-0 gateway.

If a destination IP matches and is set to *allow* in the MON policy configuration, then two actions occur. First, the packet is identified. Second, it's sent to the on-premises gateway through the HCX Network Extension appliance.

If a destination IP doesn't match, or is set to *deny* in the MON policy, the system sends the packet to the Azure VMware Solution Tier-0 for routing.

The following table describes HCX policy routes. 
  
| Network |Redirect to peer | Note |  
| - | -------------- | -------- |
| Azure virtual network address space | Deny | Explicitly include the address ranges for all your virtual networks. Traffic intended for Azure is directed out via the Azure VMware Solution and doesn't return to the on-premises network.|
| Default RFC 1918 address spaces | Allow | Add in the default RFC 1918 addresses 10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16. This configuration ensures that any traffic not matching the above criteria is rerouted back to the on-premises network. If your on-premises setup uses addresses that aren't part of RFC 1918, you must explicitly include those ranges.|
| 0.0.0.0/0 address space | Deny | Addresses that RFC 1918 doesn't cover, such as internet-routable IPs, or traffic that doesn't match the specified entries above, exit directly through the Azure VMware Solution and don't redirect back to the on-premises network.|
  
## Next steps

- [About virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud NGFW in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through the Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
