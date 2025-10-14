---
title: Data governance, and security for AI agents
description: Learn Data governance and security for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Data governance and security

Data governance and security for AI agents is not a feature to be added later. It is a foundational responsibility that must be embedded into every stage of agent design, deployment, and operation. The scope of governance must include both enterprise-wide content and workload-specific data, ensuring that agents operate securely, legally, and transparently across all environments.

The first priority is to establish a unified governance policy that applies across all AI agents in the organization. It must clearly define how data is accessed, what classifications apply, and what obligations exist around privacy, retention, and compliance. Enforcement must be consistent, whether the agent is retrieving emails via Microsoft Graph, querying a SQL database, or grounding responses in Azure-hosted documents.

1. **Data compliance.** **Every agent must comply with applicable data laws and internal policies.** No agent should be deployed without a formal legal and compliance review. This review must evaluate the types of data the agent will access, the jurisdictions involved, and the applicable regulations such as GDPR, CCPA, HIPAA, or industry-specific mandates. If the agent interacts with personal data, the review must confirm whether consent is required, whether privacy notices need updating, and whether the agent’s behavior aligns with internal standards. These reviews must be documented and repeated whenever the agent’s data sources or capabilities change.

2. **Data sensitivity labeling.** **All data used by AI agents must be classified and labeled.** Sensitivity labeling is essential to prevent unauthorized access and exposure of confidential information. All data used by AI agents must be classified according to the organization’s labeling scheme, whether it resides in SharePoint, Teams, SQL databases, or Azure Blob storage. Tools like Microsoft Purview should be used to automate classification and apply labels consistently. Agents must respect these labels at runtime, ensuring that sensitive content is not retrieved or surfaced unless explicitly permitted. This applies equally to retrieval-augmented generation scenarios and conversational agents with memory.

3. **Data privacy.** **Privacy must be built into every agent that handles personal data.** Privacy must be built into every agent that interacts with personal data. Workload teams must ensure that agents apply data minimization principles, using only the information strictly necessary for their function. Training datasets, memory stores, and logs must be reviewed for privacy risks. Where possible, data should be anonymized or pseudonymized to reduce exposure. Agents must also support user rights, including the ability to request deletion of their data, and must comply with the organization’s privacy policy. This applies to agents using Microsoft Graph, storing conversation history, or processing customer records. [Use Microsoft Purview to manage data security & compliance for AI agents.](/purview/ai-agents)

4. **Data residency and sovereignty.** **Agents must comply with data residency and sovereignty requirements.** Data residency and sovereignty requirements must be respected at every stage of agent development and deployment. Teams must understand where each data source resides, where the agent runs, and where logs or outputs are stored. Azure regions and on-premises environments should be selected based on residency needs. Logging of sensitive content should be disabled unless retention is explicitly required, and encryption must be applied when logging is necessary. Vendor guarantees must be reviewed to ensure they align with internal policies and regulatory obligations.

5. **Data retention.** **Agents must follow data retention policies.** AI agents often generate logs, memory, and training data that can persist indefinitely without proper controls. It is essential to define clear retention policies and enforce them rigorously. Technical leaders must help teams determine how long agent-related data should be retained and implement automated purging or anonymization after the retention period. Agents should only retain context that is necessary for their function. For example, a support agent may need to retain session history for troubleshooting purposes but should not store conversations beyond what is operationally required. Users must be informed about how long their data is stored and provided with mechanisms to request deletion.

6. **Data transparency.** **Agents must communicate clearly when AI uses user data.** Transparency is critical to maintaining trust in AI systems. Users must be clearly informed when they are interacting with an AI agent and how their data is being used. Every agent interface should include a disclosure such as “This is an AI assistant.” Internal stakeholders must also be notified when their data is used for training or inference. Any new data source added to an agent must go through a formal review process to validate its content, assess legal permissions, and evaluate security risks. This ensures that agents are not inadvertently connected to sensitive systems without oversight.

**Microsoft tools:**

-   **Azure AI Foundry:**
    - [Trustworthy AI for Azure AI Foundry](/azure/ai-foundry/responsible-use-of-ai-overview) outlines foundational governance principles including transparency, fairness, and accountability.
    - [Data, privacy, and security for Azure AI Agent Service](/azure/ai-foundry/responsible-ai/agents/data-privacy-security) explains how agents handle personal data, enforce privacy, and comply with regulations.
    - [Secure and compliant AI apps with Microsoft Purview](/purview/developer/secure-ai-with-purview) shows how to apply sensitivity labels, audit logs, and data loss prevention to AI agents.

