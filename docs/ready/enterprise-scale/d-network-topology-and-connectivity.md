---
title: "Network topology and connectivity"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Network Topology and Connectivity
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# D. Network topology and connectivity

![Network topology and connectivity](./media/net-con.png)
_Figure 6: Networking and connectivity_

This section will examine key design considerations and recommendations surrounding networking and connectivity to/from Azure, as well as within Azure.

## 1. Planning for IP addressing

It is vital that enterprise customers plan for IP addressing in Azure to ensure there is no overlapping IP address space across considered on-premises locations and Azure regions.

**Design considerations:**

- Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

- While virtual network address space can be added after creation, this process will mandate an outage if the virtual network is already connected to another virtual network via peering; virtual network peering will have to be deleted and re-created.

- Azure reserves five IP addresses within each subnet that should be factored in when sizing virtual networks and encompassed subnets.

- Some Azure services require [dedicated subnets](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network), such as Azure Firewall or virtual network gateways.

- Subnets can be delegated to certain services to create instances of that service within the subnet.

**Design recommendations:**

- Plan for non-overlapping IP address spaces across Azure regions and on-premises locations well in advance.

- Use IP addresses from the address allocation for private internet connections (RFC 1918).

- For environments with limited private IP addresses (RFC 1918) availability, consider using IPv6.

<!-- -->

- Do not create unnecessarily large virtual networks (such as /16). This helps ensure that IP address space isn't wasted.

- Do not create virtual networks without planning the required address space in advance, since adding address space will cause an outage once a virtual network is connected via virtual network peering.

- Do not use public IP addresses for virtual networks, especially if the public IP addresses do not belong to the customer.

## 2. Configure DNS and name resolution for on-premises and Azure resources

DNS is a critical design topic in the overall CAF enterprise-scale landing zone architecture. While some customers may want to use their existing investments in DNS, others may see cloud adoption as an opportunity to modernize their internal DNS infrastructure and optimize native Azure capabilities.

**Design considerations:**

- A DNS resolver can be used in conjunction with Azure Private DNS for cross-premises connectivity.

- Customers may require the use of existing DNS solutions across on-premises and Azure.

**Design recommendations:**

- Use Azure Private DNS for name resolution within Azure virtual networks.

- Autoregistration should be enabled for Azure DNS to automatically manage DNS record lifecycles for the virtual machines deployed within a virtual network.

- Use a virtual machine as a resolver for cross-premises DNS resolution with Azure DNS.

  - This is a short-term solution since an Azure native resolver is on the Azure Private DNS roadmap.

- Create the Azure Private DNS zone within a global "connectivity" subscription.

## 3. Define an Azure networking topology

Network topology is a critical foundational element of the CAF enterprise-scale landing zone architecture as it ultimately defines how applications can communicate with one another. This section will explore relevant technologies and topology approaches for enterprise Azure deployments.

**Design considerations:**

- Azure Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises with capabilities such as communication between virtual hubs, but it also introduces new capabilities, such as large-scale/high-throughput VPN gateways and Firewall Manager for centrally managing multiple Azure firewalls distributed across virtual WAN virtual hubs.

- Virtual networks support up to 500 virtual network peering connections.

- ExpressRoute with private peering supports advertising up to 200 prefixes from Azure to on-premises.

**Design recommendations:**

- Azure Virtual WAN is highly recommended for new large/global network deployment in Azure.

  - The following illustration depicts a sample global customer deployment with datacenters spread across Europe and the United States, as well as a large number of branch offices within both regions. The environment is globally connected via Azure Virtual WAN and ExpressRoute Global Reach.

![Example network topology](./media/eg-net-top.png)
_Figure 7: Example network topology_

- Use Azure Virtual WAN as a global connectivity resource, with a virtual hub per Azure region to connect multiple "landing zones" together across Azure regions via their local virtual hub.

- Connect virtual hubs to on-premises datacenters using ExpressRoute.

- Connect branches/remote locations to the nearest virtual hub via VPN.

