---
title: Management for AI workloads on Azure platforms
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Management for AI workloads on Azure platforms


## Manage AI deployments

Use [Azure AI Studio hubs and projects](/azure/ai-studio/concepts/ai-resources) to enforce governance and security. The central AI team deploys and configures the hub. Then the workload teams use projects, which inherit hub configurations, to move from a proof of concept to production. Azure Machine Learning has similar capabilities with its [hub workspaces](/azure/machine-learning/concept-hub-workspace).

## Manage AI models

This guidance provides recommendations for measuring AI model performance over time and realign it with Responsible AI principles.

- *Monitor model outputs.* AI workloads can change over time due to evolving data, model updates, or shifts in user behavior. Implement a monitoring and testing process to ensure that these workloads remain aligned with your responsible AI targets.

    - *Monitor generative AI.* For generative AI, use Azure AI Studio's built-in [evaluation](/azure/ai-studio/concepts/evaluation-metrics-built-in) and [manual](/azure/ai-studio/how-to/evaluate-prompts-playground) monitoring capabilities. If you're using prompt flow, [monitor prompt flow deployments](/azure/ai-studio/how-to/develop/trace-production-sdk).  Also consider using [responsible AI tools](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to supplement model monitoring.

    - *Monitor nongenerative AI.* For nongenerative AI, monitor data processing stages and model performance metrics to ensure predictions remain accurate and reliable. Enable [model monitoring](/azure/machine-learning/concept-model-monitoring?view=azureml-api-2) in Azure Machine Learning. For Azure AI services, enable monitoring for each AI service you use.

*Consider a generative AI gateway for monitoring.* A reverse proxy like Azure API Management allows you to implement logging and monitoring that aren't native to the platform. API Management allows you to collect source IPs, input text, and output text. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

- *Identify root causes of performance issues.* When a drop in performance or accuracy is detected, monitoring helps pinpoint the source of the issue. Ensure you have visibility into each stage of the interaction to isolate the problem and implement corrective actions more quickly. As with all workloads, use Azure Monitor and Application Insights to monitor the performance of AI workloads.

    - *Monitor generative AI performance.* In generative AI, monitor latency in response times or the accuracy of vector search results to enhance user experiences. In Azure AI Studio, [enable tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) to collect trace data for each request, aggregated metrics, and user feedback.

    - *Monitor nongenerative AI performance.* Capture [performance metrics](/azure/machine-learning/how-to-monitor-model-performance?view=azureml-api-2&tabs=azure-cli#set-up-model-performance-monitoring) of models deployed in Azure Machine Learning. For Azure AI services, enable [diagnostic logging](/azure/ai-services/diagnostic-logging) for each Azure AI service.

- *Track model retirement.* Tracking retirement for pretrained models avoids performance issues as vendor support ends. For instance, a generative AI model might be deprecated, requiring an update to maintain functionality. For example, Azure AI Studio shows the model retirement date for all deployments.

- *Retrain AI models as needed.* Models degrade over time due to changes in data. Schedule regular retraining based on model performance or business needs to ensure the AI system stays relevant. Retraining can be expensive so capture the initial training cost and use that cost to evaluate how frequently you should retrain AI models. Maintain version control for models and ensure a rollback mechanism for underperforming versions.

- *Establish model promotion process.* There should be quality gates to promote trained, fine-tuned, and retrained models to higher environments based on performance criteria. The performance criteria are unique to each application.

## Manage AI operations

- *Standardize compute management.* For PaaS services, you need to provision compute resources for certain actions like prompt flows and training models. A service like Azure Machine Learning has different compute options, such as compute instances, clusters, and serverless options. You want to standardize the compute type, runtimes, and shutdown periods. For service-specific compute options, see [Azure AI Studio](/azure/ai-studio/how-to/create-manage-compute) and [Azure Machine Learning](/azure/machine-learning/how-to-create-attach-compute-studio).

- *Monitor platform resources.* Use diagnostic settings to capture logs and metrics for all key services, such as Azure AI Studio, Azure Machine Learning, [Azure AI services](/azure/ai-services/diagnostic-logging). Specific services should capture audit logs and relevant service-specific logs. Implement custom monitoring alerts based on your architecture’s specific needs. Examples include alerts for container registries, Machine Learning services, and Azure OpenAI operations.

## Manage AI data

- *Ensure high-quality data processing.* For [machine learning](/azure/architecture/data-science-process/lifecycle-modeling), training data must be formatted, clean, and ready for model consumption. For generative AI, grounding data needs to be in the correct format, and likely chunked, enriched, and embedded for AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

- *Manage model versioning and detect drift.* In both generative and nongenerative AI, continuously track accuracy and data drift to ensure models remain relevant. Monitoring can alert you when model predictions or LLM responses start to deviate from expected behavior, indicating a need for retraining or adjustment. Set up custom alerts to detect performance thresholds, enabling early intervention when problems arise. Use [Evaluations in Azure AI Studio](/azure/ai-studio/concepts/evaluation-approach-gen-ai) and metrics supported in [Azure Machine Learning](/azure/machine-learning/concept-model-monitoring).

## Manage business continuity and disaster recovery

*Use multi-region deployments for AI.* Implement multi-region deployments to ensure high availability and resiliency for both generative and nongenerative AI systems For more information, see multi-region deployment in [Azure AI Studio,](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment) [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning#plan-for-multi-regional-deployment), and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery).

## Next step

> [!div class="nextstepaction"]
> [PaaS AI implementation options](../platform/implementation-options.md)