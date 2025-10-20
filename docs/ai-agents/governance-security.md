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

Data governance and compliance define how the organization manages, protects, and uses data across all AI agents and platforms. These practices ensure that AI systems operate within legal boundaries, align with internal policies, and maintain trust with users and stakeholders. Business leaders must treat governance as a strategic capability that supports innovation while minimizing risk.

Effective governance spans two domains: regulatory compliance, which addresses external legal obligations, and corporate compliance, which enforces internal standards and operational consistency.

#### Regulatory compliance

Regulatory compliance ensures that AI agents meet legal requirements such as GDPR, HIPAA, and CCPA. This includes validating how agents access and process data, updating privacy notices to reflect AI usage, and conducting Data Protection Impact Assessments when agents introduce new datasets or features. To operationalize these requirements across the cloud estate, organizations must implement foundational data practices:

- Metadata standards: Require teams to tag datasets with source, owner, sensitivity, and usage context. Use Microsoft Purview to enforce metadata policies and maintain a centralized data catalog. This supports auditability and improves discoverability.
- Sensitivity labeling: Extend existing classification schemes, such as Public, General, and Confidential, into agent workflows. Configure agents to respect these labels at runtime and restrict memory or logs from storing sensitive content unless protected.
- Privacy controls: Apply data minimization principles. Direct teams to use only the data necessary for agent functionality. Review training datasets, memory stores, and logs for privacy risks. Anonymize or pseudonymize data where possible. Support user rights, including deletion requests, and ensure agents comply with the organization’s privacy policy.
- Residency and sovereignty: Identify where each data source resides, where the agent runs, and where logs or outputs are stored. Select Azure regions or on-premises environments that meet residency requirements. Disable logging of sensitive content unless retention is required. Apply encryption to all stored data and validate vendor guarantees against internal policies.
- Retention and lifecycle management: Define retention periods for logs, memory, and training data. Implement automated purging or anonymization processes. Retain only the context necessary for agent functionality. Inform users about retention durations and provide deletion mechanisms. Expand retention policies into full lifecycle management with rules for data creation, archival, deletion, and purging.
- Transparency: Disclose AI involvement clearly in agent interfaces. Notify internal stakeholders when their data supports training or inference. Review new data sources before integration to validate content, permissions, and security risks.

Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to translate regulations like the EU AI Act into actionable controls and assess compliance posture across AI applications. Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to detects harmful user-generated and AI-generated content and to help comply with regulations or maintain the intended environment for your users.

- In **Azure AI Foundry**, you can use [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) enable Azure AI Foundry and other AI platforms to integrate data governance controls into custom AI applications and agents.

