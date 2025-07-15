---
title: Configure secure networking for Azure AI platform services
description: Learn how to implement secure networking for AI workloads using Azure platform services with actionable recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Configure secure networking for Azure AI platform services

This article helps you implement secure networking for AI workloads on Azure platform services. You need secure networking to protect sensitive AI models, ensure data privacy, and maintain compliance requirements. Proper network configuration controls access to Azure AI Foundry and Azure AI Services while optimizing performance for model training and deployment.

## Use virtual networks

Virtual networks establish secure communication boundaries for AI services and prevent unauthorized access from public networks. Private endpoints eliminate public internet exposure while maintaining full service functionality and performance. You should use virtual networks with private endpoints to protect AI models, data, and services from external threats. Here's how:

1. **Create private endpoints for all AI platform services**. Private endpoints provide dedicated network interfaces within your virtual network that connect directly to Azure services. This configuration removes public internet exposure while maintaining full functionality and performance for your AI workloads. Use [private link for Azure AI Foundry](/azure/ai-foundry/how-to/configure-private-link?tabs=azure-portal&pivots=fdp-project) and apply the same restrictions to [Azure AI services](/azure/ai-services/cognitive-services-virtual-networks).

2. **Deploy supporting services within the network boundary**. Supporting services like Azure Storage, Azure Key Vault, and Azure Container Registry must operate within the same secure network boundary as your AI services. This configuration ensures consistent security posture across all components while maintaining proper access controls for your AI workload dependencies. Use private endpoints to connect these supporting services to your managed virtual networks as shown in the [Baseline Azure AI Foundry chat reference architecture](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-chat#architecture).

## Control network traffic

Network traffic control defines how data flows between AI services and external systems. Proper traffic restrictions protect sensitive AI data and ensure secure operations. You must implement traffic controls to safeguard AI workloads and maintain operational security. Here's how:

1. **Deploy secure access using jumpbox infrastructure**. Jumpbox access provides a centralized entry point into your AI network environment while maintaining strict security boundaries. This configuration prevents direct exposure of AI resources to external networks while enabling secure access. Use a jumpbox within your AI workload virtual network or a connectivity hub virtual network, and configure [Azure Bastion](/azure/bastion/bastion-overview) for secure RDP/SSH connectivity without exposing virtual machines to the public internet.

2. **Restrict outbound traffic to approved destinations**. Outbound traffic restrictions prevent unauthorized data exfiltration while allowing necessary communication for AI model training and inference. This approach protects AI models and training data while maintaining connectivity for legitimate operations. Limit outbound traffic to approved services and fully qualified domain names (FQDNs) as documented for [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention) and [Azure AI Foundry](/azure/ai-studio/how-to/configure-managed-network).

3. **Prepare domain name resolution services**. Deploy Azure DNS infrastructure as part of your [Azure landing zone](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) and configure [conditional forwarders](/azure/private-link/private-endpoint-dns) for appropriate zones. This setup ensures reliable name resolution for secure communication between AI workloads and external systems.

4. **Configure network access controls**. Use [network security groups](/azure/virtual-network/network-security-groups-overview) (NSGs) to define and enforce access policies for inbound and outbound traffic. These controls implement the principle of least privilege, ensuring only essential communication is permitted.

5. **Use network monitoring services**. Monitor network performance and health using tools like Azure Monitor Network Insights and Azure Network Watcher. For advanced threat detection and response, integrate [Microsoft Sentinel](/azure/sentinel/overview) into your Azure network monitoring strategy.

6. **Deploy Azure Firewall to secure outbound traffic**. [Azure Firewall](/azure/firewall/overview) enforces security policies for outgoing traffic before it reaches the internet. Use it to control and monitor outbound traffic, enable SNAT for private IP translation, and ensure secure and identifiable outbound communication.

7. **Use Azure Web Application Firewall (WAF) for internet-facing workloads**. [Azure WAF](/azure/web-application-firewall/overview) protects AI workloads from common web vulnerabilities like SQL injections and cross-site scripting attacks. Configure Azure WAF on [Application Gateway](/azure/web-application-firewall/ag/ag-overview) to enhance security for workloads exposed to malicious web traffic.

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Network isolation | [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) | Creates secure network boundaries and enables private communication between Azure resources |
| Private connectivity | [Azure Private Link](/azure/private-link/private-link-overview) | Provides private access to Azure services over the Microsoft backbone network |
| Secure access | [Azure Bastion](/azure/bastion/bastion-overview) | Delivers secure RDP/SSH connectivity without public IP exposure |
| DNS management | [Azure Private DNS](/azure/dns/private-dns-overview) | Manages private DNS zones for secure name resolution within virtual networks |
| API gateway | [Azure API Management](/azure/api-management/api-management-key-concepts) | Centralizes API management and security for AI service endpoints |
| Web security | [Azure Application Gateway](/azure/application-gateway/overview) | Provides secure HTTPS termination and web application firewall capabilities |
| Global delivery | [Azure Front Door](/azure/frontdoor/front-door-overview) | Offers global load balancing and secure edge connectivity for AI applications |

## Next step

> [!div class="nextstepaction"]
> [Governance](../platform/governance.md)
