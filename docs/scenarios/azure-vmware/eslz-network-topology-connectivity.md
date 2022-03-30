---
title: Enterprise-scale network topology and connectivity for Azure VMware Solution
description: Examine key design considerations and best practices around networking and connectivity for Azure and Azure VMware Solution deployments.
author: rodrigosantosms
ms.author: janet
ms.date: 09/17/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Network topology and connectivity for Azure VMware Solution

Using the VMware software-defined datacenter (SDDC) with the Azure cloud ecosystem presents a unique set of design considerations for both cloud-native and hybrid scenarios. This article examines key considerations and best practices around networking and connectivity to, from, and within Azure and [Azure VMware Solution](/azure/azure-vmware/introduction) deployments.

The article builds on several Cloud Adoption Framework [enterprise-scale landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity) architectural principles and recommendations for managing network topology and connectivity at scale. You can use this enterprise-scale design area guidance for mission-critical Azure VMware Solution platforms. Design foundations include:

- **Hybrid integration** for connectivity between on-premises, multicloud, edge, and global users. For more information, see [Enterprise-scale support for hybrid and multicloud](/azure/cloud-adoption-framework/scenarios/hybrid/enterprise-scale-landing-zone).
- **Performance and reliability at scale** for consistent, low-latency experience and scalability for workloads.
- **Zero-trust-based network security** to secure network perimeter and traffic flows. For more information, see [Network security strategies on Azure](/azure/architecture/framework/security/design-network).
- **Extensibility** for easily expanding network footprint without design rework.

## Networking components and concepts

- **Azure Virtual Network** is the fundamental building block for private networks in Azure. With Azure Virtual Network, many types of Azure resources, such as Azure Virtual Machines (VMs), can securely communicate with each other, the internet, and on-premises datacenters. A virtual network is similar to a traditional network that you operate in your own datacenter, but has the Azure infrastructure benefits of scale, availability, and isolation.

- A **network virtual appliance (NVA)** is a network device that supports functions like connectivity, application delivery, wide-area network (WAN) optimization, and security. NVAs include Azure Firewall and Azure Load Balancer.

- **Azure Virtual WAN** is a networking service that brings many networking, security, and routing functions together in a single operational interface. These capabilities include:

  - Branch connectivity automation from Virtual WAN partner devices such as SD-WAN or customer premises equipment (CPE)-based virtual private networks (VPNs)
  - Site-to-Site VPN connectivity
  - Remote user Point-to-Site VPN connectivity
  - Private Azure ExpressRoute connectivity
  - Intracloud connectivity like transitive connectivity for virtual networks
  - VPN ExpressRoute interconnectivity
  - Routing
  - Azure Firewall
  - Encryption for private connectivity

- In **hub-spoke network topology**, a hub virtual network acts as a central point of connectivity to many spoke virtual networks. The hub can also be the connectivity point to on-premises datacenters. The spoke virtual networks peer with the hub and can be used to isolate workloads.

- **VXLAN (virtual extension LAN)** is a network virtualization technology for scaling cloud networks. VXLAN generates a virtual network to overlap a local area network (LAN) by using Layer 3 (L3) technology to extend the network.

- **Layer 2 (L2) extension** extends a virtual LAN or network broadcast domain across two sites. L2 extension has many names, such as datacenter interconnect (DCI), datacenter extension (DCE), extended Layer 2 network, stretched Layer 2 network, stretched VLAN, extended VLAN, stretched deploy, or Layer 2 VPN.

- **Layer 4 (L4)** refers to the fourth layer of the open systems interconnection (OSI) model. L4 provides transparent transmission or transfer of data between end systems or hosts. L4 is responsible for end-to-end error recovery, as well as flow control. Some of the main protocols used in L4 are:

  - Transmission Control Protocol (TCP)
  - User Datagram Protocol (UDP)
  - AppleTalk Transaction Protocol (ATP)
  - Multipath TCP (MPTCP)
  - Sequenced packet exchange (SPX)

- **Layer 7 (L7)** is the seventh and topmost layer of the OSI model, called the application layer. Layer 7 identifies the communicating parties and the quality of service between them. L7 handles privacy and user authentication, and identifies any constraints on the data syntax. This layer is wholly application-specific. API calls and responses belong to this layer. Some of the main L7 protocols are HTTP, HTTPS, and SMTP.

## Networking scenarios

Designing and implementing networking capabilities is critical for establishing the Azure VMware Solution landing zone. Azure networking products and services support a wide variety of capabilities. Which architecture to choose and how to structure services depends on your organization's workloads, governance, and requirements.

