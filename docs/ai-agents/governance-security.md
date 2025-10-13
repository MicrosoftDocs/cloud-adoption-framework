---
description: Learn Governance and security for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2### Operations

**All agents must follow a defined lifecycle from development to retirement.** *Agents must follow a defined lifecycle from development to retirement. Require lifecycle documentation and approval checkpoints. Make sure you are aware of model changes, such as automatic model upgrades when an earlier version is deprecated, or new model releases that you can test and consider switching to.*

**All agents must follow formal change management processes.** Significant changes to an agent's functionality, scope, or underlying model require a documented change log and stakeholder sign-off. This governance step prevents unauthorized modifications, maintains compliance, and ensures accountability across teams.

**Microsoft tools:**

- **Azure AI Foundry:** Combine automated policy enforcement, red teaming, and monitoring signals with manual architecture review checkpoints to maintain conformance to the [security baseline](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) and govern hubs and projects with [Azure Policy definitions](/azure/ai-foundry/how-to/azure-policy).
- **Microsoft Copilot Studio:** Coordinate feature evolution and deprecation decisions under the governance processes outlined in the [Governance and security best practices overview](/azure/microsoft-copilot-studio/guidance/sec-gov-intro) and ensure each material change passes [security scan](/azure/microsoft-copilot-studio/security-scan) reassessment.ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Governance and security for AI agents

Before your team writes a single line of code or launches an AI agent, put governance and security frameworks in place. Setting clear guardrails early will minimize the risk of incidents, ensure compliance with regulations, and maintain stakeholder trust. Rather than treating governance as a separate phase, weave these considerations throughout the design, build, deploy, and manage phases. However, it’s useful to plan and implement core governance mechanisms at the outset so they are ingrained in the project’s DNA.

## Regulatory compliance

**All agents must comply with regulations and standards.** Teams must use tools that meet regulatory requirements. Before any agent deploys, it must pass a formal security and compliance review before deployment that includes scope, data access, privacy controls, identified risks, and safety test results. Use automated policy checks. Fallback to manual review workflows. Deploy through a CI/CD pipeline with these checks embedded. Document these reviews for accountability and repeat them periodically. Audit logs and outputs to confirm compliance with evolving laws and corporate policies, such as stricter data privacy rules or AI ethics guidelines. Update agents or usage policies immediately when new regulations take effect.

**Microsoft tools:**

- **Microsoft Purview:** Establish comprehensive compliance management through [Compliance Manager assessments for AI regulations](/purview/compliance-manager-assessments#assessments-for-ai-regulations) which include regulatory templates for EU Artificial Intelligence Act, ISO/IEC 23894:2023, ISO/IEC 42001:2023, and NIST AI Risk Management Framework. Maintain ongoing compliance through [Data Security Posture Management for AI](/purview/ai-microsoft-purview) to secure and govern AI applications with insights into AI activity, compliance controls, and ready-to-use policies to monitor and protect data in AI prompts.
- **Azure AI Foundry:** Generate comprehensive documentation for regulatory reviews using [AI reports to improve AI governance](/azure/ai-foundry/what-is-ai-foundry) which show project details including model cards, model versions, content safety filter configurations, and evaluation metrics in PDF or SPDX formats for easier ongoing audits of applications in production.
- **Microsoft Copilot Studio:** Verify compliance certifications and data residency requirements through [ISO, SOC, and HIPAA compliance documentation](/azure/microsoft-copilot-studio/admin-certification) and align deployment regions with organizational requirements via [Data locations in Copilot Studio](/azure/microsoft-copilot-studio/data-location).

## Responsible AI

**All agents must follow Responsible AI principles.** Conduct regular ethics reviews. Use tools like the Responsible AI Dashboard and Fairlearn to help identify bias in datasets. Review the outputs for fairness, especially if the agent’s decisions impact people. Ensure you’re not inadvertently breaking laws like equal opportunity laws due to biased AI suggestions

**All agents must have content filters.** Keep the content filters and safety nets up to date. As new kinds of inappropriate content emerge, new slang or evolving social issues, update the moderation rules or the model. Also, watch for any drift in the agent’s behavior. Models can change outputs over time due to upstream changes or new patterns in queries. If users start exploiting a loophole to get forbidden answers and you spot it, close that loophole. This could involve adjusting the prompt or adding that scenario to the forbidden list.

**Every agent must use the same unknown handling.** Program each agent to respond politely when it cannot answer a question or access a resource. Use default responses such as “I am sorry, I do not have that information right now” and suggest escalation to a human when needed. Log unknown queries across agents to identify gaps and improve coverage.

Microsoft facilitation:

- **Microsoft Copilot Studio:** Configure content moderation in your [Knowledge sources](/azure/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation).
- **Azure AI Foundry:** Use [Content Safety in Azure AI Foundry](/azure/ai-foundry/ai-services/content-safety-overview) and follow [Azure AI Foundry content filtering](/azure/ai-foundry/concepts/content-filtering) guidance.

## Security

### Security review

**All agents must pass a security review.** Agents must undergo penetration testing and static analysis to identify vulnerabilities such as open ports or injection flaws. Validate secure coding practices and confirm sensitive configurations are stored securely. Enable audit logging and identity management.

**Microsoft tools:**

- **Azure AI Foundry:** Follow the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) to implement comprehensive security controls and enable [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) with Microsoft Defender for Cloud for layered security defenses.
- **Microsoft Copilot Studio:** Utilize [Automatic security scan](/azure/microsoft-copilot-studio/security-scan) to identify security issues before deployment and monitor [Agent runtime protection status](/azure/microsoft-copilot-studio/security-agent-runtime-view) to maintain ongoing security posture.

