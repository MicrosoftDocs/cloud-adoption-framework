---
title: Technology Plan for AI Agents across your organization using the Microsoft Ecosystem
ms.reviewer: ssumner
description: Learn how to define a technology plan for AI agents across your organization using Microsoft SaaS agents, Microsoft Foundry, and Copilot Studio
#customer intent: As an enterprise architect I want to understand what AI agent options are available to me across the Microsoft ecosystem so that I can provide the right approach that balances speed cost and operations for each use case and make that available to my teams
author: stephen-sumner
ms.author: pnp
ms.date: 12/01/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Technology plan for AI agents

This article provides guidance on how to select the right technology platform for each of your potential agent use cases. It covers adopting a ready-to-use SaaS agent or building a custom agent with Microsoft Foundry (PaaS) or Microsoft Copilot Studio (SaaS). Developing a technology plan is the second step in the **Plan for agents** phase of AI agent adoption (*see figure 1*).

:::image type="content" source="./images/ai-agent-adoption.svg" alt-text="Diagram showing a horizontal workflow with four connected phases: plan for agents (substeps are business plan, technology plan, organizational readiness, and data architecture). Govern and secure agents (Substeps are Responsible AI, Governance and Security, and Prepare environment). Build agents (Substeps are single and multi-agent systems and process to build agents). Manage agents integrate (subprocesses Integrate agents and operate agents)." lightbox="./images/ai-agent-adoption.svg" border="false":::
*Figure 1. Microsoft's AI agent adoption process.*

Effective technology adoption aligns goals with cost, level of effort, and customization needs. This alignment matches the technology to the use case and balances the effort required to achieve a return on investment. Understanding the available landscape ensures the right choice between adopting a ready-to-use SaaS agent or building a custom solution to provide business advantage.

## AI agent decision tree

The AI agent decision tree guides the technology selection process by focusing on one primary question: **Does a SaaS agent meet your functional requirements?** If a SaaS agent satisfies your needs, adopt the prebuilt solution. If no SaaS agent fits the use case, you must build a custom agent. Determining which platform to use for a custom build, Microsoft Foundry, Microsoft Copilot Studio, or custom infrastructure, requires further investigation. The following sections provide guidance on selecting the right platform based on your specific requirements.

:::image type="complex" source="./images/ai-agent-decision-tree.svg" alt-text="Decision tree diagram for selecting AI agent solutions based on business and technology requirements." lightbox="./images/ai-agent-decision-tree.svg" border="false":::
    A decision tree that guides organizations through decisions about when and how to use AI agents. It starts with "Potential agent use case" and branches into multiple decision paths. The business plan path determines if AI agents should be used. If the answer is "No," the path leads to "Use code or nongenerative AI models" with icons for GitHub, Microsoft Fabric, AI models in Foundry, and Machine Learning. If Yes, it asks if the task involves static question or answer or content generation without reasoning. The technology plan path checks if SaaS agents meet functional requirements. If Yes, the path leads to Use SaaS agents. There are icons representing Microsoft 365 Copilot agents (App Builder, Workflows, Researcher, Analyst, Surveys). Then there are icons for GitHub Copilot agent, Microsoft Fabric data agents, Azure Copilot agents, Dynamics 365 agents, and Security Copilot agents. If SaaS agents don't meet needs, the path leads to "Build AI agents" with options for GPUs & Containers (IaaS), Microsoft Foundry (PaaS), and Copilot Studio (SaaS no/low-code). You're going to start with multiple-agent systems if the use case cross security and compliance boundaries, has multiple teams involved, or you know there's going to be future growth of this system. Unless the system is low complexity, all other use cases should start with a single agent test to see if it could meet your requirements. Depending on the result, you align with a multi-agent system or single-agent system.
:::image-end:::
*Figure 2. Microsoft's AI agent decision tree.*

## Use SaaS agents

SaaS agents are ready-to-use solutions built by Microsoft that enable immediate deployment. These agents provide rapid value for standard business functions but offer limited customization compared to custom builds. Evaluate the agents available across the technology stack to determine if a prebuilt solution meets your requirements.

- **Agents in Microsoft 365 Copilot.** [App Builder agent](/copilot/microsoft-365/app-builder-privacy-data-subject-request-faq), [Workflows agent](/copilot/microsoft-365/flow-builder-privacy-data-subject-request-faq), and [Researcher](/copilot/microsoft-365/researcher-agent) enable task automation and information synthesis from Microsoft 365 data. Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to structure your deployment approach and governance model.

