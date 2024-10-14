---
title: Use Secure Virtual WAN for Azure VMware Solution in a Single Region or in Dual Regions
description: Learn about recommendations to use secure Virtual WAN and Azure VMware Solution for single-region and dual-region deployments.
author: jasonmedina
ms.author: jasonmedina
ms.date: 10/21/2024
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-VMware
---

# Use secure Virtual WAN for Azure VMware Solution in a single region or in dual regions

This article explores the Azure VMware Solution network design topologies and considerations for single-region and dual-region scenarios that use secure Azure Virtual WAN with routing intent. It describes how routing intent directs traffic through a centralized security solution. This method enhances security and streamlines network management. This article provides design considerations for deployments with and without Azure ExpressRoute Global Reach. It highlights the benefits and challenges of each scenario.

You can implement a security solution in the Virtual WAN hub to convert the hub to a secure Virtual WAN hub. To configure routing intent, you must have a secure Virtual WAN hub. Routing intent drives all private traffic and internet traffic to the hub security solution, which streamlines your secure hub routing and security design. Routing intent improves the security breadth and conducts a traffic inspection for all traffic that goes through the secure hub, including Azure VMware Solution traffic. 

This article assumes that you have a basic understanding of Virtual WAN and secure Virtual WAN with routing intent.

For more information, see the following resources:
- [What is Virtual WAN?](/azure/virtual-wan/virtual-wan-about) 
- [What is a secure virtual hub?](/azure/firewall-manager/secured-virtual-hub)
- [Configure Virtual WAN hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) 
- [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach)

## Implement secure Virtual WAN for Azure VMware Solution designs

Use secure Virtual WAN with routing intent to send all internet traffic and private network traffic (RFC 1918) to a security solution, such as Azure Firewall, a non-Microsoft network virtual appliance (NVA), or a software as a service (SaaS) solution. To support both single-region and dual-region designs, use Azure VMware Solution along with secure Virtual WAN and routing intent.

### Use a single-region design
 
Use the single-region design to inspect network traffic within the virtual hub security solution that goes to and from Azure VMware Solution. This approach simplifies network management and enhances your overall security posture. This design also prepares you if you want to deploy another Azure VMware Solution private cloud in a different region that has a dual-region design. Enable routing intent in a single region hub to help scale to a dual-hub region design later. This design supports configurations with or without Global Reach. 

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/single-region-virtual-wan-high-level-design.svg" alt-text="Diagram that shows a single-region, high-level design." border="false":::

### Use a dual-region or dual-hub design  

Use a dual-region design to inspect network traffic on two virtual hub security solutions. Inspect traffic to and from Azure VMware Solution, and inspect traffic across Azure VMware Solution private clouds that are in different regions. Enable routing intent on both regional hubs so that traffic can pass through both hub security solutions. A dual-region design with routing intent improves security and simplifies network management across regions. This design supports configurations with or without Global Reach.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/dual-region-virtual-wan-high-level-design.svg" alt-text="Diagram that shows a dual-region, high-level design." border="false":::

## Global Reach deployment options  

Use Global Reach to connect Azure VMware Solution to on-premises or regional Azure VMware Solution private clouds. Global Reach establishes a direct logical link via the Microsoft backbone.

### Use Global Reach

When you deploy Global Reach, traffic between the Global Reach sites bypasses the secure Virtual WAN hub firewall. The secure Virtual WAN hub firewall doesn't inspect Global Reach traffic that goes between Azure VMware Solution and on-premises or between Azure VMware Solution private clouds in different regions.

For example, the following diagram shows how traffic between Azure VMware Solution and on-premises uses the Global Reach connection labeled as **A** to communicate. This traffic doesn't transit the hub firewall because of Global Reach connection **A**. For optimal security between Global Reach sites, the Azure VMware Solution environment's NSX-T or an on-premises firewall must inspect traffic.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/single-region-virtual-wan-1.svg" alt-text="Diagram that shows a Global Reach example." border="false":::

Global Reach simplifies the design because it provides a direct logical connection between Azure VMware Solution and on-premises or regional Azure VMware Solution private clouds. Use Global Reach to help troubleshoot traffic between Global Reach sites and eliminate throughput limitations at the secure Virtual WAN. A drawback is that Global Reach prevents the secure virtual hub security solution from inspecting traffic between regional Azure VMware Solution private clouds and on-premises, and also within Azure VMware Solution private clouds themselves. So the secure virtual hub's security solution can't inspect the traffic that flows directly between these entities.

### Don't use Global Reach
 
