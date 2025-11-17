---
title: Secure Azure platform services (PaaS) for AI
description: Learn how to secure AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/30/2025
ms.topic: concept-article
---

# Secure Azure platform services (PaaS) for AI

This article provides security recommendations for organizations that run AI workloads on Azure. The guidance focuses on Azure AI platform-as-a-service (PaaS) solutions. You must protect AI resources from threats to maintain data integrity and compliance. Use security baselines and well-architected frameworks to safeguard your AI infrastructure against vulnerabilities.

## Secure AI resources

To secure AI resources, apply security baselines and best practices to protect the infrastructure that supports AI workloads on Azure. These measures reduce risks from external threats and ensure consistent security across your organization. Apply standardized security controls to maintain robust protection. Here's how:

1. **Apply Azure security baselines to all AI resources.** Azure security baselines provide standardized security controls that address common vulnerabilities across AI platforms. These baselines ensure consistent protection and reduce configuration errors that could expose your infrastructure. Use the [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for each AI platform you deploy.

2. **Follow Azure Well-Architected Framework security guidance.** The [Azure Well-Architected Framework](/azure/well-architected/) provides service-specific security recommendations that complement baseline controls. These guidelines address unique security considerations for each AI service and help optimize your security posture. Review and implement the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular) for your AI platforms.

## Secure AI models

AI model security protects against threats such as prompt injection attacks and model manipulation, which can compromise system integrity. Securing models ensures reliable outputs and maintains organizational trust. Implement comprehensive model protection to prevent malicious exploitation and maintain service reliability. Here's how:

1. **Enable threat protection for all AI models.** Microsoft Defender for Cloud continuously monitors and detects emerging threats before they compromise your AI infrastructure. This protection ensures consistent security coverage across all AI workloads and reduces response time to attacks. Deploy [Microsoft Defender for Cloud AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to monitor for prompt injection attacks, model manipulation, and other AI-specific threats.

2. **Monitor outputs and apply prompt shielding.** Monitor outputs to detect malicious or unpredictable responses that may indicate successful attacks against your AI models. Use prompt shielding to block harmful user inputs and prevent inappropriate responses. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan user inputs for attack patterns and regularly review model outputs for signs of compromise or manipulation.

3. **Verify model authenticity and integrity.** Verify models to ensure only legitimate and secure AI models operate in your environment. This process prevents unauthorized or tampered models from compromising your infrastructure and maintains trust in AI outputs. Establish verification steps to check model signatures, validate source authenticity, and confirm model integrity before deployment. Pay special attention to open-source models.

4. **Deploy an AI gateway for centralized security.** Use an AI gateway to centralize traffic control and enforce consistent security policies across all AI workloads. This method simplifies security management and ensures uniform protection standards. Use [Azure API Management as an AI gateway](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) to enforce authentication policies, control traffic flow, and monitor API usage. Configure the gateway's [managed identity with least privilege access](/azure/api-management/api-management-howto-use-managed-service-identity) and integrate with Microsoft Entra ID for [centralized authentication](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations).

## Secure AI access

AI access controls restrict resource usage to authorized users through authentication and authorization. Access management prevents unauthorized interactions with AI models and protects sensitive data. Implement comprehensive access controls to maintain security compliance and reduce breach risks. Here's how:

1. **Use Microsoft Entra ID for authentication instead of API keys.** Microsoft Entra ID provides centralized identity management and advanced security features that static API keys lack. Using Entra ID eliminates credential management overhead and reduces vulnerabilities from compromised keys. Replace API keys with Microsoft Entra ID authentication for [Azure AI Foundry](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), and [Azure AI Services](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id). If keys are required, regularly [rotate keys](/azure/ai-services/rotate-keys) and audit access.

2. **Maintain an inventory of AI agents.** Maintain an accurate inventory of AI agent identities to support access management and policy enforcement. This inventory prevents shadow AI deployments and ensures all agents follow security standards. Use [Microsoft Entra Agent ID](/entra/identity/monitoring-health/concept-sign-ins#microsoft-entra-agent-id) to view all AI agents created through Azure AI Foundry and Copilot Studio.

3. **Configure multifactor authentication and privileged access.** Enable multifactor authentication to add a security layer that protects against credential compromise. Use privileged access controls to limit administrative exposure and reduce attack surfaces. Enable [multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa) for all users and implement [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for administrative accounts to provide just-in-time access.

4. **Implement Conditional Access policies.** Conditional Access policies provide adaptive security that responds to risk indicators and context. These policies prevent unauthorized access and maintain user productivity through intelligent access decisions. Configure [risk-based Conditional Access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies) to require additional verification for unusual sign-in activity, restrict access by geographic location, and ensure only compliant devices access AI resources.

5. **Apply least privilege access principles.** Apply least privilege access to minimize security exposure by granting only necessary permissions for each role. This approach reduces the impact of breaches and prevents unauthorized resource access. Use [Azure role-based access control](/azure/ai-studio/concepts/rbac-ai-studio) to assign permissions based on job responsibilities and review access regularly to prevent privilege escalation.

6. **Secure service-to-service communication.** Use service-to-service authentication to eliminate credential management complexity and provide secure communication channels. This method reduces security risks from stored credentials and simplifies access management. Use [managed identity](/entra/identity/managed-identities-azure-resources/overview) to authenticate Azure services without managing credentials.

7. **Control external access to AI endpoints.** Control external access to ensure only authorized clients interact with AI models. Comprehensive monitoring prevents unauthorized model usage and maintains service availability. Require Microsoft Entra ID authentication for AI model endpoints. Consider Azure API Management as an AI gateway to enforce access policies and monitor usage patterns.

8. **Use Azure AI Foundry Management Center for governance.** Use centralized management to provide consistent access controls and resource governance across your AI infrastructure. Centralization ensures compliance with organizational standards and simplifies administration. Use the management center to control access to AI resources, manage quotas, and enforce governance policies.

## Secure AI data

To secure AI data, implement data boundaries and access controls to prevent compliance violations and privacy breaches. Apply strict data governance to ensure each AI application processes only appropriate datasets. Here's how:

1. **Define data boundaries based on user access levels.** Define data boundaries to separate information types based on user permissions and application scope. This separation prevents AI applications from exposing sensitive data to unauthorized users. Create distinct datasets for employee-facing applications (internal data), customer-facing applications (customer data), and public-facing applications (public data only).

2. **Implement dataset isolation for different AI applications.** Isolate datasets so each AI workload operates within its designated data environment without cross-contamination. This isolation reduces data leakage risks between applications with different security requirements. Use separate Azure storage accounts, databases, or data lakes for different AI applications. Configure access controls to prevent unauthorized cross-dataset access.

3. **Configure role-based data access controls.** Configure role-based controls to ensure users and applications access only data appropriate for their function and clearance level. This approach reduces privilege escalation risks and unauthorized data exposure. Implement Azure RBAC policies that align data access permissions with user roles and application requirements.

4. **Use Microsoft Purview for data governance.** Use Microsoft Purview for centralized data discovery, classification, and compliance management across your AI ecosystem. Purview maintains visibility into data usage and ensures compliance with organizational policies. Deploy [Microsoft Purview for Azure AI services](/purview/ai-azure-services) and [AI agents](/purview/ai-agents) to monitor data lineage, classify sensitive information, and enforce data governance policies.

## Secure AI execution

AI execution security protects against malicious code execution when AI agents run user-requested operations or autonomous processes. These controls prevent system compromise and maintain infrastructure stability. Implement comprehensive execution controls to protect against code injection attacks and resource exhaustion. Here's how:

1. **Isolate AI execution environments.** Isolate execution environments so each code execution operates in a controlled space and cannot affect other system components. This isolation prevents malicious code from compromising host systems or accessing unauthorized resources. Use [Dynamic Sessions in Azure Container Apps](/azure/container-apps/sessions?tabs=azure-cli) to create fresh, isolated environments for each execution. Destroy these environments automatically after completion.

2. **Review and approve execution code.** Review and approve execution code to identify security vulnerabilities and malicious patterns before deployment. This process prevents compromised scripts from executing and maintains code quality standards. Conduct thorough security reviews of all scripts before deployment. Use version control systems to track changes and ensure only approved code versions execute in your AI agents.

3. **Configure resource limits and timeouts.** Set resource limits to prevent individual executions from consuming excessive system resources and disrupting other services. These controls maintain system stability and prevent denial-of-service conditions. Set CPU, memory, and disk usage limits for execution environments. Configure automatic timeouts to terminate long-running or stuck processes.

4. **Monitor execution activity.** Monitor execution activity to gain visibility into AI agent behavior and detect malicious or unusual patterns. This monitoring enables rapid response to security incidents and maintains operational awareness. Log all execution activities, monitor resource usage patterns, and configure alerts for suspicious behavior or resource consumption anomalies.

For more information, see the following resources:
- [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview)
- [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant)
- [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions)
- [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents)

## Azure security and architecture resources

| Category | Tool | Description |
|----------|------|-------------|
| Security baselines | [Azure Machine Learning security baseline](/security/benchmark/azure/baselines/machine-learning-service-security-baseline) | Standardized security controls for Azure Machine Learning deployments |
| Security baselines | [Azure AI Foundry security baseline](/security/benchmark/azure/baselines/azure-ai-studio-security-baseline) | Security controls for Azure AI Foundry environments |
| Security baselines | [Azure OpenAI security baseline](/security/benchmark/azure/baselines/azure-openai-security-baseline) | Security controls for Azure OpenAI services |
| Architecture guidance | [Azure Machine Learning service guide](/azure/well-architected/service-guides/azure-machine-learning) | Security recommendations for Azure Machine Learning |
| Architecture guidance | [Azure OpenAI service guide](/azure/well-architected/service-guides/azure-openai) | Security best practices for Azure OpenAI implementations |

## Next steps

> [!div class="nextstepaction"]
> [Go to Management guidance](./management.md)