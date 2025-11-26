---
title: Technology plan for AI agents
ms.reviewer: ssumner
description: Learn how to define a technology plan for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: article
ms.collection: ce-skilling-ai-copilot
---

# Technology plan for AI agents

After establishing that a use case requires AI agents, decide whether to adopt ready-to-use SaaS agents or build custom agents. Ready-to-use SaaS agents reduce time to value and operational complexity but offer limited customization. Custom-built agents provide full control and deeper integration but require more development resources and ongoing maintenance. Evaluate functional requirements, timeline, budget, and internal capabilities to guide this decision.

:::image type="complex" source="./images/ai-agent-decision-tree.png" alt-text="Decision tree diagram for selecting AI agent solutions based on business and technology requirements." lightbox="./images/ai-agent-decision-tree.png":::
    A flowchart guides organizations through decisions about when and how to use AI agents. The diagram starts with a blue diamond labeled "Potential agent use case" and branches into multiple decision paths. The business plan path determines if AI agents should be used. If the answer is "No," the path leads to "Use code or non-generative AI models" with icons for GitHub, Microsoft Fabric, AI models in Foundry, and Machine Learning. If "Yes," it asks if the task involves static Q&A or content generation without reasoning. The technology plan path checks if SaaS agents meet functional requirements. If "Yes," the path leads to "Use SaaS agents" with icons representing M365 Copilot agents (App Builder, Workflows, Researcher, Analyst, Surveys), GitHub Copilot agent, Microsoft Fabric data agents, Azure Copilot agents, Dynamics 365 agents, and Security Copilot agents. If SaaS agents do not meet needs, the path leads to "Build AI agents" with options for GPUs & Containers (open-source), Microsoft Foundry (PaaS pro-code), and Copilot Studio (SaaS no/low-code). The single or multiple agents decision path asks whether the use case involves security concerns, compliance requirements, multiple teams, or future growth. If "Yes," it leads to "Build multiple agents" using workflows for orchestration. If "No," it checks task complexity and requirements, leading to either "Test a single agent" or "Build a single agent" using workflows for integration and governance. The diagram uses color-coded shapes with diamonds representing decision points and rectangles representing actions, with arrows showing the flow between choices.
:::image-end:::

## Adopt SaaS agents

Prioritize prebuilt solutions when they meet functional and budget requirements. SaaS agents reduce development overhead and accelerate deployment.

- **Agents in Microsoft 365 Copilot.** [App Builder agent](/copilot/microsoft-365/app-builder-privacy-data-subject-request-faq), [Workflows agent](/copilot/microsoft-365/flow-builder-privacy-data-subject-request-faq), and [Researcher](/copilot/microsoft-365/researcher-agent) enable task automation and information synthesis across Microsoft 365 applications. Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to structure your deployment approach and governance model.

- **Other SaaS agents.** [GitHub Copilot agents](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent) support coding tasks, [Microsoft Fabric data agents](/fabric/data-science/concept-data-agent) enable data analysis, [Azure Copilot agents](/azure/copilot/agents-preview) provide infrastructure insights, [Dynamics 365 agents](/dynamics365/customer-service/administer/overview-bots) automate customer service workflows, and [Security Copilot agents](/copilot/security/agents-overview) enhance threat detection and response. These agents deliver immediate capabilities for domain-specific productivity and process automation. For additional context, see [Overview of available Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes).

When no SaaS agents meet your functional requirements, build custom agents to achieve the necessary capabilities and integration depth.

## Build AI agents

Choose a build path based on your organization's technical capabilities, timeline, and control requirements. Microsoft provides two primary platforms: Foundry for pro-code development with maximum flexibility, and Copilot Studio for low-code development with faster deployment.

:::image type="complex" source="./images/build-overview.png" alt-text="Diagram showing build agent options across three platforms: Microsoft Foundry (pro-code with declarative agents, workflows, and hosted agents), Microsoft Copilot Studio (low-code with retrieval and task agents), and GPUs & Containers (custom infrastructure with code-first frameworks)." lightbox="./images/build-overview.png":::
    Overview of AI agent build options comparing three deployment paths. Microsoft Foundry offers pro-code development with declarative agents for focused tasks, workflows for multi-step orchestration, and hosted agents with managed runtime. Microsoft Copilot Studio provides low-code development with prebuilt connectors and retrieval and task agent capabilities. GPUs & Containers support custom infrastructure using Visual Studio Code and GitHub for maximum flexibility in agent deployment.
:::image-end:::

### Microsoft Foundry

[Microsoft Foundry](/azure/ai-foundry/what-is-azure-ai-foundry?view=foundry) is a platform-as-a-service for pro-code agent development that consolidates runtime, orchestration, and integration features into a managed environment. It exposes capabilities that span authoring, execution, and operational observability so teams can build sophisticated, production-grade agents without managing underlying VM or Kubernetes infrastructure.

**Development capabilities**

