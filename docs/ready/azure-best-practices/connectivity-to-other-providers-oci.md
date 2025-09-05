---
title: Connectivity to Oracle Cloud Infrastructure (OCI)
description: Learn how to establish secure, high-performance connectivity between Azure and Oracle Cloud Infrastructure using ExpressRoute and FastConnect. Get expert guidance on hybrid cloud architecture design.
author: stephen-sumner
ms.author: sitarant
ms.date: 09/05/2025
ms.topic: conceptual
ms.custom: think-tank
---

# Connectivity to Oracle Cloud Infrastructure

This article provides proven connectivity approaches to integrate an Azure landing zone architecture with Oracle Cloud Infrastructure (OCI). Azure organizations establish secure, high-performance connections to OCI workloads through ExpressRoute and FastConnect integration. These cross-cloud connections enable hybrid cloud scenarios that maximize the capabilities of both Microsoft Azure and Oracle Cloud platforms.

## Establish ExpressRoute connectivity to OCI

ExpressRoute and FastConnect integration is the cornerstone for connecting Azure virtual networks with OCI virtual cloud networks. This enterprise-grade connectivity approach allows resources across both cloud platforms to communicate seamlessly when private IP address spaces don't overlap. The Azure-OCI interconnect architecture delivers dedicated private network connectivity that eliminates internet routing for enhanced security and performance. For comprehensive information about the cross-cloud integration, see [Oracle application solutions integration](/azure/virtual-machines/workloads/oracle/oracle-oci-overview). For network planning considerations specific to Oracle databases, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-database-network-plan).

1. **Create the ExpressRoute circuit in the connectivity subscription.** The connectivity subscription is the recommended approach for centralizing network resources and provides consistent management for cross-cloud connections. Deploy the ExpressRoute circuit that connects Azure with OCI in this dedicated connectivity subscription to maintain separation of concerns and enable proper governance of network infrastructure. This Azure landing zone design pattern ensures network isolation and centralized network management. For guidance on subscription organization, see [Azure landing zone design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas).

2. **Implement ExpressRoute Metro for same-city deployments.** ExpressRoute Metro delivers enhanced connectivity within metropolitan areas with superior latency and bandwidth characteristics compared to standard ExpressRoute circuits. Verify whether your Azure and OCI resources are located in the same metropolitan area to take advantage of Metro connectivity benefits, including reduced latency and cost optimization. ExpressRoute Metro is available in select metropolitan areas including Amsterdam, Chicago, Madrid, Singapore, Washington DC, and others. For complete details about ExpressRoute Metro capabilities, see [About ExpressRoute Metro](/azure/expressroute/metro).

3. **Connect the ExpressRoute circuit to your hub network architecture.** Both traditional hub-and-spoke and Azure Virtual WAN topologies support OCI connectivity through ExpressRoute circuit integration. Connect the ExpressRoute circuit to your hub VNet or Virtual WAN hub to provide centralized connectivity that you can share across spoke networks and maintain consistent network policies. This hub-centric approach is the best practice for enterprise Azure networking architectures.

   :::image type="content" source="./media/azure-oci-hub-and-spoke.png" alt-text="Diagram showing Azure hub-and-spoke network topology with ExpressRoute connectivity to Oracle Cloud Infrastructure. The diagram displays an Azure hub virtual network connected to multiple spoke virtual networks, with an ExpressRoute circuit providing dedicated connectivity to OCI virtual cloud network. The hub contains an ExpressRoute gateway, and traffic flows between Azure spokes and OCI resources through the centralized hub architecture." lightbox="./media/azure-oci-hub-and-spoke.png" border="false":::

   *Figure 1: Interconnectivity between Azure and OCI via ExpressRoute.*

## Optimize network performance with FastPath

FastPath is the definitive solution for improving data path performance between Azure and OCI by bypassing the ExpressRoute gateway for virtual machine traffic. This FastPath optimization reduces latency and increases throughput for applications that demand high-performance connectivity between cloud platforms. FastPath represents a critical performance enhancement for enterprise workloads requiring optimal cross-cloud communication. For detailed information about FastPath capabilities, see [About ExpressRoute FastPath](/azure/expressroute/about-fastpath).

