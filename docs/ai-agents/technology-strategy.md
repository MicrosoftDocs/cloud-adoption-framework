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

After defining business needs, establish a technology strategy that supports AI agent delivery. This phase defines the technical roadmap and selects appropriate tools. It also guides development effort allocation, whether to buy prebuilt solutions or build custom ones. Microsoft offers multiple implementation paths, from ready-made SaaS agents to fully custom development environments. The optimal choice depends on speed, cost, and customization requirements.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how buy vs. build technology options comparing Microsoft Copilots (buy) vs. Low-code (Microsoft Copilot Studio) and pro-code (Azure AI Foundry) build options." lightbox="./images/technology-options.png" border="false":::

Organizations often use all three approaches in parallel to meet distinct needs:

- Use SaaS Copilots to improve general productivity and deliver immediate ROI.
- Build department-specific agents in Copilot Studio as medium-term initiatives.
- Launch custom Foundry projects to support mission-critical capabilities that require long-term investment.

Organizations must assign each use case to the appropriate track based on urgency and complexity. This allocation avoids over-engineering simple tasks and prevents under-powering strategic initiatives. Standardize platforms later. Initially, focus on delivering value through flexible execution.

| Solution | Approach | Best for |
|----------|----------|----------|
| **Copilots** | SaaS agents (buy) | Personal productivity for information workers. Minimal customization required. Immediate value. |
| **Microsoft Copilot Studio** | SaaS Low/no-code agents (build) | Process transformation for technical business users. Fast development with minimal coding. |
| **Azure AI Foundry Agent Service** | PaaS pro-code agents (build) | Strategic transformation for engineering teams. Deep integration and custom logic. |

## Azure AI Foundry

**Pro-code AI Agents (build with PaaS):** Use [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) or strategic use cases where AI becomes a core business capability. This path provides maximum flexibility. Workload teams build multi-model, multi-agent solutions with custom orchestration and tooling. These agents often require grounding in proprietary data sources, so teams must prepare infrastructure and integration patterns that support scalable and secure access to internal systems. This approach demands more time and technical investment but enables differentiated solutions that drive long-term value. Use the [Azure AI Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to explore and prototype before scaling. Follow the [quickstart to create a new agent](/azure/ai-foundry/agents/quickstart)

## Microsoft Copilot Studio

**Low-code AI Agents (build SaaS):** Use [Microsoft Copilot Studio](/azure/microsoft-copilot-studio/) for scenarios that require moderate customization or specific integrations but need rapid delivery. This low-code environment enables IT or power users to build conversational agents using a visual interface and over a thousand prebuilt connectors to enterprise systems. This path suits teams with limited technical resources or tight timelines. Use the [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) to validate use cases before committing to production licenses, ensuring you have time to build prototypes and gather stakeholder feedback. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio).

## Copilots

**Pre-built agents (buy SaaS):** Use Copilot agents for standard tasks that require minimal setup. These agents support personal productivity and routine processes where out-of-the-box capabilities meet business needs. The primary decision involves enabling the service and configuring data access.
Microsoft 365 Copilot includes agents such as Researcher and Analyst. Microsoft also embeds Copilots across Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support functions like security, finance, and sales. These agents manage integration internally and typically require only configuration and access permissions. See [Overview of Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes). Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to understand how to deploy and manage Copilots.

## Build prototypes

Validate each AI agent approach through structured experimentation before allocating substantial resources. This step confirms alignment with business objectives, technical feasibility, and team readiness.

1. **Run time-boxed experiments.** Direct teams to build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare a low-code agent built in Copilot Studio with a custom solution using Azure AI Foundry. Evaluate each prototype based on:

    - Development speed and usability
    - Functional coverage and extensibility
    - Integration complexity and technical blockers

2. **Define the implementation plan.** Require teams to document and present findings. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to a pro-code approach or adjust the scope. Ensure stakeholders review pilot outcomes before scaling. This review reduces rework and increases confidence in the selected path.

3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents. Avoid unnecessary complexity. Evaluate whether a single agent meets business needs efficiently. Refer to [Single or multi-agent system?](./single-multi-agent-systems.md).

## Next step

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
