---
title: Fabric governance in a unified data platform
description: Learn how to secure and govern your Microsoft Fabric OneLake environment with best practices for workspaces, cost, and data protection.
#customer intent: As a technology decision maker, I want to establish organization-wide Fabric governance baselines so data domains can operate their data products autonomously within consistent security, operational, and platform controls.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/23/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
ai-usage: ai-assisted
---

# Fabric governance in a unified data platform

*This section helps decision makers understand how to govern Microsoft Fabric.*

Organizations should decide how they govern Fabric costs, data security, networking, monitoring, and deployment. These decisions help data domains operate their data products and Fabric capacities autonomously within consistent organizational policies. This article provides guidance for establishing those policies and using Microsoft Fabric capabilities to implement them.

## Architecture and decision tree

# [Conceptual](#tab/conceptual)

:::image type="content" source="./images/executive-architecture-unified-data-platform-ai-analytics.svg" alt-text="High‑level diagram showing Microsoft Fabric at the center of a unified data platform. Data from enterprise sources, such as on‑premises systems, Microsoft services, and public cloud platforms, flows into Fabric, where you organize it as shared data products. These data products are then used across the organization to support analytics, AI systems, and reporting, including Power BI and data science workloads. Fabric connects with Azure for governance, security, and monitoring, while Azure workloads run alongside it as needed. The overall flow shows data coming into Fabric, being governed and standardized, and then powering AI, analytics, and business insights across the organization." lightbox="./images/executive-architecture-unified-data-platform-ai-analytics.svg" border="false":::

*Conceptual architecture of a unified data platform for AI and analytics.*

# [Decision tree](#tab/decision-tree)

:::image type="complex" source="images/decision-tree-unify-data-platform.svg" alt-text="Diagram showing a decision tree for unifying your data platform for leaders and decision makers." lightbox="images/decision-tree-unify-data-platform.svg" border="false":::
    The flow asks a series of yes-or-no questions. Each "Yes" leads to specific guidance. The first question asks whether the organization needs help with understanding data priorities or building skills to get more value from data. If yes, the guidance is to prepare people through roles, training, and readiness activities. The second question asks whether the organization needs a unified way to access data across clouds and workloads to support analytics and AI. If yes, the guidance is to use Microsoft Fabric as the unified data platform. The third question asks whether the organization needs help with turning operational data into business value or securely feeding data into AI systems, such as Microsoft Foundry. If yes, the guidance is to integrate Azure services with Fabric. Fourth question asks whether the organization needs help with controlling access to data or with securing data consistently. If yes, the guidance is to set governance and security baselines using Microsoft Purview and related controls. Fifth question asks whether the organization needs help with setting consistent organizational standards to process, secure, and consume data products for analytics and AI. If yes, the guidance is to set operational standards for data products, security, and lifecycle management. The flow ends by pointing to adopting AI and adopting AI agents once the unified data platform and standards are in place.
:::image-end:::

*Microsoft's decision tree to guide your unified data platform.*

--- 

## 1. Fabric cost governance

*How should we control Fabric costs?* Fabric governance should provide the controls needed to implement the financial decisions established during planning. These controls should govern which workloads can consume Fabric capacity, who can make changes that affect cost, and when capacity can scale or use additional consumption.

### 1.1 Data product onboarding

*How should we onboard data products into Fabric?* Every production data product should be evaluated before placement on Fabric capacity. The evaluation should consider expected consumption, business criticality, budget, and organizational requirements.

The data domain should place the data product on a Fabric capacity that matches its financial and operational requirements. A business-critical data product might require a dedicated Fabric capacity when contention on a shared Fabric capacity would create unacceptable risk. A low-consumption data product can normally use a shared Fabric capacity.

### 1.2 Permissions

*How should administrative authority align with financial accountability?* Administrative permissions should align with financial accountability. A data domain should receive the authority needed to manage its data products and Fabric capacity consumption within its approved budget. The organization should retain control over tenant settings and controls that affect several data domains.

