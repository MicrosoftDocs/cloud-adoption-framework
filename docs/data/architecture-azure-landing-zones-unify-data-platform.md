---
title: Azure Architecture for a Unified Data Platform
description: "Azure Architecture: Discover how to design your Azure environments for a unified data platform with Microsoft Fabric and Microsoft Purview."
#customer intent: As a technical decision maker (enterprise architect, CTO, VP, director), I want to make the right technology adoption decisions and design them to integrate into my existing systems, creating a unified data platform with Microsoft Fabric, Microsoft Purview, and Azure so that my organization can standardize data value for analytics and AI consumption.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 09/16/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
ai-usage: ai-assisted
---

# Azure architecture for a unified data platform

*This article helps decision makers determine how Microsoft Fabric, Microsoft Purview, and Azure workloads should integrate within their Azure landing zone to create a unified data platform for analytics and AI.*

A unified data platform connects the systems that produce data with the services that govern and consume it. This article focuses on the architectural decisions required to integrate Azure workloads, Microsoft Fabric, and Microsoft Purview into a unified data platform.

**Outcome**: You have decided how Azure workloads, Microsoft Fabric, and Microsoft Purview integrate to create a unified data platform.

## Architectures and decision tree

# [Conceptual](#tab/conceptual)

:::image type="content" source="./images/executive-architecture-unified-data-platform-ai-analytics.svg" alt-text="High‑level diagram showing Microsoft Fabric at the center of a unified data platform. Data from enterprise sources, such as on‑premises systems, Microsoft services, and public cloud platforms, flows into Fabric, where you organize it as shared data products. These data products are then used across the organization to support analytics, AI systems, and reporting, including Power BI and data science workloads. Fabric connects with Azure for governance, security, and monitoring, while Azure workloads run alongside it as needed. The overall flow shows data coming into Fabric, being governed and standardized, and then powering AI, analytics, and business insights across the organization." lightbox="./images/executive-architecture-unified-data-platform-ai-analytics.svg" border="false":::

*Conceptual architecture of a unified data platform for AI and analytics.*

# [Detailed](#tab/unified)

:::image type="content" source="./images/unified-data-platform-architecture-ai-analytics.svg" alt-text="Diagram showing a unified data platform architecture across Microsoft systems. Data from multiple sources is organized into data domains. They're governed in Microsoft Purview. They're ingested into Fabric OneLake and produced as data products using Fabric and Databricks. Microsoft Copilot, Foundry agents, Power BI, and data science tools consume them." lightbox="./images/unified-data-platform-architecture-ai-analytics.svg" border="false":::

*Detailed conceptual architecture of a unified data platform for AI and analytics.*

# [Decision tree](#tab/decision-tree)

:::image type="complex" source="images/decision-tree-unify-data-platform.svg" alt-text="Diagram showing a decision tree for unifying your data platform for leaders and decision makers." lightbox="images/decision-tree-unify-data-platform.svg" border="false":::
    The flow asks a series of yes-or-no questions. Each "Yes" leads to specific guidance. The first question asks whether the organization needs help with understanding data priorities or building skills to get more value from data. If yes, the guidance is to prepare people through roles, training, and readiness activities. The second question asks whether the organization needs a unified way to access data across clouds and workloads to support analytics and AI. If yes, the guidance is to use Microsoft Fabric as the unified data platform. The third question asks whether the organization needs help with turning operational data into business value or securely feeding data into AI systems, such as Microsoft Foundry. If yes, the guidance is to integrate Azure services with Fabric. Fourth question asks whether the organization needs help with controlling access to data or with securing data consistently. If yes, the guidance is to set governance and security baselines using Microsoft Purview and related controls. Fifth question asks whether the organization needs help with setting consistent organizational standards to process, secure, and consume data products for analytics and AI. If yes, the guidance is to set operational standards for data products, security, and lifecycle management. The flow ends by pointing to adopting AI and adopting AI agents once the unified data platform and standards are in place.
:::image-end:::

*Microsoft's decision tree to guide your unified data platform.*

---

## 1. Platform landing zone updates

A unified data platform usually requires governance updates, not changes to your Azure landing zone architecture. Review the Azure Policy definitions for each service and apply the policies that align with your governance requirements. Assign policies at the appropriate management group or subscription under the Workload Landing Zone management group.