- **Declarative agents.** Define agent behavior in [prompt-based](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry#types-of-agents) declarative agents. Combine model selection, prompts, instructions, and tool bindings. Declarative agents support augmentation with knowledge bases and memory to extend context and retrieval.
- **Hosted agents.** You don't need to manage your own infrastructure to bring you own agent frameworks inside a code-first managed runtime. Foundry handles provisioning, scaling, and lifecycle concerns for hosted containers, letting code-first projects focus on business logic instead of infra management. See [Hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry).

- **Workflows.** Model multi-step processes and agent coordination as orchestrated flows. Workflows enable sequential logic, conditional branching, retries, and integrations with services to represent business processes and approval paths. See [Workflows](/azure/ai-foundry/agents/concepts/workflow?view=foundry).

**Integration and interoperability**

- **Integration surface.** Foundry supports standardized messaging and cross-service interaction through the Activity Protocol and agent-to-agent (A2A) patterns.
- **Integration.** Agents can be surfaced to other Microsoft experiences and channels through built-in publishing paths, like [Microsoft 365](/azure/ai-foundry/agents/how-to/publish-copilot?view=foundry) and [Agent 365](/azure/ai-foundry/agents/how-to/agent-365?view=foundry).

**Models, memory, and tools**

- **Model selection.** Access a diverse catalog including OpenAI, Anthropic, Meta LLaMA, and Mistral. Select models that balance performance, latency, and cost for your specific use case. See the [Model catalog](/azure/ai-studio/how-to/model-catalog).
- **Memory and state.** Use [managed memory](/azure/ai-foundry/agents/concepts/agent-memory?view=foundry&tabs=python) to maintain conversation context. For strict data governance, use the bring-your-own (BYO) memory store option.
- **Tool integration.** Connect agents to external systems using the Microsoft Copilot Protocol (MCP) or OpenAPI specifications. For complex serverless automation, integrate with Fabric (Fabric IQ and Fabric data agents), SharePoint, Bing, Azure AI Search, Azure Logic Apps and Azure Functions. See the [Tool catalog](/azure/ai-foundry/agents/concepts/tool-catalog?view=foundry).

Start with the [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build and test prototypes. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart).

### Choose a setup topology

Select the appropriate infrastructure setup for your Foundry agents based on your security, networking, and scalability needs.

#### Basic agent setup

Use the [basic setup](/azure/ai-foundry/how-to/create-project) for rapid experimentation and development where enterprise-grade isolation is not required. This topology suits startups or small teams that need flexibility and speed without complex network configurations.

- **Target environment.** New environments or startups with existing Azure OpenAI resources.
- **Key features.** Quick deployment and ease of use.
- **Limitations.** Lacks network isolation and advanced enterprise guarantees.

#### Standard setup

Use the [standard setup](/azure/ai-foundry/how-to/create-hub) for production environments that require fine-grained control over data, security, and networking. This topology supports large enterprises with compliance requirements.

- **Standard with public networking.** Best for large organizations exploring AI that require enterprise data controls but do not yet need full network isolation. It supports non-confidential workloads.
- **Standard with private networking.** Essential for production environments handling confidential workloads. This configuration supports private networking and integrates with existing Azure OpenAI, search, and storage resources to meet strict compliance and security standards.

### Microsoft Copilot Studio

[Microsoft Copilot Studio](/microsoft-copilot-studio/) offers a software-as-a-service (SaaS) platform for low-code development. It enables business teams to deploy agents quickly with moderate customization. The platform includes prebuilt connectors, supports retrieval and task agents, and integrates with Azure AI Search. Built-in responsible AI features reduce the need for custom safeguards.

You can use Copilot Studio's low-code interface with Foundry's advanced models to handle sophisticated use cases while maintaining SaaS security and reliability. This hybrid approach allows business teams to build agents without extensive coding while accessing enterprise-grade AI capabilities. The combination reduces development time compared to full pro-code solutions while providing more customization than standard SaaS agents.

Test use cases with the [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) before committing to production deployment. Review available [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine the best entry point for your organization.

### GPUs & Containers 

You can also choose to deploy agents on GPU infrastructure using Azure Virtual Machines with containers as an alternative. While this guidance does not provide detailed steps for that approach, it can be useful when you need flexibility for custom configurations, integration with existing VM-based workloads, or scenarios requiring advanced security controls. Development uses Visual Studio Code and GitHub. Costs scale with token consumption and compute usage. For deployment guidance, see [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

## Validate technology choices

Organizations often use multiple approaches to meet diverse requirements. Validate platform fit through structured experimentation before scaling.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options comparing Microsoft Copilots (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Foundry) build options." lightbox="./images/technology-options.png" border="false":::

1. **Run time-boxed experiments.** Build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare low-code agents in Copilot Studio with pro-code solutions in Foundry. Evaluate development speed, functional coverage, and integration complexity.

2. **Require documentation and stakeholder review.** Document findings and present clear recommendations. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to pro-code or adjust scope. Stakeholder review reduces rework and increases confidence.

3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents or a single agent. Avoid unnecessary complexity. If a single agent meets business needs efficiently, proceed with that approach. If not, define a roadmap for multi-agent orchestration. Refer to [Single agent or multiple agents?](./single-agent-multiple-agents.md).

| Solution | Approach | Agent types | Best for |
| :--- | :--- | :--- | :--- |
| **SaaS agents** | Ready-to-use (SaaS) | Retrieval, Task | Personal productivity. Requires minimal customization to deliver immediate value. |
| **Microsoft Foundry** | Pro-code (PaaS) | Retrieval, Task, Autonomous | Strategic transformation. Supports deep integration and custom logic. |
| **Microsoft Copilot Studio** | Low-code (SaaS) | Retrieval, Task, Autonomous | Process transformation. Enables fast development with minimal coding and SaaS security. |
| **Virtual machines** | Pro-code (IaaS) | Retrieval, Task, Autonomous | Custom infrastructure. Provides full control of the entire technology stack. |

See the general [AI decision tree] for more guidance.

## Next step

After you define your business and technology strategies for AI agents, you must focus on the organizational structure and talent required to deliver and sustain these solutions.

> [!div class="nextstepaction"]
> [Organizational readiness](./organization-people-readiness-plan.md)
