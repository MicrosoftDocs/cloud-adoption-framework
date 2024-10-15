---
title: Networking for AI workloads on Azure platforms
description: Discover how to build AI applications on Azure PaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Networking for AI workloads on Azure platforms

- *Understand manage networking.* [Azure AI Studio](/azure/ai-studio/how-to/configure-managed-network) and [Azure Machine Learning](/azure/machine-learning/how-to-managed-network) deploy to Microsoft Managed virtual networks that use private endpoints to access supporting Azure services like Azure Storage, Azure Key Vault, and Azure Container Registry. Understand these network architectures and how to best configure your virtual network.

- *Configure virtual networks.* Azure has detailed networking guidance for each Azure AI platform. Use the following table to find the right guidance to configure your virtual networks.

    | AI platform | Virtual network recommendations |
    | --- | --- |
    | Azure AI Studio | Configure the [managed network](/azure/ai-studio/how-to/configure-managed-network) and use [private endpoints](/azure/ai-studio/how-to/configure-private-link)|
    | Azure OpenAI | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) |
    | Azure Machine Learning | Create a [secure workspace](/azure/machine-learning/tutorial-create-secure-workspace-vnet) with a virtual network. [Plan for network isolation](/azure/machine-learning/how-to-network-isolation-planning).Follow the [security best practices](/azure/machine-learning/concept-enterprise-security) for Azure Machine Learning |
    | Azure AI services | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) |

## Secure virtual networks

- *Consider private endpoints.* No PaaS services or AI model endpoints should be accessible from the public internet. Private endpoints to provide private connectivity to Azure services within a virtual network. Private endpoints add complexity to deployments and operations, but the security benefit often outweighs the complexity.

- *Consider enforcing private DNS zones.* Private DNS zones centralize and secure DNS management for accessing PaaS services within your AI network. Set up Azure policies that enforce private DNS zones and require private endpoints to ensure secure, internal DNS resolutions.

- *Enable custom DNS servers and private endpoints for PaaS services.* Custom DNS servers manage PaaS connectivity within the network, bypassing public DNS. Configure private DNS zones in Azure to resolve PaaS service names securely and route all traffic through private networking channels.

## Manage connectivity

- *Use a jumpbox for access.* AI development access should use a jumpbox within the virtual network of the workload or through a connectivity hub virtual network. Use Azure Bastion to securely connect to virtual machines interacting with AI services. Azure Bastion provides secure RDP/SSH connectivity without exposing VMs to the public internet. Enable Azure Bastion to ensure encrypted session data and protect access through TLS-based RDP/SSH connections.

- *Limit outbound traffic from your AI resources*. Limiting outbound traffic from your AI model endpoints helps protect sensitive data and maintain the integrity of your AI models. For minimizing data exfiltration risks, restrict outbound traffic to approved services or fully qualified domain names (FQDNs) and maintain a list of trusted sources. You should only allow unrestricted internet outbound traffic if you need access to public machine learning resources, but regularly monitor and update your systems. For more information, see [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention), [Azure AI Studio](/azure/ai-studio/how-to/configure-managed-network), and [Azure Machine Learning.](/azure/machine-learning/how-to-network-isolation-planning#allow-only-approved-outbound-mode)

- *Consider a generative AI gateway.* Consider using Azure API Management (APIM) as a generative AI gateway within your virtual networks. A generative AI gateway sits between your front-end and the AI endpoints. Application Gateway, WAF policies, and APIM within the virtual network is an established [architecture](https://github.com/Azure/apim-landing-zone-accelerator/blob/main/scenarios/workload-genai/README.md#scenario-3-azure-api-management---generative-ai-resources-as-backend) in generative AI solutions. For more information, see [AI Hub architecture](https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator#ai-hub-gateway-landing-zone-accelerator) and [Deploy Azure API Management instance to multiple Azure regions](/azure/api-management/api-management-howto-deploy-multi-region).

*Use HTTPS for internet to Azure connectivity.* Secure connections using SSL and TLS protocols help protect data integrity and confidentiality for AI workloads connecting from the internet. Implement HTTPS through Azure Application Gateway or Azure Front Door. Both services provide encrypted, secure tunnels for internet-originating connections.

## Next step

> [!div class="nextstepaction"]
> [PaaS AI Security](../platform/security.md)
