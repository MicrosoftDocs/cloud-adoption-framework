---
title: Process to build AI agents
description: Learn Process to build AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Process to build AI agents

This article provides a prescriptive framework for technical decision makers to guide workload teams in building AI agents using **Azure AI Foundry** and **Microsoft Copilot Studio**. AI agents are autonomous or semi-autonomous systems that answer questions, perform actions, or collaborate with other agents. Building them requires structured steps to prevent uncontrolled expansion, minimize risk, and optimize performance.

The guidance assumes governance and security controls are established. It focuses on how workload teams use platform capabilities at each phase while defining responsibilities between the enterprise platform and workload teams. This approach ensures predictable outcomes, cost efficiency, and compliance.

**Prerequisite:** Workload teams must use and apply the principles of the Well-Architected Framework. There’s AI guidance that covers:

- [Application Design](/azure/well-architected/ai/application-design)
- [Application Platform](/azure/well-architected/ai/application-platform)
- [Design Training Data](/azure/well-architected/ai/training-data-design)
- [Grounding Data](/azure/well-architected/ai/grounding-data-design)
- [Data Platform](/azure/well-architected/ai/data-platform)

## 1. Scope the agent

Start by requiring workload teams to document the agent’s purpose, limitations, and operational boundaries in a formal requirements document. Specify whether the agent only answers questions or also performs actions. Identify the domains of knowledge in scope to prevent uncontrolled expansion. For multi-agent systems, mandate distinct roles such as **Planner**, **Executor**, and **Reviewer**, and define their outputs and handoff protocols. This clarity prevents duplication and conflict, simplifies maintenance, and supports compliance audits.

**Azure AI Foundry:**

1. Use **Agent Service templates** to define scope and operational boundaries.
2. Configure roles and responsibilities for multi-agent systems in Foundry orchestration settings.
3. Store requirements in enterprise-managed repositories for auditability.

**Microsoft Copilot Studio:**

1. Use **Copilot Studio agent configuration** to define purpose and boundaries.
2. For multi-agent systems, set up **agent flows** with distinct roles and approval checkpoints.

## 2. Define agent instructions

Direct workload teams to create enforceable rules at the start of the instruction set. These rules define what the agent can and cannot do and include fallback behaviors such as responding with “I don’t know” when uncertain. Reinforce key guidance throughout instructions to minimize hallucinations and ensure predictable behavior. For critical operations, mandate human review for high-stakes decisions and external communications.

**Azure AI Foundry:**

1. Define **system messages** and **instruction sets** in the Agent Service configuration.
2. Use the [function calling tool](/azure/ai-foundry/agents/how-to/tools/function-calling?pivots=python) to enforce deterministic behaviors and fallback logic.
3. Configure **pause-and-review workflows** for critical outputs before execution.

**Microsoft Copilot Studio:**

1. [Orchestrate agent behavior with generative AI](/azure/microsoft-copilot-studio/advanced-generative-actions) to pause for human approval.
2. [Multistage and AI approvals in agent flows](/azure/microsoft-copilot-studio/flows-advanced-approvals), which are deterministic.
3. Apply custom instructions in the agent editor to reinforce compliance and fallback behaviors.

## 3. Choose models

Instruct workload teams to choose models aligned with task complexity rather than defaulting to the largest option. Smaller or domain-specific models often reduce cost and improve speed. Require early testing with sample prompts to validate accuracy before scaling. For multi-agent systems, tailor model selection to each role.

**Azure AI Foundry**

