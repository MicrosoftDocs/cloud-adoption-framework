---
title: Network topology and connectivity
description: Network topology and connectivity
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network topology and connectivity

This section will examine key design considerations and recommendations surrounding networking and connectivity to, from, and within Microsoft Azure.

## Planning for IP addressing

It is vital that enterprise customers plan for IP addressing in Azure to ensure there isn't overlapping IP address space across considered on-premises locations and Azure regions.

**Design considerations:**

- Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

- While virtual network (VNet) address space can be added after creation, this process will require an outage if the VNet is already connected to another VNet via peering, since the VNet peering will have to be deleted and recreated.

- Azure reserves five IP addresses within each subnetwork (subnet), which should be factored in when sizing VNets and encompassed subnets.

- Some Azure services do require [dedicated subnets](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network) such as Azure Firewall or VNet gateway.

- Subnets can be delegated to certain services to create instances of that service within the subnet.

**Design recommendations:**

- Plan for nonoverlapping IP address spaces across Azure regions and on-premises locations well in advance.

- Use IP addresses from the address allocation for private internets (RFC 1918).

- For environments with limited private IP addresses (RFC 1918) availability, consider using IPv6.

- Do not create large VNets (for example: /16) to ensure that IP address space isn't wasted.

- Do not create VNets without planning the required address space in advance, since adding address space will cause an outage once a VNet is connected via VNet peering.

- Do not use public IP addresses for VNets, especially if the public IP addresses don't belong to the customer.

## Configure the domain name system (DNS) and name resolution for on-premises and Azure resources

DNS is a critical design topic in the overall enterprise-scale architecture, and while some customers may want to use their existing investments in DNS, others may see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design considerations:**

- A DNS resolver can be used in conjunction with Azure Private DNS for cross-premises connectivity.

- Customers may require the use of existing DNS solutions across on-premises and Azure.

- The maximum number of private DNS zones to which a VNet can link with autoregistration is one.

- The maximum number of private DNS zones to which a VNet can link is 1000 without auto-registration enabled.

**Design recommendations:**

- For environments in which name resolution in Azure is all that's required, use Azure Private DNS for resolution by creating a delegated zone for name resolution (example Azure.contoso.com).

- For environments in which name resolution across Azure and on-premises is required, use existing DNS infrastructure (for example, Active Directory integrated DNS) deployed onto at least two Azure VMs and configure DNS settings in VNets to use those DNS servers.

  Azure Private DNS can still be used where the Azure Private DNS zone is linked to the VNets and DNS servers are used as hybrid resolvers with conditional forwarding to on-premises DNS names (such as `onprem.contoso.com`) using on-premises DNS servers. On-premises servers can be configured with conditional forwarders to resolver VMs in Azure for the Azure Private DNS zone (for example, Azure.contoso.com).

- Special workloads that require and/or deploy their own DNS (such as Red Hat OpenShift) should use their preferred DNS solution.

- Auto-registration should be enabled for Azure DNS to automatically manage the lifecycle of the DNS records for the virtual machines deployed within a VNet.

- Use a virtual machine as a resolver for cross-premises DNS resolution with private DNS. This is a short-term solution since an Azure-native resolver is on the Azure Private DNS road map.

- Create the Azure Private DNS zone within a global `connectivity` subscription. Additional Azure Private DNS zones might be created (for example, `privatelink.database.windows.net` or `privatelink.blob.core.windows.net` for Azure Private Link).

## Define an Azure networking topology

Network topology is a critical foundational element of the enterprise-scale architecture, as it ultimately defines how applications can communicate with each other. This section explores relevant technologies and topology approaches for enterprise Azure deployments and focuses on two core approaches⁠&mdash;virtual and traditional WAN-based networking topology.

An Azure networking topology based on Virtual WAN is the preferred enterprise-scale approach for large-scale, multi-region deployments where the customer needs to connect their global locations to both Azure and on-premises. A Virtual WAN-based network topology should also be used when the customer needs to use software-defined networking in a wide-area network (SD-WAN) deployments to fully integrate with Azure. Virtual WAN is used to meet large-scale interconnectivity requirements. Since it's a Microsoft-managed service, it'll also simultaneously reduce overall network complexity and help to modernize the customer's network.

