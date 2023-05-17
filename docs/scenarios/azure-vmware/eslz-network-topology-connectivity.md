---
title: Enterprise-scale network topology and connectivity for Azure VMware Solution
description: Examine key design considerations and best practices around networking and connectivity for Azure and Azure VMware Solution deployments.
author: rodrigosantosms
ms.author: martinek
ms.date: 10/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Network topology and connectivity for Azure VMware Solution

When using a VMware software-defined datacenter (SDDC) with an Azure cloud ecosystem, you have a unique set of design considerations to follow for both cloud-native and hybrid scenarios. This article provides key considerations and best practices for networking and connectivity to, from, and within Azure and [Azure VMware Solution](/azure/azure-vmware/introduction) deployments.

The article builds on several Cloud Adoption Framework [enterprise-scale landing zones](../../ready/landing-zone/design-area/network-topology-and-connectivity.md) architectural principles and recommendations for managing network topology and connectivity at scale. You can use this Azure landing zone design area guidance for mission-critical Azure VMware Solution platforms. Design areas include:

- **Hybrid integration** for connectivity between on-premises, multicloud, edge, and global users. For more information, see [Enterprise-scale support for hybrid and multicloud](../hybrid/enterprise-scale-landing-zone.md).
- **Performance and reliability at scale** for workload scalability and consistent, low-latency experience. A subsequent article covers [Dual region deployments](eslz-dual-region-network-topology.md).
- **Zero-trust-based network security** for network perimeter and traffic flow security. For more information, see [Network security strategies on Azure](/azure/architecture/framework/security/design-network).
- **Extensibility** for easy expansion of network footprints without any need for design reworks.

## General design considerations and recommendations

The following sections provide general design considerations and recommendations for Azure VMware Solution network topology and connectivity.

### Hub-spoke vs. Virtual WAN network topology

If you don't have an ExpressRoute connection from on-premises to Azure and you're instead using S2S VPN, you can use Virtual WAN to [transit connectivity between your on-premises VPN and the Azure VMware Solution ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er). If you're using a hub-spoke topology, you need Azure Route Server. For more information, see [Azure Route Server support for ExpressRoute and Azure VPN](/azure/route-server/expressroute-vpn-support).

### Private clouds and clusters

- All clusters can communicate within an Azure VMware Solution private cloud because they all share the same /22 address space.

- All clusters share the same connectivity settings, including internet, ExpressRoute, HCX, public IP, and ExpressRoute Global Reach. Application workloads can also share some basic networking settings like network segments, dynamic host configuration protocol (DHCP), and Domain Name System (DNS) settings.

- Design private clouds and clusters in advance before your deployment. The number of private clouds you require directly affects your networking requirements. Each private cloud requires its own [/22 address space for private cloud management](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-private-cloud-management) and [IP address segment for VM workloads](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads). Consider defining those address spaces in advance.

- Discuss with your VMware and networking teams how to segment and distribute your private clouds, clusters, and network segments for workloads. Plan well and avoid wasting IP addresses.