The following key requirements and considerations affect your Azure VMware Solution deployment decision:

- HTTP/S or non-HTTP/S internet ingress requirements into Azure VMware Solution applications
- Internet egress path considerations
- L2 extension for migrations
- NVA use in the current architecture
- Azure VMware Solution connectivity to a standard hub virtual network or Virtual WAN hub
- Private ExpressRoute connectivity from on-premises datacenters to Azure VMware Solution, and whether ExpressRoute Global Reach is enabled
- Traffic inspection requirements for:

  - Internet ingress into Azure VMware Solution applications
  - Azure VMware Solution egress access to the internet
  - Azure VMware Solution access to on-premises datacenters
  - Azure VMware Solution access to Azure Virtual Network
  - Traffic within the Azure VMware Solution private cloud

The following table provides recommendations and considerations for the most common networking scenarios, based on Azure VMware Solution traffic inspection requirements.

| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 1 | <li> Internet ingress <li> Internet egress | <li> Use Virtual WAN secured hub with default gateway propagation. <li> Use Azure Application Gateway for HTTP/S, or Azure Firewall for non-HTTP/S traffic. <li> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution. | This solution doesn't work for on-premises filtering. Global Reach bypasses the Virtual WAN hub. |
| 2 | <li> Internet ingress <li> Internet egress <li> To on-premises datacenter <li> To Azure Virtual Network| <li> Use third-party firewall NVA solutions in the hub virtual network with Azure Route Server. <li> Disable Global Reach. <li> Use Application Gateway for HTTP/S, or third-party firewall NVA for non-HTTP/S traffic.| This option is the most common for customers who want to use their existing NVA and centralize all traffic inspection in the hub virtual network. |
| 3 | <li> Internet ingress <li> Internet egress <li> To on-premises datacenter <li> To Azure Virtual Network <li> Within Azure VMware Solution| <li> Use NSX-T or a third-party NVA firewall in Azure VMware Solution. <li> Use Application Gateway for HTTPs, or Azure Firewall for non-HTTPs traffic. <li>  Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution.| Use this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. </br></br>This option can use NSX-T native features, or be combined with NVAs running on Azure VMware Solution between L1 and l0. |
| 4 | <li> Internet ingress <li> To Azure Virtual Network|<li> Use Virtual WAN secured hub. <li> Use Azure Application Gateway for HTTP/S, or Azure Firewall for non-HTTP/S traffic. <li> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution. | Use this option to advertise the `0.0.0.0/0` route from on-premises datacenters. |
| 5 | <li> Internet egress <li> Internet ingress <li> To on-premises datacenter <li> To Azure Virtual Network | <li> Use third-party firewall solutions in the hub virtual network with Azure Route Server. <li> Use Azure Application Gateway for HTTP/S, or third-party firewall NVA on Azure for non-HTTP/S traffic. <li> Use on-premises third-party firewall NVA. <li> Third-party firewall solutions in the hub virtual network with Azure Route Server. | Use this option to advertise the `0.0.0.0/0` route from NVA in the hub virtual network in Azure to the Azure VMware Solution.|

- Ingress patterns via Application Gateway and Azure Firewall are similar for all scenarios.
- You can use L4-L7 load balancer NVAs in Azure VMware Solution.
- You can use NSX-T firewall with any of these scenarios.

The following sections describe the four most common networking scenarios for Azure VMware Solution private clouds. This list isn't exhaustive. For more scenarios, see [AzureCAT-AVS networking](https://github.com/Azure/AzureCAT-AVS/tree/main/networking).

## Scenario 1: Secured Virtual WAN hub with default route propagation

This scenario has the following customer profile, architectural components, and considerations:

### Customer profile

This scenario is ideal if:

- You don't need traffic inspection between Azure VMware Solution and Azure Virtual Network.
- You don't need traffic inspection between Azure VMware Solution and on-premises datacenters.
- You do need traffic inspection between Azure VMware Solution workloads and the internet.

In this scenario, you consume Azure VMware Solution as a platform as a service (PaaS) offering. You don't own the public IP addresses. You have to add public-facing L4 and L7 inbound services if needed. You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.

### Architectural components

You can implement this scenario with:

- Azure Firewall in the secured Virtual WAN hub for firewalls
- Application Gateway for L7 load balancing
- L4 destination network address translation (DNAT) with Azure Firewall to translate and filter network ingress traffic
- Outbound internet via Azure Firewall in the Virtual WAN hub
- EXR, VPN, or SD-WAN for connectivity between on-premises datacenters and Azure VMware Solution

