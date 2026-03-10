---
title: Data architecture for AI agents across your organization
ms.reviewer: ssumner
description: Explore how Microsoft Fabric and OneLake enable AI agents to operate on unified, trusted data for better decision-making and automation.
#customer intent: As a CTO or enterprise architect, I want to understand how to prepare our data and data architecture so that AI agents can access and remain grounded in our organizational data. I need to know how to achieve this in the most cost-effective way, enabling us to unlock the power of agents securely and in a governed manner—ensuring no data leakage while maintaining up-to-date, accurate information that integrates seamlessly with platforms like Microsoft Foundry and Copilot Studio.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data architecture for AI agents

This article outlines how to prepare your data estate for AI agents, ensuring they operate on a unified, secure, and governed foundation. Because agents synthesize information rather than create it, their accuracy depends entirely on the quality and accessibility of underlying sources. Fragmented or ungoverned data leads to misleading results and security risks. This planning is the final step in the **Plan for agents** phase of AI agent adoption (*see figure 1*).

:::image type="content" source="./images/ai-agent-adoption.svg" alt-text="Diagram showing a horizontal workflow with four connected phases: plan for agents (sub-steps are business plan, technology plan, organizational readiness, and data architecture). Govern and secure agents (Sub-steps are Responsible AI, Governance and Security, and Prepare environment). Build agents (Sub-steps are single and multi-agent systems and process to build agents). Manage agents integrate (sub-processes Integrate agents and operate agents)." lightbox="./images/ai-agent-adoption.svg" border="false":::
*Figure 1. Microsoft's AI agent adoption process.*

Use this guidance to prepare your data estate for Microsoft SaaS agents, including Microsoft 365 Copilot, and custom agents built on Microsoft Foundry and Microsoft Copilot Studio. These architectural decisions ensure agents operate on authoritative content, respect compliance boundaries, and support rapid deployment.

## Unify your data platform

A unified data platform provides the architecture AI agents rely on. Microsoft Fabric OneLake serves as the central data lake where data domains create governed data products. These data products become the primary inputs for AI across the organization. AI agents consume these data products through Fabric IQ, Foundry IQ in Microsoft Foundry, and Microsoft Copilot Studio. This consumption model enforces governance, preserves security boundaries, and ensures agents operate on high‑quality inputs. This architecture establishes a single, trusted foundation for analytics and AI. For complete guidance, see [Unify your data platform](../data/executive-strategy-unify-data-platform.md).

:::image type="content" source="../data/images/unified-data-platform-architecture-ai-analytics.svg" alt-text="diagram showing data flow from non-Azure sources into Microsoft services. At the base, external data enters and moves upward into multiple data domains representing business units. Each domain connects to Microsoft Fabric OneLake workspaces for unified business data. Above, processing occurs using Fabric IQ and Fabric data agents, which then feed into Microsoft Foundry agents in Azure or Copilot Studio agents within the Microsoft ecosystem. At the top, agents integrate with Azure landing zones: platform landing zones with management groups and subscriptions, application landing zones hosting Foundry, and data management landing zones hosting Fabric capacity. Azure Databricks appears in a data landing zone for advanced analytics, enabling insights across teams." lightbox="../data/images/unified-data-platform-architecture-ai-analytics.svg" border="false":::
*Figure 2. Architecture: Unified data platform for AI and analytics.*

## Prepare Microsoft 365 data

Once your data platform is unified, also prepare Microsoft 365 data for agent consumption. Microsoft 365 Copilot agents rely on information available through Microsoft Graph. This information includes content from SharePoint, OneDrive, Exchange, and Teams. Agents retrieve content while enforcing existing permissions, sensitivity labels, and tenant policies. They don't bypass Microsoft 365 security controls.

