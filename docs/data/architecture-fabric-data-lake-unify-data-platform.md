---
title: Fabric architecture for a Unified Data Platform
description: "Fabric architecture: Discover how to design your Fabric architecture to create a unified data platform with Microsoft Purview and Azure."
#customer intent: As a technical decision maker (enterprise architect, CTO, VP, director), I want to make the right technology adoption decisions and design them to integrate into my existing systems, creating a unified data platform with Microsoft Fabric, Microsoft Purview, and Azure so that my organization can standardize data value for analytics and AI consumption.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Fabric architecture for a unified data platform

After aligning on why and what data products you need (organizational readiness), the next step is to decide how the technology fits together. This step involves creating an architecture that connects and integrates Microsoft Fabric with Azure.

This article helps you make the right architecture decisions for designing **Microsoft Fabric** as the foundation of your unified data platform. Microsoft Fabric provides a data platform with a built‑in SaaS data lake called [OneLake](/fabric/onelake/onelake-overview) that centralizes data for analytics and AI across the organization.

**Recommendation:** Adopt Microsoft Fabric with OneLake as the default analytics data platform and define clear leadership decisions for compute, regions, recovery, and workspace ownership. This setup enables all workload teams to operate within consistent standards (see Figure 1). To apply this recommendation, use this article as a checklist:

## Unified data platform architecture

Figure 1 shows an integrated Fabric‑in‑Azure architecture aligned to data domains, with enough operational structure to make the design concrete. It serves as a reference model to help organizations design and standardize their architecture.

:::image type="content" source="./images/unified-data-platform-architecture-ai-analytics.svg" alt-text="Diagram showing a unified data platform architecture across Microsoft systems. Data from multiple sources is organized into data domains. They're governed in Microsoft Purview. They're ingested into Fabric OneLake and produced as data products using Fabric and Databricks. Microsoft Copilot, Foundry agents, Power BI, and data science tools consume them." lightbox="./images/unified-data-platform-architecture-ai-analytics.svg" border="false":::
*Figure 1. Architecture: Unified data platform for AI and analytics.*

## 1. Plan for Fabric compute

You get compute in Microsoft Fabric through *capacity*. Each Fabric environment runs on a Fabric capacity, which determines available compute resources, concurrency, and performance characteristics for all workloads within that environment. Allocate budgets to data domain teams and allow them to create their own Fabric capacities sized to their requirements. They should have their own dedicated Azure subscription for capacity deployment. In early stages or for simpler environments, you can share a single Fabric capacity across multiple data domains. To learn more, see [Deployment Patterns for Microsoft Fabric](/azure/architecture/analytics/architecture/fabric-deployment-patterns).

## 2. Plan Fabric deployment

A region is the physical location where Microsoft Fabric stores and processes data. It affects performance and legal compliance. **Best practices:** Establish region selection as a central governance decision rather than a local team decision. Leading organizations define approved regions based on data residency rules and user location patterns. **Decision guidance:**

- **Single region:** Choose a single region when data laws allow it and most users are nearby. The tradeoff is higher latency for distant users.

- **Multiple regions:** Choose multiple regions when laws require local storage or large user groups need local performance. This choice improves compliance and experience but increases operational complexity.

## 3. Plan for Fabric disaster recovery

In Fabric, the disaster recovery (DR) features copy data to a paired region so workloads can resume after a regional failure. Decide whether to enable DR for your Fabric capacities. When you enable it, Fabric’s DR capability asynchronously copies OneLake data to a paired region. If one region suffers an outage, Fabric workloads can fail over to the backup region. **Best practices:** Enable disaster recovery for capacities that support critical business reporting or regulated data. Treat this decision as a business continuity decision owned by leadership. To learn more, see [OneLake Disaster Recovery and Data Protection](/fabric/onelake/onelake-disaster-recovery).

## 4. Plan your Fabric workspaces

In Microsoft Fabric, the primary unit of organization is the [Fabric workspace](/fabric/fundamentals/workspaces). A Fabric workspace is a container that groups datasets, dataflows, lakehouses, reports, and other related assets. It's also the main unit for security administration, access control, and cost management in Fabric. When designing your OneLake environment, plan how to allocate workspaces across data domains and products (see [Fabric environments governance baseline](./governance-security-baselines-fabric-data-lake-unify-data-platform.md#1-set-fabric-environment-governance-baseline)). This choice affects governance and resource isolation.

**Best practices:** Plan to give each data domain one or more dedicated Fabric workspaces. This approach aligns with your organizational structure and ensures that each domain can control access and management of its own data products. Fabric also offers a concept of [Fabric domains](/fabric/governance/domains) (governance groups of workspaces) to help manage policies across multiple workspaces owned by a domain or department (see Figure 2).

:::image type="content" source="./images/fabric-architecture-data-domains-workspaces.svg" alt-text="Diagram showing the high‑level Microsoft Fabric architecture. Microsoft Fabric provides shared intelligence, analytics services, and a single data lake for the organization. Fabric includes Data Factory, Real‑Time Intelligence, Databases, Data Engineering, and Data Warehouse. Power BI and data science are used for reporting and AI model training. All data is stored in OneLake, which includes the OneLake catalog and published data products. Each data domain works in its own Fabric workspace, such as Data Domain 1, Data Domain 2, Data Domain 3, and others. All domains share OneLake while managing their data independently through their workspaces." lightbox="./images/fabric-architecture-data-domains-workspaces.svg" border="false":::
*Figure 2. Microsoft Fabric architecture.*

## Next step

> [!div class="nextstepaction"]
> [Azure architecture for a unified data platform](./architecture-azure-landing-zones-unify-data-platform.md)
