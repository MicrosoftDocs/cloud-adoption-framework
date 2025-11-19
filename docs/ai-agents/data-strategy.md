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

A strong data plan is essential for organizations that want AI agents to deliver accurate, secure, and actionable results. This article explains how to prepare data for Microsoft SaaS agents such as Microsoft 365 Copilot and for custom AI agents built on platforms like Copilot Studio or Azure AI Foundry. It outlines the decisions leaders must make and the trade-offs involved in each step.

## Prepare Microsoft 365 data

Productivity agents in Microsoft 365 Copilot can use organizational data stored in Microsoft Graph, which includes SharePoint, OneDrive, Exchange, and other Microsoft 365 sources. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). These agents retrieve documents, emails, and collaboration artifacts while respecting existing permissions. Unlike custom agents, leaders cannot feed external datasets directly to Copilot. Success depends on optimizing the Microsoft 365 environment. Similarly, agents in Foundry and [Copilot Studio](/microsoft-copilot-studio/knowledge-copilot-studio#supported-knowledge-sources) can connect to M365 data.

Place critical business information in Microsoft 365 where Copilot can access it under existing permissions. For example, store company policies on SharePoint in a well-organized site. If knowledge resides in Outlook archives or local drives, migrate it to SharePoint or Teams so it becomes part of Microsoft Graph. Copilot can only provide value when it can access relevant content, subject to security trimming. Data readiness ensures agents provide accurate and complete answers by accessing authoritative sources. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.

## Unify business data

Organizations that succeed with AI agents start with a strong and adaptive data foundation. AI agents operate across multiple domains such as customer service, operations, HR, and finance. These agents require access to structured tables, semi-structured formats, and unstructured documents. When data remains siloed, agents still function, but teams must add integration work and custom logic to combine sources. This extra effort increases complexity and slows development.

Unifying and cleansing data within each domain creates a reliable foundation that reduces friction for teams building agents. Clean and consistent data enables faster design and deployment of agents and ensures that analytics and automation produce accurate results.

1. **Do you need a single platform?** AI agents can work without a unified platform by connecting directly to domain-specific systems or using federated queries. However, this approach introduces trade-offs:

    - Higher integration cost: Each agent must manage multiple data sources, schemas, and security models.
    - Inconsistent governance: Policies and compliance controls differ across systems, which increases risk.
    - Slower development: Adding new agents or expanding capabilities requires repeating integration work.
    
    A unified platform such as Microsoft Fabric addresses these challenges by providing a single logical data lake (OneLake) where teams organize data by domain and publish certified data products. This approach does not replace domain ownership but makes data easier to consume and govern.

2. **What data should you unify?** Ask: “Does this data help measure, visualize, or automate a business process?” If yes, prepare it for analytics and AI. If no, keep it in collaboration tools. Exclude purely collaborative content such as drafts, meeting notes, or brainstorming documents unless they contain structured data for analysis. Keep personal or ad-hoc files that do not contribute to measurable outcomes in OneDrive or SharePoint for collaboration only.

## Data retrieval strategies for agents

Organizations that adopt AI agents must decide how those agents access enterprise data to answer questions and perform tasks. Retrieval strategies directly influence accuracy, timeliness, and security. Two complementary approaches enable this access: retrieval-augmented generation (RAG) and Model Context Protocol (MCP) servers. When an employee reports a VPN issue, an effective agent uses both:

- **RAG**: The agent retrieves the VPN troubleshooting guide from the knowledge base.
- **MCP (read)**: The agent checks the current VPN service status from an IT monitoring system.
- **MCP (write)**: The agent creates a helpdesk ticket if the user requests it.

These approaches work together to provide complete and accurate responses. See [agentic RAG](/azure/ai-foundry/concepts/retrieval-augmented-generation?view=foundry#agentic-rag-modern-approach-to-retrieval) and [MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry).

1. **Start with built-in retrieval options.** Start with the RAG and MCP retrieval capabilities included in platforms such as Microsoft Foundry and Copilot Studio. Built-in options reduce integration complexity, accelerate deployment, and maintain consistency. Before investing in custom solutions, confirm whether these features meet your requirements for accuracy and governance.

    :::image type="icon" source="images/foundry-icon.png"::: **Foundry**: See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython), [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry), [Build your own MCP server](/azure/ai-foundry/mcp/build-your-own-mcp-server?view=foundry), [Sharepoint connection](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry), [Azure AI Search](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&tabs=keys%2Cazurecli).

### Plan a retrieval knowledge layer for agents

Let's talks about  a unified knowledge layer as a form of rag retrieval where you have knowledge bases are reusable, topic-centric collections that ground multiple agents and applications through a single API. Building agents becomes simpler, no longer requiring a tangle of data tools stitched into every project. Automatic access to indexed and federated knowledge sources: Expand what an agent can reach by connecting to both indexed and remote knowledge sources. For indexed sources, delivers automatic indexing, vectorization, and enrichment for text, images, and complex documents. Agentic retrieval engine in knowledge bases: A self-reflective query engine that uses AI to plan, search, and synthesize answers across sources with configurable “retrieval reasoning effort.” Traditional RAG puts a heavy tax on every new project. Every team must rebuild data connections, chunking logic, embeddings, routing and permissions from scratch. It leaves organizations with a mess of fragmented, duplicated pipelines all trying to answer the same question in a silo: what context does the model need to respond effectively? shifts that work into knowledge bases. Instead of wiring retrieval logic into.

    :::image type="icon" source="images/foundry-icon.png"::: **Foundry**: See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython)

