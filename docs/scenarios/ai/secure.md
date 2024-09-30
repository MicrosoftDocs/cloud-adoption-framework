---
title: Secure AI - Recommendations to secure AI
description: Secure AI with comprehensive recommendations focusing on confidentiality, integrity, and availability. Learn best practices for AI security.
ms.author: ssumner
author: stephen-sumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Secure AI – Recommendations to secure AI

This article offers recommendations for securing AI and focuses on the confidentiality, integrity, and availability (CIA) of AI systems. AI security governance, on the other hand, focuses on organizational risks and creating evergreen policies to mitigate those risks.

Securing AI requires all the same security measures as any cloud workload. However, it requires special attention to securing data in and out of AI endpoints and securing the AI endpoints themselves. This guidance assumes familiarity with [CAF Secure](/azure/cloud-adoption-framework/secure/) and doesn’t repeat the cloud security practices found there.

## Assess AI security risks

This guidance provides recommendations for identifying AI security risks. Familiarity with AI risk is required to properly implement security controls.

- *Identify common AI security risks.* Use widely recognized resources like [MITRE ATLAS Matrix,](https://atlas.mitre.org/matrices/ATLAS), [OWASP Machine Learning risk](https://mltop10.info/), and [OWASP Generative AI risk](https://genai.owasp.org/) to regularly evaluate risks across all AI workloads. For ongoing security posture management, consider using AI security tools like [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud, which can automate the detection and remediation of generative AI risks.

- *Identify data risks.* Sensitive data loss or exposure can have significant impacts on your organization’s stakeholders and compliance obligations. Use enterprise-wide tools like [Microsoft Purview Insider Risk Management](/azure/purview/insider-risk-management) to assess insider risk and maintain data security throughout the business. Across all AI workloads, classify and prioritize risks based on the sensitivity of the data they process, store, or transmit.

- *Conduct AI threat modeling.* Perform company-wide AI [threat modeling](https://www.microsoft.com/securityengineering/sdl/threatmodeling) using frameworks like STRIDE to assess potential attack vectors for all AI workloads. Regularly update threat models to adapt to new AI use cases and threats. The [AI CoE](./center-of-excellence.md) should consider centralizing AI threat modeling to ensure a uniform approach across the organization and mitigate risks associated with various AI models, data sources, and processes.
- *Red team AI models.* Conduct red-team testing against [generative AI models](/azure/ai-services/openai/concepts/red-teaming) and non-generative models to assess their vulnerability to attacks. Tools like [PyRIT](https://github.com/Azure/PyRIT/tree/main#python-risk-identification-tool-for-generative-ai-pyrit) can automate this process for generative AI, allowing you to challenge the model's outputs under various conditions. This step is highly technical and requires dedicated expertise to execute effectively.

## Implement AI security controls

Security controls should be uniformly applied to all AI resources across the organization. This includes having a comprehensive view of all AI systems and dependencies, ensuring they adhere to security baselines, and applying protection mechanisms consistently.

### Secure AI resources

Once risks are identified, appropriate security controls must be implemented to safeguard AI systems. This requires a comprehensive inventory of AI resources, secure configurations, and robust model protection measures.

- *Establish a centralized AI asset inventory.* Maintaining a detailed and up-to-date inventory of your AI workload resources ensures you can apply security policies uniformly to all AI workloads. Compile a company-wide inventory of all AI systems, models, datasets, and infrastructure across Azure. Utilize tools like Azure Resource Graph Explorer and Microsoft Defender for Cloud to automate the discovery process, which can [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and in [pre-deployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk).

- *Secure Azure AI platforms and infrastructure.* Standardize the application of [Azure security baselines](/azure/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular).

- *Deny inbound internet access to AI platforms.* *Deny public access to AI resources.* No PaaS services or AI model endpoints should be accessible from the public internet. For PaaS, use private endpoints for end user access. Use a jumpbox as part of the applicaiton resources to manage your AI resources.

    | Service | Recommendation
    | Azure AI services | Restrict access to select [virtual networks](/azure/ai-services/cognitive-services-virtual-networks#scenarios) or use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks?tabs=portal#use-private-endpoints) |
    | Azure AI Studio | Configure the [managed network](/azure/ai-studio/how-to/configure-managed-network) and use [private endpoints](/azure/ai-studio/how-to/configure-private-link)|
    | Azure Machine Learning | Follow the [security best practices](/azure/machine-learning/concept-enterprise-security?view=azureml-api-2) for Azure Machine Learning |
    | Azure Virtual Machines | Use a public load balancer and only permit access requests to the AI model endpoint through the load balancer |

- *Limit outbound traffic from your AI resources*. Limiting outbound traffic from your AI model endpoints helps protect sensitive data and maintain the integrity of your AI models. For minimizing data exfiltration risks, restrict outbound traffic to approved services or FQDNs and maintain a list of trusted sources. You should only allow unrestricted internet outbound traffic if you need access to public machine learning resources, but regularly monitor and update your systems. For more information, see [Azure AI services, ](/azure/ai-services/cognitive-services-data-loss-prevention)[Azure AI Studio,](/azure/ai-studio/how-to/configure-managed-network)  and [Azure Machine Learning.](/azure/machine-learning/how-to-network-isolation-planning?view=azureml-api-2#allow-only-approved-outbound-mode)

### Secure the AI models

This guidance focuses on applying threat protection, monitoring for prompt injection risks, verifying model integrity, and centralizing governance to ensure consistent security across all workloads.

- *Implement threat protection for all AI models.* Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) to protect AI models from threats like prompt injection attacks and model manipulation. This tool provides continuous monitoring of AI workloads, helping to detect and prevent emerging threats. Implementing this protection across all workloads ensures a consistent security posture throughout the organization.

- *Monitor outputs and apply prompt shielding.* Regularly inspect the data returned by AI models to detect and mitigate risks associated with malicious or unpredictable user prompts. Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to scan text for the risk of a user input attack on generative Al models.

- *Ensure model verification.* Establish company-wide verification mechanisms to ensure all AI models in use are legitimate and secure. If you use open-source models, use model signatures or other verification processes to confirm the authenticity of AI models, preventing unauthorized or tampered models from being deployed.

- *Consider using an AI Gateway.* [Azure API Management](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) (APIM) can help ensure consistent security across AI workloads. Use its built-in policies for traffic control and security enforcement. Integrate APIM with Microsoft Entra ID to centralize authentication and authorization and ensure only authorized users or applications interact with your AI models. Ensure you configure least privilege access on the [reverse proxy’s managed identity](/azure/api-management/api-management-howto-use-managed-service-identity). For more information, see [AI authentication with APIM](/azure/architecture/ai-ml/guide/azure-openai-gateway-custom-authentication#general-recommendations)

### Secure AI execution

This guidance provides recommendations for secure code executions made by AI systems, such as [virtual assistants](/azure/ai-services/openai/how-to/assistant) or [autonomous agents](/azure/cosmos-db/ai-agents), to run scripts or programs in response to user queries or tasks. This capability allows AI agents to perform a wide range of functions, from simple data retrieval to complex computations and system operations. By executing code, AI agents can automate tasks, interact with other software systems, and provide more dynamic and responsive services.

- *Implement isolation mechanisms.* Utilize dynamic session management, such as [Dynamic Sessions](/azure/container-apps/sessions?tabs=azure-cli) in Azure Container Apps, to ensure each code execution occurs in a fresh, isolated environment that is destroyed after use.

- *Secure execution code.* Conduct thorough code reviews and testing before deploying scripts for execution by AI agents. This helps identify and mitigate potential vulnerabilities. Use version control systems to manage code changes and ensure that only approved versions of scripts are executed.

- *Implement resource limits.* Set resource limits (CPU, memory, disk usage) for code execution environments to prevent any single execution from consuming excessive resources and potentially disrupting other services. Define execution timeouts to ensure that long-running or potentially stuck processes are terminated automatically.

For more information, see [How to create Assistants with Azure OpenAI Service](/azure/ai-services/openai/how-to/assistant) , [How to use Azure OpenAI Assistants function calling](/azure/ai-services/openai/how-to/assistant-functions?tabs=python) , and [Agent implementation](/azure/cosmos-db/ai-agents#implementation-of-ai-agents).

### Secure AI data

This guidance outlines best practices for securing data involved in AI systems across all applications built in Azure within our organization. Adhering to these practices will help safeguard sensitive information, maintain data integrity, and prevent unauthorized access or breaches.

- *Define and maintain data boundaries.* Ensure AI workloads use data appropriate for their access level. AI applications accessible to all employees should only process data suitable for all employees. Internet-facing AI applications must use data appropriate for public consumption. Use separate datasets or environments for different AI applications to prevent inadvertent data access. Consider using Microsoft Purview’s suite of [data security](/azure/purview/purview-security) tools to secure your data.

- *Implement strict data access controls. Ensure applications verify that end-users are authorized to access the data involved in their queries.* Avoid broad system permissions for user actions. Operate under the principle that if the AI can access certain information, the user should be authorized to access it directly.

- *Maintain a data catalog.* Keep an up-to-date catalog of all data connected to and consumed by AI systems, including storage locations and access details. Regularly scan and label data to track sensitivity levels and suitability, aiding in analytics and risk identification. Consider using [Microsoft Purview Data Catalog](/azure/purview/purview-security) to map and govern your data.

- *Create a data sensitivity change management plan.* Track data sensitivity levels as they can change over time. Use your data catalog to monitor information used in AI workloads. Implement a process to find and remove sensitive data from AI workloads.

- *Secure AI artifacts.* Recognize AI models and datasets as valuable intellectual property and implement measures to protect them accordingly. Store AI models and datasets behind private endpoints and in secure environments such as Azure Blob Storage and dedicated workspaces. Apply strict access policies and encryption to safeguard AI artifacts against unauthorized access or theft to prevent data poisoning.

- *Safeguard sensitive data.* When the original data source is unsuitable for direct use, use duplicates, local copies, or subsets that contain only the necessary information. Process sensitive data within controlled environments that feature network isolation and rigorous access controls to prevent unauthorized access or data leaks. Additionally, implement comprehensive safeguards such as encryption, continuous monitoring, and intrusion detection systems to protect against data breaches during processing.

### Secure AI access

This section outlines security recommendations for accessing AI resources in Azure, addressing both management plane access to AI resources and external access to AI model endpoints. The guidance focuses on practices applicable to all AI applications across your business.

- *Organize resources and access controls.* Use distinct workspaces to organize and manage AI artifacts like datasets, models, and experiments. This centralizes resource management and simplifies access control. For example, use [projects](/azure/ai-studio/concepts/ai-resources#organize-work-in-projects-for-customization) within Azure AI Studio to manage resources and permissions efficiently, facilitating collaboration while maintaining security boundaries.

- *Use Entra ID for authentication.* Wherever possible, eliminate static API keys in favor of Microsoft Entra ID for authentication. This enhances security through centralized identity management and reduces secret management overhead Limit the distribution of API keys. Instead, prefer identities in Entra ID over API keys for authentication. Periodically audit the list of individuals with API key access to ensure it remains current and appropriate. For authentication guidance, see [Azure AI Studio](/azure/ai-studio/concepts/rbac-ai-studio), [Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity), [Azure AI services](/azure/ai-services/authentication), [Azure Machine Learning](/azure/machine-learning/how-to-setup-authentication) , and [Azure Virtual Machines](/azure/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities) .

- *Configure authentication.* Enable [multi-factor authentication](/azure/entra/identity/authentication/tutorial-enable-azure-mfa) (MFA) and prefer secondary administrative accounts or just-in-time access with [Privileged Identity Management](/azure/entra/id-governance/privileged-identity-management/pim-configure) (PIM) for sensitive accounts. Limit control plane access using services like Azure Bastion as secure entry points into private networks.

- *Use Conditional Access Policies.* Implement risk-based [conditional access policies](/azure/entra/identity/conditional-access/overview) that respond to unusual sign-in activity or suspicious behavior.**** Use signals like user location, device state, and sign-in behavior to trigger additional verification steps. Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices (those meeting security requirements) can access AI resources.

- *Configure least privilege access.* Configure least privilege access by implementing Role-Based Access Control (RBAC) to provide minimal access to data and services. Assign roles to users and groups based on their responsibilities. Use Azure RBAC to fine-tune access control for specific resources such as virtual machines and storage accounts. Ensure users have only the minimum level of access necessary to perform their tasks. Regularly review and adjust permissions to prevent privilege creep. For example,

- *Data Scientists* should have read/write access to data storage, permission to run training jobs, and access to model training environments.

    - *AI Developers* should have access to development environments, deployment permissions, and the ability to modify AI applications.
    - *IT Administrators* should have full access to manage infrastructure, network configurations, and security policies
    - *Secure Azure service-to-service interactions.* Use [Managed Identities](/azure/entra/identity/managed-identities-azure-resources/overview) to allow Azure services to authenticate to each other without managing credentials, enhancing security and simplifying identity management.

- *Secure external access to AI model endpoints.* Require clients to authenticate using Entra ID when accessing AI model endpoints. Consider using Azure API Management as an AI gateway in front of AI model endpoints to enforce access policies, control usage, and provide monitoring capabilities.

***Maintain AI security controls ***

Effective monitoring and continuous review of AI security controls are essential to protect AI workloads across an organization. To ensure robust security, organizations should implement a comprehensive strategy that includes regular assessments, ongoing monitoring, employee training, incident response planning, and adaptive control updates.

- *Implement testing for data leakage and coercion in AI systems*. Conduct rigorous tests to determine if sensitive data can be leaked or coerced through AI systems. Perform data leakage prevention (DLP) tests and simulate AI-specific attack scenarios, such as model inversion or adversarial attacks, to evaluate the resilience of data protection measures. Ensuring that AI models and data handling processes are secure against unauthorized access and manipulation is critical for maintaining data integrity and trust in AI applications.

- *Provide AI-focused employee training and awareness.* Offer comprehensive training programs for all employees involved in AI projects, emphasizing the importance of data security and best practices specific to AI development and deployment. Educate staff on securing AI models, handling sensitive data used in training, and recognizing threats like model inversion or data poisoning attacks. Regular training ensures that team members are knowledgeable about the latest AI security protocols and understand their role in maintaining the integrity of AI workloads.

- *Develop and maintain an incident response plan for AI security incidents.* Create a robust incident response strategy tailored to AI systems to address potential data breaches or security incidents promptly and effectively. The plan should outline clear procedures for detecting, reporting, and mitigating security incidents that may affect AI models, data, or infrastructure. Conduct regular drills and simulations focused on AI-specific scenarios to ensure the response team is prepared to handle real-world AI security incidents efficiently.

- *Conduct periodic risk assessments and impact analyses for AI workloads.* Regularly evaluate emerging threats and vulnerabilities specific to AI through risk assessments and impact analyses. These evaluations help identify new risks associated with AI models, data handling processes, and deployment environments, and assess the potential impact of security breaches on AI systems. By understanding the AI-specific threat landscape, organizations can proactively implement measures to mitigate risks before they materialize.

***Next steps ***

Manage AI|Service|Recommendation|
|---|---|
|Azure AI services|Restrict access to select or use||Azure AI Studio|Configure the and use||Azure Machine Learning|Follow the||Azure Virtual Machines|Use a public load balancer and only permit access requests to the AI model endpoint through the load balancer|

## Next steps

> [!div class="nextstepaction"]
> [Govern AI](govern.md)
