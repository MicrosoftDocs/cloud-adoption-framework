---
title: Govern AI – Recommendations to govern AI
description: This guidance provides recommendations for governing AI, covering models, costs, security, operations, compliance, and data management.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Govern AI – Recommendations to govern AI

This article offers recommendations for developing your AI governance framework. It assumes you're already familiar with the governance processes defined in [CAF Govern](/azure/cloud-adoption-framework/govern/) and doesn't repeat the common cloud governance practices found there. Additionally, it presumes you established governance policies at the management group level for your AI workload types, such as internet-facing ("online") and internal ("corporate") workloads, which was covered in [AI Ready](ready.md#prepare-ai-resource-organization).

The following recommendations are intended as a starting point for your AI governance. The goal is to create a unified governance framework to mitigate AI risks. You must assess the risks specific to your business and stay vigilant about emerging risks, so you can update your AI governance policies accordingly.

## Govern AI models

This guidance outlines recommendations to control the input and output of AI model endpoints.

- *Govern generative AI models.* Generative AI models are nondeterministic and require governance controls tailored to their algorithms.

- *Define baseline content filters for generative AI models.* Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to define a baseline content filter for your approved AI models. This safety system works by running both the prompt and completion for your model through an ensemble of classification models. These classification models detect and prevent the output of harmful content across a range of categories. It provides features such as prompt shields, groundedness protection, protected material text detection, and scans images and text. Create a process for application teams to communicate different governance needs.

- *Establish a process to detect AI risks*. Use tools like Microsoft Defender for Cloud to [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [explore risks to predeployment generative AI artifacts.](/azure/defender-for-cloud/explore-ai-risk) Establish a policy to regularly [red-team generative AI models](/azure/ai-services/openai/concepts/red-teaming). Document identified risks and continuously update your AI governance policies to mitigate emerging issues.

- *Ground generative AI models.* Use [system messages](/azure/ai-services/openai/concepts/system-message?context=%2Fazure%2Fai-studio%2Fcontext%2Fcontext) and the [retrieval augmented generation](/azure/ai-studio/concepts/retrieval-augmented-generation) (RAG) pattern to govern the output of generative AI models. Test the grounding effectiveness using tools, such as [prompt flow](/azure/ai-studio/how-to/prompt-flow) or the open-source red-teaming tools, PyRIT.

- *Consider a reverse proxy for monitoring.* A reverse proxy like Azure API Management allows you to implement logging and monitoring that aren’t native to the platform. It allows you to collect source IPs, input text, and output text. For more information, see [Implement logging and monitoring for Azure OpenAI language models.](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai)

- *Invest in a golden data set.* Create a golden data set—a collection of preferred answers to common user queries—which serves as a benchmark for testing AI applications. This dataset can significantly streamline the iterative development process, ensuring that models consistently produce high-quality, expected outputs.

- *Establish policies for which models to use.* Different AI models serve different use cases. Create a policy for approving AI models that factors in the cost, model capabilities and tasks, and source of AI models.

- *Establish a policy to onboard new models.* Use sandbox environments to experiment with different models. When you move a model to production, implement a formal onboarding process that includes justification, validation, and approval. Review existing models in the production catalog to prevent duplication and maintain streamlined operations.

## Govern AI costs

This guidance outlines recommendations to control cost of AI workloads.

- *Use the right billing model.* If you have predictable workloads, use AI commitment tiers in Azure AI services. Use Provisioned Throughput Units for cost savings compared to pay-as-you-go pricing with Azure OpenAI and OpenAI models via Azure AI Studio.

- *Choose the right model for your use case.***** Select the AI model that meets your needs without overspending. Use less expensive models like GPT-3.5-turbo instead of higher-cost options like GPT-4, unless the use case specifically demands it. For fine-tuning, maximize time usage within each billing period to avoid extra charges.

- *Set provisioning limits.* Allocate provisioning quotas for each model based on expected workloads to prevent unnecessary costs. Continuously monitor dynamic quotas to ensure they match actual demand and adjust accordingly to maintain optimal throughput without overspending.

- *Use the right deployment type.* Azure OpenAI models allow you to use different [deployment types.](/azure/ai-services/openai/how-to/deployment-types) Global deployment offers lower cost per token pricing on certain GPT models.

- *Evaluate hosting options.***** Choose the right hosting infrastructure based on your solution’s needs. For example, for generative AI workloads, options include managed online endpoints, Azure Kubernetes Service (AKS), or Azure App Service, each with its own billing model. Select the option that provides the best balance between performance and cost for your specific requirements.

- *Control client behavior in consumption-based services.***** Limit client access to your AI service by enforcing security protocols such as network controls, keys, and role-based access control (RBAC). Ensure clients use API constraints like max tokens and max completions, and where possible, batch requests to optimize efficiency. Keep prompts concise while providing necessary context to reduce token consumption.

- *Consider a generative AI gateway.* The [generative AI gateway](/azure/api-management/genai-gateway-capabilities) allows you to track token usage, throttle token usage, apply circuit breakers, and route to different AI endpoints to control costs.

- *Create a policy to shut down compute instances.* Define and enforce a policy for AI resources to use the auto shutdown feature on virtual machines and compute instances in Azure AI Studio and Azure Machine Learning. The auto shutdown is applicable to nonproduction environments or for production workloads that you can take offline for certain periods of time.

For more cost management guidance, see [Manage AI costs](manage.md#manage-ai-costs) and [Cost optimization in Azure OpenAI baseline](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization).

## Govern AI security

This guidance outlines recommendations to control the security risks to AI workloads.

- *Enable Microsoft Defender for Cloud on every subscription*. It’s a cost-effective approach to detect insecure configurations in your deployed resources. You should also enable [AI threat protection](/azure/defender-for-cloud/ai-threat-protection)

- *Deny public access to AI resources.* No PaaS services or AI model endpoints should be accessible from the public internet. For PaaS, use private endpoints for end user access. For Azure Virtual Machines, use a public load balancer and only permit access requests to the AI model endpoint through the load balancer. Use a jumpbox to manage your AI resources.

- *Configure access control.* Grant least privileged user access to centralized AI resources. For example, start with the Reader role (Azure role) and elevate to Contributor (Azure role) if the limited permissions slow application development.

- *Use managed identities.* Use managed identities on all supported Azure services. Grant least privilege access to application resources that need to access to AI model endpoints.

- *Use just-in-time access.* Use Privileged Identity Management (PIM) for just-in-time access.

## Govern AI operations

This guidance outlines recommendations to control AI workloads operations.

- *Consider centralizing AI model governance.* Having a single individual or team govern AI model endpoints makes it easier to standardize governance and monitor the endpoints. The AI CoE handles this function for the business as an extension of the Cloud CoE or standalone team. For more information, see [AI CoE](center-of-excellence.md)

- *Review and manage AI models*. Develop a policy for managing model versioning, especially as models are upgraded or retired. You need to maintain compatibility with existing systems and ensure a smooth transition between model versions.

- *Define business continuity and disaster recovery plan.* Establish a policy for business continuity and disaster recovery for your AI endpoints and AI data. Configure baseline disaster recovery for resources hosting your AI model endpoints, such as virtual machines ([Linux](/azure/virtual-machines/linux/tutorial-disaster-recovery), [Windows](/azure/virtual-machines/windows/tutorial-disaster-recovery)), [Azure AI Studio](/azure/ai-studio/how-to/disaster-recovery), [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning?view=azureml-api-2), [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery), or Azure AI services. All Azure data stores, such as [Azure Blob storage](/azure/storage/common/storage-disaster-recovery-guidance), [Azure Cosmos DB](/azure/cosmos-db/online-backup-and-restore), and [Azure SQL Database](/azure/azure-sql/accelerated-database-recovery), have reliability and disaster recovery guidance that you should follow.

- *Define baseline metrics for AI resources.* Enable recommended alert rules to receive notifications of deviations that indicate a decline in workload health. For example, see [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning), [Azure AI studio prompt flow deployments](/azure/ai-studio/how-to/monitor-quality-safety?tabs=azure-studio), [Azure Virtual Machines](/azure/azure-monitor/vm/monitor-virtual-machine-alerts), and guidance on individual Azure AI services.

## Govern AI regulatory compliance

This guidance outlines recommendations to control AI workload compliance with current and future AI regulations.

- *Automate compliance.* Use [Microsoft Purview Compliance Manager](/microsoft-365/compliance/compliance-manager-overview) to assess and manage compliance across cloud environments. Use the applicable [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry. Apply other policies based on the AI services you’re using, such as [Azure AI Studio](/azure/ai-services/security-controls-policy), [Azure Machine Learning](/azure/machine-learning/policy-reference), and [Azure Virtual Machines](/azure/virtual-machines/policy-reference).

- *Develop industry-specific compliance checklists.* Regulations and standards differ by industry and location. You need to know your regulatory requirements and compile checklists reflecting the regulatory demands relevant to your industry. Use standards, such as ISO/IEC 23053:2022 ("Framework for Artificial Intelligence Systems Using Machine Learning"), to audit your policies applied to AI workloads.

## Govern AI data

This guidance outlines recommendations to control AI data fed into AI models.

- *Establish a process for cataloging data.* Use a tool like [Microsoft Purview](/purview/what-is-data-catalog) to implement a unified data catalog and classification system across your organization. Integrate these policies into your CI/CD pipelines for AI development.

- *Maintain data security boundary.* Cataloging data helps ensure you don’t feed sensitive data into public facing AI endpoints. When you create indexes from certain data sources, the indexing process can remove the current security boundaries around data. Ensure any data ingested into AI models is classified and vetted according to centralized standards.

- *Prevent copyright infringement.* Use a content filtering system such as the [Protected material detection in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/protected-material) to filter out copyrighted material. If you're grounding, training, or fine-tuning an AI model, ensure you use legally obtained and properly licensed data while implementing safeguards to prevent the model from infringing on copyrights. Regularly reviewing outputs for intellectual property compliance.

- *Implement version control for grounding data.* Establish a version control process for grounding data, for example, in retrieval-augmented generation (RAG). Versioning ensures any changes to the underlying data or its structure are tracked and can be reverted if necessary, maintaining consistency across deployments.

## Next steps

> [!div class="nextstepaction"]
> [Manage AI](manage.md)

## Example AI risk mitigations

The following table outlines some common AI risks, a mitigation strategy, and a sample policy for each. The table isn’t a complete set of risks.

| Risk ID | AI risk  | Mitigation | Policy|
|---|---|---|---|
| R001    | Noncompliance with data protection laws  | Use Microsoft Purview Compliance Manager to evaluate data compliance.                                  | All AI development and deployment must comply with data protection laws by implementing the Security Development Lifecycle.          |
| R005    | Lack of transparency in AI decision-making | Apply a standardized framework and language to enhance transparency in AI processes and decision-making.                 | AI models must maintain transparency by thorough documentation and adopting the NIST AI Risk Management Framework.              |
| R006    | Inaccurate predictions           | Use Azure API Management to track AI model metrics to ensure accuracy and reliability.                          | AI models must ensure accurate predictions through continuous performance monitoring and enabling human feedback.               |
| R007    | Adversarial attack             | Use PyRIT to test AI systems for vulnerabilities and strengthen defenses.                                | AI systems must be secured against adversarial attacks by implementing the Security Development Lifecycle and conducting AI Red Team testing. |
| R008    | Insider threats              | Use Entra ID to enforce strict access controls based on roles and group memberships to limit insider access to sensitive data.      | Insider threats must be mitigated by enforcing strict identity and access management and ensuring continuous monitoring.           |
| R009    | Unexpected costs              | Use Azure Cost Management to track CPU, GPU, memory, and storage usage to ensure efficient resource utilization and prevent cost spikes. | Manage unexpected costs by monitoring and optimizing resource usage and implementing automated detection of cost overruns.      |
| R010    | Underutilization of AI resources      | Monitor AI service metrics such as request rates and response times to optimize usage.                          | AI resource utilization must be optimized by monitoring performance metrics and using automation for scalability.               |