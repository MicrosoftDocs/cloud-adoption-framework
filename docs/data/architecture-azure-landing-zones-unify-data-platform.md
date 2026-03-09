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

After you align on why and what data products you need (organizational readiness), the next step is to decide how the technology fits together. Create an architecture that connects and integrates Microsoft Fabric with Azure and your existing systems. As a decision maker, you must design Azure environments that support a unified data platform so that your organization can standardize how data flows from operational systems into analytics and AI consumption.

**Recommendation:** Establish architecture patterns for your Azure environments. Include data management landing zones, application landing zones, and data landing zones (see Figure 1). To apply this recommendation, use this article as a checklist:

:::image type="content" source="./images/unified-data-platform-architecture-ai-analytics.svg" alt-text="Diagram showing a unified data platform architecture across Microsoft systems. Data from multiple sources is organized into data domains. They're governed in Microsoft Purview. They're ingested into Fabric OneLake and produced as data products using Fabric and Databricks. Microsoft Copilot, Foundry agents, Power BI, and data science tools consume them.":::
*Figure 1. Architecture: Unified data platform for AI and analytics.*

## 1. Plan your data management landing zones

A data management landing zone (DMLZ) is one or more Azure subscriptions for data management resources. **Recommendation:** Use DMLZs to host your Microsoft Purview account and Microsoft Fabric capacity. To apply this recommendation, use the following checklist:

:::image type="content" source="./images/azure-architecture-unified-data-platform.svg" alt-text="Diagram showing an Azure architecture for unifying a data platform with Microsoft Fabric. At the top, Microsoft Entra, Microsoft Defender, and Microsoft Purview provide organization‑wide governance and security. Azure management groups define a platform landing zone with centralized policy, monitoring, identity, security, and connectivity. Application landing zones sit under the platform. Data management landing zones host Microsoft Purview accounts that run in Microsoft Fabric capacity and govern data stored in OneLake. Separate data landing zones host Azure Databricks for data processing. Microsoft Foundry agents run in their own application landing zones and securely access governed data in OneLake through Purview. The diagram shows clear separation between platform services, data domains, and application workloads while sharing centralized governance." lightbox="./images/azure-architecture-unified-data-platform.svg" border="false":::

### 1.1 Place Microsoft Purview account in a data management landing zone

A Microsoft Purview account provides organization-wide data governance and catalog capabilities. Its placement defines ownership boundaries and governance scope across the tenant. **Best practices:** If you use Microsoft Purview for governance, deploy your Purview account into its own data management landing zone. Use one data management landing zone per Microsoft Entra ID tenant for Purview. This model matches Purview’s tenant-wide governance role and avoids fragmented control.

### 1.2 Host Microsoft Fabric capacity in data management landing zones

