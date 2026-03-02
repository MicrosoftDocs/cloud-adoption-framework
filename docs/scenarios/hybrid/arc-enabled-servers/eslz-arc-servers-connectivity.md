---
title: Network Connectivity for Azure Arc-enabled Servers
description: Learn about design considerations and recommendations for network connectivity of Azure Arc-enabled servers to manage physical servers and virtual machines.
author: stephen-sumner
ms.author: pnp
ms.date: 10/14/2025
ms.topic: concept-article
---

# Network topology and connectivity for Azure Arc-enabled servers

Azure Arc-enabled servers let you manage Windows and Linux physical servers and virtual machines through the Azure control plane. This article describes key design considerations and best practices for Azure Arc-enabled servers connectivity as part of the Cloud Adoption Framework for Azure enterprise-scale landing zone guidance. This guidance applies to physical servers and virtual machines hosted in on-premises environments or through a partner cloud provider.

This article assumes an [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) and established hybrid network connections are in place. The guidance focuses on the connectivity of the connected machine agent for Azure Arc-enabled servers.

## Architecture

The following diagram shows a conceptual reference architecture for the connectivity of Azure Arc-enabled servers.

:::image type="content" source="./media/arc-enabled-servers-connectivity-options.png" alt-text="Diagram that shows Azure Arc-enabled servers connectivity options." lightbox="./media/arc-enabled-servers-connectivity-options.png" border="false":::

## Design recommendations

Consider the following network design recommendations for Azure Arc-enabled servers.

### Define an Azure Arc agent connectivity method

First, review existing infrastructure and security requirements. Then review the [network topology and connectivity design area](../../../ready/landing-zone/design-area/network-topology-and-connectivity.md) to assess how Azure Arc-enabled servers affect overall connectivity. Then, decide how the connected machine agent should [communicate with Azure](/azure/azure-arc/servers/network-requirements) from on-premises networks or other cloud providers. This connection can go over the internet, through a proxy server, or via [Azure Private Link](/azure/azure-arc/servers/private-link-security) for a private connection. If Azure Arc is implemented over the internet with or without a proxy, [Azure Arc gateway](/azure/azure-arc/servers/arc-gateway) can be used, which is now generally available. This feature helps reduce the overall number of endpoints that the proxy needs to allow access to.

#### Direct connection

