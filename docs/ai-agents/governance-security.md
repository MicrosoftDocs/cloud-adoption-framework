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

***How to ensure responsible use of AI agents and the data they handle.*** Beyond high-level principles, you need concrete governance mechanisms and security controls for your AI agents across their lifecycle. This is about putting guardrails in place so agents access only what they should, behave as expected, and can be managed centrally. Governance processes should be ingrained in how teams design, deploy, and update agents.

:::image type="content" source="./images/responsible-ai.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/responsible-ai.png" border="false":::

## Responsible AI policy

***How to create governance policies.*** Start with a strong foundation of Responsible AI principles. Responsible AI refers to designing and operating AI systems in an ethical, transparent, and accountable manner.  Microsoft has it's own Responsible AI standard. You can start with this and adapt it to your needs.

:::image type="content" source="./images/responsible-ai.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/responsible-ai.png" border="false":::

1. **Establish a Responsible AI standard.** Define an organization-wide Responsible AI standard that all AI agents must follow. The specific policies you create for each pillar will differ based on your industry and end users. At a minimum, your policy should align with ethical principles (fairness, privacy, transparency) and relevant regulations. Make it an official policy that applies to every AI system, regardless of size or visibility. Integrate Responsible AI into governance processes, such as architecture reviews, security assessments, and compliance workflows. Avoid creating parallel structures by embedding ethical checks into existing decision-making forums. Responsible AI categories is also a great way to identity AI risks across your business.

- For **Azure AI Foundry,** see [Trustworthy AI resources](/azure/ai-foundry/responsible-use-of-ai-overview).

1. **Assign ownership and oversight.** Identify who in your organization is responsible for enforcing Responsible AI. It could be a centralized AI ethics committee, your existing compliance office, or the AI Center of Excellence in partnership with legal. Give them authority to develop and update the Responsible AI policy and to audit AI agents for compliance. At the same time, automate enforcement where possible. For example, require that every agent must implement certain safety features such as not revealing sensitive information and have this checked in code reviews or continuous integration and deployment pipelines. The platform team can build templates that include these features by default.

1. **Use Responsible AI for risk assessment.**  Responsible AI principles provide a structured framework for comprehensive risk assessment. You must evaluate each AI workload against these principles to identify potential vulnerabilities and ethical concerns. Refer to [Assess AI risks](../scenarios/ai/govern.md#assess-ai-organizational-risks).

1. **Monitor and improve AI systems continuously.** Responsible AI is not a one-time effort. Set up metrics to continuously track ethical performance. For example, how often does the agent refuse to answer because of policy, how many user complaints about incorrect or biased responses are logged. Review these regularly and improve the agent to reduce issues. If regulations evolve such as new AI laws, update your agents and policies accordingly. Consider using tools like the Responsible AI dashboard to audit your models for fairness or errors in a systematic way. Use the [Responsible AI dashboard](/azure/ai-foundry/responsible-use-of-ai-overview) to assess fairness, interpretability, and error analysis across models.

## Org-wide agent governance

***How to ensure responsible use of AI agents and the data they handle.*** Beyond high-level principles, you need concrete governance mechanisms and security controls for your AI agents across their lifecycle. This is about putting guardrails in place so agents access only what they should, behave as expected, and can be managed centrally. Governance processes should be ingrained in how teams design, deploy, and update agents.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/governance-security.png" border="false":::

## Govern agent compliance

Validate each agent’s data access and processing against GDPR, HIPAA, CCPA, and internal policies. Engage legal and compliance teams for review. Update privacy notices to reflect AI usage. Conduct Data Protection Impact Assessments when required. Repeat compliance checks when agents integrate new datasets or features. Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) translates regulations like the EU AI Act into actionable controls and enables teams to assess and manage compliance posture across AI applications.

- For **Azure AI Foundry**, use [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) enable Azure AI Foundry and other AI platforms to integrate data governance controls into custom AI applications and agents.

