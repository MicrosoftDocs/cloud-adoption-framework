---
title: "Network Topology and Connectivity"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Network Topology and Connectivity
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# D. Network Topology and Connectivity

[![Network Topology and Connectivity](./media/net-con.png "Network Topology and Connectivity")](./media/net-con.png)

Figure 6 – Networking and Connectivity

This section will examine key design considerations and recommendations surrounding networking and connectivity to/from Azure, as well as within Azure.

## 1. Planning for IP Addressing

It is vital that enterprise customers plan for IP addressing in Azure to ensure there is no overlapping IP address space across considered on-premises locations and Azure regions.

***Design Considerations***

- Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

- While Virtual Network address space can be added after creation, this process will mandate an outage if the Virtual Network is already connected to another Virtual Network via peering, since the Virtual Network peering will have to be deleted and re-created.

- Azure reserves 5 IP addresses within each subnet which should be factored in when sizing Virtual Networks and encompassed subnets.

- Some Azure services do require [dedicated subnets](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network), such as Azure Firewall or Virtual Network Gateway.

- Subnets can be delegated to certain services to create instances of that service within the subnet.

***Design Recommendations***

- Plan for non-overlapping IP address spaces across Azure regions and on-premises locations well in advance.

- Use IP addresses from the address allocation for private internets (RFC 1918).

- For environments with limited private IP addresses (RFC 1918) availability, consider using IPv6.

<!-- -->

- Do not create unnecessarily large Virtual Networks (for example: /16) to ensure there is no unnecessary wastage of IP address space.

- Do not create Virtual Networks without planning the required address space in advance, since adding address space will cause an outage once a Virtual Network is connected via Virtual Network Peering.

- Do not use public IP addresses for Virtual Networks, especially if the public IP addresses do not belong to the customer.

## 2. Configure DNS and name resolution for on-premises and Azure resources

DNS is a critical design topic in the overall CAF enterprise-scale landing zone architecture, and while some customers may want to use their existing investments in DNS, others may see cloud adoption as an opportunity to modernize their internal DNS infrastructure and leverage native Azure capabilities.

***Design Considerations***

- A DNS resolver can be used in conjunction with Azure Private DNS for cross-premises connectivity.

- Customers may require the use of existing DNS solutions across on-premises and Azure.

***Design Recommendations***

- Use Azure Private DNS for name resolution within Azure Virtual Networks.

- Auto-registration should be enabled for Azure DNS to automatically manage the life cycle of the DNS records for the Virtual Machines deployed within a Virtual Network.

- Use a Virtual Machine as a resolver for cross-premises DNS resolution with Azure DNS.

    - This is a short-term solution since an Azure native resolver is on the Azure Private DNS roadmap.

- Create the Azure Private DNS zone within a global “Connectivity” subscription.

## 3. Define an Azure Networking Topology

Network topology is a critical foundational element of the CAF enterprise-scale landing zone architecture as it ultimately defines how applications can communicate with one another. This section will therefore explore relevant technologies and topology approaches for enterprise Azure deployments.

***Design Considerations***

- Azure Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises with capabilities such as VHub to VHub communication, but also, it introduces new capabilities, such as large-scale/high-throughput VPN Gateways and Firewall Manager for centrally managing multiple Azure Firewalls distributed across VWAN VHubs.

- Virtual Networks support up to 500 Virtual Network Peering connections.

- ExpressRoute with Private Peering supports advertising up to 200 prefixes from Azure to on-premises.

***Design Recommendations***

- Azure Virtual WAN is highly recommended for new large/global network deployment in Azure.

    - The following illustration depicts a sample global customer deployment with datacentres spread across Europe and the United States, as well as a large number of branch offices within both regions. The environment is globally connected via Azure Virtual WAN and ExpressRoute Global Reach.

[![Example Network Topology](./media/eg-net-top.png "Example Network Topology")](./media/eg-net-top.png)

Figure 7 – Example Network Topology

- Leverage Azure Virtual WAN as a global connectivity resource, with a VHub per Azure region to connect multiple “landing zones” together across Azure regions via their local VHub.

