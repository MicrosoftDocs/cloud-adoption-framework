---
title: Enterprise-Scale Example Architectures for Connectivity to Azure VMware Solution
description: Learn about four scenarios that you can use to implement networking and connectivity for Azure VMware Solution deployments.
author: sablair
ms.author: lrivallain
ms.date: 12/12/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Example architectures for Azure VMware Solution

When you establish an Azure VMware Solution landing zone, you must first design and implement networking capabilities. Azure networking products and services support several networking scenarios. This article describes the four most common networking scenarios.

- **Scenario 1:** A secured Virtual WAN hub that has routing intent
- **Scenario 2:** A network virtual appliance (NVA) in Azure Virtual Network inspects all network traffic
- **Scenario 3:** Outbound traffic from Azure VMware Solution with or without NSX-T or NVAs
- **Scenario 4:** Non-Microsoft firewall solutions in a hub virtual network that has Azure Route Server

To choose an appropriate architecture and plan to structure your services, evaluate your organization's workloads, governance, and requirements.

## Scenario considerations

Review the following considerations and key requirements before you choose your Azure VMware Solution deployment scenario.

- Requirements for internet traffic that enters Azure VMware Solution applications

- Path considerations for internet traffic that exits Azure VMware Solution applications
- Network L2 extension for migrations
- NVA usage in the current architecture
- Azure VMware Solution connectivity to either a standard hub virtual network or Azure Virtual WAN hub
- Azure ExpressRoute connectivity from on-premises datacenters to Azure VMware Solution
- Use of ExpressRoute Global Reach
- Traffic inspection requirements for:
  - Internet access to Azure VMware Solution applications
  - Azure VMware Solution access to the internet
  - Azure VMware Solution access to on-premises datacenters
  - Azure VMware Solution access to Virtual Network
  - Traffic within the Azure VMware Solution private cloud

The following table describes recommendations and considerations based on Azure VMware Solution traffic inspection requirements for each scenario.

| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|----------|---------------------------------|-----------------------------|----------------|
| 1        | - From the internet <br>- To the internet | Use a Virtual WAN secured hub that has default gateway propagation.<br><br> Use Azure Application Gateway for HTTP or HTTPS traffic. Use Azure Firewall for non-HTTP or HTTPS traffic. <br><br> Deploy a secured Virtual WAN hub that has routing intent. | This option uses Global Reach, which isn't effective for on-premises filtering because it bypasses the Virtual WAN hubs. |
| 2        | - From the internet<br>- To the internet<br>- To the on-premises datacenter<br>- To Virtual Network | Use non-Microsoft firewall NVA solutions in your hub virtual network that has Route Server.<br><br> Don't use Global Reach.<br><br> Use Application Gateway for HTTP or HTTPS traffic. Use a non-Microsoft firewall NVA on Azure for non-HTTP or HTTPS traffic. | Choose this option if you want to use your existing NVA and centralize all traffic inspection in your hub virtual network. |
| 3        | - From the internet <br>- To the internet <br>- To the on-premises datacenter <br>- To Virtual Network <br>- Within Azure VMware Solution| Use NSX-T Data Center or a non-Microsoft NVA firewall in Azure VMware Solution. <br><br> Use Application Gateway for HTTPS traffic. Use Azure Firewall for non-HTTPS traffic. <br><br> Deploy the secured Virtual WAN hub, and enable a public IP address in Azure VMware Solution. | Choose this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. <br><br> Use this option to take advantage of NSX-T-native features. You can also combine this option with NVAs that run on Azure VMware Solution. |
| 4       | - From the internet <br>- To the internet <br>- To the on-premises datacenter <br>- To Virtual Network | Use non-Microsoft firewall solutions in a hub virtual network that has Route Server. <br><br> Use Application Gateway for HTTP or HTTPS traffic. Use a non-Microsoft firewall NVA on Azure for non-HTTP or HTTPS traffic. <br><br> Use an on-premises non-Microsoft firewall NVA. <br><br> Deploy non-Microsoft firewall solutions in a hub virtual network that has Route Server. | Choose this option to advertise the `0.0.0.0/0` route from an NVA in your Azure hub virtual network to Azure VMware Solution.|

