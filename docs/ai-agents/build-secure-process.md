---
title: Build AI Agents with Foundry and Copilot
ms.reviewer: ssumner
description: Learn how to build and secure AI agents using Foundry and Microsoft Copilot Studio. Follow a strategic framework for consistent, governed development.
#customer intent: As a technical decision maker, I want to understand the prerequisites for building AI agents so that I can establish a secure and well-governed foundation.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: article
ms.collection: ce-skilling-ai-copilot
---

# Build AI agents

This article provides a strategic framework for technical decision makers to build agents in Microsoft Foundry and Microsoft Copilot Studio. Use this guidance to establish standards and help your organization succeed with AI agents.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram showing five steps to build agents: Orchestration, Models, Knowledge & Tools, Observability, Security. The center highlights Microsoft Foundry and Copilot Studio as two platforms for Microsoft Build." lightbox="./images/build-ai-agents.png" border="false":::

## 1. Agent orchestration

Establish a strategic foundation before development begins. Enterprise architects must define system requirements, select technology platforms, and structure agent behavior to ensure agents deliver value while remaining secure and compliant.

### Set up environment

Standardize the environment and governance artifacts before building AI agents. Proper setup reduces deployment delays, ensures compliance, and simplifies scaling as agent adoption grows.

1.  **Define the Agent Charter.** Create a governance artifact that documents what the agent system does, how it supports business objectives, and what it must not do. The charter must specify:
    - **System responsibilities:** Identify what the solution accomplishes and how it advances business objectives.
    - **Agent roles:** Define what each agent does to prevent overlap and ensure accountability.
    - **Prohibited actions:** Specify what the system must not do to avoid compliance or security violations.

2.  **Select the technology platform.** Choose between Foundry, Copilot Studio, or custom frameworks based on control, ease of use, and integration needs. See [Technology plan](./technology-solutions-plan-strategy.md) for more information on platform selection.

**Microsoft facilitation:**

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use for scenarios requiring deep customization or pro-code control. Use [prompt-based agents](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry#types-of-agents) for rapid development or [hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry) for advanced orchestration. Apply the Well-Architected Framework principles for [AI workloads](/azure/well-architected/ai/) and start with the [AI landing zone](https://github.com/Azure/AI-Landing-Zones). See also [AI Ready](/azure/cloud-adoption-framework/scenarios/ai/ready) for general best practices.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**:  Use for SaaS integration and low-code extensibility. [Verify licensing](/microsoft-copilot-studio/requirements-licensing-subscriptions) and [configure environments](/microsoft-copilot-studio/environments-first-run-experience) to separate development, testing, and production workloads.

### Pick an orchestration strategy

Orchestration determines how agents coordinate, make decisions, and execute tasks. Select an orchestration pattern that balances complexity with control.

1. **Select an orchestration strategy.** Choose between managed services and custom frameworks based on organizational capability and requirements.

    - **Managed orchestration** (Foundry Agent Service) offers quick deployment, built-in security, and enterprise connectors, but limits customization and transparency.
    - **Agent frameworks** (Microsoft Agent Framework, LangGraph) provide complete control, full visibility, and multi-cloud flexibility but increase engineering effort.

2. **Select orchestration patterns.** For multi-agent systems you either chain agents together, which becomes See [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) in the Azure Architecture Center.

3. **Orchestration and workflows.** See workflow guidance for [single agents](./single-agent-multiple-agents.md#single-agent-workflows) and [multi-agent systems](./single-agent-multiple-agents.md#mutli-agent-orchestration-and-workflows).

**Microsoft facilitation:**

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [Workflows](/azure/ai-foundry/agents/concepts/workflow?view=foundry) for visual, low-code design suitable for rapid prototyping.

:::image type="icon" source="./images/microsoft-agent-framework-icon.png"::: **Microsoft Agent Framework**: Use code-first [workflows](/agent-framework/user-guide/workflows/overview) for complex, code-heavy scenarios requiring a pro-code environment.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Set up agent flows](/microsoft-copilot-studio/flows-overview) for multi-agent systems with distinct roles and approval checkpoints. [Configure agent behavior](/microsoft-copilot-studio/advanced-generative-actions) by orchestrating with generative AI.

### Agent instructions

Agent instructions act as operational guardrails that shape how agents respond, interact, and comply with organizational policies. Standardize these instructions to ensure consistency and regulatory alignment.

1.  **Structure instructions as configuration.** Treat agent instructions as code. Each agent requires complete guidelines covering:
    - **Identity and tone:** Define how the agent presents itself to ensure consistent user experience.
    - **Scope and boundaries:** Explicitly state what the agent does and what it avoids (for example, "Do not access payroll systems").
    - **Tool integrations:** Mandate specific tool usage. *Example: "You must use the [Tool Name] to answer questions. If the answer is not found, state 'I don't know'."*
    - **Citations:** Require citations for transparency. *Example: "Every answer must provide citations for using the [Tool Name]."*

2.  **Standardize communication protocols.** Use approved protocols such as [Agent-to-Agent (A2A)](/agent-framework/user-guide/agents/agent-types/a2a-agent) and Model Context Protocol (MCP) for interactions. Prohibit communication with unknown or internet-exposed agents to avoid security risks. Adopt structured formats like JSON for inter-agent communication to improve accuracy.

3.  **Implement version control.** Store all agent instructions in a version-controlled system such as GitHub. This creates an auditable history of changes, supports collaborative editing, and ensures teams reference approved instructions.

4.  **Validate behavior systematically.** Build automated validation into the workflow. When an agent produces output, verify it automatically using a second agent or evaluation script to check facts and tone.

**Microsoft facilitation:**
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [System message design](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering?view=foundry). Use the [A2A tool](/azure/ai-foundry/agents/how-to/tools/agent-to-agent?view=foundry&pivots=python) and [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds?view=foundry). Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry).

