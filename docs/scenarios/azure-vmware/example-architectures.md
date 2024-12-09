---
title: Enterprise-Scale Example Architectures Connectivity to Azure VMware Solution
description: Learn about scenarios that you can use to implement networking and connectivity for Azure VMware Solution deployments.
author: sablair
ms.author: lrivallain
ms.date: 12/10/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Example architectures for Azure VMware Solutions

When you establish an Azure VMware Solution landing zone, you must first design and implement networking capabilities. Azure networking products and services support several networking scenarios. This article describes the four most common networking scenarios. To choose an appropriate architecture and plan to structure your services, evaluate your organization's workloads, governance, and requirements.

Review the following considerations and key requirements before you choose your Azure VMware Solution deployment scenario.

- Internet ingress requirements into Azure VMware Solution applications

- Internet egress path considerations
- Network Layer-2 extension for migrations
- Network virtual appliance (NVA) usage in the current architecture
- Azure VMware Solution connectivity to either a standard hub virtual network or Azure Virtual WAN hub
- Azure ExpressRoute connectivity from on-premises datacenters to Azure VMware Solution and whether you should use ExpressRoute Global Reach
- Traffic inspection requirements for:
  - Internet ingress into Azure VMware Solution applications
  - Azure VMware Solution egress access to the internet
  - Azure VMware Solution access to on-premises datacenters
  - Azure VMware Solution access to Azure Virtual Network
  - Traffic within the Azure VMware Solution private cloud

The following table uses Azure VMware Solution traffic inspection requirements to provide recommendations and considerations for the most common networking scenarios.

| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|----------|---------------------------------|-----------------------------|----------------|
| 1        | - Internet ingress<br>- Internet egress | Use a Virtual WAN secured hub with default gateway propagation.<br><br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.<br><br> Deploy a secured Virtual WAN hub with routing intent. | Use of Global Reach is not effective for on-premises filtering, as it bypasses the Virtual WAN hubs. |
| 2        | - Internet ingress<br>- Internet egress<br>- To on-premises datacenter<br>- To Azure Virtual Network | Use third-party firewall NVA solutions in your hub virtual network with Azure Route Server.<br><br> Ensure not using Global Reach.<br><br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure. | Choose this option if you want to use your existing NVA and centralize all traffic inspection in your hub virtual network. |
| 3        | - Internet ingress <br>- Internet egress <br>- To on-premises datacenter <br>- To Azure Virtual Network <br>- Within Azure VMware Solution| Use NSX-T Data Center or a third-party NVA firewall in Azure VMware Solution. <br><br> Use Application Gateway for HTTPs, or Azure Firewall for non-HTTPs traffic. <br><br> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution. | Choose this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. <br><br> This option lets you use NSX-T native features. You can also combine this option with NVAs running on Azure VMware Solution. |
| 4       | - Internet ingress <br>- Internet egress <br>- To on-premises datacenter <br>- To Azure Virtual Network | Use third-party firewall solutions in a hub virtual network with Route Server. <br><br> For HTTP & HTTPS traffic, use Azure Application Gateway. For non-HTTP/HTTPS traffic, use a third-party firewall NVA on Azure. <br><br> Use an on-premises third-party firewall NVA. <br><br> Deploy third-party firewall solutions in a hub virtual network with Route Server. | Choose this option to advertise the `0.0.0.0/0` route from an NVA in your Azure hub virtual network to an Azure VMware Solution.|

Key points about the networking scenarios:

- All scenarios have similar ingress patterns via Application Gateway and Azure Firewall.

- You can use Layer 4 to Layer 7 load balancer solutions in Azure VMware Solution.
- You can use NSX-T Data Center Firewall for any of these scenarios.

The following sections outline architectural patterns for Azure VMware Solution private clouds. For more information, see [Azure VMware Solution networking and interconnectivity concepts](/azure/azure-vmware/concepts-networking).

## Scenario 1: Secured Virtual WAN hub with routing intent

This scenario involves the following customer profile, architectural components, and considerations.

### When to use this scenario

Use this scenario if:

- You don't require traffic inspection between Azure VMware Solution and on-premises datacenters.

- You need traffic inspection between Azure VMware Solution workloads and the internet.
- You need to secure public ingress traffic to Azure VMware Solution workloads.

Other considerations include:

- In this scenario, you can own the public IP addresses. For more information, see [Custom IP address prefix (BYOIP)](/azure/virtual-network/ip-services/custom-ip-address-prefix).

- You can add public-facing Level 4 or Level 7 inbound services if needed.
- You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.

### Overview

The following diagram provides a high-level overview of scenario 1.

:::image type="content" source="./media/eslz-overview-scenario-1.png" alt-text="Diagram that shows an overview of scenario 1 with secured Virtual WAN hub with default route propagation." lightbox="./media/eslz-overview-scenario-1.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-1.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- Azure Firewall in a secured Virtual WAN hub for firewalls