### Plan for RAG for agents

Retrieval-augmented generation (RAG) improves the accuracy and transparency of AI agents by grounding responses in actual enterprise content instead of relying on the model’s internal knowledge. This approach is essential for business scenarios where trust and compliance matter. When an agent retrieves relevant content before generating an answer, it reduces the risk of outdated or fabricated information and enables source citation.

Why RAG matters: AI agents that rely only on their trained models often produce incomplete or incorrect answers. RAG ensures that responses come from authoritative documents and data, which builds confidence among employees and customers. It also supports compliance by referencing approved sources.RAG retrieves approved content from knowledge sources and uses it to build answers. This method works best for unstructured or semi-structured information such as policies, manuals, FAQs, and wikis. RAG improves transparency because the agent cites actual documents.
    
    2. **Plan index usage across multiple agents.** If the organization deploys multiple custom agents, decide whether each agent uses a dedicated index or shares indexes. Separate indexes work well for distinct domains such as finance or IT, while shared indexes promote consistency but require careful permission handling and filtering. Scalability note: Avoid creating dozens of separate indexes without a plan. Consider modular indexes that multiple agents can reuse to reduce maintenance complexity.
    
    3. **Index content from golden sources.** Populate indexes with content from authoritative sources identified in the data strategy, such as those in Fabric. Include unstructured documents such as PDFs, Word files, and wikis, as well as structured data transformed for search. Ensure each source provides clean, relevant, and labeled data. Avoid duplicates and untrusted documents by selecting the best source for each type of information. Why this matters: Indexing authoritative content ensures that AI agents reference approved and accurate information rather than outdated or inconsistent data.
    
    4. **Chunk and enrich content.** Divide large documents into smaller, coherent chunks, such as paragraphs or sections, to improve search precision. Enrich each chunk with metadata like document name, type, tags, and summaries. This enrichment enables better ranking and filtering. For example, if a user asks about international refund policy, the agent can filter for chunks tagged “refund” and “international.” Trade-off: Chunking and tagging require upfront effort, but they significantly improve search relevance and reduce the risk of irrelevant answers
    
    5. **Improve retrieval.** Combine keyword search with semantic ranking and vector search to match queries based on meaning, not just exact terms. Ensure the index schema includes vector embeddings for each chunk to support semantic search. Configure indexes to store identifiers such as document names, URLs, or IDs so agents can cite sources in responses. This practice increases transparency and trust.
    
    6. **Maintain and monitor indexes.** Refresh indexes regularly when source data changes. Monitor agent queries to identify gaps or irrelevant results and adjust indexing strategies accordingly. For example, add missing keywords or split documents into smaller chunks when needed. Treat index maintenance as an ongoing operational responsibility, not a one-time setup.
    
    For detailed guidance, see [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index) and [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

#### Plan for building MCP servers

Retrieval-augmented generation (RAG) addresses the need for AI agents to read and reference information, but many business scenarios require agents to take actions or access real-time data. These scenarios include answering questions such as “How many units of SKU123 are in stock right now?” or executing tasks like “Create a new incident ticket for this issue.” These capabilities require more than indexed content. They need a secure and standardized way to query systems and perform actions. Model Context Protocol (MCP) servers provide this capability.

Why MCP matters: MCP servers act as controlled connectors that expose functions and queries through a consistent interface. They allow AI agents to interact with operational systems securely and in a way that supports compliance. Without MCP, organizations face two poor alternatives: pre-indexing dynamic data, which quickly becomes stale, or granting direct database access, which introduces security and governance risks.

1. **Know where to use MCP.** Business leaders should include MCP integration in their data plan when any of the following conditions apply:

    - **Data is dynamic or too granular to index.** Examples include real-time sensor readings or data that changes every few seconds. Indexing such data creates stale results and unnecessary overhead.
    - **The action involves writing or transacting, not just reading.** Examples include approving a request, sending an email, or invoking an API to update a record. These actions require controlled execution, not static reference.
    - **The source is a system with an API.** Many SaaS and internal systems provide APIs. Instead of continuously indexing all their data, allow the agent to query them on demand through MCP. This reduces storage and synchronization complexity.
    - **Security or compliance demands live query**. If regulations prevent storing certain data in an index, use MCP to fetch it securely with full auditing. This approach maintains compliance while enabling functionality.

2. **Identify candidate systems.** Work with IT leadership to identify systems where real-time data or transactional capabilities add business value. These typically include:

    - Customer relationship management platforms for pipeline updates
    - Enterprise resource planning systems for inventory and order management
    - IT service management tools for ticketing workflows
    - IoT databases for sensor readings
    - Internal web services that support specialized processes

    Clarify the type of interaction the AI agent needs. Some systems require read-only access for queries, while others demand read-write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs.

4. **Enforce security and compliance for MCP.** Security and compliance must be central to MCP implementation. Each MCP server should require authentication for every interaction. The AI agent passes an identity token so the MCP server validates the user and applies role-based permissions. This approach ensures that only authorized users can access sensitive data or perform actions. Organizations should also apply Zero Trust principles. For example, if a frontline employee requests financial data, the MCP linked to the finance system must reject the request unless the user has explicit access rights. In addition, all MCP calls should be logged for auditing. These logs must capture who made the request, what data was returned, and what actions were executed. Maintaining this level of transparency supports compliance and enables incident investigation when needed.

## Plan to connect SaaS agents

**Use Microsoft Graph connectors for external data.** If important data exists outside Microsoft 365, such as in an external CMS or database, use Microsoft Graph connectors to bring that content into the Microsoft Graph index. For example, connectors exist for file shares and SQL databases. This approach allows Copilot to retrieve answers from connected sources without building a custom agent, effectively extending Copilot’s reach by integrating external data into its native environment. Graph connectors reduce silos and extend Copilot’s usefulness without custom development.

**Apply zero trust principles.** Balance availability with least-privileged access to maintain security and compliance. Zero trust principles protect sensitive information and maintain compliance while enabling productivity.
 Review identity, access controls, and conditional policies to ensure that Copilot respects organizational security requirements. See [Microsoft 365 Copilot zero trust](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot?toc=%2Fcopilot%2Fmicrosoft-365%2Ftoc.json&bc=%2Fcopilot%2Fmicrosoft-365%2Fagent-framework%2Fbread%2Ftoc.json)

## Document retrieval decisions

Combining knowledge retrieval with live queries and actions enables the agent to deliver a complete and up-to-date solution. Document these decisions in the data plan. List each major data domain the agent handles and mark it as “search,” “API,” or both. For example:

    - “Product FAQs" via RAG from knowledge index
    - "Order tracking" via MCP call to Order Management APIC
    - "Create return label" via MCP to Shipping system API.

    This documentation removes ambiguity for developers and stakeholders about how the agent retrieves each type of information.


# v1

## Prepare data for Microsoft SaaS agents

Productivity agents in Microsoft 365 Copilot use organizational data stored in Microsoft Graph, which includes SharePoint, OneDrive, Exchange, and other Microsoft 365 sources. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). These agents retrieve documents, emails, and collaboration artifacts while respecting existing permissions. Unlike custom agents, leaders cannot feed external datasets directly to Copilot. Success depends on optimizing the Microsoft 365 environment.

