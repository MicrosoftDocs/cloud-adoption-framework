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

Microsoft provides three distinct agent platforms: prebuilt SaaS Copilots, low-code agents in Microsoft Copilot Studio, and pro-code agents built with Azure AI Foundry. Each path supports different business needs and technical capabilities. Organizations rarely choose just one. Instead, they often use all three approaches in parallel to meet distinct needs across departments, timelines, and levels of complexity.

| Solution | Approach | Best for |
|----------|----------|----------|
| **Azure AI Foundry Agent Service** | Build - PaaS pro-code agents | Strategic transformation for engineering teams. Deep integration and custom logic. |
| **Microsoft Copilot Studio** | Build - Low/no-code agents | Process transformation for technical business users. Fast development with minimal coding. |
| **GPUs & containers** | Build - IaaS pro-code agents | Full control of the entire technology stack.
| **Copilots** | Ready-to-use - SaaS agents| Personal productivity for information workers. Minimal customization required. Immediate value. |

## Technologies to build AI agents

Organizations must choose build paths for AI agents that align with their business priorities, technical capabilities, and governance requirements. The following options reflect three distinct approaches. Each is suited to different levels of customization, control, and investment.

:::image type="content" source="./images/build-overview.png" alt-text="Diagram that shows an overview of the build agent options." lightbox="./images/build-overview.png" border="false":::

### Azure AI Foundry

**Build with PaaS for pro-code agents.** Use [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) o develop agents for high-value scenarios where AI becomes a core business capability. This platform-as-a-service (PaaS) model supports full customization. Teams select their own AI models and infrastructure, including conversation storage in Cosmos DB. Pricing is based on token usage, and development occurs in environments such as Visual Studio Code, GitHub, and the Foundry portal.
This option suits engineering-led organizations that require multi-agent systems, proprietary data grounding, and deep integration with internal systems. Although this path demands greater technical investment and longer timelines, it enables differentiated capabilities that drive long-term business value.

Azure AI Foundry embeds Microsoft’s responsible AI engineering practices into the platform. These include tools for model interpretability, fairness evaluation, and content safety. By using this PaaS foundation, organizations inherit governance controls aligned with Microsoft’s Responsible AI Standard. This reduces the need to build compliance mechanisms from scratch and accelerates responsible deployment at scale.

Use the [Azure AI Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build prototypes before scaling. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart).

### Microsoft Copilot Studio

**Build with SaaS for low-code or no-code agents.** Use [Microsoft Copilot Studio](/microsoft-copilot-studio/) to build conversational agents through a low-code interface. This software-as-a-service (SaaS) model provides fully managed orchestration and conversation storage. Pricing is typically per message, and development occurs within the Copilot Studio environment.

Many organizations combine low-code development with Azure AI capabilities to address complex scenarios while maintaining the security and reliability of a SaaS platform. Copilot Studio supports integration with Azure AI Search, fine-tuned models, and even Azure AI Foundry components. With access to over a thousand prebuilt connectors, teams can integrate agents with business systems quickly and with minimal overhead.

Copilot Studio includes built-in responsible AI features such as content moderation, data protection, and access controls. These features reflect Microsoft’s responsible AI engineering and reduce the burden on teams to implement safeguards independently. Use this path for process transformation initiatives that require moderate customization and fast delivery.

The [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) provides a low-risk opportunity to validate use cases before committing to production. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio).

### GPUs and containers

**Build with IaaS for pro-code agents:** Use infrastructure-as-a-service (IaaS) to build agents when full control over the technology stack is essential. This path supports custom storage, model selection, and orchestration. Pricing depends on token usage and compute resources. Development typically occurs in Visual Studio Code and GitHub.

This option suits organizations with advanced engineering capabilities and strict infrastructure requirements. It enables full-stack customization but requires significant effort to manage scalability, reliability, and compliance independently.. For more information, see [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

## Ready-to-use agents (Copilots)

**Read-to-use agents (SaaS):** Prebuilt Copilots offer the fastest route to productivity gains. These agents require minimal setup and support common tasks such as summarization, drafting, and data analysis. They integrate directly into Microsoft 365, GitHub, and Power Platform, and serve information workers who benefit from embedded intelligence.

Because these agents run on Microsoft-managed SaaS platforms, they inherit Microsoft’s responsible AI engineering by default. This includes privacy protections, ethical safeguards, and compliance with global standards. These built-in controls reduce risk and simplify governance, especially for organizations that prioritize speed and consistency over deep customization.

Microsoft 365 Copilot includes agents such as Researcher and Analyst. Microsoft also embeds Copilots across Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support functions like security, finance, and sales. These agents manage integration internally and typically require only configuration and access permissions. See [Overview of available Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes). Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to understand how to deploy and manage Copilots.

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
