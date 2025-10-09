---
title: Networking for Azure Virtual Desktop
description: Use the Cloud Adoption Framework for Azure to identify networking capabilities that are required for your landing zone to support Azure Virtual Desktop workloads.
author: danycontre
ms.author: pnp
ms.date: 10/09/2025
ms.topic: conceptual
---

# Network topology and connectivity for Azure Virtual Desktop

The design and implementation of Azure networking capabilities in Azure Virtual Desktop is critical for your Azure Virtual Desktop landing zone. This article builds on several Cloud Adoption Framework for Azure [enterprise-scale landing zone](../../ready/landing-zone/design-area/network-topology-and-connectivity.md) architectural principles and recommendations for managing network topology and connectivity at scale.

The design foundations include:

- **Hybrid integration** for connectivity between on-premises, multicloud, and edge environments, and global users
- **Performance and reliability at scale** for a consistent, low-latency experience, and scalability for workloads.
- **Zero-trust–based network security** to help secure network perimeters and traffic flows. For more information, see [Network security strategies on Azure](/azure/well-architected/security/design-network).
- **Extensibility** for easily expanding a network footprint without design rework.

## Networking components and concepts

### Core networking components

- [**Azure Virtual Network**](/azure/virtual-network/virtual-networks-overview) is the fundamental building block for private networks in Azure. With Virtual Network, many types of Azure resources, such as Azure Virtual Machines, can communicate with each other, the internet, and on-premises datacenters. A virtual network is similar to a traditional network that you operate in your own datacenter. But a virtual network offers the Azure infrastructure benefits of scale, availability, and isolation.
- A [**hub-spoke network topology**](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) is a type of network architecture in which a hub virtual network acts as a central point of connectivity to several spoke virtual networks. The hub can also be the connectivity point to on-premises datacenters. The spoke virtual networks peer with the hub and help to isolate workloads.
- [**Azure Virtual WAN**](/azure/virtual-wan/virtual-wan-about) is a networking service that brings networking, security, and routing functions together in a single operational interface.

### Secure access and traffic control

- [**Network security groups**](/azure/virtual-network/network-security-groups-overview) are used to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.
- [**Application security groups**](/azure/virtual-network/application-security-groups) provide a way for you to configure network security as a natural extension of an application's structure. You can use application security groups to group VMs and define network security policies that are based on those groups. You can reuse your security policy at scale without needing to manually maintain explicit IP addresses.
- In a [**forced-tunneling**](/azure/vpn-gateway/about-site-to-site-tunneling) scenario, all internet-bound traffic that originates on Azure virtual machines (VMs) is routed, or forced, to go through an inspection and auditing appliance. Unauthorized internet access can potentially lead to information disclosure or other types of security breaches without the traffic inspection or audit.

### Routing and optimization