- For **Microsoft Copilot Studio**, follow [Governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

#### Corporate compliance

Corporate compliance ensures that AI agents align with internal governance policies and operational standards. This includes enforcing consistent deployment practices, reducing duplication of effort, and maintaining guardrails across all environments.

Organizations must use policy-as-code and infrastructure-as-code to embed governance into agent development and deployment. Provide pre-approved templates and components with built-in controls. Mandate or encourage use of these standard components to ensure consistent application of policies such as content filtering, version control, and access restrictions.

- For **Azure AI Foundry**, use [Azure Policy](/azure/ai-foundry/how-to/azure-policy) to control infrastructure configurations and [model deployment](/azure/ai-foundry/how-to/built-in-policy-model-deployment).

- For **Microsoft Copilot Studio**, [create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.

### Org-wide agent observability

Hand in hand with governance is observability. This is the ability to monitor and understand what your AI agents are doing in real time and over time. Given that AI agents have probabilistic behavior, it is critical to have visibility into their operations to detect anomalies, ensure compliance, and optimize performance. Think of AI agents as you would microservices. You need logging, monitoring, and analytics to manage them effectively at scale. Key observability practices for AI agents:

1. **Unique agent ID and ownership.** To establish effective observability, begin by directing teams to assign a unique identity to every AI agent. This identity must include ownership metadata, versioning, and lifecycle status. [Microsoft Entra Agent ID](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/announcing-microsoft-entra-agent-id-secure-and-manage-your-ai-agents/3827392) supports this requirement by linking each agent to its owner and purpose, enabling traceability and access control. This structure allows your organization to distinguish between production, development, and test instances, which is essential for managing risk and ensuring accountability.

1. **Discover all agent workloads.** Next, ensure full discovery of agent workloads across your cloud estate. Use Microsoft Defender for Cloud to [discover](/azure/defender-for-cloud/identify-ai-workload-model) and classify these workloads.  This step prevents shadow deployments and maintains a complete inventory of AI assets, which is essential for governance and cost control.

1. **Monitor all agents.** Once discovery is complete, shift focus to centralized monitoring. Use Azure Monitor Metrics and Application Insights to collect performance indicators such as latency, token usage, cost per request, and throughput. These metrics form the foundation for cost optimization and performance tuning. Instruct teams to configure custom telemetry that captures model behavior and user interaction patterns. This data enables leaders to quantify business impact and make informed decisions about scaling or refining models.

    Operational logging must follow a standardized schema. Have teams export logs to a centralized Azure Log Analytics workspace. Standardized logging of agent actions, decisions, and errors improves transparency and supports compliance and audit readiness. Centralized logs also simplify cross-team collaboration and accelerate troubleshooting.

    To support strategic planning, direct teams to build centralized dashboards using Azure Monitor Workbooks. This visibility helps align technical performance with business goals and ensures that AI investments deliver measurable value.

    - For **Azure AI Foundry**, [monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications).

    - For **Microsoft Copilot Studio**, see [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio). Centralize with [Azure Application Insights in Azure Monitor](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry).

### Org-wide agent security

To govern agent security effectively across your organization, focus on four critical threat vectors: data leakage, data poisoning, jailbreak attempts, and credential theft. These risks require proactive monitoring and response mechanisms that align with enterprise-grade security standards.

Use Microsoft Defender for Cloud’s [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) capabilities to establish a robust defense posture. This solution integrates with Azure AI Content Safety Prompt Shields and Microsoft's global threat intelligence to detect and alert on suspicious AI-related activities. By doing so, it enables your teams to respond to threats in real time and reduce exposure to emerging attack patterns. To operationalize this guidance:

1. **Establish security policies.** Define clear usage boundaries for generative AI agents. Include acceptable use policies, data handling protocols, and escalation paths for security incidents. Ensure these policies align with your broader cloud security and compliance frameworks.

1. **Deploy AI threat protection.** Instruct your platform teams to activate AI threat protection within Microsoft Defender for Cloud. This step enables automated detection of prompt injection, model manipulation, and unauthorized data access attempts.

1. **Integrate with existing SOC workflows.** Define thresholds for anomalies such as latency spikes or unauthorized access attempts. Instruct teams to create Azure Monitor Alerts and route them to Microsoft Sentinel through Log Analytics. This integration strengthens the organization’s security posture and enables faster incident response. By embedding alerting into the broader security operations workflow, decision makers ensure that AI services remain resilient and trustworthy.

1. **Monitor and audit agent behavior.** Require regular audits of generative AI agent interactions. Use logging and telemetry to identify anomalous behavior, such as unexpected data access or unusual prompt patterns.

1. **Train teams on AI-specific risks.** Provide targeted training for security and development teams on generative AI vulnerabilities. Focus on real-world scenarios such as jailbreak techniques and poisoning attacks to build awareness and readiness.

1. **Review third-party integrations.** Evaluate any external plugins or APIs connected to your AI agents. Ensure they meet your enterprise’s security standards and do not introduce unvetted data sources or exposure points.

## Org-wide agent development

You need to define preferred and unacceptable **protocols and frameworks**. Use Require all agents to use the **Model Context Protocol (MCP)** for interactions with tools, APIs, and data sources. MCP provides a structured and secure method for service discovery and invocation. Mandate the use of **Agent-to-Agent Protocol (A2A)** or compatible alternatives for inter-agent communication. This ensures consistent collaboration, task delegation, and context sharing across agents.

**Govern external connections.** Agents operate across boundaries, some within the enterprise, others with external sources. Governance must reflect this distinction to maintain control and trust. Encourage teams to use standard agent protocols, like MCP and A2A. Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards. Validate all external agent communications and limit them to explicitly approved entities. Define clear boundaries for data access and logic execution to prevent leakage of sensitive information during external interactions.

- For **Azure AI Foundry**, direct development teams to explicitly implement these protocols using frameworks such as the **Microsoft Agent Framework**, which natively supports MCP and A2A, or the built-in orchestration.

## Govern agent cost For Azure AI Foundry, centrally administer quotas and access through the [management center](/azure/ai-foundry/concepts/management-center).

## Agent platform governance and security

Organizations need an understanding of policies that affect workload governance requirements and governance that's applied to the platform itself.

### Agent protect and govern

For **Azure AI Foundry**, have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents). They should automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control.

Consider providing both end-user and application context. when adding end-user IP or identity, you can block that user or correlate incidents and alerts by that user. When adding application context, you can prioritize or determine whether suspicious behavior could be considered standard for that application in the organization. See [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

### Agent guardrails and controls

Use [**content filtering**](/azure/ai-foundry/concepts/content-filtering) system works by running both the prompt input and completion output through an ensemble of classification models aimed at detecting and preventing the output of harmful content. Create a [**blocklist**](/azure/ai-foundry/openai/how-to/use-blocklists?tabs=api) to filter specific terms from input and output
You can apply one or more blocklists, use the built-in profanity blocklist or combine multiple blocklists into the same filter. Follow agent-level **security recommendations** from Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection).

### Agent security

AI agents now operate as core infrastructure components. Their integration introduces risks across identity, data handling, infrastructure, and behavior. These risks require a security strategy that treats agents as production systems and aligns with zero-trust principles and regulatory expectations. Organizations must direct their teams to implement controls that reduce exposure and ensure operational resilience. Key elements of security for AI agents:

1. **Secure agent infrastructure.** Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline). Include network isolation, patching, and runtime monitoring. Treat agent runtimes with the same governance and oversight as customer-facing systems.

1. **Standardize content safety.** You need to block adversarial input to bypass integrated safety protocols. Use [Configure Azure Content Safety content filtering](/azure/ai-services/content-safety/overview) to block  sensitive data leakage and enforce content policies.

1. **Enforce security best practices.** Use [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks. use Microsoft Entra ID for authentication. Enforce least-privilege access.

    For **Azure AI Foundry.** Enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-ai-studio) to assign necessary permissions for specific roles. Audit permissions regularly and apply Conditional Access policies to restrict access based on risk. This approach eliminates credential sprawl and enforces scoped trust boundaries.

3. **Least privilege for tools.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

4. **Input and output filtering.** Have teams treat all incoming data—text, files, images—as potentially hostile. Instruct teams to validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

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
