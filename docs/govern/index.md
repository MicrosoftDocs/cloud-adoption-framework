---
title: Cloud governance
description: Learn how to establish governance in the cloud
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Overview

ADD CONTENT TO THIS FILE WHERE APPROPRIATE

Definition of governance: Governance refers to the establishment of policies within an organization to minimize risk. Governance in an organization serves to define its objectives, shape the organization’s culture, ensure compliance with laws, regulations, and standards, hold management accountable for their actions and decisions, and provide a structure for decision-making and control. 


## Why govern?

Governance acts as a system of protective barriers, ensuring risk management across all operations. Its primary function is to create a balanced framework that allows for autonomous decision-making within safe limits. It safeguards the organization against both accidental and deliberate internal or external threats by ensureing that stakeholder needs, conditions and options are evaluated to determine:
• balanced, agreed-on enterprise objectives to be achieved
• setting direction through prioritization and decision making
• and monitoring performance and compliance against agreed-on direction and objectives

## Cloud Governance principles
... be addressed early to ensure the successful use of the cloud within the enterprise.

... be configured when possible. Human behavior is controlled when proper guardrails are applied.

... evolve. Cloud governance is an iterative process. It must constantly be evaluated and strengthened.

## Governance MVG - Minimum Viable Governance (MVG) Approach – getting started

- Governance can be large and complex leading to slow cloud adoption.
- To overcome this challenge, organizations shall introduce a Minimum Viable Governance (MVG) approach for governance using agile methodologies.
- MVG involves creating a ‘simplified’ version of the overarching Cloud Governance with the minimum process, capabilities and functionalities required to address a core problem or deliver value to users.
- Incremental governance relies on a small set of corporate policies, processes, and tools to establish a foundation for adoption and governance.
- The foundation is called a minimum viable governance (MVG).
- An MVG allows the governance team to quickly incorporate governance into implementations throughout the adoption lifecycle.
- By levaraging for instance Azure Devops capabilites, governance activies can be easily linked to agile working styles within in an organization  and make it actionable by directly linking governance policies to code in a repository (e.g Azure Policies)

## Possible elements of a Governance Model are:
- Clearly defined Roles & Bodies/Boards
- Essential Governance Tasks & Responsibilities -> RACI Matrix
- Detailed Process description (e.g. Swim lane diagrams)
- Detailed Work Instructions or Operation procedures

Usual Outcome of a Governance model:
- Written Governance (Collection of policies) as items availables in (e.g. Wikis, Azure DevOps) for all Stakeholder
- Technical controls (e.g. Azure Policies)

## How to govern

![Cloud governance process](./_images/govern-process.svg)

## Govern inputs and outputs

