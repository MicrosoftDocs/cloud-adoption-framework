---
title: Azure Virtual Desktop network topology and connectivity design guidance
description: Use the Cloud Adoption Framework for Azure to identify networking capabilities that are required for your landing zone to support Azure Virtual Desktop workloads.
author: jcoyne-msft
ms.author: pnp
ms.date: 10/09/2025
ms.topic: concept-article
---

# Azure Virtual Desktop network topology and connectivity design guidance

This article outlines how to design network topology and connectivity for Azure Virtual Desktop (AVD) within an Azure landing zone. It helps technical decision-makers understand the networking requirements their teams must follow to ensure secure and scalable connectivity across Azure, private networks, and the public internet. Before your organization deploys AVD, you should have an Azure landing zone in place. Then you deploy AVD resources into an application landing zone.

## AVD networking components

### Core networking components

- [**Azure Virtual Network**](/azure/virtual-network/virtual-networks-overview) is the fundamental building block for private networks in Azure. With Virtual Network, many types of Azure resources, such as Azure Virtual Machines, can communicate with each other, the internet, and on-premises datacenters. A virtual network is similar to a traditional network that you operate in your own datacenter. But a virtual network offers the Azure infrastructure benefits of scale, availability, and isolation.
- [**Hub-Spoke Network Topology**](/azure/architecture/networking/architecture/hub-spoke?tabs=cli) is a type of network architecture in which a hub virtual network acts as a central point of connectivity to several spoke virtual networks. The hub can also be the connectivity point to on-premises datacenters. The spoke virtual networks peer with the hub and help to isolate workloads.
- [**Azure Virtual WAN**](/azure/virtual-wan/virtual-wan-about) is a networking service that brings networking, security, and routing functions together in a single operational interface.

### Secure access and traffic control

- [**Network security groups**](/azure/virtual-network/network-security-groups-overview) are used to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.
- [**Application security groups**](/azure/virtual-network/application-security-groups) provide a way for you to configure network security as a natural extension of an application's structure. You can use application security groups to group virtual machines and define network security policies that are based on those groups. You can reuse your security policy at scale without needing to manually maintain explicit IP addresses.
- A [**NAT Gateway**](/azure/nat-gateway/nat-overview) provides NAT services for egress traffic from private subnets to the internet. It doesn't allow inbound traffic except for response packets. This setup provides Azure Virtual Desktop environments the ability to explicitly egress to the internet and also mitigate performance effects of sending AVD service traffic through a Firewall or NVA.

### Routing and optimization

- An [**Azure Firewall or network virtual appliance (NVA)**](/azure/firewall/protect-azure-virtual-desktop) is a network device that supports functions like connectivity, application control, wide-area network (WAN) optimization, and security. NVAs include Azure Firewall and vendor network appliances found in the marketplace.
- **[User-defined routes (UDRs)](/azure/virtual-network/virtual-networks-udr-overview)** can be used to override Azure default system routes. You can also use UDRs to add extra routes to a subnet route table that allows routing specific traffic and Azure services to destinations across your networks and Azure.

### Azure Virtual Desktop enhancements

