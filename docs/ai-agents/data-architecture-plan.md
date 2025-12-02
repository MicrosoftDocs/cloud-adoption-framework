---
title: Data architecture for AI agents across your organization
ms.reviewer: ssumner
description: Explore how Microsoft Fabric and OneLake enable AI agents to operate on unified, trusted data for better decision-making and automation.
#customer intent: As a CTO or enterprise architect, I want to understand how to prepare our data and data architecture so that AI agents can access and remain grounded in our organizational data. I need to know how to achieve this in the most cost-effective way, enabling us to unlock the power of agents securely and in a governed manner—ensuring no data leakage while maintaining up-to-date, accurate information that integrates seamlessly with platforms like Microsoft Foundry and Copilot Studio.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: article
ms.collection: ce-skilling-ai-copilot
---

# Data architecture for AI agents

This article explains how to develop a comprehensive data plan that enables AI agents to deliver business value through effective data management, preparation, and security. It guides leaders through key decisions about data unification, retrieval strategies, and governance that directly influence agent accuracy and organizational risk. Planning your data architecture readiness is the final step in the **Plan for agents** phase of AI agent adoption (*see figure 1*).

:::image type="content" source="./images/ai-agent-adoption.svg" alt-text="Diagram showing a horizontal workflow with four connected phases: plan for agents (business strategy, technology strategy, people strategy, data strategy). Govern (responsible AI, organization agent governance). Build agents (single and multi-agent systems, build agents). Operate agents integrate (integrate agents). Measure (measure agents)." lightbox="./images/ai-agent-adoption.svg" border="false":::
*Figure 1. Microsoft's AI agent adoption process.*

Organizations often underestimate the role of data readiness in AI success. AI agents don't create knowledge. They retrieve and synthesize information from existing sources. If those sources are incomplete, fragmented, or inaccessible, the agent produces inaccurate or misleading results. A well-designed data plan ensures that agents operate on authoritative content, respect security boundaries, and deliver consistent value across business processes.

This guidance applies to Microsoft SaaS agents such as agents in Microsoft 365 Copilot and to custom AI agents built on platforms like Microsoft Foundry and Microsoft Copilot Studio. The decisions outlined here directly affect agent reliability, compliance posture, and the speed at which new agents can be deployed. See figure 2 for a conceptual data architecture.

:::image type="content" source="images/data-architecture-fabric-onelake-foundry-azure-microsoft.svg" alt-text="diagram showing data flow from non-Azure sources into Microsoft services. At the base, external data enters and moves upward into multiple data domains representing business units. Each domain connects to Microsoft Fabric OneLake workspaces for unified business data. Above, processing occurs using Fabric IQ and Fabric data agents, which then feed into Microsoft Foundry agents in Azure or Copilot Studio agents within the Microsoft ecosystem. At the top, agents integrate with Azure landing zones: platform landing zones with management groups and subscriptions, application landing zones hosting Foundry, and data management landing zones hosting Fabric capacity. Azure Databricks appears in a data landing zone for advanced analytics, enabling insights across teams." lightbox="images/data-architecture-fabric-onelake-foundry-azure-microsoft.svg" border="false":::
*Figure 2. Conceptual data architecture for AI agents.*

## Prepare Microsoft 365 data

