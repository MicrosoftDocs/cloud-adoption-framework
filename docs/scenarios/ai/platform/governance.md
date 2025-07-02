---
title: Govern Azure platform services (PaaS) for AI
description: Learn how to govern AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/29/2025
ms.topic: conceptual
---

# Govern Azure platform services (PaaS) for AI

This article provides governance recommendations for organizations that use Azure AI platform-as-a-service (PaaS) solutions. These recommendations help you establish responsible AI practices that reduce security, cost, and compliance risks while ensuring your AI investments align with business objectives.

## Govern AI platforms

AI platform governance applies policy controls across Azure AI services to ensure consistent operations. Platform-level governance enforces security, compliance, and operational standards across your AI ecosystem. You must implement comprehensive policies to maintain oversight and strengthen AI management practices. Here's how:

1. **Apply built-in governance policies for each AI platform.** Azure Policy provides predefined policy definitions that address common governance requirements for AI services. These policies help enforce security configurations, cost controls, and compliance requirements without custom development. Use Azure Policy to implement built-in policy definitions for [Azure AI Foundry](/azure/ai-foundry/how-to/azure-policy), [Azure AI services](/azure/ai-services/policy-reference), and [Azure AI Search](/azure/search/policy-reference).

2. **Enable Azure landing zone AI policies for comprehensive coverage.** Azure landing zones include curated policy sets that address workload-specific governance requirements. These policies provide tested configurations that align with Microsoft recommendations for AI workloads. Select the appropriate policy initiative under the *Workload Specific Compliance* category during Azure landing zone deployment, including [Azure OpenAI](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-OpenAI.html), [Azure Machine Learning](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-MachineLearning.html), [Azure AI Search](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-CognitiveServices.html), and [Azure Bot services](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-BotService.html).

## Govern AI models

Model governance controls ensure AI models produce safe, reliable, and ethical outputs. Clear policies for model inputs and outputs protect against harmful content generation and misuse while maintaining compliance standards. You must implement systematic model oversight to protect users and support responsible AI deployment practices. Here's how:

1. **Create and maintain an AI agent inventory.** Microsoft Entra Agent ID provides a centralized view of all AI agents created through Azure AI Foundry and Copilot Studio. A complete inventory enables access control enforcement and policy compliance monitoring across your organization. Use [Microsoft Entra Agent ID](/entra/identity/monitoring-health/concept-sign-ins#microsoft-entra-agent-id) to track and manage your AI agents.

2. **Enforce model restrictions.** Azure Policy allows you to control which AI models your organization can use. Apply [model-specific policies](/azure/ai-foundry/how-to/built-in-policy-model-deployment) in Azure AI Foundry to ensure compliance with organizational standards and requirements.

3. **Implement AI risk detection processes.** Use Defender for Cloud to [identify AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [assess risks](/azure/defender-for-cloud/explore-ai-risk) before deployment. Conduct regular [red team assessments](/azure/ai-services/openai/concepts/red-teaming) of generative AI models. Document all findings and update governance policies to address new risks.

    | Step                          | Action                                                                                     | Description                                                                                       |
    |-------------------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
    | Enable Defender for Cloud AI workload discovery | Use Defender for Cloud to identify AI workloads and assess risks before deployment. | This step ensures visibility into AI workloads and helps detect potential vulnerabilities early. |
    | Schedule regular red team assessments | Conduct red team assessments of generative AI models periodically.                   | Regular assessments help identify weaknesses and improve the security posture of AI models.      |
    | Document and track identified risks | Maintain a record of risks discovered during assessments.                             | Tracking risks ensures accountability and supports continuous improvement in governance policies.|
    | Update policies based on findings | Revise governance policies to address newly identified risks.                          | Policy updates ensure that governance measures remain effective and aligned with current risks. |

4. **Apply content safety controls across all models.** [Azure AI Content Safety](/azure/ai-services/content-safety/overview) provides filters that prevent harmful content generation. Consistent application maintains safety standards and reduces legal liability from inappropriate AI outputs.

5. **Apply model grounding techniques.** Control AI model outputs through [system messages](/azure/ai-services/openai/concepts/system-message) and [retrieval augmented generation](/azure/ai-studio/concepts/retrieval-augmented-generation) (RAG). Test grounding effectiveness with tools like [PyRIT](https://github.com/Azure/PyRIT) to ensure consistent and appropriate responses.

## Govern AI costs

Cost management controls prevent unnecessary AI spending while maximizing operational efficiency. Effective controls ensure AI investments align with business objectives and prevent budget overruns from resource misuse. You must implement financial oversight and resource optimization practices to maintain cost-effective AI operations. Here's how:

1. **Select the appropriate billing model for your workload patterns.** Commitment tiers and provisioned throughput provide predictable costs for stable workloads. Azure OpenAI models offer [provisioned throughput units](/azure/ai-services/openai/concepts/provisioned-throughput) (PTUs) that cost less than pay-as-you-go pricing for consistent usage patterns. Combine PTU endpoints with consumption-based endpoints to handle traffic spikes cost-effectively. Use PTUs for primary endpoints and consumption-based endpoints for overflow traffic. For more guidance, see [Introduce a gateway for multiple Azure OpenAI instances](/azure/architecture/ai-ml/guide/azure-openai-gateway-multi-backend#multiple-azure-openai-instances-in-a-single-region-and-single-subscription).

2. **Choose models that match requirements without overspending.** Model selection directly impacts costs while affecting capability requirements. Less expensive models often provide sufficient performance for many use cases without sacrificing necessary functionality. For Azure AI Foundry, see [Azure AI Foundry pricing](https://azure.microsoft.com/pricing/details/ai-foundry/?cdn=disable) and [model billing information](/azure/ai-studio/how-to/model-catalog-overview#billing). Use Azure Policy definitions to [allow specific models](/azure/ai-foundry/how-to/built-in-policy-model-deployment) that meet cost requirements.

3. **Set quotas and limits to prevent cost overruns.** Provisioning quotas control resource allocation and prevent unexpected charges. Allocate quotas for each model based on expected workloads. Monitor dynamic quotas continuously to ensure they match actual demand and adjust them to maintain optimal throughput without overspending.

4. **Select cost-effective deployment options.** Azure AI Foundry models provide different [deployment options](/azure/ai-foundry/concepts/deployments-overview). Choose the most cost-effective and compliant option for your use case.

5. **Control client usage patterns.** Client behavior directly affects consumption costs in pay-per-use services. Limit client access through security protocols like network controls, keys, and role-based access control (RBAC). Enforce API constraints like max tokens and max completions. Batch requests when possible to optimize efficiency and keep prompts concise while providing necessary context to reduce token consumption.

6. **Automate resource shutdown for non-production workloads.** Automatic shutdown prevents unnecessary compute costs during idle periods. Define and enforce policies requiring AI resources to use automatic shutdown features on virtual machines and compute instances in Azure AI Foundry and Azure Machine Learning. Apply automatic shutdown to non-production environments and production workloads that can go offline during specific periods.

7. **Implement gateway controls for cost management.** A [generative AI gateway](/azure/api-management/genai-gateway-capabilities) provides centralized cost controls across AI endpoints. The gateway tracks token usage, throttles consumption, applies circuit breakers, and routes traffic to different endpoints to optimize costs.

For additional cost management guidance, see [Manage AI costs](../manage.md#manage-ai-costs) and [cost optimization](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat#cost-optimization) in the Azure OpenAI baseline architecture.

## Govern AI security

AI security governance protects AI workloads from threats that compromise data, models, or infrastructure. Security controls safeguard systems against unauthorized access and data breaches. You must implement comprehensive security measures to maintain AI solution integrity and reliability. Here's how:

1. **Enable comprehensive threat detection across all AI resources.** Microsoft Defender for Cloud provides security monitoring and threat detection for AI workloads. This service identifies misconfigurations and security risks before they become vulnerabilities. Enable [Defender for Cloud](/azure/defender-for-cloud/get-started) on every subscription and activate [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to monitor AI-specific security risks.

2. **Implement least privilege access controls.** Role-based access control (RBAC) limits user permissions to necessary functions only. This approach reduces attack surface and prevents unauthorized access to sensitive AI resources. Start with the Reader role for all users and elevate to Contributor role only when development work requires additional permissions. Use [custom roles](/azure/role-based-access-control/custom-roles) when built-in roles provide excessive permissions.

3. **Use managed identities for service authentication.** Managed identities eliminate the need to store credentials in code or configuration files. This approach reduces credential theft risks and simplifies authentication management. Implement [managed identity](/entra/identity/managed-identities-azure-resources/overview) on all supported Azure services that access AI model endpoints and grant least privilege access to application resources.

4. **Apply just-in-time access for administrative operations.** Privileged Identity Management (PIM) provides temporary elevated access when needed. This approach minimizes exposure time for high-privilege accounts and reduces security risks. Use [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for administrative access to AI resources and require approval workflows for sensitive operations.

5. **Secure network access to AI endpoints.** Network controls prevent unauthorized access to AI services from untrusted networks. Private endpoints and virtual network integration protect AI resources from internet-based attacks. Configure [private endpoints](/azure/ai-services/cognitive-services-virtual-networks) for Azure AI services and use [virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) to restrict access to approved networks only.

## Govern AI operations

AI operations governance establishes controls over AI service management and maintenance to ensure stable performance. Operations governance provides long-term reliability and consistent business value from AI investments. You must implement centralized oversight and continuity plans to prevent downtime and maintain operational effectiveness. Here's how:

1. **Establish model lifecycle management policies.** Model versioning policies ensure compatibility and smooth transitions between updates. Version control prevents disruptions when models are upgraded or retired and maintains system stability across deployments. Create policies that define model versioning standards, compatibility testing requirements, and rollback procedures for all AI platforms in your organization.

2. **Implement business continuity and disaster recovery plans.** Disaster recovery plans protect AI operations against service interruptions and data loss while ensuring business operations continue during outages. These plans maintain service availability for critical AI workloads. Configure baseline disaster recovery for resources that host AI model endpoints, including [Azure AI Foundry](/azure/ai-studio/how-to/disaster-recovery), [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery), and Azure AI services.

3. **Configure monitoring and alerting for AI workloads.** Baseline metrics provide early warning of performance degradation and operational issues before they affect users. Alert rules enable proactive responses to prevent service disruptions. Enable recommended alert rules for [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Azure AI Foundry Agent Service deployments](/azure/ai-services/agents/how-to/metrics), and individual Azure AI services.

## Govern AI regulatory compliance

AI regulatory compliance establishes controls to meet industry standards and legal requirements for AI deployments. Compliance controls reduce liability risks and build stakeholder trust while avoiding regulatory penalties. You must implement systematic compliance processes to maintain regulatory alignment and demonstrate responsible AI practices. Here's how:

1. **Automate compliance assessment and management processes.** Microsoft Purview Compliance Manager provides centralized compliance tracking across cloud environments. Automated assessment reduces manual oversight burden and ensures consistent compliance monitoring. Use [Microsoft Purview Compliance Manager](/microsoft-365/compliance/compliance-manager-overview) to assess compliance status and apply [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry requirements.

1. **Develop industry-specific compliance frameworks.** Regulatory requirements vary across industries and geographic locations. Custom compliance frameworks address specific obligations for your business context. Create compliance checklists that reflect regulatory demands relevant to your industry and use standards like ISO/IEC 23053:2022 (Framework for Artificial Intelligence Systems Using Machine Learning) to audit policies applied to your AI workloads.

## Govern AI data

AI data governance protects sensitive information and intellectual property while ensuring high-quality AI outputs. Data controls prevent unauthorized access and maintain regulatory compliance across AI workloads. You must implement comprehensive data protection measures to safeguard privacy and maintain AI solution integrity. Here's how:

1. **Implement centralized data discovery and classification.** Microsoft Purview provides unified data governance across organizational systems. Centralized classification ensures consistent data handling standards and regulatory compliance. Use [Microsoft Purview](/purview/data-governance-overview) to scan, catalog, and classify data from systems across your organization and implement [Microsoft Purview SDKs](/purview/developer/microsoft-purview-sdk-documentation-overview) to enforce compliance policies programmatically.

2. **Maintain data security boundaries across AI systems.** Data security boundaries prevent sensitive information from reaching unauthorized AI endpoints. Indexing processes can remove existing security controls around data sources. Ensure that data ingested into AI models meets classification standards and undergoes security review before use in AI applications.

3. **Prevent copyright infringement in AI outputs.** Content filtering systems protect against intellectual property violations in AI-generated content. Copyright protection reduces legal risks and maintains ethical AI practices. Use [Protected material detection in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/protected-material) to filter copyrighted material and ensure that training or fine-tuning data uses legally obtained and properly licensed sources.

4. **Establish version control for AI training data.** Version control for grounding data ensures consistency and enables rollback capabilities. Data versioning maintains deployment stability and supports change management across AI systems. Implement version control processes for grounding data in retrieval augmented generation (RAG) implementations to track changes and maintain consistency across deployments.

## Next step

> [!div class="nextstepaction"]
> [Management PaaS AI](../platform/management.md)
