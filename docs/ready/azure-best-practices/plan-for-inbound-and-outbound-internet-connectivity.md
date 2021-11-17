---
title: Plan for inbound and outbound internet connectivity
description: Explore recommended connectivity models for inbound and outbound connectivity to and from the public internet
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/18/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, csu
---

# Plan for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.

**Design considerations:**

- Azure-native network security services such as Azure Firewall, Azure Web Application Firewall (WAF) on Azure Application Gateway, and Azure Front Door are fully managed services. So you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

- The enterprise-scale architecture is fully compatible with partner NVAs, if your organization prefers to use NVAs or for situations where native services don't satisfy your organization's specific requirements.

- Azure provides different direct internet outbound connectivity methods (such as NAT gateway or Load Balancer) for virtual machines or compute instances on a VNet. Those methods are described on the Azure outbound connectivity methods article.  

**Design recommendations:**

- Use Azure Firewall to govern:

  - Azure outbound traffic to the internet.

  - Non-HTTP/S inbound connections.

  - East/west traffic filtering (if your organization requires it).

- Use Azure Firewall [Premium](/azure/firewall/premium-features) if advanced firewall capabilities are required (TLS inspection, network intrusion detection and prevention system (IDPS), URL filtering, Web categories).

- Use Firewall Manager with Virtual WAN to deploy and manage Azure firewalls across Virtual WAN hubs or in hub virtual networks. Firewall Manager is now in general availability for both Virtual WAN and regular virtual networks.

- If multiple IP addresses and ranges are used consistently in Azure Firewall rules, it is recommended to use [IP Groups](/azure/firewall/ip-groups). IP Groups can be reused in Azure Firewall DNAT, network, and application rules for multiple firewalls across regions and subscriptions in Azure.

- Create a global Azure Firewall policy to govern security posture across the global network environment and assign it to all Azure Firewall instances. Allow for granular policies to meet requirements of specific regions by delegating incremental firewall policies to local security teams via Azure role-based access control.

- Configure supported partner SaaS security providers within Firewall Manager if your organization wants to use such solutions to help protect outbound connections.

- Use WAF within a landing-zone virtual network for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door and WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a landing zone.

- When you're using Azure Front Door and Azure Application Gateway to help protect HTTP/S applications, use WAF policies in Azure Front Door. Lock down Azure Application Gateway to receive traffic only from Azure Front Door.

- Do not use Azure’s default internet outbound access for any scenario.

  - Use NAT Gateway for online landing zones, which are Landing Zones not connected to the hub VNet, where compute resources require internet outbound access and do no need any of the security features provided by Azure Firewall (Standard or Premium) or a 3rd party NVA.

- If partner NVAs are required for east/west or south/north traffic protection and filtering:

  - For Virtual WAN network topologies, deploy the NVAs to a separate virtual network (for example, NVA virtual network). Then connect it to the regional Virtual WAN hub and to the landing zones that require access to NVAs. [This article](/azure/virtual-wan/scenario-route-through-nva) describes the process.
  - For non-Virtual WAN network topologies, deploy the partner NVAs in the central-hub virtual network.

- If partner NVAs are required for inbound HTTP/S connections, deploy them within a landing-zone virtual network and together with the applications that they're protecting and exposing to the internet.

- Do not expose Virtual Machine management ports to Internet.
  - Use [Azure Policy](/azure/virtual-network/policy-reference) to prevent Virtual Machines creation with public IP attached.
  - Use [Azure Bastion](/azure/bastion/bastion-overview) to access jump-boxes Virtual Machines for management purposes.

- Use [Azure DDoS Protection Standard protection plans](/azure/ddos-protection/ddos-protection-overview) to help protect all public endpoints hosted within your virtual networks.

- Don't replicate on-premises perimeter network concepts and architectures into Azure. Similar security capabilities are available in Azure, but the implementation and architecture must be adapted to the cloud.