1. **Ensure data readiness.** Place critical business information in Microsoft 365 where Copilot can access it under existing permissions. For example, store company policies on SharePoint in a well-organized site. If knowledge resides in Outlook archives or local drives, migrate it to SharePoint or Teams so it becomes part of Microsoft Graph. Copilot can only provide value when it can access relevant content, subject to security trimming. Data readiness ensures agents provide accurate and complete answers by accessing authoritative sources. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.

2. **Use Microsoft Graph connectors for external data.** If important data exists outside Microsoft 365, such as in an external CMS or database, use Microsoft Graph connectors to bring that content into the Microsoft Graph index. For example, connectors exist for file shares and SQL databases. This approach allows Copilot to retrieve answers from connected sources without building a custom agent, effectively extending Copilot’s reach by integrating external data into its native environment. Graph connectors reduce silos and extend Copilot’s usefulness without custom development.

3. **Apply zero trust principles.** Balance availability with least-privileged access to maintain security and compliance. Zero trust principles protect sensitive information and maintain compliance while enabling productivity.
 Review identity, access controls, and conditional policies to ensure that Copilot respects organizational security requirements. See [Microsoft 365 Copilot zero trust](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot?toc=%2Fcopilot%2Fmicrosoft-365%2Ftoc.json&bc=%2Fcopilot%2Fmicrosoft-365%2Fagent-framework%2Fbread%2Ftoc.json)

