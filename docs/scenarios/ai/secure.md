---
title: Secure AI – Process to secure AI
description: Learn the process to secure AI with best practices and recommendations.
ms.author: ssumner
author: stephen-sumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Secure AI – Process to secure AI

This article outlines the organizational process for securing AI workloads. It focuses on the confidentiality, integrity, and availability (CIA) of AI. Effective security practices reduce the risk of compromise by safeguarding the confidentiality, integrity, and availability of AI models and data. A secure AI environment also aligns with business security goals and enhances trust in AI-driven processes.

:::image type="content" source="./images/secure-ai.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/secure-ai.svg" border="false":::

## Assess AI security risks

Assessing AI security risks involves identifying and evaluating potential vulnerabilities that might affect AI workloads. Proactively addressing these risks helps prevent breaches, manipulation, and misuse, which strengthens the reliability of AI applications. This approach also supports organizational goals by protecting sensitive data and maintaining stakeholder trust.

- *Identify common AI security risks.* Use recognized resources like [MITRE ATLAS](https://atlas.mitre.org/), [OWASP Machine Learning risk](https://mltop10.info/), and [OWASP Generative AI risk](https://genai.owasp.org/) to regularly evaluate risks across all AI workloads. For ongoing security posture management, consider using AI security tools like [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud. These tools can automate the detection and remediation of generative AI risks.

- *Identify data risks.* Sensitive data loss or exposure can have significant impacts on your organization’s stakeholders and compliance obligations. Use enterprise-wide tools like [Microsoft Purview Insider Risk Management](/purview/insider-risk-management) to assess insider risk and maintain data security throughout the business. Across all AI workloads, classify and prioritize risks based on the sensitivity of the data that they process, store, or transmit.

- *Conduct AI threat modeling.* Perform company-wide AI [threat modeling](https://www.microsoft.com/securityengineering/sdl/threatmodeling) by using frameworks like STRIDE to assess potential attack vectors for all AI workloads. Update threat models regularly to adapt to new AI use cases and threats. The [AI center of excellence](./center-of-excellence.md) should consider centralizing AI threat modeling to ensure a uniform approach across the organization and mitigate risks associated with various AI models, data sources, and processes.

- *Test AI models.* Conduct red-team testing against [generative AI models](/azure/ai-services/openai/concepts/red-teaming) and nongenerative models to assess their vulnerability to attacks. Tools like [PyRIT](https://github.com/Azure/PyRIT/tree/main#python-risk-identification-tool-for-generative-ai-pyrit) can automate this process for generative AI, so that you can challenge the model's outputs under various conditions. This step is highly technical and requires dedicated expertise to perform effectively.

## Implement AI security controls

Implementing AI security controls means establishing policies, procedures, and tools that safeguard AI resources and data. These controls help ensure compliance with regulatory requirements and protect against unauthorized access, supporting continuous operation and data privacy. When you apply consistent controls across AI workloads, you can manage security more effectively.

### Secure AI resources

Securing AI resources includes managing and protecting the systems, models, and infrastructure that support AI applications. This step reduces the likelihood of unauthorized access and helps standardize security practices across the organization. A comprehensive resource inventory allows consistent application of security policies and strengthens overall control of AI assets.

- *Establish a centralized AI asset inventory.* Maintaining a detailed and up-to-date inventory of your AI workload resources ensures you can apply security policies uniformly to all AI workloads. Compile a company-wide inventory of all AI systems, models, datasets, and infrastructure across Azure. Utilize tools like Azure Resource Graph Explorer and Microsoft Defender for Cloud to automate the discovery process. Microsoft Defender for Cloud can [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and in [predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk).

- *Secure Azure AI platforms.* Standardize the application of [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every AI resource. Follow the security recommendations in [Azure Service Guides](/azure/well-architected/service-guides/?product=popular).

- *Use workload specific governance guidance.* Detailed security guidance is available for AI workloads on Azure platform services (PaaS) and Azure infrastructure (IaaS). Use this guidance to secure AI models, resources, and data within these workload types.

    > [!div class="nextstepaction"]
    > [Security for Azure platforms (PaaS)](./platform/security.md)

    > [!div class="nextstepaction"]
    > [Security for Azure infrastructure (IaaS)](./infrastructure/security.md)

### Secure AI data

Securing AI data involves protecting the data that AI models use and generate. Effective data security practices help prevent unauthorized access, data leaks, and compliance breaches. Controlling data access and maintaining a detailed catalog also support informed decision-making and reduce the risk of exposing sensitive information.

- *Define and maintain data boundaries.* Ensure AI workloads use data appropriate for their access level. AI applications accessible to all employees should only process data suitable for all employees. Internet-facing AI applications must use data appropriate for public consumption. Use separate datasets or environments for different AI applications to prevent inadvertent data access. Consider using Microsoft Purview’s suite of [data security](/purview/purview-security) tools to secure your data.

- *Implement strict data access controls.* Ensure applications verify that end-users are authorized to access the data involved in their queries. Avoid broad system permissions for user actions. Operate under the principle that if the AI can access certain information, the user should be authorized to access it directly.

- *Maintain a data catalog.* Keep an up-to-date catalog of all data connected to and consumed by AI systems, including storage locations and access details. Regularly scan and label data to track sensitivity levels and suitability, aiding in analytics and risk identification. Consider using [Microsoft Purview Data Catalog](/purview/purview-security) to map and govern your data.

- *Create a data sensitivity change management plan.* Track data sensitivity levels as they can change over time. Use your data catalog to monitor information used in AI workloads. Implement a process to find and remove sensitive data from AI workloads.

- *Secure AI artifacts.* Recognize AI models and datasets as valuable intellectual property and implement measures to protect them accordingly. Store AI models and datasets behind private endpoints and in secure environments such as Azure Blob Storage and dedicated workspaces. Apply strict access policies and encryption to safeguard AI artifacts against unauthorized access or theft to prevent data poisoning.

- *Safeguard sensitive data.* When the original data source is unsuitable for direct use, use duplicates, local copies, or subsets that contain only the necessary information. Process sensitive data within controlled environments that feature network isolation and rigorous access controls to prevent unauthorized access or data leaks. Additionally, implement comprehensive safeguards such as encryption, continuous monitoring, and intrusion detection systems to protect against data breaches during processing.

## Maintain AI security controls

Maintaining AI security controls includes ongoing monitoring, testing, and updating of security measures to address evolving threats. Regularly reviewing security controls ensures that AI workloads remain protected and that the organization can adapt to new risks. Proactive maintenance helps prevent breaches and maintains trust in AI systems over time.

- *Implement testing for data leakage and coercion in AI systems*. Conduct rigorous tests to determine if sensitive data can be leaked or coerced through AI systems. Perform data loss prevention (DLP) tests and simulate AI-specific attack scenarios. Simulate model inversion or adversarial attacks to evaluate the resilience of data protection measures. Ensuring that AI models and data handling processes are secure against unauthorized access and manipulation is critical for maintaining data integrity and trust in AI applications.

- *Provide AI-focused employee training and awareness.* Provide training programs for all employees involved in AI projects. Emphasize the importance of data security and best practices that are specific to AI development and deployment. Educate staff on how to handle sensitive data that's used in training and recognize threats like model inversion or data poisoning attacks. Regular training ensures that team members are knowledgeable about the latest AI security protocols and understand their role in maintaining the integrity of AI workloads.

- *Develop and maintain an incident response plan for AI security incidents.* Create an incident response strategy tailored to AI systems to address potential data breaches or security incidents. The plan should outline clear procedures for detecting, reporting, and mitigating security incidents that might affect AI models, data, or infrastructure. Conduct regular drills and simulations focused on AI-specific scenarios to ensure that the response team is prepared to handle real-world AI security incidents efficiently.

- *Conduct periodic risk assessments.* Evaluate emerging threats and vulnerabilities specific to AI regularly through risk assessments and impact analyses. These evaluations help identify new risks that are associated with AI models, data handling processes, and deployment environments. Evaluations also assess the potential effects of security breaches on AI systems.

## Next steps

Govern AI, Manage AI, and Secure AI are continuous processes you must iterate through regularly. Revisit each AI Strategy, AI Plan, and AI Ready as needed. Use the AI adoption checklists to determine what your next step should be.

> [!div class="nextstepaction"]
> [AI checklists](index.md#ai-checklists)
