---
title: Build and Secure AI Agents with Foundry and Copilot
ms.reviewer: ssumner
description: Learn how to build and secure AI agents using Foundry Agent Service and Microsoft Copilot Studio. Follow a strategic framework for consistent, governed development.
#customer intent: As a technical decision maker, I want to understand the prerequisites for building AI agents so that I can establish a secure and well-governed foundation.
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Build and secure AI agents

This article provides a strategic framework for technical decision makers to build agents in Foundry Agent Service and Microsoft Copilot Studio. Use this guidance to establish standards and help your organization succeed with AI agents.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram that shows how to build AI agents in Foundry and Microsoft Copilot Studio." lightbox="./images/build-ai-agents.png" border="false":::

## 1. Agent orchestration

Establish a strategic foundation before development begins. Define system requirements, select technology platforms, and structure agent behavior to ensure agents deliver value while remaining secure and compliant.

### 1.1 Define system requirements

Create an agent charter that documents what the agent system does, how it supports business objectives, and what it must not do. Your charter must specify:

- **System responsibilities**: Identify what the solution accomplishes and how it advances business objectives.
- **Single or multi-agent approach**: Single-agent systems offer simplicity. Multi-agent systems enable specialization but require complex orchestration.
- **Technology platform**: Choose between Foundry, Copilot Studio, or custom frameworks based on control, ease of use, and integration needs.
- **Agent roles**: Define what each agent does to prevent overlap and ensure accountability.
- **Prohibited actions**: Specify what the system must not do to avoid compliance or security violations.

Align the scope with business objectives and validate the charter with your Responsible AI, security, and operational teams before deployment.

### 1.2 Set up your environment

Establish a secure foundation before building AI agents. Proper environment setup reduces deployment delays and compliance violations. This investment also simplifies scaling as agent adoption grows across your organization. This foundation includes infrastructure, governance frameworks, and compliance controls that support reliable and scalable agent operations.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Start with the [AI landing zone](https://github.com/Azure/AI-Landing-Zones)reference architecture. It provides a tested baseline for infrastructure, governance, and compliance controls. Adopting this model reduces design complexity and ensures alignment with enterprise standards. Customize the landing zone to meet organizational requirements while maintaining consistency across environments. See also [Set up your Foundry environment](/azure/ai-foundry/agents/environment-setup?view=foundry). Use a [Bring Your Own (BYO)](/azure/ai-foundry/agents/how-to/use-your-own-resources?view=foundry) approach when connecting AI agents to existing infrastructure. This strategy keeps agents within established governance boundaries, ensuring compliance and cost optimization. BYO integration also supports continuity by leveraging existing security and monitoring frameworks. Isolated deployments create governance gaps and increase operational overhead. BYO integration aligns AI workloads with enterprise policies from day one.

- **Low-code approach with prompt-based agents**: Use [prompt-based agents](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry#types-of-agents) to build agents without extensive coding. This approach accelerates development and allows business stakeholders to participate in agent design.

- **Pro-code approach with hosted agents**: Use [hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry) for advanced scenarios that require custom orchestration logic and detailed control over agent behavior. Apply the Well-Architected Framework principles for [AI workloads](/azure/well-architected/ai/).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: First [verify licensing and access requirements](/microsoft-copilot-studio/requirements-licensing-subscriptions). Then [configure environments](/microsoft-copilot-studio/environments-first-run-experience) to separate development, testing, and production workloads.

### 1.3 Choose agent orchestration

Orchestration determines how agents coordinate, make decisions, and execute tasks. Single-agent setups simplify oversight and deliver reliable performance. The agent manages its own decision-making, selects appropriate tools, sequences actions, and remembers context.

Multi-agent systems distribute orchestration across specialized agents. Each agent focuses on specific tasks, uses relevant tools, and communicates with other agents to share information and coordinate actions. Structured orchestration prevents communication breakdowns, circular dependencies, and conflicting instructions.

Choose between two primary orchestration approaches:

| Approach | Benefits | Tradeoffs |
|----------|----------|-----------|
| **Managed orchestration** (Foundry Agent Service) | Quick deployment, built-in security, enterprise connectors | Limited customization, reduced transparency |
| **Agent orchestration frameworks** (Microsoft Agent Framework, LangGraph) | Complete control, full visibility, multi-cloud flexibility | Significant engineering effort, compliance responsibility |

Organizations that prioritize rapid deployment and built-in governance benefit from managed orchestration. Organizations that require advanced customization, multi-cloud flexibility, or deep integration with existing systems benefit from custom orchestration.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [Build a workflow](/azure/ai-foundry/agents/concepts/workflow?view=foundry). For hosted agents, see [Workflow orchestrations](/agent-framework/user-guide/workflows/orchestrations/overview) and [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints. [Configure agent behavior](/microsoft-copilot-studio/advanced-generative-actions) by orchestrating with generative AI. For critical operations, use [multistage and AI approvals](/microsoft-copilot-studio/flows-advanced-approvals) to enforce deterministic decision gates.

### 1.4 Define agent behavior

Agent instructions act as operational guardrails that shape how agents respond, interact, and comply with organizational policies. Well-defined behavior ensures consistency, regulatory alignment, and predictable outcomes across single-agent and multi-agent systems. Poorly structured instructions lead to compliance gaps, unclear responsibilities, and operational risk.

For **multi-agent systems**, role separation prevents conflicts and accelerates troubleshooting. For systems with multiple agents, define distinct roles such as Planner, Researcher, Executor, and Reviewer. Document what each role produces and how information flows between agents. This structure reduces duplication and improves accountability.

1. **Write clear, structured instructions**. Each agent requires complete guidelines covering these key areas:

    - **Identity and tone**: Describe how the agent presents itself and whether it uses conversational language or formal business terminology. Consistent tone helps users form accurate expectations about the interaction.
    
    - **Scope and boundaries**: Specify what the agent does and what it avoids. For example, an HR agent can answer benefits questions but must not access salary data or provide tax advice. Explicit boundaries protect against compliance violations.
    
    - **Tool integrations**: Add this to your agent to help it invoke the right tools: *You are a helpful assistant that MUST use the [name of the tool (Fabric IQ, Fabric data agent, GitHub MCP server)] to answer all the questions from user. you must never answer from your own knowledge under any circumstance. If you do not know the answer, or cannot find the answer in the provided Knowledge Base you MUST respond with "I don't know".*
    
    - **Citations.** If required, embed citation rules for transparency. This instruction works well with Azure OpenAI models: *Every answer must always provide citations for using the [Fabric IQ, Fabric data agent, GitHub MCP server] tool and render them as: "【message_idx:search_idx†source_name】"*
    
    - **Unknown situations**: Define fallback actions when the agent cannot answer, such as escalating to a human specialist or logging the request. This prevents dead ends and maintains user confidence.
    
    - **Compliance rules**: Embed organizational and regulatory requirements directly into instructions. This reduces manual oversight and ensures consistent adherence to policy.

2. **Use approved communication protocols**. Refer to [agent protocol governance](./governance-security.md#standardize-agent-protocols) and use approved protocols such as A2A and MCP for agent-to-agent interactions. Prohibit communication with unknown or internet-exposed agents to avoid security risks. Standard protocols safeguard data integrity and prevent unauthorized access.

3. **Define message formats**. Adopt structured formats like JSON for inter-agent communication. Include relevant context when passing queries between agents to improve accuracy and reduce errors.

4. **Set boundaries on conversations**. Restrict how many times agents can interact per task to prevent infinite loops and ensure timely resolution. These boundaries protect system resources and maintain user satisfaction.

5. **Build validation into every agent**. Quality control must be automatic and systematic. When an agent produces output, verify it automatically. For example, if an agent drafts a response, run it through a second agent that checks facts and tone. Allocate equal or greater effort to validation as you do to generation. This practice maintains quality standards and protects your brand reputation.

6. **Manage instructions with version control**. Store all agent instructions in a version-controlled system such as GitHub. Version control creates an auditable history of changes, supports collaborative editing, and ensures teams reference approved instructions. This practice supports compliance audits and reduces configuration errors.

Test instructions thoroughly before deployment to validate behavior against sample queries. Testing reveals gaps in instructions and prevents costly mistakes in production environments.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [System message design](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering?view=foundry) and [prompt engineering techniques](/azure/ai-foundry/openai/concepts/prompt-engineering?view=foundry). Use the [A2A tool](/azure/ai-foundry/agents/how-to/tools/agent-to-agent?view=foundry&pivots=python) and [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds?view=foundry). Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry). See [Foundry tool best practices](/azure/ai-foundry/agents/concepts/tool-best-practice?view=foundry).

In the Microsoft Agent Framework, see [A2A agents](/agent-framework/user-guide/agents/agent-types/a2a-agent).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints.

### 2. Agent model selection

Selecting the right model for each task is critical for balancing performance, cost, and compliance. Do not default to the largest or most expensive model. Instead, evaluate the complexity and importance of the task and choose a model that meets those requirements.

In **multi-agent systems**, each agent can use a different model. Assign models based on the agent’s role. Use a more capable model for interpreting user intent or orchestrating complex decisions. Use simpler models or rule-based logic for executing commands or performing predictable steps. This approach improves efficiency and ensures each agent contributes effectively to the overall system.

1. **Match model to task complexity.** Smaller models often deliver sufficient performance for internal workflows while reducing cost and latency. For routine tasks such as summarization, drafting, or FAQ-style responses, use models optimized for speed and cost. Reserve premium models for complex, high-value scenarios that require deep reasoning, multi-step analysis, or tool-rich workflows.

2. **Consider quotas and cost implications.** High-end models typically have stricter rate limits and higher costs. Using them for all tasks can lead to quota exhaustion and budget overruns. To optimize availability and cost:

    - Diversify model selection across workloads.
    - Use smaller models for routine or internal workflows.
    - Assign premium models only to tasks that justify their cost and latency.

3. **Validate choices through testing.** Before finalizing model selection, run small-scale tests with representative queries. Testing validates performance and cost trade-offs in real scenarios and supports governance by documenting model behavior and compliance with internal standards.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [model catalog](https://ai.azure.com/explore/models) and evaluate model options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks?view=foundry-classics) to compare performance and cost trade-offs. For productivity and action agents, use the [Model Router](/azure/ai-foundry/openai/concepts/model-router?view=foundry) to dynamically optimize costs while maintaining quality. Review models' [quotas and limits](/azure/ai-foundry/foundry-models/quotas-limits?view=foundry-classic).  

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) or [bring your own model](/ai-builder/byom-for-your-prompts) from Foundry.

### 3. Add knowledge and tools

To ensure AI agents operate securely, deliver accurate results, and align with business goals, organizations must define how agents access data and perform actions. This step shapes the agent’s reliability, compliance posture, and operational risk. It also determines how effectively agents contribute to business outcomes. **Follow all [data governance and compliance policies](./governance-security.md#data-governance-and-compliance).**

### 3.1 Add agent knowledge

Agents require access to validated information sources to answer questions and support decisions. Your organization must define which data sources agents access, how agents authenticate to those sources, and what happens when agents encounter information they cannot retrieve. These decisions directly affect agent reliability, security posture, and compliance with data governance policies.

Start by reviewing the [Data plan for AI agents](./data-plan.md) to understand the tradeoffs between different data integration approaches and to align agent knowledge with your organization's security and compliance requirements.

**Restrict agents to approved data sources.** Agents retrieve information only from validated and authorized repositories. For example, an HR agent references official policy documents and benefits guides but does not access payroll systems or confidential employee records. Public-facing agents use only publicly available information to prevent exposure of internal data. Verify all knowledge bases before deployment to confirm they contain no confidential or sensitive information.

**Apply least-privilege access to each agent.** Configure each agent to authenticate using managed identities with permissions scoped to specific tasks. Use Azure Role-Based Access Control (RBAC) to grant the minimum access necessary for the agent to perform its function. For example, an agent that retrieves product documentation has read-only access to a specific container or folder rather than broad permissions across storage accounts. Avoid assigning roles like "Reader" or "Contributor" unless the agent's responsibilities require that scope. Least-privilege access reduces the attack surface and limits potential damage if credentials become compromised.

**Define how agents respond to information gaps.** Agents encounter situations where they cannot find an answer or access a required resource. Establish a standard response for these scenarios. The agent acknowledges the limitation, provides a clear explanation, and suggests escalation to a human specialist. Log all instances where agents fail to retrieve information. This logging identifies gaps in knowledge coverage, highlights data access issues, and supports continuous improvement.

**Segment knowledge by agent role in multi-agent systems.** Assign each agent access to the knowledge sources relevant to its role. For example, a benefits agent accesses HR documentation while a technical support agent retrieves product manuals and troubleshooting guides. This segmentation reduces complexity, improves response accuracy, and limits the scope of access for each agent.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Connect agents to [Foundry IQ](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=foundry%2Cpython) to combine multiple data sources behind an agentic retrieval engine while maintaining governance controls.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) to connect agents to approved information repositories and [connectors](/microsoft-copilot-studio/advanced-connectors) to integrate with enterprise systems securely.

### 3.2 Agent tools for actions

Agents perform tasks such as creating support tickets, scheduling meetings, or triggering workflows. Organizations must define approved actions and secure the tools that execute them. This approach prevents unauthorized system access and ensures agents operate within business and compliance boundaries.

1. **Define tool usage in agent instructions.** Specify when and how each agent uses tools. Most frameworks support tool definitions with usage instructions. For example, when a user requests a password reset, the agent calls the `ResetPassword` API with the username. The agent confirms action details and requests user permission before execution. This confirmation step prevents unintended actions and ensures agents act only when authorized.

2. **Require human approval for sensitive actions.** Define when agents act independently and when they escalate to human support. Use business context to guide escalation rather than confidence scores alone. Allow agents to handle routine inquiries but escalate complex or sensitive issues. This approach balances efficiency with risk management and improves user satisfaction.

3. **Expose specific actions through secure APIs or connectors.** Provide narrowly scoped endpoints instead of broad system access. For example, expose a function like `createSupportTicket` with structured input parameters rather than allowing direct database access. This design keeps operations controlled and auditable.

4. **Apply least privilege to agent credentials and tokens.** Grant credentials or tokens the minimum permissions required for each action. If an agent creates tickets, its token must not delete them. If it sends emails, restrict it to a no-reply account. Scoped tokens reduce misuse risk and limit damage if credentials become compromised.

5. **Test agent actions in isolation before deployment.** Simulate each agent's action triggers in a test environment. Validate that the correct agent initiates the action, the action performs as expected, all required fields are populated, and no unintended side effects occur. Testing reveals gaps in logic and prevents costly errors in production.

6. **Log all actions with agent attribution.** Maintain detailed logs for every action, including which agent initiated it, what the action was, and who the action affected. For example, log that Agent C triggered a password reset for user X on behalf of user Y. This logging supports auditing, debugging, and accountability. Failed action logs identify improvement opportunities and inform agent refinement.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [tools](/azure/ai-foundry/agents/concepts/tool-catalog?view=foundry) and [tool best practices](/azure/ai-foundry/agents/concepts/tool-best-practice?view=foundry). Use an [AI gateway](/azure/ai-foundry/agents/how-to/tools/governance?view=foundry) for tool governance.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Add tools](/microsoft-copilot-studio/advanced-plugin-actions) and [triggers](/microsoft-copilot-studio/authoring-triggers-about).

### 3.3 Agent memory

Agent memory supports continuity across sessions by retaining context from previous interactions. This capability improves user experience by reducing repetitive input and enabling more natural conversations. However, memory introduces data protection obligations that require explicit policies and technical controls.

Organizations must define what data agents retain, how long they store it, and who can access it. These decisions directly affect compliance with regulations such as GDPR and HIPAA, as well as the organization's broader risk posture.

1. **Store only necessary information.** Retain only the minimum data required to support agent continuity. Full conversation transcripts improve user experience but increase exposure risk and complicate compliance. When restoring context into new sessions, deserialize only safe and relevant data. Apply strict filtering and validation rules to prevent leakage of unrelated user information. This practice reduces the volume of sensitive data at rest and simplifies data subject access requests.

2. **Encrypt and protect stored context.** Encrypt all memory at rest and in transit using approved encryption standards. Apply role-based access control to restrict access to stored conversations based on business need. Enable audit logging to track all read and write operations. These controls align agent adoption with enterprise risk management and support compliance audits.

3. **Define retention and deletion policies.** Establish clear policies for how long agents retain conversational data. Align retention periods with business requirements and regulatory obligations. For example, customer service agents might retain session data for 90 days to support quality assurance, while agents handling health information must comply with stricter HIPAA retention rules. Automate deletion processes to ensure data removal occurs on schedule without manual intervention.

4. **Validate behavior through testing.** Agents that use memory or share context across threads require rigorous testing. Include compliance checks in evaluation cycles and validate defenses against prompt injection attacks that attempt to manipulate stored context. Test agent behavior in multi-thread scenarios to confirm fairness, security, and performance. Verify that agents do not expose one user's data to another when switching contexts or sessions.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [memory](/azure/ai-foundry/agents/concepts/agent-memory?view=foundry&tabs=python) to store conversations. For your own storage, see [standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup?view=foundry#leveraging-your-own-resources-for-storing-customer-data), [Azure Cosmos DB](/azure/ai-foundry/agents/how-to/use-your-own-resources?view=foundry#azure-cosmos-db-for-nosql-to-store-conversations), and [Azure Cosmos DB integration](/azure/cosmos-db/gen-ai/azure-agent-service).

:::image type="icon" source="./images/foundry-icon.png"::: **Microsoft Agent Framework**: Use [serialization and deserialization](/agent-framework/user-guide/agents/multi-turn-conversation#agentthread-storage) of thread state and [agent memory](/agent-framework/user-guide/agents/agent-memory).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: [Analyze agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Review [user questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns and refine responses.

## 4. Observe and optimize

Observability ensures agents operate reliably, meet performance expectations, and align with organizational standards. Implement monitoring and telemetry early to detect issues, optimize workflows, and maintain system health across your agent fleet.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram that shows how to govern." lightbox="./images/governance-security.png" border="false":::

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use the [Microsoft Foundry Control Plane](/azure/ai-foundry/control-plane/overview?view=foundry) for unified visibility and governance across your agent fleet.

Define standards for collecting logs, metrics, and alerts from all agent instances. Send telemetry to centralized repositories such as Azure Log Analytics Workspace or storage accounts. This centralized approach enables enterprise visibility, supports compliance audits, and simplifies troubleshooting across teams. Configure [monitoring](/azure/ai-foundry/agents/how-to/metrics?view=foundry) for Foundry instances and all projects.

1. **User traces.** Track agent execution with complete visibility into inputs, outputs, tool usage, latencies, and costs. This telemetry reveals performance patterns, identifies optimization opportunities, and supports cost management. Configure [traces](/azure/ai-foundry/observability/concepts/trace-agent-concept?view=foundry) for execution visibility to provide the context needed to diagnose issues and improve agent logic. Establish expected ranges for latency, cost, and success rates. Alert teams when agents operate outside these baselines to enable rapid investigation and remediation. Use [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry) to measure quality. See [Agent Monitoring Dashboard](/azure/ai-foundry/agents/how-to/how-to-monitor-agents-dashboard?view=foundry).

2. **Use evaluations.** Create a shared set of evaluations that apply consistent quality standards across all model deployments and agent versions. Evaluations provide a structured way to assess how well AI agents perform and how safely they behave. These assessments use standardized metrics to compare different versions of an agent and determine which one best meets business needs. Leadership must ensure that evaluation practices become part of the organization's broader quality assurance strategy. Build and store evaluations in the [evaluator catalog](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators?view=foundry). Have teams use [continuous evaluation](https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/continuous-evaluation-agents?view=foundry). Integrate evaluations into CI/CD pipelines using [GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project).

3. **Conduct adversarial testing and red teaming.** Security testing must extend beyond traditional penetration tests. AI agents require specialized adversarial testing to simulate attacks that exploit their unique vulnerabilities. These tests include attempts to manipulate agent behavior through deceptive prompts or malicious inputs. Organizations must direct their teams to run these tests regularly and integrate them into release cycles. Teams can use dedicated [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: Use [analytics](/microsoft-copilot-studio/analytics-overview) and [connect to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for centralized telemetry. [Create test sets for evaluations](/microsoft-copilot-studio/analytics-agent-evaluation-create), [Security and governance guidance](/microsoft-copilot-studio/security-and-governance), [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view).

## 5. Security

Security and governance ensure AI agents operate safely, consistently, and in compliance with organizational standards. These practices reduce risks such as data leakage, harmful outputs, and regulatory violations. Effective governance spans both the applications agents support and the platforms they run on, embedding safeguards into every layer of the solution.

1. **Apply guardrails at multiple intervention points.** Guardrails prevent harmful or inappropriate outputs and protect against input-based attacks. They should operate across the full interaction lifecycle. Recommended intervention points:

    - User input. Filter prompts to block malicious or sensitive requests before they reach the model.
    - Tool calls. Validate and sanitize data exchanged with external systems to prevent injection attacks.
    - Tool responses. Inspect outputs from integrated services for compliance and safety.
    - Final output. Apply content moderation and plagiarism checks before delivering responses to users.

    This layered approach reduces single points of failure and strengthens overall resilience.

2. **Use blocklists and category filters.** Blocklists help enforce organizational standards by preventing prohibited terms, sensitive data patterns, or unsafe categories from entering or leaving the system. Maintain centralized blocklists for consistency across agents and models. Update lists regularly based on emerging threats and compliance requirements. Combine blocklists with dynamic detection methods for greater coverage.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [Guardrails and control overview](/azure/ai-foundry/guardrails/guardrails-overview?view=foundry). Apply guardrails at different [intervention points](/azure/ai-foundry/guardrails/intervention-points?view=foundry&pivots=programming-language-foundry-portal). Use an [AI Gateway](/azure/ai-foundry/agents/how-to/ai-gateway?view=foundry) to control model endpoints and enforce secure access. Use Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection) and [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

## Next step

> [!div class="nextstepaction"]
> [Integrate agents into business processes](./integrate.md)
