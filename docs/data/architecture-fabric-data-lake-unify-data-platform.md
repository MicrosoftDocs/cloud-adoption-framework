---
title: Fabric Architecture for a Unified Data Platform
description: "Fabric architecture: Discover how to design your Fabric architecture to create a unified data platform with Microsoft Purview and Azure."
#customer intent: As a technical decision maker (enterprise architect, CTO, VP, director), I want to make the right technology adoption decisions and design them to integrate into my existing systems, creating a unified data platform with Microsoft Fabric, Microsoft Purview, and Azure so that my organization can standardize data value for analytics and AI consumption.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/10/2026
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

Fabric compute runs on capacity, which defines available resources, performance, and concurrency for all workloads that share that capacity. Capacity choices directly affect cost control and service reliability. **Best practices:** Allocate budgets to data domain teams and allow those teams to own Fabric capacities that match their business criticality. Create each Fabric capacity in a data management landing zone. To learn more, see [Data management landing zones](./architecture-azure-landing-zones-unify-data-platform.md#1-plan-your-data-management-landing-zones).

## 2. Plan your Fabric regions

Each Fabric capacity runs in a single Azure region. That region determines where compute and OneLake data for workspaces on that capacity reside. Region decisions affect data residency, latency, and service availability. **Best practices:** treat region selection as a governance decision. Publish a short list of supported regions and enforce that list through policy. **Decision guidance:** Decide whether to use [Multi‑Geo](/fabric/admin/service-admin-premium-multi-geo). Choose Multi‑Geo when the organization needs formal governance across regions and clear rules for why regions exist. Multi‑Geo is unnecessary when operations remain confined to a single geography.

## 3. Plan your Fabric workspaces

A [Fabric workspace](/fabric/fundamentals/workspaces) groups data assets and acts as the primary boundary for security, administration, and cost visibility. Workspace design shapes how domains operate inside OneLake. **Best practices:** Give each data domain one or more dedicated workspaces to manage its data products. Apply access control, cost tracking, and operational policies at the workspace level. Use [Fabric domains](/fabric/governance/domains) to apply shared governance across related workspaces (see Figure 2).

:::image type="content" source="./images/fabric-architecture-data-domains-workspaces.svg" alt-text="Diagram showing the high‑level Microsoft Fabric architecture. Microsoft Fabric provides shared intelligence, analytics services, and a single data lake for the organization. Fabric includes Data Factory, Real‑Time Intelligence, Databases, Data Engineering, and Data Warehouse. Power BI and data science are used for reporting and AI model training. All data is stored in OneLake, which includes the OneLake catalog and published data products. Each data domain works in its own Fabric workspace, such as Data Domain 1, Data Domain 2, Data Domain 3, and others. All domains share OneLake while managing their data independently through their workspaces." lightbox="./images/fabric-architecture-data-domains-workspaces.svg" border="false":::
*Figure 2. Microsoft Fabric architecture.*

## 4. Plan for Fabric IQ

[Fabric IQ](/fabric/iq/overview) provides a semantic intelligence layer over OneLake. This layer defines shared business concepts that analytics tools and AI agents can interpret consistently. **Best practices:** Use Fabric IQ to provide shared meaning across data domains. Focus on scenarios where shared definitions reduce reporting risk or improve AI outcomes. **Decision guidance:** See the following guidance to [choose the right Fabric IQ capability](/fabric/iq/overview#choose-the-right-item).

## 5. Plan for Fabric disaster recovery

Fabric disaster recovery copies OneLake data to a paired Azure region. This capability supports workload recovery after a regional outage. **Best practices:** Treat Fabric disaster recovery as a business continuity decision. Enable disaster recovery where business impact justifies. **Decision guidance:** Decide to enable disaster recovery when downtime creates material risk. Choose not to enable it for exploratory or noncritical workloads. To learn more, see [OneLake Disaster Recovery and Data Protection](/fabric/onelake/onelake-disaster-recovery).

## Next step

> [!div class="nextstepaction"]
> [Azure architecture for a unified data platform](./architecture-azure-landing-zones-unify-data-platform.md)
