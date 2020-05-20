---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# D. Network topology and connectivity

This section will examine key design considerations and recommendations surrounding networking and connectivity to/from Azure, as well as within Azure.

## 1. Planning for IP addressing

It is vital that enterprise customers plan for IP addressing in Azure to ensure there is no overlapping IP address space across considered on-premises locations and Azure regions.

**Design considerations:**

- Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

- While virtual network address space can be added after creation, this process will require an outage if the virtual network is already connected to another virtual network via peering, since the virtual network peering will have to be deleted and re-created.

- Azure reserves 5 IP addresses within each subnet which should be factored in when sizing virtual networks and encompassed subnets.

- Some Azure services do require [dedicated subnets](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network), such as Azure Firewall or virtual network gateway.

- Subnets can be delegated to certain services to create instances of that service within the subnet.

**Design recommendations:**

- Plan for nonoverlapping IP address spaces across Azure regions and on-premises locations well in advance.

- Use IP addresses from the address allocation for private internets (RFC 1918).

- For environments with limited private IP addresses (RFC 1918) availability, consider using IPv6.

<!-- -->

- Do not create unnecessarily large virtual networks (for example: /16) to ensure there is no unnecessary wastage of IP address space.

- Do not create virtual networks without planning the required address space in advance, since adding address space will cause an outage once a virtual network is connected via virtual network peering.

- Do not use public IP addresses for virtual networks, especially if the public IP addresses do not belong to the customer.

## 2. Configure DNS and name resolution for on-premises and Azure resources

DNS is a critical design topic in the overall "enterprise-scale" architecture, and while some customers may want to use their existing investments in DNS, others may see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design considerations:**

- A DNS resolver can be used in conjunction with Azure Private DNS for cross-premises connectivity.

- Customers may require the use of existing DNS solutions across on-premises and Azure.

- The maximum number of private DNS zones a virtual network can get linked to with auto-registration enabled is only one.

- The maximum number of private DNS zones a virtual network can get linked to is 1000 without auto-registration enabled.

**Design recommendations:**

- For environments where name resolution in Azure is all that is required, use Azure Private DNS for resolution by creating a delegated zone for name resolution (example Azure.contoso.com).

- For environments where name resolution across Azure and on-premises is required, use existing DNS infrastructure (for example, Active Directory integrated DNS) deployed onto at least two Azure VMs and configure DNS settings in virtual networks to use those DNS servers.

  - Azure Private DNS can still be used where the Azure Private DNS zone is linked to the virtual networks and DNS servers are used as hybrid resolvers with conditional forwarding to on-premises DNS names (such as `onprem.contoso.com`) using on-premises DNS servers.

  - On-premises servers can be configured with conditional forwarders to resolver VMs in Azure for the Azure Private DNS zone (for example, Azure.contoso.com).

- Special workloads that require and/or deploy their own DNS (such as Red Hat OpenShift) should use their preferred DNS solution.

- Auto-registration should be enabled for Azure DNS to automatically manage the lifecycle of the DNS records for the virtual machines deployed within a virtual network.

- Use a virtual machine as a resolver for cross-premises DNS resolution with private DNS.

  - This is a short-term solution since an Azure native resolver is on the Azure Private DNS roadmap.

- Create the Azure Private DNS zone within a global "connectivity" subscription.

  - Additional Azure Private DNS zones might be created (for example `privatelink.database.windows.net` or `privatelink.blob.core.windows.net` for Private Link).

## 3. Define an Azure networking topology

Network topology is a critical foundational element of the "enterprise-scale" architecture as it ultimately defines how applications can communicate with one another. This section will therefore explore relevant technologies and topology approaches for enterprise Azure deployments,focusing on two core approaches:

A. Azure Virtual WAN-based networking topology

B. Traditional Azure networking topology

An Azure networking topology-based-on Azure Virtual WAN is the preferred enterprise-scale approach for large scale multiregion deployments where the customer needs to interconnect all their global locations on both Azure and on-premises. An Azure Virtual WAN-based network topology should also be used whenever the customer intends to use sd-WAN deployments fully integrated with Azure. Azure Virtual WAN is used to meet these large-scale interconnectivity requirements, but at the same time it will also reduce overall network complexity and help to modernize the customers network since virtual WAN is a networking service managed by Microsoft.