[![Diagram of secure Virtual WAN hub with default route propagation.](./media/eslz-net-scenario-1.png)](./media/eslz-net-scenario-1.png#lightbox)

### Considerations

If you don't want to receive the default route `0.0.0.0/0` advertisement from Azure VMware Solution because it conflicts with your existing environment, you need to take more action.

Azure Firewall in the secured Virtual WAN hub advertises the `0.0.0.0/0` route to Azure VMware Solution. The `0.0.0.0/0` route is also advertised on-premises via Global Reach. Implement an on-premises route filter to prevent `0.0.0.0/0` route learning. If you're using SD-WAN or VPN, this issue won't occur.

If you currently connect to a virtual network-based hub-and-spoke topology via an ExpressRoute gateway rather than directly, the default `0.0.0.0/0` route from the Virtual WAN hub propagates to the gateway and takes precedence over the internet system route built into the virtual network. To work around this issue, implement a `0.0.0.0/0` [user-defined route](/azure/virtual-network/virtual-networks-udr-overview#user-defined) in the virtual network to override the learned default route.

Established VPN, ExpressRoute, or virtual network connections to the secure Virtual WAN hub that don't require `0.0.0.0/0` advertisement will also receive the advertisement. To overcome that issue, you can either:

- Filter out the `0.0.0.0/0` route with an on-premises edge device.

- Or:
  1. Disconnect the ExpressRoute, VPN, or virtual network.
  1. Enable `0.0.0.0/0` propagation.
  1. Disable `0.0.0.0/0` propagation on those specific connections.
  1. Reconnect those connections.

You can host Application Gateway on a spoke virtual network connected to the hub or on the hub virtual network.

## Scenario 2: Third-party NVA in hub Azure Virtual Network inspecting all network traffic

This scenario has the following customer profile, architectural components, and considerations:

### Customer profile

This scenario is ideal if:

- You need to use your third-party firewall NVAs in the hub virtual network to inspect all traffic and you can't use Global Reach for geopolitical or other reasons.
  - Between on-premises datacenters and Azure VMware Solution.
  - Between Azure Virtual Network and Azure VMware Solution.
  - Internet egress from Azure VMware Solution
  - Internet ingress to Azure VMware Solution
- You need fine-grained control over firewalls outside of the Azure VMware Solution private cloud.
- You need multiple public IP addresses for inbound services, and need a block of predefined IP addresses in Azure. In this scenario, you don't own the public IPs.

In this scenario, you already have ExpressRoute connectivity between on-premises datacenters and Azure.

### Architectural components

You can implement this scenario with:

- Third-party firewall NVAs hosted in a virtual network for traffic inspection and other networking functions.
- [Azure Route Server](/azure/route-server/overview) to route the traffic between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Application Gateway as the preferred solution for L7 HTTP/S load balancing.

In this scenario, you must disable ExpressRoute Global Reach. The NVAs are responsible for providing outbound internet to Azure VMware Solution.

[![Diagram of egress through a third-party NVA in Azure Virtual Network with Azure Route Server Global Reach enabled.](./media/eslz-net-scenario-2.png)](./media/eslz-net-scenario-2.png#lightbox)

### Considerations

- ExpressRoute Global Reach must not be configured, because it would let Azure VMware Solution traffic flow directly between the Microsoft Enterprise Edge (MSEE) ExpressRoute routers, skipping the hub virtual network.
- Azure Route Server must be deployed in the hub VNet and BGP-peered with the NVAs in the transit VNet. Azure Route Server must be configured to allow "[branch-to-branch](/azure/route-server/quickstart-configure-route-server-portal#configure-route-exchange)" connectivity.
- In this scenario, custom route tables and user-defined routes are used to route traffic to/from Azure VMware Solution to the third-party firewall NVAs' load balancer. All HA modes (active/active and active/standby) are supported, with guaranteed routing symmetry.
- If you need high availability for the NVAs, consult your NVA vendor documentation and [deploy highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha?tabs=cli).

## Scenario 3: Egress from Azure VMware Solution with or without NSX-T or NVA

This scenario has the following customer profile, architectural components, and considerations:

### Customer profile

This scenario is ideal if:

- You must use the native NSX platform, so you need a PaaS deployment for Azure VMware Solution.
- Or, you need a bring-your-own-license (BYOL) NVA within Azure VMware Solution for traffic inspection.
- You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.
- You need inbound HTTP/S or L4 services.

All traffic from Azure VMware Solution to Azure Virtual Network, Azure VMware Solution to the internet, and Azure VMware Solution to on-premises datacenters funnels through the NSX tier-0/tier-1 routers or the NVAs.

### Architectural components

You can implement this scenario with:

- NSX distributed firewall (dfw), or NVA behind tier-1 in Azure VMware Solution
- Application Gateway for L7 load balancing
- L4 DNAT using Azure Firewall
- Internet breakout from Azure VMware Solution

[![Diagram of egress from Azure V M ware Solution through N S X - T and N V A.](./media/eslz-net-scenario-3.png)](./media/eslz-net-scenario-3.png#lightbox)

### Considerations

You need to enable internet access on the Azure portal. With this design, the outbound IP address can change and isn't deterministic. Public IP addresses reside outside the NVA. The NVA in Azure VMware Solution still has private IP addresses, and doesn't determine the outbound public IP address.

The NVA is BYOL, and it's your responsibility to bring the license and implement high availability for the NVA.

See the VMware documentation for NVA placement options, and for information about the VMware limitation of up to eight virtual network interface cards (NICs) on a VM. For more information, see [Firewall integration in Azure V M ware Solution](https://techcommunity.microsoft.com/t5/azure-migration-and/firewall-integration-in-azure-vmware-solution/ba-p/2254961).

## Scenario 4: Egress from Azure VMware Solution via `0.0.0.0/0` advertisement from on-premises

This scenario has the following customer profile, architectural components, and considerations:

### Customer profile

This scenario is ideal if:

- You want to use the on-premises NVA and advertise `0.0.0.0/0` from the on-premises environment.
- You already have or will have ExpressRoute between on-premises datacenters and Azure, with Global Reach enabled.
- You need public-facing HTTP/S or L4 inbound services.

Internet egress traffic inspection is handled on-premises. The secured Azure Virtual WAN hub does the traffic inspection between Azure VMware Solution and Azure Virtual Network.

### Architectural components

You can implement this scenario with:

- Application Gateway for L7 load balancing
- L4 DNAT using Azure Firewall
- Internet breakout on-premises
- ExpressRoute for connectivity between on-premises datacenters and Azure VMware Solution

[![Diagram of egress from Azure V M ware Solution via on-premises.](./media/eslz-net-scenario-4.png)](./media/eslz-net-scenario-4.png#lightbox)

### Considerations

With this design, the outbound public IP addresses reside on-premises with the on-premises NVA.

If you currently connect to a virtual network-based hub-and-spoke topology via an ExpressRoute gateway rather than directly, the default `0.0.0.0/0` route from the Virtual WAN hub propagates to the gateway and takes precedence over the internet system route built into the virtual network. To work around this issue, implement a `0.0.0.0/0` [user-defined route](/azure/virtual-network/virtual-networks-udr-overview#user-defined) in the virtual network to override the learned default route.

## Scenario 5: Third-party NVA in the Hub Vnet inspecting traffic between AVS and Internet, and between AVS and Azure VNets

This scenario has the following customer profile, architectural components, and considerations:

### Customer profile

This scenario is ideal if:

- You want Azure VMware Solution internet egress using your third-party NVA in Azure VNet hub and inspect traffic between Azure VMware Solution and Azure Virtual Network.
- You want to inspect traffic between on-premises datacenters and Azure using your on-premises third-party NVA.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own the public IPs.
- You need fine-grained control over firewalls outside of the Azure VMware Solution private cloud.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own the public IPs.

### Architectural components

You can implement this scenario with:

- Third-party NVAs active-active or active-standby hosted in a VNet for firewalls and other networking functions.
- [Azure Route Server](/azure/route-server/overview) to exchange routes between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Your third-party NVAs in your Azure Virtual Network hub are responsible for providing outbound internet to Azure VMware Solution.
- ExpressRoute for connectivity between on-premises datacenters and Azure VMware Solution

[![Diagram of egress from Azure V M ware Solution via on-premises.](./media/eslz-net-scenario-5.png)](./media/eslz-net-scenario-5.png#lightbox)

### Considerations

- With this design, the outbound public IP addresses reside with the NVAs in the Azure VNet.
- The third-party NVAs in the virtual network hub BGP are peered with Azure Route Server ([ECMP](/azure/route-server/route-server-faq#if-azure-route-server-receives-the-same-route-from-more-than-one-nva-how-does-it-handle-them)) and [advertises the default route](/azure/route-server/vmware-solution-default-route)) `0.0.0.0/0` to Azure VMware Solution.
- The default route `0.0.0.0/0` is also advertised on-premises via Global Reach, therefore, implement a route filter on-premises to prevent default route `0.0.0.0/0` learning.
- Traffic between Azure VMware Solution and the on-premises network will flow over the ExpressRoute Global Reach, as described in [Peer on-premises environments to Azure VMware Solution](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud), therefore traffic inspection between on-premises and Azure VMware Solution is performed by your on-premises third-party NVA not and your third-party NVAs in Azure Virtual Network hub.
- You can host Application Gateway on a spoke virtual network connected to the hub or on the hub virtual network.

## General design considerations and recommendations

Here are some general design considerations and recommendations for Azure VMware Solution network topology and connectivity:

### Hub-spoke vs. Virtual WAN network topology

If you do not have an ExpressRoute connection from on-premises to Azure and you are using S2S VPN instead, you can use Virtual WAN to [transit connectivity between your on-premises VPN and the Azure VMware Solution ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er). With a hub-spoke topology you will require Azure Route Server, see [About Azure Route Server support for ExpressRoute and Azure VPN](/azure/route-server/expressroute-vpn-support).

### Private clouds and clusters

- All clusters can communicate within an Azure VMware Solution private cloud, because they all share the same /22 address space.

- All clusters also share the same connectivity settings, such as internet, ExpressRoute, HCX, public IP, and ExpressRoute Global Reach. Application workloads can also share some basic networking settings like network segments, dynamic host configuration protocol (DHCP), and Domain Name System (DNS).

- Design your private clouds and clusters in advance, before deployment. The number of private clouds impacts your networking requirements directly. Each private cloud requires its own [/22 address space for private cloud management](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-private-cloud-management) and [IP address segment for VM workloads](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads). Consider defining those address spaces in advance.

- Discuss with your VMware and networking teams how to segment and distribute your private clouds, clusters, and network segments for workloads. Plan accordingly to avoid wasting IP addresses.

- For more information about managing IP addresses for private clouds, see [Define the IP address segment for private cloud management](/azure/azure-vmware/production-ready-deployment-steps#determine-the-number-of-clusters-and-hosts).

- For more information about managing IP addresses for VM workloads, see [Define the IP address segment for VM workloads](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads).

### DNS and DHCP

For DHCP, use the DHCP service built into NSX, or use a local DHCP server in the private cloud. Don't route broadcast DHCP traffic over the WAN back to on-premises networks.

For DNS, depending on the scenario you adopt and your requirements, you have different options:

- For an Azure VMware Solution environment only, deploy a new DNS infrastructure in your Azure VMware Solution private cloud.
- For Azure VMware Solution connected to an on-premises environment, use existing DNS infrastructure. If necessary, deploy DNS forwarders to extend into Azure Virtual Network or, preferably, into Azure VMware Solution. For more information, see [Add a DNS forwarder service](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.5/administration/GUID-A0172881-BB25-4992-A499-14F9BE3BE7F2.html).
- For Azure VMware Solution connected to both on-premises and Azure environments and services, use existing DNS servers or DNS forwarders in your hub virtual network if available. Or, you can extend existing on-premises DNS infrastructure to the Azure hub virtual network. For details, see the [enterprise-scale landing zones diagram](/azure/cloud-adoption-framework/ready/enterprise-scale/architecture#high-level-architecture).

For more information, see:

- [DHCP and DNS resolution considerations](/azure/azure-vmware/tutorial-network-checklist#dhcp-and-dns-resolution-considerations)
- [Configure DHCP for Azure VMware Solution](/azure/azure-vmware/configure-dhcp-azure-vmware-solution)
- [Configure DHCP on L2 stretched VMware HCX networks](/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks)
- [Configure a DNS forwarder in the Azure portal](/azure/azure-vmware/configure-nsx-network-components-azure-portal#configure-a-dns-forwarder-in-the-azure-portal)

### Internet

The following list is a quick reference:

Outbound options to enable internet and filter and inspect traffic include:

- Azure Virtual Network, NVA, and Azure Route Server using Azure internet access
- On-premises default route using on-premises internet access
- Virtual WAN secured hub with Azure Firewall or NVA, using Azure internet access

Inbound options to deliver content and applications include:

- Azure Application Gateway with L7, Secure Sockets Layer (SSL) termination, and Web Application Firewall
- DNAT and load balancer via on-premises
- Azure Virtual Network, NVA, and Azure Route Server in various scenarios
- Virtual WAN secured hub with Azure Firewall, with L4 and DNAT
- Virtual WAN secured hub with NVA in various scenarios

### ExpressRoute

The Azure VMware Solution out-of-the-box private cloud deployment automatically provisions one free 10 Gbps ExpressRoute circuit. This circuit connects Azure VMware Solution to the D-MSEE.

For location, consider deploying Azure VMware Solution on [Azure paired regions](/azure/best-practices-availability-paired-regions) near your datacenters.

#### Global Reach

- Global Reach is a required ExpressRoute add-on for Azure VMware Solution to communicate with on-premises datacenters, Azure Virtual Network, and Virtual WAN. The alternative is to design your network connectivity with Azure Route Server.

- You can peer the Azure VMware Solution ExpressRoute circuit with other ExpressRoute circuits using Global Reach at no charge.

- You can use Global Reach for peering ExpressRoute circuits through an isp, and for ExpressRoute Direct circuits.

- Global Reach isn't supported for ExpressRoute Local circuits. For ExpressRoute Local, transit from Azure VMware Solution to on-premises datacenters via third-party NVAs in an Azure virtual network.
- Global Reach isn't available in all locations.

### Bandwidth

Choose an appropriate [virtual network gateway SKU](/azure/expressroute/expressroute-about-virtual-network-gateways) for optimal bandwidth between Azure VMware Solution and Azure Virtual Network. Azure VMware Solution supports a [maximum of four ExpressRoute circuits](/azure/azure-vmware/concepts-networking#limitations) to an ExpressRoute gateway in one region.

### Network security

Network security uses traffic inspection and port mirroring.

*East-West traffic inspection* within the SDDC uses NSX-T or NVAs to inspect traffic to Azure Virtual Network across regions.

*North-South traffic inspection* inspects bidirectional traffic flow between Azure VMware Solution and datacenters. North-south traffic inspection can use:

- Third-party firewall NVA and Azure Route Server over Azure internet
- On-premises default route over on-premises internet
- Azure Firewall and Virtual WAN over Azure internet
- NSX-T within the SDDC over Azure VMware Solution internet
- Third-party firewall NVA in Azure VMware Solution within the SDDC over Azure VMware Solution internet

### Ports and protocols requirements

Configure all necessary ports for an on-premises firewall to ensure proper access to all components of the Azure VMware Solution private cloud. For more information, see [Required network ports](/azure/azure-vmware/tutorial-network-checklist#required-network-ports).

### Azure VMware Solution management access

- During deployment, consider using an Azure Bastion host in Azure Virtual Network to access the Azure VMware Solution environment.

- Once the routing to the on-premises environment is established, Azure VMware Solution management network doesn't honor the `0.0.0.0/0` routes from on-premises networks, so you have to advertise more specific routes for the on-premises networks.

### Business continuity, disaster recovery (BCDR) and migrations

- With VMware HCX migrations, the default gateway remains on-premises. For more information, see [Deploy and configure VMware HCX](/azure/azure-vmware/tutorial-deploy-vmware-hcx).

- VMware HCX migration can use HCX L2 extension. Migrations that require Layer 2 extension require ExpressRoute. S2S VPN is supported as long as the minimum [network underlay minimum requirements](https://docs.vmware.com/en/VMware-HCX/4.2/hcx-user-guide/GUID-8128EB85-4E3F-4E0C-A32C-4F9B15DACC6D.html) are net. Maximum transmission unit (MTU) size should be 1350 to accommodate the overhead of HCX. For more information about Layer 2 extension design, see [Layer 2 bridging in manager mode (VMware.com)](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-7B21DF3D-C9DB-4C10-A32F-B16642266538.html).

## Next steps

- For more information about Azure VMware Solution in hub-and-spoke networks, see [Integrate Azure VMware Solution in a hub and spoke architecture](/azure/azure-vmware/concepts-hub-and-spoke).
- For more information on VMware NSX network segments, see [Configure NSX network components using Azure VMware Solution](/azure/azure-vmware/configure-nsx-network-components-azure-portal#create-an-nsx-t-segment-in-the-azure-portal).
- To continue learning about the Cloud Adoption Framework enterprise-scale landing zone architectural principles, design considerations, and best practices for Azure VMware Solution, see the next article in the series:

  > [!div class="nextstepaction"]
  > [Security, governance, and compliance disciplines for Azure VMware Solution](eslz-security-governance-and-compliance.md)
