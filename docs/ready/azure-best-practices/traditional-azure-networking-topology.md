---
title: Traditional Azure networking topology
description: Understand key design considerations and recommendations surrounding network topologies in Azure.
author: sitarant
ms.author: sitarant
ms.date: 08/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Traditional Azure networking topology

Explore key design considerations and recommendation surrounding network topologies in Microsoft Azure.

![Diagram that illustrates a traditional Azure network topology.](./media/customer-managed-topology.png)

*Figure 1: A traditional Azure network topology.*

**Design considerations:**

- Various network topologies can connect multiple landing zone virtual networks. Examples are one large flat virtual network, multiple virtual networks connected with multiple Azure ExpressRoute circuits or connections, hub and spoke, full mesh, and hybrid.

- Virtual networks can't traverse subscription boundaries. However, you can achieve connectivity between virtual networks across different subscriptions by using virtual network peering, an ExpressRoute circuit, or VPN gateways.

- Virtual network peering is the preferred method to connect virtual networks in Azure. You can use virtual network peering to connect virtual networks in the same region, across different Azure regions, and across different Azure Active Directory (Azure AD) tenants.

- Virtual network peering and global virtual network peering aren't transitive. User-defined routes (UDRs) and network virtual appliances (NVAs) are required to enable a transit network. For more information, see [Hub-spoke network topology in Azure](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

- An Azure DDoS Protection standard protection plan can be shared across all virtual networks in a single Azure AD Tenant to protect resources with public IP addresses. For more information, see [Azure DDoS Protection Standard](/azure/ddos-protection/ddos-protection-overview).

  - Only resources with Public IP addresses are covered by Azure DDoS Protection standard protection plans.

  - 100 public IP addresses are included in the cost of an Azure DDoS Protection standard protection plan across all protected virtual networks associated to the DDoS Protection plan. Any other public IP addresses over the 100 included with the plan, are charged separately. For more information on Azure DDoS Protection Standard Protection pricing, see the [pricing page](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work).

  - Review the [supported resources of Azure DDoS Protection standard protection plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types)

- You can use ExpressRoute circuits to establish connectivity across virtual networks within the same geopolitical region or by using the premium add-on for connectivity across geopolitical regions. Keep these points in mind:

  - Network-to-network traffic might experience more latency because traffic must hairpin at the Microsoft Enterprise Edge (MSEE) routers.

  - Bandwidth will be constrained to the ExpressRoute gateway SKU.

  - Deploy and manage UDRs if they need to be inspected or logged for traffic across virtual networks.

- VPN gateways with Border Gateway Protocol (BGP) are transitive within Azure and on-premises, but they don't provide transitive access to networks connected via ExpressRoute.

- When multiple ExpressRoute circuits are connected to the same virtual network, use connection weights and BGP techniques to ensure an optimal path for traffic between on-premises and Azure. For more information, see [Optimize ExpressRoute routing](/azure/expressroute/expressroute-optimize-routing).

- Using BGP metrics to influence ExpressRoute routing is a configuration change made outside of the Azure platform. Your organization or your connectivity provider must configure the on-premises routers accordingly.

- ExpressRoute circuits with premium add-ons provide global connectivity.

