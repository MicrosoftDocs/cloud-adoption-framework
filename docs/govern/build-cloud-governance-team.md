---
title: Build a cloud governance team
description: Learn how to build a cloud governance team. Select the right members
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Build a cloud governance team 

This article shows you how to build a cloud governance team. A cloud governance team oversees cloud governance for the organization. This team is responsible for assessing risks, documenting cloud governance policies, and reporting on the progress of cloud governance. They need to understand the interest of the organization and ensure cloud governance policies minimize risks.

<img src="c:\GitHub\cloud-adoption-framework-pr\docs\govern/media/image2.png" style="width:6.5in;height:1.03333in" alt="A blue and white sign Description automatically generated" />

## Define the functions of the cloud governance team

Describe the duties and roles that the team needs to perform to implement the organization's cloud governance in an effective way. The team must define and enforce policies that govern the organization's interaction with cloud services and ensure a consistent approach across your cloud environment. To define these team functions, follow these essential functions:

- *Engage stakeholders.* The cloud governance team must actively engage stakeholders across the organization (IT, finance, operations, security, and compliance) to gather input on governance policies. The goal is to ensure the cloud meets the needs of the business and minimizes risk.

- *Assess cloud risks.* The cloud governance team must assess cloud risks regularly to identify risks and rank them by priority risks. They use or oversee the use of risk assessment tools to evaluate security, compliance, and operational risks, and communicate findings with stakeholders.

- *Develop and update governance policies*. The cloud governance team should regularly to review and update the cloud governance framework, as well as to discuss and resolve any issues or challenges that arise from cloud usage. Ensure policies are comprehensive, enforceable, and reflective of the latest cloud technologies and regulatory requirements.

- *Develop a cloud governance program*. The cloud governance team should design a cloud governance program to ensure cloud governance is successful in the organization. Create a communication plan to educate employees about their roles in upholding governance standards. Develop training materials, workshops, and documentation. Cover cloud governance adoption and change management for cloud governance policy Integrate governance training with employee onboarding.

- *Monitor and review governance.* Establish metrics to measure governance effectiveness and develop reporting methods, such as dashboards, to track compliance rates, incident response times, and user satisfaction.

## Select the members of the cloud governance team

Select the individuals responsible for overseeing and managing cloud governance within an organization. Recruiting members with the necessary skills helps ensure the team can efficiently enforce policies, manage risks, and comply with regulations in cloud operations. To select members of the cloud governance team, follow these recommendations:

- *Select a small team*. Pick a small team to encourage agility and quicker decision-making.

- *Select a diverse team.* The team should consist of individuals from different areas of the organization such as IT operations, security, finance, software development, cloud architecture, processes, and compliance.

- *Define team members’ responsibilities*. Define roles and responsibilities within your cloud governance team. Tailor them to your organization's size, complexity, and cloud maturity. Key areas of responsibility include cloud governance lead, cloud architecture, cloud security, cloud compliance, and [cloud finance](https://learn.microsoft.com/en-us/azure/cost-management-billing/finops/overview-finops).

## Define the authority of the cloud governance team

Empower the cloud governance team to implement and oversee cloud governance effectively. The goal is to ensure the cloud governance team has the legitimacy and support required to achieve the organization's cloud governance objectives efficiently. Follow these recommendations:

- *Secure executive sponsorship.* Gain support from and report to a named executive, such as the CIO or CTO, to back the cloud governance initiative with the necessary resources. The executive sponsor serves as a point of escalation for challenges and helps align cloud governance with organizational goals.

- *Establish authority levels.* The executive sponsor should define the team’s authority to define and enforce cloud governance throughout the organization.

- *Communicate authority.* The executive sponsor should communicate to the entire organization the governance team’s authority and the importance of adhering to governance policies they create.

## Define the scope of the cloud governance team

Establish the boundaries of the cloud governance team’s responsibility. The goal is to clarify areas of responsibility so the cloud governance team can focus on creating, monitoring, enforcing, and updating cloud governance policies. To define the scope, follow these recommendations:

- *Define relationship with other teams.* Clearly define the cloud governance team’s authority over cloud resources, services, and policies to avoid duplication of efforts with other teams.

- *Use a RACI matrix.* Use a Responsibility Assignment Matrix (RACI Matrix) to delineate roles and responsibilities within the cloud governance framework. See the [example cloud governance RACI matrix](#_Example:_Cloud_governance).

## Next step

The next step is to [assess cloud risks.](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Assess_cloud_risks) Assessing cloud risks involves identifying, analyzing, documenting, and communicating cloud risks.

> [!div class="nextstepaction"]
> [Assess cloud risks](assess-cloud-risks.md)

## Example: Cloud governance RACI matrix

The following is an example of a RACI matrix for cloud governance. Create a RACI matrix that aligns to your organization and meets your specific needs. Ensure the RACI matrix outlines the roles and responsibilities across different aspects of cloud governance.

| **Activity/Task**                    | **Cloud governance team** | **Executive sponsor** | **Cloud platform team** | **Workload teams** |
|--------------------------------------|---------------------------|-----------------------|-------------------------|--------------------|
| Engage stakeholders                  | R, A                      | I                     | C                       | C                  |
| Assess cloud risks                   | A                         | I                     | R                       | R                  |
| Develop & update governance policies | R, A                      | I                     | C                       | C                  |
| Report on cloud governance progress  | R, A                      | I                     | C                       | C                  |
| Cloud architecture planning          | A                         | I                     | R                       | R                  |
| Enforce governance policies          | A, C                      | I                     | R                       | R                  |
| Monitoring governance                | A, C                      | I                     | R                       | R                  |

- *Responsible (R):* The person or team doing the work to complete the task.

- *Accountable (A):* The person or group lead accountable for the task and approves the work. This person must approve completed tasks.

- *Consulted (C):* People or teams that people are subject matter experts or have specific insights into the task.

- *Informed (I):* Those who you kept up to date on progress, often only upon completion of the task or at major milestones.


