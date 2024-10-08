---
title: Manage AI – Recommendations for managing AI
description: Discover essential AI management strategies for models, costs, security, operations, compliance, and data in this comprehensive guide.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Manage AI – Recommendations for managing AI

This article provides recommendations for managing AI from development, deployment, and operations. AI management requires standardization in development and deployment and regularly measuring AI output to ensure data and models don't drift over time.

## Manage AI deployment

A primary consideration for AI endpoint management is deciding who can deploy AI resources and who’s responsible for governing the endpoints. The [AI CoE](./center-of-excellence.md) should lead the effort to determine the best approach. There are two principal options:

- *Use workload-team management AI resources for faster development.* When workload teams manage AI resources, they have to autonomy to deploy and manage AI resources within the confines of your governance policies. Use Azure Policy to enforce governance consistently across all workload environments. Where there are governance gaps, create and communicate AI policies that the workload teams must follow. For example, create generative AI policies for content filter settings and disallowed models. Make these policies clearly known to workload teams and audit regularly.

- *Use a shared AI management for increased AI governance.* In a shared management approach, a single team manages AI resources for all AI workloads. This team deploys core AI resources and configures security and governance that all workload teams use. Use this approach if want to a single team to control AI deployments and governance across your workloads. Azure AI Studio facilitates this approach with [Azure AI Studio hubs and projects](/azure/ai-studio/concepts/ai-resources). The central AI team deploys and configures the hub. Then the workload teams use projects, which inherit hub configurations, to move from a proof of concept to production. Azure Machine Learning has similar capabilities with its [Azure Machine Learning hub workspaces](/azure/machine-learning/concept-hub-workspace).

## Manage AI endpoint sharing

This guidance provides recommendations on when to share and not share an AI endpoint across multiple applications.

- *Don’t share AI endpoints when governance and model needs vary.* Applications that require different content filter settings (governance on input and output) shouldn't share an endpoint. Also don’t share a single AI endpoint if a different AI model would provide a more cost-effective way to meet application requirements.

- *Only share AI endpoints within a single workload.* Sharing an AI endpoint works best when a workload team has multiple applications. AI endpoint sharing provides the least amount of management overhead and simplifies deployment. These applications must share the same governance needs and AI model needs. Sharing endpoints could cause you to hit rate limits and quota limitations. Most Azure services have limits per subscription. Within a subscription, each region has quota limits.

## Manage AI operations

This guidance provides recommendations for establishing an operational framework for AI workloads and how to establish visibility and consistency across the AI lifecycle.

- *Adopt an AI operational framework.* Implement [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) (Machine learning operations) frameworks for traditional machine learning workflows and [GenAIOps](/azure/machine-learning/prompt-flow/how-to-end-to-end-azure-devops-with-prompt-flow) for generative AI workloads. These operational frameworks organize the end-to-end cycle for AI development.

- *Use a sandbox environment for AI experimentation.* Use a sandbox environment for AI model experimenting. You want to consistency across dev, test, and prod environments. So, the sandbox environment should be distinct from dev, test, and production environments in the AI development lifecycle. Changing deployment and governance models between dev, test, and prod can hide and introduce breaking changes.

- *Standardize compute management.* For PaaS services, you need to provision compute resources for certain actions like prompt flows and training models. A service like Azure Machine Learning has different compute options, such as compute instances, clusters, and serverless options. You want to standardize the compute type, runtimes, and shutdown periods. For service-specific compute options, see [Azure AI Studio](/azure/ai-studio/how-to/create-manage-compute) and [Azure Machine Learning](/azure/machine-learning/how-to-create-attach-compute-studio).

- *Monitor platform resources.* Use diagnostic settings to capture logs and metrics for all key services, such as Azure AI Studio, Azure Machine Learning, [Azure AI services](/azure/ai-services/diagnostic-logging). Specific services should capture audit logs and relevant service-specific logs. Implement custom monitoring alerts based on your architecture’s specific needs. Examples include alerts for container registries, Machine Learning services, and Azure OpenAI operations.

