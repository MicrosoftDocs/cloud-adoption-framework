# Data product security standards

Once data products are in place, it’s critical to enforce a **consistent security model** whenever and wherever those products are accessed. In a unified data platform, data may be consumed through various tools: Power BI reports, custom applications, AI agents like Microsoft 365 Copilot, Microsoft Fabric data agents, Azure OpenAI in Foundry Models, etc. Each of these must respect the permissions and sensitivity labels you’ve applied. As a decision maker, you should ensure that your security and compliance requirements carry through to every consumption layer. Best practices for security data consumption:

**Standard to set:** As a decision maker, set policies for your AI development teams on which data access methods are preferred. For example, you might say: “Any agent that needs structured data from our internal systems must use a Fabric Data Agent unless a specific exception is approved,” or “If using Azure AI Search, the index must have sensitivity label enforcement enabled.” These policies will ensure that even as new AI solutions are developed, they remain within your governance guardrails.

## Microsoft’s AI data boundary

The Microsoft AI data boundary means prompts and responses stay inside Microsoft managed enterprise services and Microsoft does not use that data to train foundation models. Treat the Microsoft boundary as a required security baseline for business data. **Best practice:** Successful organizations publish a policy that limits business data use to enterprise AI services that honor tenant controls and do not reuse prompts for training. They also set an approval gate for any tool that can capture prompts or outputs. They train leaders to treat prompts as business records.

## Understand Microsoft 365 Copilot data access security