## Prepare data for custom agents

Custom AI agents built in Foundry adn Copilot Studio depend on high-quality, well-organized data. Preparing this data requires deliberate planning across the organization. The ability of these agents to deliver accurate answers depends on the quality and accessibility of the data provided. A strong data plan ensures that agents deliver secure and timely responses. Leaders should organize and connect data in a structured way to create a reliable experience for users.

### Unified data foundation for AI agents

Organizations that succeed with AI agents start by creating a strong data foundation. AI depends on accurate, comprehensive, and well-governed information. Without this foundation, even advanced AI tools produce inconsistent or unreliable results. Business leaders must define an enterprise-wide data plan that combines structured business data with collaborative content. Use Microsoft Fabric for business data. Microsoft Fabric provides OneLake, a tenant-wide logical data lake that centralizes structured data. This environment supports analytics, machine learning, and AI agents by storing data in performant formats such as Delta or Parquet. Fabric enables consistent reporting and analysis. One dataset can support SQL queries, dashboards, and AI models without duplication.

Why a unified foundation matters: AI agents operate across multiple domains, customer service, operations, HR, finance, and need access to both structured and unstructured data. If data remains siloed, agents cannot deliver complete answers or perform tasks effectively. A unified foundation ensures that every agent works from trusted sources and supports consistent reporting, analytics, and decision-making.

### Data retrieval strategies

Placing data in a unified foundation solves only part of the challenge. Leaders must decide how AI agents access and use that data to answer questions and perform tasks. Retrieval strategies determine whether agents provide accurate, timely, and secure responses. Two complementary approaches enable this access: retrieval-augmented generation (RAG) and model context protocol (MCP) servers. Clear decisions prevent missteps such as indexing data that should be queried live or exposing systems without proper controls. These mechanisms work together. For example, when an employee asks a Helpdesk AI, “I have VPN issues”:

- **RAG**: The agent retrieves the VPN troubleshooting guide from the knowledge base.
- **MCP (read)**: The agent checks the current VPN service status from an IT monitoring system.
- **MCP (write)**: The agent creates a helpdesk ticket if the user requests it.

Why retrieval strategies matter: AI agents cannot rely solely on their internal models because those models often contain outdated or incomplete information. Retrieval strategies allow agents to ground responses in authoritative sources and interact with operational systems securely. Without these strategies, organizations risk inaccurate answers, compliance violations, and poor user experiences.

- **RAG (look up and explain)**: RAG retrieves relevant content from approved sources and uses that content to build answers. This approach works best for unstructured or semi-structured information such as policies, manuals, FAQs, and wikis. RAG improves accuracy and transparency because the agent cites actual documents rather than relying on assumptions.

    - **Decision point**: Determine whether to create one centralized index or multiple domain-specific indexes. A single index simplifies management but can mix unrelated content and reduce relevance. Multiple indexes improve precision and governance but add complexity in query routing and maintenance.
    - **Action**: Document the chosen indexing approach in the data plan to avoid ad hoc decisions later.

