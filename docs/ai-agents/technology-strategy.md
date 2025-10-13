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

Choose the optimal “buy vs build” approach for each AI agent to balance speed, cost, and customization. As a technical decision maker, you should guide a multi-track technology strategy. Some solutions can be *bought* (using prebuilt AI capabilities) to deliver value quickly, while others warrant *building* from scratch for a tailored fit. Balance quick ROI against long-term differentiation:

| **Approach** | **Best for** | **Microsoft solution** |
|--------------|-------------------------------|-------------------------|
| **SaaS agents (buy) | Personal productivity for anyone who works with information daily. Out-of-the-box capabilities meet your needs with minimal tweaks. Value realized almost immediately | **Microsoft 365 Copilot**<br><br>**Role-based Copilots**<br><br>**In-product Copilots** |
| **Low/no-code agents (build) | Process transformation for power users who are technical and understand business processes. Customized solutions where you want quick development with minimal coding. Faster than full coding. | **Microsoft Copilot Studio** |
| **Pro-code agents (build) | Process transformation for app developers who build application and use IDEs. Strategic use cases needing custom logic, multiple AI models, or deep integration with systems. Longer development and testing effort. | **Azure AI Foundry** |

## Understand the agent options

Here's an overview of the different agent adoption approaches:

### Azure AI Foundry

For strategic scenarios where AI becomes a core business capability, [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) provides the tools to build fully custom agents. Using the Agent Service and Microsoft’s open-source Agent Framework, engineering teams can develop sophisticated, multi-model agents with deep integrations and custom logic. It has enterprise-to-enterprise data and app connectors. This path requires more time and technical investment, but it enables differentiated solutions that drive long-term value. Use the Foundry playground to explore and prototype before scaling.

### Low-code agents (Microsoft Copilot Studio)

When your use case requires more customization, [Microsoft Copilot Studio](/azure/microsoft-copilot-studio/) offers a low-code/no-code platform that empowers IT pros and business users to build tailored AI agents. With a visual interface, built-in AI models, and over 1200 connectors, teams can create conversational agents that integrate with business system, often in weeks, not months. It's also managed with a single price. This approach balances speed and flexibility, making it ideal for departmental solutions or cross-functional workflows.

### Prebuilt agents (Copilots)

