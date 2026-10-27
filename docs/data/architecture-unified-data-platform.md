---
title: Architecture for a Unified Data Platform
description: "Learn how to design Azure landing zones, Microsoft Fabric, and Microsoft Purview architecture for a unified data platform that supports analytics and AI."
#customer intent: As a decision maker, I want to design a unified data platform architecture across Azure, Microsoft Fabric, and Microsoft Purview so that my organization can govern and share data for analytics and AI.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 09/16/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
ai-usage: ai-assisted
---

# Architecture for a unified data platform

*This article helps decision makers make architecture decisions for their Azure landing zone to create a unified data platform.*

Organizations need to determine which updates their platform landing zone requires and how Azure workloads should integrate with the unified data platform. Without a clear architecture, data can remain isolated across workloads and platforms or move between them without consistent governance and security. This article provides guidance for updating the platform landing zone and architecting workload landing zones so Azure workloads can produce data for Microsoft Fabric and consume governed data from it.

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

## 1. Azure landing zone

*How should we update our Azure landing zone?* The unified data platform should use the organization’s existing Azure landing zone architecture. The organization should not create a separate Azure architecture solely for Microsoft Fabric or data workloads.

### 1.1. Platform landing zone updates

*What changes are required to the platform landing zone?* The platform landing zone should continue to provide the shared Azure capabilities used across the organization. The organization should retain its existing management group hierarchy unless a new regulatory, security, sovereignty, or operational requirement requires a different policy scope.

**Governance baseline**: The platform team should evaluate every Azure service introduced by the unified data platform against the existing policy baseline. The review should identify whether existing controls apply and whether additional controls are required. Relevant built-in policy references include:

- [Azure Databricks](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#azure-databricks)
- [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#machine-learning)
- [Azure Data Lake Storage](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#data-lake)
- [Virtual machines (Compute)](/azure/virtual-machines/policy-reference)
- [Allowed locations](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#general)

### 1.2. Workload landing zones

*What should we put in workload landing zones?* Azure resources that support the unified data platform should reside in workload landing zones unless they provide a core Azure platform capability defined by the organization's Azure landing zone architecture.

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

### 1.3 Fabric integration

*How should Azure workloads integrate with Microsoft Fabric?* Azure workloads should integrate with Microsoft Fabric through approved organization-wide patterns for making data available through OneLake and consuming governed data products. Integration with Fabric shouldn't change the workload’s placement.

The architecture should support data products created in Fabric and data products created through other approved platforms, such as Azure Databricks. The integration pattern should identify the authoritative system of record and avoid unnecessary duplication of processing or data. See [Azure Databricks integration with OneLake](/fabric/onelake/onelake-azure-databricks) and [Azure Data Lake Storage (ADLS) Gen2 shortcut](/fabric/onelake/create-adls-shortcut).

The organization should define the supported integration patterns through its [operational standards](./operational-standards-unified-data-platform.md).

## 2. Microsoft Fabric architecture

*How should the organization design Microsoft Fabric?* Microsoft Fabric should provide the shared platform through which data domains create, publish, and consume data products. The organization should establish a common Fabric architecture before data domains deploy production data products.

### 2.1 Fabric capacity deployment

*How should we deploy Fabric capacities?* Each data domain should deploy its Fabric capacities through its designated workload landing zone subscription. The data domain should manage its Fabric capacity within its approved budget and organization-wide standards.

- **Capacity requirements**: A data domain should add Fabric capacity when existing resources can't meet an approved performance, isolation, regional, or lifecycle requirement. The data domain shouldn't add Fabric capacity only to organize data products or teams.

- **Azure subscription requirements**: A data domain should only use another workload landing zone subscription when a distinct Azure governance or administrative boundary is required. Another workspace, environment, or data product doesn't by itself justify another subscription.

- **Shared Fabric capacities**: Multiple data domains can share a Fabric capacity when shared resources provide acceptable performance and better resource utilization. 
 
- **Regional deployment**: The organization should establish a default Azure region for Fabric capacity. Data domains should use that region unless an approved requirement justifies another region. Acceptable exceptions include legal residency, data sovereignty, latency, Fabric feature availability, or an approved disaster recovery design. Convenience or team location isn't sufficient reasons for another region. See Multi-Geo support for Fabric and Fabric deployment patterns.

- **Exception approval**: The organization should define who approves another region or a Fabric capacity shared across data domains. An exception request should identify the requirement, affected data products, expected cost, and exit conditions.

### 2.2 Fabric workspaces

*How should we use workspaces?* Fabric workspaces should provide the working boundaries through which data domains create and manage data products in Microsoft Fabric. Each data domain should determine its workspace structure within organization-wide standards.

- **Workspace use**: Create a separate workspace when Fabric items require a different administrative, access, deployment, or network boundary.

- **Workspace organization.** Data domains should associate related workspaces with Fabric domains. Fabric domains logically group Fabric workspaces and support delegated governance, but domain assignment doesn't determine access to Fabric items. See [Best practices for planning and creating domains in Microsoft Fabric]( /fabric/governance/domains-best-practices).

## 3. Microsoft Purview architecture

*How should we design Microsoft Purview?* The Microsoft Purview architecture should reflect the organization’s data domains without treating Purview governance domains, Data Map domains, collections, or Fabric domains as interchangeable.

### 3.1 Microsoft Purview account placement

*Where should we deploy the Purview account?* The organization should place the Microsoft Purview Azure resource in an internal workload landing zone. The selected subscription and region should meet the organization’s regulatory and operational requirements.

The organization should assign responsibility for the Purview service centrally. Data domains should receive delegated authority for their metadata and business concepts through approved Purview roles. They should not deploy separate Purview environments solely to obtain administrative autonomy. 

See [Microsoft Purview FAQs](/purview/data-governance-purview-portal-faq).

### 3.2 Purview structure

*How should we structure Purview?* The organization should establish its governance domains and Data Map structure before data domains begin registering data sources and publishing data products.

- **Governance domains**: Governance domains provide the business context for data products and related concepts. They can include glossary terms, objectives and key results, and critical data elements. Governance domains should initially align with the organization's data domains. Use a different boundary when governance ownership requires it. See [Governance domains](/purview/unified-catalog-plan#create-governance-domains).

- **Data Map structure**: Data Map domains should represent top-level technical administration or lifecycle boundaries. Because Data Map domains are limited, use them for broad technical administration boundaries rather than mirroring organizational data domains.

- **Collections**: Collections should provide more granular administration and metadata access within a Data Map domain. The organization should use collections when operational teams need delegated responsibility for registering and scanning data sources. Collections can also separate production and nonproduction sources when those sources do not justify another Data Map domain.
Each data source must be registered in one collection within one Data Map domain. Assets scanned from that source remain associated with that structure. The organization should therefore define source placement rules before broad onboarding.

See [Governance domains and domain recommendations]( /purview/data-gov-best-practices-domains-and-gov-domains) and [Microsoft Purview domains and collections architecture and best practices]( /purview/data-gov-best-practices-domains-collections).