- **MCP servers (get the latest and take action)**: MCP servers expose functions and queries through a standardized interface. They allow agents to perform live queries against APIs, databases, and SaaS platforms and to take actions such as creating tickets or updating records. MCP ensures secure and auditable interaction with operational systems.

    - **Decision point**: Identify systems where real-time data or transactional capabilities add business value. Examples include inventory systems, IT service management tools, and ERP platforms.
    - **Action**: Document which domains require MCP integration and define whether access is read-only or read-write. This distinction influences security and compliance requirements.

- **Document retrieval decisions in the data plan.** Combining knowledge retrieval with live queries and actions enables the agent to deliver a complete and up-to-date solution. Document these decisions in the data plan. List each major data domain the agent handles and mark it as “search,” “API,” or both. For example:

    - “Product FAQs" via RAG from knowledge index
    - "Order tracking" via MCP call to Order Management APIC
    - "Create return label" via MCP to Shipping system API.

    This documentation removes ambiguity for developers and stakeholders about how the agent retrieves each type of information.

Indexing improves speed and reduces API calls but creates stale data for dynamic sources. Live queries ensure freshness but require secure integration and may increase latency. Combining RAG and MCP delivers the best experience but adds design complexity. A clear plan prevents confusion and reduces integration risk. Retrieval strategies define how AI agents interact with enterprise data. A structured approach ensures that agents provide accurate answers, perform meaningful actions, and maintain compliance.

#### Plan for retrieval-augmented generation

Retrieval-augmented generation (RAG) improves the accuracy and transparency of AI agents by grounding responses in actual enterprise content instead of relying on the model’s internal knowledge. This approach is essential for business scenarios where trust and compliance matter. When an agent retrieves relevant content before generating an answer, it reduces the risk of outdated or fabricated information and enables source citation.

Why RAG matters: AI agents that rely only on their trained models often produce incomplete or incorrect answers. RAG ensures that responses come from authoritative documents and data, which builds confidence among employees and customers. It also supports compliance by referencing approved sources.

1. **Decide on central vs data-domain indexing.** Leaders must determine how to organize search indexes. If the organization’s knowledge base is moderate in size and relatively coherent, a single centralized index simplifies management and provides one place to query for any question. In large enterprises or when content falls into distinct categories, multiple domain-focused indexes improve relevance and governance. For example, separate indexes for HR policies, IT support documentation, and finance procedures allow data owners to manage their domain and help the agent search in the most relevant index. Trade-off: One index is easier to maintain but can return irrelevant results if it mixes disparate content. Multiple indexes yield more targeted results but add complexity in query routing and maintenance. Document the chosen approach in the data plan to prevent ad hoc decisions later.

2. **Plan index usage across multiple agents.** If the organization deploys multiple custom agents, decide whether each agent uses a dedicated index or shares indexes. Separate indexes work well for distinct domains such as finance or IT, while shared indexes promote consistency but require careful permission handling and filtering. Scalability note: Avoid creating dozens of separate indexes without a plan. Consider modular indexes that multiple agents can reuse to reduce maintenance complexity.

3. **Index content from golden sources.** Populate indexes with content from authoritative sources identified in the data strategy, such as those in Fabric. Include unstructured documents such as PDFs, Word files, and wikis, as well as structured data transformed for search. Ensure each source provides clean, relevant, and labeled data. Avoid duplicates and untrusted documents by selecting the best source for each type of information. Why this matters: Indexing authoritative content ensures that AI agents reference approved and accurate information rather than outdated or inconsistent data.

4. **Chunk and enrich content.** Divide large documents into smaller, coherent chunks, such as paragraphs or sections, to improve search precision. Enrich each chunk with metadata like document name, type, tags, and summaries. This enrichment enables better ranking and filtering. For example, if a user asks about international refund policy, the agent can filter for chunks tagged “refund” and “international.” Trade-off: Chunking and tagging require upfront effort, but they significantly improve search relevance and reduce the risk of irrelevant answers

5. **Improve retrieval.** Combine keyword search with semantic ranking and vector search to match queries based on meaning, not just exact terms. Ensure the index schema includes vector embeddings for each chunk to support semantic search. Configure indexes to store identifiers such as document names, URLs, or IDs so agents can cite sources in responses. This practice increases transparency and trust.

