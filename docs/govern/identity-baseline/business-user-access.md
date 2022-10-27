---
title: Business user access governance guidance
description: 
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Business user access

Risks related to governing Business Users are largely related to the complexity of your organization's identity infrastructure. If all your users and groups are managed using a single directory or cloud-native identity provider using minimal integration with other services, your risk level will likely be small. The following sections provide guidance, and auditing that can be used to minimize the risk surrounding business users.

## Guidance

Risks and governance policies addressing the risk will differ between organization, but the following serve as common identity-related policies that you can use as a starting point for baselining your business user access governance:

- Use [automated user provisioning](/azure/active-directory/app-provisioning/how-provisioning-works) for the creation, maintenance, and removal of user identities. Synchronize with your HR tools and processes to set a good foundation for ongoing identity governance and to enhances the quality of business processes that rely on authoritative identity data.
- Require [multifactor authentication (MFA)](/azure/active-directory/authentication/howto-mfa-getstarted) and use [Conditional Access policies](/azure/active-directory/conditional-access/plan-conditional-access) when users must access sensitive applications.
- Enable [Azure Active Directory Identity Protection](/azure/active-directory/identity-protection/overview-identity-protection) to track risky sign-ins and compromised credentials.
- Use [risk detections to trigger MFA and password changes](/azure/active-directory/authentication/tutorial-risk-based-sspr-mfa).

## Audit

TODO: Can we take the links from the OneNote below and create some prescriptive audit guidance around it? Remember, we are telling the reader what to audit, how and when. We should add context to the links we are providing.

- [Microsoft.Graph.Identity.Governance](/powershell/module/microsoft.graph.identity.governance/)
- [Azure AD access reviews](/graph/api/resources/accessreviewsv2-overview?view=graph-rest-1.0)
- [Working with the Azure AD entitlement management API](/graph/api/resources/entitlementmanagement-overview)
