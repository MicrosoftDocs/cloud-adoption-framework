---
title: Security considerations for Azure API Management
description: Learn about design considerations and recommendations for security in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Security considerations for the API Management landing zone accelerator

This article provides design considerations and recommendations for security when using the API Management landing zone accelerator. Security covers multiple aspects including securing the frontend APIs, securing backends, and securing the developer portal.

Learn more about the [security](../../../ready/landing-zone/design-area/security.md) design area.

## Design considerations

- Consider how you want to secure your frontend APIs beyond using [subscription keys](/azure/api-management/api-management-howto-create-subscriptions). [OAuth 2.0](/azure/api-management/api-management-howto-protect-backend-with-aad), OpenID Connect, and [mutual TLS](/azure/api-management/api-management-howto-mutual-certificates-for-clients) are common options with built-in support.
- Think about how you want to protect your backend services behind API Management. [Client certificates](/azure/api-management/api-management-howto-mutual-certificates) and [OAuth 2.0](/azure/api-management/api-management-howto-protect-backend-with-aad) are two supported options.
- Consider which client and backend [protocols and ciphers](/azure/api-management/api-management-howto-manage-protocols-ciphers) are required to meet your security requirements.
- Consider API Management [validation policies](/azure/api-management/validation-policies) to validate REST or SOAP API requests and responses against schemas defined in the API definition or uploaded to the instance. These policies are not a replacement for a Web Application Firewall but can provide additional protection against some threats.
  > [!NOTE]
  > Adding validation policies can have performance implications, so we recommend performance load tests to assess their impact on API throughput.
- Consider which identity providers besides Microsoft Entra ID need to be supported.

## Design recommendations

- Deploy a Web Application Firewall (WAF) in front of API Management to protect against common web application exploits and vulnerabilities.
- Use Azure Key Vault to securely store and manage secrets and make them available through [named values](/azure/api-management/api-management-howto-properties) in API Management.
- Create a [system-assigned managed identity](/azure/api-management/api-management-howto-use-managed-service-identity) in API Management to establish trust relationships between the service and other resources protected by Microsoft Entra ID, including Key Vault and backend services.
- APIs should only be accessible over HTTPS to protect data in-transit and ensure its integrity.
- Use the latest TLS version when encrypting information in transit. Disable outdated and unnecessary protocols and ciphers when possible.

## Enterprise scale assumptions

The following are assumptions that went into the development of the API Management landing zone accelerator:

- Configuration of Azure Application Gateway as a WAF.
- Protection of the API Management instance in a VNet that controls internal and external connectivity.

## Next steps

- See [Azure security baseline for API Management](/security/benchmark/azure/baselines/api-management-security-baseline?toc=/azure/api-management/TOC.json) for additional guidance on securing your API Management environments.
