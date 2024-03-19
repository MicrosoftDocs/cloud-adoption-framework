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

For more information, see [Example cloud governance policies](#example-cloud-governance-policies).

## Distribute cloud governance policies

Grant access to everyone who needs to adhere to cloud governance policies. Look for ways to make adherence to the cloud governance policies easier for people in your organization. To distribute cloud governance policies, follow these recommendations:

- *Use a centralized policy repository.* Use a centralized, easily accessible repository for all governance documentation. Ensure all stakeholders, teams, and individuals have access to the latest versions of policies and related documents.

- *Create compliance checklists*. Provide a quick and actionable overview of the policies. Make it easier for teams to comply without having to navigate through extensive documentation. For more information, see [Compliance checklist examples](./enforce-cloud-governance-policies.md#examples-compliance-checklists).

## Review cloud governance policies

Assess and update cloud governance policies to ensure they remain relevant and effective in governing cloud environments. Regular review helps ensure cloud governance policies align with changing regulatory requirements, new technologies, and evolving business objectives. When you review policies, consider the following recommendations:

- *Implement feedback mechanisms.* Establish ways to receive feedback on the effectiveness of cloud governance policies. Gather input from the individuals affected by the policies to ensure they can still do their job efficiently. Update governance policies to reflect practical challenges and needs.

- *Establish event-based reviews*. Review and update cloud governance policies in responses to events, such as a failed governance policy, technology change, or regulatory compliance change.

- *Schedule regular reviews.* Regularly review governance policies to ensure they align with evolving organizational needs, risks, and cloud advancements. For example, include governance reviews in the regular cloud governance meetings with stakeholders.

- *Facilitate change control.* Include a process for policy review and updates. Ensure the cloud governance policies stay aligned with organizational, regulatory, and technological changes. Make it clear how to edit, remove, or add policies.

- *Fix cloud governance inefficiencies.* Review governance policies to find and fix inefficiencies in cloud architecture and operations. For example, instead of mandating that each team must use their own web application firewall, you could update the policy to require the use of a centralized firewall.

## Next step

Enforce cloud governance policies. Use automated and manual methods to enforce compliance with cloud governance policies.

> [!div class="nextstepaction"]
> [Enforce cloud governance policies](enforce-cloud-governance-policies.md)

## Example: Cloud governance policies

The following cloud governance policies are examples for reference. These policies are based on the examples in the [example risk list](./assess-cloud-risks.md#example-risk-list).

### Example cloud regulatory compliance governance policies

Policy ID: RC01

- Policy category: Regulatory compliance
- Risk ID: [R01](./assess-cloud-risks.md#example-regulatory-compliance-risk)
- Policy statement: Microsoft Purview must be used to monitor sensitive data
- Purpose: Data privacy compliance
- Scope: Workload teams. Platform team
- Remediation: Immediate action by affected team. Compliance training

Policy ID: RC02

- Policy category: Regulatory compliance
- Risk ID: [R01](./assess-cloud-risks.md#example-regulatory-compliance-risk)
- Policy statement: Daily sensitive data compliance reports must be generated from Microsoft Purview
- Purpose: Data privacy compliance
- Scope: Workload teams. Platform team
- Remediation: Resolution within one day, confirmation audit

### Example cloud security governance policies

Policy ID: SC01

- Policy category: Security
- Risk ID: [R02](./assess-cloud-risks.md#example-cloud-security-risks)
- Policy statement: Multifactor authentication (MFA) must be enabled for all users
- Purpose: Mitigate data breaches and unauthorized access
- Scope: Azure users
- Remediation: Revoke user access

Policy ID: SC02

- Policy category: Security
- Risk ID: [R02](./assess-cloud-risks.md#example-cloud-security-risks)
- Policy statement: Access reviews must be conducted monthly in Microsoft Entra ID Governance
- Purpose: Ensure data and service integrity
- Scope: Azure users
- Remediation: Immediate access revocation for noncompliance

Policy ID: SC03

- Policy category: Security
- Risk ID: [R03](./assess-cloud-risks.md#example-cloud-security-risks)
- Policy statement: Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code
- Purpose: Ensure secure and centralized management of code repositories
- Scope: Development teams
- Remediation: Transfer of unauthorized repositories to the specified GitHub organization and potential disciplinary actions for noncompliance

Policy ID: SC04

- Policy category: Security
- Risk ID: [R03](./assess-cloud-risks.md#example-cloud-security-risks)
- Policy statement: Teams utilizing libraries from public sources must adopt the quarantine pattern
- Purpose: Ensure libraries are safe and compliant before integration into the development process
- Scope: Development teams
- Remediation: Removal of noncompliant libraries and review of integration practices for affected projects

### Example cloud cost management policies

Policy ID: CM01

- Policy category: Cost management
- Risk ID: [R04](./assess-cloud-risks.md#example-cloud-cost-management-risk)
- Policy statement: Workload teams must set budgets alerts at the resource group level
- Purpose: Prevent overspending
- Scope: Workload teams. Platform team
- Remediation: Immediate reviews, adjustments for alerts

Policy ID: CM02

- Policy category: Cost management
- Risk ID: [R04](./assess-cloud-risks.md#example-cloud-cost-management-risk)
- Policy statement: Azure Advisor cost recommendations must be reviewed
- Purpose: Optimize cloud usage
- Scope: Workload teams. Platform team
- Remediation: Mandatory optimization audits after 60 days

### Example cloud operations governance policies

Policy ID: OP01

- Policy category: Operations
- Risk ID: [R05](./assess-cloud-risks.md#example-cloud-operations-risk)
- Policy statement: Production workloads should have an active-passive architecture across regions
- Purpose: Ensure service continuity
- Scope: Workload teams
- Remediation: Architecture evaluations, biannual reviews

Policy ID: OP02

- Policy category: Operations
- Risk ID: [R05](./assess-cloud-risks.md#example-cloud-operations-risk)
- Policy statement: All mission-critical workloads must implement a cross-region active-active architecture
- Purpose: Ensure service continuity
- Scope: Mission-critical workload teams
- Remediation: Updates within 90 days, progress reviews

### Example cloud data governance policies

Policy ID: DG01

- Policy category: Data
- Risk ID: [R06](./assess-cloud-risks.md#example-cloud-data-risk)
- Policy statement: Encryption in transit and at rest must be applied to all sensitive data
- Purpose: Protect sensitive data
- Scope: Workload team
- Remediation: Immediate encryption enforcement and security training

Policy ID: DG02

- Policy category: Data
- Risk ID: [R06](./assess-cloud-risks.md#example-cloud-data-risk)
- Policy statement: Data lifecycle policies must be enabled for all sensitive data
- Purpose: Manage data lifecycle
- Scope: Workload team
- Remediation: Implementation within 60 days, quarterly audits

### Example cloud resource management governance policies

Policy ID: RM01

- Policy category: Resource management
- Risk ID: [R07](./assess-cloud-risks.md#example-cloud-resource-management-risk)
- Policy statement: Bicep must be used to deploy resources
- Purpose: Standardize resource provisioning
- Scope: Workload team. Platform team
- Remediation: Immediate Bicep transition plan

Policy ID: RM02

- Policy category: Resource management
- Risk ID: [R07](./assess-cloud-risks.md#example-cloud-resource-management-risk)
- Policy statement: Tags must be enforced all cloud resources using Azure Policy
- Purpose: Facilitate resource tracking
- Scope: All cloud resources
- Remediation: Correct tagging within 30 days

### Example AI governance policies

Policy ID: AI01

- Policy category: AI
- Risk ID: [R08](./assess-cloud-risks.md#example-ai-risk)
- Policy statement: AI bias detection and mitigation in Azure OpenAI must be used
- Purpose: Mitigate AI bias
- Scope: Workload teams
- Remediation: Immediate corrective measures

Policy ID: AI02

- Policy category: AI
- Risk ID: [R08](./assess-cloud-risks.md#example-ai-risk)
- Policy statement: Customer-facing AI systems must be red-teamed monthly
- Purpose: Identify AI biases
- Scope: AI model teams
- Remediation: Immediate review, corrective actions for misses

### Summary of cloud governance policies

| Policy ID | Policy Category | Risk ID | Policy Statement | Purpose | Scope | Remediation |
|-----------|-----------------|---------|------------------|---------|-------|-------------|
| RC01 | Regulatory compliance | [R01](./assess-cloud-risks.md#example-regulatory-compliance-risk) | Microsoft Purview must be used to monitor sensitive data. | Regulatory compliance | Workload teams. Platform team | Immediate action by affected team. Compliance training |
| RC02 | Regulatory compliance | [R01](./assess-cloud-risks.md#example-regulatory-compliance-risk) | Daily sensitive data compliance reports must be generated from Microsoft Purview. | Regulatory compliance | Workload teams. Platform team | Resolution within one day, confirmation audit |
| SC01 | Security | [R02](./assess-cloud-risks.md#example-cloud-security-risks) | Multifactor authentication (MFA) must be enabled for all users | Mitigate data breaches and unauthorized access | Azure users | Revoke user access |
| SC02 | Security | [R02](./assess-cloud-risks.md#example-cloud-security-risks) | Access reviews must be conducted monthly in Microsoft Entra ID Governance | Ensure data and service integrity | Azure users | Immediate access revocation for noncompliance |
| SC03 | Security | [R03](./assess-cloud-risks.md#example-cloud-security-risks) | Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code | Ensure secure and centralized management of code repositories | Development teams | Transfer of unauthorized repositories to the specified GitHub organization and potential disciplinary actions for noncompliance |
| SC04 | Security | [R03](./assess-cloud-risks.md#example-cloud-security-risks) | Teams utilizing libraries from public sources must adopt the quarantine pattern | Ensure libraries are safe and compliant before integration into the development process | Development teams | Removal of noncompliant libraries and review of integration practices for affected projects |
| CM01 | Cost Management | [R04](./assess-cloud-risks.md#example-cloud-cost-management-risk) | Workload teams must set budgets alerts at the resource group level | Prevent overspending | Workload teams. Platform team | Immediate reviews, adjustments for alerts |
| CM02 | Cost Management | [R04](./assess-cloud-risks.md#example-cloud-cost-management-risk) | Azure Advisor cost recommendations must be reviewed | Optimize cloud usage | Workload teams. Platform team | Mandatory optimization audits after 60 days |
| OP01 | Operations | [R05](./assess-cloud-risks.md#example-cloud-operations-risk) | Production workloads should have an active-passive architecture across regions | Ensure service continuity | Workload teams | Architecture evaluations, biannual reviews |
| OP02 | Operations | [R05](./assess-cloud-risks.md#example-cloud-operations-risk) | All mission-critical workloads must implement a cross-region active-active architecture | Ensure service continuity | Mission-critical workload teams | Updates within 90 days, progress reviews |
| DG01 | Data | [R06](./assess-cloud-risks.md#example-cloud-data-risk) | Encryption in transit and at rest must be applied to all sensitive data | Protect sensitive data | Workload team | Immediate encryption enforcement and security training |
| DG02 | Data | [R06](./assess-cloud-risks.md#example-cloud-data-risk) | Data lifecycle policies must be enabled for all sensitive data | Manage data lifecycle | Workload team | Implementation within 60 days, quarterly audits |
| RM01 | Resource management | [R07](./assess-cloud-risks.md#example-cloud-resource-management-risk) | Bicep must be used to deploy resources | Standardize resource provisioning | Workload team. Platform team | Immediate Bicep transition plan |
| RM02 | Resource management | [R07](./assess-cloud-risks.md#example-cloud-resource-management-risk) | Tags must be enforced all cloud resources using Azure Policy | Facilitate resource tracking | All cloud resources | Correct tagging within 30 days |
| AI01 | AI | [R08](./assess-cloud-risks.md#example-ai-risk) | AI bias detection and mitigation in Azure OpenAI must be used. | Mitigate AI bias | Workload teams. | Immediate corrective measures |
| AI02 | AI | [R08](./assess-cloud-risks.md#example-ai-risk) | Customer-facing AI systems must be red-teamed monthly. | Identify AI biases | AI model teams | Immediate review, corrective actions for misses |

> [!div class="nextstepaction"]
> [Enforce cloud governance policies](enforce-cloud-governance-policies.md)
