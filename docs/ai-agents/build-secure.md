---
title: How to build and secure AI agents
description: Learn How to build and secure AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# How to build and secure AI agents

This article outlines a strategic framework for technical decision makers to guide workload teams in building AI agents using Azure AI Foundry and Microsoft Copilot Studio. It focuses on establishing a secure, scalable, and well-governed foundation that supports consistent agent development across the cloud estate.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram that shows how to build AI agents in Azure AI Foundry and Microsoft Copilot Studio." lightbox="./images/build-ai-agents.png" border="false":::

## Prerequisites

Before directing teams to build AI agents, ensure the organization has the right environment and governance in place. These prerequisites help reduce risk, control cost, and accelerate time to value.

1. **Understand how agents work.** For more information, see [How agents work](./index.md#what-is-an-ai-agent).

1. **Set up your environment:** of you're building agents in **Azure AI Foundry**, you can reference the [application landing zone accelerator for Azure AI Foundry](https://github.com/Azure/AI-Landing-Zones). It's a proven starting point that you can refine to meet your needs. Application landing zone accelerator works with and without a an Azure landing zone. 

    If you're building in **Microsoft Copilot Studio,** ensure you have [access to Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) and configure the Copilot Studio [environments](/microsoft-copilot-studio/environments-first-run-experience)  that align with your organization’s data boundaries and lifecycle management practices.

1. **Apply well-architected principles to AI workloads** The agent itself should be built upon the principles of the Well-Architected Framework (AF) for [AI workloads](/azure/well-architected/ai/). This framework helps your teams balance performance, reliability, security, and cost. As a decision maker, you must ensure that every agent initiative aligns with these principles.

## Build and secure AI agents

Navigate a structured build process to ensure agents operate reliably, comply with enterprise policies, and deliver measurable business outcomes.

### 1. Choose models

Avoid defaulting to the largest available model. Instead, instruct teams to select models that match the complexity and importance of each task. Smaller models often provide sufficient performance for internal workflows and reduce cost and latency.

For **multi-agent systems**, tailor model selection to each role. You might use a a large model for understanding queries but a smaller one or a rule-based system for executing structured tasks. Test a few models with sample queries in a small bake-off before settling.

In **Azure AI Foundry** use [the AI Foundry model catalog](https://ai.azure.com/explore/models) to find models aligned with task complexity and cost requirements. Evaluate options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks) to compare performance and cost trade-offs. For chat-based agents, [configure Model Router](/azure/ai-foundry/openai/concepts/model-router) to dynamically optimize costs while maintaining quality.

In **Microsoft Copilot Studio** [choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) from available options. You can [bring your own model](/ai-builder/byom-for-your-prompts) to connect Azure AI Foundry models for specialized tasks.

### 2. Customization

Define agent behavior with precision to ensure consistent, compliant, and business-aligned outcomes.

#### 2.1 Scope the agent

Start by documenting what the agent does and what it does not do. This "agent charter" prevents scope creep and ensures alignment across teams. For example, an HR agent might answer policy questions and help schedule leave, but must not access payroll records or offer legal advice. Clarify when and how users interact with the agent, what decisions it supports, and when it escalates to a human. This helps the agent fit into real workflows and ensures it supports your operations.

#### 2.2 Define agent instructions

Treat the agent’s instructions like a policy document. These instructions guide how the agent responds in conversation. Include:

- **Identity and persona.** Define whether the agent is a helpful assistant, uses a formal tone, or has another style.
- **Capabilities and limitations.** Clarify what the agent can and cannot do. For example, state that it can search the policy database but does not have access to personal files. Specify that it should not answer questions unrelated to HR policies.
- **Handle uncertainties or refusals.** Explain how the agent should respond when unsure. For instance, it can say it will get back later or escalate to HR. Define fallback behaviors, such as escalating to a human or deferring a response.
- **Compliance requirements.** Include rules such as not providing medical or legal advice and following privacy rules for personal data.

Essentially, treat the instructions as the specification for agent behavior. Test them out by running example prompts through Foundry’s test interface to see if the instructions yield the desired style of response. Iterate on wording as needed. Enforce key constraints repeatedly in the prompt to reduce the chance of the model ignoring them. For critical constraints, consider implementing them in code such as a final answer check that adds a disclaimer if needed.

For **multi-agent systems**, define distinct roles such as Planner, Executor, and Reviewer. Document the output each agent produces and how it transitions to the next agent. This clarity prevents duplication, reduces conflict, and simplifies maintenance. Always require structured outputs, such as JSON, to support downstream processing and compliance audits.

**Azure AI Foundry:** Define clear operational rules by [configuring system messages and instruction sets](/azure/ai-foundry/agents/concepts/threads-runs-messages) to enforce agent boundaries and fallback behaviors. To implement deterministic logic, [use function calling tools](/azure/ai-foundry/agents/how-to/tools/function-calling) to enforce predictable behaviors and handle edge cases reliably.

**Microsoft Copilot Studio:** Define agent purpose and boundaries by [configuring agent settings](/microsoft-copilot-studio/authoring-first-bot) to establish operational scope. For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints to ensure controlled collaboration.Apply custom instructions in the agent editor to reinforce compliance and fallback behaviors. Configure agent behavior by [orchestrating with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to enable natural conversation flows and pause-and-review workflows. For critical operations, [use multistage and AI approvals](/microsoft-copilot-studio/flows-advanced-approvals) to enforce deterministic decision gates.

#### 2.3 Fine-tune and distill models

Use built-in memory features to help agents retain context across sessions. This supports more personalized and efficient interactions. Review conversation data to fine-tune prompts, instructions, and tool integrations.
Run structured testing cycles to validate fairness, bias, and security. For example, test for vulnerabilities like prompt injection. Use analytics tools to understand user needs and improve agent effectiveness.

**Azure AI Foundry:** review [threads, runs, and messages](/azure/ai-foundry/agents/concepts/threads-runs-messages) to understand conversation state management. Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators) in the agent playground. For persistent memory, [configure external stores like Azure Cosmos DB](/azure/ai-foundry/agents/concepts/standard-agent-setup) to maintain context across threads.

**Microsoft Copilot Studio:** Validate agent behavior by [testing in the test panel](/microsoft-copilot-studio/authoring-test-bot) to observe conversation flows. Improve performance by [analyzing agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Understand user needs by [analyzing questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns. Refine responses by [using prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification) to provide custom instructions.

### 3. Add knowledge and tools

To ensure AI agents operate securely, accurately, and in alignment with business goals, technical decision makers must direct their teams to integrate knowledge and tools in a controlled and governed manner. This step defines how agents access data and perform actions, which impacts their usefulness, compliance posture, and operational risk.

1. **Add agent knowledge.** Agents must only use validated and approved data sources. This prevents unauthorized access, reduces compliance exposure, and ensures consistent, predictable responses. For example, when an agent answers HR or policy questions, it should only pull from officially sanctioned documents such as those indexed in Azure AI Search or stored in a vector database with enterprise embeddings. To maintain control, enforce least-privilege access. This means agents should only access the minimum data required to perform their role. Also, require fallback logic for unknown or ambiguous queries. If the agent cannot find a reliable answer, it should escalate or defer rather than guess. This approach supports both accuracy and auditability, which are essential for regulated environments or customer-facing use cases.

1. **Agent tools for actions.** Agents often need to do more than answer questions they must also take action. This includes tasks like creating support tickets, scheduling meetings, or triggering workflows. To support this, define a clear list of approved actions and ensure each one maps to a secure, authenticated tool or API. These tools must follow enterprise security policies, including identity management and data protection standards. This structure allows agents to automate routine tasks while maintaining control and traceability.

By standardizing how agents access knowledge and tools, you reduce duplication and simplify maintenance. This also allows platform teams to reuse integrations across multiple agents, which lowers operational costs and accelerates deployment timelines. For example, a single connector to a ticketing system can support multiple agents across IT, HR, and facilities. Similarly, a shared knowledge base for company policies can serve agents in different departments.

Follow governance policies when integrating knowledge and tools. This includes:

- Using project-level data isolation to prevent cross-contamination of sensitive data
- Applying data loss prevention (DLP) policies and sensitivity labels to protect information
- Requiring structured outputs (such as JSON) to support downstream processing and compliance audits
- Validating all integrations through security reviews and testing cycles

These practices reduce the risk of data leakage, unauthorized actions, or unpredictable behavior.

**Azure AI Foundry:** Use [**knowledge** tools](/azure/ai-foundry/agents/how-to/tools/overview) and enable **actions** using [action tools](/azure/ai-foundry/agents/how-to/tools/overview#action-tools) to perform tasks and streamline workflows.

**Microsoft Copilot Studio:** Integrate [**knowledge** sources](/microsoft-copilot-studio/knowledge-copilot-studio) and consider [connectors](/microsoft-copilot-studio/advanced-connectors). Enable actions by [orchestrating agent behavior](/microsoft-copilot-studio/advanced-generative-actions).

## 4. Determine orchestration

Agent orchestration is the structured coordination of agents to achieve goals by managing how they interact with tools, knowledge sources, and memory. In a single-agent context, orchestration means internally deciding which tools to call, in what sequence, and how to merge results while maintaining context essentially acting as a hub that queries data, takes actions, and integrates short- and long-term memory.

**Multi-agent systems** have distributed orchestration: agents specialize in different tasks, call their own tools, and communicate to share context, resolve conflicts, and synchronize actions. When agents also interact with each other while making tool calls, orchestration involves negotiation, delegation, and collaboration protocols to ensure consistency and efficiency. Memory integration underpins all of this, enabling continuity, personalization, and shared state across agents and tools. In short, orchestration is the “conductor” that harmonizes tool usage, knowledge retrieval, and inter-agent collaboration into a coherent workflow. Without orchestration, agents risk entering uncontrolled peer-to-peer communication, leading to loops, conflicts, or degraded performance. Orchestration defines how agents collaborate securely and efficiently, ensuring predictable outcomes and scalable behavior. To reduce risk and improve reliability, select orchestration methods that match the complexity of the workload and the skill levels of the team. This approach minimizes rework and accelerates time-to-value.

**Azure AI Foundry:** For multi-agent systems, [use AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns). Use [connected agents](/azure/ai-foundry/agents/how-to/connected-agents) for built-in orchestration in standard enterprise scenarios. For advanced customization, use the [Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/) for custom orchestration logic.

**Microsoft Copilot Studio:** Build collaborative systems by [adding other agents](/microsoft-copilot-studio/authoring-add-other-agents) to delegate specialized tasks. Enable dynamic coordination by [orchestrating agent behavior with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to select the best actions based on context.

## 5. Protect and govern

To ensure agents operate safely and consistently, organizations must establish governance practices that span both the applications agents support and the platforms they run on.

### 5.1 Use evaluations

AI agents must meet business expectations for performance and safety. To achieve this, organizations need structured evaluation processes:

- **Use continuous evaluations.** Evaluations provide a structured way to assess how well AI agents perform and how safely they behave. These assessments use standardized metrics to compare different versions of an agent and determine which one best meets business needs. Leadership must ensure that evaluation practices become part of the organization's broader quality assurance strategy. By requiring automated safety and performance checks before deployment, organizations reduce the risk of releasing agents that behave unpredictably or expose sensitive data.

- **Conduct adversarial testing and red teaming.** Security testing must extend beyond traditional penetration tests. AI agents require specialized adversarial testing to simulate attacks that exploit their unique vulnerabilities. These tests include attempts to manipulate agent behavior through deceptive prompts or malicious inputs. Organizations must direct their teams to run these tests regularly and integrate them into release cycles.

For **Azure AI Foundry**, have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents). They should automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control. Teams can use dedicated [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues.

For  **Microsoft Copilot Studio**, use the  [Security and governance guidance](/microsoft-copilot-studio/security-and-governance), [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view).

### 5.2 Implement guardrails and controls

To prevent harmful or inappropriate outputs at the agent level, the agent must use input and output filters:

1. [**Content filtering**](/azure/ai-foundry/concepts/content-filtering) that scans both user prompts and agent responses for harmful content.
1. [**Blocklist**](/azure/ai-foundry/openai/how-to/use-blocklists?tabs=api) that restrict specific terms or phrases from appearing in agent interactions.
1. **Security recommendations** from Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection).
1. **Data controls** from Microsoft Purview that apply sensitivity labels and enforce data governance policies.

Leadership must ensure these controls align with existing data protection and compliance frameworks. By embedding these safeguards into the agent platform, organizations reduce the risk of reputational damage and regulatory violations.

### 5.3 Detect risks and set alerts

Security alerts become more actionable when they include context about the user and the application involved. For example, adding user identity or IP address helps security teams block malicious actors or trace incidents. Including application context allows teams to distinguish between suspicious behavior and normal operations.

Direct teams to enrich AI-related alerts with both user and application context. This practice improves incident response and supports more accurate threat prioritization. See [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

### 5.4 Bring your own resources

To maintain trust, security, and operational continuity across your cloud estate, you can Bring Your Own (BYO) approach when integrating AI agents with enterprise infrastructure. This strategy ensures agents operate within your organization’s governance boundaries while optimizing performance and cost.

Connecting agents to your existing systems such as storage, identity, and routing, ensures they follow your organization’s security and compliance policies. This includes using your own Azure Storage, Cosmos DB, or Azure AI Search to manage agent memory and data access. By doing so, you retain control over where data resides, how it is accessed, and who can audit it. This approach also supports structured memory design. For example, your teams can combine short-term conversational buffers with long-term structured stores to maintain context without retaining raw personally identifiable information (PII). This supports privacy compliance while enabling agents to deliver personalized and coherent responses.

Ensure the BYO approach integrates seamlessly with your broader architecture. This includes aligning with identity systems for authentication, using approved APIs for tool access, and enforcing data isolation policies across projects. These measures reduce risk and simplify compliance audits.

**Azure AI Foundry:** Maintain control by [using your own resources](/azure/ai-foundry/agents/how-to/use-your-own-resources) like Azure Storage, Azure AI Search, and Cosmos DB for thread storage in standard setup configurations, ensuring compliance with organizational policies.

## 6. Observe and optimize

The agent needs observability tools early. Capture key performance metrics such as responsiveness, throughput, and error rates. Instrument agents with telemetry for logs, metrics, and traces and send to a central analytics workspace as needed. Monitor dashboards for system-wide and individual performance. Set up dashboards that visualize system-wide and agent-specific metrics. These dashboards help decision makers and operations teams identify trends, spot bottlenecks, and prioritize improvements. Configure anomaly alerts to detect unusual behavior such as spikes in error rates or latency and tie these alerts into DevOps workflows for rapid response.

To improve agent performance and reliability, organizations must monitor how agents behave in real-world scenarios:

- **[Use traces](/azure/ai-foundry/how-to/develop/trace-agents-sdk)**: Capture the journey of a request through the application. This includes function calls, values, and system events.
- **[Review threads](/azure/ai-foundry/agents/concepts/threads-runs-messages#threads)**: Threads show how agents process instructions and help teams refine agent logic.
- **[Monitor applications](/azure/ai-foundry/how-to/monitor-applications)**: Track analyze, and optimize your application’s performance and operational health in real time.
- **[Monitor models](/azure/ai-foundry/foundry-models/how-to/monitor-models)**: Get metrics on your model deployments such as a total requests, total token count (prompt tokens + completion tokens).

**Azure AI Foundry:** [Monitor the Agent Service](/azure/ai-foundry/agents/how-to/metrics).

**Microsoft Copilot Studio:** Use [analytics](/microsoft-copilot-studio/analytics-overview) and [connect to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for custom telemetry.

## Next step

> [!div class="nextstepaction"]
> [Integrate agents into business processes](./integrate.md)
