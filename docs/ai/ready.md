---
title: Architecture and governance for AI
description: Learn how to integrate AI into your Azure landing zone architecture
author: stephen-sumner
ms.author: ssumner
ms.date: 10/14/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Architecture and governance for AI

*This article explains how AI workloads fit into your Azure landing zone and enterprise architecture. It identifies the additional platform capabilities that organizations should consider as AI adoption scales.* 

:::image type="content" source="./images/ai-adoption-process.svg" alt-text="Diagram that shows the phases of AI adoption: Plan, Ready, Govern, Secure, Manage." lightbox="./images/ai-adoption-process.svg" border="false":::

Apply the same Azure landing zone principles and best practices to AI workloads as you do to other workloads. AI workloads don't require a different Azure landing zone architecture or governance model. Platform teams should use their existing governance baseline and extend it where needed to account for the AI services and models that the organization plans to use.

**Outcome**: By the end of architecture and governance planning, you should have an updated governance baseline that supports the AI technologies you plan to use in Azure.

<a name='Establish-an-AI-foundation'></a>
<a name='AI-foundation'></a>
<a name='AI-in-an-Azure-landing-zone'></a>

## Architectures and decision tree

# [Conceptual](#tab/conceptual)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" alt-text="Diagram showing a conceptual view of an Azure landing zone." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*AI in an Azure landing zone. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Conceptual + integration](#tab/conceptualintegration)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" alt-text="Diagram showing a conceptual Azure landing zone architecture and how it integrates with your Microsoft enterprise architecture." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads. Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*AI in an Azure landing zone plus enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Detailed](#tab/detailed)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-detailed-architecture.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone." lightbox="../ready/landing-zone/media/azure-landing-zone-detailed-architecture.svg" border="false":::
    A top section labeled "Unified identity, security, and governance across Azure, Microsoft, multicloud, and on-premises environments" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains the platform landing zone and multiple workload landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of workload landing zones to workload teams. The Workload landing zones section shows how workloads are organized under the Azure landing zone architecture. Workloads are grouped into Internal, Online, and Local categories. Each workload receives a dedicated workload landing zone that contains all environments associated with that workload. Typical environments include development, test, and production, with each environment consisting of one or more Azure subscriptions. Internal workload examples include a Microsoft Fabric compute landing zone and a data and AI workload landing zone that uses services such as Azure Machine Learning, Azure Databricks, AI on Azure Infrastructure, and Azure Data Lake Storage. The diagram also shows that Microsoft Foundry resources can be added to workload environments where AI capabilities are required. Workload teams manage the workload landing zones, which remain separate from the platform landing zone managed by platform teams.
:::image-end:::

