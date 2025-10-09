## Azure Virtual Desktop networking recommendations

This article explains how to design network topology and connectivity for Azure Virtual Desktop (AVD) in an enterprise-scale environment. These recommendations help technical leaders minimize risk, optimize cost, and ensure reliable performance for end users. Each section addresses critical design decisions that influence security, identity, DNS, bandwidth, and continuity strategies.

### Network topology

Use Virtual WAN when you require [transit connectivity between VPN and ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er). Virtual WAN provides a Microsoft-managed hub-and-spoke model (virtual hubs + connected virtual networks) with built-in transitive routing. Use Virtual WAN when you need managed global transit and integrated routing/security.

### Identity services

- **Microsoft Entra Domain Services–joined VMs**: Ensure Azure Virtual Desktop networks have connectivity to the network hosting the identity service.

- **[Microsoft Entra ID–joined VMs](/azure/virtual-desktop/azure-ad-joined-session-hosts)**: Azure Virtual Desktop session hosts create outbound connections to Microsoft Entra ID public endpoints. No private connectivity configurations are required.

### Configure DNS

Azure Virtual Desktop session hosts have the same name resolution requirements as any other infrastructure as a service (IaaS) workload. As a result, connectivity to custom DNS servers or access via a virtual network link to Azure private DNS zones is required. Extra Azure private DNS zones are required to host the private endpoint namespaces of certain platform as a service (PaaS) services, such as storage accounts and key management services. For more information, see [Azure private endpoint DNS configuration](/azure/private-link/private-endpoint-dns).

For classic RDS or legacy AVD scenarios, you can configure email-based feed discovery. Modern Azure Virtual Desktop clients typically discover workspaces via the AVD service endpoints without [custom DNS TXT records](/windows-server/remote/remote-desktop-services/rds-email-discovery). For more information, see [Set up email discovery to subscribe to your RDS feed](/windows-server/remote/remote-desktop-services/rds-email-discovery).

### Optimize bandwidth and latency

Azure Virtual Desktop uses RDP. To learn more about RDP, see [Remote Desktop Protocol (RDP) bandwidth requirements](/azure/virtual-desktop/rdp-bandwidth).

The connection latency varies, depending on the location of the users and the VMs. Azure Virtual Desktop services continuously roll out to new geographies to improve latency. To minimize the latency that Azure Virtual Desktop clients experience, use the [Azure Virtual Desktop Experience Estimator](https://azure.microsoft.com/services/virtual-desktop/assessment/). This tool provides round-trip time (RTT) samples from clients. You can use this information to place session hosts in the region that's closest to end users and has the lowest RTT. For information about interpreting results from the estimator tool, see [Analyze connection quality in Azure Virtual Desktop](/azure/virtual-desktop/connection-latency).

### Implement QoS policies with RDP Shortpath

RDP Shortpath for managed networks provides a direct UDP-based transport between a Remote Desktop client and a session host. RDP Shortpath for managed networks provides a way to configure QoS policies for the RDP data. QoS in Azure Virtual Desktop allows real-time RDP traffic that's sensitive to network delays to "cut in line" in front of less sensitive traffic.

You can use RDP Shortpath in two ways:

- In **managed networks**, where direct connectivity is established between the client and the session host when you use a private connection, such as an ExpressRoute connection or a VPN.
- In **public networks**, where direct connectivity is established between the client and the session host when you use a public connection. Examples of public connections include home networks, coffee shop networks, and hotel networks. There are two possible connection types when you use a public connection. **A direct UDP connection** between a client and a session host that uses the STUN protocol. **An indirect UDP connection** that uses the TURN protocol with a relay between an RDP client and a session host. This option is used if the gateway or router doesn't allow direct UDP connections.

The RDP path extends RDP multi-transport capabilities. It doesn't replace the reverse connect transport but complements it. Initial session brokering is managed through the Azure Virtual Desktop service and the reverse connect transport, which is TCP-based. All connection attempts are ignored unless they match the reverse connect session first.

RDP Shortpath, which is UDP-based, is established after authentication. If RDP Shortpath is successfully established, the reverse connect transport is dropped. Then all traffic flows over one of the RDP Shortpath methods that this section lists earlier. Using RDP Shortpath for public networks with TURN for Azure Virtual Desktop is currently in preview. For more information, see [RDP Shortpath for Azure Virtual Desktop](/azure/virtual-desktop/rdp-shortpath).

For more information, see [Implement Quality of Service (QoS) for Azure Virtual Desktop](/azure/virtual-desktop/rdp-quality-of-service-qos).

### Secure internet access

Azure Virtual Desktop compute resources and clients require access to specific public endpoints, so they need internet-bound connections. Network scenarios, such as forced tunneling to enhance security and filtering, are supported when Azure Virtual Desktop requirements are met.

To understand requirements for Azure Virtual Desktop session hosts and client devices, see [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/safe-url-list).

### Validate port and protocol requirements

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