- A [**network virtual appliance (NVA)**](https://azure.microsoft.com/blog/azure-firewall-and-network-virtual-appliances/) is a network device that supports functions like connectivity, application delivery, wide-area network (WAN) optimization, and security. NVAs include Azure Firewall and Azure Load Balancer.
- **[User-defined routes (UDRs)](/azure/virtual-network/virtual-networks-udr-overview)** can be used to override Azure default system routes. You can also use UDRs to add extra routes to a subnet route table.

### Azure Virtual Desktop enhancements

- **[Remote Desktop Protocol Shortpath (RDP Shortpath)](/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks)** is a feature of Azure Virtual Desktop that's based on [Universal Rate Control Protocol (URCP)](https://www.microsoft.com/research/publication/urcp-universal-rate-control-protocol-for-real-time-communication-applications/). RDP Shortpath establishes a direct transport that's based on User Datagram Protocol (UDP) between a supported Windows Remote Desktop client and Azure Virtual Desktop session hosts. URCP enhances UDP connections by providing active monitoring of network conditions and quality-of-service (QoS) capabilities.
- **[Azure Private Link with Azure Virtual Desktop](/azure/virtual-desktop/private-link-overview)** (optional) provides a way for you to use a [private endpoint](/azure/private-link/private-endpoint-overview) in Azure to connect session hosts to the Azure Virtual Desktop service. With Private Link, traffic between your virtual network and the Azure Virtual Desktop service travels on the Microsoft *backbone* network. As a result, you don't need to connect to the public internet to access Azure Virtual Desktop services.

## General design considerations and recommendations

The following sections provide general design considerations and recommendations for Azure Virtual Desktop network topology and connectivity.

### Hub and spoke vs. Virtual WAN network topology

Virtual WAN supports [transit connectivity between VPN and ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er) but doesn't support hub-and-spoke topologies.

### Identity services

The connectivity requirements of identity services in Azure Virtual Desktop session hosts depend on the identity model.

- For Microsoft Entra Domain Services–joined VMs: Azure Virtual Desktop networks must have connectivity to the network where the identity service is hosted.
- For [Microsoft Entra ID–joined VMs](/azure/virtual-desktop/azure-ad-joined-session-hosts): Azure Virtual Desktop session hosts create outbound connections to Microsoft Entra ID public endpoints. As a result, no private connectivity configurations are required.

### DNS

Azure Virtual Desktop session hosts have the same name resolution requirements as any other infrastructure as a service (IaaS) workload. As a result, connectivity to custom DNS servers or access via a virtual network link to Azure private DNS zones is required. Extra Azure private DNS zones are required to host the private endpoint namespaces of certain platform as a service (PaaS) services, such as storage accounts and key management services.

For more information, see [Azure private endpoint DNS configuration](/azure/private-link/private-endpoint-dns).

To facilitate the end-user Azure Virtual Desktop client configuration, including the subscription to the Remote Desktop Services (RDS) feed, it's best to set up email discovery. You need to set up email discovery in the public DNS domain and then subscribe to your RDS feed. For more information, see [Set up email discovery to subscribe to your RDS feed](/windows-server/remote/remote-desktop-services/rds-email-discovery).

### Bandwidth and latency

Azure Virtual Desktop uses RDP. To learn more about RDP, see [Remote Desktop Protocol (RDP) bandwidth requirements](/azure/virtual-desktop/rdp-bandwidth).

The connection latency varies, depending on the location of the users and the VMs. Azure Virtual Desktop services continuously roll out to new geographies to improve latency. To minimize the latency that Azure Virtual Desktop clients experience, use the [Azure Virtual Desktop Experience Estimator](https://azure.microsoft.com/services/virtual-desktop/assessment/). This tool provides round-trip time (RTT) samples from clients. You can use this information to place session hosts in the region that's closest to end users and has the lowest RTT. For information about interpreting results from the estimator tool, see [Analyze connection quality in Azure Virtual Desktop](/azure/virtual-desktop/connection-latency).

### QoS with RDP Shortpath

RDP Shortpath for managed networks provides a direct UDP-based transport between a Remote Desktop client and a session host. RDP Shortpath for managed networks provides a way to configure QoS policies for the RDP data. QoS in Azure Virtual Desktop allows real-time RDP traffic that's sensitive to network delays to "cut in line" in front of less sensitive traffic.

You can use RDP Shortpath in two ways:

- In **managed networks**, where direct connectivity is established between the client and the session host when you use a private connection, such as an ExpressRoute connection or a VPN.
- In **public networks**, where direct connectivity is established between the client and the session host when you use a public connection. Examples of public connections include home networks, coffee shop networks, and hotel networks. There are two possible connection types when you use a public connection:
  - **A direct UDP connection** between a client and a session host that uses the STUN protocol.
  - **An indirect UDP connection** that uses the TURN protocol with a relay between an RDP client and a session host. This option is used if the gateway or router doesn't allow direct UDP connections.

    > [!NOTE]
    > Using RDP Shortpath for public networks with TURN for Azure Virtual Desktop is currently in preview. For more information, see [RDP Shortpath for Azure Virtual Desktop](/azure/virtual-desktop/rdp-shortpath).

The RDP path extends RDP multi-transport capabilities. It doesn't replace the reverse connect transport but complements it.

Initial session brokering is managed through the Azure Virtual Desktop service and the reverse connect transport, which is TCP-based. All connection attempts are ignored unless they match the reverse connect session first.

RDP Shortpath, which is UDP-based, is established after authentication. If RDP Shortpath is successfully established, the reverse connect transport is dropped. Then all traffic flows over one of the RDP Shortpath methods that this section lists earlier.

For more information, see [Implement Quality of Service (QoS) for Azure Virtual Desktop](/azure/virtual-desktop/rdp-quality-of-service-qos).

### Internet

Azure Virtual Desktop compute resources and clients require access to specific public endpoints, so they need internet-bound connections. Network scenarios, such as forced tunneling to enhance security and filtering, are supported when Azure Virtual Desktop requirements are met.

To understand requirements for Azure Virtual Desktop session hosts and client devices, see [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/safe-url-list).

### Port and protocol requirements

The Azure Virtual Desktop connection models use the following ports and protocols:

- [Standard model](/azure/virtual-desktop/network-connectivity): 443/TCP
- [RDP Shortpath model](/azure/virtual-desktop/rdp-shortpath): 443/TCP and 3390/UDP or 3478/UDP for the STUN or TURN protocol

### Business continuity and disaster recovery

For business continuity and disaster recovery, a certain networking setup is required. Specifically, to deploy and recover resources to a target environment, use one of the following configurations:

- A networking setup with the same capabilities as the one on the source environment
- A networking setup that has connectivity to identity and DNS services

## Next steps

Learn about resource organization for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Resource organization](./eslz-resource-organization.md)
