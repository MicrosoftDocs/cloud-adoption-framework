---
title: "Centralize management operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Guidance on centralizing management operations
author: JnHs
ms.author: jenhayes
ms.date: 09/27/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Centralize management operations

For most organizations, using a single Azure Active Directory (Azure AD) tenant for all users simplifies management operations and reduces maintenance costs, since all management tasks can be by designated users, user groups, or service principals within that tenant. We recommend using only one Azure AD tenant for your organization if possible.

However, there are situations that may require an organization to maintain multiple Azure AD tenants. For example, multiple tenants may be required due to:

- Wholly independent subsidiaries.
- Operating independently in multiple geographies.
- Legal or compliance requirements.
- Acquisitions of other organizations (sometimes temporary until a long-term tenant consolidation strategy is defined).

In cases where a multiple-tenant architecture is required, [Azure Lighthouse](https://docs.microsoft.com/azure/lighthouse/overview) provides a way to centralize and streamline management operations. Subscriptions from multiple tenants can be onboarded for [Azure delegated resource management](https://docs.microsoft.com/azure/lighthouse/concepts/azure-delegated-resource-management), allowing specified users in the managing tenant to perform [cross-tenant management functions](https://docs.microsoft.com/azure/lighthouse/concepts/cross-tenant-management-experience) in a centralized and scalable manner.

For example, say your organization has a single tenant, *Tenant A*. Your organization then acquires two additional tenants, *Tenant B* and *Tenant C*, and you have business reasons that require you to maintain them as separate tenants.

Your organization wants to use the same policy definitions, backup practices, and security processes across all tenants. Since you already have users (including user groups and service principals) that are responsible for performing these tasks within Tenant A, you can onboard all of the subscriptions within Tenant B and Tenant C so that those same users in Tenant A can perform those tasks. Tenant A then becomes the managing tenant for Tenant B and Tenant C.

![Users in Tenant A managing resources in Tenant B and Tenant C](../_images/manage/enterprise-azure-lighthouse.jpg)

For more information, see [Azure Lighthouse in enterprise scenarios](https://docs.microsoft.com/azure/lighthouse/concepts/enterprise).
