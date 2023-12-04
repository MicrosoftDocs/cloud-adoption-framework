---
title: 'Azure VMware Solution network design guide: Connectivity with on-premises sites'
description: Learn how to design Azure VMware Solution network connectivity with on-premises sites. Considerations include throughput and latency.
author: fguerri
ms.author: fguerri
ms.date: 09/20/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase 1: Connectivity with on-premises sites

Connectivity with on-premises datacenters is the most critical design area for Azure VMware Solution networking. The key requirements that must be addressed include:

- High throughput: Migrations from on-premises vSphere environments and disaster recovery solutions require moving large volumes of data between on-premises sites and Azure VMware Solution private clouds quickly.
- Low latency: Distributed applications might require low latency for connections between Azure VMware Solution virtual machines and on-premises systems.
- Performance predictability: To achieve predictable throughput and latency, business-critical applications that are deployed on Azure VMware Solution might require dedicated connectivity services (Azure ExpressRoute) between on-premises sites and the Microsoft network.

This article describes the options supported by Azure VMware Solution for connectivity with on-premises sites:
 
- [ExpressRoute Global Reach](#expressroute-global-reach)
- [IPSec VPNs](#ipsec-vpns)
- [Transit over ExpressRoute private peering](#transit-over-expressroute-private-peering)

The options are presented in order of decreasing ability to meet the key requirements listed earlier. An option should be discarded, and the next one considered, only if it conflicts with the non-negotiable constraints of a specific scenario.

This flowchart summarizes the process for choosing a hybrid connectivity option for Azure VMware Solution:

:::image type="content" source="media/network-design-guide-figure-6.png" alt-text="Flowchart that summarizes the decision-making process for choosing a connectivity option." lightbox="media/network-design-guide-figure-6.png" border="false":::
 
## ExpressRoute Global Reach

ExpressRoute Global Reach is the default hybrid connectivity option supported by Azure VMware Solution. It provides, with minimal complexity, Layer 3 connectivity between an Azure VMware Solution private cloud and a remote site that's connected to a customer-managed ExpressRoute circuit. You can also use the customer-managed ExpressRoute circuit to connect to Azure native services. To improve security or reserve bandwidth, you can also deploy a separate customer-managed circuit that's exclusively dedicated to Azure VMware Solution traffic.

The following diagram shows a network topology that uses Global Reach for connectivity with on-premises sites. Traffic between Azure VMware Solution private clouds and on-premises sites doesn't traverse Azure virtual networks.
 
 :::image type="content" source="media/network-design-guide-figure-7.png" alt-text="Diagram that shows how ExpressRoute Global Reach enables connectivity to on-premises sites." lightbox="media/network-design-guide-figure-7.png" border="false":::

For instructions on how to connect an Azure VMware Solution private cloud to a customer-managed ExpressRoute circuit by using Global Reach, see [Peer on-premises environments to Azure VMware Solution](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud).

Global Reach connectivity fully addresses the three key requirements:
 
- High throughput: ExpressRoute enables you to connect to the Microsoft network from your premises over dedicated lines (up to 10 Gbps for provider-based ExpressRoute, or 100 Gbps for ExpressRoute Direct). 
- Low latency: Global Reach enables you to route traffic directly from the edge of the Microsoft network to Azure VMware Solution vSphere clusters. Global Reach minimizes the number of network hops between on-premises sites and private clouds.
- Predictable performance: When you use ExpressRoute Global Reach, traffic is routed over links that don't experience congestion issues (up to the maximum provisioned capacity). Therefore, the round-trip time (RTT) between virtual machines running on Azure VMware Solution and on-premises hosts remains constant over time.

You can't use Global Reach in scenarios where one or more of the following constraints apply:

  - ExpressRoute Global Reach is unavailable in the Azure region of the Azure VMware Solution private cloud or the meet-me location of the customer-managed ExpressRoute circuit. No workarounds exist for this limitation. See [About ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach#availability) for up-to-date information about Global Reach availability.
  - Non-negotiable network security requirements exist. If a firewall device can't be deployed on the on-premises side of the customer-managed ExpressRoute circuit, using Global Reach exposes all Azure VMware Solution network segments, including management networks (vCenter Server and NSX-T management), to the entire network that's connected to the circuit. The most typical scenario in which this issue arises is when customer-managed ExpressRoute circuits are implemented on top of MPLS network services (also known as the [ExpressRoute any-to-any connectivity model](/azure/expressroute/expressroute-connectivity-models)). This scenario is shown here: 
 
    :::image type="content" source="media/network-design-guide-figure-8.png" alt-text="Diagram that shows why ExpressRoute Global Reach might prevent traffic inspection." lightbox="media/network-design-guide-figure-8.png" border="false":::

    When ExpressRoute connectivity is implemented on top of MPLS IPVPNs, it's impossible to deploy firewalls in a single location to inspect all traffic to and from Azure VMware Solution. Typically, organizations that use MPLS networks deploy firewalls in large datacenters, not in all of their sites (which can be small branches, offices, or stores).

## IPSec VPNs

You can implement connectivity between Azure VMware Solution private clouds and on-premises sites by routing traffic through a *transit* virtual network on Azure. The transit network is connected to the Azure VMware Solution private cloud through the managed ExpressRoute circuit. The transit virtual network is connected to the on-premises site via an IPSec VPN, as shown here:

:::image type="content" source="media/network-design-guide-figure-9.png" alt-text="Diagram that shows a general architecture for IPSec connectivity." lightbox="media/network-design-guide-figure-9.png" border="false":::

You can enforce security policies for connections between on-premises sites and the Azure VMware Solution private cloud (the dashed line in the diagram) by routing traffic through a firewall, if the VPN device doesn't provide firewall features. This configuration requires [Azure Virtual WAN with routing Intent](/azure/virtual-wan/how-to-routing-policies), as discussed in the [Decide where to host the virtual devices on Azure](#decide-where-to-host-the-virtual-devices-on-azure) section of this article.

Before you implement IPSec connectivity between on-premises sites and transit virtual networks, you need to make three design decisions:

1. Determine which network service to use as the underlay for the IPSec tunnel. The available options are internet connectivity, ExpressRoute Microsoft peering, and ExpressRoute private peering.
2. Determine where to host the virtual devices that terminate the IPSec tunnel on the Azure side. The available options include customer-managed virtual networks and Virtual WAN hubs. 
3. Determine which virtual device terminates the IPSec tunnel on the Azure side. The choice of device also determines the required Azure configuration for routing traffic between the IPSec tunnel and the Azure VMware Solution managed circuit. The available options are native Azure VPN Gateway and third-party IPSec NVAs (network virtual appliances).

This flowchart summarizes the decision-making process:

:::image type="content" source="media/network-design-guide-figure-9-1.png" alt-text="Flowchart that summarizes the design-decision making process for implementing IPSec connectivity." border="false" lightbox="media/network-design-guide-figure-9-1.png":::

The criteria for making these decisions are described in the following sections.

#### Choose an underlay network service

We strongly recommend that you consider the three options for the VPN underlay in the order presented here: 

- **Internet connection**. The public IP address assigned to the VPN device that's hosted in the transit virtual network serves as the remote endpoint of the IPSec tunnel. Due to its low complexity and cost, you should always test and assess internet connectivity for performance (achievable IPSec throughput). You should dismiss this option only when the observed performance is too low or inconsistent. The following diagram illustrates this option.

   :::image type="content" source="media/network-design-guide-figure-10.png" alt-text="Diagram that illustrates the use of an internet connection as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure-10.png" border="false":::

- **ExpressRoute Microsoft peering**. This option provides Layer 3 connectivity to Azure public endpoints over dedicated links. Like internet connections, it enables you to reach the public IP of a VPN device that serves as the remote endpoint of the IPSec tunnel and is hosted in the transit virtual network. You should dismiss this option only when the [Microsoft peering's routing requirements](/azure/expressroute/expressroute-routing#ip-addresses-used-for-microsoft-peering) can't be met. The following diagram illustrates this option. 

   :::image type="content" source="media/network-design-guide-figure-11.png" alt-text="Diagram that illustrates the use of ExpressRoute Microsoft peering as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure-11.png" border="false":::

- **ExpressRoute private peering**. This option provides Layer 3 connectivity between an on-premises site and Azure virtual networks over dedicated links. It therefore enables you to establish an IPSec tunnel from the on-premises site to the private IP address of a VPN device that's hosted in a virtual network. ExpressRoute private peering might introduce bandwidth limitations because the ExpressRoute gateway is in the data path. You can use [ExpressRoute FastPath](/azure/expressroute/about-fastpath) to address this problem. Private peering also requires more complex routing configuration on the on-premises side. For more information, see [Configure a Site-to-Site VPN connection over ExpressRoute private peering](/azure/vpn-gateway/site-to-site-vpn-private-peering). The following diagram illustrates this option.

   :::image type="content" source="media/network-design-guide-figure-12.png" alt-text="Diagram that illustrates the use of ExpressRoute private peering as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure-12.png" border="false":::
 
#### Decide where to host the virtual devices on Azure

The available options include customer-managed virtual networks and Virtual WAN hubs. To make this decision, consider the characteristics of the pre-existing Azure environment, if there is one, and how you want to prioritize reducing management effort vs. your ability to tailor the configuration to specific needs. Following are some key considerations.

- You should use pre-existing Azure network infrastructure for Azure VMware Solution connectivity. If a customer-managed hub-spoke network already exists in the same region as the Azure VMware Solution private cloud, you should deploy the IPSec termination devices in the existing hub. If a hub-spoke network that's based on Virtual WAN exists in the same region as the Azure VMware Solution private cloud, you should use the Virtual WAN hub for IPSec termination.
- In a customer-managed hub-spoke network, to route traffic between an IPSec tunnel and the ExpressRoute managed circuit, you need to deploy an [Azure Route Server instance](/azure/route-server/overview) in the hub virtual network and configure it to [allow branch-to-branch traffic](/azure/route-server/expressroute-vpn-support). It's not possible to route traffic between Azure VMware Solution private clouds and on-premises sites through firewall devices that are deployed in the virtual network.
- Virtual WAN hubs natively support routing traffic between the IPSec tunnel that's connected to the on-premises site and the Azure VMware Solution managed ExpressRoute circuit.
- If you use Virtual WAN, you can configure [routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) for traffic inspection. You can use Azure Firewall or third-party security solutions that are supported by Virtual WAN. We recommended that you review the regional availability and limitations of routing intent.

#### Decide which virtual device terminates the IPSec tunnel

The IPSec tunnel that provides connectivity to the on-premises site can be terminated by Azure VPN Gateway or by third-party NVAs. To make this decision, consider the characteristics of the pre-existing Azure environment, if there is one, and how you want to prioritize reducing management effort vs. your ability to tailor the configuration to specific needs. Following are some key considerations.

- In both hub-spoke networks that are customer-managed and hub-spoke networks that are based on Virtual WAN, you can use Azure VPN Gateway to terminate IPSec tunnels that are connected to on-premises sites. Because they're platform-managed, Azure VPN gateways require minimal management effort. You can use pre-existing gateways even if they support other connectivity scenarios. You should review these articles for information about supported settings and expected performance:
    - [VPN Gateway SKUs and expected performance levels (standalone)](/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#benchmark)
    - [VPN Gateway cryptographic requirements (standalone)](/azure/vpn-gateway/vpn-gateway-about-compliance-crypto)
    - [VPN Gateway settings (Virtual WAN)](/azure/virtual-wan/gateway-settings#s2s)
    - [VPN Gateway cryptographic requirements (Virtual WAN)](/azure/virtual-wan/virtual-wan-ipsec) 

- Third-party NVAs are typically used to terminate tunnels from on-premises sites in the following situations:
    - The NVA is the CPE (customer premises equipment) of an SDWAN solution that's deployed both on Azure and on the on-premises site.
    - The NVA is a firewall that enforces the required security policy for connections between the on-premises site and Azure VMware Solution.

Using third-party devices might provide more flexibility and access to advanced network functions that aren't supported by native VPN gateways, but it increases complexity. High availability becomes your responsibility. You should deploy multiple instances.

## Transit over ExpressRoute private peering

ExpressRoute private peering is the most common choice for connecting an on-premises site to an Azure virtual network (or hub-spoke network) in enterprise scenarios. The Azure virtual network, or the hub virtual network in hub-spoke topologies, contains an ExpressRoute gateway that's configured with a connection to the ExpressRoute circuit. This configuration provides Layer 3 connectivity between the virtual network (or the entire hub-spoke network) and the on-premises site's network. However, it doesn't natively provide Layer 3 connectivity to Azure VMware Solution private clouds that are connected to the same virtual network (or hub virtual network) through a managed ExpressRoute circuit. (See [ExpressRoute Global Reach and Azure VMware Solution private clouds](azure-vmware-solution-network-basics.md#expressroute-global-reach-and-azure-vmware-solution-private-clouds).)

You can work around this limitation by deploying more routing devices in the Azure virtual network. Doing so enables you to route traffic through firewall NVAs that are hosted in the virtual network. 

Transit over ExpressRoute private peering might seem desirable, but it adds complexity and affects performance. You should consider it only when ExpressRoute Global Reach and IPSec VPNs (described in the previous sections) aren't applicable.

There are two implementation options:

- Single virtual network. When you use this option, the customer-managed and Azure VMware Solution managed circuits are connected to the same ExpressRoute gateway.
- Auxiliary transit virtual network. When you use this option, the customer-managed ExpressRoute circuit that provides connectivity to the on-premises site is connected to the (typically pre-existing) ExpressRoute gateway in the hub virtual network. The Azure VMware Solution managed circuit is connected to a different ExpressRoute gateway that's deployed in an auxiliary transit virtual network.

The following sections provide details about the two implementation options, including:

- Tradeoffs among performance, cost (required Azure resources), and management overhead.
- Control plane implementation (how routes are exchanged between the on-premises site and the private cloud).
- Data plane implementation (how network packets are routed between the on-premises site and the private cloud).

#### Single virtual network

When you use the single virtual network approach, both the Azure VMware Solution private cloud's managed circuit and the customer-owned circuit are connected to the same ExpressRoute gateway, typically the hub network. Traffic between the private cloud and the on-premises site can be routed through firewall NVAs that are deployed in the hub network. The single virtual network architecture is shown here:

:::image type="content" source="media/network-design-guide-figure-13.png" alt-text="Diagram that shows the single virtual network option for ExpressRoute transit." lightbox="media/network-design-guide-figure-13.png" border="false":::

The control plane and the data plane are implemented as described here:

- Control plane. An ExpressRoute gateway that's deployed in the Azure virtual network can't propagate routes between the Azure VMware Solution managed circuit and the customer-managed ExpressRoute circuit. [Azure Route Server](/azure/route-server/overview), with the [branch-to-branch setting](/azure/route-server/expressroute-vpn-support) enabled, is used to inject, in both circuits, routes for supernets that include the Azure VMware Solution private cloud's address space (management networks and workload segments) and the on-premises address space. 

  Supernets, instead of the exact prefixes that comprise those address spaces, must be announced, because the exact prefixes are already announced in the opposite direction by the Azure VMware Solution private cloud and the on-premises site. You can use supernets as large as RFC 1918 prefixes if they're compatible with the network configuration of the on-premises sites. In most cases, you should instead use the smallest supernets that include the Azure VMware Solution private cloud's address space and the on-premises address space. Doing so minimizes the risks of conflicts with the routing configuration of the on-premises sites. 

  The routes for the supernets are originated by BGP-capable NVAs. The NVAs are configured to establish a BPG session with the Azure Route Server. The NVAs are only part of the control plane and don't route actual traffic between the on-premises site and the Azure VMware Solution private cloud. The control plane implementation is represented by the dashed lines in the preceding figure.
- Data plane. The control plane implementation that's described previously attracts the following traffic to the ExpressRoute gateway: 
   - Traffic from the on-premises site that's destined to the Azure VMware Solution private cloud.
   - Traffic from the Azure VMware Solution private cloud that's destined to the on-premises site. 

  If no UDRs are applied to GatewaySubnet, traffic flows directly between the on-premises site and the Azure VMware Solution private cloud. You can route traffic to an intermediate next hop by applying UDRs to GatewaySubnet. Firewall NVAs that enforce network security policies on connections between on-premises sites and private clouds are a typical example. The data plane implementation is represented by the solid line in the preceding figure. 

#### Auxiliary virtual network

You can use an auxiliary virtual network to host a second ExpressRoute gateway that's connected only to the Azure VMware Solution private cloud's managed circuit. If you use this approach, the private cloud's managed circuit and the customer-managed circuit connect to different ExpressRoute gateways. Two Azure Route Server instances are used to announce the proper routes to each circuit and to control route propagation between the private cloud and the on-premises site. You don't need to announce supernets, as you do for the single virtual network option that's described in the previous section. Management overhead for UDRs in GatewaySubnet is also reduced. This approach enables you to route traffic between the private cloud and the on-premises site through firewall NVAs in the hub virtual network. The auxiliary virtual network implementation is shown in the following diagram:

:::image type="content" source="media/network-design-guide-figure-14.png" alt-text="Diagram that shows the auxiliary virtual network implementation." lightbox="media/network-design-guide-figure-14.png" border="false":::

The control plane and the data plane are implemented as described here:

- Control plane. To enable route propagation between the Azure VMware Solution private cloud's managed circuit and the customer-owned circuit, you need an Azure Route Server instance in each virtual network. Because the two Azure Route Server instances [can't establish a BGP adjacency](/azure/route-server/route-server-faq#can-i-peer-two-route-servers-in-two-peered-virtual-networks-and-enable-the-nvas-connected-to-the-route-servers-to-talk-to-each-other), BGP-capable NVAs are needed to propagate routes between them. For high availability, you should deploy at least two NVA instances. You can add more instances to increase throughput. The BGP-capable NVAs must have two NICs that are attached to different subnets. BGP sessions toward the two route servers (in the auxiliary virtual network and the hub virtual network) must be established over different NICs.

  Routes originated by the Azure VMware Solution private cloud and by the on-premises site are learned over ExpressRoute circuits. Their AS paths contain ASN 65515 (an Azure-reserved ASN that's used by ExpressRoute gateways) and ASN 12076 (a Microsoft-owned ASN that's used by the Microsoft Enterprise edge routers in all peering locations). The BGP-capable NVAs must remove the AS paths to prevent routes from being dropped by BGP loop detection. For more information on the required BGP configuration, see [Implement Expressroute connectivity for AVS without Global Reach](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Networking/Step-By-Step-Guides/Expressroute%20connectivity%20for%20AVS%20without%20Global%20Reach). The control plane implementation is represented by the dashed lines in the preceding diagram.
- Data plane. In the auxiliary virtual network, traffic between the Azure VMware Solution private cloud and the on-premises site is routed through the BGP-capable NVAs. Traffic to and from the Azure VMware Solution private cloud leaves or enters the NVAs through the NIC that's used for the BGP session with the auxiliary virtual network's route server. Traffic to and from the on-premises site leaves or enters the NVAs through the NIC that's used for the BGP session with the hub virtual network's route server. This NIC is attached to a subnet that's associated to a custom route table that:
   - Disables learning BGP routes from the route server (to avoid loops).  
   - Inserts the hub network's firewall in the data path. 
   
   To ensure that traffic is symmetrically routed via the hub firewall, UDRs for all prefixes that are used in the Azure VMware Solution private cloud must be configured on the hub's GatewaySubnet. For more information, see [Implement Expressroute connectivity for AVS without Global Reach](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Networking/Step-By-Step-Guides/Expressroute%20connectivity%20for%20AVS%20without%20Global%20Reach). The data plane implementation is represented by the solid line in the preceding diagram.

## Next steps

Learn about connectivity between Azure VMware Solution and Azure virtual networks.

> [!div class="nextstepaction"]
> [Connectivity between Azure VMware Solution and Azure virtual networks](virtual-network-connectivity.md) 