6. **Maintain and monitor indexes.** Refresh indexes regularly when source data changes. Monitor agent queries to identify gaps or irrelevant results and adjust indexing strategies accordingly. For example, add missing keywords or split documents into smaller chunks when needed. Treat index maintenance as an ongoing operational responsibility, not a one-time setup.

For detailed guidance, see [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index) and [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

#### Plan for MCP servers

Retrieval-augmented generation (RAG) addresses the need for AI agents to read and reference information, but many business scenarios require agents to take actions or access real-time data. These scenarios include answering questions such as “How many units of SKU123 are in stock right now?” or executing tasks like “Create a new incident ticket for this issue.” These capabilities require more than indexed content. They need a secure and standardized way to query systems and perform actions. Model Context Protocol (MCP) servers provide this capability.

Why MCP matters: MCP servers act as controlled connectors that expose functions and queries through a consistent interface. They allow AI agents to interact with operational systems securely and in a way that supports compliance. Without MCP, organizations face two poor alternatives: pre-indexing dynamic data, which quickly becomes stale, or granting direct database access, which introduces security and governance risks.

1. **Know where to use MCP.** Business leaders should include MCP integration in their data plan when any of the following conditions apply:

    - **Data is dynamic or too granular to index.** Examples include real-time sensor readings or data that changes every few seconds. Indexing such data creates stale results and unnecessary overhead.
    - **The action involves writing or transacting, not just readin**g. Examples include approving a request, sending an email, or invoking an API to update a record. These actions require controlled execution, not static reference.
    - **The source is a system with an API.** Many SaaS and internal systems provide APIs. Instead of continuously indexing all their data, allow the agent to query them on demand through MCP. This reduces storage and synchronization complexity.
    - **Security or compliance demands live query**. If regulations prevent storing certain data in an index, use MCP to fetch it securely with full auditing. This approach maintains compliance while enabling functionality.

2. **Identify candidate systems.** Work with IT leadership to identify systems where real-time data or transactional capabilities add business value. These typically include:

    - Customer relationship management platforms for pipeline updates
    - Enterprise resource planning systems for inventory and order management
    - IT service management tools for ticketing workflows
    - IoT databases for sensor readings
    - Internal web services that support specialized processes

    Clarify the type of interaction the AI agent needs. Some systems require read-only access for queries, while others demand read-write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs.

3. **MCP Server creation or connection**: After identifying candidate systems, the next decision is how to implement MCP servers. Organizations have **two primary options**. The first is to **configure pre-built connectors** when they are available. Microsoft and other vendors provide MCP connectors for widely used platforms such as Microsoft 365, Dynamics, and ServiceNow. Using these connectors accelerates adoption and reduces development complexity. The second option is to **build lightweight MCP wrappers** for systems that do not have existing connectors. This involves creating an interface that follows the MCP standard so the agent framework can communicate easily. When building these wrappers, design responses specifically for AI consumption. Instead of returning raw data, provide structured and simplified outputs that help the agent deliver accurate answers. Treat this work as a formal integration project focused on reliability and security rather than a quick customization.

4. **Enforce security and compliance for MCP.** Security and compliance must be central to MCP implementation. Each MCP server should require authentication for every interaction. The AI agent passes an identity token so the MCP server validates the user and applies role-based permissions. This approach ensures that only authorized users can access sensitive data or perform actions. Organizations should also apply Zero Trust principles. For example, if a frontline employee requests financial data, the MCP linked to the finance system must reject the request unless the user has explicit access rights. In addition, all MCP calls should be logged for auditing. These logs must capture who made the request, what data was returned, and what actions were executed. Maintaining this level of transparency supports compliance and enables incident investigation when needed.

5. **MCP for custom agents.** Custom AI agents benefit significantly from MCP integration. Register MCP endpoints in the agent platform so the agent knows which tools are available. For instance, connecting an “InventoryMCP” tool allows the agent to provide real-time inventory answers without relying on outdated indexes. Without MCP, organizations face two poor alternatives. They can pre-index inventory data, which becomes stale quickly, or they can provide direct database credentials to the agent, which introduces security and management challenges. MCP solves these problems by offering a controlled, logged gateway to live data and transactional actions.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)