- If third-party network virtual appliances are required, deploy them to a separate virtual network (e.g., NVA virtual network) and connect it to the regional virtual hub.

- Use [Azure Monitor network insights](/azure/azure-monitor/insights/network-insights-overview) (currently in preview) to monitor the end-to-end state of customer networks on Azure.

- If Azure Virtual WAN is not used, deploy global networking infrastructure using Azure virtual networks in a hub and spoke model.

  - Deploy shared infrastructure, such as ExpressRoute gateways and Azure Firewall, within the central virtual network connected to "landing zones" via virtual network peering.

<!-- -->

- Do not deploy networking overlay technologies on top of Azure networking.

- Avoid creating complex networking topologies with Azure virtual networks if the scenario can be satisfied more easily with Azure Virtual WAN.

- Do not create more than 200 peering connections per virtual WAN virtual hub.

  - While virtual networks support up to 500 virtual network peering connections, ExpressRoute with private peering only supports advertising up to 200 prefixes from Azure to on-premises.

## 4. Connectivity to Azure

This section will expand on the network topology to consider recommended models for connecting on-premises locations to Azure.

**Design considerations:**

- Azure ExpressRoute provides dedicated private connectivity to Microsoft Azure services (IaaS and PaaS) from on-premises locations.

- Private Link can be used to establish connectivity to PaaS services over ExpressRoute with private peering.

- When multiple virtual networks are connected to the same ExpressRoute circuit, they will become part of the same routing domain.

- ExpressRoute Global Reach (where available) allows customers to connect on-premises locations together using ExpressRoute circuits to transit traffic over the Microsoft backbone network.

- ExpressRoute Global Reach is not available in all ExpressRoute peering locations.

**Design recommendations:**

- Use ExpressRoute as the primary connectivity channel for connecting on-premises network to Microsoft Azure.

  - Use private peering with Private Link to establish connectivity to PaaS services.

  - VPNs can be used as a source of backup connectivity to enhance connectivity resiliency.

- Use dual ExpressRoute circuits from different peering locations when connecting an on-premises location to virtual networks in Azure. This setup will ensure redundant paths to Azure, ensuring there are no single points of failure between on-premises and Azure.

- When multiple ExpressRoute circuits are used, avoid asymmetric routing by using BGP local preference and as path prepending.

- Ensure the right SKU is used for the ExpressRoute/VPN gateways based on bandwidth and performance requirements.

- Deploy a zone-redundant ExpressRoute gateway in the supported Azure regions.

- For scenarios that require bandwidth higher than 10 Gbps or dedicated 10/100 Gbps ports, use ExpressRoute Direct.

  - When very low latency is required or when throughput from on-premises to Azure must be greater than 10 Gbps, enable FastPath to bypass the ExpressRoute gateway from the data path.

- Use VPN gateways to connect branches or remote locations to Azure.

  - For higher resiliency, deploy zone-redundant gateways (where available).

- Use ExpressRoute Global Reach to connect large offices /regional headquarters that are connected to Azure via ExpressRoute.

- When traffic isolation or dedicated bandwidth is required, such as for separating production and nonproduction environments, different ExpressRoute circuits should be used to ensure isolated routing domains and to alleviate noisy neighbor risks.

- Proactively monitor ExpressRoute circuits using network performance monitor.

- Do not explicitly use ExpressRoute circuits from a single peering location, which creates a single point of failure, making the customer highly susceptible to peering location outages.

- Do not use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth to avoid "noisy neighbor" risks.

## 5. Connectivity within Azure

This section will explore recommended models for connecting resources within Azure together.

**Design considerations:**

- Azure Virtual WAN provides inter-region connectivity between virtual hubs (currently in preview).

- Virtual network peering can be used to connect virtual networks in the same region, across different Azure regions, and even across different Azure AD tenants.

- Virtual network peering applies nontransitive routing.

- There are [limitations](/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks) associated with global virtual network peering.