- **[Remote Desktop Protocol Shortpath (RDP Shortpath)](/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks)** is a feature of Azure Virtual Desktop based on [Universal Rate Control Protocol (URCP)](https://www.microsoft.com/research/publication/urcp-universal-rate-control-protocol-for-real-time-communication-applications/). RDP Shortpath establishes a direct transport that uses the User Datagram Protocol (UDP) between a supported Windows Remote Desktop client and Azure Virtual Desktop session hosts. URCP enhances UDP connections by providing active monitoring of network conditions and quality-of-service (QoS) capabilities.
- **[Azure Private Link with Azure Virtual Desktop](/azure/virtual-desktop/private-link-overview)** (optional) provides a way for you to use a [private endpoint](/azure/private-link/private-endpoint-overview) in Azure to connect session hosts to the Azure Virtual Desktop service. With Private Link, traffic between your virtual network and the Azure Virtual Desktop service travels on the Microsoft *backbone* network. As a result, you don't need to connect to the public internet to access Azure Virtual Desktop services.

## AVD networking recommendations

Azure Virtual Desktop requires specific network design considerations to ensure reliable connectivity, security, and performance. Your network architecture directly impacts user experience, data protection, and operational efficiency across your virtual desktop environment.

### Plan AVD network topology

Use Virtual WAN when you require [transit connectivity between VPN and ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er). Virtual WAN provides a Microsoft-managed hub-and-spoke model (virtual hubs + connected virtual networks) with built-in transitive routing. Use Virtual WAN when you need managed global transit and integrated routing/security.

### Configure AVD identity services

- **Microsoft Entra Domain Services–joined VMs**: Ensure Azure Virtual Desktop networks have connectivity to the network hosting the identity service.

- **[Microsoft Entra ID–joined VMs](/azure/virtual-desktop/azure-ad-joined-session-hosts)**: Azure Virtual Desktop session hosts create outbound connections to Microsoft Entra ID public endpoints. No private connectivity configurations are required.

### Configure AVD DNS

Azure Virtual Desktop session hosts have the same name resolution requirements as any other infrastructure as a service (IaaS) workload. As a result, connectivity to custom DNS servers or access via a virtual network link to Azure private DNS zones is required. Extra Azure private DNS zones are required to host the private endpoint namespaces of certain platform as a service (PaaS) services, such as storage accounts and key management services. For more information, see [Azure private endpoint DNS configuration](/azure/private-link/private-endpoint-dns).

You can optionally configure email-based feed discovery to simplify user onboarding. Modern Azure Virtual Desktop clients can also subscribe directly using workspace discovery via the service without DNS-based email discovery. For more information, see [Set up email discovery to subscribe to your RDS feed](/windows-server/remote/remote-desktop-services/rds-email-discovery).

### Optimize AVD bandwidth and latency

Azure Virtual Desktop uses RDP. To learn more about RDP, see [Remote Desktop Protocol (RDP) bandwidth requirements](/azure/virtual-desktop/rdp-bandwidth).

The connection latency varies, depending on the location of the users and the VMs. Azure Virtual Desktop services continuously roll out to new geographies to improve latency. To minimize the latency that Azure Virtual Desktop clients experience, use the [Azure Virtual Desktop Experience Estimator](https://azure.microsoft.com/services/virtual-desktop/assessment/). This tool provides round-trip time (RTT) samples from clients. You can use this information to place session hosts in the region that's closest to end users and has the lowest RTT. For information about interpreting results from the estimator tool, see [Analyze connection quality in Azure Virtual Desktop](/azure/virtual-desktop/connection-latency).

### Implement AVD QoS policies with RDP Shortpath

RDP Shortpath for managed networks provides a direct UDP-based transport between a Remote Desktop client and a session host. RDP Shortpath for managed networks provides a way to configure QoS policies for the RDP data. QoS in Azure Virtual Desktop allows real-time RDP traffic that's sensitive to network delays to "cut in line" in front of less sensitive traffic. You can use RDP Shortpath in two ways:

- In **managed networks**, where direct connectivity is established between the client and the session host when you use a private connection, such as an ExpressRoute connection or a VPN.

- In **public networks**, where direct connectivity is established between the client and the session host when you use a public connection. Examples of public connections include home networks, coffee shop networks, and hotel networks. There are two possible connection types when you use a public connection. **A direct UDP connection** between a client and a session host that uses the STUN protocol. **An indirect UDP connection** that uses the TURN protocol with a relay between an RDP client and a session host. This option is used if the gateway or router doesn't allow direct UDP connections.

The RDP path extends RDP multi-transport capabilities. It doesn't replace the reverse connect transport but complements it. Initial session brokering is managed through the Azure Virtual Desktop service and the reverse connect transport, which is TCP-based. All connection attempts are ignored unless they match the reverse connect session first.

RDP Shortpath, which is UDP-based, is established after authentication. If RDP Shortpath is successfully established, the reverse connect transport is dropped. Then all traffic flows over one of the RDP Shortpath methods that this section lists earlier. For more information, see [RDP Shortpath for Azure Virtual Desktop](/azure/virtual-desktop/rdp-shortpath).

For more information, see [Implement Quality of Service (QoS) for Azure Virtual Desktop](/azure/virtual-desktop/rdp-quality-of-service-qos).

### Secure AVD internet access

Azure Virtual Desktop compute resources and clients require access to specific public endpoints, so they need internet-bound connections. Network scenarios, such as forced tunneling to enhance security and filtering, are supported when Azure Virtual Desktop requirements are met.

To understand requirements for Azure Virtual Desktop session hosts and client devices, see [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint).

### Validate AVD port and protocol requirements

The Azure Virtual Desktop connection models use the following ports and protocols:

- [Standard model](/azure/virtual-desktop/network-connectivity): 443/TCP
- [RDP Shortpath model](/azure/virtual-desktop/rdp-shortpath): 443/TCP and 3390/UDP or 3478/UDP for the STUN or TURN protocol

### AVD business continuity and disaster recovery

For business continuity and disaster recovery, a certain networking setup is required. Specifically, to deploy and recover resources to a target environment, use one of the following configurations:

- A networking setup with the same capabilities as the one on the source environment
- A networking setup that has connectivity to identity and DNS services

## AVD networking scenarios

To establish the Azure Virtual Desktop landing zone, the design and implementation of networking capabilities is critical. Azure networking products and services support a wide variety of capabilities. The architecture that you choose and the way that you structure services depend on your organization's workloads, governance, and requirements.

The following key requirements and considerations affect your Azure Virtual Desktop deployment decisions:

- Internet ingress and egress requirements.
- NVA use in the current architecture.
- Azure Virtual Desktop connectivity to a standard hub virtual network or Virtual WAN hub.
- The session host connection model. You can use a native model or [RDP Shortpath](/azure/virtual-desktop/rdp-shortpath).
- Traffic inspection requirements for:
  - Internet egress from Azure Virtual Desktop.
  - Internet ingress to Azure Virtual Desktop.
  - Azure Virtual Desktop traffic to on-premises datacenters.
  - Azure Virtual Desktop traffic to other Virtual Network instances.
  - Traffic within the Azure Virtual Desktop virtual network.

The most common networking scenario for Azure Virtual Desktop is a hub-and-spoke topology with hybrid connectivity.

### Scenario 1: Hub and spoke with hybrid connectivity

This scenario uses the standard session host connection model.

#### Customer profile for hub and spoke with hybrid connectivity

This scenario is ideal if:

- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You don't need traffic inspection of internet-outbound traffic from Azure Virtual Desktop networks.
- You don't need to control the public IP addresses that are used during source network address translation (SNAT) for Azure Virtual Desktop outbound internet connections.
- You don't enforce Azure Virtual Desktop network-internal traffic.
- You have preexisting hybrid connectivity to on-premises environments, either through Azure ExpressRoute or a site-to-site (S2S) virtual private network (VPN).
- You have preexisting Active Directory Domain Services (AD DS) and Domain Name System (DNS) custom servers.
- You consume Azure Virtual Desktop by using a standard connection model, not RDP Shortpath.

#### Architectural components for hub and spoke with hybrid connectivity

You can implement this scenario with:

- AD DS servers and custom DNS servers.
- Network security groups.
- Azure Network Watcher.
- Outbound internet via a default Azure virtual network path.
- ExpressRoute or a VPN virtual network gateway for hybrid connectivity to on-premises systems.
- An Azure private DNS zone.
- Azure private endpoints.
- Azure Files storage accounts.
- Azure Key Vault.

:::image type="content" source="./media/eslz-network-topology-and-connectivity/virtual-desktop-networking-scenario-hub-spoke.svg" alt-text="Diagram that shows a hub and spoke architecture with hybrid connectivity." lightbox="./media/eslz-network-topology-and-connectivity/virtual-desktop-networking-scenario-hub-spoke.svg" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/azure-virtual-desktop-multi-region-resilient-deployment.vsdx) of the full Azure Virtual Desktop multi-region resilient architecture.*

#### Considerations for hub and spoke with hybrid connectivity

- This scenario doesn't accommodate direct network connectivity between a client and a public or private session host. You can't use RDP Shortpath in this scenario.
- The Azure Virtual Desktop control plane gateway, which uses a public endpoint, manages client connections. As a result, Azure Virtual Desktop clients can create outbound connections to required Azure Virtual Desktop URLs. For more information about required URLs, see the Internet section of this article and [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint?tabs=azure).
- No public IP addresses or other public inbound paths to session hosts are needed. Traffic from clients to session hosts flows through the Azure Virtual Desktop control plane gateway.
- There's no virtual network peering between Azure Virtual Desktop spokes. All traffic goes through the connectivity hub.
- The outbound internet connections from Azure Virtual Desktop session hosts go through the default Azure outbound network address translation (NAT) process. Dynamic Azure public IP addresses are used. Customers have no control over the outbound public IP addresses that are used.
- Connections from session hosts to Azure Files storage accounts are established by using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces for the following services:
  - Azure Files storage accounts, which use the name `privatelink.file.core.windows.net`
  - Key vaults, which use the name `privatelink.vaultcore.azure.net`
- Network filtering isn't enforced for this scenario. But network security groups are placed on all subnets so that you can monitor traffic and derive insights. In Network Watcher, traffic analytics and the network security group flow logging feature are used for these purposes.

### Scenario 2: Hub and spoke with hybrid connectivity over managed networks using RDP Shortpath

For detailed deployment guidance, see [RDP Shortpath connectivity for managed networks](/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks).

#### Customer profile for hub and spoke with hybrid connectivity over managed networks using RDP Shortpath

This scenario is ideal if:

- You want to limit the number of over-the-internet connections to Azure Virtual Desktop session hosts.
- You have preexisting hybrid connectivity from an on-premises environment to Azure, either through ExpressRoute or an S2S or point-to-site (P2S) VPN.
- You have direct line-of-sight network connectivity between RDP clients and Azure Virtual Desktop hosts. Typically, one of the following setups is used in this scenario:
  - On-premises networks that are routed to Azure Virtual Desktop Azure networks
  - Client VPN connections that are routed to Azure Virtual Desktop Azure virtual networks
- You need to limit bandwidth usage of VM hosts over private networks, such as a VPN or ExpressRoute.
- You want to prioritize Azure Virtual Desktop traffic on your network.
- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You have preexisting AD DS or DNS custom servers.

#### Architectural components for hub and spoke with hybrid connectivity over managed networks using RDP Shortpath

You can implement this scenario with:

- ExpressRoute or a VPN virtual network gateway for hybrid connectivity to on-premises environments with sufficient bandwidth.
- AD DS servers and custom DNS servers.
- Network security groups.
- Outbound internet via a default Azure virtual network path.
- Domain group policy objects (GPOs) or local GPOs.
- Azure Files storage accounts.
- Azure private endpoints.
- An Azure private DNS zone.

:::image type="content" source="./media/eslz-network-topology-and-connectivity/rdp-shortpath-private.png" alt-text="Architecture diagram of the scenario that uses RDP Shortpath for private networks." lightbox="./media/eslz-network-topology-and-connectivity/rdp-shortpath-private.png" border="false":::

#### Considerations for hub and spoke with hybrid connectivity over managed networks using RDP Shortpath

- Hybrid connectivity must be available, via a VPN or ExpressRoute, with RDP client direct network connectivity to private VM hosts on port 3390.

> [!NOTE]
> For managed networks, the default UDP port can be changed.

- A domain GPO or local GPO must be used to [enable UDP](/azure/virtual-desktop/configure-rdp-shortpath?tabs=managed-networks) over managed networks.
- Hybrid connectivity must have sufficient bandwidth to allow for UDP direct connections to VM hosts.
- Hybrid connectivity must have direct routing to allow connections to VM hosts.
- The Azure Virtual Desktop control plane gateway, which uses a public endpoint, manages client connections. As a result, Azure Virtual Desktop clients can create outbound connections to required Azure Virtual Desktop URLs. For more information about required URLs, see the Internet section of this article and [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint?tabs=azure).
- No public IP addresses or other public inbound paths to session hosts are needed. Traffic from clients to session hosts flows through the Azure Virtual Desktop control plane gateway.
- The outbound internet connection from Azure Virtual Desktop session hosts goes through the default Azure outbound NAT process. Dynamic Azure public IP addresses are used. Customers have no control over the outbound public IP addresses that are used.
- Connections from session hosts to Azure Files storage accounts are established by using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces.
- Network filtering isn't enforced for this scenario. But network security groups are placed on all subnets so that you can monitor traffic and derive insights. In Network Watcher, traffic analytics and the network security group flow logging feature are used for these purposes.

### Scenario 3: Hub and spoke with public networks using RDP Shortpath

For detailed deployment guidance, see [RDP Shortpath connectivity for public networks](/azure/virtual-desktop/rdp-shortpath?tabs=public-networks).

#### Customer profile for hub and spoke with public networks using RDP Shortpath

This scenario is ideal if:

- Your Azure Virtual Desktop client connections traverse the public internet. Typical scenarios include work-from-home users, remote-branch office users who aren't connected to corporate networks, and remote contractor users.
- You have high-latency or low-bandwidth connections to Azure Virtual Desktop session hosts.
- You need to limit bandwidth usage of Azure Virtual Desktop session hosts via QoS network policies.
- You want to prioritize Azure Virtual Desktop traffic on your network via QoS policies.
- Client RDP connections start from networks with inconsistent bandwidth and speed.
- You have direct outbound connectivity from Azure Virtual Desktop session hosts. You don't use a forced-tunnel routing through on-premises networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You have preexisting AD DS or DNS custom servers.

#### Architectural components for hub and spoke with public networks using RDP Shortpath

You can implement this scenario with:

- ExpressRoute or a VPN virtual network gateway for hybrid connectivity to on-premises environments. This setup is appropriate when there's sufficient bandwidth to support connections to on-premises applications, data, or AD DS connections. We don't recommend using forced tunneling to send Azure Virtual Desktop traffic through on-premises routers.
- AD DS servers and custom DNS servers.
- Network security groups.
- Network Watcher.
- Outbound internet via a default Azure virtual network path.
- Domain GPOs or local GPOs.
- Azure Files storage accounts.
- Azure private endpoints.
- An Azure private DNS zone.

:::image type="content" source="./media/eslz-network-topology-and-connectivity/rdp-shortpath-public.png" alt-text="Architecture diagram for the scenario that uses RDP Shortpath for public networks." lightbox="./media/eslz-network-topology-and-connectivity/rdp-shortpath-public.png" border="false":::

#### Considerations for hub and spoke with public networks using RDP Shortpath

- Allow the following types of connections:
  - Outbound UDP connections from Azure Virtual Desktop session hosts to the Azure Virtual Desktop Session Traversal Utilities for NAT (STUN) and Traversal Using Relay NAT (TURN) services on port 3478
  - UDP connections from RDP clients in the port range 49152–65535

  The setting that configures these connections is turned on by default and maintains the same level of encryption as Transmission Control Protocol (TCP) reverse connect. For information about limiting RDP client port ranges, see [Limit the port range when using RDP Shortpath for public networks](/azure/virtual-desktop/configure-rdp-shortpath).
- The Azure Virtual Desktop control plane gateway, which uses a public endpoint, manages client connections. As a result, Azure Virtual Desktop clients can create outbound connections to required Azure Virtual Desktop URLs. For more information about required URLs, see the Internet section of this article and [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint?tabs=azure).
- Consumer routers that are typically found in home user networks should have Universal Plug and Play (UPnP) enabled.
- No public IP addresses or other public inbound paths to session hosts are needed. Traffic from clients to session hosts flows through the Azure Virtual Desktop control plane gateway.
- The outbound internet connection from Azure Virtual Desktop session hosts goes through the default Azure outbound NAT process. Dynamic Azure public IP addresses are used. Customers have no control over the outbound public IP addresses that are used.
- You need to configure differentiated services code point (DSCP) marking on the session hosts. Use local GPOs or domain GPOs for this configuration. When you use DSCP markers, network devices can apply QoS policies for Azure Virtual Desktop traffic. For more information, see [Implement Quality of Service (QoS) for Azure Virtual Desktop](/azure/virtual-desktop/rdp-quality-of-service-qos).
- Connections from session hosts to Azure Files storage accounts are established using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces.
- Network filtering isn't enforced for this scenario. But network security groups are placed on all subnets so that you can monitor traffic and derive insights. In Network Watcher, traffic analytics and the network security group flow logging feature are used for these purposes.

## Next steps

Learn about resource organization for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Resource organization](./eslz-resource-organization.md)