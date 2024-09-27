---
title: Introduction to single and dual Virtual WAN regions for Azure VMware Solution
description: Discover how to use secure Virtual WAN and Azure VMware Solution for single-region and dual-region deployments with best practices.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/11/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Secure Virtual WAN for Azure VMware Solution

This article explores the Azure VMware Solution network design topologies and considerations for single-region and dual-region secure Azure Virtual WAN with routing intent. It describes how routing intent directs traffic through a centralized security solution. This method enhances security and streamlines network management. This article provides design considerations for deployments with and without Azure ExpressRoute global reach and highlights their respective benefits and challenges.

A security solution in the Virtual WAN hub effectively converts the hub to a secure Virtual WAN hub. You must have a secure Virtual WAN hub to configure routing intent. Routing intent drives all private and internet traffic to the hub security solution, which streamlines the routing/security design of the secure hub. Routing intent improves the security breadth and conducts a traffic inspection for all traffic that goes through the secure hub, including Azure VMware Solution. 

This article assumes that you have a basic understanding of Virtual WAN and secure Virtual WAN with routing intent.

For more information, see the following resources:
- [What is Virtual WAN?](/azure/virtual-wan/virtual-wan-about) 
- [What is a secure virtual hub?](/azure/firewall-manager/secured-virtual-hub)
- [How to configure Virtual WAN Hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) 
- [About ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach)

## Secure Virtual WAN for Azure VMware Solution designs

Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic (RFC 1918) to a security solution, such as Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. To support both single-region and dual-region designs, use Azure VMware Solution with secure Virtual WAN and routing intent.

### Single-region design
 
Use the single-region design to inspect network traffic within the virtual hub security solution to and from Azure VMware Solution. This approach improves security and simplifies network management. This inspection occurs to and from Azure VMware Solution, which enhances your overall security posture and streamlines network administration. This design also prepares you for future deployments of another Azure VMware Solution private cloud in a different region that has a dual-region design. Enable routing intent in a single region hub to help scale to a dual-hub region design later. This design supports configurations with or without global reach. 

:::image type="content" source="./media/single-region-virtual-wan-high-level-design.png" alt-text="Diagram that shows a single-region, high-level design." border="false":::

### Dual-region or dual-hub design  

Use the dual-region design to inspect network traffic on both virtual hub security solutions. Inspect traffic to and from Azure VMware Solution and across Azure VMware Solution private clouds in different regions. Enable routing intent on both regional hubs so that traffic can pass through both hub security solutions. The dual-region design with routing intent improves security and simplifies network management across regions. This design works with or without Global Reach.

:::image type="content" source="./media/dual-region-virtual-wan-high-level-design.png" alt-text="Diagram that shows a dual-region high-level design." border="false":::

## ExpressRoute global reach deployment options  

To connect Azure VMware Solution to on-premises or regional Azure VMware Solution private clouds, Global Reach establishes a direct logical link via the Microsoft backbone.

### With Global Reach

When you deploy Global Reach, traffic between the Global Reach sites bypasses the secure Virtual WAN hub firewall. The secure Virtual WAN hub firewall doesn't inspect Global Reach traffic that goes between Azure VMware Solution and on-premises, or between the Azure VMware Solution private clouds in different regions. For example, the following diagram shows how traffic between Azure VMware Solution and on-premises uses the Global Reach connection labeled as "A" to communicate. This traffic doesn't transit the hub firewall because of the Global Reach connection "A". For optimal security between Global Reach sites, the Azure VMware Solution environment's NSX-T or an on-premises firewall must inspect traffic.

Global Reach simplifies the design because it provides a direct logical connection between Azure VMware Solution and on-premises or regional Azure VMware Solution private clouds. Use Global Reach to help troubleshoot traffic between Global Reach sites and eliminate throughput limitations at the secure Virtual WAN. A drawback is that Global Reach prevents the secure virtual hub security solution from inspecting traffic between regional Azure VMware Solution private clouds and on-premises, and also within Azure VMware Solution private clouds themselves. So the secure virtual hub's security solution can't inspect the traffic that flows directly between these entities.

:::image type="content" source="./media/single-region-virtual-wan-1.png" alt-text="Diagram that shows a global reach example." border="false":::

### Without Global Reach
 
