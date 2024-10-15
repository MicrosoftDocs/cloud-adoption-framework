---
title: Manage AI – Recommendations for managing AI
description: Learn about essential AI management strategies for models, costs, security, operations, compliance, and data in this comprehensive guide.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Manage AI – Recommendations for managing AI

This article provides recommendations for managing AI workloads from development, deployment, and operations. Effective AI management requires a structured approach from development through deployment and ongoing operations. Businesses need standardized practices and regular monitoring to prevent issues such as data and model drift, ensuring AI remains accurate and reliable over time.

:::image type="content" source="./images/manageai.svg" alt-text="Diagram showing the AI adoption framework process. It highlights Manage AI. The process with AI Strategy, AI Plan, AI Ready as sequential steps. Then Secure AI, Govern AI, and Manage AI are cyclical processes after AI Ready. Undergirding the entire process is Responsible AI." lightbox="./images/manageai.svg" border="false":::
*Figure 1. Manage AI in the AI adoption process.*

## Manage AI operations

Managing AI operations ensures visibility and consistency throughout the AI lifecycle. By adopting operational frameworks like MLOps, creating sandbox environments, and establishing CI/CD pipelines, you can oversee development, testing, and deployment.

- *Adopt an AI operational framework.* Implement [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) (Machine learning operations) frameworks for traditional machine learning workflows and [GenAIOps](/azure/machine-learning/prompt-flow/how-to-end-to-end-azure-devops-with-prompt-flow) for generative AI workloads. These operational frameworks organize the end-to-end cycle for AI development.

- *Use a sandbox environment for AI experimentation.* Use a sandbox environment for AI model experimenting. You want to consistency across dev, test, and prod environments. So, the sandbox environment should be distinct from dev, test, and production environments in the AI development lifecycle. Changing deployment and governance models between dev, test, and prod can hide and introduce breaking changes.

- *Establish continuous integration and continuous delivery pipelines for deployment.* Ensure that your data pipelines cover code quality checks, including linting and static analysis. Data pipelines should also include unit and integration tests, as well as experimentation and evaluation flows. Finally, incorporate production deployment steps, such as promoting releases to test and production environments following manual approvals. Maintain separation between models, prompt flows, and the client user interface to ensure updates to one component don't affect others. Each flow should have its own lifecycle for independent promotion.

- *Standardize AI development tools.* Define and standardize the use of SDKs and APIs for consistency across development teams. Tools like [Azure SDK](/azure/developer/) for AI workloads provide libraries and APIs that are optimized for scaling AI models and integrating them into applications. For generative AI, standardize your AI platform and orchestrators, such as [Semantic Kernel](/semantic-kernel/overview/), LangChain, and [Prompt Flow](/azure/ai-studio/how-to/prompt-flow).

## Manage AI models

AI model management involves setting governance structures, continuous monitoring, and retraining to maintain performance over time. This process helps businesses align models with ethical standards, track model performance, and ensure that AI systems remain effective and aligned with business objectives.

- *Establish a governance structure for AI oversight.* The AI CoE should ensure adherence to ethical and operational standards. Assign roles such as AI audit leads, data privacy officers, and fairness officers who are responsible for continuous measurement, compliance, and reporting. Use the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to generate reports around model outputs. This committee should make decisions on whether systems need to be adjusted based on these reports.

- *Define an AI measurement baseline.* Establish a measurement baseline to ensure that AI models align with business goals and ethical standards. Use KPIs that are related to Responsible AI principles like fairness, transparency, and accuracy. Map these KPIs to AI workloads. For example, in a customer service chatbot, measure fairness by evaluating how well the model performs across different demographic groups. To take these measurements, start with the tools used in the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard).

- *Implement continuous monitoring.* AI workloads can change over time due to evolving data, model updates, or shifts in user behavior. Implement a monitoring system to ensure that these workloads remain aligned with KPIs. Conduct audits to assess AI systems against the defined Responsible AI principles and metrics.

- *Identify root causes of performance issues.* Pinpoint the source of the issue when a drop in performance or accuracy is detected by monitoring the AI. Ensure that you have visibility into each stage of the interaction to isolate the problem and implement corrective actions more quickly. For example, if a customer service chatbot generates inaccurate responses, monitoring should help you determine whether the error is in the prompt crafting or the model's understanding of context. Use built-in tools like Azure Monitor and Application Insights to proactively identify performance bottlenecks and anomalies.

- *Track model retirement.** Track retirement for pretrained models to prevent performance issues as vendor support ends. For instance, a generative AI model might be deprecated, so you'd need to update it to maintain functionality. Studio shows the model retirement date for all deployments.

