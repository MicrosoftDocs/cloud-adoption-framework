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

To support business outcomes, AI agents must be integrated into your broader technology planning. Choose the optimal "buy vs build" approach for each use case to balance speed, cost, and customization. Some agents can be bought (using prebuilt AI capabilities) to deliver value quickly, while others warrant building from scratch for a tailored fit. This balance ensures quick ROI where possible and long-term differentiation where needed.

| **Approach** | **Best for** | **Microsoft solution** |
|--------------|-------------------------------|-------------------------|
| SaaS agents (buy) | Personal productivity for information workers. Minimal customization required. Immediate value. | **Microsoft 365 Copilot**<br>**Role-based Copilots**<br>**In-product Copilots** |
| Low/no-code agents (build) | Process transformation for technical business users. Fast development with minimal coding. | **Microsoft Copilot Studio** |
| Pro-code agents (build) | Strategic transformation for engineering teams. Deep integration and custom logic. | **Azure AI Foundry** |

## Understand the agent options

Here's an overview of the different agent adoption approaches. Each option presents distinct integration and data requirements that influence how teams implement and scale AI agents. These considerations affect not only technical feasibility but also the skills required across the organization.

### Azure AI Foundry (build pro code)

For strategic scenarios where AI becomes a core business capability, [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) provides the tools to build fully custom agents. Using the Agent Service and Microsoft’s open-source Agent Framework, engineering teams can develop sophisticated, multi-model agents with deep integrations and custom logic. These agents often require grounding in proprietary data sources, which means teams must prepare infrastructure and integration patterns that support scalable and secure access to internal systems. This path demands more time and technical investment but enables differentiated solutions that drive long-term value. Use the [Azure AI Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to explore and prototype before scaling. Follow the [quickstart to create a new agent](/azure/ai-foundry/agents/quickstart)

### Microsoft Copilot Studio (build low code)

When use cases require more customization but less engineering effort, [Microsoft Copilot Studio](/azure/microsoft-copilot-studio/) empowers IT pros and business users to build tailored AI agents. With a visual interface, built-in AI models, and over 1200 connectors, teams create conversational agents that integrate with business systems in weeks, not months.
Copilot Studio agents handle much of the integration complexity internally. The platform indexes connected data sources and uses built-in AI to interpret and respond to user inputs. This reduces the need for external orchestration or custom data pipelines. However, technical leaders must ensure that the systems Copilot Studio connects to are accessible, documented, and governed appropriately.

Start with a [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) to validate use cases before committing to production licenses, ensuring you have time to build prototypes and gather stakeholder feedback. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio).

### Prebuilt agents (Copilots)

Microsoft 365 Copilot includes prebuilt agents like Researcher and Analyst to support individual productivity. In addition, Microsoft offers in-product Copilots across services such as Azure, GitHub, Microsoft Fabric, and Power Platform. Role-based Copilots support functions like security, finance, and sales. These agents deliver immediate value with minimal setup and no custom development.

Prebuilt agents handle integration internally and often require only configuration and access permissions. However, technical leaders must ensure that the underlying systems and data sources are available and compatible with Copilot’s indexing and extensibility models. While Copilot can index and interpret data automatically, teams must still prepare the environment to support secure and governed access. See [Overview of Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes) and [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to understand how to deploy and manage these agents effectively.

## Hybrid approach

Many businesses use multiple approaches in parallel based on the nature of each use case. As a technology leader, orchestrate a portfolio where individual use Copilots to get immediate improvements. Other build custom agents in Copilot Studio for specific needs. For strategic initiatives, use Azure AI Foundry for full custom development.

Diversify how you implement AI agents, matching each project’s approach to its urgency and complexity. Over time, you can consolidate or standardize where it makes sense, but initially a flexible strategy will maximize your overall ROI.

## Build prototypes

Before fully committing budget and time to a chosen approach (whether buy, low-code, or pro-code), run a quick proof-of-concept to de-risk your decision. This is a leadership best practice to ensure you’re on the right track.

1. **Time-box experiments for each option.** Allocate a short period (one to two weeks) for your team to prototype the solution using different methods. For example, if debating between a low-code Power Virtual Agents bot and a custom Azure AI build, have a small team try creating a basic version in each. Compare the development speed, the functionality achieved, and any blockers encountered. These experiments will reveal which approach delivers the needed result with the least effort or uncover unforeseen limitations.

2. **Pilot prebuilt solutions with real users.** If you’re evaluating a prebuilt Copilot, conduct a limited pilot in your environment. Enable the Copilot for a small user group and monitor usage and feedback for a couple of weeks. This will show you how well it actually addresses the use case and what adoption challenges might arise. For instance, you might discover that a sales Copilot isn’t used by reps because it doesn’t handle certain product data, indicating a gap to fill either via configuration or by choosing a different approach.

3. **Adapt based on pilot learnings.** Use the findings from prototypes and pilots to inform your go-forward plan. If a low-code prototype met requirements, you can proceed confidently with that path and allocate resources accordingly. If it fell short, you may pivot to pro-code or refine the scope. The goal is to avoid costly surprises later by doing a lightweight trial run now. Make sure to capture and discuss pilot results with stakeholders before moving to the next phase.

## Next step

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
