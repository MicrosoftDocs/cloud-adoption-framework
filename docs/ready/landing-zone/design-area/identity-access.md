---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: anlucen
ms.author: martinek
ms.date: 06/24/2022
ms.topic: conceptual
s.custom: think-tank, UpdateFrequency.5
---

# Azure identity and access management design area

This critical design area establishes a foundation for the management of identity and access.

## Design area review

**Involved roles or functions:** Identity and access management require support from one or both of the following functions. These roles can help make decisions and implement those decisions:

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The goal of this design area is to evaluate options for your identity and access foundation. At minimum, make decisions about your approach for synchronizing identities with Azure Active Directory:

- Authenticating users
- Assigning access to resources
- Any core requirements for separation of duties

**Out of scope:** Identity and access management forms a foundation for proper access control. It doesn't fully address more advanced issues, including these issues:

- Zero trust
- Operational management of elevated privileges
- Automated guardrails to prevent common identity and access mistakes

Review guidance in the compliance design areas related to [security](./security.md) and [governance](./governance.md). Those areas usually require a broader audience to make and act on decisions.

## Design area overview

Identity provides the basis for a wide variety of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps decide which requests should be permitted.

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, identity and access management lets the right individuals access the right resources at the right time for the right reasons.

Identity and access management is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to help organizations make highly secure, operationally efficient environments.

These articles examine design considerations and recommendations related to identity and access management in a cloud environment:

- [Azure Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
- [Platform access](identity-access-platform-access.md)
- [Prerequisites for a landing zone](identity-access-landing-zones.md)

>[!TIP]
> If you have multiple Azure Active Directory tenants, review [Azure landing zones and multiple Azure Active Directory tenants](multi-tenant/overview.md) and its associated content.

## Next steps

> [!div class="nextstepaction"]
> [Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
