---
title: Data Processing Standards for for AI and Analytics
description: "Data processing standards for AI and analytics: Discover best practices for ingesting, transforming, and publishing data in Microsoft Fabric. Ensure consistent, high-quality data."
#customer intent: As a decision maker, I want help making the right decisions and checklists of best practices to set data processing standards for my entire organization.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data processing standards for AI and analytics

A unified data platform depends on consistent ingestion, transformation, and publishing standards so leaders can trust data for analytics and AI. **Recommendation:** Establish organization‑wide standards that control what data enters OneLake, how teams refine that data, and how governed data products reach consumers (see Figure 1). To apply this recommendation, use this article as a checklist:

:::image type="content" source="images/operational-standards-unify-data-platform.svg" alt-text="Diagram showing the three major steps in setting operational standards. First, set data processing standards like how to move data through the bronze, silver, and gold layers. Second, set security standards for how to secure data products in different Microsoft services. Third, set consumption and lifecycle standards for data products." lightbox="images/operational-standards-unify-data-platform.svg" border="false":::
*Figure 1. Three steps to setting operational standards for data.*

## 1. Set data ingestion standards

Data ingestion defines cost exposure, security risk, and long‑term trust in analytics and AI. OneLake serves as the central data lake for analytics and AI in Microsoft Fabric, so leaders must control what enters that lake.
**Recommendation:** Set clear boundaries so teams ingest only data that supports defined business outcomes. To apply this recommendation, use the following checklist.

1. **Ingest data with defined business value.** Defined business value means data explains or measures a business process or outcome that leaders care about. **Best practices:** Require a clear business question or decision for every dataset proposed for OneLake. Treat ingestion as a product decision, not a technical default. **Decision guidance:** Decide to ingest data when it supports a known outcome or metric. Choose to leave data in operational systems or departmental storage when no use case exists. This choice reduces storage cost and governance overhead.

2. **Integrate operational databases through supported patterns.** Operational databases often supply analytics and AI scenarios, but direct access creates risk and instability. **Best practices:** Use Microsoft Fabric supported patterns such as [shortcuts](/fabric/onelake/onelake-shortcuts) for virtual access and [mirroring](/fabric/mirroring/overview) for replicated access. Azure databases often require mirroring for reliable integration.
**Decision guidance:** Choose shortcuts when virtual access meets performance needs. Choose mirroring when analytics performance, isolation, or downstream reuse requires a physical copy in OneLake.

3. **Integrate existing data lakes.** Many organizations already operate data lakes such as Azure Data Lake Storage (ADLS), Google Cloud Storage, or Amazon S3. **Best practices:** Treat existing lakes as part of the unified data estate rather than forcing immediate migration. Use [shortcuts](/fabric/onelake/onelake-shortcuts) or [mirroring](/fabric/mirroring/overview). **Decision guidance:** Decide based on readiness and risk. To avoid duplication, choose shortcuts. Choose mirroring when consistency, performance, or compliance outweighs duplication cost.

4. **Surface Azure Databricks outputs in OneLake.** Azure Databricks often already produces curated analytics data.
**Best practices:** Keep Databricks pipelines in place and surface final Gold outputs in OneLake. **Decision Guidance:** Choose [shortcuts](/fabric/onelake/onelake-azure-databricks) to avoid replication and when remote access meets needs. Choose  [mirroring](/fabric/mirroring/azure-databricks) when governance or consumption patterns demand local data.

5. **Separate internal and external data intake.** Internal analytics data and external‑facing data require different controls. **Best practices**: Create separate workspaces or lake areas for external data products. Store only approved external datasets in those locations. **Decision guidance:** Decide early whether data supports internal decisions or external sharing. Choose physical separation to reduce accidental exposure and simplify security policy enforcement.

## 2. Set data transformation standards

Getting data into OneLake is only the first step. The real value comes from transforming raw data into high-quality, ready-to-use data products. Leaders don't design pipelines, but they define platforms and architectural standards that prevent fragmentation. **Recommendation:** Standardize transformation platforms and enforce a consistent refinement architecture. To apply this recommendation, use the following checklist:

### 2.1. Use the right data platform

Your choice of platform sets operational requirements for your data products in Microsoft and Azure environments. **Recommendation:** For each data product, balance simplicity and integration with the need for specialized engineering capabilities. To apply this recommendation, use the following checklist:

1. **Fabric (default).** Fabric provides integrated data engineering, analytics, and BI engines that operate directly on OneLake, which acts as the unified governed data estate for the organization. **Best practices:** Use Fabric for standard analytics, reporting, and data preparation. Favor native Fabric engines such as Dataflows Gen2, Spark, and SQL to simplify access control, lineage, and cost management. Use OneLake as the single storage layer. **Decision guidance:** Choose Fabric when requirements fit built-in capabilities and when leadership values unified governance and billing. Accept limited customization in exchange for lower operational overhead.

2. **Azure Databricks.** Many people prefer Azure Databricks. It supports large‑scale processing and advanced machine learning scenarios. **Best practices:** Continue using Databricks where expertise or scale already exists. Require outputs to land in OneLake or connect through OneLake shortcuts so governance, security, and discovery remain centralized. **Decision guidance:** Choose Databricks when Fabric doesn't meet current requirements. Accept higher integration and skill overhead as the tradeoff.

3. **Enforce platform ownership boundaries.** Clear platform boundaries prevent duplicated cost and inconsistent logic across systems. **Best practices:** Assign responsibility for each class of workload to one platform. Require architectural review before approving cross-platform processing. **Decision guidance:** Decide which platform owns ingestion, transformation, and analytics outcomes. Prevent duplicate transformations and overlapping pipelines that deliver the same business result.

### 2.2. Apply medallion architecture

The medallion architecture establishes trust, consistency, and governance across all data products by defining a clear progression from raw data to business-ready outputs. **Recommendation:** Require all data products in OneLake to follow a bronze, silver, and gold structure and prohibit shortcuts that bypass these layers. To apply this recommendation, use the following checklist:

1. **Mandate a bronze layer as the system of record (raw ingestion)**: The bronze layer captures data exactly as it arrives in OneLake and preserves original source fidelity. **Best practices:** Store data as append-only and immutable. Prohibit corrections or enrichment at this stage. Require every inbound dataset to land in bronze first. **Decision guidance:** Decide that bronze exists only to preserve truth from source systems. Accept slower usability in exchange for auditability and traceability.

2. **Establish the silver layer as the trusted view.** The silver layer holds validated, standardized, and cleansed data that teams rely on for consistent analysis. **Best practices:** Apply data quality rules, format alignment, and basic business validation. Document silver datasets clearly and manage changes through governance processes.
**Decision guidance:** Choose silver as the authoritative cleansed layer. Prohibit teams from recleaning raw data independently, which creates conflicting interpretations.

3. **Gold (business context, data products)**: Certify gold datasets as business data products. The gold layer delivers governed data products that leaders use for decisions, performance tracking, and reporting. **Best practices:** Align gold data to approved business definitions and metrics. Optimize structures for consumption. Register every gold dataset as a data product in Microsoft Purview with ownership, purpose, and refresh details. **Decision guidance:** Decide that any dataset used across teams or for decisions must exist in gold. Reject unmanaged or uncertified datasets that bypass governance.

4. **Create sanitized products for external use.** External sharing requires deliberate separation from internal operational data. **Best practices:** Produce curated datasets that remove or mask sensitive fields and reduce detail where required. Assign ownership and apply clear labels such as Public or External use. Store these datasets in approved locations. **Decision guidance:** Choose to treat external datasets as independent products. Accept added governance steps to reduce legal and security risk.

Fabric supports this model through [materialized lake views](/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view) that can automatically manage the transformations. See [Medallion Lakehouse Architecture in Fabric](/fabric/onelake/onelake-medallion-lakehouse-architecture). For an analytics architecture, see [Analytics End-to-End with Microsoft Fabric](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end).

*Table. Example medallion architecture. Gold layer combines data from two datasets.*

| Dataset | Layer | Example Data | What happened |
| ---- | ---- | ---- | ---- |
| *Sales transactions* | *Bronze* | *OrderID=984321 · StoreID=17 · Amount="1,200" · TxnDate="2026-01-05T14:32:09Z"* | *This record arrived from the sales system exactly as sent. Amount is text. Timestamp follows system format. No meaning is applied.* |
| | *Silver* | *OrderID=984321 · StoreID=17 · Amount=1200.00 · TxnDate=2026-01-05* | *The transaction is standardized and validated. Amount is numeric. Date follows enterprise rules. Data is now trustworthy.* |
| *Store reference* | *Bronze* | *StoreID="17" · RegionName="EAST "* | *This record arrived from a location system. Formatting reflects the source.* |
| | *Silver* | *StoreID=17 · Region=East* | *Store identifiers align with sales data. Region values are cleaned and consistent.* |
| *Daily revenue by region* | *Gold* | *Region=East · Date=2026-01-05 · TotalRevenue=425000* | *This value combines Silver sales transactions with Silver store reference data. Individual records are summarized to answer a business question.* |

