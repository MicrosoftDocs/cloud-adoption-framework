---
title:  Virtual WAN network topology in an Azure landing zone
description: Learn how to set up Virtual WAN network topology in an Azure landing zone
author: stephen-sumner
ms.author: pnp
ms.date: 10/08/2025
ms.topic: conceptual
---

# Virtual WAN network topology in an Azure landing zone

This article provides prescriptive guidance to design Azure Virtual WAN network topologies in an Azure landing zone. Azure Virtual WAN is a Microsoft-managed networking service that provides automated connectivity between Azure regions, virtual networks, and on-premises locations through a hub-and-spoke architecture. Use Virtual WAN for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. Virtual WAN eliminates the need to manually set up transitive routing for Azure networking, which simplifies network management and reduces operational complexity. The following figure shows a sample global enterprise deployment with datacenters spread across Europe and the United States. The deployment contains many branch offices within both regions.

:::image type="complex" source="./media/virtual-wan-topology.png" alt-text="Diagram that illustrates a Virtual WAN network topology in an Azure landing zone." lightbox="./media/virtual-wan-topology.png" border="false":::
    Diagram showing Azure landing zone architecture with two main sections: Connectivity subscription on the left and Landing zone subscription on the right. The connectivity subscription includes Azure Firewall, DNS, DDoS protection, VPN/ExpressRoute gateways, and two VWAN hubs labeled Region 1 and Region N. Lines labeled ‘VWAN Hub Connection’ link these hubs to corresponding vNet regions in the landing zone subscription. Each vNet region contains resource groups, NSGs/ASGs, UDRs, and shared services like dashboards and managed identities. The diagram emphasizes secure connectivity between VWAN hubs and landing zone networks.
:::image-end:::

*Figure 1: Virtual WAN network topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

## Plan your Virtual WAN architecture

Azure Virtual WAN simplifies end-to-end network connectivity in Azure and from on-premises to Azure by creating a [hub-and-spoke network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture). A hub-and-spoke architecture uses a central hub to connect multiple spoke virtual networks and on-premises locations, which enables efficient traffic routing and centralized management. This hub-and-spoke architecture scales to support multiple Azure regions and on-premises locations with any-to-any connectivity, as shown in the following figure:

:::image type="complex" source="./media/global-transit.png" alt-text="Diagram that illustrates a global transit network with Virtual WAN." border="false":::
    Diagram of a global transit network using Azure Virtual WAN. It shows two regions, Region 1 and Region 2, each containing multiple VNets connected to a Virtual WAN hub. The hubs are linked by a hub-to-hub connection for inter-region communication. Below each hub, icons represent branch offices and connectivity endpoints, including ExpressRoute and user devices. The layout emphasizes centralized hub connectivity for VNets within regions and global transit between regions.
:::image-end:::

*Figure 2: Global transit network with Virtual WAN.*

1. **Design a hub-per-region architecture.** Deploy one Virtual WAN hub per Azure region to establish regional connectivity. Connect multiple landing zones together across Azure regions via a common global Azure Virtual WAN. This hub-per-region architecture provides consistent global connectivity while it localizes traffic within regions for optimal performance and reduced latency.

   **Connectivity capabilities:** Azure Virtual WAN any-to-any transitive connectivity supports the following paths within the same region and across regions:

   - Virtual network to virtual network
   - Virtual network to branch
   - Branch to virtual network
   - Branch to branch

   **Hub resource constraints:**

   Azure Virtual WAN Hubs restrict deployment to Microsoft managed resources only. You can deploy only the following resources within the WAN hubs:

   - Virtual network gateways (point-to-site VPN, site-to-site VPN, and Azure ExpressRoute)
   - Azure Firewall via Firewall Manager
   - Route tables
   - Some [network virtual appliances (NVA)](/azure/virtual-wan/about-nva-hub) for vendor-specific SD-WAN capabilities

1. **Place Azure Virtual WAN and Azure Firewall resources in the connectivity subscription.** This resource organization centralizes network and security resources for consistent management and aligns with the Azure landing zone architecture. This separation of connectivity resources from application workloads provides clear ownership boundaries and simplifies governance.

