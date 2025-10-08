---
title:  Virtual WAN network topology in an Azure landing zone
description: Learn how to set up Virtual WAN network topology in an Azure landing zone
author: stephen-sumner
ms.author: pnp
ms.date: 10/08/2025
ms.topic: conceptual
---

# Virtual WAN network topology in an Azure landing zone

This article explains how to design and implement an Azure Virtual WAN network topology within an Azure landing zone. Azure Virtual WAN is a Microsoft-managed networking service that provides global, dynamic, and transitive connectivity across Azure regions and on-premises environments. This guidance is important because it simplifies connectivity, reduces operational complexity, and enables scalable architectures for enterprise-scale deployments.

:::image type="complex" source="./media/virtual-wan-topology.png" alt-text="Diagram that illustrates a Virtual WAN network topology in an Azure landing zone." lightbox="./media/virtual-wan-topology.png" border="false":::
    Diagram showing Azure landing zone architecture with two main sections: Connectivity subscription and Landing zone subscription on the right. The connectivity subscription includes Azure Firewall, DNS, DDoS protection, VPN/ExpressRoute gateways, and two VWAN hubs labeled Region 1 and Region N. Lines labeled ‘VWAN Hub Connection’ link these hubs to corresponding virtual network regions in the landing zone subscription. Each virtual network region contains resource groups, NSGs/ASGs, UDRs, and shared services like dashboards and managed identities. The diagram emphasizes secure connectivity between VWAN hubs and landing zone networks.
:::image-end:::

*Figure 1: Virtual WAN network topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

## Create hub-and-spoke network architecture

Azure Virtual WAN simplifies end-to-end network connectivity in Azure, and to Azure from on-premises, by creating a [hub-and-spoke network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture). The architecture easily scales to support multiple Azure regions and on-premises locations (any-to-any connectivity) as shown in the following figure:

:::image type="complex" source="./media/global-transit.png" alt-text="Diagram that illustrates a global transit network with Virtual WAN." border="false":::
    Diagram of a global transit network using Azure Virtual WAN. It shows two regions, Region 1 and Region 2, each containing multiple VNets connected to a Virtual WAN hub. The hubs are linked by a hub-to-hub connection for inter-region communication. Below each hub, icons represent branch offices and connectivity endpoints, including ExpressRoute and user devices. The layout emphasizes centralized hub connectivity for VNets within regions and global transit between regions.
:::image-end:::

*Figure 2: Global transit network with Virtual WAN.*

Azure Virtual WAN any-to-any transitive connectivity supports the following paths within the same region and across regions:

   - Virtual network to virtual network
   - Virtual network to branch
   - Branch to virtual network
   - Branch to branch

**Constraints:** Virtual WAN hubs only support Microsoft-managed resources such as:

   - Virtual network gateways (point-to-site VPN, site-to-site VPN, and Azure ExpressRoute)
   - Azure Firewall via Firewall Manager
   - Route tables
   - Some [network virtual appliances (NVA)](/azure/virtual-wan/about-nva-hub) for vendor-specific SD-WAN capabilities

## Plan your Virtual WAN deployment

1. **Use one or more Virtual WAN Hubs per Azure region.** Use a Virtual WAN hub per Azure region. The goal is to connect multiple application landing zones together across Azure regions by way of a common global Azure Virtual WAN. Virtual WAN is subject to Azure subscription limits. You can deploy multiple Azure Virtual WAN hubs in the same region to scale beyond the single hub limits

1. **Use the connectivity subscription.** Place all Virtual WAN resources, Azure Firewall, and the Azure DDoS standard protection plan in the connectivity subscription of your Azure landing zone.

1. **Deploy Azure DDoS.** Create a single Azure DDoS standard protection plan in the connectivity subscription. All application landing zone virtual network and platform virtual networks should use this plan. You can share an Azure DDoS Protection plan across all VNets in a single Microsoft Entra tenant to protect resources with public IP addresses. see [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview). An Azure DDoS Protection plan includes 100 public IP addresses. These public IP addresses span all protected virtual networks associated with the DDoS protection plan. Any other public IP addresses, beyond the 100 included with the plan, are charged separately. For more information on Azure DDoS Protection pricing, see, see the [Azure DDoS Protection pricing page](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work). Review the [supported resources of Azure DDoS Protection plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types).

1. **Use a single resource group.** The Virtual WAN portal experience requires that all Virtual WAN resources deploy together into the same resource group. Deploy all Virtual WAN resources in the same resource group within the connectivity subscription. This structure streamlines deployment and lifecycle management.

1. **Deploy required shared services.** Deploy required shared services, like DNS servers, in a dedicated spoke virtual network. Customer-deployed shared resources can't be deployed inside the Virtual WAN hub itself.

