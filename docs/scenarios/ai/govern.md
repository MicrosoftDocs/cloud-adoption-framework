---
title: Govern AI – Recommendations for governing AI
description: Get recommendations for governing AI. Get recommendations for governing models, costs, security, operations, compliance, and data management.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Govern AI – Recommendations for governing AI

This article provides recommendations for developing an AI governance framework. It assumes that you're already familiar with the governance processes defined in [Govern overview](/azure/cloud-adoption-framework/govern/) and doesn't repeat the common cloud governance practices described there. Additionally, it assumes that you've established governance policies at the management group level for your AI workload types, like internet-facing (online) and internal (corporate) workloads. These polices are covered in [AI Ready](ready.md#prepare-ai-resource-organization).

The following recommendations are intended as a starting point for your AI governance. The goal is to create a unified governance framework to mitigate AI risks. You need to assess the risks that are specific to your business and stay vigilant about emerging risks so that you can update your AI governance policies accordingly.

## Govern AI models

This guidance outlines recommendations for controlling the input and output of AI model endpoints.

- *Govern generative AI models.* Generative AI models are nondeterministic and require governance controls that are tailored to their algorithms.

- *Define baseline content filters for generative AI models.* Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to define a baseline content filter for your approved AI models. This safety system runs both the prompt and completion for your model through a group of classification models. These classification models detect and help prevent the output of harmful content across a range of categories. Content Safety provides features like prompt shields, groundedness detection, and protected material text detection. It scans images and text. Create a process for application teams to communicate different governance needs.