*AI in a detailed conceptual Azure landing zone architecture. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Detailed + integration](#tab/detailedintegration)

:::image type="complex" border="false" source="../ready/landing-zone/media/azure-landing-zone-detailed-architecture-enterprise-integration.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone and how it integrates with your Microsoft enterprise architecture." lightbox="../ready/landing-zone/media/azure-landing-zone-detailed-architecture-enterprise-integration.svg":::
    Detailed Azure landing zone architecture diagram. A top layer labeled "Unified identity, security, and governance" spans the environment and includes Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, the Azure landing zone is divided into a platform landing zone and workload landing zones. The platform landing zone contains a tenant root group with a management group hierarchy. Management groups organize centralized platform resources for security, management, identity, and connectivity. Azure Policy and Azure RBAC are applied across the hierarchy. Workload landing zones are grouped into Internal, Online, and Local categories, with separate management groups for sandbox and decommissioned resources. The workload landing zones section shows example workloads. Each workload has a dedicated workload landing zone that contains production, test, and development environments. Example internal workloads include Microsoft Fabric compute and a data and AI workload. Microsoft Foundry connects to workload landing zones, indicating that AI capabilities can be added to selected workload environments. Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*AI in a detailed conceptual Azure landing zone architecture plus enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [AI decision tree](#tab/decisiontree)

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying the AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot for Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for roles such as security, sales, service, or finance. If the use case is general, use Microsoft Copilot. If you already use Microsoft 365 Copilot and need custom agents with domain-specific skills, use extensibility tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio as a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Foundry as a development platform with API access to Foundry Tools. If you need prebuilt non-generative models or Azure AI Search for agent support, use Foundry Tools. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure (regional availability and feature status varies; verify current serverless GPU support). If you need to bring your own models, use Azure Virtual Machines (optionally with Azure CycleCloud or Azure Batch) or Azure Kubernetes Service for containerized workloads.
:::image-end:::

*Microsoft AI decision tree.*

---

<a name='Establish-AI-governance'></a>
<a name='AI-governance'></a>

## Platform landing zone

AI adoption should build on the existing Azure landing zone rather than introduce a separate platform structure. AI workloads use the same management group hierarchy and platform capabilities as other Azure workloads. Organizations generally don't need AI-specific management groups. Instead, platform teams should extend existing governance and connectivity capabilities to address the Azure services that AI workloads use.

**Governance baseline**: The existing Azure landing zone governance baseline should remain the starting point for AI workloads. Platform teams should extend that baseline when AI services introduce requirements that existing policies don't address.

- **Azure Policy**: Organizations should start with the baseline policies from the [platform landing zone accelerator](https://aka.ms/alz/policies). Platform teams should then add Azure Policy definitions for the AI services that the organization approves, such as [Microsoft Foundry models](/azure/foundry/how-to/model-deployment-policy?tabs=cli), [Foundry Tools](/azure/ai-services/policy-reference?context=/azure/foundry/context/context), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search), and [Azure Virtual Machines](/azure/virtual-machines/policy-reference). Applying these policies through the existing management group hierarchy gives AI workloads consistent guardrails without requiring a separate governance model. Microsoft guidance supports applying the AI-specific policies through the landing-zone management group hierarchy so workload resources inherit them.

<a name='Establish-AI-networking'></a>

- **Networking**: Existing Azure landing zone networking patterns should also remain the foundation for AI workloads. Platform teams should extend shared connectivity and network protection where AI workloads create additional requirements, particularly for internet-facing services or access to on-premises data.
   
   - **DDoS Protection**: Internet-facing AI workloads should use [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview). The platform team can provide this protection as part of the organization's shared networking capabilities rather than requiring individual workload teams to establish their own platform-level approach.

   - **Hybrid connectivity**: Organizations that access on-premises data from Azure AI workloads should choose connectivity based on their performance and availability requirements. [Azure ExpressRoute](/azure/expressroute/expressroute-introduction) provides private connectivity and is appropriate when organizations require predictable connectivity to Azure. [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) provides encrypted connectivity over the public internet and can suit less demanding connectivity requirements. Existing Azure landing zone guidance also supports VPN Gateway and ExpressRoute as hybrid connectivity patterns.

## Workload landing zones

AI workloads use the same workload landing zone principles as other Azure workloads. Each workload should have its own workload landing zone and use one or more Azure subscriptions to separate environments based on the organization's governance and isolation requirements. Azure subscriptions provide boundaries for areas such as quota, cost, governance, and security. 

The platform team should place Workload landing zone subscriptions for AI workloads under the existing management group that provides the appropriate governance controls. Internet-facing AI workloads generally belong under the online management group. Internal AI workloads generally belong under the internal ("Corp") management group. Platform teams should use these existing boundaries instead of creating management groups specifically for AI. Azure Policy assignments at the management group level then provide consistent platform guardrails across AI and other workloads.

<a name='Establish-AI-reliability'></a>
<a name='AI-reliability'></a>

### Reliability

AI workloads should use the organization's existing availability and disaster recovery standards. Platform teams should prepare the Azure landing zone to support multiple regions so workload teams can deploy AI workloads across regions when their business continuity requirements justify the added cost and complexity. Azure landing zone region guidance specifically recommends designing the platform so it can support multiregion workload landing zones. 

- **Data location**: Data location should also be part of the regional design. Workload teams should place retrieval data near the AI services that consume it when latency and performance are important. Regional placement must also meet the organization's data residency requirements.

- **Availability and capacity**: AI introduces additional regional considerations because service availability, model availability, and capacity can vary by Azure region. Organizations should identify the regions that support their approved AI services and models before making those regions available for AI workloads.

- **Failover**: Workload teams that require regional failover should also account for AI assets that the workload depends on, such as model deployments and retrieval data. The recovery design should ensure that the secondary region has the resources and data necessary to restore the workload.

### Enterprise integration

AI workloads should integrate with enterprise platforms through the same architecture principles as other workloads. The primary AI-specific consideration is access to trusted organizational data.

Organizations should establish a unified approach to data that makes governed data available to AI workloads without requiring every workload team to build separate data integration patterns. Microsoft Fabric can prepare and provide organizational data for analytics and AI scenarios. Azure AI workloads can then consume the appropriate data through approved integration patterns. For guidance on establishing this foundation, see [Unified data platform](/azure/cloud-adoption-framework/data/executive-strategy-unify-data-platform?tabs=conceptual).

## Next steps

The architecture and governance considerations for a workload landing zone depend on the AI platforms and technologies that the workload uses. The following guidance provides deeper architecture recommendations for different AI adoption patterns.

> [!div class="nextstepaction"]
> [AI on Azure platforms](../scenarios/ai/platform/architectures.md)

> [!div class="nextstepaction"]
> [AI on Azure infrastructure](/azure/cloud-adoption-framework/ai/infrastructure/ai-azure-infrastructure)
