---
title: Dual-Region Azure VMware Solution design without Global Reach, using Secure Virtual WAN with Routing-Intent
description: Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions with Secure Virtual WAN without Global Reach.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/11/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Dual-region deployments using secure Virtual WAN hub with routing intent without Global Reach

This article describes the best practices for connectivity, traffic flows, and high availability of dual-region Azure VMware Solution when you use Azure secure Virtual WAN with routing intent. You learn the design details of using secure Virtual WAN with routing intent, without Global Reach. This article breaks down Virtual WAN with routing intent topology from the perspective of Azure VMware Solution private clouds, on-premises sites, and Azure native. The implementation and configuration of secure Virtual WAN with routing intent are beyond the scope of this article.  

In regions without Global Reach support or with a security requirement to inspect traffic between Azure VMware Solution and on-premises at the hub firewall, a support ticket must be opened to enable ExpressRoute to ExpressRoute transitivity for both regional hubs. ExpressRoute to ExpressRoute transitivity isn't supported by default with Virtual WAN. - see [Transit connectivity between ExpressRoute circuits with routing intent](/azure/virtual-wan/how-to-routing-policies#expressroute)
  
## Dual-region with Secure Virtual WAN without Global Reach scenario

Secure Virtual WAN with Routing Intent is only supported with Virtual WAN Standard SKU. Secure Virtual WAN with Routing Intent provides the capability to send all Internet traffic and Private network traffic to a security solution like Azure Firewall, a third-party Network Virtual Appliance (NVA), or SaaS solution. In the scenario, we have a network topology that spans two regions. There's one Virtual WAN with two Hubs, Hub1 and Hub2. Hub1 is in Region 1, and Hub2 is in Region 2. Each Hub has its own instance of Azure Firewall deployed(Hub 1 Firewall, Hub 2 Firewall), essentially making them each Secure Virtual WAN Hubs. Having Secure Virtual WAN hubs is a technical prerequisite to Routing Intent. Secure Virtual WAN Hub1 and Hub2 have Routing Intent enabled.    

Each region also has an Azure VMware Solution Private Cloud and an Azure Virtual Network. Theres also an on-premises site connecting to both regions, which we review in more detail later in this document. 

>[!NOTE]
>  If you're using non-RFC1918 prefixes in your connected on-premises networks, Azure Virtual Networks or Azure VMware Solution, make sure you have specified those prefixes in the "Private Traffic Prefixes" text box for Routing Intent. Keep in mind that you should always enter summarized routes only in the “Private Traffic Prefixes” section to cover your range. Do not input the exact range that is being advertised to Virtual WAN as this can lead to routing issues. For example, if the ExpressRoute Circuit is advertising 40.0.0.0/24 from on-premises, put a /23 CIDR range or larger in the Private Traffic Prefix text box (example: 40.0.0.0/23). - see [Configure routing intent and policies through Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
>

>[!NOTE]
>  When configuring Azure VMware Solution with Secure Virtual WAN Hubs, ensure optimal routing results on the hub by setting the Hub Routing Preference option to "AS Path." - see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference)
>

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-1.png" alt-text="Diagram that shows a dual-region Azure VMware Solution scenario." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Connection | Description  |
|:-------------------- |:--------------------  |
| D | Azure VMware Solution private cloud connection to its local regional hub  |
| E | On-premises connectivity via ExpressRoute to both regional hubs  |
| Inter-hub | Inter-hub logical connection between two hubs that are deployed under the same Virtual WAN  |

### Dual-region secure Virtual WAN traffic flows

The following sections cover traffic flows and connectivity for Azure VMware Solution, on-premises, Azure virtual networks, and the internet.

## Azure VMware Solution connectivity and traffic flows

This section focuses on only the Azure VMware Solution private clouds in both regions. Each Azure VMware Solution private cloud has an ExpressRoute connection to the hub (connections labeled as "D").