Agents in Foundry ([SharePoint](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry&preserve-view=true)) and [Copilot Studio](/microsoft-copilot-studio/knowledge-copilot-studio#supported-knowledge-sources) can also connect to data in Microsoft 365 apps. Use the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready. For architecture details, see [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy).

**What data belongs in Microsoft 365?** At this stage, the decision isn't about retrieval mechanics. The decision is about placement. Content that serves collaboration, reference, or organizational knowledge should live in Microsoft 365. That content remains governed through document‑level permissions and retention policies.

## Data retrieval strategies for custom agents

Organizations building AI agents must decide how the agent accesses data to answer questions and perform tasks. These choices directly affect accuracy, timeliness, and security. Agents generally combine two complementary approaches: agentic retrieval and Model Context Protocol (MCP) servers.

When an employee reports a VPN issue, an effective agent uses agentic retrieval to pull the troubleshooting guide from the organization's approved knowledge sources. It checks the real‑time VPN service status through an MCP read operation, and it can create a helpdesk ticket through an MCP write operation if the user requests it. Agentic retrieval provides curated, authoritative knowledge. MCP provides operational data and the ability to take actions.

**Agentic retrieval and RAG**: Agentic retrieval includes the retrieval‑and‑grounding aspects of traditional RAG, but extends them with reasoning, decomposition, parallel evidence gathering, and multi‑source synthesis. It's the preferred term and recommended pattern for enterprise AI agents.

Both approaches work best when they draw from a unified, governed data foundation. Microsoft Fabric supports this through OneLake and the medallion architecture, organizing structured, semi‑structured, and unstructured content. Adaptive Gold extends this model by allowing agents to optimize knowledge curation based on usage patterns.

See [agentic RAG](/azure/ai-foundry/concepts/retrieval-augmented-generation?view=foundry&preserve-view=true#agentic-rag-modern-approach-to-retrieval) and [MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true).

### Start with built-in retrieval options

Begin with the retrieval capabilities built into Microsoft Foundry and Copilot Studio. Built‑in agentic retrieval and MCP features reduce integration complexity, accelerate deployment, and maintain governance consistency. Before investing in custom solutions, confirm whether these capabilities satisfy requirements for accuracy, compliance, and operational control.
Examples of built‑in capabilities include:

- [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&preserve-view=true&preserve-view=true&tabs=foundry%2Cpython)
- [Fabric IQ](/fabric/iq/overview)
- [Fabric data agents](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundry&preserve-view=truen)
- [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true)
- [SharePoint connection](/azure/ai-foundry/agents/how-to/tools/sharepoint?view=foundry&preserve-view=true)
- [Azure AI Search](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&preserve-view=true&tabs=keys%2Cazurecli)
- [OneLake search indexers](/azure/search/search-how-to-index-onelake-files)

### Plan for agentic retrieval

**When to use agentic retrieval**: Use agentic retrieval when an agent must look up, explain, and cite information, especially from unstructured or semi‑structured content such as policies, manuals, FAQs, product documentation, and curated extracts. Unlike a static RAG application that queries a single fixed index, agentic retrieval orchestrates a broader reasoning process. It decomposes user questions into sub‑queries, runs parallel searches across approved sources, reconciles conflicting information, and synthesizes an answer grounded with citations. This approach provides just‑in‑time context and higher accuracy without locking the system into a static retrieval corpus or ranking strategy.

1. **Plan for a unified knowledge layer.** A unified knowledge layer consolidates retrievable content behind an approved endpoint or shared knowledge base so multiple agents and applications can produce consistent, grounded answers. These reusable knowledge bases typically center on domains such as employee policies, product documentation, and support content. Foundry IQ is the preferred service for building this layer. It can incorporate curated Silver, Gold, and Adaptive Gold datasets produced by Fabric data agents, along with Azure AI Search indexes when authoritative answers are required. See [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&preserve-view=true&tabs=foundry%2Cpython).

2. **Plan for indexes.** Use an Azure AI Search index when you need tightly controlled retrieval behavior, including custom chunking, embeddings, fine‑tuned ranking, or deterministic search over a defined corpus. Indexes complement, not replace, the unified knowledge layer.

    **Retrieval from Fabric OneLake**: Create Azure AI Search OneLake Search [search indexers](/azure/search/search-how-to-index-onelake-files) over Silver‑layer data. Silver is the correct layer for agent grounding because Silver retains the raw relationships, structure, and patterns. Gold datasets introduce aggregations and transformations that improve analytics but remove the detail agents need for reasoning, inference, and multi‑source synthesis. Agents use Silver datasets to identify relationships and patterns, and might generate a curated dataset as a result. You can register the curated dataset as a data product in Purview, or you can store it as an instruction/specification file in Git so the agent can regenerate the curated set on demand. For architectural guidance, see [Fabric enterprise architecture](/azure/architecture/example-scenario/analytics/enterprise-bi-microsoft-fabric).

### Plan for building MCP servers

**When to use MCP?** Choose MCP when agents must take actions or access real‑time data. For example, "How many units of SKU123 are in stock right now?" or "Create an incident ticket." MCP gives agents a standardized way to call tools hosted on remote servers, with identity, policy, and audit controls.

1. **Identify candidate systems.**  Prioritize systems where live queries or transactions add value: CRM for pipeline updates, ERP for inventory and orders, ITSM for tickets, IoT telemetry for sensor readings, and internal APIs for specialized processes.

2. **Build or connect MCP servers.** Use available and built‑in MCP servers in Foundry and Copilot Studio. If they aren't available, you need to build them. Clarify the type of interaction the AI agent needs. Some systems require read‑only access for queries, while others demand read‑write capabilities to create or update records. This distinction influences security controls and compliance requirements. Define these roles early to avoid unnecessary risk and ensure governance aligns with operational needs. See [Connect to MCP servers](/azure/ai-foundry/agents/how-to/tools/model-context-protocol?view=foundry&preserve-view=true) or [Build and register an MCP server](/azure/ai-foundry/mcp/build-your-own-mcp-server?view=foundry&preserve-view=true).

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