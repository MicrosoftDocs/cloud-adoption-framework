---
title: Governance and security for AI Agents
description: Learn Governance and security for AI Agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Agent governance and security

AI agents introduce new capabilities across the cloud estate, but they also raise complex questions about ethics, compliance, and operational control. To ensure responsible use, decision makers must establish a governance framework that begins with Responsible AI principles, followed by data governance, and then agent governance. This order reflects the dependencies: agents rely on governed data, and Responsible AI principles guide how agents behave and interact with that data.

## Org-wide agent governance

***How to ensure responsible use of AI agents and the data they handle.*** Beyond high-level principles, you need concrete governance mechanisms for your AI agents across their lifecycle. This is about putting guardrails in place so agents access only what they should, behave as expected, and can be managed centrally. Governance processes should be ingrained in how teams design, deploy, and update agents.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/governance-security.png" border="false":::

### Org-wide Data governance and compliance

AI agents now play a central role in how organizations operate, interact with customers, and make decisions. As these agents become more capable and embedded across departments, business leaders must treat their governance as a core business function, not just a technical concern. This means establishing clear rules, oversight mechanisms, and accountability structures that apply across the entire organization.

#### Regulatory compliance

Regulatory compliance ensures that AI agents meet legal requirements such as GDPR, HIPAA, and CCPA. This includes validating how agents access and process data, updating privacy notices to reflect AI usage, and conducting Data Protection Impact Assessments when agents introduce new datasets or features. To operationalize these requirements across the cloud estate, organizations must implement foundational data practices:

- **Metadata standards**: Require teams to tag datasets with source, owner, sensitivity, and usage context. Use Microsoft Purview to enforce metadata policies and maintain a centralized data catalog. This supports auditability and improves discoverability.
- **Sensitivity labeling**: Extend existing classification schemes, such as Public, General, and Confidential, into agent workflows. Configure agents to respect these labels at runtime and restrict memory or logs from storing sensitive content unless protected.
- **Privacy controls**: Apply data minimization principles. Direct teams to use only the data necessary for agent functionality. Review training datasets, memory stores, and logs for privacy risks. Anonymize or pseudonymize data where possible. Support user rights, including deletion requests, and ensure agents comply with the organization’s privacy policy.
- **Residency and sovereignty**: Identify where each data source resides, where the agent runs, and where logs or outputs are stored. Select Azure regions or on-premises environments that meet residency requirements. Disable logging of sensitive content unless retention is required. Apply encryption to all stored data and validate vendor guarantees against internal policies.
- **Retention and lifecycle management**: Define retention periods for logs, memory, and training data. Implement automated purging or anonymization processes. Retain only the context necessary for agent functionality. Inform users about retention durations and provide deletion mechanisms. Expand retention policies into full lifecycle management with rules for data creation, archival, deletion, and purging.
- **Transparency**: Disclose AI involvement clearly in agent interfaces. Notify internal stakeholders when their data supports training or inference. Review new data sources before integration to validate content, permissions, and security risks.

To support these efforts, use:

- Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to translate regulations like the EU AI Act into actionable controls and assess compliance posture across AI applications. 
- Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to detects harmful user-generated and AI-generated content and to help comply with regulations or maintain the intended environment for your users.

For platform-specific implementation:

