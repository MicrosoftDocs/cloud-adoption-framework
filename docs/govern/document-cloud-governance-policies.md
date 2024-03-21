---
title: Document cloud governance policies
description: Explore the essentials of documenting effective cloud governance policies within Microsoft's Azure Govern methodology. This guide provides step-by-step instructions on creating a robust governance framework to mitigate risks and maintain cloud governance with best practices and examples.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/05/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Document cloud governance policies

This article shows you how to document cloud governance policies. Cloud governance policies specify what should or shouldn't happen in the cloud. The cloud governance team should create one or more cloud governance policies for each risk identified in the risk assessment. Cloud governance policies are the governance framework for individuals interacting with the cloud.

:::image type="content" source="./_images/document.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./_images/document.svg" border="false":::

## Define an approach to documenting cloud governance policies

Establish an approach for creating, maintaining, and updating the rules and guidelines that govern the use of cloud services. The goal is to produce cloud governance policies that don’t require frequent updates and consider the effects of cloud governance policies across the cloud environment. To define a policy documentation approach, follow these recommendations:

- *Define standard governance language.* Develop a standard structure and format for documenting cloud governance policies. The policies must be a clear and authoritative reference for stakeholders.

- *Recognize the different scopes of governance.* Define and assign specific governance responsibilities tailored to the unique roles within your organization. For example, a developer governs application code. A workload team is responsible for a single workload, and the platform team is responsible for governance that workloads inherit.

- *Evaluate the broad effects of cloud governance.* Cloud governance creates friction. Find a balance between friction and freedom. Consider the effects of governance on workload architecture, software development practices, and other areas as you develop cloud governance policies. For example, what you allow or disallow determines workload architecture and affects software development practices.

## Define cloud governance policies

Create cloud governance policies that outline how to use and manage the cloud to mitigate risks. Create a governance framework that manages risk. Minimize the need for frequent policy updates. To define cloud governance policies, follow these recommendations:

- *Use a policy ID*. Use the policy category and a number to uniquely identify each policy, such as SC01 for the first security governance policy.

- *Include the policy statement.* Craft specific policy statements that address identified risks. Use definitive language such as *must*, *should*, *must not*, and *shouldn't*. Use the enforcement controls from the risk list as a starting point. Focus on outcomes rather than configuration steps. Name the tool required for enforcement so you know where to monitor compliance.

- *Include risk ID.* List the risk in the policy. Associate every governance policy to a risk.

- *Include the policy category.* Include governance categories, such as security, compliance, cost management, into the policy categorization. Categories help with sorting, filtering, and finding cloud governance policies.

- *Include policy purpose*. State the purpose of each policy. Use the risk or the regulatory compliance requirement the policy satisfies as a starting point.

- *Define the policy scope*. Clearly define what and who this policy applies to, such as all cloud services, regions, environments, and workloads. Specify any exceptions to ensure there's no ambiguity. Use standardized language so it's easy to sort, filter, and find policies.

- *Include the policy remediation strategies.* Define the desired response to a violation of a cloud governance policy. Tailor responses to the severity of the risk, such as scheduling discussions for nonproduction violations and immediate remediation efforts for production violations.

