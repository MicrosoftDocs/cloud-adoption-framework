---
title: Document cloud governance policies
description: Learn how to document governance policies for the cloud. Base cloud governance policies on the risks.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Document cloud governance policies

This article shows you how to document cloud governance policies. Cloud governance policies specify what should or should not happen in the cloud. The cloud governance team should create one or more cloud governance policies for each identified risk. Cloud governance policies are the governance framework for those interacting with the cloud.

<img src="c:\GitHub\cloud-adoption-framework-pr\docs\govern/media/image4.png" style="width:6.5in;height:0.87708in" alt="A blue rectangle with white text Description automatically generated" />

## Define an approach to documenting cloud governance policies

Establish an approach for creating, maintaining, and updating the rules and guidelines that govern the use of cloud services. The goal is to produce cloud governance policies that don’t require frequent updates and consider the effects of cloud governance policies across the cloud environment. To define an approach, follow these recommendations:

- *Define standard governance language.* Develop a standard structure and format for documenting cloud governance policies so it serves as a clear and authoritative reference for stakeholders.

<!-- -->

- *Recognize the different scopes of governance.* Define and assign specific governance responsibilities tailored to the unique roles within your organization. For example, a developer governs application code. A workload team is responsible for a single workload, and the platform team is responsible for governance that workloads inherit.

- *Evaluate the broad effects of cloud governance.* Cloud governance creates friction. Find a balance between friction and freedom. Consider workload architecture, software development practices, and other areas as you develop cloud governance policies. For example, what you allow or disallow determines workload architecture and affects software development practices.

## Define cloud governance policies

Create cloud governance policies that outline how to use and manage the cloud to mitigate risks. Create a governance framework that manages risk. Minimize the need for frequent policy updates. Follow these recommendations:

- *Use a policy ID*. Use the policy category and a number to uniquely identify each policy, such as SC01 for the first security governance policy.

- *Include the policy statement.* Craft specific policy statements that address identified risks. Use definitive language such as “must” and “should”. Use the enforcement controls from the risk list as a starting point. Focus on outcomes rather than configuration steps. Name the tool required for enforcement so you know where to monitor compliance.

- *Include risk ID.* List the risk in the policy. Associate every governance policy to a risk.

- *Include the policy category.* Include governance categories, such as security, compliance, cost management, into the policy categorization. It helps with sorting, filtering, and searching policies.

- *Include policy purpose*. State the purpose of each policy, such as a restatement of the risk or the regulatory compliance requirement the policy satisfies.

- *Define the policy scope*. Clearly define what and who this policy applies to, such as all cloud services, regions, environments, and workloads. Specify any exceptions to ensure there's no ambiguity.

- *Include the policy remediation strategies.* Define the desired response to a violation of a cloud governance policy. Tailor responses to the severity of the risk, such as scheduling discussions for non-production violations and immediate remediation efforts for production violations.

For more information, see [Example policies](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Example_policies).

## Distribute cloud governance policies

Grant access to everyone who needs to adhere to cloud governance policies. Look for ways to make adherence to the cloud governance policies easier for people in your organization. To disseminate policies, follow these recommendations:

- *Use a centralized policy repository.* Use a centralized, easily accessible repository for all governance documentation. Ensure all stakeholders have access to the latest versions of policies and related documents.

- *Create compliance checklists*. Provide a quick and actionable overview of the policies, making it easier for teams to comply without having to navigate through extensive documentation. For more information, see [Compliance checklist examples](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Governance_policy_checklists)*.*

## Review cloud governance policies

Assess and update cloud governance policies to ensure they remain relevant and effective in governing cloud environments. It helps maintain their alignment with evolving regulatory requirements, technological advancements, and organizational objectives. Consider the following recommendations:

1.  *Implement feedback mechanisms.* Establish ways to receive feedback on the effectiveness of cloud governance policies. Gather input from those affected by the policies to ensure they can still do their job efficiently. Update governance policies to reflect practical challenges and needs.

2.  *Establish event-based reviews*. Review and update cloud governance policies in responses to events, such as a failed governance policy, technology change, or regulatory compliance change.

3.  *Schedule regular reviews.* Regularly review governance policies to ensure they align with evolving organizational needs, risks, and cloud advancements. For example, include governance reviews in the regular cloud governance meetings with stakeholders.

4.  *Facilitate change control.* Include a process for policy review and updates. Ensure the cloud governance policies stay aligned with organizational, regulatory, and technological changes. Make it clear how to edit, remove, or add policies.

5.  *Fix cloud governance inefficiencies.* Review governance policies to find and fix inefficiencies in cloud architecture and operations. For example, instead of mandating that each team must use their own web application firewall, you could update the policy to require the use of a centralized firewall.

## Next step

The next step is to [enforce cloud governance policies](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Enforce_cloud_governance).

## Examples: Cloud governance policies for Azure