- In **Azure AI Foundry**, you can use [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) enable Azure AI Foundry and other AI platforms to integrate data governance controls into custom AI applications and agents. [Identity Microsoft Purview's support](purview/ai-azure-services) for Azure AI Foundry.

- In **Microsoft Copilot Studio**, follow [Governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

#### Corporate compliance

Corporate compliance ensures that AI agents align with internal governance policies and operational standards. This includes enforcing consistent deployment practices, reducing duplication of effort, and maintaining guardrails across all environments.
Business leaders must direct their teams to embed governance into agent development and deployment using policy-as-code and infrastructure-as-code. These approaches allow organizations to define rules in reusable templates and components that teams must use when building agents.
Key actions include:

- Provide pre-approved templates and components with built-in controls for content filtering, version control, and access restrictions.
- Mandate or encourage use of these standard components to ensure consistent application of internal policies.

Platform-specific tools support these practices:

- For **Azure AI Foundry**, use [Azure Policy](/azure/ai-foundry/how-to/azure-policy) to control infrastructure configurations and [model deployment](/azure/ai-foundry/how-to/built-in-policy-model-deployment).

- For **Microsoft Copilot Studio**, [create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.

### Org-wide agent observability

To manage AI agents effectively across your organization, treat observability as a core business capability and not just a technical function. Observability refers to the ability to monitor and understand what AI agents do both in real time and over time. Because these agents operate probabilistically and do not always behave the same way, visibility into their actions becomes essential for managing risk, ensuring compliance, and optimizing performance.

1. **Unique agent ID and ownership.** Start by requiring every AI agent to have a unique identity. This identity must include ownership details, version history, and lifecycle status.  [Microsoft Entra Agent ID](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/announcing-microsoft-entra-agent-id-secure-and-manage-your-ai-agents/3827392)  supports this structure by linking each agent to its owner and purpose. This clarity helps your organization distinguish between production, development, and test agents which is critical for accountability and risk management.

1. **Discover all agent workloads.** Untracked or "shadow" deployments pose security and cost risks. Leaders must direct their teams to discover and classify all AI workloads across the cloud environment. This step ensures the organization maintains a complete inventory of AI assets. Use tools like Microsoft Defender for Cloud to [discover](/azure/defender-for-cloud/identify-ai-workload-model) and categorize agent workloads. A full inventory supports better governance, financial oversight, and strategic planning.

1. **Centralize monitoring and logging.** Once the organization identifies all agents, the next step is to monitor their behavior and performance centrally. Leaders must require consistent tracking of key metrics such as:

    - Latency (how fast agents respond)
    - Token usage (how much data agents process)
    - Cost per request
    - Throughput (how many requests agents handle)

    Use Azure Monitor Metrics and Application Insights to collect and analyze this data. Instruct teams to configure custom telemetry that captures how agents behave and how users interact with them. This information helps leaders decide whether to scale, refine, or retire agents based on business impact.

    **Standardize operational logging across all agents.** Require teams to export logs to a centralized Azure Log Analytics workspace. This consistency improves transparency, supports audit readiness, and simplifies troubleshooting. Centralized logs also enable cross-team collaboration.
    To align technical performance with business goals, ask teams to build dashboards using Azure Monitor Workbooks. These dashboards provide leadership with a clear view of how AI investments contribute to outcomes.

    Platform-specific tools support these efforts:

    - For **Azure AI Foundry**, [monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications).

    - For **Microsoft Copilot Studio**, see [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio). Centralize with [Azure Application Insights in Azure Monitor](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry).

1. **Observe cost.** AI agents consume resources such as compute power, tokens, and API calls. Without visibility, costs can escalate quickly. Leaders must create a unified view of agent usage and cost across departments and projects to track metrics like:

    - Token consumption
    - API calls
    - Compute usage

    Organize this data by department or project to identify where costs concentrate. Apply cost center tags using [Microsoft Cost Management](/azure/cost-management-billing/costs/cost-allocation-introduction) to allocate expenses accurately. Require teams to tag resources per agent or use case so you can see cost breakdowns clearly. Set up real-time alerts to notify teams when spending approaches budget thresholds. These alerts help prevent overruns and support proactive financial management. Restrict who can create, deploy, and scale agents by using role-based access control (RBAC). This structure reduces risk and ensures only authorized personnel manage AI deployments.

    For platform-specific cost management:

    - For **Azure AI Foundry**, [plan and manage costs](/azure/ai-foundry/how-to/costs-plan-manage). Centrally administer quotas and access through the [management center](/azure/ai-foundry/concepts/management-center).
    - For **Microsoft Copilot Studio**, [view and manage cost](/microsoft-copilot-studio/requirements-messages-management).

### Org-wide agent security

AI agents operate differently from traditional IT systems. They process natural language, interact with external sources, and often make autonomous decisions. These capabilities introduce risks such as:

- **Data leakage**: Agents might unintentionally expose sensitive information.
- **Data poisoning**: Malicious actors can manipulate training data to alter agent behavior.
- **Jailbreak attempts**: Attackers can bypass safeguards to make agents behave unpredictably.
- **Credential theft**: Agents can become a vector for stealing authentication credentials.

To manage these risks, leaders must direct their teams to integrate agent security into existing enterprise security frameworks. This integration ensures consistency, reduces exposure, and supports regulatory compliance.

1. **Establish security policies.** Start by setting clear boundaries for how AI agents operate. These policies must include:

    - Acceptable use guidelines for generative AI
    - Data handling protocols that specify what agents can access and store
    - Escalation paths for responding to security incidents

    Ensure these policies align with broader cloud security and compliance frameworks already in place. This alignment helps integrate AI governance into existing enterprise risk management practices.

1. **Deploy AI threat protection.** Direct platform teams to use Microsoft Defender for Cloud’s [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) capabilities. This solution detects prompt injection, model manipulation, and unauthorized data access attempts. It integrates with Azure AI Content Safety Prompt Shields and Microsoft’s global threat intelligence to identify suspicious activity in real time. Activating these protections enables faster response to emerging threats and reduces exposure to high-risk behaviors.

1. **Integrate with security operations.** Ensure AI-related alerts flow into the Security Operations Center (SOC). Define thresholds for anomalies such as latency spikes or unauthorized access attempts. Use Azure Monitor Alerts and route them to Microsoft Sentinel through Log Analytics. This integration strengthens the organization’s overall security posture and ensures agents remain resilient and trustworthy.

1. **Monitor and audit agent behavior.** Require periodic audits of agent interactions. Use logging and telemetry to identify unusual behavior, such as unexpected data access or abnormal prompt patterns. These audits help detect early signs of compromise and support compliance with internal and external standards.

1. **Train teams on AI-specific risks.** Provide targeted training for security and development teams. Focus on real-world scenarios such as:

    - Jailbreak techniques that bypass agent safeguards
    - Data poisoning attacks that manipulate training data
    - Credential theft through agent interfaces

    This training builds awareness and readiness, enabling teams to respond effectively to AI-specific threats.

1. **Govern external integrations.** AI agents often interact with external systems and data sources. These connections introduce additional risks. Leaders must ensure governance reflects this complexity. Require teams to:

    - Use standard protocols such as Model Context Protocol (MCP) and Agent-to-Agent Protocol (A2A) for secure communication
    - Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards
    - Validate all external agent communications and limit them to explicitly approved entities
    - Define clear boundaries for data access and logic execution during external interactions

    These measures help prevent leakage of sensitive information and maintain control over agent behavior across organizational boundaries.

## Org-wide agent development

To ensure consistency, safety, and interoperability, organizations must standardize how agents interact with tools, data, and each other. Business leaders must define which protocols and frameworks are acceptable and direct teams to use them across all agent development efforts.

1. **Standardize agent frameworks.** Direct development teams to use frameworks that support enterprise governance and security requirements. For example, in Azure AI Foundry, use the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview), which includes native support for secure communication protocols such as Model Context Protocol (MCP) and Agent-to-Agent Protocol (A2A). This framework also includes orchestration capabilities that simplify agent coordination and ensure consistent behavior across environments.

    Standardizing frameworks reduces development complexity, improves cross-team collaboration, and streamlines compliance with internal policies. It also enables faster onboarding of new agents and simplifies long-term maintenance.

1. **Standardize agent protocols.** Require all agent development efforts to use standard agent protocols, such as:

    - **Model Context Protocol (MCP)**: This protocol provides structured and secure access to tools, APIs, and data sources. It ensures agents operate within defined boundaries and only access approved resources.
    - **Agent-to-Agent Protocol (A2A)**: This protocol enables consistent communication between agents, including task delegation and context sharing. It supports predictable agent behavior and reduces the risk of miscommunication or unintended actions.

    These protocols create a common language for agents across the organization, which improves interoperability and reduces integration overhead. They also support governance by enforcing clear rules for how agents interact with internal and external systems.

- For **Azure AI Foundry**, direct development teams to explicitly implement these protocols using frameworks such as the **Microsoft Agent Framework**, which natively supports MCP and A2A, or it's built-in orchestration.

## Agent platform governance and security

Organizations need an understanding of policies that affect workload governance requirements and governance that's applied to the platform itself.

### Protect and govern in the agent platform

For **Azure AI Foundry**, have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents). They should automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control.

Consider providing both end-user and application context. when adding end-user IP or identity, you can block that user or correlate incidents and alerts by that user. When adding application context, you can prioritize or determine whether suspicious behavior could be considered standard for that application in the organization. See [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

### Agent guardrails and controls in the agent platform

Use [**content filtering**](/azure/ai-foundry/concepts/content-filtering) system works by running both the prompt input and completion output through an ensemble of classification models aimed at detecting and preventing the output of harmful content. Create a [**blocklist**](/azure/ai-foundry/openai/how-to/use-blocklists?tabs=api) to filter specific terms from input and output
You can apply one or more blocklists, use the built-in profanity blocklist or combine multiple blocklists into the same filter. Follow agent-level **security recommendations** from Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection).

### Agent security agent platform

AI agents now operate as core infrastructure components. Their integration introduces risks across identity, data handling, infrastructure, and behavior. These risks require a security strategy that treats agents as production systems and aligns with zero-trust principles and regulatory expectations. Organizations must direct their teams to implement controls that reduce exposure and ensure operational resilience. Key elements of security for AI agents:

1. **Secure agent infrastructure.** Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline). Include network isolation, patching, and runtime monitoring. Treat agent runtimes with the same governance and oversight as customer-facing systems.

