---
title: Networking for Azure Virtual Desktop
description: Use the Cloud Adoption Framework for Azure to identify networking capabilities that your landing zone needs to support Azure Virtual Desktop workloads.
author: danycontrerasms
ms.author: brblanch
ms.date: 05/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Network topology and connectivity for Azure Virtual Desktop

## Review network options

Designing and implementing Azure Virtual Desktop Azure networking capabilities is critical for your Azure Virtual Desktop landing zone. Azure networking products and services support a wide variety of networking capabilities. How you structure these services and the networking architectures you choose depends on your organization's workload, governance, and connectivity requirements.

## Networking components and concepts

- [**Azure Virtual Network**](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) is the fundamental building block for private networks in Azure. With Azure Virtual Network, many types of Azure resources, such as Azure Virtual Machines (VMs), can securely communicate with each other, the internet, and on-premises datacenters. A virtual network is similar to a traditional network that you operate in your own datacenter, but has the Azure infrastructure benefits of scale, availability, and isolation.

- In [**hub-spoke network topology**](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli), a hub virtual network acts as a central point of connectivity to many spoke virtual networks. The hub can also be the connectivity point to on-premises datacenters. The spoke virtual networks peer with the hub and can be used to isolate workloads.

- [**Azure Virtual WAN**](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about) is a networking service that brings many networking, security, and routing functions together in a single operational interface. These capabilities include:

  - Branch connectivity automation from Virtual WAN partner devices such as SD-WAN or customer premises equipment (CPE) based virtual private networks (VPNs)
  - Site-to-site VPN connectivity
  - Remote user point-to-site VPN connectivity
  - Private Azure ExpressRoute connectivity
  - Intracloud connectivity like transitive connectivity for virtual networks
  - VPN ExpressRoute interconnectivity
  - Routing
  - Azure Firewall
  - Encryption for private connectivity

