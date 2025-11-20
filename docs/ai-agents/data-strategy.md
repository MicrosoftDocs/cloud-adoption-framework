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

A strong data plan is essential for organizations that want AI agents to deliver accurate, secure, and actionable results. This guidance explains how to prepare organizational data for Microsoft SaaS agents such as Microsoft 365 Copilot and for custom AI agents built on platforms like Copilot Studio or Azure AI Foundry. It outlines the decisions business leaders must make and the trade-offs involved in each step.

Organizations often underestimate the role of data readiness in AI success. AI agents do not create knowledge; they retrieve and synthesize information from existing sources. If those sources are incomplete, fragmented, or inaccessible, the agent produces inaccurate or misleading results. A well-designed data plan ensures that agents operate on authoritative content, respect security boundaries, and deliver consistent value across business processes.

## Prepare Microsoft 365 data

Productivity agents in Microsoft 365 Copilot can use organizational data stored in Microsoft Graph, which includes SharePoint, OneDrive, Exchange, and other Microsoft 365 sources. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). These agents retrieve documents, emails, and collaboration artifacts while respecting existing permissions. Unlike custom agents, leaders cannot feed external datasets directly to Copilot. Similarly, agents in Foundry and [Copilot Studio](/microsoft-copilot-studio/knowledge-copilot-studio#supported-knowledge-sources) can connect to M365 data.

Place authoritative business content in Microsoft 365 where Copilot can access it through existing permissions. For example, store company policies in a well-organized SharePoint site. If essential knowledge resides in Outlook archives or local drives, migrate it to SharePoint or Teams so it becomes part of Microsoft Graph. Copilot can only provide accurate answers when it can access relevant content that reflects organizational standards. Data readiness ensures agents deliver complete and reliable responses by grounding them in trusted sources. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.

## Unify business data

Organizations that succeed with AI agents start with a strong and adaptive data foundation. AI agents operate across multiple domains such as customer service, operations, HR, and finance. These agents require access to structured tables, semi-structured formats, and unstructured documents. When data remains siloed, agents still function, but teams must add integration work and custom logic to combine sources. This extra effort increases complexity and slows development.

Unifying and cleansing data within each domain creates a reliable foundation that reduces friction for teams building agents. Clean and consistent data enables faster design and deployment of agents and ensures that analytics and automation produce accurate results.

1. **Why do you need a single data platform?** AI agents can work without a unified platform by connecting directly to domain-specific systems or using federated queries. However, this approach introduces trade-offs:

    - Higher integration cost: Each agent must manage multiple data sources, schemas, and security models.
    - Inconsistent governance: Policies and compliance controls differ across systems, which increases risk.
    - Slower development: Adding new agents or expanding capabilities requires repeating integration work.
    
    A unified platform such as Microsoft Fabric addresses these challenges by providing a single logical data lake (OneLake) where teams organize data by domain and publish certified data products. This approach does not replace domain ownership but makes data easier to consume and govern.

2. **What data should you unify?** Ask: “Does this data help understand a business process?” If yes, prepare it for analytics and AI. If no, keep it in collaboration tools. Exclude purely collaborative content such as drafts, meeting notes, or brainstorming documents unless they contain structured data for analysis. Keep personal or ad-hoc files that do not contribute to measurable outcomes in OneDrive or SharePoint for collaboration only.

## Data retrieval strategies for agents

Organizations that adopt AI agents must decide how those agents access data to answer questions and perform tasks. Retrieval strategies directly influence accuracy, timeliness, and security. Two complementary approaches enable this access: retrieval-augmented generation (RAG) and Model Context Protocol (MCP) servers. These approaches work together to provide complete and accurate responses. For example, when an employee reports a VPN issue, an effective agent uses both approaches:

- **RAG**: The agent retrieves the VPN troubleshooting guide from the knowledge base.
- **MCP (read)**: The agent checks the current VPN service status from an IT monitoring system.
- **MCP (write)**: The agent creates a helpdesk ticket if the user requests it.

Understanding when and how to use these approaches is essential for building reliable and secure AI capabilities.. See [agentic RAG](/azure/ai-foundry/concepts/retrieval-augmented-generation?view=foundry#agentic-rag-modern-approach-to-retrieval) and [MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry).

Understanding when and how to use these approaches is essential for building reliable and secure AI capabilities. Both strategies work best when they draw from a consistent and governed data foundation. When RAG retrieves content from a centralized knowledge layer built on this platform, responses reflect authoritative information rather than fragmented sources. Similarly, MCP can reference the same platform for read operations when real-time access is not required, reducing reliance on multiple APIs and improving compliance. This integration ensures that retrieval decisions align with organizational governance and security standards.

### Start with built-in retrieval options

Begin with the RAG and MCP retrieval capabilities included in platforms such as Microsoft Foundry and Copilot Studio. Built-in options reduce integration complexity, accelerate deployment, and maintain consistency. Before investing in custom solutions, confirm whether these features meet your requirements for accuracy and governance.

:::image type="icon" source="images/foundry-icon.png"::: **Foundry**: See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython), [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry), [Build your own MCP server](/azure/ai-foundry/mcp/build-your-own-mcp-server?view=foundry), [Sharepoint connection](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry), [Azure AI Search](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&tabs=keys%2Cazurecli).

### Plan for RAG for agents

**When to use RAG**: Use RAG when agents need to look up and explain information. RAG retrieves relevant content from approved sources and uses that content to build answers. This approach works best for unstructured or semi-structured information such as policies, manuals, FAQs, and wikis. RAG improves accuracy and transparency because you can configure it to have the agent cites documents. See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython).

