---
title: Governance for AI agents across the organization
ms.reviewer: ssumner
description: Explore best practices for governing AI agents, from data residency laws to corporate compliance, to ensure secure and responsible AI deployment.
#customer intent: As a CTO or enterprise architect, I want to understand how to implement governance across the organization. I need to develop policies that apply universally and can be enforced by the compliance team. Additionally, I want to learn about the controls and solutions Microsoft provides to help facilitate this governance.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Governance for AI agents across the organization

This article helps you establish governance and security practices for AI agents across your organization. Without proper governance, AI agents can expose sensitive data, operate outside compliance boundaries, or create security vulnerabilities that threaten business operations. The guidance here explains how to implement controls that protect data, ensure regulatory compliance, maintain visibility into agent behavior, and secure agent infrastructure throughout its lifecycle.

Organizations must apply concrete governance mechanisms that span the entire agent lifecycle. These mechanisms ensure agents access only authorized data, behave predictably, and remain manageable at scale. Governance must be embedded into how teams design, deploy, monitor, and update agents, not treated as an afterthought.

:::image type="complex" source="./images/governance-security.png" alt-text="Diagram of Microsoft's agent governance and lifecycle management framework." lightbox="./images/governance-security.png":::
    The diagram illustrates Microsoft's agent governance and lifecycle management framework in three main sections. The top section shows org-wide agent governance with Microsoft Agent 365 at the center, connected to three areas: Data governance and compliance (Microsoft Purview, Azure Policy), Security (Microsoft Defender), and Observability (Azure Monitor, Microsoft Entra). Below this is a development layer featuring Microsoft Agent Framework, Foundry SDK, A2A, and MCP. The middle section shows the "Build" phase of lifecycle management with four categories: Agents and Workflows (Traces, Monitor, Evaluation), Models (Monitor, Evaluation), Evaluations (Evaluations, Evaluator catalog, Red team), and Guardrails (Guardrails, Blocklists). The bottom section shows the "Operate" phase with Foundry control plane containing Assets (Agents, Models, Tools), Compliance (Policies, Guardrails, Security posture), Quota (Tokens per minute, Provisioned throughput unit), and Admin (All projects, AI Gateway). At the base is the Microsoft Foundry logo with the label "Foundry Agent Service."
:::image-end:::

## Data governance and compliance

AI agents play a central role in operations, customer interactions, and decision-making. As agents become embedded across departments, governance becomes a core business function rather than a technical concern. Effective governance establishes clear rules, oversight mechanisms, and accountability structures that apply across the entire organization.

### Regulatory compliance

**Policy: All agents must comply with regulations and standards.** This policy includes data protection laws (such as GDPR and HIPAA), industry certifications, and internal governance requirements. Organizations must translate regulations into foundational controls that ensure agents process data responsibly, securely, and transparently.

1. **Enforce data privacy.** Agents must follow data minimization principles and use only the data necessary for intended functionality. Governance teams must review datasets fed into AI models for RAG, fine-tuning, or training. Review memory stores and logs to identify and mitigate privacy risks. Agents must anonymize or pseudonymize personal data where feasible and support user rights, including deletion requests, in alignment with organizational privacy policy.

1. **Mandate data residency compliance.** Agents must operate in environments that meet data residency and sovereignty requirements. Architects must identify the location of each data source, agent runtime, and output storage. Agents must use Azure regions or on-premises environments that comply with residency policies. Configure logging to avoid unnecessary storage of sensitive content. Retain only what compliance or operational policies require and ensure data is encrypted at rest.