We recommend that you consistently use Global Reach unless you have specific requirements. When you don't use Global Reach, you can inspect all the traffic on the secure Virtual WAN hub security solution between Azure VMware Solution and the on-premises or regional Azure VMware Solution private clouds. But this approach increases the complexity of the design. Also consider the throughput limitations at the secure Virtual WAN hub. Use Global Reach unless you have one of the following limitations.

- **You must inspect traffic on the Virtual WAN hub between Azure VMware Solution and on-premises, and also within Azure VMware Solution private clouds.** You can't use Global Reach if you have a security requirement to inspect traffic between Azure VMware Solution and on-premises, or between regional Azure VMware Solution private clouds on the virtual hub firewall. 
   
- **A region doesn't support Global Reach.** If a region doesn't support Global Reach, you can use routing intent to establish connectivity between ExpressRoute connections, whether between Azure VMware Solution and on-premises or among regional Azure VMware Solution private clouds. By default, virtual hubs don't support ExpressRoute to ExpressRoute transitivity. To enable this transitivity, you must initiate a support ticket. For more information, see [ExpressRoute Global Reach availability](/azure/expressroute/expressroute-global-reach#availability).

- **Your on-premises ExpressRoute instance uses the ExpressRoute Local SKU.** The ExpressRoute Local SKU doesn't support Global Reach. If you use the Local SKU, you can use routing intent to establish connectivity between the Azure VMware Solution and your on-premises network.

The following diagram shows an example that doesn't use Global Reach.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/single-region-without-global-reach-1.svg" alt-text="Diagram that shows an example that doesn't have Global Reach." border="false":::

## Consider Global Reach options for a single region or for dual regions

Use the following guidance to determine whether you need to enable Global Reach for your scenario.
 
### Use a single-region design that has Global Reach
 
When you use Global Reach in a single region, the secure hub routes all private traffic and internet traffic through a security solution, such as Azure Firewall, a non-Microsoft NVA, or a SaaS solution. In the following diagram, routing intent inspects traffic, but Global Reach traffic between Azure VMware Solution and on-premises bypasses the hub firewall (connection **A**). So you need to inspect this Global Reach traffic with NSX-T in Azure VMware Solution or an on-premises firewall for better security across Global Reach sites.
                            
:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/single-region-virtual-wan-1.svg" alt-text="Diagram that shows a single region that has Global Reach and Azure VMware Solution." border="false":::

The following table shows the traffic flow to and from Azure VMware Solution.

| Location 1 | Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution | &#8594;<br>&#8592; | Virtual networks | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | The internet | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | On-premises | No|

The following table shows the traffic flow to and from virtual networks.

| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual networks | &#8594;<br>&#8592; | On-premises | Yes|
| Virtual networks | &#8594;<br>&#8592; | The internet | Yes|
| Virtual networks | &#8594;<br>&#8592; | Virtual networks | Yes|

### Use a single-region design that doesn't have Global Reach

When you don't use Global Reach in a single region, the secure hub routes all private traffic and internet traffic through a security solution. Routing intent inspects traffic. With this design, traffic between Azure VMware Solution and on-premises transits the hub firewall for inspection. Virtual hubs don't support ExpressRoute to ExpressRoute transitivity by default. To enable this transitivity, you must initiate a support ticket. After the support ticket is fulfilled, the secure hub advertises the default RFC 1918 addresses to Azure VMware Solution and to on-premises. When you use routing intent from on-premises, you can't advertise the exact default RFC 1918 address prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Instead, you must always advertise more specific routes.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/single-region-without-global-reach-1.svg" alt-text="Diagram that shows a single region that doesn't use Global Reach." border="false":::

The following table shows the traffic flow to and from Azure VMware Solution. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution | &#8594;<br>&#8592; | On-premises | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | The internet | Yes|
| Azure VMware Solution | &#8594;<br>&#8592; | Virtual networks | Yes|
  
The following table shows the traffic flow to and from virtual networks.  
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual networks | &#8594;<br>&#8592; | On-premises | Yes|
| Virtual networks | &#8594;<br>&#8592; | The internet | Yes|
| Virtual networks | &#8594;<br>&#8592; | Virtual networks | Yes|
  
### Use a dual-region design that has Global Reach

When you use Global Reach in two regions, you deploy two secure hubs in different regions within your Virtual WAN. You also set up two Azure VMware Solution private clouds in separate regions.