- *Establish a process to detect AI risks.* Use tools like Defender for Cloud to [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [explore risks to predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk). Establish a policy to regularly [red team generative AI models](/azure/ai-services/openai/concepts/red-teaming). Document identified risks and continuously update your AI governance policies to mitigate emerging issues.

- *Ground generative AI models.* Use [system messages](/azure/ai-services/openai/concepts/system-message?context=%2Fazure%2Fai-studio%2Fcontext%2Fcontext) and the [retrieval augmented generation](/azure/ai-studio/concepts/retrieval-augmented-generation) (RAG) pattern to govern the output of generative AI models. Test the effectiveness of grounding by using tools like [prompt flow](/azure/ai-studio/how-to/prompt-flow) or the open-source red teaming framework PyRIT.

- *Consider a reverse proxy for monitoring.* A reverse proxy like Azure API Management allows you to implement logging and monitoring that aren't native to the platform. API Management allows you to collect source IPs, input text, and output text. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

- *Invest in a golden dataset.* Create a golden dataset that serves as a benchmark for testing AI applications. A golden dataset is a collection of preferred answers to common user queries. This dataset can significantly streamline the iterative development process, which ensures that models consistently produce high-quality, expected outputs.

- *Establish policies for which models to use.* Different AI models serve different use cases. Create a policy for approving AI models that factors in the cost, model capabilities and tasks, and source of AI models.

- *Establish a policy to onboard new models.* Use sandbox environments to experiment with different models. When you move a model to production, implement a formal onboarding process that includes justification, validation, and approval. Review existing models in the production catalog to prevent duplication and maintain streamlined operations.

## Govern AI costs

This guidance outlines recommendations for controlling the cost of AI workloads.

- *Use the right billing model.* If you have predictable workloads, use AI commitment tiers in Azure AI services. Use provisioned throughput units, which can be less expensive than pay-as-you-go pricing with Azure OpenAI and OpenAI models via Azure AI Studio.

- *Choose the right model for your use case.* Select the AI model that meets your needs without incurring excessive costs. Use less expensive models like GPT-3.5 Turbo instead of higher-cost options like GPT-4, unless the use case demands a more expensive model. For fine-tuning, maximize time usage within each billing period to avoid extra charges.

- *Set provisioning limits.* Allocate provisioning quotas for each model based on expected workloads to prevent unnecessary costs. Continuously monitor dynamic quotas to ensure that they match actual demand and adjust them accordingly to maintain optimal throughput without overspending.

- *Use the right deployment type.* Azure OpenAI models allow you to use different [deployment types](/azure/ai-services/openai/how-to/deployment-types). Global deployment offers lower cost-per-token pricing on certain GPT models.

- *Evaluate hosting options.* Choose the right hosting infrastructure, depending on your solution's needs. For example, for generative AI workloads, options include managed online endpoints, Azure Kubernetes Service (AKS), and Azure App Service, each with its own billing model. Select the option that provides the best balance between performance and cost for your specific requirements.

- *Control client behavior in consumption-based services.* Limit client access to your AI service by enforcing security protocols like network controls, keys, and role-based access control (RBAC). Ensure that clients use API constraints like max tokens and max completions. When possible, batch requests to optimize efficiency. Keep prompts concise, but provide necessary context to reduce token consumption.

- *Consider using a generative AI gateway.* A [generative AI gateway](/azure/api-management/genai-gateway-capabilities) allows you to track token usage, throttle token usage, apply circuit breakers, and route to different AI endpoints to control costs.

- *Create a policy to shut down compute instances.* Define and enforce a policy stating that AI resources must use the automatic shutdown feature on virtual machines and compute instances in Azure AI Studio and Azure Machine Learning. Automatic shutdown is applicable to nonproduction environments and production workloads that you can take offline for certain periods of time.

For more cost management guidance, see [Manage AI costs](manage.md#manage-ai-costs) and [Cost optimization in the Azure OpenAI baseline](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization).

## Govern AI security

This guidance outlines recommendations for controlling security risks to AI workloads.

- *Enable Defender for Cloud on every subscription.* Defender for Cloud provides a cost-effective approach for detecting configurations in your deployed resources that aren't secure. You should also enable [AI threat protection](/azure/defender-for-cloud/ai-threat-protection).

- *Deny public access to AI resources.* Platform as a service (PaaS) services and AI model endpoints shouldn't be accessible from the public internet. For PaaS, use private endpoints for end user access. For Azure Virtual Machines, use a public load balancer and only permit access requests to the AI model endpoint through the load balancer. Use a jumpbox to manage your AI resources.

- *Configure access control.* Grant least privilege user access to centralized AI resources. For example, start with the Reader Azure role, and elevate to the Contributor Azure role if the limited permissions slow down application development.

- *Use managed identities.* Use managed identities on all supported Azure services. Grant least privilege access to application resources that need to access AI model endpoints.

- *Use just-in-time access.* Use privileged identity management (PIM) for just-in-time access.

## Govern AI operations

This guidance outlines recommendations for controlling AI workload operations.

- *Consider centralizing AI model governance.* Having a single individual or team govern AI model endpoints makes it easier to standardize governance and monitor the endpoints. The AI Center of Excellence (CoE) handles this function for the business as an extension of the Cloud CoE or standalone team. For more information, see [AI CoE](center-of-excellence.md).

- *Review and manage AI models.* Develop a policy for managing model versioning, especially as models are upgraded or retired. You need to maintain compatibility with existing systems and ensure a smooth transition between model versions.

- *Define a business continuity and disaster recovery plan.* Establish a policy for business continuity and disaster recovery for your AI endpoints and AI data. Configure baseline disaster recovery for resources that host your AI model endpoints, like [Linux](/azure/virtual-machines/linux/tutorial-disaster-recovery) and [Windows](/azure/virtual-machines/windows/tutorial-disaster-recovery) virtual machines, [Azure AI Studio](/azure/ai-studio/how-to/disaster-recovery), [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning), [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery), or Azure AI services. All Azure data stores, such as [Azure Blob Storage](/azure/storage/common/storage-disaster-recovery-guidance), [Azure Cosmos DB](/azure/cosmos-db/online-backup-and-restore), and [Azure SQL Database](/azure/azure-sql/accelerated-database-recovery), provide reliability and disaster recovery guidance that you should follow.

- *Define baseline metrics for AI resources.* Enable recommended alert rules to receive notifications of deviations that indicate a decline in workload health. For examples, see [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning), [Azure AI Studio prompt flow deployments](/azure/ai-studio/how-to/monitor-quality-safety?tabs=azure-studio), [Azure Virtual Machines](/azure/azure-monitor/vm/monitor-virtual-machine-alerts), and guidance on individual Azure AI services.

## Govern AI regulatory compliance

This guidance outlines recommendations for controlling AI workload compliance with current and future AI regulations.

- *Automate compliance.* Use [Microsoft Purview Compliance Manager](/microsoft-365/compliance/compliance-manager-overview) to assess and manage compliance across cloud environments. Use the applicable [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry. Apply other policies based on the AI services that you use, such as [Azure AI Studio](/azure/ai-services/security-controls-policy), [Azure Machine Learning](/azure/machine-learning/policy-reference), and [Azure Virtual Machines](/azure/virtual-machines/policy-reference).

- *Develop industry-specific compliance checklists.* Regulations and standards differ by industry and location. You need to know your regulatory requirements and compile checklists that reflect the regulatory demands that are relevant to your industry. Use standards, such as ISO/IEC 23053:2022 (Framework for Artificial Intelligence Systems Using Machine Learning), to audit policies that are applied to your AI workloads.

## Govern AI data

This guidance outlines recommendations for controlling AI data that's fed into AI models.

- *Establish a process for cataloging data.* Use a tool like [Microsoft Purview](/purview/what-is-data-catalog) to implement a unified data catalog and classification system across your organization. Integrate these policies into your CI/CD pipelines for AI development.

- *Maintain data security boundaries.* Cataloging data helps ensure that you don't feed sensitive data into public-facing AI endpoints. When you create indexes from certain data sources, the indexing process can remove the security boundaries around data. Ensure that any data ingested into AI models is classified and vetted according to centralized standards.

- *Prevent copyright infringement.* Use a content filtering system like [Protected material detection in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/protected-material) to filter out copyrighted material. If you're grounding, training, or fine-tuning an AI model, ensure that you use legally obtained and properly licensed data and implement safeguards to prevent the model from infringing on copyrights. Regularly review outputs for intellectual property compliance.

- *Implement version control for grounding data.* Establish a version control process for grounding data, for example, in RAG. Versioning ensures that any changes to the underlying data or its structure are tracked and can be reverted if necessary, which maintains consistency across deployments.

## Example AI risk mitigations

The following table lists some common AI risks and provides a mitigation strategy and a sample policy for each one. The table doesn't list a complete set of risks.

| Risk ID | AI risk  | Mitigation | Policy|
|---|---|---|---|
| R001    | Noncompliance with data protection laws  | Use Microsoft Purview Compliance Manager to evaluate data compliance.                                  |The Security Development Lifecycle must be implemented to ensure that all AI development and deployment complies with data protection laws.          |
| R005    | Lack of transparency in AI decision making | Apply a standardized framework and language to improve transparency in AI processes and decision making.                 | The NIST AI Risk Management Framework must be adopted and all AI models must be thoroughly documented to maintain transparency of all AI models.              |
| R006    | Inaccurate predictions           | Use Azure API Management to track AI model metrics to ensure accuracy and reliability.                          |Continuous performance monitoring and human feedback must be used to ensure that AI model predictions are accurate.               |
| R007    | Adversarial attack             | Use PyRIT to test AI systems for vulnerabilities and strengthen defenses.                                |The Security Development Lifecycle and AI red team testing must be used to secure AI systems against adversarial attacks. |
| R008    | Insider threats              | Use Microsoft Entra ID to enforce strict access controls that are based on roles and group memberships to limit insider access to sensitive data.      | Strict identity and access management and continuous monitoring must be used to mitigate insider threats.           |
| R009    | Unexpected costs              | Use Microsoft Cost Management to track CPU, GPU, memory, and storage usage to ensure efficient resource utilization and prevent cost spikes. |Monitoring and optimization of resource usage and automated detection of cost overruns must be used to manage unexpected costs.      |
| R010    | Underutilization of AI resources      | Monitor AI service metrics, like request rates and response times, to optimize usage.                          | Performance metrics and automated scalability must be used to optimize AI resource utilization.               |

## Next step

> [!div class="nextstepaction"]
> [Manage AI](manage.md)