### Secure authentication and authorization

**All agents must use secure authentication mechanisms.** Authenticate agents using Microsoft Entra ID Managed Identities instead of access keys or passwords. Managed identities eliminate credential storage in code and support automatic rotation. Assign least-privilege roles using Azure Role-Based Access Control (RBAC). Avoid broad permissions such as “Reader” or “Contributor” unless justified.

### Baseline infrastructure security

**Every agent must follow baseline security recommendations.** Apply standard security controls to containers and cloud services. Enable logging and monitoring at the infrastructure level to detect abnormal behavior such as unexpected outbound calls or resource spikes. Lock down the environment to prevent exploitation of underlying resources.

**Microsoft tools:**

- **Azure AI Foundry:** Configure [secure networking with private link](/azure/ai-foundry/how-to/configure-private-link) to restrict data exfiltration and enforce private access to models while validating egress rules during security reviews.
- **Microsoft Copilot Studio:** Follow [Security and governance guidelines](/azure/microsoft-copilot-studio/security-and-governance) to review access controls, connectors, and environment boundaries that minimize over-privileged operations.

### Input sanitization

**All agents must sanitize all user inputs.** Treat user-supplied files as hostile. Implement virus scanning for uploads and validate new input types such as images. Enforce strict checks on file types, size limits, and data formats. Update filtering rules based on real-world usage and discovered injection attempts.

### Security testing

**AI agents must undergo continuous security testing.** Include agents in regular penetration testing cycles. Cover traditional web-based attacks and AI-specific adversarial scenarios such as prompt injection and hidden command embedding. Remediate vulnerabilities promptly and add regression tests.

- Test prompt hardening to ensure user instructions cannot override system rules.
- Separate system instructions from user input using role-based message formatting.
- Test jailbreak scenarios and implement adversarial input detection with anomaly detection or prompt injection classifiers.

**Microsoft tools:**