- [Azure Databricks](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#azure-databricks)
- [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#machine-learning)
- [Azure Data Lake Storage](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#data-lake)
- [Virtual machines (Compute)](/azure/virtual-machines/policy-reference)
- [Allowed locations](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#general)

## 2. Workload landing zones

Workload landing zones host the services that support your unified data platform. These services inherit the governance, security, networking, and operational controls established through your platform landing zone design.

Most resources used to create, govern, and manage data products should be deployed in workload landing zones under the Internal management group. This placement typically includes Microsoft Fabric capacity, Microsoft Purview, Azure Databricks, Azure Machine Learning, Azure Data Lake Storage, and shared AI infrastructure.

Workloads that consume governed data products can be deployed in Internal, Online, or Local workload landing zones. These workloads should use approved access patterns and apply appropriate controls to protect source data and maintain governance requirements.

This section provides guidance on where to place key Microsoft and Azure services and how they integrate with Microsoft Fabric as part of a unified data platform.

| Service                                       | Typical management group placement                                |
| --------------------------------------------- | ------------------------------------------------ |
| Microsoft Purview                             | Internal workload landing zone                   |
| Microsoft Fabric capacity                     | Internal workload landing zone                   |
| Azure workload (consuming data product or AI) | Internal, Online, or Local workload landing zone |
| Azure databases                               | Internal, Online, or Local workload landing zone |
| Azure Databricks                              | Internal workload landing zone                   |
| Azure Machine Learning                        | Internal workload landing zone                   |
| Azure Data Lake Storage                       | Internal workload landing zone                   |
| AI infrastructure (training/GPUs)             | Internal workload landing zone                   |


### 2.1 Microsoft Fabric capacity

*Management group placement: Internal.* [Microsoft Fabric capacity](/fabric/enterprise/licenses#capacity) provides the shared compute that powers analytics, reporting, data engineering, and AI workloads in Microsoft Fabric. Deploy Fabric capacity within workload landing zones under the Internal management group so capacity inherits organizational governance, security, and operational controls.

The primary decision is how to allocate Fabric capacity across data domains. Capacity ownership should align with organizational maturity, operational accountability, and demand predictability.

- **Option 1: Isolated Fabric capacities.** You assign dedicated Fabric capacity to individual data domains. Each domain manages its own capacity, scaling decisions, and budget accountability. Use this model when data domains have mature operating practices, predictable demand, and clear ownership. **Trade-off:** Dedicated capacities provide greater control and isolation but can increase cost and operational overhead. Smaller capacities might also limit access to some Power BI features.

- **Option 2: Shared Fabric capacities.** You can manage one or more shared Fabric capacities through a central platform team. Multiple data domains use the same capacity, with the central team responsible for monitoring, scaling, and governance. Use this model when data domains are still developing operational maturity or when demand varies significantly across domains. **Trade-off:** Shared capacities improve utilization and simplify operations but can reduce cost transparency and increase the risk of resource contention.

- **Option 3: Hybrid model.** A hybrid approach keeps smaller or new data domains on shared capacity while assigning dedicated capacity to domains with sustained demand or higher criticality. You combine shared and dedicated capacity models. Define clear thresholds for capacity graduation. Base thresholds on sustained usage, uptime requirements, or isolation needs. Apply consistent governance across both models.
**Trade-off:** Accept added governance complexity as the tradeoff for flexibility and long-term scalability.

For more information, see [Deployment Patterns for Microsoft Fabric](/azure/architecture/analytics/architecture/fabric-deployment-patterns).

### 2.2 Microsoft Purview account

*Management group placement: Internal.* Microsoft Purview provides organization-wide data governance, catalog, lineage, and data discovery capabilities. Deploy a single Microsoft Purview account for each Microsoft Entra ID tenant. The modern Microsoft Purview experience is designed as a single organization-wide governance service that provides a unified catalog and consistent governance across Microsoft Fabric, Azure resources, Microsoft 365, and connected data sources. 

Deploy the Microsoft Purview resource in a workload landing zone under the Internal management group. During deployment, validate the account region and any related regulatory requirements. Microsoft Purview governance remains organization-wide even when data resides in multiple regions because Microsoft Purview processes data locally to connected sources and doesn't move source data into the Microsoft Purview account region. See [Microsoft Purview FAQs](/purview/data-governance-purview-portal-faq).

### 2.3 Azure workloads and Fabric

**Management group placement: Internal, Online, Local.* Azure workloads can integrate with a unified data platform by either producing data for Microsoft Fabric or consuming governed data products from Fabric. The workload landing zone placement depends on the workload's purpose and business requirements, not on its integration with Fabric.

- Workloads that create, transform, or manage shared data products typically reside in workload landing zones under the Internal management group.
- Workloads that consume governed data products can reside in Internal, Online, or Local workload landing zones.

Regardless of placement, all workloads should use approved interfaces that protect source data, maintain governance requirements, and provide consistent access to business information. The primary decision is how workloads exchange data and knowledge with Fabric.

#### 2.3.1 Consuming data from Fabric

*How Azure workloads consume data products from Fabric?* Azure workloads consume Fabric data through interfaces that support their architecture requirements. The primary decision is whether the consumer is an agent or AI model in Microsoft Foundry, or another Azure workload that needs direct access to Fabric data.

- **Microsoft Foundry**: Agents and AI models in Microsoft Foundry can use Fabric data for grounding and reasoning. Select an integration option based on the type of context and retrieval capability that the solution requires.

    - [Foundry IQ](/azure/foundry/agents/concepts/what-is-foundry-iq): Use Foundry IQ when you want a managed knowledge-base experience that multiple agents can share. Foundry IQ configures Azure AI Search indexing and retrieval for supported knowledge sources such as OneLake.

    - Azure AI Search:  Use Azure AI Search directly when the solution requires control of the search index, enrichment pipeline, ranking strategy, retrieval configuration, or application-specific search experiences. Populate the index from Fabric by using a [knowledge source](/fabric/onelake/onelake-foundry-knowledge) or a [Fabric data pipeline](/fabric/data-factory/connector-azure-search-copy-activity), then use the index to ground the agent. 

- **Other Azure workloads**: Azure workloads can consume Fabric data products through interfaces and services that align with workload requirements. Common consumers include: 

    - Custom applications that use data products to support business processes.
    - Analytics solutions that consume curated business data.
    - Azure Databricks workloads that process governed datasets.
    - Machine learning workloads that use data products for training or inference.
    - Reporting solutions that consume certified business data.

Azure workloads can access Fabric data products through capabilities such as [SQL analytics endpoint](/fabric/database/sql/sql-analytics-endpoint), OneLake access, [OneLake APIs](/fabric/onelake/onelake-access-api), and other integration mechanisms that align to workload requirements.

#### 2.3.2 Producing data for Fabric

*How should Azure workloads produce data for Fabric?* Many workload landing zones contain operational systems that generate valuable business data. These systems should remain optimized for transactional processing and operational requirements. Rather than running analytics directly against operational systems, publish selected data into Fabric and OneLake.

- **Azure databases.** Operational databases often contain the most current business information but aren't designed to support large-scale analytics or AI workloads. Use Fabric [mirroring](/fabric/mirroring/overview) to replicate selected operational data into OneLake in near real time. This approach preserves application performance and operational independence while making current data available for enterprise analytics and AI.

- **SAP and Oracle.** SAP and Oracle systems often serve as authoritative business systems with strict uptime, governance, or change-control requirements. Integrate SAP and Oracle data into Fabric by using mirroring for [SAP](/fabric/mirroring/sap) and [Oracle](/fabric/mirroring/oracle). This approach creates a consistent ingestion path into OneLake without requiring significant changes to existing enterprise workloads.

### 2.4 Azure data and AI/ML workloads

*What if I develop data producs in Azure, not Fabric?* Azure data and AI/ML workloads are workloads designed to create data products in Azure. These workloads typically run Azure Databricks, Azure Machine Learning, and Azure infrastructure. Deploy these Azure services to workload landing zones under the Internal management group.

#### 2.4.1 Workload landing zone boundaries

*How many workload landing zones should a data domain have?* A workload landing zone should align to ownership, governance, and permission boundaries. A single workload landing zone can support one or more data products and one or more subscriptions. Create additional workload landing zones only when ownership, security, compliance, or operational requirements require a separate boundary.

#### 2.4.2 Data product placement

*When should a data product have its own workload landing zone?* Most data products don't require a dedicated workload landing zone. Multiple data products can share the same workload landing zone when they operate under the same ownership, governance, and operational model. Create a separate workload landing zone only when business or regulatory requirements justify a distinct boundary.
 
#### 2.4.3 Azure services placement

*Do we need to isolate different Azure platforms?* Place Azure services according to ownership and governance boundaries, not technology boundaries. Azure Databricks, Azure Machine Learning, Azure Data Lake Storage, AI infrastructure, networking, monitoring, and security services can coexist in the same workload landing zone when they support the same data products and operating model. Separate services only when governance, compliance, or operational requirements justify additional boundaries.

#### 2.4.4 Fabric and Databricks integration

*Where does the authoritative copy of data reside?* Organizations that use both Microsoft Fabric and Azure Databricks should define a single authoritative copy for each dataset. This decision establishes ownership, governance responsibilities, and integration patterns. Select either OneLake or Azure Data Lake Storage as the authoritative store for a dataset and expose data through approved integration patterns rather than maintaining multiple authoritative copies.

**Option 1: OneLake as the system of record.** Azure Databricks reads and writes data directly in OneLake, not Azure Data Lake Storage Gen2. Choose this option for new data platforms or consolidation onto Fabric. **Trade-off**: Requires teams to align to Fabric operating and governance standards. See [Azure Databricks integration with OneLake](/fabric/onelake/onelake-azure-databricks).

**Option 2: Azure Data Lake Storage as the system of record.** Azure Databricks continues to use Azure Data Lake Storage Gen2. Microsoft Fabric accesses the data through OneLake shortcuts. Apply this pattern to existing Databricks estates with mature pipelines. Choose this option when speed and continuity matter more than consolidation. **Trade-off**: Requires coordination between ADLS operations and Fabric governance.Accept split ownership between ADLS operations and Fabric governance. Plan for added coordination across teams that manage storage, security, and metadata. See [Azure Data Lake Storage (ADLS) Gen2 shortcut](/fabric/onelake/create-adls-shortcut).

## Next step

> [!div class="nextstepaction"]
> [Data governance and security baselines with Purview](./governance-security-baselines-purview-data-estate-unify-data-platform.md)
