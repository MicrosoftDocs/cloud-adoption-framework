---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise enrollment and Azure AD tenants

## 1. Planning for enterprise enrollment

An enterprise enrollment, often referred to as the Enterprise Agreement, represents the commercial relationship between Microsoft and the customer regarding their use of Azure. It provides the basis for billing across all customer subscriptions and therefore has an impact on administration of the customer estate. Enterprise enrollment is managed via Azure enterprise (also referred to as EA) portal. Azure enterprise enrollment often represent organisational hierarchy such as departments, accounts and subscription. These hierarchy represent cost enrollment groups within an organisation.

![Azure EA hierarchies.](./media/ea.png)
_Figure 1: EA enrollment hierarchy._

Departments help you segment costs into logical groupings. Departments enable you to set a budget or quota at the department level (note: quota is not hard enforcement but rather used for reporting purpose)

Accounts are organizational units in the Azure enterprise portal. You can use accounts to manage subscriptions and access reports.

Subscriptions are the smallest unit in the Azure enterprise portal. They're containers for Azure services managed by the service administrator. Subscription is where organisation deploy Azure services.

Enterprise enrollment roles links users with their functional role and consists of:

- Enterprise administrator
- Department administrator
- Account owner
- Service administrator
- Notification contact

### Why enterprise enrollment

Enterprise enrollment provides organizational representations and make it easier for enterprise to roll up cost to their respective department. Enterprise enrollment enables to set an administrator for department or for entire organization. Enterprise portal of Azure which enable enterprise enrollment also enable organisation to set key contacts to receive critical communication from Microsoft.

### Scenarios where enterprise enrollment is not possible

Enterprise enrollment is part of Enterprise Agreement. Customers who are not enterprise customer of Azure will not have access to enterprise portal and thus will not be able to manage subscriptions via enterprise portal.

In the absence of enterprise portal it is possible to manage resources via [Azure management group](https://docs.microsoft.com/azure/governance/management-groups/overview), however features and implementation of hierarchy in management group will differ from enterprise enrollment.

Management group can be used to organize hierarchy for unified policy and access management while enterprise enrollment organize subscription into departments and accounts for purpose of account, expenses, administer and unified communication management.

**Design considerations:**

- The enrollment provides a hierarchical organizational structure to govern the management of customers subscriptions.

- Multiple customers environments can be separated at an EA account level to support holistic isolation.

- There can be multiple administrators appointed to a single enrollment.

- Each subscription must have an associated account owner.

- Each account owner will be made a subscription owner for any subscriptions provisioned under that account.

- A subscription can only belong to one account at any given time.

- A subscription can be suspended based on a specified set of criteria.

**Design recommendations:**

- Setup the notification contact email address to ensure notifications are sent to an appropriate group mailbox.

- Assign a budget for each account and establish an alert associated with the budget.

- Organisation can have a variety of structures such as functional, divisional, geographic, matrix or team structure. Use organizational structure to map organization structure to enterprise enrollment.

- Create a new department for IT if business domains have independent IT capabilities.

- Restrict and minimize the number of account owners within the enrollment to avoid the proliferation of admin access to subscriptions and associated Azure resources.

- If multiple Azure AD tenants are used, ensure the account owner is associated with the same tenant as where subscriptions for the account are provisioned.

- Setup Enterprise Dev/Test/prod environments at an EA account level to support holistic isolation.

- Do not ignore notification emails sent to the notification account email address. Microsoft sends important EA wide communications to this account.

- Do not move or rename an EA account in Azure AD.

- Periodically audit EA portal to review who has access and avoid using msa account where possible.

## 2. Define Azure AD tenants

Azure AD tenant provide identity and access management which is an important part of security posture ensuring that only authenticated and authorized user have access to resources to which they have permission to access. Azure AD not only provide these services to applications and services deployed in Azure but to services and applications also deployed outside Azure (such as on-premises or third-party cloud providers). Azure AD service is also utilized by SaaS application such as Microsoft 365 and Azure Marketplace applications. Organization already using on-premises Active Directory can use their existing infrastructure and can extend authentication to the cloud by integrating ad with Azure AD. Each Azure AD has one or more domains. A directory can have many subscriptions associated with it, but only one Azure AD tenant.

It is very important that we asked basic security question in design phase of Azure AD such how organization is managing credential, control of human and application access and how to control programatic access.

**Design considerations:**

- Multiple tenants can be leveraged under the same enterprise enrollment.

**Design recommendations:**

- Use Azure AD SSO based on the selected [planning topology](https://docs.microsoft.com/azure/active-directory/hybrid/plan-connect-topologies).

- In case organisation does not have existing identity infrastructure, then it is recommended to start by implementing Azure AD only identity deployment. Such deployment with [Azure AD Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/) and [enterprise mobility suite](https://docs.microsoft.com/mem/intune/fundamentals/what-is-intune) provide end to end protection for SaaS and enterprise application as well as devices.

- Multi-factor authentication provides a second barrier of authentication adding another layer of security. It is recommended to enforce [multi-factor authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks) and  [conditional access policies](https://docs.microsoft.com/azure/active-directory/conditional-access/overview) for all privileged accounts to make it more secure. Multi-factor authentication does provide another barrier of authentication but does not stop phishing or social engineering such as hacker taking physical possession of your phone or sim swapping or cloning. It is recommended that multi-factor authentication should be implemented with device management policy(such as strong pin locking and encryption and erasing device remotely when its lost). Out of band multi-factor authentication (such as biometric) is also considered a secure form of multi-factor authentication.

- Plan and implement for [emergency access](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

- Use Azure AD [priviledged identity management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) for identity and access management.

- If dev/test/prod are going to be completely isolated environments from an identity perspective, separate them at a tenant level (I.e. Use multiple tenants).

- Avoid creating a new Azure AD tenant unless there is a strong IAM justification and processes are already in-place.
