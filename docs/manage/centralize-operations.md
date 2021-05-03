---
title: Centralize management operations
description: Learn to centralize management operations by using a single Azure Active Directory tenant for all users. Centralized management simplifies management operations and reduces maintenance costs.
author: JnHs
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# Centralize management operations

For most organizations, using a single Azure Active Directory (Azure AD) tenant for all users simplifies management operations and reduces maintenance costs. This is because all management tasks can be by designated users, user groups, or service principals within that tenant.

We recommend that you use only one Azure AD tenant for your organization, if possible. However, some situations might require an organization to maintain multiple Azure AD tenants for the following reasons:

- They are wholly independent subsidiaries.
- They're operating independently in multiple geographies.
- Certain legal or compliance requirements apply.
- There are acquisitions of other organizations (sometimes temporary until a long-term tenant consolidation strategy is defined).

When a multiple-tenant architecture is required, [Azure Lighthouse](/azure/lighthouse/overview) provides a way to centralize and streamline management operations. Subscriptions from multiple tenants can be onboarded for [Azure delegated resource management](/azure/lighthouse/concepts/azure-delegated-resource-management). This option allows specified users in the managing tenant to perform [cross-tenant management functions](/azure/lighthouse/concepts/cross-tenant-management-experience) in a centralized and scalable manner.

For example, let's say your organization has a single tenant, `Tenant A`. The organization then acquires two additional tenants, `Tenant B` and `Tenant C`, and you have business reasons that require you to maintain them as separate tenants.

Your organization wants to use the same policy definitions, backup practices, and security processes across all tenants. Because you already have users (including user groups and service principals) that are responsible for performing these tasks within `Tenant A`, you can onboard all of the subscriptions within `Tenant B` and `Tenant C` so that those same users in `Tenant A` can perform those tasks. `Tenant A` then becomes the managing tenant for `Tenant B` and `Tenant C`.

![Users in Tenant A managing resources in Tenant B and Tenant C](../_images/manage/enterprise-azure-lighthouse.jpg)

For more information, see [Azure Lighthouse in enterprise scenarios](/azure/lighthouse/concepts/enterprise).