1. **Enable FastPath for latency-sensitive applications.** FastPath delivers direct network traffic routing to virtual machines in the virtual network, bypassing the ExpressRoute gateway for maximum performance gains. Deploy your application in a single VNet with an ExpressRoute gateway and FastPath enabled when your workload demands the lowest possible latency between Azure and OCI. This configuration represents the optimal architecture for latency-critical applications.

   :::image type="content" source="./media/azure-oci-one-vnet.png" alt-text="Diagram showing Azure single virtual network topology optimized for low latency connectivity to Oracle Cloud Infrastructure. The diagram displays a single Azure virtual network with an ExpressRoute gateway that has FastPath enabled, providing direct connectivity to OCI virtual cloud network. Virtual machines in the Azure VNet communicate directly with OCI resources, bypassing the gateway for optimal performance." lightbox="./media/azure-oci-one-vnet.png" border="false":::

   *Figure 2: Interconnectivity between Azure and OCI with a single VNet.*

2. **Deploy Ultra Performance or ErGw3AZ gateway SKUs for FastPath.** FastPath requires specific ExpressRoute gateway SKUs (stock keeping units - pricing tiers) to function properly while maintaining route exchange capabilities. Deploy either the Ultra Performance SKU or the ErGw3AZ SKU for your ExpressRoute gateway to enable FastPath functionality and ensure proper route management between Azure and OCI networks. These gateway SKUs are the only supported configurations for FastPath enablement. For comprehensive information, see [ExpressRoute virtual network gateways](/azure/expressroute/expressroute-about-virtual-network-gateways).

3. **Understand FastPath limitations before implementation.** FastPath has specific limitations that directly impact network architecture design decisions. Not all FastPath features are available on every circuit type. FastPath is supported on ExpressRoute Direct and ExpressRoute provider circuits, but certain features (for example, virtual network peering over FastPath or Private Link/Private Endpoint support) are limited to ExpressRoute Direct or require enrollment. FastPath also doesn't support Azure Virtual WAN hubs and has complex behavior with internal load balancers in spoke virtual networks, where traffic can still go through the gateway. Review the current FastPath limitations and design your network architecture to avoid compatibility issues that could impact your hybrid cloud connectivity strategy. For comprehensive limitations documentation, see [About ExpressRoute FastPath](/azure/expressroute/about-fastpath).

## Design for availability zones and latency optimization

Availability zone placement is a critical factor that affects latency between Azure and OCI resources and requires careful consideration of performance versus availability requirements. The geographic distribution of your workloads influences the optimal placement strategy for reducing cross-cloud communication delays. Proper availability zone planning ensures both resilience and performance optimization for Azure-OCI hybrid architectures. For comprehensive information about availability zones, see [Availability zones overview](/azure/reliability/availability-zones-overview).

1. **Conduct thorough latency testing across availability zones.** Availability zone placement directly impacts latency between Azure and OCI resources and affects application performance. Deploy test virtual machines in different availability zones and measure latency to OCI resources to identify which availability zone provides optimal performance for your specific workload requirements. This testing approach ensures data-driven placement decisions.

2. **Architect for balanced availability and performance requirements.** Availability zones provide resilience but introduce latency variations that affect application performance. Design your application architecture to balance high availability needs with performance requirements, considering whether workload distribution across availability zones or concentration in a single optimal availability zone better serves your business objectives. This architectural decision is fundamental to Azure-OCI hybrid success.