- *Establish CI/CD pipelines for deployment.* Ensure your data pipelines cover: Code quality checks (linting, static analysis), unit and integration tests, experimentation and evaluation flows, production deployment steps, such as promoting releases to test and production environments following manual approvals. Maintain separation between models, prompt flows, and the client user interface to ensure updates to one component don't impact others. Each flow should have its own lifecycle for independent promotion.

- *Standardize AI development tools.* Define and standardize the use of SDKs and APIs for consistency across development teams. Tools like [Azure SDK](/azure/developer/) for AI workloads provide libraries and APIs that are optimized for scaling AI models and integrating them into applications. For generative AI, standardize your AI platform and orchestrators, such as [Semantic Kernel](/semantic-kernel/overview/), LangChain, and [Prompt Flow](/azure/ai-studio/how-to/prompt-flow).

## Manage AI models

This guidance provides recommendations for measuring AI model performance over time and realign it with Responsible AI principles.

- *Establish a governance structure for AI oversight.* The AI CoE should ensure adherence to ethical and operational standards. Assign roles such as AI audit leads, data privacy officers, and fairness officers who are responsible for continuous measurement, compliance, and reporting. Use the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to generate reports around model outputs. This committee should make decisions on whether systems need to be adjusted based on these reports.

- *Define AI measurement baseline.* Establishing a measurement baseline ensures AI models align with business goals and ethical standards. Use KPIs tied to Responsible AI principles like fairness, transparency, and accuracy. Map these KPIs to AI workloads. For example, in a customer service chatbot, measure fairness by evaluating how well the model performs across different demographic groups. Start with the tools used in the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to take these measurements.

- *Implement continuous monitoring.* AI workloads can change over time due to evolving data, model updates, or shifts in user behavior. Implement a monitoring system to ensure that these workloads remain aligned with KPIs. Conduct audits to assess AI systems against the defined Responsible AI principles and metrics. In generative AI, monitor inputs and outputs. Use Azure AI Studio to [evaluate](/azure/ai-studio/concepts/evaluation-approach-gen-ai) the output of generative AI models [Responsible AI dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) tools. For nongenerative AI, monitor data processing stages and model performance metrics to ensure predictions remain accurate and reliable.

- *Identify root causes of performance issues.* When a drop in performance or accuracy is detected, monitoring helps pinpoint the source of the issue. Ensure you have visibility into each stage of the interaction to isolate the problem and implement corrective actions more quickly. For example, if a customer service chatbot generates inaccurate responses, monitoring should allow you to determine whether the error is in the prompt crafting or the model's understanding of context. Use built-in tools like Azure Monitor and Application Insights to proactively identify performance bottlenecks and anomalies. In generative AI, monitor latency in response times or the accuracy of vector search results to enhance user experiences. [Enable tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) to understand the execution process.

- *Track model retirement.* Tracking retirement for pretrained models avoids performance issues as vendor support ends. For instance, a generative AI model might be deprecated, requiring an update to maintain functionality. For example, Azure AI Studio shows the model retirement date for all deployments.

- *Retrain AI models as needed.* Models degrade over time due to changes in data. Schedule regular retraining based on model performance or business needs to ensure the AI system stays relevant. Retraining can be expensive so capture the initial training cost and use that cost to evaluate how frequently you should retrain AI models. Maintain version control for models and ensure a rollback mechanism for underperforming versions.

- *Establish model promotion process.* There should be quality gates to promote trained, fine-tuned, and retrained models to higher environments based on performance criteria. The performance criteria are unique to each application.

## Manage AI costs

To manage AI costs, you need to understand the expenses related to AI resources, including compute, storage, and token processing. The cost management fundamentals apply here.

- *Monitor and maximize billing efficiency.* Understand cost breakpoints to avoid unnecessary charges. Examples include making full use of fixed-price thresholds for image generation or hourly fine-tuning. Track your usage patterns, including tokens per minute (TPM) and requests per minute (RPM), and adjust models and architecture accordingly. Consider a commitment-based billing model for consistent usage patterns.

