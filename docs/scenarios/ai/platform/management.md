---
title: Management recommendations for AI workloads on Azure
description: Learn how to manage AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Management recommendations for AI workloads on Azure

This article offers management recommendations for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Studio, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and non-generative AI workloads.

Effective management of AI workloads on Azure involves overseeing deployment, model performance, operations, data, and disaster recovery to support your AI workloads. Proper management helps ensure that AI workloads are reliable, trustworthy, and secure throughout their lifecycle.

## Manage AI deployments

Managing AI deployments helps workload teams move from proof-of-concept stages to production environments with consistent configurations that improve security and compliance across teams. Azure offers tools like Azure AI Studio [hubs and projects](/azure/ai-studio/concepts/ai-resources) to enforce governance and security. Azure Machine Learning has similar capabilities with its [hub workspaces](/azure/machine-learning/concept-hub-workspace).

## Manage AI models

Managing AI models includes monitoring their outputs, performance, and alignment with Responsible AI principles. AI models can drift over time due to changing data, user behaviors, or other external factors. These changes can lead to inaccurate results or ethical concerns if not addressed.

- *Monitor model outputs.* AI workloads can change over time due to evolving data, model updates, or shifts in user behavior. Implement a monitoring and testing process to ensure that these workloads remain aligned with your responsible AI targets.

    - *Monitor generative AI.* For generative AI workloads, use Azure AI Studio's built-in [evaluation](/azure/ai-studio/concepts/evaluation-metrics-built-in) and [manual](/azure/ai-studio/how-to/evaluate-prompts-playground) monitoring capabilities. If you're using prompt flow, [monitor prompt flow deployments](/azure/ai-studio/how-to/develop/trace-production-sdk). Also consider using [responsible AI tools](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to supplement model monitoring.

    - *Monitor nongenerative AI.* For nongenerative AI workloads, monitor data processing stages and model performance metrics to ensure predictions remain accurate and reliable. Enable [model monitoring](/azure/machine-learning/concept-model-monitoring) in Azure Machine Learning. For Azure AI services, enable monitoring for each AI service you use.

- *Monitor model performance.* When a drop in performance or accuracy is detected, monitoring helps pinpoint the source of the issue. As with all workloads, use Azure Monitor and Application Insights to monitor the performance of AI workloads.

    - *Monitor generative AI performance.* In generative AI, monitor latency in response times or the accuracy of vector search results to enhance user experiences. In Azure AI Studio, [enable tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) to collect trace data for each request, aggregated metrics, and user feedback.

    - *Monitor nongenerative AI performance.* Capture [performance metrics](/azure/machine-learning/how-to-monitor-model-performance#set-up-model-performance-monitoring) of models deployed in Azure Machine Learning. For Azure AI services, enable [diagnostic logging](/azure/ai-services/diagnostic-logging) for each Azure AI service.

- *Consider a generative AI gateway for monitoring.* A reverse proxy like Azure API Management allows you to implement logging and monitoring that aren't native to the platform. API Management allows you to collect source IPs, input text, and output text. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

## Manage AI operations

AI operations management involves standardizing compute resources and monitoring platform resources for Azure AI workloads. It ensures that teams use the correct compute resources efficiently and capture metrics and logs from platform resources.

- *Monitor platform resources.* Use diagnostic settings to capture logs and metrics for all key services, such as Studio, Machine Learning, and [Azure AI services](/azure/ai-services/diagnostic-logging). Specific services should capture audit logs and relevant service-specific logs. Implement custom monitoring alerts based on your architecture’s specific needs. Examples include alerts for container registries, Machine Learning services, and Azure OpenAI Service operations.

- *Standardize compute management.* You need compute resources for certain actions like prompt flows and training models. A service like Machine Learning has different compute options, such as compute instances, clusters, and serverless options. Standardize the compute type, runtimes, and shutdown periods. For service-specific compute options, see [Studio](/azure/ai-studio/how-to/create-manage-compute) and [Machine Learning](/azure/machine-learning/how-to-create-attach-compute-studio).

## Manage AI data

High-quality data is the foundation of accurate AI models. Tracking model drift helps maintain the relevance of AI predictions over time, and it allows organizations to adapt models as necessary to reflect current conditions.

- *Monitor data drift.* Track accuracy and data drift continuously in generative and nongenerative AI to ensure that models remain relevant. Monitoring can alert you when model predictions or large language model responses deviate from expected behavior. This deviation indicates a need for retraining or adjustment. Set up custom alerts to detect performance thresholds. This approach enables early intervention when problems arise. Use [evaluations in Studio](/azure/ai-studio/concepts/evaluation-approach-gen-ai) and [metrics supported in Machine Learning](/azure/machine-learning/concept-model-monitoring).

- *Ensure quality data processing.* For [machine learning](/azure/architecture/data-science-process/lifecycle-modeling), training data must be formatted, clean, and ready for model consumption. For generative AI, grounding data needs to be in the correct format, and likely chunked, enriched, and embedded for AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

## Manage business continuity and disaster recovery

Implement multi-region deployments to ensure high availability and resiliency for both generative and nongenerative AI systems For more information, see multi-region deployment in [Azure AI Studio,](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment) [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning#plan-for-multi-regional-deployment), and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery).

## Next step

> [!div class="nextstepaction"]
> [PaaS AI workload architectures](../platform/architectures.md)