## 2. Agent model selection strategy

Define a strategy for model selection that balances performance, cost, and compliance. Do not default to the largest models. Instead, evaluate task complexity and establish standards that align model capabilities with specific requirements.

In multi-agent architectures, define policies for assigning distinct models to specific agents based on their roles. Use capable models for orchestration and reasoning while utilizing cost-effective models for routine execution. This tiered approach optimizes efficiency and ensures architectural cohesion.

1. **Match model capabilities to task complexity.** Establish guidelines that map workload types to appropriate model classes. Use smaller, optimized models for routine tasks like summarization to control costs and latency. Reserve premium models for high-value scenarios requiring complex reasoning or multi-step analysis.

2. **Enforce quota and cost governance.** High-end models impose stricter rate limits and higher costs. To prevent budget overruns and service interruptions, diversify model usage across workloads and restrict premium model allocation to tasks that justify the investment.

3. **Mandate validation prior to deployment.** Require small-scale testing with representative queries before standardizing on a model. This validation documents performance trade-offs and ensures the selected model complies with internal governance standards.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [model catalog](https://ai.azure.com/explore/models) and evaluate model options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks?view=foundry-classics) to compare performance and cost trade-offs. For productivity and action agents, use the [Model Router](/azure/ai-foundry/openai/concepts/model-router?view=foundry) to dynamically optimize costs while maintaining quality. Review models' [quotas and limits](/azure/ai-foundry/foundry-models/quotas-limits?view=foundry-classic).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) or [bring your own model](/ai-builder/byom-for-your-prompts) from Foundry.

## 3. Agent knowledge and tools

Organizations must define standards for how agents access data and perform actions. These policies determine the agent’s reliability, compliance posture, and operational risk. Follow all [**data governance and compliance policies**](./governance-security-across-organization.md#data-governance-and-compliance).

### Agent knowledge

Review the [Data architecture for AI agents](./data-architecture-plan.md) to align integration strategies with organizational security requirements.

1. **Segment knowledge by role.** In multi-agent systems, restrict data access based on the specific function of each agent. Segmentation reduces complexity and limits the potential exposure of sensitive information.

2. **Connect to governed data sources.** Ensure agents retrieve information only from approved, managed repositories. Avoid connecting agents to unstructured or unverified data lakes without proper filtering.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Connect agents to [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython) to combine multiple data sources behind an agentic retrieval engine while maintaining governance controls.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) to connect agents to approved information repositories and [connectors](/microsoft-copilot-studio/advanced-connectors) to integrate with enterprise systems securely.

### Agent tools

Agents performing tasks, such as triggering workflows or modifying records, require strict governance to prevent unauthorized system access. Define approved actions and secure the tools that execute them to ensure operations remain within compliance boundaries.

1. **Codify tool usage policies.** Explicitly define in the instructions when and how agents are permitted to use tools. Instructions must mandate that agents confirm action details and request user permission before execution to prevent unintended consequences.

2. **Mandate human approval for sensitive actions.** Specify when and how each agent uses tools. Most frameworks support tool definitions with usage instructions. For example, when a user requests a password reset, the agent calls the `ResetPassword` API with the username. The agent confirms action details and requests user permission before execution. This confirmation step prevents unintended actions and ensures agents act only when authorized.

3. **Secure integration endpoints.** Expose actions through narrowly scoped APIs rather than direct system access. Define structured input parameters to keep operations controlled and auditable.

4. **Restrict credential scope.** Apply least-privilege principles to agent credentials and tokens. Ensure tokens are scoped strictly to the required action (for example, read-only versus write access) to reduce misuse risk.

5. **Require isolated testing.** Mandate that all agent actions be validated in a test environment before deployment. Verify that actions perform as expected without side effects to prevent operational errors in production.

6. **Standardize action attribution.** Enforce detailed logging for every action, capturing the initiating agent, the specific operation, and the affected user. This attribution is essential for auditing, debugging, and accountability.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [tools](/azure/ai-foundry/agents/concepts/tool-catalog?view=foundry) and [tool best practices](/azure/ai-foundry/agents/concepts/tool-best-practice?view=foundry). Use an [AI gateway](/azure/ai-foundry/agents/how-to/tools/governance?view=foundry) for tool governance.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Add tools](/microsoft-copilot-studio/advanced-plugin-actions) and [triggers](/microsoft-copilot-studio/authoring-triggers-about).