For more information, see the [example cloud governance policies](#example-cloud-governance-policies).

## Distribute cloud governance policies

Grant access to everyone who needs to adhere to cloud governance policies. Look for ways to make adherence to the cloud governance policies easier for people in your organization. To distribute cloud governance policies, follow these recommendations:

- *Use a centralized policy repository.* Use a centralized, easily accessible repository for all governance documentation. Ensure all stakeholders, teams, and individuals have access to the latest versions of policies and related documents.

- *Create compliance checklists*. Provide a quick and actionable overview of the policies. Make it easier for teams to comply without having to navigate through extensive documentation. For more information, see the [example compliance checklist](./enforce-cloud-governance-policies.md#example-cloud-governance-compliance-checklists).

## Review cloud governance policies

Assess and update cloud governance policies to ensure they remain relevant and effective in governing cloud environments. Regular review helps ensure cloud governance policies align with changing regulatory requirements, new technologies, and evolving business objectives. When you review policies, consider the following recommendations:

- *Implement feedback mechanisms.* Establish ways to receive feedback on the effectiveness of cloud governance policies. Gather input from the individuals affected by the policies to ensure they can still do their job efficiently. Update governance policies to reflect practical challenges and needs.

- *Establish event-based reviews*. Review and update cloud governance policies in responses to events, such as a failed governance policy, technology change, or regulatory compliance change.

- *Schedule regular reviews.* Regularly review governance policies to ensure they align with evolving organizational needs, risks, and cloud advancements. For example, include governance reviews in the regular cloud governance meetings with stakeholders.

- *Facilitate change control.* Include a process for policy review and updates. Ensure the cloud governance policies stay aligned with organizational, regulatory, and technological changes. Make it clear how to edit, remove, or add policies.

- *Fix cloud governance inefficiencies.* Review governance policies to find and fix inefficiencies in cloud architecture and operations. For example, instead of mandating that each team must use their own web application firewall, you could update the policy to require the use of a centralized firewall.

## Example cloud governance policies

The following cloud governance policies are examples for reference. These policies are based on the examples in the [example risk list](./assess-cloud-risks.md#example-risk-list).

| Policy ID | Policy Category | Risk ID | Policy Statement | Purpose | Scope | Remediation | Monitoring |
|-----------|-----------------|---------|------------------|---------|-------|-------------| ---------- |
| RC01 | Regulatory compliance | [R01](assess-cloud-risks.md#example-risk-list) | Microsoft Purview must be used to monitor sensitive data. | Regulatory compliance | Workload teams. Platform team | Immediate action by affected team. Compliance training | Microsoft Purview |
| RC02 | Regulatory compliance | [R01](assess-cloud-risks.md#example-risk-list) | Daily sensitive data compliance reports must be generated from Microsoft Purview. | Regulatory compliance | Workload teams. Platform team | Resolution within one day, confirmation audit | Microsoft Purview |
| SC01 | Security | [R02](assess-cloud-risks.md#example-risk-list) | Multifactor authentication (MFA) must be enabled for all users | Mitigate data breaches and unauthorized access | Azure users | Revoke user access | Microsoft Entra ID Conditional Access |
| SC02 | Security | [R02](assess-cloud-risks.md#example-risk-list) | Access reviews must be conducted monthly in Microsoft Entra ID Governance | Ensure data and service integrity | Azure users | Immediate access revocation for noncompliance | Microsoft Entra ID Governance |
| SC03 | Security | [R03](assess-cloud-risks.md#example-risk-list) | Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code | Ensure secure and centralized management of code repositories | Development teams | Transfer of unauthorized repositories to the specified GitHub organization and potential disciplinary actions for noncompliance | GitHub audit log |
| SC04 | Security | [R03](assess-cloud-risks.md#example-risk-list) | Teams utilizing libraries from public sources must adopt the quarantine pattern | Ensure libraries are safe and compliant before integration into the development process | Development teams | Removal of noncompliant libraries and review of integration practices for affected projects | Manual audit (monthly) |
| CM01 | Cost Management | [R04](assess-cloud-risks.md#example-risk-list) | Workload teams must set budgets alerts at the resource group level | Prevent overspending | Workload teams. Platform team | Immediate reviews, adjustments for alerts | Azure Cost Management |
| CM02 | Cost Management | [R04](assess-cloud-risks.md#example-risk-list) | Azure Advisor cost recommendations must be reviewed | Optimize cloud usage | Workload teams. Platform team | Mandatory optimization audits after 60 days | Azure Advisor |
| OP01 | Operations | [R05](assess-cloud-risks.md#example-risk-list) | Production workloads should have an active-passive architecture across regions | Ensure service continuity | Workload teams | Architecture evaluations, biannual reviews | Manual audit (per production release) |
| OP02 | Operations | [R05](assess-cloud-risks.md#example-risk-list) | All mission-critical workloads must implement a cross-region active-active architecture | Ensure service continuity | Mission-critical workload teams | Updates within 90 days, progress reviews | Manual audit (per production release) |
| DG01 | Data | [R06](assess-cloud-risks.md#example-risk-list) | Encryption in transit and at rest must be applied to all sensitive data | Protect sensitive data | Workload team | Immediate encryption enforcement and security training | Azure Policy |
| DG02 | Data | [R06](assess-cloud-risks.md#example-risk-list) | Data lifecycle policies must be enabled in Microsoft Purview for all sensitive data | Manage data lifecycle | Workload team | Implementation within 60 days, quarterly audits | Microsoft Purview |
| RM01 | Resource management | [R07](assess-cloud-risks.md#example-risk-list) | Bicep must be used to deploy resources | Standardize resource provisioning | Workload team. Platform team | Immediate Bicep transition plan | CI/CD pipeline |
| RM02 | Resource management | [R07](assess-cloud-risks.md#example-risk-list) | Tags must be enforced all cloud resources using Azure Policy | Facilitate resource tracking | All cloud resources | Correct tagging within 30 days | Azure Policy |
| AI01 | AI | [R08](assess-cloud-risks.md#example-risk-list) | AI content filtering configuration must be reviewed monthly. | Mitigate AI harmful outputs | Workload teams. | Immediate corrective measures | Azure OpenAI |
| AI02 | AI | [R08](assess-cloud-risks.md#example-risk-list) | Customer-facing AI systems must be red-teamed monthly. | Identify AI biases | AI model teams | Immediate review, corrective actions for misses | Manual audit (monthly) |

## Next step

> [!div class="nextstepaction"]
> [Enforce cloud governance policies](enforce-cloud-governance-policies.md)