Consider these key points about the networking scenarios:

- All scenarios have similar ingress patterns via Application Gateway and Azure Firewall.

- You can use L4 to L7 load balancer solutions in Azure VMware Solution.
- You can use the NSX-T Distributed Firewall for any of these scenarios.

The following sections outline architectural patterns for Azure VMware Solution private clouds. For more information, see [Azure VMware Solution networking and interconnectivity concepts](/azure/azure-vmware/concepts-networking).

## Scenario 1: A secured Virtual WAN hub that has routing intent

This scenario involves the following architectural components and considerations.

### When to use this scenario

Use this scenario if:

- You don't require traffic inspection between Azure VMware Solution and on-premises datacenters.

- You require traffic inspection between Azure VMware Solution workloads and the internet.
- You need to secure public ingress traffic to Azure VMware Solution workloads.

Also consider these other factors:

- In this scenario, you can own the public IP addresses. For more information, see [Custom IP address prefix](/azure/virtual-network/ip-services/custom-ip-address-prefix).

- You can add public-facing L4 or L7 inbound services if needed.
- You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.

### Overview

The following diagram provides a high-level overview of scenario 1.

:::image type="content" source="./media/eslz-overview-scenario-1.png" alt-text="Diagram that shows an overview of scenario 1 with a secured Virtual WAN hub that has routing intent." lightbox="./media/eslz-overview-scenario-1.png" border="false":::

