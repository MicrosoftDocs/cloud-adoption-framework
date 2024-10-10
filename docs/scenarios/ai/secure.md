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

- *Identify common AI security risks.* Use recognized resources like [MITRE ATLAS](https://atlas.mitre.org/), [OWASP Machine Learning risk](https://mltop10.info/), and [OWASP Generative AI risk](https://genai.owasp.org/) to regularly evaluate risks across all AI workloads. For ongoing security posture management, consider using AI security tools like [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud, which can automate the detection and remediation of generative AI risks.

- *Identify data risks.* Sensitive data loss or exposure can have significant impacts on your organization’s stakeholders and compliance obligations. Use enterprise-wide tools like [Microsoft Purview Insider Risk Management](/purview/insider-risk-management) for assessing insider risk and maintaining data security throughout the business. Across all AI workloads, classify and prioritize risks based on the sensitivity of the data they process, store, or transmit.

- *Conduct AI threat modeling.* Perform company-wide AI [threat modeling](https://www.microsoft.com/securityengineering/sdl/threatmodeling) using frameworks like STRIDE to assess potential attack vectors for all AI workloads. Regularly update threat models to adapt to new AI use cases and threats. The [AI CoE](./center-of-excellence.md) should consider centralizing AI threat modeling to ensure a uniform approach across the organization and mitigate risks associated with various AI models, data sources, and processes.

- *Test AI models.* Conduct red-team testing against [generative AI models](/azure/ai-services/openai/concepts/red-teaming) and nongenerative models to assess their vulnerability to attacks. Tools like [PyRIT](https://github.com/Azure/PyRIT/tree/main#python-risk-identification-tool-for-generative-ai-pyrit) can automate this process for generative AI, allowing you to challenge the model's outputs under various conditions. This step is highly technical and requires dedicated expertise to execute effectively.

## Implement AI security controls

This guidance provides recommendations for implementing security controls for AI. Apply consistent security controls to all AI resources across the organization.

- *Establish a centralized AI asset inventory.* Maintaining a detailed and up-to-date inventory of your AI workload resources ensures you can apply security policies uniformly to all AI workloads. Compile a company-wide inventory of all AI systems, models, datasets, and infrastructure across Azure. Utilize tools like Azure Resource Graph Explorer and Microsoft Defender for Cloud to automate the discovery process. Microsoft Defender for Cloud can [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and in [predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk).

- *Secure Azure AI platforms.* Standardize the application of [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular).

Follow the specific security guidance for your AI workload type:

- [AI on Azure AI platforms (PaaS)](./platform/./secure.md)
- [AI on Azure infrastructure (IaaS)](./infrastructure/storage.md)

## Secure AI data

This guidance outlines best practices for securing data involved in AI systems across all applications built in Azure within our organization. Adhering to these practices helps safeguard sensitive information, maintain data integrity, and prevent unauthorized access or breaches.

- *Define and maintain data boundaries.* Ensure AI workloads use data appropriate for their access level. AI applications accessible to all employees should only process data suitable for all employees. Internet-facing AI applications must use data appropriate for public consumption. Use separate datasets or environments for different AI applications to prevent inadvertent data access. Consider using Microsoft Purview’s suite of [data security](/purview/purview-security) tools to secure your data.

- *Implement strict data access controls. Ensure applications verify that end-users are authorized to access the data involved in their queries.* Avoid broad system permissions for user actions. Operate under the principle that if the AI can access certain information, the user should be authorized to access it directly.

- *Maintain a data catalog.* Keep an up-to-date catalog of all data connected to and consumed by AI systems, including storage locations and access details. Regularly scan and label data to track sensitivity levels and suitability, aiding in analytics and risk identification. Consider using [Microsoft Purview Data Catalog](/purview/purview-security) to map and govern your data.

- *Create a data sensitivity change management plan.* Track data sensitivity levels as they can change over time. Use your data catalog to monitor information used in AI workloads. Implement a process to find and remove sensitive data from AI workloads.

- *Secure AI artifacts.* Recognize AI models and datasets as valuable intellectual property and implement measures to protect them accordingly. Store AI models and datasets behind private endpoints and in secure environments such as Azure Blob Storage and dedicated workspaces. Apply strict access policies and encryption to safeguard AI artifacts against unauthorized access or theft to prevent data poisoning.

- *Safeguard sensitive data.* When the original data source is unsuitable for direct use, use duplicates, local copies, or subsets that contain only the necessary information. Process sensitive data within controlled environments that feature network isolation and rigorous access controls to prevent unauthorized access or data leaks. Additionally, implement comprehensive safeguards such as encryption, continuous monitoring, and intrusion detection systems to protect against data breaches during processing.

## Maintain AI security controls

This guidance provides recommendations for maintaining the security of AI workloads over time. Effective monitoring and continuous review of AI security controls are essential to protect AI workloads across an organization.

- *Implement testing for data leakage and coercion in AI systems*. Conduct rigorous tests to determine if sensitive data can be leaked or coerced through AI systems. Perform data loss prevention (DLP) tests and simulate AI-specific attack scenarios. Simulate model inversion or adversarial attacks to evaluate the resilience of data protection measures. Ensuring that AI models and data handling processes are secure against unauthorized access and manipulation is critical for maintaining data integrity and trust in AI applications.

- *Provide AI-focused employee training and awareness.* Offer comprehensive training programs for all employees involved in AI projects, emphasizing the importance of data security and best practices specific to AI development and deployment. Educate staff on handling sensitive data used in training and recognizing threats like model inversion or data poisoning attacks. Regular training ensures that team members are knowledgeable about the latest AI security protocols and understand their role in maintaining the integrity of AI workloads.

- *Develop and maintain an incident response plan for AI security incidents.* Create an incident response strategy tailored to AI systems to address potential data breaches or security incidents. The plan should outline clear procedures for detecting, reporting, and mitigating security incidents that might affect AI models, data, or infrastructure. Conduct regular drills and simulations focused on AI-specific scenarios to ensure the response team is prepared to handle real-world AI security incidents efficiently.

- *Conduct periodic risk assessments and impact analyses for AI workloads.* Regularly evaluate emerging threats and vulnerabilities specific to AI through risk assessments and impact analyses. These evaluations help identify new risks associated with AI models, data handling processes, and deployment environments, and assess the potential impact of security breaches on AI systems.

## Next steps

> [!div class="nextstepaction"]
> [Govern AI](govern.md)
