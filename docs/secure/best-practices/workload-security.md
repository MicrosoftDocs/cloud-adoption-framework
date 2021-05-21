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

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "securing your workload" question at the CAF level

**Note: For this article, we should focus on items that would be applied across multiple workloads / considered a standard to be applied across all workloads. For singular-workload and further detail, point to articles in https://aka.ms/waf as well as pointing the reader to the Well-Architected Framework in general.**

- Cloud services are used for well-established functions instead of building custom service implementations.Developers should use services available from a cloud provider for well-established functions like databases, encryption, identity directory, and authentication instead of writing custom versions or third-party solutions that must be integrated into the cloud provider.
- Detailed error messages and verbose information are hidden from the end user/client applications. Exceptions in code are handled gracefully and logged.Providing unnecessary information to end users in case of application failure should be avoided. Revealing detailed error information (call stack, SQL queries, out of range errors...) can provide attackers with valuable information about the internals of the application. Error handlers should make the application fail gracefully and log the error.
- Platform specific information (e.g. web server version) is removed from server-client communication channels.Information revealing the application platform, such as HTTP banners containing framework information ("X-Powered-By", "X-ASPNET-VERSION"), are commonly used by malicious actors when mapping attack vectors of the application. HTTP headers, error messages, website footers etc. should not contain information about the application platform. Azure CDN or Cloudflare can be used to separate the hosting platform from end users, Azure API Management offers transformation policies that allow to modify HTTP headers and remove sensitive information.
- CDN (content delivery network) is used to separate the hosting platform and end-users/clients.Azure CDN can be used to separate the hosting platform from end users. Azure CDN contains a rule engine to remove platform-specific information and headers. The use of Azure CDN or 3rd party CDN will have different cost implications depending on what is chosen for the workload.
- Application configuration is stored using a dedicated configuration management system (Azure App Configuration, Azure Key Vault etc.)Application configuration information can be stored together with the application itself or preferably using a dedicated configuration management system like Azure App Configuration or Azure Key Vault. Keys and secrets shouldn't be included in application configuration.
- Access to data storage is identity-based, whenever possible.Protecting data at rest is required to maintain confidentiality, integrity, and availability assurances across all workloads. Cloud service providers make multiple methods of access control available - shared keys, shared signatures, anonymous access, identity provider-based. Identity provider methods (such as AAD and RBAC) are the least liable to compromise and enable more fine-grained role-based access controls.
- Authentication tokens are cached securely and encrypted when sharing across web servers.OAuth tokens are usually cached after they've been acquired. Application code should first try to get tokens silently from a cache before attempting to acquire a token from the identity provider, to optimise performance and maximize availability. Tokens should be stored securely and handled as any other credentials. When there's a need to share tokens across application servers (instead of each server acquiring and caching their own) encryption should be used.
- There are controls in place for this workload to detect and protect from data exfiltration.