The following diagram shows an example of this configuration. Each regional Azure VMware Solution private cloud connects directly to its local regional hub (connection **D**). On-premises connects to each regional hub (connection **E**). All RFC 1918 traffic and internet traffic routes through a security solution on both secure hubs via routing intent. The Azure VMware Solution private clouds have connectivity back to on-premises via Global Reach (connections **A** and **B**). Azure VMware Solution clouds connect to each other via Global Reach (connection **C**). Global Reach traffic between the Azure VMware Solution private clouds or between the Azure VMware Solution private clouds and on-premises bypasses the two hub firewalls (connections **A**, **B**, and **C**). For enhanced security across Global Reach sites, use NSX-T in Azure VMware Solution or an on-premises firewall to inspect this traffic.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/dual-region-virtual-wan-1.svg" alt-text="Diagram that shows dual regions with Global Reach and Azure VMware Solution." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1*. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | Virtual network 1 | Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | The internet | Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1  | &#8594;<br>&#8592; | On-premises | No |
  
The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 2*.  
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 1 | Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | The internet | Yes, via the hub 2 firewall|  
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | On-premises | No| 

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1 and region 2*.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Azure VMware Solution private cloud region 2 |  No|

The following table shows the traffic flow to and from virtual networks.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual network 1 | &#8594;<br>&#8592; | On-premises | Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | The internet | Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | Virtual network 2 | Yes, via the hub 1 and hub 2 firewalls|
| Virtual network 2 | &#8594;<br>&#8592; | On-premises | Yes, via the hub 2 firewall|
| Virtual network 2 | &#8594;<br>&#8592; | The internet | Yes, via the hub 2 firewall|
  
### Use a dual-region design that doesn't have Global Reach

When you use Global Reach in two regions, you deploy two secure hubs in different regions within your Virtual WAN. You also set up two Azure VMware Solution private clouds in separate regions. 

The following diagram shows an example of this configuration. Each regional Azure VMware Solution private cloud connects directly to its local regional hub (connection **D**). On-premises connects to each regional hub (connection **E**). All RFC 1918 traffic and internet traffic routes through a security solution on both secure hubs via routing intent.

Virtual hubs don't support ExpressRoute to ExpressRoute transitivity by default. To enable this transitivity, you must initiate a support ticket. After the support ticket is fulfilled, the secure hubs advertises the default RFC 1918 addresses to Azure VMware Solution and to on-premises. Reference both regional hubs when you open the ticket. Use ExpressRoute to ExpressRoute transitivity so that Azure VMware Solution private clouds can communicate with each other over the Virtual WAN interhub and the Azure VMware Solution cloud can communicate with on-premises.

RFC 1918 addresses are advertised to on-premises, you can't advertise the exact default RFC 1918 address prefixes (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) back to Azure. Instead, you must always advertise more specific routes.

:::image type="content" source="./media/introduction-virtual-wan-azure-vmware-solution/dual-region-virtual-wan-without-global-reach-1.svg" alt-text="Diagram that shows a dual region that doesn't have Global Reach." border="false":::

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1*.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Virtual network 1 |  Yes, via the hub 1 firewall|
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 1 firewall |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 1 firewall |  
  
The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 2*. 
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 1 |  Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 2 firewall|
| Azure VMware Solution private cloud region 2 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 2 firewall|

The following table shows the traffic flow to and from *Azure VMware Solution private cloud region 1 and region 2*. 

| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |    
| -------------- | -------- | ---------- | --- |
| Azure VMware Solution private cloud region 1 | &#8594;<br>&#8592; | Azure VMware Solution private cloud region 2 |  Yes, via the hub 1 and hub 2 firewalls|
  
The following table shows the traffic flow to and from virtual networks.
  
| Location 1 |   Direction |  Location 2 | Does the secure Virtual WAN hub firewall inspect this traffic? |  
| -------------- | -------- | ---------- | --- |
| Virtual network 1 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 1 firewall|  
| Virtual network 1 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 1 firewall|
| Virtual network 1 | &#8594;<br>&#8592; | Virtual network 2 |  Yes, via the hub 1 and hub 2 firewalls| 
| Virtual network 2 | &#8594;<br>&#8592; | On-premises |  Yes, via the hub 2 firewall|
| Virtual network 2 | &#8594;<br>&#8592; | The internet |  Yes, via the hub 2 firewall|
  
## Related resources

- [Single-region Azure VMware Solution design that has Virtual WAN and Global Reach](single-region-virtual-wan-global-reach.md)
- [Single-region Azure VMware Solution design that doesn't have Global Reach](single-region-virtual-wan-without-global-reach.md)
 - [Dual-region Azure VMware Solution design that has Virtual WAN and Global Reach](dual-region-virtual-wan-global-reach.md)
- [Dual-region Azure VMware Solution design that doesn't have Global Reach](dual-region-virtual-wan-without-global-reach.md)

