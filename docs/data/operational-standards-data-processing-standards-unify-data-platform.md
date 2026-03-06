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

This article provides standards and best practices for processing data in Microsoft Fabric. It covers how to ingest data into OneLake, transform it by using the medallion architecture, and publish it as a governed data product. Use these standards to make sure your organization produces consistent, high-quality data that people across the business can discover, trust, and use.

These standards are intended for data leaders and decision-makers who are responsible for setting organizational policy. You don't need to write code to apply this guidance, but you do need to make key choices about how your teams ingest, transform, and publish data.

## 1. Set data ingestion standards

Each data domain is responsible for ingesting the raw data needed to create its data products into OneLake (the central data lake). The guiding principle is to only ingest data that has a clear purpose for analytics or AI. Avoid dumping data “just in case”. Focus on data that will drive decisions, insights, or automation. Here's a checklist:

1. **Only ingest data with clear business value.** Identify the data that truly supports the creation of useful data products. A simple test is to ask: *“Does this dataset help explain or measure a business process or outcome we care about?”* If yes, plan to bring it into OneLake. If not, consider leaving it where it is (for example, in an operational system or a departmental SharePoint) until there is a clear use case. This reduces unnecessary storage, improves cost control, and helps teams concentrate on data that produces measurable value.

2. **Integrate operational databases.** Microsoft Fabric provides two primary methods: [Shortcuts](/fabric/onelake/onelake-shortcuts) (virtual ingestion) and [mirroring](/fabric/mirroring/overview) (replication). Mirroring is often required for data in Azure databases. This creates a direct and reliable intake path for new sources and keeps OneLake at the center of future data products.

3. **Integrate existing data lakes.** Many organizations have data lakes, like ADLS in Azure, Google Cloud Storage, or Amazon S3. The data can often stay where it is. OneLake [shortcuts](/fabric/onelake/onelake-shortcuts) make this data visible inside Fabric without moving or copying anything. [Mirroring](/fabric/mirroring/overview) becomes the right choice when a synchronized copy inside OneLake improves performance or simplifies downstream operations. Both options allow Fabric, Purview, and AI workloads to treat the existing lake as part of a unified foundation while avoiding any disruption to current processes.

4. **Ingest Azure Databricks outputs.** Keep existing Azure Databricks pipelines running as is. At a minimum, surface the final Gold datasets into OneLake. This approach preserves your investments in Databricks while enabling centralized discovery and use of that data through Fabric and Purview. **Decision Guidance:** Use [shortcuts](/fabric/onelake/onelake-azure-databricks) for Databricks outputs if the performance of reading them remotely is fine and if you want to avoid duplication. Use [mirroring](/fabric/mirroring/azure-databricks) if you need the data to be physically present in OneLake for performance or governance reasons.

5. **Separate internal vs. external data.** Organize your data ingestion such that any data intended for external sharing or public use is kept separate from strictly internal data. For example, you might have a workspace or lake folder for “External Data Products” that contains only data cleared for clients or partners.  It reduces the risk that sensitive internal data accidentally gets exposed to external users because it was mixed together. It also simplifies applying different security policies to external-facing data versus internal data.

## 2. Set data transformation standards

Getting data into OneLake is only the first step. The real value comes from transforming raw data into high-quality, ready-to-use data products. This typically involves cleaning, integrating, and aggregating data, which can be a complex technical process. As a decision-maker, you don’t need to write the code, but you do need to set standards and make key choices about *how* your organization will perform these data transformations. Two major considerations are choosing the right processing platform and enforcing a standard architecture for data refinement.

### 1. Use the right data platform

Platform selection should align with your data assessment and target data architecture. For each data product, balance simplicity and native integration with the need for specialized engineering capabilities. Regardless of platform choice, all processing should operate over the same governed data estate to avoid fragmentation and duplicated logic.

1. **Fabric (default).** Microsoft Fabric provides built-in engines for data transformation: Dataflows Gen2 (for data integration pipelines), Spark (for big data processing with notebooks), and SQL-based processing (for data warehousing and analytics). In many cases, these will cover your needs and have the advantage of being tightly integrated with OneLake and the rest of Fabric. **When to choose:** Choose Fabric when standard data engineering, BI, or analysis tasks are required, and especially if teams are already familiar with tools like Power Query, SQL, or Spark and can adapt to Fabric’s version of them. 