| Name of input/output  | Input/output | Govern phase | Description how to make it and how to use it |
| --- | --- | --- | --- |
| Cloud strategy | input | Build a governance team | The cloud strategy sets the direction for an organization's cloud adoption and outlines the objective to be achieved. Cloud governance is the cornerstone of a successful cloud strategy because it ensures that the cloud use supports your business objectives and requirements. Therefore, organizations should consider the cloud strategy as a key input to direct risk management efforts towards achieving its goals.|
| Cloud governance RACI | output | Build a governance team | A Governance RACI (Responsible, Accountable, Consulted, Informed) is a tool used to clarify the roles and responsibilities of various stakeholders in a cloud governance team. The RACI matrix is a responsibility assignment chart that maps out every task, actividad, or key decision involved in completing a cloud governance function.|
| Business risks | input | Quantify risk | A crucial governance activity for any organization is to identify and understand corporate risks and translate them into policy statements that support any compliance requirements. Organizations must have the ability to continually identify and manage evolving business risks to create the necessary corporate cloud policies to avoid or mitigate them. |
| Legal, compliance, regulatory requirements | input | Quantify risk | Legal, compliance, and regulatory requirements are essential for cloud governance as they help ensure that cloud usage supports business objectives, mitigates risks, enhances compliance readiness, avoids penalties, and adheres to laws. These requirements will depend on industry-specific regulations, size of the organization, geographical location, nature of business operations, etc. For instance, a healthcare organization operating in the European Union (EU) might have data residency requirements due to the General Data Protection Regulation (GDPR). In this case, the organization’s cloud governance should ensure that patient data is stored within the EU, is protected by adequate security measures, is only accessible by authorized personnel, and is used in a manner that complies with GDPR requirements. Organizations must have the ability to identify and translate those requirements into the cloud governance framework ensuring the proper controls are in place to comply with such requirements.|
| Cloud governance compliance reports | input | Quantify risk | Cloud Governance Compliance Reports are documents that provide an assessment of an organization’s adherence to its stated cloud governance policies and procedures. For example, Microsoft Entra Reports generated to identify unusual activity and unauthorized access to data, Azure Policy compliance with external regulations and certifications, Exchange online audit reports, device compliance reports, etc |
| Governance, risk and vulnerability assessments | input | Quantify risk | Governance, risk, and vulnerability assessments are crucial for managing risk, ensuring continuity, and communicating objectives. They identify governance and security gaps, provide remediation recommendations, and help maintain and enhance governance and security posture over time. They focus on key organizational matters and aid in compliance reporting. |
| Risk register | output | Quantify risk | Risk register is a risk management tool used to identify and document potential risks that could affect a program, project or business operations. For those organizations that use risk register, it is recommended that it be utilized as an input for cloud governance for delevoping effective cloud policies to ensure business risk consistency and mitigation. |
| Business risks identified | output | Quantify risk | Business risks are those potential threats or vulnerabilities that could impact an organization’s operations or data security in the cloud such as data breach, service disruption, cost overun, compliance risks, etc. A minimum viable product (MVP) is commonly used to define the smallest unit of something that can produce tangible value. A business risk MVP is the starting point for your initial cloud adoption efforts, governance can mature in parallel with your increasing use of cloud resources. The following are a few basic examples of business risks that can be included as part of an MVP: All assets are at risk of being deleted (through error, mistake or maintenance). All assets are at risk of generating too much spending. - All assets could be compromised by weak passwords or insecure settings. Any asset with open ports exposed to the internet are at risk of compromise. |
| Risk register updated | output | Quantify risk | For those organizations that use risk register, the history and status of risks may be updated after performing risk analysis, evaluation and treatment |
| Business risks identified | input | Document governance policies | Previously identified business risks should be taken into account to identify and document the cloud policies that are necessary to mitigate or eliminate them. |
| Risk register updated | input | Document governance policies | The current state of business risks may be reflected in the risk register where appropriate. If this is the case, it must be taken into account as a source of information to identify and document the required cloud policies.|
| New/updated cloud corporate policies identified & documented | output | Document governance policies | Policies must be designed to define the necessary steps to remediate the risks where possible. It is recommended that they be duly documented and communicated. Each organization is unique and registers its policies according to its needs, but commonly cloud policies can be attached to Information Security Standards documents or any other IT standard or regulatory document accesible by all relevant stakeholders. |
| Tolerance indicators and metrics identified | output | Document governance policies | The tolerance levels for each risk that triggers a corporate policy must be defined. Tolerance to these risks is specific to each organization. Likewise, the metrics associated with the tolerance indicator must be identified to set which measurement or calculation will be monitored to take a remediation action. For example, if the businees risks is "Overprovisioned resources", a valid tolerance indicator is " VM's CPU utilization under 20% for 7 days" so the related metric in this case is "CPU utilization". When the previously defined criterion is met, the cloud policy "All overprovisioned resources must be scaled down" will be triggered. Finally, using autoscaling by Azure policy is one way to ultimately automate a remediation action.  |
| New/updated cloud corporate policies documented | input | Implement governance | Previously identified and documented cloud policies must be implemented to perform necessary risk remediation tasks. |
| Tolerance indicators, metrics and policy design options identified | input | Implement governance | Previously defined tolerance indicators and metrics must be implemented to effectively trigger the defined cloud policies. |
| New/updated cloud corporate policies automated when possible | output | Implement governance | Cloud corporate policies should be finally implemented in the cloud platform. Automating cloud policies is very important for efficiency, consistency, real-time compliance monitoring and human-error reduction in managing cloud environments. |
| Cloud corporate policies adherence monitoring | input | Measure governance | After you've defined your compliance violation triggers and actions, you can start planning how best to use the logging and reporting tools and other features of the cloud platform to help automate your monitoring and policy compliance strategy |
| Governance, risk and vulnerability assessments  | input | Measure governance | Governance, Risk, and Vulnerability Assessments are important because they identify potential risks, ensure compliance, and provide insights for improving security, thereby enhancing the overall cloud governance posture.  |
| Cloud governance compliance reports | output | Measure governance | The cloud governance team should create and evaluate compliance reports to identify adherence and potential deviations to the organization’s stated cloud policies and procedures. The results of these reports will be used to identify and quantify new risks, starting a new iteration of cloud governance processes |
| Governance, risk and vulnerability assessments performed | output | Measure governance | Once assessments are executed they provide a comprehensive understanding of the organization's cloud environment. This enables the identification of new/evolving risks and vulnerabilities, risk mitigation strategies, improved security posture, compliance assurance and continuous improvement. |
| Governance workbook | output | Measure governance | The governance workbook is an Azure Monitor workbook that provides a comprehensive overview of the governance posture of your Azure environment. It includes the standard metrics aligned with the Cloud Adoption Framework for all disciplines and has the capability to identify and apply recommendations to address non-compliant resources. |
| add name | output | Measure governance | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |
| add name | add input/output | add govern phase | add DESCRIPTION |




## Prerequisites

