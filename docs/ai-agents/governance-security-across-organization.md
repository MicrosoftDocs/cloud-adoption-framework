---
title: Govern and secure AI agents AI agents across the organization
ms.reviewer: ssumner
description: Explore best practices for governing AI agents, from data residency laws to corporate compliance, to ensure secure and responsible AI deployment.
#customer intent: As a CTO or enterprise architect, I want to understand how to implement governance across the organization. I need to develop policies that apply universally and can be enforced by the compliance team. Additionally, I want to learn about the controls and solutions Microsoft provides to help facilitate this governance.
author: stephen-sumner
ms.author: pnp
ms.date: 04/09/2026
ms.update-cycle: 180-days
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Govern and secure AI agents

AI agents are software systems that can access data, make decisions, and take actions across business systems. They operate with delegated authority and can affect multiple systems at once. This capability creates organizational risk that differs from traditional applications. Decision makers must define baseline policies that apply to every agent so that risk remains controlled as adoption grows. A governance and security baseline sets the minimum requirements that every agent must meet before it is allowed to operate.

**Recommendation:** Establish a centralized and enforceable governance and security baseline for all AI agents that aligns with existing identity, data governance, and security practices.

:::image type="content" source="./images/ai-agent-adoption.svg" alt-text="Diagram showing a horizontal workflow with four connected phases: plan for agents (sub-steps are business plan, technology plan, organizational readiness, and data architecture). Govern and secure agents (Sub-steps are Responsible AI, Governance and Security, and Prepare environment). Build agents (Sub-steps are single and multi-agent systems and process to build agents). Manage agents integrate (sub-processes Integrate agents and operate agents)." lightbox="./images/ai-agent-adoption.svg" border="false":::
*Figure 1. Microsoft's AI agent adoption process.*

## 1. Responsible AI policies

Responsible AI policies define acceptable use of AI across the organization and establish expectations for fairness, transparency, and accountability. Decision makers must ensure that governance and security policies build on these foundations rather than duplicate or conflict with them. See [Responsible AI policies](../ai/responsible-ai-policies.md) to put a consistent framework in place before adoption spreads.

## 2. Agent governance and security

AI agent governance and security requires coordinated decisions across multiple areas of the organization. These decisions define the standards that control how agents are created, what data they can access, how they're secured, and how compliance is enforced. Leaders must establish policies across the following domains:

- **Control plane** governance to define ownership, identity, lifecycle management, and observability for all agents.
- **Data governance and compliance** to control how agents access, process, store, and retain data in alignment with regulatory and corporate requirements.
- **Security** to protect agents from threats, enforce access controls, and integrate agent workloads into existing security operations.
- **Development standards** to ensure consistent use of approved frameworks, protocols, and integration patterns across the organization.

Together, these policy areas form a unified governance model. Decision makers should align these standards with existing Azure governance structures to ensure they're enforceable, auditable, and scalable across the enterprise.

:::image type="complex" source="./images/governance-security.svg" alt-text="Diagram showing governance and security framework for AI agents across the organization with four horizontal layers." lightbox="./images/governance-security.svg" border="false":::
    The diagram illustrates a comprehensive governance and security framework organized into four layers. The top layer, "Data governance and compliance," includes Microsoft Purview Compliance Manager, Microsoft Purview APIs, Copilot Studio governance features, and data location controls. The second layer, "Agent observability," contains Microsoft Agent 365, Microsoft Defender for Cloud, Azure Log Analytics, Application Insights, and Cost Management. The third layer, "Agent security," shows Defender for Cloud AI threat protection, Content Safety in Foundry Control Plane, AI Red Teaming Agent, Azure role-based access control (RBAC), and Microsoft Sentinel. The bottom layer, "Agent development," lists Microsoft Agent Framework, Foundry SDK, Model Context Protocol (MCP), and Agent-to-Agent Protocol (A2A). Each layer connects to specific Microsoft services that support governance objectives at that level.
:::image-end:::

### 2.1 AI agent control plane

**Every agent must be observable, governed, and secure.** Agents introduce organizational risk because they access data and take actions with delegated authority. Leaders must know which agents exist, who owns them, what they can access, and how to intervene when behavior falls outside policy.

