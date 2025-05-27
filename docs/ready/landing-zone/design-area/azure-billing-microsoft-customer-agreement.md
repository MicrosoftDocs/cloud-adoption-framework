---
title: Microsoft customer agreement and Microsoft Entra tenants
description: Understand mca agreements and Microsoft Entra tenants.
author: jtracey93
ms.author: jatracey
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency.5
---

# Plan for the Microsoft customer agreement service

The [Microsoft customer agreement](https://www.microsoft.com/licensing/how-to-buy/microsoft-customer-agreement) is a recent and modern Azure service and commerce platform. It represents the commercial relationship between Microsoft and how your organization uses Azure. The agreement enables a streamlined, electronic transaction in an 11-page agreement that doesn't expire. It provides a billing foundation for your subscriptions and affects how your digital estate is administered. You can manage your agreement in the [Azure portal](https://portal.azure.com).

The Microsoft customer agreement often represents an organization's hierarchy, which consists of billing profiles, invoice sections, and subscriptions. This hierarchy represents cost centers within an organization.

![Diagram that shows the hierarchy of a Microsoft customer agreement.](../../enterprise-scale/media/mca-hierarchy.png)

> [!IMPORTANT]
> If migrating from an Enterprise Agreement to a Microsoft customer agreement,  review the following articles:
>
> - [Complete Enterprise Agreement tasks in your billing account for a Microsoft customer agreement](/azure/cost-management-billing/manage/mca-enterprise-operations)
> - [Set up your billing account for a Microsoft customer agreement](/azure/cost-management-billing/manage/mca-setup-account)

## Design considerations

- The agreement provides a hierarchical organizational structure to govern how subscriptions are managed. For more information, see [Organize costs by customizing your billing account](/azure/cost-management-billing/manage/mca-section-invoice).

- An agreement billing account is managed by a single Microsoft Entra tenant. However, subscriptions across different Microsoft Entra tenants are supported by a single agreement. For more information, see [How tenants and subscriptions relate to billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#how-tenants-and-subscriptions-relate-to-billing-account) and [Manage subscriptions under multiple tenants in a single Microsoft customer agreement](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#manage-subscriptions-under-multiple-tenants-in-a-single-microsoft-customer-agreement).

- New Azure subscriptions provisioned with an agreement are associated with the Microsoft Entra tenant in which the agreement billing account is located.

- Agreements use the role-based access control (RBAC) model. Multiple users can be assigned with the required roles at the same scopes (for example, billing account, billing profile, and invoice section). These billing roles and assignments are outside of standard Azure RBAC roles and assignments. They can't be assigned at a management group or resource group scope.

- A subscription can belong to only one invoice section at any time. Subscriptions can only be moved between invoice sections within the same billing profile.

- An optional purchase order number can be set up on a billing profile.

- A specific set of criteria can be used to determine whether a subscription should be suspended.

- Before you provision more billing profiles, [review the potential impact to charges and reservations](/azure/cost-management-billing/manage/mca-section-invoice#things-to-consider-when-adding-new-billing-profiles).

- Use [Microsoft Cost Management](/azure/cost-management-billing/cost-management-billing-overview) reports and views, which explore and analyze your organization's costs with Azure metadata.

## Design recommendations

- Set up a Notification Contact email address on the agreement billing account to ensure notifications are sent to an appropriate group mailbox.

- Assign a budget for each invoice section or billing profile, and establish an alert associated with the budget.

- An organization can have various structures, such as functional, divisional, geographic, matrix, or team. Use organizational structures to map your organization to your agreement hierarchy. Invoice sections are suitable for most scenarios.

- If your business domain has independent IT capabilities, create a new invoice section for IT.

- Don't ignore notifications sent to the contact email address. Microsoft sends important prompts to this address.

- Periodically audit the agreement billing RBAC role assignments to review who has access.

- For development/testing (dev/test) workloads, use the Microsoft Azure plan for dev/test offer, where available. Ensure you comply with the [terms of use](https://azure.microsoft.com/offers/ms-azr-0148g/).

- Any user with [permissions](/azure/cost-management-billing/manage/understand-mca-roles#subscription-billing-roles-and-tasks) on an invoice section, billing profile, or billing account to create subscriptions must use multifactor authentication (MFA). This applies to all privileged accounts as documented in[Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](/entra/identity/role-based-access-control/security-planning?bc=%2Fazure%2Fcloud-adoption-framework%2F_bread%2Ftoc.json&toc=%2Fazure%2Fcloud-adoption-framework%2Ftoc.json).