- *Retrain AI models as needed.* Account for models degrading over time because of changes in data. Schedule regular retraining based on model performance or business needs to ensure that the AI system stays relevant. Retraining can be expensive, so assess the initial training cost and use that cost to evaluate how frequently you should retrain AI models. Maintain version control for models and ensure a rollback mechanism for underperforming versions.

- *Establish model promotion process.* Use quality gates to promote trained, fine-tuned, and retrained models to higher environments based on performance criteria. The performance criteria are unique to each application.

## Manage AI costs

Managing AI costs requires a clear understanding of expenses related to resources like compute, storage, and token processing. You should implement cost management best practices, monitor usage, and set up automated alerts to avoid unexpected expenses and optimize resource efficiency.

- *Follow cost management best practices for each service.* Each Azure service has specific features and best practices that maximize cost optimization. Familiarize yourself with following guidance for planning and managing cost in [Azure AI Studio](/azure/ai-studio/how-to/costs-plan-manage), [Azure OpenAI Service](/azure/ai-services/openai/how-to/manage-costs), [Azure Machine Learning](/azure/machine-learning/concept-plan-manage-cost), [Azure Virtual Machines](/azure/virtual-machines/cost-optimization-plan-to-manage-costs).

- *Monitor and maximize billing efficiency.* Understand cost breakpoints to avoid unnecessary charges. Examples include making full use of fixed-price thresholds for image generation or hourly fine-tuning. Track your usage patterns, including tokens per minute (TPM) and requests per minute (RPM), and adjust models and architecture accordingly. Consider a commitment-based billing model for consistent usage patterns.

- *Set up automated cost alerts.* Use budget alerts notify you of unexpected charges and establish budgeting strategies to control and predict your AI expenses.

For generative AI applications using Azure OpenAI, see these [cost optimization recommendations.](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization).

## Manage AI data

Effective AI data management focuses on maintaining data accuracy, integrity, and sensitivity throughout the AI lifecycle. By curating high-quality datasets and securing data pipelines, businesses can ensure that data remains reliable and compliant with changing regulatory requirements.

- *Maintain data accuracy and curate golden datasets.* Develop an authoritative set of data used for regular testing and validation across both AI types. Continuously curate this dataset to ensure it reflects up-to-date, accurate information.

- *Ensure data pipeline integrity.* Develop and maintain custom data pipelines to ensure data integrity from data collection to preprocessing and storage. Each step of the pipeline must be secure to maintain performance and reliability in both types of AI applications.

- *Manage data sensitivity changes.* Understand that the sensitivity classification of data can change over time. You might want to reclassify low sensitivity data as highly sensitive because of business or regulatory changes. Develop processes for removing or replacing sensitive data in downstream systems. [Microsoft Defender for Cloud](/azure/defender-for-cloud/data-security-posture-enable) and [Microsoft Purview](/purview/purview-security) can help you label and manage sensitive data. This process starts with a good data catalog before AI ingestion. When changes occur, identify all models or systems that use the sensitive data. If possible, retrain AI models by using datasets that exclude the reclassified sensitive data.

## Manage business continuity and disaster recovery

Business continuity and disaster recovery for AI involve creating multi-region deployments and regularly testing recovery plans. These strategies help ensure AI systems remain operational during disruptions and minimize the risk of prolonged outages or data loss.

- *Use multiregion deployments for AI.* Implement multiregion deployments to ensure high availability and resiliency for both generative and nongenerative AI systems. These strategies minimize downtime and ensure that critical AI applications remain operational during regional outages or infrastructure failures. Make sure to implement the necessary redundancy for trained and fine-tuned models to avoid the need for retraining during an outage.

- *Test and validate disaster recovery plans regularly.* Perform regular tests of disaster recovery plans to verify that you can restore generative and nongenerative AI systems effectively. Include testing of data restoration processes and validation procedures to ensure that all AI components are functioning properly after recovery. Validating regularly ensures that the organization is prepared for real-world incidents and minimizes the risk of failures during recovery.

- *Manage and track changes to AI systems.* Ensure that all changes to models, data, and configurations are managed through version control systems such as Git. Doing so is critical for tracking modifications and ensuring the ability to restore previous versions during recovery. For generative and nongenerative AI, automated auditing of model and system changes should be in place so that you can quickly identify and revert unplanned alterations.

## Next step

> [!div class="nextstepaction"]
> [AI management lifecycle](./index.md#how-to-adopt-ai-on-azure)
