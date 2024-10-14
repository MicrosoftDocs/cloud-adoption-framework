---
title: AI Ready – Recommendations to prepare an AI foundation
description: Optimize your AI foundation with Azure's best practices for region selection, governance, networking, and connectivity.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Ready – Recommendations to prepare an AI foundation

:::image type="content" source="./images/aiready.svg" alt-text="Diagram showing the AI adoption framework process. It highlights AI Ready. The process with AI Strategy, AI Plan, AI Ready as sequential steps. Then Secure AI, Govern AI, and Manage AI are cyclical processes after AI Ready. Undergirding the entire process is Responsible AI." lightbox="./images/aiready.svg" border="false":::
*Figure 1. AI Ready in the AI adoption process.*

This article provides recommendations for making key design and process decisions for adopting AI workloads at scale. It assumes as a prerequisite familiarity with [CAF Ready](/azure/cloud-adoption-framework/ready/) and [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/). It focuses on AI-specific guidance for region selection, resource organization, and networking. The following diagram illustrates a scalable, baseline environment for your AI workloads.

:::image type="content" source="./images/ai-resource-hierarchy.svg" alt-text="Diagram showing the resource organization for internal and internet-facing AI workloads." lightbox="./images/ai-resource-hierarchy.svg" border="false":::
*Figure 1. Scalable pattern for AI workloads.*

## Prepare AI reliability

Select the right region or regions to host your AI models. It affects the performance, compliance, cost, and availability of your AI services:

- *Use multiple regions to host AI model endpoints.* For production workloads, host AI endpoints in at least two regions to provide redundancy and ensure high availability. Although generative AI models are stateless, hosting them in multiple regions enables faster failover and recovery during regional failures. For Azure OpenAI models (GPTs), you can use [global deployments](/azure/ai-services/openai/how-to/deployment-types#deployment-types), which is multi-region and can automatically and transparently route the request to a region with enough capacity. If you opt for a nonglobal deployment (regional), use [Azure API Management](/azure/api-management/genai-gateway-capabilities#backend-load-balancer-and-circuit-breaker) for load balancing API requests to AI endpoints.

- *Confirm service availability.* Before deployment, ensure the necessary AI services [availability in the region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/#products-by-region_tab5) you selected. Some regions might not offer specific AI services or might have limited features, which can affect the functionality and scalability of your solution. For example, Azure OpenAI service availability can differ depending on the deployment model: Global Standard, Global Provisioned, (Regional) Standard, (Regional) Provisioned. Verify the AI service to ensure you have access to the resources you need.

- *Evaluate region quota and capacity.* As your AI workloads grow, consider the quota or subscription limits in your chosen region. Azure services have regional subscription limits, and these limits could affect large-scale AI model deployments, such as large inference workloads. Proactively reach out to Azure support if you anticipate needing extra capacity to avoid disruptions.

- *Evaluate performance.* Additionally, when building applications that need to retrieve data, such as a RAG applications, consider where you store your data to optimize performance. While data colocation with models in RAG apps isn't required, it can improve performance by reducing latency and ensuring efficient data retrieval.

- *Prepare for continuity of operations.* To ensure Business Continuity and Disaster Recovery (BCDR), replicate critical assets such as fine-tuned models, RAG data, trained models, and training datasets in a secondary region. This redundancy enables faster recovery if there's an outage and ensures continued service availability.

## Prepare AI governance

In Azure, resource organization is how you structure management groups and subscriptions to organize your Azure resources. Resource organization is critical for AI governance across AI workloads and cost management.

- *Separate internet facing and internal AI workloads*. At a minimum, use management groups to separate AI workloads into internet-facing ("online") and internal only ("corporate"). The distinction provides an important data governance boundary. It helps you keep internal separate from public data. You don't want external users to access sensitive business information required for internal work. This distinction between internet-facing and internal workloads aligns with [Azure landing zone management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

- *Apply AI policies to each management group.* Start with baseline policies for each workload type, such as those articulated by [Azure landing zone policies](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies). Add more Azure Policy definitions to your baseline to drive uniform governance for [Azure AI services](/azure/ai-services/policy-reference), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search), [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies#machine-learning), [Azure Virtual Machines](/azure/virtual-machines/policy-reference) and others.

- *Deploy AI resources in workload subscriptions.* AI resources need to inherit workload governance policies from the workload management group (internal or internet-facing). Keep them separate from platform resources. AI resources controlled by platform teams tend to create development bottlenecks. In the context of Azure landing zone, deploy AI platforms to application landing zone subscriptions.

## Prepare AI networking

This guidance provides recommendations for setting up your network topology for AI workloads. Organizations with multiple intelligent applications should use a hub and spoke network topology. If you have a single intelligent application, hub and spoke topology is where you should head when you have more workloads.

- *Connect to on-premises data.* For organizations transferring large amounts of data from on-premises sources to cloud environments, use a high-bandwidth connection. Azure [ExpressRoute](/azure/expressroute/expressroute-introduction) is ideal for high data volumes, real-time processing, or workloads that require consistent performance. It has [FastPath](/azure/expressroute/about-fastpath) feature that improves data path performance. Use [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) for moderate data volumes, infrequent data transfer, or when public internet access is required. It’s simpler to set up and cost-effective for smaller datasets than ExpressRoute. For more information, see [Connect an on-premises network to Azure](/azure/architecture/reference-architectures/hybrid-networking/).

- *Prepare domain name resolution services.* Use private endpoints to protect AI workloads by assigning them private IP addresses for communication. [Integrate private endpoints with DNS](/azure/private-link/private-endpoint-dns-integration) for proper DNS resolution and successful private endpoint functionality. Deploy Azure DNS infrastructure as part of your [Azure landing zone](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) and [configure conditional forwarders](/azure/private-link/private-endpoint-dns) from existing DNS services for the appropriate zones. For more information,see, [Private Link and DNS integration at scale for Azure landing zones](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale).

- *Segment virtual networks.* Apply network segmentation to control traffic flow and reduce the risk of lateral movement in case of a breach. Microsegmentation can provide even finer control at the workload or application level within Azure Virtual Networks (VNets).

- *Configure network access controls.* Utilize Network Security Groups (NSGs) and Azure Firewall to define and apply access policies that govern inbound and outbound traffic to and from AI workloads. These controls can be used to implement the principle of least privilege, ensuring that only essential communication is permitted.

- *Use network monitoring services.* Use services such as Azure Monitor Network Insights and Azure Network Watcher to gain visibility into network performance and health. Additionally, use Azure Sentinel for advanced threat detection and response across your Azure network.

## Implementation options

Choosing the right approach for the foundation of AI workloads involves not only setting up the core infrastructure but also understanding the separation of responsibilities and considerations necessary for an AI-focused Azure landing zone.

### Deploy a foundation with Azure landing zone

Azure landing zone provides a starting point for preparing your Azure environment. Deploy AI workload resources such as Azure AI Studio, Azure Machine Learning, Azure AI services, Azure Virtual Machines, and supporting resources to an new application landing zone (*see figure 2: "Landing zone A2 subscription"*). You can use the various implementations for Azure Landing Zone. Ensure to apply the policies relevant to your AI deployment as you're using the Azure Landing Zone accelerator.

:::image type="content" source="./images/alz-ai.svg" alt-text="Diagram showing AI workloads within an Azure landing zone." lightbox="./images/alz-ai.svg" border="false":::
*Figure 2. AI applications in the context of an Azure landing zone.*

### Deploy a custom environment

You can use the guidance discussed in this article to establish a foundational environment for your AI workloads.

## Next steps

The rest of the guidance focuses on building AI workloads in Azure using PaaS and IaaS solutions.

> [!div class="nextstepaction"]
> [PaaS AI workloads](./platform/resource-selection.md)

> [!div class="nextstepaction"]
> [IaaS AI workloads](./infrastructure/compute.md)
