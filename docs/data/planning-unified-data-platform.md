---
title: Planning for a unified data platform
description: Learn how to establish data ownership, prioritize data product investments, choose an operating model, and develop the capabilities needed for a unified data platform.
#customer intent: As a decision maker, I want to establish an organizational model for data ownership, investment, resourcing, and capabilities so that my organization can prioritize and sustain valuable data products.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/20/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
ai-usage: ai-assisted
---

# Planning for a unified data platform

*This article helps decision makers establish the organizational model needed to create and sustain valuable data products across the organization.* 

Organizations need to decide where accountability for data resides and how they will direct resources toward the data products that matter most. Without clear ownership and investment priorities, data initiatives can compete for resources, duplicate effort, and create data products that lack sustained business value. This article helps organizations establish data domains, prioritize data product investments, choose an operating model, and develop the capabilities needed to support those priorities.

## Solution and decision tree

# [Conceptual](#tab/conceptual)

:::image type="content" source="./images/executive-architecture-unified-data-platform-ai-analytics.svg" alt-text="High‑level diagram showing Microsoft Fabric at the center of a unified data platform. Data from enterprise sources, such as on‑premises systems, Microsoft services, and public cloud platforms, flows into Fabric, where you organize it as shared data products. These data products are then used across the organization to support analytics, AI systems, and reporting, including Power BI and data science workloads. Fabric connects with Azure for governance, security, and monitoring, while Azure workloads run alongside it as needed. The overall flow shows data coming into Fabric, being governed and standardized, and then powering AI, analytics, and business insights across the organization." lightbox="./images/executive-architecture-unified-data-platform-ai-analytics.svg" border="false":::

*Conceptual architecture of a unified data platform for AI and analytics.*

# [Decision tree](#tab/decision-tree)

:::image type="complex" source="images/decision-tree-unify-data-platform.svg" alt-text="Diagram showing a decision tree for unifying your data platform for leaders and decision makers." lightbox="images/decision-tree-unify-data-platform.svg" border="false":::
    The flow asks a series of yes-or-no questions. Each "Yes" leads to specific guidance. The first question asks whether the organization needs help with understanding data priorities or building skills to get more value from data. If yes, the guidance is to prepare people through roles, training, and readiness activities. The second question asks whether the organization needs a unified way to access data across clouds and workloads to support analytics and AI. If yes, the guidance is to use Microsoft Fabric as the unified data platform. The third question asks whether the organization needs help with turning operational data into business value or securely feeding data into AI systems, such as Microsoft Foundry. If yes, the guidance is to integrate Azure services with Fabric. Fourth question asks whether the organization needs help with controlling access to data or with securing data consistently. If yes, the guidance is to set governance and security baselines using Microsoft Purview and related controls. Fifth question asks whether the organization needs help with setting consistent organizational standards to process, secure, and consume data products for analytics and AI. If yes, the guidance is to set operational standards for data products, security, and lifecycle management. The flow ends by pointing to adopting AI and adopting AI agents once the unified data platform and standards are in place.
:::image-end:::

*Microsoft's decision tree to guide your unified data platform.*

--- 

## 1. Operating model

*How should you distribute responsibilities?* Organizations should use a federated operating model that combines organization-wide governance with data domain accountability. The organization should establish policies that apply across all data domains. Each data domain should have authority over its data and data products within those policies. Organizations should document this division of authority.

### 1.1 Data domains

*What responsibilities should we decentralize?* A data domain defines an organizational boundary for accountability over related data and data products.

:::image type="content" source="images/data-sources-data-domains.svg" alt-text="Diagram of a data platform where multiple data domains sit above shared data sources. The top section shows several data domains labeled Data domain 1, Data domain 2, Data domain 3, and Data domain n. These labels represent business units or product lines. Below them is a data sources layer. Arrows indicate that each data domain pulls data from the same common sources. The data sources include on‑premises systems, Dataverse, Microsoft 365, Azure, Google Cloud, and Amazon S3. The diagram emphasizes that data domains organize and use data from many different platforms." lightbox="images/data-sources-data-domains.svg" border="false":::
*Overview of data domains.*

