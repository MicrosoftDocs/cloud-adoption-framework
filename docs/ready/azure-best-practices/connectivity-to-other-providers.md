---
title: Connectivity to other cloud providers
description: Integrate an Azure enterprise-scale landing zone architecture to other cloud providers such as Amazon Web Services (AWS) and Google Cloud.
author: stephen-sumner
ms.author: sitarant
ms.date: 09/05/2025
ms.topic: concept-article
ms.custom:
  - sfi-image-nochange
---

# Connectivity to other cloud providers

This article explains how to connect Azure landing zone architectures to other cloud providers, such as Amazon Web Services (AWS) and Google Cloud. Organizations need reliable, secure, and high-performance cross-cloud connectivity to run enterprise hybrid and multi-cloud workloads with predictable network behavior.

> [!NOTE]
> Microsoft and Oracle partnered to provide high-throughput, low-latency cross-connections between Azure and Oracle Cloud Infrastructure (OCI). For more information, see [Connectivity to Oracle Cloud Infrastructure](./connectivity-to-other-providers-oci.md).

## Evaluate connectivity options

Three cornerstone connectivity architectures establish enterprise-grade connections between Azure and other cloud providers. Organizations must systematically assess these cross-cloud connection methodologies based on their specific requirements for network performance, security posture, and operational complexity.

1. **Option 1 - Choose ExpressRoute with customer-managed routing for maximum control and performance optimization.** ExpressRoute (Azure's private circuit service) with customer-managed routing connects ExpressRoute circuits to the other cloud provider's private connection (for example, [AWS Direct Connect](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Welcome.html) or [Google Cloud Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect)). This approach gives you full control over BGP (Border Gateway Protocol) routing decisions and traffic engineering. It requires advanced networking expertise to operate and troubleshoot complex multi-cloud routing configurations, but it offers the most flexibility for performance tuning. For more, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).

