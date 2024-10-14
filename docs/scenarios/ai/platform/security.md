---
title: Security for AI workloads using Azure AI platforms
description: Discover how to build AI applications on Azure PaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Security for AI workloads using Azure AI platforms

This articles provides recommendations for securing AI workloads that use Azure AI platform as a service (PaaS) solutions, such as Azure AI Studio, Azure Machine Learning, and Azure AI services. It focuses on the implementation of security configurations for the AI models and platforms on which they run. It's the second step in the overarching [Secure AI](./security.md) process.

## Secure AI resources

This guidance provides recommendations for securing Azure resources deployed for AI workloads.

*Secure Azure AI platforms.* Standardize the application of [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular).

## Secure the AI models

This guidance focuses on applying threat protection, monitoring for prompt injection risks, verifying model integrity, and centralizing governance to ensure consistent security across all workloads.

- *Implement threat protection for all AI models.* Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) to protect AI models from threats like prompt injection attacks and model manipulation. This tool provides continuous monitoring of AI workloads, helping to detect and prevent emerging threats. Implementing this protection across all workloads ensures a consistent security posture throughout the organization.

- *Monitor outputs and apply prompt shielding.* Regularly inspect the data returned by AI models to detect and mitigate risks associated with malicious or unpredictable user prompts. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan text for the risk of a user input attack on generative Al models.

- *Ensure model verification.* Establish company-wide verification mechanisms to ensure all AI models in use are legitimate and secure. If you use open-source models, use model signatures or other verification processes to confirm the authenticity of AI models, preventing unauthorized or tampered models from being deployed.

- *Consider using an AI Gateway.* [Azure API Management](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) (APIM) can help ensure consistent security across AI workloads. Use its built-in policies for traffic control and security enforcement. Integrate APIM with Microsoft Entra ID to centralize authentication and authorization and ensure only authorized users or applications interact with your AI models. Ensure you configure least privilege access on the [reverse proxy’s managed identity](/azure/api-management/api-management-howto-use-managed-service-identity). For more information, see [AI authentication with APIM](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations)

## Secure AI access

This section outlines security recommendations for accessing AI resources in Azure, addressing both management plane access to AI resources and external access to AI model endpoints. The guidance focuses on practices applicable to all AI applications across your business.

- *Organize resources and access controls.* Use distinct workspaces to organize and manage AI artifacts like datasets, models, and experiments. Workspaces centralize resource management and simplify access control. For example, use [projects](/azure/ai-studio/concepts/ai-resources#organize-work-in-projects-for-customization) within Azure AI Studio to manage resources and permissions efficiently, facilitating collaboration while maintaining security boundaries.

- *Use Entra ID for authentication.* Wherever possible, eliminate static API keys in favor of Microsoft Entra ID for authentication. This step enhances security through centralized identity management and reduces secret management overhead. Also limit the distribution of API keys. Instead, prefer identities in Entra ID over API keys for authentication. Audit the list of individuals with API key access to ensure it's current. For authentication guidance, see [Azure AI Studio](/azure/ai-studio/concepts/rbac-ai-studio), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), [Azure AI services](/azure/ai-services/authentication), [Azure Machine Learning](/azure/machine-learning/how-to-setup-authentication).

- *Configure authentication.* Enable [multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa) (MFA) and prefer secondary administrative accounts or just-in-time access with [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) (PIM) for sensitive accounts. Limit control plane access using services like Azure Bastion as secure entry points into private networks.

- *Use Conditional Access Policies.* Implement risk-based [conditional access policies](/entra/identity/conditional-access/overview) that respond to unusual sign-in activity or suspicious behavior. Use signals like user location, device state, and sign-in behavior to trigger extra verification steps. Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices (those meeting security requirements) can access AI resources.

- *Configure least privilege access.* Configure least privilege access by implementing Role-Based Access Control (RBAC) to provide minimal access to data and services. Assign roles to users and groups based on their responsibilities. Use Azure RBAC to fine-tune access control for specific resources such as virtual machines and storage accounts. Ensure users have only the minimum level of access necessary to perform their tasks. Regularly review and adjust permissions to prevent privilege creep. For example,

    - *Data scientists* should have read/write access to data storage, permission to run training jobs, and access to model training environments.
    - *AI developers* should have access to development environments, deployment permissions, and the ability to modify AI applications.
    - *IT administrators* should have full access to manage infrastructure, network configurations, and security policies

- *Secure Azure service-to-service interactions.* Use [Managed Identities](/entra/identity/managed-identities-azure-resources/overview) to allow Azure services to authenticate to each other without managing credentials.

- *Secure external access to AI model endpoints.* Require clients to authenticate using Entra ID when accessing AI model endpoints. Consider using Azure API Management as an AI gateway in front of AI model endpoints to enforce access policies, control usage, and provide monitoring capabilities.

## Secure AI execution

This guidance provides recommendations for secure code executions made by AI systems, such as [virtual assistants](/azure/ai-services/openai/how-to/assistant) or [autonomous agents](/azure/cosmos-db/ai-agents), to run scripts or programs in response to user queries or tasks. This capability allows AI agents to perform a wide range of functions, from simple data retrieval to complex computations and system operations. By executing code, AI agents can automate tasks, interact with other software systems, and provide more dynamic and responsive services.

- *Implement isolation mechanisms.* Utilize dynamic session management, such as [Dynamic Sessions](/azure/container-apps/sessions?tabs=azure-cli) in Azure Container Apps, to ensure each code execution occurs in a fresh, isolated environment that is destroyed after use.

- *Secure execution code.* Conduct thorough code reviews and testing before deploying scripts for execution by AI agents. This process helps identify and mitigate potential vulnerabilities. Use version control systems to manage code changes and ensure that only approved versions of scripts are executed.

- *Implement resource limits.* Set resource limits (CPU, memory, disk usage) for code execution environments to prevent any single execution from consuming excessive resources and potentially disrupting other services. Define execution timeouts to ensure that long-running or potentially stuck processes are terminated automatically.

For more information, see [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant) , [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions?tabs=python) , and [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents).