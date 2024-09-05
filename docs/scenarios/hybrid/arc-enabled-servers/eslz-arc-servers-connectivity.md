---
title: Network connectivity for Azure Arc-enabled servers
description: Understand the design considerations and recommendations for network connectivity of Azure Arc-enabled servers
author: Welasco
ms.author: vsantana
ms.date: 10/08/2021
ms.topic: conceptual
ms.custom: think-tank, e2e-hybrid
---

# Network topology and connectivity for Azure Arc-enabled servers

Azure Arc-enabled servers let you manage your Windows and Linux physical servers and virtual machines (hosted either in your on-premises environment or by a third-party cloud provider) using the Azure control plane. This document walks you through the key design considerations and best practices for Azure Arc-enabled servers connectivity as part of a Cloud Adoption Framework enterprise-scale landing zone guidance.

This article assumes that you have successfully implemented enterprise-scale landing zone and established hybrid network connections, and therefore focuses on the Azure Arc-enabled servers connected machine agent connectivity. For more information on this prerequisite, review the [enterprise-scale overview](../../../ready/enterprise-scale/index.md) and the [implementation guidance](../../../ready/enterprise-scale/implementation.md).

## Architecture

The following diagram shows a conceptual reference architecture for the connectivity of Azure Arc-enabled servers.

