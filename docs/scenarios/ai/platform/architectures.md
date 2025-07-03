---
title: Get AI architecture guidance for Azure platform services (PaaS) for AI
description: Find AI architectures and guides to build AI workloads with Azure AI platform services like Azure AI Foundry, Azure OpenAI, Azure Machine Learning, and Azure AI Services.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Get AI architecture guidance for Azure platform services (PaaS) for AI

This article helps organizations build AI workloads on Azure platform-as-a-service (PaaS) solutions. These services support both generative and nongenerative AI workloads with enterprise-grade security and scalability.

## Use generative AI architectures and guides

Generative AI architectures create new content and enable conversational experiences through large language models. The architectures provide different complexity levels to match your organization's needs and technical maturity. You must select the appropriate architecture based on your organization's size, compliance requirements, and existing Azure infrastructure. Here's how:

1. **Start with baseline architectures that provide proven design patterns for production workloads.** These architectures include security configurations, networking designs, and operational practices that enterprises need for reliable AI deployments. They address common challenges like model governance, cost management, and data protection.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Baseline Azure OpenAI architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone) | Architecture | Enterprise |
   | [Baseline Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat) | Architecture | Any |
   | [Basic Azure OpenAI reference architecture](/azure/architecture/ai-ml/architecture/basic-openai-e2e-chat) | Architecture | Startup |

2. **Apply operational guidance that supports AI development lifecycle management.** These guides establish practices for model deployment, monitoring, and continuous improvement across development environments. They ensure consistent quality and reliability as AI applications evolve.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) | Guide | Any |
   | [Developing RAG solutions](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) | Guide | Any |
   | [Proxy Azure OpenAI usage](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) | Guide | Any |

3. **Implement Well-Architected design areas that address specific technical concerns for AI workloads.** These design areas provide detailed recommendations for application design, data management, and operational excellence that complement the architectural patterns.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Application design](/azure/well-architected/ai/application-design) | Design area | Any |
   | [Application platform](/azure/well-architected/ai/application-platform) | Design area | Any |
   | [Training data design](/azure/well-architected/ai/training-data-design) | Design area | Any |
   | [Grounding data design](/azure/well-architected/ai/grounding-data-design) | Design area | Any |
   | [Data platform](/azure/well-architected/ai/data-platform) | Design area | Any |
   | [MLOps and GenAIOps](/azure/well-architected/ai/mlops-genaiops) | Design area | Any |
   | [Operations](/azure/well-architected/ai/operations) | Design area | Any |
   | [Test and evaluate](/azure/well-architected/ai/test) | Design area | Any |
   | [Responsible AI](/azure/well-architected/ai/responsible-ai) | Design area | Any |

## Use nongenerative AI architectures and guides

Nongenerative AI architectures focus on classification, prediction, and analysis tasks without creating new content. These architectures process existing data to extract insights, automate decisions, and enhance business processes. You must choose architectures that align with your specific data processing and analysis requirements.

Here's how:

1. **Select specialized architectures that address specific use cases for data processing and analysis.** These architectures demonstrate proven patterns for common business scenarios like document processing, media analysis, and predictive analytics. They provide implementation guidance for integrating AI capabilities into existing business processes.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Document processing architectures](/azure/architecture/ai-ml/architecture/automate-document-classification-durable-functions) | Architecture | Any |
   | [Video and image classification architecture](/azure/architecture/ai-ml/architecture/analyze-video-computer-vision-machine-learning) | Architecture | Any |
   | [Audio processing architecture](/azure/architecture/ai-ml/openai/architecture/call-center-openai-analytics) | Architecture | Any |
   | [Predictive analytics architecture](/azure/architecture/ai-ml/idea/personalized-offers) | Architecture | Any |

2. **Apply operational frameworks that support machine learning model lifecycle management.** These guides establish best practices for model training, deployment, and monitoring that ensure consistent performance and reliability in production environments.

   | Article | Article type | Target organization |
   |---------|--------------|---------------------|
   | [Azure Machine Learning](/azure/architecture/ai-ml/#azure-machine-learning) | Guide | Any |
   | [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) | Guide | Any |

## Adopt AI standards

The following articles provide best practices for adopting AI workloads using Azure PaaS solutions. These practices ensure your AI workloads meet requirements for security, governance, and operational excellence across key categories.

- **[Resource selection](./resource-selection.md)** - Use best practices to choose appropriate AI services and compute resources.
- **[Networking](./networking.md)** - Apply best practices to design secure and performant network connectivity.
- **[Governance](./governance.md)** - Follow best practices to establish policies and controls for AI resource management.
- **[Management](./management.md)** - Implement best practices for monitoring and operational practices.
- **[Security](./security.md)** - Enforce best practices for applying security controls and compliance requirements.

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Platform Services | [Azure AI Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) | Unified platform for building and deploying generative and nongenerative AI applications |
| Platform Services | [Azure OpenAI](/azure/ai-services/openai/) | Access to OpenAI models with enterprise security and compliance |
| Platform Services | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | End-to-end machine learning lifecycle management platform |
| Platform Services | [Azure AI Services](/azure/ai-services/what-are-ai-services) | Prebuilt AI capabilities for vision, speech, language, and decision making |
| Architecture Guidance | [Azure Architecture Center AI/ML](/azure/architecture/ai-ml/) | Comprehensive collection of AI and machine learning architecture patterns |
| Best Practices | [Well-Architected Framework AI Workloads](/azure/well-architected/ai/get-started) | Design principles and recommendations for AI workloads on Azure |

## Next steps

> [!div class="nextstepaction"]
> [Resource selection](./resource-selection.md)