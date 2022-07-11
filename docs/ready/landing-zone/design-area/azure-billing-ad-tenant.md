---
title: Azure billing offers and Active Directory tenants
description: Understand Azure billing offers and Active Directory tenants
author: jtracey93
ms.author: jatracey
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure billing offers and Active Directory tenants

This critical design area focuses on the two highest levels of alignment across all of your Azure deployments; your Azure billing offer and the association of that offer with an Azure Active Directory (Azure AD) tenant.

## Design area review

**Involved roles or functions:** This design area will likely require support from one or more of the following functions or roles to make decisions and implement those decisions: [cloud strategy](../../../organize/cloud-strategy.md), [cloud platform](../../../organize/cloud-platform.md), and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The objective of this exercise is to evaluate the various [offer types](https://azure.microsoft.com/support/legal/offer-details/) and Azure Active Directory tenant association is best suited for your overall environment.

**Out of scope:** This design area references *Active Directory or AD*, but it doesn't focus on the identity or management aspects of Azure AD, only the tenant in which your identities will ultimately be hosted. That guidance will be reviewed in the [identity and access management design area](./identity-access.md)

## Design area overview

The Azure service presents a range of [active subscription offers](https://azure.microsoft.com/support/legal/offer-details/), and customers can use these offers at the same time to gain flexible billing options. Example subscriptions include Enterprise Agreement (Enterprise Agreement), Microsoft customer agreement, cloud service provider, and others.

![Diagram that shows Azure scopes within one Azure Active Directory (Azure AD) tenant with various billing offers and subscriptions.](../../enterprise-scale/media/az-scopes-billing.png)

The Azure landing zone architecture supports subscriptions from any [Azure offer](https://azure.microsoft.com/support/legal/offer-details/). Subscriptions can only exist within one Azure Active Directory (Azure AD) tenant to then relocate into the management group hierarchy within that tenant. They can then be managed by the various controls with enterprise-scale platforms like Azure Policy and role-based access control (RBAC).

> [!NOTE]
> The Azure landing zone accelerator implementation is scoped and deployed to one Azure AD tenant; however, billing options can span across multiple Azure AD tenants. For example, an Enterprise Agreement enrollment supports Azure subscriptions across different Azure AD tenants.

Explore the further information, considerations and recommendations for each approach below:

- [Enterprise Agreement (EA)](./azure-billing-enterprise-agreement.md)
- [Microsoft customer agreement (MCA)](./azure-billing-microsoft-customer-agreement.md)
- [Cloud service provider agreement (CSP)](./azure-billing-cloud-solution-provider.md)
- [Define an Azure Active Directory (Azure AD) tenant](./azure-ad-define.md)
