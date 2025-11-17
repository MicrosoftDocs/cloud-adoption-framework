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

# Technology strategy for AI agents

After defining your business strategy for AI agents, you must now establish a technology strategy that enables effective agent delivery across your organization. Your business strategy identifies where AI agents create value through customer engagement, operational efficiency, and innovation. Your technology strategy determines how to deliver these agents by selecting the right platforms, balancing implementation speed with customization needs, and managing costs effectively.

## Select technology options

Microsoft provides multiple options to adopt agents. For each AI agent use case, you choose the option that best meets your business requirements and technical capabilities. Each platform enables specific [agent types](./index.md#types-of-agents) and development approaches.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options comparing Microsoft Copilots (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Foundry) build options." lightbox="./images/technology-options.png" border="false":::

Organizations adopt multiple approaches to address varying requirements across departments, project timelines, and technical complexity levels.

| Solution | Approach | Agent types | Best for |
|----------|----------|-------------| -------- |
| **SaaS agents** | Ready-to-use agents (SaaS) | Retrieval, Task | Personal productivity for information workers. Minimal customization required. Immediate value. |
| **Foundry Agent Service** | Build with PaaS for pro-code agents | Retrieval, Task, Autonomous | Strategic transformation for engineering teams. Deep integration and custom logic. |
| **Microsoft Copilot Studio** | Build with SaaS for low-code or no-code agents | Retrieval, Task, Autonomous | Process transformation for technical business users. Fast development with minimal coding. |
| **Virtual machines** | Build with IaaS for pro-code agents | Retrieval, Task, Autonomous |Full control of the entire technology stack.|

:::image type="content" source="./images/ai-agent-decision-tree.png" alt-text="Decision tree diagram showing when to use traditional AI apps, generative AI apps, SaaS agents, and AI agents you build." lightbox="./images/ai-agent-decision-tree.png" border="false":::

## Choose build paths for AI agents

Each build path offers different levels of control, required investment, and governance complexity. Select your path based on your business priorities and technical capabilities.

:::image type="content" source="./images/build-overview.png" alt-text="Diagram that shows an overview of the build agent options." lightbox="./images/build-overview.png" border="false":::

### Foundry Agent Service

Use [Foundry Agent Service](/azure/ai-foundry/agents/overview) when you need pro-code agents for high-value scenarios. This platform-as-a-service (PaaS) approach provides full customization capabilities, including model selection, infrastructure control, and data integration. Foundry works best for organizations with strong engineering capabilities. You can build retrieval agents, task agents, and autonomous agents.

The platform includes Microsoft's responsible AI engineering practices with built-in tools for fairness evaluation and content safety. These features simplify compliance requirements and accelerate your deployment timeline. Start development using the [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build and test prototypes. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart) and validate your use case.

### Microsoft Copilot Studio

Use [Microsoft Copilot Studio](/microsoft-copilot-studio/) when business teams need rapid agent deployment with moderate customization requirements. This software-as-a-service (SaaS) platform enables low-code development that business-led teams can manage independently. Copilot Studio natively supports retrieval and task agents and enables autonomous agents through Azure AI component integration.

The platform provides over one thousand prebuilt connectors for common business systems. You can integrate with Azure AI Search and deploy fine-tuned models without extensive coding. Built-in responsible AI features include content moderation and access controls that reduce your need for custom safeguards.

Test your use cases with the [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) before committing to production deployment. Review available [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine the best entry point for your organization.

### GPUs and containers

Deploy agents on GPU infrastructure and containers when you need complete control over your technology stack. This infrastructure-as-a-service (IaaS) approach supports all agent types and works best for organizations with advanced engineering capabilities and strict infrastructure requirements.

This path enables you to:
1. Control every aspect of your agent architecture
2. Optimize performance for specific workloads
3. Meet stringent compliance or data residency requirements

Develop your agents using Visual Studio Code and GitHub, with costs based on token consumption and compute resource usage. For detailed guidance, see [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

### Microsoft Agent Framework and protocols

The [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) provides an open-source development kit for building individual agents and orchestrating multi-agent workflows. Use this framework with pro-code development paths on Foundry and GPU/container environments. The framework does not apply to Microsoft Copilot Studio or ready-to-use Copilots, which include their own orchestration mechanisms.

Deploy the Microsoft Agent Framework when you need greater control over agent orchestration than Foundry's built-in capabilities provide. The framework delivers enterprise-grade features with abstractions for both single-agent and multi-agent patterns.

Standardize agent communication across your cloud estate using two key protocols:

1. **Model Context Protocol (MCP):** Implement the [Model Context Protocol](/agent-framework/user-guide/model-context-protocol/) to define consistent interaction patterns between agents and external tools or data sources. This protocol simplifies connection processes and ensures uniformity across different agent implementations.

2. **Agent-to-Agent (A2A) Protocol:** Deploy the [A2A protocol](/agent-framework/user-guide/agents/agent-types/a2a-agent) to enable programmatic agent discovery and coordination. This protocol supports dynamic and scalable multi-agent workflows across your organization.

These protocols reduce custom integration requirements, lower operational risk, and improve system maintainability. For organizations managing multiple AI agents across departments, adopting these standards ensures reliable and secure agent communication.

## Ready-to-use agents (Copilots)

Use ready-to-use Copilots for immediate deployment of retrieval and task agents. These agents handle common tasks including summarization, drafting, and data analysis. They integrate directly with Microsoft 365, GitHub, and Power Platform without custom development.

Copilots operate within Microsoft-managed SaaS platforms and include responsible AI engineering by default. You receive built-in privacy protections, ethical safeguards, and compliance with global standards. These controls reduce your risk exposure and simplify governance requirements.

Microsoft 365 Copilot includes specialized agents such as Researcher and Analyst. Additional Copilots exist across Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support specific functions including security, finance, and sales operations. Review the [Overview of available Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes) to identify relevant options. Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to plan your deployment and management approach.

## Validate technology choices

To confirm the right technology path for AI agent delivery, decision makers must validate platform fit through structured experimentation. This step ensures that each approach aligns with business objectives, technical feasibility, and team readiness before scaling across the cloud estate. It also reduces the risk of misalignment between business needs and technical capabilities.

Organizations often use all three implementation paths, Copilots, Microsoft Copilot Studio, and Foundry, in parallel. Each path serves distinct needs, and experimentation helps clarify which one fits best for each use case.

1. **Run time-boxed experiments.** Direct teams to build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare a low-code agent built in Copilot Studio with a custom solution using Foundry. Evaluate each prototype based on:

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