Azure Arc-enabled servers can provide [direct connectivity to Azure public endpoints](/azure/azure-arc/servers/network-requirements#networking-configuration). With this connectivity method, all machine agents use a public endpoint to open a connection to Azure via the internet. The connected machine agent for Linux and Windows securely communicates outbound to Azure via the HTTPS protocol (TCP/443). Configure the machine operating system to use Transport Layer Security (TLS) version 1.2 or higher. TLS 1.3 is supported and recommended for all environments where available for improved security and compliance. When using the direct connection method, evaluate internet access for the connected machine agent. Configure the [required network rules](/azure/azure-arc/servers/network-requirements).

#### Proxy server or firewall connection

- If a machine uses a firewall or a proxy server to communicate over the internet, the agent connects outbound via the HTTPS protocol.
- If a firewall or proxy server is used to restrict outbound connectivity, allow the IP ranges in accordance with the [connected machine agent network requirements](/azure/azure-arc/servers/network-requirements). When only the required IP ranges or domain names are allowed for the agent to communicate with the service, use [service tags and URLs](/azure/azure-arc/servers/network-requirements#service-tags) to configure the firewall or proxy server.
- If extensions are deployed on Azure Arc-enabled servers, every extension connects to its own endpoint or endpoints, and all corresponding URLs must also be allowed in the firewall or proxy. Add these endpoints to ensure granular secured network traffic and to meet the principle of least privilege. Ensure that Azure extensions deployed on an Azure Arc-enabled server can communicate with other Azure services. Provide this connectivity directly through public networks, a firewall, or a proxy server. Configure private endpoints for the Azure Arc agent to use Azure Private Link if enhanced security and compliance are required. Private Link is generally available and recommended for regulated environments. If private connectivity is required, take extra steps to [enable private endpoint connectivity for each service](/azure/azure-arc/servers/private-link-security#how-it-works) that extensions access. Also, consider using either [shared or dedicated circuits](/azure/expressroute/expressroute-circuit-peerings) depending on cost, availability, and bandwidth requirements.
- To reduce the total number of URLs required in the firewall or proxy, determine whether the Azure Arc gateway service would be beneficial.
- Log Analytics gateway isn't supported as a proxy for the Connected Machine agent. Use Azure Arc gateway or standard proxy configurations as documented. For monitoring-only scenarios, use Monitor mode for the Connected Machine agent.

#### Azure Arc gateway

[Azure Arc gateway](/azure/azure-arc/servers/arc-gateway) reduces the total number of outbound HTTPS endpoints that a proxy needs for Azure Arc to work. It eliminates the need for most wildcard endpoints and reduces the total number of required endpoints to eight for agent connectivity. Extension endpoints may require additional configuration. The Azure Arc gateway service doesn't support Private Link or ExpressRoute peering; it requires internet access for outbound connectivity. Review Azure Arc gateway documentation for the latest supported scenarios and limitations.

#### Private Link

To ensure that all traffic from Azure Arc agents remains on the network, use Azure Arc Private Link Scope for Azure Arc-enabled servers. This configuration provides security advantages and is recommended for organizations with strict data residency or compliance requirements. The traffic doesn't traverse the internet, and fewer outbound exceptions are needed on datacenter firewalls. However, Private Link imposes management challenges and increases overall complexity and cost, especially for global organizations. Consider the following challenges:

- Azure Arc Private Link Scope encompasses all Azure Arc clients under the same Domain Name System (DNS) scope. Mixed use of private and public endpoints for Azure Arc clients sharing a DNS server isn't supported. Workarounds such as [DNS policies](/windows-server/networking/dns/deploy/dns-policies-overview) can be implemented.
- Azure Arc clients can have all private endpoints in a primary region. If not, DNS must be configured so that the same private endpoint names resolve to different IP addresses. For example, [selectively replicated DNS partitions for Windows Server Active Directory-integrated DNS](/troubleshoot/windows-server/networking/create-apply-custom-application-directory-partition) can be used. If the same private endpoints are used for all Azure Arc clients, routing from all networks to the private endpoints must be possible.
- To use private endpoints for any Azure services accessed by extension software components deployed via Azure Arc, extra steps are required. These services include Log Analytics workspaces, Azure Automation accounts, Azure Key Vault, and Azure Storage.
- Connectivity to Microsoft Entra ID uses public endpoints; clients require outbound internet access for authentication and identity services. As of October 2025, Private Link support for Microsoft Entra ID isn't available for Azure Arc-enabled servers.
- If ExpressRoute is used for private connectivity, review the resiliency best practices for [circuits](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/azure-resources/Network/expressRouteCircuits/), [gateways](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/azure-resources/Network/expressRouteGateways/), [connections](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/azure-resources/Network/connections/), and [ExpressRoute Direct](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/azure-resources/Network/expressRoutePorts/).

Azure Private Link is generally available for Azure Arc-enabled servers. Refer to the Private Link documentation for updated service availability and limitations.

Because of these challenges, evaluate if Private Link is required for Azure Arc implementation. Public endpoints encrypt traffic using TLS 1.2 or higher. Depending on usage of Azure Arc for servers, traffic may be limited to management and metadata traffic. To address security concerns, implement [local agent security controls](/azure/azure-arc/servers/security-overview#local-agent-security-controls).

Monitor mode for the Connected Machine agent restricts functionality to monitoring only and disables remote management and configuration extensions. Use Monitor mode for environments requiring minimal connectivity and maximum isolation.

For more information, see [Private Link security](/azure/azure-arc/servers/private-link-security#how-it-works) and review the [restrictions and limitations](/azure/azure-arc/servers/private-link-security#restrictions-and-limitations) associated with Private Link support for Azure Arc.

Indirectly connected mode for Azure Arc-enabled servers is retired as of September 2025. All connectivity must be direct or via supported proxy/gateway solutions.

:::image type="content" source="./media/arc-enabled-servers-private-link-topology.png" alt-text="Diagram that shows the Azure Arc-enabled servers Private Link topology." lightbox="./media/arc-enabled-servers-private-link-topology.png" border="false":::

### Manage access to Azure service tags

Implement an automated process to update firewall and proxy network rules according to the [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements). Use Azure service tags and regularly review updates to required endpoints.

## Next steps

For more information about hybrid cloud adoption, see the following resources:

- [Azure Arc jumpstart scenarios](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/)
- [Connected machine agent prerequisites](/azure/azure-arc/servers/prerequisites)
- [Network configuration for the Private Link connectivity method](/azure/azure-arc/servers/private-link-security#network-configuration)
- [Use Private Link to connect servers to Azure Arc](/azure/azure-arc/servers/private-link-security#how-it-works)
- [Plan an at-scale deployment of Azure Arc-enabled servers](/azure/azure-arc/servers/plan-at-scale-deployment)
- [Private Link setup](/azure/azure-arc/servers/private-link-security#planning-your-private-link-setup)
- [Troubleshoot Azure connected machine agent connection problems](/azure/azure-arc/servers/troubleshoot-agent-onboard)
- [Training: Manage hybrid infrastructure with Azure Arc](/training/paths/manage-hybrid-infrastructure-with-azure-arc/)
- For Windows Server 2025, use Windows Admin Center in Azure Arc for unified management and diagnostics. Review [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview) for new features including Network HUD and pay-as-you-go licensing.