1. Use the [AI Foundry model catalog](https://ai.azure.com/explore/models) to find models.
2. Review the [model leaderboards in Azure AI Foundry](/azure/ai-foundry/concepts/model-benchmarks) for performance and cost trade-offs.
3. Configure [Model Router in Azure AI Foundry](/azure/ai-foundry/openai/concepts/model-router) for chat-based agents to optimize cost dynamically.

**Microsoft Copilot Studio.**

1. [Select a primary AI model for your agent](/azure/microsoft-copilot-studio/authoring-select-agent-model)
2. Connect to **Azure AI Foundry** to [Bring your own model for your prompts](/azure/ai-builder/byom-for-your-prompts).

## 4. Customize

Memory is a foundational capability for multi-turn and personalized interactions. Both Azure AI Foundry and Microsoft Copilot Studio offer built-in memory features that allow agents to retain context across sessions or within threads. Require structured testing cycles to refine prompts, instructions, memory behavior, and tool integrations. Mandate fairness and bias testing, validate content moderation, and include security tests for vulnerabilities such as prompt injection.

See Microsoft facilitation:

**Azure AI Foundry.**

1. Review [Threads, Runs, and Messages](/azure/ai-foundry/agents/concepts/threads-runs-messages) to refine instructions and orchestration.
2. Use the [Agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators) and Agent playground for iterative testing. Use the [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent) or red teaming scans [locally](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) or in [Azure](/azure/ai-foundry/how-to/develop/run-ai-red-teaming-cloud?tabs=python).
3. For persistent memory across threads, configure external stores like [Azure Cosmos DB](/azure/ai-foundry/agents/concepts/standard-agent-setup).

**Microsoft Copilot Studio**

1. [Test your agent](/azure/microsoft-copilot-studio/authoring-test-bot?tabs=webApp) using a test panel to see how the agent leads a customer through the conversation.
2. [Analyze conversational agent effectiveness](/azure/microsoft-copilot-studio/analytics-improve-agent-effectiveness).
3. [Analyze user questions by theme (preview)](/azure/microsoft-copilot-studio/analytics-themes)
4. [Use prompt modification to provide custom instructions to your agent](/azure/microsoft-copilot-studio/nlu-generative-answers-prompt-modification)

## 5. Add tools (knowledge and actions)

Have workload teams to integrate approved knowledge sources and action tools into AI agents. These integrations allow agents to answer questions accurately and automate tasks securely. The goal is to ensure workload teams follow enterprise governance policies while optimizing cost and minimizing risk.

### Knoweldge

Direct workload teams to connect only approved and validated knowledge sources to agents. This prevents uncontrolled access, reduces compliance risk, and ensures predictable behavior. Knowledge integration must follow least-privilege principles and include fallback logic for unknown queries.

**Azure AI Foundry**

1. Use [knowledge tools](/azure/ai-foundry/agents/how-to/tools/overview) to connect data to your agents.
2. Configure data isolation via the [standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup#project-level-data-isolation) for each project.
3. Configure [user’s identity or token](/azure/entra/architecture/authenticate-applications-and-users) during queries to enforce access controls.
4. Define fallback behavior in the agent’s response logic for cases where data is unavailable.

**Microsoft Copilot Studio**

1. Use [Knowledge sources](/azure/microsoft-copilot-studio/knowledge-copilot-studio) and [connectors](/azure/microsoft-copilot-studio/advanced-connectors) to ingest approved content.
2. [Protect sensitive data](/azure/microsoft-copilot-studio/security-and-governance) with data loss prevention policies, sensitivity labels, and access controls to protect sensitive data. [View sensitivity labels for SharePoint data sources.](/azure/microsoft-copilot-studio/sensitivity-label-copilot-studio)
3. [Extend agent capabilities](/azure/microsoft-copilot-studio/copilot-connectors-in-copilot-studio) using prebuilt or custom connectors to integrate documents, APIs, and databases.
4. Use [Editor and Viewer roles](/azure/microsoft-copilot-studio/admin-sharing-controls-limits) to restrict access and manage shared environments.
5. Rely on [automatically updates indexed content](/azure/microsoft-copilot-studio/knowledge-unstructured-data) for indexed knowledge sources to maintain accuracy.
6. Use default responses and instructions to handle unknowns gracefully.

### Actions

Enable agents to perform approved actions such as creating support tickets or scheduling meetings. These actions must align with governance policies and use least-privilege principles to minimize risk. Validate each action in isolation before production deployment and enforce detailed logging for compliance.

**Microsoft Copilot Studio:**

1. [Orchestrate agent behavior with generative AI](/azure/microsoft-copilot-studio/advanced-generative-actions)
2. You can use deterministic [Agent flows](/azure/microsoft-copilot-studio/flows-overview) to permit various agent actions.

**Azure AI Foundry:**

1. Use [Azure AI Foundry action tools](/azure/ai-foundry/agents/how-to/tools/overview#action-tools) to streamline workflows with your AI agent with capabilities to take actions.
2. Configure orchestration logic to confirm details before execution and log all actions for auditing.

## 6. Choose orchestration

For multi-agent systems, require workload teams to select orchestration methods that match complexity and team skills. Orchestration ensures agents collaborate securely and efficiently without uncontrolled peer-to-peer communication. Use authenticated protocols for agent-to-agent (A2A) exchanges and prohibit connections to unknown or internet-exposed agents.

**Azure AI Foundry**

1. Use [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns)
2. Use the [built-in orchestration](/azure/ai-foundry/agents/concepts/standard-agent-setup#step-by-step-provisioning-process) for standard enterprise scenarios with [connected agents](/azure/ai-foundry/agents/how-to/connected-agents?pivots=portal#example-building-a-modular-contract-review-agent-with-connected-agents).
3. For advanced needs, start with the [Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/). Otherwise, see [LangChain](/azure/ai-foundry/how-to/develop/langchain) and [LlamaInde](/azure/ai-foundry/how-to/develop/llama-index).

**Microsoft Copilot Studio**

1. [Add other agents](/azure/microsoft-copilot-studio/authoring-add-other-agents) for multi-agent systems.
2. [Orchestrate agent behavior with generative AI](/azure/microsoft-copilot-studio/advanced-generative-actions).
3. [Multistage and AI approvals in agent flows](/azure/microsoft-copilot-studio/flows-advanced-approvals)

## 7. Bring your own services (trust)

Workload teams will integrate using a **Bring Your Own (BYO)** approach as needed. Connect AI workloads to your infrastructure such as storage, networking, identity, and indexes.

**Microsoft facilitation:**

- **Azure AI Foundry:** Both standard setup configurations are designed to give you complete control over sensitive data by requiring the [use your own resources](/azure/ai-foundry/agents/how-to/use-your-own-resources), like Azure Storage, Azure AI Search, and Cosmos DB for thread storage.
- **Microsoft Copilot Studio:**

## 8. Configure observability

Direct workload teams to integrate observability tools early. Define key performance metrics such as responsiveness, throughput, and error rates. Instrument agents with telemetry for logs, metrics, and traces. Monitor dashboards for system-wide and individual performance. Configure anomaly alerts and tie them into DevOps workflows.

**Microsoft facilitation:**

- **Microsoft Copilot Studio:** [Use analytics](/azure/microsoft-copilot-studio/analytics-overview) to understand how well your agent is performing and to identify areas for improvement. For custom telemetry, [connect your Copilot Studio agent to Azure Application Insights](/azure/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry), and view telemetry in real-time.
- **Azure AI Foundry:** Use [Foundry evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/general-purpose-evaluators) to monitor and understand the behaviors of your agents. [Monitor](/azure/ai-foundry/agents/how-to/metrics) the Azure AI Foundry Agent Service. [View trace results](/azure/ai-foundry/how-to/develop/trace-agents-sdk) for agents you build on the platform. [Continuously Evaluate your AI agents.](/azure/ai-foundry/how-to/continuous-evaluation-agents) Evaluate your agents in [GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project). Conduct [AI red teaming](/azure/ai-foundry/concepts/ai-red-teaming-agent) on your AI agents before production [AI Red Teaming Agent](/azure/ai-foundry/concepts/ai-red-teaming-agent).

## Microsoft facilitation

Azure AI Foundry and Microsoft Copilot Studio provide distinct development paths for building production-ready AI agents. Azure AI Foundry offers code-first flexibility with full control over models, tools, and orchestration for complex enterprise scenarios. Microsoft Copilot Studio provides a low-code approach for rapid development with built-in governance, making it accessible to business users. Use Azure AI Foundry when you need maximum customization and programmatic control over agent behavior. Use Microsoft Copilot Studio when you need to enable business users to build governed agents quickly with enterprise-grade security.

### Azure AI Foundry

Azure AI Foundry provides a comprehensive platform for building, deploying, and managing production-ready AI agents with enterprise-grade security and full developer control. The platform supports the complete agent lifecycle from environment setup through continuous monitoring.

#### Scope the agent

To establish secure agent boundaries, [set up your agent environment](/azure/ai-foundry/agents/environment-setup) to create projects with basic or standard setup configurations. For enhanced data governance, [use the standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup) to store customer data in your own Azure resources with project-level data isolation.

#### Define agent instructions

Define clear operational rules by [configuring system messages and instruction sets](/azure/ai-foundry/agents/concepts/threads-runs-messages) to enforce agent boundaries and fallback behaviors. To implement deterministic logic, [use function calling tools](/azure/ai-foundry/agents/how-to/tools/function-calling) to enforce predictable behaviors and handle edge cases reliably.

#### Choose models

Select appropriate models by [exploring the AI Foundry model catalog](https://ai.azure.com/explore/models) to find models aligned with task complexity and cost requirements. Evaluate options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks) to compare performance and cost trade-offs. For chat-based agents, [configure Model Router](/azure/ai-foundry/openai/concepts/model-router) to dynamically optimize costs while maintaining quality.

#### Customize

Build context-aware agents by [reviewing threads, runs, and messages](/azure/ai-foundry/agents/concepts/threads-runs-messages) to understand conversation state management. Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators) in the agent playground. Validate security by [running AI red teaming scans](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) locally during development or [in the cloud](/azure/ai-foundry/how-to/develop/run-ai-red-teaming-cloud) for pre-deployment testing. For persistent memory, [configure external stores like Azure Cosmos DB](/azure/ai-foundry/agents/concepts/standard-agent-setup) to maintain context across threads.

#### Add tools (knowledge and actions)

Connect approved data sources using [knowledge tools](/azure/ai-foundry/agents/how-to/tools/overview) to enable agents to answer questions accurately. Secure access by [configuring project-level data isolation](/azure/ai-foundry/agents/concepts/standard-agent-setup#project-level-data-isolation). Enable automation using [action tools](/azure/ai-foundry/agents/how-to/tools/overview#action-tools) to perform tasks and streamline workflows.

#### Choose orchestration

Design multi-agent systems by [reviewing AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) to select the right coordination approach. Use [connected agents](/azure/ai-foundry/agents/how-to/connected-agents) for built-in orchestration in standard enterprise scenarios. For advanced customization, [explore the Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/) for custom orchestration logic.

#### Bring your own services (trust)

Maintain data sovereignty by [using your own resources](/azure/ai-foundry/agents/how-to/use-your-own-resources) like Azure Storage, Azure AI Search, and Cosmos DB for thread storage in standard setup configurations, ensuring compliance with organizational policies.

#### Configure observability

Monitor agent behavior using [Foundry evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/general-purpose-evaluators) to understand performance and quality. Track operational metrics by [monitoring the Agent Service](/azure/ai-foundry/agents/how-to/metrics). Debug execution by [viewing trace results](/azure/ai-foundry/how-to/develop/trace-agents-sdk) for detailed analysis. Implement production monitoring by [continuously evaluating agents](/azure/ai-foundry/how-to/continuous-evaluation-agents). Integrate quality checks in your deployment pipeline by [evaluating in GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops).

### Microsoft Copilot Studio

Microsoft Copilot Studio enables business users and developers to build enterprise-grade conversational agents using low-code tools with built-in governance and security controls.

#### Scope the agent

Define agent purpose and boundaries by [configuring agent settings](/microsoft-copilot-studio/authoring-first-bot) to establish operational scope. For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints to ensure controlled collaboration.

#### Define agent instructions

Configure agent behavior by [orchestrating with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to enable natural conversation flows and pause-and-review workflows. For critical operations, [use multistage and AI approvals](/microsoft-copilot-studio/flows-advanced-approvals) to enforce deterministic decision gates.

#### Choose models

Select optimal models by [choosing a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) from available options. Expand capabilities by [bringing your own model](/ai-builder/byom-for-your-prompts) to connect Azure AI Foundry models for specialized tasks.

#### Customize

Validate agent behavior by [testing in the test panel](/microsoft-copilot-studio/authoring-test-bot) to observe conversation flows. Improve performance by [analyzing agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Understand user needs by [analyzing questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns. Refine responses by [using prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification) to provide custom instructions.

#### Add tools (knowledge and actions)

Integrate content using [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) and [connectors](/microsoft-copilot-studio/advanced-connectors) to ground agent responses. Secure data by [protecting sensitive information](/microsoft-copilot-studio/security-and-governance) with data loss prevention policies and sensitivity labels. Ensure compliance by [viewing sensitivity labels](/microsoft-copilot-studio/sensitivity-label-copilot-studio) for SharePoint data sources. Expand functionality by [extending agent capabilities](/microsoft-copilot-studio/copilot-connectors-in-copilot-studio) with prebuilt or custom connectors. Enable autonomous actions by [orchestrating agent behavior](/microsoft-copilot-studio/advanced-generative-actions) to perform tasks without explicit user commands.

#### Choose orchestration

Build collaborative systems by [adding other agents](/microsoft-copilot-studio/authoring-add-other-agents) to delegate specialized tasks. Enable dynamic coordination by [orchestrating agent behavior with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to select the best actions based on context.

#### Bring your own services (trust)

Control access by [using Editor and Viewer roles](/microsoft-copilot-studio/admin-sharing-controls-limits) to restrict permissions and manage shared environments securely.

#### Configure observability

Track performance using [analytics](/microsoft-copilot-studio/analytics-overview) to understand agent effectiveness and identify improvement areas. Enable advanced monitoring by [connecting to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for custom telemetry and real-time diagnostics.