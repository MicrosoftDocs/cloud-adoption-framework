---
title: Governance and security for AI Agents
description: Learn Governance and security for AI Agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Governance and security for AI Agents

***How to protect, regulate, and ensure responsible use of AI agents and the data they handle.*** Before your team writes a single line of code or launches an AI agent, put governance and security frameworks in place. Setting clear guardrails early will minimize the risk of incidents, ensure compliance with regulations, and maintain stakeholder trust. Rather than treating governance as a separate phase, weave these considerations throughout the design, build, deploy, and manage phases. However, it is useful to plan and implement core governance mechanisms at the outset so they are ingrained in the project's DNA.

## Agent governance

AI agents now operate as integral components of organization systems. They interact with sensitive data, execute tasks, and influence business outcomes. To ensure safe, scalable, and responsible use of AI agents, organizations must adopt a comprehensive governance strategy that spans design, deployment, and ongoing operations. This guidance outlines how technical leadership should organize their teams and processes to enforce consistent governance across the Microsoft ecosystem.

1. **Define a centralized compliance framework for AI agents.** Develop a unified AI agent governance framework that spans the entire organization. This means having consistent policies for how all agents are classified (by risk or criticality), what review/approval they need, how their behavior is monitored, and how data sensitivity is managed. Without a central framework, different teams might implement AI with inconsistent controls, leading to gaps or conflicts. Integrate this framework with existing corporate policies and any upcoming regulations (like the EU AI Act) so that using AI agents is just another facet of complying with enterprise rules. In short, treat AI governance as part of corporate governance.

1. **Integrate governance into development and deployment workflows.** Make governance checks a built-in part of the AI agent development lifecycle. For example, incorporate policy compliance validation into CI/CD pipelines so an agent cannot be deployed unless it passes certain checks. These checks could verify that the agent’s data access is restricted, that content filters are active, that scenario-specific risk mitigations like prompt injection tests have passed, and that pre-deployment approval gates are established. Require a security and compliance review sign-off before promotion to production. By automating and enforcing these in the pipeline, you prevent policy violations upfront rather than remediating after something goes wrong. Use policy as code where possible. Encode rules such as agents must not access data labeled Confidential into scripts or cloud policies that automatically enforce them in runtime environments. This ensures uniform enforcement across teams and speeds up deployment by removing manual governance steps.

1. **Use policy enforcement to control deployment behavior** Manual enforcement of governance policies introduces inconsistency and delays. Policy-as-code enables technical teams to define and enforce constraints programmatically, ensuring uniform behavior across environments and reducing operational overhead.

    - Adopt policy-as-code to govern agent deployment, data residency, and access control.
    - Ensure policies are versioned, testable, and auditable, enabling governance teams to track changes and validate enforcement.
    - Apply policies consistently across custom-built agents and third-party platforms to reduce fragmentation.

1. **Standardize agent development.** Standardization reduces risk, accelerates development, and simplifies governance. Mandate use of pre-configured templates and reference architectures that include built-in governance controls. By requiring teams to use vetted templates and reference architectures, organizations ensure consistent safeguards such as content filters, logging, and escalation logic. Technical leadership must select platforms that support enterprise-grade features and direct teams to adopt standardized development practices. Narrow use of frameworks, like MIcrosoft Agent Framework, to support interoperability.

1. **Establish reusable components.** Reusable components reduce duplication, accelerate development, and ensure consistent application of enterprise policies. Governance and platform teams must create libraries of pre-approved components and encourage their use across agent initiatives. Technical leadership must prioritize reuse over customization to improve ROI and reduce operational overhead.

    - Create libraries of pre-approved components such as fallback messages, clarification prompts, and secure data connectors.
    - Encourage developers to use approved components instead of building from scratch.
    - Maintain versioned collections to support governance and lifecycle management.

1. **Align data governance with AI agent behavior.**
AI agents rely on data to operate effectively. Misaligned data governance introduces risks related to privacy, security, and compliance. Technical leaders must ensure that all data used by agents adheres to enterprise governance standards.

    - Ensure all data used by agents meets enterprise data governance standards, including lineage tracking, access auditing, and sensitivity classification.
    - Extend data governance controls across all agent platforms, including custom-built solutions and third-party tools.
    - Integrate data governance into agent design so teams consider data constraints from the outset.

1. **Monitor compliance continuously.**
Governance must adapt to evolving risks, regulations, and business priorities. Continuous monitoring enables organizations to reassess controls, identify gaps, and respond proactively. Technical leaders must establish feedback loops and use automated tools to maintain alignment with emerging standards.

    - Establish feedback loops between governance and engineering teams to reassess controls and update policies.
    - Use automated tools to track changes in regulatory and operational requirements.
    - Review governance posture regularly using metrics and dashboards to assess effectiveness and identify areas for improvement.

