---
title: 'Azure VMware Solution network design guide: Connectivity with Azure virtual networks'
description: Learn how to design Azure VMware Solution network connectivity with Azure virtual networks. This article is part of the Azure VMware Solution design guide.
author: fguerri
ms.author: fguerri
ms.date: 09/14/2023
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

Design Phase #2 depends on the option selected in [Design Phase #1](network-design-guide-onprem-connectivity.md) for on-premises connectivity. In fact, the managed ExpressRoute circuit that connects a private cloud to an Azure virtual network may also play a role in connectivity with on-premises sites. This is the case when [Transit over ExpressRoute Private peering](network-design-guide-onprem-connectivity.md#transit-over-expressroute-private-peering) is chosen in Design Phase #1, as shown in the following flow chart:

:::image type="content" source="media/network-design-guide-figure15.png" alt-text="Figure 15. Flowchart that shows the design decision making process for connectivity to Azure virtual networks." lightbox="media/network-design-guide-figure15.png":::
*Design Phase #2: How to choose an option for connectivity with Azure virtual networks.*

Continue learning about connectivity with Azure virtual networks by proceeding to one of the following sections, the one that matches the hybrid connectivity option you chose in Design Phase 1.

## Transit over ExpressRoute private peering is used for on-premises traffic
When [Transit over ExpressRoute Private Peering](network-design-guide-onprem-connectivity.md#transit-over-expressroute-private-peering) is used for connectivity with on-premises sites, traffic is routed through NVAs (typically, Azure Firewall or third-party firewall solutions) in the hub network. Traffic from on-premises sites enters the Azure virtual network through the ExpressRoute gateway (connected to the customer-owned circuit) and is routed to the firewall NVA. After inspection, it is forwarded (if not dropped by the firewall) to the private cloud through the managed ExpressRoute circuit. In the opposite direction, traffic from the private cloud enters the hub virtual network or the auxiliary virtual network, depending on the implementation option chosen in Design Phase #1 ([single virtual network](network-design-guide-onprem-connectivity.md#single-virtual-network) or [auxiliary virtual network](network-design-guide-onprem-connectivity.md#auxiliary-virtual-network)). Then, it gets routed through the ExpressRoute gateway connected to the managed circuit and to the firewall NVA. After inspection, it is forwarded (if not dropped by the firewall) to the on-premises destination through the customer-owned ExpressRoute circuit. Both the "single virtual network" and the "auxiliary virtual network" options include routing configuration that causes all traffic from a private cloud to be forwarded to the firewall NVAs in the hub network, irrespective of its destination (Azure virtual network or on-premises sites). Firewall rules to allow/drop connections between virtual machines running in the private cloud and Azure resources must be added to the firewall policy.

## ExpressRoute Global Reach is used for on-premises traffic
When [ExpressRoute Global Reach](network-design-guide-onprem-connectivity.md#expressroute-global-reach) is used for connectivity with on-premises sites, the ExpressRoute gateway connection between the hub network and the private cloud only carries traffic destined to Azure resources. In order to route this traffic through a firewall device, the following configuration is required:
- In traditional hub-spoke networks, User-Defined Routes (UDRs) must be added to the hub virtual network's GatewaySubnet for all destinations (IP prefixes) in Azure that must be reached through the NVAs. The next hop IP address for the UDRs is the firewall's VIP (the firewall's private IP address when Azure Firewall is used).
- In hub-spoke networks based on Virtual WAN with hub-integrated NVAs (Azure Firewall or third-party security solutions), custom static routes must be added to the Virtual WAN hub's default route table. A UDR is required for each IP prefix that must be reached through the NVAs from Azure VMware Solution. The next hop for these UDRs must be the Firewall/NVA's VIP. Alternatively, [Azure Virtual WAN Routing Intent/Routing Policies](/azure/virtual-wan/how-to-routing-policies) can be activated and configured on secured Virtual WAN Hubs.

## IPSec VPNs are used for on-premises traffic

When [IPSec VPNs](network-design-guide-onprem-connectivity.md#ipsec-vpns) are used for connectivity with on-premises sites, more routing configuration is required to route connections between a private cloud and resources in Azure VNets through firewall NVAs:    
- In traditional hub-spoke networks, User-Defined Routes (UDRs) must be added to the hub network's GatewaySubnet for all destinations (IP prefixes) in Azure that must be reached through the NVAs. The next hop IP address for the UDRs is the firewall's VIP (the firewall's private IP address when Azure Firewall is used).
- In hub-spoke networks based on Virtual WAN with hub-integrated NVAs (Azure Firewall or third-party security solutions), custom static routes must be added to the Virtual WAN hub's default route table for each set of destinations (IP prefixes) that must be reached through the NVAs from Azure VMware Solution. For each such UDR, the next hop must be the Firewall/NVA's VIP. Alternatively, [Azure Virtual WAN Routing Intent/Routing Policies](/azure/virtual-wan/how-to-routing-policies) can be activated and configured on secured Virtual WAN Hubs.

## Next Steps
Learn about inbound Internet connectivity

> [!div class="nextstepaction"] 
> [Inbound Internet connectivity](network-design-guide-internet-inbound-connectivity.md)