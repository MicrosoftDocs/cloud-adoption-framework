---
title: AI architecture guidance to build AI workloads on Azure
description: Learn to find AI architectures and guides to build AI workloads with Azure AI platform services (PaaS).
author: stephen-sumner
ms.author: pnp
ms.date: 04/29/2025
ms.topic: conceptual
---

# AI architecture guidance to build AI workloads on Azure

This article offers architecture guidance for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Foundry, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and nongenerative AI workloads.

> [!NOTE]
> If you're using Azure landing zones, begin with the ***[Baseline Azure OpenAI architecture in Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone)*** and deploy it to an application landing zone subscription.

## Generative AI architectures and guides

| Article | Article type | Target organization |
|--------------|--------------|-------------|
| [Baseline Azure OpenAI architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone)| Architecture | Enterprise |
| [Baseline Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat)| Architecture | Any |
| [Basic Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/basic-openai-e2e-chat)| Architecture | Startup |
| [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) | Guide| Any |
| [Developing RAG solutions](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) | Guides| Any |
| [Proxy Azure OpenAI usage](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) | Guide| Any |
| [Application design](/azure/well-architected/ai/application-design) | Design area | Any |
| [Application platform](/azure/well-architected/ai/application-platform)| Design area | Any |
| [Training data design](/azure/well-architected/ai/training-data-design) | Design area | Any |
| [Grounding data design](/azure/well-architected/ai/grounding-data-design) | Design area | Any |
| [Data platform](/azure/well-architected/ai/data-platform) | Design area | Any |
| [MLOps and GenAIOps](/azure/well-architected/ai/mlops-genaiops) | Design area | Any |
| [Operations](/azure/well-architected/ai/operations) | Design area | Any |
| [Test and evaluate](/azure/well-architected/ai/test) | Design area | Any |
| [Responsible AI](/azure/well-architected/ai/responsible-ai) | Design area | Any |

## Nongenerative AI architectures and guides

| Article | Article type | Target organization |
|------------|--------------|-------------|
| [Document processing architectures](/azure/architecture/ai-ml/architecture/automate-document-classification-durable-functions) | Architectures | Any |
| [Video and image classification architecture](/azure/architecture/ai-ml/architecture/analyze-video-computer-vision-machine-learning)| Architectures |Any |
| [Audio processing architecture](/azure/architecture/ai-ml/openai/architecture/call-center-openai-analytics) | Architecture | Any|
| [Predictive analytics architecture](/azure/architecture/ai-ml/idea/personalized-offers)| Architecture | Any|
| [Azure Machine Learning](/azure/architecture/ai-ml/#azure-machine-learning)| Guides | Any |
| [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2)| Guides|Any |

## Use the AI design areas as a framework

The AI design areas provide technology-specific framework to design AI workloads with Azure's AI platform-as-a-service (PaaS) solutions. It focuses on Azure AI Foundry, Azure OpenAI, Azure Machine Learning, and Azure AI Services. Use them to establish standards and best practices related to these services:

- [Resource selection](./resource-selection.md)
- [Networking](./networking.md)
- [Governance](./governance.md)
- [Management](./management.md)
- [Security](./security.md)

Each design area includes recommendations for both generative and nongenerative AI workloads on Azure, consolidating best practices that apply to all AI workloads using Azure PaaS AI platforms.

## Next step

> [!div class="nextstepaction"]
> [Resource selection](./resource-selection.md)