- **In-product SaaS agents.** [GitHub Copilot agents](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent) support coding tasks. [Microsoft Fabric data agents](/fabric/data-science/concept-data-agent) enable data analysis from data in Fabric. [Azure Copilot agents](/azure/copilot/agents-preview) provide insights and recommendations for your Azure environment. [Dynamics 365 agents](/dynamics365/customer-service/administer/overview-bots) help with customer service workflows. [Security Copilot agents](/copilot/security/agents-overview) enhance threat detection and response. These agents deliver immediate capabilities for domain-specific productivity and process automation. For more context, see [Overview of available Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes).

When no SaaS agents meet your functional requirements, build custom agents to achieve the necessary capabilities and integration depth.

## Build AI agents

Choose a build path based on your organization's technical capabilities, timeline, and control requirements. Microsoft provides two primary platforms, Foundry (PaaS) and Copilot Studio (SaaS), with GPUs and containers (IaaS) as a third option.

:::image type="complex" source="./images/build-overview.png" alt-text="Diagram showing build agent options across three platforms: Microsoft Foundry (pro-code with declarative agents, workflows, and hosted agents), Microsoft Copilot Studio (low-code with retrieval and task agents), and GPUs & Containers (custom infrastructure with code-first frameworks)." lightbox="./images/build-overview.png" border="false":::
    Overview of AI agent build options comparing three deployment paths. Microsoft Foundry offers pro-code development with declarative agents for focused tasks, workflows for multi-step orchestration, and hosted agents with managed runtime. Microsoft Copilot Studio provides low-code development with prebuilt connectors and retrieval and task agent capabilities. GPUs & Containers support custom infrastructure using Visual Studio Code and GitHub for maximum flexibility in agent deployment.
:::image-end:::
*Figure 3. Microsoft's AI agent build options.*

### Microsoft Foundry

[Microsoft Foundry](/azure/ai-foundry/what-is-azure-ai-foundry?view=foundry&preserve-view=true) provides a platform-as-a-service (PaaS) environment for no/low-code agent development (declarative agents) or pro-code agent development (hosted agents). Foundry lets you pick your own models, and it consolidates runtime, orchestration, and integration into a managed environment. You don't need to manage the underlying virtual machine or Kubernetes infrastructure. See the following image for more capabilities:

:::image type="complex" source="./images/foundry-overview.png" alt-text="Diagram showing the Microsoft Foundry architecture including authoring, orchestration, and runtime layers." lightbox="./images/foundry-overview.png" border="false":::
    Overview of the Microsoft Foundry architecture. The diagram illustrates the flow from authoring tools to the managed runtime environment. It highlights key components including the model catalog, agent orchestration engine, and integration capabilities with external data and tools.
:::image-end:::
*Figure 4. Overview of Microsoft Foundry's AI capabilities.*

