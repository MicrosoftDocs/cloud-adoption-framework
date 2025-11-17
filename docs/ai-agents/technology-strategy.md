---
title: Technology strategy for AI agents
ms.reviewer: ssumner
description: Learn how to define a technology strategy for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/11/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Technology plan for AI agents

Defining a technology strategy for AI agents is essential after establishing a business strategy. The business strategy identifies where AI agents create value through customer engagement, operational efficiency, and innovation. The technology strategy determines how to deliver these agents by selecting appropriate platforms, balancing implementation speed with customization needs, and managing costs effectively. This guidance helps technical decision makers evaluate options and make informed choices.

## Select AI technology options

Organizations must decide when to use AI agents and when alternative approaches are more suitable. The decision depends on process complexity, customization requirements, and available resources.

:::image type="content" source="./images/ai-agent-decision-tree.png" alt-text="Decision tree diagram showing when to use traditional AI apps, generative AI apps, SaaS agents, and AI agents you build." lightbox="./images/ai-agent-decision-tree.png" border="false":::

1. **Build a tradition AI app.** Use traditional AI applications when processes follow clear rules, have structured workflows, and rely on consistent inputs and outputs. These scenarios do not require agents. Instead, use tools such as Microsoft Fabric for Data Science and Azure Machine Learning to build non-generative AI applications.

2. **Build a generative AI app.** Choose a generative AI chatbot when the goal is to answer questions using a defined set of organizational data without complex retrieval or orchestration. Azure OpenAI or Foundry can support these use cases effectively.

3. **Use SaaS agents.** If prebuilt solutions meet functional and budget requirements, adopt SaaS agents before building custom ones. Microsoft 365 Copilot, GitHub Copilot, Dynamics Copilot, and Security Copilot provide ready-to-use options for productivity and business process automation. Review the [Overview of available Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes) to identify relevant options. Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to plan your deployment and management approach.

4. **Build AI agents.** When SaaS agents do not meet requirements, consider building custom agents using one of these approaches:

    - Foundry Agent Service for pro-code development
    - Microsoft Copilot Studio for low-code/no-code scenarios
    - Virtual machines for highly regulated environments requiring full control

## Solutions to build AI agents

Each build path offers different levels of control, investment, and governance complexity. Select the path that aligns with business priorities and technical capabilities.

:::image type="content" source="./images/build-overview.png" alt-text="Diagram that shows an overview of the build agent options." lightbox="./images/build-overview.png" border="false":::

### Foundry Agent Service

The [Foundry Agent Service](/azure/ai-foundry/agents/overview) provides a platform-as-a-service (PaaS) model for pro-code development. It supports full customization, including model selection, infrastructure control, and data integration. Foundry is best for organizations with strong engineering capabilities and high-value scenarios. It includes responsible AI tools for fairness evaluation and content safety, simplifying compliance. Start with the [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build and test prototypes. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart) and validate your use case.

### Microsoft Copilot Studio

Use [Microsoft Copilot Studio](/microsoft-copilot-studio/) offers a software-as-a-service (SaaS) platform for low-code development. It enables business teams to deploy agents quickly with moderate customization. The platform includes prebuilt connectors, supports retrieval and task agents, and integrates with Azure AI Search. Built-in responsible AI features reduce the need for custom safeguards. Test use cases with the  [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) before committing to production deployment. Review available [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine the best entry point for your organization.

### Virtual machines and agents

Deploy agents on GPU infrastructure and containers when complete control of the technology stack is required. This infrastructure-as-a-service (IaaS) approach supports all agent types and meets strict compliance or data residency requirements. Development uses Visual Studio Code and GitHub, with costs based on token consumption and compute usage. See  [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

## Agent frameworks

When building agent-based solutions, organizations must decide whether to use built-in orchestration or adopt an external framework. This decision affects flexibility, scalability, and governance.

**Built-in orchestration**: Foundry Agent Service's native orchestration offers simplicity and speed. It integrates tightly with Foundry services and minimizes setup overhead. However, this approach limits flexibility and cross-platform scalability.

**External frameworks**: External frameworks such as the [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) provide greater control and adaptability. They support both single-agent and multi-agent orchestration in PaaS and IaaS deployments. These frameworks work with standard protocols that simplify integration and improve maintainability:

- Model Context Protocol (MCP): Defines consistent interaction patterns between agents and external tools or data sources. See [Model Context protocol](/agent-framework/user-guide/model-context-protocol/).
- Agent-to-Agent (A2A) Protocol: Enables programmatic agent discovery and coordination for dynamic multi-agent workflows. See [A2A protocol](/agent-framework/user-guide/agents/agent-types/a2a-agent)

External frameworks require more engineering effort and governance but deliver long-term benefits in interoperability and scalability. If advanced orchestration or multi-cloud integration is a priority, adopt these frameworks early and establish governance standards for MCP and A2A protocols. Action steps for decision makers:

1. Inventory existing integrations and frameworks.
1. Clarify scalability and governance requirements.
1. Run pilot tests with external frameworks to validate fit.
1. Define standards for protocol adoption to ensure security and consistency.

## Validate technology choices

Organizations often use multiple approaches to meet diverse requirements. Validate platform fit through structured experimentation before scaling.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options comparing Microsoft Copilots (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Foundry) build options." lightbox="./images/technology-options.png" border="false":::

1. **Run time-boxed experiments.** Build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare low-code agents in Copilot Studio with pro-code solutions in Foundry. Evaluate development speed, functional coverage, and integration complexity.

2. **Require documentation and stakeholder review.** Document findings and present clear recommendations. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to pro-code or adjust scope. Stakeholder review reduces rework and increases confidence.

3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents or a single agent. Avoid unnecessary complexity. If a single agent meets business needs efficiently, proceed with that approach. If not, define a roadmap for multi-agent orchestration. Refer to [Single or multi-agent system?](./single-multi-agent-systems.md).

| Solution | Approach | Agent types | Best for |
|----------|----------|-------------| -------- |
| **SaaS agents** | Ready-to-use agents (SaaS) | Retrieval, Task | Personal productivity for information workers. Minimal customization required. Immediate value. |
| **Foundry Agent Service** | Build with PaaS for pro-code agents | Retrieval, Task, Autonomous | Strategic transformation for engineering teams. Deep integration and custom logic. |
| **Microsoft Copilot Studio** | Build with SaaS for low-code or no-code agents | Retrieval, Task, Autonomous | Process transformation for technical business users. Fast development with minimal coding. |
| **Virtual machines** | Build with IaaS for pro-code agents | Retrieval, Task, Autonomous |Full control of the entire technology stack.|

## Next step

After you define your business and technology strategies for AI agents, you must focus on the organizational structure and talent required to deliver and sustain these solutions.

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
