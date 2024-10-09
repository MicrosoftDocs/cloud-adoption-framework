---
title: Manage AI – Recommendations for Managing AI
description: Learn about essential AI management strategies for models, costs, security, operations, compliance, and data in this comprehensive guide.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Manage AI – Recommendations for managing AI

This article provides recommendations for managing AI throughout its lifecycle, from development and deployment to ongoing operations. AI management requires standardization in development and deployment processes. Additionally, it includes regularly monitoring AI output to prevent data and model drift over time.

## Manage AI deployment

A primary consideration for AI endpoint management is deciding who can deploy AI resources and who’s responsible for governing the endpoints. The [AI Center of Excellence (AI CoE)](./center-of-excellence.md) should lead the effort to determine the best approach. There are two principal options:

- **Use workload-team management of AI resources for faster development.** When workload teams manage AI resources, they have the autonomy to deploy and manage AI resources within the confines of your governance policies. Use Azure Policy to enforce governance consistently across all workload environments. Create and communicate AI policies that the workload teams must follow to address any governance gaps. For example, create generative AI policies to enforce content filter settings and prevent the use of disallowed models. Make these policies clearly known to workload teams and audit regularly.

The following diagram shows the workload-team management of AI resources.

    :::image type="content" source="./images/workload-team-ai-management.svg" alt-text="Diagram that shows how a workload team manages resources for both internal and internet-facing AI workloads." lightbox="./images/workload-team-ai-management.svg" border="false":::

- **Use a shared management of AI resources to enhance AI governance.** In a shared AI management approach, a central team manages AI resources for all AI workloads. This team deploys core AI resources and configures security and governance that all workload teams use. Use this approach if you want a single team to control AI deployments and governance across your workloads. Azure AI Studio facilitates this approach with [Studio hubs and projects](/azure/ai-studio/concepts/ai-resources). The central AI team deploys and configures the hub. Then the workload teams use projects, which inherit hub configurations, to move from a proof of concept to production. Azure Machine Learning has similar capabilities with its [hub workspaces](/azure/machine-learning/concept-hub-workspace).

The following diagram shows the central AI team management of AI resources.

    :::image type="content" source="./images/central-ai-management.svg" alt-text="Diagram that shows how a central AI team manages resources for both internal and internet-facing AI workloads." lightbox="./images/central-ai-management.svg" border="false":::

## Manage AI endpoint sharing

This guidance provides recommendations for when to share and not share an AI endpoint across multiple workloads.

- **Avoid sharing AI endpoints when governance and model needs vary.** Workloads that require different content filter settings, such as governance on input and output, shouldn't share an endpoint. Also, don’t share a single AI endpoint if a different AI model would provide a more cost-effective way to meet workload requirements.

- **Share AI endpoints only within a single workload.** Sharing an AI endpoint works best when a workload team has multiple applications as part of the same workload. AI endpoint sharing provides the least amount of management overhead and simplifies deployment. These applications must share the same governance needs and AI model needs. Sharing endpoints can cause you to hit rate limits and quota limitations. Most Azure services have limits per subscription. Within a subscription, each region has quota limits.

## Manage AI operations

This guidance provides recommendations for establishing an operational framework for AI workloads. It describes how to establish visibility and consistency across the AI lifecycle.

- **Adopt an AI operational framework.** Implement [machine learning operations (MLOps)](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) frameworks for traditional machine learning workflows and [GenAIOps](/azure/machine-learning/prompt-flow/how-to-end-to-end-azure-devops-with-prompt-flow) for generative AI workloads. These operational frameworks organize the end-to-end cycle for AI development.

- **Use a sandbox environment for AI experimentation.** Use a sandbox environment for AI model experimenting. You want to have consistency across development, testing, and production environments. The sandbox environment should be distinct from development, testing, and production environments in the AI development lifecycle. Changing deployment and governance models between development, testing, and production can hide and introduce breaking changes.

- **Standardize compute management.** For platform as a service services, you need to provision compute resources for certain actions like prompt flows and training models. A service like Machine Learning has different compute options, such as compute instances, clusters, and serverless options. Standardize the compute type, runtimes, and shutdown periods. For service-specific compute options, see [Studio](/azure/ai-studio/how-to/create-manage-compute) and [Machine Learning](/azure/machine-learning/how-to-create-attach-compute-studio).

- **Monitor platform resources.** Use diagnostic settings to capture logs and metrics for all key services, such as Studio, Machine Learning, and [Azure AI services](/azure/ai-services/diagnostic-logging). Specific services should capture audit logs and relevant service-specific logs. Implement custom monitoring alerts based on your architecture’s specific needs. Examples include alerts for container registries, Machine Learning services, and Azure OpenAI Service operations.

- **Establish continuous integration and continuous delivery pipelines for deployment.** Ensure that your data pipelines cover code quality checks, including linting and static analysis. Data pipelines should also include unit and integration tests, as well as experimentation and evaluation flows. Finally, incorporate production deployment steps, such as promoting releases to test and production environments following manual approvals. Maintain separation between models, prompt flows, and the client user interface to ensure updates to one component don't affect others. Each flow should have its own lifecycle for independent promotion.

- **Standardize AI development tools.** Define and standardize the use of SDKs and APIs for consistency across development teams. Tools like [Azure SDK](/azure/developer/) for AI workloads provide libraries and APIs that are optimized for scaling AI models and integrating them into applications. For generative AI, standardize your AI platform and orchestrators, such as [Semantic Kernel](/semantic-kernel/overview/), LangChain, and [Prompt Flow](/azure/ai-studio/how-to/prompt-flow).

## Manage AI models

This guidance provides recommendations for measuring AI model performance over time and realigning it with Responsible AI principles.

- **Establish a governance structure for AI oversight.** The AI CoE should ensure adherence to ethical and operational standards. Assign roles such as AI audit leads, data privacy officers, and fairness officers who are responsible for continuous measurement, compliance, and reporting. Use the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to generate reports around model outputs. This committee should make decisions on whether systems need to be adjusted based on these reports.

- **Define an AI measurement baseline.** Establish a measurement baseline to ensure that AI models align with business goals and ethical standards. Use KPIs that are related to Responsible AI principles like fairness, transparency, and accuracy. Map these KPIs to AI workloads. For example, in a customer service chatbot, measure fairness by evaluating how well the model performs across different demographic groups. To take these measurements, start with the tools used in the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard).

- **Implement continuous monitoring.** Understand that AI workloads can change over time because of evolving data, model updates, or shifts in user behavior. Implement a monitoring system to ensure that these workloads remain aligned with KPIs. Conduct audits to assess AI systems against the defined Responsible AI principles and metrics. In generative AI, monitor inputs and outputs. Use Studio to [evaluate the output](/azure/ai-studio/concepts/evaluation-approach-gen-ai) of generative AI models [Responsible AI dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) tools. For nongenerative AI, monitor data processing stages and model performance metrics to ensure that predictions remain accurate and reliable.

- **Identify root causes of performance issues.** Pinpoint the source of the issue when a drop in performance or accuracy is detected by monitoring the AI. Ensure that you have visibility into each stage of the interaction to isolate the problem and implement corrective actions more quickly. For example, if a customer service chatbot generates inaccurate responses, monitoring should help you determine whether the error is in the prompt crafting or the model's understanding of context. Use built-in tools like Azure Monitor and Application Insights to proactively identify performance bottlenecks and anomalies. In generative AI, monitor latency in response times or the accuracy of vector search results to enhance user experiences. [Enable tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) to understand the process flow.

- **Track model retirement.** Track retirement for pretrained models to prevent performance issues as vendor support ends. For instance, a generative AI model might be deprecated, so you'd need to update it to maintain functionality. Studio shows the model retirement date for all deployments.

- **Retrain AI models as needed.** Account for models degrading over time because of changes in data. Schedule regular retraining based on model performance or business needs to ensure that the AI system stays relevant. Retraining can be expensive, so assess the initial training cost and use that cost to evaluate how frequently you should retrain AI models. Maintain version control for models and ensure a rollback mechanism for underperforming versions.

- **Establish model promotion process.** Use quality gates to promote trained, fine-tuned, and retrained models to higher environments based on performance criteria. The performance criteria are unique to each application.

## Manage AI costs

To manage AI costs, you need to understand the expenses related to AI resources. These expenses include compute, storage, and token processing. The cost management fundamentals apply here.

- **Monitor and maximize billing efficiency.** Understand cost breakpoints to avoid unnecessary charges. Examples include making full use of fixed-price thresholds for image generation or hourly fine-tuning. Track your usage patterns, including tokens per minute and requests per minute, and adjust models and architecture accordingly. Consider a commitment-based billing model for consistent usage patterns.

