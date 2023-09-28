---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm
ms.topic: conceptual
ms.date: 09/19/2023
---

# Azure identity and access management design area

This critical design area establishes a foundation for the management of identity and access based on best practices.

The technological landscape in the enterprise is becoming complex and heterogenous. Identity is the primary security perimeter in a public cloud, so Identity and access management must be treated as the foundation of any secure and fully compliant public cloud architecture.

Robust identity and access management forms the basis of modern security. Authorization and access controls ensure that only authenticated users with verified devices can access and administer applications. It ensures that the right individual access the right resources at the right time, and for the right reason. It also provides reliable audit logging and nonrepudiation of user action.

Azure offers a comprehensive set of services, tools, and reference architectures to help organizations make highly secure, operationally efficient environments.

## Design area review

**Involved roles or functions:** Identity and access management require support from one or both of the following functions. These roles can help make decisions and implement those decisions:

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)
- [Cloud security team](../../../organize/cloud-security.md)

**Scope:** The goal of this design area is to evaluate options for your identity and access foundation. It includes:

- Authenticating users
- Assigning access to resources
- Core requirements for separation of duties
- Using hybrid identities with Active Directory Domain Services domains

**Out of scope:** Identity and access management forms a foundation for proper access control. It doesn't fully address more advanced issues, including these issues:

- Zero trust
- Operational management of elevated privileges
- Automated guardrails to prevent common identity and access mistakes

These topics are addressed in the compliance design areas related to [security](./security.md) and [governance](./governance.md). Additionally, the [Azure Identity Management and access control security best practices](/azure/security/fundamentals/identity-management-best-practices) guide provides a comprehensive set of recommendations for identity and access management.

## Design area overview

Identity provides the basis for a wide variety of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps decide which requests should be permitted.

Identity and access management is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture.

These articles examine design considerations and recommendations related to identity and access management in a cloud environment:

- [Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
- [Application access](identity-access-application-access.md)
- [Prerequisites for a landing zone](identity-access-landing-zones.md)

> [!TIP]
> If you have multiple Azure Active Directory tenants, review [Azure landing zones and multiple Azure Active Directory tenants](multi-tenant/overview.md) and its associated content.

## Next steps

> [!div class="nextstepaction"]
> [Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
