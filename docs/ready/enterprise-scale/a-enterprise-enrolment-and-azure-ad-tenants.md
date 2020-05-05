---
title: "Enterprise enrollment and Azure AD tenants"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Enterprise enrollment and Azure AD tenants
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# A. Enterprise enrollment and Microsoft Azure Active Directory tenants

![EA enrollment](./media/ea.png)

Figure 3 – Enterprise agreement enrollment hierarchy

## 1. Planning for enterprise enrollment

An enterprise enrollment, often referred to as the enterprise agreement (EA), represents the commercial relationship between Microsoft and the customer regarding their use of Azure. It provides the basis for billing across all customer subscriptions and therefore has an impact on administration of the customer estate.

**Design considerations:**

- The enrollment provides a hierarchical organizational structure to govern the management of customer subscriptions.

- Different customer environments can be separated at an EA account level to support holistic isolation.

- There can be multiple administrators appointed to a single enrollment.

- Each subscription must have an associated account owner.

- Each account owner will be made a subscription owner for any subscriptions provisioned under that account.

- A subscription can only belong to one account at any given time.

- A subscription can be suspended based on a specified set of criteria.

**Design recommendations:**

- Set up the notification account email address to ensure notifications are sent to an appropriate group mailbox.

- Assign a budget for each account and establish an alert associated with the budget.

- Use the department organizational element to map customer business divisions.

- Create a new department if business domains have independent IT capabilities.

- Restrict and minimize the number of account owners within the enrollment to avoid the proliferation of admin access to subscriptions and associated Azure resources.

- If multiple Azure Active Directory (AD) tenants are used, ensure the account owner is associated with the same tenant as where subscriptions for the account are provisioned.

- Separate dev/test/prod environments at an EA account level to support holistic isolation.

<!-- -->

- Do not ignore notification emails sent to the notification account email address. Microsoft sends important EA-wide communications to this account.

- Do not move or rename an EA account in Azure AD.

## 2. Define Azure AD tenants

An Azure AD tenant is an instance of Azure AD, which contains accounts and groups and acts as an authentication source for subscriptions that must be rooted to a single Azure AD tenant.

**Design considerations:**

- Multiple tenants can be used under the same enterprise enrollment.

**Design recommendations:**

- Use Azure AD SSO based on the selected [planning topology](/azure/active-directory/hybrid/plan-connect-topologies).

- Enforce multi-factor authentication and conditional access policies for all privileged accounts.

- Use Azure AD Privileged Identity Management for identity and access management.

<!-- docsTest:ignore Dev/Test/Prod -->

- If development/testing/production are going to be completely isolated environments from an identity perspective, separate them at a tenant level (for example, use multiple tenants).

<!-- -->

- Avoid creating a new Azure AD tenant unless there is a strong IAM justification and processes are already in place.

## Next steps

Suggested design for [identity and access management](./b-identity-and-access-management.md).

> [!div class="nextstepaction"]
> [Identity and access management](./b-identity-and-access-management.md)