The following cloud governance policies are examples for reference. These policies are based on the examples in the [example risk list](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Risk_register_example_1) and align with the structure outlined above.

### Example regulatory compliance policies

Policy ID: RC01

- Policy category: Regulatory compliance

- Risk ID: R01

- Policy statement: Microsoft Purview must be used to enforce GDPR.

- Purpose: GDPR compliance

- Scope: Workload teams. Platform team

- Remediation: Immediate action by affected team. Compliance training

Policy ID: RC02

- Policy category: Regulatory compliance

- Risk ID: R01

- Policy statement: Daily GDPR compliance reports must be generated from Microsoft Purview.

- Purpose: GDPR compliance

- Scope: Workload teams. Platform team

- Remediation: Resolution within one day, confirmation audit

### Example security policies

Policy ID: SC01

- Policy category: Security

- Risk ID: R02

- Policy statement: Multi-Factor Authentication (MFA) must be enabled for all users

- Purpose: Mitigate data breaches and unauthorized access

- Scope: Azure users

- Remediation: Revoke user access

Policy ID: SC02

- Policy category: Security

- Risk ID: R02

- Policy statement: Access reviews must be conducted monthly in Entra ID Governance

- Purpose: Ensure data and service integrity

- Scope: Azure users

- Remediation: Immediate access revocation for non-compliance

Policy ID: SC03

- Policy category: Security

- Risk ID: R02

- Policy statement: Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code

- Purpose: Ensure secure and centralized management of code repositories

- Scope: Development teams

- Remediation: Transfer of unauthorized repositories to the specified GitHub organization and potential disciplinary actions for non-compliance

Policy ID: SC04

- Policy category: Security

- Risk ID: R02

- Policy statement: Teams utilizing third-party libraries from public sources must adopt the quarantine pattern

- Purpose: Ensure third-party libraries are safe and compliant before integration into the development process

- Scope: Development teams

- Remediation: Removal of non-compliant libraries and review of integration practices for affected projects

### Example operations governance policies

Policy ID: OP01

- Policy category: Operations

- Risk ID: R04

- Policy statement: Production workloads should have an active-passive architecture across regions

- Purpose: Ensure service continuity

- Scope: Workload teams

- Remediation: Architecture evaluations, biannual reviews

Policy ID: OP02

- Policy category: Operations

- Risk ID: R04

- Policy statement: All mission-critical workloads must implement a cross-region active-active architecture

- Purpose: Ensure service continuity

- Scope: Mission-critical workload teams

- Remediation: Updates within 90 days, progress reviews

### Example cost management policies

Policy ID: CM01

- Policy category: Cost Management

- Risk ID: R03

- Policy statement: Workload teams must set budgets alerts at the resource group level

- Purpose: Prevent overspending

- Scope: Workload teams. Platform team

- Remediation: Immediate reviews, adjustments for alerts

Policy ID: CM02

- Policy category: Cost Management

- Risk ID: R03

- Policy statement: Azure Advisor cost recommendations must be reviewed

- Purpose: Optimize cloud usage

- Scope: Workload teams. Platform team

<!-- -->

- Remediation: Mandatory optimization audits after 60 days

### Example data governance policies

Policy ID: DG01

- Policy category: Data

- Risk ID: R05

- Policy statement: Encryption in transit and at rest must be applied to all sensitive data

- Purpose: Protect sensitive data

- Scope: Workload team

- Remediation: Immediate encryption enforcement and security training

Policy ID: DG02

- Policy category: Data

- Risk ID: R05

- Policy statement: Data lifecycle policies must be enabled for all sensitive data

- Purpose: Manage data lifecycle

- Scope: Workload team

<!-- -->

- Remediation: Implementation within 60 days, quarterly audits

### Example resource management policies

Policy ID: RM01

- Policy category: Resource management

- Risk ID: R06

- Policy statement: Bicep must be used to deploy resources

- Purpose: Standardize resource provisioning

- Scope: Workload team. Platform team

- Remediation: Immediate Bicep transition plan

Policy ID: RM02

- Policy category: Resource management

- Risk ID: R06

- Policy statement: Tags must be enforced all cloud resources using Azure Policy

- Purpose: Facilitate resource tracking

- Scope: All cloud resources

<!-- -->

- Remediation: Correct tagging within 30 days

### Example AI governance policies

Policy ID: AI01

- Policy category: AI

- Risk ID: R07

- Policy statement: AI bias detection and mitigation in Azure OpenAI must be used.

- Purpose: Mitigate AI bias

- Scope: Workload teams.

- Remediation: Immediate corrective measures

Policy ID: AI02

- Policy category: AI

- Risk ID: R07

- Policy statement: Customer-facing AI systems must be red-teamed monthly.

- Purpose: Identify AI biases

- Scope: AI model teams

- Remediation: Immediate review, corrective actions for misses


> [!div class="nextstepaction"]
> [Enforce cloud governance policies](enforce-cloud-governance-policies.md)
