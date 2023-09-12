---
title: 'Azure VMware Solution network design guide: Connectivity with Azure virtual networks'
description: Learn how to design Azure VMware Solution network connectivity with Azure virtual networks. This article is part of the Azure VMware Solution design guide.
author: fguerri
ms.author: fguerri
ms.date: 09/15/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase 2: Connectivity with Azure virtual networks

Azure VMware Solution private clouds connect to Azure virtual networks via managed Azure ExpressRoute circuits. For more information, see [ExpressRoute circuits and Azure VMware Solution private clouds](azure-vmware-solution-network-basics.md#azure-expressroute-circuits-and-azure-vmware-solution-private-clouds). In hub-spoke Azure networks (including networks that are built with Azure Virtual WAN), connecting a private cloud's managed circuit to an ExpressRoute gateway in the hub network (or Virtual WAN hub) provides Layer 3 connectivity with the private cloud. However, enforcing security policies to selectively allow or deny connections between resources is often a requirement. This requirement can exist between:

- Azure virtual networks and VMs running in the Azure VMware Solution private cloud.
- Azure virtual networks and the Azure VMware Solution private cloud's management endpoints.

Although both Azure virtual networks and vSphere/NSX-T provide native constructs for network segmentation, firewall solutions deployed as network virtual appliancess (NVAs) in Azure virtual networks are often the preferred option in enterprise-scale environments. This article focuses on a virtual network configuration that allows you to route traffic between private clouds and Azure virtual networks by using custom next hops, such as firewall NVAs.

The choice you make in this design phase depends on the option that you selected in [design phase 1](on-premises-connectivity.md) for on-premises connectivity. In fact, the managed ExpressRoute circuit that connects a private cloud to an Azure virtual network can also play a role in connectivity with on-premises sites. This is the case if you choose [transit over ExpressRoute private peering](on-premises-connectivity.md#transit-over-expressroute-private-peering) during design phase 1. This flowchart shows the process for choosing an option for connectivity with Azure virtual networks:

:::image type="content" source="media/network-design-guide-figure-15.png" alt-text="Flowchart that shows the design decision making process for connectivity to Azure virtual networks." lightbox="media/network-design-guide-figure-15.png" border="false":::

For more information about connectivity with Azure virtual networks, read one of the following sections. Choose the section that matches the hybrid connectivity option that you selected during design phase 1.

## Transit over ExpressRoute private peering is used for on-premises traffic

When you use [transit over ExpressRoute private peering](on-premises-connectivity.md#transit-over-expressroute-private-peering) for connectivity with on-premises sites, traffic is routed through NVAs (typically, Azure Firewall or third-party firewall solutions) in the hub network. Traffic from on-premises sites enters the Azure virtual network via the ExpressRoute gateway (connected to the customer-owned circuit) and is routed to the firewall NVA. After inspection, traffic is forwarded (if it's not dropped by the firewall) to the private cloud via the managed ExpressRoute circuit. 

In the opposite direction, traffic from the private cloud enters the hub virtual network or the auxiliary virtual network, depending on the implementation option chosen during design phase 1 ([single virtual network](on-premises-connectivity.md#single-virtual-network) or [auxiliary virtual network](on-premises-connectivity.md#auxiliary-virtual-network)). It's then routed through the ExpressRoute gateway that's connected to the managed circuit and to the firewall NVA. After inspection, traffic is forwarded (if it's not dropped by the firewall) to the on-premises destination via the customer-owned ExpressRoute circuit. 

The single virtual network and the auxiliary virtual network options both include routing configuration that causes all traffic from a private cloud to be forwarded to the firewall NVAs in the hub network, regardlesss of its destination (Azure virtual network or on-premises sites). Firewall rules to allow or drop connections between virtual machines running in the private cloud and Azure resources must be added to the firewall policy.

## ExpressRoute Global Reach is used for on-premises traffic

When you use [ExpressRoute Global Reach](on-premises-connectivity.md#expressroute-global-reach) for connectivity with on-premises sites, the ExpressRoute gateway connection between the hub network and the private cloud only carries traffic destined to Azure resources. To route this traffic through a firewall device, you need to implement the following configuration:

- In traditional hub-spoke networks, you need to add User Defined Routes (UDRs) to the hub virtual network's GatewaySubnet for all destinations (IP prefixes) on Azure that need to be reached via the NVAs. The next hop IP address for the UDRs is the firewall's VIP (the firewall's private IP address when you use Azure Firewall).
- In hub-spoke networks that are based on Virtual WAN with hub-integrated NVAs (Azure Firewall or third-party security solutions), you need to add custom static routes to the Virtual WAN hub's default route table. A UDR is required for each IP prefix that needs to be reached through the NVAs from Azure VMware Solution. The next hop for these UDRs needs to be the firewall or NVA's VIP. Alternatively, you can activate and configure [Virtual WAN routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) on secured Virtual WAN hubs.

## IPSec VPNs are used for on-premises traffic

When you use [IPSec VPNs](on-premises-connectivity.md#ipsec-vpns) for connectivity with on-premises sites, you need to configure additional routing  to route connections between a private cloud and resources in Azure virtual networks via firewall NVAs:

- In traditional hub-spoke networks, you need to add UDRs to the hub network's GatewaySubnet for all destinations (IP prefixes) on Azure that need to be reached via the NVAs. The next hop IP address for the UDRs is the firewall's VIP (the firewall's private IP address when you use Azure Firewall).
- In hub-spoke networks that are based on Virtual WAN with hub-integrated NVAs (Azure Firewall or third-party security solutions), you need to add custom static routes to the Virtual WAN hub's default route table for each set of destinations (IP prefixes) that need to be reached via the NVAs from Azure VMware Solution. For each UDR, the next hop must be the firewall or NVA's VIP. Alternatively, you can activate and configure [Virtual WAN routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) on secured Virtual WAN hubs.

## Next steps

Learn about inbound internet connectivity.

> [!div class="nextstepaction"] 
> [Inbound internet connectivity](network-design-guide-internet-inbound-connectivity.md)