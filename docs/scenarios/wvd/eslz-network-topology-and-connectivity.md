---
title: Networking for Azure Virtual Desktop
description: Use the Cloud Adoption Framework for Azure to identify networking capabilities that your landing zone needs to support Azure Virtual Desktop workloads.
author: danycontre
ms.author: tozimmergren
ms.date: 08/15/2023
ms.topic: conceptual
ms.subservice: caf-scenario-virtual-desktop
ms.custom: think-tank, e2e-avd
---

# Network topology and connectivity for Azure Virtual Desktop

The design and implementation of Azure Virtual Desktop Azure networking capabilities is critical for your Azure Virtual Desktop landing zone. This article builds on several Cloud Adoption Framework [enterprise-scale landing zone](../../ready/landing-zone/design-area/network-topology-and-connectivity.md) architectural principles and recommendation to manage network topology and connectivity at scale.

The design foundations include:

- **Hybrid integration** for connectivity between on-premises, multicloud, edge, and global users. For more information, see [Enterprise-scale support for hybrid and multicloud](../hybrid/enterprise-scale-landing-zone.md).
- **Performance and reliability at scale** for consistent, low-latency experience, and scalability for workloads.
- **Zero-trust based network security** to secure network perimeter and traffic flows. For more information, see [Network security strategies on Azure](/azure/architecture/framework/security/design-network).
- **Extensibility** for easily expanding network footprint without design rework.

## Networking components and concepts

