---
title: Enterprise enrollment considerations for AKS
description: AKS guidelines for enterprise enrollment
author: brianblanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

<!-- docutune:casing "HPA" -->

# Enterprise enrollment considerations for AKS

For most customer implementations, standard best practices around enterprise enrollment and Active Directory tenants are unchanged when deploying Azure landing zones for AKS. There are seldom specific considerations or recommendations that would impact enterprise enrollment or Active Directory tenant decisions. See the following considerations to determine whether AKS requirements would impact existing tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing [enterprise enrollment or Active Directory tenant decisions](../../ready/enterprise-scale/enterprise-enrollment-and-azure-ad-tenants.md).

You might also want to review the [identity and access management considerations](./eslz-identity-and-access-management.md) to understand how the Active Directory tenant is applied in the design of authentication and authorization solutions. You might also want to evaluate the [resource organization considerations](./eslz-resource-organization.md) to understand how the enrollment might be organized into management groups, subscriptions, and resource groups.

## Design considerations

Most customers will identify their primary Azure AD tenant as their Kubernetes role-based access control (RBAC) Azure AD tenant. But, Kubernetes allows for different elevations of RBAC management. There are situations where you might want to establish a different Kubernetes RBAC Azure AD tenant from the tenant, which governs identity for the landing zone. This can lead to some specific considerations when establishing Azure landing zones for AKS. The following are indicators that might lead you to consider this alternative approach to tenant assignment:

- Will the landing zone or Kubernetes hosts be used as part of clean-room development?
- Are there heightened compliance requirements, which specify separation of duties between the people operating the host and the accounts that operate the landing zone environment?
- In a centrally managed environment with multiple hosts in a single landing zone, is there a need for extended blast radius control for compromised identities?

Managing multiple Azure AD tenants comes at a management cost that must be weighed against the benefits gained from such a topology. There are seldom cases with multiple tenants would be part of any Microsoft recommendation. But the above questions could indicate a need to consider this option.
