---
title: Network connectivity for Azure Arc-enabled servers
description: Understand the design considerations and recommendations for network connectivity of Azure Arc-enabled servers
author: Welasco
ms.author: vsantana
ms.date: 10/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-hybrid
---

# Network connectivity for Azure Arc-enabled servers

Azure Arc-enabled servers let you manage your Windows and Linux physical servers and virtual machines (hosted either in your on-premises environment or by a third-party cloud provider) using the Azure control plane. This document walks you through the key design considerations and best practices for Azure Arc-enabled servers connectivity as part of a Cloud Adoption Framework enterprise-scale landing zone guidance.

This article assumes that you have successfully implemented enterprise-scale landing zone and established hybrid network connections, and therefore focuses on the Azure Arc-enabled servers connected machine agent connectivity. For more information on this prerequisite, review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and the [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Architecture

The following diagram shows a conceptual reference architecture for the connectivity of Azure Arc-enabled servers.

![Azure Arc-enabled servers connectivity options](./media/arc-enabled-servers-connectivity-options.svg)

## Design considerations

The following list gives an overview of network design considerations for Azure Arc-enabled servers.

- **Define the agent's connectivity method:** Review your existing infrastructure, security requirements, and decide how the connected machine agent will [communicate with Azure](/azure/azure-arc/servers/agent-overview#networking-configuration) from your on-premises network or other cloud providers. This connection can go directly over the internet, through a proxy server, or you can [implement Private Link](/azure/azure-arc/servers/private-link-security) for a private connection.
- **Manage access to Azure service tags:** Create an automated process to keep the firewall and proxy network rules updated according to the [Azure Arc network service tags and IP addresses range](https://www.microsoft.com/en-us/download/details.aspx?id=56519).
- **Secure your network connectivity to Azure Arc:** Configure the machine to use Transport Layer Security (TLS) version 1.2. Older versions are not recommended due to known vulnerabilities.
- **Define extensions connectivity method:** Azure extensions deployed on an Azure Arc-enabled server also need to communicate with other Azure services. This connectivity can go directly using public networks, through a firewall, or through a proxy server. To further secure the extension connectivity, you can [implement private endpoints](/azure/azure-arc/servers/private-link-security#how-it-works) for each extension.
- **Review your overall connectivity architecture:** Review the [network topology and connectivity design area](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity) of Azure landing zone enterprise-scale to assess the impact of Azure Arc-enabled servers on your overall connectivity.

## Design recommendations

### Define Azure Arc agent's connectivity method

Azure Arc-enabled servers let you connect hybrid machines using the following methods:

- Direct connection, optionally from behind a firewall or a proxy server
- Azure Private Link

#### Direct connection

Azure Arc-enabled servers offer a [direct connectivity to Azure public endpoints](/azure/azure-arc/servers/agent-overview#networking-configuration). With this connectivity method, all machine agents will open a connection via the internet using a public endpoint. The connected machine agent for Linux and Windows communicates outbound to Azure in a secure manner using the HTTPS protocol (TCP/443).

When using the direct connection method, you need to review your internet access for the connected machine agent. We recommend configuring the [required network rules](/azure/azure-arc/servers/agent-overview#networking-configuration).

#### Proxy server or firewall connection (optional)

If the machine uses a firewall or a proxy server to communicate over the internet, the agent connects outbound using the HTTP protocol.

If outbound connectivity is restricted by your firewall or a proxy server, make sure the [Azure Arc network service tags and IP addresses range](/azure/azure-arc/servers/agent-overview#networking-configuration) are not blocked by those devices. When you only allow the required IP ranges or domain names for the agent to communicate with the service, use [service tags and URLs](https://www.microsoft.com/en-us/download/details.aspx?id=56519) to configure your firewall or proxy server.

Be aware that if you deploy extensions on your Azure Arc-enabled servers, every extension has its own endpoint, and you must also allow all corresponding URLs in the firewall or proxy. Adding these endpoints will ensure granular secured network traffic to meet principle of least privilege (PoLP).

#### Private Link

Azure Arc-enabled servers let you deploy VM extensions to centrally manage your servers from Azure. These extensions connect to other resources such as Log Analytics workspaces, automation accounts, Key Vault or Azure Storage. You can use Azure Private Link to make this connection private without opening any public network access. All of the data is kept private, preventing data exfiltration. The traffic between Azure Arc-enabled servers and Azure services will go through a Site-to-Site VPN tunnel or an ExpressRoute with private peering.

![Azure Arc-enabled servers Private Link topology](./media/arc-enabled-servers-private-link-topology.svg)

This connection method has specific [restrictions and limitations](/azure/azure-arc/servers/private-link-security#restrictions-and-limitations) you should be familiar with. When you enable any of Azure Arc-enabled servers extensions, those extensions connect to specific Azure services that have their own requirements for configuring Private Link support.

> [!TIP]
> Review [Azure Private Link security](/azure/azure-arc/servers/private-link-security#how-it-works) for more information.

### Manage access to Azure service tags

We recommend implementing an automated process for keeping the firewall and proxy network rules updated according to the [Azure Arc network service tags and IP addresses range](https://www.microsoft.com/download/details.aspx?id=56519).

### Secure your network connectivity to Azure Arc

We recommend using [Transport Layer Security 1.2 protocol](/azure/azure-arc/servers/agent-overview#transport-layer-security-12-protocol) to ensure the security of data in transit to Azure. Older versions of TLS/Secure Sockets Layer (SSL) were found to be vulnerable and are not recommended.

### Define extensions connectivity method

When you enable any of the Azure Arc-enabled servers supported VM extensions, those extensions connect to other Azure services. It's important to determine the connectivity method for those extensions: either directly, behind a proxy server/firewall, or using Azure Private Link.

If your Azure Arc-enabled-servers use a proxy or a firewall, you must also allow all URLs required for the extensions, as they will communicate with their own endpoints.

If you are using Private Link, you must configure [Private Link for each service](/azure/azure-arc/servers/private-link-security#how-it-works).

## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Review the required [network configuration](/azure/azure-arc/servers/private-link-security#network-configuration) for the Private Link connectivity method
- Understand how Azure Arc-enabled servers [Private Link](/azure/azure-arc/servers/private-link-security#how-it-works) works
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
- Plan your [Private Link setup](/azure/azure-arc/servers/private-link-security#planning-your-private-link-setup)
- For solving any connectivity issues, review the troubleshooting Azure Arc-enabled servers agent connection [guide](/azure/azure-arc/servers/troubleshoot-agent-onboard)
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