We recommend that you consistently use Global Reach unless you have specific requirements. When you don't use Global Reach, all the traffic on the secure Virtual WAN hub security solution between Azure VMware Solution and the on-premises or regional Azure VMware Solution private clouds can be inspected. But this approach increases the complexity of the design. Also consider the throughput limitations at the secure Virtual WAN hub. Use Global Reach unless you have one of the following limitations:

- **You must inspect traffic on the Virtual WAN hub between Azure VMware Solution and on-premises, and also within Azure VMware Solution private clouds.**  This use case is best when there's a security requirement to inspect traffic between Azure VMware Solution and on-premises, or between regional Azure VMware Solution private clouds on the virtual hub firewall. 
   
- **A region doesn't support Global Reach.** If your region doesn't support Global Reach, you can use routing intent to establish connectivity between ExpressRoute connections, whether between Azure VMware Solution and on-premises or among regional Azure VMware Solution private clouds. By default, virtual hubs don't support ExpressRoute to ExpressRoute transitivity. To enable this transitivity, you must initiate a support ticket. For more information, see [ExpressRoute Global Reach availability](/azure/expressroute/expressroute-global-reach#availability).

- **Your on-premises ExpressRoute instance uses the ExpressRoute Local SKU.** The ExpressRoute Local SKU doesn't support Global Reach. If you use the Local SKU, you can use routing intent to establish connectivity between the Azure VMware Solution and your on-premises network.

:::image type="content" source="./media/single-region-without-globalreach-1.png" alt-text="Diagram that shows an example that doesn't have global reach." border="false":::

## Single and dual regions with Global Reach enabled and disabled
 
### Single-region design with Global Reach
 
When you use single-region with Global Reach, the secure hub routes all private and internet traffic through a security solution, such as Azure Firewall, a non-Microsoft NVA, or a SaaS solution. You can use routing intent to inspect traffic. But Global Reach traffic between Azure VMware Solution and on-premises bypasses the hub firewall as shown on Global Reach connection "A". So you need to inspect this Global Reach traffic with NSX-T in Azure VMware Solution or a firewall on-premises for better security across Global Reach sites.
                            
:::image type="content" source="./media/single-region-virtual-wan-1.png" alt-text="Diagram that shows a single-region with global reach Azure VMware Solution scenario." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution* that the secure virtual hub inspects when you use this design.

| Location 1 | Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution | &#8594;<br>&#8592; | Virtual networks | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | The internet | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | on-premises | No|

The following table shows the traffic flow to and from *virtual networks* that the secure virtual hub inspects when you use this design.

| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual networks | &#8594;<br>&#8592; | On-premises | Yes|
| Virtual networks | &#8594;<br>&#8592; | The internet | Yes|
| Virtual networks | &#8594;<br>&#8592; | Virtual networks | Yes|

### Single-region design without Global Reach

When you use single-region without Global Reach, the secure hub routes all private and internet traffic through a security solution. Use routing intent to inspect traffic. With this design, traffic between Azure VMware Solution and on-premises transits the hub firewall for inspection. As mentioned earlier, virtual hubs don't support ExpressRoute to ExpressRoute transitivity by default. To enable this transitivity, you must initiate a support ticket. After the support ticket is fulfilled, the secure hub advertises the default RFC 1918 addresses to Azure VMware Solution and to on-premises. When you use routing intent from on-premises, you can't advertise the exact default RFC 1918 address prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Instead, you must always advertise more specific routes.

:::image type="content" source="./media/single-region-without-globalreach-1.png" alt-text="Diagram of single-region without global reach Azure VMware Solution scenario." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution* that the secure virtual hub inspects when you use this design. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution | &#8594;<br>&#8592; | On-premises | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | The internet | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | Virtual networks | Yes|
  
The following table shows the traffic flow to and from *virtual networks* that the secure virtual hub inspects when you use this design.  
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual networks | &#8594;<br>&#8592; | On-premises | Yes|
| Virtual networks | &#8594;<br>&#8592; | The internet | Yes|
| Virtual networks | &#8594;<br>&#8592; | Virtual networks | Yes|
  
### Dual-region design with Global Reach

