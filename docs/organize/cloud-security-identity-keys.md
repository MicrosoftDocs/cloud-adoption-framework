---
title: Function of identity and key management in the cloud
description: Understand the function of identity and key management in the cloud.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Function of identity and key management in the cloud

The main objective of a security team working on identity management is to provide authentication and authorization of humans, services, devices, and applications. Key and certification management provides secure distribution and access to key material for cryptographic operations (which often support similar outcomes as identity management).

## Modernization

Data identity and key management modernization is being shaped by:

- Identity and key/certification management disciplines are coming closer together as they both provide assurances for authentication and authorization to enable secure communications.
- Identity controls are emerging as a primary security perimeter for cloud applications
- Key-based authentication for cloud services is being replaced with identity management because of the difficulty of storing and securely providing access to those keys.
- Critical importance of carrying positive lessons learned from on-premises identity architectures such as single identity, single sign-on (SSO), and native application integration.
- Critical importance of avoiding common mistakes of on-premises architectures that often overcomplicated them, making support difficult and attacks easier. These include:
  - Sprawling groups and organizational units (OUs).
  - Sprawling set of third-party directories and identity management systems.
  - Lack of clear standardization and ownership of application identity strategy.
- Credential theft attacks remain a high impact and high likelihood threat to mitigate.
- Service accounts and application accounts remaining a top challenge, but becoming easier to solve. Identity teams should actively embrace the cloud capabilities that are beginning to solve this like [Azure AD managed identities](/azure/active-directory/managed-identities-azure-resources/overview).

## Team composition and key relationships

Identity and key management teams need to build strong relationships with the following roles:

- IT architecture and operations
- Security architecture and operations
- Development teams
- Data security teams
- Privacy teams
- Legal teams
- Compliance/risk management teams

## Next steps

Review the function of [infrastructure and endpoint security](./cloud-security-infrastructure-endpoint.md)