-   **Microsoft Copilot Studio:**
    - [Security and governance in Copilot Studio](/microsoft-copilot-studio/security-and-governance) provides an overview of governance controls including sensitivity labels and audit logs.
    - [Governance and security best practices overview](/microsoft-copilot-studio/guidance/sec-gov-intro) offers a phased approach to governance from planning to monitoring.
    - [Use Microsoft Purview to manage data security & compliance for Copilot Studio](/purview/ai-copilot-studio) lists supported Purview capabilities like DSPM, auditing, and insider risk management.

-   **Microsoft Defender for Cloud (Preview):**
    - [AI threat protection overview in Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) to detect prompt injection, data leakage, and anomalous agent behavior.

## Data security

AI agents increasingly operate across sensitive enterprise environments, introducing new risks to data confidentiality, regulatory compliance, and operational integrity. As organizations scale agent capabilities across internal and external workflows, technical leaders must ensure that data security remains foundational to agent design and deployment. This requires a strategic approach to access control, data isolation, and governance that aligns with enterprise security policies and supports long-term scalability.
To maintain trust and reduce exposure, organizations must implement security controls that prevent unauthorized access, isolate sensitive content, and enforce accountability across agent interactions. These controls not only protect data but also enable responsible innovation by ensuring agents operate within clearly defined boundaries.

1. **Apply least privilege access and isolate identities.**
Direct teams to enforce least privilege principles across all agent roles and services. Use managed identities and role-based access controls to eliminate static credentials and reduce the attack surface. This approach simplifies credential management while ensuring agents only access what is necessary for their function.

1. **Isolate sensitive data from public-facing agents**
Require strict separation between internal datasets and those accessible to agents exposed to external users. Define data boundaries at both the storage and indexing layers, and validate external sources before integration. Maintain a centralized list of trusted sources to ensure content accuracy and compliance.

1. **Automate sanitization and enforce policy-based filtering.**
Instruct teams to embed automated sanitization protocols into agent workflows. These protocols must remove confidential fields and apply policy-based filters to outputs before distribution. This ensures consistent enforcement of data handling standards and reduces manual oversight.

1. **Govern changes to agent data sources through formal review.**
Establish a formal review process for integrating new data sources into agent workflows. Require validation of content, intended use, and connection security. Notify stakeholders of changes to maintain transparency and prevent accidental exposure of sensitive or unapproved data.

1. **Require authentication and monitor agent activity.**
Ensure agents operate within authenticated environments. Configure agents to run tools with user credentials and restrict access based on roles or groups. Enable audit logging to capture interactions and administrative actions, supporting forensic analysis and compliance reporting.

**Microsoft tools:**

- **Azure AI Foundry:**
    - [Apply least privilege access principles using Azure role-based access control](/azure/ai-foundry/concepts/rbac-ai-studio) to assign necessary permissions for specific roles.
    - [Use managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks and [follow managed identity best practices](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#follow-the-principle-of-least-privilege-when-granting-access).
    - [Define data boundaries based on user access levels and implement dataset isolation](/azure/cloud-adoption-framework/scenarios/ai/platform/security#secure-ai-data) for different agent environments.
    - [Use Prompt Shields to detect user prompt attacks and document-embedded attacks](/azure/ai-services/content-safety/concepts/jailbreak-detection) that attempt to manipulate agent behavior.
    - [Configure Azure Content Safety content filtering](/azure/ai-services/content-safety/overview) to block sensitive data leakage and enforce content policies.
    - [Implement agentic AI safeguards including audit trails, data validation, and independent guardrails](/azure/well-architected/ai/responsible-ai#implement-agentic-ai-safeguards) for production deployments.

- **Microsoft Copilot Studio:**
    - [Configure user authentication with Microsoft Entra ID](/microsoft-copilot-studio/configuration-authentication-azure-ad) to ensure only authorized users can interact with agents.
    - [Run tools with user credentials by default](/microsoft-copilot-studio/advanced-plugin-actions#authentication-considerations-for-tools) to restrict data access based on individual user permissions.
    - [Use data policies to require user authentication](/microsoft-copilot-studio/dlp-example-3) and block improperly configured agents.
    - [Enable audit logging in Microsoft Purview](/microsoft-copilot-studio/admin-logging-copilot-studio) to capture user interactions and administrative actions.
    - [Configure data loss prevention policies](/microsoft-copilot-studio/admin-data-loss-prevention) to govern agent capabilities and restrict knowledge sources.

## Next step

> [!div class="nextstepaction"]
> [Governance and security](./governance-security.md)