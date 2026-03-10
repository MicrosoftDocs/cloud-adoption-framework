---
title: Data Product Security Standards for Microsoft AI and Analytics
description: Understand how Microsoft and Azure AI and analytics enforce data security when consuming from Microsoft Fabric and decide what security standards to set for your org
#customer intent:  As a decision maker (business leader, data domain lead, CTO), I want a checklist of best practices and decision guidance to help me make the right decisions on how to understand how Microsoft and Azure AI and analytics enforce data security when consuming from Microsoft Fabric and decide what security standards to set for your org.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data security standards for AI and analytics

AI and analytics consume data products in a unified data platform through multiple Microsoft services. Each service enforces security in a specific way. **Recommendation:** For every Microsoft product that can access data products, first understand its native access and security model. Then, decide whether to inherit it as‑is or define standards where your requirements aren't met (see Figure 1). To apply this recommendation, use this article as a checklist:

:::image type="content" source="images/operational-standards-unify-data-platform.svg" alt-text="Diagram showing the three major steps in setting operational standards. First, set data-processing standards like how to move data through the bronze, silver, and gold layers. Second, set security standards for how to secure data products in different Microsoft services. Third, set consumption and lifecycle standards for data products." lightbox="images/operational-standards-unify-data-platform.svg" border="false":::
*Figure 1. Three steps to setting operational standards for data.*

## Business data in AI standard

Successful organizations publish a policy that limits business data use to services that honor tenant controls and don't reuse prompts for training. They also set an approval gate for any tool that can capture prompts or outputs. They train leaders to treat prompts as business records. **Best practices:** Microsoft doesn't use that data to train foundation models. Treat the Microsoft boundary as a required security baseline for business data.

## Microsoft 365 Copilot security standard

