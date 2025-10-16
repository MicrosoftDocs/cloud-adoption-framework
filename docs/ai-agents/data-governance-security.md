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

In addition to general AI governance, put special focus on data governance and security for AI agents. AI agents often weave through various data sources, some of which are sensitive or regulated. Ensuring data is handled properly is a fundamental responsibility that must be baked into every stage of agent development.

1. **Compliance with data laws.** Every agent must be compliant with relevant data protection regulations such as GDPR, HIPAA, CCPA and internal data policies before it goes live. Engage legal and compliance teams to review each agent’s data access and processing. For example, if an agent will handle personal customer data, confirm that you have the customer’s consent. Ensure your privacy notice is updated to mention AI usage. Conduct a Data Protection Impact Assessment if required. This review is not a one-time activity. If an agent later integrates a new dataset or feature, perform another compliance check.

2. **Data sensitivity labeling.** All data used by AI agents must be classified and labeled. If you already use a labeling scheme such as Public, Confidential or Highly Confidential, extend it to data fed to or produced by agents. Use tools like Microsoft Purview to automatically apply and enforce these labels across the enterprise. Agents should check labels at runtime. For instance, an agent retrieving documents from SharePoint should skip any document labeled Confidential if the user is not authorized to view it. Additionally, restrict agent memory or logs from storing sensitive content unless it is properly protected.

3. **Data privacy.** Privacy must be built into every agent that handles personal data. Privacy must be built into every agent that interacts with personal data. Workload teams must ensure that agents apply data minimization principles, using only the information strictly necessary for their function. Training datasets, memory stores, and logs must be reviewed for privacy risks. Where possible, data should be anonymized or pseudonymized to reduce exposure. Agents must also support user rights, including the ability to request deletion of their data, and must comply with the organization’s privacy policy. This applies to agents using Microsoft Graph, storing conversation history, or processing customer records. [Use Microsoft Purview to manage data security & compliance for AI agents.](/purview/ai-agents)

4. **Data residency and sovereignty.** Agents must comply with data residency and sovereignty requirements. Data residency and sovereignty requirements must be respected at every stage of agent development and deployment. Teams must understand where each data source resides, where the agent runs, and where logs or outputs are stored. Azure regions and on-premises environments should be selected based on residency needs. Logging of sensitive content should be disabled unless retention is explicitly required, and encryption must be applied when logging is necessary. Vendor guarantees must be reviewed to ensure they align with internal policies and regulatory obligations.

5. **Data retention.** Agents must follow data retention policies. AI agents often generate logs, memory, and training data that can persist indefinitely without proper controls. It is essential to define clear retention policies and enforce them rigorously. Technical leaders must help teams determine how long agent-related data should be retained and implement automated purging or anonymization after the retention period. Agents should only retain context that is necessary for their function. For example, a support agent may need to retain session history for troubleshooting purposes but should not store conversations beyond what is operationally required. Users must be informed about how long their data is stored and provided with mechanisms to request deletion.

6. **Data transparency.** Agents must communicate clearly when AI uses user data. Transparency is critical to maintaining trust in AI systems. Users must be clearly informed when they are interacting with an AI agent and how their data is being used. Every agent interface should include a disclosure such as "This is an AI assistant." Internal stakeholders must also be notified when their data is used for training or inference. Any new data source added to an agent must go through a formal review process to validate its content, assess legal permissions, and evaluate security risks. This ensures that agents are not inadvertently connected to sensitive systems without oversight.

## Microsoft tools for data governance and security

**Azure AI Foundry:**

- [Trustworthy AI for Azure AI Foundry](/azure/ai-foundry/responsible-use-of-ai-overview) outlines foundational governance principles including transparency, fairness, and accountability.
- [Data, privacy, and security for Azure AI Agent Service](/azure/ai-foundry/responsible-ai/agents/data-privacy-security) explains how agents handle personal data, enforce privacy, and comply with regulations.
- [Secure and compliant AI apps with Microsoft Purview](/purview/developer/secure-ai-with-purview) shows how to apply sensitivity labels, audit logs, and data loss prevention to AI agents.
- [Apply least privilege access principles using Azure role-based access control](/azure/ai-foundry/concepts/rbac-ai-studio) to assign necessary permissions for specific roles.
- [Use managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks and [follow managed identity best practices](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#follow-the-principle-of-least-privilege-when-granting-access).
- [Define data boundaries based on user access levels and implement dataset isolation](/azure/cloud-adoption-framework/scenarios/ai/platform/security#secure-ai-data) for different agent environments.
- [Use Prompt Shields to detect user prompt attacks and document-embedded attacks](/azure/ai-services/content-safety/concepts/jailbreak-detection) that attempt to manipulate agent behavior.
- [Configure Azure Content Safety content filtering](/azure/ai-services/content-safety/overview) to block sensitive data leakage and enforce content policies.
- [Implement agentic AI safeguards including audit trails, data validation, and independent guardrails](/azure/well-architected/ai/responsible-ai#implement-agentic-ai-safeguards) for production deployments.

**Microsoft Copilot Studio:**

- [Security and governance in Copilot Studio](/microsoft-copilot-studio/security-and-governance) provides an overview of governance controls including sensitivity labels and audit logs.
- [Governance and security best practices overview](/microsoft-copilot-studio/guidance/sec-gov-intro) offers a phased approach to governance from planning to monitoring.
- [Use Microsoft Purview to manage data security & compliance for Copilot Studio](/purview/ai-copilot-studio) lists supported Purview capabilities like DSPM, auditing, and insider risk management.
- [AI threat protection overview in Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) to detect prompt injection, data leakage, and anomalous agent behavior.
- [Configure user authentication with Microsoft Entra ID](/microsoft-copilot-studio/configuration-authentication-azure-ad) to ensure only authorized users can interact with agents.
- [Run tools with user credentials by default](/microsoft-copilot-studio/advanced-plugin-actions#authentication-considerations-for-tools) to restrict data access based on individual user permissions.
- [Use data policies to require user authentication](/microsoft-copilot-studio/dlp-example-3) and block improperly configured agents.
- [Enable audit logging in Microsoft Purview](/microsoft-copilot-studio/admin-logging-copilot-studio) to capture user interactions and administrative actions.
- [Configure data loss prevention policies](/microsoft-copilot-studio/admin-data-loss-prevention) to govern agent capabilities and restrict knowledge sources.

## Next step

> [!div class="nextstepaction"]
> [Single or multi-agent systems?](./single-multi-agent-systems.md)