---
title: Management for AI workloads on Azure platforms
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Management for AI workloads on Azure platforms

Effective management of AI workloads on Azure involves overseeing deployment, model performance, operations, data, and disaster recovery to support AI-driven initiatives. This topic matters when adopting AI because proper management ensures that AI systems operate reliably, align with responsible AI principles, and remain secure throughout their lifecycle.

## Manage AI deployments

Managing AI deployments helps workload teams move from proof-of-concept stages to production environments with consistent configurations that improve security and compliance across teams. Azure offers tools like Azure AI Studio [hubs and projects](/azure/ai-studio/concepts/ai-resources) to enforce governance and security. Azure Machine Learning has similar capabilities with its [hub workspaces](/azure/machine-learning/concept-hub-workspace).

## Manage AI models

Managing AI models includes monitoring their outputs, performance, and alignment with Responsible AI principles. AI models can drift over time due to changing data, user behaviors, or other external factors. These changes can lead to inaccurate results or ethical concerns if not addressed.

- *Monitor model outputs.* AI workloads can change over time due to evolving data, model updates, or shifts in user behavior. Implement a monitoring and testing process to ensure that these workloads remain aligned with your responsible AI targets.

    - *Monitor generative AI.* For generative AI workloads, use Azure AI Studio's built-in [evaluation](/azure/ai-studio/concepts/evaluation-metrics-built-in) and [manual](/azure/ai-studio/how-to/evaluate-prompts-playground) monitoring capabilities. If you're using prompt flow, [monitor prompt flow deployments](/azure/ai-studio/how-to/develop/trace-production-sdk).  Also consider using [responsible AI tools](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to supplement model monitoring.

    - *Monitor nongenerative AI.* For nongenerative AI workloads, monitor data processing stages and model performance metrics to ensure predictions remain accurate and reliable. Enable [model monitoring](/azure/machine-learning/concept-model-monitoring?view=azureml-api-2) in Azure Machine Learning. For Azure AI services, enable monitoring for each AI service you use.

- *Monitor model performance.* When a drop in performance or accuracy is detected, monitoring helps pinpoint the source of the issue. As with all workloads, use Azure Monitor and Application Insights to monitor the performance of AI workloads.

    - *Monitor generative AI performance.* In generative AI, monitor latency in response times or the accuracy of vector search results to enhance user experiences. In Azure AI Studio, [enable tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) to collect trace data for each request, aggregated metrics, and user feedback.

    - *Monitor nongenerative AI performance.* Capture [performance metrics](/azure/machine-learning/how-to-monitor-model-performance#set-up-model-performance-monitoring) of models deployed in Azure Machine Learning. For Azure AI services, enable [diagnostic logging](/azure/ai-services/diagnostic-logging) for each Azure AI service.

- *Consider a generative AI gateway for monitoring.* A reverse proxy like Azure API Management allows you to implement logging and monitoring that aren't native to the platform. API Management allows you to collect source IPs, input text, and output text. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

## Manage AI operations

- *Standardize compute management.* For PaaS services, you need to provision compute resources for certain actions like prompt flows and training models. A service like Azure Machine Learning has different compute options, such as compute instances, clusters, and serverless options. You want to standardize the compute type, runtimes, and shutdown periods. For service-specific compute options, see [Azure AI Studio](/azure/ai-studio/how-to/create-manage-compute) and [Azure Machine Learning](/azure/machine-learning/how-to-create-attach-compute-studio).

- *Monitor platform resources.* Use diagnostic settings to capture logs and metrics for all key services, such as Azure AI Studio, Azure Machine Learning, [Azure AI services](/azure/ai-services/diagnostic-logging). Specific services should capture audit logs and relevant service-specific logs. Implement custom monitoring alerts based on your architecture’s specific needs. Examples include alerts for container registries, Machine Learning services, and Azure OpenAI operations.

## Manage AI data

Ensuring data quality and detecting model drift are key steps in data management.

- *Ensure high-quality data processing.* For [machine learning](/azure/architecture/data-science-process/lifecycle-modeling), training data must be formatted, clean, and ready for model consumption. For generative AI, grounding data needs to be in the correct format, and likely chunked, enriched, and embedded for AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

- *Manage model versioning and detect drift.* In both generative and nongenerative AI, continuously track accuracy and data drift to ensure models remain relevant. Monitoring can alert you when model predictions or LLM responses start to deviate from expected behavior, indicating a need for retraining or adjustment. Set up custom alerts to detect performance thresholds, enabling early intervention when problems arise. Use [Evaluations in Azure AI Studio](/azure/ai-studio/concepts/evaluation-approach-gen-ai) and metrics supported in [Azure Machine Learning](/azure/machine-learning/concept-model-monitoring).

## Manage business continuity and disaster recovery

*Use multi-region deployments for AI.* Implement multi-region deployments to ensure high availability and resiliency for both generative and nongenerative AI systems For more information, see multi-region deployment in [Azure AI Studio,](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment) [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning#plan-for-multi-regional-deployment), and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery).

## Next step

> [!div class="nextstepaction"]
> [PaaS AI implementation options](../platform/implementation-options.md)