- Application Gateway for Level 7 load balancing and Web Application Firewall (WAF)
- Level 4 destination network address translation (DNAT) with Azure Firewall to translate and filter network ingress traffic
- Outbound internet via Azure Firewall in your Virtual WAN hub
- EXR, VPN, or SD-WAN for connectivity between on-premises datacenters and Azure VMware Solution

:::image type="content" source="./media/eslz-net-scenario-1.png" alt-text="Diagram that shows scenario 1 with secured Virtual WAN hub with default route propagation." lightbox="./media/eslz-net-scenario-1.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-1.vsdx) of this architecture.*

### Considerations

Azure Firewall in a secured Virtual WAN hub advertises the `0.0.0.0/0` route to Azure VMware Solution. This route is also advertised on-premises through Global Reach. You can use SD-WAN or VPN to implement an on-premises route filter to prevent `0.0.0.0/0` route learning.

Established VPN, ExpressRoute, or virtual network connections to a secure Virtual WAN hub that don't require `0.0.0.0/0` advertisement receive the advertisement anyway. To prevent this action, you can either:

- Use an on-premises edge device to filter out the `0.0.0.0/0` route.

- Disable `0.0.0.0/0` propagation on specific connections.
  1. Disconnect the ExpressRoute, VPN, or virtual network connections.
  2. Enable `0.0.0.0/0` propagation.
  3. Disable `0.0.0.0/0` propagation on those specific connections.
  4. Reconnect those connections.

You can host Azure Application Gateway on a spoke virtual network that connects to your Virtual WAN hub.

### Enable Azure VMware Solution to inspect on-premises traffic via Azure Firewall

To enable Azure VMware Solution to inspect on-premises traffic via Azure Firewall, do the following steps:

1. Remove the Global Reach connection between Azure VMware Solution and on-premises.
1. Open a support case with Microsoft Support to [enable ExpressRoute-to-ExpressRoute transit connectivity via a Firewall appliance in the hub with private routing policies](/azure/virtual-wan/how-to-routing-policies#expressroute).

## Scenario 2: Use an NVA in Azure Virtual Network to inspect all network traffic

This scenario involves the following customer profile, architectural components, and considerations.

### When to use this scenario

Use this scenario if:

- You need to use your non-Microsoft firewall NVAs in a hub virtual network to inspect all traffic, and you can't use Global Reach for geopolitical reasons or other reasons.
  - You are between on-premises datacenters and Azure VMware Solution.
  - You are between Azure Virtual Network and Azure VMware Solution.
  - You need internet ingress from Azure VMware Solution.
  - You need internet egress to Azure VMware Solution.

- You need fine-grained control over firewalls that are outside the Azure VMware Solution private cloud.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own the public IP addresses.

This scenario assumes you have ExpressRoute connectivity between on-premises datacenters and Azure.

### Overview

The following diagram provides a high-level overview of scenario 2.

:::image type="content" source="./media/eslz-overview-scenario-2.png" alt-text="Diagram that shows an overview of scenario 2 with third-party NVA in hub Azure Virtual Network inspecting all network traffic." lightbox="./media/eslz-overview-scenario-2.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-2.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- Non-Microsoft firewall NVAs that are hosted in a virtual network to provide traffic inspection and other networking functions.

- [Route Server](/azure/route-server/overview) to route traffic between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Application Gateway to provide Level 7 HTTP or HTTPS load balancing.

You must disable ExpressRoute Global Reach in this scenario. The non-Microsoft NVAs provide outbound internet access to Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-2.png" alt-text="Diagram that shows scenario 2 with third-party NVA in hub Azure Virtual Network inspecting all network traffic." lightbox="./media/eslz-net-scenario-2.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-2.vsdx) of this architecture.*

### Considerations

- Never configure ExpressRoute Global Reach for this scenario because it lets Azure VMware Solution traffic flow directly between Microsoft Enterprise Edge (MSEE) ExpressRoute routers, skipping the hub virtual network.

