---
title: AI Ready – Recommendations to Prepare an AI Foundation
description: Learn how to optimize your AI foundation by using Azure best practices for region selection, governance, networking, and connectivity.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Ready – Recommendations to prepare an AI foundation

This article provides recommendations for making key design and process decisions that your workloads inherit. It assumes that you're already familiar with [Cloud Adoption Framework for Azure - Ready](/azure/cloud-adoption-framework/ready/) and [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/). The article focuses on AI-specific guidance for region selection, governance baselines, networking, and connectivity to align with your [AI centralization and endpoint sharing](./plan.md#plan-for-ai-centralization-and-endpoint-sharing) approach.

:::image type="complex" source="./images/ai-resource-hierarchy.svg" alt-text="Diagram that shows a resource hierarchy for AI workloads. It shows a hub and spoke approach with internet-facing and internal applications." border="false" lightbox="true":::
Diagram that shows AI workloads within a resource hierarchy that use management groups and subscriptions and are organized in a hub-and-spoke architecture. The diagram shows where internal and external users connect to different types of AI workloads. It illustrates centralized and decentralized AI workload deployment, and highlights internal-only workloads and internet-facing workloads. It includes security and networking components for managing resources across regions. Centralized AI resources are shared, but intelligent apps are deployed within individual subscriptions.
:::image-end:::

*Figure 1. The diagram illustrates a resource hierarchy for AI workloads. It shows a hub-and-spoke approach with internet-facing and internal applications. It also depicts centralized and decentralized AI endpoints.*

## Prepare AI deployment regions

Whether you use a centralized or decentralized approach to AI model deployment, you need to choose the right region or regions to host your AI models. This choice affects the performance, compliance, cost, and availability of your AI services.

- **Use multiple regions to host AI model endpoints.** For production workloads, host AI endpoints in at least two regions to provide redundancy and ensure high availability. Although generative AI models are stateless, hosting them in multiple regions ensures faster failover and recovery during regional failures. For Azure OpenAI Service models, like GPT models, you can use [global deployments](/azure/ai-services/openai/how-to/deployment-types#deployment-types). These multiregion deployments can automatically and transparently route requests to a region that has enough capacity. If you choose a nonglobal deployment, also known as a regional deployment, use [Azure API Management](/azure/api-management/genai-gateway-capabilities#backend-load-balancer-and-circuit-breaker) for load balancing API requests to AI endpoints.

- **Confirm service availability.** Before deployment, ensure that there is [availability in the region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/#products-by-region_tab5) for the AI resources that you need. Certain regions might not provide specific AI services or might have limited features, which can affect the functionality of your solution. This limitation can also affect the scalability of your deployment. For example, Azure OpenAI service availability can vary based on your deployment model. These deployment models include global standard, global provisioned, regional standard, and regional provisioned. Check the AI service to confirm that you have access to the necessary resources.

- **Evaluate region quota and capacity.** Consider the quota or subscription limits in your chosen region as your AI workloads grow. Azure services have regional subscription limits. These limits can affect large-scale AI model deployments, such as large inference workloads. To prevent disruptions, contact Azure support in advance if you foresee a need for additional capacity.

- **Evaluate performance.** When you build applications that need to retrieve data, such as retrieval-augmented-generation (RAG) applications, it's important to consider data storage locations to optimize performance. You don't have to colocate data with models in RAG apps, but doing so can improve performance by reducing latency and ensuring efficient data retrieval.

- **Prepare for continuity of operations.** To ensure business continuity and disaster recovery, replicate critical assets such as fine-tuned models, RAG data, trained models, and training datasets in a secondary region. This redundancy enables faster recovery if there's an outage and ensures continued service availability.

## Prepare AI resource organization

In Azure, resource organization includes structuring management groups and subscriptions to effectively manage your Azure resources. Resource organization is essential for AI governance across AI workloads and for efficient cost management.

- **Use management groups to govern different workload types.** Separate AI workloads into two different types. These workload types are internet-facing, or *online*, and internal-only, or *corporate*. This distinction provides an important data governance boundary. Use this approach to prevent external users from accessing sensitive or confidential business information that you need for internal work. You don't need a separate management group for AI workloads. The distinction between internet-facing workloads and internal-only workloads aligns with Azure landing zones. For more information, see [Azure landing zone management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

- **Apply AI policies to each management group.** Start with baseline policies for each workload type and [Azure landing zone policies](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies). Add more Azure Policy definitions to this baseline for AI services, such as [Azure AI services](/azure/ai-services/policy-reference), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search), [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies#machine-learning), [Azure Virtual Machines](/azure/virtual-machines/policy-reference).

- **Know where to place centralized AI resources.** If you use a centralized model to share AI endpoints, place those AI resources in a dedicated AI subscription. A dedicated AI subscription provides a governance boundary for a dedicated team to deploy, govern, secure, and manage AI endpoints. It also isolates AI resources from workload resources. For more information, see *Figure 1: Intelligent app 3*. In the context of an Azure landing zone, a dedicated AI subscription is an application landing zone subscription that only has AI resources.

- **Know where to place decentralized AI resources.** In a decentralized model, where you dedicate AI resources to an application, deploy AI resources and application resources together in the same subscription. In the context of an Azure landing zone, it's an application landing zone subscription that has AI resources and application resources.

## Prepare AI network topology

This guidance provides recommendations for setting up your network topology for AI workloads. Organizations that have multiple intelligent applications should use a hub-and-spoke network topology. When you have a single intelligent application, consider adopting a hub-and-spoke topology as the number of your workloads increases.

- **Deploy networking and security resources to the hub.** Centralize Azure Bastion in the hub virtual network for AI development access. Use Azure Firewall as needed to secure network traffic between. For security reasons, it can be beneficial to group all private endpoints in the hub. Deploy on-premises connectivity resources like Azure VPN Gateway and Azure ExpressRoute to the hub virtual network.

- **Deploy AI resources and endpoints in spoke virtual networks.** Spoke virtual networks host all AI resources and endpoints so that they inherit the governance policies of the management group that they're in. This guidance includes centralized AI resources.

- **Secure public endpoints for intelligent applications.** Public-facing AI applications need to place all AI endpoints and intelligent application resources behind virtual networks. Use private endpoints for all platform as a service (PaaS) solutions to maintain secure internal communication between Azure resources without exposing them to the public internet. Route public traffic through Azure Front Door or Azure Application Gateway, coupled with Azure web application firewall (WAF) policies.

- **Deploy reverse proxies in spoke virtual networks.** Regional load balancers like Application Gateway and reverse proxies like API Management that reside in a virtual network should be in the spoke virtual network and front intelligent application resources. Secure these endpoints with WAF policies to ensure safe access from external sources. Coupling Application Gateway, WAF policies, and API Management within the virtual network is an established [architecture](https://github.com/Azure/apim-landing-zone-accelerator/blob/main/scenarios/workload-genai/README.md#scenario-3-azure-api-management---generative-ai-resources-as-backend) in generative AI solutions. For more information, see [AI Hub architecture](https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator#ai-hub-gateway-landing-zone-accelerator) and [Deploy API Management instance to multiple Azure regions](/azure/api-management/api-management-howto-deploy-multi-region).

## Prepare AI connectivity

This guidance provides recommendations on how different users should connect to AI applications and resources. It also addresses dedicated on-premises connectivity to high-throughput data transfer.

- **Connect to internal AI workloads.** On-premises users connect to internal AI workloads through an Application Gateway or Azure Front Door with Azure WAF policies for security purposes. AI developers and administrators connect via Azure Bastion in the hub virtual network. For more information, see *Figure 1*.

- **Secure internet-facing networks.** External, online users access internet-facing AI workloads through the application's resources in the spoke network. Front these workloads with Application Gateway or Azure Front Door with Azure WAF policies for security purposes.

- **Connect to on-premises data.** Organizations that transfer large amounts of data from on-premises sources to cloud environments should use a high-bandwidth connection. [ExpressRoute](/azure/expressroute/expressroute-introduction) is ideal for high data volumes, real-time processing, or workloads that require consistent performance. It has a [FastPath](/azure/expressroute/about-fastpath) feature that improves data path performance. Use [VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) for moderate data volumes, infrequent data transfer, or when public internet access is required. It’s simpler to set up and more cost effective for smaller datasets compared to ExpressRoute. For more information, see [Connect an on-premises network to Azure](/azure/architecture/reference-architectures/hybrid-networking/).

- **Prepare domain name resolution services.** Use private endpoints to protect AI workloads by assigning them private IP addresses for communication. [Integrate private endpoints with DNS](/azure/private-link/private-endpoint-dns-integration) for proper DNS resolution and successful private endpoint functionality. Deploy Azure DNS infrastructure as part of your [Azure landing zone](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) and [configure conditional forwarders](/azure/private-link/private-endpoint-dns) from existing DNS services for the appropriate zones. For more information, see [Private Link and DNS integration at scale for Azure landing zones](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale).

## Implementation options

To choose the right approach for the foundation of AI workloads, you need to set up the core infrastructure and understand the separation of responsibilities and considerations that you need for an AI-focused Azure landing zone.

### Deploy a foundation with an Azure landing zone

An Azure landing zone provides a starting point to prepare your Azure environment. Deploy AI workload resources, such as Azure AI Studio, Machine Learning, AI services, Virtual Machines, and supporting resources to an application landing zone. For more information, see *Figure 2: Landing zone A2 subscription*. You can use various implementations for an Azure landing zone. Make sure to apply the policies that are relevant to your AI deployment when you use the Azure landing zone accelerator.

:::image type="content" source="./images/alz-ai.svg" alt-text="Diagram that shows AI workloads within an Azure landing zone." lightbox="./images/alz-ai.svg" border="false":::
*Figure 2. Diagram that shows AI applications in the context of an Azure landing zone.*

### Deploy a custom environment

If you have an existing Azure environment or don't want to start with an Azure landing zone, use the guidance in this article to create a custom environment for your AI workloads.

## Next steps

The following guidance focuses on building AI workloads in Azure by using PaaS and infrastructure as a service (IaaS) solutions.

> [!div class="nextstepaction"]
> [Adopt AI with Azure PaaS](adopt-paas.md)
> [!div class="nextstepaction"]
> [Adopt AI with Azure IaaS](adopt-iaas.md)