- ExpressRoute circuits can be used to establish connectivity across virtual networks within the same geo-political region or by using the premium add-on for connectivity across geo-political regions.

  - Virtual network to virtual network traffic may experience additional latency since traffic must hairpin at the MSEE

  - Bandwidth will be constrained to the ExpressRoute gateway SKU.

  - Customers must still deploy and manage UDRs should they require inspection/logging for cross-virtual network traffic.

**Design recommendations:**

- It is recommended to follow the principle of “**traffic in Azure stays in Azure**” for communication to travel across resources in Azure via the Microsoft backbone network, even when they're in different regions.

- Use Azure Virtual WAN to establish global connectivity across customer networks in Azure, with traffic routed across regions between virtual hubs (currently in preview).

- Connect virtual networks in an Azure region to an Azure Virtual WAN virtual hub in the same region using virtual network peering.

- Use virtual network peering to connect different virtual networks in Azure together.

- When Azure Virtual WAN is not being used, connect virtual networks across Azure regions via global virtual network peering.

- Only consider ExpressRoute as an alternative to connect virtual networks across Azure after previous options (virtual WAN or global virtual network peering) have been evaluated and determined unsuitable for the customer's scenario.

- Use Azure Firewall or an NVA to enable transitive routing across virtual networks connected via peering.

<!-- -->

- Do not use existing on-premises network (e.g., MPLS) to connect Azure resources across Azure regions.

- Do not implement forced tunneling to enable communication from Azure to Azure resources.

- Do not develop an overly complex Azure networking architecture to connect Azure regions across the world.

## 6. Connectivity to Azure PaaS services

Building on the previous connectivity sections, this section will explore recommended connectivity approaches when using Azure PaaS services.

**Design considerations:**