A traditional Azure networking topology should be used for customers who only intend to deploy resources in a few Azure regions, don't need a global interconnected network, have a low number of remote or branch locations per region (less than 30), or require full control and granularity for manually configuring their Azure network. This traditional topology will support these customers to build a secure network foundation in Azure.

## Virtual WAN (Microsoft-managed) network topology

![Network topology and connectivity](./media/net-con2.png)

_Figure 1: Virtual-WAN-based network topology_

**Design considerations:**

- [Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-about) is a Microsoft-managed solution where end-to-end global transit connectivity is provided out-of-the-box. Virtual WAN hubs eliminate the need for customers to manually set up network connectivity, such as when a customer doesn't require setting up user-defined routing (UDR) or network virtual appliances (NVA)s to enable global transit connectivity.

- Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises by creating [hub-and-spoke network architecture](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-global-transit-network-architecture) that spans multiple Azure regions and on-premises locations (any-to-any connectivity) out-of-the-box, as depicted in the figure below:

![Network topology and connectivity](./media/global-transit.png)
_Figure 2: Global transit network with Virtual WAN._

- Virtual WAN any-to-any transitive connectivity supports the following paths (within the same region and across regions):

  - Virtual network to virtual network
  - Virtual network to branch
  - Branch to virtual network
  - Branch to branch

- Virtual WAN hubs are locked down, and the only resources that customer can deploy within them are VNet gateways (point-to-site and site-to-site virtual private networks (VPNs) and ExpressRoute), Azure Firewall via Firewall Manager, and route tables.

- Virtual WAN increases the limit of up to 200 prefixes advertised from Azure to on-premises via ExpressRoute private peering to 10,000 prefixes per single Virtual WAN hub. The limit of 10,000 prefixes also includes VPNs (site-to-site and point-to-site VPNs).

- VNet-to-VNet transitive connectivity (within a region and across regions) is in public preview, and throughput is limited currently available up to 3 gigabits per second (Gbps) (to increase to more than 20 Gbps).

- Virtual WAN hub to hub connectivity is currently in public preview.

- Virtual WAN integrates with a variety of SD-WAN [providers](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-locations-partners).

