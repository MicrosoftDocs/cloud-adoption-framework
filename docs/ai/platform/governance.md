---
title: Govern Azure platform services (PaaS) for AI
description: Learn how to govern AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 10/09/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Govern Azure platform services (PaaS) for AI

This article describes governance practices for organizations that use Azure AI platform-as-a-service (PaaS) solutions. These practices help you build responsible AI systems and reduce security, cost, and compliance risks. Effective governance ensures that your AI investments align with your business goals.

## Govern AI platforms

Use Azure Policy to establish consistent governance requirements across the AI services in your environment. Apply built-in policy definitions to enforce organizational requirements for:

- [Microsoft Foundry models](/azure/foundry/how-to/model-deployment-policy)
- [Foundry Tools](/azure/ai-services/policy-reference)
- [Azure AI Search](/azure/search/policy-reference)
- [Azure Machine Learning](/azure/machine-learning/policy-reference)

## Govern agents

**Create and maintain an AI agent inventory.** Microsoft Entra Agent ID gives you a centralized view of AI agents created in Foundry and Copilot Studio. Use [Microsoft Entra Agent ID](/entra/agent-id/what-is-microsoft-entra-agent-id) to track and manage AI agents.

## Govern AI models

Model governance establishes controls for which models your organization can deploy and how those models operate. Use deployment policies, guardrails, security monitoring, and lifecycle controls to maintain consistent requirements across model deployments. To govern AI models, follow these steps:

1. **Restrict model deployments.** Use [built-in policies for Microsoft Foundry model deployments](/azure/foundry/how-to/model-deployment-policy) to restrict deployments to approved models or publishers and define model eligibility requirements.

2. **Apply guardrails to model deployments.** Microsoft Foundry [guardrails](/azure/foundry/guardrails/guardrails-overview) provide safety and security controls for model inputs and outputs and, for supported agents, agent interactions. Configure guardrails based on your organization's responsible AI and security requirements.

3. **Enforce guardrail requirements.** Use [guardrail policies](/azure/foundry/control-plane/how-to-manage-compliance-security) to establish minimum guardrail controls across model deployments. Review compliance to identify deployments that don't meet organizational requirements.

4. **Monitor AI security risks.** Use [Microsoft Defender for Cloud integration with Foundry](/azure/foundry/control-plane/how-to-manage-compliance-security) to review security posture recommendations and threat protection for supported AI workloads.

## Govern AI costs

Cost management controls help prevent unnecessary AI spending and maximize operational efficiency. Effective controls keep AI investments aligned with business goals and prevent budget overruns from resource misuse. Implement financial oversight and resource optimization to maintain cost-effective AI operations. To manage and govern AI costs, follow these steps:

1. **Select billing model.** Commitment tiers and provisioned throughput offer predictable costs for stable workloads. Provisioned throughput units (PTUs) are the unit of measure for provisioned throughput. A PTU represents a fixed amount of model processing capacity. When you create a provisioned deployment, you specify how many PTUs to allocate. Foundry reserves that amount of compute and holds it for your deployment. See [What is provisioned throughput for Foundry Models?](/azure/foundry/openai/concepts/provisioned-throughput)