### Agent memory

Agent memory supports continuity across sessions by retaining context from previous interactions. This capability improves user experience by reducing repetitive input and enabling more natural conversations. However, memory introduces data protection obligations that require explicit policies and technical controls.

Organizations must define what data agents retain, how long they store it, and who can access it. These decisions directly affect compliance with regulations such as GDPR and HIPAA, as well as the organization's broader risk posture.

1. **Store only necessary information.** Retain only the minimum data required to support agent continuity. Full conversation transcripts improve user experience but increase exposure risk and complicate compliance. When restoring context into new sessions, deserialize only safe and relevant data. Apply strict filtering and validation rules to prevent leakage of unrelated user information. This practice reduces the volume of sensitive data at rest and simplifies data subject access requests.

2. **Encrypt and protect stored context.** Encrypt all memory at rest and in transit using approved encryption standards. Apply role-based access control to restrict access to stored conversations based on business need. Enable audit logging to track all read and write operations. These controls align agent adoption with enterprise risk management and support compliance audits.

3. **Define retention and deletion policies.** Establish clear policies for how long agents retain conversational data. Align retention periods with business requirements and regulatory obligations. For example, customer service agents might retain session data for 90 days to support quality assurance, while agents handling health information must comply with stricter HIPAA retention rules. Automate deletion processes to ensure data removal occurs on schedule without manual intervention.

4. **Validate behavior through testing.** Agents that use memory or share context across threads require rigorous testing. Include compliance checks in evaluation cycles and validate defenses against prompt injection attacks that attempt to manipulate stored context. Test agent behavior in multi-thread scenarios to confirm fairness, security, and performance. Verify that agents do not expose one user's data to another when switching contexts or sessions.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [memory](/azure/ai-foundry/agents/concepts/agent-memory?view=foundry&tabs=python) to store conversations. For your own storage, see [standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup?view=foundry#leveraging-your-own-resources-for-storing-customer-data), [Azure Cosmos DB](/azure/ai-foundry/agents/how-to/use-your-own-resources?view=foundry#azure-cosmos-db-for-nosql-to-store-conversations), and [Azure Cosmos DB integration](/azure/cosmos-db/gen-ai/azure-agent-service).