### 2.3. Consider an adaptive gold layer

Adaptive Gold is included here as a forward‑looking consideration. The idea is that you use AI agents to create gold layers. Agents can observe patterns that you might not be able to. If users frequently ask for "top customer issues by region per month," AI agents can materialize that dataset. This capability isn't provided out of the box in Microsoft Fabric today. It would require building a custom AI agent that operates on Fabric and Power BI telemetry.

## 3. Set data product publishing standards

Publishing standards define how your organization exposes trusted data products through Microsoft Fabric OneLake and Microsoft Purview. The goal is to scale reuse, enforce governance, and reduce risk across analytics and AI workloads.
**Recommendation:** Establish a single publishing standard that makes every approved data product discoverable, governed, and clearly intended for a defined audience before broad use. To apply this recommendation, use the following checklist:

1. **Standardize publication through OneLake Catalog.** OneLake Catalog provides a unified access surface for data products across Fabric and external processing platforms such as Databricks. **Best practices:** Use OneLake as the default execution and consumption layer for all approved data products. Treat Microsoft Purview as the system of record for governance and business definitions. This alignment allows Power BI, Fabric data agents, and Azure AI Search to consume data consistently while enabling centralized governance visibility.

2. **Ensure discoverability.** Discoverability ensures decision makers and consumers can find trusted data products without relying on informal knowledge. **Best practices:** Configure Fabric workspace visibility so relevant audiences can discover items. They don't need access, just the ability to request access. Enable [Purview access request workflows](/purview/unified-catalog-workflows) so users can request permission directly from the catalog. **Decision guidance:** Choose broad discoverability when the goal is reuse across domains. Choose limited discoverability when regulatory or confidentiality constraints apply. Balance visibility with access controls rather than hiding assets.

3. **Mandate metadata enrichment at publication.** Metadata provides context that allows leaders to assess fitness, trust, and reuse of a data product. **Best practices:** Require descriptive metadata at publication. Use [tags in Fabric](/fabric/governance/tags-overview) to classify products by business domain or initiative. Ensure descriptions explain purpose and data scope. This practice supports catalog search and improves confidence in reuse.
**Decision guidance:** Decide whether metadata requirements remain minimal or enforce a standard schema. Choose a standard schema when the organization operates multiple domains and needs consistency. Choose a lighter approach for early maturity stages.

4. **Endorse and certify when appropriate.** Define endorsement and certification criteria.
Endorsement signals trust level and governance maturity to the organization. **Best practices:** Use Promoted to indicate domain-recommended products. Use Certified to indicate products that passed formal governance review. Apply certification to Gold datasets that support executive reporting or critical analytics. Reference Fabric endorsement guidance at [Endorsement](/fabric/governance/endorsement-overview). **Decision guidance:** Decide which products require certification. Choose mandatory certification for executive or regulatory workloads. Choose optional certification when speed and experimentation take priority. Accept slower onboarding as the tradeoff for higher trust.

5. **Publish as a data product in Purview.** Purview data products provide a higher-level view that groups assets into a managed product lifecycle. **Best practices:** Create a Purview data product entry for each published data product. Include product name, description, owners, quality status, and related assets such as tables, models, and reports. Reference [Data Products in Unified Catalog.](/purview/unified-catalog-data-products). **Decision guidance:**
Decide whether Purview data products are required for all published assets or only for strategic products. Choose full coverage when portfolio visibility matters. Choose selective coverage when governance capacity is limited.

6. **Declare intended audience and usage.** Clear intent prevents misuse and supports compliance across analytics and AI scenarios. **Best practices:** Require each data product to state its intended audience and supported workload type. Specify internal, partner, or public use. Identify AI, analytics, BI, or public web scenarios. Use Purview [metadata](/purview/unified-catalog-custom-metadata), [glossary terms](/purview/unified-catalog-glossary-terms), and [sensitivity labels](/purview/data-map-sensitivity-labels) together to express this intent consistently. **Decision guidance:** Decide whether external or agent use requires extra approval. Choose stricter approval when data leaves organizational boundaries. Accept slower publication as the tradeoff for reduced risk.

## Next step

> [!div class="nextstepaction"]
> [Data security standards](./operational-standards-data-product-security-standards-unify-data-platform.md)