- You must deploy Route Server in your hub virtual network. Route Server must be Border Gateway Protocol (BGP)-peered with the NVAs in the transit virtual network. Configure Route Server to allow [branch-to-branch](/azure/route-server/quickstart-configure-route-server-portal#configure-route-exchange) connectivity.
- Use custom route tables and user-defined routes to route traffic in both directions between Azure VMware Solution and the non-Microsoft firewall NVAs' load balancer. This setup supports all high-availability modes, including active/active and active/standby, and helps ensure routing symmetry.
- If you need high availability for NVAs, see your NVA vendor documentation and [deploy highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Scenario 3: Egress from Azure VMware Solution with or without NSX-T or NVA

This scenario involves the following customer profile, architectural components, and considerations.

### When to use this scenario

Use this scenario if:

- You must use the native NSX-T Data Center platform, so you need a platform as a service (PaaS) deployment for Azure VMware Solution.

- You need a bring-your-own-license (BYOL) NVA within Azure VMware Solution for traffic inspection.
- You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.
- You need inbound HTTP, HTTPS, or Level-4 services.

All traffic from Azure VMware Solution to Azure Virtual Network, from Azure VMware Solution to the internet, and from Azure VMware Solution to on-premises datacenters gets funneled through the NSX-T Data Center Tier-0 or Tier-1 gateways or the NVAs.

### Overview

The following diagram provides a high-level overview of scenario 3.

:::image type="content" source="./media/eslz-overview-scenario-3.png" alt-text="Diagram that shows an overview of scenario 3 with egress from Azure VMware Solution with or without NSX-T Data Center or NVA." lightbox="./media/eslz-overview-scenario-3.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-3.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- An NSX distributed firewall (DFW) or an NVA behind tier-1 in Azure VMware Solution.
- Application Gateway to provide Level-7 load balancing.
- Level-4 DNAT via Azure Firewall.
- Internet breakout from Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-3.png" alt-text="Diagram that shows scenario 3 with egress from Azure VMware Solution with or without NSX-T Data Center or NVA." lightbox="./media/eslz-net-scenario-3.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-3.vsdx) of this architecture.*

### Considerations

Enable internet access on the Azure portal. For this scenario, an outbound IP address can change and isn't deterministic. Public IP addresses reside outside the NVA. The NVA in Azure VMware Solution still has private IP addresses and doesn't determine the outbound public IP address.

The NVA is BYOL. It's your responsibility to bring a license and implement high availability for the NVA.

See the VMware documentation for NVA placement options and for information about the VMware limitation of up to eight virtual network interface cards (NICs) on a VM. For more information, see [Firewall integration in Azure VMware Solution](https://techcommunity.microsoft.com/t5/azure-migration-and/firewall-integration-in-azure-vmware-solution/ba-p/2254961).

## Scenario 4: Non-Microsoft firewall solutions in a hub virtual network with Route Server

This scenario has the following customer profile, architectural components, and considerations:

### When to use this scenario

Use this scenario if:

- You want to enable Azure VMware Solution internet egress via your third-party NVA in Azure virtual network hub and you want to inspect traffic between Azure VMware Solution and Azure Virtual Network.

- You want to inspect traffic between on-premises datacenters and Azure via your on-premises non-Microsoft NVA.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own the public IPs.
- You need fine-grained control over firewalls outside the Azure VMware Solution private cloud.

### Overview

The following diagram provides a high-level overview of scenario 4.

:::image type="content" source="./media/eslz-overview-scenario-4.png" alt-text="Diagram that shows an overview of scenario 4 with a third-party NVA in the hub virtual network." lightbox="./media/eslz-overview-scenario-4.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-4.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- Non-Microsoft NVAs active-active or active-standby hosted in a virtual network for firewalls and other networking functions.

- [Route Server](/azure/route-server/overview) to exchange routes between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Non-Microsoft NVAs in your Azure Virtual Network hub to provide outbound internet to Azure VMware Solution.
- ExpressRoute for connectivity between on-premises datacenters and Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-4.png" alt-text="Diagram that shows scenario 4 with a third-party NVA in the hub virtual network." lightbox="./media/eslz-net-scenario-4.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-4.vsdx) of this architecture.*

### Considerations

- For this scenario, outbound public IP addresses reside with NVAs in the Azure virtual network.

- Non-Microsoft NVAs in the virtual network hub BGP are peered with Route Server ([ECMP](/azure/route-server/route-server-faq#if-azure-route-server-receives-the-same-route-from-more-than-one-nva-how-does-it-handle-them)) and [advertise the default route](/azure/route-server/vmware-solution-default-route)) `0.0.0.0/0` to Azure VMware Solution.
- The default route `0.0.0.0/0` is also advertised on-premises via Global Reach. Implement a route filter on-premises to prevent default route `0.0.0.0/0` learning.
- Traffic between Azure VMware Solution and your on-premises network flows through the ExpressRoute Global Reach, as described in [Peer on-premises environments to Azure VMware Solution](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud). Traffic inspection between on-premises and Azure VMware Solution is performed by your on-premises third-party NVA, not your third-party NVAs in Azure Virtual Network hub.
- You can host Application Gateway on a spoke virtual network that connects to a hub or that's on the hub virtual network.

## Next steps

- [Integrate Azure VMware Solution in a hub-and-spoke architecture](/azure/azure-vmware/concepts-hub-and-spoke).
- [Configure NSX-T Data Center network components using Azure VMware Solution](/azure/azure-vmware/configure-nsx-network-components-azure-portal#create-an-nsx-t-segment-in-the-azure-portal).
- To learn Cloud Adoption Framework enterprise-scale landing zone architectural principles, various design considerations, and best practices for Azure VMware Solution, see the next article in this series:

  > [!div class="nextstepaction"]
  > [Security, governance, and compliance disciplines for Azure VMware Solution](./eslz-security-governance-and-compliance.md)
