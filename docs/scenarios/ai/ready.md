---
title: AI Ready – Recommendations to prepare an AI foundation
description: Optimize your AI foundation with Azure's best practices for region selection, governance, networking, and connectivity.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Ready – Recommendations to prepare an AI foundation

This article provides recommendations for making key design and process decisions that all your AI workloads inherit. It assumes as a prerequisite familiarity with [CAF Ready](/azure/cloud-adoption-framework/ready/) and [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/). It focuses on AI-specific guidance for region selection, governance baselines, networking, and connectivity to align with [your AI model centralization and sharing approach](./plan.md#plan-for-ai-centralization-and-endpoint-sharing).

:::image type="content" source="./images/ai-resource-hierarchy.svg" alt-text="Diagram showing AI workloads within a resource hierarchy using management groups and subscriptions, organized in a hub-and-spoke architecture. It shows where internal and external users connect to different AI workload types. The architecture illustrates centralized and decentralized AI workload deployment, highlighting internal and internet-facing workloads, with security and networking components for resource management across regions. Centralized AI resources are shared, while intelligent apps are deployed within individual subscriptions." lightbox="./images/ai-resource-hierarchy.svg" border="false":::
*Figure 1. Resource hierarchy for AI workloads. It shows a hub and spoke approach with internet-facing and internal applications. It depicts centralized and decentralized AI endpoints.*

## Prepare AI deployment regions

Whether you use a centralized or decentralized approach to AI model deployment, you still need to select the right region or regions to host your AI models. It affects the performance, compliance, cost, and availability of your AI services:

- *Use multiple regions to host AI model endpoints.* For production workloads, host AI endpoints in at least two regions to provide redundancy and ensure high availability. Although generative AI models are stateless, hosting them in multiple regions enables faster failover and recovery during regional failures. For Azure OpenAI models (GPTs), you can use [global deployments](/azure/ai-services/openai/how-to/deployment-types#deployment-types), which is multi-region and can automatically and transparently route the request to a region with enough capacity. If you opt for a nonglobal deployment (regional), use [Azure API Management](/azure/api-management/genai-gateway-capabilities#backend-load-balancer-and-circuit-breaker) for load balancing API requests to AI endpoints.

- *Confirm service availability.* Before deployment, ensure the necessary AI services [availability in the region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/#products-by-region_tab5) you selected. Some regions might not offer specific AI services or might have limited features, which can affect the functionality and scalability of your solution. For example, Azure OpenAI service availability can differ depending on the deployment model (Global Standard, Global Provisioned, [Regional] Standard, [Regional] Provisioned). Verify the AI service to ensure you have access to the resources you need.

- *Evaluate region quota and capacity.* As your AI workloads grow, consider the quota or subscription limits in your chosen region. Azure services have regional subscription limits, and these limits could affect large-scale AI model deployments, such as large inference workloads. Proactively reach out to Azure support if you anticipate needing extra capacity to avoid disruptions.

- *Evaluate performance.* Additionally, when building applications that need to retrieve data, such as a RAG applications, consider where you store your data to optimize performance. While data colocation with models in RAG apps isn't required, it can improve performance by reducing latency and ensuring efficient data retrieval.

- *Prepare for continuity of operations.* To ensure Business Continuity and Disaster Recovery (BCDR), replicate critical assets such as fine-tuned models, RAG data, trained models, and training datasets in a secondary region. This redundancy enables faster recovery if there's an outage and ensures continued service availability.

## Prepare AI resource organization

In Azure, resource organization is how you structure management groups and subscriptions to organize your Azure resources. Resource organization is critical for AI governance across AI workloads and cost management.

- *Use management groups to govern different workload types*. AI workloads should at least be divided into two different types: internet-facing ("online") and internal only ("corporate") workloads. The distinction provides an important data governance boundary. You don’t want to allow external users to access sensitive or confidential business information required for internal work. You don’t need a separate management group for AI workloads. This distinction between internet-facing and internal workloads aligns with Azure landing zone. For more information, see [Azure landing zone management groups.](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)

- *Apply AI policies to each management group.* Start with baseline policies for each workload type, such as "[landing zones](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#landing-zones)" "[online](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#online)" or "[corporate](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#corp)" policies used in Azure landing zone. Then, review and assign  Azure Policy built-in definitions for [Azure AI services](/azure/ai-services/policy-reference), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search)*, [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies#machine-learning), [Azure Virtual Machines](/azure/virtual-machines/policy-reference).

- *Know where to place centralized AI resources.* If you’re using a centralized model to share AI endpoints, place those AI resources in a dedicated AI subscription. The subscription provides a governance boundary for a dedicated team to deploy, govern, secure, and manage AI endpoints. It also isolates AI resources from workload resources. (*See figure, specifically Workload 2 subscription - Dedicated AI resources*). In the context of Azure landing zone, it's an application landing zone subscription with only AI resources.

- *Know where to place decentralized AI resources.* In a decentralized model, where you dedicate AI resources to an application, deploy AI resources and application resources together in the same subscription. In the context of Azure landing zone, it's an application landing zone subscription with AI resources and application resources.

## Prepare AI network topology

This guidance provides recommendations for setting up your network topology for AI workloads. Organizations with multiple intelligent applications should use a hub and spoke network topology. If you have a single intelligent application, hub and spoke topology is where you should head when you have more workloads.

- *Deploy networking and security resources to the hub.* Centralize Azure Bastion in the hub virtual network for AI development access. Place Azure Firewall as needed here to secure network traffic between. It can be beneficial to group all private endpoints in the hub for security reasons. Also deploy on-premises connectivity resources like VPN Gateway and Express Route to the hub virtual network.

- *Deploy AI resources and endpoints in spoke virtual networks.* Spoke virtual networks host all AI resources and endpoints so they inherit the governance policies of the management group they’re in. This guidance includes centralized AI resources.

- *Secure public endpoints for intelligent applications.* Public-facing AI applications need to place all AI endpoints and intelligent application resources behind virtual networks. Use private endpoints for any PaaS services to maintain secure internal communication between Azure resources without exposing them to the public internet. Route public traffic through Azure Front Door or Application Gateway, coupled with Azure Web Application Firewall (WAF) policies.

- *Deploy reverse proxies in spoke virtual networks.* Regional load balancers like Application Gateway and reverse proxies like Azure API Management (APIM) that reside in a virtual network should be in the spoke virtual network and front intelligent application resources. Secure these endpoints with WAF policies to ensure safe access from external sources. Coupling Application Gateway, WAF policies, and APIM within the virtual network is an established [architecture](https://github.com/Azure/apim-landing-zone-accelerator/blob/main/scenarios/workload-genai/README.md#scenario-3-azure-api-management---generative-ai-resources-as-backend) in generative AI solutions. For more information, see [AI Hub architecture](https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator#ai-hub-gateway-landing-zone-accelerator) and [Deploy Azure API Management instance to multiple Azure regions](/azure/api-management/api-management-howto-deploy-multi-region).

## Prepare AI connectivity

This guidance provides recommendations on how different end users should connect to AI applications and resources. It also addresses dedicated on-premises connectivity to high-throughput data transfer.

- *Connect to internal AI workloads.* On-premises users connect to internal AI workloads through an Application Gateway or Azure Front Door with Azure Web Application Firewall policies for security purposes. AI developers and administrators connect via Azure Bastion in the hub virtual network (*see figure 1*).

- *Secure internet-facing networks.* External, online users access internet-facing AI workloads through the applications resources in the spoke network. Front these workloads with Application Gateway or Azure Front Door with Azure Web Application Firewall policies for security purposes.

- *Connect to on-premises data.* For organizations transferring large amounts of data from on-premises sources to cloud environments, use a high-bandwidth connection. Azure [ExpressRoute](/azure/expressroute/expressroute-introduction) is ideal for high data volumes, real-time processing, or workloads that require consistent performance. It has [FastPath](/azure/expressroute/about-fastpath) feature that improves data path performance. Use [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) for moderate data volumes, infrequent data transfer, or when public internet access is required. It’s simpler to set up and cost-effective for smaller datasets than ExpressRoute. For more information, see [Connect an on-premises network to Azure](/azure/architecture/reference-architectures/hybrid-networking/).

- *Prepare domain name resolution services.* Use private endpoints to protect AI workloads by assigning them private IP addresses for communication. [Integrate private endpoints with DNS](/azure/private-link/private-endpoint-dns-integration) for proper DNS resolution and successful private endpoint functionality. Deploy Azure DNS infrastructure as part of your [Azure landing zone](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) and configure conditional forwarders from existing DNS services for the appropriate zones (/azure/private-link/private-endpoint-dns). For more information,see, [Private Link and DNS integration at scale for Azure landing zones](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale).

## Implementation options

Choosing the right approach for the foundation of AI workloads involves not only setting up the core infrastructure but also understanding the separation of responsibilities and considerations necessary for an AI-focused Azure landing zone.

### Deploy a foundation with Azure landing zone

Azure landing zone provides a starting point for preparing your Azure environment. Deploy AI workload resources such as Azure AI Studio, Azure Machine Learning, Azure AI services, Azure Virtual Machines, and supporting resources to an Application Landing Zone (*see figure 2: "Landing zone A2 subscription"*). You can use the various implementations for Azure Landing Zone. Ensure to apply the policies relevant to your AI deployment as you're using the Azure Landing Zone accelerator.

:::image type="content" source="./images/alz-ai.svg" alt-text="Diagram showing AI workloads within an Azure landing zone." lightbox="./images/alz-ai.svg" border="false":::
*Figure 2. AI applications in the context of an Azure landing zone.*

### Deploy a custom environment

If you have an existing Azure environment or don’t want to start with Azure landing zone, use the guidance discussed in this article to create a custom environment for your AI workloads.

## Next steps

The rest of the guidance focuses on building AI workloads in Azure using PaaS and IaaS solutions.
> [!div class="nextstepaction"]
> [Adopt AI with Azure PaaS](adopt-paas.md)

> [!div class="nextstepaction"]
> [Adopt AI with Azure IaaS](adopt-iaas.md)