When you use dual-region with Global Reach, you deploy two secure hubs in different regions within your Virtual WAN. You also set up two Azure VMware Solution private clouds in separate regions. Each regional Azure VMware Solution private cloud connects directly to its local regional hub (as shown by connection "D"). On-premises has connectivity to each regional hub (connection "E"). All RFC 1918 and internet traffic routes through a security solution on both secure hubs via routing intent. The Azure VMware Solution private clouds have connectivity back to on-premises via Global Reach (connections "A" and "B"). Azure VMware Solution clouds have connectivity back to each other via Global Reach (connection "C"). Global Reach traffic between the Azure VMware Solution private clouds or between the Azure VMware Solution private clouds and on-premises bypasses the two hub firewalls (see connections "A", "B", and "C"). For enhanced security across Global Reach sites, use NSX-T in Azure VMware Solution or a firewall on-premises to inspect this traffic.

:::image type="content" source="./media/dual-region-virtual-wan-1.png" alt-text="Diagram that shows dual-region with global reach Azure VMware Solution scenario." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1* that the secure virtual hub inspects when you use this design. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | Virtual network 1 | Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | The internet | Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | On-premises | No |
  
The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 2* that the secure virtual hub inspects when you use this design.  
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 1 | Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | The internet | Yes, via the hub 2 firewall|  
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | On-premises | No| 

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1 and region 2* that the secure virtual hub inspects when you use this design.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Azure VMware Solution private cloud region 2 |  No|

The following table shows the traffic flow to and from *virtual networks* that the secure virtual hub inspects when you use this design.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual network 1 | &#8594;<br>&#8592; | On-premises | Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | The internet | Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 1 and hub 2 firewalls|
| Virtual network 2 | &#8594;<br>&#8592; | on-premises | Yes, via the hub 2 firewall|
| Virtual network 2 | &#8594;<br>&#8592; | The internet | Yes, via the hub 2 firewall|
  
### Dual-region design without Global Reach

When you use dual-region with Global Reach, you deploy two secure hubs in different regions within your Virtual WAN. You also set up two Azure VMware Solution private clouds in separate regions. Each regional Azure VMware Solution private cloud connects directly to its local regional hub (as shown by connection "D"). On-premises has connectivity to each regional hub (connection "E"). All RFC 1918 and internet traffic routes through a security solution on both secure hubs via routing intent.

As mentioned earlier, virtual hubs don't support ExpressRoute to ExpressRoute transitivity by default. To enable this transitivity, you must initiate a support ticket. After the support ticket is fulfilled, the secure hubs advertises the default RFC 1918 addresses to Azure VMware Solution and to on-premises. Make sure to reference both regional hubs when you open the ticket. Use ExpressRoute to ExpressRoute transitivity so that Azure VMware Solution private clouds can communicate with each other over the Virtual WAN inter-hub and the Azure VMware Solution cloud can communicate with on-premises.

RFC 1918 addresses are advertised to on-premises, you can't advertise the exact default RFC 1918 address prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Instead, you must always advertise more specific routes.

:::image type="content" source="./media/dual-region-virtual-wan-without-globalreach-1.png" alt-text="Diagram that shows dual-region without global reach Azure VMware Solution scenario." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1* that the secure virtual hub inspects when you use this design.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Virtual network 1 |  Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 1 firewall |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 1 firewall |  
  
The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 2* that the secure virtual hub inspects when you use this design. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 1 |  Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 2 firewall|

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1 and region 2* that the secure virtual hub inspects when you use this design. 

| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |    
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Azure VMware Solution private cloud region 2 |  Yes, via the hub 1 and hub 2 firewalls|
  
The following table shows the traffic flow to and from *virtual networks* that the secure virtual hub inspects when you use this design.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual network 1 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 1 firewall|  
| Virtual network 1 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls| 
| Virtual network 2 | &#8594;<br>&#8592; | on-premises |  Yes, via the hub 2 firewall|
| Virtual network 2 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 2 firewall|
  
## Related resources

- [Single-region Azure VMware Solution design with global reach, using Secure Virtual WAN with Routing Intent](single-region-with-secure-virtual-wan-with-globalreach.md)
- [Single-region Azure VMware Solution design without global reach, using Secure Virtual WAN with Routing Intent](single-region-with-secure-virtual-wan-without-globalreach.md)
 - [Dual-region Azure VMware Solution design with global reach, using Secure Virtual WAN with Routing Intent](dual-region-with-secure-virtual-wan-with-globalreach.md)
- [Dual-region Azure VMware Solution design without global reach, using Secure Virtual WAN with Routing Intent](dual-region-with-secure-virtual-wan-without-globalreach.md)

