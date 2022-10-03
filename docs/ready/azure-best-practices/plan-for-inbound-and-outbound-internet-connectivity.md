---
title: Plan for inbound and outbound internet connectivity
description: Explore recommended connectivity models for inbound and outbound connectivity to and from the public internet.
author: JefferyMitchell
ms.author: brblanch
ms.date: 06/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, csu
---

# Plan for inbound and outbound internet connectivity

This article lists considerations and recommendations for inbound and outbound connectivity between Azure and the public internet.

## Design considerations

- Azure native network security services such as [Azure Firewall](/azure/firewall/overview), [Azure Web Application Firewall (WAF) on Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview), and [Azure Front Door](/azure/frontdoor/front-door-overview) are fully managed. You don't incur the operational and management costs and complexity of infrastructure deployments at scale.

- If your organization prefers to use non-Azure network virtual appliance (NVAs), or for situations where native services don't satisfy specific requirements, the Azure landing zone architecture is fully compatible with partner NVAs.

- Azure provides several direct internet outbound connectivity methods, such as [Virtual network NAT gateways](/azure/virtual-network/nat-gateway/nat-overview) or [public load balancers with outbound rules](/azure/load-balancer/load-balancer-overview), for virtual machines (VMs) or compute instances on a virtual network. Load balancer and NAT gateway are fully managed by Azure and provide secure outbound connectivity by default. For more information, see [Azure outbound connectivity methods](/azure/load-balancer/load-balancer-outbound-connections#scenarios).

## Design recommendations

- Use Azure Firewall to govern:

  - Azure outbound traffic to the internet.
  - Non-HTTP/S inbound connections.
  - East-west traffic filtering, if your organization requires it.

- Use [Azure Firewall Premium](/azure/firewall/premium-features) for advanced firewall capabilities, such as:

  - Transport Layer Security (TLS) inspection.
  - A network intrusion detection and prevention system (IDPS).
  - URL filtering.
  - Web categories.

- [Azure Firewall Manager](/azure/firewall-manager/overview) supports both [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) and regular virtual networks. Use Firewall Manager with Virtual WAN to deploy and manage Azure firewalls across Virtual WAN hubs or in hub virtual networks.

- If you use multiple IP addresses and ranges consistently in Azure Firewall rules, set up [IP Groups](/azure/firewall/ip-groups) in Azure Firewall. You can use the IP groups in Azure Firewall DNAT, network, and application rules for multiple firewalls across Azure regions and subscriptions.

- Use a [NAT gateway](/azure/virtual-network/nat-gateway/nat-gateway-resource) to provide secure, scalable and resilient outbound connectivity from your virtual network. NAT gateway is the recommended option to use for explicit outbound connectivity. Key features of NAT gateway include:

  - **Secure by default** and part of your virtual network. The virtual network is a private and isolated network. Static public IP addresses associated to NAT gateway can easily be whitelisted at internet destination endpoints.
  - **Resilient to infrastructure failures**. NAT gateway has multiple fault domains and can sustain multiple failures without service outage. 
  - **Scaled out upon creation**. Simply add a public IP address to NAT gateway and all 64,512 SNAT ports provided by the public IP are made available to resources in a NAT gateway subnet. Up to 16 IP addresses can be added to NAT gateway in any combination of public IP addresses, prefixes, or both. This means [NAT gateway can scale to over 1 million SNAT ports](/azure/virtual-network/nat-gateway/nat-gateway-resource#scalability) for outbound connectivity.
  - Enterprise grade performance as a multi-tenant platform service. NAT gateway provides outbound connectivity immediately upon deployment and does not impact network bandwidth. 
  - Alleviates risk of SNAT port exhaustion with its [on-demand SNAT port allocation](/azure/virtual-network/nat-gateway/nat-gateway-resource#nat-gateway-dynamically-allocates-snat-ports) to all IP based resources in a NAT gateway associated subnet. 
  - Integrated with other Azure serviecs such as [Azure Firewall](/azure/firewall/integrate-with-nat-gateway) and [Azure App Services](/azure/app-service/networking/nat-gateway-integration) to provide secure and scalable outbound connectivity.

- If you use a custom [user defined route](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) (UDR) to manage outbound connectivity to Azure platform as a service (PaaS) services, specify a [service tag](/azure/virtual-network/virtual-networks-udr-overview#service-tags-for-user-defined-routes) as the address prefix. Service tags update underlying IP addresses automatically to include changes, and reduce the overhead of managing Azure prefixes in a route table.

- Create a global Azure Firewall policy to govern security posture across the global network environment. Assign the policy to all Azure Firewall instances.

- Allow granular policies to meet specific region requirements by using Azure role-based access control to delegate incremental policies to local security teams.

- Use WAF within a landing-zone virtual network for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door and WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a landing zone.

- To use Azure Front Door and Azure Application Gateway to help protect HTTP/S applications, use WAF policies in Azure Front Door. Lock down Azure Application Gateway to receive traffic only from Azure Front Door.

- If you need partner NVAs for inbound HTTP/S connections, deploy them within a landing-zone virtual network, together with the applications that they protect and expose to the internet.

- For outbound access, don't use Azure's default internet outbound access for any scenario.

- If your organization wants to use software-as-a-service (SaaS) security providers to help protect outbound connections, configure supported partners within Firewall Manager.

- If you use partner NVAs for east-west or north-south traffic protection and filtering:

  - For Virtual WAN network topologies, deploy the NVAs to a separate NVA virtual network. Connect the virtual network to the regional Virtual WAN hub and to the landing zones that need access to the NVAs. For more information, see [Scenario: Route traffic through an NVA](/azure/virtual-wan/scenario-route-through-nva).
  - For non-Virtual WAN network topologies, deploy the partner NVAs in the central hub virtual network.

- Don't expose VM management ports to the internet. For management tasks:

  - Use [Azure Policy](/azure/virtual-network/policy-reference) to prevent VM creation with public IPs.
  - Use [Azure Bastion](/azure/bastion/bastion-overview) to access jumpbox VMs.

- Use [Azure DDoS Protection Standard](/azure/ddos-protection/ddos-protection-overview) protection plans to help protect the public endpoints you host within your virtual networks.

- Don't try to replicate on-premises perimeter network concepts and architectures into Azure. Although Azure has similar security capabilities, the implementation and architecture are adapted to the cloud.
