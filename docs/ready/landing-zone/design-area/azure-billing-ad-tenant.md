---
title: Enterprise Agreement enrollments and Azure Active Directory tenants
description: Understand Enterprise Agreement enrollments and Azure Active Directory tenants.
author: jtracey93
ms.author: jatracey
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise Agreement enrollments and Azure Active Directory tenants

The Azure service presents a range of [active subscription offers](https://azure.microsoft.com/support/legal/offer-details/), and customers can use these offers at the same time to gain flexible billing options. Example subscriptions include Enterprise Agreement (Enterprise Agreement) Support, Microsoft Customer Agreement, Cloud Service Provider, and others.  

![Diagram that shows Azure scopes within one Azure Active Directory (Azure AD) tenant with various billing offers and subscriptions.](../../enterprise-scale/media/az-scopes-billing.png)

The Azure landing zone architecture supports subscriptions from any Azure offer. Subscriptions should exist within one Azure Active Directory (Azure AD) tenant to then relocate into the management group hierarchy within that tenant. They can then be managed by the various controls with enterprise-scale platforms like Azure Policy and role-based access control (RBAC).

>[!NOTE]
> The Azure Landing Zone accelerator implementation is scoped and deployed to one Azure AD tenant; however, billing options can span across multiple Azure AD tenants. For example, an Enterprise Agreement enrollment supports Azure subscriptions across different Azure AD tenants.

Explore the further information, considerations and recommendations for each approach below:

- [Enterprise Agreement (EA)](./azure-billing-ea.md)
- [Microsoft Customer Agreement (MCA)](./azure-billing-mca.md)
- [Cloud Service Provider Agreement (CSP)](./azure-billing-csp.md)
- [Define an Azure Active Directory (AAD) tenant](./azure-ad-define.md)