- Many managed service providers offer [managed services](https://docs.microsoft.com/azure/networking/networking-partners-msp) for Virtual WAN.

- VPN gateways in Virtual WAN scale up to 20 Gbps and 20,000 connections per virtual hub.

- ExpressRoute circuits with the premium add-on are required, and they should be from an ExpressRoute Global Reach location.

- Azure Firewall Manager (currently in public preview) allows the deployment of the Azure Firewall in the Virtual WAN hub.

- Virtual WAN hub to hub traffic via Azure Firewall is currently not supported. As alternative, use a native hub to hub transit routing capabilities in Virtual WAN, and use NSGs to allow/block VNet traffic across hubs.

**Design recommendations:**

- Virtual WAN is highly recommended for new large/global network deployments in Azure where customers require global transit connectivity across Azure regions and on-premises locations, without having to manually setup Azure networking transitive routing by themselves.

  The following figure depicts a sample global customer deployment with datacenters spread across Europe and the United States, as well as a large number of branch offices within both regions. The environment is globally connected via Virtual WAN and ExpressRoute Global Reach.

![Example Network Topology](./media/eg-net-top.png)

_Figure 3: Sample network topology_

- Use Virtual WAN as a global connectivity resource, with a Virtual WAN hub per Azure region to connect multiple landing zones together across Azure regions via their local Virtual WAN hub.

- Connect Virtual WAN hubs to on-premises datacenters using ExpressRoute.

- Connect branches/remote locations to the nearest Virtual WAN hub via site-to-site VPN, or enable branch connectivity to Virtual WAN via an SD-WAN partner solution.

- Connect end users to the Virtual WAN hub via a point-to-site VPN.

- It is recommended that the principle, "Traffic in Azure stays in Azure," is followed so that communication across resources in Azure occurs via the Microsoft backbone network even when they're in different regions.

- Deploy Azure Firewall in Virtual WAN hubs for east-west and south-north traffic protection/filtering within an Azure region.

- If third-party NVAs are required for east-west and/or south-north traffic protection/filtering, deploy the NVAs to a separate VNet (for example, NVA VNet), and connect it to the regional Virtual WAN hub and to the landing zones requiring access to NVAs, as described in this [article.](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-route-table-portal)

- When deploying third-party networking technologies/NVAs, follow the third-party vendor's guidance to ensure there aren't conflicting configurations with Azure networking.

- Do not build a transit network on top of Virtual WAN, as Virtual WAN satisfies all transitive networking topology requirements, including the ability to use third-party NVAs.

- It is recommended to not use existing on-premises networks (for example, multiprotocol Label Switching [MPLS]) to connect Azure resources across Azure regions, as Azure networking technologies support the interconnection of Azure resources across regions through the Microsoft backbone.

- For brownfield scenarios where you are migrating from non-Virtual WAN-based hub-and-spoke network topology, refer to this migration [article](https://docs.microsoft.com/azure/virtual-wan/migrate-from-hub-spoke-topology).

- Virtual WAN and Azure Firewall resources should be created within the `connectivity` subscription.

- Do not create more than 500 VNet connections per the Virtual WAN virtual hub.

## Traditional Azure networking (customer-managed) topology

While Virtual WAN offers a wide range of powerful capabilities, there are some cases where a traditional Azure networking approach may be optimal:

- If a global transitive network across multiple Azure regions and/or cross-premises isn't required (for example, a branch in US requiring to connect to a VNet in Europe)

- If there isn't a need to connect to a large number of remote locations via VPN or integration with an SD-WAN solution

- If the customer's preference is to have granular control and configuration when setting up a network topology in Azure

![Network topology and connectivity](./media/cmanged-nt.png)

_Figure 4: A customer-managed Azure network topology_

**Design considerations:**

- There are multiple network topologies to connect multiple landing zones VNets: one large flat VNet, multiple VNets connected with multiple ExpressRoute circuits/connections, hub-and-spoke, full mesh, and hybrid.

- VNets don't traverse subscription boundaries, but connectivity between VNets in different subscriptions can be achieved using either VNet peering, an ExpressRoute circuit, or using VPN gateways.

- VNet peering can be used to connect VNets in the same region, across different Azure regions, and across different Azure AD tenants.

- VNet peering and global VNet peering aren't transitive. Therefore, UDRs and NVAs are required to enable a transit network, as described in this [article](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

- ExpressRoute circuits can be used to establish connectivity across VNets within the same geo-political region or by using the premium add-on for connectivity across geo-political regions.

  - VNet to VNet traffic may experience additional latency since traffic must hairpin at Microsoft Enterprise Enrollment (MSEE).

  - Bandwidth will be constrained to the ExpressRoute gateway stock-keeping unit (SKU).

  - Customers must still deploy and manage UDRs, should they require inspection/logging for cross-VNet (VNet) traffic.

- VPN gateways with border gateway protocols (BGPs) are transitive within Azure and on-premises, but don't transit across ExpressRoute gateways.

- When multiple ExpressRoute circuits are connected to the same VNet, connection weights and BGP techniques (described in this [article](https://docs.microsoft.com/azure/expressroute/expressroute-optimize-routing) must be used to ensure an optimal path for traffic from on-premises to Azure and vice-versa.

- Using BGP techniques to influence ExpressRoute routing is a configuration outside the Azure cloud. Therefore, the customer and/or their connectivity provider must configure their on-premises routers accordingly.

- ExpressRoute circuits with premium add-ons provide global connectivity; however, the maximum number of ExpressRoute connections per ExpressRoute gateway is four.

- While the maximum number of VNet peering connections per VNet is 500, the maximum number of routes that can be advertised from Azure to on-premises via ExpressRoute private peering is 200.

- A VPN gateway's maximum aggregated throughput is 10 Gbps and support up to 30 site-to-site/VNet-to-VNet tunnels.

**Design recommendations:**

- A network design-based in the hub-and-spoke network topology with non-virtual-WAN technologies should be considered for the following scenarios:

  - Azure deployments where traffic boundary is within an Azure region.

  - A network architecture with up to two Azure regions where there's a requirement for transit connectivity between landing zone VNets across regions.

  - A network architecture spanning multiple Azure regions and there isn't a need for transitive connectivity between landing zones VNets across regions.

  - There is no need for transitive connectivity between VPN and ExpressRoute connections.

  - The main cross-premises connectivity channel is ExpressRoute, and the number of VPN connections is less than 30 per VPN gateway.

  - There is a heavy dependency on centralized NVAs and complex/granular routing.

- For regional deployments, primarily use the hub-and-spoke topology, with landing zones VNets connecting with VNet peering to a central hub VNet for cross-premises connectivity via ExpressRoute, VPN for branch connectivity, spoke-to-spoke connectivity via NVAs and UDRs, and internet-outbound protection via NVA, as depicted in the figure below.

![Network topology and connectivity](./media/HS.png "Network Topology and Connectivity")

_Figure 5: Hub-and-spoke network topology._

- When a high level of isolation is achieved, a dedicated ExpressRoute bandwidth is required for specific business units. When the maximum number of connections per ExpressRoute gateway (up to four) is reached, use the multiple VNets connected with multiple ExpressRoute circuits topology, as depicted in the picture below:

![Network topology and connectivity](./media/MvnetHS.png "Network Topology and Connectivity")

_Figure 6: Multiple VNets connected with multiple ExpressRoute circuits_

- Deploy a set of minimal shared services, including ExpressRoute gateways, VPN gateways (as required) and Azure Firewall or third-party NVAs (as required) in the central hub VNet. If necessary, also Active Directory domain controllers and DNS servers.

- Deploy Azure Firewall or third-party NVAs for east-west and/or south-north traffic protection/filtering, in the central hub VNet.

- When deploying third-party networking technologies/NVAs, follow the third-party vendor's guidance to ensure that deployment is supported by the vendor, is designed for high-availability and maximal performance, and that there aren't conflicting configurations with Azure networking.

- L7 inbound NVAs (such as Azure Application Gateway) shouldn't be deployed as a shared service in the central hub VNet. Instead, they should be deployed together with the app in their respective landing zone.

- Use existing customer network (MPLS and SD-WAN) for connecting branch locations with corporate headquarters. Transit in Azure between ExpressRoute and VPN gateways isn't supported.

- For network architectures with multiple hub-and-spoke topologies across Azure regions, use global VNet peering to connect landing zone VNets when a small number of landing zones need to communicate across regions. That this approach would offer benefits such as high network bandwidth with global VNet peering (as allowed by the VM SKU) but will bypass the central NVA (in case traffic inspection/filtering is required). This would also be subject to global VNet peering [limitations](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks).

- When a customer deploys hub-and-spoke network architecture in two Azure regions and transit connectivity between all landing zones across regions is required, use ExpressRoute with dual circuits to provide transit connectivity for landing zones VNets across Azure regions. In this scenario, landing zones can transit within a region via NVA in local hub VNet and across regions via ExpressRoute circuit, with the traffic hairpinning at the MSEE. This design is depicted in the image below:

![Network topology and connectivity](./media/MvnetHSPP.png "Network Topology and Connectivity")
_Figure 7: Landing zone connectivity design_

- When a customer requires hub-and-spoke network architectures across more than two Azure regions and global transit connectivity between landing zones, VNets across Azure regions is required. While this architecture could be implemented by interconnecting central hub VNets with global VNet peering and using UDRs and NVAs to enable global transit routing, the complexity and management overhead is high. Instead, we recommend deploying global transit network architecture with Virtual WAN.

- Use [Azure Monitor network insights](https://docs.microsoft.com/azure/azure-monitor/insights/network-insights-overview) (currently in preview) to monitor the end-to-end state of customer networks on Azure.

- Do not create more than 200 peering connections per central hub VNet.

- While VNets support up to 500 VNet peering connections, ExpressRoute with private peering only supports advertising up to 200 prefixes from Azure to on-premises.

## Connectivity to Azure

This section will expand on the network topology to consider recommended models for connecting on-premises locations to Azure.

**Design considerations:**

- Azure ExpressRoute provides dedicated private connectivity to Microsoft Azure services (infrastructure-as-a-service and platform-as-a-service [PaaS]) from on-premises locations.

- Private Link can be used to establish connectivity to PaaS services over ExpressRoute with private peering.

- When multiple VNets are connected to the same ExpressRoute circuit, they'll become part of the same routing domain, and all VNets will share the bandwidth.

- ExpressRoute Global Reach (where available) allows customers to connect on-premises locations together using ExpressRoute circuits to transit traffic over the Microsoft backbone network.

- ExpressRoute Global Reach is available in many ExpressRoute peering [locations](https://docs.microsoft.com/azure/expressroute/expressroute-global-reach#availability).

- ExpressRoute Direct allows to create multiple ExpressRoute circuits at no additional cost, up to the ExpressRoute Direct port capacity (10g or 100g and allows you to connect directly to Microsoft's ExpressRoute routers). For the 100 Gbps SKU, the minimum circuit bandwidth is 5 Gbps. For the 10 Gbps SKU, the minimum circuit bandwidth is 1 Gbps.

**Design recommendations:**

- Use ExpressRoute as the primary connectivity channel for connecting on-premises network to Microsoft Azure. Use private peering with Private Link to establish connectivity to PaaS services. VPNs can be used as a source of backup connectivity to enhance connectivity resiliency.

- Use dual ExpressRoute circuits from different peering locations when connecting an on-premises location to VNets in Azure. This setup will ensure redundant paths to Azure, removing single points of failure between on-premises and Azure.

- When multiple ExpressRoute circuits are used, [optimize routing](https://docs.microsoft.com/azure/expressroute/expressroute-optimize-routing) by using BGP local preference and as pre-pending path.

- Ensure the right SKU is used for the ExpressRoute/VPN gateways based on bandwidth and performance requirements.

- Deploy a zone redundant ExpressRoute gateway in the supported Azure regions.

- For scenarios that require bandwidth higher than 10 Gbps or dedicated 10/100 Gbps ports, use ExpressRoute Direct.

- When low latency is required, or throughput from on-premises to Azure must be greater than 10 Gbps, enable FastPath to bypass the ExpressRoute gateway from the data path.

- Use VPN gateways to connect branches or remote locations to Azure. For higher resilience, deploy zone-redundant gateways (where available).

- Use ExpressRoute Global Reach to connect large offices/regional headquarters/datacenters connected to Azure via ExpressRoute.

- When traffic isolation or dedicated bandwidth is required (such as for separating production and nonproduction environments), different ExpressRoute circuits should be used to ensure isolated routing domains and to alleviate noisy-neighbor risks.

- Proactively monitor ExpressRoute circuits using Azure Network Performance Monitor.

- Do not explicitly use ExpressRoute circuits from a single peering location, as this creates a single point of failure and makes the customer susceptible to peering location outages.

- Do not use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth to avoid noisy-neighbor risks.

## Connectivity to Azure PaaS services

Building on the previous connectivity sections, this section will explore recommended connectivity approaches when using Azure PaaS services.

**Design considerations:**

- Azure PaaS services are typically accessed over public endpoints, however, the Azure platform provides capabilities to secure such endpoints or even make them entirely private.

  - VNet injection provides dedicated private deployments for supported services. But management plane traffic flows through public IP addresses.

  - [Private Link](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access using private IP addresses to Azure PaaS instances, or custom services behind an Azure Load Balancer standard.

  - VNet service endpoints provide service level access from selected subnets to selected PaaS services.

- Enterprise customers often have concerns regarding public endpoints for PaaS services that must be appropriately mitigated.

- For [supported services](https://docs.microsoft.com/azure/private-link/private-link-overview#availability), Private Link addresses data exfiltration concerns associated with service endpoints. Alternately, outbound filtering via NVAs can be used to mitigate risk during data exfiltration.

**Design recommendations:**

- Use VNet injection for supported Azure services to make them available from within a customer VNet.

- Azure PaaS services that have been injected into a VNet still perform management plane operations using public IP addresses. Ensure that this communication is locked down within the VNet using UDRs and NSGs.

- Use Private Link, where available, for shared Azure PaaS services. Private Link is generally available for several services and is in public preview for numerous ones. Private Link availability is detailed [here](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource). Customer requirements should be carefully aligned with the product [road map](https://aka.ms/privatePaaS).

- Access Azure PaaS services from on-premises via ExpressRoute private peering, using either VNet injection for dedicated Azure services or Azure Private Link for available shared Azure services. To access Azure PaaS services from on-premises when VNet injection or Private Link aren't available, use ExpressRoute with Microsoft peering when there are no data exfiltration concerns. This would avoid transiting over the public internet.

- Use VNet service endpoints to secure access to Azure PaaS services from within a customer VNet, but only when Private Link isn't available and there aren't data exfiltration concerns. To address data exfiltration concerns with service endpoints, use NVA filtering. Use VNet service endpoint policies for Azure Storage.

- Do not enable VNet service endpoints by default on all subnets.

- Do not use VNet service endpoints when there are data exfiltration concerns, unless NVA filtering is used.

- It isn't recommended to implement forced tunneling and enable communication from Azure to Azure resources.

## Planning for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.

**Design considerations:**

- Azure-native network security services such as Azure Firewall, Application Gateway Web Application Firewall (WAF), and Azure Front Door Service are fully managed services, meaning that customers don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

- The enterprise scale architecture is fully compatible with third-party NVAs, should the customer prefer to use NVAs or for situations where native services don't satisfy specific customer requirements.

**Design recommendations:**

- Use Azure Firewall to govern:

  - Azure outbound traffic to the internet

  - Non-HTTP/S inbound connections

  - East-west traffic filtering (if required by the customer)

- Use Firewall Manager with Virtual WAN to deploy and manage Azure firewalls across Virtual WAN hubs or in hub VNets. Firewall Manager is currently in preview for both Virtual WAN and regular VNets.

- Create a global Azure Firewall policy to govern security posture across the global network environment and assign it to all Azure firewalls. Allow for granular policies to meet requirements of specific regions by delegating incremental firewall policies to local security teams via RBAC.

- Configure supported third-party SaaS security providers within Firewall Manager if the customer wishes to use such solutions to protect outbound connections.

- Use App Gateway WAF within a landing zone VNet for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door Service WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a landing zone.

- When using Azure Front Door Service and Application Gateway to protect HTTP/S apps, use WAF policies in Azure Front Door Service and Lockdown in Application Gateway to receive traffic only from Azure Front Door Service.

- If third-party NVAs are required for east-west and/or south-north traffic protection/filtering:

For Virtual WAN network topologies, deploy the NVAs to a separate VNet (for example, NVA VNet), and connect it to the regional Virtual WAN hub and to the landing zones that require access to NVAs, as described in this [article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-route-table-portal). For non-Virtual WAN network topologies, deploy the third-party NVAs in the central hub VNet.

- If third-party NVAs are required for inbound HTTP/S connections, they should be deployed within a landing zone VNet and together with the apps that they're protecting and exposing to the internet.

- Use distributed Azure denial-of-service (DDoS) standard protection plans to protect all public endpoints hosted within customer VNets.

- Do not replicate on-premises DMZ concepts and architectures into Azure, as customers can get similar security capabilities in Azure as with on-premises, but the implementation and architecture will need to be adapted to the cloud.

## Planning for app delivery

This section explores key recommendations to deliver internal and external facing apps in a secure, highly scalable, and highly available manner.

**Design considerations:**

- Azure Load Balancer (internal and public) provides high availability for app delivery at a regional level.

- Application Gateway allows the secure delivery of HTTP/S apps at a regional level.

- Azure Front Door Service allows the secure delivery of highly available HTTP/S apps across Azure regions.

- Azure Traffic Manager allows the delivery of global apps.

**Design recommendations:**

- App delivery for both internal- and external-facing apps should be performed within landing zones.

- For secure delivery of HTTP/S apps, use app gateway v2 and ensure that WAF protection/policies are enabled.

- Use a third-party NVA if Application Gateway v2 can't be used for the security of HTTP/S apps.

- An Application Gateway v2 or third-party NVAs used for inbound HTTP/S connections should be deployed within the landing zone VNet and with the apps that they're securing.

- All public IP addresses in a landing zone should be protected with a DDoS standard protection plan.

- Global HTTP/S apps that span Azure regions should be delivered and protected using Azure Front Door Service with WAF policies.

- When using Azure Front Door Service and Application Gateway to protect HTTP/S apps, use WAF policies in Azure Front Door Service and Lockdown in Application Gateway to receive traffic only from Azure Front Door Service.

- Global apps that span protocols other than HTTP/S should be delivered using Traffic Manager.

## Planning for landing zone network segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network zero-trust implementation.

**Design considerations:**

- The zero-trust model assumes a breached state and verifies each request as though it originates from an uncontrolled network.

- An advanced zero-trust network implementation employs fully distributed ingress/egress cloud micro-perimeters and deeper micro-segmentation.

- Network security groups can use Azure service tags to facilitate connectivity to Azure PaaS services.

- App security groups don't span or provide protection across VNets.

- NSG flow logs are now supported using Azure Resource Manager templates.

**Design recommendations:**

- Delegate subnet creation to the landing zone owner. This will enable them to define how to segment workloads across subnets (for example, a single, large subnet, multi-tier app, or VNet-injected app). The platform team can use Azure Policy to ensure an NSG with specific rules (such as deny inbound SSH or RDP from internet, or allow/block traffic across landing zones) is always associated to subnets with deny only policies.

- NSGs must be used to protect traffic across subnets, as well as east-west traffic across the platform (inter-landing-zone traffic).

- The app team should use app security groups at the subnet level NSGs to protect multi-tier VMs within their landing zone.

- Use NSGs and app security groups to micro-segment traffic within the landing zone and avoid using a central NVA to filter traffic flows.

- It is recommended to enable NSG flow logs and feed them into traffic analytics to gain insights into internal and external traffic flows.

- Use NSGs to selectively whitelist inter-landing-zone connectivity.

- For virtual-WAN-based network topologies, route traffic across landing zones via Azure Firewall if the customer requires packet inspection and logging capabilities for traffic flowing across landing zones.

## Define network encryption requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

**Design considerations:**

- Cost and available bandwidth are inversely proportional to length of encryption tunnel between endpoints.

- When using VPN to connect to Azure, traffic is encrypted over the internet via IP security (IPsec) tunnels.

- When using ExpressRoute with private peering, traffic isn't currently encrypted.

- MACsec encryption can be applied to ExpressRoute Direct to achieve network encryption.

- Azure doesn't currently offer native encryption over global VNet peering. If encryption between Azure regions is required today, it's possible to connect VNets using VPN gateways rather than global VNet peering.

**Design recommendations:**
![Encryption flows](./media/enc-flows.png)

_Figure 8: Encryption flows_

- When establishing VPN connections from on-premises to Azure using VPN gateways, traffic is encrypted at a protocol level using IPsec tunnels, as depicted in Flow A in the diagram above.

- When using ExpressRoute Direct, configure [media access control security (MACsec)](https://docs.microsoft.com/azure/expressroute/expressroute-howto-MACsec) in order to encrypt traffic at 12 levels between the customer's routers and MSEE, as depicted in Flow B in the diagram above.

- For Virtual WAN scenarios where MACsec isn't an option (for example, not using ExpressRoute Direct), use Virtual WAN VPN gateway to establish IPsec tunnels over ExpressRoute private peering. This is depicted by Flow C in the diagram above.

- For non-virtual-WAN scenarios, and where MACsec isn't an option (for example, not using ExpressRoute Direct), today the only options is to use third-party NVAs to establish IPsec tunnels over ExpressRoute private peering or establish a VPN tunnel over ExpressRoute with Microsoft peering.
It is in the road map to support IPsec encryption for ExpressRoute private peering.

- If traffic between Azure regions must be encrypted, use VPN gateways to connect VNets across regions.

- Do not use third-party NVAs in Azure to encrypt traffic over ExpressRoute private peering without first validating native Azure capabilities as depicted in flows B and C above.

## Planning for traffic inspection

In many industries, customers require that Azure traffic (inbound and outbound internet traffic) is mirrored to a network packet collector for deep inspection and analysis. This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

**Design considerations:**

While [Azure Virtual Network TAP](https://docs.microsoft.com/azure/virtual-network/virtual-network-tap-overview) (in preview) is available in all Azure regions, the preview program is currently on hold. Azure Network Watcher packet in Network Watcher is generally available, but captures are limited to a maximum period of five hours.

**Design recommendations:**

Since VNet TAP in preview is on hold, evaluate the following options:

- Use Network Watcher packet to capture despite the limited capture window.

- Evaluate if NSG flow logs v2 provide the level of detail required.

- Use third-party solutions such as Gigamon for scenarios where sustained deep-packet inspection is required.

- Do not block Azure deployments just because VNet TAP isn't available.

- Do not develop a custom solution to mirror traffic. While this might be acceptable for small scale scenarios, this approach isn't encouraged at scale due to complexity and the supportability issues that may arise.
