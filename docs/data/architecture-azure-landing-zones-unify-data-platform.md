---
title: Azure Architecture for a Unified Data Platform
description: "Azure Architecture: Discover how to design your Azure environments for a unified data platform with Microsoft Fabric and Microsoft Purview."
#customer intent: As a technical decision maker (enterprise architect, CTO, VP, director), I want to make the right technology adoption decisions and design them to integrate into my existing systems, creating a unified data platform with Microsoft Fabric, Microsoft Purview, and Azure so that my organization can standardize data value for analytics and AI consumption.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Azure architecture for a unified data platform

After aligning on why and what data products you need (organizational readiness), the next step is to decide how the technology fits together. This step involves creating an architecture that connects and integrates Microsoft Fabric with Azure (see Figure 1). Key aspects of the architecture include:

1. **[Fabric architecture](./architecture-fabric-data-lake-unify-data-platform.md)**: Design the Microsoft Fabric OneLake data lake architecture for your data domains and data products.

2. **[Azure architecture](#1-plan-your-data-management-landing-zones)**: Create and organize your **Azure environments** (data management landing zones, application landing zones, data landing zones) to support a unified data platform. 

This article helps you make the right architecture decisions for designing the **Azure environments** needed to integrate into the unified data platform.

:::image type="content" source="./images/unified-data-platform-architecture-ai-analytics.svg" alt-text="Diagram showing a unified data platform architecture across Microsoft systems. Data from multiple sources is organized into data domains. They're governed in Microsoft Purview. They're ingested into Fabric OneLake and produced as data products using Fabric and Databricks. Microsoft Copilot, Foundry agents, Power BI, and data science tools consume them.":::
*Figure 1. Architecture: Unified data platform for AI and analytics.*

## 1. Plan your data management landing zones

A data management landing zone (DMLZ) is one or more Azure subscriptions for data management resources. In the context of Microsoft Fabric adoption, use DMLZs to host your Microsoft Purview account and Microsoft Fabric capacity. Data management landing zones belong with application landing zones, not in the platform landing zone. They require distinct ownership from shared infrastructure. **Here's checklist of best practices:**

:::image type="content" source="./images/azure-architecture-unified-data-platform.svg" alt-text="Diagram showing an Azure architecture for unifying a data platform with Microsoft Fabric. At the top, Microsoft Entra, Microsoft Defender, and Microsoft Purview provide organization‑wide governance and security. Azure management groups define a platform landing zone with centralized policy, monitoring, identity, security, and connectivity. Application landing zones sit under the platform. Data management landing zones host Microsoft Purview accounts that run in Microsoft Fabric capacity and govern data stored in OneLake. Separate data landing zones host Azure Databricks for data processing. Microsoft Foundry agents run in their own application landing zones and securely access governed data in OneLake through Purview. The diagram shows clear separation between platform services, data domains, and application workloads while sharing centralized governance." lightbox="./images/azure-architecture-unified-data-platform.svg" border="false":::

### 1.1 Microsoft Purview account in a data management landing zone

If you use Microsoft Purview for governance, deploy your Purview account into its own data management landing zone. There's one data management landing zone per Microsoft Entra ID tenant for Purview. Using Purview in a dedicated environment helps maintain clear ownership and governance boundaries.

### 1.2 Microsoft Fabric capacity in data management landing zones

Compute in Microsoft Fabric is called [Fabric capacity](/fabric/enterprise/licenses#capacity). Fabric capacities are pools of computing resources for Fabric, similar to Power BI capacities. Create your Fabric capacities in a DMLZ. This approach separates the data platform’s core from other operational assets, and it supports distinct ownership and cost tracking.

To manage Fabric capacity, decide whether each data domain gets its own Fabric capacity or if you centralize capacity. **Decision guidance:**

**Option 1: Decentralized capacities per domain (recommended).** Each data domain has its own DMLZs. They create and manage their own Fabric capacity in their DMLZs.

- **When to choose:** Choose this option when data domains are mature and have the expertise to manage their environments. They might have steady or predictable usage and need guaranteed performance isolation.

- **Benefits:** Each data domain can scale its capacity as needed and is accountable for its own costs and performance. There's no competition for resources between data domains, and each data domain can decide when to scale up or down.

- **Tradeoffs:** This approach can increase the total operational overhead and possibly lead to lower overall utilization efficiency. One data domain's capacity might be idle while another's is at full usage. It might also require more initial setup (creating multiple capacities). Smaller Fabric capacities might not be large enough to unlock certain product features, such as in Power BI.

**Option 2: Centralized capacity.** In this model, the organization creates and manages a set of Fabric capacities that multiple data domains share. Often there's just one org-wide capacity, or a few (one for production, one for nonproduction).

- **When to choose:** Choose this option when data domains are early in their maturity or have variable and unpredictable usage patterns. It's also useful if you want simpler operations by managing fewer capacities.

- **Benefits:** You get higher resource utilization (fewer underused pockets of capacity) and simplified management because the central team handles scaling and monitoring.

- **Tradeoffs:** Without careful governance, a shared capacity can lead to contention. One data domain's heavy usage could affect others. It can obscure the true cost of each data domain's usage. Individual data domains also have less control or visibility into scaling decisions.

**Option 3: Hybrid approach.** A combined model gives you the best of both. Maintain a shared central capacity for small or new data domains. Allow larger, more demanding data domains to have their own dedicated capacities once they reach a certain size or criticality.

- **When to choose:** Use this option when you anticipate that some data domains will grow quickly or have special performance requirements. However, you might also have many smaller data domains that aren't yet ready for their own capacity. It provides a transition path. New data domains start on the shared capacity and "graduate" to their own when they meet criteria you define, such as sustained high usage, critical uptime needs, or specific security isolation.

- **Benefits:** You get the efficiency of shared infrastructure and us of dedicated capacity when workloads outgrow the shared pool.

- **Tradeoffs:** This model requires governance to decide when a data domain should move to dedicated capacity. It can also add complexity in tracking which data domain is on which model, and making sure the shift is smooth when the time comes.

For more information, see [Deployment Patterns for Microsoft Fabric](/azure/architecture/analytics/architecture/fabric-deployment-patterns).

## 2. Integrate your application landing zones

Application landing zones are one or more Azure subscriptions where operational workloads run. These workloads include business applications, services, and AI applications that produce or consume data products. These landing zones are separate from data management landing zones. They have a different purpose. They often have different owners. Ownership usually sits with application or product teams. As a decision maker, you set clear expectations for how these landing zones interact with the unified data platform. Use the following checklist:

1. **Standardize Microsoft Foundry data access.** If application teams are building AI or analytics features, require them to use the approved mechanisms to access enterprise data in OneLake instead of creating their own shadow copies of data. For example, if using Microsoft Foundry to build AI agents in an application, ensure those agents retrieve data through the Fabric Data Agent or Azure AI Search with Foundry IQ indexes, rather than directly accessing back-end databases.

2. **Integrate operational databases.** Many application landing zones contain critical **online transaction processing (OLTP) databases** (systems for sales, ERP, customer records). These systems generate key business data. To integrate these databases with the unified platform, use Fabric’s [mirroring](/fabric/mirroring/overview) feature to replicate necessary data from these operational stores into OneLake in near-real-time. This approach keeps the source databases operationally independent (no heavy loads from analytics queries) while ensuring the data platform has current data for reporting and AI.

3. **Include major external systems (SAP, Oracle):** If you have large enterprise systems like **SAP or Oracle** that reside outside Azure or have strict uptime requirements, plan to bring their data into OneLake as well. **Best practice:** Integrate SAP and Oracle data by mirroring [SAP](/fabric/mirroring/sap) and [Oracle](/fabric/mirroring/oracle) data into Fabric. With this approach, your organization creates a consistent, governed pipeline from core business systems into OneLake. Keep these platforms operationally independent while using Fabric as the single convergence layer.

## 3. Plan your data landing zones (as needed)

If your organization uses other data resources, like Azure Databricks, Azure Data Lake Storage (ADLS), or Azure Machine Learning workspaces, use data landing zones (DLZs) to manage them. A data landing zone is an Azure subscription or set of resources that hosts data and ML/AI workloads.

### 3.1 Manage data landing zones

Each data domain that requires such resources can have its own data landing zones. For instance, if your Sales data domain uses a Databricks workspace to process streaming data or run advanced machine learning, deploy that workspace in a dedicated DLZ for the Sales data domain. This way, the data domain team can manage it, and it has clear cost and resource isolation from other data domains. Some data domains might group multiple data products in one DLZ, while others might allocate a separate DLZ per data product.

**Option 1: Multiple data products in one DLZ.** A single data landing zone hosts several related data products.

- **When to choose:** If a data domain has several smaller data initiatives that share similar security and infrastructure needs, one DLZ can host all of them.

- **Benefit:** This approach simplifies governance and resource management. There’s one set of policies and infrastructure to manage, and teams within the data domain can standardize their tools and deployment processes.

- **Tradeoff:** It can be harder to separate costs by product or to limit the effects of an issue. If one product has a problem, it might affect others in the same zone. Also, security or compliance settings apply to the whole zone, so you can’t easily differentiate policies between products if they have different requirements.

**Option 2: One DLZ per data product.** Each data product is deployed in its own dedicated landing zone.

- **When to choose:** If a data product is large, critical, or has unique security and compliance requirements, choose a dedicated landing zone.

- **Benefit:** This approach provides strong isolation. Each data product can be managed, secured, and even developed on its own timeline without affecting others. You can easily attribute costs and performance to that specific product.

- **Tradeoff:** More landing zones mean more overhead in terms of managing infrastructure and potentially some duplication of services, such as multiple distinct Databricks workspaces. It’s more complex, but sometimes necessary for regulatory or performance reasons.

Some organizations adopt a hybrid of these approaches, depending on each domain’s needs. The key is to evaluate the independence and sensitivity of each data product. If products share data or processes and don't require isolation, a shared DLZ can work. If they need to be separate or if you want the freedom to manage them differently, use separate DLZs.

### 3.2 Use Fabric and Databricks integration patterns

If your data platform includes Azure Databricks, integrate it with your Microsoft Fabric OneLake environment. Two supported integration patterns exist between Azure Databricks and Microsoft Fabric. The choice depends primarily on whether you're building new data products or operating an existing Databricks estate, and on where you want long‑term ownership of the lake to reside.

**Option 1: OneLake as the system of record.** In this pattern, you configure Databricks workspaces to read from and write to OneLake as their storage layer, not Azure Data Lake Storage Gen2.

- **When to choose**: Use this pattern for new projects or when you want a pure SaaS-managed storage layer. It takes advantage of OneLake’s fully managed nature and ensures that all data resides in the unified Fabric environment.

- **Benefit:** You have one authoritative data lake (OneLake) with the governance and security of Fabric. You don't need to manage separate storage accounts for Databricks.

- **Tradeoffs:** Setting up integration requires some initial effort, like configuring credentials and access for Databricks to OneLake. Teams used to native Databricks with its own storage might need to adjust. See [Azure Databricks integration with OneLake](/fabric/onelake/onelake-azure-databricks).

**Option 2. ADLS as system of record.** In this approach, you use **Azure Data Lake Storage (ADLS)** Gen2 account as the primary data lake for your Databricks pipelines. Databricks writes to ADLS as usual. Microsoft Fabric then connects to that data by using **shortcuts** in OneLake. OneLake "shortcuts" point to data in ADLS so that Fabric can read it as if it were in OneLake.

- **When to choose**: Choose this model when you have an existing Databricks estate with established pipelines. Use it when teams prefer Databricks’ default PaaS storage model. This approach is often the fastest path when onboarding Fabric into an environment that already runs at scale on Databricks.

- **Benefit:** You don't have to move your data or rebuild pipelines. Databricks continues operating with its own storage and processes, and Fabric users can still discover and use the curated data via OneLake shortcuts.

- **Tradeoffs:** This approach introduces a split in ownership and more complexity. You handle the PaaS operations of ADLS (security, scaling) separately from Fabric. There's an extra integration step, managing the shortcuts.

- **Best Practice:** If you use this pattern, make sure to register those ADLS data sources in Purview. Create a clear process to expose data from ADLS into Fabric via shortcuts. This way, Fabric’s catalog and Purview have visibility into those datasets, and AI or analytics queries can reach them. See [Azure Data Lake Storage (ADLS) Gen2 shortcut](/fabric/onelake/create-adls-shortcut).

## Next step

> [!div class="nextstepaction"]
> [Data governance and security baselines](./governance-security-baselines-purview-data-estate-unify-data.md)