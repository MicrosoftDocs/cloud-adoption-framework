---
title: Data Processing Standards for a Unified Data Platform
description: "Data processing standards: Discover best practices for ingesting, transforming, and publishing data in Microsoft Fabric. Ensure consistent, high-quality data."
#customer intent: As a decision maker, I want help making the right decisions and checklists of best practices to set data processing standards for my entire organization.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: 
ms.collection: ce-skilling-ai-copilot
---

# Data processing standards for a unified data platform

A unified data platform depends on consistent ingestion, transformation, and publishing standards so leaders can trust data for analytics and AI. **Recommendation:** Establish organization‑wide standards that control what data enters OneLake, how teams refine that data, and how governed data products reach consumers. Here’s a checklist.

## 1. Set data ingestion standards

Data ingestion defines cost exposure, security risk, and long‑term trust in analytics and AI. OneLake serves as the central data lake for analytics and AI in Microsoft Fabric, so leaders must control what enters that lake.
**Recommendation:** Set clear boundaries so teams ingest only data that supports defined business outcomes.
Here’s a checklist.

1. **Ingest data with defined business value.** Defined business value means data explains or measures a business process or outcome that leaders care about. **Best practices:** Require a clear business question or decision for every dataset proposed for OneLake. Treat ingestion as a product decision, not a technical default. **Decision guidance:** Decide to ingest data when it supports a known outcome or metric. Choose to leave data in operational systems or departmental storage when no use case exists. This choice reduces storage cost and governance overhead.

2. **Integrate operational databases through supported patterns.** Operational databases often supply analytics and AI scenarios, but direct access creates risk and instability. **Best practices:** Use Microsoft Fabric supported patterns such as [shortcuts](/fabric/onelake/onelake-shortcuts) for virtual access and [mirroring](/fabric/mirroring/overview) for replicated access. Azure databases often require mirroring for reliable integration.
**Decision guidance:** Choose shortcuts when virtual access meets performance needs. Choose mirroring when analytics performance, isolation, or downstream reuse requires a physical copy in OneLake.

3. **Integrate existing data lakes.** Many organizations already operate data lakes such as Azure Data Lake Storage (ADLS), Google Cloud Storage, or Amazon S3. **Best practices:** Treat existing lakes as part of the unified data estate rather than forcing immediate migration. Use [shortcuts](/fabric/onelake/onelake-shortcuts) or [mirroring](/fabric/mirroring/overview). **Decision guidance:** Decide based on readiness and risk. Choose shortcuts to avoid disruption. Choose mirroring when consistency, performance, or compliance outweighs duplication cost.

4. **Surface Azure Databricks outputs in OneLake.** Azure Databricks often already produces curated analytics data.
**Best practices:** Keep Databricks pipelines in place and surface final Gold outputs in OneLake. **Decision Guidance:** Choose [shortcuts](/fabric/onelake/onelake-azure-databricks) to avoid replication and when remote access meets needs. Choose  [mirroring](/fabric/mirroring/azure-databricks) when governance or consumption patterns demand local data.

5. **Separate internal and external data intake.** Internal analytics data and external‑facing data require different controls. **Best practices**: Create separate workspaces or lake areas for external data products. Store only approved external datasets in those locations. **Decision guidance:** Decide early whether data supports internal decisions or external sharing. Choose physical separation to reduce accidental exposure and simplify security policy enforcement.

## 2. Set data transformation standards

Getting data into OneLake is only the first step. The real value comes from transforming raw data into high-quality, ready-to-use data products. Leaders do not design pipelines, but they define platforms and architectural standards that prevent fragmentation. **Recommendation:** Standardize transformation platforms and enforce a consistent refinement architecture. Here’s a checklist.

### 1. Use the right data platform

Platform choice sets the foundation for governance, cost control, and operational consistency across all analytics and data products in Microsoft and Azure environments.**Recommendation:** For each data product, balance simplicity and  integration with the need for specialized engineering capabilities. Here's a checklist:

