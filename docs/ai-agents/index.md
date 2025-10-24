---
title: AI agent adoption
description: Learn AI agent adoption
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# AI agent adoption

Organizations adopt AI agents to automate tasks, increase productivity, and deliver new digital services across the cloud environment. However, deploying a chatbot or machine learning model does not guarantee business impact. Without structured planning, governance, integration, and measurement, AI agents remain disconnected tools rather than strategic assets.

:::image type="content" source="./images/ai-agent-adoption.png" alt-text="Diagram that shows the process outlined in this guidance: plan, govern, build and secure, integrate, and measure agents across your organization." lightbox="./images/ai-agent-adoption.png" border="false":::

This guidance defines a step-by-step framework that helps decision makers plan, govern, build, integrate, and measure AI agents across the organization. Each milestone supports return on investment, cost optimization, risk reduction, and team alignment to ensure agents deliver measurable value across the cloud estate.

The series focuses on **Azure AI Foundry Agent Service** and **Microsoft Copilot Studio**, which provide flexible tools for designing, deploying, and managing agents. It also includes use cases for **Microsoft Copilots** and building with GPU-based infrastructure and containers architectures.

## What is an AI agent?

An AI agent is a microservice that uses a generative AI model alongside instructions, knowledge, and tools to reason, act, and learn. These agents operate in response to user messages, system events, or other agents.

:::image type="content" source="./images/agent-overview.png" alt-text="Diagram that shows the basic architecture of an agent." lightbox="./images/agent-overview.png" border="false":::

Each agent interprets instructions to determine its scope and actions. It uses tools to retrieve knowledge, perform tasks, and maintain memory, which enables persistent and context-aware engagement. After gathering inputs, the data gets sent to the language model, which generates an output, such as a user message, a response to another agent, or an action with tool results. This structure allows agents to operate independently while remaining aligned with enterprise goals.

## Types of agents

Organizations use three types of agents depending on the complexity and criticality of the task:

:::image type="content" source="./images/spectrum-agents.png" alt-text="Diagram that shows the three main types of agents: retrieval, task, and autonomous." lightbox="./images/spectrum-agents.png" border="false":::

- **Retrieval agents** return information from grounding data. These agents suit scenarios where speed and accuracy matter most, such as customer support or compliance queries. They operate within well-defined boundaries and introduce minimal risk.
- **Task agents** take action when prompted. These agents automate structured workflows like updating records or creating service tickets. They require more oversight than retrieval agents but remain predictable when scoped and tested.
- **Autonomous agents** act independently. These agents adapt to changing conditions and make decisions without constant human input. They orchestrate multi-step processes and optimize operations. However, their non-deterministic behavior requires rigorous testing and governance before use in mission-critical workloads.

The choice of agent type depends on the use case and the criticality of the process. While autonomous agents offer significant innovation potential, their non-deterministic behavior means they require rigorous testing and governance before being applied to mission-critical workloads. Retrieval and task agents typically provide faster, lower-risk adoption paths.

## Why AI agents?

AI agents offer a scalable way to automate decision-making, streamline operations, and improve responsiveness across business functions. Their ability to interact through natural language and adapt to changing inputs makes them well-suited for environments with unstructured data, dynamic workflows, or complex logic.

Organizations use AI agents to reduce manual effort, accelerate innovation, and improve operational efficiency. However, the value of these agents depends on how well they integrate with existing systems and how directly they support business objectives.

## Next step

To realize the full potential of AI agents, organizations must align their adoption strategy with business outcomes. The next section explores how AI agents create internal and customer-facing impact—and how decision makers can guide their teams to use agents effectively across the business.

> [!div class="nextstepaction"]
> [Business strategy for AI agents](./business-strategy.md)
