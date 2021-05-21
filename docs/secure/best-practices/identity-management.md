---
title: Secure Identity Management
description: CAF Best Practices - Identity Management
author: lizetpenamsft
ms.author: lipenade
ms.date: 05/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Identity and Access Management Best Practices

## Checklist: how are you managing the identity for your workload?

> [!div class="checklist"]
>
> * Treat identity as the primary security perimeter.
> * Define clear lines of responsibility and separation of duties for each function. Restrict access based on a need-to-know basis and least privilege security principals.
> * Use role-base access control. Assign permissions to users, groups, and applications at a certain scope through Azure RBAC. Use built-in roles when possible.
> * Prevent deletion or modification of a resource, resource group, or subscription through management locks.
> * Use Managed Identities to access resources in Azure.
> * Support a single enterprise directory. Keep the cloud and on-premises directories synchronized, except for critical-impact accounts.
> * Centralize identity management. Designate a single Azure AD directory as the authoritative source for corporate and organizational accounts. Consistency and a single authoritative sources will increase clarity and reduce security risks from human errors and configuration complexity.
> * Set up Azure AD Conditional Access. Enforce and measure key security attributes when authenticating all users, especially for critical-impact, high privilege accounts. 
> * Lower exposure of privilege accounts.
> * Choose a passwordless authentication method when possible.
> * Enable password management and roll our self service password reset. Enable Microsoft's password guidance.
> * Create an organization specific custom banned password list.
> * Block legacy protocols and authentication methods. This can be achieved with Conditional Access.
> * Manage connected tenants.
> * Plan for routine security improvements.
> * Enforce multi-factor verification for users.
> * Enable single sign-on
> * Use Azure AD for storage authentication.
> * Enable Privilege Identity Management for tracking admin roles.
> * Enable Azure Active Directory Identity Protection.
> * Use risk detection to trigger MFA and password changes.
> * Automate threat response.
> * Monitor Azure AD Connect Health in hybrid environments.





## Azure Services for Identity

- [Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) Azure AD allows application management for cloud and on-premises apps using Application Proxy, the My Apps portal or Access Panel, and Software as a Service Apps. It allows authentication, self service password resets, Multi-Factor Authentication, custom banned password list, and smart lockout. It allows developers to build apps that sign in all Microsoft Identities, get tokens to call Microsoft Graph, other Microsoft APIs or custom APIs.Among the features provided by AAD are: conditional access, device management, manage license assignments for enterprise users, access to apps and setup delegates using groups and administrator roles. Use Azure Active Directory Connect and Connect Health to provide a single user identity for authentication and authorization to all resources, regardless of location (cloud or on-premises) through Hybrid Identity. It offers Identity governance and protection, managed identities to access Azure resources, Privileged Identity Management (PIM) as well as reports and monitoring.
- [Azure AD Connect](/azure/active-directory/hybrid/whatis-hybrid-identity) Synchronize Azure AD with your existing on premises Active Directory using Azure AD connect. Often times this is in place already if you have services like O365 or Dynamics Online deployed.
- [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) Azure Active Directory (Azure AD) business-to-business (B2B) collaboration is a feature within External Identities that lets you invite guest users to collaborate with your organization. With B2B collaboration, you can securely share your company's applications and services with guest users from any other organization, while maintaining control over your own corporate data. Work safely and securely with external partners, large or small, even if they don't have Azure AD or an IT department. A simple invitation and redemption process lets partners use their own credentials to access your company's resources. Developers can use Azure AD business-to-business APIs to customize the invitation process or write applications like self-service sign-up portals.
- [Azure AD B2C](/azure/active-directory-b2c/overview) Azure Active Directory B2C provides business-to-customer identity as a service. Your customers use their preferred social, enterprise, or local account identities to get single sign-on access to your applications and APIs. Azure Active Directory B2C (Azure AD B2C) is a customer identity access management solution capable of supporting millions of users and billions of authentications per day. It takes care of the scaling and safety of the authentication platform, monitoring and automatically handling threats like denial-of-service, password spray, or brute force attacks. Azure AD B2C is a white-label authentication solution. You can customize the entire user experience with your brand so that it blends seamlessly with your web and mobile applications. It allows Single Sign On access with a user-provided identity using standards-based authentication protocols including OpenID Connect, OAuth 2.0, and SAML.

Azure AD External Identities focuses less on a user's relationship to your organization and more on how the user wants to sign in to your apps and resources. Within this framework, Azure AD supports a variety of scenarios from business-to-business (B2B) collaboration to access management for consumer/customer- or citizen-facing applications (business-to-customer, or B2C). To compare External Identities solutions and determine which service is best for your scenario, please refer to this article ["Compare External Identity Solutions"](/azure/active-directory/external-identities/compare-with-b2c#compare-external-identities-solutions)

