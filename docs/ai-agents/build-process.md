---
title: How to build AI agent
description: Learn How to build AI agent
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# How to build AI agents

This article provides a framework for technical decision makers to guide workload teams in building AI agents using **Azure AI Foundry** and **Microsoft Copilot Studio**.

## Prerequisites

To guide your teams in building AI agents with Azure AI Foundry and Microsoft Copilot Studio, you need to establish a clear foundation that supports secure, scalable, and well-governed development across your cloud estate. The prerequisites you outlined form the basis of that foundation. Here's how to interpret and act on them from a technical decision maker’s perspective:

:::image type="content" source="./images/agent-overview.png" alt-text="Diagram that shows how to agents work." lightbox="./images/agent-overview.png" border="false":::

1. **Understand how agents work.** AI agents are autonomous or semi-autonomous systems that answer questions, perform actions, or collaborate with other agents. They take an input in the form of system events (triggers), user messages (chats), or messages from other agents (multi-agent or agent-to-agents communication). Building them requires structured steps to prevent uncontrolled expansion, minimize risk, and optimize performance. An agent uses a generative AI model—typically a large language model—to interpret instructions and process incoming data from various tools. These instructions define the agent’s operational boundaries, specifying what actions it must take or avoid. To fulfill its role, the agent uses tools to gather knowledge, perform tasks, or retrieve memory. This tool interaction enables the agent to maintain context across conversations and support persistent engagement. After collecting the necessary information, the agent sends all relevant inputs to the language model, which generates an output. This output can take the form of a message to the user, a response to another agent, or a summary of the tool’s results and actions. This structure allows the agent to act autonomously while remaining aligned with enterprise goals, ensuring consistent and context-aware decision-making across systems.

1. **Set up your environment:** of you're building agents in **Azure AI Foundry** use the [application landing zone accelerator for Azure AI Foundry](https://github.com/Azure/AI-Landing-Zones). It's recommended that you start with an Azure landing zone to establish your platform landing zone. However, if you choose to build a custom platform, the application landing zone accelerator works without a platform landing zone. If you're building in **Microsoft Copilot Studio,** ensure you have [access to Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) and configure the Copilot Studio [environments](/microsoft-copilot-studio/environments-first-run-experience)  that align with your organization’s data boundaries and lifecycle management practices.

1. **Apply well-architected principles to AI workloads** The agent itself should be built upon the principles of the Well-Architected Framework (AF) for [AI workloads](/azure/well-architected/ai/). This framework helps your teams balance performance, reliability, security, and cost. As a decision maker, you must ensure that every agent initiative aligns with these principles.

## Agent build process

Organizations that adopt AI agents across their cloud environments must guide their teams through a structured build process. This process ensures agents operate reliably, comply with enterprise policies, and deliver measurable business outcomes. The following roadmap outlines key decisions and actions for technical leaders to direct their teams effectively.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram that shows how to agents work." lightbox="./images/build-ai-agents.png" border="false":::

### 1. Models

Avoid defaulting to the largest available model. Instead, instruct teams to select models that match the complexity and importance of each task. Smaller models often provide sufficient performance for internal workflows and reduce cost and latency.

For **multi-agent systems**, tailor model selection to each role. You might use a a large model for understanding queries but a smaller one or a rule-based system for executing structured tasks. Test a few models with sample queries in a small bake-off before settling.

