---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---


Point to: https://docs.microsoft.com/en-us/security/compass/identity

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "managing identity" question at the CAF level

- When communicating with Azure platform services managed identities are preferred over API keys and connection strings.Try to avoid authentication with keys (connection strings, API keys etc.) and always prefer Managed Identities (formerly also known as Managed Service Identity, MSI). Managed identities enable Azure Services to authenticate to each other without presenting explicit credentials via code. Typical use case is a Web App accessing Key Vault credentials or a Virtual Machine accessing SQL Database.
- All APIs in this workload require clients to authenticate.API URLs used by client applications are exposed to attackers (JavaScript code on a website can be viewed, mobile application can be decompiled and inspected) and should be protected. For internal APIs, requiring authentication can increase the difficulty of lateral movement if an attacker obtains network access. Typical mechanisms include API keys, authorization tokens, IP restrictions or Azure Managed identities.
- Modern authentication protocols (OAuth 2.0, OpenID) are used by this workload.Modern authentication protocols support strong controls such as MFA and should be used instead of legacy.
- Azure Active Directory or other managed identity provider (Microsoft Account, Azure B2C etc.) is used for user authentication.If possible, applications should utilize Azure Active Directory or other managed identity providers (such as Microsoft Account, Azure B2C...) to avoid managing user credentials with custom implementation. Modern protocols like OAuth 2.0 use token-based authentication with limited timespan, identity providers offer additional functionality like multi-factor authentication, password reset etc.
- Authentication via identity services is prioritized for this workload vs. cryptographic keys.Consideration should always be given to authenticating with identity services rather than cryptographic keys when available. Managing keys securely with application code is difficult and regularly leads to mistakes like accidentally publishing sensitive access keys to code repositories like GitHub. Identity systems (such as Azure Active Directory) offer secure and usable experience for access control with built-in sophisticated mechanisms for key rotation, monitoring for anomalies, and more.
- Conditional access policies are implemented for users of this workload.Modern cloud-based applications are often accessible over the internet and location-based networking restrictions don't make much sense, but it needs to be mapped and understood what kind of restrictions are required. Multi-factor Authentication (MFA) is a necessity for remote access, IP-based filtering can be used to enable ad-hoc debugging, but VPNs are preferred.
- Password-less or multi-factor authentication (MFA) is enforced for users of this workload.Attack methods have evolved to the point where passwords alone cannot reliably protect an account. Modern authentication solutions including password-less and multi-factor authentication increase security posture through strong authentication.
- Current on-premises Active Directory is synchronized with Azure AD or other cloud identity system.
