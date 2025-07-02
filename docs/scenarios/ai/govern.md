---
title: Govern AI
description: Learn the process to govern AI with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Govern AI

This article helps you establish an organizational process for governing AI. You use this guidance to integrate AI risk management into your broader risk management strategies, creating a unified approach to AI, cybersecurity, and privacy governance. The process follows the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf) and [NIST AI RMF Playbook](https://airc.nist.gov/AI_RMF_Knowledge_Base/Playbook). The guidance aligns with the framework in [CAF Govern](/azure/cloud-adoption-framework/govern/).

## Assess AI organizational risks

AI risk assessment identifies potential risks that AI technologies introduce into your organization. This assessment builds trust in AI systems and reduces unintended consequences. You must conduct thorough risk assessments to ensure AI deployments align with your organization's values, risk tolerance, and operational goals. Here's how:

1. **Understand your AI workloads.** Each AI workload presents unique risks based on its purpose, scope, and implementation. You must clarify the specific function, data sources, and intended outcomes for each AI workload to map associated risks effectively. Document any assumptions and limitations related to each AI workload to establish clear boundaries for risk assessment.

1. **Use Responsible AI principles to identify risks.** Responsible AI principles provide a structured framework for comprehensive risk assessment. You must evaluate each AI workload against these principles to identify potential vulnerabilities and ethical concerns. Use the following table to guide your risk identification process:

    | Responsible AI principle    | Definition  | Risk assessment question    |
    |-----------------------------|-------------|----------------|
    | AI Privacy and Security      | AI workloads should respect privacy and be secure.  | How might AI workloads handle sensitive data or become vulnerable to security breaches?            |
    | Reliability and Safety       | AI workloads should perform safely and reliably.    | In what situations could AI workloads fail to operate safely or produce unreliable outcomes?   |
    | Fairness                     | AI workloads should treat people equitably.         | How could AI workloads lead to unequal treatment or unintended bias in decision-making? |
    | Inclusiveness                | AI workloads should be inclusive and empowering.     | How might certain groups be excluded or disadvantaged in the design or deployment of AI workloads?|
    | Transparency                 | AI workloads should be understandable.               | What aspects of AI decision-making could be difficult for users to understand or explain?|
    | Accountability               | People should be accountable for AI workloads.       | Where could accountability be unclear or difficult to establish in the development or use of AI?|

1. **Identify specific AI risks.** Risk identification requires systematic evaluation of security, operational, and ethical vulnerabilities. You must assess potential data breaches, unauthorized access, model manipulation, and misuse scenarios for each AI workload. Consult stakeholders from different departments to uncover risks that technical teams might overlook, and evaluate both quantitative impacts (financial losses, performance degradation) and qualitative impacts (reputational damage, user trust) to determine your organization's risk tolerance.

1. **Identify risks from external dependencies.** External dependencies introduce additional risk vectors that require careful evaluation. You must assess risks from third-party data sources, AI models, software libraries, and API integrations that your AI workloads depend on. Address potential issues such as security vulnerabilities, data quality problems, bias in external datasets, intellectual property conflicts, and vendor reliability by establishing clear policies that ensure external dependencies align with your organizational privacy, security, and compliance standards.

1. **Assess integration risks.** AI workloads rarely operate in isolation and create new risks when integrated with existing systems. You must evaluate how AI workloads connect with current applications, databases, and business processes to identify potential failure points. Document specific risks such as dependency cascades where AI failure affects multiple systems, increased system complexity that makes troubleshooting difficult, data format incompatibilities, performance bottlenecks, and security gaps at integration points that could compromise overall system functionality.

## Document AI governance policies

AI governance policies provide a structured framework for responsible AI use within your organization. These policies align AI activities with ethical standards, regulatory requirements, and business objectives. You must document policies that address identified AI risks based on your organization's risk tolerance. Here are AI governance policy examples:

| AI governance policy area | AI governance policy recommendations |
|-----------|----------------------|
| Define policies for selecting and onboarding models | ▪ *Establish policies for selecting AI models.* Policies should outline criteria for choosing models that meet organizational values, capabilities, and cost constraints. Review potential models for alignment with risk tolerance and intended task requirements.<br><br> ▪ *Onboard new models with structured policies.* A formal process for model onboarding maintains consistency in model justification, validation, and approval. Use sandbox environments for initial experiments, then validate and review models in the production catalog to avoid duplication. |
| Define policies for using third-party tools and data | ▪ *Set controls for third-party tools.* A vetting process for third-party tools safeguards against security, compliance, and alignment risks. Policies should include guidelines for data privacy, security, and ethical standards when using external datasets.<br><br> ▪ *Define data sensitivity standards.* Keeping sensitive and public data separate is essential for mitigating AI risks. Create policies around data handling and separation.<br><br> ▪ *Define data quality standards.* A "golden dataset" provides a reliable benchmark for AI model testing and evaluation. Establish clear policies for data consistency and quality to ensure high performance and trustworthy outputs. |
| Define policies for maintaining and monitoring models | ▪ *Specify retraining frequency by use case.* Frequent retraining supports accuracy for high-risk AI workloads. Define guidelines that consider the use case and risk level of each model, especially for sectors like healthcare and finance.<br><br> ▪ *Monitor for performance degradation.* Monitoring model performance over time helps detect issues before they affect outcomes. Document benchmarks, and if a model’s performance declines, initiate a retraining or review process. |
| Define policies for regulatory compliance     | ▪ *Comply with regional legal requirements.* Understanding regional laws ensures AI operations remain compliant across locations. Research applicable regulations for each deployment area, such as data privacy laws, ethical standards, and industry regulations.<br><br> ▪ *Develop region-specific policies.* Tailoring AI policies to regional considerations supports compliance with local standards. Policies might include language support, data storage protocols, and cultural adaptations.<br><br> ▪ *Adapt AI for regional variability.* Flexibility in AI workloads allows for location-specific functionality adjustments. For global operations, document region-specific adaptations like localized training data and feature restrictions. |
| Define policies for user conduct              | ▪ *Define risk mitigation strategies for misuse.* Misuse prevention policies help protect against intentional or unintentional harms. Outline possible misuse scenarios and incorporate controls, such as restricted functionalities or misuse detection features.<br><br> ▪ *Set user conduct guidelines.* User agreements clarify acceptable behaviors when interacting with the AI workload, reducing the risk of misuse. Draft clear terms of use to communicate standards and support responsible AI interaction. |
| Define policies for AI integration and replacement | ▪ *Outline integration policies.* Integration guidelines ensure AI workloads maintain data integrity and security during workload interfacing. Specify technical requirements, data-sharing protocols, and security measures.<br><br> ▪ *Plan for transition and replacement.* Transition policies provide structure when replacing old processes with AI workloads. Outline steps for phasing out legacy processes, training staff, and monitoring performance throughout the change. |

## Enforce AI governance policies

The enforcement of your AI governance policies maintains consistent and ethical AI practices across your organization. You should use automated tools and manual interventions ensure policy adherence across all AI deployments. Here's how:

1. **Automate policy enforcement where possible.** Automated enforcement reduces human error and ensures consistent policy application across all AI deployments. Automation provides real-time monitoring and immediate response to policy violations, which manual processes cannot match effectively. Use platforms like Azure Policy and Microsoft Purview to enforce policies automatically across AI deployments, and regularly assess areas where automation can improve policy adherence.

2. **Manually enforce AI policies where automation is insufficient.** Manual enforcement addresses complex scenarios that require human judgment and provides essential training for policy awareness. Human oversight ensures policies adapt to unique situations and maintains organizational understanding of AI governance principles. Provide AI risk and compliance training for employees to ensure they understand their role in AI governance, conduct regular workshops to keep staff updated on AI policies, and perform periodic audits to monitor adherence and identify areas for improvement.

3. **Use workload-specific governance guidance for targeted enforcement.** Workload-specific guidance addresses unique security and compliance requirements for different AI deployment patterns. This approach ensures policies align with the technical architecture and risk profile of each AI workload type. Use detailed security guidance available for AI workloads on Azure platform services (PaaS) and Azure infrastructure (IaaS) to govern AI models, resources, and data within these workload types.

    - [Govern PaaS AI](./platform/governance.md)
    - [Govern IaaS AI](./infrastructure/governance.md)

## Monitor AI organizational risks

Risk monitoring identifies emerging threats and ensures AI workloads operate as intended. Continuous evaluation maintains system reliability and prevents negative impacts. You must establish systematic monitoring to adapt to evolving conditions and address risks before they affect operations. Here's how:

1. **Establish procedures for ongoing risk evaluation.** Regular risk evaluations provide early detection of emerging threats and system degradation. You must create structured review processes that engage stakeholders from across your organization to assess broader AI impacts and maintain comprehensive risk awareness. Schedule quarterly risk assessments for high-risk AI workloads and annual assessments for lower-risk systems, and develop response plans that outline specific actions for different risk scenarios to enable rapid mitigation when issues arise.

2. **Develop a comprehensive measurement plan.** A structured measurement plan ensures consistent data collection and analysis across all AI workloads. You must define clear data collection methods that combine automated logging for operational metrics with surveys and interviews for qualitative feedback from users and stakeholders. Establish measurement frequency based on workload risk levels, focusing monitoring efforts on high-risk areas, and create feedback loops that use measurement results to refine risk assessments and improve monitoring processes.

3. **Quantify and qualify AI risks systematically.** Balanced risk measurement requires both quantitative metrics and qualitative indicators that align with each workload's specific purpose and risk profile. You must select appropriate quantitative metrics such as error rates, accuracy scores, and performance benchmarks alongside qualitative indicators including user feedback, ethical concerns, and stakeholder satisfaction. Benchmark performance against industry standards and regulatory requirements to track AI trustworthiness, effectiveness, and compliance over time.

4. **Document and report measurement outcomes consistently.** Systematic documentation and reporting enhance transparency and support informed decision-making across your organization. You must create standardized reports that summarize key metrics, significant findings, and any anomalies detected during monitoring activities. Share these insights with relevant stakeholders through regular briefings and use findings to refine risk mitigation strategies, update governance policies, and improve future AI deployments.

5. **Establish independent review processes.** Independent reviews provide objective assessments that internal teams might miss due to familiarity or bias. You must implement regular independent reviews using external auditors or uninvolved internal reviewers who can assess AI risks and compliance objectively. Use review findings to identify blind spots in your risk assessments, strengthen governance policies, and validate the effectiveness of your current monitoring approaches.

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