## Managed Identities to Access Azure Resources

Identity Management is at the core of all data protection. Identity-based attacks work because passwords are hard for busy people but are easy target for attackers. Credentials in the source code, passwords that are re-used across environment and services, easy-to-remember passwords are some of the pitfalls that bad actors can exploit.

Use managed identities to access data resources in Azure whenever possible, this will avoid the user of credentials and protect access to the resource using Azure Active Directory. Ideally, credentials are never stored in developers' workstations and aren't checked into source control, using a managed identity allows this identity to authenticate with any service that supports Azure AD authentication, without credentials in the code.

[Managed Identities (MI)](/azure/active-directory/managed-identities-azure-resources/overview) allows you to give a resource in Azure an identity. Internally, managed identities are service principals of a special type, which are locked to only be used with Azure resources. They were formerly known as Managed Service Identities. There are two types of managed identities:

- System-assigned Managed Identity: The life cycle of a system-assigned identity is directly tied to the Azure service instance that it's enabled on. If the instance is deleted, Azure automatically cleans up the credentials and the identity in Azure AD.
- User-assigned Managed Identity: After the identity is created, the identity can be assigned to one or more Azure service instances. The life cycle of a user-assigned identity is managed separately from the life cycle of the Azure service instances to which it's assigned.

[Services that support Managed Identities](/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities#azure-services-that-support-managed-identities-for-azure-resources)

## Examples of securing database access and storage using Managed Identities

- [Secure Azure SQL Database Connection from App Services using Managed Identity](/azure/app-service/app-service-web-tutorial-connect-msi)
- [Connect with Managed Identity to Azure Database for MySQL](/azure/mysql/howto-connect-with-managed-identity)
- [Connect to and Azure Database for PostgreSQL using Managed Identities](/azure/postgresql/howto-connect-with-managed-identity)
- [Connect to Azure Storage using Managed Identities](/azure/search/search-howto-managed-identities-storage)


## Modern Authentication and Provisioning Protocols

Microsoft Azure Active Directory (Azure AD) enables integration with many authentication and synchronization protocols. The authentication integrations enable you to use Azure AD and its security and management features with little or no changes to your applications that use legacy authentication methods. The synchronization integrations enable you to sync user and group data to Azure AD, and then user Azure AD management capabilities

### OAuth 2.0 Authentication with AAD

The OAuth 2.0 is the industry protocol for authorization. It allows a user to grant limited access to its protected resources. Designed to work specifically with Hypertext Transfer Protocol (HTTP), OAuth separates the role of the client from the resource owner. The client requests access to the resources controlled by the resource owner and hosted by the resource server. The resource server issues access tokens with the approval of the resource owner. The client uses the access tokens to access the protected resources hosted by the resource server.

### OpenID Connect

OpenID Connect extends the OAuth 2.0 authorization protocol for use as an authentication protocol, so that you can do single sign-on using OAuth. OpenID Connect introduces the concept of an ID token, which is a security token that allows the client to verify the identity of the user. The ID token also gets basic profile information about the user. It also introduces the UserInfo endpoint, an API that returns information about the user.

For more on Auth 2.0 and OpenID Connect, the terminology, endpoints as well as the grants to securely obtain tokens please refer to [OAuth 2.0 and OpenID Connect Protocols](/azure/active-directory/develop/active-directory-v2-protocols)

The Microsoft identity platform supports authentication for these app architectures:

- [Single-page apps](/azure/active-directory/develop/scenario-spa-overview)
- [Web app that signs in users](/azure/active-directory/develop/scenario-web-app-sign-user-overview)
- [Web app that calls web APIs](/azure/active-directory/develop/scenario-web-app-call-api-overview)
- [Protected Web API](/azure/active-directory/develop/scenario-protected-web-api-overview)
- [Web API that calls web APIs](/azure/active-directory/develop/scenario-web-api-call-api-overview)
- [Desktop app](/azure/active-directory/develop/scenario-desktop-overview)
- [Mobile apps](/azure/active-directory/develop/scenario-mobile-overview)
- [Daemon apps](/azure/active-directory/develop/scenario-daemon-overview)

Applications use the different authentication flows to sign in users and get tokens to call protected APIs. Depending on the type of application and the supported scenario, the token requests will follow different grants or authentication flows: [Scenarios and supported authentication flows](/azure/active-directory/develop/authentication-flows-app-scenarios#scenarios-and-supported-authentication-flows)
[How each flow emits tokens and codes](/azure/active-directory/develop/msal-authentication-flows)

## Microsoft Identity Platform

The following diagram outlines the most common app scenarios and their identity components.

<img src="./../media/application-scenarios-identity-platform.svg" alt="App scenarios and their identity components">

### SAMLv2.0

Security Assertion Markup Language (SAML) is an open standard for exchanging authentication and authorization data between an identity provider and a service provider. SAML is an XML-based markup language for security assertions, which are statements that service providers use to make access-control decisions.
The SAML specification defines three roles:

- The principal, generally a user
- The identity provider (IdP)
- The service provider (SP)
Use when there's a need to provide an single sign-on (SSO) experience for an enterprise SAML application.

### Authentication Libraries

Many developers have built and deployed applications using the Azure Active Directory Authentication Library (ADAL). We now recommend using the Microsoft Authentication Library (MSAL) for authentication and authorization of Azure AD entities.

By using MSAL instead of ADAL:

- You can authenticate a broader set of identities:
    - Azure AD identities
    - Microsoft accounts
    - Social and local accounts by using Azure AD B2C
- Your users will get the best single-sign-on experience.
- Your application can enable incremental consent.
- Supporting Conditional Access is easier.
- You benefit from innovation. Because all Microsoft development efforts are now focused on MSAL, no new features will be implemented in ADAL.

>[!Important]
> **Key take away**:
> MSAL is now the recommended authentication library for use with the Microsoft identity platform.
> Migrate existing apps from Azure Active Directory Authentication Library (ADAL) to Microsoft Authentication Library (MSAL).

## Identity Platform additional considerations

> [!div class="checklist"]
> * Apply [Microsoft Platform Policies](/legal/microsoft-identity-platform/terms-of-use)
> * Keep the information associated to the account used to register and manage apps up-to-date.
> * Implement proper branding guidelines for applications.
> * Provide links to your app terms of service and privacy statements.
> * Manage all redirect URIs.
> * Minimize and manage the list of app registration owners.
> * Don't enable support for OAuth2 implicit grant flow.
> * Move beyond username and password, don't use resource owner password credential flow (ROPC)
> * Protect and manage app credentials for web apps, web APIs and daemon apps. Use certificate credentials instead of password credentials or client secrets.
> * Don't store credentials in code or configuration files. Use manage identities and Azure Key Vault to store and rotate credentials.
> * Use least privilege principle on applications so it only asks for the permissions in needs only when needed.
> * Use modern authentication solutions (OAuth 2.0 and OpenID Connect)
> * Don't program directly against these protocols. Instead, use the Microsoft Authentication Library (MSAL) and migrate apps that use ADAL to use MSAL.
> * In web apps of web APIs, keep one token cache per account.
> * Don't look at the access token value, or attempt to parse it as a client. They can change values, formats, or even become encrypted without warning - always use the id_token if your client needs to learn something about the user, or call Microsoft Graph. 
> * Understand user consent experience
> * Test for Conditional Access Policies.

**Further reading:**
* [Microsoft identity platform (overview)](/azure/active-directory/develop/v2-overview)
* [Microsoft identity platform protocols reference](/azure/active-directory/develop/active-directory-v2-protocols)
* [Access tokens reference](/azure/active-directory/develop/access-tokens)
* [ID tokens reference](/azure/active-directory/develop/id-tokens)
* [Authentication libraries reference](/azure/active-directory/develop/reference-v2-libraries)
* [Permissions and consent in the Microsoft identity platform](/azure/active-directory/develop/v2-permissions-and-consent)


## Identity and Access APIs

With **Microsoft Graph**, you can access [Azure Active Directory](/azure/active-directory/fundamentals/active-directory-whatis) resources to enable scenarios like managing administrator (directory) roles, inviting external users to an organization, and, if you are a Cloud Solution Provider (CSP), managing your customer's data. Microsoft Graph also provides methods that apps can use to, for example, discover information about users' transitive group and role memberships.

Directory resources and APIs can open up new ways for you to engage with users and manage their experiences with Microsoft Graph. You can try the API in the [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).

You can use the [**Azure Active Directory PowerShell Module** Version for Graph](/powershell/module/azuread/?view=azureadps-2.0&preserve-view=true) for Azure AD administrative tasks such as user management, domain management and for configuring single sign-on. The Azure AD PowerShell for Graph module has two versions: a Public preview version and a General Availability version. It is not recommended to use the Public Preview version for production scenarios.

## Use SCIM to automate provisioning on AAD
Azure Active Directory (Azure AD) can automatically provision users and groups to any application or system that is fronted by a web service with the interface defined in the System for Cross-Domain Identity Management (SCIM) 2.0 protocol specification.

Azure AD's support for the SCIM 2.0 protocol is described in Using System for Cross-Domain Identity Management (SCIM) to automatically provision users and groups from Azure Active Directory to applications.

**Further reading:**

* [Decision tree to help you choose between SCIM and Microsoft Graph to automate provisioning](/azure/active-directory/app-provisioning/scim-graph-scenarios)

* [SCIM Protocol Compliance](/azure/active-directory/app-provisioning/application-provisioning-config-problem-scim-compatibility)

## Azure AD Conditional Access

The modern security perimeter now extends beyond an organization's network to include user and device identity. Organizations can utilize these identity signals as part of their access control decisions.

Conditional Access is the tool used by Azure Active Directory to bring signals together, to make decisions, and enforce organizational policies. Conditional Access is at the heart of the new identity driven control plane.

By using Conditional Access policies, you can apply the right access controls when needed to keep your organization secure and stay out of your user's way when not needed.

<img src="./../media/conditional-access-overview.png" alt="Conditional Access Overview">

In the following illustration, user requests to access the on-premises and cloud applications are first checked against a list of conditions. The requests are either allowed access, forced to go through multi-factor authentication, or blocked based on the conditions that they satisfy.

<img src="./../media/conditional-access.png" alt="Conditional Access - User Requests">

**Further reading:**

- [Conditional Access Overview and main concepts](/azure/active-directory/conditional-access/overview)
- [How to build a Conditional Access Policy](/azure/active-directory/conditional-access/concept-conditional-access-policies)

## Overview of Password-less and multi-factor authentication (MFA)

### Passwordless

Features like multi-factor authentication (MFA) are a great way to secure your organization, but users often get frustrated with the additional security layer on top of having to remember their passwords. Passwordless authentication methods are more convenient because the password is removed and replaced with something you have, plus something you are or something you know.

Microsoft global Azure offer the following three passwordless authentication options that integrate with Azure Active Directory (Azure AD):

- Windows Hello for Business
- Microsoft Authenticator app
- FIDO2 security keys



### Multi-factor Authentication

Multi-factor authentication is a process where a user is prompted during the sign-in process for an additional form of identification, such as to enter a code on their cellphone or to provide a fingerprint scan.

If you only use a password to authenticate a user, it leaves an insecure vector for attack. If the password is weak or has been exposed elsewhere, is it really the user signing in with the username and password, or is it an attacker? When you require a second form of authentication, security is increased as this additional factor isn't something that's easy for an attacker to obtain or duplicate.

Azure AD Multi-Factor Authentication works by requiring two or more of the following authentication methods:

- Something you know, typically a password.
- Something you have, such as a trusted device that is not easily duplicated, like a phone or hardware key.
- Something you are - biometrics like a fingerprint or face scan.

**Further Reading:**

- [Deploying Passwordless Authentication](/azure/active-directory/authentication/howto-authentication-passwordless-deployment)
- [How MFA works](/azure/active-directory/authentication/concept-mfa-howitworks)

## Privilege Identity Management

Privileged Identity Management is a domain within Identity Management focused on the special requirements of powerful accounts within the IT infrastructure of an enterprise. It is frequently used as an Information Security and governance tool to help companies in meeting compliance regulations and to prevent internal data breaches through the use of privileged accounts.

Privileged Identity Management (PIM) is a service in Azure Active Directory (Azure AD) that enables you to manage, control, and monitor access to important resources in your organization. It is part of Identity Governance in Azure AD and enables just-in-time and scheduled access, approval workflows for Azure AD and Azure Resource roles.

### Reasons to use PIM, what does it do?

Organizations want to minimize the number of people who have access to secure information or resources, because that reduces the chance of a malicious actor getting that access, or an authorized user inadvertently impacting a sensitive resource. However, users still need to carry out privileged operations in Azure AD, Azure, Microsoft 365, or SaaS apps. Organizations can give users just-in-time privileged access to Azure resources and Azure AD.

Here are some of the key features of Privileged Identity Management:

- Provide just-in-time privileged access to Azure AD and Azure resources
- Assign time-bound access to resources using start and end dates
- Require approval to activate privileged roles
- Enforce multi-factor authentication to activate any role
- Use justification to understand why users activate
- Get notifications when privileged roles are activated
- Conduct access reviews to ensure users still need roles
- Download audit history for internal or external audit

*Using this feature requires an Azure AD Premium P2 license.*

## Security Controls for Identity Management

[Security Control V2: Identity Management](/security/benchmark/azure/security-controls-v2-identity-management)

- IM-1 [Standardize Azure Active Directory as the central identity and authentication system](/security/benchmark/azure/security-controls-v2-identity-management#im-1-standardize-azure-active-directory-as-the-central-identity-and-authentication-system)
- IM-2: [Manage application identities securely and automatically](/security/benchmark/azure/security-controls-v2-identity-management#im-2-manage-application-identities-securely-and-automatically)
- IM-3: [Use Azure AD single sign-on (SSO) for application access](/security/benchmark/azure/security-controls-v2-identity-management#im-3-use-azure-ad-single-sign-on-sso-for-application-access)
- IM-4: [Use strong authentication controls for all Azure Active Directory based access](/security/benchmark/azure/security-controls-v2-identity-management#im-4-use-strong-authentication-controls-for-all-azure-active-directory-based-access)
- IM-5: [Monitor and alert on account anomalies](/security/benchmark/azure/security-controls-v2-identity-management#im-5-monitor-and-alert-on-account-anomalies)
- IM-6: [Restrict Azure resource access based on conditions](/security/benchmark/azure/security-controls-v2-identity-management#im-6-restrict-azure-resource-access-based-on-conditions)
- IM-7: [Eliminate unintended credential exposure](/security/benchmark/azure/security-controls-v2-identity-management#im-7-eliminate-unintended-credential-exposure)
- IM-8: [Secure user access to legacy applications](/security/benchmark/azure/security-controls-v2-identity-management#im-8-secure-user-access-to-legacy-applications)







## Summary

- When communicating with Azure platform services managed identities are preferred over API keys and connection strings.Try to avoid authentication with keys (connection strings, API keys etc.) and always prefer Managed Identities (formerly also known as Managed Service Identity, MSI). Managed identities enable Azure Services to authenticate to each other without presenting explicit credentials via code. Typical use case is a Web App accessing Key Vault credentials or a Virtual Machine accessing SQL Database.
- All APIs in this workload require clients to authenticate.API URLs used by client applications are exposed to attackers (JavaScript code on a website can be viewed, mobile application can be decompiled and inspected) and should be protected. For internal APIs, requiring authentication can increase the difficulty of lateral movement if an attacker obtains network access. Typical mechanisms include API keys, authorization tokens, IP restrictions or Azure Managed identities.
- Modern authentication protocols (OAuth 2.0, OpenID) are used by this workload. Modern authentication protocols support strong controls such as MFA and should be used instead of legacy.
- Azure Active Directory or other managed identity provider (Microsoft Account, Azure B2C etc.) is used for user authentication.If possible, applications should utilize Azure Active Directory or other managed identity providers (such as Microsoft Account, Azure B2C...) to avoid managing user credentials with custom implementation. Modern protocols like OAuth 2.0 use token-based authentication with limited timespan, identity providers offer additional functionality like multi-factor authentication, password reset etc.
- Authentication via identity services is prioritized for this workload vs. cryptographic keys.Consideration should always be given to authenticating with identity services rather than cryptographic keys when available. Managing keys securely with application code is difficult and regularly leads to mistakes like accidentally publishing sensitive access keys to code repositories like GitHub. Identity systems (such as Azure Active Directory) offer secure and usable experience for access control with built-in sophisticated mechanisms for key rotation, monitoring for anomalies, and more.
- Conditional access policies are implemented for users of this workload.Modern cloud-based applications are often accessible over the internet and location-based networking restrictions don't make much sense, but it needs to be mapped and understood what kind of restrictions are required. Multi-factor Authentication (MFA) is a necessity for remote access, IP-based filtering can be used to enable ad-hoc debugging, but VPNs are preferred.
- Password-less or multi-factor authentication (MFA) is enforced for users of this workload.Attack methods have evolved to the point where passwords alone cannot reliably protect an account. Modern authentication solutions including password-less and multi-factor authentication increase security posture through strong authentication.
- Current on-premises Active Directory is synchronized with Azure AD or other cloud identity system.

## Further reading

* [Identity Management Best Practices](/azure/security/fundamentals/identity-management-best-practices)

* [Security Checklist for Identity Management](/azure/security/fundamentals/steps-secure-identity)

* [Choose passwordless authentication](/azure/active-directory/authentication/concept-authentication-passwordless)

* [Microsoft security best practices for Identity and Access Management](/security/compass/identity)

* [AAD deployment 30, 90 and beyond](/azure/active-directory/fundamentals/active-directory-deployment-checklist-p2)

* [Identity Platform Best Practices](/azure/active-directory/develop/identity-platform-integration-checklist)
