---
title: Data plan for AI agents
ms.reviewer: ssumner
description: Learn how to develop a comprehensive data plan that enables AI agents to deliver business value through effective data management, preparation, and security.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data plan for AI agents

A strong data plan is essential for organizations that want AI agents to deliver accurate, secure, and actionable results. This guidance explains how to prepare organizational data for Microsoft SaaS agents such as Microsoft 365 Copilot and for custom AI agents built on platforms like Copilot Studio or Microsoft Foundry. It outlines the decisions business leaders must make and the trade-offs involved in each step.

Organizations often underestimate the role of data readiness in AI success. AI agents do not create knowledge; they retrieve and synthesize information from existing sources. If those sources are incomplete, fragmented, or inaccessible, the agent produces inaccurate or misleading results. A well-designed data plan ensures that agents operate on authoritative content, respect security boundaries, and deliver consistent value across business processes.

:::image type="content" source="images/alz-fabric-agents-data.png" alt-text="Diagram of a data estate from Microsoft 365 apps to data in Azure. It shows unification of business data in Microsoft Fabric's OneLake data lake, and how that data supports Foundry and Copilot Agents." lightbox="images/alz-fabric-agents-data.png":::

## Prepare Microsoft 365 data

Microsoft 365 Copilot productivity agents, such as Researcher agent, App Builder agent, and Workflows agent, rely on organizational data stored in Microsoft Graph, which includes SharePoint, OneDrive, Exchange, and other Microsoft 365 sources. These agents retrieve documents, emails, and collaboration artifacts while honoring existing permissions. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). Agents in Foundry ([SharePoint](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry)) and [Copilot Studio](/microsoft-copilot-studio/knowledge-copilot-studio#supported-knowledge-sources) can also connect to data in Microsoft 365 apps.

**What belongs in Microsoft 365?** Keep content in Microsoft 365 when its primary purpose is collaboration, reference, or knowledge retrieval. Examples include policies, procedures, playbooks, templates, FAQs, emails, Teams chats, meeting transcripts, agendas, project documents, and departmental knowledge bases that require document-level permissions in Word, Excel, PowerPoint, Outlook, and Teams. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.

## Unify business data

Microsoft 365 enables agents to reason over collaboration and knowledge content. However, agents that automate processes or analyze business performance need more than documents and emails. They require a unified, governed data foundation that spans operational systems and structured business data, and can include curated signals from Microsoft 365 content. Microsoft Fabric provides this foundation. Unifying and cleansing data within each domain creates a reliable foundation that reduces friction for teams building agents. Clean and consistent data enables faster design and deployment of agents and ensures that analytics and automation produce accurate results.

### Why a single data platform matters

AI agents can operate without a unified platform by connecting directly to domain-specific systems or using federated queries. However, this approach introduces trade-offs:

- Higher integration cost: Each agent must manage multiple data sources, schemas, and security models.
- Inconsistent governance: Policies and compliance controls differ across systems, increasing risk.
- Slower development: Adding new agents or expanding capabilities requires repeating integration work.

A unified platform such as Microsoft Fabric addresses these challenges by providing OneLake—a single logical data lake where teams organize data by domain and publish certified data products. This approach does not replace domain ownership but makes data easier to consume and govern. This architecture is not just for analytics. It directly enables AI agents. Fabric’s unified data layer ensures that retrieval strategies like RAG and MCP can operate on trusted, governed data rather than fragmented sources.

### What data should you unify?

Ask: “Does this data help understand a business process?” If yes, prepare it for analytics and AI. If no, keep it in collaboration tools. Exclude purely collaborative content such as drafts, meeting notes, or brainstorming documents unless they contain structured data for analysis. Keep personal or ad-hoc files that do not contribute to measurable outcomes in OneDrive or SharePoint for collaboration only.

Fabric organizes structured tables alongside semi-structured and unstructured datasets, including content ingested from SharePoint and OneDrive, through the medallion architecture. PDFs, Word documents, and similar files are generally unstructured because they lack a fixed schema like rows and columns. They become semi-structured if they include metadata or tags (for example, XML or JSON wrappers), or structured if cognitive services extract fields and map them to Fabric tables.

### Use Fabric data agents

Fabric Data Agents use natural language to query structured data and translate questions into precise SQL statements. They work best on mirrored or shortcut tables, especially those designated as Gold sources, because these tables provide certified, high-quality data for accurate results.

### Medallion architecture layers

The medallion architecture creates a structured approach for managing semi-structured and unstructured data. It organizes data into three layers:

- **Bronze (raw ingestion)**: All data (tabular, JSON/XML, PDFs, and Office files) lands in OneLake in its original form. This layer remains immutable for audit and lineage. External sources should be accessed via shortcuts or mirroring rather than copying.

- **Silver (validated)**: Clean and standardize data. Remove duplicates, normalize formats (such as converting PDFs to text or extracting entities), and apply schemas (for example, converting JSON into Delta tables).

- **Gold (business context)**:  Aggregate data with business meaning, add a semantic layer, optimize performance, and certify datasets. Gold can include dynamic datasets that evolve based on agent-driven consumption patterns. Register these data products in Microsoft Purview for governance and compliance.

To enable retrieval, create OneLake search indexers on Silver-layer data. Agents use Silver datasets to identify relationships and patterns. When an agent creates a curated set, store it as a registered data product in Purview or keep the instructions as a specification file in Git for version control. This process ensures reproducibility and governance.

### Adaptive Gold (dynamic)

Adaptive Gold introduces a dynamic approach to data curation that responds to real-world usage patterns. Instead of relying on static indexing, organizations use agent-driven processes to create curated datasets that evolve with business needs.

Agents track frequent queries and aggregations to identify high-value patterns. They then materialize curated datasets as Delta tables or generate specification files to ensure reproducibility. Governance guardrails enforce approved metrics such as RevenuePerRegion or CustomerSatisfactionScore, and all dynamic datasets are registered in Microsoft Purview for compliance and visibility.

| Aspect | Silver layer | Gold layer (static) | Adaptive gold (agent-driven) |
|--------|--------------|-------------------|------------------------------|
| Purpose | Clean, validated, normalized data | Business-ready, curated datasets with predefined metrics | Dynamic aggregations based on usage patterns and telemetry |
| Data quality | Deduplicated, standardized | Certified, governed, optimized for analytics | Optimized for frequent queries and evolving business needs |
| Structure | Normalized tables, semi-structured indexed | Semantic layer with KPIs, hierarchies, curated joins | Agent-generated tables or spec files for reproducibility |
| Performance | Good for ad-hoc queries | High performance (materialized views, pre-aggregations) | Improves over time as agents learn common queries |
| Governance | Registered in Purview | Certified and auditable in Purview | Registered dynamically; enforced via Foundry + DSPM guardrails |
| Agent role | Consumes validated data | Queries curated sets for consistent metrics | Creates new curated sets or instructions for reuse |
| Flexibility | High (raw + normalized) | Low (static definitions) | Very high (adaptive to real-world usage) |

## Data retrieval strategies for custom agents

Organizations that adopt AI agents must decide how those agents access data to answer questions and perform tasks. Retrieval strategies directly influence accuracy, timeliness, and security. Two complementary approaches enable this access: retrieval-augmented generation (RAG) and Model Context Protocol (MCP) servers. These approaches work together to provide complete and accurate responses. For example, when an employee reports a VPN issue, an effective agent uses both approaches:

- **RAG**: The agent retrieves the VPN troubleshooting guide from the knowledge base.
- **MCP (read)**: The agent checks the current VPN service status from an IT monitoring system.
- **MCP (write)**: The agent creates a helpdesk ticket if the user requests it.

Understanding when and how to use these approaches is essential for building reliable and secure AI capabilities.. See [agentic RAG](/azure/ai-foundry/concepts/retrieval-augmented-generation?view=foundry#agentic-rag-modern-approach-to-retrieval) and [MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry).

Both RAG and MCP work best when they draw from a unified and governed data foundation. Microsoft Fabric provides this foundation, organizing structured, semi-structured, and unstructured data through the Medallion Architecture—and now extending it with Adaptive Gold for agent-driven optimization.

### Start with built-in retrieval options

Begin with the RAG and MCP retrieval capabilities included in platforms such as Microsoft Foundry and Copilot Studio. Built-in options reduce integration complexity, accelerate deployment, and maintain consistency. Before investing in custom solutions, confirm whether these features meet your requirements for accuracy and governance. See, for examples, these capabilities:

- [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython)
- [Fabric data agents](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundryn)
- [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry)
- [Sharepoint connection](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry)
- [Azure AI Search](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&tabs=keys%2Cazurecli).

### Plan for RAG for agents

**When to use RAG?**: Use RAG when agents need to look up, explain, and cite information. It excels for unstructured and semi-structured content, policies, manuals, FAQs, product docs, and curated extracts, because it retrieves just-in-time context and grounds answers in sources. Agentic RAG improves accuracy by decomposing a user’s question into subqueries, running them in parallel, and synthesizing results with citations.

1. **Plan for a unified knowledge layer.** Traditional RAG requires every team to rebuild data connections, chunking logic, embeddings, routing, and permissions from scratch. This creates fragmented pipelines and duplicated effort. To avoid this, implement a unified knowledge layer that consolidates retrievable data into a single endpoint or knowledge base that any agent can use with approval. Define reusable knowledge bases around topics such as employee policies, product documentation, or support content. From there, multiple agents and applications can connect and use the same knowledge base for grounding responses. Use Foundry IQ to build your agent knowledge layer and consider incorporating curated Silver, Gold, or Adaptive Gold datasets from Fabric Data Agents or Azure AI Search indexes for authoritative answers.See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython).

2. **Plan for traditional RAG.** When teams need granular control over chunking, indexing, and retrieval, build a traditional RAG pipeline. Treat each index as a data product with clear governance. Decide whether separate indexes for structured and unstructured data are necessary or if hybrid search meets your needs. Plan update cadence, rollback strategies, and latency targets early. See Design an index for agentic retrieval and Design and develop a RAG solution. See [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index) and [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

#### Plan for building MCP servers

**When to use MCP?** Choose MCP when agents must take actions or access real‑time data. For example, “How many units of SKU123 are in stock right now?” or “Create an incident ticket.” MCP gives agents a standardized way to call tools hosted on remote servers, with identity, policy, and audit controls.

1. **Identify candidate systems.**  Prioritize systems where live queries or transactions add value: CRM for pipeline updates, ERP for inventory and orders, ITSM for tickets, IoT telemetry for sensor readings, and internal APIs for specialized processes.

2. **Build or connect MCP servers.** Where there are available and built-in MCP servers in Foundry and Copilot Studio, use them. When there aren’t, you need to build. Clarify the type of interaction the AI agent needs. Some systems require read-only access for queries, while others demand read-write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs. See Connect to MCP servers or Build and register an MCP server. See [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry) or [Build an register an MCP server](/azure/ai-foundry/mcp/build-your-own-mcp-server?view=foundry).

3. **Enforce security and compliance for MCP.** Require authentication for every tool call. Foundry supports key‑based access, Entra Agent Identity, project managed identity, and OAuth identity passthrough, with detailed auditing of tool invocations and data flows. Use RBAC on both the Foundry project and the target service, and prefer identity passthrough when user‑level permissions must persist. See [Authentication support for MCP tool](/azure/ai-foundry/agents/how-to/mcp-authentication?view=foundry).

## Document retrieval decisions

A successful data plan does not end with technical implementation. Leaders must document how AI agents access information so that governance, compliance, and accountability remain clear. Retrieval decisions affect accuracy, security, and operational risk. Without documentation, teams face ambiguity about which systems agents use and how those systems interact.
Start by listing each major data domain the agent supports and classify the retrieval method for that domain. Use clear categories such as search, API, or both. For example:

- Product FAQs: Search using a knowledge index
- Order tracking: API call to the order management system
- Create return label: API call to the shipping system

This documentation provides transparency for stakeholders and developers. It also supports audits and compliance reviews by showing how data flows through the agent ecosystem. When retrieval strategies combine RAG and MCP, note which approach applies to each domain and why. For instance, RAG might handle static policy documents, while MCP manages real-time inventory queries.
Include governance details in the same record. Specify which data sources are certified, which APIs require authentication, and which permissions apply. This step ensures that retrieval aligns with organizational security policies and regulatory requirements.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)