Microsoft 365 Copilot productivity agents, such as Researcher agent, App Builder agent, and Workflows agent, rely on organizational data stored in Microsoft Graph. Microsoft Graph includes data from SharePoint, OneDrive, Exchange, and other Microsoft 365 sources. These agents retrieve documents, emails, and collaboration artifacts while honoring existing permissions. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). Agents in Foundry ([SharePoint](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry&preserve-view=true)) and [Copilot Studio](/microsoft-copilot-studio/knowledge-copilot-studio#supported-knowledge-sources) can also connect to data in Microsoft 365 apps. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.

**What Microsoft 365 shouldn't you sync to Fabric?** Keep content in Microsoft 365 when its primary purpose is collaboration, reference, or knowledge retrieval. Examples include policies, procedures, playbooks, templates, FAQs, emails, Teams chats, meeting transcripts, agendas, project documents, and departmental knowledge bases. These normally require document-level permissions in Word, Excel, PowerPoint, Outlook, and Teams.

## Unify business data

Microsoft 365 provides collaboration and knowledge content for AI agents, but process automation and performance analytics require more than documents and emails. These agents need a unified, governed data foundation that spans operational systems and structured business data, and can include curated signals from Microsoft 365 content. Microsoft Fabric delivers this foundation through OneLake, a single, logical data lake automatically provisioned for every Fabric tenant. OneLake supports multiple analytical engines and uses Delta Parquet format for consistency and performance.

Unifying and cleansing data within each domain creates a reliable base for agent development. Clean, consistent data accelerates design and deployment and ensures analytics and automation produce accurate results. This approach reduces friction for teams and supports governance by default.

### Why a single data platform matters

AI agents can technically operate without a unified platform by connecting directly to domain-specific systems or using federated queries. However, a unified approach delivers significant advantages:

| Benefit | Impact |
|---------|--------|
| Lower integration effort | Agents connect to a single logical data lake rather than multiple systems, reducing complexity and accelerating development. |
| Consistent governance | Policies, compliance controls, and security models are applied uniformly across all data domains. |
| Faster innovation | New agents and capabilities can be deployed without repeating integration work for every source. |
| Improved discoverability | Certified data products are easier to find and consume, enabling agents to reason over trusted datasets. |
| Better performance for AI | Retrieval strategies like RAG and MCP operate on optimized, governed data rather than fragmented sources. |

Microsoft Fabric addresses these needs through OneLake, a single logical data lake where teams organize data by domain and publish certified data products. This approach preserves domain ownership while making data easier to consume and govern. It’s not just an analytics architecture. It’s a foundation for AI agents to operate effectively and securely.

### What data should you unify?

Start by asking a clear question: "Does this data help explain or measure a business process?" If the answer is yes, prepare that data for analytics and AI. If the answer is no, keep it in collaboration tools for reference and teamwork.

Unify data that supports operational decisions, performance tracking, or automation. Examples include transactional records, customer interactions, inventory details, financial metrics, and curated signals extracted from collaboration content. These datasets provide measurable outcomes and enable agents to reason over structured information. Exclude content that serves only collaborative purposes, such as drafts, brainstorming notes, or informal meeting summaries, unless those files contain structured data relevant for analysis. Keep personal or unplanned documents in OneDrive or SharePoint for collaboration only.

Microsoft Fabric organizes unified data using the medallion architecture, which supports structured tables alongside semi-structured and unstructured datasets. It includes content ingested from SharePoint and OneDrive. Unstructured files such as PDFs and Word documents typically lack a fixed schema. They become semi-structured when enriched with metadata or tags (for example, XML or JSON wrappers). They become structured when cognitive services extract fields and map them to Fabric tables. This progression ensures that AI agents can query and interpret data accurately.

### Use Fabric data agents

Fabric Data Agents allow business teams to query structured data using natural language. These agents translate questions into precise SQL statements and return accurate results when they operate on high-quality, certified tables. They work best on mirrored or shortcut tables designated as Gold sources, because these tables provide curated and governed data that supports consistent metrics and reliable analytics.

Organizations should prioritize creating and certifying Gold tables for critical business domains such as finance, supply chain, and customer operations. This step ensures that AI agents deliver accurate insights and reduces the risk of inconsistent reporting.

### Medallion architecture layers

The medallion architecture organizes data into three layers that progressively improve quality and usability:

1. **Bronze (raw ingestion)**: Store all data in its original form in OneLake, including tabular files, JSON/XML, PDFs, and Office documents. Keep this layer immutable for audit and lineage. Use shortcuts or mirroring for external sources to avoid duplication and maintain consistency.

2. **Silver (validated)**: Clean and standardize data. Remove duplicates, normalize formats, and apply schemas. For example, convert PDFs to text or transform JSON into Delta tables. This layer supports accurate joins and indexing for retrieval.

3. **Gold (business context)**: Aggregate data with business meaning, add semantic layers, optimize performance, and certify datasets. Register these curated data products in Microsoft Purview to enforce governance and compliance.

To enable retrieval, create OneLake [search indexers](/azure/search/search-how-to-index-onelake-files) with Azure AI Search on Silver-layer data. Agents use Silver datasets to identify relationships and patterns. When an agent creates a curated set, store it as a registered data product in Purview or keep the instructions as a specification file in Git for version control. This process ensures reproducibility and governance. For an architecture, see [Fabric enterprise architecture](/azure/architecture/example-scenario/analytics/enterprise-bi-microsoft-fabric).

### Adaptive Gold (dynamic)

Adaptive Gold introduces a dynamic approach to data curation that responds to real-world usage patterns. Instead of relying on static indexing, organizations use agent-driven processes to create curated datasets that evolve with business needs.

Agents monitor frequent queries and aggregations to identify high-value patterns. They then materialize curated datasets as Delta tables or generate specification files to ensure reproducibility. Governance guardrails enforce approved metrics such as RevenuePerRegion or CustomerSatisfactionScore, and all dynamic datasets are registered in Microsoft Purview for compliance and visibility.

This adaptive model improves flexibility and performance because it prioritizes data that agents use most often. It also reduces latency for common queries and supports continuous optimization without manual intervention.

| Aspect | Silver layer | Gold layer (static) | Adaptive gold (agent-driven) |
|--------|--------------|-------------------|------------------------------|
| Purpose | Clean, validated, normalized data | Business-ready, curated datasets with predefined metrics | Dynamic aggregations based on usage patterns and telemetry |
| Data quality | Deduplicated, standardized | Certified, governed, optimized for analytics | Optimized for frequent queries and evolving business needs |
| Structure | Normalized tables, semi-structured indexed | Semantic layer with KPIs, hierarchies, curated joins | Agent-generated tables or spec files for reproducibility |
| Performance | Good for ad-hoc queries | High performance (materialized views, preaggregations) | Improves over time as agents learn common queries |
| Governance | Registered in Purview | Certified and auditable in Purview | Registered dynamically, Enforced via Foundry + DSPM guardrails |
| Agent role | Consumes validated data | Queries curated sets for consistent metrics | Creates new curated sets or instructions for reuse |
| Flexibility | High (raw + normalized) | Low (static definitions) | Very high (adaptive to real-world usage) |

## Data retrieval strategies for custom agents

Organizations that build custom AI agents must decide how those agents access data to answer questions and perform tasks. Retrieval strategies directly influence accuracy, timeliness, and security. Two complementary approaches enable this access: retrieval-augmented generation (RAG) and Model Context Protocol (MCP) servers. These approaches work together to provide complete and accurate responses. For example, when an employee reports a VPN issue, an effective agent uses both approaches:

- **RAG**: The agent retrieves the VPN troubleshooting guide from the knowledge base.
- **MCP (read)**: The agent checks the current VPN service status from an IT monitoring system.
- **MCP (write)**: The agent creates a helpdesk ticket if the user requests it.

Both RAG and MCP work best when they draw from a unified and governed data foundation. Microsoft Fabric provides this foundation through OneLake and the medallion architecture, which organizes structured, semi-structured, and unstructured data. Adaptive Gold extends this model by enabling agent-driven optimization based on usage patterns. See [agentic RAG](/azure/ai-foundry/concepts/retrieval-augmented-generation?view=foundry&preserve-view=true#agentic-rag-modern-approach-to-retrieval) and [MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true).

### Start with built-in retrieval options

Begin with the RAG and MCP retrieval capabilities included in platforms such as Microsoft Foundry and Copilot Studio. Built-in options reduce integration complexity, accelerate deployment, and maintain consistency. Before investing in custom solutions, confirm whether these features meet your requirements for accuracy and governance. Examples of built-in capabilities include:

- [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&preserve-view=true&preserve-view=true&tabs=foundry%2Cpython)
- [Fabric data agents](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundry&preserve-view=truen)
- [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true)
- [Sharepoint connection](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry&preserve-view=true)
- [Azure AI Search](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&preserve-view=true&tabs=keys%2Cazurecli).

### Plan for RAG for agents

**When to use RAG?**: Use RAG when agents need to look up, explain, and cite information. It excels at unstructured and semi-structured content such as policies, manuals, FAQs, product documentation, and curated extracts because it retrieves just-in-time context and grounds answers in sources. Agentic RAG improves accuracy by decomposing a user’s question into subqueries, running them in parallel, and synthesizing results with citations.

1. **Plan for a unified knowledge layer.** Traditional RAG requires every team to rebuild data connections, chunking logic, embeddings, routing, and permissions from scratch. It creates fragmented pipelines and duplicated effort. To avoid this situation, implement a unified knowledge layer that consolidates retrievable data into a single endpoint or knowledge base that any agent can use with approval. Define reusable knowledge bases around topics such as employee policies, product documentation, or support content. From there, multiple agents and applications can connect and use the same knowledge base for grounding responses. Use **Foundry IQ** to build your agent knowledge layer. Consider incorporating curated Silver, Gold, or Adaptive Gold datasets from Fabric Data Agents or Azure AI Search indexes for authoritative answers. See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&preserve-view=true&tabs=foundry%2Cpython).

2. **Plan for traditional RAG.** When teams need granular control over chunking, indexing, and retrieval, build a traditional RAG pipeline. Treat each index as a data product with clear governance. Decide whether separate indexes for structured and unstructured data are necessary or if hybrid search meets your needs. Plan update cadence, rollback strategies, and latency targets early. See [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index) and [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

#### Plan for building MCP servers

**When to use MCP?** Choose MCP when agents must take actions or access real‑time data. For example, "How many units of SKU123 are in stock right now?" or "Create an incident ticket." MCP gives agents a standardized way to call tools hosted on remote servers, with identity, policy, and audit controls.

1. **Identify candidate systems.**  Prioritize systems where live queries or transactions add value: CRM for pipeline updates, ERP for inventory and orders, ITSM for tickets, IoT telemetry for sensor readings, and internal APIs for specialized processes.

2. **Build or connect MCP servers.** Where there are available and built-in MCP servers in Foundry and Copilot Studio, use them. When there aren’t, you need to build. Clarify the type of interaction the AI agent needs. Some systems require read-only access for queries, while others demand read-write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs. See Connect to MCP servers or Build and register an MCP server. See [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true) or [Build an register an MCP server](/azure/ai-foundry/mcp/build-your-own-mcp-server?view=foundry&preserve-view=true).

3. **Enforce security and compliance for MCP.** Require authentication for every tool call. Foundry supports key‑based access, Microsoft Entra Agent Identity, project managed identity, and OAuth identity passthrough. It provides detailed auditing of tool invocations and data flows. Use RBAC on both the Foundry project and the target service, and prefer identity passthrough when user‑level permissions must persist. See [Authentication support for MCP tool](/azure/ai-foundry/agents/how-to/mcp-authentication?view=foundry&preserve-view=true).

## Document retrieval decisions

A successful data plan doesn't end with technical implementation. Leaders must document how AI agents access information so that governance, compliance, and accountability remain clear. Retrieval decisions affect accuracy, security, and operational risk. Without documentation, teams face ambiguity about which systems agents use and how those systems interact.
Start by listing each major data domain the agent supports and classify the retrieval method for that domain. Use clear categories such as search, API, or both. For example:

- Product FAQs: Search using a knowledge index
- Order tracking: API call to the order management system
- Create return label: API call to the shipping system

This documentation provides transparency for stakeholders and developers. It also supports audits and compliance reviews by showing how data flows through the agent ecosystem. When retrieval strategies combine RAG and MCP, note which approach applies to each domain and why. For instance, RAG might handle static policy documents, while MCP manages real-time inventory queries.
Include governance details in the same record. Specify which data sources are certified, which APIs require authentication, and which permissions apply. This step ensures that retrieval aligns with organizational security policies and regulatory requirements.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai-across-organization.md)