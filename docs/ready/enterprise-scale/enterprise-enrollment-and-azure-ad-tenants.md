---
title: Enterprise enrollment and Azure Active Directory tenants
description: Enterprise enrollment and Azure Active Directory tenants
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise enrollment and Azure Active Directory tenants

## Planning for enterprise enrollment

An enterprise enrollment, often referred to as an Enterprise Agreement, represents the commercial relationship between Microsoft and how the customer uses Azure. It provides the basis for billing across all customer subscriptions and impacts administration of the customer estate. Enterprise enrollment, also known as EA, is managed via an Azure enterprise portal. Azure enterprise enrollment often represents an organization's hierarchy, including departments, accounts, and subscriptions. This hierarchy represents cost-enrollment groups within an organization.

![Azure EA hierarchies](./media/ea.png)
_Figure 1: An EA enrollment hierarchy_

* Departments help to segment costs into logical groupings and to set a budget or quota at the department level (note: the quota isn't enforced firmly and is used for reporting purposes).

* Accounts are organizational units in the Azure enterprise portal; they can be used to manage subscriptions and access reports.

* Subscriptions are the smallest unit in the Azure enterprise portal. They're containers for Azure services managed by the service administrator. They are where an organization deploys Azure services.

* Enterprise enrollment roles link users with their functional role and are:
 * Enterprise administrator
 * Department administrator
 * Account owner
 * Service administrator
 * Notification contact

### Why enterprise enrollment

* Enterprise enrollment provides organizational representations and makes it easier for enterprises to roll costs to their respective departments.
* Enterprise enrollment supports setting an administrator for departments or for entire organizations.
* The Azure Enterprise Portal enables enterprise enrollment and also helps organizations to set key contacts who receive critical communication from Microsoft.

### Scenarios where enterprise enrollment isn't possible

* Enterprise enrollment is part of an Enterprise Agreement. Customers who aren't Azure enterprise customers won't have access to the Enterprise Portal and won't be able to manage subscriptions here.

* It is possible to manage resources without the Enterprise Portal via [Azure Management Group](https://docs.microsoft.com/azure/governance/management-groups/overview). Features and implementation of hierarchy in management groups will differ from enterprise enrollment.

* Management groups can be used to organize hierarchies for unified policies and access management, while enterprise enrollment organizes subscriptions into departments and accounts for unified account, expense, administration, and communication management.

**Design considerations:**

* The enrollment provides a hierarchical organizational structure to govern the management of customers subscriptions.

* Multiple customers environments can be separated at an EA-account level to support holistic isolation.

* There can be multiple administrators appointed to a single enrollment.

* Each subscription must have an associated account owner.

* Each account owner will be made a subscription owner for any subscriptions provisioned under that account.

* A subscription can only belong to one account at any given time.

* A subscription can be suspended based on a specified set of criteria.

**Design recommendations:**

* Set up the notification contact email address to ensure notifications are sent to an appropriate group mailbox.

* Assign a budget for each account and establish an alert associated with the budget.

* An organization can have a variety of structures such as functional, divisional, geographic, matrix, or team structure. Use organizational structure to map organization structure to enterprise enrollment.

* Create a new department for IT if business domains have independent IT capabilities.

* Restrict and minimize the number of account owners within the enrollment to avoid the proliferation of admin access to subscriptions and associated Azure resources.

* If multiple Azure AD tenants are used, verify that the account owner is associated with the same tenant as where subscriptions for the account are provisioned.

* Set up enterprise development (dev)/testing (test)/production environments at an EA account level to support holistic isolation.

* Do not ignore notification emails sent to the notification account email address. Microsoft sends important EA-wide communications to this account.

* Do not move or rename an EA account in Azure AD.

* Periodically audit the EA portal to review who has access and avoid using a Microsoft account where possible.

## Define Azure AD tenants

An Azure AD tenant provides identity and access management, which is an important part of security posture, ensuring that only authenticated and authorized users have access to the resources to which they have permission to access. Azure AD not only provides these services to applications and services deployed in Azure but to services and applications deployed outside of Azure (such as on-premises or third-party cloud providers). Azure AD service is also utilized by software-as-a-service (SaaS) applications such as Microsoft 365 and theAzure Marketplace. Organization already using on-premises Active Directory can use their existing infrastructure and extend authentication to the cloud by integrating with Azure AD. Each Azure AD has one or more domains. A directory can have many subscriptions associated with it but only one Azure AD tenant.

It is important to ask basic security questions during the Azure AD design phase—how an organization is managing credentials, control of human and application access, and how to control programmatic access.

**Design considerations:**

Multiple tenants can function in the same enterprise enrollment.

**Design recommendations:**

- Use Azure AD Single Sign-on based on the selected [planning topology](https://docs.microsoft.com/azure/active-directory/hybrid/plan-connect-topologies).

- If an organization doesn't have identity infrastructure, it's recommended to start by implementing Azure-AD-only identity deployment. Such deployment with [Azure AD Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/) and the [Microsoft Enterprise Mobility Suite](https://docs.microsoft.com/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS and enterprise applications as well as for devices.

- Multi-factor authentication (MFA) provides another layer of security and a second barrier of authentication. It is recommended to enforce [MFA](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks) and [Conditional Access policies](https://docs.microsoft.com/azure/active-directory/conditional-access/overview) for all privileged accounts to make them more secure. MFA doesn't stop phishing or social engineering such as a hacker taking physical possession of your phone, SIM swapping, or cloning. It is recommended for MFA to be implemented with a device management policy(such as strong pin locking, encryption, and erasing a device remotely when it's lost). Out-of-band MFA (such as biometric) is also considered a secure form of MFA.

- Plan and implement for [emergency access](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

- Use Azure AD [Privileged Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) for identity and access management.

- If dev/test/prod are going to be isolated environments from an identity perspective, then separate them at a tenant level; use multiple tenants.

- Avoid creating a new Azure AD tenant unless there's a strong IAM justification and processes are already in place.
