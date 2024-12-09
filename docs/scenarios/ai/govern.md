---
title: Govern AI – Process to govern AI
description: Learn the process to govern AI with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Govern AI – Process to govern AI

This article outlines the organizational process for governing AI. It follows the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf) and [NIST AI RMF Playbook](https://airc.nist.gov/AI_RMF_Knowledge_Base/Playbook). It also aligns with the framework in [CAF Govern](/azure/cloud-adoption-framework/govern/).

This guidance aims to help you integrate AI risk management into broader risk management strategies. This integration provides more cohesive handling of AI, cybersecurity, and privacy risks for a unified governance approach.

:::image type="content" source="./images/govern-ai.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/govern-ai.svg" border="false":::

## Assess AI organizational risks

AI risk assessment identifies and addresses potential risks introduced by AI technologies. This process builds trust in AI systems and reduces unintended consequences. Addressing organizational risks ensures that AI deployments align with the organization's values, risk tolerance, and operational goals.

- *Understand the AI workloads.* To mitigate AI risks, you must understand your AI workloads. By clarifying the scope and purpose of each AI workload, you can map associated risks. This clarification should include any assumptions and limitations related to the AI workload.

- *Use Responsible AI principles to identify risks.* These principles provide a framework for assessing AI risks. Use the following table to identify and mitigate risks through a structured assessment of AI principles.

    | Responsible AI principle    | Definition  | Risk assessment question    |
    |-----------------------------|-------------|----------------|
    | AI Privacy and Security      | AI workloads should respect privacy and be secure.  | How might AI workloads handle sensitive data or become vulnerable to security breaches?            |
    | Reliability and Safety       | AI workloads should perform safely and reliably.    | In what situations could AI workloads fail to operate safely or produce unreliable outcomes?   |
    | Fairness                     | AI workloads should treat people equitably.         | How could AI workloads lead to unequal treatment or unintended bias in decision-making? |
    | Inclusiveness                | AI workloads should be inclusive and empowering.     | How might certain groups be excluded or disadvantaged in the design or deployment of AI workloads?|
    | Transparency                 | AI workloads should be understandable.               | What aspects of AI decision-making could be difficult for users to understand or explain?|
    | Accountability               | People should be accountable for AI workloads.       | Where could accountability be unclear or difficult to establish in the development or use of AI?|

- *Identify AI risks.* Start by evaluating the security risks of AI workloads, including potential data breaches, unauthorized access, or misuse. Consult stakeholders to uncover less visible risks, and assess both qualitative and quantitative impacts, including reputational risks, to determine the organization’s risk tolerance.

- *Identify risks from external dependencies.* Assess risks related to third-party data sources, software, and integrations. Address issues like security vulnerabilities, bias, and intellectual property risks by establishing policies that ensure alignment with organizational privacy and compliance standards.

- *Assess integration risks.* Evaluate AI workloads integrate with existing workloads and processes. Document potential risks, such as dependency on other workloads, increased complexity, or incompatibilities that could impact functionality.

## Document AI governance policies

AI governance policies provide a structured framework for responsible AI usage. These policies align AI activities with ethical standards, regulatory requirements, and business objectives. Documenting policies ensures clear guidelines for managing AI models, data, and operations.

| AI governance policy area | AI governance policy recommendations |
|-----------|----------------------|
| Define policies for selecting and onboarding models | ▪ *Establish policies for selecting AI models.* Policies should outline criteria for choosing models that meet organizational values, capabilities, and cost constraints. Review potential models for alignment with risk tolerance and intended task requirements.<br><br> ▪ *Onboard new models with structured policies.* A formal process for model onboarding maintains consistency in model justification, validation, and approval. Use sandbox environments for initial experiments, then validate and review models in the production catalog to avoid duplication. |
| Define policies for using third-party tools and data | ▪ *Set controls for third-party tools.* A vetting process for third-party tools safeguards against security, compliance, and alignment risks. Policies should include guidelines for data privacy, security, and ethical standards when using external datasets.<br><br> ▪ *Define data sensitivity standards.* Keeping sensitive and public data separate is essential for mitigating AI risks. Create policies around data handling and separation.<br><br> ▪ *Define data quality standards.* A "golden dataset" provides a reliable benchmark for AI model testing and evaluation. Establish clear policies for data consistency and quality to ensure high performance and trustworthy outputs. |
| Define policies for maintaining and monitoring models | ▪ *Specify retraining frequency by use case.* Frequent retraining supports accuracy for high-risk AI workloads. Define guidelines that consider the use case and risk level of each model, especially for sectors like healthcare and finance.<br><br> ▪ *Monitor for performance degradation.* Monitoring model performance over time helps detect issues before they affect outcomes. Document benchmarks, and if a model’s performance declines, initiate a retraining or review process. |
| Define policies for regulatory compliance     | ▪ *Comply with regional legal requirements.* Understanding regional laws ensures AI operations remain compliant across locations. Research applicable regulations for each deployment area, such as data privacy laws, ethical standards, and industry regulations.<br><br> ▪ *Develop region-specific policies.* Tailoring AI policies to regional considerations supports compliance with local standards. Policies might include language support, data storage protocols, and cultural adaptations.<br><br> ▪ *Adapt AI for regional variability.* Flexibility in AI workloads allows for location-specific functionality adjustments. For global operations, document region-specific adaptations like localized training data and feature restrictions. |
| Define policies for user conduct              | ▪ *Define risk mitigation strategies for misuse.* Misuse prevention policies help protect against intentional or unintentional harms. Outline possible misuse scenarios and incorporate controls, such as restricted functionalities or misuse detection features.<br><br> ▪ *Set user conduct guidelines.* User agreements clarify acceptable behaviors when interacting with the AI workload, reducing the risk of misuse. Draft clear terms of use to communicate standards and support responsible AI interaction. |
| Define policies for AI integration and replacement | ▪ *Outline integration policies.* Integration guidelines ensure AI workloads maintain data integrity and security during workload interfacing. Specify technical requirements, data-sharing protocols, and security measures.<br><br> ▪ *Plan for transition and replacement.* Transition policies provide structure when replacing old processes with AI workloads. Outline steps for phasing out legacy processes, training staff, and monitoring performance throughout the change. |

## Enforce AI governance policies

Enforcing AI governance policies ensures consistent and ethical AI practices within an organization. Automated tools and manual interventions support policy adherence across deployments. Proper enforcement helps maintain compliance and minimizes human error.

- *Automate policy enforcement where possible* Use platforms like Azure Policy and Microsoft Purview to enforce policies automatically across AI deployments, reducing human error. Regularly assess areas where automation can improve policy adherence.

- *Manually enforce AI policies.* Provide AI risk and compliance training for employees to ensure they understand their role in AI governance. Regular workshops keep staff updated on AI policies, and periodic audits help monitor adherence and identify areas for improvement.

- *Use workload specific governance guidance.* Detailed security guidance is available for AI workloads on Azure platform services (PaaS) and Azure infrastructure (IaaS). Use this guidance to govern AI models, resources, and data within these workload types.

    > [!div class="nextstepaction"]
    > [Governance for Azure platforms (PaaS)](./platform/governance.md)

    > [!div class="nextstepaction"]
    > [Governance for Azure infrastructure (IaaS)](./infrastructure/governance.md)

## Monitor AI organizational risks

Monitoring AI risks enables organizations to identify emerging risks and address them promptly. Regular evaluations ensure AI workloads operate as intended. Consistent monitoring helps organizations adapt to evolving conditions and prevent negative impacts from AI systems.

- *Establish procedures for ongoing risk evaluation.* Set up regular reviews to identify new risks, engaging stakeholders to assess the broader impacts of AI. Develop a response plan for issues that arise to allow for risk reassessment and necessary adjustments.

- *Develop a measurement plan.* A clear measurement plan ensures consistent data collection and analysis. Define data collection methods, such as automated logging for operational metrics and surveys for qualitative feedback. Establish the frequency and scope of measurements, focusing on high-risk areas, and create feedback loops to refine risk assessments based on stakeholder input.

- *Quantify and qualify AI risks.* Choose quantitative metrics (error rates, accuracy) and qualitative indicators (user feedback, ethical concerns) that align with the workload’s purpose. Benchmark performance against industry standards to track the AI’s impacts, trustworthiness, and performance.

- *Document and report measurement outcomes.* Regular documentation and reports enhance transparency and accountability. Create standardized reports that summarize metrics, findings, and any anomalies to guide decision-making. Share these insights with stakeholders, using them to refine risk mitigation strategies and improve future deployments.

- *Establish independent review processes.* Regular independent reviews provide objective assessments of AI risks and compliance, using external or uninvolved internal reviewers. Use findings to strengthen risk assessments and refine governance policies.

## Next step

> [!div class="nextstepaction"]
> [Manage AI](manage.md)

## Example AI risk mitigations

The following table lists some common AI risks and provides a mitigation strategy and a sample policy for each one. The table doesn't list a complete set of risks.

| Risk ID | AI risk| Mitigation | Policy|
|---|---|---|---|
| R001| Noncompliance with data protection laws| Use Microsoft Purview Compliance Manager to evaluate data compliance.|The Security Development Lifecycle must be implemented to ensure that all AI development and deployment complies with data protection laws.|
| R005| Lack of transparency in AI decision making | Apply a standardized framework and language to improve transparency in AI processes and decision making. | The NIST AI Risk Management Framework must be adopted and all AI models must be thoroughly documented to maintain transparency of all AI models.|
| R006| Inaccurate predictions | Use Azure API Management to track AI model metrics to ensure accuracy and reliability.|Continuous performance monitoring and human feedback must be used to ensure that AI model predictions are accurate. |
| R007| Adversarial attack | Use PyRIT to test AI workloads for vulnerabilities and strengthen defenses.|The Security Development Lifecycle and AI red team testing must be used to secure AI workloads against adversarial attacks. |
| R008| Insider threats| Use Microsoft Entra ID to enforce strict access controls that are based on roles and group memberships to limit insider access to sensitive data.| Strict identity and access management and continuous monitoring must be used to mitigate insider threats. |
| R009| Unexpected costs| Use Microsoft Cost Management to track CPU, GPU, memory, and storage usage to ensure efficient resource utilization and prevent cost spikes. |Monitoring and optimization of resource usage and automated detection of cost overruns must be used to manage unexpected costs.|
| R010| Underutilization of AI resources| Monitor AI service metrics, like request rates and response times, to optimize usage.| Performance metrics and automated scalability must be used to optimize AI resource utilization. |