[![Diagram that shows Azure Arc-enabled servers connectivity options.](./media/arc-enabled-servers-connectivity-options.png)](./media/arc-enabled-servers-connectivity-options.png#lightbox)

## Design considerations

The following list gives an overview of network design considerations for Azure Arc-enabled servers.

- **Define the agent's connectivity method:** Review your existing infrastructure, security requirements, and decide how the connected machine agent will [communicate with Azure](/azure/azure-arc/servers/network-requirements) from your on-premises network or other cloud providers. This connection can go directly over the internet, through a proxy server, or you can [implement Private Link](/azure/azure-arc/servers/private-link-security) for a private connection.
- **Manage access to Azure service tags:** Create an automated process to keep the firewall and proxy network rules updated according to the [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements).
- **Secure your network connectivity to Azure Arc:** Configure the machine operating system to use Transport Layer Security (TLS) version 1.2. Older versions aren't recommended due to known vulnerabilities.
- **Define extensions connectivity method:** Azure extensions deployed on an Azure Arc-enabled server typically need to communicate with other Azure services. This connectivity can go directly using public networks, through a firewall, or through a proxy server. If your design requires private connectivity, you'll need to take [additional steps](/azure/azure-arc/servers/private-link-security#how-it-works) beyond configuring Private Endpoints for the Arc agent to enable Private Endpoint connectivity for each service accessed by extensions. Also, consider the use of either [shared or dedicated circuits](/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager) in terms of cost, availability, and bandwidth requirements.
- **Review your overall connectivity architecture:** Review the [network topology and connectivity design area](../../../ready/landing-zone/design-area/network-topology-and-connectivity.md) of Azure landing zone enterprise-scale to assess the impact of Azure Arc-enabled servers on your overall connectivity.

## Design recommendations

### Define Azure Arc agent's connectivity method

Azure Arc-enabled servers let you connect hybrid machines using the following methods:

- Direct connection, optionally from behind a firewall or a proxy server
- Azure Private Link

#### Direct connection

Azure Arc-enabled servers offer a [direct connectivity to Azure public endpoints](/azure/azure-arc/servers/network-requirements#networking-configuration). With this connectivity method, all machine agents open a connection via the internet using a public endpoint. The connected machine agent for Linux and Windows communicates outbound to Azure in a secure manner using the HTTPS protocol (TCP/443).

When using the direct connection method, you need to review your internet access for the connected machine agent. We recommend configuring the [required network rules](/azure/azure-arc/servers/network-requirements).

#### Proxy server or firewall connection (optional)

If the machine uses a firewall or a proxy server to communicate over the internet, the agent connects outbound using the HTTPS protocol.

If outbound connectivity is restricted by your firewall or a proxy server, make sure to allow the IP ranges as per the [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements). When you only allow the required IP ranges or domain names for the agent to communicate with the service, use [service tags and URLs](/azure/azure-arc/servers/network-requirements#service-tags) to configure your firewall or proxy server.

If you deploy extensions on your Azure Arc-enabled servers, every extension connects to its own endpoint or endpoints, and you must also allow all corresponding URLs in the firewall or proxy. Adding these endpoints ensures granular secured network traffic to meet principle of least privilege (PoLP).

#### Private Link

By using Azure Arc-enabled server with Arc Private Link Scope, you can ensure that all traffic from your Arc agents remains on your network. This configuration has security advantages: the traffic doesn't traverse the Internet and you do not need to open as many outbound exceptions on your datacenter firewall. However, using Private Link imposes a number of management challenges while increasing overall complexity and cost, especially for global organizations. Some of these challenges are:

- The choice to use Arc Private Link Scopes encompasses all Arc clients under the same DNS scope. You can't have some Arc clients using Private Endpoints and some using public when they share a DNS server (without workarounds like [DNS Policies](/windows-server/networking/dns/deploy/dns-policies-overview)).
- Your Arc clients either all Private Endpoints in a primary region or DNS needs to be configured so that the same Private Endpoint names resolve to different IP addresses (for example, using [selectively replicated DNS partitions for Active Directory-integrated DNS](/troubleshoot/windows-server/networking/create-apply-custom-application-directory-partition)). If you use the same Private Endpoints for all your Arc clients, you need to be able to route traffic from all of your networks to the Private Endpoints.
- More steps are required to ensure Private Endpoints are also used for any Azure services accessed by Extensions software components deployed using Arc, such as Log Analytics workspaces, Automation Accounts, Key Vault or Azure Storage.
- Connectivity to Azure Entra ID uses public endpoint, so clients still require some internet access.
- If ExpressRoute is used for private connectivity, consider reviewing the resiliency best practices for [circuits](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-circuits/), [gateways](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-gateway/), [connections](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-connection/) and [ExpressRoute Direct](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-direct/).

Because of these challenges, we recommend evaluating whether Private Link is a requirement for your Arc implementation. Consider that with public endpoints, the traffic will be encrypted and, depending on how to use Arc for Servers, can be limited to management and metadata traffic. Security concerns can be alleviated by implementing [local agent security controls](/azure/azure-arc/servers/security-overview#local-agent-security-controls).

Review the [restrictions and limitations](/azure/azure-arc/servers/private-link-security#restrictions-and-limitations) associated with Private Link support for Arc for more details.

[![Diagram that shows Azure Arc-enabled servers Private Link topology.](./media/arc-enabled-servers-private-link-topology.png)](./media/arc-enabled-servers-private-link-topology.png#lightbox)

> [!TIP]
> Review [Azure Private Link security](/azure/azure-arc/servers/private-link-security#how-it-works) for more information.

### Manage access to Azure service tags

We recommend implementing an automated process for keeping the firewall and proxy network rules updated according to the [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements).

### Secure your network connectivity to Azure Arc

We recommend using [Transport Layer Security 1.2 protocol](/azure/azure-arc/servers/network-requirements#transport-layer-security-12-protocol) to ensure the security of data in transit to Azure. Older versions of TLS/Secure Sockets Layer (SSL) were found to be vulnerable and aren't recommended.

### Define extensions connectivity method

When you enable any of the Azure Arc-enabled servers supported VM extensions, those extensions connect to other Azure services. It's important to determine the connectivity method for those extensions: either directly, behind a proxy server/firewall, or using Azure Private Link.

If your Azure Arc-enabled-servers use a proxy or a firewall, you must also allow all URLs required for the extensions, as they'll communicate with their own endpoints.

If you're using Private Link, you must configure [Private Link for each service](/azure/azure-arc/servers/private-link-security#how-it-works).

## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following resources:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios.
- Review the [prerequisites](/azure/azure-arc/servers/prerequisites) for Azure Arc-enabled servers.
- Review the required [network configuration](/azure/azure-arc/servers/private-link-security#network-configuration) for the Private Link connectivity method.
- Understand how Azure Arc-enabled servers [Private Link](/azure/azure-arc/servers/private-link-security#how-it-works) works.
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers.
- Plan your [Private Link setup](/azure/azure-arc/servers/private-link-security#planning-your-private-link-setup).
- For solving any connectivity issues, review the [troubleshooting Azure Arc-enabled servers agent connection guide](/azure/azure-arc/servers/troubleshoot-agent-onboard).
- Learn more about Azure Arc via the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).
