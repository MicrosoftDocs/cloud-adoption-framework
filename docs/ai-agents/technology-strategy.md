---
title: Technology strategy for AI agents
description: Learn the technology strategy for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Technology strategy for AI agents

Choose the optimal “buy vs build” approach for each AI agent to balance speed, cost, and customization. As a technical decision maker, you should guide a multi-track technology strategy. Some solutions can be *bought* (using prebuilt AI capabilities) to deliver value quickly, while others warrant *building* from scratch for a tailored fit. Balance quick ROI against long-term differentiation:

| **Approach** | **Best For (When to Choose)** | **Typical Time-to-ROI** | **Microsoft Solution** |
|--------------|-------------------------------|-------------------------|------------------------|
| **Prebuilt "Buy" (SaaS)** | Out-of-the-box capabilities meet your needs with minimal tweaks. | **Shorter:** Value realized almost immediately | **Microsoft 365 Copilot**<br>**Role-based Copilots**<br>**In-product Copilots** |
| **Low/no-Code Platform "Build"** | Customized solutions where you want quick development with minimal coding. | **Moderate:** Faster than full coding. | **Microsoft Copilot Studio** |
| **Pro-code "Build"** | **Strategic use cases** needing custom logic, multiple AI models, or deep integration with systems | **Longer:** Development and testing effort. | **Azure AI Foundry** |

## Prebuilt agents (Microsoft 365 Copilot)

**Explore and deploy prebuilt agents.** Start by reviewing [Microsoft 365 Copilot and prebuilt agents](/microsoft-365-copilot/extensibility/overview#extend-copilot-with-agents) to understand the range of ready-to-use solutions. These agents handle common scenarios like employee onboarding, IT helpdesk, and sales enablement. Review the [agents overview](/microsoft-365-copilot/extensibility/agents-overview) to understand how they extend Copilot's capabilities with specialized knowledge and workflows, then explore [installation and governance methods](/copilot/microsoft-365/copilot-agent-install#agent-installation-and-governance-methods) to deploy them to your organization.

**Adopt and measure value.** Follow the [Microsoft 365 Copilot adoption guide](/copilot/microsoft-365/microsoft-365-copilot-enablement-resources) to plan your rollout, including license assignment, user training, and change management. Use the [Microsoft Adoption site](https://adoption.microsoft.com/copilot) for success kits, scenario libraries, and launch materials. Track usage and impact through the [Copilot setup guide](/copilot/microsoft-365/microsoft-365-copilot-setup) which covers deployment phases, pilot programs, and reporting.

## Low-code agents (Microsoft Copilot Studio)

**Start a trial and build your first agent.** Begin by [signing up for a Copilot Studio trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#sign-up-for-a-copilot-studio-trial) to explore the platform at no cost. Then follow the [quickstart to create and deploy an agent](/microsoft-copilot-studio/fundamentals-get-started) which walks through adding knowledge, testing changes, and publishing to a demo website. For more structured guidance, explore [training modules on creating agents](/training/paths/create-extend-custom-copilots-microsoft-copilot-studio/) with exercises for building, managing topics, and working with variables.

**Extend capabilities with connectors and tools.** Enhance your agents using [Power Platform connectors](/connectors/overview#use-connectors) to integrate with over 1,200 services and business systems. Review [how to extend agent capabilities with connectors](/microsoft-copilot-studio/copilot-connectors-in-copilot-studio) to add external data sources, trigger workflows, and connect to enterprise applications. Understand [connector overview for different products](/connectors/overview#use-connectors) including Copilot Studio, Power Automate, Power Apps, and Logic Apps to leverage the full ecosystem.

## Pro-code agents (Azure AI Foundry)

**Prototype in the playground and learn the fundamentals.** Start by exploring the [Azure AI Foundry playgrounds](/azure/ai-foundry/concepts/concept-playgrounds) which provide no-code environments to test agents, iterate on prompts, and validate ideas before writing code. Review [what Azure AI Foundry Agent Service is](/azure/ai-foundry/agents/overview) to understand the agent factory model, including how models, tools, orchestration, observability, and trust features work together to create production-ready agents.

**Build custom agents with SDKs and frameworks.** Follow the [quickstart to create a new agent](/azure/ai-foundry/agents/quickstart) using Python, TypeScript, C#, or Java SDKs with step-by-step code examples. Explore [connected agents for multi-agent systems](/azure/ai-foundry/agents/how-to/connected-agents) to build collaborative workflows where specialized agents work together without custom orchestration logic. For advanced scenarios, review [agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) and implementation guidance for the [Microsoft Agent Framework](/agent-framework/user-guide/workflows/orchestrations/overview) to design sequential, concurrent, handoff, and complex multi-agent systems.

## Use a hybrid approach

Many businesses use multiple approaches in parallel based on the nature of each use case. As a technology leader, orchestrate a portfolio where individual use Copilots to get immediate improvements. Other build custom agents in Copilot Studio for specific needs. For strategic initiatives, use Azure AI Foundry for full custom development.

Diversify how you implement AI agents, matching each project’s approach to its urgency and complexity. Over time, you can consolidate or standardize where it makes sense, but initially a flexible strategy will maximize your overall ROI.

## Build prototypes

Before fully committing budget and time to a chosen approach (whether buy, low-code, or pro-code), run a quick proof-of-concept to de-risk your decision. This is a leadership best practice to ensure you’re on the right track.

1. **Time-box experiments for each option.** Allocate a short period (one to two weeks) for your team to prototype the solution using different methods. For example, if debating between a low-code Power Virtual Agents bot and a custom Azure AI build, have a small team try creating a basic version in each. Compare the development speed, the functionality achieved, and any blockers encountered. These experiments will reveal which approach delivers the needed result with the least effort or uncover unforeseen limitations.

2. **Pilot prebuilt solutions with real users.** If you’re evaluating a prebuilt Copilot, conduct a limited pilot in your environment. Enable the Copilot for a small user group and monitor usage and feedback for a couple of weeks. This will show you how well it actually addresses the use case and what adoption challenges might arise. For instance, you might discover that a sales Copilot isn’t used by reps because it doesn’t handle certain product data, indicating a gap to fill either via configuration or by choosing a different approach.

3. **Adapt based on pilot learnings.** Use the findings from prototypes and pilots to inform your go-forward plan. If a low-code prototype met requirements, you can proceed confidently with that path and allocate resources accordingly. If it fell short, you may pivot to pro-code or refine the scope. The goal is to avoid costly surprises later by doing a lightweight trial run now. Make sure to capture and discuss pilot results with stakeholders before moving to the next phase.
