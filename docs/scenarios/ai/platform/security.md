---
title: Security recommendations for AI workloads on Azure
description: Learn how to secure AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/30/2025
ms.topic: conceptual
---

# Security recommendations for AI workloads on Azure

This article offers security recommendations for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Foundry, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and nongenerative AI workloads.

As AI becomes more integrated into business operations, protecting these resources from potential threats is crucial to maintain data integrity and compliance. Applying standardized security baselines and following well-architected frameworks helps organizations safeguard their AI infrastructure against vulnerabilities.

## Secure AI resources

Securing AI resources means applying security baselines and best practices to protect the infrastructure used for AI workloads on Azure. This protection minimizes risks from external threats and ensures a consistent security posture across the organization.

*Secure Azure AI platforms.* Standardize the application of [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular) within the Azure Well-Architected Framework.

| Azure AI platform security baseline | Azure Well-Architected Framework service guide |
| --- | --- |
[Azure Machine Learning](/security/benchmark/azure/baselines/machine-learning-service-security-baseline) | [Azure Machine Learning](/azure/well-architected/service-guides/azure-machine-learning)
[Azure AI Foundry](/security/benchmark/azure/baselines/azure-ai-studio-security-baseline) | |
[Azure OpenAI](/security/benchmark/azure/baselines/azure-openai-security-baseline) | [Azure OpenAI](/azure/well-architected/service-guides/azure-openai)|

## Secure the AI models

Securing AI models refers to implementing threat protection, monitoring for prompt injection risks, verifying model integrity, and centralizing governance. These practices ensure that AI models remain safe from malicious manipulation, maintain their reliability, and provide accurate results.

- *Implement threat protection for all AI models.* Use Microsoft Defender for Cloud's [AI threat protection](/azure/defender-for-cloud/ai-threat-protection) to protect AI models from threats like prompt injection attacks and model manipulation. This tool provides continuous monitoring of AI workloads, helping to detect and prevent emerging threats. Implementing this protection across all workloads ensures a consistent security posture throughout the organization.

- *Monitor outputs and apply prompt shielding.* Regularly inspect the data returned by AI models to detect and mitigate risks associated with malicious or unpredictable user prompts. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan text for the risk of a user input attack on generative Al models.

- *Ensure model verification.* Establish company-wide verification mechanisms to ensure all AI models in use are legitimate and secure. If you use open-source models, use model signatures or other verification processes to confirm the authenticity of AI models, preventing unauthorized or tampered models from being deployed.

- *Consider using an AI Gateway.* [Azure API Management](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) (APIM) can help ensure consistent security across AI workloads. Use its built-in policies for traffic control and security enforcement. Integrate APIM with Microsoft Entra ID to centralize authentication and authorization and ensure only authorized users or applications interact with your AI models. Ensure you configure least privilege access on the [reverse proxy’s managed identity](/azure/api-management/api-management-howto-use-managed-service-identity). For more information, see [AI authentication with APIM](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations)

## Secure AI access

Securing AI access includes establishing authentication and authorization controls for both management plane and external access to AI resources. Proper access management restricts resource usage to only users with verified permissions. It reduces the chances of unauthorized interactions with AI models. Strong access controls, such as role-based access and Conditional Access policies, helps protect sensitive data and maintain compliance with security standards.

- *Use Microsoft Entra ID for authentication.* Wherever possible, eliminate static API keys in favor of Microsoft Entra ID for authentication. Prefer use Microsoft Entra ID for authentication. If you use keys, audit API key access and [rotate keys](/azure/ai-services/rotate-keys) regularly. For authentication guidance, see [Azure AI Foundry](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), [Azure AI services](/azure/ai-services/authentication#authenticate-with-microsoft-entra-id), [Azure Machine Learning](/azure/machine-learning/how-to-setup-authentication).

- *Inventory agents.* An accurate inventory of AI agent identities is the foundation for managing access and enforcing policy controls. Use Entra Agent ID to see all AI agents created in your organization using Azure AI Foundry and Copilot Studio. For more information, see [Microsoft Entra Agent ID](/entra/identity/monitoring-health/concept-sign-ins#microsoft-entra-agent-id).

- *Configure authentication.* Enable [multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa) (MFA) and prefer secondary administrative accounts or just-in-time access with [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) (PIM) for sensitive accounts. Limit control plane access using services like Azure Bastion as secure entry points into private networks.

- *Use Conditional Access Policies.* Implement [risk-based Conditional Access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies) that respond to unusual sign-in activity or suspicious behavior. Use signals like user location, device state, and sign-in behavior to trigger extra verification steps. Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices (those meeting security requirements) can access AI resources.

- *Configure least privilege access.* Assign roles to users and groups based on their responsibilities. Use Azure role-based access control (RBAC) to ensure users have only the minimum level of access necessary to perform their tasks. Regularly review and adjust permissions to prevent privilege creep. For more information, see [Azure AI Foundry RBAC](/azure/ai-studio/concepts/rbac-ai-studio).

- *Secure Azure service-to-service interactions.* Use [managed identity](/entra/identity/managed-identities-azure-resources/overview) to allow Azure services to authenticate to each other without managing credentials.

- *Secure external access to AI model endpoints.* Require clients to authenticate using Microsoft Entra ID when accessing AI model endpoints. Consider using Azure API Management as an AI gateway in front of AI model endpoints to enforce access policies, control usage, and provide monitoring capabilities.

- *Utilize the Azure AI Foundry Management Center.* Use the management center to manage access to AI resources, view and manage quotas, and govern access to comply with organizational standards.

## Secure AI execution

Securing AI execution involves safeguarding the processes by which AI agents, such as [virtual assistants](/azure/ai-services/openai/how-to/assistant) or [autonomous agents](/azure/cosmos-db/ai-agents), run code in response to user requests. Isolate the execution environments, conduct code reviews, and set resource limits. These measures help ensure that these executions don't compromise system stability or security. These practices prevent malicious activities and protect the integrity of the systems in which AI agents operate, allowing them to function reliably within a secure framework.

- *Implement isolation mechanisms.* Utilize dynamic session management, such as [Dynamic Sessions](/azure/container-apps/sessions?tabs=azure-cli) in Azure Container Apps, to ensure each code execution occurs in a fresh, isolated environment that is destroyed after use.

- *Secure execution code.* Conduct thorough code reviews and testing before deploying scripts for execution by AI agents. This process helps identify and mitigate potential vulnerabilities. Use version control systems to manage code changes and ensure that only approved versions of scripts are executed.

- *Implement resource limits.* Set resource limits (CPU, memory, disk usage) for code execution environments to prevent any single execution from consuming excessive resources and potentially disrupting other services. Define execution timeouts to ensure that long-running or potentially stuck processes are terminated automatically.

For more information, see [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant) , [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions) , and [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents).

## Next step

> [!div class="nextstepaction"]
> [Govern PaaS AI](../govern.md)