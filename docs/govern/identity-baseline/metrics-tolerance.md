---
title: Risk tolerance metrics and indicators in the Identity Baseline discipline.
description: Use the Cloud Adoption Framework for Azure to learn how to quantify business risk tolerance related to the Identity Baseline discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Identity baseline metrics, indicators, and risk tolerance

Learn to quantify business risk tolerance associated with the Identity Baseline discipline. Defining metrics and indicators helps to create a business case for investing in the maturity of this discipline.

## Metrics

Identity management focuses on identifying, authenticating, and authorizing individuals, groups of users, or automated processes, and providing them appropriate access to resources in your cloud deployments. As part of your risk analysis you'll want to gather data related to your identity services to determine how much risk you face, and how important investment in your Identity Baseline discipline is for your planned cloud deployments.

The following are examples of useful metrics that you should gather to help evaluate risk tolerance within the Identity Baseline discipline:

- **Identity systems size.** Total number of users, groups, or other objects managed through your identity systems.
- **Overall size of directory services infrastructure.** Number of directory forests, domains, and tenants used by your organization.
- **Dependency on legacy or on-premises authentication mechanisms.** Number of workloads that depend on legacy or third-party or multi-factor authentication mechanisms.
- **Extent of cloud-deployed directory services.** Number of directory forests, domains, and tenants you've deployed to the cloud.
- **Cloud-deployed Active Directory servers.** Number of Active Directory servers deployed to the cloud.
- **Cloud-deployed organizational units.** Number of Active Directory organizational units (OUs) deployed to the cloud.
- **Extent of federation.** Number of identity management systems federated with your organization's systems.
- **Elevated users.** Number of user accounts with elevated access to resources or management tools.
- **Use of Azure role-based access control.** Number of subscriptions, resource groups, or individual resources not managed through Azure role-based access control (Azure RBAC) via groups.
- **Authentication claims.** Number of successful and failed user authentication attempts.
- **Authorization claims.** Number of successful and failed attempts by users to access resources.
- **Compromised accounts.** Number of user accounts that have been compromised.

## Risk tolerance indicators

Risks related to identity baseline are largely related to the complexity of your organization's identity infrastructure. If all your users and groups are managed using a single directory or cloud-native identity provider using minimal integration with other services, your risk level will likely be small. As your business needs grow, your identity management systems may need to support more complicated scenarios, such as multiple directories to support your internal organization or federation with external identity providers. As these systems become more complex, risk increases.

In the early stages of cloud adoption, work with your IT security team and business stakeholders to identify [business risks](./business-risks.md) related to identity, then determine an acceptable baseline for identity risk tolerance. This section of the Cloud Adoption Framework provides examples, but the detailed risks and baselines for your company or deployments may be different.

Once you have a baseline, establish minimum benchmarks representing an unacceptable increase in your identified risks. These benchmarks act as triggers for when you need to take action to address these risks. The following are a few examples of how identity related metrics, such as those discussed above, can justify an increased investment in the Identity Baseline discipline.

- **User account number trigger.** A company with more than *x* users, groups, or other objects managed in your identity systems could benefit from investment in the Identity Baseline discipline to ensure efficient governance over a large number of accounts.
- **On-premises identity dependency trigger.** A company planning to migrate workloads to the cloud that require legacy authentication capabilities or third-party multi-factor authentication should invest in the Identity Baseline discipline to reduce risks related to refactoring or additional cloud infrastructure deployment.
- **Directory services complexity trigger.** A company maintaining more than *x* individual forests, domains, or directory tenants should invest in the Identity Baseline discipline to reduce risks related with account management and the efficiency issues related to multiple user credentials spread across multiple systems.
- **Cloud-hosted directory services trigger.** A company hosting *x* Active Directory server virtual machines (VMs) hosted in the cloud, or having *x* organizational units (OUs) managed on these cloud-based servers, can benefit from investment in the Identity Baseline discipline to optimize integration with any on-premises or other external identity services.
- **Federation trigger.** A company implementing identity federation with *x* external identity management systems can benefit from investing in the Identity Baseline discipline to ensure consistent organizational policy across federation members.
- **Elevated access trigger.** A company with more than *x%* of users with elevated permissions to management tools and resources should consider investing in the Identity Baseline discipline to minimize the risk of inadvertent overprovisioning of access to users.
- **Azure RBAC trigger.** A company with less than *x%* of resources using Azure role-based access control methods should consider investing in the Identity Baseline discipline to identify optimized ways to assign user access to resources.
- **Authentication failure trigger.** A company where authentication failures represent more than *x%* of attempts should invest in the Identity Baseline discipline to ensure that authentication methods are not under external attack, and that users can authenticate properly.
- **Authorization failure trigger.** A company where access attempts are rejected more than *x%* of the time should invest in the Identity Baseline discipline to improve the application and updating of access controls, and identify potentially malicious access attempts.
- **Compromised account trigger.** A company with more than 1 compromised account should invest in the Identity Baseline discipline to improve the strength and security of authentication mechanisms and improve mechanisms to remediate risks related to compromised accounts.

The exact metrics and triggers you use to gauge risk tolerance and the level of investment in the Identity Baseline discipline will be specific to your organization, but the examples above should serve as a useful base for discussion within your cloud governance team.

## Next steps

Use the [Identity Baseline discipline template](./template.md) to document metrics and tolerance indicators that align to the current cloud adoption plan.

Review sample Identity Baseline policies as a starting point to develop your own policies to address specific business risks aligned with your cloud adoption plans.

> [!div class="nextstepaction"]
> [Review sample policies](./policy-statements.md)
