---
title: Adopt AI on Azure
description: Learn how Microsoft recommends adopting Artificial Intelligence (AI) in your organization with the Microsoft Cloud Adoption Framework.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Adopt AI on Azure

The AI adoption scenario in the Cloud Adoption Framework (CAF) provides a structured approach for integrating AI into your organization using Azure. It covers both generative and non-generative AI adoption guidance, offering recommendations relevant for organizations of all sizes and industries. This guidance serves as your roadmap for AI adoption, acting as a central hub to find the resources and advice you need.

AI adoption is the process of integrating AI into your organization. Effective AI adoption is characterized by AI that is trustworthy.

:::image type="content" source="./images/ai-adoption-process.svg" alt-text="Diagram showing the AI adoption framework process. It's a continuous process that contains AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI. Undergirding the entire process is Responsible AI." lightbox="./images/ai-adoption-process.svg" border="false":::
*Figure 1. How to use the AI adoption guidance for Azure.*

## Why adopt AI?

AI adoption is foundational for optimizing operations at both the individual and organizational levels. It enhances individual efficiency by automating routine tasks and providing creative insights. At the business level, AI boosts efficiency by automating processes ranging from adaptive chatbots to business forecasting. These use cases allow businesses and employees to focus on customers and work that matters most. The barriers to adopting AI are lower than ever. Microsoft provides a range of AI services that cater to different skill sets, budgets, and data needs. You can decide whether to buy or build AI workloads based on your business requirements.

## How to adopt AI

Adopting AI is a sequential process that requires ongoing monitoring, governance, and adjustments to adapt to evolving technologies, opportunities, and requirements. The CAF AI adoption guidance divides AI adoption into six steps. If you're new to AI adoption, complete all six steps. Revisit the AI Strategy, AI Plan, and AI Ready steps as needed. Govern AI, Manage AI, and Secure AI are continuous processes that you should iterate through regularly to ensure your AI workloads remain secure, cost-effective, and trustworthy.

1. *AI Strategy*: Choose the right AI technology for each use case based on the required skills, data availability, and associated costs. Define your data and Responsible AI strategy.
1. *AI Plan*: Assess your AI maturity, acquire necessary AI skills, access the AI technology you need, and plan for responsible AI. Part of planning is reviewing the needs of the AI security, governance, and management processes.
1. *AI Ready*: Prepare your Azure environment for deployment and establish a strong security and governance foundation for all AI workloads.
1. *Govern AI*: Control your AI workloads and models by establishing guardrails to ensure compliance and responsible AI use.
1. *Manage AI*: Manage your AI deployments, operations, models, and data over time to ensure they remain aligned with your business goals.
1. *Secure AI*: Assess AI security risks and apply security controls to protect your AI workloads.

## AI adoption checklists

Use the AI adoption checklists as your roadmap for being successful with AI. There are two checklists available: one for startups and one for enterprises. The enterprise checklist provides the most comprehensive guidance. It helps you prepare your organization to adopt AI at scale. For a quicker path to AI adoption, use the startup checklist. As your organization grows, consult the enterprise checklist to support your expanding AI needs.

| AI adoption phase | Startup checklist | Enterprise checklist |
|---|---|---|
| [AI Strategy](./strategy.md) | &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) | &#9744; [Identify AI use cases](./strategy.md#identify-ai-use-cases) <br> &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) <br> &#9744; [Define an AI data strategy](./strategy.md#define-an-ai-data-strategy) <br> &#9744; [Define a responsible AI strategy](./strategy.md#define-a-responsible-ai-strategy) |
| [AI Plan](./plan.md) | &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Start Responsible AI adoption](./plan.md#start-responsible-ai-adoption) | &#9744; [Assess AI skills](./plan.md#assess-ai-skills) <br> &#9744; [Acquire AI skills](./plan.md#acquire-ai-skills) <br> &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Prioritize AI use cases](./plan.md#prioritize-ai-use-cases) <br> &#9744; [Create an AI proof of concept](./plan.md#create-an-ai-proof-of-concept) <br> &#9744; [Start Responsible AI adoption](./plan.md#start-responsible-ai-adoption) <br> &#9744;[Estimate delivery timelines](./plan.md#estimate-delivery-timelines) |
| [AI Ready](./ready.md) | &#9744; [Establish AI governance](./ready.md#establish-ai-governance) <br> &#9744; [Build an environment](./ready.md#build-an-environment) <br> &#9744; [Choose an architecture](./platform/architectures.md) | &#9744; [Establish AI reliability](./ready.md#establish-ai-reliability) <br> &#9744; [Establish AI governance](./ready.md#establish-ai-governance) <br> &#9744; [Establish AI networking](./ready.md#establish-ai-networking) <br> &#9744; [Establish an AI foundation](./ready.md#use-azure-landing-zone) <br> &#9744; [Chose an architecture](./platform/architectures.md) |
| [Govern AI](./govern.md) | &#9744; [Enforce AI policies](./govern.md#enforce-ai-policies) | &#9744; [Assess AI organizational risks](./govern.md#assess-ai-organizational-risks) <br> &#9744; [Document AI governance policies](./govern.md#document-ai-governance-policies) <br> &#9744; [Enforce AI policies](./govern.md#enforce-ai-policies) <br> &#9744; [Monitor AI risks](./govern.md#monitor-ai-risks) |
| [Manage AI](./manage.md) | &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) | &#9744; [Manage AI operations](./manage.md#manage-ai-operations) <br> &#9744; [Manage AI deployment](./manage.md#manage-ai-deployment) <br> &#9744; [Manage AI endpoint sharing](./manage.md#manage-ai-endpoint-sharing) <br> &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) <br> &#9744; [Manage AI data](./manage.md#manage-ai-data) <br> &#9744; [Manage AI business continuity](./manage.md#manage-ai-business-continuity) |
| [Secure AI](./secure.md) | &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) | &#9744; [Assess AI security risks](./secure.md#assess-ai-security-risks) <br> &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) <br> &#9744; [Maintain AI security controls](./secure.md#secure-the-ai-models) <br> &#9744; [Secure AI data](./secure.md#secure-ai-data) <br> &#9744; [Secure AI access](./secure.md#secure-ai-access) |

## Next step

> [!div class="nextstepaction"]
> [AI Strategy](strategy.md)
