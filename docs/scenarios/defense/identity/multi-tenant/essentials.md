---
title: Identity essentials for multi-tenant Defense organizations
description: An overview of identity essentials for multi-tenant Defense organizations in Azure Active Directory
author: stephen-sumner
ms.author: andrmass
ms.reviewer: ssumner
ms.date: 06/30/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---
# Identity essentials for multi-tenant defense organizations

Zero Trust architecture is emerging as a key strategy for ensuring the integrity and confidentiality of sensitive information in defense organizations. Identity is a foundational pillar of Zero Trust. It's important to understand how Azure AD serves as a critical component in implementing a Zero Trust model. Understanding its core concepts and functionalities is imperative before delving into the practical aspects of building a Zero Trust environment. The following guide provides essential insights into Azure AD, tailored specifically to defense scenarios.

## Azure AD tenant

An instance of Azure AD is called an **Azure AD tenant**. The tenant is boundary. It’s your personalized instance of Azure AD and forms a security boundary for Microsoft cloud services. It provides robust protection for sensitive defense identity data.

**Organizations should consolidate Azure AD tenants.** Microsoft recommends one Azure AD tenant per organization. This setup is the most cohesive experience for users and administrators alike while minimizing licensing cost. A single identity platform for Microsoft 365 (Microsoft 365), Azure, PowerPlatform, line-of-business (LOB) applications, Software-as-a-Service (SaaS) providers, and cloud service providers (CSP) provides the most comprehensive zero trust capabilities. Organizations with multiple Azure AD tenants must manage different sets of users, groups, applications, and policies, increasing cost and adding administrative complexity.

**Azure AD is not Active Directory in the cloud.** Azure AD isn’t an evolution of Active Directory Domain Services (AD DS). The tenant concept is like an Active Directory Forest but different. Azure AD is a reimagined, hyperscale, modern, distributed identity service.

**Tenant domain name.** Each tenant has a unique initial domain name. For example, using *contoso* as an example, the domain would be *contoso.onmicrosoft.com* for all commercial customers, *contoso.onmicrosoft.us* for most government customers, and tenant ID in the form of a Globally Unique Identifier (GUID) like *a976dd56-c1d8-485c-8ea7-facbce6726c2.* Each tenant only has one immutable initial domain. You can't change the initial domain or tenant ID after tenant creation.

Member users in your tenant must have a username with a suffix matching the initial domain, or using a [**custom domain**](/azure/active-directory/fundamentals/add-custom-domain) you create and verify via DNS records. Custom domains allow users to sign in with a friendly username, usually their email address ([user@contoso.com](mailto:user@contoso.com)). You can only verify a custom domain in one Azure AD tenant globally.

Note: Custom domains aren't security or trust boundaries like Active Directory Domain Services (AD DS) Forests. They're simply DNS namespace for globally identifying Azure AD users.

## Architecture

Azure AD has no domain controllers, organizational units, group policy objects, domain/forest trusts, or FSMO roles. Azure AD is Software-as-a-Service, is accessed via RESTful APIs and modern authentication and authorization protocols and uses a flat structure with resource-based delegation. Each instance of Azure AD is a [highly available](/azure/active-directory/fundamentals/active-directory-architecture) data store containing identity, policy, and configuration objects replicated across Azure regions, and data redundancy for critical defense information.

## Identities

The two main types of identities in Azure AD are users and service principals.

**Users** are identities for individuals accessing Microsoft and federated cloud services. Users can either be members or guests in an instance of Azure AD. Usually, members are internal to your organization and guests belong to an external organization like a mission partner or defense contractor. To learn more about guest users and collaboration between organizations, see [B2B collaboration overview](/azure/active-directory/external-identities/what-is-b2b).

**Service principals** are nonperson entities (NPE) in Azure AD. Service principals can represent applications, service / automation accounts, and Azure resources. Even [non-Azure resources](/azure/azure-arc/servers/managed-identity-authentication), such as on-premises servers, can have a service principal in Azure AD and interact with other Azure resources. Service principals are useful in automating defense workflows and managing applications critical to defense operations. For more information, see [Application and service principal objects in Azure Active Directory](/azure/active-directory/develop/app-objects-and-service-principals).