- **Dedicated Fabric capacity**: A data domain with dedicated Fabric capacity should normally have greater authority over its Fabric capacity because its decisions affect its own budget. 

- **Shared Fabric capacity**: A shared Fabric capacity should use centralized administration. Participating data domains should not receive unrestricted authority to resize the Fabric capacity, change overage settings, or weaken surge protection. The organization should establish an approval process for changes that can increase cost or affect other data domains.

### 1.3 Capacity changes

*How should we control Fabric capacity changes?* A data domain should change Fabric capacity only after it has reviewed sustained demand, throttling, and business effect.

- **Capacity monitoring**: Data domains should monitor Fabric capacity utilization and throttling so they can identify sustained pressure and determine its cause. The Fabric Capacity Metrics app should provide the main evidence for Fabric capacity decisions.
See [Fabric Capacity Metrics app](/fabric/enterprise/metrics-app). 

- **Permanent capacity changes**: A data domain should increase Fabric capacity when sustained demand prevents the existing Fabric capacity from efficiently meeting agreed requirements. An isolated utilization spike shouldn't normally justify an increase. Fabric uses bursting and smoothing to accommodate temporary demand, so sustained throttling or recurring rejection provides stronger evidence that optimization or scaling is required. See [Fabric capacity throttling](/fabric/enterprise/throttling), [Evaluate and optimize your Microsoft Fabric capacity](/fabric/enterprise/optimize-capacity), and  [Scale your Fabric capacity](/fabric/enterprise/scale-capacity).

- **Temporary additional consumption**: A data domain should decide whether its Fabric capacities can use capacity overage to maintain continuity during temporary demand. Capacity overage should act as a temporary continuity control rather than planned Fabric capacity. See [Capacity overage in Microsoft Fabric](/fabric/enterprise/capacity-overage-overview).

- **Consumption protection**: Data domains should use surge protection when background consumption could materially affect interactive workloads. Capacity-level surge protection can reject new background operations before a Fabric capacity enters deep throttling. Workspace-level surge protection can limit how much compute one workspace consumes. Shared Fabric capacities should use appropriate protection when consumption by one workspace could disrupt data products owned by other data domains. Surge protection should control excessive consumption rather than serve as a general mechanism for prioritizing named workloads. [Manage surge protection for Fabric capacities](/fabric/enterprise/surge-protection).

## 2. Fabric data security