1. **Organize all Virtual WAN resources into a single resource group.** Place all Virtual WAN resources into a single resource group in the connectivity subscription. Keep all Virtual WAN resources together even when you deploy across multiple regions. This single resource group approach simplifies management, aligns with portal requirements, and provides a single location for network infrastructure governance.

1. **Deploy required shared services in a dedicated spoke virtual network.** Create a spoke virtual network attached to the Virtual WAN hub for shared services. Virtual WAN hubs have specific constraints on deployable resources. Shared services that don't fall into the supported category require alternative deployment approaches to ensure proper integration with your Virtual WAN topology. Shared resources like DNS servers, domain controllers, or management tools can't deploy inside the Virtual WAN hub itself due to platform restrictions. Place these shared services in a spoke network that connects to the hub to make them accessible across your entire Virtual WAN topology while you maintain proper isolation.

1. **Validate your architecture against Azure Virtual WAN limits.** Review Azure Virtual WAN limits before deployment to avoid redesign work. Azure Virtual WAN has specific limits for virtual network connections, and other resources. Review the [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits) and adjust your design to stay within these boundaries. Deploy multiple Virtual WAN virtual hubs in the same region if you need to scale beyond single hub limits.

### Connect on-premises locations and branches

Virtual WAN provides multiple connectivity options to integrate on-premises datacenters, branch offices, and remote locations into your Azure network. Choose the appropriate connectivity method based on bandwidth requirements, security needs, and existing infrastructure.

1. **Connect on-premises datacenters to Virtual WAN hubs.** Connect Virtual WAN hubs to on-premises datacenters by using ExpressRoute. You can connect ExpressRoute circuits to a Virtual WAN hub by using a Local, Standard, or Premium SKU. For deployments in the same city, consider [ExpressRoute Metro](/azure/expressroute/metro) for dual high-availability connectivity within a metro region when you need resilient local paths. It can offer architectural and potential cost efficiencies depending on workload patterns. ExpressRoute Standard or Premium circuits, in locations supported by [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach), can connect to a Virtual WAN ExpressRoute gateway. And they have all the Virtual WAN transit capabilities (VPN-to-VPN, VPN, and ExpressRoute transit). ExpressRoute Standard or Premium circuits that are in locations not supported by Global Reach can connect to Azure resources, but can't use Virtual WAN transit capabilities.

    :::image type="complex" source="./media/global-reach-topology.png" alt-text="Diagram of a sample network topology." border="false":::
   Diagram of an Azure Virtual WAN topology connecting two regions: US and EMEA. Each region has a headquarters connected via ExpressRoute to a Virtual WAN hub. The hubs are linked through ExpressRoute Global Reach. Under each hub, multiple VNets and branch offices are shown. The US side includes two WAN hubs, VNets, and branch offices, while the EMEA side mirrors this structure with its own hubs, VNets, and branch offices.
    :::image-end:::

    *Figure 3: Sample network topology.*

1. **Connect branches and remote locations to the nearest Virtual WAN hub.** Use Site-to-Site VPN to establish connectivity for branch offices and remote locations. Route connections through the geographically closest Virtual WAN hub to minimize latency and optimize network performance. Alternatively, enable branch connectivity through an SD-WAN partner solution that integrates with Virtual WAN for simplified management and vendor-specific capabilities. Virtual WAN integrates with various [SD-WAN providers](/azure/virtual-wan/virtual-wan-locations-partners). Many managed service providers offer [managed services](/azure/networking/networking-partners-msp) for Virtual WAN.

1. **Connect individual users to the Virtual WAN hub.** Use Point-to-Site VPN to provide secure remote access for individual users. Point-to-Site VPN provides secure remote access for users who need to connect from various locations.

### Configure routing and traffic segmentation

Virtual WAN routing capabilities provide granular control over traffic flow between virtual networks, branches, and on-premises locations. Proper routing configuration ensures traffic follows optimal paths while maintaining security and compliance requirements.