1. **Plan for a unified knowledge layer.** Traditional RAG requires every team to rebuild data connections, chunking logic, embeddings, routing, and permissions from scratch. This creates fragmented pipelines and duplicated effort. To avoid this, implement a unified knowledge layer that consolidates retrievable data into a single endpoint or knowledge base that any agent can use with approval. Define reusable knowledge bases around topics such as employee policies, product documentation, or support content. From there, multiple agents and applications can connect and use the same knowledge base for grounding responses. Use [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython) to build your agent knowledge layer.

2. **Plan for traditional RAG.** When a team needs more control over how content is chunked, indexed, and retrieved than a shared knowledge layer can provide, build a traditional RAG pipeline. Treat each index as a data product designed for scalability and governance. Plan index granularity carefully. Use one index per major domain or permission boundary to maintain clarity and security. Avoid creating dozens of small indexes unless retrieval quality suffers without them. Decide whether separate indexes for structured and unstructured data are necessary or if a combined approach using vector and keyword search meets your needs. Consider how often indexes will be updated, when embeddings should be refreshed, and what rollback strategy applies if something goes wrong. Estimate query volume and set latency targets early. For very large indexes, consider sharding to distribute load and caching for frequently accessed queries. SEe [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index) and [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

#### Plan for building MCP servers

**When to use MCP?** Use MCP when agents need to take actions or access real-time data. These scenarios include answering questions such as “How many units of SKU123 are in stock right now?” or executing tasks like “Create a new incident ticket for this issue.” These capabilities require more than indexed content. They need a secure and standardized way to query systems and perform actions. MCP servers provide this capability. Include MCP integration in your data plan when any of these conditions apply:

- Data is dynamic or too granular to index (for example, real-time sensor readings).
- The action involves writing or transacting, not just reading (for example, creating a ticket or updating a record).
- The source system provides an API (for example, SaaS platforms or internal services).
- Security or compliance requires live queries instead of storing data in an index.

1. **Identify candidate systems.** Work with IT leadership to identify systems where real-time data or transactional capabilities add business value. These typically include:

    - Customer relationship management platforms for pipeline updates
    - Enterprise resource planning systems for inventory and order management
    - IT service management tools for ticketing workflows
    - IoT databases for sensor readings
    - Internal web services that support specialized processes

2. **Plan to build MCP servers.** Where there's available and built-in MCP servers in Foundry and Copilot Studio use them. When there isn't you need to build. Clarify the type of interaction the AI agent needs. Some systems require read-only access for queries, while others demand read-write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs.

3. **Enforce security and compliance for MCP.** Require authentication for every MCP interaction. The AI agent passes an identity token so the MCP server validates the user and applies role-based permissions. Log all MCP calls for auditing, including who made the request, what data was returned, and what actions were executed.

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