Compute in Microsoft Fabric is called [Fabric capacity](/fabric/enterprise/licenses#capacity). Microsoft Fabric capacity provides pooled compute for Fabric workloads, similar to Power BI capacity. **Recommendation:** Decide whether to assign Fabric capacity per data domain, share capacity across domains, or combine both approaches based on data domain maturity and usage predictability. To apply this recommendation, review the following options:

**Option 1: Choose decentralized Fabric capacities for mature data domains.** In this model, each data domain has its own DMLZs. They create and manage their own Microsoft Fabric capacity in their DMLZs. **Best practices:** Use this model when a data domain demonstrates operational maturity and stable demand. Allow the domain to control scaling decisions and budget accountability. **Decision guidance:** Decide on decentralized capacity when workloads require predictable performance and clear cost ownership. Accept higher operational overhead and possible idle capacity as tradeoffs. Smaller capacities might also limit access to some Power BI features.

**Option 2: Choose centralized Fabric capacity for early or variable usage.** In this model, you manage capacity through a central team. A centralized model places multiple data domains on one or a few shared Fabric capacities. **Best practices:** Use this model to simplify operations and improve overall capacity utilization. Central teams handle monitoring, scaling, and governance standards. **Decision guidance:** Choose centralized capacity when data domains show low maturity or fluctuating demand. Accept the risk of resource contention and reduced cost transparency without strong governance controls.

**Option 3: Use a hybrid capacity model to support growth.**  A hybrid approach keeps smaller or new data domains on shared capacity while assigning dedicated capacity to domains with sustained demand or higher criticality. You combine shared and dedicated capacity models. **Best practices:** Define clear thresholds for capacity graduation. Base thresholds on sustained usage, uptime requirements, or isolation needs. Apply consistent governance across both models.
**Decision guidance:** Choose a hybrid model when the organization expects uneven data domain growth. Accept added governance complexity as the tradeoff for flexibility and long-term scalability.

For more information, see [Deployment Patterns for Microsoft Fabric](/azure/architecture/analytics/architecture/fabric-deployment-patterns).

## 2. Integrate your application landing zones

Application landing zones host operational workloads such as business applications, services, and AI solutions that produce or consume enterprise data. These landing zones sit outside data management landing zones and usually have different owners. As a decision maker, you define how these environments interact with the unified data platform to protect governance, reduce duplication, and maintain operational independence.

**Recommendation:** Set clear integration standards that require application landing zones to access enterprise data through governed Fabric and OneLake mechanisms rather than direct or unplanned data paths. To apply this recommendation, use the following checklist:

1. **Standardize Microsoft Foundry data access.** Data access defines how applications and AI solutions retrieve governed data from OneLake. Inconsistent access patterns create shadow data copies and weaken governance controls. **Best practices:** Require application teams to use approved Fabric and Foundry integration mechanisms to access enterprise data stored in OneLake. These mechanisms include the Fabric Data Agent and Azure AI Search with Foundry IQ indexes. This approach enforces consistent governance, security, and audit controls across all consuming applications. **Decision guidance:** Choose mandatory standardized access when data sensitivity or regulatory requirements are high. This choice limits flexibility but preserves governance integrity. Avoid allowing direct database access when long-term data consistency and trust matter more than short-term convenience.

2. **Integrate Azure operational databases through Fabric mirroring.** Many application landing zones host online transaction processing (OLTP) databases that support core business operations such as sales, finance, and customer records. These systems generate critical data but can't absorb analytical workloads without risk. **Best practices:** Use Fabric  [mirroring](/fabric/mirroring/overview) to replicate selected operational data into OneLake in near real time. This approach keeps operational systems independent while providing current data for analytics and AI across the organization.

3. **Include major external systems (SAP, Oracle)  into OneLake:** Large enterprise systems such as SAP and Oracle often operate outside Azure or have strict uptime and change control requirements. These systems still represent authoritative sources of business data. **Best practices:** Integrate SAP and Oracle data into Fabric by using mirroring for [SAP](/fabric/mirroring/sap) and [Oracle](/fabric/mirroring/oracle). This model creates a consistent and governed ingestion path into OneLake while preserving the operational independence of these platforms. **Decision guidance:**
Choose Fabric mirroring when the organization needs a single convergence layer for enterprise data without disrupting core systems. This choice simplifies governance and analytics but requires clear ownership for data freshness and availability expectations.

## 3. Plan your data landing zones (as needed)

A data landing zone is an environment (consisting of one or more Azure subscriptions) for data and AI/ML resources that operate alongside Microsoft Fabric. These platforms include Azure Databricks, Azure Data Lake Storage (ADLS), and Azure Machine Learning. These platforms often serve specialized use cases that Fabric doesn't replace. As a decision maker, you define when to introduce these environments and how they integrate with the unified data platform. **Recommendation:** Use data landing zones when the organization requires data or AI platforms beyond Fabric. Integrate those environments with OneLake through governed patterns. To apply this recommendation, use the following checklist:

### 3.1 Choose how data products map to data landing zones

A data domain can group multiple data products in one data landing zone or assign each data product its own landing zone. This choice affects isolation, governance scope, and operational effort. **Recommendation:**
Align landing zone structure to the independence and sensitivity of data products within the domain. Keep the structure simple unless regulatory or operational requirements require stronger separation. To apply this recommendation, review the following options:

**Option 1: Multiple data products in one DLZ.** Choose one data landing zone for multiple data products when the products share security requirements and infrastructure standards. This option simplifies governance and reduces management overhead. Accept reduced cost separation and shared risk if one product encounters problems.

**Option 2: One DLZ per data product.** Choose one data landing zone per data product when the product is critical or requires distinct security or compliance controls. This option provides strong isolation and clear cost attribution. Accept higher operational overhead and some duplication of platform services.

**Option 3: Apply hybrid models intentionally.** Some data domains require both shared and dedicated data landing zones based on product maturity or risk. Choose a hybrid approach when some data products require isolation and others don't. Avoid inconsistent or unplanned decisions, because inconsistent structure increases governance complexity and operational risk.

### 3.2 Use Fabric and Databricks integration patterns

If your data platform includes Azure Databricks, you need to integrate it with your Microsoft Fabric OneLake environment. Two supported integration patterns exist between Azure Databricks and Microsoft Fabric. **Recommendation:** Establish decision criteria to help data domains determine where the system of record should be. To apply this recommendation, review the following options:

**Option 1: OneLake as the system of record.** In this pattern, you configure Databricks workspaces to read from and write to OneLake, not Azure Data Lake Storage Gen2. **Best practices:** Use this pattern when the organization prioritizes a single authoritative lake under Fabric governance. Centralize security and policy controls in Fabric. Reduce infrastructure management by avoiding separate Azure Data Lake Storage accounts. **Decision guidance:**
Choose this option for new data platforms or strategic rebuilds. Accept initial integration setup as a tradeoff for long-term simplicity and centralized ownership. Recognize that teams accustomed to Databricks-managed storage must align to Fabric governance and operating standards. See [Azure Databricks integration with OneLake](/fabric/onelake/onelake-azure-databricks).

**Option 2. ADLS as system of record.** In this pattern, Azure Databricks continues to write to Azure Data Lake Storage Gen2 while Microsoft Fabric accesses the same data through OneLake shortcuts that reference ADLS locations. **Best practices:** Apply this pattern to existing Databricks estates with mature pipelines. Avoid data movement or pipeline refactoring. Expose curated datasets to Fabric through managed shortcuts. Register ADLS sources in Microsoft Purview to maintain catalog visibility and governance consistency. **Decision guidance:** Choose this option when speed and continuity matter more than consolidation. Accept split ownership between ADLS operations and Fabric governance. Plan for added coordination across teams that manage storage, security, and metadata. See [Azure Data Lake Storage (ADLS) Gen2 shortcut](/fabric/onelake/create-adls-shortcut).

## Next step

> [!div class="nextstepaction"]
> [Data governance and security baselines with Purview](./governance-security-baselines-purview-data-estate-unify-data-platform.md)