- Connect VHubs to on-premises data centres using ExpressRoute.

- Connect branches/remote locations to the nearest VHub via VPN.

- If third party network virtual appliances are required, deploy them to a separate Virtual Network (i.e. NVA VNet) and connect it to the regional VHub.

- Use [Azure Monitor Network Insights](/azure/azure-monitor/insights/network-insights-overview) (currently in preview) to monitor the end-to-end state of customer networks on Azure.

- If Azure VWAN is not used, deploy global networking infrastructure using Azure Virtual Networks in a hub and spoke model.

    - Deploy shared infrastructure, such as ExpressRoute Gateways and Azure Firewall, within the central VNet connected to “landing zones” via VNet peering.

<!-- -->

- Do not deploy networking overlay technologies on top of Azure networking.

- Avoid creating complex networking topologies with Azure Virtual Networks if the scenario can be satisfied more easily with Azure Virtual WAN.

- Do not create more than 200 peering connections per VWAN VHub.

    - While Virtual Networks support up to 500 VNet peering connections, ExpressRoute with Private Peering only supports advertising up to 200 prefixes from Azure to on-premises.

## 4. Connectivity to Azure

This section will expand on the network topology to consider recommended models for connecting on-premises locations to Azure.

***Design Considerations***

- Azure ExpressRoute provides dedicated private connectivity to Microsoft Azure services (IaaS and PaaS) from on-premises locations.

- Private Link can be used to establish connectivity to PaaS services over ExpressRoute with Private Peering.

- When multiple virtual networks are connected to the same ExpressRoute circuit, they will become part of the same routing domain.

- ExpressRoute Global Reach (where available) allows customers to connect on-premises locations together using ExpressRoute circuits to transit traffic over the Microsoft backbone network.

- ExpressRoute Global Reach is not available in all ExpressRoute peering locations.

***Design Recommendations***

- Use ExpressRoute as the primary connectivity channel for connecting on-premises network to Microsoft Azure.

    - Leverage Private Peering with Private Link to establish connectivity to PaaS services.

    - VPNs can be used as a source of backup connectivity to enhance connectivity resiliency.

- Use dual ExpressRoute circuits from different peering locations when connecting an on-premises location to Virtual Networks in Azure. This setup will ensure redundant paths to Azure, ensuring there are no single points of failure between on-premises and Azure.

- When multiple ExpressRoute circuits are used, avoid asymmetric routing by using BGP local preference and AS Path prepending.

- Ensure the right SKU is used for the ExpressRoute/VPN Gateways based on bandwidth and performance requirements.

- Deploy a Zone Redundant ExpressRoute Gateway in the supported Azure regions.

- For scenarios that require bandwidth higher than 10Gbps or dedicated 10/100 Gbps ports, use ExpressRoute Direct.

    - When very low latency is required, or throughput from on-premises to Azure must be greater than 10 Gbps, enable FastPath to bypass the ExpressRoute Gateway from the data path.

- Use VPN Gateways to connect branches or remote locations to Azure.

    - For higher resiliency, deploy Zone-Redundant Gateways (where available).

- Use ExpressRoute Global Reach to connect large offices /regional headquarters that are connected to Azure via ExpressRoute.

- When traffic isolation or dedicated bandwidth is required, such as for separating production and non-production environments, different ExpressRoute circuits should be used to ensure isolated routing domains and to alleviate noisy neighbour risks.

- Proactively monitor ExpressRoute circuits using Network Performance Monitor.

<!-- -->

- Do not explicitly use ExpressRoute circuits from a single peering location as it creates a single point of failure, making the customer highly susceptible to peering location outages.

- Do not use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth, so as to avoid “noisy neighbour” risks.

## 5. Connectivity within Azure

This section will explore recommended models for connecting resources within Azure together.

***Design Considerations***

- Azure Virtual WAN provides inter-region connectivity between VHubs (currently in preview).

- Virtual Network Peering can be used to connect Virtual Networks in the same region, across different Azure regions, and even across different AAD tenants.

- Virtual Network Peering applies not transitive routing.

- There are [limitations](/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks) associated with Global VNet Peering.

