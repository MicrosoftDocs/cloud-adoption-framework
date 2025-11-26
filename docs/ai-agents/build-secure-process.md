---
title: Process to Build AI agents with Microsoft Foundry and Copilot Studio
ms.reviewer: ssumner
description: Learn how to build and secure AI agents using Microsoft Foundry and Microsoft Copilot Studio. Follow a strategic framework for consistent, governed development.
#customer intent: As an enterprise architect, I want to gain a clear understanding of the processes and decision-making involved in building AI agents across my organization—particularly within the Microsoft ecosystem—using Microsoft Foundry as the primary platform and Microsoft Copilot Studio as a complementary tool.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: article
ms.collection: ce-skilling-ai-copilot
---

# Process to build AI agents

This article establishes the framework to build AI agents consistently and securely across organizations. The five-step process addresses critical decision points in agent development: orchestration patterns, model selection trade-offs, data and tool integration standards, observability requirements, and security controls. By following this structured approach, organizations reduce deployment complexity, ensure regulatory compliance, and scale agent adoption while maintaining operational control.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram showing five steps to build agents: Orchestration, Models, Knowledge & Tools, Observability, Security. The center highlights Microsoft Foundry and Copilot Studio as two platforms for Microsoft Build." lightbox="./images/build-ai-agents.png" border="false":::

Without proper governance frameworks for AI agent development, organizations face fragmented implementations, inconsistent security postures, and compliance violations. Agents built without standardized processes create technical debt through duplicated efforts, incompatible architectures, and unmanaged proliferation of models and tools. This lack of coordination increases operational risk, drives up costs through inefficient resource utilization, and slows innovation as teams struggle to integrate disparate agent systems.

## Agent orchestration

Strategic orchestration decisions determine how agents coordinate work, integrate with existing systems, and scale across the enterprise. These choices affect development velocity, operational complexity, and the organization's ability to maintain control as agent adoption grows.

### Define the agent charter

**Create governance artifacts that document agent boundaries and business alignment.** The charter serves as the authoritative reference for what the agent system accomplishes and what it must avoid. This documentation prevents scope creep, ensures compliance teams understand system boundaries, and provides clear accountability when issues arise. Include system responsibilities that map to specific business objectives, agent roles that prevent functional overlap, and prohibited actions that establish compliance guardrails. Without clear charters, agents evolve beyond their intended scope, creating security vulnerabilities and regulatory exposure.

### Set up environment

**Establish standardized environments before development begins.** Platform selection drives your organization's ability to balance control with development speed. Choose Microsoft Foundry when you need programmatic control, custom orchestration patterns, and direct management of model deployments. Select Copilot Studio for rapid prototyping with SaaS integrations and when business users need to modify agent behavior without engineering support. This decision affects not just initial development but also long-term maintenance costs, integration complexity, and the skills your organization must develop. See [Technology plan](./technology-solutions-plan-strategy.md) for more detailed information.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [prompt-based agents](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry#types-of-agents) for rapid development. For [hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry) to choose your own agent framework on managed infrastructure. See the [AI workloads](/azure/well-architected/ai/) in WAF. For an enterprise environment, reference and modify the [AI landing zone](https://github.com/Azure/AI-Landing-Zones) deployment. See also [AI Ready](/azure/cloud-adoption-framework/scenarios/ai/ready) for Azure landing zone platform guidance.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use for SaaS integration and low-code extensibility. [Verify licensing](/microsoft-copilot-studio/requirements-licensing-subscriptions) and [configure environments](/microsoft-copilot-studio/environments-first-run-experience) to separate development, testing, and production workloads.

### Pick an orchestration strategy

Orchestration determines how agents coordinate, make decisions, and execute tasks. Select an orchestration pattern that balances complexity with control.

**Select an orchestration approach (Foundry only).** This guidance applies to PaaS environments. There are two primary approaches managed orchestration and agent frameworks. Choose your orchestration approach based on organizational capability and control requirements. Managed orchestration through Foundry Agent Service accelerates deployment and provides built-in security but limits customization and reduces transparency into decision-making processes. Agent frameworks like Microsoft Agent Framework and LangGraph offer complete control and multi-cloud flexibility but require significant engineering investment and ongoing maintenance. Your choice determines how quickly teams can deploy agents versus how much control you maintain over agent behavior and decision logic.

**Define orchestration patterns.** For multi-agent systems, decide whether to chain agents sequentially or implement parallel processing patterns. Sequential chaining simplifies debugging and provides clear accountability but increases latency. Parallel processing improves response times but requires sophisticated coordination mechanisms and error handling. See [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) in the Azure Architecture Center.

**Implement deterministic workflows.** Create deterministic sequences of agent operations using workflows in Foundry and Microsoft Agent Framework. Single agents use workflows for broader integration and governance. Multi-agent systems require workflows to control behavior rather than chaining via agents. Review workflow decision guidance for [single agents](./single-agent-multiple-agents.md#single-agent-workflows) and [multi-agent systems](./single-agent-multiple-agents.md#multi-agent-orchestration-and-workflows).

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [workflows](/azure/ai-foundry/agents/concepts/workflow?view=foundry) for visual, low-code design suitable for rapid prototyping.

:::image type="icon" source="./images/microsoft-agent-framework-icon.png"::: **Microsoft Agent Framework**: Use [workflows](/agent-framework/user-guide/workflows/overview) to implement orchestration patterns in code.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Set up agent flows](/microsoft-copilot-studio/flows-overview) for multi-agent systems with distinct roles and approval checkpoints. [Configure agent behavior](/microsoft-copilot-studio/advanced-generative-actions) by orchestrating with generative AI.

### Agent instructions

**Standardize agent instructions as configuration to ensure consistent behavior and compliance.** Instructions function as operational guardrails that shape every agent interaction. Treating instructions as code enables version control, peer review, and rollback capabilities when issues arise. Structure instructions to cover identity and tone for consistent user experience, scope and boundaries that explicitly state prohibited actions, tool integration mandates that specify required data sources, and citation requirements that ensure transparency in agent responses.

Communication protocols between agents require explicit standards. Use approved protocols such as [Agent-to-Agent (A2A)](/agent-framework/user-guide/agents/agent-types/a2a-agent) and Model Context Protocol (MCP) while prohibiting communication with unknown or internet-exposed agents. Structured formats like JSON improve accuracy and enable better error handling in multi-agent interactions.

Store all instructions in version-controlled systems to create auditable change histories and support collaborative editing. Build automated validation into workflows where secondary agents or evaluation scripts verify output accuracy and appropriate tone. This systematic approach prevents drift in agent behavior and maintains compliance as systems evolve.

| Guideline | Description |
|-----------|-------------|
| **Identity and tone** | Define how the agent presents itself to ensure consistent user experience. |
| **Scope and boundaries** | Explicitly state what the agent does and what it avoids (for example, "Do not access payroll systems"). |
| **Tool integrations** | Mandate specific tool usage. *Example: "You must use the [Tool Name] to answer questions. If the answer is not found, state 'I don't know'."* |
| **Citations** | Require citations for transparency. *Example: "Every answer must provide citations for using the [Tool Name]."* |

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [System message design](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering?view=foundry). Use the [A2A tool](/azure/ai-foundry/agents/how-to/tools/agent-to-agent?view=foundry&pivots=python) and [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds?view=foundry). Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry).

## Agent model selection strategy

Model selection directly affects cost, performance, and compliance across your agent fleet. Organizations that default to the largest available models face unnecessary costs and quota limitations that constrain scaling.

**Match model capabilities to task complexity.** Smaller, optimized models handle routine tasks like summarization efficiently while controlling costs and reducing latency. Reserve premium models for scenarios requiring complex reasoning or multi-step analysis where the value justifies higher costs. This tiered approach prevents budget overruns while ensuring critical workloads receive appropriate resources.

**Enforce quota and cost governance.** High-end models impose stricter rate limits that can interrupt service during peak loads. Diversify model usage across workloads to prevent single points of failure. Implement cost allocation tags to track spending by department and use case, enabling data-driven decisions about model investments.

**Mandate validation prior to deployment.** Small-scale testing with representative queries documents performance trade-offs and validates compliance with governance standards. This validation prevents costly mistakes where teams deploy expensive models for simple tasks or undersize models for complex requirements.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [model catalog](https://ai.azure.com/explore/models) and evaluate model options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks?view=foundry-classics) to compare performance and cost trade-offs. For productivity and action agents, use the [Model Router](/azure/ai-foundry/openai/concepts/model-router?view=foundry) to dynamically optimize costs while maintaining quality. Review models' [quotas and limits](/azure/ai-foundry/foundry-models/quotas-limits?view=foundry-classic).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) or [bring your own model](/ai-builder/byom-for-your-prompts) from Foundry.

## Agent knowledge and tools

Data access and tool permissions determine agent reliability, compliance posture, and operational risk. These policies establish boundaries that prevent unauthorized actions while enabling agents to deliver value. Follow all [data governance and compliance policies](./governance-security-across-organization.md#data-governance-and-compliance).

### Agent knowledge

**Segment knowledge by role to minimize data exposure.** Multi-agent systems require strict data boundaries where each agent accesses only information necessary for its function. This segmentation reduces attack surfaces and simplifies compliance audits by creating clear data access patterns. When agents connect to data sources, ensure retrieval occurs only from governed repositories with proper filtering and access controls. Review the [Data architecture for AI agents](./data-architecture-plan.md#data-retrieval-strategies-for-custom-agents) to align integration strategies with security requirements.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Connect agents to [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython) to combine multiple data sources behind an agentic retrieval engine while maintaining governance controls.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) to connect agents to approved information repositories and [connectors](/microsoft-copilot-studio/advanced-connectors) to integrate with enterprise systems securely.

### Agent tools

**Codify tool usage policies with explicit permissions and boundaries.** Agents performing actions like triggering workflows or modifying records require strict governance frameworks. Define in agent instructions when tools can be used, what confirmation steps are required, and which actions need human approval. For sensitive operations like password resets or financial transactions, mandate explicit user confirmation before execution. This confirmation prevents unintended actions and creates clear audit trails.

**Secure integration endpoints through API isolation.** Expose actions through narrowly scoped APIs rather than direct system access. Define structured input parameters that validate data types and ranges before execution. Apply least-privilege principles to credentials, ensuring tokens are scoped to specific actions with appropriate read or write permissions. This approach limits potential damage from compromised agents while maintaining operational flexibility.

**Require isolated testing for all agent actions.** Validate agent behavior in test environments that mirror production configurations but cannot affect real systems. Verify that actions perform as expected without side effects, test error handling when APIs fail or return unexpected results, and confirm audit logging captures all necessary details. Standardize action attribution by logging the initiating agent, specific operation performed, affected users or systems, and timestamp with correlation IDs for debugging.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [tools](/azure/ai-foundry/agents/concepts/tool-catalog?view=foundry) and [tool best practices](/azure/ai-foundry/agents/concepts/tool-best-practice?view=foundry). Use an [AI gateway](/azure/ai-foundry/agents/how-to/tools/governance?view=foundry) for tool governance.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Add tools](/microsoft-copilot-studio/advanced-plugin-actions) and [triggers](/microsoft-copilot-studio/authoring-triggers-about).

### Agent memory

**Implement memory controls that balance user experience with compliance requirements.** Agent memory enables natural conversations by retaining context across sessions, but this capability introduces data protection obligations. Store only minimum necessary information to support continuity while reducing exposure risk. Full conversation transcripts improve experience but complicate compliance with regulations like GDPR and HIPAA.

**Encrypt and protect stored context using enterprise standards.** Apply encryption at rest and in transit using approved algorithms. Implement role-based access control that restricts memory access based on business need. Enable comprehensive audit logging that tracks all read and write operations to stored conversations. These controls align agent adoption with risk management frameworks and support regulatory audits.

**Define retention and deletion policies aligned with regulatory requirements.** Establish clear timelines for data retention based on business needs and compliance obligations. Customer service agents might retain data for 90 days to support quality assurance, while healthcare agents must follow HIPAA retention rules. Automate deletion processes to ensure consistent enforcement without manual intervention.

**Validate behavior through rigorous testing.** Test memory functionality to confirm agents do not expose one user's data to another, validate defenses against prompt injection attacks targeting stored context, and verify performance in multi-thread scenarios. Include compliance checks in evaluation cycles to ensure memory usage meets regulatory standards.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [memory](/azure/ai-foundry/agents/concepts/agent-memory?view=foundry&tabs=python) to store conversations. For your own storage, see [standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup?view=foundry#leveraging-your-own-resources-for-storing-customer-data), [Azure Cosmos DB](/azure/ai-foundry/agents/how-to/use-your-own-resources?view=foundry#azure-cosmos-db-for-nosql-to-store-conversations), and [Azure Cosmos DB integration](/azure/cosmos-db/gen-ai/azure-agent-service).

:::image type="icon" source="./images/microsoft-agent-framework-icon.png"::: **Microsoft Agent Framework**: Use [serialization and deserialization](/agent-framework/user-guide/agents/multi-turn-conversation#agentthread-storage) of thread state and [agent memory](/agent-framework/user-guide/agents/agent-memory).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Analyze agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Review [user questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns and refine responses.

## Agent observability

Observability provides the visibility needed to maintain reliable agent operations, optimize performance, and ensure compliance with organizational standards. Early implementation of monitoring and telemetry enables proactive issue detection and continuous improvement.

:::image type="content" source="./images/observability-security-build-agents.png" alt-text="Diagram showing agent observability and security components: monitoring traces, metrics, and evaluations for agent health; guardrails and blocklists for input validation, tool calls, responses, and output filtering." lightbox="./images/observability-security-build-agents.png" border="false":::

**Implement comprehensive tracing across agent workflows.** Configure traces that capture execution paths, decision points, and interaction patterns. This visibility enables rapid diagnosis when agents produce unexpected results or experience performance degradation. Establish baselines for latency, cost per interaction, and success rates. Alert teams when metrics deviate from expected ranges to enable investigation before users notice issues.

**Standardize evaluation frameworks across your agent fleet.** Create shared evaluations that measure quality, safety, and reliability consistently. Store evaluations in a central catalog to ensure all teams apply the same standards. Integrate evaluations into CI/CD pipelines to catch issues before production deployment. This systematic approach prevents quality drift as agents evolve and new versions deploy.

**Extend security testing beyond traditional methods.** AI agents face unique threats that conventional security testing might miss. Implement dedicated AI red teaming that tests for prompt injection vulnerabilities, attempts to extract training data or system prompts, and validates guardrails against adversarial inputs. Regular security assessments ensure agents remain resilient as attack techniques evolve.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use the [Microsoft Foundry Control Plane](/azure/ai-foundry/control-plane/overview?view=foundry) for unified visibility and governance across your agent fleet.

- **Agents and workflows:** Configure [traces](/azure/ai-foundry/observability/concepts/trace-agent-concept?view=foundry) for execution visibility. Configure [monitoring](/azure/ai-foundry/agents/how-to/metrics?view=foundry) for Foundry instances and all projects. Use [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry) to measure quality. See [Agent Monitoring Dashboard](/azure/ai-foundry/agents/how-to/how-to-monitor-agents-dashboard?view=foundry).

- **Models:** [Monitor models](/azure/ai-foundry/foundry-models/how-to/monitor-models?view=foundry) and use [evaluations](/azure/ai-foundry/concepts/observability?view=foundry#what-are-evaluators) to measure AI response quality.

- **Evaluations:** Build and store evaluations in the [evaluator catalog](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry). Have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents?view=foundry). Integrate evaluations into CI/CD pipelines using [GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project). Use dedicated [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [analytics](/microsoft-copilot-studio/analytics-overview) and [connect to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for centralized telemetry. [Create test sets for evaluations](/microsoft-copilot-studio/analytics-agent-evaluation-create), [Security and governance guidance](/microsoft-copilot-studio/security-and-governance), [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view).

## Agent security

Security controls embedded throughout the agent lifecycle prevent harmful outputs, protect against attacks, and ensure compliance with organizational standards. These safeguards operate across multiple layers to create defense in depth.

**Deploy guardrails at multiple intervention points.** Effective guardrails operate throughout the interaction lifecycle rather than at a single checkpoint. Filter user inputs to block malicious prompts or sensitive data before processing. Validate tool calls to prevent injection attacks when agents interact with external systems. Inspect tool responses for compliance and safety before agents process the information. Apply content moderation and plagiarism checks to final outputs before delivery to users. This layered approach ensures no single failure point compromises the entire system.

**Maintain centralized blocklists for consistent enforcement.** Blocklists prevent prohibited terms, sensitive patterns, or unsafe content from entering or leaving the system. Centralize blocklist management to ensure all agents and models apply consistent standards. Update lists regularly based on emerging threats, new compliance requirements, and lessons learned from incidents. Combine static blocklists with dynamic detection methods to achieve comprehensive coverage while maintaining performance.

**Microsoft facilitation:**<br>
:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [Guardrails and control overview](/azure/ai-foundry/guardrails/guardrails-overview?view=foundry). Apply guardrails at different [intervention points](/azure/ai-foundry/guardrails/intervention-points?view=foundry&pivots=programming-language-foundry-portal). Use an [AI Gateway](/azure/ai-foundry/agents/how-to/ai-gateway?view=foundry) to control model endpoints and enforce secure access. Use Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection) and [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

## Next step

> [!div class="nextstepaction"]
> [Operate AI agents](./integrate-manage-operate.md)
