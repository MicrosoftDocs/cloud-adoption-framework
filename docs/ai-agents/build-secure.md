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

This article outlines a strategic framework for technical decision makers to understand the process, decisions, and best practices required to build agents in **Foundry Agent Service** and **Microsoft Copilot Studio**, so you can lead your teams and organization and set standards that help your business be successful with AI agents.

:::image type="content" source="./images/build-ai-agents.png" alt-text="Diagram that shows how to build AI agents in Foundry and Microsoft Copilot Studio." lightbox="./images/build-ai-agents.png" border="false":::
## 1. Agent orchestration

Business leaders must establish a strategic foundation for AI agents before development begins. This section guides you through defining system requirements, selecting technology platforms, and structuring agent behavior to ensure agents deliver value while remaining secure and compliant.

### 1.1 Define the system requirements

Your organization needs clear boundaries and responsibilities for AI agents. Create an agent charter that documents what the agent system does, how it supports business objectives, and what it must not do. This charter becomes your governance foundation and helps you make informed decisions about agent scope and capabilities.

Your agent charter should specify:

- **System responsibilities**: What the overall solution accomplishes and how it advances your business objectives.
- **Single or multi-agent approach**: Single-agent systems offer simplicity and lower operational overhead. Multi-agent systems enable specialization and scalability but require more complex orchestration. Choose based on your business needs. See [Single or multi-agent system?](./single-multi-agent-systems.md).
- **Technology platform**: Foundry, Copilot Studio, or Azure virtual machines each offer different tradeoffs between control, ease of use, and integration capabilities.
- **Agent type**: Productivity agents answer questions and provide information. Action agents perform tasks like creating tickets or scheduling meetings. Autonomous agents operate independently within defined boundaries. See [What is an AI agent?](./index.md#what-is-an-ai-agent).
- **Agent role or roles**: Define what each agent does. Clear role definition prevents overlap and ensures accountability.
- **Prohibited actions**: Specify what the system must not do to avoid compliance or security violations. Organizations that define prohibited actions upfront reduce regulatory risk and prevent costly incidents.
- **Workflow integration**: Confirm how the system fits into existing business processes. Integration into established workflows accelerates adoption and improves return on investment. See [Workflow concepts](/azure/ai-foundry/agents/concepts/workflow?view=foundry#workflow-concepts).

For example, an HR agent can answer policy questions and assist with scheduling leave requests. The agent must not access payroll records or provide legal advice. These boundary rules protect sensitive data and prevent regulatory breaches.

Include these interaction details in your charter:

- **Interaction points**: Identify where users engage with the agent such as Teams or a web portal. Choose interaction points where employees already work to maximize adoption.
- **Decision support**: Specify which decisions the agent informs and which remain under human control. Keep humans in control of high-stakes decisions to maintain accountability and reduce risk.
- **Escalation rules**: Define when the agent transfers issues to a human and describe the escalation process. Clear escalation rules ensure complex issues receive appropriate expertise while routine questions get immediate answers.

**Apply these best practices for scoping**:

- **Align with business objectives**: Confirm that the scope supports your strategic priorities and compliance obligations. Agents that align with business goals achieve measurable return on investment and stakeholder support.
- **Validate with stakeholders**: Review the charter document with your Responsible AI, security, and operational teams before deployment. Cross-functional validation identifies risks early and builds organizational consensus.
- **Update under change control**: Revise the charter as business needs evolve but enforce strict governance to prevent scope creep. Formal change control processes maintain your security posture and budget predictability.
- **Implement technical safeguards**: Use middleware for input validation, logging, and security enforcement to ensure agents operate within defined boundaries. Technical safeguards provide defense-in-depth protection alongside policy controls.

### 1.2 Set up your environment

Establish a secure and well-architected foundation before building AI agents. This foundation includes infrastructure, governance frameworks, and compliance controls that support reliable and scalable agent operations.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry:** Start with the [AI landing zone](https://github.com/Azure/AI-Landing-Zones). This reference architecture provides a proven foundation you can customize to meet your requirements. You have two primary approaches:

- **Low-code approach with prompt-based agents**: Use [prompt-based agents](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry#types-of-agents) to build agents without extensive coding. This approach accelerates development and allows business stakeholders to participate in agent design.

- **Pro-code approach with hosted agents**: Use [hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry) for advanced scenarios that require custom orchestration logic and detailed control over agent behavior.

Apply [Well-Architected Framework principles](/azure/well-architected/ai/) to balance performance, reliability, security, and cost.

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio:** First [verify licensing and access requirements](/microsoft-copilot-studio/requirements-licensing-subscriptions). Then [configure environments](/microsoft-copilot-studio/environments-first-run-experience) to separate development, testing, and production workloads.

Proper environment setup reduces deployment delays and compliance violations. This investment also simplifies scaling as agent adoption grows across your organization.

### 1.3 Choose agent orchestration

Orchestration determines how agents coordinate, make decisions, and execute tasks. In a single-agent setup, the agent manages its own decision-making process, selects appropriate tools, sequences actions, and remembers context from previous interactions. This structure delivers reliable performance and simplifies oversight.

In multi-agent systems, orchestration becomes distributed across multiple specialized agents. Each agent focuses on specific tasks, uses relevant tools, and communicates with other agents to share information and coordinate actions. Structured orchestration prevents communication breakdowns, circular dependencies, and conflicting instructions. This approach enables scalable, modular design that grows with your business needs.

**Choose between these orchestration approaches**:

| Approach | Description | Advantages | Tradeoffs | Best for |
|----------|-------------|------------|-----------|----------|
| **Managed orchestration with Foundry Agent Service** | Foundry provides a fully managed, low-code orchestration platform within Azure. It handles conversation threads, tool calls, and output sequencing with minimal coding effort. | Fast deployment delivers rapid time-to-value. Built-in security and compliance features include Azure AD integration. Enterprise connectors and automatic scaling reduce operational burden. | Limited customization restricts complex workflow adaptation. Orchestration logic operates as a managed service with less transparency. Azure hosting exclusively means no multi-cloud flexibility. | Organizations that prioritize speed, governance, and simplicity over deep customization. Ideal when rapid deployment and built-in compliance matter more than workflow control. |
| **Custom orchestration with agent frameworks** | Frameworks such as Microsoft Agent Framework or LangGraph provide full control over orchestration logic, multi-agent workflows, and state management. These frameworks run in your infrastructure or applications. | Transparent workflows give you complete visibility into decision logic. Detailed debugging and performance tuning capabilities support optimization. Broader integration options extend beyond Azure to support diverse technology stacks. | Higher development and maintenance effort requires dedicated engineering resources. Skilled engineering teams become essential for success. You assume full responsibility for security, compliance, and infrastructure management. | Organizations that require advanced customization, multi-cloud support, or integration with existing systems. Best when workflow control and flexibility outweigh speed-to-market considerations. |

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry:** See [Build a workflow](/azure/ai-foundry/agents/concepts/workflow?view=foundry). For hosted agents, see [Workflow orchestrations](/agent-framework/user-guide/workflows/orchestrations/overview) and [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio:** For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints. [Configure agent behavior](/microsoft-copilot-studio/advanced-generative-actions) by orchestrating with generative AI. For critical operations, use [multistage and AI approvals](/microsoft-copilot-studio/flows-advanced-approvals) to enforce deterministic decision gates.

### 1.4 Define agent behavior

Agent instructions, also known as system messages, serve as operational guidelines that determine how agents respond and behave. Well-structured instructions ensure agents operate within approved boundaries, comply with regulations, and maintain consistent tone and identity.

For multi-agent systems, assign each agent a specific role such as Planner, Researcher, Executor, or Reviewer. Document what each agent produces and how information flows between agents. Role separation prevents overlapping responsibilities, reduces conflicts, and enables faster troubleshooting.

**Follow these practices for effective agent instructions**:

1. **Write clear, structured instructions**. Each agent requires complete guidelines covering these key areas:

    - **Identity and tone**: Describe how the agent presents itself and whether it uses conversational language or formal business terminology. Consistent tone helps users form accurate expectations about the interaction.
    
    - **Scope and boundaries**: State explicitly what the agent does and what it avoids. An HR agent might answer benefits questions but must not access salary data or provide tax advice. Clear boundaries protect your organization from compliance violations.
    
    - **Unknown situations**: Specify how the agent handles questions it cannot answer. The agent can transfer to a human specialist, log the request for review, or provide a standard response. This guidance ensures users receive appropriate support even when the agent reaches its limits.
    
    - **Compliance rules**: Embed organizational and regulatory requirements directly into instructions. These embedded rules align agent behavior with corporate policy and legal obligations without requiring constant manual oversight.

2. **Use approved communication protocols**. Refer to [agent protocol governance](./governance-security.md#standardize-agent-protocols) and adopt standard protocols such as A2A and MCP when agents need to collaborate or delegate tasks. Interacting with unknown or internet-exposed agents introduces significant security risks and should be prohibited. Approved protocols protect your organization from data breaches and unauthorized access.

3. **Define message formats**. Use structured data formats such as JSON to ensure clarity and consistency. In multi-agent systems, when Agent A sends a query to Agent B, include relevant context rather than just the raw question. This context sharing improves accuracy and reduces errors.

4. **Set boundaries on conversations**. Restrict how many times agents can interact per task to prevent infinite loops and ensure timely resolution. These boundaries protect system resources and maintain user satisfaction.

5. **Build validation into every agent**. Quality control must be automatic and systematic. When an agent produces output, verify it automatically. For example, if an agent drafts a response, run it through a second agent that checks facts and tone. Allocate equal or greater effort to validation as you do to generation. This practice maintains quality standards and protects your brand reputation.

6. **Manage instructions with version control**. Store all agent instructions in a version-controlled system such as GitHub. Version control creates an auditable history of changes, supports collaborative editing, and ensures teams reference approved instructions. This practice supports compliance audits and reduces configuration errors.

Test instructions thoroughly before deployment to validate behavior against sample queries. Testing reveals gaps in instructions and prevents costly mistakes in production environments.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: See [System message design](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering?view=foundry) and [prompt engineering techniques](/azure/ai-foundry/openai/concepts/prompt-engineering?view=foundry). Use the [A2A tool](/azure/ai-foundry/agents/how-to/tools/agent-to-agent?view=foundry&pivots=python) and [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds?view=foundry). In the Microsoft Agent Framework, see [A2A agents](/agent-framework/user-guide/agents/agent-types/a2a-agent).

:::image type="icon" source="./images/copilot-studio-icon.png"::: **Copilot Studio**: For multi-agent systems, [set up agent flows](/microsoft-copilot-studio/flows-overview) with distinct roles and approval checkpoints.

### 2. Agent model selection

Start by selecting models that align with the complexity and importance of each task. Avoid defaulting to the largest or most expensive model. Instead, instruct teams to select models that match the complexity and importance of each task. Smaller models often provide sufficient performance for internal workflows and reduce cost and latency. Evaluate the task's requirements and choose models that balance performance, cost, and quota constraints.

Consider quotas and cost implications. Higher-end models often have stricter rate limits and higher costs, which can lead to quota exhaustion and budget overruns if used for all tasks. To optimize availability and cost, diversify your model selection. Use smaller models for routine or internal workflows and reserve premium models for complex, high-value scenarios.

In **multi-agent systems**, assign models based on role. For example, use a more capable model to interpret user intent, and a simpler model or rule-based logic to execute commands. This approach improves efficiency and ensures each agent contributes effectively to the overall system. Before finalizing model choices, run a small-scale test using sample queries. This testing phase helps validate performance and cost trade-offs in real scenarios. It also supports governance by documenting model behavior and ensuring compliance with internal standards.

:::image type="icon" source="./images/foundry-icon.png"::: **Foundry**: Use [model catalog](https://ai.azure.com/explore/models) to find models aligned with task complexity and cost requirements. Each model in Foundry has specific [usage quotas and pricing](/azure/ai-foundry/foundry-models/quotas-limits).  Always review quota limits in the Azure portal and [request increases to default limits](/azure/ai-foundry/foundry-models/quotas-limits#request-increases-to-the-default-limits), as needed. Evaluate options using [model leaderboards](/azure/ai-foundry/concepts/model-benchmarks) to compare performance and cost trade-offs. For chat-based agents, [configure Model Router](/azure/ai-foundry/openai/concepts/model-router) to dynamically optimize costs while maintaining quality.

In **Microsoft Copilot Studio** [choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) from available options. You can [bring your own model](/ai-builder/byom-for-your-prompts) to connect Foundry models for specialized tasks.

### 3. Add knowledge and tools

To ensure AI agents operate securely, deliver accurate results, and align with business goals, organizations must define how agents access data and perform actions. This step shapes the agent’s reliability, compliance posture, and operational risk. It also determines how effectively agents contribute to business outcomes. **Follow all [data governance and compliance policies](./governance-security.md#data-governance-and-compliance).**

### 3.1 Add agent knowledge

AI agents must use only validated and approved data sources. For example, when an agent answers HR or policy questions, it should reference only sanctioned documents—such as those indexed in Azure AI Search or stored in a vector database with embeddings. This approach reduces compliance exposure and avoids misinformation.

1. **Enforce least-privilege access.** Each agent must use managed identity and operate under tightly scoped permissions through Azure Role-Based Access Control (RBAC). Avoid broad roles like "Reader" or "Contributor" unless the agent’s function justifies it. Tailor permissions to the agent’s specific tasks to limit exposure and align with security best practices.

2. **Handle unknowns consistently.** When an agent cannot answer a question or access a resource, it must respond politely and suggest escalation to a human. Logging unknown queries across agents helps identify gaps and improve coverage over time.

3. **Keep the agent’s data sources current.** Use scheduled or event-driven updates, preferably incremental, to refresh indexed content. Monitor refresh jobs to prevent stale data. For dynamic information like inventory or weather, connect the agent using MCP (Model Context Protocol) servers. MCP servers provide a standardized way to expose real-time data and actions to agents, making them ideal for scenarios where freshness and reliability are critical. An outdated agent quickly loses credibility, so plan for ongoing maintenance.

In **Foundry**, use [**knowledge** tools](/azure/ai-foundry/agents/how-to/tools/overview). With the Microsoft Agent Framework, extend the capabilities of your agents by connecting it to tools hosted on remote [Model Context Protocol](/agent-framework/user-guide/model-context-protocol/).

In **Microsoft Copilot Studio**, use [knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) and [connectors](/microsoft-copilot-studio/advanced-connectors).

### 3.2 Agent tools for actions

Agents often need to perform tasks beyond answering questions, such as creating support tickets, scheduling meetings, or triggering workflows. To support this, organizations must define a clear list of approved actions and map each one to a secure, authenticated tool or API. Avoid giving agents broad access to systems. Instead:

1. **Keep a human in the loop.** Define when agents act independently and when they defer to human support. Avoid relying solely on confidence scores. Instead, use business context to guide escalation. For example, allow agents to handle routine inquiries but escalate complex or sensitive issues. This improves reliability and user satisfaction while reducing risk.

2. **Use well-defined APIs or connectors.** Do not give agents broad access to systems. Instead, expose specific actions through secure APIs or functions. For example, rather than allowing direct database access, provide an endpoint like createSupportTicket with structured input. This keeps operations scoped and controlled.

3. **Apply least privilege to each agent.** Ensure the credentials or tokens the agent uses for actions have minimal rights. If an agent creates tickets, its token must not delete them. If it sends emails, restrict it to a dummy or no-reply account to prevent misuse. If only one agent executes changes, its credentials must reflect that. Other agents might only read data or provide responses. Scope tokens and credentials to prevent misuse.

4. **Define tool usage in the instructions.** Confirm the details of the action, then ask for permission to execute on the user’s behalf. Specify when and how each agent uses its tools. Most frameworks allow defining tools with usage instructions. For example, if the user asks to reset their password, the agent must call the ResetPassword API with their username. This prevents unintended actions and ensures agents act only when appropriate.

5. **Test each agent’s actions in isolation.** Before deploying, simulate each agent’s action triggers in a test environment. Validate that the correct agent initiates the action, the action performs as expected, all required fields are filled, and no unintended side effects occur. Adjust prompts or logic if behavior deviates from expectations.

6. **Log all actions with agent attribution.** Maintain detailed logs for every action, including which agent initiated it, what the action was, and who the action affected. For example, you might log that Agent C triggered password reset for user X on behalf of user Y. This supports auditing, debugging, and accountability. Logging failed actions will also help you improve agent functionality over time.

For **multi-agent systems**, partition action capabilities across agents. Just as organizations partition knowledge, they must also partition actions to keep the system modular and secure. Agent A might answer frequently asked questions, Agent B might retrieve internal data, and Agent C executes changes.

In **Foundry**, use [**action** tools](/azure/ai-foundry/agents/how-to/tools/overview#action-tools).

In **Microsoft Copilot Studio**, use [orchestrate agent behavior](/microsoft-copilot-studio/advanced-generative-actions).

This approach helps organizations define a secure and scalable roadmap for agent development. It clarifies responsibilities, minimizes risk, and ensures agents contribute meaningfully to business operations across the cloud estate

### 3.3 Agent memory

Improving agent behavior across a cloud estate requires a balance between user experience, security, and regulatory compliance. Organizations must define clear governance boundaries while enabling agents to operate efficiently across sessions and workflows. The following best practices support scalable and secure agent interactions.

1. **Use memory to improve continuity.** Agents that retain context across sessions reduce repetitive user input and improve responsiveness. This continuity lowers latency and reduces unnecessary API calls. However, storing context introduces data retention responsibilities. Organizations subject to regulations such as GDPR or HIPAA must define clear policies for data minimization, retention, and deletion.

2. **Persist only the information necessary to support continuity** Avoid storing full transcripts unless the business case justifies the privacy trade-off. Full transcripts improve user experience but increase exposure risk. Minimal context reduces risk but may limit the agent’s ability to respond effectively. When restoring context into a new session, ensure agents only deserialize safe and relevant data. Prevent leakage of unrelated user information by applying strict filtering and validation rules.

3. **Protect sensitive data.** Encrypt all memory at rest and in transit. Apply role-based access control (RBAC) and identity management to restrict access. Enable audit logging to track all read and write operations. These controls form the foundation for secure agent behavior and align AI adoption with enterprise risk management strategies.

4. **Validate behavior through testing.** Agents that use memory or share context across threads must undergo rigorous testing. Include compliance checks in evaluation cycles and validate defenses against prompt injection and other vulnerabilities. Test agent behavior under multi-thread scenarios to confirm fairness, security, and performance. This validation ensures agents operate reliably and safely across diverse workflows and user groups.

**Foundry** stores [threads, runs, and messages](/azure/ai-foundry/agents/concepts/threads-runs-messages) in a Microsoft-managed storage account. This configuration requires no setup but limits control over data retention and compliance. Organizations that require full control should configure Bring Your Own Thread Storage (BYOS) using a data store, like Azure Cosmos DB. BYOS enables custom retention policies, encryption, and audit logging. For example, Cosmos DB organizes agent data into three containers: user messages, system messages, model inputs and outputs. See [configure external stores like Azure Cosmos DB](/azure/ai-foundry/agents/concepts/standard-agent-setup) and [Azure Cosmos DB integration with Azure AI Agents Service](/azure/cosmos-db/gen-ai/azure-agent-service).

Agent frameworks, like the Microsoft Agent Framework, supports [serialization and deserialization](/agent-framework/user-guide/agents/multi-turn-conversation#agentthread-storage) of thread state. Thread ID reuse and context serialization support these strategies but require code changes and introduce operational complexity. Decision makers must weigh these efforts against the benefits of improved control, compliance, and user experience. See also [Agent Memory](/agent-framework/user-guide/agents/agent-memory) in the Microsoft Agent Framework. Test and refine behavior using [agent evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/agent-evaluators) in the agent playground.

In **Microsoft Copilot Studio**, [control transcript access and retention](/microsoft-copilot-studio/admin-transcript-controls). Validate agent behavior by [testing in the test panel](/microsoft-copilot-studio/authoring-test-bot) to observe conversation flows. Improve performance by [analyzing agent effectiveness](/microsoft-copilot-studio/analytics-improve-agent-effectiveness) to identify optimization opportunities. Understand user needs by [analyzing questions by theme](/microsoft-copilot-studio/analytics-themes) to discover patterns. Refine responses by [using prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification) to provide custom instructions.

## 5. Protect and govern

To ensure agents operate safely and consistently, organizations must establish governance practices that span both the applications agents support and the platforms they run on.

:::image type="content" source="./images/governance-security.png" alt-text="Diagram that shows how to govern ." lightbox="./images/governance-security.png" border="false":::

### 5.1 Use evaluations

AI agents must meet business expectations for performance and safety. To achieve this, organizations need structured evaluation processes:

- **Use continuous evaluations.** Evaluations provide a structured way to assess how well AI agents perform and how safely they behave. These assessments use standardized metrics to compare different versions of an agent and determine which one best meets business needs. Leadership must ensure that evaluation practices become part of the organization's broader quality assurance strategy. When you require automated safety and performance checks before deployment, you reduce the risk of releasing agents that behave unpredictably or expose sensitive data.

- **Conduct adversarial testing and red teaming.** Security testing must extend beyond traditional penetration tests. AI agents require specialized adversarial testing to simulate attacks that exploit their unique vulnerabilities. These tests include attempts to manipulate agent behavior through deceptive prompts or malicious inputs. Organizations must direct their teams to run these tests regularly and integrate them into release cycles.

For **Foundry**, have teams use [continuous evaluation](/azure/ai-foundry/how-to/continuous-evaluation-agents). They should automate quality and safety gates by integrating evaluation workflows via [GitHub Actions evaluations](/azure/ai-foundry/how-to/evaluation-github-action?tabs=foundry-project) or [Azure DevOps evaluations](/azure/ai-foundry/how-to/evaluation-azure-devops?tabs=foundry-project) and enforce standardized agent behaviors using reusable templates in source control. Teams can use dedicated [AI Red Teaming Agent](/azure/ai-foundry/how-to/develop/run-scans-ai-red-teaming-agent) to scan applications for safety and security issues.

For  **Microsoft Copilot Studio**, [Create test sets for evaluations](/microsoft-copilot-studio/analytics-agent-evaluation-create), [Security and governance guidance](/microsoft-copilot-studio/security-and-governance), [automatic security scans](/microsoft-copilot-studio/security-scan), and verify [agent runtime protection status](/microsoft-copilot-studio/security-agent-runtime-view).

### 5.2 Implement guardrails and controls

To prevent harmful or inappropriate outputs at the agent level, the agent must use input and output filters:

1. [**Content filtering**](/azure/ai-foundry/concepts/content-filtering) that scans both user prompts and agent responses for harmful content.
1. [**Blocklist**](/azure/ai-foundry/openai/how-to/use-blocklists?tabs=api) that restrict specific terms or phrases from appearing in agent interactions.
1. **Security recommendations** from Microsoft Defender for Cloud's [AI protection](/azure/defender-for-cloud/ai-threat-protection).
1. **Data controls** from Microsoft Purview that apply sensitivity labels and enforce data governance policies.

Leadership must ensure these controls align with existing data protection and compliance frameworks. When you embed these safeguards into the agent platform, organizations reduce the risk of reputational damage and regulatory violations.

### 5.3 Detect risks and set alerts

Security alerts become more actionable when they include context about the user and the application involved. For example, adding user identity or IP address helps security teams block malicious actors or trace incidents. Including application context allows teams to distinguish between suspicious behavior and normal operations.

Direct teams to enrich AI-related alerts with both user and application context. This practice improves incident response and supports more accurate threat prioritization. See [Gain application and end-user context for AI alerts](/azure/defender-for-cloud/gain-end-user-context-ai).

### 5.4 Bring your own resources

To maintain trust, security, and operational continuity across your cloud estate, you can Bring Your Own (BYO) approach when integrating AI agents with enterprise infrastructure. This strategy ensures agents operate within your organization’s governance boundaries while optimizing performance and cost.

When you connect agents to your existing systems such as storage, identity, and routing, ensures they follow your organization’s security and compliance policies. This includes using your own Azure Storage, Cosmos DB, or Azure AI Search to manage agent memory and data access. By doing so, you retain control over where data resides, how it's accessed, and who can audit it. This approach also supports structured memory design. For example, your teams can combine short-term conversational buffers with long-term structured stores to maintain context without retaining raw personal data. This supports privacy compliance while enabling agents to deliver personalized and coherent responses.

Ensure the BYO approach integrates seamlessly with your broader architecture. This includes aligning with identity systems for authentication, using approved APIs for tool access, and enforcing data isolation policies across projects. These measures reduce risk and simplify compliance audits.

**Foundry:** Maintain control by [using your own resources](/azure/ai-foundry/agents/how-to/use-your-own-resources) like Azure Storage, Azure AI Search, and Cosmos DB for thread storage in standard setup configurations.

## 6. Observe and optimize

The agent needs observability tools early. Capture key performance metrics such as responsiveness, throughput, and error rates. Instrument agents with telemetry for logs, metrics, and traces and send to a central analytics workspace as needed. Monitor dashboards for system-wide and individual performance. Set up dashboards that visualize system-wide and agent-specific metrics. These dashboards help decision makers and operations teams identify trends, spot bottlenecks, and prioritize improvements. Configure anomaly alerts to detect unusual behavior such as spikes in error rates or latency and tie these alerts into DevOps workflows for rapid response.

To improve agent performance and reliability, organizations must monitor how agents behave in real-world scenarios:

- **[Use traces](/azure/ai-foundry/how-to/develop/trace-agents-sdk)**: Capture the journey of a request through individual agents, such as inputs and outputs and metadata.
- **[Review threads](/azure/ai-foundry/agents/concepts/threads-runs-messages#threads)**: Threads show how agents process instructions and help teams refine agent logic.
- **[Monitor applications](/azure/ai-foundry/how-to/monitor-applications)**: Track, analyze, and optimize your application’s performance and operational health in real time.
- **[Monitor models](/azure/ai-foundry/foundry-models/how-to/monitor-models)**: Get metrics on your model deployments such as total requests, total token count (prompt tokens + completion tokens).

**Foundry:** [Monitor the Agent Service](/azure/ai-foundry/agents/how-to/metrics).

:::image type="icon" source="images/copilot-studio-icon.svg"::: **Microsoft Copilot Studio:** Use [analytics](/microsoft-copilot-studio/analytics-overview) and [connect to Azure Application Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) for custom telemetry.

## Next step

> [!div class="nextstepaction"]
> [Integrate agents into business processes](./integrate.md)