- **Azure AI Foundry:** Execute comprehensive adversarial testing using the [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent) with support for multiple [attack strategies](/azure/ai-foundry/concepts/ai-red-teaming-agent#supported-attack-strategies) and integrate these test cases into CI/CD workflows using [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project).

### Incident Response

**All agents must have documented incident response and rollback procedures.** Define what qualifies as an incident, including data leaks, prompt injection, harmful outputs, or credential compromise. Document escalation paths and decision criteria. Include agent owner, technical expert, security lead, and compliance advisor in the response team.

- Implement configuration toggles for immediate agent disablement.
- Back up data before launch and maintain quarantine modes for compromised agents.
- Follow Azure AI Foundry guidance for disaster recovery and risk monitoring.

See **Microsoft Facilitation:**

- **Azure AI Foundry:** Follow guidance to set up [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery). If you’re using an Azure OpenAI deployment, learn [How to use Risks & Safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to check.

### Observability and monitoring

**All agents must have a unique identity and be visible in the enterprise directory.** Agents created in Microsoft Copilot Studio and Azure AI Foundry automatically appear in Microsoft Entra ID. Navigate to Enterprise Applications and filter by Application type → Agent ID (Preview) to view agent identities. This identity ensures traceability and prevents rogue deployments.

**All agents must have a designated owner and documented scope.** Assign an accountable owner for each agent’s lifecycle. Automate ownership tracking and verify through manual audits. Document the agent’s purpose, owning team, data sources, compliance status, and review dates. Enforce quarterly scope reviews and flag changes for approval to prevent uncontrolled expansion.

**All agents must be cataloged in a centralized portfolio.** Register every new agent with IT or a center of excellence. Include basic details such as purpose, owner, and compliance status. A centralized catalog prevents duplication, enforces standards, and identifies gaps where new agents are needed. It also improves adoption by providing visibility to end users.

**All agent interactions must be logged in a tamper-evident format.** Centralize logs and conduct periodic audits with anomaly detection. Include timestamps, user IDs, and actions in logs to support forensic analysis. Log all rejections and escalations to identify gaps in scope or clarify agent purpose. Address findings before go-live by adding missing security controls or adjusting configurations.

**All agents must implement real-time monitoring and alerting for security events.** Track abnormal usage patterns, data exfiltration attempts, and denial-of-service (DoS) indicators. Integrate alerts with SIEM systems such as Microsoft Sentinel. Establish thresholds for anomalous behavior and configure alerts to notify security teams immediately. Rapid detection and response minimize impact and maintain resilience.

**All agent interactions must be logged in a tamper-evident format.** Logs must include timestamps, user IDs, and actions, and support forensic analysis in case of incidents.

**Microsoft tools:**

- **Azure AI Foundry:** Track model health and drift with [Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications) while consolidating evaluation outputs through [Continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).
- **Microsoft Copilot Studio:** Audit configuration modifications, publishing events, and component updates through [Monitor logging and auditing](/azure/microsoft-copilot-studio/admin-logging-copilot-studio) to maintain traceability and detect unauthorized changes to agent configurations.

### Development

**All agents deployments must use repeatable templates.** Templates standardize development and embed safeguards such as human handoff logic and permission checks. Make templates accessible through a shared repository or importable solution to simplify adoption. Review agents against the template and require teams to justify deviations. This approach accelerates development, improves consistency, and reduces governance overhead.

**All agents must use approved frameworks.** Require teams to build agents using a common framework such as Microsoft Agent Framework. Approved frameworks ensure compatibility with enterprise security, compliance, and monitoring standards. They also reduce integration complexity and improve maintainability across the lifecycle.

**Microsoft tools:**

- **Azure AI Foundry:** Automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and use the [Azure AI Foundry VS Code Agent development extension](/azure/ai-foundry/how-to/develop/vs-code-agents) to standardize local configuration and enforce policy compliance.
- **Microsoft Copilot Studio:** Standardize lifecycle workflows using [Create and manage solution pipelines](/azure/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) to embed approval, testing, and security validation checkpoints while organizing validated building blocks in [Reusable component collections](/azure/microsoft-copilot-studio/authoring-export-import-copilot-components).

### Operations

**All agents must follow a defined lifecycle from development to retirement.** *Agents must follow a defined lifecycle from development to retirement. Require lifecycle documentation and approval checkpoints. Make sure you are aware of model changes, such as automatic model upgrades when an earlier version is deprecated, or new model releases that you can test and consider switching to.*

**All agents must follow formal change management processes.** Significant changes to an agent’s functionality, scope, or underlying model require a documented change log and stakeholder sign-off. This governance step prevents unauthorized modifications, maintains compliance, and ensures accountability across teams.

## Microsoft facilitation

See **Microsoft facilitation: regulatory**

- **Microsoft Purview:** Use tools such as Microsoft’s AI Compliance Manager (in Purview) to map your controls to regulatory requirements.
- **Copilot Studio:** See compliance with regulatory requirements, [Review ISO, SOC, and HIPAA compliance](/azure/microsoft-copilot-studio/admin-certification). Follow all data residency requirements, and deploy your agents to the right Microsoft datacenter, see [Data locations in Copilot Studio.](/azure/microsoft-copilot-studio/data-location) [**Governance and security best practices overview**](/azure/microsoft-copilot-studio/guidance/sec-gov-intro). [Microsoft Copilot Studio compliance](/azure/microsoft-copilot-studio/admin-certification). [Data locations in Copilot Studio.](/azure/microsoft-copilot-studio/data-location)
- **Azure AI Foundry:** Apply [Azure Policy definitions](/azure/ai-foundry/how-to/azure-policy) that meet your governance policies to govern and audit hub and projects. Use the [Management center overview](/azure/ai-foundry/concepts/management-center) to govern hubs, projects, quotas, and access. [Control AI model deployment with built-in policies](/azure/ai-foundry/how-to/built-in-policy-model-deployment).

See **Microsoft facilitation: Observability**

- **Microsoft Copilot Studio:** [Monitor](/azure/microsoft-copilot-studio/admin-logging-copilot-studio) changes to the content and settings of an agent that can affect security and agent behavior.
- **Azure AI Foundry:** [Continuously Evaluate your AI agents](/azure/ai-foundry/how-to/continuous-evaluation-agents). [Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and [Monitor your Generative AI Application](/azure/ai-foundry/how-to/monitor-applications) behavior to detect drift, misuse, or performance anomalies.

## Security Microsoft facilitation:

- **Copilot Studio:** Agents are secure by default. If modified, use the [Automatic security scan](/azure/microsoft-copilot-studio/security-scan). Follow the [Security and governance](/azure/microsoft-copilot-studio/security-and-governance) guidelines, and monitor the [Agent runtime protection status](/azure/microsoft-copilot-studio/security-agent-runtime-view). Follow the Copilot Studio [**Governance and security best practices overview**](/azure/microsoft-copilot-studio/guidance/sec-gov-intro). [Create and manage custom solutions](/azure/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) using pipelines. Consider creating [reusable component collections](/azure/microsoft-copilot-studio/authoring-export-import-copilot-components).
- **Azure AI Foundry:** Use the [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent) to test a range of different [attack strategies](/azure/ai-foundry/concepts/ai-red-teaming-agent#supported-attack-strategies). Follow the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) and [Secure networking](/azure/ai-foundry/how-to/configure-private-link) guidance. Enable [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) with Microsoft Defender for Cloud. Use [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project). Use evaluations in [GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) to create a CI/CD pipeline agents. [Work with Azure AI Foundry Agent Service using the Azure AI Foundry for Visual Studio Code extension.](/azure/ai-foundry/how-to/develop/vs-code-agents)

Determine how you will enforce these governance rules. Automation is ideal. Use Azure Policy, Microsoft Purview, Microsoft Defender for Cloud, CI/CD checks that scan prompts for banned content. Supplement with manual governance gates, like architecture review boards or compliance sign-offs at key milestones. Also, schedule **periodic audits**, perhaps quarterly, of agents in production to ensure they still comply with evolving policies and that their scope hasn’t unintentionally expanded.

## Microsoft facilitation

### Azure AI Foundry

1. Regulatory compliance: Govern hubs and projects with [Azure Policy definitions](/azure/ai-foundry/how-to/azure-policy) and enforce model deployment controls using [built-in policy for model deployment](/azure/ai-foundry/how-to/built-in-policy-model-deployment) while centrally administering quotas and access through the [Management center](/azure/ai-foundry/concepts/management-center).
2. Responsible AI (bias and safety): Apply [Content Safety in Azure AI Foundry](/azure/ai-foundry/ai-services/content-safety-overview) and tune policies via [content filtering guidance](/azure/ai-foundry/concepts/content-filtering) while scheduling continuous fairness and safety evaluations using [Continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).
3. Content filtering and red teaming: Execute adversarial assessments with the [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent) referencing supported [attack strategies](/azure/ai-foundry/concepts/ai-red-teaming-agent#supported-attack-strategies) and integrate those test cases into CI/CD evaluations using [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project).
4. Security review and baseline: Align infrastructure and service controls with the [Azure security baseline for Azure AI Foundry](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline) and enable layered defenses using [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) in Microsoft Defender for Cloud.
5. Secure networking and isolation: Restrict data exfiltration and enforce private access to models by configuring [Secure networking with Private Link](/azure/ai-foundry/how-to/configure-private-link) and validating egress rules during peer reviews.
6. Authentication and authorization: Assign least-privilege roles via [Role-based access control for Azure AI Foundry](/azure/ai-foundry/concepts/rbac-azure-ai-foundry?pivots=fdp-project) and rotate access boundaries during quarterly governance audits.
7. Incident response and resilience: Prepare rollback and continuity procedures using [Customer enabled disaster recovery](/azure/ai-foundry/how-to/disaster-recovery) and integrate proactive risk detection from [Risks and safety monitoring](/azure/ai-foundry/openai/how-to/risks-safety-monitor) to trigger containment workflows.
8. Observability and monitoring: Track model health and drift with [Monitor model deployments](/azure/ai-foundry/foundry-models/how-to/monitor-models) and application-level behaviors using [Monitor generative AI applications](/azure/ai-foundry/how-to/monitor-applications) while consolidating evaluation outputs through [continuous evaluation for agents](/azure/ai-foundry/how-to/continuous-evaluation-agents).
9. Secure development and CI/CD: Automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control.
10. Ongoing governance enforcement: Combine automated policy, red teaming, and monitoring signals (policy enforcement, evaluation drift, threat detection) with manual architecture review checkpoints to maintain conformance to the [security baseline](/azure/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline).
11. Threat modeling and prompt security: Incorporate adversarial prompt test cases defined in [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent) scenarios into regression suites to detect jailbreak attempts before production rollout.
12. Developer tooling and local productivity: Use the [Azure AI Foundry VS Code Agent development extension](/azure/ai-foundry/how-to/develop/vs-code-agents) to standardize local configuration, enforce policy compliance, and accelerate secure iteration.

### Microsoft Copilot Studio

1. Regulatory compliance: Confirm certifications and attestations using [Compliance (ISO, SOC, HIPAA) documentation](/azure/microsoft-copilot-studio/admin-certification) and align deployment regions with organizational residency requirements via [Data locations in Copilot Studio](/azure/microsoft-copilot-studio/data-location).
2. Responsible AI and content controls: Configure content moderation policies at ingestion and retrieval using [Knowledge sources content moderation](/azure/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) and document escalation behavior for unknown intents.
3. Governance framework: Apply structured guardrails following the [Governance and security best practices overview](/azure/microsoft-copilot-studio/guidance/sec-gov-intro) and map each agent to documented ownership and scope in your governance catalog.
4. Security scanning and runtime protection: Run pre-deployment assurance using the [Automatic security scan](/azure/microsoft-copilot-studio/security-scan) and continuously verify protections in production through the [Agent runtime protection status](/azure/microsoft-copilot-studio/security-agent-runtime-view) view.
5. Security configuration hardening: Review access, connectors, and environment boundaries against the consolidated [Security and governance guidance](/azure/microsoft-copilot-studio/security-and-governance) to minimize over-privileged operations.
6. Observability and change tracking: Audit configuration modifications, publishing events, and component updates through [Monitor logging and auditing](/azure/microsoft-copilot-studio/admin-logging-copilot-studio) and reconcile anomalies during scheduled reviews.
7. Reusable solution templates: Standardize lifecycle workflows using [Create and manage solution pipelines](/azure/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) to embed approval, testing, and security validation checkpoints.
8. Component reuse and consistency: Accelerate compliant scaling and reduce drift by organizing validated building blocks in [Reusable component collections](/azure/microsoft-copilot-studio/authoring-export-import-copilot-components) and enforcing version governance.
9. Lifecycle and change management: Coordinate feature evolution and deprecation decisions under the governance processes outlined in the [Governance and security best practices overview](/azure/microsoft-copilot-studio/guidance/sec-gov-intro) and ensure each material change passes security scan reassessment.
10. Continuous monitoring and drift detection: Reassess security posture and behavioral alignment periodically by correlating runtime protection insights from the [Agent runtime protection status](/azure/microsoft-copilot-studio/security-agent-runtime-view) with audit event streams from [logging and auditing](/azure/microsoft-copilot-studio/admin-logging-copilot-studio).
11. Operational readiness: Validate solution packaging and environment promotion paths using [Solution pipelines](/azure/microsoft-copilot-studio/authoring-solutions-overview#create-and-manage-solution-pipelines) while enforcing required compliance documentation updates at each release gate.
12. Ongoing governance enforcement: Consolidate evidence from security scans, moderation outcomes, and runtime protection into compliance reviews leveraging the [Governance and security best practices overview](/azure/microsoft-copilot-studio/guidance/sec-gov-intro) as the authoritative checklist.
