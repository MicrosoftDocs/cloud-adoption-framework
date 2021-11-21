---
title: Enterprise Agreement enrollment design area guidance
description: Understand the Enterprise Agreement enrollments and Azure Active Directory tenants design area.
author: jtracey93
ms.author: jatracey
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Plan for Enterprise Agreement enrollment

Enterprise Agreement enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides billing foundation for your subscriptions and how your digital estate is administered. The Azure EA portal (https://EA.Azure.com) helps you to manage your Enterprise Agreement enrollment. An enrollment often represents an organization's hierarchy, including departments, accounts, and subscriptions. This hierarchy represents cost centers within an organization.

![Diagram that shows Azure Enterprise Agreement hierarchies.](../../enterprise-scale/media/ea.png)

- Departments help to segment costs into logical groupings and set a budget or quota at the department level. The quota isn't firmly enforced; it's used for reporting purposes.

- Accounts are organizational units in the Azure EA portal. They can be used to manage subscriptions and access reports.

- Subscriptions are the smallest units in the Azure EA portal. They're containers for Azure services that are managed by a Service Administrator. This is where your organization deploys Azure services.

- [Enterprise Agreement enrollment roles](/azure/cost-management-billing/manage/understand-ea-roles#enterprise-user-roles) link users with their functional role. These roles are:

  - Enterprise Administrator
  - Department Administrator
  - Account owner
  - Service Administrator
  - Notification Contact

## How an Enterprise Agreement enrollment relates to Azure AD and Azure RBAC

When your organization uses an Enterprise Agreement enrollment for Azure subscriptions, it's important to understand the various authentication and authorization boundaries and the relationship between these boundaries.

There is an inherent trust relationship between Azure subscriptions and an Azure AD tenant, which is described further in [Associate or add an Azure subscription to your Azure AD tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory). An Enterprise Agreement enrollment can also use an Azure AD tenant as an identity provider, depending on the [authentication level](/azure/cost-management-billing/manage/ea-portal-troubleshoot#authentication-level-types) set on the enrollment and which option was selected when the enrollment account owner was created. However, apart from the account owner, Enterprise Agreement enrollment roles don't provide access to Azure AD or the Azure subscriptions within that enrollment.

For example, a finance user is granted an Enterprise Administrator role on the Enterprise Agreement enrollment. They're a standard user without elevated permissions or roles assigned to them in Azure AD or on any Azure management group, subscription, resource group, or resource. The finance user can only perform the roles listed at [Managing Azure Enterprise Agreement roles](/azure/cost-management-billing/manage/understand-ea-roles#enterprise-administrator) and can't access the Azure subscriptions on the enrollment. The only Enterprise Agreement role with access to Azure subscriptions is the account owner because this permission was granted when the subscription was created.

![Diagram that shows Azure Enterprise Agreement relationship with Azure AD and RBAC.](../../enterprise-scale/media/ea-azure-relationship.png)

## Design considerations

- The enrollment provides a hierarchical organizational structure to govern how subscriptions are managed. For more information, see [Managing Azure Enterprise Agreement roles](/azure/cost-management-billing/manage/understand-ea-roles#azure-enterprise-portal-hierarchy).

- A range of administrators can be assigned to a single enrollment.

- Each subscription should have a designated account owner. See [Azure EA portal administration guide](/azure/cost-management-billing/manage/ea-portal-administration#change-azure-subscription-or-account-ownership) for details on how to change this, if needed.

- Each account owner is a subscription owner for any subscriptions provisioned under that account.

- A subscription can belong to only one account at a time.

- A specific set of criteria can be used to determine whether a subscription should be suspended.

- Departments and accounts can filter enrollment billing and usage reports.

- Review [Programmatically create Azure Enterprise Agreement subscriptions with the latest APIs](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#limitations-of-azure-enterprise-subscription-creation-api) for more information about Enterprise Agreement subscription limitations.

## Design recommendations

- Only use the authentication type `Work or school account` for all account types. Avoid using the `Microsoft account (MSA)` account type.

- Set up a Notification Contact email address to ensure notifications are sent to an appropriate group mailbox.

- An organization can have various structures, including functional, divisional, geographic, matrix, or team structures. Using departments and accounts to map your organization's structure to your enrollment hierarchy can help with separating billing.

- Use [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) reports and views, which can use Azure metadata (for example, tags and location) to explore and analyze your organization's costs.

- Restrict and minimize the number of account owners within the enrollment to limit administrator access to subscriptions and associated Azure resources.

- Assign a budget for each department and account, and establish an alert associated with the budget.

- Create a new department for IT if business domains have independent IT capabilities.

- If you use multiple Azure AD tenants, verify that the account owner is associated with the same tenant as where subscriptions for the account are provisioned.

- For development/testing (dev/test) workloads, use the [Enterprise Dev/Test](/azure/cost-management-billing/manage/ea-portal-administration#enterprise-devtest-offer) offer, where available. Ensure you comply with the [terms of use](https://azure.microsoft.com/offers/ms-azr-0148p/).

- Don't ignore notification emails sent to the notification account email address. Microsoft sends important Enterprise Agreement prompts to this account.

- Don't move or rename an Enterprise Agreement account in Azure AD.

- Periodically audit the Azure EA portal to review who has access, and when possible, avoid using a Microsoft account.

- [Enable both **DA View Charges** and **AO View Charges** on every Enterprise Agreement enrollment](/azure/cost-management-billing/costs/assign-access-acm-data#enable-access-to-costs-in-the-azure-portal) to allow users with the correct permissions to view Azure Cost Management + Billing data.
