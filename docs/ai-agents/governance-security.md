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

***How to protect, regulate, and ensure responsible use of AI agents and the data they handle.*** Beyond high-level principles, you need concrete governance mechanisms and security controls for your AI agents across their lifecycle. This is about putting guardrails in place so agents access only what they should, behave as expected, and can be managed centrally. Governance processes should be ingrained in how teams design, deploy, and update agents.

## Agent governance

Key elements of AI agent governance:

1. **Centralize policy and oversight.** Create a unified AI agent governance framework that applies to all teams. For example, define classification of agents by risk or business impact. Required approval steps for each class, such as a low-risk internal FAQ bot might need light review while a customer-facing finance advice agent needs heavy scrutiny. Define what ongoing monitoring you require. Integrate these with existing corporate governance and treat AI agents like any other critical technology asset that must comply with laws and company policies. If upcoming regulations such as the EU AI Act are relevant, proactively incorporate their requirements so you are not caught off guard.

1. **Integrate governance into development and deployment.** Make governance shift left into the development process. This can be done by automating checks in CI/CD pipelines and deployment processes. For instance, before an agent goes live, have a pipeline step that verifies it is only connecting to approved data sources, content safety filters are enabled, no sensitive info is hard-coded, and that a security review sign-off exists. Use policy as code where possible and encode rules such as if an agent attempts to call an external API not on the allow list, block the deployment or if an agent’s configuration lacks an owner metadata, fail the build. Tools like Azure Policy can enforce cloud resource configurations and ensure the agent runs only in approved regions. This proactive gating prevents policy violations from reaching production.

1. **Standardize agent development.** Provide pre-approved templates and components that include built-in governance. For example, a conversation fallback module that politely refuses disallowed requests, a logging component that sends transcripts to a secure database, or a secure data connector that handles auth tokens. By mandating or encouraging use of these standard components, all agents will inherently have consistent safeguards. The platform team should maintain these and update them as policies evolve. This approach reduces reinventing the wheel and ensures things like content filtering are not accidentally omitted. Microsoft’s platforms support this by supporting templates for Microsoft Copilot Studio and Azure AI Foundry.

1. **Use standardized protocols for agent interactions.** Standardization enables interoperability, simplifies integration, and reduces the cost of maintaining agent ecosystems. By mandating open and interoperable protocols, organizations can ensure that agents operate predictably across diverse environments. Require all agents to use the **Model Context Protocol (MCP)** for interactions with tools, APIs, and data sources. MCP provides a structured and secure method for service discovery and invocation. Mandate the use of **Agent-to-Agent Protocol (A2A)** or compatible alternatives for inter-agent communication. This ensures consistent collaboration, task delegation, and context sharing across agents. Direct development teams to explicitly implement these protocols using frameworks such as the **Microsoft Agent Framework**, which natively supports MCP and A2A.

1. **Differentiate internal and external ecosystem interactions.** Agents operate across boundaries—some within the enterprise, others with external partners. Governance must reflect this distinction to maintain control and trust. Allow internal agents to freely use MCP and A2A, provided they register with approved MCP servers and remain discoverable within the enterprise ecosystem. Restrict external interactions to **trusted MCP servers** that meet organizational security and compliance standards. Validate all external agent communications and limit them to explicitly approved entities. Define clear boundaries for data access and logic execution to prevent leakage of sensitive information during external interactions.

1. **Data governance alignment.** Ensure data governance policies carry over into AI agent usage. If your company classifies data as Confidential, your agents must respect that and not surface confidential info to unauthorized users. Enforce that all data integrated into agents is classified and labeled using tools like Microsoft Purview for automatic labeling. Agents should check labels at runtime and for instance refuse to disclose content labeled Highly Sensitive. Also audit how agents use data. If an agent stores conversation history, that log must be governed such as who can access it and when is it deleted. Align retention policies for agent logs with corporate data retention rules. Essentially, close any gap between traditional data governance and this new AI scenario.

1. **Monitor compliance continuously.** Establish a process for ongoing compliance checks even after deployment. Regularly review agents for policy adherence, perhaps via automated tests or periodic audits. Set up dashboards with compliance metrics such as percentage of agents with missing owner info or number of times agents accessed a disallowed site. Governance is not set and forget. As new threats or regulations emerge, you need feedback loops to update policies and ensure teams implement those updates.

### Microsoft tools