- *Set up automated cost alerts.* Use budget alerts notify you of unexpected charges and establish budgeting strategies to control and predict your AI expenses.

- *Follow cost management best practices for each service.* Each Azure service has specific features and best practices that maximize cost optimization. Familiarize yourself with following guidance for planning and managing cost in [Azure AI Studio](/azure/ai-studio/how-to/costs-plan-manage), [Azure OpenAI Service](/azure/ai-services/openai/how-to/manage-costs), [Azure Machine Learning](/azure/machine-learning/concept-plan-manage-cost), [Azure Virtual Machines](/azure/virtual-machines/cost-optimization-plan-to-manage-costs)

For generative AI applications using Azure OpenAI, see these [cost optimization recommendations.](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization)

## Manage AI data

This guidance outlines best practices for ensuring data pipeline integrity, consistent ingestion, model versioning, drift detection, and high-quality processing.

- *Maintain data accuracy and curate golden datasets.* Develop an authoritative set of data used for regular testing and validation across both AI types. Continuously curate this dataset to ensure it reflects up-to-date, accurate information.

- *Ensure data pipeline integrity.* Develop and maintain custom data pipelines to ensure data integrity from data collection to preprocessing and storage. Each step of the pipeline must be secure to maintain performance and reliability in both types of AI applications.

- *Ensure high-quality data processing.* For [machine learning](/azure/architecture/data-science-process/lifecycle-modeling), training data must be formatted, clean, and ready for model consumption. For generative AI, grounding data needs to be in the correct format, and likely chunked, enriched, and embedded for AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

- *Manage model versioning and detect drift.* In both generative and nongenerative AI, continuously track accuracy and data drift to ensure models remain relevant. Monitoring can alert you when model predictions or LLM responses start to deviate from expected behavior, indicating a need for retraining or adjustment. Set up custom alerts to detect performance thresholds, enabling early intervention when problems arise. Use [Evaluations in Azure AI Studio](/azure/ai-studio/concepts/evaluation-approach-gen-ai) and metrics supported in [Azure Machine Learning](/azure/machine-learning/concept-model-monitoring).

- *Manage data sensitivity changes.* The sensitivity classification of data can change over time. You might want to reclassify low sensitivity as highly sensitive due to business or regulatory changes. Develop processes for removing or replacing sensitive data in downstream systems. [Microsoft Defender for Cloud](/azure/defender-for-cloud/data-security-posture-enable) and [Microsoft Purview](/purview/purview-security) can help you label and manage sensitive data. This process starts with a good data catalog before AI ingestion. When the change happens, identify all models or systems that use the sensitive data. If feasible, retrain AI models using datasets that exclude the reclassified sensitive data.

## Manage business continuity and disaster recovery

This guidance outlines business continuity and recovery processes for both generative and nongenerative AI workloads.

- *Use multi-region deployments for AI.* Implement multi-region deployments to ensure high availability and resiliency for both generative and nongenerative AI systems. These strategies minimize downtime and ensure critical AI applications remain operational during regional outages or infrastructure failures. Make sure to implement the necessary redundancy for trained and fine-tuned models to avoid the need for retraining during an outage. For more information, see multi-region deployment in [Azure AI Studio,](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment) [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning#plan-for-multi-regional-deployment), and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery).

- *Regularly test and validate disaster recovery plans.* Perform regular tests of disaster recovery plans to verify that both generative and nongenerative AI systems can be restored effectively. Include testing of data restoration processes and validation procedures to ensure all AI components are functioning properly post-recovery. Regular validation ensures the organization is prepared for real-world incidents and minimizes the risk of failures during recovery.

- *Manage and track changes to AI systems.* Ensure all changes to models, data, and configurations are managed through version control systems such as Git. It’s critical for tracking modifications and ensuring the ability to restore previous versions during recovery. For both generative and nongenerative AI, automated auditing of model and system changes should be in place to quickly identify and revert unplanned alterations.

## Next step

> [!div class="nextstepaction"]
> [AI management lifecycle](./index.md#how-to-adopt-ai-on-azure)
