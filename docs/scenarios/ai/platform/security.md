---
title: Secure Azure platform services (PaaS) for AI
description: Learn how to secure AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/30/2025
ms.topic: conceptual
---

# Secure Azure platform services (PaaS) for AI

This article provides security recommendations for organizations that run AI workloads on Azure. These recommendations focus on Azure AI platform-as-a-service (PaaS) solutions. Organizations must protect AI resources from potential threats to maintain data integrity and compliance. Security baselines and well-architected frameworks help organizations safeguard their AI infrastructure against vulnerabilities.

## Secure AI resources

AI resource security requires security baselines and best practices to protect the infrastructure that supports AI workloads on Azure. This protection reduces risks from external threats and ensures consistent security across the organization. You must apply standardized security controls to maintain robust protection. Here's how:

1. **Apply Azure security baselines to all AI resources.** Azure security baselines provide standardized security controls that address common vulnerabilities across AI platforms. These baselines ensure consistent protection and reduce configuration errors that could expose your infrastructure. Use the [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for each AI platform you deploy.

2. **Follow Azure Well-Architected Framework security guidance.** The Azure Well-Architected Framework provides service-specific security recommendations that complement baseline controls. These guidelines address unique security considerations for each AI service and help optimize your security posture. Review and implement the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular) for your AI platforms.

## Secure AI models

AI model security protects against threats like prompt injection attacks and model manipulation that can compromise system integrity. Model security ensures AI systems provide reliable outputs and maintain organizational trust. You must implement comprehensive model protection to prevent malicious exploitation and maintain service reliability. Here's how:

1. **Enable threat protection for all AI models.** Microsoft Defender for Cloud provides continuous monitoring and detection capabilities that identify emerging threats before they compromise your AI infrastructure. This protection ensures consistent security coverage across all AI workloads and reduces response time to potential attacks. Deploy [Microsoft Defender for Cloud AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to monitor for prompt injection attacks, model manipulation, and other AI-specific threats.

2. **Monitor outputs and apply prompt shielding.** Output monitoring detects malicious or unpredictable responses that could indicate successful attacks against your AI models. Prompt shielding prevents harmful user inputs from reaching your models and generating inappropriate responses. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan user inputs for attack patterns and regularly review model outputs for signs of compromise or manipulation.

3. **Verify model authenticity and integrity.** Model verification ensures only legitimate and secure AI models operate in your environment. This verification prevents unauthorized or tampered models from compromising your infrastructure and maintains trust in AI outputs. Establish verification processes that check model signatures, validate source authenticity, and confirm model integrity before deployment, especially for open-source models.

4. **Deploy an AI gateway for centralized security.** An AI gateway provides centralized traffic control and consistent security policy enforcement across all AI workloads. This approach simplifies security management and ensures uniform protection standards throughout your organization. Use [Azure API Management as an AI gateway](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) to enforce authentication policies, control traffic flow, and monitor API usage patterns. Configure the gateway's [managed identity with least privilege access](/azure/api-management/api-management-howto-use-managed-service-identity) and integrate with Microsoft Entra ID for [centralized authentication](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations).

## Secure AI access

AI access controls restrict resource usage to authorized users through authentication and authorization mechanisms. Access management prevents unauthorized interactions with AI models and protects sensitive data. You must implement comprehensive access controls to maintain security compliance and reduce breach risks. Here's how:

1. **Use Microsoft Entra ID for authentication instead of API keys.** Microsoft Entra ID provides centralized identity management with advanced security features that static API keys cannot offer. This approach eliminates credential management overhead and reduces security vulnerabilities from compromised keys. Replace API keys with Microsoft Entra ID authentication for [Azure AI Foundry](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), and [Azure AI Services](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id). If you must use keys, [rotate keys](/azure/ai-services/rotate-keys) regularly and audit access.

2. **Maintain an inventory of AI agents.** An accurate inventory of AI agent identities provides the foundation for access management and policy enforcement. This inventory prevents shadow AI deployments and ensures all agents follow security standards. Use [Microsoft Entra Agent ID](/entra/identity/monitoring-health/concept-sign-ins#microsoft-entra-agent-id) to view all AI agents created through Azure AI Foundry and Copilot Studio.

3. **Configure multifactor authentication and privileged access.** Multifactor authentication adds an essential security layer that protects against credential compromise. Privileged access controls limit administrative exposure and reduce attack surfaces. Enable [multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa) for all users and implement [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for administrative accounts to provide just-in-time access.

4. **Implement Conditional Access policies.** Conditional Access policies provide adaptive security that responds to risk indicators and context. These policies prevent unauthorized access while maintaining user productivity through intelligent access decisions. Configure [risk-based Conditional Access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies) that require additional verification for unusual sign-in activity, restrict access by geographic location, and ensure only compliant devices access AI resources.

5. **Apply least privilege access principles.** Least privilege access minimizes security exposure by granting only necessary permissions for specific roles. This approach reduces the impact of potential breaches and prevents unauthorized resource access. Use [Azure role-based access control](/azure/ai-studio/concepts/rbac-ai-studio) to assign appropriate permissions based on job responsibilities and review access regularly to prevent privilege escalation.

6. **Secure service-to-service communication.** Service-to-service authentication eliminates credential management complexity while providing secure communication channels. This approach reduces security risks from stored credentials and simplifies access management. Use [managed identity](/entra/identity/managed-identities-azure-resources/overview) to authenticate Azure services without managing credentials.

7. **Control external access to AI endpoints.** External access controls ensure only authorized clients interact with AI models and provide comprehensive monitoring capabilities. This protection prevents unauthorized model usage and maintains service availability. Require Microsoft Entra ID authentication for AI model endpoints and consider Azure API Management as an AI gateway to enforce access policies and monitor usage patterns.

8. **Use Azure AI Foundry Management Center for governance.** Centralized management provides consistent access controls and resource governance across your AI infrastructure. This centralization ensures compliance with organizational standards and simplifies administrative overhead. Use the management center to control access to AI resources, manage quotas, and enforce governance policies.

## Secure AI data

Securing AI data means implementing data boundaries and access controls to prevent compliance violations and privacy breaches. You must implement strict data governance to ensure each AI application processes only appropriate datasets. Here's how:

1. **Define data boundaries based on user access levels.** Data boundaries establish clear separation between different information types based on user permissions and application scope. This separation prevents AI applications from exposing sensitive data to unauthorized users. Create distinct datasets for employee-facing applications (internal data), customer-facing applications (customer data), and public-facing applications (public data only).

2. **Implement dataset isolation for different AI applications.** Dataset isolation ensures each AI workload operates within its designated data environment without cross-contamination. This isolation reduces data leakage risks between applications with different security requirements. Use separate Azure storage accounts, databases, or data lakes for different AI applications, and configure access controls to prevent unauthorized cross-dataset access.

3. **Configure role-based data access controls.** Role-based controls ensure users and applications access only data appropriate for their function and clearance level. This approach reduces privilege escalation risks and unauthorized data exposure. Implement Azure RBAC policies that align data access permissions with user roles and application requirements.

4. **Use Microsoft Purview for data governance.** Microsoft Purview provides centralized data discovery, classification, and compliance management across your AI ecosystem. This tool maintains visibility into data usage and ensures compliance with organizational policies. Deploy [Microsoft Purview for Azure AI services](/purview/ai-azure-services) and [AI agents](/purview/ai-agents) to monitor data lineage, classify sensitive information, and enforce data governance policies.

## Secure AI execution

AI execution security protects against malicious code execution when AI agents run user-requested operations or autonomous processes. Execution security prevents system compromise and maintains infrastructure stability. You must implement comprehensive execution controls to protect against code injection attacks and resource exhaustion. Here's how:

1. **Isolate AI execution environments.** Environment isolation ensures each code execution operates in a controlled space that cannot affect other system components. This isolation prevents malicious code from compromising host systems or accessing unauthorized resources. Use [Dynamic Sessions in Azure Container Apps](/azure/container-apps/sessions?tabs=azure-cli) to create fresh, isolated environments for each execution that are automatically destroyed after completion.

2. **Review and approve execution code.** Code review processes identify security vulnerabilities and malicious patterns before deployment to production environments. This review prevents compromised scripts from executing and maintains code quality standards. Conduct thorough security reviews of all scripts before deployment, use version control systems to track changes, and ensure only approved code versions execute in your AI agents.

3. **Configure resource limits and timeouts.** Resource limits prevent individual executions from consuming excessive system resources that could disrupt other services. These controls maintain system stability and prevent denial-of-service conditions. Set CPU, memory, and disk usage limits for execution environments and configure automatic timeouts to terminate long-running or stuck processes.

4. **Monitor execution activity.** Execution monitoring provides visibility into AI agent behavior and helps detect malicious or unusual activity patterns. This monitoring enables rapid response to security incidents and maintains operational awareness. Log all execution activities, monitor resource usage patterns, and configure alerts for suspicious behavior or resource consumption anomalies.

For more information, see [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview), [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant), [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions), and [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents).

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Security baselines | [Azure Machine Learning security baseline](/security/benchmark/azure/baselines/machine-learning-service-security-baseline) | Provides standardized security controls for Azure Machine Learning deployments |
| Security baselines | [Azure AI Foundry security baseline](/security/benchmark/azure/baselines/azure-ai-studio-security-baseline) | Offers security controls specific to Azure AI Foundry environments |
| Security baselines | [Azure OpenAI security baseline](/security/benchmark/azure/baselines/azure-openai-security-baseline) | Delivers security controls tailored for Azure OpenAI services |
| Architecture guidance | [Azure Machine Learning service guide](/azure/well-architected/service-guides/azure-machine-learning) | Provides comprehensive security recommendations for Azure Machine Learning |
| Architecture guidance | [Azure OpenAI service guide](/azure/well-architected/service-guides/azure-openai) | Offers security best practices specific to Azure OpenAI implementations |

## Next step

> [!div class="nextstepaction"]
> [Management](./management.md)