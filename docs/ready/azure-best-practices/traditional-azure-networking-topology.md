---
title: Traditional Azure networking topology
description: Learn about key design considerations and recommendations surrounding traditional network topologies in Microsoft Azure to ensure robust and efficient connectivity across virtual networks.
author: jtracey93
ms.author: jatracey
ms.date: 08/25/2025
ms.topic: concept-article
ms.custom: think-tank
---

# Traditional Azure networking topology

> [!IMPORTANT]
> Try the [topology](/azure/network-watcher/network-insights-topology) experience, which offers a visualization of Azure resources for ease of inventory management and monitoring networks at scale. Use the topology feature to visualize resources and their dependencies across subscriptions, regions, and locations.

This article describes key design considerations and recommendations for network topologies in Microsoft Azure. The following diagram shows a traditional Azure network topology:

:::image type="content" source="./media/customer-managed-topology.png" alt-text="Diagram that illustrates a traditional Azure network topology." lightbox="./media/customer-managed-topology.png" border="false":::

## Design considerations

- Various network topologies can connect multiple landing zone virtual networks. Examples of network topologies include hub-and-spoke, full-mesh, and hybrid topologies. You can also have multiple virtual networks that are connected via multiple Azure ExpressRoute circuits or connections.

- Virtual networks can't traverse subscription boundaries. However, you can use virtual network peering, an ExpressRoute circuit, or VPN gateways to achieve connectivity between virtual networks across different subscriptions.

- Virtual network peering is the preferred method to connect virtual networks in Azure. You can use virtual network peering to connect virtual networks in the same region, across different Azure regions, and across different Microsoft Entra tenants.

- Virtual network peering and global virtual network peering aren't transitive. To enable a transit network, you need user-defined routes (UDRs) and network virtual appliances (NVAs). For more information, see [Hub-spoke network topology in Azure](/azure/architecture/networking/architecture/hub-spoke).

- You can share an Azure DDoS Protection plan across all virtual networks in a single Microsoft Entra tenant to protect resources with public IP addresses. For more information, see [DDoS Protection](/azure/ddos-protection/ddos-protection-overview).

  - DDoS Protection plans cover only resources with public IP addresses.

  - The cost of a DDoS Protection plan includes 100 public IP addresses across protected virtual networks that are associated with the DDoS Protection plan. Protection for more resources costs more. For more information, see [DDoS Protection pricing](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work-).

  - Review the [supported resources of DDoS Protection plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types-).

- You can use ExpressRoute circuits to establish connectivity across virtual networks within the same geopolitical region or use the premium add-on for connectivity across geopolitical regions. Keep these points in mind:

  - Network-to-network traffic might experience more latency, because traffic must hairpin at the Microsoft Enterprise edge (MSEE) routers.

  - The ExpressRoute gateway SKU constrains bandwidth.

  - Deploy and manage UDRs if you need to inspect or log UDRs for traffic across virtual networks.

- VPN gateways with Border Gateway Protocol (BGP) are transitive within Azure and on-premises networks, but they don't provide transitive access to networks connected through ExpressRoute by default. If you need transitive access to networks connected through ExpressRoute, consider [Azure Route Server](/azure/route-server/overview).

- When you connect multiple ExpressRoute circuits to the same virtual network, use connection weights and BGP techniques to ensure an optimal path for traffic between on-premises networks and Azure. For more information, see [Optimize ExpressRoute routing](/azure/expressroute/expressroute-optimize-routing).

If you use BGP metrics to influence ExpressRoute routing, you need to change the configuration outside of the Azure platform. Your organization or your connectivity provider must configure the on-premises routers accordingly.

- ExpressRoute circuits with premium add-ons provide global connectivity.

- ExpressRoute has certain limits, including a maximum number of ExpressRoute connections for each ExpressRoute gateway. And ExpressRoute private peering has a maximum limit for the number of routes that it can identify from Azure to on-premises. For more information, see [ExpressRoute limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#expressroute-limits).

- A VPN gateway's maximum aggregated throughput is 10 gigabits per second. A VPN gateway supports up to 100 site-to-site or network-to-network tunnels.

- If an NVA is part of the architecture, consider Route Server to simplify dynamic routing between your NVA and your virtual network. Use Route Server to exchange routing information directly through BGP between any NVA that supports BGP and the Azure software-defined network (SDN) in the Azure virtual network. You don't need to manually configure or maintain route tables with this approach.

## Design recommendations

- Consider a network design based on the traditional hub-and-spoke network topology for the following scenarios:

  - A network architecture deployed within a single Azure region.
  
  - A network architecture that spans multiple Azure regions, with no need for transitive connectivity between virtual networks for landing zones across regions.

  - A network architecture that spans multiple Azure regions, and global virtual network peering that can connect virtual networks across Azure regions.

  - There's no need for transitive connectivity between VPN and ExpressRoute connections.

  - The main hybrid connectivity method in place is ExpressRoute, and the number of VPN connections is less than 100 per VPN gateway.

  - There's a dependency on centralized NVAs and granular routing.

- For regional deployments, primarily use the hub-and-spoke topology with a regional hub for each spoke Azure region. Use application landing zone virtual networks that use virtual network peering to connect to a regional central hub virtual network for the following scenarios:

  - Cross-premises connectivity through ExpressRoute that's enabled in two different peering locations. For more information, see [Design and architect ExpressRoute for resiliency](/azure/expressroute/design-architecture-for-resiliency).

  - A VPN for branch connectivity.

  - Spoke-to-spoke connectivity through NVAs and UDRs.

  - Internet-outbound protection through Azure Firewall or another non-Microsoft NVA.

- The following diagram shows the hub-and-spoke topology. Use this configuration to ensure appropriate traffic control and to meet most requirements for segmentation and inspection.

   :::image type="content" source="./media/hub-and-spoke-topology.png" alt-text="Diagram that illustrates a hub-and-spoke network topology." lightbox="./media/hub-and-spoke-topology.png" border="false":::

- Use the topology that has multiple virtual networks that are connected via multiple ExpressRoute circuits at different peering locations if:

  - You need a high level of isolation. For more information, see [Design and architect ExpressRoute for resiliency](/azure/expressroute/design-architecture-for-resiliency).

  - You need dedicated ExpressRoute bandwidth for specific business units.

  - You reach the maximum number of connections for each ExpressRoute gateway. To determine the maximum number, see [ExpressRoute limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#expressroute-limits).

- The following diagram shows this topology.

   :::image type="content" source="./media/vnet-multiple-circuits.png" alt-text="Diagram that illustrates multiple virtual networks connected with multiple ExpressRoute circuits." lightbox="./media/vnet-multiple-circuits.png" border="false":::

- For dual-homed peering within the same city, consider [ExpressRoute Metro](/azure/expressroute/metro).

- Deploy Azure Firewall or partner NVAs in the central-hub virtual network for east/west or south/north traffic protection and filtering.

- Deploy a set of minimal shared services, including ExpressRoute gateways, VPN gateways (as required), and Azure Firewall or partner NVAs (as required) in the central-hub virtual network. If necessary, also deploy Active Directory domain controllers and DNS servers.

- Deploy a single DDoS Protection standard plan in the connectivity subscription. Use this plan for all landing zone and platform virtual networks.

- Use your existing network, multiprotocol label switching (MPLS), and SD-WAN to connect branch locations with corporate headquarters. If you don't use Route Server, then you don't have support for transit in Azure between ExpressRoute connections and VPN gateways.

- Deploy Azure Firewall or partner NVAs for east/west or south/north traffic protection and filtering, in the central-hub virtual network.

- When you deploy partner networking technologies or NVAs, follow the partner vendor's guidance to ensure that:

  - The vendor supports deployment.

  - The guidance supports high availability and maximum performance.

  - There are no conflicting configurations with Azure networking.

- Don't deploy Layer 7 inbound NVAs, such as Azure Application Gateway, as a shared service in the central-hub virtual network. Instead, deploy them together with the application in their respective landing zones.

- Deploy a single DDoS standard protection plan in the connectivity subscription.

  - All landing zone and platform virtual networks should use this plan.

- Use your existing network, multiprotocol label switching, and SD-WAN to connect branch locations with corporate headquarters. If you don't use Route Server, then there's no support for transit in Azure between ExpressRoute and VPN gateways.

- If you need transitivity between ExpressRoute and VPN gateways in a hub-and-spoke scenario, use Route Server. For more information, see [Route Server support for ExpressRoute and Azure VPN](/azure/route-server/expressroute-vpn-support).

    :::image type="content" source="./media/route-server-transitivity.png" alt-text="Diagram that illustrates transitivity between ER and VPN gateways with Route Server." lightbox="./media/route-server-transitivity.png" border="false":::

- When you have hub-and-spoke networks in multiple Azure regions, and you need to connect a few landing zones across regions, use global virtual network peering. You can directly connect landing zone virtual networks that need to route traffic to each other. Depending on the communicating virtual machine's SKU, global virtual network peering can provide high network throughput. Traffic that goes between directly peered landing zone virtual networks bypasses NVAs within hub virtual networks. Limitations on global virtual network peering apply to the traffic.

- When you have hub-and-spoke networks in multiple Azure regions, and you need to connect most landing zones across regions, use hub NVAs to connect hub virtual networks in each region to each other and to route traffic across regions. You can also use this approach if you can't use direct peering to bypass hub NVAs because of incompatibility with your security requirements. Global virtual network peering or ExpressRoute circuits can help to connect hub virtual networks in the following ways:

  - Global virtual network peering provides a low latency and high throughput connection but generates [traffic fees](/azure/virtual-network/virtual-network-peering-overview#pricing).

  - If you route through ExpressRoute, you might increase latency due to the MSEE hairpin. The selected [ExpressRoute gateway SKU](/azure/expressroute/expressroute-about-virtual-network-gateways#gwsku) limits the throughput.
  
The following diagram shows options for hub-to-hub connectivity:

  :::image type="content" source="./media/hub-to-hub-er-or-peering.png" alt-text="Diagram that illustrates options for hub-to-hub connectivity." lightbox="./media/hub-to-hub-er-or-peering.png" border="false":::  

- When you need to connect two Azure regions, use global virtual network peering to connect the hub virtual networks in each region.

- Use a managed global transit network architecture that's based on [Azure Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md) if your organization:

  - Requires hub-and-spoke network architectures across more than two Azure regions.

  - Requires global transit connectivity between landing zone virtual networks across Azure regions.

  - Wants to minimize network management overhead.

- When you need to connect more than two Azure regions, then we recommend that the hub virtual networks in each region connect to the same ExpressRoute circuits. Global virtual network peering requires you to manage a large number of peering relationships and a complex set of UDRs across multiple virtual networks. The following diagram shows how to connect hub-and-spoke networks in three regions:

  :::image type="content" source="./media/multiregion-hub-to-hub-er.png" alt-text="Diagram that illustrates ExpressRoute providing hub-to-hub connectivity between multiple regions." lightbox="./media/multiregion-hub-to-hub-er.png" border="false":::

- When you use ExpressRoute circuits for cross-region connectivity, spokes in different regions communicate directly and bypass the firewall because they learn through BGP routes to the spokes of the remote hub. If you need the firewall NVAs in the hub virtual networks to inspect traffic across spokes, you must implement one of these options:

  - Create more specific route entries in the spoke UDRs for the firewall in the local hub virtual network to redirect traffic across hubs.

  - To simplify route configuration, [disable BGP propagation](/azure/virtual-network/virtual-networks-udr-overview#border-gateway-protocol) on the spoke route tables.

- When your organization requires hub-and-spoke network architectures across more than two Azure regions and global transit connectivity between landing zone virtual networks across Azure regions, and you want to minimize network management overhead, we recommend a managed global transit network architecture that's based on [Virtual WAN](./virtual-wan-network-topology.md).

- Deploy each region's hub network resources into separate resource groups, and sort them into each deployed region.

- Use [Azure Virtual Network Manager](/azure/virtual-network-manager/overview) to manage connectivity and security configuration of virtual networks globally across subscriptions.

- Use [Network Watcher network insights](/azure/network-watcher/network-insights-overview) to monitor the end-to-end state of your networks on Azure.

- You must consider the following two [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) when you connect spoke virtual networks to the central hub virtual network:

  - The maximum number of virtual network peering connections per virtual network.
  
  - The maximum number of prefixes that ExpressRoute with private peering advertises from Azure to on-premises.

  - Ensure that the number of spoke virtual networks connected to the hub virtual network doesn't exceed these limits.

## Next step

> [!div class="nextstepaction"]
> [Virtual WAN network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/virtual-wan-network-topology)