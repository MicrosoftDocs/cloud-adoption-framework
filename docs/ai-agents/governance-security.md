---
title: Governance and security for AI Agents
description: Learn Governance and security for AI Agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Agent governance and security across your organization

**Establishing control over AI agents and the data they access.** Beyond high-level principles, you need concrete governance mechanisms for your AI agents across their lifecycle. This is about putting guardrails in place so agents access only what they should, behave as expected, and can be managed centrally. Governance processes should be ingrained in how teams design, deploy, and update agents.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram that shows how to govern ." lightbox="./images/governance-security.png" border="false":::

## Data governance and compliance

AI agents now play a central role in how organizations operate, interact with customers, and make decisions. As these agents become more capable and embedded across departments, you must treat their governance as a core business function, not just a technical concern. Agent governance means establishing clear rules, oversight mechanisms, and accountability structures that apply across the entire organization.

### Regulatory compliance

**Policy: All agents must comply with regulations and standards.** this includes data protection laws (such as GDPR and HIPAA), industry certifications, and internal governance requirements. Technical decision makers must direct their teams to implement foundational controls that ensure agents process data responsibly, securely, and transparently.

- **Privacy**: All AI agents must follow data minimization principles and use only the data necessary for their intended functionality. Teams must review training datasets, memory stores, and logs to identify and mitigate privacy risks. Agents must anonymize or pseudonymize personal data where feasible and support user rights, including deletion requests, in alignment with the organization’s privacy policy.
- **Residency and sovereignty**: All AI agents must operate in environments that meet data residency and sovereignty requirements. Teams must identify the location of each data source, agent runtime, and output storage. Agents must use Azure regions or on-premises environments that comply with residency policies. Logging of sensitive content must remain disabled unless retention is required, and all stored data must be encrypted.
- **Retention and lifecycle management**: All AI agents must follow defined retention periods for logs, memory, and training data. Teams must implement automated purging or anonymization processes and retain only the context necessary for agent functionality. Agents must inform users about retention durations and provide deletion mechanisms. Retention policies must extend into full lifecycle management, including rules for data creation, archival, deletion, and purging.

