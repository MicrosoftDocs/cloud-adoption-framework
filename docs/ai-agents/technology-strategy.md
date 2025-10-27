---
title: Technology strategy for AI ag### Azure AI Foundry
description: Learn the technology strategy for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Technology strategy for AI agents

To build on the business strategy for AI agents, decision makers must now define a technology strategy that supports the delivery of those agents across the organization. The business strategy already identifies where AI agents create value whether through customer engagement, operational efficiency, or innovation. The technology strategy must now determine how to deliver those agents effectively, balancing speed, cost, and customization.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options comparing Microsoft Copilots (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Azure AI Foundry) build options." lightbox="./images/technology-options.png" border="false":::

## Technology options for agent delivery

Microsoft provides three distinct agent platforms: prebuilt SaaS Copilots, low-code agents in Microsoft Copilot Studio, and pro-code agents built with Azure AI Foundry. Each path supports different business needs and [agent types](./index.md#types-of-agents). Organizations rarely choose just one. Instead, they often use all three approaches in parallel to meet distinct needs across departments, timelines, and levels of complexity.

| Solution | Approach | Agent types | Best for |
|----------|----------|-------------| -------- |
| **Azure AI Foundry Agent Service** | Build with PaaS for pro-code agents | Retrieval, Task, Autonomous | Strategic transformation for engineering teams. Deep integration and custom logic. |
| **Microsoft Copilot Studio** | Build with SaaS for low-code or no-code agents | Retrieval, Task, Autonomous | Process transformation for technical business users. Fast development with minimal coding. |
| **GPUs & containers** | Build with IaaS for pro-code agents | Retrieval, Task, Autonomous |Full control of the entire technology stack.|
| **Copilots** | Read-to-use agents (SaaS) | Retrieval, Task | Personal productivity for information workers. Minimal customization required. Immediate value. |

## Build paths for AI agents

Each build path supports different levels of control, investment, and governance. The choice depends on business priorities and technical capabilities.

:::image type="content" source="./images/build-overview.png" alt-text="Diagram that shows an overview of the build agent options." lightbox="./images/build-overview.png" border="false":::

### Azure AI Foundry

**Build with PaaS for pro-code agents.** Use [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) to build pro-code agents for high-value scenarios. This platform-as-a-service (PaaS) model supports full customization, including model selection, infrastructure control, and proprietary data integration. Foundry suits engineering-led organizations that require multi-agent systems and deep integration with internal systems.

Foundry supports all three agent types. Retrieval agents provide fast, accurate responses. Task agents automate structured workflows. Autonomous agents orchestrate complex processes and adapt to changing conditions. Foundry embeds Microsoft’s responsible AI engineering practices, including tools for fairness evaluation and content safety, which simplifies compliance and accelerates deployment.

Use the [Azure AI Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build prototypes before scaling. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart).

### Microsoft Copilot Studio

**Build with SaaS for low-code or no-code agents.** Use [Microsoft Copilot Studio](/microsoft-copilot-studio/) to build low-code agents through a managed SaaS platform. This path suits business-led teams that need fast delivery with moderate customization. Copilot Studio supports retrieval and task agents by default and can support autonomous agents when integrated with Azure AI components.

Copilot Studio includes over a thousand prebuilt connectors for business systems and supports integration with Azure AI Search and fine-tuned models. Built-in responsible AI features such as content moderation and access controls reduce the need for custom safeguards. The [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) provides a low-risk opportunity to validate use cases before committing to production. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio).

### GPUs and containers

**Build with IaaS for pro-code agents:** to build agents when full control over the technology stack is essential. This path supports all agent types and suits organizations with advanced engineering capabilities and strict infrastructure requirements.

Retrieval and task agents remain predictable and easier to govern. Autonomous agents require extensive testing and monitoring to ensure reliability. Development typically occurs in Visual Studio Code and GitHub, with pricing based on token usage and compute resources. For more information, see [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

### Microsoft Agent Framework

The [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) provides an open-source development kit for building individual AI agents and orchestrating multi-agent workflows. This framework applies specifically to pro-code development paths: Azure AI Foundry and GPU/container environments. It does not apply to Microsoft Copilot Studio or ready-to-use Copilots, which provide their own orchestration mechanisms.

Organizations use the Microsoft Agent Framework when they need more control over agent orchestration than Azure AI Foundry's built-in capabilities provide. The framework combines enterprise-grade features with abstractions for single-agent and multi-agent patterns. It supports .NET and Python and integrates with Azure OpenAI and OpenAI.

The framework suits teams that require custom multi-agent workflows, specific programming language support, or graph-based orchestration patterns. Two protocols facilitate agent communication:

- [Model Context Protocol (MCP)](/agent-framework/user-guide/model-context-protocol/) standardizes how agents connect with external tools and data sources.
- [Agent-to-Agent (A2A) protocol](/agent-framework/user-guide/agents/agent-types/a2a-agent) enables agents to discover each other and coordinate tasks programmatically.

These protocols reduce custom integration work and ensure consistent communication across multi-agent systems.

## Ready-to-use agents (Copilots)

**Read-to-use agents (SaaS):** Use ready-to-use Copilots to deploy retrieval and task agents quickly. These agents support common tasks such as summarization, drafting, and data analysis. They integrate directly into Microsoft 365, GitHub, and Power Platform.

Copilots operate within Microsoft-managed SaaS platforms and inherit responsible AI engineering by default. This includes privacy protections, ethical safeguards, and compliance with global standards. These built-in controls reduce risk and simplify governance.

Microsoft 365 Copilot includes agents such as Researcher and Analyst. Microsoft also embeds Copilots across Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support functions like security, finance, and sales. See [Overview of available Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes). Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to understand how to deploy and manage Copilots.

## Validate technology choices

To confirm the right technology path for AI agent delivery, decision makers must validate platform fit through structured experimentation. This step ensures that each approach aligns with business objectives, technical feasibility, and team readiness before scaling across the cloud estate. It also reduces the risk of misalignment between business needs and technical capabilities.

Organizations often use all three implementation paths, Copilots, Microsoft Copilot Studio, and Azure AI Foundry, in parallel. Each path serves distinct needs, and experimentation helps clarify which one fits best for each use case.

1. **Run time-boxed experiments.** Direct teams to build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare a low-code agent built in Copilot Studio with a custom solution using Azure AI Foundry. Evaluate each prototype based on:

    - Development speed and usability
    - Functional coverage and extensibility
    - Integration complexity and technical blockers

    This comparison provides tangible evidence of what each platform can deliver and how well it supports the intended business outcomes.

2. **Require documentation and stakeholder review.** Instruct teams to document their findings and present a clear implementation recommendation. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to a pro-code approach or adjust the scope. Require stakeholders to review pilot outcomes before scaling. This review process increases confidence in the selected path and reduces rework.

3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents or a single agent. Avoid unnecessary complexity. If a single agent meets business needs efficiently, proceed with that model. If not, define a roadmap for multi-agent orchestration. Refer to [Single or multi-agent system?](./single-multi-agent-systems.md).

By validating platform fit early, you ensure that each AI agent initiative remains grounded in business value and technical feasibility. This structured approach supports faster delivery, better resource allocation, and more effective scaling across the organization.

## Next step

After you define your business and technology strategies for AI agents, you must focus on the organizational structure and talent required to deliver and sustain these solutions.

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