- **Data domain formation**: Data domains should align with organizational boundaries where a leader can set priorities and control investment. Business units or product lines often provide effective boundaries because they already have established leadership and budgets. Data domains shouldn't reflect where data resides or which technology stores it. If no leader has sufficient authority over the related data and data products, define a different boundary.

- **Data ownership**: Assign one senior owner to each data domain. The owner is accountable for the domain's business outcomes and data products and needs enough authority to set priorities and resolve competing needs.

- **Data product investment**: Each data domain should determine which data products to propose and sustain based on its business priorities.

- **Domain budget**: Data domains should determine how to use their budget to support their data and data products within organization-wide requirements.

- **Data domain changes**: Data domain boundaries should remain stable until organizational accountability materially changes. Organizations should review boundaries after organizational changes or when recurring cross-data-domain decisions create unclear ownership. Repeated escalation can indicate that the data domain structure no longer reflects organizational decision authority.

### 1.2 Central responsibility 

*What responsibilities should you centralize?* Centralize decisions that require consistency across data domains. Central responsibility should focus on organization-wide policy and the shared capabilities needed to apply it.

- **Organization-wide policies**: The organization should establish governance and security requirements that apply across all data domains. It should also establish the standards that data products must meet for organizational reuse. These policies define the boundaries within which data domains make their own decisions.

- **Platform guardrails**: The organization should translate organization-wide policies into platform guardrails. Microsoft Fabric supports centralized and delegated administration across the tenant and other scopes. The organization should centrally control settings that can create organization-wide exposure, such as external sharing or guest access. It should delegate settings when data domains can make independent decisions without increasing organization-wide risk. Organizations should review tenant settings regularly as Microsoft Fabric introduces new capabilities and settings. See [Governance overview and guidance](/fabric/governance/governance-compliance-overview). 

- **Shared capabilities**: The organization should provide shared platform capabilities when centralization improves consistency or reduces duplicated platform work. These capabilities can include Microsoft Fabric and Microsoft Purview. The organization should establish how data domains access and fund shared capabilities. Data domains should retain authority over investments that support their own data and data products.

- **Exceptions**: The organization should establish a documented exception process for data domains that cannot meet a policy or shared platform requirement. Each approved exception should identify the responsible leader and the conditions for continued approval.

## 2. Data prioritization

*How should you prioritize data initiatives?* Decision makers should maintain a prioritized roadmap of data products that support defined business goals. A data product is a reusable set of data assets organized around a defined business purpose. Organizations should start with the business outcome rather than the available data. This approach directs investment toward data products with identifiable consumers and measurable value.

- **Business goals**: Each proposed data product should support a defined business goal. A business goal can depend on data products from multiple data domains. Each data domain remains accountable for the data products it contributes. Decision makers should fund a data product only when its sponsor can explain the outcome it enables and how the organization will recognize that value. The outcome might improve an important decision. It might enable automation or provide trusted data for reuse.

- **Investment case**: Each proposed data product should have an investment case that identifies its expected value and the resources needed to deliver and sustain it. The investment case should identify the data product's business criticality. The organization should use this classification as an input to reliability, deployment, monitoring, capacity, and change requirements. Decision makers should evaluate whether the expected value justifies the total investment without deciding the technical design. 

- **Portfolio priority**: Organizations should compare proposed data products using consistent criteria for business value and feasibility. Dependencies should determine sequencing after leaders establish relative value. Each review should result in a decision to fund, defer, or reject the proposal. High-value data products with achievable prerequisites should normally receive earlier investment. Organizations should defer a proposal when a critical prerequisite is not ready. They should reject a proposal when its expected value does not justify the investment.

- **Continued investment**: Organizations should reassess funded data products as business priorities and realized value change. Data domains should provide enough evidence to show whether each data product continues to support its intended outcome. Decision makers should continue investment when a data product provides sufficient value and retains clear ownership. They should reduce investment or retire a data product when its value no longer justifies its cost.

## 3. Staffing

*How should we staff data domains?* The data product roadmap should drive staffing. Organizations should not establish permanent teams before sustained demand exists.

- **Dedicated staffing**: A data domain should use dedicated staffing when sustained demand justifies persistent expertise. This model also fits data domains that support strategically important data products or depend heavily on business knowledge. The data domain should fund dedicated staffing through its approved budget.