But a traditional Azure networking topology should be used for customers that either 1) only intend to deploy resources in a few Azure regions, 2) have no need for a global interconnected network, 3) have a low number of remote/branch locations per region (less than 30), and/or 4) require full control and granularity for manually configuring their Azure network. This will enable these customers to build a secure network foundation in Azure.

## A. Azure Virtual WAN (Microsoft-managed) based network topology

![Network Topology and Connectivity](./media/net-con2.png)

_Figure 6: Azure Virtual WAN-based network topology._

**Design considerations:**

- [Azure Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-about) is a Microsoft-managed solution, where end-to-end global transit connectivity is provided out-of-the-box. Virtual WAN hubs eliminate the need for customers to manually setup the network connectivity. As an example, customer does not require to setup UDRs or NVAs to enable global transit connectivity.

- Azure Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises by creating a [hub and spoke network architecture](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-global-transit-network-architecture) that spans multiple Azure regions and on-premises locations (any-to-any connectivity) out-of-the-box, as depicted in the picture below:

![Network Topology and Connectivity](./media/global-transit.png)

_Figure 7: Global transit network with Azure Virtual WAN._

- Azure Virtual WAN any-to-any transitive connectivity supports the following paths (within the same region and across regions):

  - Virtual network to virtual network
  - Virtual network to branch
  - Branch to virtual network
  - Branch to branch

- Azure Virtual WAN hubs are locked down, and the only resources that customer can deploy within them are virtual network gateways (p2s and s2s VPN and ExpressRoute), Azure Firewall via Firewall Manager and route tables.

- Azure Virtual WAN increases the limit of up to 200 prefixes advertised from Azure to on-premises via ExpressRoute private peering to 10,000 prefixes per single virtual WAN hub. The limit of 10,000 prefixes also includes VPN (s2s and p2s VPN).

- Virtual network to virtual network transitive connectivity (within a region and across regions) is in public preview, and throughput is limited currently available up to 3gbps (to be increased to > 20Gbps by ga).

- Azure Virtual WAN hub to hub connectivity is currently in public preview.

- Azure Virtual WAN integrates with a variety of sd-WAN [providers](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-locations-partners).

