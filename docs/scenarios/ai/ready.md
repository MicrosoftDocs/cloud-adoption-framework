---
title: AI Ready
description: Learn the process to build AI workloads in Azure with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# AI Ready

This article outlines the organizational process for building AI workloads in Azure. The article provides recommendations for making key design and process decisions for adopting AI workloads at scale. It focuses on AI-specific guidance for resource organization and connectivity.

## Establish governance boundaries for AI workloads

AI governance requires proper resource organization and policy management to ensure secure, compliant, and cost-effective operations. You must create clear governance boundaries to protect sensitive data and control AI resource access effectively. Here's how:

1. **Create separate management groups for internet-facing and internal AI workloads.** Management group separation establishes critical data governance boundaries between external ("online") and internal-only ("corporate") AI applications. This separation prevents external users from accessing sensitive internal business data while you maintain appropriate access controls. The approach aligns with [Azure landing zone management group](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) architecture principles and supports policy inheritance across workload types.

2. **Apply AI-specific policies to each management group.** Start with baseline policies from [Azure landing zones](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies) and add Azure Policy definitions for [Azure AI Foundry](/azure/ai-foundry/how-to/built-in-policy-model-deployment), [Azure AI services](/azure/ai-services/policy-reference), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search), and [Azure Virtual Machines](/azure/virtual-machines/policy-reference). Policy enforcement ensures uniform AI governance across your platform and reduces manual compliance oversight.

3. **Deploy AI resources within workload-specific subscriptions.** AI resources must inherit governance policies from their workload management group rather than platform subscriptions. This separation prevents development bottlenecks that platform team controls create and enables workload teams to operate with appropriate autonomy. Deploy AI workloads to application landing zone subscriptions in Azure landing zone environments.

## Establish secure connectivity for AI workloads

AI networking encompasses network infrastructure design, security measures, and efficient data transfer patterns for AI workloads. You must implement proper security controls and connectivity options to prevent network-based disruptions and maintain consistent performance. Here's how:

1. **Activate Azure DDoS Protection for internet-facing AI workloads.** [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) safeguards your AI services from potential disruptions and downtime that distributed denial of service attacks cause. DDoS protection at the virtual network level defends against traffic floods that target internet-facing applications and maintains service availability during attacks.

2. **Secure operational access to AI workloads with Azure Bastion.** Use a jumpbox and Azure Bastion to secure operational access to AI workloads and prevent direct internet exposure of management interfaces. This approach creates a secure gateway for administrative tasks while maintaining network isolation for AI resources.

3. **Choose appropriate connectivity for on-premises data sources.** Organizations that transfer large amounts of data from on-premises sources to cloud environments need high-bandwidth connections to support AI workload performance requirements.

   - **Use Azure ExpressRoute for high-volume data transfer.** [Azure ExpressRoute](/azure/expressroute/expressroute-introduction) provides dedicated connectivity for high data volumes, real-time processing, or workloads that require consistent performance. ExpressRoute includes a [FastPath](/azure/expressroute/about-fastpath) feature that improves data path performance by bypassing the ExpressRoute gateway for specific traffic flows.

   - **Use Azure VPN Gateway for moderate data transfer.** [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) works well for moderate data volumes, infrequent data transfer, or when public internet access is required. VPN Gateway offers simpler setup and cost-effective operation for smaller datasets compared to ExpressRoute. Use the appropriate [topology and design](/azure/vpn-gateway/design) for your AI workloads, including site-to-site VPN for cross-premises connectivity and point-to-site VPN for secure device access.

## Establish AI reliability across regions

AI reliability requires strategic region placement and redundancy planning to ensure consistent performance and high availability. Organizations must address model hosting, data locality, and disaster recovery to maintain reliable AI services. You need to plan your regional deployment strategy to avoid service interruptions and optimize performance. Here's how:

1. **Deploy AI endpoints across multiple regions for production workloads.** Production AI workloads require hosting in at least two regions to provide redundancy and ensure high availability. Multi-region deployments enable faster failover and recovery during regional failures. For Azure OpenAI in Azure AI Foundry, use [global deployments](/azure/ai-services/openai/how-to/deployment-types#deployment-types) that automatically route requests to regions with available capacity. For regional deployments, implement [Azure API Management](/azure/api-management/genai-gateway-capabilities#backend-load-balancer-and-circuit-breaker) to load balance API requests across AI endpoints.

2. **Verify AI service availability in target regions before deployment.** Different regions provide varying levels of AI service availability and feature support. Check [Azure service availability by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/#products-by-region_tab5) to confirm your required AI services are available. Azure OpenAI deployment models include global standard, global provisioned, regional standard, and regional provisioned options with different regional availability patterns.

3. **Evaluate regional quota limits and capacity requirements.** Azure AI services have regional subscription limits that affect large-scale model deployments and inference workloads. Contact Azure support proactively when you anticipate capacity needs that exceed standard quotas to prevent service disruptions during scaling.

4. **Optimize data placement for retrieval-augmented generation applications.** Data storage location significantly affects application performance in RAG scenarios. Co-locating data with AI models in the same region reduces latency and improves data retrieval efficiency, though cross-region configurations remain viable for specific business requirements.

5. **Replicate critical AI assets to secondary regions for business continuity.** Business continuity requires replicating fine-tuned models, RAG datasets, trained models, and training data to secondary regions. Asset replication enables faster recovery during outages and maintains service availability across different failure scenarios.

## Establish an AI foundation

An AI foundation provides the core infrastructure and resource hierarchy that support AI workloads in Azure. It includes setting up scalable, secure environments that align with governance and operational needs. A strong AI foundation enables efficient deployment and management of AI workloads. It also ensures security and flexibility for future growth.

### Use an Azure landing zone

An [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) is the recommended starting point that prepares your Azure environment. It provides a predefined setup for platform and application resources. Once the platform is in place, you can deploy AI workloads to dedicated application landing zones.

If your organization uses Azure landing zones for workloads, then continue to use them for workloads that use AI. You deploy your AI workloads to dedicated application landing zones. Figure 2 below illustrates how AI workloads integrate within an Azure landing zone.

:::image type="content" source="./images/azure-landing-zone-ai.svg" alt-text="Diagram showing AI workloads within an Azure landing zone." lightbox="./images/azure-landing-zone-ai.svg" border="false":::
*Figure 2. AI workload in an Azure landing zone.*

### Build an AI environment

If you don't use an Azure landing zone, follow the recommendations in this article to build your AI environment. The following diagram shows a baseline resource hierarchy. It segments internal AI workloads and internet-facing AI workloads. Internal workloads use policy to deny online access from customers. This separation safeguards internal data from exposure to external users. AI development should use a jumpbox to manage AI resources and data.

:::image type="content" source="./images/baseline-resource-hierarchy.svg" alt-text="Diagram showing the resource organization for internal and internet-facing AI workloads." lightbox="./images/baseline-resource-hierarchy.svg" border="false":::
*Figure 3. Baseline resource hierarchy for AI workloads.*

## Next steps

The next step is to build and deploy AI workloads to your AI environment. Use the following links to find the architecture guidance that meets your needs. Start with platform-as-a-service (PaaS) architectures. PaaS is Microsoft's recommended approach to adopting AI.

> [!div class="nextstepaction"]
> [PaaS AI architecture guidance](./platform/architectures.md)

> [!div class="nextstepaction"]
> [IaaS AI architecture guidance](./infrastructure/cycle-cloud.md)