**Access model in Microsoft 365 apps:** Microsoft 365 Copilot can access only the data already available to a user within Microsoft 365. This data includes files, emails, chats, calendars, and other information exposed through Microsoft Graph and the [Semantic Index](/microsoftsearch/semantic-index-for-copilot#privacy-compliance-and-security). Microsoft 365 Copilot uses the user's existing identity and respects all current access permissions. Copilot operates entirely within Microsoft's enterprise boundary, and prompt data isn't used for model training. **Best practices:** Continue to rely on Microsoft 365's built-in security model. [How does Microsoft 365 Copilot protect organizational data?](/copilot/microsoft-365/microsoft-365-copilot-privacy#how-does-microsoft-365-copilot-protect-organizational-data)

**Access model with Fabric data agents:** When Microsoft 365 Copilot connects to a Fabric data agent, it continues to operate under the user's identity. Fabric remains responsible for enforcing workspace permissions, item permissions, and row‑ or column‑level security. This security model makes sure users never see more data through Copilot than they're already entitled to view in Fabric. To learn more, see [Microsoft 365 Copilot and Fabric data agent](/fabric/data-science/data-agent-microsoft-365-copilot).

## Fabric data agent security standard

**Access model:** Fabric Data Agents are a governed interface to your data in Microsoft Fabric's OneLake. When a Copilot or Foundry queries a Fabric Data Agent, it must authenticate as a user. Fabric applies all its normal security filters on the data. In short, the Fabric data agent doesn't return data that the user can't retrieve in Fabric. Any sensitive-data policies down to rows and columns remain in force. Using a Fabric Data Agent doesn't expose any data by itself. It's another entry point that fully respects Fabric's governance settings. To learn more, see [Fabric data agent sharing and permission management](/fabric/data-science/data-agent-sharing). **Best practices:**

- **Use Fabric agents for internal data.** If your AI or reporting solution needs to pull structured data, require it to go through a Fabric Data Agent instead of bypassing with direct connectors. This approach guarantees unified enforcement of all data policies during AI consumption. For example, if an AI assistant in Teams needs sales figures, have it query a published Fabric agent so that the security policy automatically applies.

- **One agent per audience.** You can publish multiple Fabric Data Agents with different scopes. If different user groups should see different slices of data, create separate agents with appropriate security filters. Avoid a one-size-fits-all agent. This way, each agent experience delivers results appropriate to the caller's role.

- **Govern publishing.** You should govern how agents are published and shared to ensure quality and operational consistency. As a decision maker, you might require an approval step before publishing Fabric agents to the Microsoft 365 Copilot Agent Catalog. This step helps prevent low-quality agents from circulating, even though they can't bypass data access controls.

## Azure AI Search security standard

**Access model:** Azure AI Search indexes data so applications and AI systems can retrieve it. It can read data from [Fabric OneLake](/azure/search/agentic-knowledge-source-how-to-onelake?pivots=python) and other locations only when [granted explicit permission](/azure/search/search-how-to-index-onelake-files#grant-permissions). However, by default, an Azure AI Search index doesn't automatically enforce your source permissions. Once data is indexed, any user or app with query access to the index could retrieve that content. **Best practices:**

1. **Enforce either labels or ACLs (or both).** Require [ACL‑based filtering](/azure/search/search-query-access-control-rbac-enforcement) and/or [Microsoft Purview sensitivity‑label enforcement](/azure/search/search-query-sensitivity-labels) for sensitive content. Avoid indexing sensitive files unless you have strong label or access control list (ACL) enforcement in place. **Decision guidance:** Choose Purview sensitivity labels when you want centralized policy control, such as automatically denying all "Secret" data. **Tradeoff**: You accept dependency on correct labeling and label governance. Choose ACL filtering when access needs to mirror file-by-file permissions and you can manage the metadata overhead. **Tradeoff**: You accept higher metadata-management cost. Choose both when you need defense in depth. **Tradeoff**: You accept more complexity in troubleshooting and validation.

2. **Index only what's approved:** Include only content that your organization is comfortable exposing broadly or can be secured through metadata. Avoid indexing sensitive files unless you have strong label or ACL enforcement in place. Maintain an inventory of search indexes and designate owners for them, so you know what data is being made searchable.

3. **Test with real user accounts.** Before deploying an AI solution that uses Azure Search, test the search queries with accounts of different roles to verify that restricted content truly stays filtered out. Catching a misconfigured index (one missing certain ACL entries) in testing prevents an accidental exposure later. This guidance applies to all platforms that use Azure AI Search. It includes Microsoft Foundry, Microsoft Copilot Studio, and any other system that queries Azure AI Search indexes.

## Microsoft Foundry security standard

**Access model:** Microsoft Foundry enables custom AI agents to connect to data through multiple access paths. These options create material governance and security decisions for leaders responsible for platform standards. **Recommendation:** Set an organization-wide access model that defines approved data integration paths for Foundry agents. To apply this recommendation, use the following checklist:

- **Use Foundry IQ.** Foundry IQ is a managed knowledge layer built on Azure AI Search. It enforces access through indexed metadata, such as sensitivity labels or access control lists, when those signals are present in the source and supported by the connector. **Best practices:** Treat Foundry IQ the same way you treat Azure AI Search. Require that all indexed content comes from sources with well‑managed permissions or from data that has sensitivity labels in Microsoft Purview. Make metadata quality a prerequisite for approval. **Decision guidance:** Choose this option when you need consistent access enforcement across agents. Avoid it only when the data source can't provide reliable metadata. The tradeoff is broader coverage versus predictable security behavior. See [Connect Agents to Foundry IQ Knowledge Bases](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval#authentication-and-permissions).

- **Use Fabric data agents.** Foundry agents can call Fabric Data Agents as tools. Fabric enforces its own fine‑grained security and applies it consistently across analytics and AI experiences. **Best practices:** Treat Fabric Data Agents as the preferred access path for high‑value or sensitive organizational data. This approach preserves one security model across Power BI, Copilot, and custom agents. **Decision guidance:** Decide which data categories must be accessed through Fabric only. Choose this option for governed data products and shared analytics assets. The tradeoff is architectural consistency versus limited integration paths. See [Microsoft Foundry](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundry&preserve-view=true&pivots=python) and [Microsoft Fabric](/fabric/data-science/data-agent-foundry#how-it-works).

- **Use Azure AI Search indexes.** Foundry agents can query an Azure AI Search index directly instead of using Foundry IQ. This path bypasses any other guardrails that a curated knowledge base might provide. **Best practices:** Require that any directly connected index enforces access through labels or access control lists. Assume that an unsecured index exposes all documents to all users. **Decision guidance:** Choose direct index access for scenarios where security controls are enforced at the index level. Prefer Foundry IQ when governance consistency matters. The tradeoff is flexibility versus risk of unintended data exposure. See [Connect an Azure AI Search index to Foundry agents](/azure/ai-foundry/agents/how-to/tools/ai-search).

- **Use MCP servers.** MCP servers enable Foundry agents to invoke tools that interact with external APIs, services, and data sources, including databases. **Best practices:** Require user-identity passthrough when an MCP tool accesses sensitive data or systems with user‑specific permissions. Avoid MCP connections to systems that can't restrict access per user. **Decision guidance:** Decide if shared credentials are acceptable. Require user‑based authentication for business data and operational systems. The tradeoff is operational simplicity versus strong access control. See [MCP server authentication](/azure/ai-foundry/agents/how-to/mcp-authentication).

**Decision guidance:**

- **Define an AI architecture standard:** Foundry supports many integration patterns, which increases flexibility but also increases risk without clear boundaries. **Best practices:** Define which connector types are approved for internal data, which require review, and which are disallowed. Align this standard with your existing data and security policies. **Decision guidance:** Decide which access paths are mandatory for internal data. Choose Fabric or approved knowledge bases when security consistency matters most. Restrict unvetted sources. The tradeoff is innovation speed versus predictable security outcomes.

- **Require oversight for high-risk agents:** Custom agents can combine multiple tools, which increases exposure when agents access sensitive systems or perform actions. **Best practices:** Require formal review for any agent that connects to sensitive systems or performs actions. Validate that every tool enforces authentication and authorization correctly. **Decision guidance:** Decide which agent classes require strict review. Apply lighter review to low-risk and read-only scenarios. The tradeoff is governance effort versus exposure reduction.

- **Require security competency as a condition for AI development:** Each Foundry connector enforces security differently, and misuse can bypass user‑level controls without intent. **Best practices:** Require teams to understand the security model of every approved connector. Standardize on supported identity frameworks, such as Microsoft Entra ID. **Decision guidance:** Decide how security competency is enforced. Use gated access or formal validation for teams handling sensitive data. Apply lighter requirements for low‑risk use. The tradeoff is enablement speed versus reduced misconfiguration risk.

### Microsoft Copilot Studio security standard

**Access model:** Microsoft Copilot Studio enables your organization to build custom copilots (agents) that run within your Microsoft 365 tenant environment. These custom copilots can connect to various knowledge sources, such as SharePoint, OneDrive, databases, or even Fabric Data Agents, to retrieve information. Copilot Studio runs in Microsoft's cloud and processes prompts and responses inside the Microsoft 365 service boundary. Prompts and responses remain in the tenant, and Microsoft doesn't use them for model training, consistent with Microsoft 365 Copilot behavior.

Copilot Studio agents access organizational data by using the current user's Microsoft Entra identity. The agent can only retrieve content that the user already has permission to view in systems, such as SharePoint or OneDrive.

**Best practices:** To help govern outputs, use Purview [sensitivity labels](/microsoft-copilot-studio/sensitivity-label-copilot-studio#microsoft-purview-strengthens-information-protection-for-copilot-studio) flow through responses. To block knowledge sources, administrators can apply [data policies](/microsoft-copilot-studio/admin-data-loss-prevention) to limit which knowledge sources are available.

Copilot Studio can retrieve data products through Azure AI Search and Fabric data agents. Each option enforces security differently and must align with organizational standards. **Decision guidance:**

- **Azure AI Search:** Choose Azure AI Search when indexed content already uses ACLs or sensitivity labels. See [Azure AI Search](/microsoft-copilot-studio/knowledge-azure-ai-search).

- **Fabric data agents:** Choose Fabric data agents when you need native enforcement of workspace, item, row‑level, and column‑level security defined in Fabric. See [Fabric data agents](/fabric/data-science/data-agent-microsoft-copilot-studio) and [Consuming a data agent in Microsoft Copilot Studio](/fabric/data-science/data-agent-microsoft-copilot-studio).

### Microsoft Power BI security standard

**Access model:** Power BI transforms OneLake data into reports and dashboards while preserving Microsoft Purview sensitivity labels. These protections extend to exported content when supported by upstream systems. **Decision guidance:** For leaders, Power BI represents the final mile of data exposure. Making sure labels are applied upstream guarantees that protections remain intact even when content is shared or exported. See [Power BI implementation planning](/power-bi/guidance/powerbi-implementation-planning-content-distribution-sharing).

### Copilot in Fabric security standard

**Access model:** Copilot in Fabric operates entirely within Fabric and acts only on behalf of the signed‑in user. It doesn't introduce a new access path and can't exceed existing permissions. Outputs remain private until explicitly shared. See [Privacy, Security, and Responsible AI Use of Copilot in Fabric](/fabric/fundamentals/copilot-privacy-security). See [diagram of Copilot in Fabric](/fabric/fundamentals/how-copilot-works#process-overview-diagram).

### Next step

> [!div class="nextstepaction"]
> [Data consumption standards](./operational-standards-data-product-consumption-unify-data-platform.md)