- Azure PaaS services are typically accessed over public endpoints, however, the Azure platform provides capabilities to secure such endpoints or even make them entirely private.

  - Virtual network injection provides dedicated private deployments for supported services.

  - [Private Link](/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access using private IP addresses to Azure PaaS instances, or custom services behind an Azure load balancer standard.

  - Virtual network service endpoints provide service level access from selected subnets to selected PaaS services.

- Enterprise customers often have concerns about how to appropriately mitigate public endpoints for PaaS services.

- For supported services, Private Link addresses data exfiltration concerns associated with service endpoints.

  - Alternately, outbound filtering via NVAs can be used to provide data exfiltration risk mitigations.

**Design recommendations:**

- Use virtual network injection for supported Azure services to make them available from within a customer virtual network.

- Azure PaaS services that have been injected into a virtual network still perform management plane operations using public IP addresses. Ensure that this communication is locked down within the virtual network using UDRs and NSGs.

- Use Azure Private Link, where available, for Azure PaaS services that cannot be injected into a .NET.

  - Azure Private Link is in public preview for numerous [services](/azure/private-link/private-endpoint-overview#private-link-resource), and customer requirements should be carefully aligned with the product [roadmap](https://aka.ms/privatepaas).

- Access Azure PaaS services from on-premises via ExpressRoute private peering, using either virtual network injection for dedicated Azure services or Azure Private Link for available shared Azure services.

- Use virtual network service endpoints to secure access to Azure PaaS services from within a customer virtual network, but only when Private Link is not available and when there are no data exfiltration concerns.

  - Use NVA filtering to address potential data exfiltration scenarios when using virtual network service endpoints.

  - Use virtual network service endpoint policies for Azure Storage.

- Do not enable virtual network service endpoints by default on all subnets.

- Do not use virtual network service endpoints when there are data exfiltration concerns, unless NVA filtering is used.

## 7. Planning for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.

**Design considerations:**

- Azure native network security services such as Azure Firewall, Application Gateway WAF, and Azure Front Door WAF are fully managed services, meaning that customers do not incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

- The CAF enterprise-scale landing zone architecture is fully compatible with third-party network virtual appliances, should the customer prefer to use NVAs or for situations where native services do not satisfy specific customer requirements.

**Design recommendations:**

- Use Azure Firewall to govern outbound traffic to the internet and nonHTTP/S inbound connections.

- Use Firewall Manager with Azure Virtual WAN to deploy and manage Azure firewalls across virtual hubs.

- Configure supported third-party SaaS security providers within Firewall Manager if the customer wishes to use such solutions to protect outbound connections.

- Use Azure DDoS Protection Standard plans to protect all public endpoints hosted within customer virtual networks.

- Use Application Gateway WAF within a "landing zone" virtual network for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a "landing zone”.

- If third-party NVAs are used, they should be deployed into a separate virtual network (e.g., NVA virtual network) and connected to a regional virtual hub via peering.

- If third-party NVAs are used, deployments should follow vendor best practice recommendations, with particular attention to highly available and Azure-certified architecture.

<!-- -->

- Do not replicate on-premises DMZ concepts and architectures into Azure.

## 8. Define network encryption requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

**Design considerations:**

- Cost and available bandwidth are inversely proportional to length of encryption tunnel between endpoints.

- When using VPN to connect to Azure, traffic is encrypted over the internet via IPsec tunnels.

- When using ExpressRoute with private peering, traffic is not currently encrypted.

- MACsec encryption can be applied to ExpressRoute Direct to achieve network encryption.

- Azure does not currently offer native encryption over global virtual network peering. However, work is being conducted to encrypt all Azure to Azure traffic using MACsec, which is expected to be available by the end of 2020.

  - If encryption between Azure regions is required today, it is possible to connect virtual networks using VPN gateways rather than global virtual network peering.

**Design recommendations:**
![Encryption flows](./media/enc-flows.png)
_Figure 8: Encryption flows_

<!-- docsTest:ignore "Flow A" "Flow B" L2 MSEE Gigamon VTAP -->

- When establishing VPN connections from on-premises to Azure using VPN gateways, traffic is encrypted at a protocol level using IPsec tunnels, as depicted in Flow A in the diagram above.

- When using ExpressRoute Direct, configure [MACsec](/azure/expressroute/expressroute-howto-macsec) to encrypt traffic at l2 level between the customer's routers and msee, as depicted in Flow B in the diagram above.

- When using regular ExpressRoute circuits, use Azure Virtual WAN VPN gateway to establish [IPsec tunnels over ExpressRoute](/azure/virtual-wan/vpn-over-expressroute) private peering. This is depicted by flow c in the diagram above.

  - If additional scale or capabilities are required, use third-party NVAs connected to Azure Virtual WAN.

- If traffic between Azure regions must be encrypted, use VPN gateways to connect virtual networks across regions. MACsec encryption across regions is being rolled out, but the capability is not available yet.

<!-- -->

- Do not use third-party NVAs in Azure to encrypt traffic over ExpressRoute private peering without first validating native Azure capabilities as depicted in Flow B and flow c above.

## 9. Planning for traffic inspection

In many industries, customers require that traffic in Azure--particularly, inbound and outbound internet traffic--mirrors a network packet collector for deep inspection and analysis. This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure virtual networks.

**Design considerations:**

- The Azure Virtual Network tap (vtap) preview is not currently available, and there is no eta to resume its availability.

- Network Watcher packet captures are limited to a maximum period of five hours.

**Design recommendations:**

- Use Network Watcher packet capture despite the limited capture window.

- Evaluate if NSG flow logs v2 provide the level of detail required.

- Use third-party solutions such as Gigamon for scenarios where sustained deep-packet inspection is required.

<!-- -->

- Do not block Azure deployments just because VTAP is unavailable.

- Do not develop a custom solution to mirror traffic. While this may be acceptable for small-scale scenarios, this approach is not encouraged at scale due to complexity and supportability issues that may arise.

## Next steps

Suggested design for [management and monitoring](./e-management-and-monitoring.md).

> [!div class="nextstepaction"]
> [Management and monitoring](./e-management-and-monitoring.md)