Explore Microsoft 365 Copilot, which includes prebuilt agents like Researcher and Analyst to support individual productivity. In addition, Microsoft offers in-product Copilots across services such as Azure, GitHub, Microsoft Fabric, and Power Platform. There are also role-based Copilots tailored for functions like security, finance, and sales. These agents are built to deliver immediate value with minimal setup. If a prebuilt Copilot aligns with your use case, it can be enabled and configured without custom development, making it the fastest way to integrate AI into your workflows. See [Overview of Microsoft Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes) and [Agent Success Kit.](https://adoption.microsoft.com/ai-agents/success-kit/)

## Hybrid approach

Many businesses use multiple approaches in parallel based on the nature of each use case. As a technology leader, orchestrate a portfolio where individual use Copilots to get immediate improvements. Other build custom agents in Copilot Studio for specific needs. For strategic initiatives, use Azure AI Foundry for full custom development.

Diversify how you implement AI agents, matching each project’s approach to its urgency and complexity. Over time, you can consolidate or standardize where it makes sense, but initially a flexible strategy will maximize your overall ROI.

## Build prototypes

Before fully committing budget and time to a chosen approach (whether buy, low-code, or pro-code), run a quick proof-of-concept to de-risk your decision. This is a leadership best practice to ensure you’re on the right track.

1. **Time-box experiments for each option.** Allocate a short period (one to two weeks) for your team to prototype the solution using different methods. For example, if debating between a low-code Power Virtual Agents bot and a custom Azure AI build, have a small team try creating a basic version in each. Compare the development speed, the functionality achieved, and any blockers encountered. These experiments will reveal which approach delivers the needed result with the least effort or uncover unforeseen limitations.

2. **Pilot prebuilt solutions with real users.** If you’re evaluating a prebuilt Copilot, conduct a limited pilot in your environment. Enable the Copilot for a small user group and monitor usage and feedback for a couple of weeks. This will show you how well it actually addresses the use case and what adoption challenges might arise. For instance, you might discover that a sales Copilot isn’t used by reps because it doesn’t handle certain product data, indicating a gap to fill either via configuration or by choosing a different approach.

3. **Adapt based on pilot learnings.** Use the findings from prototypes and pilots to inform your go-forward plan. If a low-code prototype met requirements, you can proceed confidently with that path and allocate resources accordingly. If it fell short, you may pivot to pro-code or refine the scope. The goal is to avoid costly surprises later by doing a lightweight trial run now. Make sure to capture and discuss pilot results with stakeholders before moving to the next phase.

## Microsoft tools

- **Azure AI Foundry:** Prototype in the playground and learn the fundamentals.** Start by exploring the [Azure AI Foundry playgrounds](/azure/ai-foundry/concepts/concept-playgrounds) which provide no-code environments to test agents, iterate on prompts, and validate ideas before writing code. Review [what Azure AI Foundry Agent Service is](/azure/ai-foundry/agents/overview) to understand the agent factory model, including how models, tools, orchestration, observability, and trust features work together to create production-ready agents. Build custom agents with SDKs and frameworks.** Follow the [quickstart to create a new agent](/azure/ai-foundry/agents/quickstart) using Python, TypeScript, C#, or Java SDKs with step-by-step code examples. Explore [connected agents for multi-agent systems](/azure/ai-foundry/agents/how-to/connected-agents) to build collaborative workflows where specialized agents work together without custom orchestration logic. For advanced scenarios, review [agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) and implementation guidance for the [Microsoft Agent Framework](/agent-framework/user-guide/workflows/orchestrations/overview) to design sequential, concurrent, handoff, and complex multi-agent systems.

- **Microsoft Copilot Studio:** Start with the [Copilot Studio overview](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to understand how this graphical, low-code tool enables anyone to build powerful custom agents without AI expertise or coding. Review [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine whether to use the standalone web app at copilotstudio.microsoft.com for IT admins building customer-facing agents, or the Teams app for internal employee-focused solutions. Licensing and trials:** Assess [licensing requirements](/microsoft-copilot-studio/requirements-licensing-subscriptions) for your deployment, including prepaid Copilot Credits ($200 per tenant per month for 25,000 credits) or pay-as-you-go options ($0.01 per Copilot Credit). Start with a [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) to validate use cases before committing to production licenses, ensuring you have time to build prototypes and gather stakeholder feedback. Development approaches:** Choose between the [lite experience in Microsoft 365 Copilot](/microsoft-365-copilot/extensibility/declarative-agent-tool-comparison#copilot-studio-lite-experience) for quick, no-code agent creation suitable for personal productivity, or the [full Copilot Studio experience](/microsoft-365-copilot/extensibility/declarative-agent-tool-comparison#copilot-studio-full-experience) with Power Platform connectors for department-level solutions requiring workflow automation and data integration. Build skills with the [Create agents in Microsoft Copilot Studio training path](/training/paths/create-extend-custom-copilots-microsoft-copilot-studio/) to prepare your teams for rapid agent development.

- **Microsoft Copilots:**

    - **Microsoft 365 Copilot:** Review the [extensibility overview](/microsoft-365-copilot/extensibility/overview) to understand how agents extend Copilot's built-in capabilities with knowledge, skills, and automated workflows. Explore [prebuilt agents available in Microsoft 365 Copilot Chat](https://m365.cloud.microsoft/m365apps/f3a6e67f-850d-4dd9-960a-04c6638ded36/app:co:copilotplugins?source=copilotChat&fromCode=pwav2&redirectId=26FCE8716E9549689003C3D9B0893F92&auth=2) built by Microsoft and partners to support common tasks like employee onboarding, IT helpdesk support, and sales enablement. Technical decision makers should assess [agent installation and governance methods](/copilot/microsoft-365/copilot-agent-install#agent-installation-and-governance-methods) to control which agents users can access through the Copilot Control System in the Microsoft 365 admin center.
    
    - **Role-based Copilots:** Evaluate specialized Copilots designed for specific business functions. [Security Copilot](/copilot/security/microsoft-security-copilot) uses consumption-based pricing through [Security Compute Units (SCUs)](/azure/copilot/security/microsoft-security-copilot), while [Sales Copilot](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Service Copilot](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Finance Copilot](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance) provide role-specific automation and insights. Review the [Copilot international availability report](https://releaseplans.microsoft.com/availability-reports/?report=copilotproductreport) to verify language and geography support for your deployment.
    
    - **In-product Copilots:** Assess in-product Copilots integrated directly into your existing tools. [GitHub Copilot](https://github.com/features/copilot) accelerates development workflows with AI-powered code suggestions. [Copilot in Power Apps](/power-apps/maker/canvas-apps/ai-overview) and [Copilot in Power Automate](/power-automate/get-started-with-copilot) enable low-code automation for business processes. [Copilot for Azure](/azure/copilot/overview) simplifies cloud management tasks, while [Copilot in Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview) enhances data analytics and insights across your data estate.

## Next step

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
