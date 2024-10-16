---
title: Govern AI – Recommendations for governing AI
description: Get recommendations for governing AI. Get recommendations for governing models, costs, security, operations, compliance, and data management.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Govern AI – Recommendations for governing AI

This guide offers recommendations for developing a strong AI governance framework at the business level. It follows the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf) and [NIST AI RMF Playbook](https://airc.nist.gov/AI_RMF_Knowledge_Base/Playbook). It also aligns with the governance practices defined in [CAF Govern](azure/cloud-adoption-framework/govern/). The goal is to create a unified governance approach that effectively manages AI risks by integrating AI risk management into broader enterprise risk management strategies. When you address AI risks alongside other risks, such as cybersecurity and privacy, it supports a more cohesive and efficient organizational outcome.

:::image type="content" source="./images/governai.svg" alt-text="Diagram showing the AI adoption framework process. It highlights Govern AI. The process with AI Strategy, AI Plan, AI Ready as sequential steps. Then Secure AI, Govern AI, and Manage AI are cyclical processes after AI Ready. Undergirding the entire process is Responsible AI." lightbox="./images/governai.svg" border="false":::

## Assess AI organizational risks

Assessing AI organizational risks involves identifying potential negative outcomes that AI technologies might introduce to your business. Proactively addressing these risks builds trust in AI workloads and ensures that AI enhances business operations without unintended negative consequences. Follow these recommendations:

- *Set Responsible AI principles as targets.* Microsoft's Responsible AI principles are a framework to assess and mitigate AI risks. These principles correspond to the characteristics of trustworthy AI in the NIST AI RMF. Use the definition and risk assessment question to identify AI risks in your business.

    | Responsible AI principle | Definition | Risk assessment question |
    |--------------------------|------------|--------------------------|
    | AI Privacy and Security| AI workloads should respect privacy and be secure. | How can the organization ensure AI workloads maintain privacy and security? |
    | Reliability and Safety | AI workloads should perform safely and reliably. | How can the organization guarantee reliable performance across diverse conditions and use cases? |
    | Fairness | AI workloads should treat people equitably. | How can the organization ensure AI distributes resources or information fairly? |
    | Inclusiveness| AI workloads should be inclusive and empowering. | How can AI workloads be designed to include and empower people of all abilities? |
    | Transparency | AI workloads should be understandable. | How can the organization ensure users understand and responsibly use AI workloads? |
    | Accountability | People should be accountable for AI workloads. | How can the organization establish oversight to ensure accountability and control? |

- *Understand the AI workloads.* By clarifying the scope and purpose of each workload, you can more easily map associated risks, such as potential biases or technical limitations that could lead to failures. This should include any assumptions and limitations related to the AI workload.

- *Identify AI risks.* Start by identifying baseline security risks to AI workloads. Assess whether your AI workloads are vulnerable to data breaches, unauthorized access, or misuse. Perform a context analysis to identify possible negative outcomes that could result from AI malfunctions or misuse. Consult external stakeholders and communities affected by the AI. Use their insights to identify risks that might not be visible. Assess both qualitative and quantitative costs, including nonmonetary impacts like reputational harm. Document these to evaluate the organization’s tolerance for such risks.

- *Identify risks from external dependencies.* Assess risks related to third-party data sources, software, and integrations across the business. These risks might include security vulnerabilities, bias, and intellectual property issues. Develop policies to manage external risks and ensure that third-party components align with the organization’s privacy and compliance standards. By addressing these risks proactively, your organization strengthens its AI governance framework and builds resilience for future AI adoption.

- *Assess integration risks.* Evaluate AI workloads integrate with existing workloads and processes. Document potential risks, such as dependency on other workloads, increased complexity, or incompatibilities that could impact functionality.

## Document AI governance policies

AI governance policies create a structured framework for responsible AI usage within an organization. These policies provide clear guidelines to align AI operations with ethical standards, regulatory requirements, and business goals. By establishing governance policies, businesses can control AI-related risks, enhance accountability, and foster trust among stakeholders.

### Define policies for selecting and onboard models

- *Establish policies for selecting AI models.* Policies should outline criteria for choosing models that meet organizational values, capabilities, and cost constraints. Review potential models for alignment with risk tolerance and intended task requirements.

- *Onboard new models with structured policies.* A formal process for model onboarding maintains consistency in model justification, validation, and approval. Use sandbox environments for initial experiments, then validate and review models in the production catalog to avoid duplication.

### Define policies for using third-party tools and data

- *Set controls for third-party tools.* A vetting process for third-party tools safeguards against security, compliance, and alignment risks. Policies should include guidelines for data privacy, security, and ethical standards when using external datasets.

- *Define data sensitivity standards.* Keeping sensitive and public data separate is essential for mitigating AI risks. Create policies around data handling and separation.

- *Define data quality standards.* A "golden dataset" provides a reliable benchmark for AI model testing and evaluation. Establish clear policies for data consistency and quality to ensure high performance and trustworthy outputs.

### Define policies for maintain and monitor models

- *Specify retraining frequency by use case.* Frequent retraining supports accuracy for high-risk AI workloads. Define guidelines that consider the use case and risk level of each model, especially for sectors like healthcare and finance.

- *Monitor for performance degradation.* Monitoring model performance over time helps detect issues before they affect outcomes. Document benchmarks, and if a model’s performance declines, initiate a retraining or review process.

### Define policies for regulatory compliance

- *Comply with regional legal requirements.* Understanding regional laws ensures AI operations remain compliant across locations. Research applicable regulations for each deployment area, such as data privacy laws, ethical standards, and industry regulations.

- *Develop region-specific policies.* Tailoring AI policies to regional considerations supports compliance with local standards. Policies might include language support, data storage protocols, and cultural adaptations.

- *Adapt AI for regional variability.* Flexibility in AI workloads allows for location-specific functionality adjustments. For global operations, document region-specific adaptations like localized training data and feature restrictions.

### Define policies for misuse and set user guidelines

- *Define risk mitigation strategies for misuse.* Misuse prevention policies help protect against intentional or unintentional harms. Outline possible misuse scenarios and incorporate controls, such as restricted functionalities or misuse detection features.

- *Set user conduct guidelines.* User agreements clarify acceptable behaviors when interacting with the AI workload, reducing the risk of misuse. Draft clear terms of use to communicate standards and support responsible AI interaction.

### Integrate AI and manage transitions

- *Outline integration policies.* Integration guidelines ensure AI workloads maintain data integrity and security during workload interfacing. Specify technical requirements, data-sharing protocols, and security measures.

- *Plan for transition and replacement.* Transition policies provide structure when replacing old processes with AI workloads. Outline steps for phasing out legacy processes, training staff, and monitoring performance throughout the change.

## Enforce AI policies

Enforcing AI policies helps an organization maintain consistent and ethical AI practices across its operations. Use automated means where possible. Use manual enforcement where automation has gaps. Effective enforcement eliminates all unapproved AI use.

- *Automate policy enforcement where possible* Use tools like Azure Policy and Microsoft Purview to enforce policies automatically across AI deployments. Automation reduces human error and ensures consistent workload of policies. Conduct regular assessments to identify areas where automation could be expanded, and prioritize automating the most critical compliance tasks.

- *Manually enforce AI policies.* Provide training for staff on AI risks, ethical considerations, and compliance requirements. Ensure that employees understand their role in upholding AI governance policies. Conduct regular workshops or refresher courses to keep staff informed of updates to AI policies and best practices in ethical AI deployment. Where automation is insufficient, actively communicate AI policies to relevant stakeholders, including team members and decision-makers. Implement periodic audits to monitor adherence to policies. Use audit findings to identify gaps, track compliance levels, and make adjustments to the policies or their enforcement as needed.

- *Use workload specific governance guidance.* There's detailed governance guidance for AI workloads on Azure platform services (PaaS) and Azure infrastructure (IaaS). Use this guidance for specific instructions on how to govern AI models, costs, and data withing those workload types.

    > [!div class="nextstepaction"]
    > [Govern PaaS AI workloads](./platform/resource-selection.md)
    
    > [!div class="nextstepaction"]
    > [Govern IaaS AI workloads](./infrastructure/compute.md)
    
## Monitor AI risks

Ongoing AI risk monitoring helps businesses continuously identify and address potential risks that might emerge over time. Established procedures for regular risk evaluation ensure that AI workloads operate as intended and adapt to changing conditions. Monitoring AI risks improves the organization’s ability to manage unforeseen challenges and maintain AI reliability.

- *Establish procedures for ongoing risk evaluation.* Ongoing evaluations help identify emerging risks and ensure AI workloads continue to operate as intended. Set up a schedule for regular reviews focused on performance, new risks, and updated risk assessments, engaging stakeholders to understand the AI’s broader impacts. When issues arise, have a response plan ready to reassess risks and make adjustments as necessary.

- *Develop risk-prevention procedures.* Proactive risk prevention reduces the chance of AI workload failures and associated costs. Regularly evaluate both qualitative and quantitative risks, and use these findings to guide deployment decisions throughout the AI lifecycle. Outline specific prevention, detection, and correction actions, updating them as new risks surface.

- *Implement tracking mechanisms for AI risks.* Effective risk tracking allows continuous monitoring of both known and emergent risks. Establish processes, personnel, and documentation to identify and monitor AI risks over time, particularly focusing on intended versus actual performance. In challenging settings, document limitations in tracking, and consider adding alternative methods.

- *Quantify and qualify AI risks.* A balanced approach to measurement provides a clearer understanding of the AI’s risk profile. Choose quantitative metrics (error rates, accuracy) and qualitative indicators (user feedback, ethical concerns) that align with the workload’s purpose. Benchmark performance against industry standards to track the AI’s impacts, trustworthiness, and performance.

- *Develop a measurement plan.* A clear measurement plan ensures consistent data collection and analysis. Define data collection methods, such as automated logging for operational metrics and surveys for qualitative feedback. Establish the frequency and scope of measurements, focusing on high-risk areas, and create feedback loops to refine risk assessments based on stakeholder input.

- *Monitor key trustworthiness characteristics.* Trustworthiness metrics help ensure AI workloads are reliable, secure, and respectful of privacy. Track performance metrics like accuracy and robustness, and monitor security risks to assess resilience to threats. Regularly evaluate data handling practices for privacy compliance, implementing privacy-enhancing technologies as needed.

- *Document and report measurement outcomes.* Regular documentation and reporting enhance transparency and accountability. Create standardized reports that summarize metrics, findings, and any anomalies to guide decision-making. Share these insights with stakeholders, using them to refine risk mitigation strategies and improve future deployments.

- *Establish independent review processes.* Independent reviews provide objective assessments of AI risks and compliance. Conduct periodic audits with external or uninvolved internal reviewers, and engage subject matter experts to interpret findings and offer more insights. Address any limitations in measurement methods, adjusting them to strengthen the overall risk assessment process.

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