- **Azure AI Foundry**
    - [Microsoft Purview Compliance Manager](/purview/compliance-manager) translates regulations like the EU AI Act into actionable controls and enables teams to assess and manage compliance posture across AI applications.
    - [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) enable Azure AI Foundry and other AI platforms to integrate enterprise-grade data security and governance controls into custom AI applications and agents.
    - [Azure Policy](/azure/ai-foundry/how-to/azure-policy) enforces deployment constraints and aligns with internal governance standards and [enforce model deployment controls](/azure/ai-foundry/how-to/built-in-policy-model-deployment)
    - Centrally administer quotas and access through the [Management center](/azure/ai-foundry/concepts/management-center).
    - - Automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control.

- **Microsoft Copilot Studio**
    - Apply structured guardrails following the [Governance and security best practices overview](/microsoft-copilot-studio/guidance/sec-gov-intro) and map each agent to documented ownership and scope in your governance catalog.
    - [Data locations in Copilot Studio](/microsoft-copilot-studio/data-location) helps align AI agent deployments with jurisdictional requirements.
    - [Compliance (ISO, SOC, HIPAA) documentation](/microsoft-copilot-studio/admin-certification) validates adherence to enterprise-grade security and privacy standards.
    -  Standardize lifecycle workflows using [Create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) to embed approval, testing, and security validation checkpoints.
    - Accelerate compliant scaling and reduce drift by organizing validated building blocks in [Reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.
    - Coordinate feature evolution and deprecation decisions under the governance processes outlined in the [Governance and security best practices overview](/microsoft-copilot-studio/guidance/sec-gov-intro) and ensure each material change passes security scan reassessment.
    - Validate solution packaging and environment promotion paths using [Solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) while enforcing required compliance documentation updates at each release gate.

## Agent security

AI agents now operate as core infrastructure components. Their integration introduces risks across identity, data handling, infrastructure, and behavior. These risks require a security strategy that treats agents as production systems and aligns with zero-trust principles and regulatory expectations. Organizations must direct their teams to implement controls that reduce exposure and ensure operational resilience. Key elements of security for AI agents:

1. **Secure agent runtimes as production assets** Require infrastructure teams to apply baseline security controls to every AI agent environment. Include network isolation, patching, and runtime monitoring. Treat agent runtimes with the same governance and oversight as customer-facing systems.

2. **Govern identity and enforce least-privilege access.** Prohibit static credentials in agent code or configuration. Assign Managed Identities and use Microsoft Entra ID for authentication. Require OAuth 2.0 for external access and enforce least-privilege roles using Azure RBAC. Audit permissions regularly and apply Conditional Access policies to restrict access based on risk. This approach eliminates credential sprawl and enforces scoped trust boundaries.

3. **Least privilege for tools.** If agents can execute actions, govern those capabilities tightly. Each tool the agent uses should enforce the user’s permissions or have scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent it from returning credit card numbers in answers.

4. **Input and output filtering.** Have teams treat all incoming data—text, files, images—as potentially hostile. Instruct teams to validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

5. **Security and adversarial testing.** Require penetration testing across the agent’s full stack. Include prompt injection tests to validate instruction isolation and rejection of unauthorized queries. Simulate adversarial inputs and monitor agent responses. Integrate automated test cases into CI/CD pipelines and run red team exercises. Include prompt hardening and response filtration in every release cycle.

6. **Agent incident response plan**  Prepare for the worst-case scenario with AI-specific incident response plans. Decide in advance how you would quickly disable an agent if it is doing harm or malfunctioning. For instance, the platform team should be able to revoke the agent’s credentials or shut its service down immediately. Plan how to communicate incidents. If an agent gave some wrong financial advice to customers, how will you correct that. Include steps for preserving logs for forensic analysis and updating stakeholders. Just as you have disaster recovery plans for systems, have one for AI agents. For example, if the underlying model is found to be flawed, can you roll back to a previous version or switch to a backup model. Run drills if the agent is critical to ensure the team knows how to respond under pressure.

### Microsoft tools

**Azure AI Foundry:** Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline).
    - Enable layered defenses using [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) in Microsoft Defender for Cloud.
    - Restrict data exfiltration and enforce private access to models by configuring [Secure networking with Private Link](/azure/ai-foundry/how-to/configure-private-link) and validating egress rules during peer reviews.
    - Assign least-privilege roles via [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project) and rotate access boundaries during quarterly governance audits.
    - Prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.

**Microsoft Copilot Studio:**
    - Review access, connectors, and environment boundaries against the consolidated [Security and governance guidance](/microsoft-copilot-studio/security-and-governance).
    - Run pre-deployment assurance using the [Automatic security scan](/microsoft-copilot-studio/security-scan) and continuously verify protections in production through the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) view.