**Microsoft tools:**

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

## Agent observability

Effective governance of AI agents requires full visibility into their identity, behavior, and operational footprint. Without observability, organizations risk deploying agents that operate outside policy boundaries, introduce security vulnerabilities, or degrade user trust.  To implement observability at scale, organizations must treat AI agents as first-class operational entities, similar to microservices or APIs with clear ownership, lifecycle tracking, and performance telemetry. This enables governance teams to detect anomalies, enforce policy, and maintain audit readiness across environments.

1.  **Assign unique identities to agents across platforms.** Require every AI agent to have a persistent identity, such as an **Agent ID** in Microsoft Entra ID. This identity supports traceability, access control, and lifecycle management. Use this identity to link logs, ownership metadata, and compliance status.

2.  **Define ownership and scope for each agent.** Mandate that every agent has a designated owner and documented scope. This metadata must include the responsible team, approved data sources, intended use cases, and compliance review status. Require quarterly reviews to detect scope creep and enforce approval workflows for changes. This prevents agents from evolving beyond their original intent without oversight and ensures that every agent has accountable stewardship.

3.  **Maintain a centralized agent catalog.** Direct teams to build and maintain a central inventory of all AI agents, experimental and production. This catalog should include identity, ownership, purpose, compliance status, and operational metrics. Use this portfolio to detect duplication, align governance reviews, and support discoverability of approved agents. A centralized view reduces shadow IT and improves coordination across departments.

4.  **Implement tamper-evident logging of agent activity.** Require comprehensive logging of all agent interactions, including queries received, actions taken, and responses generated. Store logs in secure, write-once systems to prevent alteration. Include timestamps, user IDs, and agent IDs to support forensic analysis and accountability. Ensure that logs also capture refusals, escalations, and policy violations to inform governance reviews and model improvements.

5.  **Deploy real-time monitoring and alerting.** Instruct platform teams to monitor agent behavior continuously and define thresholds for anomalous activity. Examples include spikes in usage, repeated errors, or unexpected data access patterns. Use telemetry to track performance metrics such as latency, success rates, and hallucination scores. Integrate monitoring with security operations to trigger alerts when agents deviate from expected behavior or policy constraints.

6.  **Use continuous evaluation to validate agent performance.** Establish automated evaluation pipelines that test agents against predefined queries and expected outcomes. Track quality scores over time and investigate performance drift. Use these evaluations to inform retraining, grounding updates, or deprecation decisions. Continuous evaluation ensures that agents remain aligned with business goals and governance standards.

By implementing these practices, technical leaders ensure that no agent operates in a blind spot. Observability transforms AI agents from opaque systems into transparent, accountable components of enterprise infrastructure.

**Microsoft tools:**

- **Azure AI Foundry:** Track model health and drift with [Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications) while consolidating evaluation outputs through [continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).

- **Microsoft Copilot Studio:** Audit configuration modifications, publishing events, and component updates through [Monitor logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio) and reconcile anomalies during scheduled reviews. Reassess security posture and behavioral alignment periodically by correlating runtime protection insights from the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) with audit event streams from [logging and auditing](/microsoft-copilot-studio/admin-logging-copilot-studio).

## Agent security

AI agents introduce new operational risks that span infrastructure, identity, data handling, and behavioral unpredictability. To ensure safe and scalable deployment, organizations must treat AI agents as production-grade systems. This requires a comprehensive security strategy that includes infrastructure hardening, identity governance, input validation, adversarial testing, and incident response. These controls reduce the likelihood of data breaches, model manipulation, or unauthorized access, while aligning with zero-trust principles and regulatory expectations. To implement this strategy effectively across the organization:

1. **Apply baseline infrastructure security to all agent runtimes.** Direct teams to treat every AI agent’s hosting environment as a production-critical asset.

1. **Enforce secure authentication and least-privilege access.** Prohibit static credentials in agent code or configuration. Assign Managed Identities to agents and use Microsoft Entra ID for all authentication flows. Require OAuth 2.0 for external service access and enforce least-privilege roles using Azure RBAC. Regularly audit agent permissions and apply Conditional Access policies where applicable. This approach eliminates credential sprawl and ensures agents operate within tightly scoped trust boundaries.

1. **Sanitize all user inputs across modalities.** Treat all incoming data—text, files, images—as potentially hostile. Instruct teams to implement input validation and filtering for every agent. For text, strip scripting or injection content. For files, enforce type and size restrictions and scan for malware. For media, use content scanning services to detect inappropriate or dangerous content. Update sanitization rules based on observed attack patterns and ensure these checks run before any input reaches the model or backend systems.

1. **Integrate continuous security testing and adversarial evaluation.** Require penetration testing across the agent’s full stack, including front-end interfaces, middleware, and backend services. Include prompt injection testing to validate that system instructions remain isolated and that agents reject unauthorized queries. Simulate adversarial inputs and monitor how agents respond. Incorporate automated test cases into CI/CD pipelines and conduct red team exercises regularly. Prompt hardening and response filtration must be part of every release cycle.

