---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: anlucen
ms.author: doalle
ms.date: 06/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Identity and Access Management design area

This critical design area establishes a foundation for the management of identity and access.

## Design area review

**Involved roles or functions:** This design area likely requires support from one or more of the following functions or roles. These roles can help make decisions and implement those decisions:

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The goal of this exercise is to evaluate options for your identity and access foundation. At minimum, you should make decisions about your approach for synchronizing identities with Azure Active Directory:

- Authenticating users
- Assigning access to resources
- Any core requirements for separation of duties

**Out of scope:** This design area forms a foundation for proper access control. But, it doesn't fully address more advanced issues like:

- Zero trust
- Operational management of elevated privileges
- Automated guardrails to prevent common identity and access mistakes

That guidance is reviewed in the compliance design areas related to [security](./security.md) and [governance](./governance.md). Those areas usually require a broader audience to make and act on decisions.

## Design area overview

Identity provides the basis for a large percentage of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to help organizations make highly secure, operationally efficient environments as outlined here.

This section examines design considerations and recommendations related to IAM in a cloud environment.

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, IAM lets the right individuals access the right resources at the right time for the right reasons.

> [!div class="nextstepaction"]
> [Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