- For **Microsoft Copilot Studio**, follow [Governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

**Monitor compliance continuously.** Establish a process for ongoing compliance checks even after deployment. Regularly review agents for policy adherence, perhaps via automated tests or periodic audits. Set up dashboards with compliance metrics such as percentage of agents with missing owner info or number of times agents accessed a disallowed site. Governance is not set and forget. As new threats or regulations emerge, you need feedback loops to update policies and ensure teams implement those updates.

## Govern agent security risks and alerts

To govern agent security effectively across your organization, direct your teams to implement a comprehensive strategy that addresses the unique risks introduced by generative AI. Focus on four critical threat vectors: data leakage, data poisoning, jailbreak attempts, and credential theft. These risks require proactive monitoring and response mechanisms that align with enterprise-grade security standards.

Use Microsoft Defender for Cloud’s [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) capabilities to establish a robust defense posture. This solution integrates with Azure AI Content Safety Prompt Shields and Microsoft's global threat intelligence to detect and alert on suspicious AI-related activities. By doing so, it enables your teams to respond to threats in real time and reduce exposure to emerging attack patterns. To operationalize this guidance:

1. **Establish governance policies.** Define clear usage boundaries for generative AI agents. Include acceptable use policies, data handling protocols, and escalation paths for security incidents. Ensure these policies align with your broader cloud security and compliance frameworks.

1. **Deploy AI threat protection.** Instruct your platform teams to activate AI threat protection within Microsoft Defender for Cloud. This step enables automated detection of prompt injection, model manipulation, and unauthorized data access attempts.

1. **Integrate with existing SOC workflows.** Ensure that AI threat alerts flow into your Security Operations Center (SOC) tooling, like Microsoft Sentinel. This integration allows your security analysts to triage and respond to AI-specific threats alongside traditional security incidents.

1. **Monitor and audit agent behavior.** Require regular audits of generative AI agent interactions. Use logging and telemetry to identify anomalous behavior, such as unexpected data access or unusual prompt patterns.

1. **Train teams on AI-specific risks.** Provide targeted training for security and development teams on generative AI vulnerabilities. Focus on real-world scenarios such as jailbreak techniques and poisoning attacks to build awareness and readiness.

1. **Review third-party integrations.** Evaluate any external plugins or APIs connected to your AI agents. Ensure they meet your enterprise’s security standards and do not introduce unvetted data sources or exposure points.

## Govern agent deployment

Provide pre-approved templates and components that include built-in governance. For example, a conversation fallback module that politely refuses disallowed requests, a logging component that sends transcripts to a secure database, or a secure data connector that handles auth tokens. By mandating or encouraging use of these standard components, all agents will inherently have consistent safeguards. The platform team should maintain these and update them as policies evolve. This approach reduces reinventing the wheel and ensures things like content filtering are not accidentally omitted.

- For **Azure AI Foundry**, use Azure Policy [Azure AI Foundry](/azure/ai-foundry/how-to/azure-policy) [control model deployment](/azure/ai-foundry/how-to/built-in-policy-model-deployment).

- For **Microsoft Copilot Studio**, [create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.

## Govern observability

## Govern agent development

You need to define preferred and unacceptable **protocols and frameworks**. Use Require all agents to use the **Model Context Protocol (MCP)** for interactions with tools, APIs, and data sources. MCP provides a structured and secure method for service discovery and invocation. Mandate the use of **Agent-to-Agent Protocol (A2A)** or compatible alternatives for inter-agent communication. This ensures consistent collaboration, task delegation, and context sharing across agents.

**Govern external connections.** Agents operate across boundaries, some within the enterprise, others with external sources. Governance must reflect this distinction to maintain control and trust. Encourage teams to use standard agent protocols, like MCP and A2A. Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards. Validate all external agent communications and limit them to explicitly approved entities. Define clear boundaries for data access and logic execution to prevent leakage of sensitive information during external interactions.

- For **Azure AI Foundry**, direct development teams to explicitly implement these protocols using frameworks such as the **Microsoft Agent Framework**, which natively supports MCP and A2A, or the built-in orchestration.

## Govern agent cost

For Azure AI Foundry, centrally administer quotas and access through the [management center](/azure/ai-foundry/concepts/management-center).

## Agent governance and security

### Protect and govern

For **Azure AI Foundry**, have teams use evaluations. They should automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control. 

Consider providing both end-user and application context. when adding end-user IP or identity, you can block that user or correlate incidents and alerts by that user. When adding application context, you can prioritize or determine whether suspicious behavior could be considered standard for that application in the organization. See [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).


## Guardrails and controls

Use [**content filtering**](/azure/ai-foundry/concepts/content-filtering) system works by running both the prompt input and completion output through an ensemble of classification models aimed at detecting and preventing the output of harmful content. Create a [**blocklist**](/azure/ai-foundry/openai/how-to/use-blocklists?tabs=api) to filter specific terms from input and output
You can apply one or more blocklists, use the built-in profanity blocklist or combine multiple blocklists into the same filter. Follow agent-level **security recommendations** from Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection).

## Agent security

AI agents now operate as core infrastructure components. Their integration introduces risks across identity, data handling, infrastructure, and behavior. These risks require a security strategy that treats agents as production systems and aligns with zero-trust principles and regulatory expectations. Organizations must direct their teams to implement controls that reduce exposure and ensure operational resilience. Key elements of security for AI agents:

1. **Secure agent infrastructure.** Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline). Include network isolation, patching, and runtime monitoring. Treat agent runtimes with the same governance and oversight as customer-facing systems.

1. **Enforce security best practices.** Use [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks. use Microsoft Entra ID for authentication. Enforce least-privilege access.

    For **Azure AI Foundry.** Enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-ai-studio) to assign necessary permissions for specific roles. Audit permissions regularly and apply Conditional Access policies to restrict access based on risk. This approach eliminates credential sprawl and enforces scoped trust boundaries.

3. **Least privilege for tools.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

4. **Input and output filtering.** Have teams treat all incoming data—text, files, images—as potentially hostile. Instruct teams to validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