- **Set up automated cost alerts.** Use budget alerts to get notifications of unexpected charges and establish budgeting strategies to control and predict your AI expenses.

- **Follow cost management best practices for each service.** Use the specific features and best practices of each Azure service to maximize cost optimization. Familiarize yourself with the guidance for planning and managing cost in these articles: [Studio](/azure/ai-studio/how-to/costs-plan-manage), [Azure OpenAI](/azure/ai-services/openai/how-to/manage-costs), [Machine Learning](/azure/machine-learning/concept-plan-manage-cost), and [Azure Virtual Machines](/azure/virtual-machines/cost-optimization-plan-to-manage-costs).

For generative AI applications that use Azure OpenAI, see [Cost optimization recommendations](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization).

## Manage AI data

This guidance outlines best practices for ensuring data pipeline integrity, consistent ingestion, model versioning, drift detection, and high-quality processing.

- **Maintain data accuracy and curate golden datasets.** Develop an authoritative set of data that's used for regular testing and validation across both AI types. Continuously curate this dataset to ensure that it reflects up-to-date, accurate information.

- **Ensure data pipeline integrity.** Develop and maintain custom data pipelines to ensure data integrity throughout the stages of data collection, preprocessing, and storage. Each step of the pipeline must be secure to maintain performance and reliability in both types of AI applications.

- **Ensure high-quality data processing.** Format, clean, and prepare training data for model consumption in [machine learning](/azure/architecture/data-science-process/lifecycle-modeling). For generative AI, grounding data needs to be in the correct format. It also probably needs to be chunked, enriched, and embedded for AI model consumption. For more information, see [Guide to designing and developing a Retrieval-Augmented Generation solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

- **Manage model versioning and detect drift.** Track accuracy and data drift continuously in generative and nongenerative AI to ensure that models remain relevant. Monitoring can alert you when model predictions or large language model responses deviate from expected behavior. This deviation indicates a need for retraining or adjustment. Set up custom alerts to detect performance thresholds. This approach enables early intervention when problems arise. Use [evaluations in Studio](/azure/ai-studio/concepts/evaluation-approach-gen-ai) and [metrics supported in Machine Learning](/azure/machine-learning/concept-model-monitoring).

- **Manage data sensitivity changes.** Understand that the sensitivity classification of data can change over time. You might want to reclassify low sensitivity data as highly sensitive because of business or regulatory changes. Develop processes for removing or replacing sensitive data in downstream systems. [Microsoft Defender for Cloud](/azure/defender-for-cloud/data-security-posture-enable) and [Microsoft Purview](/purview/purview-security) can help you label and manage sensitive data. This process starts with a good data catalog before AI ingestion. When changes occur, identify all models or systems that use the sensitive data. If possible, retrain AI models by using datasets that exclude the reclassified sensitive data.

## Manage business continuity and disaster recovery

This guidance outlines business continuity and recovery processes for generative and nongenerative AI workloads.

- **Use multiregion deployments for AI.** Implement multiregion deployments to ensure high availability and resiliency for both generative and nongenerative AI systems. These strategies minimize downtime and ensure that critical AI applications remain operational during regional outages or infrastructure failures. Make sure to implement the necessary redundancy for trained and fine-tuned models to avoid the need for retraining during an outage. For more information, see multiregion deployment in [Studio](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment), [Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning#plan-for-multi-regional-deployment), and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery).

- **Test and validate disaster recovery plans regularly.** Perform regular tests of disaster recovery plans to verify that you can restore generative and nongenerative AI systems effectively. Include testing of data restoration processes and validation procedures to ensure that all AI components are functioning properly after recovery. Validating regularly ensures that the organization is prepared for real-world incidents and minimizes the risk of failures during recovery.

- **Manage and track changes to AI systems.** Ensure that all changes to models, data, and configurations are managed through version control systems such as Git. Doing so is critical for tracking modifications and ensuring the ability to restore previous versions during recovery. For generative and nongenerative AI, automated auditing of model and system changes should be in place so that you can quickly identify and revert unplanned alterations.

## Next step

> [!div class="nextstepaction"]
> [AI management lifecycle](./index.md#how-to-adopt-ai-on-azure)