2. **Match models to requirements.** Model selection affects both costs and capability requirements. Less expensive models often deliver enough performance for many use cases without losing needed functionality. For Foundry, see [Foundry pricing](https://azure.microsoft.com/pricing/details/microsoft-foundry/?cdn=disable) and [plan and manage costs](/azure/foundry/concepts/manage-costs). Use Azure Policy definitions to [allow specific models](/azure/foundry/how-to/model-deployment-policy) that meet your cost requirements.

3. **Manage model quotas and limits.** Review [Quotas and limit](/azure/foundry/foundry-models/quotas-limits) and allocate capacity based on workload demand. Monitor quota usage and request increases when existing capacity doesn't meet workload requirements.

4. **Deployment options.** Foundry models provide different [deployment options](/azure/foundry/foundry-models/concepts/deployment-types). Choose the most cost-effective and compliant option for your use case.

5. **Control client usage patterns.** Client behavior directly affects consumption costs in pay-per-use services. Limit client access by using security protocols, such as network controls, keys, and role-based access control (RBAC). Enforce API constraints, including maximum tokens and maximum completions. Batch requests when possible to optimize efficiency. Keep prompts concise and provide only the necessary context to reduce token consumption.

6. **Implement gateway controls.** A [generative AI gateway](/azure/api-management/genai-gateway-capabilities) provides centralized cost controls for AI endpoints. The gateway tracks token usage, throttles consumption, applies circuit breakers, and routes traffic to different endpoints to optimize costs. For example, you can use a generative AI gateway to limit token usage during peak hours and route requests to less expensive endpoints.

For additional cost management guidance, see [Manage AI costs](../manage.md#manage-ai-costs) and [cost optimization](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-chat#cost-optimization) in the baseline Foundry chat reference architecture.

## Govern AI security

AI security governance protects AI workloads from threats to data, models, or infrastructure. Security controls help prevent unauthorized access and data breaches. Implement comprehensive security measures to maintain the integrity and reliability of your AI solutions. To govern AI security, follow these steps:

1. **Enable comprehensive threat detection across all AI resources.** Microsoft Defender for Cloud offers security monitoring and threat detection for AI workloads. This service identifies misconfigurations and security risks before they become vulnerabilities. Enable [Defender for Cloud](/azure/defender-for-cloud/get-started) on every subscription and activate [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to monitor AI-specific security risks.

2. **Implement least privilege access controls.** Use role-based access control (RBAC) to grant users and workload identities only the permissions they require. Use [RBAC for Foundry](/azure/foundry/concepts/rbac-foundry) resources and scope role assignments to the required resources. Use custom Azure roles when built-in roles grant broader permissions than required.

3. **Use managed identities for service authentication.** Managed identities remove the need to store credentials in code or configuration files. This approach reduces credential theft risks and simplifies authentication management. Implement [managed identity](/entra/identity/managed-identities-azure-resources/overview) on all supported Azure services that access AI model endpoints. Grant least privilege access to application resources.

4. **Apply just-in-time access for administrative operations.** Privileged Identity Management (PIM) provides temporary elevated access to resources for administrative tasks. This approach minimizes exposure time for high-privilege accounts and reduces security risks. Use [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for administrative access to AI resources. Require approval workflows for sensitive operations, such as modifying access to production AI models.

5. **Secure network access to AI resources.** Use network isolation to control inbound and outbound connectivity for Microsoft Foundry. Configure [network isolation and private endpoints](/azure/foundry/how-to/configure-private-link) where workloads require private connectivity. Apply equivalent network controls to other AI services based on their networking requirements.

## Govern AI operations

AI operations governance sets controls for AI service management and maintenance to ensure stable performance. These controls provide long-term reliability and consistent business value from AI investments. Implement centralized oversight and continuity plans to prevent downtime and maintain operational effectiveness. To govern AI operations, follow these steps:

1. **Establish model lifecycle management policies.** Define processes for evaluating model updates, testing replacements, and migrating deployments before models retire. Track the [Microsoft Foundry Models lifecycle and support policy](/azure/foundry/openai/concepts/model-retirements) and model retirement schedules. Establish rollback procedures for model changes that introduce unexpected behavior.

2. **Implement business continuity and disaster recovery plans.** Disaster recovery plans protect AI operations against service interruptions and data loss. For example, configure backup and failover for Azure AI model endpoints to maintain service availability during outages. These plans help ensure business operations continue during outages and maintain service availability for critical AI workloads. Configure baseline disaster recovery for resources that host AI model endpoints, including [Foundry](/azure/foundry/how-to/high-availability-resiliency).

3. **Configure monitoring and alerting for AI workloads.** Baseline metrics provide early warning of performance degradation and operational issues before they affect users. Alert rules enable proactive responses to prevent service disruptions. Enable recommended alert rules for [Azure AI Search](/azure/search/monitor-azure-cognitive-search#azure-ai-search-alert-rules), [Foundry service health](/azure/foundry/how-to/stay-informed-service-health), and individual Foundry Tools.

## Govern AI regulatory compliance

AI regulatory compliance sets controls to meet industry standards and legal requirements for AI deployments. Compliance controls reduce liability risks, build stakeholder trust, and help avoid regulatory penalties. Implement systematic compliance processes to maintain regulatory alignment and demonstrate responsible AI practices. To govern AI regulatory compliance, follow these steps:

1. **Automate compliance assessment and management processes.** Microsoft Purview Compliance Manager provides centralized compliance tracking across cloud environments. Automated assessment reduces manual oversight and ensures consistent compliance monitoring. Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to assess compliance status. Apply [regulatory compliance initiatives](/azure/governance/policy/samples/#regulatory-compliance) in Azure Policy for your industry requirements.

2. **Develop industry-specific compliance frameworks.** Regulatory requirements vary across industries and geographic locations. Custom compliance frameworks address specific obligations for your business context. Create compliance checklists that reflect regulatory demands for your industry. Use standards such as ISO/IEC 42001:2023 (Artificial Intelligence Management Systems) to audit policies applied to your AI workloads. For example, if you operate in healthcare, include HIPAA requirements in your compliance checklist.

## Govern AI data

AI data governance establishes controls for the data that AI workloads access and use. Govern data according to its sensitivity, regulatory requirements, and intended use. Apply consistent discovery, classification, access, protection, and lifecycle controls across data used for AI. For guidance on establishing these controls with Microsoft Purview, see [Data governance and security baselines with Microsoft Purview](/azure/cloud-adoption-framework/data/governance-security-baselines-purview-data-estate-unify-data-platform?tabs=purview).

## Next step

> [!div class="nextstepaction"]
> [Go to Management PaaS AI](../../scenarios/ai/platform/management.md)