In **Azure AI Foundry** use [the AI Foundry model catalog](https://ai.azure.com/explore/models) to find models aligned with task complexity and cost requirements. Evaluate options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks) to compare performance and cost trade-offs. For chat-based agents, [configure Model Router](/azure/ai-foundry/openai/concepts/model-router) to dynamically optimize costs while maintaining quality.

In **Microsoft Copilot Studio** [choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) from available options. You can [bring your own model](/ai-builder/byom-for-your-prompts) to connect Azure AI Foundry models for specialized tasks.

### 2. Customization

To ensure the agent delivers consistent, compliant, and business-aligned outcomes, define its customization parameters with precision. This section outlines how to scope the agent’s responsibilities, configure its behavior, and validate its performance across real-world scenarios. These steps help technical decision makers establish a reliable foundation for agent deployment, reduce operational risk, and support long-term scalability.

#### Scope the agent

Document the agent’s scope clearly. This agent charter must specify what the agent does and does not do. For example, an HR bot might answer policy questions and help schedule leave but must not provide legal advice or access payroll records. This clarity prevents scope creep and aligns stakeholders. Map the agent’s role within business processes. Define when users invoke the agent, what decisions it supports, and when it escalates to a human. This ensures the agent fits into real workflows and supports operational goals.

#### Define agent instructions

Direct workload teams to write the initial system prompts or instructions that set the behavior of the agent. This is effectively the policy the agent will follow in conversation. Include the following:

- **Agent identity and persona.** Define whether the agent is a helpful assistant, uses a formal tone, or has another style.
- **Capabilities and limitations.** Clarify what the agent can and cannot do. For example, state that it can search the policy database but does not have access to personal files. Specify that it should not answer questions unrelated to HR policies.
- **Handle uncertainties or refusals.** Explain how the agent should respond when unsure. For instance, it can say it will get back later or escalate to HR.
- **Compliance requirements.** Include rules such as not providing medical or legal advice and following privacy rules for personal data.

Essentially, treat the instructions as the specification for agent behavior. Test them out by running example prompts through Foundry’s test interface to see if the instructions yield the desired style of response. Iterate on wording as needed. Enforce key constraints repeatedly in the prompt to reduce the chance of the model ignoring them. For critical constraints, consider implementing them in code such as a final answer check that adds a disclaimer if needed.

For **multi-agent systems**, define distinct roles such as Planner, Executor, and Reviewer. Document the output each agent produces and how it transitions to the next agent. This clarity prevents duplication, reduces conflict, and simplifies maintenance. Always require structured outputs, such as JSON, to support downstream processing and compliance audits.

**Azure AI Foundry:** Define clear operational rules by [configuring system messages and instruction sets](/azure/ai-foundry/agents/concepts/threads-runs-messages) to enforce agent boundaries and fallback behaviors. To implement deterministic logic, [use function calling tools](/azure/ai-foundry/agents/how-to/tools/function-calling) to enforce predictable behaviors and handle edge cases reliably.

**Microsoft Copilot Studio:** Define agent purpose and boundaries by [configuring agent settings](/microsoft-copilot-studio/authoring-first-bot) to establish operational scope. For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints to ensure controlled collaboration.Apply custom instructions in the agent editor to reinforce compliance and fallback behaviors. Configure agent behavior by [orchestrating with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to enable natural conversation flows and pause-and-review workflows. For critical operations, [use multistage and AI approvals](/microsoft-copilot-studio/flows-advanced-approvals) to enforce deterministic decision gates.

#### Fine-tune and distill models

In Azure AI Foundry, review [threads, runs, and messages](/azure/ai-foundry/agents/concepts/threads-runs-messages) to understand conversation state management. Use the data in your threads to fine-tune and distill models
Memory is a foundational capability for multi-turn and personalized interactions. Both Azure AI Foundry and Microsoft Copilot Studio offer built-in memory features that allow agents to retain context across sessions or within threads. Require structured testing cycles to refine prompts, instructions, memory behavior, and tool integrations. Mandate fairness and bias testing, validate content moderation, and include security tests for vulnerabilities such as prompt injection.

**Azure AI Foundry:** Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators) in the agent playground. For persistent memory, [configure external stores like Azure Cosmos DB](/azure/ai-foundry/agents/concepts/standard-agent-setup) to maintain context across threads.

**Microsoft Copilot Studio:** Validate agent behavior by [testing in the test panel](/microsoft-copilot-studio/authoring-test-bot) to observe conversation flows. Improve performance by [analyzing agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Understand user needs by [analyzing questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns. Refine responses by [using prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification) to provide custom instructions.

### 3. Knowledge and tools

Have workload teams to integrate the connections to data sources (knowledge) and any action-taking abilities (tools) the agent needs. This is often where platform teams provide approved integrations. These integrations allow agents to answer questions accurately and automate tasks securely. The goal is to ensure workload teams follow enterprise governance policies while optimizing cost and minimizing risk.

1. **Add agent knowledge.** Direct workload teams to connect only approved and validated knowledge sources to agents. This prevents uncontrolled access, reduces compliance risk, and ensures predictable behavior. Knowledge integration must follow least-privilege principles and include fallback logic for unknown queries. For a retrieval-augmented agent, for example, you would index the relevant documents using Azure AI Search or a vector database for embeddings. Then the team writes the code for the agent to retrieve relevant docs when a query comes.

1. **Agent tools for actions.** Enable agents to perform approved actions such as creating support tickets or scheduling meetings. Identify which actions are allowed (create a ticket, send an email, trigger a workflow).Set up tool functions or APIs the agent can call securely. In Foundry, this could be function calls or custom tools with authentication. In Copilot Studio, it could be Power Automate flows or connectors where you map agent intents to actions.

**Azure AI Foundry:** Connect approved data sources using [knowledge tools](/azure/ai-foundry/agents/how-to/tools/overview) to enable agents to answer questions accurately. Secure access by [configuring project-level data isolation](/azure/ai-foundry/agents/concepts/standard-agent-setup#project-level-data-isolation). Enable automation using [action tools](/azure/ai-foundry/agents/how-to/tools/overview#action-tools) to perform tasks and streamline workflows.

**Microsoft Copilot Studio:** Integrate content using [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) and [connectors](/microsoft-copilot-studio/advanced-connectors) to ground agent responses. Secure data by [protecting sensitive information](/microsoft-copilot-studio/security-and-governance) with data loss prevention policies and sensitivity labels. Ensure compliance by [viewing sensitivity labels](/microsoft-copilot-studio/sensitivity-label-copilot-studio) for SharePoint data sources. Expand functionality by [extending agent capabilities](/microsoft-copilot-studio/copilot-connectors-in-copilot-studio) with prebuilt or custom connectors. Enable autonomous actions by [orchestrating agent behavior](/microsoft-copilot-studio/advanced-generative-actions) to perform tasks without explicit user commands. Rely on [automatically updates indexed content](/microsoft-copilot-studio/knowledge-unstructured-data) for indexed knowledge sources to maintain accuracy.

## 6. Choose orchestration

Multi-agent systems introduce operational complexity that requires structured coordination. Without orchestration, agents risk entering uncontrolled peer-to-peer communication, leading to loops, conflicts, or degraded performance. Orchestration defines how agents collaborate securely and efficiently, ensuring predictable outcomes and scalable behavior. To reduce risk and improve reliability, direct workload teams to select orchestration methods that match the complexity of the workload and the skill levels of the team. This approach minimizes rework and accelerates time-to-value.

**Azure AI Foundry:** [Use AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns). Use [connected agents](/azure/ai-foundry/agents/how-to/connected-agents) for built-in orchestration in standard enterprise scenarios. For advanced customization, use the [Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/) for custom orchestration logic.

**Microsoft Copilot Studio:** Build collaborative systems by [adding other agents](/microsoft-copilot-studio/authoring-add-other-agents) to delegate specialized tasks. Enable dynamic coordination by [orchestrating agent behavior with generative AI](/microsoft-copilot-studio/advanced-generative-actions) to select the best actions based on context.

## 5. Bring your own services (trust)

Workload teams will integrate using a **Bring Your Own (BYO)** approach as needed. Integrating AI workloads into existing infrastructure ensures compliance, security, and operational continuity. A Bring Your Own (BYO) approach allows organizations to connect agents to their own storage, identity systems, and routing logic. This approach allows you to implement structured memory systems. For example, you can combine short-term conversational buffers with long-term structured stores. Schedule summaries to maintain context without retaining raw personally identifiable information (PII). Have teams use vector stores for flexible and scalable memory, paired with databases for session logging. It allows you to design intelligent routing for cost and performance optimization. For example you can place a gateway in front of large language models (LLMs) to manage traffic. Route requests to low-cost models first and escalate based on confidence thresholds. Add failover mechanisms and semantic caching to improve reliability and reduce latency.

**Azure AI Foundry:** Maintain control by [using your own resources](/azure/ai-foundry/agents/how-to/use-your-own-resources) like Azure Storage, Azure AI Search, and Cosmos DB for thread storage in standard setup configurations, ensuring compliance with organizational policies.

## 6. Observability

The agent needs observability tools early. Define key performance metrics such as responsiveness, throughput, and error rates. Instrument agents with telemetry for logs, metrics, and traces. Monitor dashboards for system-wide and individual performance. Configure anomaly alerts and tie them into DevOps workflows.

**Azure AI Foundry:** Monitor agent behavior with [Foundry evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/general-purpose-evaluators) to understand performance and quality. Track operational metrics by [monitoring the Agent Service](/azure/ai-foundry/agents/how-to/metrics). Debug execution by [viewing trace results](/azure/ai-foundry/how-to/develop/trace-agents-sdk) for detailed analysis. Implement production monitoring by [continuously evaluating agents](/azure/ai-foundry/how-to/continuous-evaluation-agents). Integrate quality checks in your deployment pipeline by [evaluating in GitHub Actions](/azure/ai-foundry/how-to/evaluation-github-action) or [Azure DevOps](/azure/ai-foundry/how-to/evaluation-azure-devops). Validate security by [running AI red teaming scans](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) locally during development or [in the cloud](/azure/ai-foundry/how-to/develop/run-ai-red-teaming-cloud) for pre-deployment testing.

**Microsoft Copilot Studio:** Track performance using [analytics](/microsoft-copilot-studio/analytics-overview) to understand agent effectiveness and identify improvement areas. Enable advanced monitoring by [connecting to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for custom telemetry and real-time diagnostics.

## Next step

> [!div class="nextstepaction"]
> [Integrate agents](./deploy.md)