1. **Plan for subscription limits and scalability.** Don't create more than 500 virtual network connections per Virtual WAN virtual hub. If you need more than 500 virtual network connections per Virtual WAN virtual hub, you can deploy another Virtual WAN virtual hub. Deploy it in the same region as part of the same Virtual WAN and resource group. Plan your deployment carefully, and ensure that your network architecture is within the [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits).

## Connect on-premises locations and branches

1. **Use ExpressRoute.** You can connect ExpressRoute circuits to a Virtual WAN hub by using a Local, Standard, or Premium SKU. For deployments in the same city, consider [ExpressRoute Metro](/azure/expressroute/metro). ExpressRoute Standard or Premium circuits, in locations supported by [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach), can connect to a Virtual WAN ExpressRoute gateway. And they have all the Virtual WAN transit capabilities (VPN-to-VPN, VPN, and ExpressRoute transit). ExpressRoute Standard or Premium circuits that are in locations not supported by Global Reach can connect to Azure resources, but can't use Virtual WAN transit capabilities.

    :::image type="complex" source="./media/global-reach-topology.png" alt-text="Diagram of a sample network topology." border="false":::
   Diagram of an Azure Virtual WAN topology connecting two regions: US and EMEA. Each region has a headquarters connected via ExpressRoute to a Virtual WAN hub. The hubs are linked through ExpressRoute Global Reach. Under each hub, multiple VNets and branch offices are shown. The US side includes two WAN hubs, VNets, and branch offices, while the EMEA side mirrors this structure with its own hubs, VNets, and branch offices.
    :::image-end:::

    *Figure 3: Sample network topology.*

1. **Connect branches and remote locations.** Connect branches and remote locations to the nearest Virtual WAN hub via Site-to-Site VPN, or enable branch connectivity to Virtual WAN via an SD-WAN partner solution. Virtual WAN integrates with various [SD-WAN providers](/azure/virtual-wan/virtual-wan-locations-partners). Many managed service providers offer [managed services](/azure/networking/networking-partners-msp) for Virtual WAN.

1. **Connect individual users.** Connect users to the Virtual WAN hub via a Point-to-Site VPN. Point-to-Site VPN provides secure remote access for users who need to connect from various locations.

## Configure routing and traffic segmentation

Configure [virtual hub routing](/azure/virtual-wan/about-virtual-hub-routing) to segment traffic between VNets and branches. Use Virtual WAN hub routing features to control traffic flow between VNets and branches. Create custom route tables to enforce security and compliance requirements. Ensure all Azure traffic remains on the Microsoft backbone network for optimal performance. For internet-bound traffic, configure outbound filtering through Azure Firewall.

## Implement security controls

1. **Consider network virtual appliances (NVAs).** You can deploy [NVA firewalls](/azure/virtual-wan/about-nva-hub#security-provided-by-nva-firewalls) into a Virtual WAN hub that performs both SD-WAN connectivity and Next-Generation Firewall capabilities. You can connect on-premises devices to the NVA in the hub and also use the same appliance to inspect all North-South, East-West, and Internet-bound traffic. When you're deploying partner networking technologies and NVAs, follow the partner vendor's guidance to ensure there are no conflicting configurations with Azure networking.

1. **Consider secured virtual hubs.** A secured virtual hub is an Azure Virtual WAN Hub with associated security and routing policies configured by Azure Firewall Manager. Review the latest [constraints](/azure/firewall-manager/overview#known-issues) before deployment. Virtual WAN hub-to-hub traffic that goes through Azure Firewall in both source hubs and target hubs (secured virtual hubs) is supported when you enable routing intent and policies. Use [Virtual WAN hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) to support traffic that goes between secured hubs. Virtual WAN secured virtual hubs don't support Azure DDoS standard protection plans. For more information, see [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview), [Azure Firewall Manager known issues](/azure/firewall-manager/overview#known-issues), and [Hub virtual network and secured virtual hub comparison](/azure/firewall-manager/vhubs-and-vnets#comparison).

## Manage and monitor your deployment

Configure Azure Monitor insights to monitor the end-to-end topology of your Virtual WAN. [Insights in Azure Monitor for Virtual WAN](/azure/virtual-wan/azure-monitor-insights) provide visibility into network status, connection health, and [key metrics](/azure/virtual-wan/azure-monitor-insights#detailed) for proactive management. Configure alerts for critical thresholds to detect and respond to issues before they affect users.

## Migrate existing hub-and-spoke topologies

For brownfield scenarios where you're migrating from a hub-and-spoke network topology not based on Virtual WAN, see [Migrate to Azure Virtual WAN](/azure/virtual-wan/migrate-from-hub-spoke-topology).