1. **Define data retention policies.** Agents must follow defined retention periods for logs, memory, and training data. Implement automated purging or anonymization processes and retain only the context necessary for agent functionality. Agents must inform users about retention durations and provide deletion mechanisms. Retention policies must extend into full lifecycle management, including rules for data creation, archival, deletion, and purging.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to translate regulations, such as the EU AI Act, into controls and assess compliance posture across AI applications. Use [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) to integrate compliance automation into agent workflows. Review [Microsoft Purview capabilities for Foundry](/purview/ai-azure-services) to understand data governance and protection options.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Follow [governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

### Corporate compliance

**Policy: All agents must comply with Responsible AI policies.** Corporate compliance ensures agents align with internal governance policies. Corporate policies include consistent deployment practices, version control, and guardrails across environments. Define reusable infrastructure templates and mandate their use. Use policy-as-code and infrastructure-as-code to enforce standards. Review agent updates and deployments through automated pipelines.

1. **Isolate confidential data.** Separate confidential data from public data sources using physical or logical boundaries. Customer-facing agents should only use data sources appropriate for internet exposure. This separation prevents confidential information from unintentionally reaching public channels. In an Azure landing zone, deploy internal agents and data in "corp" management group subscriptions and public agents and data in "online" management group subscriptions. For example, an HR agent accesses employee records in the corp subscription, and a customer support agent accesses only public documentation in the online subscription.

1. **Restrict data access.** Grant access to necessary data only. Avoid exposing confidential or sensitive data to the agent during training or runtime unless necessary. Use tools like [Microsoft Purview Data Loss Prevention (DLP)](/purview/dlp-learn-about-dlp) to enforce sensitivity labels and route agent behavior accordingly. Prevent agents from storing sensitive content in memory or logs unless encryption and access controls are in place. Extend existing classification schemes into agent workflows to maintain data protection standards. [Manage agent identities](/azure/ai-foundry/agents/concepts/agent-identity?view=foundry&tabs=rest-api#manage-agent-identities).

1. **Standardize internal access controls.** Internal-facing agents must follow the same data governance rules as other systems. Agents must only retrieve data that the requesting user is authorized to access. This typically involves passing the user’s identity or token securely when querying data, ensuring session integrity and least privilege. For example, an internal helpdesk agent must show an employee only their own HR record, not someone else's. Align agent behavior with existing role-based access controls to maintain compliance and user trust.

1. **Govern external access.** Agents that interact with external users introduce additional complexity. These users often fall outside the enterprise identity system, increasing the risk of unauthorized data exposure. Limit agent access to public or explicitly shared data. Never expose internal systems, sensitive records, or proprietary content unless the organization verifies the user’s identity and grants appropriate permissions.
To maintain control, organizations must:

    - Define clear boundaries for what external agents can access and perform.
    - Use authentication mechanisms such as OAuth or federated identity systems when external users require access to personalized or sensitive data.
    - Apply strict rate limits and monitoring to detect misuse.
    - Implement fallback logic for queries outside the agent’s scope. For example, if an external user asks about internal HR policies, the agent should respond with a generic message or redirect to a public-facing resource.

1. **Standardize data integrations.** Standardize how agents connect to knowledge and tools to reduce duplication and simplify maintenance. Use official APIs and connectors instead of custom integrations. This allows multiple agents across departments (IT, HR, facilities) to reuse infrastructure, reduce operational costs, and accelerate deployment timelines.

    Support agents with a shared knowledge base for company policies. When integrating knowledge and tools, follow governance policies:

    - Use project-level data isolation to prevent cross-contamination of sensitive information.
    - Apply data loss prevention (DLP) policies and sensitivity labels to protect data.
    - Require structured outputs (such as JSON) to support downstream processing and compliance audits.
    - Validate all integrations through security reviews and testing cycles.

    These practices reduce the risk of data leakage, unauthorized actions, and unpredictable behavior.

1. **Mandate transparency.** Disclose AI involvement clearly in agent interfaces. Notify internal stakeholders when their data supports training or inference. Review new data sources before integration to validate content, permissions, and security risks.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [Azure Policy](/azure/ai-foundry/how-to/azure-policy) to control infrastructure configurations and [model deployment](/azure/ai-foundry/how-to/model-deployment-policy?view=foundry). [Create custom policies](/azure/ai-foundry/how-to/custom-policy-definition?view=foundry) as needed.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.

## Agent observability

**Policy: The actions of every agent must be auditable.** To manage AI agents effectively across the organization, treat observability as a core business capability. Observability refers to the ability to monitor and understand what AI agents do both in real time and over time. Because these agents operate probabilistically and do not always behave the same way, visibility into their actions becomes essential for managing risk, ensuring compliance, and optimizing performance.

1. **Assign unique identities.** Require every AI agent to have a unique identity. This identity must include ownership details, version history, and lifecycle status. [Microsoft Entra Agent identity](/azure/ai-foundry/agents/concepts/agent-identity?view=foundry&tabs=rest-api) supports this structure by linking each agent to its owner and purpose. This clarity helps the organization distinguish between production, development, and test agents, which is critical for accountability and risk management.

1. **Maintain agent inventory.** Untracked or "shadow" deployments pose security and cost risks. Organizations must discover and classify all AI workloads across the cloud environment. This step ensures the organization maintains a complete inventory of AI assets. Use [Agent 365](/microsoft-365/admin/manage/agent-365-overview?view=o365-worldwide) for a full inventory, metrics, governance, financial oversight across all agents. If Agent 365 is unavailable, use Microsoft Defender for Cloud to [discover](/azure/defender-for-cloud/identify-ai-workload-model) and categorize agent workloads.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [Publish an agent to Agent 365](/azure/ai-foundry/agents/how-to/agent-365?view=foundry).

1. **Centralize logging.** Track key logs consistently, ideally to a centralized location, such as an Azure Log Analytics workspace. This consistency improves transparency, supports audit readiness, and simplifies troubleshooting. Centralized logs also enable cross-team collaboration. Gather custom telemetry in Application Insights that captures how agents behave and how users interact with them. This information helps decide whether to scale, refine, or retire agents based on business impact. To align technical performance with business goals, use or build **dashboards**. These dashboards provide leadership with a clear view of how AI investments contribute to outcomes.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: [monitor agents](/azure/ai-foundry/agents/how-to/metrics), [monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models), and [monitor applications](/azure/ai-foundry/how-to/monitor-applications) and [dashboards](/azure/ai-foundry/agents/how-to/metrics#dashboards).

    :::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: See [monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio). Centralize with [Azure Application Insights in Azure Monitor](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry).

1. **Track and allocate costs.** AI agents consume resources such as compute power, tokens, and API calls. Without visibility, costs can escalate quickly. Establish a unified view of agent usage and cost across departments and projects to track metrics like token consumption and compute usage. Organize this data by department or project to identify where costs concentrate. Apply cost center tags using [Microsoft Cost Management](/azure/cost-management-billing/costs/cost-allocation-introduction) to allocate agent expenses accurately. Require teams to tag resources per agent or use case to visualize cost breakdowns clearly. Set up real-time **alerts** to notify teams when spending approaches budget thresholds. These alerts help prevent overruns and support proactive financial management. Restrict who can create, deploy, and scale agents by using Azure **role-based access control** (RBAC). This structure reduces risk and ensures only authorized personnel manage AI deployments.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: [Plan and manage costs](/azure/ai-foundry/how-to/costs-plan-manage). Centrally administer quotas and access through the [management center](/azure/ai-foundry/concepts/management-center).

    :::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Review usage and message allocation](/microsoft-copilot-studio/requirements-messages-management) to manage consumption.

## Agent security

**Policy: All agents must meet all baseline security requirements.** AI agents operate differently from traditional IT systems. They process natural language, interact with external sources, and often make autonomous decisions. These capabilities introduce risks such as:

- **Data leakage**: Agents might unintentionally expose sensitive information.
- **Data poisoning**: Malicious actors can manipulate training data to alter agent behavior.
- **Jailbreak attempts**: Attackers can bypass safeguards to make agents behave unpredictably.
- **Credential theft**: Agents can become a vector for stealing authentication credentials.

To manage these risks, integrate agent security into existing enterprise security frameworks. This integration ensures consistency, reduces exposure, and supports regulatory compliance.

1. **Require AI threat protection.** Activate AI-specific threat protection. Microsoft Defender for Cloud’s [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) includes capabilities that detect prompt manipulation, unauthorized data access, and other agent-specific threats. These protections use global threat intelligence and integrate with Azure AI Content Safety to identify suspicious behavior in real time. Activating these tools reduces exposure and enables faster response to emerging risks.

1. **Enforce infrastructure security baselines.** Treat agent infrastructure with the same level of oversight as customer-facing systems. Treat agent runtimes with the same governance and oversight as customer-facing systems.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Review the [Azure security baseline for Foundry](/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) as a standard policy.

1. **Mandate adversarial testing.** Organizations must validate agent resilience before deployment. Red teaming simulates real-world attacks to identify vulnerabilities that standard testing might miss. These exercises help detect weaknesses such as prompt injection, data leakage, and jailbreak attempts. Run adversarial tests on all agents before production release and after significant updates. This step reduces the likelihood of exploitation and improves the agent's ability to handle hostile input.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Enforce the use of the [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues before deployment. Also see [AI Red Teaming Playground Labs](https://github.com/microsoft/AI-Red-Teaming-Playground-Labs?tab=readme-ov-file#ai-red-teaming-playground-labs)

    :::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Review [security and governance guidance](/microsoft-copilot-studio/security-and-governance), enable [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) to ensure continuous validation.

1. **Filter inputs and outputs.** Block adversarial input to bypass integrated safety protocols. Treat all incoming data, text, files, images, as potentially hostile. Validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Enforce baseline [guardrails and controls](/azure/ai-services/content-safety/overview) to mitigate harmful content. Combine with [Purview DLP](/purview/dlp-learn-about-dlp) policies or adding custom detectors, either within Purview or as standalone solutions, to reduce sensitive data leakage.

1. **Standardize authentication.** Use [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-azure-ai-foundry).

1. **Enforce least privilege.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

1. **Integrate with security operations.** Ensure AI-related alerts flow into the Security Operations Center (SOC). Define thresholds for anomalies such as latency spikes or unauthorized access attempts. Use Azure Monitor Alerts and route them to Microsoft Sentinel through Log Analytics. This integration strengthens the organization’s overall security posture and ensures agents remain resilient and trustworthy.

1. **Audit agent behavior.** Require periodic audits of agent interactions. Use logging and telemetry to identify unusual behavior, such as unexpected data access or different prompt patterns. These audits help detect early signs of compromise and support compliance with internal and external standards.

1. **Mandate security training.** Provide targeted training for security and development teams. Focus on real-world scenarios such as:

    - Jailbreak techniques that bypass agent safeguards.
    - Data poisoning attacks that manipulate training data.
    - Credential theft through agent interfaces.

    This training builds awareness and readiness, enabling teams to respond effectively to AI-specific threats.

1. **Govern external integrations.** AI agents often interact with external systems and data sources. These connections introduce more risks. Governance must reflect this complexity. Require teams to:

    - Support interoperability standards such as MCP (widely adopted across platforms) and emerging standards like A2A.
    - Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards.
    - Validate all external agent communications and limit them to explicitly approved entities.
    - Define clear boundaries for data access and logic execution during external interactions.

    These measures help prevent leakage of sensitive information and maintain control over agent behavior across organizational boundaries.

1. **Establish incident response plans.** Decide in advance how to quickly disable an agent if it malfunctions or causes harm. Plan how to communicate incidents. Include steps for preserving logs for forensic analysis and updating stakeholders. Just as disaster recovery plans exist for systems, establish one for AI agents. Run drills if the agent is critical to ensure the team knows how to respond under pressure.

    :::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Enforce the [high availability and resiliency](/azure/ai-foundry/how-to/high-availability-resiliency?view=foundry) guidance across your organization.

## Agent development

**Policy: Every agent must only use approved frameworks and protocols.** To ensure consistency, safety, and interoperability, organizations must standardize how agents interact with tools, data, and each other. Business leaders must define which protocols and frameworks are acceptable and mandate their use across all agent development efforts.

### Standardize agent frameworks

Establish a consistent set of frameworks and SDKs for agent development. This reduces complexity, improves collaboration across departments, and simplifies long-term maintenance. For example, within Foundry, standardize on options like the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) and the [Foundry SDK](/azure/ai-foundry/how-to/develop/sdk-overview?pivots=programming-language-python). These tools provide structured approaches to agent orchestration and integration, and they support rapid onboarding of new agents. When selecting frameworks, consider the following points:

- **Compatibility with existing infrastructure**: Ensure the framework integrates well with current cloud architecture and data sources.
- **Support and documentation**: Choose frameworks with robust documentation and active support to reduce ramp-up time.
- **Governance alignment**: Favor frameworks that include built-in compliance and security features to meet internal policy requirements.

By standardizing these choices, organizations create a predictable development environment that accelerates delivery and reduces risk.

### Standardize agent protocols

Protocols define how agents interact with tools, data, and each other. Require all agent development efforts to use standard protocols to ensure secure and predictable behavior. Two key protocols to adopt:

- **Model Context Protocol (MCP)**: MCP provides structured and secure access to tools, APIs, and data sources. It enforces boundaries around what agents can access, which helps prevent unauthorized actions and supports compliance.
- **Agent-to-Agent Protocol (A2A)**: A2A enables consistent communication between agents. It supports task delegation and context sharing, which improves coordination and reduces errors in multi-agent systems.

These protocols create a common language for agents across the organization. They reduce integration overhead, improve interoperability, and support governance by enforcing clear interaction rules.

## Next step

> [!div class="nextstepaction"]
> [Single agent or multiple agents?](./single-agent-multiple-agents.md)
