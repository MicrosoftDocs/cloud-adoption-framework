---
title: Get AI architecture guidance for Azure platform services (PaaS) for AI
description: Find AI architectures and guides to build AI workloads with Azure AI platform services like Microsoft Foundry and Azure Machine Learning.
author: stephen-sumner
ms.author: ssumner
ms.date: 10/09/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# AI architecture guidance for Azure platform services (PaaS) for AI

This article helps organizations build AI workloads on Azure platform-as-a-service (PaaS) solutions. These services support both generative and nongenerative AI workloads with enterprise-grade security and scalability.

## Generative AI architectures and guides

Generative AI architectures create new content and enable conversational experiences through large language models. The architectures provide different complexity levels to match your organization's needs and technical maturity.

- **Baseline architectures.** These architectures include security configurations, networking designs, and operational practices that enterprises need for reliable AI deployments. They address common challenges like model governance, cost management, and data protection.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Baseline Foundry chat reference architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-landing-zone) | Architecture | Enterprise |
   | [AI workload landing zone](https://github.com/Azure/AI-Landing-Zones) | Architecture | Any |
   | [Baseline Foundry chat reference architecture](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-chat) | Architecture | Any |
   | [Basic Foundry chat reference architecture](/azure/architecture/ai-ml/architecture/basic-azure-ai-foundry-chat) | Architecture | Startup |

- **Operational guidance.** These guides establish practices for model deployment, monitoring, and continuous improvement across development environments. They ensure consistent quality and reliability as AI applications evolve.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) | Guide | Any |
   | [Developing RAG solutions](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) | Guide | Any |
   | [Proxy Azure OpenAI usage](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) | Guide | Any |

- **Well-Architected Framework.** Use the AI workload [design areas](/azure/well-architected/ai/application-design).

For the full list of available guidance, see the [Azure Architecture Center](/azure/architecture/ai-ml/ai-get-started#explore-ai-architectures-and-guides).

## Nongenerative AI architectures and guides

Nongenerative AI architectures focus on classification, prediction, and analysis tasks without creating new content. These architectures process existing data to extract insights, automate decisions, and enhance business processes.

- **Architectures.** These architectures demonstrate proven patterns for common business scenarios like document processing, media analysis, and predictive analytics. They provide implementation guidance for integrating AI capabilities into existing business processes.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Document processing architectures](/azure/architecture/ai-ml/architecture/automate-document-classification-durable-functions) | Architecture | Any |
   | [Audio processing architecture](/azure/architecture/ai-ml/openai/architecture/call-center-openai-analytics) | Architecture | Any |

- **Operational frameworks.** These guides establish best practices for model training, deployment, and monitoring that ensure consistent performance and reliability in production environments.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Azure Machine Learning](/azure/architecture/ai-ml/#azure-machine-learning) | Guide | Any |
   | [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) | Guide | Any |

For the full list of available guidance, see the [Azure Architecture Center](/azure/architecture/ai-ml/ai-get-started#explore-ai-architectures-and-guides).

## Next steps

> [!div class="nextstepaction"]
> [Resource selection](../../scenarios/ai/platform/resource-selection.md)