With ExpressRoute to ExpressRoute transitivity enabled on the secure hub and routing intent enabled, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to both Azure VMware Solution private clouds over connection "D". In addition to the default RFC 1918 addresses, both Azure VMware Solution private clouds learn more specific routes from Azure virtual networks and networks (S2S VPN, P2S VPN, SDWAN) that are connected to both hub 1 and hub 2. Both Azure VMware Solution private clouds don't learn specific routes from on-premises networks. For routing traffic back to on-premises networks, it uses the default RFC 1918 addresses that it learned via connection "D" from its local regional hub. This traffic transits through the local regional hub firewall, as shown in the diagram. The hub firewall has the specific routes for on-premises networks and routes traffic toward the destination over connection “E”. Traffic from both Azure VMware Solution private clouds, heading towards virtual networks, transit the hub firewall. For more information, see the traffic flow section.

The diagram shows traffic flows from the perspective of the Azure VMware Solution private cloud region 1 and Azure VMware Solution private cloud region 2. 

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-2.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with Azure VMware Solution topology." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 1| Yes, the hub 1 firewall inspects traffic.|
| 2 | Azure VMware Solution cloud region 1 | &#8594;| On-premises| Yes, the hub 1 firewall inspects traffic.|
| 3 | Azure VMware Solution cloud region 1 | &#8594;| Virtual network 2| Yes, the hub 1 firewall inspects traffic, and then the hub 2 firewall inspects traffic.|
| 4 | Azure VMware Solution cloud region 1 | &#8594;| Azure VMware Solution cloud region 2| Yes, the hub 1 firewall inspects traffic, and then the hub 2 firewall inspects traffic.|
| 5 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 1| Yes, traffic is inspected at the hub 2 firewall, then hub 1 firewall.|
| 6 | Azure VMware Solution cloud region 2 | &#8594;| Virtual network 2| Yes, the hub 2 firewall inspects traffic.|
| 7 | Azure VMware Solution cloud region 2 | &#8594;| On-premises| Yes, the hub 2 firewall inspects traffic.|


## On-premises connectivity and traffic flow

This section focuses only on the on-premises site. As shown in the diagram, the on-premises site has an ExpressRoute connection to both hub 1 and hub 2 (connection labeled as "E").

With ExpressRoute to ExpressRoute transitivity enabled on both secure hubs and routing intent enabled, each secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to on-premises over connection "E". In addition to the default RFC 1918 addresses, on-premises learns more specific routes from Azure virtual networks and branch networks (S2S VPN, P2S VPN, SDWAN) that are connected to both hub 1 and hub 2. 

By default, on-premises doesn't learn the specific routes for both Azure VMware Solution private clouds. Instead, it routes to both Azure VMware Solution private clouds using the default RFC 1918 addresses it learns over connection “E”. On-premises learns the default RFC 1918 addresses from both hub 1 and hub 2 via connection “E”. 

>[!NOTE]
>  It's extremely important to add specific routes on both hubs. If you don't add specific routes on the hubs, it leads to suboptimal routing because on-premises uses Equal Cost multi-path (ECMP) between the "E" connections for traffic destined to any Azure VMware Solution private cloud. As a result, traffic between on-premises and any Azure VMware Solution private cloud may experience latency, performance issues, or packet drops.
>

To advertise a more specific route down to on-premises, it needs to be accomplished from the "Private Traffic Prefixes" box within routing intent. - see [Configure routing intent and policies through Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva). You need to add a summarized route that encompasses both your Azure VMware Solution /22 block and your Azure VMware Solution subnets. If you add the same exact prefix or a more specific prefix instead of a summary route, you introduce routing issues within the Azure environment. Therefore, it's important to remember that any prefixes added to the "Private Traffic Prefixes" box must be summarized routes.

As illustrated in the diagram, Azure VMware Solution private cloud 1 includes workload subnets from 10.10.0.0/24 to 10.10.7.0/24. On Hub 1, the summary route 10.10.0.0/21 is added to "Private Traffic Prefixes" because it encompasses all eight subnets. Additionally, on Hub 1, the summary route 10.150.0.0/22 is added to "Private Traffic Prefixes" to cover the Azure VMware Solution management block. Summary routes 10.10.0.0/21 and 10.150.0.0/22 are then advertised down to on-premises via connection "E", providing on-premises with a more specific route than 10.0.0.0/8.

