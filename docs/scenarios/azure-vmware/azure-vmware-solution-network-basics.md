---
title: 'Azure VMware Solution network design guide: networking basics'
description: Learn the fundamental concepts of Azure VMware Solution networking. Understanding these concepts is a prerequisite for using this guide. 
author: fguerri
ms.author: fguerri
ms.date: 09/14/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Azure VMware Solution networking basics

This article summarizes some fundamental concepts about Azure VMware Solution networking. Understanding these concepts is a prerequisite to understanding the network architectures in the other articles in this guide.

## Azure ExpressRoute circuits and Azure VMware Solution private clouds

Azure VMware Solution runs on bare-metal VMware ESXi nodes that are deployed in an Azure datacenter and attached to its physical network. In the same way that ExpressRoute circuits enable you to establish Layer 3 connectivity between external networks and Azure virtual networks, a dedicated ExpressRoute implementation provides Layer 3 connectivity between physical ESXi nodes and Azure virtual networks.

When an Azure VMware Solution private cloud is provisioned, an associated ExpressRoute circuit is also instantiated in a Microsoft-managed subscription. The private cloud's owner can then connect the circuit to one or more ExpressRoute virtual network gateways in Azure virtual networks by redeeming authorization keys for the circuit. (This procedure is the same as the one that's used to create connections between ExpressRoute gateways and customer-managed circuits.) See the [Azure VMware Solution documentation](/azure/azure-vmware/deploy-azure-vmware-solution?tabs=azure-portal#connect-to-azure-virtual-network-with-expressroute) for detailed instructions.
 
:::image type="content" source="media/network-design-guide-figure-2.png" alt-text="Diagram that shows how Azure VMware Solution private clouds connect to Azure virtual networks over ExpressRoute circuits." lightbox="media/network-design-guide-figure-2.png" border="false":::

## ExpressRoute Global Reach and Azure VMware Solution private clouds 

An Azure ExpressRoute gateway can't be used to route traffic between on-premises locations that are connected to it over different circuits. This limitation also applies to the Azure VMware Solution dedicated ExpressRoute implementation, as shown here:

:::image type="content" source="media/network-design-guide-figure-3.png" alt-text="Diagram showing that ExpressRoute doesn't support routing traffic between different circuits that are connected to the same gateway." lightbox="media/network-design-guide-figure-3.png" border="false":::

Global Reach is an ExpressRoute feature that enables you to connect two ExpressRoute circuits so that the networks connected to each circuit can route traffic to each other over the Microsoft backbone. Global Reach is available in the Azure VMware Solution dedicated ExpressRoute implementation. So you can use Global Reach to connect ExpressRoute circuits that are managed by Azure VMware Solution to circuits that you manage, which provides Layer 3 connectivity between on-premises networks and Azure VMware Solution private clouds.

:::image type="content" source="media/network-design-guide-figure-4.png" alt-text="Diagram that shows how ExpressRoute Global Reach enables direct Layer 3 connectivity to on-premises sites over ExpressRoute." lightbox="media/network-design-guide-figure-4.png" border="false":::

## Azure VMware Solution network topology

An Azure VMware Solution private cloud infrastructure includes several network segments. The segments are realized by VMware's network virtualization stack (virtual distributed switches) and connected to the underlying physical infrastructure through the ESXi hosts' physical NICs.

- **Management networks** support  basic vSphere cluster functions (vCenter Server and NSX-T management virtual machines, vMotion, replication, vSAN, …). The management networks’ address space is allocated from the /22 address block assigned to each Azure VMware Solution private cloud at provisioning time. See the [Azure VMware Solution official documentation](/azure/azure-vmware/tutorial-network-checklist#routing-and-subnet-considerations) for details on how IP address ranges from the /22 block are assigned to management networks.
- **Workload segments** are customer-defined NSX-T segments to which Azure VMware Solution virtual machines attach. The address range for a workload segment is customer-defined. It cannot overlap with: (i) The Azure VMware Solution private cloud's /22 management block; (ii) Address ranges used in peered Azure virtual networks; (iii) Address ranges used in remote networks connected to the private cloud. Workload segments can be attached to Tier-1 gateways. An Azure VMware Solution private cloud can have one or more Tier-1 gateways. Tier-1 gateways can be linked to the private cloud's default Tier-0 gateway, which provides connectivity to the physical network outside the vSphere/NSX-T cluster.

The network topology of an Azure VMware solution private cloud is shown in the figure below.

:::image type="content" source="media/network-design-guide-figure4-1.png" alt-text="Figure 4-1. Network topology of an Azure VMware Solution private cloud." lightbox="media/network-design-guide-figure4-1.png":::
*Network topology of an Azure VMware Solution private cloud.*

## Dynamic routing in Azure VMware Solution
Azure VMware Solution private clouds connect to Azure virtual networks and remote sites over the managed ExpressRoute circuit. Border Gateway Protocol (BGP) is used for dynamic route exchange, as shown in the figure below.

:::image type="content" source="media/network-design-guide-figure5.png" alt-text="Figure 5. Diagram that shows how route propagation works in Azure VMware Solution." lightbox="media/network-design-guide-figure5.png":::
*Dynamic routing in Azure VMware Solution.*

In the standard topology shown in the above figure:
- Routes for management and workload segments in the Azure VMware Solution private cloud are announced to all ExpressRoute Gateways connected to the private cloud's managed circuit. In the opposite direction, ExpressRoute Gateways announce routes for: (i) The prefixes that comprise the address space of their own virtual network; (ii) The prefixes that comprise the address space of all directly peered virtual networks, if peering is configured to [allow gateway transit](/azure/virtual-network/virtual-network-peering-overview#gateways-and-on-premises-connectivity) (dotted-line arrow in the figure). 
- Routes for management and workload segments in the Azure VMware Solution private cloud are announced to all ExpressRoute circuits connected to the private cloud's managed circuit via Global Reach. In the opposite direction, all routes announced from the on-premises site over the customer-managed ExpressRoute circuit are propagated to the Azure VMware Solution private cloud (solid-line arrow in the figure).
- The routes announced from the on-premises site over the customer-managed ExpressRoute circuit are learned by all ExpressRoute Gateways connected to the circuit. The routes are injected into: (i) The route table of the Gateway's virtual network; (ii) The route table of all directly peered virtual networks, if peering is configured to [allow gateway transit](/azure/virtual-network/virtual-network-peering-overview#gateways-and-on-premises-connectivity). In the opposite direction, ExpressRoute Gateways announce routes for: (i) The prefixes that comprise the address space of their own virtual network; (ii) The prefixes that comprise the address space of all directly peered virtual networks, if peering is configured to [allow gateway transit](/azure/virtual-network/virtual-network-peering-overview#gateways-and-on-premises-connectivity) (dashed-line arrow in the figure).

> [!NOTE]
> ExpressRoute Gateways do not propagate routes across circuit connections. In the above figure, the ExpressRoute Gateway does not propagate routes learned in the dotted BGP session to the dashed BGP session, and vice versa. This is the reason why Global Reach is required to enable connectivity between the Azure VMware Solution private cloud and the on-premises site.

## Outbound data transfer charges
The managed ExpressRoute circuit associated to an Azure VMware Solution private cloud is instantiated in a Microsoft-owned subscription. Your subscriptions are not billed for any costs (monthly fees and data transfer fees) associated to the managed circuit. More specifically, your subscriptions are not billed for:
- ExpressRoute monthly fees for the managed circuit;
- Traffic transferred from an Azure virtual network to the private cloud over the managed circuit;
- ExpressRoute Global Reach ingress and egress traffic charges. When an ExpressRoute circuit that you own is connected via Global Reach to an Azure VMware Solution managed circuit, Global Reach ingress and egress charges are suppressed on your circuit too, if your circuit is in the same [geopolitical region](/azure/expressroute/expressroute-locations#locations) as the private cloud.

The ExpressRoute virtual network gateway connected to the private cloud's managed circuit is instantiated in a virtual network that you own and, as such, billed at the [standard ExpressRoute virtual network gateway rates](https://azure.microsoft.com/pricing/details/expressroute/). 

Any other network-related resources (Azure VPN Gateways, Azure Route Servers, virtual network Peerings, Public IP addresses, ...) required by the topologies discussed in this guide must be deployed in your subscription. They are billed at the standard rates.  

More details on billing for Azure VMware Solution are provided in the [official documentation](/azure/azure-vmware/faq#billing).

## Next Steps
Learn about connectivity between Azure VMware Solution and on-premises sites.

> [!div class="nextstepaction"]
> [Connectivity with on-premises sites](./network-design-guide-onprem-connectivity.md)

