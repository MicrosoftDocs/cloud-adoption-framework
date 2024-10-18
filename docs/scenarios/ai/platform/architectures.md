---
title: Architecture guidance to build AI workloads on Azure
description: Learn to find AI architectures and guides to build AI workloads with Azure AI platform services (PaaS).
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Architecture guidance to build AI workloads on Azure

This article offers architecture guidance for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Studio, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and non-generative AI workloads.

The Azure Architecture Center offers reference architectures and guides for building generative and non-generative AI workloads on Azure. These resources provide structured, well-tested architectural guidance for creating AI workloads. In [AI Ready](../ready.md#establish-ai-governance), ou established a resource hierarchy that categorizes AI workloads into internal and internet-facing groups. You can deploy these architectural resources to workload subscriptions within either the internal or internet-facing management groups. The following tables link to resources for implementing generative AI workloads.

If you're using Azure landing zones, begin with the [Baseline Azure OpenAI architecture in Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone) and deploy it to an application landing zone subscription.

## Generative AI architectures and guides

| Article | Article type | Target organization |
|--------------|--------------|-------------|
| [Baseline Azure OpenAI architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone)| Architecture | Enterprise<br> Azure landing zone user |
| [Baseline Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat)| Architecture | Any |
| [Basic Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/basic-openai-e2e-chat)| Architecture | Startup |
| [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) | Guide| Any |
| [Developing RAG solutions](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) | Guides| Any |
| [Proxy Azure OpenAI usage](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) | Guide| Any |

## Nongenerative AI architectures and guides

| Article | Article type | Target organization |
|------------|--------------|-------------|
| [Azure Machine Learning architectures](/azure/architecture/ai-ml/#azure-machine-learning)| Architectures | Any |
| [Document processing architectures](/azure/architecture/ai-ml/architecture/automate-document-classification-durable-functions) | Architectures | Any |
| [Video and image classification architecture](/azure/architecture/ai-ml/architecture/analyze-video-computer-vision-machine-learning)| Architectures |Any |
| [Audio processing architecture](/azure/architecture/ai-ml/openai/architecture/call-center-openai-analytics) | Architecture | Any|
| [Predictive analytics architecture](/azure/architecture/ai-ml/architecture/customer-lifecycle-churn)| Architecture | Any|
| [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2)| Guides|Any |
| [Team Data Science Process](/azure/architecture/data-science-process/overview) | Guides|Any |

## Use the AI design areas as a framework

The AI design areas outlined in this guidance offer structured recommendations for organizations building AI workloads with Azure's platform-as-a-service (PaaS) solutions. The following design areas provide comprehensive guidelines for adopting AI workloads on Azure and managing them throughout their lifecycle:

- [AI resource selection](./resource-selection.md)
- [AI networking](./networking.md)
- [AI governance](./governance.md)
- [AI management](./management.md)
- [AI security](./security.md)

Use the AI design area articles as a framework alongside the reference architectures. Each design area includes recommendations for both generative and nongenerative AI workloads on Azure, consolidating best practices that apply to all AI workloads using Azure PaaS AI platforms.

## Next step

> [!div class="nextstepaction"]
> [AI resource selection](./resource-selection.md)