2. **Option 2 - Select ExpressRoute with cloud exchange provider for simplified operational management.** ExpressRoute with cloud exchange provider routing connects the same private circuits through third-party providers like [Equinix Cloud Exchange](https://www.equinix.com/interconnection-services/cloud-exchange-fabric), [Megaport](https://www.megaport.com/), or [PacketFabric](https://www.packetfabric.com/) but transfers routing complexity and operational overhead to the exchange provider. This strategic approach reduces day-to-day operational burden while maintaining private connectivity performance benefits and predictable latency characteristics. For available cloud exchange providers and locations, see [ExpressRoute connectivity partners and peering locations](/azure/expressroute/expressroute-locations).

3. **Option 3 - Use Site-to-Site VPN for cost-effective internet-based connectivity when private circuits aren't feasible.** Site-to-Site VPN over the public internet offers the most accessible and rapid deployment option when private circuits aren't available, cost-effective, or technically required for the specific workload demands. This method provides encrypted secure connectivity but with potentially lower throughput performance and higher latency variability compared to ExpressRoute private connectivity options. For detailed implementation guidance, see [What is Azure VPN Gateway?](/azure/vpn-gateway/vpn-gateway-about-vpngateways)

Use the following cross-cloud connectivity flow chart to select the appropriate option:

:::image type="complex" source="./media/cloud-interconnect-decision-tree.png" alt-text="Decision flow chart for selecting cross-cloud connectivity options between Azure and other cloud providers.":::
   The flow chart guides organizations through a decision-making process to choose between ExpressRoute with customer-managed routing, ExpressRoute with cloud exchange provider, or Site-to-Site VPN connectivity. The chart includes decision points for performance requirements, operational complexity, cost considerations, and deployment timeline constraints. Each path leads to specific recommendations based on organizational needs and technical capabilities.
:::image-end:::

Figure 1: Cross-cloud connectivity flow chart

## Plan network architecture requirements

Network architecture design fundamentals determine connectivity success between Azure and other cloud providers. Organizations must systematically address specific technical requirements and performance characteristics to ensure successful cross-cloud communication with enterprise-grade reliability.

1. **Verify non-overlapping IP address spaces before establishing connections to prevent routing conflicts.** Azure virtual networks (VNets) can only connect to another cloud provider's virtual private cloud (VPC) when private IP address ranges don't overlap anywhere in the topology. Plan IP address allocation across clouds during design. Use CIDR (Classless Inter-Domain Routing) planning tools and a centralized IP address management (IPAM) system for multi-cloud deployments.

2. **Evaluate performance requirements against connection options for optimal workload performance.** Site-to-Site VPN (IPsec-based VPN over the internet) typically has lower throughput and more variable latency than ExpressRoute private connectivity. ExpressRoute gives predictable bandwidth and consistent latency that suit demanding enterprise workloads. ExpressRoute provider circuits commonly offer 50 Mbps–10 Gbps. [ExpressRoute Direct](/azure/expressroute/expressroute-erdirect-about) supports 10 Gbps and 100 Gbps ports and can host logical circuits up to those capacities.

3. **Assess deployment timeline constraints for connection methods and business continuity planning.** Site-to-Site VPN offers the fastest deployment option when Azure ExpressRoute and other cloud provider private connectivity equivalents aren't already established in your network infrastructure. Organizations can implement VPN connections within days while planning longer-term private connectivity solutions that may require weeks or months for provisioning and configuration.

4. **Consider routing complexity and operational overhead when selecting connection methods.** Customer-managed ExpressRoute routing increases operational complexity and requires networking expertise if you don't use a cloud exchange provider. Weigh the benefits of granular control against the cost of BGP routing management, traffic engineering, and ongoing network operations.

5. **Plan for DNS resolution between cloud environments with cost considerations.** DNS resolution between Azure and other cloud providers requires additional configuration, specialized DNS forwarding rules, and incurs extra operational costs. Design DNS architecture strategically to support seamless name resolution across cloud platforms while managing associated expenses through DNS zone planning and conditional forwarding strategies. For implementers, see the [DNS Private Resolver overview](/azure/dns/dns-private-resolver-overview) for a managed DNS forwarding solution.

## Optimize performance with FastPath

FastPath technology serves as a cornerstone feature that enhances network performance between Azure and other cloud providers. Organizations can use FastPath to dramatically reduce latency and improve data transfer efficiency in cross-cloud scenarios by bypassing traditional gateway processing bottlenecks.

1. **Enable FastPath to bypass ExpressRoute gateway processing and achieve optimal network performance.** FastPath (an ExpressRoute data-path optimization) sends network traffic directly to virtual machines in a VNet and bypasses gateway data-plane processing. This reduces latency and increases throughput for supported scenarios. For details and compatibility rules, see [About ExpressRoute FastPath](/azure/expressroute/about-fastpath).

2. **Implement FastPath on ExpressRoute circuits based on performance requirements and circuit specifications.** FastPath is available on both ExpressRoute Direct circuits and ExpressRoute provider circuits, with different IP address limits depending on the specific circuit type and bandwidth allocation. Organizations can enable this performance optimization feature across their ExpressRoute infrastructure to optimize network performance, considering the specific technical limitations for each circuit type and bandwidth tier.

3. **Deploy virtual network gateway with appropriate SKU specifications for FastPath functionality.** FastPath requires a virtual network gateway for essential route exchange purposes even though data traffic bypasses this gateway during normal operations. Use either the Ultra Performance SKU or the ErGw3AZ SKU for the ExpressRoute gateway to enable proper route management and optimal FastPath functionality. For detailed gateway SKU specifications and performance characteristics, see [About ExpressRoute virtual network gateways](/azure/expressroute/expressroute-about-virtual-network-gateways).

4. **Review FastPath limitations systematically before implementation to ensure compatibility.** Some configurations don't support FastPath, for example UDRs (user-defined routes) on the gateway subnet or specific network security group settings. Check FastPath compatibility against your current network design before enabling it. For full limitations, see [FastPath limitations](/azure/expressroute/about-fastpath#limitations).

## Implement connectivity solutions

Implementation approach serves as the foundation that determines the success of cross-cloud connectivity deployment. Organizations must follow specific technical steps and architectural best practices to establish reliable, high-performance connections between Azure and other cloud providers with enterprise-grade reliability.

1. **Choose private connectivity over internet-based connections for production workloads and mission-critical applications.** Private connectivity through ExpressRoute provides comprehensive service-level agreements, predictable throughput performance, and enhanced security posture compared to internet-based connections. Select customer-managed routing or cloud exchange provider based on organizational networking expertise, operational requirements, and performance optimization needs. ExpressRoute circuits offer guaranteed bandwidth with a high availability SLA. For more information, see [ExpressRoute SLA](https://azure.microsoft.com/support/legal/sla/expressroute/).

2. **Create ExpressRoute circuits in the connectivity subscription for proper resource organization.** Put ExpressRoute circuits in a dedicated connectivity subscription (a subscription used for networking resources). This helps centralize resource organization, billing, and access control. This practice aligns with [Azure landing zone architectural principles](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

3. **Connect ExpressRoute circuits to appropriate Azure network topology based on architectural patterns.** Link ExpressRoute circuits to the hub virtual network in a hub-and-spoke design or to the virtual hub in Azure Virtual WAN (a managed hub service). This ensures correct traffic flow, network segmentation, and policy enforcement. For Virtual WAN guidance, see [Virtual WAN network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/virtual-wan-network-topology).

4. **Consider ExpressRoute Metro for same-city deployments to optimize latency and costs.** ExpressRoute Metro provides enhanced connectivity options with reduced latency characteristics for deployments within the same metropolitan area. This option can significantly reduce network latency and operational costs for organizations with resources in close geographic proximity while maintaining high bandwidth capabilities. For detailed technical specifications, see [About ExpressRoute Metro](/azure/expressroute/metro).

:::image type="complex" source="./media/eslz-other-cloud-providers.png" alt-text="Architecture diagram showing cross-cloud connectivity using ExpressRoute with customer-managed routing.":::
   The diagram displays an on-premises network connected to Azure through ExpressRoute, with customer-managed BGP routing extending connectivity to another cloud provider (AWS or Google Cloud) through their respective private connectivity services (Direct Connect or Cloud Interconnect). The architecture shows ExpressRoute circuits, virtual network gateways, and cross-cloud routing paths managed by the customer organization for maximum control over traffic engineering and routing decisions.
:::image-end:::

Figure 2: Cross-cloud connectivity with customer-managed routing (Option 1)

:::image type="complex" source="./media/other-cloud-exchange-provider.png" alt-text="Architecture diagram showing cross-cloud connectivity using ExpressRoute with a cloud exchange provider.":::
   The diagram illustrates connectivity between on-premises networks, Azure, and other cloud providers through a third-party cloud exchange provider such as Equinix, Megaport, or PacketFabric. The cloud exchange provider manages the routing complexity and interconnections between multiple cloud platforms, simplifying operational overhead while maintaining private connectivity performance. The architecture shows how the exchange provider serves as the central routing hub for multi-cloud connectivity.
:::image-end:::

Figure 3: Cross-cloud connectivity with a cloud exchange provider (Option 2)

## Deploy optimized network configurations

Network configuration optimization ensures maximum performance and enterprise-grade reliability for cross-cloud connections. Organizations must implement specific deployment patterns and architectural configurations based on their performance requirements and connectivity objectives to achieve optimal cross-cloud network performance.

1. **Deploy single virtual network architecture for latency-sensitive applications requiring minimal network latency.** Applications requiring minimal network latency between Azure and other cloud providers benefit significantly from deployment in a single virtual network with an ExpressRoute gateway and FastPath enabled. This optimized configuration minimizes network path complexity and reduces connection overhead to achieve optimal latency performance for critical workloads.

   :::image type="complex" source="./media/other-cloud-fast-path.png" alt-text="Architecture diagram showing cross-cloud connectivity with ExpressRoute FastPath enabled for optimal performance.":::
      The diagram demonstrates a single Azure virtual network with an ExpressRoute gateway that has FastPath enabled, providing direct connectivity to other cloud providers. FastPath bypasses the ExpressRoute gateway for virtual machine traffic, reducing latency and increasing throughput. The architecture shows how network traffic flows directly from Azure VMs to resources in other cloud providers, minimizing network hops and gateway processing delays for latency-sensitive applications.
   :::image-end:::

   Figure 4: Cross-cloud connectivity with FastPath enabled

2. **Use Site-to-Site VPN when ExpressRoute isn't available, cost-effective, or technically required.** Site-to-Site VPN over the public internet provides secure encrypted connectivity when private circuits aren't available, cost-effective, or necessary for the specific use case requirements. This approach supports organizations with less demanding performance requirements, budget constraints, or rapid deployment needs. For comprehensive implementation guidance, see [How to connect AWS and Azure using a BGP-enabled VPN gateway](/azure/vpn-gateway/vpn-gateway-howto-aws-bgp).

   :::image type="complex" source="./media/other-cloud-s2s-vpn.png" alt-text="Architecture diagram showing cross-cloud connectivity using Site-to-Site VPN over the public internet.":::
      The diagram illustrates secure encrypted connectivity between Azure and other cloud providers using Site-to-Site VPN tunnels over the public internet. The architecture shows VPN gateways in each cloud platform establishing IPsec tunnels for secure data transmission. This cost-effective approach provides encrypted connectivity when private circuits aren't available or required, supporting organizations with budget constraints or rapid deployment timelines while maintaining security through encryption protocols.
   :::image-end:::

   Figure 5: Cross-cloud connectivity using Site-to-Site VPN over the Internet

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Private Connectivity | [Azure ExpressRoute](/azure/expressroute/) | Provides dedicated private connections between Azure and other cloud providers with guaranteed bandwidth, 99.9% availability SLA, and predictable performance characteristics |
| Network Performance Optimization | [ExpressRoute FastPath](/azure/expressroute/about-fastpath) | Improves data path performance by reducing latency through bypassing the ExpressRoute gateway for direct virtual machine connectivity |
| Secure VPN Connectivity | [Site-to-Site VPN Gateway](/azure/vpn-gateway/tutorial-create-gateway-portal) | Enables encrypted secure connectivity over the internet between Azure and other cloud providers with BGP routing support |
| Metropolitan Area Connectivity | [ExpressRoute Metro](/azure/expressroute/metro) | Provides enhanced connectivity options for same-city deployments with reduced latency and optimized cost structure |
| Network Topology Management | [Azure Virtual WAN](/azure/virtual-wan/) | Supports cross-cloud connectivity through virtual hub connections for simplified network management and global connectivity |
| Cross-Cloud Integration | [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models) | Comprehensive guidance for establishing private connectivity between Azure and other cloud platforms using various deployment models |

## Next steps

To learn more about connectivity to Oracle Cloud Infrastructure (OCI), see [Connectivity to Oracle Cloud Infrastructure](./connectivity-to-other-providers-oci.md).