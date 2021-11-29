---
title: Cloud Solution Provider service
description: Learn how to understand Cloud Solution Provider (CSP) service agreements and Azure Active Directory (Azure AD) tenants.
author: jtracey93
ms.author: jatracey
ms.date: 12/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Plan for the Cloud Solution Provider service

The Cloud Solution Provider (CSP) service gives Microsoft partners access to Microsoft cloud services within one platform. It supports partners to:

- Own the customer lifecycle and end-to-end relationship.
- Set pricing, terms, and directly bill customers.
- Directly provision and manage subscriptions.
- Attach services that add value.
- Be the customer's first point of contact for support.

[Azure in CSP](https://azure.microsoft.com/offers/ms-azr-0145p/) is an Azure plan with various subscriptions that are hosted by the partner's [Microsoft partner agreement (MPA)](/azure/cost-management-billing/understand/mpa-overview). The MPA is similar to the Microsoft customer agreement. Both are hosted on the modern commerce platform and use a [simplified purchase agreement](https://www.microsoft.com/licensing/docs/customeragreement).

![Diagram that shows an MPA hierarchy.](../../enterprise-scale/media/mpa-hierarchy.png)

> [!IMPORTANT]
> The partner CSP completely manages an MPA.

## Design considerations

- A [CSP reseller relationship](/partner-center/request-a-relationship-with-a-customer) must exist between the partner and each Azure Active Directory (Azure AD) tenant in which the customer wants to provision a new Azure plan and CSP subscriptions.

- Only the partner can provision an Azure plan and CSP subscriptions.

- A specific set of criteria can be used to determine whether a subscription should be suspended; a partner can also suspend a subscription.

- The partner can allow customers to view their Azure usage fees on a per customer basis. For more information, see [Enable the policy to view Azure usage charges](/azure/cost-management-billing/costs/get-started-partners#enable-cost-management-for-customer-tenant-subscriptions). Partners can also use other tools to provide customers with access to their charges.

- By default, only the partner Azure Reservations can be purchased by the partner for their customer. However, the [**Customer Permissions** feature](/partner-center/give-customers-permission) grants customers permission to purchase Azure Reservations from their CSP.

## Design recommendations

- Work with your CSP partner to ensure that Azure Lighthouse is used for administer on behalf of (AOBO) access for most support scenarios. For more information, see [Azure Lighthouse and the Cloud Solution Provider program](/azure/lighthouse/concepts/cloud-solution-provider).

- Work with your CSP partner to understand how to create support cases and escalation processes.

- Discuss how to create self-service subscriptions with your CSP partner.

- Use [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) reports and views. These reports can use Azure metadata, like tags and location, to explore and analyze your organization's costs.
