---
title: Azure VMware Solution Network Design Guide - Connectivity with on-premises sites
description: Learn how to design Azure VMware Solution network connectivity with on-premises sites.
author: fguerri
ms.author: fguerri
ms.date: 06/06/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase #1: Connectivity with on-premises sites
Connectivity with on-premises datacenters is the most critical design area for Azure VMware Solution networking. The key requirements that must be addressed include:
- High throughput: Migrations from on-premises vSphere environments and disaster recovery solutions require moving large volumes of data between on-premises sites and Azure VMware Solution private clouds quickly.
- Low latency: Distributed applications may require low latency for connections between Azure VMware Solution virtual machines and on-premises systems.
- Performance predictability: Mission critical applications deployed on Azure VMware Solution may require dedicated connectivity services between on-premises sites and the Microsoft network (ExpressRoute), for predictable throughput and latency.

This section describes the options supported by Azure VMware Solution for connectivity with on-premises sites: 
- [ExpressRoute Global Reach](#expressroute-global-reach)
- [IPSec VPNs](#ipsec-vpns)
- [Transit over ExpressRoute private peering](#transit-over-expressroute-private-peering)

The options are presented in order of decreasing ability to meet the key requirements listed above. An option should be discarded, and the next one considered, only if it conflicts with non-negotiable constraints that exist in a specific scenario.

:::image type="content" source="media/network-design-guide-figure6.png" alt-text="Figure 6. Flowchart that summarizes the design decision making process for connectivity to on-premises sites." lightbox="media/network-design-guide-figure6.png":::
*Design phase #1. How to select a hybrid connectivity option for Azure VMware Solution.*

## ExpressRoute Global Reach
ExpressRoute Global Reach is the default hybrid connectivity option supported by Azure VMware Solution. It provides plain layer-3 connectivity between an Azure VMware Solution private cloud and a remote site connected to a customer-managed ExpressRoute circuit, with minimal complexity. The customer-managed ExpressRoute circuit can be used to connect to Azure native services too. For security or bandwidth reservation purposes, it's possible to deploy a separate customer-managed circuit exclusively dedicated to Azure VMware Solution traffic. 

The figure shows the network topology when Global Reach is used for connectivity with on-premises sites.
 
 :::image type="content" source="media/network-design-guide-figure7.png" alt-text="Figure 7. Diagram that shows how ExpressRoute Global Reach enables connectivity to on-premises sites." lightbox="media/network-design-guide-figure7.png":::
*Hybrid connectivity with ExpressRoute Global Reach. Traffic between Azure VMware Solution private clouds and on-premises sites does not transit through Azure virtual networks.*

Detailed instructions on how to connect an Azure VMware Solution private cloud to a customer-managed ExpressRoute circuit using Global Reach are available in [the Azure VMware Solution documentation](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud).

Global Reach connectivity fully addresses the three key requirements:  
- High throughput: ExpressRoute allows connecting to the Microsoft network from your premises over dedicated lines (up to 10 Gbps for provider-based ExpressRoute, or 100 Gbps for ExpressRoute Direct). 
- Low latency: Global Reach allows routing traffic directly from the edge of the Microsoft network to the Azure VMware Solution vSphere clusters. Global Reach minimizes the number of network hops between on-premises sites and private clouds.
- Predictable performance: When using ExpressRoute Global Reach, traffic is routed over links that will not experience congestion issues (up to the maximum provisioned capacity). Therefore, the round-trip time (RTT) between virtual machines running on Azure VMware Solution and on-premises hosts remains constant over time.

Global Reach is not an option in scenarios where one or more of the following constraints apply:
  - ExpressRoute Global Reach is unavailable in the Azure region of the Azure VMware Solution private cloud and/or the meet-me location of the customer-managed ExpressRoute circuit. No workarounds exist for this limitation. Refer to the [ExpressRoute documentation](/azure/expressroute/expressroute-global-reach#availability) for up-to-date information about Global Reach availability.
  - Non-negotiable network security requirements. If a firewall device cannot be deployed at the on-premises side of the customer-managed ExpressRoute circuit, using Global Reach exposes all Azure VMware Solution network segments, including management networks (vCenter Server and NSX-T Manager), to the entire network connected to the circuit. The most typical scenario where this issue arises is customer-managed ExpressRoute circuits implemented on top of MPLS network services (also known as [ExpressRoute "any-to-any" connectivity model](/azure/expressroute/expressroute-connectivity-models)), as shown in the figure.
 
:::image type="content" source="media/network-design-guide-figure8.png" alt-text="Figure 8. Diagram that shows why ExpressRoute Global Reach may prevent traffic inspection." lightbox="media/network-design-guide-figure8.png":::
*ExpressRoute connectivity implemented on top of MPLS IPVPNs makes it impossible to deploy firewalls in a single location/facility to inspect all traffic to/from Azure VMware Solution. Typically, organizations that use MPLS networks deploy firewalls in large datacenters, not in all of their sites (which can be small branches/offices/stores).*

## IPSec VPNs
Connectivity between Azure VMware Solution private clouds and on-premises sites can be implemented by routing traffic through a "transit" virtual network in Azure. The transit network is connected to the Azure VMware Solution private cloud through the managed ExpressRoute circuit. The transit virtual network is connected to the on-premises site using an IPSec VPN, as shown in the diagram.

:::image type="content" source="media/network-design-guide-figure9.png" alt-text="Figure 9. General architecture for IPSec connectivity." lightbox="media/network-design-guide-figure9.png":::
*The IPSec VPN connectivity option covered in this section. Traffic between Azure VMware Solution private clouds and on-premises sites is routed through a transit virtual network in Azure.*

Security policies for connections between on-premises sites and the Azure VMware Solution private cloud (dashed line in the figure) can be enforced by routing traffic through a firewall, if the VPN device does not provide firewall features itself. This configuration requires [Virtual WAN with Routing Intent](/azure/virtual-wan/how-to-routing-policies), as discussed in the section [IPSec VPN design decision #2: Customer-managed virtual network vs. Virtual WAN hub](#ipsec-vpn-design-decision-2-customer-managed-virtual-network-vs-virtual-wan-hub) below.

Implementing IPSec connectivity between on-premises sites and transit virtual networks entails three design decisions:
1. Determine which network service to use as the underlay for the IPSec tunnel. The available options are internet connectivity, ExpressRoute "Microsoft" peering and ExpressRoute "private" peering.
2. Determine where to host the virtual devices that terminate the IPSec tunnel on the Azure side. The available options include customer-managed virtual networks or Virtual WAN hubs. 
3. Determine which virtual device terminates the IPSec tunnel on the Azure side. The choice of the device also determines the required Azure configuration to route traffic between the IPSec tunnel and the Azure VMware Solution managed circuit. The available options are native Azure VPN gateway or third-party IPSec NVAs.

:::image type="content" source="media/network-design-guide-figure9-1.png" alt-text="Figure 9-1. Flowchart that summarizes the design decision making process for IPSec connectivity." lightbox="media/network-design-guide-figure9-1.png":::
*Design process for IPSec connectivity.*

The criteria that drive these design decisions are covered next.

#### IPSec VPN design decision #1: Underlay network service
This guide strongly advocates considering the three available options for the VPN underlay in the order they are presented below. 

- **Internet connection**. The Public IP assigned to the VPN device hosted in the transit virtual network serves as the remote endpoint of the IPSec tunnel. Due to its low complexity and cost, internet connectivity should be always tested and assessed from a performance standpoint (achievable IPSec throughput, see the “IPSec bandwidth considerations” section). It should be dismissed only when the observed performance is too low and/or not consistent over time.

:::image type="content" source="media/network-design-guide-figure10.png" alt-text="Figure 10. Internet connection as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure10.png":::
*Internet connection as the IPSec tunnel underlay.*

- **ExpressRoute "Microsoft" peering**. It provides layer-3 connectivity to Azure public endpoints over dedicated links. Just like internet connections, it allows reaching the public IP of a VPN device hosted in the transit virtual network, which serves as the remote endpoint of the IPSec tunnel. This option should be dismissed only when the [Microsoft peering's routing requirements](/azure/expressroute/expressroute-routing#ip-addresses-used-for-microsoft-peering) cannot be met.

:::image type="content" source="media/network-design-guide-figure11.png" alt-text="Figure 11. ExpressRoute Microsoft peering as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure11.png":::
*ExpressRoute "Microsoft" peering as the IPSec tunnel underlay.*

- **ExpressRoute "private" peering**. It provides layer-3 connectivity between an on-premises site and Azure virtual networks over dedicated links. As such, it allows establishing an IPSec tunnel from the on-premises site towards the private IP address of a VPN device hosted in a virtual network. The ExpressRoute "private" peering may introduce bandwidth limitations, as the ExpressRoute Gateway is in the data path.[ExpressRoute FastPath](/azure/expressroute/about-fastpath) can be used to address this problem. The "private" peering also requires more complex routing configuration on the on-premises side. For more information, see [this article](/azure/vpn-gateway/site-to-site-vpn-private-peering?toc=%2Fazure%2Fexpressroute%2Ftoc.json).

:::image type="content" source="media/network-design-guide-figure12.png" alt-text="Figure 12. ExpressRoute private peering as the IPSec tunnel underlay." lightbox="media/network-design-guide-figure12.png":::
*ExpressRoute "private" peering as the IPSec tunnel underlay.*

#### IPSec VPN design decision #2: Customer-managed virtual network vs. Virtual WAN hub
This design decision is driven by the characteristics of the pre-existing Azure environment (if any) and by the desired trade-off between management effort and ability to tailor the configuration to specific needs. The key considerations include:
- Pre-existing Azure network infrastructure should be used for Azure VMware Solution connectivity. If a customer-managed hub-spoke network is already present in the same region as the Azure VMware Solution private cloud, then the IPSec termination devices should be deployed in the existing hub. If a hub-spoke network based on Virtual WAN is present in the same region as the Azure VMware Solution private cloud, then the Virtual WAN hub should be used for IPSec termination.
- In a customer-managed hub-spoke network, routing traffic between an IPSec tunnel and the ExpressRoute managed circuit requires deploying an [Azure Route Server instance](/azure/route-server/overview) in the hub virtual network, configured to [allow “Branch-to-branch” traffic](/azure/route-server/expressroute-vpn-support). It is not possible to route traffic between Azure VMware Solution private clouds and on-premises sites through firewall devices deployed in the virtual network.
- Virtual WAN hubs natively support routing traffic between the IPSec tunnel connected to the on-premises site and the Azure VMware Solution managed ExpressRoute circuit.
- When using Virtual WAN, [Routing Intent/Routing Policies](/azure/virtual-wan/how-to-routing-policies) can be configured for traffic inspection. Azure Firewall or third-party security solutions supported by Virtual WAN can be used. It is recommended to review regional availability and limitations for Routing Intent.

#### IPSec VPN design decision #3: IPSec termination device
The IPSec tunnel that provides connectivity to the on-premises site can be terminated by Azure VPN Gateways or by third-party NVAs. This design decision is driven by the characteristics of the pre-existing Azure environment (if any) and by the desired trade-off between management effort and ability to tailor the configuration to specific needs. The key considerations include:

- **Azure VPN Gateways**, both in customer-managed and Virtual-WAN-based hub-spoke networks, can be used to terminate IPSec tunnels connected to on-premises sites. Being platform-managed, Azure VPN Gateways require minimal management effort. Pre-existing gateways can be used even if they support other connectivity scenarios. The following documentation articles should be reviewed to understand supported settings and expected performance:
    - [VPN Gateway SKUs and expected performance levels (standalone)](/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#benchmark)
    - [VPN Gateway cryptographic requirements (standalone)](/azure/vpn-gateway/vpn-gateway-about-compliance-crypto)
    - [VPN Gateway settings (Virtual WAN)](/azure/virtual-wan/gateway-settings#s2s)
    - [VPN Gateway cryptographic requirements (Virtual WAN)](/azure/virtual-wan/virtual-wan-ipsec) 

- **Third-party NVAs** are typically used to terminate tunnels from on-premises sites in the following situations:
    - The NVA is the CPE of an SDWAN solution deployed both in Azure and the on-premises site.
    - The NVA is a firewall that enforces the required security policy for connections between the on-premises site and Azure VMware Solution.

Using third-party devices may provide more flexibility (and access to advanced network functions not supported by native VPN gateways) but increases complexity: high availability becomes the user's responsibility, multiple instances should be deployed, etc.

## Transit over ExpressRoute private peering
ExpressRoute private peering is the most common choice for connecting an on-premises site to an Azure virtual network (or hub-spoke network) in enterprise scenarios. The Azure virtual network (or the hub virtual network in hub-spoke topologies) contains an ExpressRoute Gateway, configured with a connection to the ExpressRoute circuit. This setup provides layer-3 connectivity between the virtual network (or the whole hub-spoke network) and the on-premises site's network. However, it does not natively provide layer-3 connectivity to Azure VMware Solution private clouds connected to the same virtual network (or hub virtual network, in hub-spoke networks) through a managed ExpressRoute circuit (see section ["What is the role played by ExpressRoute Global Reach"](network-design-guide-avs-networking-basics.md#what-is-the-role-played-by-expressroute-global-reach)).

By deploying more routing devices in the Azure virtual network, it is possible to overcome this limitation. and route traffic through firewall NVAs hosted in the virtual network. While this approach may seem desirable, it has complexity and performance implications. It should be considered only when ExpressRoute Global Reach and IPSec VPNs (covered in the previous sections) are not applicable.

Two implementation options exist:
- Single virtual network. When using this option, both the customer-managed and the Azure VMware Solution managed circuits are connected to the same ExpressRoute Gateway.
- Auxiliary transit virtual network. When using this option, the customer-managed ExpressRoute circuit that provides connectivity to the on-premises site is connected to the (typically pre-existing) ExpressRoute Gateway in the hub virtual network. The Azure VMware Solution managed circuit is connected to a different ExpressRoute Gateway deployed in an auxiliary transit virtual network.

The following sections provide detail on the 2 implementations options, including:
- Trade-offs between performance, cost (i.e. required Azure resources) and management overhead
- Control plane implementation (i.e. how routes are exchanged between the on-premises site and the private cloud)
- Data plane implementation (i.e. how network packets are routed between the on-premises site and the private cloud).

#### Single virtual network
In the single virtual network approach, both the Azure VMware Solution private cloud's managed circuit and the customer-owned circuit are connected to the same ExpressRoute gateway, typically the hub network. Traffic between the private cloud and the on-premises site can be routed through firewall NVAs deployed in the hub network. The single virtual network architecture is shown in the figure.

:::image type="content" source="media/network-design-guide-figure13.png" alt-text="Figure 13. Diagram that shows the single virtual network option for ExpressRoute transit." lightbox="media/network-design-guide-figure13.png":::
*The single virtual network option for ExpressRoute transit.*

The control plane and the data plane are implemented as follows.
- Control plane. ExpressRoute Gateway deployed in the Azure virtual network cannot propagate routes between the Azure VMware Solution managed and the customer-managed ExpressRoute circuits. [Azure Route Server](/azure/route-server/overview) with the [branch-to-branch setting](/azure/route-server/expressroute-vpn-support) enabled is used to inject, in both circuits, routes for supernets that include the Azure VMware Solution private cloud's address space (management networks and workload segments) and the on-premises address space. Supernets, instead of the exact prefixes that comprise those address spaces, must be announced, because the exact prefixes are already announced in the opposite direction by the Azure VMware Solution private cloud and the on-premises site. Supernets as large as RFC 1918 prefixes may be used if compatible with the network configuration of the on-premises sites. In most cases, the smallest supernets that include that include the Azure VMware Solution private cloud’s address space and the on-premises address space should be used instead. Doing so minimizes the risks of conflicts with the routing configuration of the on-premises sites. The routes for the supernets are originated by BGP-capable NVAs. The NVAs are configured to establish a BPG session with the Azure Route Server. The NVAs are only part of the control plane and do not route actual traffic between the on-premises site and the Azure VMware Solution private cloud. The control plane implementation is shown by the dashed lines in the figure above.
- Data plane. The control plane implementation described above achieves the effect of attracting to the ExpressRoute Gateway (i) traffic from the on-premises site, destined to the Azure VMware Solution private cloud; and (ii) traffic from the Azure VMware Solution private cloud, destined to the on-premises site. If no UDRs are applied to the GatewaySubnet, traffic flows directly between the on-premises site and the Azure VMware Solution private cloud. By applying UDRs to the GatewaySubnet, it is possible to route traffic to an intermediate next hop. Firewall NVAs that enforce network security policies on connections between on-premises sites and private clouds are a typical example. The control plane implementation is shown by the solid lines in the figure above. 

#### Auxiliary virtual network
An auxiliary virtual network can be used to host a second ExpressRoute gateway, only connected to the Azure VMware Solution private cloud's managed circuit. With this approach, the private cloud's managed circuit and the customer-managed circuit connect to different ExpressRoute gateways. Two Azure Route Server instances are used to announce the proper routes to each circuit, and to control route propagation between the private cloud and the on-premises site. Announcing supernets is no longer necessary (as it is the case for the single virtual network option covered in the previous section). Management overhead for UDRs in the GatewaySubnet is also reduced. This approach allows routing traffic between the private cloud and the on-premises site through firewall NVAs in the hub virtual network. The auxiliary virtual network implementation option is shown in the figure below.

:::image type="content" source="media/network-design-guide-figure14.png" alt-text="Figure 14. Diagram that shows the auxiliary virtual network implementation option." lightbox="media/network-design-guide-figure14.png":::
*The auxiliary virtual network implementation option.*

The control plane and the data plane are implemented as follows.
- Control plane. To enable route propagation between the Azure VMware Solution private cloud's managed circuit and the customer-owned circuit, an Azure Route Server instance is needed in each virtual network. As the two Azure Route Server instances [cannot establish a BGP adjacency](/azure/route-server/route-server-faq#can-i-peer-two-route-servers-in-two-peered-virtual-networks-and-enable-the-nvas-connected-to-the-route-servers-to-talk-to-each-other), BGP-capable NVAs are needed to propagate routes between them. At least two NVA instances should be deployed for high availability. More instances may be added to increase throughput. The BGP-capable NVAs must have two NICs, attached to different subnets. BGP sessions towards the two Route Servers (in the auxiliary virtual network and the hub virtual network) must be established over different NICs. Routes originated by the Azure VMware Solution private cloud and by the on-premises site are learned over ExpressRoute circuits: Their AS Path contains ASN 65515 (Azure-reserved ASN used by ExpressRoute Gateways) and ASN 12076 (Microsoft-owned ASN used by the MSEEs in all peering locations). The BGP-capable NVAs must manipulate the AS Path by removing them, to prevent routes from being dropped by BGP loop detection. More details on the required BGP configuration are provided in [this step-by-step configuration guide](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Networking/Step-By-Step-Guides/Expressroute%20connectivity%20for%20AVS%20without%20Global%20Reach). The control plane implementation is shown by the dashed lines in the figure above.
- Data plane. In the auxiliary virtual network, traffic between the Azure VMware Solution private cloud and the on-premises site is routed through the BGP-capable NVAs. Traffic to/from the Azure VMware Solution private cloud leaves/enters the NVAs through the NIC used for the BGP session with the auxiliary virtual network's Route Server. Traffic to/from the on-premises site leaves/enters the NVAs through the NIC used for the BGP session with the hub virtual network’s Route Server. This NIC is attached to subnet associated to a custom route table that (i) disables learning BGP routes from the Route Server (to avoid loops) and (ii) inserts the hub network's firewall in the datapath. To ensure that traffic is symmetrically routed via the hub firewall, UDRs for the all the prefixes used in the Azure VMware Solution private cloud must be configured on the hub's GatewaySubnet. More details are provided in [this step-by-step configuration guide](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Networking/Step-By-Step-Guides/Expressroute%20connectivity%20for%20AVS%20without%20Global%20Reach). The data plane implementation is shown by the solid lines in the figure above.


## Next Steps
Learn about connectivity between Azure VMware Solution and Azure virtual networks.

> [!div class="nextstepaction"]
> [Connectivity between Azure VMware Solution and Azure virtual networks](network-design-guide-virtualnetwork-connectivity.md) 