For more information about managing IP addresses for private clouds, see [Define the IP address segment for private cloud management](/azure/azure-vmware/production-ready-deployment-steps#determine-the-number-of-clusters-and-hosts).

For more information about managing IP addresses for VM workloads, see [Define the IP address segment for VM workloads](/azure/azure-vmware/production-ready-deployment-steps#define-the-ip-address-segment-for-vm-workloads).

### DNS and DHCP

For DHCP, use the DHCP service built into NSX-T Data Center, or use a local DHCP server in a private cloud. Don't route broadcast DHCP traffic over the WAN back to on-premises networks.

For DNS, depending on the scenario you adopt and your requirements, you have multiple options:

- For an Azure VMware Solution environment only, you can deploy a new DNS infrastructure in your Azure VMware Solution private cloud.
- For Azure VMware Solution connected to an on-premises environment, you can use existing DNS infrastructure. If necessary, deploy DNS forwarders to extend into Azure Virtual Network or, preferably, into Azure VMware Solution. For more information, see [Add a DNS forwarder service](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.5/administration/GUID-A0172881-BB25-4992-A499-14F9BE3BE7F2.html).
- For Azure VMware Solution connected to both on-premises and Azure environments and services, you can use existing DNS servers or DNS forwarders in your hub virtual network if available. You can also extend existing on-premises DNS infrastructure to the Azure hub virtual network. For details, see the [enterprise-scale landing zones diagram](../../ready/landing-zone/index.md).

For more information, see the following articles:

- [DHCP and DNS resolution considerations](/azure/azure-vmware/tutorial-network-checklist#dhcp-and-dns-resolution-considerations)
- [Configure DHCP for Azure VMware Solution](/azure/azure-vmware/configure-dhcp-azure-vmware-solution)
- [Configure DHCP on L2 stretched VMware HCX networks](/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks)
- [Configure a DNS forwarder in the Azure portal](/azure/azure-vmware/configure-nsx-network-components-azure-portal#configure-a-dns-forwarder-in-the-azure-portal)

### Internet

Outbound options for enabling internet and filtering and inspecting traffic include:

- Azure Virtual Network, NVA, and Azure Route Server using Azure internet access.
- On-premises default route using on-premises internet access.
- Virtual WAN secured hub with Azure Firewall or NVA, using Azure internet access.

Inbound options for delivering content and applications include:

- Azure Application Gateway with L7, Secure Sockets Layer (SSL) termination, and Web Application Firewall.
- DNAT and load balancer from on-premises.
- Azure Virtual Network, NVA, and Azure Route Server in various scenarios.
- Virtual WAN secured hub with Azure Firewall, with L4 and DNAT.
- Virtual WAN secured hub with NVA in various scenarios.

### ExpressRoute

The Azure VMware Solution out-of-the-box private cloud deployment automatically one free 10 Gbps ExpressRoute circuit. This circuit connects Azure VMware Solution to the D-MSEE.

Consider deploying Azure VMware Solution in [Azure paired regions](/azure/best-practices-availability-paired-regions) near your datacenters.

#### Global Reach

- Global Reach is a required ExpressRoute add-on for Azure VMware Solution to communicate with on-premises datacenters, Azure Virtual Network, and Virtual WAN. The alternative is to design your network connectivity with Azure Route Server.

- You can peer the Azure VMware Solution ExpressRoute circuit with other ExpressRoute circuits using Global Reach at no charge.

- You can use Global Reach for peering ExpressRoute circuits through an ISP and for ExpressRoute Direct circuits.

- Global Reach isn't supported for ExpressRoute Local circuits. For ExpressRoute Local, transit from Azure VMware Solution to on-premises datacenters via third-party NVAs in an Azure virtual network.
- Global Reach isn't available in all locations.

### Bandwidth

Choose an appropriate [virtual network gateway SKU](/azure/expressroute/expressroute-about-virtual-network-gateways) for optimal bandwidth between Azure VMware Solution and Azure Virtual Network. Azure VMware Solution supports a [maximum of four ExpressRoute circuits](/azure/azure-vmware/concepts-networking#limitations) to an ExpressRoute gateway in one region.

### Network security

Network security involves traffic inspection and port mirroring.

*East-West traffic inspection* within an SDDC uses NSX-T Data Center or NVAs to inspect traffic to Azure Virtual Network across regions.

*North-South traffic inspection* inspects bidirectional traffic flow between Azure VMware Solution and datacenters. North-south traffic inspection can use:

- A third-party firewall NVA and Azure Route Server over Azure internet.
- An on-premises default route over on-premises internet.
- Azure Firewall and Virtual WAN over Azure internet
- NSX-T Data Center within the SDDC over Azure VMware Solution internet.
- A third-party firewall NVA in Azure VMware Solution within the SDDC over Azure VMware Solution internet

### Ports and protocol requirements

Configure all necessary ports for an on-premises firewall to ensure proper access to all Azure VMware Solution private cloud components. For more information, see [Required network ports](/azure/azure-vmware/tutorial-network-checklist#required-network-ports).

### Azure VMware Solution management access

- Consider using an Azure Bastion host in Azure Virtual Network to access the Azure VMware Solution environment during deployment.

- Once you establish routing to your on-premises environment, Azure VMware Solution management network doesn't honor the `0.0.0.0/0` routes from on-premises networks, so you need to advertise more specific routes for your on-premises networks.

### Business continuity, disaster recovery (BCDR), and migrations

- In VMware HCX migrations, the default gateway remains on-premises. For more information, see [Deploy and configure VMware HCX](/azure/azure-vmware/tutorial-deploy-vmware-hcx).

- VMware HCX migrations can use HCX L2 extension. Migrations that require Layer 2 extension also require ExpressRoute. S2S VPN is supported as long as the minimum [network underlay minimum requirements](https://docs.vmware.com/en/VMware-HCX/4.2/hcx-user-guide/GUID-8128EB85-4E3F-4E0C-A32C-4F9B15DACC6D.html) are net. Maximum transmission unit (MTU) size should be 1350 to accommodate the overhead of HCX. For more information about Layer 2 extension design, see [Layer 2 bridging in manager mode (VMware.com)](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-7B21DF3D-C9DB-4C10-A32F-B16642266538.html).

## Next steps

- For more information about Azure VMware Solution in hub-and-spoke networks, see [Integrate Azure VMware Solution in a hub and spoke architecture](/azure/azure-vmware/concepts-hub-and-spoke).
- For more information on VMware NSX-T Data Center network segments, see [Configure NSX-T Data Center network components using Azure VMware Solution](/azure/azure-vmware/configure-nsx-network-components-azure-portal#create-an-nsx-t-segment-in-the-azure-portal).
- To learn Cloud Adoption Framework enterprise-scale landing zone architectural principles, various design considerations, and best practices for Azure VMware Solution, see the next article in this series:

  > [!div class="nextstepaction"]
  > [Single Region Hub & Spoke Topologies ](./networking-hubspoke.md)