- ExpressRoute circuits can be used to establish connectivity across Virtual Networks within the same geo-political region or by leveraging the Premium add-on for connectivity across geo-political regions.

    - VNet to VNet traffic may experience additional latency since traffic must hairpin at the MSEE

    - Bandwidth will be constrained to the ExpressRoute Gateway SKU

    - Customers must still deploy and manage UDRs should they require inspection/logging for cross-VNet traffic.

***Design Recommendations***

- It is strongly recommended that the principal of “**traffic in Azure stays in Azure**” is followed, so that communication across resources in Azure, even if they are in different regions, occurs via the Microsoft backbone network.

- Use Azure Virtual WAN to establish global connectivity across customer networks in Azure, with traffic routed across regions from VHub to VHub (currently in preview).

- Connect Virtual Networks in an Azure region to an Azure Virtual WAN VHub in the same region using Virtual Network Peering.

- Use Virtual Network Peering to connect different VNets in Azure together.

- When Azure Virtual WAN is not being used, connect VNets across Azure regions via Global VNet Peering.

- Only consider ExpressRoute as an alternative to connect VNets across Azure after previous options (Virtual WAN or Global VNet peering) have been evaluated and determined not to be suitable for the customer’s scenario.

- Use Azure Firewall or an NVA to enable transitive routing across Virtual Networks connected via peering.

<!-- -->

- Do not use existing on-premises network (i.e. MPLS) to connect Azure resources across Azure regions.

- Do not implement forced tunnelling to enable communication from Azure to Azure resources.

- Do not develop an overly complex Azure networking architecture to connect Azure regions across the world.

## 6. Connectivity to Azure PaaS Services

Building on the previous connectivity sections, this section will explore recommended connectivity approaches when leveraging Azure PaaS services.

***Design Considerations***

