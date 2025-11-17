---
title: Data plan for AI agents
ms.reviewer: ssumner
description: Learn how to develop a comprehensive data plan that enables AI agents to deliver business value through effective data management, preparation, and security.
author: stephen-sumner
ms.author: pnp
ms.date: 11/14/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Data plan for AI agents

Organizations need a data plan to enable AI agents to deliver accurate, secure, and compliant outcomes. A good data plan ensures that enterprise SaaS agents such as Microsoft 365 Copilot have governed access to productivity content, and that teams building custom AI agents work with high-quality, well-prepared data. Without this foundation, AI adoption introduces unnecessary risk, inefficiency, and cost.

## Prepare data for Microsoft SaaS agents

Productivity agents such as Microsoft 365 Copilot agents, depend on access to organizational content stored in OneDrive, SharePoint, Exchange, and other Microsoft 365 sources. These agents use Microsoft Graph to retrieve documents, emails, and collaboration artifacts while respecting existing permissions. See [Microsoft 365 Copilot architecture](/copilot/microsoft-365/microsoft-365-copilot-architecture#user-access-and-data-privacy). To prepare your data for Microsoft 365 Copilot agents:

1. **Use the adoption guide.** Follow the [Microsoft 365 adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources#step-1---get-your-organization-ready-and-use-the-microsoft-adoption-site) to get your data ready.  

1. **Apply zero trust principles.** To ensure secure and effective access, organizations must balance availability with least-privileged access principles. See [Microsoft 365 Copilot zero trust](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot?toc=%2Fcopilot%2Fmicrosoft-365%2Ftoc.json&bc=%2Fcopilot%2Fmicrosoft-365%2Fagent-framework%2Fbread%2Ftoc.json)

## Prepare data for custom agents

Custom agents built in platforms such as Copilot Studio or Foundry require indexed data sources. High-quality data improves performance by enabling agents to reason over content and retrieve relevant information.

### Establish a unified data platform

Create a centralized data platform as the authoritative source for structured business data. Start with Microsoft Fabric, which represents all data in Fabric without creating multiple copies.See [Fabric mirroring overview](/fabric/mirroring/overview).

### Data preparation for Copilot Studio agents

When you build an agent in Copilot Studio, its ability to deliver accurate, helpful answers depends on the quality and accessibility of the data you provide. Think of this as creating a strong foundation for your agent. A well-prepared data plan ensures your agent delivers accurate, secure, and timely answers. By organizing and connecting your data thoughtfully, you create a reliable experience for your users. Here’s how to prepare:

1. Decide What Knowledge Your Agent Needs
Start by identifying the types of questions your agent should answer. Will it handle FAQs, product details, or internal policies? This clarity helps you choose the right sources, files, folders, or external systems.

Step 2: Gather and Organize Your Data
Collect the documents, spreadsheets, and knowledge bases your agent will use. Store them in accessible locations like OneDrive, SharePoint, or supported systems such as Salesforce or ServiceNow. Organize them into folders with clear names and remove duplicates or outdated content.

Step 3: Check File Readiness
Before uploading:

Ensure files are in supported formats and not password-protected.
Avoid confidential or highly restricted content unless permissions are properly managed.
If files come from shared locations, confirm the agent maker has access.


Step 4: Connect Your Sources
In Copilot Studio, add your files or connect to external systems using built-in connectors. When you connect a folder or knowledge base, the entire structure is indexed—not just individual files—so keep your folders clean and relevant.

Step 5: Understand How Your Data Is Processed
Copilot Studio breaks your content into smaller chunks and creates semantic indexes and vector embeddings. This allows the agent to retrieve the most relevant pieces of information when answering questions.

Step 6: Keep Data Fresh
Connected sources sync automatically on a schedule. Deleted files are removed during refresh, so your agent stays up to date. Manual refresh isn’t available yet, so plan for periodic updates in your source systems.

Step 7: Respect Limits and Permissions
Each agent can include:

Up to 500 knowledge objects (files, folders, articles).
A maximum of 5 different sources.
Permissions are enforced at query time—users only see what they’re allowed to access.


Step 8: Enable Dataverse Search
If you can’t add files, check with your admin to ensure Dataverse search is enabled. This is required for knowledge sources to work.

### Data preparation for Foundry agents

 how to create a strategic data plan that supports agents built on Azure AI Foundry and Azure AI Search. The steps follow the logical sequence leaders should consider when planning and implementing this strategy.

## 1. Organize knowledge around data domains and data products

Start by defining **data domains** that align with business units or major functional areas such as HR, finance, or customer support. Treat each domain as a **data product** that exposes the right indexes and knowledge for all agents that need it. This approach reduces duplication and simplifies governance because agents within the same domain share common knowledge needs.

Instead of creating separate indexes for every agent, maintain one authoritative index per domain. In Azure AI Foundry, a knowledge source points to an Azure AI Search index. Multiple agents reference the same knowledge source, which connects to the domain index. This design allows organizations to monitor API calls, enforce security boundaries where needed, and maintain consistent governance.

**Why this structure matters:** Organizing data as products within domains prevents drift in how information is chunked, embedded, and retrieved. It also lowers operational overhead by reducing redundant ingestion pipelines and ensures predictable cost as adoption grows.

### 2. Define a clear data contract

A data contract is an agreement that sets expectations for how information supports intelligent agents across the organization. Establishing this contract early prevents misalignment and ensures that every agent operates on consistent, reliable data. Business leaders should focus on five key decisions when planning this contract:

**1. Clarify the knowledge scope**  
Determine what information each agent family needs to answer questions effectively. Decide which data sources are shared across multiple agents and which are unique to specific use cases. Document these choices so teams understand where authoritative knowledge resides.

**2. Confirm index readiness**  
Indexes are structured collections of searchable content. Ensure that each index includes clear text fields, ranking rules for relevance, and metadata such as document titles and sections. These elements make it possible for agents to provide accurate, traceable answers.

**3. Set a standard for content structure**  
Break large documents into smaller, logical sections that preserve headings and context. Consistent structure improves retrieval accuracy and reduces confusion when agents cite information. Aim for a predictable format that works across all domains.

**4. Align on embedding approach**  
Embedding refers to converting text into numeric representations for similarity matching. Use the same approach for both storing and querying data to maintain consistency. This alignment avoids mismatched results and ensures predictable performance.

**5. Define relevance controls**  
Decide how to handle internal terminology, acronyms, and business priorities such as freshness or regional relevance. Create synonym lists and scoring rules that reflect organizational needs. Apply these rules consistently so agents prioritize the right information.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)