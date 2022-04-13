---
title: Security considerations for Azure API Management
description: <<Describe how this landing zone accelerator can improve security for Azure API Management.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Security considerations for API Managementlanding zone accelerator

[Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.]

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

- Consider how you want to secure your frontend APIs beyond using subscription keys. OAuth 2.0, OpenID Connect, and mutual TLS are common options with built-in support.
- Think about how you want to protect your backend services behind API Management. Client certificates and OAuth 2.0 are two supported options.
- Consider which client and backend protocols and ciphers are required to meet your security requirements.
- API Management validation policies are available to validate API requests and responses against an OpenAPI schema. These is not a replacement for a Web Application Firewall but can provide additional protection against some threats. Note that adding validation policies can have performance implications, so we recommend performance load tests to assess their impact on API throughput.
- Consider which identity providers besides Azure AD need to be supported.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of API Management.

- Deploy a Web Application Firewall (WAF) in front of API Management to provide protection against common web application exploits and vulnerabilities. 
- Use Azure Key Vault to securely store and manage secrets and make them available through named values within API Management.
- Create a system assigned Managed Identity within API Management to establish trust relationships between the service and other resources protected by Azure Active Directory, including Key Vault and backend services.
- APIs should only be accessible over HTTPS to protect data in-transit and ensure its integrity.
- Use the latest TLS version when encrypting information in transit and disable outdated and unnecessary protocols and ciphers when possible.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for <<Token-LongName>>.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.
