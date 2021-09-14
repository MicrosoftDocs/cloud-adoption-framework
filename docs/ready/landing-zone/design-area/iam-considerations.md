---
title: Identity and access management considerations
description: Understand identity and access management considerations as part of the Azure landing zone design areas.
author: dominicallen
ms.author: doalle
ms.date: 09/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

## Identity and access management Design considerations

- There are limits around the number of custom roles and role assignments that must be considered when you lay down a framework around IAM and governance. For more information, see [Azure RBAC service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-role-based-access-control-limits).
- There's a limit of 2,000 role assignments per subscription.
- There's a limit of 500 role assignments per management group.
- Centralized versus federated resource ownership:
  - Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It's standard practice for any organization that grants or denies access to confidential or critical business resources.
  - Managing application resources that don't violate security boundaries or other aspects required to maintain security and compliance can be delegated to application teams. Allowing users to provision resources within a securely managed environment allows organizations to take advantage of the agile nature of the cloud while preventing the violation of any critical security or governance boundary.
  - Depending on the definition of the centralized or federated resource ownership, custom roles might differ. The custom roles for the centralized resource ownership are limited and might need additional rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. But in other organizations that need a more centralized approach, the NetOps role needs to be enriched with more allowed actions like creating peering between the hub and the spokes.

## Authentication in a landing zone design considerations

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend an existing on-premises identity domain into Azure or to create a brand new one. Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD Domain Services (Azure AD DS), or both. Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS local host authentication and group policy management.

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone.
- Applications that rely on domain services and use older protocols can use [Azure AD DS](/azure/active-directory-domain-services).
- There is a difference between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs, and understand and document the authentication provider that each one will be using. Plan accordingly for all applications.