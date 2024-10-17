---
title: Architecture guidance to build AI workloads on Azure
description: Discover how to build AI applications on Azure PaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Architecture guidance to build AI workloads on Azure

The Azure Architecture Center has reference architectures and guides to build generative AI and nongenerative AI workloads. The following tables provides links to implementation guidance for building generative AI applications.

For Azure landing zone users, start with the [Baseline Azure OpenAI architecture in Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone).

## Generative AI

| Article | Article type | Target organization |
|--------------|--------------|-------------|
| [Baseline Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat)| Architecture | Any |
| [Basic Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/basic-openai-e2e-chat)| Architecture | Startup |
| [Baseline Azure OpenAI architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone)| Architecture | Enterprise, Azure landing zone user |
| [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) | Guide| Any |
| [Developing RAG solutions](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) | Guides| Any |
| [Proxy Azure OpenAI usage](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) | Guide| Any |

## Nongenerative AI

| Architectures| Article Type | Description |
|------------|--------------|-------------|
| [Azure machine learning architectures](/azure/architecture/ai-ml/#azure-machine-learning)| Architectures | Any |
| [Document processing architectures](/azure/architecture/ai-ml/architecture/automate-document-classification-durable-functions) | Architectures | Any |
| [Video and image classification architectures](/azure/architecture/ai-ml/architecture/analyze-video-computer-vision-machine-learning)| Architectures |Any |
| [Audio processing architectures](/azure/architecture/ai-ml/openai/architecture/call-center-openai-analytics) | Architecture | Any|
| [Predictive analytics architectures](/azure/architecture/ai-ml/architecture/customer-lifecycle-churn)| Architecture | Any|
| [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2)| Guides|Any |
| [Team Data Science Process](/azure/architecture/data-science-process/overview) | Guides|Any |

## Understand AI workload design best practices

To understand the level of effort to build AI workloads, see the following articles. They provide organizational guidelines for building AI workloads on Azure:

- [AI resource selection](./resource-selection.md)
- [AI networking](./compute.md)
- [AI governance](./compute.md)
- [AI management](./compute.md)
- [AI security](./compute.md)

> [!div class="nextstepaction"]
> [AI resource selection](./resource-selection.md)