1. **Fabric (default).** Fabric provides integrated data engineering, analytics, and BI engines that operate directly on OneLake, which acts as the unified governed data estate for the organization. **Best practices:** Use Fabric for standard analytics, reporting, and data preparation. Favor native Fabric engines such as Dataflows Gen2, Spark, and SQL to simplify access control, lineage, and cost management. Use OneLake as the single storage layer to avoid fragmented data estates. **Decision guidance:** Choose Fabric when requirements fit built-in capabilities and when leadership values unified governance and billing. Accept limited customization in exchange for lower operational overhead.

2. **Azure Databricks.** Azure Databricks is a preferred by many. It supports large‑scale processing and advanced machine learning scenarios. **Best practices:** Continue Databricks use where expertise or scale already exists. Require outputs to land in OneLake or connect through OneLake shortcuts so governance, security, and discovery remain centralized. **Decision guidance:** Choose Databricks when Fabric does not meet current requirements. Accept higher integration and skill overhead as the tradeoff.

3. **Enforce platform ownership boundaries.** Clear platform boundaries prevent duplicated cost and inconsistent logic across systems. **Best practices:** Assign responsibility for each class of workload to one platform. Require architectural review before approving cross-platform processing. **Decision guidance:** Decide which platform owns ingestion, transformation, and analytics outcomes. Prevent duplicate transformations and overlapping pipelines that deliver the same business result.

### 2. Apply medallion architecture

The medallion architecture establishes trust, consistency, and governance across all data products by defining a clear progression from raw data to business-ready outputs. **Recommendation:** Require all data products in OneLake to follow a bronze, silver, and gold structure and prohibit shortcuts that bypass these layers. To act on this recommendation, use this checklist:

1. **Mandate a bronze layer as the system of record (raw ingestion)**: The bronze layer captures data exactly as it arrives in OneLake and preserves original source fidelity. **Best practices:** Store data as append-only and immutable. Prohibit corrections or enrichment at this stage. Require every inbound dataset to land in bronze first, even for rapid downstream use. **Decision guidance:** Decide that bronze exists only to preserve truth from source systems. Accept slower usability in exchange for auditability and traceability.

2. **Establish the silver layer as the trusted view.** The silver layer holds validated, standardized, and cleansed data that teams rely on for consistent analysis. **Best practices:** Apply data quality rules, format alignment, and basic business validation. Document silver datasets clearly and manage changes through governance processes.
**Decision guidance:** Choose silver as the authoritative cleansed layer. Prohibit teams from re-cleaning raw data independently, which creates conflicting interpretations.

3. **Gold (business context, data products)**: Certify gold datasets as business data products. The gold layer delivers governed data products that leaders use for decisions, performance tracking, and reporting. **Best practices:** Align gold data to approved business definitions and metrics. Optimize structures for consumption. Register every gold dataset as a data product in Microsoft Purview with ownership, purpose, and refresh details. **Decision guidance:** Decide that any dataset used across teams or for decisions must exist in gold. Reject unmanaged or uncertified datasets that bypass governance.

4. **Create sanitized products for external use.** External sharing requires deliberate separation from internal operational data. **Best practices:** Produce curated datasets that remove or mask sensitive fields and reduce detail where required. Assign ownership and apply clear labels such as Public or External use. Store these datasets in approved locations. **Decision guidance:** Choose to treat external datasets as independent products. Accept added governance steps to reduce legal and security risk.

Fabric supports this model through [materialized lake views](/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view) can automatically manage the transformations. See [Medallion Lakehouse Architecture in Fabric](/fabric/onelake/onelake-medallion-lakehouse-architecture). For an analytics architecture, see [Analytics End-to-End with Microsoft Fabric](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end).

*Table. Example medallion architecture. Gold layer combines data from two datasets.*
| Dataset | Layer | Example Data | What happened |
|----|----|----|----|
| *Sales transactions* | *Bronze* | *OrderID=984321 · StoreID=17 · Amount="1,200" · TxnDate="2026-01-05T14:32:09Z"* | *This record arrived from the sales system exactly as sent. Amount is text. Timestamp follows system format. No meaning is applied.* |
|  | *Silver* | *OrderID=984321 · StoreID=17 · Amount=1200.00 · TxnDate=2026-01-05* | *The transaction is standardized and validated. Amount is numeric. Date follows enterprise rules. Data is now trustworthy.* |
| *Store reference* | *Bronze* | *StoreID="17" · RegionName="EAST "* | *This record arrived from a location system. Formatting reflects the source.* |
|  | *Silver* | *StoreID=17 · Region=East* | *Store identifiers align with sales data. Region values are cleaned and consistent.* |
| *Daily revenue by region* | *Gold* | *Region=East · Date=2026-01-05 · TotalRevenue=425000* | *This value combines Silver sales transactions with Silver store reference data. Individual records are summarized to answer a business question.* |

