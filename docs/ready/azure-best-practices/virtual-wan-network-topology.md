---
title: Virtual WAN network topology
description: Examine key design considerations and recommendations surrounding virtual wide area networks in Microsoft Azure.
author: stephen-sumner
ms.author: pnp
ms.date: 07/31/2024
ms.topic: conceptual
---

# Design a Virtual WAN network topology

This article provides prescriptive guidance to design Azure Virtual WAN network topologies. Azure Virtual WAN is a Microsoft-managed networking service that provides end-to-end global transit connectivity across Azure regions and on-premises locations. Virtual WAN eliminates the need to manually configure network connectivity, user-defined routes (UDR), or network virtual appliances (NVAs) for global transit. This guidance helps you design a Virtual WAN topology that meets your organization's connectivity requirements while staying within Azure service limits and following best practices.

[![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)](./media/virtual-wan-topology.png#lightbox)

*Figure 1: Virtual WAN network topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

## Understand Virtual WAN capabilities and constraints

Before you design your Virtual WAN topology, assess the capabilities and constraints of Azure Virtual WAN to ensure the service fits your requirements. Azure Virtual WAN simplifies end-to-end network connectivity in Azure and from on-premises to Azure by creating a [hub-and-spoke network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture). This architecture scales to support multiple Azure regions and on-premises locations with any-to-any connectivity, as shown in the following figure:

![Diagram that illustrates a global transit network with Virtual WAN.](./media/global-transit.png)

*Figure 2: Global transit network with Virtual WAN.*

**Connectivity capabilities:**

Azure Virtual WAN any-to-any transitive connectivity supports the following paths within the same region and across regions:

- Virtual network to virtual network
- Virtual network to branch
- Branch to virtual network
- Branch to branch

**Hub resource constraints:**

Azure Virtual WAN hubs are restricted to the deployment of Microsoft managed resources. The only resources that you can deploy within the WAN hubs are:

- Virtual network gateways (point-to-site VPN, site-to-site VPN, and Azure ExpressRoute)
- Azure Firewall via Firewall Manager
- Route tables
- Some [network virtual appliances (NVA)](/azure/virtual-wan/about-nva-hub) for vendor-specific SD-WAN capabilities

**Service limits:**

- Virtual WAN is bound by [Azure subscription limits for Virtual WAN](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits).
- Network-to-network transitive connectivity within a region and across regions via hub-to-hub is in general availability (GA).
- The Microsoft-managed routing function that's a part of every virtual hub enables the transit connectivity between virtual networks in Standard Virtual WAN. Each hub supports an aggregate throughput of up to 50 Gbps for VNet-to-VNet traffic.
- By default, a single Azure Virtual WAN hub supports up to 2,000 VM workloads across all directly attached VNets. You can increase this limit by adjusting hub [capacity units](/azure/virtual-wan/hub-settings#virtual-hub-capacity). For more information, see [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits).
- You can deploy multiple Azure Virtual WAN hubs in the same region to scale beyond the single hub limits.

**Partner integrations:**

- Virtual WAN integrates with various [SD-WAN providers](/azure/virtual-wan/virtual-wan-locations-partners).
- Many managed service providers offer [managed services](/azure/networking/networking-partners-msp) for Virtual WAN.

**Gateway capabilities:**

- User VPN (point-to-site) gateways in Virtual WAN scale up to 200-Gbps aggregate throughput and 100,000 client connections per virtual hub. For more information, see [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits).
- Site-to-site VPN gateways in Virtual WAN scale up to 20-Gbps aggregated throughput.
- You can connect ExpressRoute circuits to a Virtual WAN hub by using a Local, Standard, or Premium SKU.
- For deployments in the same city, consider [ExpressRoute Metro](/azure/expressroute/metro).
- ExpressRoute Standard or Premium circuits in locations supported by [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) can connect to a Virtual WAN ExpressRoute gateway and use all Virtual WAN transit capabilities (VPN-to-VPN, VPN, and ExpressRoute transit). For circuits in locations not supported by Global Reach, you can still connect to Azure resources but can't use Virtual WAN transit capabilities.

**Security capabilities:**

- Azure Firewall Manager supports deployment of Azure Firewall in the Virtual WAN hub, known as secured virtual hub. For more information, see the [Azure Firewall Manager overview](/azure/firewall-manager/overview) for secured virtual hubs and the latest [constraints](/azure/firewall-manager/overview#known-issues).
- Virtual WAN hub-to-hub traffic that goes through Azure Firewall in both source hubs and target hubs (secured virtual hubs) is supported when you enable routing intent and policies. For more information, see [Use cases for Virtual WAN hub routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies#use-cases).

**Resource organization:**

- The Virtual WAN portal experience requires that all Virtual WAN resources deploy together into the same resource group.

**DDoS protection:**

- You can share an Azure DDoS Protection plan across all VNets in a single Microsoft Entra tenant to protect resources with public IP addresses. For more information, see [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview).
- Virtual WAN secure virtual hubs don't support Azure DDoS standard protection plans. For more information, see [Azure Firewall Manager known issues](/azure/firewall-manager/overview#known-issues) and [Hub virtual network and secured virtual hub comparison](/azure/firewall-manager/vhubs-and-vnets#comparison).
- Azure DDoS Protection plans only cover resources with public IP addresses.
- An Azure DDoS Protection plan includes 100 public IP addresses. These public IP addresses span all protected VNets associated with the DDoS protection plan. Any other public IP addresses, beyond the 100 included with the plan, are charged separately. For more information on Azure DDoS Protection pricing, see the [pricing page](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work).
- Review the [supported resources of Azure DDoS Protection plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types).

## Deploy Virtual WAN for large or global network topologies

Use Virtual WAN for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. Virtual WAN eliminates the need to manually set up transitive routing for Azure networking. The following figure shows a sample global enterprise deployment with datacenters spread across Europe and the United States. The deployment contains many branch offices within both regions. The environment connects globally via Azure Virtual WAN and [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach).

![Diagram of a sample network topology.](./media/global-reach-topology.png)

*Figure 3: Sample network topology.*

### Plan your Virtual WAN architecture

Before you deploy Virtual WAN resources, establish a deployment plan that ensures your architecture meets organizational requirements and stays within service limits. Strategic planning prevents costly redesign work and ensures optimal performance from the start.

1. **Design a hub-per-region architecture** by deploying one Virtual WAN hub per Azure region. Connect multiple landing zones together across Azure regions via a common global Azure Virtual WAN. This architecture provides consistent global connectivity while localizing traffic within regions for optimal performance and reduced latency.

1. **Organize all Virtual WAN resources into a single resource group** in the connectivity subscription. Keep all Virtual WAN resources together even when you deploy across multiple regions. This organizational approach simplifies management, aligns with portal requirements, and provides a single location for network infrastructure governance.

1. **Validate your architecture against Azure Virtual WAN limits** before deployment to avoid redesign work. Azure Virtual WAN has specific limits for virtual network connections (500 minus the total number of hubs), VM workloads per hub (2,000 by default), and other resources. Review the [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-virtual-wan-limits) and adjust your design to stay within these boundaries. Deploy multiple hubs in the same region if you need to scale beyond single hub limits.

### Connect on-premises locations and branches

Virtual WAN provides multiple connectivity options to integrate on-premises datacenters, branch offices, and remote locations into your Azure network. Choose the appropriate connectivity method based on bandwidth requirements, security needs, and existing infrastructure.

1. **Connect on-premises datacenters to Virtual WAN hubs** by using ExpressRoute circuits. ExpressRoute provides reliable, high-bandwidth connectivity with predictable performance and private network paths. Deploy Local, Standard, or Premium SKU circuits based on your requirements. For same-city deployments, use [ExpressRoute Metro](/azure/expressroute/metro) to reduce costs while maintaining performance. Circuits in locations that support [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) can use all Virtual WAN transit capabilities including VPN-to-VPN, VPN, and ExpressRoute transit.

1. **Connect branches and remote locations to the nearest Virtual WAN hub** via Site-to-Site VPN. Route connections through the geographically closest hub to minimize latency and optimize network performance. Alternatively, enable branch connectivity through an SD-WAN partner solution that integrates with Virtual WAN for simplified management and vendor-specific capabilities.

1. **Connect individual users to the Virtual WAN hub** via Point-to-Site VPN. Point-to-Site VPN provides secure remote access for users who need to connect from various locations. Virtual WAN supports up to 200-Gbps aggregate throughput and 100,000 client connections per virtual hub to accommodate large remote workforces.

### Configure routing and traffic segmentation

Virtual WAN routing capabilities provide granular control over traffic flow between virtual networks, branches, and on-premises locations. Proper routing configuration ensures traffic follows optimal paths while maintaining security and compliance requirements.

1. **Use virtual hub routing features** to segment traffic between VNets and branches. [Virtual hub routing](/azure/virtual-wan/about-virtual-hub-routing) provides granular control over traffic flow without additional infrastructure. Configure custom route tables to direct traffic based on your security and compliance requirements.

1. **Route all traffic through the Microsoft backbone network** to follow the principle of "traffic in Azure stays in Azure." Communication across resources in Azure occurs via the Microsoft backbone network, even when the resources are in different regions. This routing approach improves security by keeping traffic off the public internet and enhances performance through Microsoft's global network infrastructure.

1. **Enable Virtual WAN hub routing intent and routing policies** to support traffic that flows between secured hubs. [Routing intent and policies](/azure/virtual-wan/how-to-routing-policies) provide centralized control over inter-hub traffic when you use Azure Firewall or network virtual appliances. This configuration ensures consistent security policy enforcement across your global network topology.

### Deploy shared services and infrastructure

Virtual WAN hubs have specific constraints on deployable resources. Shared services that don't fall into the supported category require alternative deployment approaches to ensure proper integration with your Virtual WAN topology.

1. **Deploy required shared services in a dedicated spoke virtual network** attached to the Virtual WAN hub. Shared resources like DNS servers, domain controllers, or management tools can't deploy inside the Virtual WAN hub itself due to platform restrictions. Place these services in a spoke network that connects to the hub to make them accessible across your entire Virtual WAN topology while maintaining proper isolation.

### Implement security controls

Security implementation in Virtual WAN requires careful consideration of multiple layers including network filtering, DDoS protection, and centralized policy enforcement. Deploy security controls that protect your network while maintaining performance and manageability.

1. **Deploy Azure Firewall in the virtual hub** for internet outbound protection and filtering. Azure Firewall provides centralized security policy enforcement across your network. Deploy firewall instances in secured virtual hubs through [Azure Firewall Manager](/azure/firewall-manager/overview) to filter traffic, enforce policies, and protect against threats. Review the latest [constraints](/azure/firewall-manager/overview#known-issues) before deployment.

1. **Deploy network virtual appliances into Virtual WAN hubs** when you need both SD-WAN connectivity and Next-Generation Firewall capabilities. [NVA firewalls](/azure/virtual-wan/about-nva-hub#security-provided-by-nva-firewalls) can connect on-premises devices and inspect all North-South, East-West, and Internet-bound traffic through the same appliance. This deployment model provides integrated security and connectivity while maintaining centralized management.

1. **Follow the partner vendor's guidance** when you deploy partner networking technologies and NVAs. Vendor-specific configuration requirements ensure optimal performance and prevent conflicting configurations with Azure networking. Work with your vendor's support team to validate your deployment architecture before implementation.

1. **Deploy a single Azure DDoS standard protection plan** in the connectivity subscription. Share this plan across all landing zone and platform VNets to ensure consistent DDoS protection across your environment. A single plan covers 100 public IP addresses and provides centralized management of DDoS protection policies. Note that Virtual WAN secured virtual hubs don't support Azure DDoS standard protection plans, so apply protection at the spoke VNet level. For more information, see the [Hub virtual network and secured virtual hub comparison](/azure/firewall-manager/vhubs-and-vnets#comparison).

### Manage and monitor your deployment

Proper management and monitoring ensure your Virtual WAN deployment operates reliably and provides visibility into network performance, connectivity issues, and capacity utilization. Establish monitoring practices from the start to maintain operational excellence.

1. **Create Azure Virtual WAN and Azure Firewall resources** within the connectivity subscription. This resource organization centralizes network and security resources for consistent management and aligns with the Azure landing zone architecture. Separation of connectivity resources from application workloads provides clear ownership boundaries and simplifies governance.

1. **Use Azure Monitor insights** to monitor the end-to-end topology of your Virtual WAN. [Insights in Azure Monitor for Virtual WAN (preview)](/azure/virtual-wan/azure-monitor-insights) provide visibility into network status, connection health, and [key metrics](/azure/virtual-wan/azure-monitor-insights#detailed) for proactive management. Configure alerts for critical thresholds to detect and respond to issues before they affect users.

### Migrate existing hub-and-spoke topologies

Organizations with existing hub-and-spoke network architectures can migrate to Virtual WAN to gain simplified management and enhanced transit capabilities. Migration requires careful planning to minimize disruption while transitioning to the new architecture.

1. **Use the migration guide for brownfield scenarios** where you migrate from a hub-and-spoke network topology not based on Virtual WAN. The [Migrate to Azure Virtual WAN](/azure/virtual-wan/migrate-from-hub-spoke-topology) guide provides detailed steps to transition your existing architecture. Follow the phased approach to minimize downtime and validate connectivity at each stage before proceeding.