- Azure PaaS services are typically accessed over public endpoints, however, the Azure platform provides capabilities to secure such endpoints or even make them entirely private.

    - VNet injection provides dedicated private deployments for supported services.

    - [Private Link](/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access using private IP addresses to Azure PaaS instances, or custom services behind a Azure Load Balancer Standard.

    - VNet Service Endpoints provide service level access from selected subnets to selected PaaS services.

- Enterprise customers often have concerns regarding public endpoints for PaaS services which must be appropriately mitigated.

- For supported services, Private Link addresses data exfiltration concerns associated with Service Endpoints.

    - Alternatively, outbound filtering via NVAs can be used to provide data exfiltration risk mitigations.

***Design Recommendations***

- Use VNet injection for supported Azure services to make them available from within a customer Virtual Network.

- Azure PaaS services that have been injected into a Virtual Network still perform management plane operations using public IP addresses. Ensure that this communication is locked down within the Virtual Network using UDRs and NSGs.

- Use Azure Private Link, where available, for Azure PaaS services that cannot be injected into a VNet.

    - Private Link is in public preview for numerous [services](/azure/private-link/private-endpoint-overview#private-link-resource), and customer requirements should be carefully aligned with the product [roadmap](https://aka.ms/privatePaaS).

- Access Azure PaaS services from on-premises via ExpressRoute Private Peering, using either VNet injection for dedicated Azure services or Azure Private Link for available shared Azure services.

- Use VNet Service Endpoints to secure access to Azure PaaS services from within a customer VNet, but only when Private Link is not available and when there are no data exfiltration concerns.

    - Use NVA filtering to address potential data exfiltration scenarios when using VNet Service Endpoints.

    - Use VNet Service Endpoint Policies for Azure Storage.

<!-- -->

- Do not enable VNet Service Endpoints by default on all subnets.

- Do not use VNet Service Endpoints when there are data exfiltration concerns, unless NVA filtering is used.

## 7. Planning for Inbound and Outbound Internet Connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public Internet.

***Design Considerations***

- Azure native network security services such as Azure Firewall, Application Gateway WAF, and Azure Front Door WAF are fully managed services, meaning that customers do not incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

- The CAF enterprise-scale landing zone architecture is fully compatible with third party network virtual appliances, should the customer prefer to use NVAs or for situations where native services do not satisfy specific customer requirements.

***Design Recommendations***

- Use Azure Firewall to govern outbound traffic to the internet and non-HTTP/S inbound connections.

- Use Firewall Manager with Azure Virtual WAN to deploy and manage Azure Firewalls across VHubs.

- Configure supported 3^rd^ party SaaS security providers within Firewall Manager if the customer wishes to use such solutions to protect outbound connections.

- Use Azure DDoS Standard Protection Plans to protect all public endpoints hosted within customer Virtual Networks.

- Use Application Gateway WAF within a “landing zone” Virtual Network for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a “landing zone”.

- If third party NVAs are used, they should be deployed into a separate Virtual Network (i.e. NVA VNet) and connected to a regional VHub via peering.

- If third-party NVAs are used, deployments should follow vendor best practise recommendations, with particular attention to high-availability and Azure certified architectures.

<!-- -->

- Do not replicate on-premises DMZ concepts and architectures into Azure.

## 8. Define Network Encryption Requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

***Design Considerations***

- Cost and available bandwidth are inversely proportional to length of encryption tunnel between endpoints.

- When using VPN to connect to Azure, traffic is encrypted over the internet via IPSec tunnels.

- When using ExpressRoute with Private Peering, traffic is not currently encrypted.

- MACsec encryption can be applied to ExpressRoute Direct to achieve network encryption.

- Azure does not currently offer native encryption over Global VNet Peering. However, work is being conducted to encrypt all Azure to Azure traffic using MACsec, which is expected to be available CY2020.

    - If encryption between Azure regions is required today, it is possible to connect VNets using VPN Gateways rather than Global VNet Peering.

***Design Recommendations***
[![Encryption Flows](./media/enc-flows.png "Encryption Flows")](./media/enc-flows.png)

Figure 8 – Encryption Flows

- When establishing VPN connections from on-premises to Azure using VPN Gateways, traffic is encrypted at a protocol level using IPSec tunnels, as depicted in flow A in the diagram above.

- When utilising ExpressRoute Direct, configure [MACSec](/azure/expressroute/expressroute-howto-macsec) in order to encrypt traffic at L2 level between the customer’s routers and MSEE, as depicted in flow B in the diagram above.

- When utilising regular ExpressRoute circuits, use Azure VWAN VPN Gateway to establish [IPSec tunnels over ExpressRoute](/azure/virtual-wan/vpn-over-expressroute) Private Peering. This is depicted by flow *C* in the diagram above.

    - If additional scale or capabilities are required use 3^rd^ party NVAs connected to Azure VWAN.

- If traffic between Azure regions must be encrypted, use VPN Gateways to connect VNets across regions. MACSec encryption across regions is being rolled out, but the capability is not available yet.

<!-- -->

- Do not use third-party NVAs in Azure to encrypt traffic over ExpressRoute Private Peering without first validating native Azure capabilities as depicted in flows *B* and *C* above.

## 9. Planning for Traffic Inspection

In many industries customers require that traffic in Azure, particularly inbound and outbound internet traffic, is mirrored to a network packet collector for deep inspection and analysis. This section therefor explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Networks.

***Design Considerations***

- The Azure Virtual Network TAP (VTAP) preview is not currently available, and there is no ETA to resume its availability.

- Network Watcher packet captures are limited to a maximum period of 5 hours.

***Design Recommendations***

- Use Network Watcher packet capture despite the limited capture window.

- Evaluate if NSG Flow Logs v2 provide the level of detail required.

- Use 3^rd^ party solutions, such as Gigamon, for scenarios where sustained deep packet inspection is required.

<!-- -->

- Do not block Azure deployments just because VTAP is unavailable.

- Do not develop a custom solution to mirror traffic. While this might be acceptable for small scale scenarios, this approach is not encouraged at scale due to complexity and supportability issues which may arise.

## Next steps

Suggested design for [Management and Monitoring](./E-Management-and-Monitoring.md)

> [!div class="nextstepaction"]
> [Management and Monitoring](./E-Management-and-Monitoring.md)