:::image type="icon" source="./images/foundry-icon.png"::: **Microsoft Agent Framework**: Use [serialization and deserialization](/agent-framework/user-guide/agents/multi-turn-conversation#agentthread-storage) of thread state and [agent memory](/agent-framework/user-guide/agents/agent-memory).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Analyze agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Review [user questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns and refine responses.

## 4. Agent observability

Observability ensures agents operate reliably, meet performance expectations, and align with organizational standards. Implement monitoring and telemetry early to detect issues, optimize workflows, and maintain system health across your agent fleet.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram illustrating governance layers for agents and workflows. At the top, a box labeled Organizational Governance includes categories for Data Governance, Security, Observability, and Development, with tools such as Microsoft Purview, Azure Policy, Microsoft Defender, Azure Monitor, Microsoft Entra, and development frameworks like Microsoft Agent Framework, Foundry SDK, and MCP. Below, a second box labeled Government for Building and Operating Agents and Workflows is divided into two sections: Build Phase: Four boxes for Agents and Workflows, Models, Evaluations, and Guardrails, each governed and secured by corresponding tools. Operate Phase: Four boxes for Assets, Compliance, Quotas, and Administration, with tools supporting governance during operations.." lightbox="./images/governance-security.png" border="false":::

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use the [Microsoft Foundry Control Plane](/azure/ai-foundry/control-plane/overview?view=foundry) for unified visibility and governance across your agent fleet. 

1. **Agents and workflows.** Configure [traces](/azure/ai-foundry/observability/concepts/trace-agent-concept?view=foundry) for execution visibility to provide the context needed to diagnose issues and improve agent logic. Establish expected ranges for latency, cost, and success rates. Alert teams when agents operate outside these baselines to enable rapid investigation and remediation. Configure [monitoring](/azure/ai-foundry/agents/how-to/metrics?view=foundry) for Foundry instances and all projects Use [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry) to measure quality. See [Agent Monitoring Dashboard](/azure/ai-foundry/agents/how-to/how-to-monitor-agents-dashboard?view=foundry).

2. **Models.** [Monitor models](/azure/ai-foundry/foundry-models/how-to/monitor-models?view=foundry) and use [evaluations](/azure/ai-foundry/concepts/observability?view=foundry#what-are-evaluators) to measure the quality, safety, and reliability of AI responses from deployed models.

3. **Evaluations.** Create a shared set of [evaluations](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry) that apply consistent quality standards across all model deployments and agent versions. Build and store evaluations in the [evaluator catalog](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry). Have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents?view=foundry). Integrate evaluations into CI/CD pipelines using [GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project).Security testing must extend beyond traditional penetration tests. Teams can use dedicated [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [analytics](/microsoft-copilot-studio/analytics-overview) and [connect to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for centralized telemetry. [Create test sets for evaluations](/microsoft-copilot-studio/analytics-agent-evaluation-create), [Security and governance guidance](/microsoft-copilot-studio/security-and-governance), [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view).

## 5. Agent security

Security and governance ensure AI agents operate safely, consistently, and in compliance with organizational standards. These practices reduce risks such as data leakage, harmful outputs, and regulatory violations. Effective governance spans both the applications agents support and the platforms they run on, embedding safeguards into every layer of the solution.

1. **Guardrails.** Guardrails prevent harmful or inappropriate outputs and protect against input-based attacks. They should operate across the full interaction lifecycle. Recommended intervention points:

    - User input. Filter prompts to block malicious or sensitive requests before they reach the model.
    - Tool calls. Validate and sanitize data exchanged with external systems to prevent injection attacks.
    - Tool responses. Inspect outputs from integrated services for compliance and safety.
    - Final output. Apply content moderation and plagiarism checks before delivering responses to users.

    This layered approach reduces single points of failure and strengthens overall resilience.

2. **Blocklists.** Blocklists help enforce organizational standards by preventing prohibited terms, sensitive data patterns, or unsafe categories from entering or leaving the system. Maintain centralized blocklists for consistency across agents and models. Update lists regularly based on emerging threats and compliance requirements. Combine blocklists with dynamic detection methods for greater coverage.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [Guardrails and control overview](/azure/ai-foundry/guardrails/guardrails-overview?view=foundry). Apply guardrails at different [intervention points](/azure/ai-foundry/guardrails/intervention-points?view=foundry&pivots=programming-language-foundry-portal). Use an [AI Gateway](/azure/ai-foundry/agents/how-to/ai-gateway?view=foundry) to control model endpoints and enforce secure access. Use Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection) and [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

## Next step

> [!div class="nextstepaction"]
> [Operate AI agents](./integrate-manage-operate.md)
