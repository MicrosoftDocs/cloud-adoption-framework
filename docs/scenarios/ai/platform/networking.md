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

Network traffic control determines how data flows between your AI services and external systems. Traffic restrictions prevent unauthorized data movement while ensuring AI operations function properly. You must implement traffic controls to protect sensitive AI data and maintain operational security. Here's how:

1. **Deploy secure access through jumpbox infrastructure**. Jumpbox access provides a controlled entry point into your AI network environment while maintaining strict security boundaries. This approach centralizes access control and prevents direct exposure of AI development resources to external networks. Use a jumpbox within your AI workload virtual network or through a connectivity hub virtual network and configure [Azure Bastion](/azure/bastion/bastion-overview) to provide secure RDP/SSH connectivity without exposing virtual machines to the public internet.

2. **Restrict outbound traffic to approved destinations**. Outbound traffic restrictions prevent data exfiltration while allowing necessary communication for AI model training and inference. These restrictions protect your AI models and training data from unauthorized external transmission while maintaining required connectivity for legitimate operations. Limit outbound traffic to approved services and fully qualified domain names (FQDNs) as documented for [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention) and [Azure AI Foundry](/azure/ai-studio/how-to/configure-managed-network).

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
> [Governance for platform AI services](../platform/governance.md)
