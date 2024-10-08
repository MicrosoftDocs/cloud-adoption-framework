---
title: Secure AI - Recommendations to secure AI
description: Secure AI with comprehensive recommendations that focus on confidentiality, integrity, and availability. Learn best practices for AI security.
ms.author: ssumner
author: stephen-sumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Secure AI – Recommendations to secure AI

This article provides recommendations for securing AI. It focuses on the confidentiality, integrity, and availability of AI systems. Alternatively, AI security governance focuses on organizational risks and creating evergreen policies to mitigate those risks.

Securing AI requires you to implement the same security measures as any cloud workload. However, it requires you to pay special attention to securing data that flows in and out of AI endpoints, and securing the AI endpoints themselves. This guidance assumes that you're familiar with [CAF Secure](/azure/cloud-adoption-framework/secure/) and doesn’t repeat the cloud security practices found there.

## Assess AI security risks

This guidance provides recommendations for identifying AI security risks. To properly implement security controls, you need to be familiar with AI risk.

- **Identify common AI security risks.** Use recognized resources like [MITRE ATLAS](https://atlas.mitre.org/), [OWASP Machine Learning risk](https://mltop10.info/), and [OWASP Generative AI risk](https://genai.owasp.org/) to regularly evaluate risks across all AI workloads. For ongoing security posture management, consider using AI security tools like [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud. These tools can automate the detection and remediation of generative AI risks.

- **Identify data risks.** Sensitive data loss or exposure can have significant effects on your organization’s stakeholders and compliance obligations. Use enterprise-wide tools like [Microsoft Purview Insider Risk Management](/purview/insider-risk-management) to assess insider risk and maintain data security throughout the business. Across all AI workloads, classify and prioritize risks based on the sensitivity of the data that they process, store, or transmit.

- **Conduct AI threat modeling.** Perform company-wide AI [threat modeling](https://www.microsoft.com/securityengineering/sdl/threatmodeling) by using frameworks like STRIDE to assess potential attack vectors for all AI workloads. Update threat models regularly to adapt to new AI use cases and threats. The [AI CoE](./center-of-excellence.md) should consider centralizing AI threat modeling to ensure a uniform approach across the organization and mitigate risks associated with various AI models, data sources, and processes.

- **Test AI models.** Conduct red-team testing against [generative AI models](/azure/ai-services/openai/concepts/red-teaming) and nongenerative models to assess their vulnerability to attacks. Tools like [PyRIT](https://github.com/Azure/PyRIT/tree/main#python-risk-identification-tool-for-generative-ai-pyrit) can automate this process for generative AI, so that you can challenge the model's outputs under various conditions. This step is highly technical and requires dedicated expertise to perform effectively.

## Implement AI security controls

This guidance provides recommendations for implementing security controls for AI. You must apply consistent security controls to all AI resources across the organization.

### Secure AI resources

This guidance provides recommendations for securing Azure resources that are deployed for AI workloads.

- **Establish a centralized AI asset inventory.** Maintain a detailed and up-to-date inventory of your AI workload resources to ensure that you can apply security policies uniformly to all AI workloads. Compile a company-wide inventory of all AI systems, models, datasets, and infrastructure across Azure. Utilize tools like Azure Resource Graph Explorer and Microsoft Defender for Cloud to automate the discovery process, which can [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and [predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk).

- **Secure Azure AI platforms and infrastructure.** Standardize the application of [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure service guides](/azure/well-architected/service-guides/?product=popular).

- **Deny inbound internet access to AI platforms.** Deny public access to AI resources. No PaaS services or AI model endpoints should be accessible from the public internet. For PaaS, use private endpoints for end user access. Use a jumpbox as part of the application resources for managing your AI resources.

    | Service | Recommendation |
    | --- | --- |
    | Azure AI services | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks?tabs=portal#use-private-endpoints) |
    | Azure AI Studio | Configure the [managed network](/azure/ai-studio/how-to/configure-managed-network) and use [private endpoints](/azure/ai-studio/how-to/configure-private-link)|
    | Azure Machine Learning | Follow the [security best practices](/azure/machine-learning/concept-enterprise-security) for Machine Learning |
    | Azure Virtual Machines | Use a public load balancer and only permit access requests to the AI model endpoint through the load balancer |

- **Limit outbound traffic from your AI resources**. Limit outbound traffic from your AI model endpoints to help protect sensitive data and maintain the integrity of your AI models. For minimizing data exfiltration risks, restrict outbound traffic to approved services or fully qualified domain names (FQDNs) and maintain a list of trusted sources. You should only allow unrestricted internet outbound traffic if you need access to public machine learning resources. Regularly monitor and update your systems. For more information, see [Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention), [Studio,](/azure/ai-studio/how-to/configure-managed-network), and [Machine Learning.](/azure/machine-learning/how-to-network-isolation-planning#allow-only-approved-outbound-mode).

### Secure the AI models

This guidance focuses on applying threat protection, monitoring for prompt injection risks, verifying model integrity, and centralizing governance to ensure consistent security across all workloads.

- **Implement threat protection for all AI models.** Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) to protect AI models from threats like prompt injection attacks and model manipulation. This tool provides continuous monitoring of AI workloads and helps detect and prevent emerging threats. Implement this protection across all workloads to ensure a consistent security posture throughout the organization.

- **Monitor outputs and apply prompt shielding.** Inspect the data returned by AI models regularly to detect and mitigate risks that are associated with malicious or unpredictable user prompts. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan text for the risk of a user input attack on generative Al models.

- **Ensure model verification.** Establish company-wide verification mechanisms to ensure that all AI models in use are legitimate and secure. If you use open-source models, use model signatures or other verification processes to confirm the authenticity of AI models. This approach prevents the deployment of unauthorized or tampered models.

- **Consider using an AI Gateway.** Use [Azure API Management](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) to help ensure consistent security across AI workloads. Use its built-in policies for traffic control and security enforcement. Integrate API Management with Microsoft Entra ID to centralize authentication and authorization and ensure that only authorized users or applications interact with your AI models. Configure least privilege access on the [reverse proxy’s managed identity](/azure/api-management/api-management-howto-use-managed-service-identity). For more information, see [AI authentication with API Management](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations).

### Secure AI execution

This guidance provides recommendations for secure code executions that AI systems make, such as [virtual assistants](/azure/ai-services/openai/how-to/assistant) or [autonomous agents](/azure/cosmos-db/ai-agents), to run scripts or programs in response to user queries or tasks. This capability enables AI agents to perform a wide range of functions, from simple data retrieval to complex computations and system operations. By executing code, AI agents can automate tasks, interact with other software systems, and provide more dynamic and responsive services.

- **Implement isolation mechanisms.** Use dynamic session management, such as [Dynamic Sessions](/azure/container-apps/sessions?tabs=azure-cli) in Azure Container Apps, to ensure each code execution occurs in a fresh, isolated environment that's destroyed after use.

- **Secure execution code.** Conduct thorough code reviews and testing before you deploy scripts for AI agents to execute. This process helps identify and mitigate potential vulnerabilities. Use version control systems to manage code changes and ensure that only approved versions of scripts are executed.

- **Implement resource limits.** Set resource limits on CPU, memory, and disk usage for code execution environments to prevent any single execution from consuming excessive resources. This helps avoid potential disruptions to other services. Define execution timeouts to ensure that long-running or potentially stuck processes are terminated automatically.

For more information, see [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant), [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions?tabs=python), and [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents).

### Secure AI data

This guidance outlines best practices for securing data involved in AI systems across all applications built in Azure within your organization. Adhere to these practices to help safeguard sensitive information, maintain data integrity, and prevent unauthorized access or breaches.

- **Define and maintain data boundaries.** Ensure AI workloads use data appropriate for their access level. AI applications tht are accessible to all employees should only process data suitable for all employees. Internet-facing AI applications must use data that's appropriate for public consumption. Use separate datasets or environments for different AI applications to prevent inadvertent data access. Consider using Microsoft Purview’s suite of [data security tools](/purview/purview-security) to secure your data.

- **Implement strict data access controls.** Ensure applications verify that end-users are authorized to access the data included in their queries. Avoid broad system permissions for user actions. Operate under the principle that if the AI can access certain information, the user should be authorized to access it directly.

- **Maintain a data catalog.** Keep an up-to-date catalog of all data that AI systems are connected to and consume, including storage locations and access details. Scan and label data regularly to track sensitivity levels and suitability. This approach aids in analytics and risk identification. Consider using [Microsoft Purview Data Catalog](/purview/purview-security) to map and govern your data.

- **Create a data sensitivity change management plan.** Track data sensitivity levels because they can change over time. Use your data catalog to monitor information used in AI workloads. Implement a process to find and remove sensitive data from AI workloads.

- **Secure AI artifacts.** Recognize AI models and datasets as valuable intellectual property and implement measures to protect them accordingly. Store AI models and datasets behind private endpoints and in secure environments such as Azure Blob Storage and dedicated workspaces. Apply strict access policies and encryption to safeguard AI artifacts against unauthorized access or theft to prevent data poisoning.

- **Safeguard sensitive data.** Use duplicates, local copies, or subsets that contain only the necessary information when the original data source is unsuitable for direct use. Process sensitive data within controlled environments that feature network isolation and rigorous access controls to prevent unauthorized access or data leaks. Additionally, implement comprehensive safeguards such as encryption, continuous monitoring, and intrusion detection systems to protect against data breaches during processing.

### Secure AI access

This section outlines security recommendations for accessing AI resources in Azure. It addresses management plane access to AI resources and external access to AI model endpoints. The guidance focuses on practices that are applicable to all AI applications across your business.

- **Organize resources and access controls.** Use distinct workspaces to organize and manage AI artifacts like datasets, models, and experiments. Workspaces centralize resource management and simplify access control. For example, use [projects](/azure/ai-studio/concepts/ai-resources#organize-work-in-projects-for-customization) within Studio to manage resources and permissions efficiently. This approach facilitates collaboration while maintaining security boundaries.

- **Use Entra ID for authentication.** Eliminate static API keys in favor of Microsoft Entra ID for authentication whenever possible. This step enhances security through centralized identity management and reduces secret management overhead. Limit the distribution of API keys. Instead, prefer identities in Entra ID over API keys for authentication. Audit the list of individuals with API key access to ensure it's current. For more information about authentication guidance, see [Studio](/azure/ai-studio/concepts/rbac-ai-studio), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), [Azure AI services](/azure/ai-services/authentication), [Machine Learning](/azure/machine-learning/how-to-setup-authentication), and [Virtual Machines](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities).

- **Configure authentication.** Enable [multifactor authentication (MFA)](/entra/identity/authentication/tutorial-enable-azure-mfa) and prefer secondary administrative accounts or just-in-time access with [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) (PIM) for sensitive accounts. Limit control plane access by using services like Azure Bastion as secure entry points into private networks.

- **Use conditional access policies.** Implement risk-based [conditional access policies](/entra/identity/conditional-access/overview) that respond to unusual sign-in activity or suspicious behavior. Use signals like user location, device state, and sign-in behavior to trigger extra verification steps. Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices, which are devices that meet security requirements, can access AI resources.

- **Configure least privilege access.** Configure least privilege access by implementing role-based access control (RBAC) to provide minimal access to data and services. Assign roles to users and groups based on their responsibilities. Use Azure RBAC to fine tune access control for specific resources such as virtual machines and storage accounts. Ensure users have only the minimum level of access required to perform their tasks. Regularly review and adjust permissions to prevent privilege creep. For example:

- *Data scientists* should have read and write access to data storage, permission to run training jobs, and access to model training environments.

- *AI developers* should have access to development environments, deployment permissions, and the ability to modify AI applications.

- *IT administrators* should have full access to manage infrastructure, network configurations, and security policies.

- **Secure Azure service-to-service interactions.** Use [Managed Identities](/entra/identity/managed-identities-azure-resources/overview) to allow Azure services to authenticate to each other without managing credentials.

- **Secure external access to AI model endpoints.** Require clients to authenticate by using Entra ID when they access AI model endpoints. Consider using Azure API Management as an AI gateway in front of AI model endpoints to enforce access policies, control usage, and provide monitoring capabilities.

## Maintain AI security controls

This guidance provides recommendations for maintaining the security of AI workloads over time. Effective monitoring and continuous review of AI security controls are essential to protect AI workloads across an organization.

- **Implement testing for data leakage and coercion in AI systems**. Conduct rigorous tests to determine if sensitive data can be leaked or coerced through AI systems. Perform data loss prevention tests and simulate AI-specific attack scenarios. Simulate model inversion or adversarial attacks to evaluate the resilience of data protection measures. Ensuring that AI models and data handling processes are secure against unauthorized access and manipulation is crucial to maintain data integrity and trust in AI applications.

- **Provide AI-focused employee training and awareness.** Provide comprehensive training programs for all employees involved in AI projects. Emphasize the importance of data security and best practices specific to AI development and deployment. Educate staff on how to handle sensitive data that's used in training and recognize threats like model inversion or data poisoning attacks. Regular training ensures that team members are knowledgeable about the latest AI security protocols and understand their role in maintaining the integrity of AI workloads.

- **Develop and maintain an incident response plan for AI security incidents.** Create an incident response strategy tailored to AI systems to address potential data breaches or security incidents. The plan should outline clear procedures for detecting, reporting, and mitigating security incidents that might affect AI models, data, or infrastructure. Conduct regular drills and simulations focused on AI-specific scenarios to ensure that the response team is prepared to handle real-world AI security incidents efficiently.

- **Conduct periodic risk assessments and impact analyses for AI workloads.** Evaluate emerging threats and vulnerabilities specific to AI regularly through risk assessments and impact analyses. These evaluations help identify new risks that are associated with AI models, data handling processes, and deployment environments. Evaluations also assess the potential impact of security breaches on AI systems.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](govern.md)
