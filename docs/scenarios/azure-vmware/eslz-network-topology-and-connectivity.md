---
title: Enterprise-scale network topology and connectivity for Azure VMware Solution
description: .
author: Microsoft CAE/CSA/GBB/PG
ms.author: Microsoft CAE/CSA/GBB/PG
ms.date: 08/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network topology and connectivity for Azure VMware Solution enterprise-scale scenario

Leveraging VMWare's Software Defined Data Center with Azure's Cloud ecosystem presents a unique set of design considerations for establishing and maintaining connectivity at scale for both cloud native and hybrid scenarios. This article builds on several architecture principles and recommendations defined in the Cloud Adoption Framework [Enterprise-Scale Landing Zones (ESLZ)](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity) design area for [network topology and connectivity](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity).

Following the guidance in this article will help examine key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure and [Azure VMware Solution (AVS)](https://docs.microsoft.com/azure/azure-vmware/introduction) deployments. For mission-critical AVS platforms, leverage the guidance on the enterprise-scale design areas as the design foundations including:

**Hybrid integration** - Connectivity between on-premises, multi-cloud, edge, and global users [Enterprise-Scale support for hybrid and multicloud](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/hybrid/enterprise-scale-landing-zone)
**Performance and reliability at scale** - Consistent, low-latency experience and scalability
for workloads
**Zero-trust based network security** - Securing network perimeter and traffic flows [Network security strategies on Azure](https://docs.microsoft.com/en-us/azure/architecture/framework/security/design-network)
**Extensibility** - Ease of expanding network footprint without design rework

## Terminology used in this document

- **Azure Virtual Network (VNet):** Is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.
- **NVA:** Network Virtual Appliance: A network device used to support functions including but not limited to connectivity, application delivery, WAN optimization, and security such as Firewalls, Load balancers, etc.
- **North-South traffic inspection**: Bidirectional traffic flow to and from AVS to the Datacenter
- **East-West traffic inspection**: Traffic to Azure VNet's and cross region.
- **Virtual Extensible LAN (VXLAN)**: network virtualization technology aimed at scaling that cloud by generating a VNet to overlap a Local Access Network (LAN) leveraging Layer 3 (L3) technology to extend the network.
- **Destination Network Address Translation (DNAT):** Destination Network Address Translation for translating and filtering ingress traffic.
- **Source Network Address Translation (SNAT):** Source Network Address Translation (SNAT)for translating outbound traffic.
- **Layer 2 (L2) extension:** Taking a VLAN or network and extending that broadcast domain across two sites. It can be identified by many names including; Data Center Interconnect (DCI), Data Center Extension (DCE), Extended Layer 2 Network, Stretched Layer 2 Network, Stretched VLAN, Extended VLAN, Stretched Deploy, Layer 2 VPN.
- **Azure Virtual WAN (vWAN):** Networking service that brings many networking, security, and routing functionalities together to provide a single operational interface. These functionalities include branch connectivity (via connectivity automation from Virtual WAN Partner devices such as SD-WAN or VPN CPE), Site-to-site VPN connectivity, remote user VPN (Point-to-site) connectivity, private (ExpressRoute) connectivity, intra-cloud connectivity (transitive connectivity for VNets), VPN ExpressRoute inter-connectivity, routing, Azure Firewall, and encryption for private connectivity.
- **Azure Hub-Spoke Topology:** The hub VNet acts as a central point of connectivity to many spoke VNets. The hub can also be used as the connectivity point to your on-premises networks. The spoke VNets peer with the hub and can be used to isolate workloads.
- **Layer 4, (L4):** Refers to the fourth layer of the Open Systems Interconnection (OSI) Model. It provides the transparent transmission or transfer of data between end systems or hosts and is responsible for end-to-end error recovery, as well as flow control. Some of the main protocols used in L4 are:
  - User Datagram Protocol (UDP)
  - UDP Lite
  - Cyclic UDP (CUDP)
  - Reliable UDP (RUDP)
  - AppleTalk Transaction Protocol (ATP)
  - Multipath TCP (MTCP)
  - Transaction Control Protocol (TCP)
  - Sequenced Packet Exchange (SPX)
- **Layer 7, (L7):** Refers to the seventh and topmost layer of the OSI Model known as the application layer. Layer 7 identifies the communicating parties and the quality of service between them, considers privacy and user authentication, as well as identifies any constraints on the data syntax. This layer is wholly application-specific. API calls and responses belong to this layer, and some of main protocols used are HTTP, HTTPS and SMTP.

## Common Networking Scenarios

Designing and implementing AVS networking capabilities is critical for establishing the Landing Zone. Azure Networking Products and Services support a wide variety of networking capabilities. How these services are structured and which networking architectures chosen, depends on the organization’s workload, governance, and requirements.

These are some **key considerations** that affect your AVS deployment:

- Traffic inspection requirements (AVS to internet egress, AVS to on-premises, AVS to Azure VNet, and within AVS). These represent the first four columns of the table below.
- Internet egress path considerations.
- Internet Ingress (HTTP(s) or non-HTTP(s)) requirements into applications in AVS
- L2 extension for migrations
- Use of NVAs in the current architecture.
- AVS connectivity to a standard Hub vNet or Azure Virtual WAN Hub
- Private connectivity (ExpressRoute) used from on-premises to AVS and whether or not global reach is enabled

This section describes the four most common scenarios used in an AVS Private cloud. This is not an exhaustive list. For additional scenarios outside of the scope of this document, see [Deploy NVAs that support VXLAN with Route Server and Transit VNET](https://github.com/Azure/AzureCAT-AVS/tree/main/networking/deploy-nva-with-vxlan-in-transit-vnet-and-route-server).

![Most Common Scenarios](../_images/eslz-net-table.png)

** Ingress patterns via App GW and Azure Firewall/NVA are similar for all scenarios. L4-L7 Load Balancer NVAs can be used in AVS however is not in the scope of this document.

*** NSX-T firewall can be leveraged in conjunction with any of these scenarios.

## Scenario 1: Secured vWAN Hub with default route propagation

- **Customer Profile/Requirements**

  This scenario is ideal for customers who do not need traffic inspection between AVS and Azure VNets, and between AVS and On-Premises but do need traffic inspection between AVS workloads and Internet.

  AVS will be consumed as a PaaS offering.  Note that the customer does not own the public IPs, and if needed, public-facing L4 and L7 inbound services will need to be added.  Customers may or may not already have ExpressRoute connectivity between on-premises and Azure.  

- **Architectural Components**

  This customer profile can be achieved with Azure firewall in secured vWAN Hub for firewalling, Application Gateway for L7 load balancing, L4 DNAT using Azure firewall, outbound internet via Azure firewall in vWAN hub, ExR, VPN, or SD-WAN for connectivity between On-Prem and AVS.

  ![Scenario 1](../_images/eslz-net-scenario1.png)

- **Considerations**

  If customer does not require to receive the default route 0.0.0.0/0 advertisement from AVS, because it can conflict with their existing environment, additional actions will need to be taken.
  
  Azure firewall in secured vWAN Hub would advertise the 0.0.0.0/0 route to AVS. Note that this 0.0.0.0/0 will also get advertised to on-prem via Global Reach. Customer should implement a route filter on-premises to prevent the 0.0.0.0/0 learnt on-premises. If using SD-WAN or VPN, this issue will not come up.

  If you are currently utilizing a VNet based Hub & Spoke topology that is connected to via an Express Route VNet Gateway rather than connected to vWAN directly, you will need to consider that the default route (0.0.0.0/0) from the secure vWAN Hub will be propagated to the VNet Gateway and take precedence over the in-built Internet System-route within the VNet.   To work around this, implement a 0.0.0.0/0 [User Defined Routes](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview#default-route) in the VNets to override the learned default route.

  If there are VPN or ExpressRoute connections already established to the secure vWAN hub that do not require 0.0.0.0/0 advertisement from secure vWAN hub, those connections will also receive the 0.0.0.0/0 advertisement. To overcome that, either filter out the 0.0.0.0/0 with the on-premises edge device, or disconnect the ExpressRoute/VPN, enable 0.0.0.0/0 propagation, then disable 0.0.0.0/0 propagation on those specific connections, then re-connect those connections.

  If there are Azure VNets connected to vWAN hub those connections will receive the 0.0.0.0/0, if that is not needed disconnect those Azure VNets, enable 0.0.0.0/0 advertisement, disable 0.0.0.0/0 on those VNet connections, then re-connect the VNets.

  The Application Gateway can be hosted on a spoke VNet connected to the hub or the hub VNet.

## Scenario 2: Third-Party NVA in Azure vNET with Route Server (Global Reach disabled)

- **Customer Profile/Requirements**
  
  This scenario is ideal for customers who need fine grain control over firewalling outside of the AVS Private Cloud and need to implement a security appliance consistent with their current appliance vendor used in on-premises or other Azure environments.
  
  Customers who need multiple Public IPs for inbound services and need a block of predefined IP Addresses in Azure.  Note that the customer does not own the public IPs. Usually, public facing L4 and L7 inbound services are required for services hosted in AVS, and outbound internet connectivity is required as well. In this scenario, customers already have ExpressRoute connectivity between on-premises and Azure.

  Customer also needs to inspect traffic between AVS and on-premises or Customer cannot use Global Reach.

  Also tailored to customers who need to inspect traffic between AVS and on-premises using NVAs and cannot use Global Reach for certain geo-political restrictions.

- **Architectural Components**
  
  This Customer requirements can be achieved with 3rd party NVAs hosted in VNet for firewalling and some other networking functionalities. [Azure Route Server](https://docs.microsoft.com/azure/route-server/overview) is required to route the traffic between AVS, on-premises and VNets, and in this scenario, Azure ExpressRoute Global Reach must be disabled. The NVAs are responsible for providing Outbound internet to AVS. Application Gateway is the preferred solution for L7 HTTP(s) Load Balancing.

  ![Scenario 2](../_images/eslz-net-scenario2.png)

- **Considerations**
  
  Since all the traffic needs to be inspected in the Hub VNet, where the NVAs are hosted, customers need to disable Azure ExpressRoute Global Reach, as Global Reach would allow the traffic to/from AVS to flow directly between the MSEE and D-MSEE skipping the Hub VNet. Then the customer will need to implement the Azure Route Server to make sure the traffic is routed through the Hub. The customer is responsible for implementing and managing its NVA solution, an existing one can be used as well.

  > [!NOTE]
  > Azure Route Server is currently in public preview.
  
  If High-Availability for the NVAs is required, deploy the NVAs in an Active-Standby configuration to preserve symmetric routing. Further details can be found [here](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/dmz/nva-ha?tabs=cli) and review your NVA vendor documentation for best practices guidance.

  The architecture diagram below shows NVA with VXLAN support. For use case with NVA without VXLAN support refer the documentation [here](https://github.com/Azure/AzureCAT-AVS/tree/main/networking/deploy-non-integrated-nvas-without-vxlan-in-vwan-with-transit-vnet-and-route-server).

## Scenario 3. Egress from AVS with or without NSX-T or NVA

- **Customer Profile/Requirements**

  This scenario is ideal for customers that needs to use AVS native NSX platform (hence AVS PaaS solution) or BYOL NVA within AVS for traffic inspection. All traffic from AVS to Azure VNET, AVS to internet and AVS to on-premises is funneled through the NSX tier-0/tier-1 routers or the NVAs. Customer may or may not already have ExpressRoute connectivity between on-premises and Azure.  Customer requires inbound http(s) or L4 services.

- **Architectural Components**

  This customer profile can be leveraged with NSX DFW (Distributed firewall) or with NVA behind tier-1 in AVS, Application Gateway for L7 load balancing, L4 DNAT using Azure firewall and using internet breakout from AVS.

  ![Scenario 3](../_images/eslz-net-scenario3.png)

- **Considerations**

  The customer needs to enable internet access on the Azure Portal.  With this design, outbound IP can change and is not deterministic.  Public IPs reside outside of the NVA.  NVA in AVS would still have private IPs and would not be determine the outbound public IP.  NVA would be BYOL and it is customer's responsibility to bring a license and high availability of the NVA.
  
  Consult VMware documentation for NVA placement options available and the VMware limitation of up to 8 vNICs on a VM. Also for additional information review [this](https://techcommunity.microsoft.com/t5/azure-migration-and/firewall-integration-in-azure-vmware-solution/ba-p/2254961) blog.

## Scenario 4. Egress from AVS via on-premises (0.0.0.0/0 advertisement from on-premises)

- **Customer Profile/Requirements**

  This scenario is ideal for customer who want to use the on-premises NVA and advertises 0.0.0.0/0 from on-premises. Internet egress traffic inspection is handled on-premises. Traffic inspection between AVS and Azure vNET is done by the Azure Secured vWAN hub. Customer already has or will have ExpressRoute between on-premises and Azure and Global Reach enabled.  Public facing HTTP(s) or L4 inbound services are required.

- **Architectural Components**

  Application Gateway for L7 load balancing, L4 DNAT using Azure firewall, internet breakout on-premises and ExpressRoute for connectivity between on-premises and AVS.

  ![Scenario 4](../_images/eslz-net-scenario4.png)

- **Considerations**

  With this design the outbound Public IPs reside on-premises with the on-premises NVA.

  Customer is currently utilizing a VNET based Hub & Spoke topology that is connected to via an Express Route VNet Gateway rather than connected to vWAN directly, you will need to consider that the default route (0.0.0.0/0) from the secure vWAN Hub will be propagated to the VNet Gateway and take precedence over the in-built Internet System-route within the VNET. To work around this implement a 0.0.0.0/0 [User Defined Routes](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview#default-route) in the VNets to override the learned default route.

## General Design Considerations and Recommendations

- Private Clouds and Clusters
  - Design your Private Clouds and Clusters in advance, prior to any deployment. The number of Private Clouds impacts your networking requirements directly as each [Private Cloud requires its own /22 address space for Private Cloud management](https://docs.microsoft.com/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-private-cloud-management) and [IP address segment for VM workloads](https://docs.microsoft.com/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads). Consider defining that in advance with your VMware and Networking Teams, discuss how you will segment and prefer to distribute your Private Clouds, Clusters, Network Segments for Workloads, etc.; specially to avoid the waste of IP Addresses.
  - All Clusters can talk to each other within the same AVS Private Cloud, as they all share the same /22 Address Space.
  - Another important consideration is that all Clusters will also share the same Connectivity Settings such as: internet, ExpressRoute, HCX, Public IP, and ExpressRoute Global Reach. Application workloads can also share some basic Networking settings such as: Network Segments, DHCP, and DNS.
  - Recommended references:
    - [Define the IP address segment for private cloud management](https://docs.microsoft.com/en-us/azure/azure-vmware/production-ready-deployment-steps#determine-the-number-of-clusters-and-hosts)
    - [Define the IP address segment for VM workloads](https://docs.microsoft.com/en-us/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads)
- Bandwidth
  - Choose an adequate [Virtual Network Gateway SKUs](https://docs.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways) for optimal bandwidth between AVS to Azure Virtual Networks. Currently, AVS supports a maximum of 4 ExpressRoute circuits in one region to an ExpressRoute gateway.
- DNS and DHCP
  - DHCP: Use the DHCP service built-in to NSX or use a local DHCP server in the private cloud instead of routing broadcast DHCP traffic over the WAN back to on-premises.
  - DNS: Depending on the scenario you are adopting, and the requirements that you have, you may have different options, see the examples below according to the different connectivity options:
    - AVS environment only: Deploy a new DNS Infrastructure inside your AVS Private Cloud.
    - AVS connected to on-premises: Use existing DNS infrastructure, extending it to inside Azure VNet or AVS (preferred) if required by deploying DNS Forwarders. Recommended VMware reference: [Add a DNS Forwarder Service](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.5/administration/GUID-A0172881-BB25-4992-A499-14F9BE3BE7F2.html)
    - AVS connected to on-premises and Azure Environments and Services: Extend existing on-premises DNS infrastructure to the Azure Hub or Identity VNet (See [Enterprise Scale Landing Zones diagram](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/architecture#high-level-architecture)), or use existing DNS infrastructure if already available. They are usually DNS Servers or simply DNS Forwarders deployed in your Hub Vnet.
  - Recommended references:
    - [DHCP and DNS resolution considerations](https://docs.microsoft.com/en-us/azure/azure-vmware/tutorial-network-checklist#dhcp-and-dns-resolution-considerations)
    - [Configure DHCP for Azure VMware Solution](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-dhcp-azure-vmware-solution)
    - [Configure DHCP on L2 stretched VMware HCX networks](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks)
    - [Configure a DNS forwarder in the Azure portal](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-nsx-network-components-azure-portal#configure-a-dns-forwarder-in-the-azure-portal)
- Ports and Protocols requirements
  - It is important to ensure all necessary ports are configured if there is a firewall on-premises to ensure all different components of the AVS private cloud can be accessed properly. See [Tutorial – Network planning checklist – Azure Vmware Solution](https://docs.microsoft.com/en-us/azure/azure-vmware/tutorial-network-checklist#required-network-ports).
- Network Topology ([Hub Spoke](https://docs.microsoft.com/azure/azure-vmware/concepts-hub-and-spoke) vs vWAN)
  - For scenarios where [transit routing between Site-2Site VPN ExpressRoute](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-about#transit-er) is required, it is supported with the use of vWAN but Hub-Spoke topology is not supported.
  - Use the scenarios presented in the beginning of this document to decide which deployment model is the best for your needs.
- Internet
  - The list below is just a simple reference. Use the Decision Tree and Scenarios described in the beginning of this document to decide which deployment model is the best for your needs.
  - Outbound – Possible Options to enable internet and filter/inspect traffic:
    - Vnet + NVA + Route Server (uses Azure internet)
    - On-premises Default Route (uses on-premises internet)
    - vWAN Secured Hub with Azure Firewall or NVA (uses Azure internet)
  - Inbound – Possible Options to deliver content/applications:
    - Azure Application Gateway (L7, SSL termination, Web Application Firewall)
    - DNAT/LB via on-premises
    - VNet + NVA + Route Server (various scenarios)
    - vWAN Secured Hub with Azure Firewall (L4, DNAT)
    - vWAN Secured Hub with NVA (various scenarios)
- On-premises Networks
  - It is possible to stretch on-premises networks to AVS, see the following reference for more details: [Configure DHCP on L2 stretched Vmware HCX networks – Azure Vmware Solution](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks)
- ExpressRoute
  - Location
    - Consider deploying AVS on [paired regions](https://docs.microsoft.com/azure/best-practices-availability-paired-regions), near to your Datacenters.
  - ExpressRoute
    - If using ExpressRoute Local, customer will need to transit from AVS to on-premises via 3rd party NVAs in an Azure VNet. This is because global reach isn't supported with ExpressRoute Local circuits.
    - One ExpressRoute circuit is automatically provisioned by the AVS deployment, and it connects AVS to the D-MSEE, this circuit is free of charge and comes out-of-the-box with the AVS Private Cloud.
    - Global Reach
      - It can be used peering with, ExpressRoute circuits through an ISP, or/and ExpressRoute Direct circuits.
      - Global Reach is a required add-on in case you want AVS to communicate with on-premises and/or Azure VNets/vWAN, otherwise you will have to design your network connectivity using Azure Route Server, see the scenarios presented in the beginning of this document for more details.
      - You can peer the ExpressRoute circuit for AVS with other ExpressRoute circuits using Global Reach without charges.
      - Exceptions may apply, e.g.: Brazil, and other Locations where Global Reach is not available yet.
- VMware NSX network segments
  - [Configure NSX network components using Azure Vmware Solution – Azure Vmware Solution](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-nsx-network-components-azure-portal#create-an-nsx-t-segment-in-the-azure-portal)
- Network Security
  - Traffic Inspection
    - East / West within the SDDC (NVA vs NSX-T)
    - North / South
      - NVA + Route Server (Azure internet)
      - On-premises Default Route (on-premises internet)
      - Azure Firewall + VWAN (Azure internet)
      - NSX-T within SDDC (AVS internet)
      - NVA in AVS within SDDC (AVS internet)
  - Port Mirroring
- AVS management access
  - During the deployment, consider using a bastion host in Azure vNET to access the AVS environment.  Once the routing to the on-premises environment is established, AVS management  network does not honor the 0.0.0.0/0 routes from on-premises so you have to advertise more specific routes for the on-prem networks.
- BCDR & Migrations
  - VMware HCX – Migration
    - [Deploy and configure VMware HCX – Azure VMware Solution](https://docs.microsoft.com/en-us/azure/azure-vmware/tutorial-deploy-vmware-hcx)
    - HCX L2 extension.
    - Default gateway remains on-premises.
  - Layer-2 Extension Design
    - [Layer 2 Bridging in Manager Mode (vmware.com)](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-7B21DF3D-C9DB-4C10-A32F-B16642266538.html)
    - For migrations that require Layer 2 extension ExpressRoute is required. VPN is not supported.
    - MTU size should be 1350 to accommodate for the overhead of HCX.