*Download a [PowerPoint file](https://arch-center.azureedge.net/eslz-overview-scenario-1.pptx) of this architecture.*

### Components

This scenario consists of the following components:

- Azure Firewall in a secured Virtual WAN hub for firewalls

- Application Gateway for L7 load balancing and Azure Web Application Firewall
- L4 destination network address translation (DNAT) with Azure Firewall to translate and filter network ingress traffic
- Outbound internet via Azure Firewall in your Virtual WAN hub
- EXR, VPN, or SD-WAN for connectivity between on-premises datacenters and Azure VMware Solution

:::image type="content" source="./media/eslz-net-scenario-1.png" alt-text="Diagram that shows scenario 1 with a secured Virtual WAN hub that has routing intent." lightbox="./media/eslz-net-scenario-1.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-1.vsdx) of this architecture.*

### Considerations

- Azure Firewall in a secured Virtual WAN hub advertises the `0.0.0.0/0` route to Azure VMware Solution. This route is also advertised on-premises through Global Reach. You can use SD-WAN or VPN to implement an on-premises route filter to prevent `0.0.0.0/0` route learning.

- Established VPN, ExpressRoute, or virtual network connections to a secure Virtual WAN hub that don't require `0.0.0.0/0` advertisement receive the advertisement anyway. To prevent this action, you can either:

  - Use an on-premises edge device to filter out the `0.0.0.0/0` route.

  - Disable `0.0.0.0/0` propagation on specific connections.
    1. Disconnect the ExpressRoute, VPN, or virtual network connections.
    2. Enable `0.0.0.0/0` propagation.
    3. Disable `0.0.0.0/0` propagation on those specific connections.
    4. Reconnect those connections.

- You can host Application Gateway on a spoke virtual network that connects to your Virtual WAN hub.

### Enable Azure VMware Solution to inspect on-premises traffic via Azure Firewall

To enable Azure VMware Solution to inspect on-premises traffic via Azure Firewall, do the following steps:

1. Remove the Global Reach connection between Azure VMware Solution and on-premises.
1. Open a support case with Microsoft Support to [enable ExpressRoute-to-ExpressRoute transit connectivity via an Azure Firewall appliance in the hub that's configured with private routing policies](/azure/virtual-wan/how-to-routing-policies#expressroute).

## Scenario 2: An NVA in Virtual Network inspects all network traffic

This scenario involves the following architectural components and considerations.

### When to use this scenario

Use this scenario if:

- You need to use your non-Microsoft firewall NVAs in a hub virtual network to inspect all traffic, and you can't use Global Reach for geopolitical reasons or other reasons.
  - You have connectivity between on-premises datacenters and Azure VMware Solution.
  - You have connectivity between Virtual Network and Azure VMware Solution.
  - You need internet access from Azure VMware Solution.
  - You need internet access to Azure VMware Solution.

- You need fine-grained control over firewalls that are outside the Azure VMware Solution private cloud.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own public IP addresses.

This scenario assumes that you have ExpressRoute connectivity between on-premises datacenters and Azure.

### Overview

The following diagram provides a high-level overview of scenario 2.

:::image type="content" source="./media/eslz-overview-scenario-2.png" alt-text="Diagram that shows an overview of scenario 2 with non-Microsoft NVA in hub Virtual Network inspecting all network traffic." lightbox="./media/eslz-overview-scenario-2.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-2.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- Non-Microsoft firewall NVAs that are hosted in a virtual network to provide traffic inspection and other networking functions.

- [Route Server](/azure/route-server/overview) to route traffic between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Application Gateway to provide L7 HTTP or HTTPS load balancing.

You must disable ExpressRoute Global Reach in this scenario. The non-Microsoft NVAs provide outbound internet access to Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-2.png" alt-text="Diagram that shows scenario 2 with non-Microsoft NVA in hub Virtual Network inspecting all network traffic." lightbox="./media/eslz-net-scenario-2.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-2.vsdx) of this architecture.*

### Considerations

- Don't configure ExpressRoute Global Reach for this scenario because Azure VMware Solution traffic flows directly between Microsoft Enterprise Edge (MSEE) ExpressRoute routers. The traffic skips the hub virtual network.

- Deploy Route Server in your hub virtual network. Route Server must be Border Gateway Protocol (BGP)-peered with the NVAs in the transit virtual network. Configure Route Server to allow [branch-to-branch](/azure/route-server/quickstart-configure-route-server-portal#configure-route-exchange) connectivity.
- Use custom route tables and user-defined routes to route traffic in both directions between Azure VMware Solution and the non-Microsoft firewall NVAs' load balancer. This setup supports all high-availability modes, including active/active and active/standby, and helps ensure routing symmetry.
- If you need high availability for NVAs, see your NVA vendor documentation and [deploy highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Scenario 3: Outbound traffic from Azure VMware Solution with or without NSX-T or NVAs

This scenario involves the following architectural components and considerations.

### When to use this scenario

Use this scenario if:

- You use the native NSX-T Data Center platform, so you need a platform as a service (PaaS) deployment for Azure VMware Solution.

- You need a bring-your-own-license (BYOL) NVA within Azure VMware Solution for traffic inspection.
- You need inbound HTTP, HTTPS, or L4 services.

You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure. All traffic from Azure VMware Solution to Virtual Network, from Azure VMware Solution to the internet, and from Azure VMware Solution to on-premises datacenters gets funneled through the NSX-T Data Center Tier-0 or Tier-1 gateways or the NVAs.

### Overview

The following diagram provides a high-level overview of scenario 3.

:::image type="content" source="./media/eslz-overview-scenario-3.png" alt-text="Diagram that shows an overview of scenario 3 with outbound traffic from Azure VMware Solution with or without NSX-T Data Center or NVAs." lightbox="./media/eslz-overview-scenario-3.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-3.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- An NSX distributed firewall or an NVA behind tier-1 in Azure VMware Solution.
- Application Gateway to provide L7 load balancing.
- L4 DNAT via Azure Firewall.
- Internet breakout from Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-3.png" alt-text="Diagram that shows scenario 3 with egress from Azure VMware Solution with or without NSX-T Data Center or NVA." lightbox="./media/eslz-net-scenario-3.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-3.vsdx) of this architecture.*

### Considerations

- Enable internet access in the Azure portal. For this scenario, an outbound IP address can change and isn't deterministic. Public IP addresses reside outside the NVA. The NVA in Azure VMware Solution still has private IP addresses and doesn't determine the outbound public IP address.

- The NVA is BYOL, which means that you bring a license and implement high availability for the NVA.

- See VMware documentation for NVA placement options and information about the VMware limit of eight virtual network interface cards on a virtual machine. For more information, see [Firewall integration in Azure VMware Solution](https://techcommunity.microsoft.com/t5/azure-migration-and/firewall-integration-in-azure-vmware-solution/ba-p/2254961).

## Scenario 4: Non-Microsoft firewall solutions in a hub virtual network that has Route Server

This scenario involves the following architectural components and considerations.

### When to use this scenario

Use this scenario if:

- You want to enable Azure VMware Solution internet egress via your non-Microsoft NVA in an Azure virtual network hub. And you want to inspect traffic between Azure VMware Solution and Virtual Network.

- You want to inspect traffic between on-premises datacenters and Azure via your on-premises, non-Microsoft NVA.
- You need multiple public IP addresses for inbound services and need a block of predefined IP addresses in Azure. In this scenario, you don't own public IP addresses.
- You need fine-grained control over firewalls outside the Azure VMware Solution private cloud.

### Overview

The following diagram provides a high-level overview of scenario 4.

:::image type="content" source="./media/eslz-overview-scenario-4.png" alt-text="Diagram that shows an overview of scenario 4 with a non-Microsoft NVA in the hub virtual network." lightbox="./media/eslz-overview-scenario-4.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-overview-scenario-4.vsdx) of this architecture.*

### Components

This scenario consists of the following components:

- Non-Microsoft NVAs, configured in active/active or active/standby mode, that are hosted in a virtual network to perform firewall and other networking functions.

- [Route Server](/azure/route-server/overview) to exchange routes between Azure VMware Solution, on-premises datacenters, and virtual networks.
- Non-Microsoft NVAs in your Azure virtual network hub to provide outbound internet to Azure VMware Solution.
- ExpressRoute for connectivity between on-premises datacenters and Azure VMware Solution.

:::image type="content" source="./media/eslz-net-scenario-4.png" alt-text="Diagram that shows scenario 4 with a non-Microsoft NVA in the hub virtual network." lightbox="./media/eslz-net-scenario-4.png" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/eslz-net-scenario-4.vsdx) of this architecture.*

### Considerations

- For this scenario, outbound public IP addresses are assigned to NVAs in the Azure virtual network.

- Non-Microsoft NVAs in the virtual network hub are configured to peer with Route Service via BGP and [Equal-Cost Multi-Path (ECMP)](/azure/route-server/route-server-faq#if-azure-route-server-receives-the-same-route-from-more-than-one-nva-how-does-it-handle-them) routing. These NVAs [advertise the default route](/azure/route-server/vmware-solution-default-route) `0.0.0.0/0` to Azure VMware Solution.
- The default route `0.0.0.0/0` is also advertised on-premises via Global Reach. Implement a route filter on-premises to prevent default route `0.0.0.0/0` learning.
- Traffic between Azure VMware Solution and your on-premises network flows through ExpressRoute Global Reach. For more information, see [Peer on-premises environments to Azure VMware Solution](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud). The on-premises non-Microsoft NVA performs traffic inspection between on-premises and Azure VMware Solution instead of the non-Microsoft NVAs in the Azure virtual network hub.
- You can host Application Gateway on a spoke virtual network that connects to a hub or that's on the hub virtual network.

## Next steps

- [Integrate Azure VMware Solution in a hub-and-spoke architecture](/azure/azure-vmware/concepts-hub-and-spoke)
- [Configure NSX network components using Azure VMware Solution](/azure/azure-vmware/configure-nsx-network-components-azure-portal#create-an-nsx-t-segment-in-the-azure-portal)
- To learn Cloud Adoption Framework enterprise-scale landing zone architectural principles, various design considerations, and best practices for Azure VMware Solution, see the next article in this series:

  > [!div class="nextstepaction"]
  > [Security, governance, and compliance for Azure VMware Solution](./eslz-security-governance-and-compliance.md)