*How should we secure the Fabric platform?* The organization should first establish its data security requirements through the organization-wide data governance process. See [Data security](./data-governance-unified-data-platform.md#4-data-security) for decisions about classification, sensitivity labels, protection, and data loss prevention.

Fabric governance should translate those requirements into access boundaries for workspaces, Fabric items, and underlying OneLake data. Each data domain should control access to the Fabric workspaces and data products that it owns. 

- **Workspace access**: Apply workspace roles when a person needs broad capabilities across the workspace. Restrict workspace Admin and Member roles because these roles can manage or share workspace content. Assign workspace roles to Microsoft Entra security groups instead of individual users.

- **Item access**: Item permissions should apply when a person needs access to a specific data product without access to every item in the workspace. Sharing an item does not necessarily grant permission to query its underlying OneLake data. See [Permission model](/fabric/security/permission-model).

- **Data access**: Apply OneLake security or an experience-specific control when users require different access to the underlying data. This control is necessary when several audiences use the same data product but shouldn't see the same records or tables. See [OneLake data access](/fabric/onelake/security/data-access-control-model).

- **Workspace isolation**: Apply separate workspaces when data products require materially different administration, deployment, or network controls. Don't create extra workspaces only to reproduce boundaries that item permissions or OneLake security can enforce reliably.

See [OneLake security best practices](/fabric/onelake/security/best-practices-secure-data-in-onelake).

## 3. Fabric networking

*How should we set up Fabric networking?* The organization should derive Fabric networking requirements from its established connectivity and data protection standards.  The organization should make separate decisions for inbound access to Fabric and outbound access from Fabric to external data sources. These directions use different controls and can have different requirements.

- **Inbound access to Fabric**: When private connectivity is required for selected workspaces, the organization should use workspace-level private links where the required Fabric capabilities support them. When network security requirements apply across Fabric, the organization should use tenant-level private links. The organization should assess the broader operational effect before applying tenant-level restrictions. See [Private links for Fabric tenants](/fabric/security/security-private-links-overview).

- **Outbound access to data sources**: When private connectivity is required, data domains should use supported private connectivity controls for the applicable Fabric workload and data source. Managed private endpoints provide private connectivity for supported Fabric workloads and supported data sources. See [Overview of managed private endpoints for Fabric](/fabric/security/security-managed-private-endpoints-overview) 

See [Network security in Fabric](/fabric/security/security-overview#understand-network-security).

## 4. Fabric monitoring

*How should we monitor Fabric?* The organization should establish minimum Fabric monitoring requirements and assign responsibility according to the scope of impact. Each data domain should monitor its data products and dedicated Fabric capacities. The organization should monitor shared Fabric capacities and conditions that affect several data domains.

The Fabric Monitor hub can provide an organization-level view of Fabric capacity health. Its capacity monitoring experience is currently in preview, so the organization should not depend on it as its only required monitoring control. See [Fabric Monitoring hub](/fabric/admin/monitoring-hub).

- **Data products**: Each production data product should have a named operational owner who is accountable for monitoring and operational response. The responsible data domain should define the conditions that require notification, investigation, or escalation.

- **Requirements**: Monitoring should reflect the data product requirements established during onboarding. A business-critical data product should normally have automated failure alerts and an escalation path. A less critical data product can use periodic review when delayed recovery has limited business effect.

- **Tooling**: Workspace monitoring can collect logs and metrics from supported Fabric items. It can centralize telemetry from several workspaces when the source and monitoring workspaces use the same Azure region. Data collection begins only after the feature is enabled, and it doesn't backfill previous activity. Data domains should confirm telemetry support for the Fabric items used by each data product. They shouldn't treat workspace monitoring as complete coverage for every Fabric experience. See [Workspace monitoring](/fabric/fundamentals/workspace-monitoring-overview).

## 5. Deployment

*How should we deploy to Fabric?* The organization should establish a small number of approved deployment patterns based on the business effect of an incorrect or failed release. Every production data product should use a repeatable release process. The organization should not require every data product to use the same lifecycle. 

Data domains should select a deployment pattern from the potential business effect of a failed release. Business criticality should inform that assessment, but it doesn't alone determine the release pattern.

- **Lower-risk pattern**: This pattern should apply when a failed release has limited business effect and restoration is straightforward. The release must remain repeatable. The data domain should document the deployed version and the recovery process.

- **Medium-risk pattern**: This pattern should apply when multiple contributors or frequent releases increase the probability of change-related failure. Source control and development isolation should be required. The release process should include validation before production deployment.

- **High-risk pattern**: This pattern should apply when an incorrect or failed release can materially disrupt an important business process or organizational reporting. Source control and production isolation should be required. An independent person or automated control should validate the release. The data domain should define a tested recovery process.

Data domains should use Microsoft Fabric Git integration and deployment pipelines when the Fabric item supports these capabilities and the selected deployment pattern requires them. An approved alternative should apply when a Fabric item does not support the standard pattern.

See [Microsoft Fabric Git integration](/fabric/cicd/git-integration/intro-to-git-integration), [Deployment pipelines](/fabric/cicd/deployment-pipelines/intro-to-deployment-pipelines) and [Fabric CI/CD concepts and best practices](/fabric/fundamentals/understand-best-practices-fabric-cicd).
