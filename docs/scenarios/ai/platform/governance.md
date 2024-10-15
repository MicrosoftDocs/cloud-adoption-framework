---
title: Governance for AI workloads on Azure platforms
description: Discover how to build AI applications on Azure PaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Governance for AI workloads on Azure platforms

This guidance assumes that you've established governance policies at the management group level for your AI workload types, like internet-facing (online) and internal (corporate) workloads. These polices are covered in [AI Ready](ready.md#prepare-ai-resource-organization). The following recommendations are intended as a starting point for your AI governance.

## Govern AI models

Organizations need clear processes for managing AI models to ensure reliable, safe, and ethical outputs. Controls over AI model inputs and outputs help mitigate risks, such as harmful content and unintended behaviors, which could have serious implications for both users and the organization.

- *Establish a process to detect AI risks.* Use tools like Defender for Cloud to [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [explore risks to predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk). Establish a policy to regularly [red team generative AI models](/azure/ai-services/openai/concepts/red-teaming). Document identified risks and continuously update your AI governance policies to mitigate emerging issues.

- *Define baseline content filters for generative AI models.* Use [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to define a baseline content filter for your approved AI models. This safety system runs both the prompt and completion for your model through a group of classification models. These classification models detect and help prevent the output of harmful content across a range of categories. Content Safety provides features like prompt shields, groundedness detection, and protected material text detection. It scans images and text. Create a process for application teams to communicate different governance needs.

- *Ground generative AI models.* Use [system messages](/azure/ai-services/openai/concepts/system-message) and the [retrieval augmented generation](/azure/ai-studio/concepts/retrieval-augmented-generation) (RAG) pattern to govern the output of generative AI models. Test the effectiveness of grounding by using tools like [prompt flow](/azure/ai-studio/how-to/prompt-flow) or the open-source red teaming framework [PyRIT](https://github.com/Azure/PyRI#python-risk-identification-tool-for-generative-ai-pyrit).

## Govern AI costs

Controlling costs in AI workloads allows organizations to maximize efficiency while reducing expenses. Cost governance strategies ensure that AI investments align with business goals and help prevent unexpected expenses from over-provisioning or underutilization.

- *Use the right billing model.* If you have predictable workloads, use AI commitment tiers in Azure AI services. Use provisioned throughput units, which can be less expensive than pay-as-you-go pricing with Azure OpenAI and OpenAI models via Azure AI Studio.

- *Choose the right model for your use case.* Select the AI model that meets your needs without incurring excessive costs. Use less expensive models like GPT-3.5 Turbo instead of higher-cost options like GPT-4, unless the use case demands a more expensive model. For fine-tuning, maximize time usage within each billing period to avoid extra charges.

- *Set provisioning limits.* Allocate provisioning quotas for each model based on expected workloads to prevent unnecessary costs. Continuously monitor dynamic quotas to ensure that they match actual demand and adjust them accordingly to maintain optimal throughput without overspending.

- *Use the right deployment type.* Azure OpenAI models allow you to use different [deployment types](/azure/ai-services/openai/how-to/deployment-types). Global deployment offers lower cost-per-token pricing on certain GPT models.

- *Evaluate hosting options.* Choose the right hosting infrastructure, depending on your solution's needs. For example, for generative AI workloads, options include managed online endpoints, Azure Kubernetes Service (AKS), and Azure App Service, each with its own billing model. Select the option that provides the best balance between performance and cost for your specific requirements.

- *Control client behavior in consumption-based services.* Limit client access to your AI service by enforcing security protocols like network controls, keys, and role-based access control (RBAC). Ensure that clients use API constraints like max tokens and max completions. When possible, batch requests to optimize efficiency. Keep prompts concise, but provide necessary context to reduce token consumption.

- *Consider using a generative AI gateway.* A [generative AI gateway](/azure/api-management/genai-gateway-capabilities) allows you to track token usage, throttle token usage, apply circuit breakers, and route to different AI endpoints to control costs.

- *Create a policy to shut down compute instances.* Define and enforce a policy stating that AI resources must use the automatic shutdown feature on virtual machines and compute instances in Azure AI Studio and Azure Machine Learning. Automatic shutdown is applicable to nonproduction environments and production workloads that you can take offline for certain periods of time.

For more cost management guidance, see [Manage AI costs](manage.md#manage-ai-costs) and [Cost optimization in the Azure OpenAI baseline](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization).

## Govern AI platforms

Use Azure Policy to apply built-in policy definitions for each AI platform you're using. [Azure AI Search](/azure/search/policy-reference)

## Govern AI security

Security in AI workloads protects against potential threats that could compromise data, models, or infrastructure. Strong security practices for AI maintain the safety and integrity of these systems, reducing risks of unauthorized access and data breaches.

- *Enable Defender for Cloud on every subscription.* Defender for Cloud provides a cost-effective approach for detecting configurations in your deployed resources that aren't secure. You should also enable [AI threat protection](/azure/defender-for-cloud/ai-threat-protection).

- *Configure access control.* Grant least privilege user access to centralized AI resources. For example, start with the Reader Azure role, and elevate to the Contributor Azure role if the limited permissions slow down application development.

- *Use managed identities.* Use managed identities on all supported Azure services. Grant least privilege access to application resources that need to access AI model endpoints.

- *Use just-in-time access.* Use privileged identity management (PIM) for just-in-time access.

## Govern AI operations

Effective AI operations management ensures stable and consistent AI services for organizations. Centralized oversight and continuity plans enable companies to maintain reliable model performance and minimize downtime, which is essential for sustaining AI’s business value.

- *Review and manage AI models.* Develop a policy for managing model versioning, especially as models are upgraded or retired. You need to maintain compatibility with existing systems and ensure a smooth transition between model versions.

- *Define a business continuity and disaster recovery plan.* Establish a policy for business continuity and disaster recovery for your AI endpoints and AI data. Configure baseline disaster recovery for resources that host your AI model endpoints, like [Linux](/azure/virtual-machines/linux/tutorial-disaster-recovery) and [Windows](/azure/virtual-machines/windows/tutorial-disaster-recovery) virtual machines, [Azure AI Studio](/azure/ai-studio/how-to/disaster-recovery), [Azure Machine Learning](/azure/machine-learning/how-to-high-availability-machine-learning), [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery), or Azure AI services. All Azure data stores, such as [Azure Blob Storage](/azure/storage/common/storage-disaster-recovery-guidance), [Azure Cosmos DB](/azure/cosmos-db/online-backup-and-restore), and [Azure SQL Database](/azure/azure-sql/accelerated-database-recovery), provide reliability and disaster recovery guidance that you should follow.

- *Define baseline metrics for AI resources.* Enable recommended alert rules to receive notifications of deviations that indicate a decline in workload health. For examples, see [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning), [Azure AI Studio prompt flow deployments](/azure/ai-studio/how-to/monitor-quality-safety?tabs=azure-studio), and guidance on individual Azure AI services.

## Govern AI regulatory compliance

Regulatory compliance in AI ensures that organizations adhere to industry standards and legal requirements. Robust compliance measures help mitigate risks related to legal liabilities and build trust in AI solutions among users, clients, and regulators.

- *Automate compliance.* Use [Microsoft Purview Compliance Manager](/microsoft-365/compliance/compliance-manager-overview) to assess and manage compliance across cloud environments. Use the applicable [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry. Apply other policies based on the AI services that you use, such as [Azure AI Studio](/azure/ai-services/security-controls-policy) and [Azure Machine Learning](/azure/machine-learning/policy-reference).

- *Develop industry-specific compliance checklists.* Regulations and standards differ by industry and location. You need to know your regulatory requirements and compile checklists that reflect the regulatory demands that are relevant to your industry. Use standards, such as ISO/IEC 23053:2022 (Framework for Artificial Intelligence Systems Using Machine Learning), to audit policies that are applied to your AI workloads.

## Govern AI data

Proper data governance for AI ensures that only appropriate, compliant data feeds into models. This safeguards data privacy and intellectual property, reducing risks associated with data misuse and enhancing the quality and reliability of AI outputs.

- *Establish a process for cataloging data.* Use a tool like [Microsoft Purview](/purview/what-is-data-catalog) to implement a unified data catalog and classification system across your organization. Integrate these policies into your CI/CD pipelines for AI development.

- *Maintain data security boundaries.* Cataloging data helps ensure that you don't feed sensitive data into public-facing AI endpoints. When you create indexes from certain data sources, the indexing process can remove the security boundaries around data. Ensure that any data ingested into AI models is classified and vetted according to centralized standards.

- *Prevent copyright infringement.* Use a content filtering system like [Protected material detection in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/protected-material) to filter out copyrighted material. If you're grounding, training, or fine-tuning an AI model, ensure that you use legally obtained and properly licensed data and implement safeguards to prevent the model from infringing on copyrights. Regularly review outputs for intellectual property compliance.

- *Implement version control for grounding data.* Establish a version control process for grounding data, for example, in RAG. Versioning ensures that any changes to the underlying data or its structure are tracked and can be reverted if necessary, which maintains consistency across deployments.

## Next step

> [!div class="nextstepaction"]
> [PaaS AI Management](../platform/management.md)