5. **Security and adversarial testing.** Require penetration testing across the agent’s full stack. Include prompt injection tests to validate instruction isolation and rejection of unauthorized queries. Simulate adversarial inputs and monitor agent responses. Integrate automated test cases into CI/CD pipelines and run red team exercises. Include prompt hardening and response filtration in every release cycle.

6. **Agent incident response plan**  Prepare for the worst-case scenario with AI-specific incident response plans. Decide in advance how you would quickly disable an agent if it is doing harm or malfunctioning. For instance, the platform team should be able to revoke the agent’s credentials or shut its service down immediately. Plan how to communicate incidents. If an agent gave some wrong financial advice to customers, how will you correct that. Include steps for preserving logs for forensic analysis and updating stakeholders. Just as you have disaster recovery plans for systems, have one for AI agents. For example, if the underlying model is found to be flawed, can you roll back to a previous version or switch to a backup model. Run drills if the agent is critical to ensure the team knows how to respond under pressure.

### Microsoft tools

**Azure AI Foundry:** 
    - 
    - Restrict data exfiltration and enforce private access to models by configuring [Secure networking with Private Link](/azure/ai-foundry/how-to/configure-private-link) and validating egress rules during peer reviews.
    - Assign least-privilege roles via [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project) and rotate access boundaries during quarterly governance audits.
    - Prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.

**Microsoft Copilot Studio:**
    - Review access, connectors, and environment boundaries against the consolidated [Security and governance guidance](/microsoft-copilot-studio/security-and-governance).
    - Run pre-deployment assurance using the [Automatic security scan](/microsoft-copilot-studio/security-scan) and continuously verify protections in production through the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) view.

### Agent observability

Hand in hand with governance is observability. This is the ability to monitor and understand what your AI agents are doing in real time and over time. Given that AI agents have probabilistic behavior, it is critical to have visibility into their operations to detect anomalies, ensure compliance, and optimize performance. Think of AI agents as you would microservices. You need logging, monitoring, and analytics to manage them effectively at scale. Key observability practices for AI agents:

1. **Define ownership and scope for each agent.** For each agent, enforce that an owner and backup is assigned and document its intended scope and use case. Require workload teams to periodically re-test that this agent is still doing a specific task for a specific department and is owned by a specific person. This practice catches scope creep. If someone tries to expand what the agent does beyond its original intent without proper review, the documentation and review process will flag it. It also means any time an agent’s access or capabilities change, that change should be reviewed and noted in its record.

2. **Maintain a centralized agent catalog.** Direct teams to build and maintain a central inventory of all AI agents, experimental and production. This could be a simple dataset or a system that the platform team curates. At minimum, capture for each agent the business owner, technical owner, its purpose, what data it can access, what tools it can use, and its current compliance status. A catalog prevents unmanaged agents and helps spot duplication. It also aids in governance. You can periodically review this catalog to ensure each agent is still needed and up to standards.

3. **Use Microsoft Entra Agent ID.** [Microsoft Entra Agent ID](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/announcing-microsoft-entra-agent-id-secure-and-manage-your-ai-agents/3827392) supports traceability, access control, and lifecycle management. Use this identity to link logs, ownership metadata, and compliance status. It also helps if you have multiple versions of agents or development and test instances. Each should be distinguishable. With a unique identity, you can track usage statistics and tie them to the agent’s owner and purpose.

4. **Avoid shadow AI models.** To maintain visibility of all generative AI models running in your environment. See [Discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model)

5. **Real-time monitoring and alerting.** Instruct teams to monitor agent behavior continuously and define thresholds for anomalous activity. Set up monitoring on key metrics and events for agents. Define what constitutes abnormal behavior. Examples include spikes in usage, repeated errors, or unexpected data access patterns. Tie these alerts into your Security Operations Center workflows if you have one so they are investigated promptly. For example, Microsoft Defender for Cloud’s AI protection can detect certain anomalies in agent behavior such as attempts to extract secrets. Those should raise immediate flags. Make sure to also log the reason behind actions when possible. If your platform allows capturing the chain of thought or confidence scores, store them. For example, Azure AI Foundry can output trace logs of how the agent decided to call a certain function. Such detail is invaluable for troubleshooting and for training improvements.

4. **Comprehensive logging.** Log everything the agent does in a secure and tamper-proof way. Logging is critical for debugging issues, analyzing failures or odd behaviors, and is often required for compliance such as audit trails. This includes user queries, the agent’s responses, actions it takes such as calls to functions or APIs, and any significant decisions internally such as if it used a tool because confidence was low. Logs should have timestamps, the user or external system that interacted, and the agent’s ID. Use write-once storage or append-only logs to ensure an agent or malicious actor cannot alter history.

#### Azure AI Foundry

[Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications). Consolidate evaluation outputs through [continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).

#### Microsoft Copilot Studio

Audit configuration modifications, publishing events, and component updates through [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio) and reconcile anomalies during scheduled reviews. Reassess security posture and behavioral alignment periodically by correlating runtime protection insights from the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) with audit event streams from [logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio).

## Next step

> [!div class="nextstepaction"]
> [Single or multi-agent systems>](./single-multi-agent-systems.md)