## Agent observability

Hand in hand with governance is observability. This is the ability to monitor and understand what your AI agents are doing in real time and over time. Given that AI agents have probabilistic behavior, it is critical to have visibility into their operations to detect anomalies, ensure compliance, and optimize performance. Think of AI agents as you would microservices. You need logging, monitoring, and analytics to manage them effectively at scale. Key observability practices for AI agents:

1. **Define ownership and scope for each agent.** For each agent, enforce that an owner and backup is assigned and document its intended scope and use case. Require workload teams to periodically reattest that this agent is still doing a specific task for a specific department and is owned by a specific person. This practice catches scope creep. If someone tries to expand what the agent does beyond its original intent without proper review, the documentation and review process will flag it. It also means any time an agent’s access or capabilities change, that change should be reviewed and noted in its record.

2. **Maintain a centralized agent catalog.** Direct teams to build and maintain a central inventory of all AI agents, experimental and production. This could be a simple dataset or a system that the platform team curates. At minimum, capture for each agent the business owner, technical owner, its purpose, what data it can access, what tools it can use, and its current compliance status. A catalog prevents unmanaged agents and helps spot duplication. It also aids in governance. You can periodically review this catalog to ensure each agent is still needed and up to standards.

3. **Unique agent identity.** Require every AI agent to have a persistent identity, such as an **Agent ID** in Microsoft Entra ID. This identity supports traceability, access control, and lifecycle management. Use this identity to link logs, ownership metadata, and compliance status. It also helps if you have multiple versions of agents or development and test instances. Each should be distinguishable. With a unique identity, you can track usage statistics and tie them to the agent’s owner and purpose.

4. **Comprehensive logging.** Log everything the agent does in a secure and tamper-proof way. Logging is critical for debugging issues, analyzing failures or odd behaviors, and is often required for compliance such as audit trails. This includes user queries, the agent’s responses, actions it takes such as calls to functions or APIs, and any significant decisions internally such as if it used a tool because confidence was low. Logs should have timestamps, the user or external system that interacted, and the agent’s ID. Use write-once storage or append-only logs to ensure an agent or malicious actor cannot alter history.

5. **Real-time monitoring and alerting.** Instruct teams to monitor agent behavior continuously and define thresholds for anomalous activity. Set up monitoring on key metrics and events for agents. Define what constitutes abnormal behavior. Examples include spikes in usage, repeated errors, or unexpected data access patterns. Tie these alerts into your Security Operations Center workflows if you have one so they are investigated promptly. For example, Microsoft Defender for Cloud’s AI protection can detect certain anomalies in agent behavior such as attempts to extract secrets. Those should raise immediate flags. Make sure to also log the reason behind actions when possible. If your platform allows capturing the chain of thought or confidence scores, store them. For example, Azure AI Foundry can output trace logs of how the agent decided to call a certain function. Such detail is invaluable for troubleshooting and for training improvements.

6. **Continuous evaluation.** Establish automated evaluation pipelines that test agents against predefined queries and expected outcomes. Track quality scores over time and investigate performance drift. Use these evaluations to inform retraining, grounding updates, or deprecation decisions. Continuous evaluation ensures that agents remain aligned with business goals and governance standards.

7. **Dashboard and analytics.** Provide management a dashboard view of agent performance and usage. Summarize things like how many queries were handled, success rates, top topics asked, user satisfaction ratings, and more. Additionally, track business key performance indicators from phase one here such as the handle time reduction goal and see if they are being met in real usage. Including these metrics in regular business reviews keeps AI agents on leadership’s radar and ensures accountability.

By making AI agents observable, you ensure no dark corners. Every agent is accounted for, monitored, and tuned. This dramatically reduces the risk of something going wrong unnoticed. It also empowers you to continuously improve agents because you have data to show where they struggle. Leadership should insist on robust observability as a prerequisite to scaling AI agents widely, as it is key to maintaining control and trust in an AI-augmented environment.

### Microsoft tools for observability

#### Azure AI Foundry

[Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications). Consolidate evaluation outputs through [continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).

#### Microsoft Copilot Studio

Audit configuration modifications, publishing events, and component updates through [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio) and reconcile anomalies during scheduled reviews. Reassess security posture and behavioral alignment periodically by correlating runtime protection insights from the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) with audit event streams from [logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio).

## Next step

> [!div class="nextstepaction"]
> [Single or multi-agent systems>](./single-multi-agent-systems.md)