Azure VMware Solution private cloud 2 includes workload subnets from 10.20.0.0/24 to 10.20.7.0/24. On Hub 2, the summary route 10.20.0.0/21 is added to "Private Traffic Prefixes" because it encompasses all eight subnets. Additionally, on Hub 2, the summary route 10.250.0.0/22 is added to “Private Traffic Prefixes.” This covers the Azure VMware Solution management block. Summary routes 10.20.0.0/21 and 10.250.0.0/22 are then advertised down to on-premises via connection “E.” This provides on-premises with a more specific route than 10.0.0.0/8.

There's no issue in adding the entire Azure VMware Solution Management /22 block under “Private Traffic Prefixes” because Azure VMware Solution doesn't advertise the exact /22 block back to Azure; it always advertises more specific routes.

As mentioned earlier, when you enable ExpressRoute to ExpressRoute transitivity on the Hub, it sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to your on-premises network. Therefore, you shouldnt advertise the exact RFC 1918 prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Advertising the same exact routes creates routing problems within Azure. Instead, you should advertise more specific routes back to Azure for your on-premises networks.

>[!NOTE]
>  If you're currently advertising the default RFC 1918 addresses from on-premises to Azure and wish to continue this practice, you need to split each RFC 1918 range into two equal sub-ranges and advertise these sub-ranges back to Azure. The sub-ranges are 10.0.0.0/9, 10.128.0.0/9, 172.16.0.0/13, 172.24.0.0/13, 192.168.0.0/17, and 192.168.128.0/17.
>

The diagram illustrates traffic flows from the perspective of on-premises. 

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-3.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with on-premises." border="false":::

The following table describes the topology connectivity in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 2 | On-premises | &#8594;| Azure VMware Solution cloud region 1 | Yes, the hub 1 firewall inspects traffic.|
| 7 | On-premises | &#8594;| Azure VMware Solution cloud region 2 | Yes, the hub 2 firewall inspects traffic.|
| 8 | On-premises | &#8594;| Virtual Network 1 | Yes, the hub 1 firewall inspects traffic.|
| 9 | On-premises | &#8594;| Virtual Network 2 | Yes, the hub 2 firewall inspects traffic.|

## Azure virtual network connectivity and traffic flow

This section focuses only on connectivity from the Azure Virtual Networks perspective. As depicted in the diagram, each Virtual Network has a Virtual Network peering directly to its regional hub.

The diagram shows how all Azure native resources in both Virtual Networks learn routes under their "Effective Routes". With routing intent enabled, Hub 1 and Hub 2 always send the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to their peered Virtual Networks. Azure native resources in the Virtual Networks don't learn specific routes from outside their Virtual Network. With routing intent enabled, all resources in the virtual network currently learn the default RFC 1918 address and use their regional hub firewall as the next hop. Azure VMware Solution private clouds communicate with each other via connection "D" to their local regional hub firewall. From there, they traverse the Virtual WAN inter-hub and undergo inspection at the cross-regional hub firewall. Additionally, Azure VMware Solution private clouds communicate with on-premises via connection "D" over their local regional hub firewall. All traffic ingressing and egressing the virtual networks will always transit their regional hub firewalls. For more information, see the traffic flow section.

The diagram shows traffic flows from the Azure virtual networks perspective.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-4.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with virtual networks." border="false":::

The following table describes the traffic flow in the preceding diagram. 

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 1 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 1 | Yes, the hub 1 firewall inspects traffic.|
| 3 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 1| Yes, traffic is inspected at Hub 2 firewall then Hub firewall 1|
| 5 | Virtual network 1 | &#8594;| Azure VMware Solution cloud region 2| Yes, traffic is inspected at Hub 1 firewall then Hub firewall 2|
| 6 | Virtual network 2 | &#8594;| Azure VMware Solution cloud region 2| Yes, the hub 2 firewall inspects traffic.|
| 8 | Virtual network 1 | &#8594;| On-premises| Yes, the hub 1 firewall inspects traffic.|
| 9 | Virtual network 2 | &#8594;| On-premises| Yes, the hub 2 firewall inspects traffic.|
| 10 | Virtual network 1 | &#8594;| Virtual network 2| Yes, the hub 1 firewall inspects traffic, and then the hub 2 firewall inspects traffic.|
| 10 | Virtual network 2 | &#8594;| Virtual network 1| Yes, the hub 2 firewall inspects traffic, and then the hub 1 firewall inspects traffic.|