In **Azure AI Foundry**, you can use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to translate regulations like the EU AI Act into actionable controls and assess compliance posture across AI applications. Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview). See [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) and an overview of [Microsoft Purview's](/purview/ai-azure-services) for Azure AI Foundry.

In **Microsoft Copilot Studio**, follow [Governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

### Corporate compliance

**Policy: All agents must comply with the Responsible AI policies.** Corporate compliance ensures agents align with internal governance policies. Corporate policies include consistent deployment practices, version control, and guardrails across environments. Define reusable infrastructure templates and mandate their use. Use policy-as-code and infrastructure-as-code to enforce standards. Review agent updates and deployments through automated pipelines.

- **Sensitivity labeling**: All AI agents must interpret and enforce organizational sensitivity labels such as General, Public, and Confidential. Agents must restrict memory and logging functions from storing sensitive content unless protected by encryption and access controls. Teams must extend existing classification schemes into agent workflows to maintain data protection standards.
- **Transparency**: Disclose AI involvement clearly in agent interfaces. Notify internal stakeholders when their data supports training or inference. Review new data sources before integration to validate content, permissions, and security risks.

In **Azure AI Foundry**, use [Azure Policy](/azure/ai-foundry/how-to/azure-policy) to control infrastructure configurations and [model deployment](/azure/ai-foundry/how-to/built-in-policy-model-deployment).

In **Microsoft Copilot Studio**, [create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.

## Agent observability

**Policy: The actions and behaviors of every agent must be logged and auditable.** To manage AI agents effectively across your organization, treat observability as a core business capability and not just a technical function. Observability refers to the ability to monitor and understand what AI agents do both in real time and over time. Because these agents operate probabilistically and don't always behave the same way, visibility into their actions becomes essential for managing risk, ensuring compliance, and optimizing performance.

1. **All agents must have a unique identity.** Start by requiring every AI agent to have a unique identity. This identity must include ownership details, version history, and lifecycle status. [Microsoft Entra Agent ID](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/announcing-microsoft-entra-agent-id-secure-and-manage-your-ai-agents/3827392)  supports this structure by linking each agent to its owner and purpose. This clarity helps your organization distinguish between production, development, and test agents, which is critical for accountability and risk management.

1. **Every agent must be inventoried.** Untracked or "shadow" deployments pose security and cost risks. Leaders must direct their teams to discover and classify all AI workloads across the cloud environment. This step ensures the organization maintains a complete inventory of AI assets. Use tools like Microsoft Defender for Cloud to [discover](/azure/defender-for-cloud/identify-ai-workload-model) and categorize agent workloads. A full inventory supports better governance, financial oversight, and strategic planning.

1. **All agents must have metrics and logs captured.** Once the organization identifies all agents, the next step is to monitor their behavior and performance. Have team track key **metrics** and **logs** consistently, ideally to a centralized location, such as an Azure Log Analytics workspace. This consistency improves transparency, supports audit readiness, and simplifies troubleshooting. Centralized logs also enable cross-team collaboration. As needed, instruct teams to gather custom telemetry in Application Insights that captures how agents behave and how users interact with them. This information helps you decide whether to scale, refine, or retire agents based on business impact. To align technical performance with business goals, teams should use or build **dashboards**. These dashboards provide leadership with a clear view of how AI investments contribute to outcomes.

    - For **Azure AI Foundry**, [monitor agents](/azure/ai-foundry/agents/how-to/metrics), [monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models), and [monitor applications](/azure/ai-foundry/how-to/monitor-applications) and [dashboards](/azure/ai-foundry/agents/how-to/metrics#dashboards).
    - For **Microsoft Copilot Studio**, see [monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio). Centralize with [Azure Application Insights in Azure Monitor](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry).

1. **All agents must meet budgets.** AI agents consume resources such as compute power, tokens, and API calls. Without visibility, costs can escalate quickly. You need a unified view of agent usage and cost across departments and projects to track metrics like token consumption and compute usage. Organize this data by department or project to identify where costs concentrate. Apply cost center tags using [Microsoft Cost Management](/azure/cost-management-billing/costs/cost-allocation-introduction) to allocate agent expenses accurately. Require teams to tag resources per agent or use case so you can see cost breakdowns clearly. Set up real-time **alerts** to notify teams when spending approaches budget thresholds. These alerts help prevent overruns and support proactive financial management. Restrict who can create, deploy, and scale agents by using Azure **role-based access control** (RBAC). This structure reduces risk and ensures only authorized personnel manage AI deployments.

    - In **Azure AI Foundry**, [plan and manage costs](/azure/ai-foundry/how-to/costs-plan-manage). Centrally administer quotas and access through the [management center](/azure/ai-foundry/concepts/management-center).
    - In **Microsoft Copilot Studio**, [view and manage cost](/microsoft-copilot-studio/requirements-messages-management).

## Agent security

**Policy: All agents must undergo continuous security testing.** AI agents operate differently from traditional IT systems. They process natural language, interact with external sources, and often make autonomous decisions. These capabilities introduce risks such as:

- **Data leakage**: Agents might unintentionally expose sensitive information.
- **Data poisoning**: Malicious actors can manipulate training data to alter agent behavior.
- **Jailbreak attempts**: Attackers can bypass safeguards to make agents behave unpredictably.
- **Credential theft**: Agents can become a vector for stealing authentication credentials.

To manage these risks, leaders must direct their teams to integrate agent security into existing enterprise security frameworks. This integration ensures consistency, reduces exposure, and supports regulatory compliance.

1. **Use AI threat protection.** Direct platform teams to activate AI-specific threat protection. Microsoft Defender for Cloud’s [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) includes capabilities that detect prompt manipulation, unauthorized data access, and other agent-specific threats. These protections use global threat intelligence and integrate with Azure AI Content Safety to identify suspicious behavior in real time. Activating these tools reduces exposure and enables faster response to emerging risks.

1. **Every agent must follow baseline security recommendations.** Treat agent infrastructure with the same level of oversight as customer-facing systems. Treat agent runtimes with the same governance and oversight as customer-facing systems.

    For **Azure AI Foundry**, use the [Azure security baseline for Azure AI Foundry](/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline).

1. **All agents must filter agent inputs and outputs.** You need to block adversarial input to bypass integrated safety protocols. Have teams treat all incoming data, text, files, images, as potentially hostile. Instruct teams to validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

    For **Azure AI Foundry**, [configure Azure Content Safety content filtering](/azure/ai-services/content-safety/overview) to block  sensitive data leakage and enforce content policies.

1. **All agents must use secure authentication mechanisms.** Use [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks. Enforce least-privilege access.

    For **Azure AI Foundry**, enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-azure-ai-foundry).

1. **Least privilege for tools.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

1. **Integrate with security operations.** Ensure AI-related alerts flow into the Security Operations Center (SOC). Define thresholds for anomalies such as latency spikes or unauthorized access attempts. Use Azure Monitor Alerts and route them to Microsoft Sentinel through Log Analytics. This integration strengthens the organization’s overall security posture and ensures agents remain resilient and trustworthy.

1. **Monitor and audit agent behavior.** Require periodic audits of agent interactions. Use logging and telemetry to identify unusual behavior, such as unexpected data access or different prompt patterns. These audits help detect early signs of compromise and support compliance with internal and external standards.

1. **Train teams on AI-specific risks.** Provide targeted training for security and development teams. Focus on real-world scenarios such as:

    - Jailbreak techniques that bypass agent safeguards
    - Data poisoning attacks that manipulate training data
    - Credential theft through agent interfaces

    This training builds awareness and readiness, enabling teams to respond effectively to AI-specific threats.

1. **All MCP and agent-to-agent integrations must be from approved sources.** AI agents often interact with external systems and data sources. These connections introduce more risks. Leaders must ensure governance reflects this complexity. Require teams to:

    - Use standard protocols such as Model Context Protocol (MCP) and Agent-to-Agent Protocol (A2A) for secure communication
    - Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards
    - Validate all external agent communications and limit them to explicitly approved entities
    - Define clear boundaries for data access and logic execution during external interactions

    These measures help prevent leakage of sensitive information and maintain control over agent behavior across organizational boundaries.

1. **Create agent incident response plan.**  Decide in advance how you would quickly disable an agent if it's doing harm or malfunctioning. Plan how to communicate incidents. Include steps for preserving logs for forensic analysis and updating stakeholders. Just as you have disaster recovery plans for systems, have one for AI agents. Run drills if the agent is critical to ensure the team knows how to respond under pressure.

    For **Azure AI Foundry**, prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.

## Agent development

To ensure consistency, safety, and interoperability, organizations must standardize how agents interact with tools, data, and each other. Business leaders must define which protocols and frameworks are acceptable and direct teams to use them across all agent development efforts.

### Standardize agent frameworks

Direct your teams to use a consistent set of frameworks and SDKs for agent development. This reduces complexity, improves collaboration across departments, and simplifies long-term maintenance. For example, within Azure AI Foundry, you can standardize on options like the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) and the [Azure AI Foundry SDK](/azure/ai-foundry/how-to/develop/sdk-overview?pivots=programming-language-python). These tools provide structured approaches to agent orchestration and integration, and they support rapid onboarding of new agents. When selecting frameworks, consider the following points:

- **Compatibility with existing infrastructure**: Ensure the framework integrates well with your current cloud architecture and data sources.
- **Support and documentation**: Choose frameworks with robust documentation and active support to reduce ramp-up time.
- **Governance alignment**: Favor frameworks that include built-in compliance and security features to meet internal policy requirements.

By standardizing these choices, you create a predictable development environment that accelerates delivery and reduces risk.

### Standardize agent protocols

Protocols define how agents interact with tools, data, and each other. Require all agent development efforts to use standard protocols to ensure secure and predictable behavior. Two key protocols to adopt:

- **Model Context Protocol (MCP)**: MCP provides structured and secure access to tools, APIs, and data sources. It enforces boundaries around what agents can access, which helps prevent unauthorized actions and supports compliance.
- **Agent-to-Agent Protocol (A2A)**: A2A enables consistent communication between agents. It supports task delegation and context sharing, which improves coordination and reduces errors in multi-agent systems.

These protocols create a common language for agents across your organization. They reduce integration overhead, improve interoperability, and support governance by enforcing clear interaction rules.

For **Azure AI Foundry**, ensure you understand the available orchestration options. In addition to the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) and the [Azure AI Foundry SDK](/azure/ai-foundry/how-to/develop/sdk-overview?pivots=programming-language-python), Azure AI Foundry supports other frameworks, like LangGraph, and its own built-in orchestration tools. Provide guidance on when to use each option based on the complexity of the agent, the required integrations, and the business outcomes.

## Next step

> [!div class="nextstepaction"]
> [Single or multi-agent systems?](./single-multi-agent-systems.md)
