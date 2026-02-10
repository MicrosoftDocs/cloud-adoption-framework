---
title: Plan for inbound and outbound internet connectivity
description: Explore recommended connectivity models for inbound and outbound connectivity to and from the public internet.
author: sebassem
ms.author: sebassem
ms.date: 11/25/2025
ms.reviewer: ssumner
ms.topic: concept-article
ms.custom: think-tank, csu
---

# Plan for inbound and outbound internet connectivity

This article lists considerations and recommendations for inbound and outbound connectivity between Azure and the public internet.

## Design considerations

- Azure native network security services such as [Azure Firewall](/azure/firewall/overview), [Azure Web Application Firewall (WAF) on Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview), and [Azure Front Door](/azure/frontdoor/front-door-overview) are fully managed. You don't incur the operational and management costs and complexity of infrastructure deployments at scale.

- If your organization prefers to use non-Azure network virtual appliance (NVAs) or in situations where native services don't satisfy specific requirements, the Azure landing zone architecture is fully compatible with partner NVAs.

- Azure provides several direct internet outbound connectivity methods, such as network address translation (NAT) gateways or load balancers, for virtual machines (VMs) or compute instances on a virtual network. [Azure NAT Gateway](/azure/nat-gateway/nat-overview) is recommended as the default for enabling outbound connectivity as it is operationally the simplest to set up, and is the most scalable and efficient option among all outbound connectivity methods available in Azure. For more information, see [Azure outbound connectivity methods](/azure/load-balancer/load-balancer-outbound-connections#scenarios).

> [!NOTE]
> The *Azure Firewall Management NIC* was originally required only for forced tunneling. However, this requirement has been updated to support new Azure Firewall features that depend on the management NIC. The Azure Firewall documentation reflects this change. To take advantage of these upcoming features, ensure that your Azure Firewall is deployed with the management NIC *enabled*. For more information, see [Azure Firewall Management NIC](/azure/firewall/management-nic).

## Design recommendations

- Use Azure NAT Gateway for direct outbound connectivity to the internet. A NAT gateway is a fully managed, highly resilient NAT service that provides [scalable and on-demand SNAT](/azure/nat-gateway/nat-gateway-resource).

  - Use a NAT gateway for:

    - Dynamic or large workloads sending traffic to the internet.
    - Static and predictable public IP addresses for outbound connectivity. NAT gateway can be associated with up to 16 public IP addresses or a /28 public IP prefix.
    - Mitigation of issues with SNAT port exhaustion commonly experienced with [Load balancer outbound rules](/azure/load-balancer/troubleshoot-outbound-connection#use-a-nat-gateway-for-outbound-connectivity-to-the-internet), [Azure Firewall](/azure/firewall/integrate-with-nat-gateway), or [Azure App Service](/azure/app-service/overview-nat-gateway-integration).
    - Security and privacy of resources within your network. Only outbound and return traffic can pass through the NAT gateway.

- Use Azure Firewall to govern:

  - Azure outbound traffic to the internet.
  - Non-HTTP/S inbound connections.
  - East-west traffic filtering, if your organization requires it.

- Deploy Azure Firewall with the Management NIC enabled

  - Ensure the AzureFirewallManagementSubnet is created in advance to avoid deployment issues when using an existing virtual network, with a minimum subnet size of /26
  - Assign a public IP address to the Management NIC. This IP facilitates the firewall's operational tasks, including updates and management communications.
  - By default, Azure associates a system-provided route table to the AzureFirewallManagementSubnet. This table includes a default route to the internet and *Propagate gateway routes* must be disabled.

- Use [Azure Firewall Premium](/azure/firewall/premium-features) for advanced firewall capabilities, such as:

  - Transport Layer Security (TLS) inspection.
  - A network intrusion detection and prevention system (IDPS).
  - URL filtering.
  - Web categories.

> [!NOTE]
> For Standard and Premium firewall versions, the Firewall Management NIC must be manually enabled during the create process. All Basic Firewall versions and all Secured Hub firewalls always have a Management NIC enabled.

- [Azure Firewall Manager](/azure/firewall-manager/overview) supports both [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) and regular virtual networks. Use Firewall Manager with Virtual WAN to deploy and manage Azure firewalls across Virtual WAN hubs or in hub virtual networks.

- If you use multiple IP addresses and ranges consistently in Azure Firewall rules, set up [IP Groups](/azure/firewall/ip-groups) in Azure Firewall. You can use the IP groups in Azure Firewall DNAT, network, and application rules for multiple firewalls across Azure regions and subscriptions.

- If you use a custom [user defined route](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) (UDR) to manage outbound connectivity to Azure platform as a service (PaaS) services, specify a [service tag](/azure/virtual-network/virtual-networks-udr-overview#service-tags-for-user-defined-routes) as the address prefix. Service tags update underlying IP addresses automatically to include changes, and reduce the overhead of managing Azure prefixes in a route table.

> [!NOTE]
> Avoid associating customer route tables with AzureFirewallManagementSubnet. Associating custom route tables with the management subnet can lead to misconfigurations and potential service disruptions. If you do associate a route table, ensure it has a default route to the Internet to avoid service disruptions.

- Create a global Azure Firewall policy to govern security posture across the global network environment. Assign the policy to all Azure Firewall instances.

- Allow granular policies to meet specific region requirements by using Azure role-based access control to delegate incremental policies to local security teams.

- Use WAF within a landing-zone virtual network for protecting inbound HTTP/S traffic from the internet.

- Use Azure Front Door and WAF policies to provide global protection across Azure regions for inbound HTTP/S connections to a landing zone.

  - Ensure you have reviewed the guidance in [Global routing redundancy for mission-critical web applications](/azure/architecture/guide/networking/global-web-applications/overview) when using Azure Front Door in your architectures.

- To use Azure Front Door and Azure Application Gateway to help protect HTTP/S applications, use WAF policies in Azure Front Door. Lock down Azure Application Gateway to receive traffic only from Azure Front Door.

- If you need partner NVAs for inbound HTTP/S connections, deploy them within a landing-zone virtual network, together with the applications they protect and expose to the internet.

- For outbound access, don't use Azure's default internet outbound access for any scenario. Issues experienced with default outbound access include:

  - Increased risk of SNAT port exhaustion.
  - Insecure by default.
  - Can't depend on default access IPs. They aren't owned by the customer and subject to change.

- Use a NAT gateway for online landing zones, or landing zones not connected to the hub virtual network. Compute resources that need outbound internet access and don't need the security of Azure Firewall standard or premium, or a third-party NVA, can use online landing zones.

- If your organization wants to use software-as-a-service (SaaS) security providers to help protect outbound connections, configure supported partners within Firewall Manager.

- If you use partner NVAs for east-west or north-south traffic protection and filtering:

  - For Virtual WAN network topologies, deploy the NVAs to a separate NVA virtual network. Connect the virtual network to the regional Virtual WAN hub and to the landing zones that need access to the NVAs. For more information, see [Scenario: Route traffic through an NVA](/azure/virtual-wan/scenario-route-through-nva).
  - For non-Virtual WAN network topologies, deploy the partner NVAs in the central hub virtual network.

- Don't expose VM management ports to the internet. For management tasks:

  - Use [Azure Policy](/azure/virtual-network/policy-reference) to prevent VM creation with public IPs.
  - Use [Azure Bastion](/azure/bastion/bastion-overview) to access jumpbox VMs.

- Use [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) protection plans to help protect the public endpoints you host within your virtual networks.

- Don't try to replicate on-premises perimeter network concepts and architectures into Azure. Although Azure has similar security capabilities, its implementation and architecture have been adapted to the cloud.