- **Activity protocol, A2A, & integration with M365/Agent 365.** Foundry supports the [Activity Protocol](/microsoft-365/agents-sdk/activity-protocol) and agent-to-agent (A2A) patterns for standardized messaging. Agents can be published to [Microsoft 365](/azure/ai-foundry/agents/how-to/publish-copilot?view=foundry&preserve-view=true) and [Agent 365](/azure/ai-foundry/agents/how-to/agent-365?view=foundry&preserve-view=true) to surface capabilities directly in user workflows.
- **Multi-agent workflows.** [Workflows](/azure/ai-foundry/agents/concepts/workflow?view=foundry&preserve-view=true) orchestrate complex business processes by handling sequential logic, conditional branching, and state management across multiple agents.
- **Declarative agents.** [Prompt-based agents](/azure/ai-foundry/agents/concepts/development-lifecycle?view=foundry&preserve-view=true#types-of-agents) rely primarily on model reasoning and instructions, simplifying updates and versioning for behavior-driven agents.
- **Hosted agents.** Code-first, [hosted agents](/azure/ai-foundry/agents/concepts/hosted-agents?view=foundry&preserve-view=true) support custom libraries or frameworks. This option provides a managed runtime that handles provisioning and scaling while allowing full code control.
- **Models from.** The [Model catalog](/azure/ai-studio/how-to/model-catalog) includes models from OpenAI, Anthropic, Meta, and Mistral, allowing selection based on specific performance, latency, and cost requirements.
- **Memory.** [Managed memory](/azure/ai-foundry/agents/concepts/agent-memory?view=foundry&preserve-view=true&tabs=python) maintains conversation context. For strict data sovereignty requirements, a bring-your-own (BYO) memory store option is available.
- **Tools.** The [Tool catalog](/azure/ai-foundry/agents/concepts/tool-catalog?view=foundry&preserve-view=true), model context protocol (MCP), and OpenAPI specifications enable connections to external systems. Integration with Azure Logic Apps and Azure Functions supports serverless automation.

**Setup options**: Foundry has two setup options that align with your security and operational needs. The [basic setup](/azure/ai-foundry/agents/environment-setup?view=foundry&preserve-view=true#choose-your-setup) is for rapid prototyping and individual development when speed and ease of access are priorities. This option lacks network isolation. The [standard setup](/azure/ai-foundry/agents/concepts/standard-agent-setup?view=foundry&preserve-view=true) provides fine-grained control over data, security, and networking. Within the standard setup, you can use public networking for nonconfidential workloads that require enterprise data controls. You can also use private networking for confidential workloads that must integrate with existing Azure resources to meet strict compliance standards. Review the [comparison and deployment guide](/azure/ai-foundry/agents/environment-setup?view=foundry&preserve-view=true#choose-your-setup) for details on both topologies.

**Foundry playground**: The [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) enables you to build and test prototypes. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart).

### Microsoft Copilot Studio

[Microsoft Copilot Studio](/microsoft-copilot-studio/) offers a software-as-a-service (SaaS) platform for low-code development. It enables business teams to deploy agents quickly with moderate customization. The platform includes prebuilt connectors, supports retrieval and task agents, and integrates with Azure AI Search. Built-in responsible AI features reduce the need for custom safeguards.

Use Copilot Studio's low-code interface with Foundry's advanced models to handle sophisticated use cases while maintaining SaaS security and reliability. This hybrid approach allows business teams to build agents without extensive coding while accessing enterprise-grade AI capabilities. The combination reduces development time compared to full pro-code solutions while providing more customization than standard SaaS agents.

Test use cases with the [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) before committing to production deployment. Review available [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine the best entry point for your organization.

### GPUs and containers

You can host the AI model that an agent uses on GPU-backed containers. This approach is ideal when you want to run your own models rather than relying on Foundry endpoints. In this setup, the AI model runs on GPUs while the agent itself runs on CPUs. When configuring your agent and specifying the model it will use, you point it to the hosted model. The choice of compute platform depends on the size of the model and the level of control you need over the environment.

For hosting **AI models**, Azure Container Apps with serverless GPU support is a good option for small language models because it automatically handles scaling and minimizes operational overhead. For large language models, Azure Kubernetes Service is recommended since it supports large GPU clusters, offers higher throughput, and provides advanced control over scaling and networking.

For hosting **AI agents**, you can use either Azure Kubernetes Service or Azure Container Apps with CPU-based clusters to run agents with a custom orchestration framework.

## Validate technology choices

Organizations often use multiple approaches to meet diverse requirements. Validate platform fit through structured experimentation before scaling.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options. Compare Microsoft SaaS agents (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Foundry) build options." lightbox="./images/technology-options.png" border="false":::

1. **Run time-boxed experiments.** Build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare low-code agents in Copilot Studio with pro-code solutions in Microsoft Foundry. Evaluate development speed, functional coverage, and integration complexity.

2. **Require documentation and stakeholder review.** Document findings and present clear recommendations. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to pro-code or adjust scope. Stakeholder review reduces rework and increases confidence.

3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents or a single agent. Avoid unnecessary complexity. If a single agent meets business needs efficiently, proceed with that approach. If not, define a roadmap for multi-agent orchestration. Refer to [Single agent or multiple agents?](./single-agent-multiple-agents.md).

| Solution | Approach | Agent types | Best for |
| :--- | :--- | :--- | :--- |
| **SaaS agents** | Ready-to-use (SaaS) | Retrieval, Task | Personal productivity. Requires minimal customization to deliver immediate value. |
| **Microsoft Foundry** | Pro-code and low/no-code (PaaS) | Retrieval, Task, Autonomous | Strategic transformation. Supports deep integration and custom logic. |
| **Microsoft Copilot Studio** | Low/no-code (SaaS) | Retrieval, Task, Autonomous | Process transformation. Enables fast development with minimal coding and SaaS security. |
| **GPUs and containers** | Pro-code (PaaS or IaaS) | Retrieval, Task, Autonomous | Compliance-sensitive or highly customized (custom model configurations, private networking, strict isolation) workloads with full control of the entire technology stack. |

See the general [AI decision tree](/azure/cloud-adoption-framework/scenarios/ai/strategy#microsoft-ai-decision-tree) for more guidance.

## Next step

After you define your business and technology strategies for AI agents, focus on organizational structure and talent. Your teams need the right skills and structure to deliver and sustain these solutions.

> [!div class="nextstepaction"]
> [Organizational readiness](./organization-people-readiness-plan.md)
