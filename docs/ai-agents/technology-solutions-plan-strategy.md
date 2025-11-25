---
title: Technology plN for AI agents
ms.reviewer: ssumner
description: Learn how to define a technology plan for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/11/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Technology plan for AI agents

After establishing that a use case requires AI agents, decide whether to adopt ready-to-use SaaS agents or build custom agents. Ready-to-use SaaS agents reduce time to value and operational complexity but offer limited customization. Custom-built agents provide full control and deeper integration but require more development resources and ongoing maintenance. Evaluate functional requirements, timeline, budget, and internal capabilities to guide this decision.

:::image type="content" source="./images/ai-agent-decision-tree.png" alt-text="Decision tree diagram showing when to use traditional AI apps, generative AI apps, SaaS agents, and AI agents you build." lightbox="./images/ai-agent-decision-tree.png" border="false":::

## Adopt SaaS agents

Prioritize prebuilt solutions when they meet functional and budget requirements. SaaS agents reduce development overhead and accelerate deployment.

- **Agents in Microsoft 365 Copilot.** [App Builder agent](/copilot/microsoft-365/app-builder-privacy-data-subject-request-faq), [Workflows agent](/copilot/microsoft-365/flow-builder-privacy-data-subject-request-faq), and [Researcher](/copilot/microsoft-365/researcher-agent) enable task automation and information synthesis across Microsoft 365 applications. Use the [Agent Success Kit](https://adoption.microsoft.com/ai-agents/success-kit/) to structure your deployment approach and governance model.

- **Other SaaS agents.** [GitHub Copilot agents](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent) support coding tasks, [Microsoft Fabric data agents](/fabric/data-science/concept-data-agent) enable data analysis, [Azure Copilot agents](/azure/copilot/agents-preview) provide infrastructure insights, [Dynamics 365 agents](/dynamics365/customer-service/administer/overview-bots) automate customer service workflows, and [Security Copilot agents](/copilot/security/agents-overview) enhance threat detection and response. These agents deliver immediate capabilities for domain-specific productivity and process automation. For additional context, see [Overview of available Copilots](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes).

When no SaaS agents meet your functional requirements, build custom agents to achieve the necessary capabilities and integration depth.

## Build AI agents

Choose a build path based on your organization's technical capabilities, timeline, and control requirements. Microsoft provides two primary platforms: Foundry for pro-code development with maximum flexibility, and Copilot Studio for low-code development with faster deployment.

:::image type="content" source="./images/build-overview.png" alt-text="Diagram that shows an overview of the build agent options." lightbox="./images/build-overview.png" border="false":::

### Microsoft Foundry

[Microsoft Foundry](/azure/ai-foundry/agents/overview) provides a platform-as-a-service (PaaS) model for pro-code development. It supports full customization, including model selection, infrastructure control, and data integration. Foundry is best for organizations with strong engineering capabilities and high-value scenarios. It includes responsible AI tools for fairness evaluation and content safety, simplifying compliance. Start with the [Foundry playground](/azure/ai-foundry/concepts/concept-playgrounds) to build and test prototypes. Follow the quickstart guide to [create a new agent](/azure/ai-foundry/agents/quickstart) and validate your use case.

### Microsoft Copilot Studio

[Microsoft Copilot Studio](/microsoft-copilot-studio/) offers a software-as-a-service (SaaS) platform for low-code development. It enables business teams to deploy agents quickly with moderate customization. The platform includes prebuilt connectors, supports retrieval and task agents, and integrates with Azure AI Search. Built-in responsible AI features reduce the need for custom safeguards.

You can use Copilot Studio's low-code interface with Foundry's advanced models to handle sophisticated use cases while maintaining SaaS security and reliability. This hybrid approach allows business teams to build agents without extensive coding while accessing enterprise-grade AI capabilities. The combination reduces development time compared to full pro-code solutions while providing more customization than standard SaaS agents.

Test use cases with the [60-day free trial](/microsoft-copilot-studio/requirements-licensing-subscriptions#copilot-studio-for-microsoft-teams-plans) before committing to production deployment. Review available [access options](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio#access-copilot-studio) to determine the best entry point for your organization.

### Virtual machine agents

You can also choose to deploy agents on GPU infrastructure using Azure Virtual Machines with containers as an alternative. While this guidance does not provide detailed steps for that approach, it can be useful when you need flexibility for custom configurations, integration with existing VM-based workloads, or scenarios requiring advanced security controls. Development uses Visual Studio Code and GitHub. Costs scale with token consumption and compute usage. For deployment guidance, see [AI on IaaS](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/cycle-cloud).

## Validate technology choices

Organizations often use multiple approaches to meet diverse requirements. Validate platform fit through structured experimentation before scaling.

:::image type="content" source="./images/technology-options.png" alt-text="Diagram that shows how to ready-to-use vs. build technology options comparing Microsoft Copilots (ready-to-use) vs. Low-code (Microsoft Copilot Studio) and pro-code (Foundry) build options." lightbox="./images/technology-options.png" border="false":::

1. **Run time-boxed experiments.** Build short prototypes for each candidate solution. Allocate one to two weeks per option. Compare low-code agents in Copilot Studio with pro-code solutions in Foundry. Evaluate development speed, functional coverage, and integration complexity.
2. **Require documentation and stakeholder review.** Document findings and present clear recommendations. If a low-code solution meets functional and security requirements, proceed with that option. If not, shift to pro-code or adjust scope. Stakeholder review reduces rework and increases confidence.
3. **Assess single-agent versus multi-agent architecture.** Use prototypes to determine whether the task requires multiple specialized agents or a single agent. Avoid unnecessary complexity. If a single agent meets business needs efficiently, proceed with that approach. If not, define a roadmap for multi-agent orchestration. Refer to [Single agent or multiple agents?](./single-multi-agent-systems.md).

| Solution | Approach | Agent types | Best for |
| :--- | :--- | :--- | :--- |
| **SaaS agents** | Ready-to-use (SaaS) | Retrieval, Task | Personal productivity. Requires minimal customization to deliver immediate value. |
| **Microsoft Foundry** | Pro-code (PaaS) | Retrieval, Task, Autonomous | Strategic transformation. Supports deep integration and custom logic. |
| **Microsoft Copilot Studio** | Low-code (SaaS) | Retrieval, Task, Autonomous | Process transformation. Enables fast development with minimal coding and SaaS security. |
| **Virtual machines** | Pro-code (IaaS) | Retrieval, Task, Autonomous | Custom infrastructure. Provides full control of the entire technology stack. |

## Next step

After you define your business and technology strategies for AI agents, you must focus on the organizational structure and talent required to deliver and sustain these solutions.

> [!div class="nextstepaction"]
> [People strategy](./people-strategy.md)