- ExpressRoute is bound to certain limits; there are a maximum number of ExpressRoute connections per ExpressRoute gateway and ExpressRoute private peering can identify a maximum number of routes from Azure to on-premises. See [ExpressRoute limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#expressroute-limits) for more information about these limits.

- A VPN gateway's maximum aggregated throughput is 10 gigabits per second. It supports up to 30 site-to-site or network-to-network tunnels.

**Design recommendations:**

- Consider a network design based on the traditional hub-and-spoke network topology for the following scenarios:

  - A network architecture deployed within a single Azure region.

  - A network architecture that spans multiple Azure regions, with no need for transitive connectivity between virtual networks for landing zones across regions.

  - A network architecture that spans multiple Azure regions, and global virtual network peering can be used to connect virtual networks across Azure regions.

  - There's no need for transitive connectivity between VPN and ExpressRoute connections.

  - The main hybrid connectivity method in place is ExpressRoute, and the number of VPN connections is less than 30 per VPN gateway.

  - There's a dependency on centralized NVAs and granular routing.

- For regional deployments, primarily use the hub-and-spoke topology. Use landing zone virtual networks that connect with virtual network peering to a central hub virtual network for cross-premises connectivity via ExpressRoute, VPN for branch connectivity, spoke-to-spoke connectivity via NVAs and UDRs, and internet-outbound protection via Azure Firewall or other third-party NVA. The following diagram shows this topology. This configuration allows for appropriate traffic control to meet most requirements for segmentation and inspection.

  ![Diagram that illustrates a hub-and-spoke network topology.](./media/hub-and-spoke-topology.png)

 *Figure 2: Hub-and-spoke network topology.*

- Use the topology of multiple virtual networks connected with multiple ExpressRoute circuits when one of these conditions is true:

  - You need a high level of isolation.

  - You need dedicated ExpressRoute bandwidth for specific business units.

  - You've reached the maximum number of connections per ExpressRoute gateway (refer to the [ExpressRoute limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#expressroute-limits) article for the maximum number).

The following figure shows this topology.

  ![Diagram that illustrates multiple virtual networks connected with multiple ExpressRoute circuits.](./media/vnet-multiple-circuits.png)

 *Figure 3: Multiple virtual networks connected with multiple ExpressRoute circuits.*

- Deploy a set of minimal shared services, including ExpressRoute gateways, VPN gateways (as required), and Azure Firewall or partner NVAs (as required) in the central-hub virtual network. If necessary, also deploy Active Directory domain controllers and DNS servers.

- Deploy Azure Firewall or partner NVAs for east/west or south/north traffic protection and filtering, in the central-hub virtual network.

- When you're deploying partner networking technologies or NVAs, follow the partner vendor's guidance to ensure that:

  - The vendor supports deployment.

  - The guidance is designed for high availability and maximum performance.

  - There are no conflicting configurations with Azure networking.

- Don't deploy Layer 7 inbound NVAs, such as Azure Application Gateway, as a shared service in the central-hub virtual network. Instead, deploy them together with the application in their respective landing zones.

- Deploy a single Azure DDoS standard protection plan in the Connectivity subscription.

  - All Landing Zone and Platform virtual networks should use this plan.

- Use your existing network, multiprotocol label switching, and SD-WAN to connect branch locations with corporate headquarters. Transit in Azure between ExpressRoute and VPN gateways isn't supported.

- When you have hub-and-spoke networks in multiple Azure regions and a few landing zones need to connect across regions, use global virtual network peering to directly connect landing zone virtual networks that need to route traffic to each other. Depending on the communicating VM's SKU, global virtual network peering can provide high network throughput. Traffic between directly peered landing zone virtual networks will bypass NVAs within hub virtual networks. This would also be subject to [limitations on global virtual network peering](/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks).

- When you have hub-and-spoke networks in multiple Azure regions and most landing zones need to connect across regions (or when using direct peering to bypass hub NVAs isn't compatible with your security requirements), use hub NVAs to connect hub virtual networks in each region to each other and route traffic across regions. Global virtual network peering or ExpressRoute circuits can help to connect Hub virtual networks in the following ways:

  - Global virtual network peering provides a low latency and high throughput connection but generates [traffic fees](/azure/virtual-network/virtual-network-peering-overview#pricing).
  
  - Routing via ExpressRoute might lead to increased latency (due to MSEE hairpin) and throughput will be constrained to the [ExpressRoute Gateway SKU](/azure/expressroute/expressroute-about-virtual-network-gateways#gwsku).
   
The following figure shows both options:

 ![Diagram that illustrates options for hub-to-hub connectivity.](./media/hub-to-hub-er-or-peering.png)

*Figure 4: Options for hub-to-hub connectivity.*

- When two Azure regions need to connect, evaluate and use global virtual network peering or the same ExpressRoute circuit(s) to connect both hub virtual networks.

- When more than two Azure regions need to connect, then the recommendation is for hub virtual networks in each region to connect to the same ExpressRoute circuit(s). Global virtual network peering would require managing a large number of peering relationships and a complex set of user-defined routes (UDRs) across multiple virtual networks. The following diagram shows how to connect hub-and-poke networks in three regions:

![Diagram that illustrates ExpressRoute providing hub-to-hub connectivity between multiple regions.](./media/multiregion-hub-to-hub-er.png)

*Figure 5: ExpressRoute providing hub-to-hub connectivity between multiple regions.*

- When using ExpressRoute circuits for cross-region connectivity, spokes in different regions will communicate directly and bypass the firewall, as they will learn via BGP routes to the spokes of the remote hub. If you require traffic across spokes to be inspected by the firewall NVAs in the hub virtual networks, you must implement one of these options:

  - Create more specific route entries in the spoke UDRs for the firewall in the local hub virtual network to redirect traffic across hubs.
  
  - To simplify route configuration, [disable BGP propagation](/azure/virtual-network/virtual-networks-udr-overview#border-gateway-protocol) on the spoke route tables.

- When your organization requires hub-and-spoke network architectures across more than two Azure regions, global transit connectivity between landing zones virtual networks across Azure regions is required, and you want to minimize network management overhead, it's recommended to evaluate a [managed global transit network architecture](./virtual-wan-network-topology.md) that's based on Virtual WAN.

- Deploy each region's hub network resources into separate resource groups, and sort them into each deployed region.

- Use [Azure Monitor for Networks (preview)](/azure/azure-monitor/insights/network-insights-overview) to monitor the end-to-end state of your networks on Azure.

- Two [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) must be considered when you connect spoke virtual networks to the central hub virtual network:

  - The maximum number of virtual network peering connections per virtual network
  - The maximum number of prefixes that ExpressRoute with private peering advertises from Azure to on-premises

  Ensure that the number of spoke virtual networks connected to the hub virtual network don't exceed these limits.