- **Shared staffing**: The organization should provide shared staffing when several data domains need similar expertise but individual demand is intermittent. Shared specialists can provide capabilities such as data engineering or platform administration. Shared specialists should prioritize work according to the data product roadmap.

- **External staffing**: A data domain should use external providers when the need is temporary or highly specialized. External providers can also accelerate delivery until the organization develops an internal capability. The data domain should identify which knowledge must transfer internally before the engagement ends.

## 4. Skilling

*How should we get the skills we need?* Decision makers need to identify capability gaps from the approved roadmap, then select development methods to close those gaps.

- ** Applied development**: Training should address an identified capability gap and connect to active data product work where practical. This approach gives people a setting in which to apply new knowledge. It also gives leaders evidence that training improves delivery capability.

- ** Skill validation**: Credentials (certifications and applied skills) can validate relevant platform skills. They should support the capability strategy rather than define it. Organizations should select current Microsoft Learn training and role-based credentials after they identify the roles and capabilities they need. See [Microsoft Credentials](/credentials/).

## 5. Cost management and FinOps

*How should your organization manage spending?* Organizations should establish an ongoing FinOps process that connects spending with the value of data products. Each data domain should have financial accountability for spending within its approved budget. The organization should use its existing Azure financial processes for Microsoft Fabric where practical. It should define additional Fabric-specific processes only where shared Fabric capacity requires more detailed consumption allocation.

### 5.1 Cost allocation

*How should we allocate costs?* Organizations should align Fabric cost allocation with their existing Azure cost allocation model. Organizations that already use showback or chargeback for Azure should extend that model to Fabric where practical. The allocation method should assign spending to the data domains responsible for consuming it. The method should also explain how the organization distributes shared costs and reservation benefits.

- **Azure cost reporting**: Microsoft Cost Management can organize and redistribute costs across subscriptions, resource groups, or tags through cost allocation rules. See [Cost Allocation]( /azure/cost-management-billing/costs/cost-allocation-introduction).

- **New process**: If you don't have an established model, start with showback to give data domains visibility into their costs before introducing chargeback. 

- **Chargeback tooling**: When data domains share Fabric capacity, use the Microsoft Fabric Chargeback app to attribute Fabric capacity consumption to the appropriate data domains. See [Microsoft Fabric Chargeback app](/fabric/enterprise/chargeback-app).

### 5.2 Cost forecasting

*How should we forecast Fabric costs?* Data domains should forecast expected spending as part of their budgeting process and update forecasts as actual consumption becomes known. Fabric capacity is an important cost driver, so account for planned capacity needs and expected growth.

Data domains should use the Microsoft Fabric SKU estimator for initial planning and the Microsoft Fabric Capacity Metrics app to refine forecasts using observed consumption. Microsoft recommends starting with smaller Fabric capacity and increasing capacity as actual demand justifies additional investment. See [Fabric capacity planning](/fabric/enterprise/capacity-planning-overview).

### 5.3 Cost optimization

*How should we optimize spending?* Data domain leaders should periodically compare actual spending with the approved budget and the expected value of their data products. The review should determine whether spending remains justified or whether the organization should optimize consumption or change investment.

- **Review frequency**: The review cadence should reflect cost volatility. Monthly reviews normally fit data domains with changing workloads or recurring consumption spikes. Quarterly reviews can fit data domains with stable and predictable usage.

- **FinOps tools**: Data domain leaders should use Fabric capacity usage together with the Azure bill to understand material cost drivers. Microsoft Cost Management shows the usage charges for a Fabric capacity, and the Microsoft Fabric Capacity Metrics app provides the corresponding capacity utilization information. See [Understand your Fabric capacity Azure bill](/fabric/enterprise/azure-billing) and [Evaluate and optimize your Microsoft Fabric capacity](/fabric/enterprise/optimize-capacity). 

- **Commitment-based pricing**: Organizations can purchase Fabric capacity reservations for one-year or three-year terms. A reservation covers matching Fabric capacity usage but does not cover storage or networking charges. Organizations should make this commitment only after usage has become sufficiently predictable. [Save costs with Microsoft Fabric Capacity reservations](/azure/cost-management-billing/reservations/fabric-capacity).