Adopt a centralized agent governance layer to enforce consistent identity, ownership, access control, and continuous monitoring for all agents. This approach replaces fragmented oversight with a single, organization-wide standard that is enforceable and auditable.

This governance layer becomes the foundation for applying governance practices, where policies are defined, applied, and continuously enforced across all agents. Here's how:

1. **Assign organizational accountability for agent governance.** AI agents introduce organizational risk similar to applications and identities. Governance requires clear accountability. **Best practices:** Assign ownership for agent governance to the same leaders responsible for cloud governance, security, and compliance. Align agent oversight with existing Azure governance structures. Avoid creating parallel governance models.

    **Decision guidance:**  If agent usage is limited, existing governance forums might be sufficient. If agents are used across multiple business units, revisit governance and formalize AI agent accountability with defined authority. Central ownership improves consistency. It requires clear decision rights.

2. **Maintain an agent registry.** Untracked or "shadow" deployments pose security and cost risks. Organizations discover and classify all AI agents across the cloud environment to maintain a complete inventory of AI assets. You can't govern agents you don't know exist. **Best practices:** Require every AI agent to be recorded in a single organizational inventory. Track ownership, purpose, platform, and access scope. Treat agents as managed organizational resources. Agent 365 provides an [Agent Registry](/microsoft-365/admin/manage/agent-registry?context=%2Fmicrosoft-agent-365%2Fcontext&view=o365-worldwide&preserve-view=true) when adopted.

    **Decision guidance:** If Agent 365 is available, use the built-in registry. If the environment is small, manual tracking might be sufficient for early adoption. If Agent 365 isn't available at scale, use Microsoft Entra Agent ID as the authoritative source for agent identities and ownership. This approach provides structure and visibility until a unified registry is adopted.

3. **Require a single identity for every agent.** Agent actions must be attributable and enforceable to a unique identity. **Best practices:** Require each agent to operate under a distinct agent identity. Use [Microsoft Entra Agent ID](/microsoft-agent-365/admin/capabilities-entra?view=o365-worldwide&preserve-view=true) to assign identity, permissions, and lifecycle controls. Bind agent access to organizational identity policies. Entra Agent ID enables consistent identity management across agent platforms and aligns agents with existing Azure identity governance.

4. **Enforce policies consistently across agent platforms.** Agents should follow the same organizational rules regardless of where they run. **Best practices:** Define policies for data access, identity usage, and allowed actions. Apply policies consistently across first-party agents, custom agents, and third-party agents. Don't rely on team-level rules alone. Agent 365 supports centralized agent policy configuration where adopted. Use [Agent settings](/microsoft-365/admin/manage/agent-settings?context=%2Fmicrosoft-agent-365%2Fcontext&view=o365-worldwide&preserve-view=true) to configure allowed agent types, sharing, policies, and user access. On the [Tools page](/microsoft-365/admin/manage/manage-tools-for-agent?context=%2Fmicrosoft-agent-365%2Fcontext&view=o365-worldwide&preserve-view=true), view AI-powered tools and MCP servers and choose to allow or block them.  