1. **Standardize content safety.** You need to block adversarial input to bypass integrated safety protocols. Use [Configure Azure Content Safety content filtering](/azure/ai-services/content-safety/overview) to block  sensitive data leakage and enforce content policies.

1. **Enforce security best practices.** Use [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks. use Microsoft Entra ID for authentication. Enforce least-privilege access.

    For **Azure AI Foundry.** Enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-ai-studio) to assign necessary permissions for specific roles. Audit permissions regularly and apply Conditional Access policies to restrict access based on risk. This approach eliminates credential sprawl and enforces scoped trust boundaries.

3. **Least privilege for tools.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

4. **Input and output filtering.** Have teams treat all incoming data, text, files, images, as potentially hostile. Instruct teams to validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

5. **Security and adversarial testing.** Require penetration testing across the agent’s full stack. Include prompt injection tests to validate instruction isolation and rejection of unauthorized queries. Simulate adversarial inputs and monitor agent responses. Integrate automated test cases into CI/CD pipelines and run red team exercises. Include prompt hardening and response filtration in every release cycle.

6. **Agent incident response plan**  Prepare for the worst-case scenario with AI-specific incident response plans. Decide in advance how you would quickly disable an agent if it is doing harm or malfunctioning. For instance, the platform team should be able to revoke the agent’s credentials or shut its service down immediately. Plan how to communicate incidents. If an agent gave some wrong financial advice to customers, how will you correct that. Include steps for preserving logs for forensic analysis and updating stakeholders. Just as you have disaster recovery plans for systems, have one for AI agents. For example, if the underlying model is found to be flawed, can you roll back to a previous version or switch to a backup model. Run drills if the agent is critical to ensure the team knows how to respond under pressure.

### Microsoft tools

**Azure AI Foundry:** 
    - Restrict data exfiltration and enforce private access to models by configuring [Secure networking with Private Link](/azure/ai-foundry/how-to/configure-private-link) and validating egress rules during peer reviews.
    - Assign least-privilege roles via [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project) and rotate access boundaries during quarterly governance audits.
    - Prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.

**Microsoft Copilot Studio:**
    - Review access, connectors, and environment boundaries against the consolidated [Security and governance guidance](/microsoft-copilot-studio/security-and-governance).
    - Run pre-deployment assurance using the [Automatic security scan](/microsoft-copilot-studio/security-scan) and continuously verify protections in production through the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) view.

## Next step

> [!div class="nextstepaction"]
> [Single or multi-agent systems>](./single-multi-agent-systems.md)
