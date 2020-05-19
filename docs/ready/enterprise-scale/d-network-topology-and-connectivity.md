---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# D. Network Topology and Connectivity

This section will examine key design considerations and recommendations surrounding networking and connectivity to/from Azure, as well as within Azure.

## 1. Planning for IP Addressing

It is vital that enterprise customers plan for IP addressing in Azure to ensure there is no overlapping IP address space across considered on-premises locations and Azure regions.

***Design Considerations***

-   Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

-   While Virtual Network address space can be added after creation, this process will require an outage if the Virtual Network is already connected to another Virtual Network via peering, since the Virtual Network peering will have to be deleted and re-created.

-   Azure reserves 5 IP addresses within each subnet which should be factored in when sizing Virtual Networks and encompassed subnets.

-   Some Azure services do require [dedicated subnets](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network), such as Azure Firewall or Virtual Network Gateway.

-   Subnets can be delegated to certain services to create instances of that service within the subnet.

***Design Recommendations***

-   Plan for non-overlapping IP address spaces across Azure regions and on-premises locations well in advance.

-   Use IP addresses from the address allocation for private internets (RFC 1918).

-   For environments with limited private IP addresses (RFC 1918) availability, consider using IPv6.

<!-- -->

-   Do not create unnecessarily large Virtual Networks (for example: /16) to ensure there is no unnecessary wastage of IP address space.

-   Do not create Virtual Networks without planning the required address space in advance, since adding address space will cause an outage once a Virtual Network is connected via Virtual Network Peering.

-   Do not use public IP addresses for Virtual Networks, especially if the public IP addresses do not belong to the customer.

## 2. Configure DNS and name resolution for on-premises and Azure resources

DNS is a critical design topic in the overall "North Star" architecture, and while some customers may want to use their existing investments in DNS, others may see cloud adoption as an opportunity to modernize their internal DNS infrastructure and leverage native Azure capabilities.

***Design Considerations***

-   A DNS resolver can be used in conjunction with Azure Private DNS for cross-premises connectivity.

-   Customers may require the use of existing DNS solutions across on-premises and Azure.

-   The maximum number of private DNS zones a Virtual Network can get linked to with auto-registration enabled is only one.

-   The maximum number of private DNS zones a Virtual Network can get linked to is 1000 without auto-registration enabled.

***Design Recommendations***

-   For environments where name resolution in Azure is all that is required, use Azure Private DNS for resolution by creating a delegated zone for name resolution (example azure.contoso.com).

-   For environments where name resolution across Azure and on-premises is required, use existing DNS infrastructure (for example, Active Directory integrated DNS) deployed onto at least two Azure VMs and configure DNS settings in Virtual Networks to use those DNS servers.

     - Azure Private DNS can still be used where the Azure Private DNS Zone is linked to the VNets and DNS servers are used as hybrid resolvers with conditional forwarding to on-premises DNS names (such as onprem.contoso.com) leveraging on-premises DNS servers.

     - On-premises servers can be configured with conditional forwarders to resolver VMs in Azure for the Azure Private DNS zone (for example, azure.contoso.com).

-   Special workloads that require and/or deploy their own DNS (i.e. OpenShift) should use their preferred DNS solution.

-   Auto-registration should be enabled for Azure DNS to automatically manage the life cycle of the DNS records for the Virtual Machines deployed within a Virtual Network.

-   Use a Virtual Machine as a resolver for cross-premises DNS resolution with Private DNS.

     - This is a short-term solution since an Azure native resolver is on the Azure Private DNS roadmap.

-   Create the Azure Private DNS zone within a global "Connectivity" subscription.

     - Additional Azure Private DNS zones might be created (for example privatelink.database.windows.net or privatelink.blob.core.windows.net for Private Link).

## 3. Define an Azure Networking Topology

Network topology is a critical foundational element of the "North Star" architecture as it ultimately defines how applications can communicate with one another. This section will therefore explore relevant technologies and topology approaches for enterprise Azure deployments,focusing on two core approaches:

