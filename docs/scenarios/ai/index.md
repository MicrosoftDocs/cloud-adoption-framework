---
title: AI Adoption on Azure
description: Learn how Microsoft recommends adopting Artificial Intelligence (AI) in your organization with the Microsoft Cloud Adoption Framework.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI adoption on Azure

This collection of guidance shows you how to adopt AI on Azure. It covers generative AI and nongenerative AI adoption. It helps you pick the right AI technology for your use case based on factors like skills, data, and cost. You learn how to assess your AI maturity, access AI resources, plan for responsible AI, and determine whether centralizing AI models is suitable for your organization. Additionally, it guides you in preparing your AI foundation and consistently enforcing security, governance, and management across your cloud environment to protect sensitive data.

:::image type="content" source="./images/ai-adoption-process.svg" alt-text="Diagram showing the AI adoption framework process. It starts with Strategy, Plan, Ready, and Adopt. Then Secure, Manage, and Govern are cyclical processes after Adopt. Undergirding the entire process is Responsible AI." lightbox="./images/ai-adoption-process.svg" border="false":::
*Figure 1. How to use the AI adoption guidance for Azure.*

## Why adopt AI on Azure?

When applied appropriately to the right use cases, AI delivers significant business value. It automates business processes for consistency, enhances individual efficiency and creativity, and reduces the toil of daily tasks. Microsoft's AI portfolio offers solutions for a wide variety of use cases and AI maturity levels. Azure provides a range of AI platforms and infrastructure services (PaaS and IaaS) to build, secure, and govern AI workloads, giving you access to the latest AI models.

## How to adopt AI on Azure

AI adoption is a seven-step process. The first three steps are foundational.   process with securing, governing, and managing AI representing continuous processes. While represented at the end, security, governance, and management are in integral Responsible AI activities and must be a part of your planning process before deployment. The AI guidance here indicate the appropriate time to engage in these Responsible AI activities.

1. *AI Strategy*: Learn how to pick the right AI technology for each use case based on required AI skills, data, and cost.
1. *AI Plan*: Assess your AI maturity, acquire necessary AI skills, access the AI technology you need, and plan your Azure environment for AI.
1. *AI Ready*: Prepare your Azure environment for deployment and establish a strong security and governance foundation for all AI workloads.
1. *Adopt AI*: Adopt Azure technologies and find implementation resources to build AI applications.
1. *Secure AI*: Assess AI security risks and apply security controls to protect your AI workloads.
1. *Govern AI*: Control your AI workloads and models by establishing guardrails to ensure compliance and responsible use.
1. *Manage AI*: Manage your AI workloads, models, and data over time to ensure they remain aligned with your business goals.

## AI adoption checklists

Use the AI adoption checklist to see the roadmap to adopting AI. There's a checklist for startups and enterprises. The startup checklist covers the essentials for securing and governing AI workloads in Azure. The Enterprise checklist.

### Startup AI adoption checklist

| AI adoption phase | Activities |
|---|---|
| [Strategy](./strategy.md) | &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) <br> &#9744; [Define a responsible AI strategy](./strategy.md#define-a-responsible-ai-strategy) |
| [Plan](./plan.md) | &#9744; [Access AI resources](./plan.md#access-ai-resources) |
| [Ready](./ready.md) | &#9744;  [Prepare AI deployment regions](./ready.md#prepare-ai-deployment-regions) |
| [Adopt](./adopt-paas.md) | &#9744; [Build AI with Azure platforms (PaaS)](./adopt-paas.md) |
| [Secure](./secure.md) | &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) |
| [Govern](./govern.md) | &#9744; [Govern AI models](./govern.md#govern-ai-models) <br> &#9744; [Govern AI costs](./govern.md#govern-ai-costs) <br> &#9744; [Govern AI data](./govern.md#govern-ai-data) |
| [Manage](./manage.md) | &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) |

### Enterprise AI adoption checklist

| AI adoption phase | Activities |
|---|---|
| [Strategy](./strategy.md) | &#9744; [Define AI uses cases](./strategy.md#define-ai-use-cases) &#9744; [Define an AI technology strategy](./strategy.md#define-an-ai-technology-strategy) <br> &#9744; [Define an AI data strategy](./strategy.md#define-an-ai-data-strategy) <br> &#9744; [Define a responsible AI strategy](./strategy.md#define-a-responsible-ai-strategy) |
| [Plan](./plan.md) |  &#9744; [Evaluate AI maturity](./plan.md#evaluate-ai-maturity) <br> &#9744; [Acquire AI skills](./plan.md#acquire-ai-skills) <br> &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Create an AI proof of concept](./plan.md#create-an-ai-proof-of-concept) <br> &#9744; [Plan for Responsible AI](./plan.md#plan-for-responsible-ai) |
| [Ready](./ready.md) | &#9744;  [Prepare AI deployment regions](./ready.md#prepare-ai-deployment-regions) <br> &#9744; [Estimate delivery timelines](./plan.md#estimate-delivery-timelines) |
| [Adopt](./adopt-paas.md) | &#9744; [AI on Azure platforms (PaaS)](./adopt-paas.md) |
| [Secure](./secure.md) | &#9744; [Assess AI security risks](./secure.md#assess-ai-security-risks) <br> &#9744; [Implement AI security controls](./secure.md#secure-ai-resources) <br> &#9744; [Maintain AI security controls](./secure.md#secure-the-ai-models) <br> &#9744; [Secure AI data](./secure.md#secure-ai-data) <br> &#9744; [Secure AI access](./secure.md#secure-ai-access) |
| [Govern](./govern.md) | &#9744; [Govern AI models](./govern.md#govern-ai-models) <br> &#9744; [Govern AI costs](./govern.md#govern-ai-costs) <br> &#9744; [Govern AI security](./govern.md#govern-ai-security) <br> &#9744; [Govern AI operations](./govern.md#govern-ai-operations) <br> &#9744; [Govern AI regulatory compliance](./govern.md#govern-ai-regulatory-compliance) <br> &#9744;[Govern AI data](./govern.md#govern-ai-data) |
| [Manage](./manage.md) | &#9744; [Manage AI deployment](./manage.md#manage-ai-deployment) <br> &#9744; [Manage AI endpoint sharing](./manage.md) <br> &#9744; [Mange AI operations](./manage.md#manage-ai-operations) [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) <br> &#9744; [Manage AI data](./manage.md#manage-ai-data) <br> &#9744; [Mange AI continuity of operations](./manage.md#manage-ai-continuity-of-operations) |

## Next steps

> [!div class="nextstepaction"]
> [AI Strategy](strategy.md)