### 3. Consider an Adaptive gold layer

Adaptive Gold is included here as a forward‑looking consideration. The idea is that you use AI agents to create gold layers. Agents can observe patterns that we might not be able to. If users frequently ask for “top customer issues by region per month,” AI agents can materialize that dataset. This capability is not provided out of the box in Microsoft Fabric today. It would require building a custom AI agent that operates on Fabric and Power BI telemetry.

## 5. Set data product publishing standards

After transforming data into valuable products, the next operational step is to publish these data products in a way that makes them easy to discover, understand, and use across the organization (or even externally, if intended). Publishing is more than just putting data into OneLake. It involves adding the necessary context and access so that the data product can actually deliver value. **Best practices checklist:**

1. **Use the OneLake Catalog:** All approved data products, regardless of where they were processed (Fabric, Databricks), should be made available through OneLake Catalog. OneLake is your standardized storage and access layer for data products. By ensuring everything is in OneLake, you simplify integration with tools like Power BI, Fabric data agents, Azure AI Search, and other consumption methods. It also means Purview can see and govern all the data products in one place.

    - **OneLake** is the execution and consumption surface for data products
    - **Microsoft Purview** is the governance and business definition system of record

2. **Ensure discoverability.** The data product must be published in the **OneLake data catalog** with appropriate visibility. The Fabric workspace where the data product lives should be visible (at least in a discoverable sense) to the relevant audiences. Use Purview’s catalog and **Fabric’s item endorsement** features to boost visibility. For example, mark key datasets as “Promoted” or “Certified” in Fabric so users know which ones are official.  Set permissions such that users who might need the data can request access if they don’t have it. Purview can enable a workflow where a user finds a dataset and can ask the owner for permission. 

3. **Enrich with metadata**. As you publish, enrich each data product so that consumers can find, understand, and trust it. Adding descriptive [tags in Fabric](/fabric/governance/tags-overview) helps keep the catalog organized, making it easier for users to locate resources by business domain or project.

4. **Endorse and certify when appropriate**: Endorsement in Fabric allows data owners to mark a data product as *Promoted* (“this is useful and somewhat validated”) or *Certified* (“this has been through a formal governance review and is a trusted source”). **Best practice:** Create a process for certification of critical data products. For example, require that a Gold dataset feeding executive reports is reviewed by a governance board or data steward, then mark it as Certified. This gives users confidence. Promoted can be a lighter-weight, interim step to indicate a dataset is recommended by its domain owners even if not formally certified. See [Endorsement](/fabric/governance/endorsement-overview).

5. **Publish as a data product in Purview.** Microsoft Purview has a concept of *data products* in its catalog. It groups together a set of data assets and metadata into a higher-level product view. When you publish a data product, consider creating a data product entry in Purview. This would include the product’s name, description, the list of underlying data assets (tables, reports, models that constitute the product), owners, and quality status. It provides a one-stop summary in the catalog. This is useful for consumers to get the full picture of a data product and for you to manage the lifecycle at a product level. See [Data Products in Unified Catalog.](/purview/unified-catalog-data-products)

6. **Declare intended audience and usage.** Make it clear who the data product is intended for and how it should (and shouldn’t) be used.** Best practice:** Specify whether the product is for internal teams, partners, or public consumption, and whether it supports analytics, BI, agentic, or public web workloads. Products intended for external agentic experiences must include an approved external purpose. Use Purview [**metadata**](/purview/unified-catalog-custom-metadata), [**glossary terms**](/purview/unified-catalog-glossary-terms), and [**sensitivity labels**](/purview/data-map-sensitivity-labels) work together to express this intent consistently.