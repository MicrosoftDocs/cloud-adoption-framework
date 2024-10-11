---
title: Networking for AI workloads on Azure platforms
description: Discover how to build AI applications on Azure PaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Networking for AI workloads on Azure platforms

Azure AI Studio and Azure Machine Learning deploy to Microsoft Managed virtual networks that use private endpoints to access supporting Azure services like Azure Storage, Azure Key Vault, and Azure Container Registry.

- *Use virtual networks.* Implement secure networking practices to protect data as it moves to and from AI services. Use Azure services like Azure Private Link to provide private connectivity to Azure services with a virtual network. This configuration ensures data remains on the Microsoft network rather than traversing the public internet.

- *Deny inbound internet access to AI platforms.* *Deny public access to AI resources.* No PaaS services or AI model endpoints should be accessible from the public internet. For PaaS, use private endpoints for end user access. Use a jumpbox as part of the application resources for managing your AI resources.

    | Service | Recommendation |
    | --- | --- |
    | Azure AI Studio | Configure the [managed network](/azure/ai-studio/how-to/configure-managed-network) and use [private endpoints](/azure/ai-studio/how-to/configure-private-link)|
    | Azure OpenAI | ADD |
    | Azure Machine Learning | Follow the [security best practices](/azure/machine-learning/concept-enterprise-security) for Azure Machine Learning |
    | Azure AI services | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks?tabs=portal#use-private-endpoints) |

- *Limit outbound traffic from your AI resources*. Limiting outbound traffic from your AI model endpoints helps protect sensitive data and maintain the integrity of your AI models. For minimizing data exfiltration risks, restrict outbound traffic to approved services or fully qualified domain names (FQDNs) and maintain a list of trusted sources. You should only allow unrestricted internet outbound traffic if you need access to public machine learning resources, but regularly monitor and update your systems. For more information, see [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention), [Azure AI Studio,](/azure/ai-studio/how-to/configure-managed-network), and [Azure Machine Learning.](/azure/machine-learning/how-to-network-isolation-planning#allow-only-approved-outbound-mode)

- *Consider a generative AI gateway.* Consider using Azure API Management (APIM) as a generative AI gateway within your virtual networks. A generative AI gateway sits between your front-end and the AI endpoints. Application Gateway, WAF policies, and APIM within the virtual network is an established [architecture](https://github.com/Azure/apim-landing-zone-accelerator/blob/main/scenarios/workload-genai/README.md#scenario-3-azure-api-management---generative-ai-resources-as-backend) in generative AI solutions. For more information, see [AI Hub architecture](https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator#ai-hub-gateway-landing-zone-accelerator) and [Deploy Azure API Management instance to multiple Azure regions](/azure/api-management/api-management-howto-deploy-multi-region).

Apply network security controls by restricting access to service interfaces, allowing only necessary services or users. Limit internet exposure by exposing only services intended for external-facing use cases and using private connectivity for other services.

- *Segment virtual networks.* Apply network segmentation to control traffic flow and reduce the risk of lateral movement in case of a breach. Microsegmentation can provide even finer control at the workload or application level within Azure Virtual Networks (VNets).

- *Configure network access controls.* Utilize Network Security Groups (NSGs) and Azure Firewall to define and apply access policies that govern inbound and outbound traffic to and from AI workloads. These controls can be used to implement the principle of least privilege, ensuring that only essential communication is permitted.

- *Use network monitoring services.* Use services such as Azure Monitor Network Insights and Azure Network Watcher to gain visibility into network performance and health. Additionally, use Azure Sentinel for advanced threat detection and response across your Azure network.

- *Use private endpoints.* Create a virtual network and create a private endpoint subnet. Only allow access to your AI endpoints via private endpoints in the private endpoint subnet. Private endpoints add complexity to deployments and operations, but the security benefit often outweighs the complexity.

- *Manage default network access rules.* By default, Azure AI services resources accept connections from clients on any network. To limit access to selected networks, you must first change the default action.  Making changes to network rules can impact your applications' ability to connect to Azure AI services. Setting the default network rule to deny blocks all access to the data unless specific network rules that grant access are also applied. Before you change the default rule to deny access, be sure to grant access to any allowed networks by using network rules. If you allow listing for the IP addresses for your on-premises network, be sure to add all possible outgoing public IP addresses from your on-premises network.

- *Grant access to trusted Azure services for Azure OpenAI.* You can grant a subset of trusted Azure services access to Azure OpenAI, while maintaining network rules for other apps. These trusted services will then use managed identity to authenticate your Azure OpenAI service. More details are here : Configure Virtual Networks for Azure AI services.

- *Firewall rules.* Enabling firewall rules helps in managing and securing access to your Azure AI services. Only requests from allowed sources can access the service.