A.    Azure Virtual WAN Based Networking  Topology

B.    Traditional Azure Networking Topology


An Azure networking topology based-on Azure Virtual WAN is the preferred NorthStar approach for large scale multi-region deployments where the customer needs to interconnect all their global locations on both Azure and on-premises. An Azure Virtual WAN based network topology should also be used whenever the customer intends to leverage SD-WAN deployments fully integrated with Azure. Azure Virtual WAN is used to meet these large-scale interconnectivity requirements, but at the same time it will also reduce overall network complexity and help to modernize the customers network since Virtual WAN is a networking service managed by Microsoft.


However, a traditional Azure networking topology should be used for customers that either 1) only intend to deploy resources in a few Azure regions, 2) have no need for a global interconnected network, 3) have a low number of remote/branch locations per region (less than 30), and/or 4)require full control and granularity for manually configuring their Azure network. This will enable these customers to build a secure network foundation in Azure.


## A. Azure Virtual WAN (Microsoft Managed) Based Network Topology

[![Network Topology and Connectivity](./media/net-con2.png "Network Topology and Connectivity")](#)

Figure 6 – Azure Virtual WAN based network topology
 
***Design Considerations***

-   [Azure Virtual WAN](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about) is a Microsoft-managed solution, where end-to-end global transit connectivity is provided out-of-the-box. Virtual WAN Hubs eliminate the need for customers to manually setup the network connectivity. As an example, customer does not require to setup UDRs or NVAs to enable global transit connectivity.

-   Azure Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises by creating a [hub and spoke network architecture](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-global-transit-network-architecture) that spans multiple Azure regions and on-premises locations (any-to-any connectivity) out-of-the-box, as depicted in the picture below:

[![Network Topology and Connectivity](./media/global-transit.png "Network Topology and Connectivity")](#)

Figure 7 – Global transit network with Azure Virtual WAN

-   Azure Virtual WAN any-to-any transitive connectivity supports the following paths (within the same region and across regions): 

     - VNet to VNet  
     - VNet to Branch 
     - Branch to VNet 
     - Branch to Branch 

-   Azure Virtual WAN Hubs are locked down, and the only resources that customer can deploy within them are Virtual Network Gateways (P2S and S2S VPN and ExpressRoute), Azure Firewall via Firewall Manager and Route Tables.

-   Azure Virtual WAN increases the limit of up to 200 prefixes advertised from Azure to on-premises via ExpressRoute Private Peering to 10,000 prefixes per single Virtual WAN Hub. The limit of 10,000 prefixes also includes VPN (S2S and P2S VPN). 

-   VNet to VNet transitive connectivity (within a region and across regions) is in public preview, and throughput is limited currently available up to 3Gbps (to be increased to > 20Gbps by GA).

-   Azure Virtual WAN Hub to Hub connectivity is currently in Public Preview.

-   Azure Virtual WAN integrates with a variety of SD-WAN [providers](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-locations-partners).

-   Many MSPs provide [managed services](https://docs.microsoft.com/en-us/azure/networking/networking-partners-msp) for Virtual WAN.

-   VPN Gateways in Azure Virtual WAN scale up to 20Gbps and 20,000 connections per Virtual Hub.

-   ExpressRoute Circuits with the Premium add-on are required and, they should be from an ExpressRoute Global Reach location.

-   Azure Firewall Manager (currently in Public Preview) allows the deployment of the Azure Firewall in the Virtual WAN Hub.

-   Azure Virtual WAN Hub to Hub traffic via Azure Firewall is currently not supported.

     - As alternative, use native Hub to Hub transit routing capabilities in Azure VWAN and use NSGs to allow/block VNet traffic across Hubs.


***Design  Recommendations***


-   Azure Virtual WAN is highly recommended for new large/global network deployments in Azure where customers require global transit connectivity across Azure regions and on-premises locations, without having to manually setup Azure networking transitive routing by themselves.

     - The following figure depicts a sample global customer deployment with datacenters spread across Europe and the United States, as well as a large number of branch offices within both regions. The environment is globally connected via Azure Virtual WAN and ExpressRoute Global Reach.

[![Example Network Topology](./media/eg-net-top.png "Example Network Topology")](#)

Figure 8 – Example Network Topology

-   Leverage Azure Virtual WAN as a global connectivity resource, with a Virtual WAN Hub per Azure region to connect multiple "Landing Zones" together across Azure regions via their local Virtual WAN Hub.

-   Connect Virtual WAN Hubs to on-premises data centers using ExpressRoute.

-   Connect branches/remote locations to the nearest Virtual WAN Hub via S2S VPN, or enable branch connectivity to Azure VWAN via SD-WAN partner solution.

-   Connect end users to the Virtual WAN Hub via P2S VPN.

-   It is strongly recommended that the principal of **"traffic in Azure stays in Azure"** is followed, so that communication across resources in Azure, even if they are in different regions, occurs via the Microsoft backbone network.

-   Deploy Azure Firewall in Virtual WAN Hubs for east-west and south-north traffic protection/filtering within an Azure region.

-   If 3rd party NVAs are required for east-west and/or south-north traffic protection/filtering, deploy the NVAs to a separate VNet (i.e. NVA VNet) and connect it to the regional Virtual WAN Hub as well as to the "Landing Zones" that require access to NVAs as described in this [article.](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-route-table-portal) 

-   In the case of deploying 3rd party networking technologies/NVAs, please follow the 3rd party vendor's guidance, to ensure there are no conflicting configurations with Azure networking.

-   Do not build a transit network on top of Azure Virtual WAN, as Virtual WAN satisfies all transitive networking topology requirements, including the ability to use 3rd party NVAs. 

-   It is recommended not to use existing on-premises network (i.e. MPLS) to connect Azure resources across Azure regions, as Azure networking technologies allow the interconnection of Azure resources across regions through the Microsoft backbone.

-   For brownfield scenarios where you are migrating from a non-Virtual WAN based hub & spoke network topology, refer to this migration [article](https://docs.microsoft.com/en-us/azure/virtual-wan/migrate-from-hub-spoke-topology).

-   Azure Virtual WAN and Azure Firewall resources should be created within the "Connectivity" subscription.

-   Do not create more than 500 VNet connections per VWAN VHub.


    ## B. Traditional Azure Networking (Customer Managed) Topology

    While Azure VWAN offers a wide range of powerful capabilities, there are some cases where a traditional Azure networking approach may preferential, such as:

-   If a global transitive network across multiple Azure regions and/or cross-premises is not required (for example, a branch in US requiring to connect to a VNet in Europe).

-   If there is no need to connect to a large number of remote locations via VPN or integration with a SD-WAN solution.

-   If the customer's preference is to have granular control and configuration when setting up a network topology in Azure.



    [![Network Topology and Connectivity](./media/cmanged-nt.png "Network Topology and Connectivity")](#)

- Figure 9 – Customer managed Azure network topology

***Design Considerations***

-   There are multiple network topologies to connect multiple "Landing Zones" VNets: one large flat VNet, multiple VNets connected with multiple ExpressRoute circuits/connections, hub and spoke, full mesh or hybrid. 

-   VNets do not traverse subscription boundaries but connectivity between VNets in different subscriptions can be achieved using either VNet Peering, an ExpressRoute circuit or using VPN Gateways.

-   VNet Peering can be used to connect Virtual Networks in the same region, across different Azure regions, and even across different Azure AD tenants.

-   VNet Peering, as well as Global VNet Peering, are not transitive, therefore UDRs and NVAs are required to enable a transit network as described on this [article](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

-   ExpressRoute circuits can be used to establish connectivity across Virtual Networks within the same geo-political region or by leveraging the Premium add-on for connectivity across geo-political regions.

     - VNet to VNet traffic may experience additional latency since traffic must hairpin at the MSEE.

     - Bandwidth will be constrained to the ExpressRoute Gateway SKU.

     - Customers must still deploy and manage UDRs should they require inspection/logging for cross-VNet traffic.

-   VPN Gateways with BGP are transitive within Azure and on-premises, but do not transit across ExpressRoute Gateways.

-   When multiple ExpressRoute circuits are connected to the same VNet, connection weights and BGP techniques (as described on this [article](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-optimize-routing) must be used to ensure an optimal path for traffic from on-premises to Azure and vice versa.

-   Using BGP techniques to influence ExpressRoute routing is a configuration outside the Azure cloud, therefore customer and/or their connectivity provider must configure their on-premises routers accordingly.

-   ExpressRoute circuits with Premium add-on provide global connectivity, however, the maximum number of ExpressRoute connections per ExpressRoute Gateway is 4.

-   While the maximum number of VNet peering connections per VNet is 500, the maximum number of routes that can be advertised from Azure to on-premises via ExpressRoute Private Peering is 200.

-   VPN Gateways maximum aggregated throughput is 10Gbps and support up to 30 S2S/VNet-to-VNet Tunnels.

***Design Recommendations***

-   A network design based in the hub & spoke network topology with non-VWAN technologies should be considered for the following scenarios: 

     - Azure deployments where traffic boundary is within an Azure region.

     -  A network architecture with up to two Azure regions, where there is a requirement for transit connectivity between "Landing Zones VNets" across regions.

     -  A network architecture spanning multiple Azure regions and there is no need for transitive connectivity between "Landing Zones" VNets across regions.

     - There is no need for transitive connectivity between VPN and ExpressRoute connections.

     -   The main cross-premises connectivity channel is ExpressRoute, and the number of VPN connections is less than 30 per VPN Gateway.

     - There is a heavy dependency on centralized NVAs and complex/granular routing.

-   For regional deployments, primarily use the hub and spoke topology, with "Landing Zones" VNets connecting with VNet peering to a central hub VNet for cross-premises connectivity via ExpressRoute, VPN for branch connectivity, spoke to spoke connectivity via NVA and UDRs, and internet-outbound protection via NVA as depicted in the picture below.

![Network Topology and Connectivity](./media/HS.png "Network Topology and Connectivity")

Figure 10 – Hub and spoke network topology

-   When a high level of isolation, dedicated ExpressRoute bandwidth is required for specific business units, or the maximum number of connections per ExpressRoute Gateway (up to 4) is reached, use the multiple VNets connected with multiple ExpressRoute circuits topology as depicted in the picture below:

![Network Topology and Connectivity](./media/MvnetHS.png "Network Topology and Connectivity")

Figure 11 – Multiple VNets connected with multiple ExpressRoute circuits

-   Deploy a set of minimal shared services, including ExpressRoute Gateways, VPN Gateways (as required) and Azure Firewall or 3rd party NVAs (as required) in the central hub VNet. If required, deploy also Active Directory Domain Controllers and DNS Servers.

-   Deploy Azure Firewall or 3rd party NVAs for east-west and/or south-north traffic protection/filtering, in the central hub VNet.

-   In case of deploying 3rd party networking technologies/NVAs, please follow the 3rd party vendor's guidance, to ensure deployment is supported by vendor, designed for HA and maximal performance, as well as there are no conflicting configurations with Azure networking.

-   L7 Inbound NVAs (such as Application Gateway) should not be deployed as a shared service in the central hub VNet. Instead, they should be deployed together with the application in their respective "Landing Zone".

-   Use existing customer network (MPLS, SD-WAN) for connecting branch locations with corporate headquarters. Transit in Azure between ExpressRoute and VPN Gateways is not supported.

-   For network architectures with multiple hub & spoke topologies across Azure regions, use Global VNet Peering to connect "Landing Zone" VNets when a small number of "Landing Zones" need to communicate across regions.

     - Note that this approach would offer benefits as high network bandwidth with Global VNet Peering (as allowed by the VM SKU), but will bypass the central NVA (in case traffic inspection/filtering is required), as well as this would be subject to Global VNet Peering [limitations](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview#constraints-for-peered-virtual-networks).

-   When customer deploys a hub & spoke network architecture in two Azure regions, and transit connectivity between all "Landing Zones" across regions is required, use ExpressRoute with dual circuits to provide transit connectivity for "Landing Zones" VNets across Azure regions. In this scenario, "Landing Zones" can transit within a region via NVA in local hub VNet, and across regions via ExpressRoute circuit, with the traffic hairpining at the MSEE. This design is depicted in the picture below:

![Network Topology and Connectivity](./media/MvnetHSPP.png "Network Topology and Connectivity")


-   When customer requires hub & spoke network architectures across more than two Azure regions, and global transit connectivity between "Landing Zones" VNets across Azure regions is required, while this architecture could be implemented by interconnecting central hub VNets with Global VNet Peering, and using UDRs + NVAs to enable global transit routing, the complexity and management overhead is high. Instead, we recommend deploying such a global transit network architecture with Azure Virtual WAN.

-   Use [Azure Monitor Network Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/network-insights-overview) (currently in preview) to monitor the end-to-end state of customer networks on Azure.

-   Do not create more than 200 peering connections per central hub VNet.

     - While Virtual Networks support up to 500 VNet peering connections, ExpressRoute with Private Peering only supports advertising up to 200 prefixes from Azure to on-premises.


## 4. Connectivity to Azure

This section will expand on the network topology to consider recommended models for connecting on-premises locations to Azure.

***Design Considerations***

-   Azure ExpressRoute provides dedicated private connectivity to Microsoft Azure services (IaaS and PaaS) from on-premises locations.

-   Private Link can be used to establish connectivity to PaaS services over ExpressRoute with Private Peering.

-   When multiple virtual networks are connected to the same ExpressRoute circuit, they will become part of the same routing domain and all virtual networks will share the bandwidth.

-   ExpressRoute Global Reach (where available) allows customers to connect on-premises locations together using ExpressRoute circuits to transit traffic over the Microsoft backbone network.

-  ExpressRoute Global Reach is available in many ExpressRoute peering [locations](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-global-reach#availability).

-   ExpressRoute Direct allows to create multiple ExpressRoute circuits at no additional cost, up to the ExpressRoute Direct port capacity (10G or 100G and allows you to connect directly to Microsoft's ExpressRoute routers).

    - For the 100 Gbps SKU, the minimum circuit bandwidth is 5 Gbps.

    - For the 10 Gbps SKU, the minimum circuit bandwidth is 1 Gbps.

***Design Recommendations***

-   Use ExpressRoute as the primary connectivity channel for connecting on-premises network to Microsoft Azure.

    -   Leverage Private Peering with Private Link to establish connectivity to PaaS services.

    -   VPNs can be used as a source of backup connectivity to enhance connectivity resiliency.

-   Use dual ExpressRoute circuits from different peering locations when connecting an on-premises location to Virtual Networks in Azure. This setup will ensure redundant paths to Azure, removing single points of failure between on-premises and Azure.

-   When multiple ExpressRoute circuits are used, [optimize routing](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-optimize-routing) by using BGP local preference and AS Path prepending.

-   Ensure the right SKU is used for the ExpressRoute/VPN Gateways based on bandwidth and performance requirements.

-   Deploy a Zone Redundant ExpressRoute Gateway in the supported Azure regions.

-   For scenarios that require bandwidth higher than 10Gbps or dedicated 10/100 Gbps ports, use ExpressRoute Direct.

-   When very low latency is required, or throughput from on-premises to Azure must be greater than 10 Gbps, enable FastPath to bypass the ExpressRoute Gateway from the data path.

-   Use VPN Gateways to connect branches or remote locations to Azure.

    -   For higher resiliency, deploy Zone-Redundant Gateways (where available).

-   Use ExpressRoute Global Reach to connect large offices /regional headquarters/datacenter that are connected to Azure via ExpressRoute.

-   When traffic isolation or dedicated bandwidth is required, such as for separating production and non-production environments, different ExpressRoute circuits should be used to ensure isolated routing domains and to alleviate noisy neighbour risks.

-   Proactively monitor ExpressRoute circuits using Network Performance Monitor.

<!-- -->

-   Do not explicitly use ExpressRoute circuits from a single peering location as it creates a single point of failure, making the customer likely susceptible to peering location outages.

-   Do not use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth, so as to avoid "noisy neighbour" risks.

## 5. Connectivity to Azure PaaS Services

Building on the previous connectivity sections, this section will explore recommended connectivity approaches when leveraging Azure PaaS services.

***Design Considerations***

-   Azure PaaS services are typically accessed over public endpoints, however, the Azure platform provides capabilities to secure such endpoints or even make them entirely private.

     - VNet injection provides dedicated private deployments for supported services. However, management plane traffic flows through public IP addresses.

     - [Private Link](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access using private IP addresses to Azure PaaS instances, or custom services behind an Azure Load Balancer Standard.

     - VNet Service Endpoints provide service level access from selected subnets to selected PaaS services.

-   Enterprise customers often have concerns regarding public endpoints for PaaS services which must be appropriately mitigated.

-   For [supported services](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview#availability), Private Link addresses data exfiltration concerns associated with Service Endpoints.

     - Alternatively, outbound filtering via NVAs can be used to provide data exfiltration risk mitigations.


***Design Recommendations***

-   Use VNet injection for supported Azure services to make them available from within a customer Virtual Network.

-   Azure PaaS services that have been injected into a Virtual Network still perform management plane operations using public IP addresses. Ensure that this communication is locked down within the Virtual Network using UDRs and NSGs.

-   Use Azure Private Link, where available, for shared Azure PaaS services.

     - Private Link is GA for several services and is in public preview for numerous ones. Private Link availability is detailed [here](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource). Customer requirements should be carefully aligned with the product [roadmap](https://aka.ms/privatePaaS).

-   Access Azure PaaS services from on-premises via ExpressRoute Private Peering, using either VNet injection for dedicated Azure services or Azure Private Link for available shared Azure services.

     - To access Azure PaaS services from on-premises when VNet injection or Private Link are not available, use ExpressRoute with Microsoft Peering when there are no data exfiltration concerns. This would avoid transiting over the public internet.

-   Use VNet Service Endpoints to secure access to Azure PaaS services from within a customer VNet, but only when Private Link is not available and when there are no data exfiltration concerns. To address data exfiltration concerns with Service Endpoints:

     - Use NVA filtering.

     - Use VNet Service Endpoint Policies for Azure Storage.

-   Do not enable VNet Service Endpoints by default on all subnets.

-   Do not use VNet Service Endpoints when there are data exfiltration concerns, unless NVA filtering is used.

-   It is strongly recommended to not implement forced tunneling to enable communication from Azure to Azure resources.


## 6. Planning for Inbound and Outbound Internet Connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public Internet.

***Design Considerations***

-   Azure native network security services such as Azure Firewall, Application Gateway WAF, and Azure Front Door WAF are fully managed services, meaning that customers do not incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

-   The "North Star" architecture is fully compatible with 3rd party NVAs, should the customer prefer to use NVAs or for situations where native services do not satisfy specific customer requirements.

***Design Recommendations***

-   Use Azure Firewall to govern:

     - Azure outbound traffic to the internet

     - Non-HTTP/S inbound connections

     - East-west traffic filtering (if required by customer)

-   Use Firewall Manager with Azure Virtual WAN to deploy and manage Azure Firewalls across Azure Virtual WAN Hubs, or in Hub VNets.

     - Firewall Manager is currently in Preview for both Virtual WAN and regular VNets.

-   Create a global Azure Firewall policy to govern security posture across the global network environment and assign it to all Azure Firewalls. Allow for granular policies to meet requirements of specific regions by delegating incremental Firewall Policies to local security teams via RBAC.

-   Configure supported 3rd party SaaS security providers within Firewall Manager if the customer wishes to use such solutions to protect outbound connections.

-   Use Application Gateway WAF within a "Landing Zone" Virtual Network for protecting inbound HTTP/S traffic from the internet.

-   Use Azure Front Door WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a "Landing Zone".

-   When using Azure Front Door and Application Gateway to protect HTTP/S applications, use WAF policies in Front Door and lock down Application Gateway to receive traffic only from Azure Front Door.

-   If 3rd party NVAs are required for east-west and/or south-north traffic protection/filtering: 

     - For VWAN network topologies, deploy the NVAs to a separate VNet (i.e. NVA VNet) and connect it to the regional Virtual WAN Hub as well as to the "Landing Zones" that require access to NVAs as described in this [article](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-route-table-portal).

     - For non-Virtual WAN network topologies, deploy the 3rd party NVAs in the central Hub VNet.

-   If 3rd party NVAs are required for inbound HTTP/S connections, they should be deployed within a "Landing Zone" Virtual Network, together with the applications that they are protecting and exposing to the internet.

-   Use Azure DDoS Standard Protection Plans to protect all public endpoints hosted within customer Virtual Networks.

-   Do not replicate on-premises DMZ concepts and architectures into Azure, as customers can get similar security capabilities in Azure as on-premises, but the implementation and architecture will need to be adapted to the cloud.

## 7. Planning for Application Delivery

This section explores key recommendations to deliver internal and external facing applications in a secure, highly scalable and highly available manner.

***Design Considerations***

-   Azure Load Balancer (internal and public) provides high availability for application delivery at a regional level.

-   Azure Application Gateway allows the secure delivery of HTTP/S applications at a regional level.

-   Azure Front Door allows the secure delivery of highly available HTTP/S applications across Azure regions.

-   Azure Traffic manager allows the delivery of global applications.

***Design Recommendations***

-   Application delivery for both internal and external facing applications should be performed within a "Landing Zones".

-   For secure delivery of HTTP/S applications, use Application Gateway v2 and ensure WAF protection/policies are enabled.

-   Use a 3rd party NVAs if Application Gateway v2 cannot be used for the security of HTTP/S applications.

-   Application Gateway v2 or 3rd party NVAs used for inbound HTTP/S connections, should be deployed within the "Landing Zone" Virtual Network, together with the applications that they are securing.

-   All public IP addresses in a "Landing Zone" should be protected with a DDoS Standard protection plan.

-   Global HTTP/S applications that span Azure regions should be delivered and protected using Azure Front Door with WAF policies.

-   When using Azure Front Door and Application Gateway to protect HTTP/S applications, use WAF policies in Front Door and lock down Application Gateway to receive traffic only from Azure Front Door.

-   Global applications that span protocols other than HTTP/S should be delivered using Azure Traffic Manager.

## 8. Planning for "Landing Zone" Network Segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a "Landing Zone" to drive a network Zero Trust implementation.

***Design Considerations***

-   The Zero Trust model assumes a breached state and verifies each request as though it originates from an uncontrolled network.

-   An advanced Zero Trust network implementation employs fully distributed ingress/egress cloud micro-perimeters and deeper micro-segmentation.

-   Network Security Groups can use Azure Service Tags to facilitate connectivity to Azure PaaS services.

-   Application Security Groups do not span or provide protection across Virtual Networks.

-   NSG Flow Logs are now supported using ARM templates.

***Design Recommendations***

-   Delegate subnet creation to the "Landing Zone" owner. This will enable them to define how to segment workloads across subnets (i.e. single large subnet, multi-tier app, VNet injected app).

     - The Platform team can use Azure Policy to ensure an NSG with specific rules (such as deny inbound SSH or RDP from Internet, or allow/block traffic across landing zones) is always associated to subnets with Deny only policies.

-   NSGs must be used to protect traffic across subnets, as well as east-west traffic across the platform (inter "Landing Zone" traffic).

-   Application team should use Application Security Groups at the subnet level NSGs to protect multi-tier VMs within their "Landing Zone".

-   Use NSGs and ASGs to microsegment traffic within the "Landing Zone" and avoid using a central NVA to filter these traffic flows.

-   Is recommended to enable NSG Flow Logs and feed them into Traffic Analytics to gain insights into internal and external traffic flows.

-   Use NSGs to selectively whitelist inter "Landing Zone" connectivity.

-   For VWAN-based network topologies, route traffic across "Landing Zones" via Azure Firewall only if the customer requires packet inspection and logging capabilities for traffic flowing across "Landing Zones". 


## 9. Define Network Encryption Requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

***Design Considerations***

-   Cost and available bandwidth are inversely proportional to length of encryption tunnel between endpoints.

-   When using VPN to connect to Azure, traffic is encrypted over the internet via IPsec tunnels.

-   When using ExpressRoute with Private Peering, traffic is not currently encrypted.

-   MACsec encryption can be applied to ExpressRoute Direct to achieve network encryption.

-   Azure does not currently offer native encryption over Global VNet Peering. 

     - If encryption between Azure regions is required today, it is possible to connect VNets using VPN Gateways rather than Global VNet Peering.

***Design Recommendations***
[![Encryption Flows](./media/enc-flows.png "Encryption Flows")](#)

Figure 8 – Encryption Flows

-   When establishing VPN connections from on-premises to Azure using VPN Gateways, traffic is encrypted at a protocol level using IPsec tunnels, as depicted in flow A in the diagram above.

-   When utilising ExpressRoute Direct, configure [MACsec](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-MACsec) in order to encrypt traffic at L2 level between the customer's routers and MSEE, as depicted in flow B in the diagram above.

-   For Azure Virtual WAN scenarios, and where MACsec is not an option (for example, not using ExpressRoute Direct), use VWAN VPN Gateway to establish IPsec tunnels over ExpressRoute Private Peering. This is depicted by flow C in the diagram above.

-   For non-VWAN scenarios, and where MACsec is not an option (for example, not using ExpressRoute Direct), today the only options is  to use 3rd party NVAs to establish IPsec tunnels over ExpressRoute Private Peering or establish a VPN tunnel over ExpressRoute with Microsoft Peering.

     - It's in the roadmap to support IPsec encryption for ExpressRoute Private Peering.

-   If traffic between Azure regions must be encrypted, use VPN Gateways to connect VNets across regions. 

-   Do not use 3rd party NVAs in Azure to encrypt traffic over ExpressRoute Private Peering without first validating native Azure capabilities as depicted in flows *B* and *C* above.

## 10. Planning for Traffic Inspection

In many industries customers require that traffic in Azure, particularly inbound and outbound internet traffic, is mirrored to a network packet collector for deep inspection and analysis. This section therefore explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Networks.

***Design Considerations***

-   While [Azure Virtual Network TAP (VTAP)](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-tap-overview) (in preview) is available in all Azure regions, currently the preview program is on hold.

-   Network Watcher packet captures in Network Watcher is GA, but captures are limited to a maximum period of 5 hours.

***Design Recommendations***

-   As Virtual Network TAP in preview is on hold, evaluate the following options:

     - Use Network Watcher packet capture despite the limited capture window.

     - Evaluate if NSG Flow Logs v2 provide the level of detail required.

     - Use 3rd party solutions, such as Gigamon, for scenarios where sustained deep packet inspection is required.

     - Do not block Azure deployments just because VTAP is unavailable.

     - Do not develop a custom solution to mirror traffic. While this might be acceptable for small scale scenarios, this approach is not encouraged at scale due to complexity and supportability issues which may arise.