You can use Azure AD Connect Sync or Azure AD Connect Cloud Sync to synchronize user, group, and computer (device) objects in Active Directory Domain Services with Azure AD. This configuration is called [hybrid identity](/azure/active-directory/hybrid/whatis-hybrid-identity).

## Permissions

There are no Domain Admin or equivalent roles in Azure AD. This feature enhances the security posture against common attacks by APTs such as privilege escalation and pass-the-hash lateral movement techniques. Azure AD roles grant permissions to manage Azure AD objects and configuration. [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) is the highest privileged role in Azure AD. There are many out-of-box [limited administrator roles](/azure/active-directory/roles/permissions-reference) for various limited admin functions. Azure AD makes it easy to assign permissions using j[ust-in-time (JIT)](/azure/active-directory/privileged-identity-management/pim-configure) and [just-enough-admin (JEA)](/azure/active-directory/roles/delegate-by-task) principles.

## Authentication

Unlike Active Directory, users in Azure AD aren't limited to password or smartcard authentication. Azure AD users can use passwords, but there are many other [authentication and verification methods](/azure/active-directory/authentication/concept-authentication-methods) that Azure AD supports. The methods include native support for smartcard certificates and derived credentials, Microsoft Authenticator passwordless, FIDO2 security keys (hardware passkey), and device credentials like Windows Hello for Business. Azure AD offers passwordless, phishing-resistant methods in support of [Memorandum 22-09](/azure/active-directory/standards/memo-22-09-multi-factor-authentication) and [DODCIO Zero Trust Strategy capabilities](https://dodcio.defense.gov/Portals/0/Documents/Library/ZTCapabilitiesActivities.pdf).

**Protocol support.** Azure AD applications can't use Kerberos, NTLM, or LDAP. They must use modern protocols intended for use over the internet, such as OpenID Connect, OAuth 2.0, and SAML 2.0.

**Supports any application.** Azure AD isn't just for Microsoft applications and services. Azure AD can be the identity provider for any application, cloud service provider, SaaS provider, or identity system that implements the same protocols. This support flexibility provides interoperability with allied defense forces and contractors.

**Mission partners.** When mission partners use Azure AD, they can seamlessly collaborate with [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) and protect access granted to guests using [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview).

## Applications

Azure AD isn't just for Microsoft services and applications. It supports identity for nearly any application in defense environments.

It can act as a common policy enforcement point (PEP) for zero trust architecture. Azure AD [Conditional Access](/azure/active-directory/conditional-access/overview) enables fine-grained authorization based on Risk and Service value. It can use user attributes, sign-in details, device health, location, and identity risk. For more information, see [Zero trust security](/azure/security/fundamentals/zero-trust).

## Devices

Windows devices can be joined to Azure Active Directory in a similar manner to AD DS. When users sign into an Azure AD Joined device, a PIN or gesture is used to unlock a device-bound key, validated against Azure AD. The result is a [Primary Refresh Token (PRT)](/azure/active-directory/devices/concept-primary-refresh-token) issued to the device that facilitates single sign-on to Azure AD protected services using native applications like Microsoft Teams.

When Azure AD Joined devices are enrolled in Microsoft Endpoint Manager (Intune), device compliance can be used as a grant control within [Conditional Access](/azure/active-directory/conditional-access/overview).

When Windows devices joined to AD DS are synchronized to Azure AD, these devices can be joined to both Active Directory and Azure Active Directory at the same time. This configuration is called [hybrid Azure AD join](/azure/active-directory/devices/howto-hybrid-azure-ad-join). Hybrid Azure AD devices authenticate users against Active Directory first, then retrieve a PRT from Azure AD. Like device compliance, hybrid Azure AD join state can also be used as a grant control within Conditional Access.

