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

Organizations need a comprehensive data plan to enable AI agents to deliver accurate, secure, and compliant outcomes. A strong data plan ensures that SaaS agents, such as agents in Microsoft 365 Copilot, have governed access to productivity content and that teams creating custom AI agents work with high-quality, well-prepared data. A well-defined data strategy ensures agents deliver accurate, traceable answers while maintaining compliance and security. Leaders who invest in planning avoid fragmentation, reduce operational risk, and create a foundation for scalable AI solutions.

This article explains how to prepare organizational data for both Microsoft SaaS agents and custom agents in Foundry and Copilot Studio. It outlines the decisions leaders must make to ensure data readiness, governance, and alignment with business priorities.

## Prepare data for Microsoft SaaS agents

Productivity agents such as Microsoft 365 Copilot agents, depend on access to organizational content stored in OneDrive, SharePoint, Exchange, and other Microsoft 365 sources. These agents use Microsoft Graph to retrieve documents, emails, and collaboration artifacts while respecting existing permissions. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). To prepare your data for Microsoft 365 Copilot agents:

1. **Use the adoption guide.** Follow the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.  

1. **Apply zero trust principles.** To ensure secure and effective access, organizations must balance availability with least-privileged access principles. See [Microsoft 365 Copilot zero trust](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot?toc=%2Fcopilot%2Fmicrosoft-365%2Ftoc.json&bc=%2Fcopilot%2Fmicrosoft-365%2Fagent-framework%2Fbread%2Ftoc.json)

## Prepare data for custom agents

Custom agents built in platforms such as Copilot Studio or Azure AI Foundry depend on high-quality, well-organized data. Preparing this data requires deliberate planning across the organization. The ability of these agents to deliver accurate answers depends on the quality and accessibility of the data provided. A strong data plan ensures that agents deliver secure and timely responses. Leaders should organize and connect data in a structured way to create a reliable experience for users.

### Establish a unified data platform

Organizations should start by creating a unified data platform that serves as the authoritative source for structured business data. This approach reduces duplication, simplifies governance, and ensures predictable costs as adoption grows.

1. **Identify data domains.** Define data domains that align with major business units or functional areas such as HR, finance, or customer support. Treat required agent data indexes and the underlying data as data products. This structure exposes the right indexes for all agents that need them and prevents unnecessary duplication. Organizing data as products within domains prevents inconsistencies in how information is chunked, embedded, and retrieved. It also reduces operational overhead by eliminating redundant ingestion pipelines and supports consistent governance.

2. **Create a centralized data platform.** Create a centralized data platform as the authoritative source for structured business data. Start with Microsoft Fabric, which represents all data in Fabric without creating multiple copies. See [Fabric mirroring overview](/fabric/mirroring/overview).

3. **Define data glossary.** Establish clear rules for how agents interpret and prioritize information. Decide how to handle internal terminology, acronyms, and business priorities such as freshness or regional relevance. Create synonym lists and scoring rules that reflect organizational needs. Apply these rules consistently so agents retrieve the most relevant and accurate information.

### Data preparation for Copilot Studio agents

When building an agent in Copilot Studio, its ability to deliver accurate answers depends on the quality and accessibility of the data provided. A well-prepared data plan ensures the agent delivers secure and timely answers. Organize and connect data thoughtfully to create a reliable experience for users. Steps to prepare data:

1. **Decide what knowledge the agent needs.** Identify the types of questions the agent answers, such as FAQs, product details, or internal policies. This clarity helps select the right sources, files, folders, or external systems.

2. **Gather and organize data.** Collect documents, spreadsheets, and knowledge bases. Store them in accessible locations like OneDrive, SharePoint, or supported systems such as Salesforce or ServiceNow. Organize folders with clear names and remove duplicates or outdated content.

3. **Check file readiness.** Ensure files are in supported formats and not password-protected. Avoid confidential or highly restricted content unless permissions are properly managed. Confirm the agent maker has access to shared locations.

4. **Connect sources** In Copilot Studio, add files or connect to external systems using built-in connectors. When connecting a folder or knowledge base, the entire structure is indexed, not just individual files, so keep folders clean and relevant.

5. **Understand how data is processed.** Copilot Studio breaks content into smaller chunks and creates semantic indexes and vector embeddings. This process enables the agent to retrieve relevant information when answering questions.

For more information, see [Knowledge sources summary](/microsoft-copilot-studio/knowledge-copilot-studio).

### Data preparation for Foundry agents

Create a strategic data plan that supports agents built on Foundry and Azure AI Search. The steps follow the logical sequence leaders consider when planning and implementing this strategy.

1. **Scope the data.** Identify the types of data custom agents will need. Determine what information agents in each data domain need to answer questions effectively. Decide which data sources are shared across multiple agents and which are unique to specific use cases. Document these choices so teams understand where authoritative knowledge resides.

2. **Prepare data.** Plan to store authoritative documents, spreadsheets, and knowledge bases in a single environment that enforces governance and compliance. Use Microsoft Fabric as the foundation for golden datasets that feed Azure AI Search indexes and other retrieval mechanisms. Fabric provides integrated security, monitoring, and data quality controls, which reduce fragmentation and simplify compliance. A centralized approach requires upfront investment in governance and data stewardship. However, it avoids costly rework later and ensures consistent access across domains.

3. **Plan for chunking and enriching** Large documents often reduce retrieval accuracy. Plan to break content into smaller, logical sections that preserve headings and context. Define a predictable structure that applies across domains. This consistency improves search precision and reduces confusion when agents cite information. Poorly structured content leads to incomplete or inaccurate responses. A clear chunking strategy supports traceability and compliance.

4. **Plan for embedding** Embedding converts text into numeric representations for similarity matching. Plan to use the same approach for storing and querying data. Consistency prevents mismatched results and ensures predictable performance across agents. Standardize embedding practices across teams to avoid fragmented implementations that degrade accuracy.

5. **Plan indexes.** Indexes organize searchable content. A domain-based index design allows multiple agents to reference the same authoritative source, simplifying governance and enforcing security boundaries. This approach also enables monitoring of API usage and reduces duplication.
Considerations: Some organizations face constraints such as legacy systems or specialized use cases that require separate indexes. Evaluate whether domain-level indexing aligns with your governance model and operational priorities. If feasible, plan for this structure early to avoid costly redesign later. For detailed guidance, see [Design an index for agentic retrieval](/azure/search/agentic-retrieval-how-to-create-index).

For more information, see [Design and develop a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)