**Microsoft 365 Copilot consuming data in Microsoft 365 apps:** Microsoft 365 Copilot can access only the data already available to a user within Microsoft 365. This data includes files, emails, chats, calendars, and other information exposed through Microsoft Graph and the [Semantic Index](/microsoftsearch/semantic-index-for-copilot#privacy-compliance-and-security). Microsoft 365 Copilot uses the user’s existing identity and respects all current access permissions. Copilot operates entirely within Microsoft’s enterprise boundary, and prompt data is not used for model training. See [How does Microsoft 365 Copilot protect organizational data?](/copilot/microsoft-365/microsoft-365-copilot-privacy#how-does-microsoft-365-copilot-protect-organizational-data)

**Microsoft 365 Copilot** **and Fabric data agents:** When Microsoft 365 Copilot connects to a Fabric data agent, it continues to operate under the user’s identity. Fabric remains responsible for enforcing workspace permissions, item permissions, and row‑ or column‑level security. This ensures users never see more data through Copilot than they are already entitled to view in Fabric. See [Microsoft 365 Copilot and Fabric data agent](/fabric/data-science/data-agent-microsoft-365-copilot).

### Fabric data agent data access security

Fabric data agents let people and systems query OneLake data using natural language. An agent is an entry point to a data product. It honors the caller’s Microsoft Entra identity and enforces the same workspace roles and item permissions used in Fabric. Fabric data agents preserve row‑, column‑, and object‑level security. OneLake access controls also still apply. Publishing an agent does not expose data by itself. See [Fabric data agent sharing and permission management.](/fabric/data-science/data-agent-sharing)

### Azure AI Search data access security

Azure AI Search indexes data so applications and AI systems can retrieve it. It can read data from [Fabric OneLake](/azure/search/agentic-knowledge-source-how-to-onelake?pivots=python) and other locations only when it has been [granted explicit permission](/azure/search/search-how-to-index-onelake-files#grant-permissions). These indexes sit between source data and downstream experiences and only enforce the access controls present in the index itself. They do not automatically inherit Fabric workspace permissions.

This creates an important governance consideration: if sensitive data is indexed without access metadata or classification enforcement, any application that can query that index may retrieve confidential content.

**Best practice:** Successful organizations index only approved content for the target audience. They require either ACL metadata or Purview sensitivity label enforcement for sensitive content. They also require testing with real identities before any application goes live. They maintain an inventory of indexes with owners and retention rules. This guidance applies to all platforms that use Azure AI Search, including Microsoft Foundry, Microsoft Copilot Studio, and any other system that queries Azure AI Search indexes.

**Decision guidance:** These options help ensure that only users or applications with the appropriate rights can retrieve specific documents.

- **Purview sensitivity labels:** [Microsoft Purview sensitivity‑label enforcement](/azure/search/search-query-sensitivity-labels) prevents a caller from retrieving labeled documents unless their identity is allowed to view them. Choose Purview label enforcement when you need policy checks for confidential data. **Tradeoff**: You accept dependency on correct labeling and label governance.

- **ACL-based filtering**: [ACL‑based filtering](/azure/search/search-query-access-control-rbac-enforcement) restricts results by evaluating the caller’s identity against the document’s stored permissions. Choose ACL filtering when access varies by document and you can maintain accurate permission metadata. **Tradeoff**: You accept higher metadata management cost.

- **Both**: Choose both when you need defense in depth. **Tradeoff**: You accept more complexity in troubleshooting and validation.

### Microsoft Foundry data access security

Microsoft Foundry lets you build AI agents that can use data from Fabric, OneLake, and other enterprise systems. Microsoft Foundry agents operate within Microsoft‑controlled infrastructure. Microsoft does not share prompt data with external model providers.

Agents can pull information from four main sources: Foundry IQ, Azure AI Search indexes, MCP servers, and Fabric data agents. Each one handles data security differently, so it’s important to choose the right method for your scenario:

- **Foundry IQ**: Uses Azure AI Search knowledge bases and enforces access through index‑level metadata (ACLs or sensitivity labels). Only authorized content is returned. Governance quality depends on the underlying search index. See [Connect Agents to Foundry IQ Knowledge Bases](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=search%2Cpython#authentication-and-permissions).

- **Azure AI Search index.** Foundry agents can query Azure AI Search indexes.  
  When you use this approach, you must follow the Azure AI Search data security best practices. Azure AI Search enforces access rules during queries only when the index contains ACL metadata or sensitivity labels. Without this information, any caller with access to the index can retrieve all its content. See [Connect an Azure AI Search index to Foundry agents](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&tabs=keys%2Cazurecli&pivots=python)

- **MCP servers**: MCP servers provide tools or data through the Model Context Protocol. Foundry supports multiple authentication models. **Best practice:** Use identity passthrough when user‑level access decisions matter. Avoid placing sensitive data behind services that cannot enforce per‑user authorization. See [MCP server authentication](/azure/ai-foundry/agents/how-to/mcp-authentication?view=foundry).

- **Fabric data agents**: Fabric enforces all security controls, including row‑ and column‑level policies. Foundry does not bypass these controls. **Best practices:** Use Fabric agents when consistent, governed access to data products is required across AI experiences. Let Fabric handle row‑ and column‑level security. Use separate agents if different audiences require different data views. See guidance in [Microsoft Foundry](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundry&preserve-view=true&pivots=python) and [Microsoft Fabric](/fabric/data-science/data-agent-foundry#how-it-works) docs.

### Microsoft Copilot Studio data access security

Microsoft Copilot Studio enables custom copilots that operate entirely within the tenant boundary. Prompts and responses remain within Microsoft systems and are not reused for training. When copilots consume data from:

- **Azure AI Search:** When a Copilot Studio uses [Azure AI Search](/microsoft-copilot-studio/knowledge-azure-ai-search), enforcement depends on the presence of ACLs or sensitivity labels in the index.

- **Fabric data agents:** When a copilot calls a [Fabric data agents](/fabric/data-science/data-agent-microsoft-copilot-studio), Fabric applies all existing permissions and security policies This includes workspace, item, row‑level, and column‑level security. See [Consuming a data agent in Microsoft Copilot Studio.](/fabric/data-science/data-agent-microsoft-copilot-studio)

Purview [Sensitivity labels](/microsoft-copilot-studio/sensitivity-label-copilot-studio#microsoft-purview-strengthens-information-protection-for-copilot-studio) flow through responses to help govern outputs. To block knowledge sources, administrators can apply [data policies](/microsoft-copilot-studio/admin-data-loss-prevention) to limit which knowledge sources are available.

### Microsoft PowerBI data access security

Power BI transforms OneLake data into reports and dashboards while preserving Microsoft Purview sensitivity labels. These protections extend to exported content when supported by upstream systems. **Decision guidance:** For leaders, Power BI represents the final mile of data exposure. Ensuring labels are applied upstream guarantees that protections remain intact even when content is shared or exported. See [Power BI implementation planning.](/power-bi/guidance/powerbi-implementation-planning-content-distribution-sharing)

### Copilot in Fabric data access security

Copilot in Fabric operates entirely within Fabric and acts only on behalf of the signed‑in user. It does not introduce a new access path and cannot exceed existing permissions. Outputs remain private until explicitly shared. See [Privacy, Security, and Responsible AI Use of Copilot in Fabric.](/fabric/fundamentals/copilot-privacy-security) See [diagram of Copilot in Fabric](/fabric/fundamentals/how-copilot-works#process-overview-diagram).

### Next step

By paying attention to each of these areas, you ensure that once data products are published every consumption channel is governed. The core principle is that security and compliance should be pervasive. From the raw data in OneLake, to the BI reports, to the AI agents answering questions, the same policies and permissions apply. Users and systems should only access what they are allowed to, and sensitive data should remain protected at every step.