- [**Azure Virtual Network**](/azure/virtual-network/virtual-networks-overview) is the fundamental building block for private networks in Azure. With Azure Virtual Network, many types of Azure resources, such as Azure Virtual Machines (VMs), can securely communicate with each other, the internet, and on-premises datacenters. A virtual network is similar to a traditional network that you operate in your own datacenter, but has the Azure infrastructure benefits of scale, availability, and isolation.
- [**Hub-spoke network topology**](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli), a hub virtual network acts as a central point of connectivity to several spoke virtual networks. The hub can also be the connectivity point to on-premises datacenters. The spoke virtual networks peer with the hub and helps to isolate workloads.
- [**Azure Virtual WAN**](/azure/virtual-wan/virtual-wan-about) is a networking service that brings networking, security, and routing functions together in a single operational interface.
- [**Network virtual appliance (NVA)**](https://azure.microsoft.com/blog/azure-firewall-and-network-virtual-appliances/) is a network device that supports functions like connectivity, application delivery, wide-area network (WAN) optimization, and security. NVAs include Azure Firewall and Azure Load Balancer.
- In [**Forced tunneling**](/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm#:~:text=Forced%20tunneling%20in%20Azure%20is%20configured%20via%20virtual,virtual%20networks%2C%20see%20User-defined%20routes%20and%20IP%20forwarding.) scenario all internet-bound traffic originating on Azure VMs is routed or "forced" to go through an inspection and auditing appliance. Unauthorized internet access can potentially lead to information disclosure or other types of security breaches without the traffic inspection or audit.
- [**Network security groups (NSGs)**](/azure/virtual-network/network-security-groups-overview) are used to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.
- [**Application security groups**](/azure/virtual-network/application-security-groups) enable you to configure network security as a natural extension of an application's structure. You can use them to group virtual machines and define network security policies based on those groups. You can reuse your security policy at scale without needing to manually maintain explicit IP addresses.
- **[User Defined Routes (UDR)](/azure/virtual-network/virtual-networks-udr-overview)** can be used to override Azure's default system routes, or to add additional routes to a subnet's route table.
- **[Remote Desktop Protocol Shortpath (RDP Shortpath)](/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks)** is a feature of Azure Virtual Desktop, based on [Universal Rate Control Protocol (URCP)](https://www.microsoft.com/research/publication/urcp-universal-rate-control-protocol-for-real-time-communication-applications/), that establishes a direct UDP-based transport between a supported Windows Remote Desktop client and AVD session hosts. URCP enhances UDP connection with active monitoring of network conditions and quality-of-service (QoS) capabilities. 
- **[Azure Private Link with Azure Virtual Desktop (Preview)](/azure/virtual-desktop/private-link-overview)** allows you to use a [private endpoint](/azure/private-link/private-endpoint-overview) in Azure to connect session hosts to the AVD service. With Private Link, traffic between your virtual network and the AVD service travels the Microsoft "backbone" network, which means you'll no longer need to connect to the public internet to access the AVD services.

## Networking scenarios

To establish the Azure Virtual Desktop landing zone, the design and implementation of networking capabilities is critical. Azure networking products and services support a wide variety of capabilities. Which architecture to choose and how to structure services depends on your organization's workloads, governance, and requirements.

The following key requirements and considerations affect your Azure Virtual Desktop deployment decisions:

- Internet ingress and egress requirements.
- NVA use in the current architecture.
- Azure Virtual Desktop connectivity to a standard hub virtual network or Virtual WAN hub.
- Session host connection model (native and [RDP Shortpath](/azure/virtual-desktop/rdp-shortpath)).
- Traffic inspection requirements for:
  - Internet egress from Azure Virtual Desktop.
  - Internet ingress to Azure Virtual Desktop.
  - Azure Virtual Desktop to on-premises datacenters.
  - Azure Virtual Desktop to other Azure Virtual Network.
  - Traffic within the Azure Virtual Desktop virtual network.
The most common networking scenario for Azure Virtual Desktop is hub and spoke with hybrid connectivity.

## Scenario 1: Hub and spoke with hybrid connectivity

### Customer profile

This scenario is ideal if:

- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You don't need traffic inspection of internet outbound traffic from Azure Virtual Desktop networks.
- You don't need to control the public IPs use to SNAT Azure Virtual Desktop internet outbound connections.
- You don't enforce Azure Virtual Desktops networks internal traffic.
- You have pre-existing hybrid connectivity to on-premises (Express Route or S2S VPN).
- You have pre-existing AD DS and DNS custom servers.
- You consume Azure Virtual Desktop with standard connection model (No RDP Shortpath).

### Architectural components

You can implement this scenario with:

- AD DS servers and custom DNS servers.
- Network security groups.
- Network Watcher.
- Outbound internet via default Azure virtual network path.
- Express route or VPN virtual network gateway for hybrid connectivity to on-premises.
- Azure private DNS zone.
- Azure private endpoints.
- Azure Files service on storage accounts.
- Azure key vault.

[![Diagram of the hub and spoke with hybrid connectivity scenario](./media/network-topology-scenario-1.png)](./media/network-topology-scenario-1.png#lightbox)

### Considerations

- This scenario doesn't account for client direct network connectivity to session public or private (no RDP Shortpath) hosts.
- Azure Virtual Desktop control plane gateway (public endpoint) manages client connections. Therefore, Azure Virtual Desktop clients can create outbound connections to required Azure Virtual Desktop URLs. For more information, see [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/safe-url-list).
- No public IPs or any other public inbound path to session hosts is needed, traffic from clients to session hosts flows through Azure Virtual Desktop control plane gateway.
- No virtual network peering between Azure Virtual Desktop spokes, all the traffic goes through the connectivity hub.
- Outbound internet connection from Azure Virtual Desktop session hosts goes through the default Azure outbound NAT using dynamic Azure public IPs (no customer control on outbound public IPs used).
- Connections from session hosts to Azure Files (storage accounts) are established using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces:
  - Storage account file service (privatelink.file.core.windows.net).
  - Key vaults (privatelink.vaultcore.azure.net).
- Even though for this scenario network filtering isn't enforced, NSGs are placed on all subnets to enable monitoring and insights by using network watcher NSG flow logs and traffic analytics.

## Scenario 2: Hub and spoke with hybrid connectivity over managed networks using RDP Shortpath

See [RDP Shortpath Connectivity for managed networks Microsoft Learn page](/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks) for detailed deployment guidance.

### Customer profile

This scenario is ideal if:

- You want to limit the amount of over the internet connections to AVD Session Hosts.
- You have pre-existing hybrid connectivity from on-premises to Azure (Express Route or S2S/P2S VPN).
- You have direct line of sight network connectivity between RDP clients and AVD hosts. Typically, this is on-premises networks routed to AVD Azure networks or client VPN connections routed to AVD Azure virtual networks.
- You need to limit bandwidth usage of VM Hosts over private networks (VPN or ExpressRoute).
- You want to prioritize AVD traffic on your network.
- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You have pre-existing AD DS and/or DNS custom servers.

### Architectural components

You can implement this scenario with:

- Express route or VPN virtual network gateway for hybrid connectivity to on-premises with sufficient bandwidth.
- AD DS servers and custom DNS servers.
- Network security groups.
- Outbound internet via default Azure virtual network path.
- Group Policy or Local Policy Objects.
- Azure files service on storage accounts.
- Azure private endpoints.
- Azure private DNS zone.

![RDP Shortpath for private networks diagram](media/eslz-network-topology-and-connectivity/image.png)

### Considerations

- Hybrid connectivity must be available (VPN or ExpressRoute) with RDP client direct network connectivity to private VM hosts on port 3390. NOTE:  For managed networks the default UDP port can be changed.
- A domain GPO or local policy must be used to [enable UDP](/azure/virtual-desktop/configure-rdp-shortpath?tabs=managed-networks) over managed networks.
- Hybrid connectivity must have sufficient bandwidth to allow for UDP direct connections to VM hosts.
- Hybrid connectivity must have direct routing to allow connection to VM hosts.
- Azure Virtual Desktop control plane Gateway (public endpoint) manages client connections. Therefore, AVD clients can create outbound connections to required AVD URLs ([check required URL list](/azure/virtual-desktop/safe-url-list?tabs=azure) under general design considerations and recommendations).
- No public IPs or any other public inbound path to session hosts is needed, traffic from clients to session hosts flows through Azure Virtual Desktop control plane gateway.
- Outbound internet connection from Azure Virtual Desktop session hosts goes through the default Azure outbound NAT using dynamic Azure public IPs (no customer control on outbound public IPs used).
- Connections from session hosts to Azure files (storage accounts) are established using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces.
- Even though for this scenario network filtering isn't enforced, NSGs are placed on all subnets to enable monitoring and insights by using network watcher NSG flow logs and traffic analytics.

_**NOTE:  At this time, AVD does not support using Private Link and RDP Shortpath at the same time**_

## Scenario 3: Hub and spoke with public networks using RDP Shortpath

See [RDP Shortpath Connectivity for public networks Microsoft Learn page](/azure/virtual-desktop/rdp-shortpath?tabs=public-networks) for detailed deployment guidance.

### Customer profile

This scenario is ideal if:

- Your AVD Client Connections are traversing the public internet. Typical scenarios include, but not limited to, work from home users, remote branch office users not connected to corporate networks, and remote contractor users.
- You have a high latency or low bandwidth connections to Azure Virtual Desktops session hosts.
- You need to limit bandwidth usage of AVD session hosts via QoS network policies.
- You want to prioritize AVD traffic on your network via QoS policies.
- Client RDP connections start from networks with inconsistent bandwidth and speed.
- You have direct outbound connectivity from AVD Session hosts (Avoid forced tunnel routing through on-premises networks).
- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You have pre-existing AD DS and/or DNS custom servers.

### Architectural components

You can implement this scenario with:

- Express route or VPN virtual network gateway for hybrid connectivity to on-premises with sufficient bandwidth to support connections to on-premises applications, data, or AD DS connections. Microsoft doesn't recommend force tunneling of all AVD traffic through on-premises routers.
- AD DS servers and custom DNS servers.
- Network security groups.
- Network Watcher,
- Outbound internet via default Azure virtual network path.
- Group Policy or Local Policy Objects.
- Azure files service on storage accounts.
- Azure private endpoints.
- Azure private DNS zone.

![RDP Shortpath for public networks diagram](media/eslz-network-topology-and-connectivity/image1.png)

### Considerations

- Allow outbound UDP Connection from AVD Session hosts to the AVD STUN/TURN services (3478) and UDP connections from RDP Clients (49152-65535). This setting is turned on by default and maintains the same level of encryption as TCP reverse connect. Documentation on how to [limit RDP Client port ranges](/azure/virtual-desktop/configure-rdp-shortpath-limit-ports-public-networks) can be found in the AVD Documentation pages
- Azure Virtual Desktop control plane Gateway (public endpoint) manages client connections. Therefore, AVD clients can create outbound connections to required AVD URLs ([check required URL list](/azure/virtual-desktop/safe-url-list?tabs=azure) under general design considerations and recommendations).
- Consumer routers typically found in home user networks should have UPnP enabled.
- No public IPs or any other public inbound path to session hosts is needed, traffic from clients to session hosts flows through Azure Virtual Desktop control plane gateway.
- Outbound internet connection from Azure Virtual Desktop session hosts goes through the default Azure outbound NAT using dynamic Azure public IPs (no customer control on outbound public IPs used).
- [DSCP markers must be configured](/azure/virtual-desktop/rdp-quality-of-service-qos) on the session hosts vial local policy or domain group policy for network devices to apply QoS policies for AVD traffic.  
- Connections from session hosts to Azure files (storage accounts) are established using private endpoints.
- Azure private DNS zones are used to resolve private endpoint namespaces.
- Even though for this scenario network filtering isn't enforced, NSGs are placed on all subnets to enable monitoring and insights by using network watcher NSG flow logs and traffic analytics.

## General design considerations and recommendations

Here are some general design considerations and recommendations for Azure Virtual Desktop network topology and connectivity:

### Hub and spoke vs. Virtual Wide Area Network (WAN) network topology

Virtual WAN supports [transit connectivity between VPN and ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er), but doesn't support hub-and-spoke topology.

### Identity services

The identity services connectivity requirements of Azure Virtual Desktop session hosts depend on the identity model.

- Azure AD Domain Services (AD DS) joined VMs: Azure Virtual Desktop networks must have connectivity to the network where the identity service is hosted.
- [Azure AD (Azure AD) joined VMs](/azure/architecture/example-scenario/wvd/azure-virtual-desktop-azure-active-directory-join): Azure Virtual Desktop session hosts create outbound connections to Azure AD public endpoints, therefore no private connectivity configurations required.

### DNS

Azure Virtual Desktop session hosts have the same name resolution requirements as any other IaaS workload, therefore connectivity to custom DNS servers or access (via virtual network link) to Azure Private DNS zones is required. Additional Azure private DNS zones are required to host the private endpoint namespaces of certain (storage accounts, key) Platform As A Service (PaaS) services.

- [Azure private endpoint DNS configuration](/azure/private-link/private-endpoint-dns)

To facilitate end user Azure Virtual Desktop client configuration (subscription to RDS feed), it's recommended to set up email discovery in the public DNS domain and [set up email discovery to subscribe to your RDS feed](/windows-server/remote/remote-desktop-services/rds-email-discovery).

### Bandwidth and latency

Azure Virtual Desktops use Remote Desktop Protocol (RDP). To know more about RDP, see [Remote Desktop Protocol (RDP) bandwidth requirements](/azure/virtual-desktop/rdp-bandwidth).

The connection latency varies depending on the location of the users and the virtual machines. Azure Virtual Desktop services continuously roll out to new geographies to improve latency. To minimize the latency perceived by Azure Virtual Desktop clients, use the [Azure Virtual Desktop Experience Estimator](https://azure.microsoft.com/services/virtual-desktop/assessment/) to get round trip time (RTT) sample from clients. You can use this information to place session hosts in the closest region with the lowest RTT to the end users ([interpreting results from estimator tool](/azure/virtual-desktop/connection-latency)).

### Quality of Service (QoS) with RDP Shortpath

RDP Shortpath for managed networks provides a direct UDP-based transport between Remote Desktop Client and the Session host. RDP Shortpath for managed networks enables configuration of Quality of Service (QoS) policies for the RDP data. QoS in Azure Virtual Desktop allows real-time RDP traffic sensitive to network delays to "cut in line" in front of less sensitive traffic.

You can use RDP Shortpath in two ways:

- **Managed networks**, where direct connectivity is established between the client and the session host when using a private connection, such as an ExpressRoute, or virtual private network (VPN).
- **Public networks**, where direct connectivity is established between the client and the session host when using a public connection. Examples of public connections are home network, coffee shop network, hotel network, and more. There are two connection types when using a public connection:
  - **A direct UDP connection** between a client and session host using the Simple Traversal Underneath NAT (STUN) protocol.
  - **An indirect UDP connection** using the Traversal Using Relay NAT (TURN) protocol with a relay between an RDP client and session host. This option is used if the gateway/router doesn't allow direct UDP connections. NOTE:  When launched, the TURN service will only be available in specific regions, then will expand over time. You can check the available regions in the link below.

Note that RDP path extends RDP multi-transport capabilities. It doesn't replace the reverse connect transport but complements it.

Initial session brokering is managed through the Azure Virtual Desktop service and the reverse connect transport (TCP). All connection attempts are ignored unless they match the reverse connect session first.

RDP Shortpath (UDP) is established after authentication, and if successfully established, the reverse connect transport is dropped, and all traffic flows over one of the RDP Shortpath methods listed above

For more information, see [Implement Quality of Service (QoS) for Azure Virtual Desktop](/azure/virtual-desktop/rdp-quality-of-service-qos).

### Internet

Azure Virtual Desktop compute resources and clients require access to specific public endpoints, so they need internet-bound connections. Network scenarios like forced tunneling to enhance security and filtering are supported when Azure Virtual Desktop requirements are met.

See [Required URL list and check tool](/azure/virtual-desktop/safe-url-list) to understand the requirements for AVD session hosts and client devices.

### Ports and protocols requirements

The Azure Virtual Desktop connection flow uses:

- [Standard model](/azure/virtual-desktop/network-connectivity): 443/TCP
- [RDP Shortpath model](/azure/virtual-desktop/shortpath): 443/TCP and 3390/UDP or 3478/UDP (STUN / TURN)

### Business continuity and disaster recovery (BCDR)

A networking setup with the same capabilities as the one on the source environment or that at least has connectivity to identity and DNS services is required to deploy and recover these resources to a target environment.

## Next steps

Learn about resource organization for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Resource organization](./eslz-resource-organization.md)