3. **Validate regional availability for interconnectivity.** Azure-OCI interconnectivity is available only in specific regional pairs and limits deployment options. Confirm that your target Azure and OCI regions support direct interconnectivity before finalizing your architecture design to avoid unexpected connectivity limitations or additional routing complexity. Regional validation is essential for successful Azure-OCI integration planning. For the current list of supported regions, see [Oracle application solutions integration](/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

## Implement operational access patterns

Operational access to OCI resources from Azure requires specific connectivity patterns that deliver secure and efficient management capabilities. These connectivity patterns enable consistent operational practices across both cloud platforms while maintaining security boundaries. Proper operational access design is crucial for effective Azure-OCI hybrid management.

1. **Deploy jump boxes for secure OCI resource management from Azure.** Jump boxes deliver secure access to OCI virtual cloud networks from Azure environments without exposing OCI resources directly. Deploy a jump box in a spoke VNet connected to your hub network to establish a secure operational bridge that allows Azure-based management tools to access OCI resources while maintaining network isolation. As a managed alternative to self-managed jump boxes, use [Azure Bastion](/azure/bastion/bastion-overview) to provide secure, browser-based RDP/SSH access without exposing management ports. This jump box approach is the recommended pattern for secure cross-cloud operations.

   :::image type="content" source="./media/azure-oci-jump-box-one-vnet.png" alt-text="Diagram showing Azure operational access pattern using a jump box to manage Oracle Cloud Infrastructure resources. The diagram displays an Azure virtual network containing a jump box virtual machine that provides secure administrative access to OCI virtual cloud network through ExpressRoute connectivity. The jump box serves as a secure bridge for Azure-based management tools to operate OCI resources while maintaining network isolation and security boundaries." lightbox="./media/azure-oci-jump-box-one-vnet.png" border="false":::

   *Figure 3: Managing OCI resources from Azure via a jump box.*

2. **Implement ExpressRoute Global Reach for on-premises to OCI connectivity.** ExpressRoute Global Reach enables direct connectivity from on-premises networks to OCI through existing Azure ExpressRoute circuits. Connect your existing on-premises ExpressRoute circuit to the OCI ExpressRoute circuit to allow the Microsoft Enterprise Edge (MSEE) router to serve as the central routing point, but calculate bandwidth costs using the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) before implementing this ExpressRoute approach for large data migration scenarios. ExpressRoute Global Reach represents the optimal solution for on-premises to OCI connectivity. For comprehensive information, see [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach).

   :::image type="content" source="./media/azure-oci-gr-hub-and-spoke.png" alt-text="Diagram showing ExpressRoute Global Reach connectivity pattern enabling on-premises access to Oracle Cloud Infrastructure through Azure. The diagram displays an on-premises network connected to Azure hub-and-spoke topology via ExpressRoute, with Global Reach linking the on-premises ExpressRoute circuit to a separate OCI ExpressRoute circuit. The Microsoft Enterprise Edge (MSEE) router serves as the central routing point, enabling direct communication between on-premises networks and OCI virtual cloud network while maintaining connectivity to Azure spoke networks." lightbox="./media/azure-oci-gr-hub-and-spoke.png" border="false":::

   *Figure 4: Managing OCI resources from on-premises via ExpressRoute Global Reach.*

## Key takeaways

Azure-OCI connectivity through ExpressRoute and FastConnect delivers enterprise-grade hybrid cloud capabilities. The recommended approach includes:

- **ExpressRoute circuit deployment** in dedicated connectivity subscriptions for centralized network management
- **FastPath implementation** with Ultra Performance or ErGw3AZ gateway SKUs for optimal performance
- **Availability zone optimization** through latency testing and architectural planning
- **Operational access patterns** using jump boxes or Azure Bastion for secure cross-cloud management
- **ExpressRoute Global Reach** for on-premises to OCI connectivity requirements

This Azure-OCI integration architecture enables seamless hybrid cloud operations while maintaining security, performance, and operational consistency across both platforms.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Networking | [Azure ExpressRoute](/azure/expressroute/expressroute-introduction) | Provides private connectivity between Azure and OCI through dedicated circuits |
| Networking | [ExpressRoute FastPath](/azure/expressroute/about-fastpath) | Improves data path performance by bypassing ExpressRoute gateway for VM traffic |
| Networking | [ExpressRoute Metro](/azure/expressroute/metro) | Enables enhanced connectivity within metropolitan areas for same-city deployments |
| Networking | [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) | Connects on-premises networks to OCI through existing Azure ExpressRoute circuits |
| Networking | [ExpressRoute virtual network gateways](/azure/expressroute/expressroute-about-virtual-network-gateways) | Provides gateway SKU guidance for FastPath enablement and route management |
| Planning | [Azure landing zone design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) | Offers subscription organization guidance for connectivity resources |
| Pricing | [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) | Calculates bandwidth costs for ExpressRoute Global Reach and data migration scenarios |
| Documentation | [Oracle application solutions integration](/azure/virtual-machines/workloads/oracle/oracle-oci-overview) | Provides comprehensive guidance for Azure-OCI interconnectivity and regional availability |
| Configuration | [Configure Azure-OCI networking](/azure/virtual-machines/workloads/oracle/configure-azure-oci-networking) | Provides step-by-step guidance for configuring network connectivity between Azure and OCI |
| Documentation | [Availability zones overview](/azure/reliability/availability-zones-overview) | Explains availability zone concepts for latency optimization planning |

## Next steps

> [!div class="nextstepaction"]
> [Connectivity to other cloud providers](./connectivity-to-other-providers.md)
