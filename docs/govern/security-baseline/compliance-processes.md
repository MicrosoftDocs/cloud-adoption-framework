---
title: Security Baseline policy compliance processes
description: Create processes that support a Security Baseline discipline. Establish procedures and policies for detecting vulnerabilities and remediating security risks.
author: martinekuan
ms.author: martinek
ms.date: 09/17/2019
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Security Baseline policy compliance processes

This article shows you how to develop policy adherence processes that govern the [Security Baseline discipline](./index.md). Effective governance of cloud security starts with recurring manual processes. These processes detect vulnerabilities and impose policies to remediate those security risks. To use these processes, your cloud governance team and interested business and IT stakeholders need to regularly review and update policies. They also need to ensure policy compliance. Besides taking manual steps, you can also automate many ongoing monitoring and enforcement processes or supplement them with tooling. This practice reduces the overhead of governance and helps you respond quickly to policy deviations.

## Planning, review, and reporting processes

The best Security Baseline tools in the cloud are only as good as the processes and policies that they support. The following sections describe processes that are commonly part of the Security Baseline discipline. These processes can be a good resource when you update your security policy. Typically, you update your policy based on business change and feedback. The feedback comes from security and IT teams that are tasked with turning governance guidance into action. Use the following sections as a starting point when you update your policy.

### Initial risk assessment and planning

As part of your initial adoption of the Security Baseline discipline, identify your core business risks and tolerances that are related to cloud security. Use this information to discuss specific technical risks with members of your IT and security teams. During that discussion, establish your initial governance strategy by developing a baseline set of security policies for mitigating these risks.

### Deployment planning

Before you deploy any workload or asset, perform a security review. In that review, identify any new risks, and ensure all access and data security policy requirements are met.

### Deployment testing

When you deploy a workload or asset, review the deployment to validate security policy compliance. Make the cloud governance team responsible for that review in cooperation with your corporate security teams.

### Annual planning

On an annual basis, perform a high-level review of your Security Baseline strategy. Explore future corporate priorities and updated cloud adoption strategies to identify potential risk increases and other emerging security needs. Also review the latest Security Baseline best practices. Integrate these practices into your policies and review processes.

### Quarterly review and planning

On a quarterly basis, review security audit data and incident reports. Identify any changes that are needed in your security policy. As part of this process, review the current cybersecurity landscape to proactively anticipate emerging threats. Update your policy appropriately. After the review is complete, align design guidance with the updated policy.

This planning process is also a good time to evaluate the current membership of your cloud governance team. Look for knowledge gaps that are related to new or changing policies. Also look for risks that are related to security. Invite relevant IT staff to participate in reviews and planning as either temporary technical advisors or permanent members of your team.

### Education and training

On a bimonthly basis, offer training sessions to bring IT staff and developers up to date on the latest security policy requirements. As part of this process, review and update your documentation, guidance, and other training assets. Ensure that these materials are in sync with the latest corporate policy statements.

### Monthly audit and reporting reviews

On a monthly basis, perform an audit on all cloud deployments to assure their continued alignment with your security policy. Review security-related activities with IT staff. Identify any compliance issues that you don't already handle as part of the ongoing monitoring and enforcement process. Produce a report as the result of this review. Distribute that report to the cloud strategy team and each cloud adoption team to communicate overall adherence to your policy. Store the report for auditing and legal purposes.

## Processes for ongoing monitoring

The success of a Security Baseline strategy depends on its visibility into the current and past state of your cloud infrastructure. You need to be able to analyze the relevant metrics and data of the security health and activity of your cloud resources. Without this information, you can't identify changes in your risks or detect violations of your risk tolerances. Ongoing governance processes require high-quality data. Only when you have that data can you modify policies to better protect your infrastructure against changing threats and security requirements.

Ensure that your security and IT teams have implemented automated monitoring systems for your cloud infrastructure. Make sure that these systems capture the log data that you need to evaluate risk. Be proactive in monitoring these systems to ensure prompt detection and mitigation of potential policy violations. Ensure your monitoring strategy is in line with security needs.

## Violation triggers and enforcement actions

Security noncompliance can lead to critical data exposure and service disruptions. To lower these risks, give the cloud governance team visibility into serious policy violations. Ensure that IT staff has clear escalation paths for reporting security issues. Also ensure that those reports go to governance team members who can best identify policy issues and verify that those issues are mitigated.

When you detect violations, take action to realign with your policy as soon as possible. For tools that your IT team can use to automate most violation triggers, see [Security Baseline toolchain for Azure](./toolchain.md).

Your monitoring data can help you resolve policy violations. For examples, see the following triggers and enforcement actions:

- **You detect an increase in attacks.** If any resource experiences a 25 percent increase in brute force or DDoS attacks, discuss the situation with IT security staff and the workload owner to determine remedies. Track the issue. If you need to revise policies to mitigate future incidents, update your guidance.
- **You detect unclassified data.** If a data source doesn't have an appropriate privacy, security, or business-impact classification, deny it external access. Grant access only after the data owner applies the classification and an appropriate level of data protection.
- **You detect a security health issue.** Disable access to any virtual machines (VMs) that have known access or malware vulnerabilities. Grant access only after you install appropriate patches or security software. Update policy guidance to account for any new threats that you detect.
- **You detect a network vulnerability.** Configure your system to send an alert whenever a resource is accessed that network access policies don't explicitly allow. Send the alert to IT security staff and the relevant workload owner. Track the issue. If you need to revise policies to mitigate future incidents, update your guidance.

## Next steps

To document the processes and triggers that align with the current cloud adoption plan, use the [Security Baseline discipline template](./template.md).

For guidance on executing cloud management policies in alignment with adoption plans, see the following article on discipline improvement.

> [!div class="nextstepaction"]
> [Security Baseline discipline improvement](./discipline-improvement.md)