## Internet connectivity

This section focuses only on how internet connectivity is provided for Azure-native resources in virtual networks and Azure VMware Solution private clouds with dual region. There are several options to provide internet connectivity to Azure VMware Solution. For more information, see [Internet access concepts for Azure VMware Solution](/azure/azure-VMware/concepts-design-public-internet-access).

- *Option 1:* Azure-hosted internet service
- *Option 2:* Azure VMware Solution-managed SNAT  
- *Option 3:* Azure public IPv4 address to the NSX-T Data Center edge   

You can use all three options with dual-region secure Virtual WAN with routing intent. But when you use secure Virtual WAN with routing intent, you should use option 1. This scenario also uses option 1 to provide internet connectivity. Option 1 works best with secure Virtual WAN because it's easy to inspect, deploy, and manage.

As mentioned earlier, when you enable routing intent on both secure hubs, it advertises RFC 1918 to all directly peered virtual networks. But you can also advertise a default route 0.0.0.0/0 for internet connectivity to downstream resources. With routing intent, you can choose to generate a default route from both hub firewalls. This default route is advertised to its directly peered virtual networks and to its directly connected Azure VMware Solution. This section is broken into two sections, one that explains internet connectivity from both regional Azure VMware Solution perspective and another from the virtual networks perspective.  

#### Azure VMware Solution internet connectivity

When you enable routing intent for internet traffic, by default, the secure Virtual WAN hub doesn't advertise the default route across ExpressRoute circuits. To ensure the default route is propagated to its directly connected Azure VMware Solution from the Azure Virtual WAN, you must enable default route propagation on your Azure VMware Solution ExpressRoute circuits. For more information, see [To advertise default route 0.0.0.0/0 to endpoints](/azure/virtual-wan/virtual-wan-expressroute-portal#to-advertise-default-route-00000-to-endpoints).

After changes are complete, the default route 0.0.0.0/0 is then advertised via connection “D” from the hub. Don't enable this setting for on-premises ExpressRoute circuits. We recommend that you implement a Border Gateway Protocol (BGP) filter on your on-premises equipment to exclude learning the default route. A BGP filter adds an extra layer of protection and ensures that your configuration doesn't affect on-premises internet connectivity.

#### Virtual network internet connectivity

When you enable routing intent for internet access, it automatically generates a default route from both regional hubs and advertises it to their hub-peered virtual network connections. Under *Effective Routes* for the Virtual Machines' NICs in the Virtual Network that the 0.0.0.0/0 next hop is the regional hub firewall. The default route is never advertised across regional hubs over the ‘inter-hub' link. Therefore, Virtual Networks use their local regional hub for internet access and have no backup internet connectivity to the cross-regional hub. 

For more information, see the traffic flow section.

The diagram illustrates traffic flows from the Virtual Networks and Azure VMware Solution private clouds perspective.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-5.png" alt-text="Diagram that shows a dual-region Azure VMware Solution with internet." border="false":::

The following table describes the traffic flow in the preceding diagram.

| Traffic flow number | Source |   Direction | Destination | Does the secure Virtual WAN hub firewall inspect this traffic? |
| - | -------------- | -------- | ---------- | ---------- |
| 11 | Azure VMware Solution cloud region 1 | &#8594;| The internet| Yes, the hub 1 firewall inspects traffic.
| 12 | Virtual network 2 | &#8594;| The internet | Yes, the hub 2 firewall inspects traffic.
| 13 | Virtual network 1 | &#8594;| The internet | Yes, the hub 1 firewall inspects traffic.
| 14 | Azure VMware Solution cloud region 2 | &#8594;| The internet | Yes, the hub 2 firewall inspects traffic.

