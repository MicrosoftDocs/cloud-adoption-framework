---
title: AI adoption on Azure
description: Learn how Microsoft recommends adopting Artificial Intelligence (AI) in your organization with the Microsoft Cloud Adoption Framework.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI adoption on Azure

This guidance provides a comprehensive roadmap for adopting AI on Azure, serving as a framework to help you navigate the AI landscape. Use it to find detailed implementation instructions and to establish processes for securing, governing, and managing AI workloads. Think of this as your manual for achieving AI success on Azure.

:::image type="content" source="./images/ai-adoption-process.svg" alt-text="Diagram showing the AI adoption framework process. It's a continuous process that contains AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI. Undergirding the entire process is Responsible AI." lightbox="./images/ai-adoption-process.svg" border="false":::
*Figure 1. How to use the AI adoption guidance for Azure.*

## Why adopt AI?

When applied effectively, AI improves business. It enhances individual efficiency and automates business processes. These uses allows business and personnel to focus on the work that matters most. The barrier to adopt AI is lower than it's ever been. Microsoft provides a range of AI services that cater to different skill sets, budgets, and data needs. You decide if you want to buy or build AI workloads based on your business needs.

## How to adopt AI

AI adoption is a sequential process. Some steps in the process you visit once, others are continuous. This guidance serves as your roadmap for AI adoption and a hub for finding the resources you need. There's aAI adoption checklist to see the roadmap to adopting AI. There's a checklist for startups and enterprises. The startup checklist covers the essentials for securing and governing AI workloads in Azure. The Enterprise checklist provide comprehensive guidance for scaling AI workloads in Azure. The following steps outline how to adopt AI on Azure:

1. *AI Strategy*: Choose the right AI technology for each use case based on the required skills, data availability, and associated costs. Define your data and Responsible AI strategy.
1. *AI Plan*: Assess your AI maturity, acquire necessary AI skills, access the AI technology you need, and plan for responsible AI. Part of planning is reviewing the needs of the AI security, governance, and management processes.
1. *AI Ready*: Prepare your Azure environment for deployment and establish a strong security and governance foundation for all AI workloads.
1. *Govern AI*: Control your AI workloads and models by establishing guardrails to ensure compliance and responsible AI use.
1. *Manage AI*: Manage your AI deployments, operations, models, and data over time to ensure they remain aligned with your business goals.
1. *Secure AI*: Assess AI security risks and apply security controls to protect your AI workloads.

## AI adoption checklists

| AI adoption phase | Startup checklist | Enterprise checklist |
|---|---|---|
| [AI Strategy](./strategy.md) | &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) | &#9744; [Define AI use cases](./strategy.md#define-ai-use-cases) <br> &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) <br> &#9744; [Define an AI data strategy](./strategy.md#define-an-ai-data-strategy) <br> &#9744; [Define a responsible AI strategy](./strategy.md#define-a-responsible-ai-strategy) |
| [AI Plan](./plan.md) | &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Plan for Responsible AI](./plan.md#plan-for-responsible-ai) | &#9744; [Evaluate AI maturity](./plan.md#evaluate-ai-maturity) <br> &#9744; [Acquire AI skills](./plan.md#acquire-ai-skills) <br> &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Create an AI proof of concept](./plan.md#create-an-ai-proof-of-concept) <br> &#9744; [Plan for Responsible AI](./plan.md#plan-for-responsible-ai) |
| [AI Ready](./ready.md) | &#9744; [Establish AI governance](./ready.md#prepare-ai-governance) | &#9744; [Establish AI reliability](./ready.md#establish-ai-reliability) <br> &#9744; [Establish AI governance](./ready.md#establish-ai-governance) <br> &#9744; [Establish AI networking](./ready.md#establish-ai-networking) <br> &#9744; [Establish an AI foundation](./ready.md#use-azure-landing-zone) |
| AI Ready: Implementation | &#9744; [Choose an architecture](./platform/implementation-options.md) | &#9744; [Choose a PaaS architecture](./platform/implementation-options.md) <br> &#9744; [Choose an IaaS architecture](./platform/implementation-options.md)
| [Govern AI](./govern.md) | &#9744; [Govern AI models](./govern.md#govern-ai-models) <br> &#9744; [Govern AI costs](./govern.md#govern-ai-costs) | &#9744; [Govern AI models](./govern.md#govern-ai-models) <br> &#9744; [Govern AI costs](./govern.md#govern-ai-costs) <br> &#9744; [Govern AI security](./govern.md#govern-ai-security) <br> &#9744; [Govern AI operations](./govern.md#govern-ai-operations) <br> &#9744; [Govern AI regulatory compliance](./govern.md#govern-ai-regulatory-compliance) <br> &#9744; [Govern AI data](./govern.md#govern-ai-data) |
| [Manage AI](./manage.md) | &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) | &#9744; [Manage AI deployment](./manage.md#manage-ai-deployment) <br> &#9744; [Manage AI endpoint sharing](./manage.md#manage-ai-endpoint-sharing) <br> &#9744; [Manage AI operations](./manage.md#manage-ai-operations) <br> &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) <br> &#9744; [Manage AI data](./manage.md#manage-ai-data) <br> &#9744; [Manage AI business continuity](./manage.md#manage-business-continuity-and-disaster-recovery) |
| [Secure AI](./secure.md) | &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) | &#9744; [Assess AI security risks](./secure.md#assess-ai-security-risks) <br> &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) <br> &#9744; [Maintain AI security controls](./secure.md#secure-the-ai-models) <br> &#9744; [Secure AI data](./secure.md#secure-ai-data) <br> &#9744; [Secure AI access](./secure.md#secure-ai-access) |

## Next steps

> [!div class="nextstepaction"]
> [AI Strategy](strategy.md)