- A [**network virtual appliance (NVA)**](https://azure.microsoft.com/en-us/blog/azure-firewall-and-network-virtual-appliances/) is a network device that supports functions like connectivity, application delivery, wide-area network (WAN) optimization, and security. NVAs include Azure Firewall and Azure Load Balancer.

- In [**Forced tunneling**](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm#:~:text=Forced%20tunneling%20in%20Azure%20is%20configured%20via%20virtual,virtual%20networks%2C%20see%20User-defined%20routes%20and%20IP%20forwarding.) scenario all Internet-bound traffic originating on Azure VMs is routed or "forced" to go through an inspection and auditing appliance. without the option to allow you to inspect or audit the traffic. Unauthorized Internet access can potentially lead to information disclosure or other types of security breaches.

- [**Network Security Group (NSG)**](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview) can be used to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.

- [**User Defined Routes (UDR)**](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview) can be used to override Azure's default system routes, or to add additional routes to a subnet's route table.

## Networking scenarios

Designing and implementing networking capabilities is critical for establishing the Azure Virtual Desktop landing zone. Azure networking products and services support a wide variety of capabilities. Which architecture to choose and how to structure services depends on your organization's workloads, governance, and requirements.

The following key requirements and considerations that affect your Azure Virtual Desktop deployment decision:

- Internet ingress and egress requirements.
- NVA use in the current architecture.
- Azure Virtual Desktop connectivity to a standard hub virtual network or Virtual WAN hub.
- Session host connection model (native and RDP Shortpath).
- Traffic inspection requirements for:
  - Internet egress from Azure Virtual Desktop.
  - Internet ingress to Azure Virtual Desktop.
  - Azure Virtual Desktop to on-premises datacenters.
  - Azure Virtual Desktop to other Azure Virtual Network.
  - Traffic within the Azure Virtual Desktop virtual network.

The following scenarios describe the most common networking scenarios for Azure Virtual Desktop. This list isn't exhaustive. For more scenarios.

## Scenario 1: Hub & Spoke with hybrid connectivity

### Customer profile

This scenario is ideal if:

- You don't need traffic inspection between Azure Virtual Desktop networks and other Azure virtual networks.
- You don't need traffic inspection between Azure Virtual Desktop networks and on-premises datacenters.
- You don't need traffic inspection of internet-bound traffic from Azure Virtual Desktop networks.
- You have a pre-existing hybrid connectivity to on-premeses (Express Route or S2S VPN).
- You do need traffic inspection between Azure VMware Solution workloads and the internet.

In this scenario, you consume Azure VMware Solution as a platform as a service (PaaS) offering. You don't own the public IP addresses. You have to add public-facing L4 and L7 inbound services if needed. You might or might not already have ExpressRoute connectivity between on-premises datacenters and Azure.

### Architectural components

### Considerations

## General design considerations and recommendations

Here are some general design considerations and recommendations for Azure Virtual Desktop network topology and connectivity:

### Hub-spoke vs. Virtual WAN network topology

Virtual WAN supports [transit connectivity between VPN and ExpressRoute](/azure/virtual-wan/virtual-wan-about#transit-er), but doesn't support hub-spoke topology.

### DNS and identity services

Regardless of the connectivity model used, Azure Virtual Desktop subnets need to have connectivity to identity (AD DS or AADDS) and DNS (Custom DNS) services.

### Bandwidth and latency

Azure Virtual Desktops leverages Remote Desktop Protocol (RDP), more information on RDP bandwidth requirements can be found at:

- [Remote Desktop Protocol (RDP) bandwidth requirements](https://docs.microsoft.com/en-us/azure/virtual-desktop/rdp-bandwidth)

Connection latency will vary depending on the location of the users and the virtual machines. Azure Virtual Desktop services will continuously roll out to new geographies to improve latency. To minimized latency perceived by Azure Virtual Desktop clients, use the [Azure Virtual Desktop Experience Estimator](https://azure.microsoft.com/en-us/services/virtual-desktop/assessment/) to get round trip time (RTT) sample from clients and use this information to place session hosts in the closest region with the lowest RTT to the end users ([Interpreting results from estimator tool](https://docs.microsoft.com/en-us/azure/virtual-desktop/connection-latency)).

Additional information to interpret 

### Quality of Service (QoS)

RDP Shortpath for managed networks provides a direct UDP-based transport between Remote Desktop Client and Session host. RDP Shortpath for managed networks enables configuration of Quality of Service (QoS) policies for the RDP data. QoS in Azure Virtual Desktop allows real-time RDP traffic that's sensitive to network delays to "cut in line" in front of traffic that's less sensitive. more information on QoS can be found at:

- [Implement Quality of Service (QoS) for Azure Virtual Desktop](https://docs.microsoft.com/en-us/azure/virtual-desktop/rdp-quality-of-service-qos)

### Network security and Internet

Azure Virtual Desktop compute resources and clients require to access public endpoints, therefore internet-bound connections will be needed. Network scenarios like forced tunneling to enhance security and filtering are supported as long as the Azure virtual Desktop requirements are meet, the following link outlines the requirements for AVD session hosts and client devices.

- [Required URL list and check tool](https://docs.microsoft.com/en-us/azure/virtual-desktop/safe-url-list)

### Ports and protocols requirements

Azure Virtual Desktop connection flow uses:

- [Native model](https://docs.microsoft.com/en-us/azure/virtual-desktop/network-connectivity): 443/TCP
- [RDP Shortpath model](https://docs.microsoft.com/en-us/azure/virtual-desktop/shortpath): 443/TCP and 3390/UDP

### Business continuity and disaster recovery (BCDR)

Although Azure network services (vNet, NSG, UDR, ASG, etc.) are regional, Compute resources used by Azure Virtual Desktop as session hosts are not, therefore deploying or recovery these resources to a target region, will require a networking setup that has connectivity to identity, DNS and data sources as the source.

## Follow Azure networking best practices

As part of your networking design process, see these articles:

- [Plan virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm). Learn how to plan for virtual networks based on your isolation, connectivity, and location requirements.
- [Azure best practices for network security](/azure/security/fundamentals/network-best-practices). Learn about Azure best practices that can help you enhance your network security.
- [Best practices for networking when you migrate workloads to Azure](../../migrate/azure-best-practices/migrate-best-practices-networking.md). Get more guidance about how to implement Azure networking to support workloads.

## Next steps

[Management and monitoring](./eslz-management-and-monitoring.md)