## Microsoft 365 and Azure use Azure Active Directory

Azure AD is the identity platform for Microsoft 365 and Azure.

**Microsoft 365 and Azure AD.** When you use Microsoft 365 services like Microsoft Office, Intune, or Microsoft 365 Defender, you're using Azure AD. Azure AD allows you to sign into Microsoft Office. Azure AD allows you to use the people picker in SharePoint and OneDrive. Azure AD allows you to create a new Team or Microsoft 365 Group.

**Azure and Azure AD.** All Azure resources belong to an Azure subscription. You can assign permission at the subscription level by applying [role-based access control (RBAC)](/azure/role-based-access-control/overview). The identities managing the subscription, including authentication and authorization for management, use Azure AD. Subscriptions are attached or “pinned” to exactly one Azure AD tenant.

Many Azure resources can use a [managed identity](/azure/active-directory/managed-identities-azure-resources/overview) to interact with other resources. The managed identity is a security principal in the Azure AD tenant. You can grant permissions to the managed identity and authorize it to access APIs protected by Azure AD, such as Microsoft Graph.

## Microsoft Graph

Microsoft web portals for Entra, Azure, and Microsoft 365 provide a graphical interface to Azure AD. You can automate programmatic access to read and update Azure AD objects and configuration policies using RESTful APIs called Microsoft Graph. There are many Microsoft Graph clients in various languages, including [PowerShell](/powershell/microsoftgraph/overview), Go, Python, Java, .NET, Ruby, and more. Explore the [Microsoft Graph repositories](https://github.com/orgs/microsoftgraph/repositories) on GitHub.

## Sovereign clouds

There are two separate versions of the Azure AD services defense organizations might use on public (internet-connected) networks: Azure AD Global and Azure AD Government.

- Azure AD Global is for commercial Microsoft 365 and Azure, Microsoft 365 GCC Moderate. The sign-in service for Azure AD Global is [login.microsoftonline.com](https://login.microsoftonline.com).
- Azure AD Government is Azure Government (IL4), DoD (IL5), Microsoft 365 GCC High, Microsoft 365 DoD (IL5). The sign-in service for Azure AD Government is [login.microsoftonline.us](https://login.microsoftonline.us).

Different Azure AD services use different sign-in URLs. As a result, you need to use separate web portals. You also need to supply environment switches to connect with Microsoft Graph clients and PowerShell modules for managing Azure and Microsoft 365 (*see table 1*).

*Table 1. Sovereign cloud endpoints for US Government.*

| Endpoint | Global | GCC High | DoD IL5 |
| --- | --- | --- | --- |
| Entra Portal | [entra.microsoft.com](https://entra.microsoft.com) | [entra.microsoft.us](https://entra.microsoft.us) | [entra.microsoft.us](https://entra.microsoft.us) |
| Azure portal | [portal.azure.com](https://portal.azure.com) | [portal.azure.us](https://portal.azure.us) | [portal.azure.us](https://portal.azure.us) |
| Defender Admin Center | [security.microsoft.com](https://security.microsoft.com) | [security.microsoft.us](https://security.microsoft.us) | [security.apps.mil](https://security.apps.mil) |
| MS Graph PowerShell |`Connect-MgGraph<br>-Environment Global` | `Connect-MgGraph<br>-Environment USGov` | `Connect-MgGraph<br>-Environment USGovDoD` |
| Az PowerShell | `Connect-AzAccount<br>-Environment AzureCloud` | `Connect-AzAccount<br>-Environment AzureUSGovernment` | `Connect-AzAccount<br>-Environment AzureUSGovernment` |
| Azure CLI | `az cloud set --name AzureCloud` | `az cloud set --AzureUSGovernment` | `az cloud set --AzureUSGovernment` |

## Next step

> [!div class="nextstepaction"]
> [Zero trust configurations](zero-trust-configuration.md)

## Related links

- [Manage multi-tenant operations](manage-operations.md)
- [Centralized security operations](security-operations.md)