#### Internet access resiliency for Azure VMware Solution

With Azure VMware Solution using the dual-region without Global Reach design, you don't have outbound internet connectivity redundancy because each Azure VMware Solution private cloud learns the default route from both its local regional hub and isn't directly connected to its cross-regional hub. If a regional outage affects the local regional hub, use one of the following manual configuration options to achieve internet redundancy.

**Option 1: For outbound internet access only**  
During a local regional outage, if you need outbound internet access for your Azure VMware Solution workload, you can opt for VMware Solution-managed SNAT. It's a straightforward solution that quickly provides the access you need. For more information, see [Turn on managed SNAT for Azure VMware Solution workloads](/azure/azure-vmware/enable-managed-snat-for-workloads).

**Option 2: For inbound and outbound internet access**    
During a local regional outage, if you need both inbound and outbound internet access for your Azure VMware Solution cloud, start by removing the “D” connection for your local regional hub. Remove the authorization key created for the “D” connection from the Azure VMware Solution blade in the Azure portal. Then, create a new connection to the cross-regional hub. For handling inbound traffic, consider using Azure Front Door or Azure Traffic Manager to maintain regional high availability.

## Use VMware HCX Mobility Optimized Networking (MON) without Global Reach

You can enable HCX Mobility Optimized Networking (MON) when you use HCX Network Extension. MON provides optimal traffic routing under certain scenarios to prevent network tromboning between the on-premises-based and cloud-based resources on extended networks.

### Egress traffic from Azure VMware Solution   

When you enable MON for a specific extended network and a virtual machine, the traffic flow changes. For MON, egress traffic from that virtual machine doesn't trombone back to on-premises. Instead, it bypasses the Network Extension IPSEC tunnel. Traffic for that virtual machine egresses out of the Azure VMware Solution NSX-T Tier-1 Gateway> NSX-T Tier-0 Gateway>Azure Virtual WAN.

### Ingress traffic to Azure VMware Solution 
 
Enabling MON for a specific extended network and a virtual machine results in a change. From Azure VMware Solution NSX-T, it injects a /32 host route back to Azure Virtual WAN. Azure Virtual WAN advertises this /32 route back to on-premises, virtual networks, and branch networks (S2S VPN, P2S VPN, SDWAN). The purpose of this /32 host route is to ensure that traffic from on-premises, virtual networks, and branch networks doesn't use the Network Extension IPSEC tunnel when destined for the MON-enabled virtual machine. Traffic from source networks is directed straight to the MON enabled virtual machine due to the /32 route that is learned. 

### HCX MON limitation with secure Virtual WAN without Global Reach
 
When you enable ExpressRoute to ExpressRoute transitivity on the secure hub and you enable routing intent, the secure hub sends the default RFC 1918 addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to both the on-premises and Azure VMware Solution. In addition to the default RFC 1918 addresses, both on-premises and Azure VMware Solution learn more specific routes from Azure virtual networks and branch networks that are connected to the hub. But on-premises networks don't learn any specific routes from the Azure VMware Solution, and Azure VMware Solution doesn't learn specific routes from on-premises networks. Instead, both environments rely on the default RFC 1918 addresses to facilitate routing back to one another via their local regional hub firewall. Therefore, more specific routes, such as HCX MON host routes, aren't advertised from the Azure VMware Solution ExpressRoute to the on-premises-based ExpressRoute circuit and vice-versa. The inability to learn specific routes introduces asymmetric traffic flows. Traffic egresses Azure VMware Solution via the NSX-T Tier-0 gateway, but returning traffic from on-premises returns over the Network Extension IPSEC tunnel.

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

- [Virtual hub settings](/azure/virtual-wan/hub-settings)
- [Configure Azure Firewall in a Virtual WAN hub](/azure/virtual-wan/howto-firewall)
- [Configure Palo Alto Networks Cloud NGFW in Virtual WAN](/azure/virtual-wan/how-to-palo-alto-cloud-ngfw)
- [Configure routing intent and policies through Virtual WAN portal](/azure/virtual-wan/how-to-routing-policies#nva)