- Many MSPs provide [managed services](https://docs.microsoft.com/azure/networking/networking-partners-msp) for virtual WAN.

- VPN gateways in Azure Virtual WAN scale up to 20gbps and 20,000 connections per virtual hub.

- ExpressRoute circuits with the premium add-on are required and, they should be from an ExpressRoute Global Reach location.

- Azure Firewall Manager (currently in public preview) allows the deployment of the Azure Firewall in the virtual WAN hub.

- Azure Virtual WAN hub to hub traffic via Azure Firewall is currently not supported.

  - As alternative, use native hub to hub transit routing capabilities in Azure Virtual WAN and use NSGs to allow/block virtual network traffic across hubs.

**Design recommendations:**

- Azure Virtual WAN is highly recommended for new large/global network deployments in Azure where customers require global transit connectivity across Azure regions and on-premises locations, without having to manually setup Azure networking transitive routing by themselves.

  - The following figure depicts a sample global customer deployment with datacenters spread across Europe and the United States, as well as a large number of branch offices within both regions. The environment is globally connected via Azure Virtual WAN and ExpressRoute Global Reach.

![Example Network Topology](./media/eg-net-top.png)

_Figure 8: Example network topology._

- Use Azure Virtual WAN as a global connectivity resource, with a virtual WAN hub per Azure region to connect multiple "landing zones" together across Azure regions via their local virtual WAN hub.

- Connect virtual WAN hubs to on-premises datacenters using ExpressRoute.

- Connect branches/remote locations to the nearest virtual WAN hub via s2s VPN, or enable branch connectivity to Azure Virtual WAN via sd-WAN partner solution.

- Connect end users to the virtual WAN hub via p2s VPN.

- It is strongly recommended that the principal of **"traffic in Azure stays in Azure"** is followed, so that communication across resources in Azure, even if they are in different regions, occurs via the Microsoft backbone network.

- Deploy Azure Firewall in virtual WAN hubs for east-west and south-north traffic protection/filtering within an Azure region.

- If third-party NVAs are required for east-west and/or south-north traffic protection/filtering, deploy the NVAs to a separate virtual network (I.e. NVA virtual network) and connect it to the regional virtual WAN hub as well as to the "landing zones" that require access to NVAs as described in this [article.](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-route-table-portal)

- In the case of deploying third-party networking technologies/NVAs, please follow the third-party vendor's guidance, to ensure there are no conflicting configurations with Azure networking.

- Do not build a transit network on top of Azure Virtual WAN, as virtual WAN satisfies all transitive networking topology requirements, including the ability to use third-party NVAs.

- It is recommended not to use existing on-premises network (I.e. MPLS) to connect Azure resources across Azure regions, as Azure networking technologies allow the interconnection of Azure resources across regions through the Microsoft backbone.

- For brownfield scenarios where you are migrating from a nonvirtual WAN-based hub and spoke network topology, refer to this migration [article](https://docs.microsoft.com/azure/virtual-wan/migrate-from-hub-spoke-topology).

- Azure Virtual WAN and Azure Firewall resources should be created within the "connectivity" subscription.

- Do not create more than 500 virtual network connections per virtual WAN virtual hub.

## B. Traditional Azure networking (customer managed) topology

    While Azure Virtual WAN offers a wide range of powerful capabilities, there are some cases where a traditional Azure networking approach may preferential, such as:

- If a global transitive network across multiple Azure regions and/or cross-premises is not required (for example, a branch in US requiring to connect to a virtual network in Europe).

- If there is no need to connect to a large number of remote locations via VPN or integration with a sd-WAN solution.

- If the customer's preference is to have granular control and configuration when setting up a network topology in Azure.

![Network Topology and Connectivity](./media/cmanged-nt.png)

- Figure 9&mdash;customer managed Azure network topology

**Design considerations:**

- There are multiple network topologies to connect multiple "landing zones" virtual networks: one large flat virtual network, multiple virtual networks connected with multiple ExpressRoute circuits/connections, hub and spoke, full mesh or hybrid.

- Virtual networks do not traverse subscription boundaries but connectivity between virtual networks in different subscriptions can be achieved using either virtual network peering, an ExpressRoute circuit or using VPN gateways.

- Virtual network peering can be used to connect virtual networks in the same region, across different Azure regions, and even across different Azure AD tenants.

- Virtual network peering, as well as global virtual network peering, are not transitive, therefore UDRs and NVAs are required to enable a transit network as described on this [article](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

- ExpressRoute circuits can be used to establish connectivity across virtual networks within the same geo-political region or by using the premium add-on for connectivity across geo-political regions.

  - Virtual network to virtual network traffic may experience additional latency since traffic must hairpin at the MSEE.

  - Bandwidth will be constrained to the ExpressRoute gateway SKU.

  - Customers must still deploy and manage UDRs should they require inspection/logging for cross-VNet traffic.

- VPN gateways with BGP are transitive within Azure and on-premises, but do not transit across ExpressRoute gateways.

- When multiple ExpressRoute circuits are connected to the same virtual network, connection weights and BGP techniques (as described on this [article](https://docs.microsoft.com/azure/expressroute/expressroute-optimize-routing) must be used to ensure an optimal path for traffic from on-premises to Azure and vice versa.

- Using BGP techniques to influence ExpressRoute routing is a configuration outside the Azure cloud, therefore customer and/or their connectivity provider must configure their on-premises routers accordingly.

- ExpressRoute circuits with premium add-on provide global connectivity, however, the maximum number of ExpressRoute connections per ExpressRoute gateway is 4.

- While the maximum number of virtual network peering connections per virtual network is 500, the maximum number of routes that can be advertised from Azure to on-premises via ExpressRoute private peering is 200.

- VPN gateways maximum aggregated throughput is 10gbps and support up to 30 s2s/VNet-to-VNet tunnels.

**Design recommendations:**

- A network design-based in the hub and spoke network topology with non-virtual-WAN technologies should be considered for the following scenarios:

  - Azure deployments where traffic boundary is within an Azure region.

  - A network architecture with up to two Azure regions, where there is a requirement for transit connectivity between "landing zones virtual networks" across regions.

  - A network architecture spanning multiple Azure regions and there is no need for transitive connectivity between "landing zones" virtual networks across regions.

  - There is no need for transitive connectivity between VPN and ExpressRoute connections.

  - The main cross-premises connectivity channel is ExpressRoute, and the number of VPN connections is less than 30 per VPN gateway.

  - There is a heavy dependency on centralized NVAs and complex/granular routing.

- For regional deployments, primarily use the hub and spoke topology, with "landing zones" virtual networks connecting with virtual network peering to a central hub virtual network for cross-premises connectivity via ExpressRoute, VPN for branch connectivity, spoke to spoke connectivity via NVA and UDRs, and internet-outbound protection via NVA as depicted in the picture below.

![Network Topology and Connectivity](./media/HS.png "Network Topology and Connectivity")

_Figure 10: Hub and spoke network topology._

- When a high level of isolation, dedicated ExpressRoute bandwidth is required for specific business units, or the maximum number of connections per ExpressRoute gateway (up to 4) is reached, use the multiple virtual networks connected with multiple ExpressRoute circuits topology as depicted in the picture below:

![Network Topology and Connectivity](./media/MvnetHS.png "Network Topology and Connectivity")

_Figure 11: Multiple virtual networks connected with multiple ExpressRoute circuits._

- Deploy a set of minimal shared services, including ExpressRoute gateways, VPN gateways (as required) and Azure Firewall or third-party NVAs (as required) in the central hub virtual network. If required, deploy also Active Directory domain controllers and DNS servers.

- Deploy Azure Firewall or third-party NVAs for east-west and/or south-north traffic protection/filtering, in the central hub virtual network.

- In case of deploying third-party networking technologies/NVAs, please follow the third-party vendor's guidance, to ensure deployment is supported by vendor, designed for ha and maximal performance, as well as there are no conflicting configurations with Azure networking.

- L7 inbound NVAs (such as application gateway) should not be deployed as a shared service in the central hub virtual network. Instead, they should be deployed together with the application in their respective "landing zone".

- Use existing customer network (MPLS, sd-WAN) for connecting branch locations with corporate headquarters. Transit in Azure between ExpressRoute and VPN gateways is not supported.

- For network architectures with multiple hub and spoke topologies across Azure regions, use global virtual network peering to connect "landing zone" virtual networks when a small number of "landing zones" need to communicate across regions.

  - Note that this approach would offer benefits as high network bandwidth with global virtual network peering (as allowed by the VM SKU), but will bypass the central NVA (in case traffic inspection/filtering is required), as well as this would be subject to global virtual network peering [limitations](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks).

- When customer deploys a hub and spoke network architecture in two Azure regions, and transit connectivity between all "landing zones" across regions is required, use ExpressRoute with dual circuits to provide transit connectivity for "landing zones" virtual networks across Azure regions. In this scenario, "landing zones" can transit within a region via NVA in local hub virtual network, and across regions via ExpressRoute circuit, with the traffic hairpinning at the MSEE. This design is depicted in the picture below:

![Network Topology and Connectivity](./media/MvnetHSPP.png "Network Topology and Connectivity")

- When customer requires hub and spoke network architectures across more than two Azure regions, and global transit connectivity between "landing zones" virtual networks across Azure regions is required, while this architecture could be implemented by interconnecting central hub virtual networks with global virtual network peering, and using UDRs + NVAs to enable global transit routing, the complexity and management overhead is high. Instead, we recommend deploying such a global transit network architecture with Azure Virtual WAN.

- Use [Azure Monitor network insights](https://docs.microsoft.com/azure/azure-monitor/insights/network-insights-overview) (currently in preview) to monitor the end-to-end state of customer networks on Azure.

- Do not create more than 200 peering connections per central hub virtual network.

  - While virtual networks support up to 500 virtual network peering connections, ExpressRoute with private peering only supports advertising up to 200 prefixes from Azure to on-premises.

## 4. Connectivity to Azure

This section will expand on the network topology to consider recommended models for connecting on-premises locations to Azure.

**Design considerations:**

- Azure ExpressRoute provides dedicated private connectivity to Microsoft Azure services (IaaS and PaaS) from on-premises locations.

- Private Link can be used to establish connectivity to PaaS services over ExpressRoute with private peering.

- When multiple virtual networks are connected to the same ExpressRoute circuit, they will become part of the same routing domain and all virtual networks will share the bandwidth.

- ExpressRoute Global Reach (where available) allows customers to connect on-premises locations together using ExpressRoute circuits to transit traffic over the Microsoft backbone network.

- ExpressRoute Global Reach is available in many ExpressRoute peering [locations](https://docs.microsoft.com/azure/expressroute/expressroute-global-reach#availability).

- ExpressRoute Direct allows to create multiple ExpressRoute circuits at no additional cost, up to the ExpressRoute Direct port capacity (10g or 100g and allows you to connect directly to Microsoft's ExpressRoute routers).

  - For the 100 Gbps SKU, the minimum circuit bandwidth is 5 Gbps.

  - For the 10 Gbps SKU, the minimum circuit bandwidth is 1 Gbps.

**Design recommendations:**

- Use ExpressRoute as the primary connectivity channel for connecting on-premises network to Microsoft Azure.

  - Use private peering with Private Link to establish connectivity to PaaS services.

  - VPNs can be used as a source of backup connectivity to enhance connectivity resiliency.

- Use dual ExpressRoute circuits from different peering locations when connecting an on-premises location to virtual networks in Azure. This setup will ensure redundant paths to Azure, removing single points of failure between on-premises and Azure.

- When multiple ExpressRoute circuits are used, [optimize routing](https://docs.microsoft.com/azure/expressroute/expressroute-optimize-routing) by using BGP local preference and as path prepending.

- Ensure the right SKU is used for the ExpressRoute/VPN gateways based on bandwidth and performance requirements.

- Deploy a zone redundant ExpressRoute gateway in the supported Azure regions.

- For scenarios that require bandwidth higher than 10gbps or dedicated 10/100 Gbps ports, use ExpressRoute Direct.

- When very low latency is required, or throughput from on-premises to Azure must be greater than 10 Gbps, enable FastPath to bypass the ExpressRoute gateway from the data path.

- Use VPN gateways to connect branches or remote locations to Azure.

  - For higher resiliency, deploy zone-redundant gateways (where available).

- Use ExpressRoute Global Reach to connect large offices /regional headquarters/datacenter that are connected to Azure via ExpressRoute.

- When traffic isolation or dedicated bandwidth is required, such as for separating production and nonproduction environments, different ExpressRoute circuits should be used to ensure isolated routing domains and to alleviate noisy neighbor risks.

- Proactively monitor ExpressRoute circuits using network performance monitor.

<!-- -->

- Do not explicitly use ExpressRoute circuits from a single peering location as it creates a single point of failure, making the customer likely susceptible to peering location outages.

- Do not use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth, so as to avoid "noisy neighbor" risks.

## 5. Connectivity to Azure PaaS services

Building on the previous connectivity sections, this section will explore recommended connectivity approaches when using Azure PaaS services.

**Design considerations:**

- Azure PaaS services are typically accessed over public endpoints, however, the Azure platform provides capabilities to secure such endpoints or even make them entirely private.

  - Virtual network injection provides dedicated private deployments for supported services. But management plane traffic flows through public IP addresses.

  - [Private Link](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access using private IP addresses to Azure PaaS instances, or custom services behind an Azure Load Balancer standard.

  - Virtual network service endpoints provide service level access from selected subnets to selected PaaS services.

- Enterprise customers often have concerns regarding public endpoints for PaaS services which must be appropriately mitigated.

- For [supported services](https://docs.microsoft.com/azure/private-link/private-link-overview#availability), Private Link addresses data exfiltration concerns associated with service endpoints.

  - Alternatively, outbound filtering via NVAs can be used to provide data exfiltration risk mitigations.

**Design recommendations:**

- Use virtual network injection for supported Azure services to make them available from within a customer virtual network.

- Azure PaaS services that have been injected into a virtual network still perform management plane operations using public IP addresses. Ensure that this communication is locked down within the virtual network using UDRs and NSGs.

- Use Azure Private Link, where available, for shared Azure PaaS services.

  - Private Link is ga for several services and is in public preview for numerous ones. Private Link availability is detailed [here](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource). Customer requirements should be carefully aligned with the product [roadmap](https://aka.ms/privatePaaS).

- Access Azure PaaS services from on-premises via ExpressRoute private peering, using either virtual network injection for dedicated Azure services or Azure Private Link for available shared Azure services.

  - To access Azure PaaS services from on-premises when virtual network injection or Private Link are not available, use ExpressRoute with Microsoft peering when there are no data exfiltration concerns. This would avoid transiting over the public internet.

- Use virtual network service endpoints to secure access to Azure PaaS services from within a customer virtual network, but only when Private Link is not available and when there are no data exfiltration concerns. To address data exfiltration concerns with service endpoints:

  - Use NVA filtering.

  - Use virtual network service endpoint policies for Azure Storage.

- Do not enable virtual network service endpoints by default on all subnets.

- Do not use virtual network service endpoints when there are data exfiltration concerns, unless NVA filtering is used.

- It is strongly recommended to not implement forced tunneling to enable communication from Azure to Azure resources.

## 6. Planning for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.

**Design considerations:**

- Azure native network security services such as Azure Firewall, Application Gateway WAF, and Azure front door WAF are fully managed services, meaning that customers do not incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

- The "enterprise-scale" architecture is fully compatible with third-party NVAs, should the customer prefer to use NVAs or for situations where native services do not satisfy specific customer requirements.

**Design recommendations:**

- Use Azure Firewall to govern:

  - Azure outbound traffic to the internet

  - Non-HTTP/S inbound connections

  - East-west traffic filtering (if required by customer)

- Use Firewall Manager with Azure Virtual WAN to deploy and manage Azure firewalls across Azure Virtual WAN hubs, or in hub virtual networks.

  - Firewall Manager is currently in preview for both virtual WAN and regular virtual networks.

- Create a global Azure Firewall policy to govern security posture across the global network environment and assign it to all Azure firewalls. Allow for granular policies to meet requirements of specific regions by delegating incremental firewall policies to local security teams via RBAC.

- Configure supported third-party SaaS security providers within Firewall Manager if the customer wishes to use such solutions to protect outbound connections.

- Use Application Gateway WAF within a "landing zone" virtual network for protecting inbound HTTP/S traffic from the internet.

- Use Azure front door WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a "landing zone".

- When using Azure front door and application gateway to protect HTTP/S applications, use WAF policies in front door and lock down application gateway to receive traffic only from Azure front door.

- If third-party NVAs are required for east-west and/or south-north traffic protection/filtering:

  - For virtual WAN network topologies, deploy the NVAs to a separate virtual network (I.e. NVA virtual network) and connect it to the regional virtual WAN hub as well as to the "landing zones" that require access to NVAs as described in this [article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-route-table-portal).

  - For nonvirtual WAN network topologies, deploy the third-party NVAs in the central hub virtual network.

- If third-party NVAs are required for inbound HTTP/S connections, they should be deployed within a "landing zone" virtual network, together with the applications that they are protecting and exposing to the internet.

- Use Azure DDoS standard protection plans to protect all public endpoints hosted within customer virtual networks.

- Do not replicate on-premises DMZ concepts and architectures into Azure, as customers can get similar security capabilities in Azure as on-premises, but the implementation and architecture will need to be adapted to the cloud.

## 7. Planning for application delivery

This section explores key recommendations to deliver internal and external facing applications in a secure, highly scalable and highly available manner.

**Design considerations:**

- Azure Load Balancer (internal and public) provides high availability for application delivery at a regional level.

- Azure Application Gateway allows the secure delivery of HTTP/S applications at a regional level.

- Azure front door allows the secure delivery of highly available HTTP/S applications across Azure regions.

- Azure traffic manager allows the delivery of global applications.

**Design recommendations:**

- Application delivery for both internal and external facing applications should be performed within a "landing zones".

- For secure delivery of HTTP/S applications, use application gateway v2 and ensure WAF protection/policies are enabled.

- Use a third-party NVAs if application gateway v2 cannot be used for the security of HTTP/S applications.

- Application gateway v2 or third-party NVAs used for inbound HTTP/S connections, should be deployed within the "landing zone" virtual network, together with the applications that they are securing.

- All public IP addresses in a "landing zone" should be protected with a DDoS standard protection plan.

- Global HTTP/S applications that span Azure regions should be delivered and protected using Azure front door with WAF policies.

- When using Azure front door and application gateway to protect HTTP/S applications, use WAF policies in front door and lock down application gateway to receive traffic only from Azure front door.

- Global applications that span protocols other than HTTP/S should be delivered using Azure traffic manager.

## 8. Planning for "landing zone" network segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a "landing zone" to drive a network zero trust implementation.

**Design considerations:**

- The zero trust model assumes a breached state and verifies each request as though it originates from an uncontrolled network.

- An advanced zero trust network implementation employs fully distributed ingress/egress cloud micro-perimeters and deeper micro-segmentation.

- Network security groups can use Azure service tags to facilitate connectivity to Azure PaaS services.

- Application security groups do not span or provide protection across virtual networks.

- NSG flow logs are now supported using ARM templates.

**Design recommendations:**

- Delegate subnet creation to the "landing zone" owner. This will enable them to define how to segment workloads across subnets (I.e. Single large subnet, multitier app, virtual network injected app).

  - The platform team can use Azure Policy to ensure an NSG with specific rules (such as deny inbound SSH or RDP from internet, or allow/block traffic across landing zones) is always associated to subnets with deny only policies.

- NSGs must be used to protect traffic across subnets, as well as east-west traffic across the platform (inter "landing zone" traffic).

- Application team should use application security groups at the subnet level NSGs to protect multitier VMs within their "landing zone".

- Use NSGs and asgs to microsegment traffic within the "landing zone" and avoid using a central NVA to filter these traffic flows.

- Is recommended to enable NSG flow logs and feed them into traffic analytics to gain insights into internal and external traffic flows.

- Use NSGs to selectively whitelist inter "landing zone" connectivity.

- For virtual-wan-based network topologies, route traffic across "landing zones" via Azure Firewall only if the customer requires packet inspection and logging capabilities for traffic flowing across "landing zones".

## 9. Define network encryption requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

**Design considerations:**

- Cost and available bandwidth are inversely proportional to length of encryption tunnel between endpoints.

- When using VPN to connect to Azure, traffic is encrypted over the internet via IPsec tunnels.

- When using ExpressRoute with private peering, traffic is not currently encrypted.

- MACsec encryption can be applied to ExpressRoute Direct to achieve network encryption.

- Azure does not currently offer native encryption over global virtual network peering.

  - If encryption between Azure regions is required today, it is possible to connect virtual networks using VPN gateways rather than global virtual network peering.

**Design recommendations:**
![Encryption Flows](./media/enc-flows.png)

_Figure 8: Encryption flows._

- When establishing VPN connections from on-premises to Azure using VPN gateways, traffic is encrypted at a protocol level using IPsec tunnels, as depicted in flow a in the diagram above.

- When utilising ExpressRoute Direct, configure [MACsec](https://docs.microsoft.com/azure/expressroute/expressroute-howto-MACsec) in order to encrypt traffic at l2 level between the customer's routers and MSEE, as depicted in flow B in the diagram above.

- For Azure Virtual WAN scenarios, and where MACsec is not an option (for example, not using ExpressRoute Direct), use virtual WAN VPN gateway to establish IPsec tunnels over ExpressRoute private peering. This is depicted by flow C in the diagram above.

- For non-virtual-wan scenarios, and where MACsec is not an option (for example, not using ExpressRoute Direct), today the only options is to use third-party NVAs to establish IPsec tunnels over ExpressRoute private peering or establish a VPN tunnel over ExpressRoute with Microsoft peering.

  - It's in the roadmap to support IPsec encryption for ExpressRoute private peering.

- If traffic between Azure regions must be encrypted, use VPN gateways to connect virtual networks across regions.

- Do not use third-party NVAs in Azure to encrypt traffic over ExpressRoute private peering without first validating native Azure capabilities as depicted in flows *B* and *C* above.

## 10. Planning for traffic inspection

In many industries customers require that traffic in Azure, particularly inbound and outbound internet traffic, is mirrored to a network packet collector for deep inspection and analysis. This section therefore explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

**Design considerations:**

- While [Azure Virtual Network tap (vtap)](https://docs.microsoft.com/azure/virtual-network/virtual-network-tap-overview) (in preview) is available in all Azure regions, currently the preview program is on hold.

- Network Watcher packet captures in Network Watcher is ga, but captures are limited to a maximum period of 5 hours.

**Design recommendations:**

- As virtual network tap in preview is on hold, evaluate the following options:

  - Use Network Watcher packet capture despite the limited capture window.

  - Evaluate if NSG flow logs v2 provide the level of detail required.

  - Use third-party solutions, such as gigamon, for scenarios where sustained deep packet inspection is required.

  - Do not block Azure deployments just because vtap is unavailable.

  - Do not develop a custom solution to mirror traffic. While this might be acceptable for small scale scenarios, this approach is not encouraged at scale due to complexity and supportability issues which may arise.
