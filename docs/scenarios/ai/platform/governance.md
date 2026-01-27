---
title: Govern Azure platform services (PaaS) for AI
description: Learn how to govern AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/17/2025
ms.topic: concept-article
---

# Govern Azure platform services (PaaS) for AI

This article describes governance practices for organizations that use Azure AI platform-as-a-service (PaaS) solutions. These practices help you build responsible AI systems and reduce security, cost, and compliance risks. Effective governance ensures that your AI investments align with your business goals.

## Govern AI platforms

AI platform governance uses policy controls to keep Foundry Tools operating consistently. Platform-level governance enforces security, compliance, and operational standards across your AI environment. Implement comprehensive policies to maintain oversight and improve AI management. To govern Azure AI platforms, follow these steps:

1. **Apply built-in governance policies for each AI platform.** Azure Policy offers predefined policy definitions for common governance needs in AI services. These policies enforce security settings, cost controls, and compliance requirements without custom development. Use Azure Policy to apply built-in policy definitions for:
- [Microsoft Foundry](/azure/ai-foundry/how-to/azure-policy)
- [Foundry Tools](/azure/ai-services/policy-reference)
- [Azure AI Search](/azure/search/policy-reference)

2. **Enable Azure landing zone AI policies for comprehensive coverage.** Azure landing zones provide curated policy sets for workload-specific governance. These policies use tested configurations that follow Microsoft recommendations for AI workloads. When you deploy an Azure landing zone, select the policy initiative under the *Workload Specific Compliance* category. Available options include:
- [Azure OpenAI](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-OpenAI.html)
- [Azure Machine Learning](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-MachineLearning.html)
- [Azure AI Search](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-CognitiveServices.html)
- [Azure AI Bot Service](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-BotService.html)

## Govern AI models

Model governance sets controls to keep AI models safe, reliable, and ethical. It uses Azure Policy to restrict which models can be deployed. Content safety filters block harmful or inappropriate outputs. Clear rules for inputs and outputs prevent misuse and protect against harmful content. These measures maintain compliance and support responsible AI principles. Continuous oversight through monitoring, audits, and policy reviews protects users and builds trust. To govern AI models, follow these steps:

1. **Create and maintain an AI agent inventory.** Microsoft Entra Agent ID gives you a centralized view and management of AI agents created in Foundry and Copilot Studio. Maintaining a complete inventory lets you enforce access controls and monitor policy compliance across your organization. Use [Microsoft Entra Agent ID](/entra/identity/monitoring-health/concept-sign-ins#microsoft-entra-agent-id) to track and manage your AI agents.

2. **Enforce model restrictions.** Azure Policy lets you control which AI models your organization uses. Apply [model-specific policies](/azure/ai-foundry/how-to/built-in-policy-model-deployment) in Foundry to meet your organization's standards and requirements.

3. **Implement AI risk detection processes.** Use Defender for Cloud to [identify AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [assess risks](/azure/defender-for-cloud/explore-ai-risk) before deployment. Run regular [red team assessments](/azure/ai-services/openai/concepts/red-teaming) on generative AI models. Document your findings and update governance policies to address new risks.

    | Step                          | Action                                                                                     | Description                                                                                       |
    |-------------------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
    | Enable Defender for Cloud AI workload discovery | Use Defender for Cloud to identify AI workloads and assess risks before deployment. | This step ensures visibility into AI workloads and helps detect potential vulnerabilities early. |
    | Schedule regular red team assessments | Conduct red team assessments of generative AI models periodically.                   | Regular assessments help identify weaknesses and improve the security posture of AI models.      |
    | Document and track identified risks | Maintain a record of risks discovered during assessments.                             | Tracking risks ensures accountability and supports continuous improvement in governance policies.|
    | Update policies based on findings | Revise governance policies to address newly identified risks.                          | Policy updates ensure that governance measures remain effective and aligned with current risks. |

4. **Apply content safety controls across all models.** [Azure AI Content Safety](/azure/ai-services/content-safety/overview) provides filters that prevent harmful content generation. Applying these controls consistently maintains safety standards and reduces legal risks from inappropriate AI outputs.

5. **Apply model grounding techniques.** Control AI model outputs using [system messages](/azure/ai-services/openai/concepts/system-message) and [retrieval augmented generation (RAG)](/azure/ai-studio/concepts/retrieval-augmented-generation). RAG combines AI model outputs with information retrieved from external sources to improve accuracy and relevance. For example, RAG can use a knowledge base to provide more accurate answers to user queries. Test grounding effectiveness with tools such as [PyRIT](https://github.com/Azure/PyRIT) to ensure models respond consistently and appropriately.

## Govern AI costs

Cost management controls help prevent unnecessary AI spending and maximize operational efficiency. Effective controls keep AI investments aligned with business goals and prevent budget overruns from resource misuse. Implement financial oversight and resource optimization to maintain cost-effective AI operations. To manage and govern AI costs, follow these steps:

1. **Select the appropriate billing model for your workload patterns.** Commitment tiers and provisioned throughput offer predictable costs for stable workloads. [Provisioned throughput units (PTUs)](/azure/ai-services/openai/concepts/provisioned-throughput) are a billing option in Azure OpenAI that reserve a set amount of compute resources for predictable costs, and typically cost less than pay-as-you-go pricing for consistent usage. To handle traffic spikes efficiently, combine PTU endpoints with consumption-based endpoints. Use PTUs for primary endpoints and consumption-based endpoints for overflow traffic. For more guidance, see [Introduce a gateway for multiple Azure OpenAI instances](/azure/architecture/ai-ml/guide/azure-openai-gateway-multi-backend#multiple-azure-openai-instances-in-a-single-region-and-single-subscription).

2. **Choose models that match requirements without overspending.** Model selection affects both costs and capability requirements. Less expensive models often deliver enough performance for many use cases without losing needed functionality. For Foundry, see [Foundry pricing](https://azure.microsoft.com/pricing/details/ai-foundry/?cdn=disable) and [model billing information](/azure/ai-studio/how-to/model-catalog-overview#billing). Use Azure Policy definitions to [allow specific models](/azure/ai-foundry/how-to/built-in-policy-model-deployment) that meet your cost requirements.

3. **Set quotas and limits to prevent cost overruns.** Provisioning quotas control resource allocation and help prevent unexpected charges. Allocate quotas for each model based on expected workloads. Monitor quotas regularly to ensure they match actual demand. Adjust quotas as needed to maintain optimal throughput without overspending.

4. **Select cost-effective deployment options.** Foundry models provide different [deployment options](/azure/ai-foundry/concepts/deployments-overview). Choose the most cost-effective and compliant option for your use case.

5. **Control client usage patterns.** Client behavior directly affects consumption costs in pay-per-use services. Limit client access using security protocols, such as:
- Network controls
- Keys
- Role-based access control (RBAC)

Enforce API constraints, including:
- Maximum tokens
- Maximum completions

Batch requests when possible to optimize efficiency. Keep prompts concise and provide only the necessary context to reduce token consumption.

6. **Automate resource shutdown for non-production workloads.** Automatic shutdown helps prevent unnecessary compute costs during idle periods. Define and enforce policies that require AI resources to use automatic shutdown features on virtual machines and compute instances in Foundry and Azure Machine Learning. Apply automatic shutdown to non-production environments. Also, apply it to production workloads that can go offline during specific periods.

7. **Implement gateway controls for cost management.** A [generative AI gateway](/azure/api-management/genai-gateway-capabilities) provides centralized cost controls for AI endpoints. The gateway tracks token usage, throttles consumption, applies circuit breakers, and routes traffic to different endpoints to optimize costs. For example, you can use a generative AI gateway to limit token usage during peak hours and route requests to less expensive endpoints.

For additional cost management guidance, see [Manage AI costs](../manage.md#manage-ai-costs) and [cost optimization](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-chat#cost-optimization) in the baseline Foundry chat reference architecture.

## Govern AI security

AI security governance protects AI workloads from threats to data, models, or infrastructure. Security controls help prevent unauthorized access and data breaches. Implement comprehensive security measures to maintain the integrity and reliability of your AI solutions. To govern AI security, follow these steps:

1. **Enable comprehensive threat detection across all AI resources.** Microsoft Defender for Cloud offers security monitoring and threat detection for AI workloads. This service identifies misconfigurations and security risks before they become vulnerabilities. Enable [Defender for Cloud](/azure/defender-for-cloud/get-started) on every subscription and activate [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to monitor AI-specific security risks.

2. **Implement least privilege access controls.** Role-based access control (RBAC) is a security method that limits user permissions to only what is necessary. This approach reduces the attack surface and helps prevent unauthorized access to sensitive AI resources. Assign the Reader role to all users by default. Elevate users to the Contributor role only when development work requires more permissions. Use [custom roles](/azure/role-based-access-control/custom-roles) if built-in roles provide excessive permissions. For example, create a custom role that allows access only to specific AI model endpoints.

3. **Use managed identities for service authentication.** Managed identities remove the need to store credentials in code or configuration files. This approach reduces credential theft risks and simplifies authentication management. Implement [managed identity](/entra/identity/managed-identities-azure-resources/overview) on all supported Azure services that access AI model endpoints. Grant least privilege access to application resources.

4. **Apply just-in-time access for administrative operations.** Privileged Identity Management (PIM) provides temporary elevated access to resources for administrative tasks. This approach minimizes exposure time for high-privilege accounts and reduces security risks. Use [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for administrative access to AI resources. Require approval workflows for sensitive operations, such as modifying access to production AI models.

5. **Secure network access to AI endpoints.** Network controls help prevent unauthorized access to AI services from untrusted networks. Private endpoints and virtual network integration protect AI resources from internet-based attacks. Configure [private endpoints](/azure/ai-services/cognitive-services-virtual-networks) for Foundry Tools. Use [virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) to restrict access to approved networks.

## Govern AI operations

AI operations governance sets controls for AI service management and maintenance to ensure stable performance. These controls provide long-term reliability and consistent business value from AI investments. Implement centralized oversight and continuity plans to prevent downtime and maintain operational effectiveness. To govern AI operations, follow these steps:

1. **Establish model lifecycle management policies.** Model versioning policies ensure compatibility and smooth transitions between updates. Version control helps prevent disruptions when models are upgraded or retired. It also maintains system stability across deployments. Create policies that define model versioning standards, compatibility testing requirements, and rollback procedures for all AI platforms in your organization. For example, use Azure Policy to restrict which models are available for deployment. Apply content safety filters to prevent harmful outputs. If you upgrade a model and encounter issues, use rollback procedures to restore the previous version.

2. **Implement business continuity and disaster recovery plans.** Disaster recovery plans protect AI operations against service interruptions and data loss. For example, configure backup and failover for Azure AI model endpoints to maintain service availability during outages. These plans help ensure business operations continue during outages and maintain service availability for critical AI workloads. Configure baseline disaster recovery for resources that host AI model endpoints, including:
- [Foundry](/azure/ai-studio/how-to/disaster-recovery)
- [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery)
- Foundry Tools

3. **Configure monitoring and alerting for AI workloads.** Baseline metrics provide early warning of performance degradation and operational issues before they affect users. Alert rules enable proactive responses to prevent service disruptions. Enable recommended alert rules for [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Foundry Agent Service deployments](/azure/ai-foundry/agents/how-to/metrics), and individual Foundry Tools.

## Govern AI regulatory compliance

AI regulatory compliance sets controls to meet industry standards and legal requirements for AI deployments. Compliance controls reduce liability risks, build stakeholder trust, and help avoid regulatory penalties. Implement systematic compliance processes to maintain regulatory alignment and demonstrate responsible AI practices. To govern AI regulatory compliance, follow these steps:

1. **Automate compliance assessment and management processes.** Microsoft Purview Compliance Manager provides centralized compliance tracking across cloud environments. Automated assessment reduces manual oversight and ensures consistent compliance monitoring. Use [Microsoft Purview Compliance Manager](/microsoft-365/compliance/compliance-manager-overview) to assess compliance status. Apply [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry requirements.

2. **Develop industry-specific compliance frameworks.** Regulatory requirements vary across industries and geographic locations. Custom compliance frameworks address specific obligations for your business context. Create compliance checklists that reflect regulatory demands for your industry. Use standards such as ISO/IEC 23053:2022 (Framework for Artificial Intelligence Systems Using Machine Learning) to audit policies applied to your AI workloads. For example, if you operate in healthcare, include HIPAA requirements in your compliance checklist.

## Govern AI data

AI data governance protects sensitive information and intellectual property, and helps ensure high-quality AI outputs. Data controls prevent unauthorized access and maintain regulatory compliance across AI workloads. Implement comprehensive data protection measures to safeguard privacy and maintain AI solution integrity. To govern AI data, follow these steps:

1. **Implement centralized data discovery and classification.** Microsoft Purview provides unified data governance across organizational systems. Centralized classification ensures consistent data handling standards and regulatory compliance. Use [Microsoft Purview](/purview/data-governance-overview) to scan, catalog, and classify data from systems across your organization. Implement [Microsoft Purview SDKs](/purview/developer/microsoft-purview-sdk-documentation-overview) to enforce compliance policies programmatically. For example, use the SDK to automatically tag sensitive data and restrict access based on classification.

2. **Maintain data security boundaries across AI systems.** Data security boundaries prevent sensitive information from reaching unauthorized AI endpoints. Indexing processes can remove existing security controls around data sources. Before using data in AI applications, ensure that data ingested into AI models meets classification standards and passes a security review.

3. **Prevent copyright infringement in AI outputs.** Content filtering systems help prevent intellectual property violations in AI-generated content. Copyright protection reduces legal risks and supports ethical AI practices. Use [Protected material detection in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/protected-material) to filter copyrighted material. Make sure that training or fine-tuning data uses legally obtained and properly licensed sources.

4. **Establish version control for AI training data.** Version control for grounding data ensures consistency and enables rollback capabilities. For example, use Git or Azure DevOps to track changes to training datasets and revert to previous versions if needed. Data versioning helps maintain deployment stability and supports change management across AI systems. Implement version control processes for grounding data in retrieval augmented generation (RAG) implementations to track changes and maintain consistency across deployments. For instance, if a new dataset causes unexpected model behavior, you can roll back to a previous version.

## Next step

> [!div class="nextstepaction"]
> [Go to Management PaaS AI](../platform/management.md)