---
title: Networking recommendations for AI workloads on Azure
description: Learn networking for AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Networking recommendations for AI workloads on Azure

This article offers networking recommendations for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Studio, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and non-generative AI workloads.

Networking enables secure and efficient connectivity to critical AI resources and is foundational to data integrity and privacy. Effective networking strategies protect sensitive AI workloads from unauthorized access and help optimize performance for AI model training and deployment.

## Configure virtual networks

Configuring virtual networks refers to setting up and managing private and secure networking environments for Azure AI platforms. Virtual networks allow organizations to isolate AI workloads and create secure communication channels. Proper configuration ensures that only authorized users and systems can access critical AI resources, and it minimizes exposure to the public internet.

| AI platform | Virtual network recommendations |
| --- | --- |
| Azure AI Studio | Configure the [managed network](/azure/ai-studio/how-to/configure-managed-network) and use [private endpoints](/azure/ai-studio/how-to/configure-private-link)|
| Azure OpenAI | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) |
| Azure Machine Learning | Create a [secure workspace](/azure/machine-learning/tutorial-create-secure-workspace-vnet) with a virtual network. [Plan for network isolation](/azure/machine-learning/how-to-network-isolation-planning). Follow the [security best practices](/azure/machine-learning/concept-enterprise-security) for Azure Machine Learning |
| Azure AI services | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) |

[Azure AI Studio](/azure/ai-studio/how-to/configure-managed-network) and [Azure Machine Learning](/azure/machine-learning/how-to-managed-network) deploy to Microsoft-managed virtual networks and deploy required dependent services. The managed virtual networks use private endpoints to access supporting Azure services like Azure Storage, Azure Key Vault, and Azure Container Registry. Use the links to view the network architectures of these services so you can best configure your virtual network.

## Secure virtual networks

Securing virtual networks involves using private endpoints, enforcing DNS zones, and enabling custom DNS servers to protect AI workloads. These strategies limit public internet exposure and prevent unauthorized access. Effective network security is essential for safeguarding sensitive AI models and ensuring privacy compliance.

- *Consider private endpoints.* No PaaS services or AI model endpoints should be accessible from the public internet. Private endpoints to provide private connectivity to Azure services within a virtual network. Private endpoints add complexity to deployments and operations, but the security benefit often outweighs the complexity.

- *Consider creating private endpoints for AI service portals.* Private endpoints provide secure, private access to PaaS portals like Azure AI Studio and Azure Machine Learning studioF. Set up private endpoints for these global portals in a hub virtual network. This configuration provides secure access to public-facing portal interfaces directly from user devices.

- *Consider enforcing private DNS zones.* Private DNS zones centralize and secure DNS management for accessing PaaS services within your AI network. Set up Azure policies that enforce private DNS zones and require private endpoints to ensure secure, internal DNS resolutions. If you don't have central Private DNS Zones, the DNS forwarding doesn't work until you add conditional forwarding manually. For example, see [using custom DNS](/azure/machine-learning/how-to-custom-dns) with Azure AI Studio hubs and Azure Machine Learning workspace.

- *Enable custom DNS servers and private endpoints for PaaS services.* Custom DNS servers manage PaaS connectivity within the network, bypassing public DNS. Configure private DNS zones in Azure to resolve PaaS service names securely and route all traffic through private networking channels.

## Manage connectivity

Managing connectivity controls how AI resources interact with external systems, focusing on secure data transmission and access. Techniques like using a jumpbox and limiting outbound traffic help protect AI workloads. Proper connectivity management minimizes security risks and ensures smooth, uninterrupted AI operations.

- *Use a jumpbox for access.* AI development access should use a jumpbox within the virtual network of the workload or through a connectivity hub virtual network. Use Azure Bastion to securely connect to virtual machines interacting with AI services. Azure Bastion provides secure RDP/SSH connectivity without exposing VMs to the public internet. Enable Azure Bastion to ensure encrypted session data and protect access through TLS-based RDP/SSH connections.

- *Limit outbound traffic from your AI resources*. Limiting outbound traffic from your AI model endpoints helps protect sensitive data and maintain the integrity of your AI models. For minimizing data exfiltration risks, restrict outbound traffic to approved services or fully qualified domain names (FQDNs) and maintain a list of trusted sources. You should only allow unrestricted internet outbound traffic if you need access to public machine learning resources, but regularly monitor and update your systems. For more information, see [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention), [Azure AI Studio](/azure/ai-studio/how-to/configure-managed-network), and [Azure Machine Learning.](/azure/machine-learning/how-to-network-isolation-planning#allow-only-approved-outbound-mode)

- *Consider a generative AI gateway.* Consider using Azure API Management (APIM) as a generative AI gateway within your virtual networks. A generative AI gateway sits between your front-end and the AI endpoints. Application Gateway, WAF policies, and APIM within the virtual network is an established [architecture](https://github.com/Azure/apim-landing-zone-accelerator/blob/main/scenarios/workload-genai/README.md#scenario-3-azure-api-management---generative-ai-resources-as-backend) in generative AI solutions. For more information, see [AI Hub architecture](https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator#ai-hub-gateway-landing-zone-accelerator) and [Deploy Azure API Management instance to multiple Azure regions](/azure/api-management/api-management-howto-deploy-multi-region).

- *Use HTTPS for internet to Azure connectivity.* Secure connections using TLS protocols help protect data integrity and confidentiality for AI workloads connecting from the internet. Implement HTTPS through Azure Application Gateway or Azure Front Door. Both services provide encrypted, secure tunnels for internet-originating connections.

## Next step

> [!div class="nextstepaction"]
> [Governance PaaS AI](../platform/governance.md)