5. **Observe agent activity and tools.** Agent risk changes as behavior and usage evolve. **Best practices:**  Maintain continuous visibility into agent activity, access patterns, and policy compliance. Use observed behavior to identify drift, emerging risk, and gaps in controls. Adjust governance decisions as agent adoption scales. Agent 365 provides organizational‑level visibility such a [hero metrics](/microsoft-365/admin/manage/agent-365-overview?view=o365-worldwide&context=%2Fmicrosoft-agent-365%2Fcontext#hero-metrics-for-agent-adoption-and-impact&preserve-view=true). Use the [Agent Map](/microsoft-365/admin/manage/agent-map?view=o365-worldwide&context=%2Fmicrosoft-agent-365%2Fcontext&preserve-view=true) to visually see agents. Have teams [auto-instrument their agents](/microsoft-agent-365/developer/observability?tabs=python#auto-instrumentation&preserve-view=true) to eliminate the need for developers to write monitoring code manually, simplifies setup, and ensures consistent performance tracking.

6. **Track and allocate costs.** AI agents consume resources such as compute power, tokens, and API calls. Without visibility, costs escalate quickly. Establish a unified view of agent usage and cost across departments and projects to track metrics like token consumption and compute usage. Organize this data by department or project to identify where costs concentrate. Apply cost center tags to allocate agent expenses accurately. Require teams to tag resources per agent or use case to visualize cost breakdowns clearly. Set up real-time alerts to notify teams when spending approaches budget thresholds. These alerts prevent overruns and support proactive financial management. Restrict who can create, deploy, and scale agents to reduce risk and ensure only authorized personnel manage AI deployments.

**When Agent 365 isn't adopted:** If Agent 365 isn't available, organizations can gather governance signals from separate services such as:

- [Microsoft Entra](/entra/agent-id/) for AI agent identity.
- [Microsoft Purview](/purview/ai-agents) for data governance and compliance for AI agents.
- [Microsoft Defender](/defender-xdr/ai-agent-inventory?tabs=azure-ai-foundry) for AI agent security monitoring  
- [Azure Monitor](/azure/cloud-adoption-framework/manage/monitor#design-a-monitoring-solution) for centralized monitoring of Microsoft Foundry and Copilot Studio agents.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Require teams to evaluate Foundry's integration with Agent 365 by reviewing the following platform capabilities: [Microsoft Entra Agent Identity](/azure/ai-foundry/agents/concepts/agent-identity?view=foundry&preserve-view=true&tabs=rest-api), [Publish agents to Agent 365](/azure/ai-foundry/agents/how-to/agent-365) for central observability. Also determine how you would like to monitor the agents applications by reviewing the following articles: [Monitor agents](/azure/ai-foundry/agents/how-to/metrics), [monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models), [monitor applications](/azure/ai-foundry/how-to/monitor-applications) using [dashboards](/azure/ai-foundry/agents/how-to/metrics#dashboards). [Plan and manage costs](/azure/ai-foundry/how-to/costs-plan-manage), and use the [management center](/azure/ai-foundry/concepts/management-center) to centrally administer quotas and access. If Agent 365 isn't available, use [Microsoft Defender for Cloud](/azure/defender-for-cloud/identify-ai-workload-model) to discover and categorize agent workloads. **Automation:** Use the [Data Agent Governance and Security Accelerator](https://github.com/microsoft/Data-and-Agent-Governance-and-Security-Accelerator) for help automating governance of Microsoft Foundry resources with Defender for Cloud, diagnostics, tagging, and Content Safety integration.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Have teams review articles on [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio), centralize data with [Azure Application Insights in Azure Monitor](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry), and [review usage and message allocation](/microsoft-copilot-studio/requirements-messages-management) to manage consumption.

### 2.2. Data governance and compliance

Organizations require concrete mechanisms to control how agents access, process, and store data. These mechanisms translate regulatory requirements and corporate policies into technical controls that enforce boundaries around agent behavior. Data governance establishes the foundation for responsible AI deployment by defining what data agents can use, where they can operate, and how long they can retain information.

#### 2.2.1 Regulatory compliance

**All agents must comply with regulations and standards.** Regulatory compliance encompasses data protection laws, industry certifications, and internal governance requirements. Translate these regulations into foundational controls to ensure agents process data responsibly, securely, and transparently.

1. **Enforce data privacy.** Require agents to follow data privacy principles and use only the data necessary for intended functionality. Review datasets fed into AI models for RAG, fine-tuning, or training to identify privacy risks. Audit memory stores and logs regularly. Anonymize or pseudonymize personal data where feasible. Support user rights, such as deletion requests, to align with organizational privacy policies.

2. **Mandate data residency compliance.** Ensure agents operate in environments that meet data residency and sovereignty requirements. Identify the location of each data source, agent runtime, and output storage to ensure compliance. Use Azure regions or on-premises environments that align with residency policies. Configure logging to avoid unnecessary storage of sensitive content, retain only what compliance or operational policies require, and ensure data remains encrypted at rest.

3. **Define data retention policies.** Enforce defined retention periods for logs, memory, and training data. Implement automated purging or anonymization processes to retain only the context necessary for agent functionality. Require agents to inform users about retention durations and provide deletion mechanisms. Extend retention policies into full lifecycle management, covering data creation, archival, deletion, and purging.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to translate regulations, such as the EU AI Act, into controls and assess compliance posture across AI applications. Use [Microsoft Purview APIs](/purview/developer/secure-ai-with-purview) to integrate compliance automation into agent workflows. Review [Microsoft Purview capabilities for Foundry](/purview/ai-azure-services) to understand data governance and protection options.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Follow [governance and security best practices](/microsoft-copilot-studio/guidance/sec-gov-intro). Use [data locations](/microsoft-copilot-studio/data-location) to respect data sovereignty. See the platform's [compliance (ISO, SOC, HIPAA) certifications](/microsoft-copilot-studio/admin-certification).

#### 2.2.2 Corporate compliance

**All agents must comply with Responsible AI policies.** Corporate compliance ensures agents align with internal governance policies grounded in Responsible AI principles: fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability. Organizations translate these principles into concrete controls that govern how agents handle data, make decisions, and interact with users. These controls protect the organization from reputational harm, regulatory penalties, and loss of user trust while ensuring agents operate within defined ethical and operational boundaries.

1. **Isolate confidential data.** Separate confidential data from public data sources using physical or logical boundaries. Public-facing agents must not access internal business data. This separation prevents confidential information from unintentionally reaching public channels. In an Azure landing zone, deploy internal agents and data in "corp" (internal) management group subscriptions and public agents and data in "online" management group subscriptions.

1. **Restrict data access and enforce permissions.** Grant agents access only to the specific data sources required for their function. Don't provide broad access to all organizational data. When an agent accesses data on behalf of a user, ensure it inherits that user's permissions. Pass the user's identity or token securely when querying data to ensure session integrity. Apply Microsoft Purview Data Loss Prevention (DLP) policies and sensitivity labels to protect data. This approach ensures that an internal helpdesk agent, for example, shows an employee only their own HR record.

1. **Standardize knowledge and tool integrations.** Standardize how agents connect to knowledge and tools to reduce duplication and simplify maintenance. Use official APIs and connectors instead of custom integrations. It allows multiple agents across departments to reuse infrastructure and reduces operational costs. Follow governance policies that use project-level data isolation to prevent cross-contamination.

1. **Mandate transparency.** Disclose AI involvement clearly in agent interfaces. Notify internal stakeholders when their data supports training or inference. Review new data sources before integration to validate content, permissions, and security risks.

1. **Enforce fairness, inclusiveness, and accountability.** Assign clear ownership for AI outcomes to ensure alignment with organizational Responsible AI policies. Use Responsible AI tools to evaluate models for bias and inclusiveness during development and testing phases. Review model evaluations regularly to verify that agents treat all user groups fairly. Designate a human role accountable for approving deployments and monitoring ongoing compliance with ethical standards.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Review [Microsoft Purview capabilities for Foundry](/purview/ai-azure-services) to understand data governance and protection options. Use [Manage agent identities](/azure/ai-foundry/agents/concepts/agent-identity?tabs=rest-api#manage-agent-identities) to control access. Use [Azure Policy](/azure/ai-foundry/how-to/azure-policy) to control infrastructure configurations and [model deployment](/azure/ai-foundry/how-to/model-deployment-policy). [Create custom policies](/azure/ai-foundry/how-to/custom-policy-definition) as needed.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Create and manage solution pipelines](/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) and use [reusable component collections](/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforce version governance.

### 2.3 Agent security

**All agents must meet all baseline security requirements.** AI agents process natural language, interact with external sources, and often make autonomous decisions. These capabilities introduce security risks that organizations must address, including data leakage, data poisoning, jailbreak attempts, and credential theft. Organizations integrate agent security into existing enterprise security frameworks to ensure consistency, reduce exposure, and support regulatory compliance.

1. **Mandate agent security training.** Provide targeted training for security and development teams. Focus on real-world scenarios of jailbreak techniques that bypass agent safeguards, data poisoning attacks that manipulate training data, and credential theft through agent interfaces. This training builds awareness and readiness, enabling teams to respond effectively to AI-specific threats.

2. **Require AI threat protection.** Activate AI-specific threat protection. Defender for Cloud's [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) detects prompt manipulation, unauthorized data access, and other agent-specific threats. These protections use global threat intelligence and integrate with Content Safety to identify suspicious behavior in real time. Activating these tools reduces exposure and enables faster response to emerging risks.

3. **Enforce infrastructure security baselines.** Treat agent infrastructure with the same level of oversight as customer-facing systems. Agent runtimes require the same governance and oversight as customer-facing systems to prevent unauthorized access and ensure stability.

4. **Mandate adversarial testing.** Validate agent resilience before deployment. Red teaming simulates real-world attacks to identify vulnerabilities that standard testing might miss. These exercises detect weaknesses such as prompt injection, data leakage, and jailbreak attempts. Run adversarial tests on all agents before production release and after significant updates. This step reduces the likelihood of exploitation and improves the agent's ability to handle hostile input.

5. **Filter inputs and outputs.** Block adversarial input that attempts to bypass integrated safety protocols. Treat all incoming data, text, files, and images as potentially hostile. Validate and filter inputs before they reach models or backend systems. Strip scripting and injection content from text, enforce type and size restrictions for files, and scan media using moderation services. Update sanitization rules based on observed attack patterns.

6. **Standardize authentication.** Mandate the use of [managed identities for authentication](/entra/identity/managed-identities-azure-resources/overview) to eliminate credential management risks. This approach removes the need for developers to handle secrets and ensures that only authorized identities can access resources.

7. **Enforce least privilege.** Govern agent capabilities tightly when they execute actions. Each tool the agent uses enforces the user's permissions, or it has scoped service accounts. Use Data Loss Prevention (DLP) policies to restrict what data the agent can access or output. For instance, prevent the agent from returning credit card numbers in answers.

8. **Integrate with security operations.** Ensure AI-related alerts flow into the Security Operations Center (SOC). Define thresholds for anomalies such as latency spikes or unauthorized access attempts. Use Azure Monitor Alerts and route them to Microsoft Sentinel through Log Analytics. This integration strengthens the organization's overall security posture and ensures agents remain resilient and trustworthy.

9. **Govern external integrations.** Support interoperability standards such as MCP and emerging standards like A2A when agents interact with external systems. Restrict external interactions to trusted MCP servers that meet organizational security and compliance standards. Validate all external agent communications and limit them to explicitly approved entities. Define clear boundaries for data access and logic execution during external interactions. These measures prevent leakage of sensitive information and maintain control over agent behavior across organizational boundaries.

10. **Establish incident response plans.** Decide in advance how to quickly disable an agent if it malfunctions or causes harm. Plan how to communicate incidents. Include steps for preserving logs for forensic analysis and updating stakeholders. Establish disaster recovery plans for AI agents as you do for systems. Run drills if the agent supports critical operations to ensure the team knows how to respond under pressure.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Review the [Azure security baseline for Foundry](/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) as a standard policy. Enforce the use of the [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues before deployment. Also see [AI Red Teaming Playground Labs](https://github.com/microsoft/AI-Red-Teaming-Playground-Labs?tab=readme-ov-file#ai-red-teaming-playground-labs). Enforce baseline [guardrails and controls](/azure/ai-services/content-safety/overview) to mitigate harmful content. Combine with [Purview DLP](/purview/dlp-learn-about-dlp) policies or add custom detectors, either within Purview or as standalone solutions, to reduce sensitive data leakage. Enforce least-privilege roles using [Azure role-based access control](/azure/ai-foundry/concepts/rbac-azure-ai-foundry). Enforce the [high availability and resiliency](/azure/ai-foundry/how-to/high-availability-resiliency) guidance across your organization.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Review [security and governance guidance](/microsoft-copilot-studio/security-and-governance), enable [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) to ensure continuous validation.

### 2.4 Agent development standards

**Every agent must use only approved frameworks and protocols.** Organizations standardize how agents interact with tools, data, and each other to ensure consistency, safety, and interoperability. Business leaders define which protocols and frameworks are acceptable and mandate their use across all agent development efforts.

1. **Standardize agent frameworks.** Establish a consistent set of frameworks and SDKs for agent development. This approach reduces complexity, improves collaboration across departments, and simplifies long-term maintenance. Standardize on options that provide structured approaches to agent orchestration and integration and support rapid onboarding of new agents. When selecting frameworks, ensure compatibility with existing infrastructure so the framework integrates well with current cloud architecture and data sources. Choose frameworks with robust documentation and active support to reduce ramp-up time. Favor frameworks that include built-in compliance and security features to meet internal policy requirements. Standardizing these choices creates a predictable development environment that accelerates delivery and reduces risk.

1. **Standardize agent protocols.** Protocols define how agents interact with tools, data, and each other. All agent development efforts use standard protocols to ensure secure and predictable behavior. Two key protocols to adopt are the Model Context Protocol (MCP) and the Agent-to-Agent Protocol (A2A). MCP provides structured and secure access to tools, APIs, and data sources. It enforces boundaries around what agents can access, which prevents unauthorized actions and supports compliance. A2A enables consistent communication between agents. It supports task delegation and context sharing, which improves coordination and reduces errors in multi-agent systems. These protocols create a common language for agents across the organization. They reduce integration overhead, improve interoperability, and support governance by enforcing clear interaction rules.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Standardize development with the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) and the [Foundry SDK](/azure/ai-foundry/how-to/develop/sdk-overview?pivots=programming-language-python). These tools provide structured approaches to agent orchestration and integration.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use the [authoring canvas](/microsoft-copilot-studio/authoring-fundamentals) for low-code development and [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) to integrate with external data and services.

## 3. Prepare environment

An environment is the controlled space where workloads and AI agents are developed, deployed, and operated. The goal is to ensure that every AI environment enforces governance policies that act as guardrails, delivering consistency, security, and compliance across all workloads and agents. These guardrails protect teams while enabling rapid, safe development.

1. **Collaborate on enforcement strategy.** Governance must balance control with agility. Overly rigid policies can slow development and stifle innovation. Partner with workload teams to define an approach that starts with monitoring rather than immediate restrictions. Begin with an audit-based model to observe behaviors and identify patterns, then gradually introduce stricter controls as needed. This phased approach minimizes disruption while refining guardrails over time.

2. **Govern the environments.** Governing environments means applying consistent organizational policies and controls across all platforms, whether Azure AI platforms, Azure infrastructure, or SaaS. Organizations are responsible for ensuring every environment aligns with corporate standards and regulatory requirements.

    - **AI on Azure platforms and infrastructure**: Establish consistently governed application landing zones for building agents. These application landing zones provide a foundation for identity, networking, and security controls. AI agents don't require a specialized application landing zone architecture, but governance policies should reflect the services in use. For detailed guidance, see [Ready your AI environment](../scenarios/ai/ready.md).

    - **AI on SaaS**: A landing zone foundation isn't required because the platform is fully managed. Instead, focus on configuring identity, access, and data governance settings in line with organizational policies and best practices. Apply compliance controls wherever possible to maintain security and regulatory alignment.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**:  For infrastructure patterns, start with the [Foundry chat reference architecture](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-chat) and/or the [AI application landing zone](https://github.com/Azure/AI-Landing-Zones) and modify to fit your needs. Review the [AI workloads](/azure/well-architected/ai/) guidance in the Well-Architected Framework.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Follow [governance and security best practices](/microsoft-copilot-studio/security-and-governance#security-and-governance-controls). [Configure environments](/microsoft-copilot-studio/environments-first-run-experience) to separate workloads. Apply [Data Loss Prevention (DLP) policies](/microsoft-copilot-studio/admin-data-loss-prevention) to control connector usage within each environment. [Create agents from templates](/microsoft-copilot-studio/template-fundamentals).

## Next step

> [!div class="nextstepaction"]
> [Single agent or multiple agents?](./single-agent-multiple-agents.md)
