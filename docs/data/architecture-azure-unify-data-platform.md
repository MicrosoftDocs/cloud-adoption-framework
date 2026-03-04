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

After aligning on why and what data products you need (organizational readiness), the next step is to decide how the technology fits together. This involves creating an architecture that connects  integrates Microsoft Fabric with Azure (see Figure 1). Key aspects of the architecture include:

1. **[Fabric architecture](./architecture-fabric-data-lake-unify-data-platform.md)**: Design the Microsoft Fabric OneLake data lake architecture for your domains and data products.

2. **[Azure architecture](#1-use-data-management-landing-zones)**: Integreate **Azure environments** into Fabric. Create data management landing zones (Fabric capacities, Microsoft Purview account), integrate application landing zones (Microsoft Foundry, transactional databases), and data landing zones (Azure Databricks, Azure Machine Learning).

This article helps you make the right architecture decisions for designing the **Azure environments** needed to integrate into the unified data platform.

:::image type="content" source="./images/azure-architecture-unified-data-platform.svg" alt-text="Diagram showing an Azure architecture for unifying a data platform with Microsoft Fabric. At the top, Microsoft Entra, Microsoft Defender, and Microsoft Purview provide organization‑wide governance and security. Below, Azure management groups define a platform landing zone with centralized policy, monitoring, identity, security, and connectivity. Application landing zones sit under the platform. Data management landing zones host Microsoft Purview accounts that run in Microsoft Fabric capacity and govern data stored in OneLake. Separate data landing zones host Azure Databricks for data processing. Microsoft Foundry agents run in their own application landing zones and securely access governed data in OneLake through Purview. The diagram shows clear separation between platform services, data domains, and application workloads while sharing centralized governance.":::

## 1. Plan your data management landing zones

A data management landing zone (DMLZ) is one or more Azure subscriptions for data management resources. In the context of Microsoft Fabric adoption, you use DMLZs to host your Microsoft Purview account and Microsoft Fabric capacity. DMLZs belong with application landing zones, not in the platform landing zone. They require distinct ownership from shared infrastructure. Set up your data management landing zone with the following in mind:

### 1.1 Microsoft Purview account in a data management landing zone

If you use Microsoft Purview for governance (highly recommended), deploy your Purview account into its own Data Management Landing Zone. There’s one DMLZ per Microsoft Entra ID tenant for Purview. Isolating Purview in a dedicated environment helps maintain clear ownership and governance boundaries.

### 1.2 Microsoft Fabric capacity in data management landing zones

Compute in Microsoft Fabric is delivered through [Fabric capacity](/fabric/enterprise/licenses#capacity)*.* Fabric capacities are pools of computing resources for Fabric, analogous to Power BI capacities. Plan to create your Fabric capacities in a DMLZ. This separates the data platform’s core from other operational assets, allowing distinct ownership and cost tracking.

For managing Fabric capacity, you have a critical decision to make: Will each data domain get its own Fabric capacity, or will capacity be centralized? Each approach has pros and cons:

**Option 1: Decentralized capacities per domain (recommended**). Each data domain has their own DMLZ(s). They create and manage their own Fabric capacity in their DMLZ(s).

- **When to choose:** This is best when domains are sufficiently mature and have the expertise to manage their environments independently. They may have steady or predictable usage and need guaranteed performance isolation.

- **Benefits:** Each domain can scale its capacity as needed and is accountable for its own costs and performance. There’s no competition for resources between domains, and each domain can decide when to scale up or down.

- **Tradeoffs:** This approach can increase the total operational overhead and possibly lead to lower overall utilization efficiency. One domain’s capacity might be idle while another’s is maxed out. It may also require more initial setup (creating multiple capacities). Smaller Fabric capacities might not be large enough to unlock certain product features, for example, in Power BI.

**Option 2: Centralized capacity.** In this model, central IT or data team provisions and manages a set of Fabric capacities that are shared by multiple domains. Often there might be just one org-wide capacity, or a few (one for production, one for non-production).

- **When to choose:** This is effective when data domains are early in their maturity or have highly variable and unpredictable usage patterns. It’s also useful if you want simpler operations by managing fewer capacities.

- **Benefits:** Higher resource utilization (fewer underused pockets of capacity) and simplified management because the central team handles scaling and monitoring.

- **Tradeoffs:** Without careful governance, a shared capacity can lead to contention. One domain’s heavy usage could impact others. It can obscure the true cost of each domain’s usage. Individual domains also have less control or visibility into scaling decisions.

**Option 3: Hybrid approach.** A combined model gives you the best of both. Maintain a shared central capacity for small or new domains. Allow larger, more demanding domains to have their own dedicated capacities once they reach a certain size or criticality.

- **When to choose:** Use this when you anticipate that some domains will grow quickly or have special performance requirements, but you also have many smaller domains that aren’t yet ready for their own capacity. It provides a transition path. New domains start on the shared capacity and “graduate” to their own when they meet criteria you define, such as sustained high usage, critical SLA needs, or specific security isolations.

- **Benefits:** You get the efficiency of shared infrastructure for those who need it, and the performance and autonomy of dedicated capacity for those who outgrow the shared pool.

- **Tradeoffs:** This model requires governance to decide when a domain should move to dedicated capacity. It can also add complexity in tracking which domain is on which model, and making sure the shift is smooth when the time comes.

See [Deployment Patterns for Microsoft Fabric](/azure/architecture/analytics/architecture/fabric-deployment-patterns) for more information.

## 2. Integrate your application landing zones

Application landing zones are one or more Azure subscriptions where operational workloads run. These workloads include business applications, services, and AI applications that produce or consume data products. These landing zones are separate from data management landing zones. They have a different purpose. They often have different owners. Ownership usually sits with application or product teams. As a decision maker, your role is to set clear expectations for how these landing zones interact with the unified data platform. Here’s a checklist:

1. **Standardize Microsoft Foundry data access.** If application teams are building AI or analytics features, mandate that they use the approved mechanisms to access enterprise data in OneLake (as opposed to creating their own shadow copies of data). For example, if using Microsoft Foundry to build AI agents in an application, ensure those agents retrieve data via the Fabric Data Agent or Azure AI Search with Foundry IQ indexes, rather than directly hitting back-end databases.

2. **Integrate operational databases.** Many application landing zones contain critical **online transaction processing (OLTP) databases** (systems for sales, ERP, customer records). These generate key business data. To integrate these with the unified platform, use Fabric’s [mirroring](/fabric/mirroring/overview) feature to replicate necessary data from these operational stores into OneLake in near-real-time. This approach keeps the source databases operationally independent (no heavy loads from analytics queries) while ensuring the data platform has current data for reporting and AI.

3. **Include major external systems (SAP, Oracle):** If you have large enterprise systems like **SAP or Oracle** that reside outside Azure or have very stringent uptime requirements, plan to bring their data into OneLake as well. **Best practice:** Integrate SAP and Oracle data by mirroring [SAP](/fabric/mirroring/sap) and [Oracle](/fabric/mirroring/oracle) data into Fabric, organizations create a consistent, governed pipeline from their core business systems into OneLake. Keep these platforms operationally independent while using Fabric as the single convergence layer.

## 3. Plan your data landing zones (as needed)

If your organization uses other data resources, like Azure Databricks, Azure Data Lake Storage (ADLS), or Azure Machine Learning workspaces, you should use Data landing zones (DLZs) to manage them. A data landing zone is an Azure subscription (or set of resources) that hosts data and ML/AI workloads.

### 3.1 Manage data landing zones

Each data domain that requires such resources can have its own data landing zone(s). For instance, if your Sales domain uses a Databricks workspace to process streaming data or run advanced machine learning, deploy that workspace in a dedicated DLZ for the Sales domain. This way, the domain team can manage it, and it has clear cost and resource isolation from other domains. Some domains might group multiple data products in one DLZ, while others may allocate a separate DLZ per data product.

**Option 1: Multiple data products in one DLZ.** A single data landing zone hosts several related data products.

- **When to choose:** If a data domain has several smaller data initiatives that share similar security and infrastructure needs, one DLZ can host all of them.

- **Benefit:** This simplifies governance and resource management. There’s one set of policies and infrastructure to manage, and teams within the domain can standardize their tools and deployment processes.

- **Tradeoff:** Multiple products in one DLZ means they are coupled. It can be harder to separate costs by product or to limit the blast radius of an issue. If one product has a problem, it might affect others in the same zone. Also, security or compliance settings apply to the whole zone, so you can’t easily differentiate policies between products if they have different requirements.

**Option 2: One DLZ per data product.** Each data product is deployed in its own dedicated landing zone.

- **When to choose:** If a data product is large, critical, or has unique security and compliance requirements, a dedicated landing zone is advisable.

- **Benefit:** This provides strong isolation. Each data product can be managed, secured, and even developed on its own timeline without affecting others. Costs and performance are easier to attribute to that specific product.

- **Tradeoff:** More landing zones mean more overhead in terms of managing infrastructure and potentially some duplication of services, for example, multiple distinct Databricks workspaces. It’s more complex, but sometimes necessary for regulatory or performance reasons.

Some organizations adopt a hybrid of these approaches, depending on each domain’s needs. The key is to evaluate the independence and sensitivity of each data product. If products share a lot of common data or processes and aren’t strictly separated in terms of security, a shared DLZ can work. If they need to be very separate or if you want the freedom to manage them differently, use separate DLZs.

### 3.2 Use Fabric and Databricks integration patterns

If your data platform includes Azure Databricks, it’s important to integrate it with your Microsoft Fabric OneLake environment. There are two supported integration patterns between Azure Databricks and Microsoft Fabric. The choice depends primarily on whether you are building new data products or operating an existing Databricks estate, and on where you want long‑term ownership of the lake to reside.

**Option 1: OneLake as the system of record.** In this pattern, Databricks workspaces are configured to read from and write to OneLake as their storage layer, not Azure Data Lake Storage Gen2.

- **When to choose**: Use this pattern for new projects or when you want a pure SaaS-managed storage layer. It takes advantage of OneLake’s fully managed nature and ensures that all data resides in the unified Fabric environment.

- **Benefit:** You have one authoritative data lake (OneLake) with all the governance and security of Fabric. There’s no need to manage separate storage accounts for Databricks.

- **Tradeoffs:** Setting up integration requires some initial effort, like configuring credentials and access for Databricks to OneLake. Teams used to native Databricks with its own storage might need to adjust. See [Azure Databricks integration with OneLake](/fabric/onelake/onelake-azure-databricks).

**Option 2. ADLS as system of record.** In this approach, you to use **Azure Data Lake Storage (ADLS)** Gen2 account as the primary data lake for your Databricks pipelines. Databricks writes to ADLS as usual. Microsoft Fabric then connects to that data by using **shortcuts** in OneLake. OneLake “shortcuts” point to data in ADLS so that Fabric can read it as if it were in OneLake.

- **When to choose**: Choose this model when you have an existing Databricks estate with established pipelines. Use it when teams prefer Databricks’ default PaaS storage model. This is often the fastest path when onboarding Fabric into an environment that already runs at scale on Databricks.

- **Benefit:** You don’t have to move your data or rebuild pipelines. Databricks continues operating with its own storage and processes, and Fabric users can still discover and use the curated data via OneLake shortcuts.

- **Tradeoffs:** This introduces a split in ownership and possibly a bit more complexity. Your data lake is not fully managed by Fabric. you’ll still handle ADLS operations (security, scaling) separately. There’s an extra integration step (managing the shortcuts), and because data isn’t natively in Fabric, certain Fabric features (like some governance automation or performance optimizations) might not fully apply.

- **Best Practice:** If you use this pattern, make sure to register those ADLS data sources in Purview. Create a clear process to expose data from ADLS into Fabric via shortcuts. This way, Fabric’s catalog and Purview has visibility into those datasets, and AI or analytics queries can reach them. See [Azure Data Lake Storage (ADLS) Gen2 shortcut](/fabric/onelake/create-adls-shortcut).

## Next step

> [!div class="nextstepaction"]
> [Governance and security baselines](purview-data-estate-governance-security-baselines-unify-data.md)