2. **Azure Databricks.** Many organizations also use Azure Databricks or other platforms for certain workloads, such as large-scale data processing or advanced machine learning. You may even have existing data pipelines in Databricks or other tools. **When to choose:** Choose Databricks when you have existing expertise there or needs that go beyond Fabric’s current capabilities. **Tradeoff:** Using multiple platforms means you must put more effort into integration and governance. Use OneLake and Purview to bridge the gap. It could also mean higher overhead in terms of skillsets required and duplicated data. **Best practices:** Don’t create new silos.  If you use Azure Databricks (or another platform), ensure it operates on the *same unified data lake*. For instance, you might continue to use Databricks for specialized tasks but still store the output in OneLake (or use shortcuts to link the storage) so that governance, discovery, and downstream usage remain unified. The key is to avoid parallel, disconnected data pipelines that produce conflicting results.

**Standards to enforce:** Ensure you’re not paying twice for the same outcome. Factor in the cost model and licensing of each option. Fabric capacity is a straightforward way to get a bundle of capabilities. Databricks is a PaaS platform in Azure with its own cos. For example, running a transformation in Databricks and then again in Fabric would be wasteful. Aim for clear delineation: which tool does what, and avoid overlaps.

In summary, make platform decisions with a bias toward simplicity and integration, but remain open to using the right tool for the job if needed. Crucially, all platforms should feed into the unified data lake and governance framework. 

### 2. Apply medallion architecture

Adopt the medallion architecture as the standard for creating data products. Successful organizations use this model for governance. The medallion architecture uses three layers of data transformation: bronze (raw), silver (trusted), gold (data product). Data moves forward only. This prevents disagreement about which data is correct. Here’s the structure to follow:

1. **Bronze (raw ingestion)**: The Bronze layer is the system of record. It captures data exactly as it enters OneLake. Data is immutable and append only. Nothing is corrected or enriched at this stage. **Standard to enforce:** Every piece of data that comes into OneLake should land in a Bronze area first, even if it’s quickly transformed afterward. Teams should not directly modify or use raw data without going through this layering, to avoid confusion about what’s original data.

2. **Silver (validated)**: The Silver layer represents trust. Data here is cleaned, validated, and standardized. Errors are removed. Formats are aligned. Basic business rules are applied. **Standard to enforce: ** Data in the Silver layer should be considered the official cleansed data for the organization. Once data is in Silver, teams should not need to go back to raw sources for cleansed data. This means governance of the Silver layer is critical. It should be well documented, and changes should be managed.

3. **Gold (business context, data products)**: The Gold layer delivers value. It contains certified business data products that leaders rely on to run the business. Data is aligned to business definitions. Metrics and KPIs are clear and approved. Conflicting numbers are eliminated. **Best practices:** Design Gold data with the end-user in mind. These datasets should be optimized for easy consumption. They might have business-friendly column names, predefined calculations (like year-to-date totals, common KPIs), and performance optimizations (indexes, pre-aggregations). Ensure that every Gold dataset is registered in **Microsoft Purview as a data product**, with clear metadata (description, owner, update schedule, so any user or system can discover and trust it). **Standard to enforce:** No “rogue” data products. Every dataset that is used for important decisions or by multiple teams must be in the Gold layer (or certified as such), meaning it’s governed.

4. **Sanitize data for external use:** If you do need to share some internal data with external parties (or make it public), do not share the raw internal dataset directly. Instead, create a sanitized, curated version of the data specifically for that purpose. This might involve removing or masking any sensitive or personal information, aggregating detailed data into summary statistics, and thoroughly reviewing it for compliance. Treat this sanitized dataset as its own data product. Give it an owner, document its contents and purpose, apply appropriate labels (“Public” or “External Use”), and ensure it’s stored in a location designated for external data. This way, when external consumers access it, they get only what they are supposed to, and the truly sensitive internal data remains protected. 

In Fabric, [Materialized lake views](/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view) can automatically manage the transformations. See [Medallion Lakehouse Architecture in Fabric](/fabric/onelake/onelake-medallion-lakehouse-architecture). For an analytics architecture, see [Analytics End-to-End with Microsoft Fabric](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end).

*Table. Example medallion architecture. Gold layer combines data from two datasets.*
| ***Dataset*** | ***Layer*** | ***Example Data*** | ***What happened*** |
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