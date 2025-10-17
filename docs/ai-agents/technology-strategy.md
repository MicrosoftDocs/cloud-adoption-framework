---
title: Technology strategy for AI ag### Azure AI Foundry
description: Learn the technology strategy for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Technology strategy for AI agents

Once the business needs are defined, establish a clear technology strategy to deliver AI agent solutions. This phase focuses on selecting the appropriate tools and setting a technical roadmap. It guides development effort allocation (buy vs. build).

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how buy vs. build technology options comparing Microsoft Copilots (buy) vs. Low-code (Microsoft Copilot Studio) and pro-code (Azure AI Foundry) build options." lightbox="./images/technology-options.png" border="false":::

Microsoft provides multiple paths to implement AI agents, ranging from ready-made SaaS solutions to fully custom development. The optimal choice balances speed, cost, and customization:

| Solution | Approach | Best for |
|----------|----------|----------|
| **Copilots** | SaaS agents (buy) | Personal productivity for information workers. Minimal customization required. Immediate value. |
| **Microsoft Copilot Studio** | SaaS Low/no-code agents (build) | Process transformation for technical business users. Fast development with minimal coding. |
| **Azure AI Foundry Agent Service** | PaaS pro-code agents (build) | Strategic transformation for engineering teams. Deep integration and custom logic. |

## Azure AI Foundry

**Pro-code AI Agents (build with PaaS):** For strategic use cases where AI becomes a core business capability, [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) provides the tools to build fully custom agents. This approach gives maximum flexibility. Your workload teams can develop multi-model, multi-agent solutions with custom orchestration and tooling. These agents often require grounding in proprietary data sources, which means teams must prepare infrastructure and integration patterns that support scalable and secure access to internal systems. This path demands more time and technical investment but enables differentiated solutions that drive long-term value. Use the [Azure AI Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to explore and prototype before scaling. Follow the [quickstart to create a new agent](/azure/ai-foundry/agents/quickstart)

## Microsoft Copilot Studio

**Low-code AI Agents (build SaaS):** WFor scenarios requiring moderate customization, specific processes or integrations, but where you want to deliver quickly, [Microsoft Copilot Studio](/azure/microsoft-copilot-studio/) provides a low-code development environment. It allows IT or power users to build conversational agents with a visual interface and over a thousand pre-built connectors to enterprise systems. This is a good middle path when technical resources are limited or time-to-market is critical. Decision makers should consider if the use case can be met by assembling components in Copilot Studio, which often takes weeks instead of months. A[60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) to validate use cases before committing to production licenses, ensuring you have time to build prototypes and gather stakeholder feedback. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio).

## Copilots

**Pre-built agents (buy SaaS):** For standard tasks, Copilot agents deliver immediate value with minimal setup. These agents suit personal productivity or routine processes where out-of-the-box capabilities meet the need. The primary decision involves enabling the service and ensuring data access.

Microsoft 365 Copilot includes agents such as Researcher and Analyst to support individual productivity. Microsoft also embeds Copilots across Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support functions like security, finance, and sales. These prebuilt agents manage integration internally and typically require only configuration and access permissions. See [Overview of Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes). Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to understand how to deploy and manage Copilots.

## Hybrid approach

Organizations often use all three AI agent approaches in parallel to meet distinct needs. For example, enable SaaS Copilots to improve general productivity and deliver immediate ROI. Use Copilot Studio to build department-specific agents as medium-term initiatives. In parallel, initiate a custom Foundry project to support mission-critical capabilities that require long-term investment. Technology leaders must assign each use case to the appropriate track based on urgency and complexity. This approach prevents over-engineering simple tasks and avoids under-powering strategic initiatives. Standardize platforms later. Initially, prioritize value delivery through flexible execution.

## Build prototypes

Before allocating substantial resources to any AI agent solution, whether through Azure AI Foundry, Microsoft Copilot Studio, or prebuilt Copilots, validate the approach through structured experimentation. This step confirms alignment with business objectives, technical feasibility, and team readiness.

1. **Run time-boxed experiments.** Direct teams to build short prototypes for each candidate solution. Allocate one to two weeks per option to develop a basic version using different methods. For example, compare a low-code agent built in Copilot Studio with a custom solution using Azure AI Foundry. Evaluate each prototype based on:

    - Development speed and usability
    - Functional coverage and extensibility
    - Integration complexity and technical blockers

    This process identifies the most viable path without committing long-term resources prematurely.

2. **Define the implementation plan.** Require teams to document and present their findings from each prototype. If a low-code solution satisfies functional and security requirements, proceed with that option. If it does not, shift to a pro-code approach or adjust the scope accordingly. Ensure stakeholders review the pilot outcomes before scaling. This review process reduces rework and increases confidence in the selected path.

3. **Assess single-agent versus multi-agent architecture.** Use the prototype to determine whether the task requires multiple specialized agents. Avoid introducing complexity unless the requirements clearly justify a multi-agent system. Evaluate whether a single agent can meet the business needs efficiently. For deeper guidance, refer to [Single or multi-agent system?](./single-multi-agent-systems.md).

## Next step

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