1. **Establish incident response and rollback procedures for AI agents.** Define what constitutes an AI incident—such as data leaks, prompt injections, credential compromise, or harmful behavior—and document response playbooks for each scenario. These playbooks must include escalation paths, kill-switch procedures, log preservation, credential invalidation, and rollback steps. Require teams to maintain configuration toggles that allow immediate shutdown of agents in production. Ensure backups exist for agent knowledge bases and that “quarantine mode” procedures isolate compromised agents. Conduct regular incident response drills to validate readiness and reduce recovery time.

By embedding these five pillars into the AI agent lifecycle, technical leaders reduce operational risk, improve compliance posture, and ensure that AI deployments remain secure, resilient, and aligned with enterprise governance standards.

**Microsoft tools:**

- **Azure AI Foundry:**

    - Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline).
    - Enable layered defenses using [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) in Microsoft Defender for Cloud.
    - Restrict data exfiltration and enforce private access to models by configuring [Secure networking with Private Link](/azure/ai-foundry/how-to/configure-private-link) and validating egress rules during peer reviews.
    - Assign least-privilege roles via [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project) and rotate access boundaries during quarterly governance audits.
    - Prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.

- **Microsoft Copilot Studio:**
    - Review access, connectors, and environment boundaries against the consolidated [Security and governance guidance](/microsoft-copilot-studio/security-and-governance).
    - Run pre-deployment assurance using the [Automatic security scan](/microsoft-copilot-studio/security-scan) and continuously verify protections in production through the [Agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view) view.

## Agent protocols

As organizations integrate autonomous agents into core operations, the need for structured governance becomes critical. These agents increasingly interact with internal systems, external APIs, and other agents to automate workflows, make decisions, and support business processes. Without a standardized approach, organizations risk fragmentation, security vulnerabilities, and operational inefficiencies.

To ensure consistent, secure, and scalable agent behavior across development teams, leadership must establish a protocol governance framework. This framework defines how agents communicate, transact, and collaborate—internally and externally, while aligning with enterprise compliance and security standards.

1. **Use standardized protocols for agent interactions** Standardization enables interoperability, simplifies integration, and reduces the cost of maintaining agent ecosystems. By mandating open and interoperable protocols, organizations can ensure that agents operate predictably across diverse environments.

    - Require all agents to use the **Model Context Protocol (MCP)** for interactions with tools, APIs, and data sources. MCP provides a structured and secure method for service discovery and invocation.
    - Mandate the use of **Agent-to-Agent Protocol (A2A)** or compatible alternatives for inter-agent communication. This ensures consistent collaboration, task delegation, and context sharing across agents.
    - Direct development teams to explicitly implement these protocols using frameworks such as the **Microsoft Agent Framework**, which natively supports MCP and A2A.

2. **Differentiate internal and external ecosystem interactions.** Agents operate across boundaries—some within the enterprise, others with external partners. Governance must reflect this distinction to maintain control and trust.

    - Allow internal agents to freely use MCP and A2A, provided they register with approved MCP servers and remain discoverable within the enterprise ecosystem.
    - Restrict external interactions to **trusted MCP servers** that meet organizational security and compliance standards. Validate all external agent communications and limit them to explicitly approved entities.
    - Define clear boundaries for data access and logic execution to prevent leakage of sensitive information during external interactions.

3. **Enforce security, observability, and lifecycle management** Protocol governance must extend beyond communication standards to include operational controls. These controls ensure agents behave securely, transparently, and remain manageable throughout their lifecycle.

    - Require authentication and encryption for all MCP server interactions and agent communications. Integrate with identity providers such as **Microsoft Entra ID** to enforce access control.
    - Implement observability using **OpenTelemetry** or equivalent frameworks to trace agent actions, tool calls, and inter-agent communications. This enables real-time monitoring and post-incident analysis.
    - Establish centralized lifecycle management for agents. Define onboarding, versioning, and retirement processes. Assign ownership and maintain documentation for every agent to ensure accountability.

4. **Define leadership responsibilities for operationalizing governance** Leadership must actively support and enforce protocol governance to ensure adoption and compliance across teams.

    - Maintain a registry of approved protocols, MCP servers, and agents. This registry serves as the authoritative source for development and audit purposes.
    - Provide training and documentation to development teams on protocol usage, security expectations, and governance workflows.
    - Conduct regular audits to identify compliance gaps and emerging risks. Use findings to refine governance policies and tooling.
    - Equip teams with governance dashboards and observability tools to monitor agent behavior and protocol adherence in real time.

## Next step

> [!div class="nextstepaction"]
> [Agent governance and security](./governance-security.md)