1. **Use virtual hub routing features.** Configure virtual hub routing to segment traffic between VNets and branches. [Virtual hub routing](/azure/virtual-wan/about-virtual-hub-routing) provides granular control over traffic flow without additional infrastructure. Configure custom route tables to direct traffic based on your security and compliance requirements.

1. **Route all traffic through the Microsoft backbone network.** Configure routing to follow the principle of "traffic in Azure stays in Azure." Communication across resources in Azure occurs via the Microsoft backbone network, even when the resources exist in different regions. This routing approach improves security by keeping traffic off the public internet and enhances performance through Microsoft's global network infrastructure.

### Implement security controls

Security implementation in Virtual WAN requires careful consideration of multiple layers including network filtering, DDoS protection, and centralized policy enforcement. Deploy security controls that protect your network while maintaining performance and manageability.

1. **Deploy a single Azure DDoS standard protection plan.** Create a single Azure DDoS standard protection plan in the connectivity subscription. Share this plan across all landing zone and platform VNets to ensure consistent DDoS protection across your environment. A single plan covers 100 public IP addresses and provides centralized management of DDoS protection policies. The plan protects only resources with public IP addresses. Any public IP addresses beyond the 100 addresses included with the plan incur separate charges. For more information on pricing, see the [Azure DDoS Protection pricing page](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work). Review the [supported resources of Azure DDoS Protection plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types).

1. **Protect outbound internet traffic.** consider Azure Firewall in the virtual hub for internet outbound protection

1. **Consider network virtual appliances (NVAs).** Use NVA deployment when you need both SD-WAN connectivity and Next-Generation Firewall capabilities. [NVA firewalls](/azure/virtual-wan/about-nva-hub#security-provided-by-nva-firewalls) can connect on-premises devices and inspect all North-South, East-West, and Internet-bound traffic through the same appliance. When you're deploying partner networking technologies and NVAs, follow the partner vendor's guidance to ensure there are no conflicting configurations with Azure networking.

1. **Consider secured virtual hubs.** A secured virtual hub is an Azure Virtual WAN Hub with associated security and routing policies configured by Azure Firewall Manager. Review the latest [constraints](/azure/firewall-manager/overview#known-issues) before deployment. Virtual WAN hub-to-hub traffic that goes through Azure Firewall in both source hubs and target hubs (secured virtual hubs) is supported when you enable routing intent and policies. For more information, see [Routing intent and policies](/azure/virtual-wan/how-to-routing-policies). Virtual WAN secured virtual hubs don't support Azure DDoS standard protection plans. Apply protection at the spoke VNet level instead. You can share an Azure DDoS Protection plan across all VNets in a single Microsoft Entra tenant. For more information, see [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview), [Azure Firewall Manager known issues](/azure/firewall-manager/overview#known-issues), and [Hub virtual network and secured virtual hub comparison](/azure/firewall-manager/vhubs-and-vnets#comparison).

### Manage and monitor your deployment

Proper management and monitoring ensure your Virtual WAN deployment operates reliably and provides visibility into network performance, connectivity issues, and capacity utilization. Establish monitoring practices from the start to maintain operational excellence.

Configure Azure Monitor insights to monitor the end-to-end topology of your Virtual WAN. [Insights in Azure Monitor for Virtual WAN](/azure/virtual-wan/azure-monitor-insights) provide visibility into network status, connection health, and [key metrics](/azure/virtual-wan/azure-monitor-insights#detailed) for proactive management. Configure alerts for critical thresholds to detect and respond to issues before they affect users.

### Migrate existing hub-and-spoke topologies

Organizations with existing hub-and-spoke network architectures (brownfield scenarios) can migrate to Virtual WAN to gain simplified management and enhanced transit capabilities. Migration requires careful planning to minimize disruption while transitioning to the new architecture. Follow the migration guide when you migrate from a hub-and-spoke network topology not based on Virtual WAN. The [Migrate to Azure Virtual WAN](/azure/virtual-wan/migrate-from-hub-spoke-topology) guide provides detailed steps to transition your existing architecture. Follow the phased approach to minimize downtime and validate connectivity at each stage before proceeding.
