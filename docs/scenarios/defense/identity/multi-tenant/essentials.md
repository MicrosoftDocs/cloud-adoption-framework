---
title: Identity essentials for multi-tenant Defense organizations
description: An overview of identity essentials for multi-tenant defense organizations using Microsoft Entra ID and implementing zero trust
author: amasse3
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 07/10/2023
ms.topic: conceptual
---
# Identity essentials for multi-tenant defense organizations

The following guide provides zero trust identity essentials for multi-tenant defense organizations and focuses on Microsoft Entra ID. Zero trust is a key strategy for ensuring the integrity and confidentiality of sensitive information. Identity is a foundational pillar of zero trust. Microsoft Entra ID is the Microsoft cloud identity service. Microsoft Entra ID is a critical zero trust component that all Microsoft cloud customers use.

Architects and decision makers must understand the core capabilities of Microsoft Entra ID and its role in zero trust before building the defense enterprise strategy. Defense organizations can meet many zero trust requirements by adopting Microsoft Entra ID. Many already have access to essential Microsoft Entra features through their existing Microsoft 365 licenses.

<a name='azure-ad-tenants'></a>

## Microsoft Entra tenants

An instance of Microsoft Entra ID is called an *Microsoft Entra tenant*. A Microsoft Entra tenant is an identity platform and boundary. It's the identity platform for your organization and a secure, identity boundary for the Microsoft cloud services you use. As such, it's ideal for protecting sensitive defense identity data.

**Consolidating Microsoft Entra tenants.** Microsoft recommends one Microsoft Entra tenant per organization. A single Microsoft Entra tenant provides the most seamless identity management experience for users and administrators. It provides the most comprehensive zero trust capabilities. Organizations with multiple Microsoft Entra tenants must manage different sets of users, groups, applications, and policies, increasing cost and adding administrative complexity. A single tenant also minimizes licensing cost.

You should try to have Microsoft 365, Azure services, Power Platform, line-of-business (LOB) applications, software-as-a-service (SaaS) applications, and other cloud service providers (CSP) use a single Microsoft Entra tenant.

**Microsoft Entra ID versus Active Directory.** Microsoft Entra ID isn't an evolution of Active Directory Domain Services (AD DS). The tenant concept is like an Active Directory Forest, but the underlying architecture is different. Microsoft Entra ID is a hyperscale, modern, and cloud-based identity service.

**Initial domain names and tenant IDs.** Each tenant has a unique initial domain name and tenant ID. For example, an organization named *Contoso* might have the initial domain name `contoso.onmicrosoft.com` for Microsoft Entra ID and `contoso.onmicrosoft.us` for Microsoft Entra Government. Tenant IDs are globally unique identifiers (GUID) like `a976dd56-c1d8-485c-8ea7-facbce6726c2`. Each tenant only has one initial domain and tenant ID. Both values are immutable and can't be changed after tenant creation.

Users sign into Microsoft Entra accounts with their User Principal Name (UPN). The UPN is a Microsoft Entra user attribute, and it needs a [routable suffix](/microsoft-365/enterprise/prepare-a-non-routable-domain-for-directory-synchronization). The initial domain is [the default routable suffix](/azure/active-directory/hybrid/connect/plan-connect-userprincipalname) (`user@contoso.onmicrosoft.com`). You can add [custom domains](/azure/active-directory/fundamentals/add-custom-domain) to create and use a more friendly UPN. The friendly UPN usually matches the user's email address (`user@contoso.com`). The UPN for Microsoft Entra ID might differ from your users' AD DS userPrincipalName. Having a different UPN and AD DS userPrincipalName is common when the AD DS userPrincipalName values are [nonroutable](/azure/active-directory/hybrid/connect/plan-connect-userprincipalname) or they use a suffix that doesn't match a verified custom domain in the tenant.

You can only verify a custom domain in one Microsoft Entra tenant globally. Custom domains aren't security or trust boundaries like Active Directory Domain Services (AD DS) Forests. They're a DNS namespace for identifying a Microsoft Entra user's home tenant.

<a name='azure-ad-architecture'></a>

## Microsoft Entra architecture

Microsoft Entra ID has no domain controllers, organizational units, group policy objects, domain/forest trusts, or Flexible Single Master Operation (FSMO) roles. Microsoft Entra ID is a software-as-a-service, identity management solution. You can access Microsoft Entra ID via RESTful APIs. You use [modern authentication](/exchange/clients-and-mobile-in-exchange-online/outlook-for-ios-and-android/setup-with-modern-authentication#modern-authentication) and authorization protocols to access resources protected by Microsoft Entra ID. The directory has a flat structure and uses [resource-based](/azure/active-directory/roles/admin-units-manage) permissions.

Each Microsoft Entra tenant is a [highly available](/azure/active-directory/fundamentals/active-directory-architecture) data store for identity management data. It stores identity, policy, and configuration objects and replicates them across Azure regions. A Microsoft Entra tenant provides data redundancy for critical defense information.

## Identity types

Microsoft Entra ID has two types of identities. The two identity types are users and service principals.

**Users.** Users are identities for individuals accessing Microsoft and federated cloud services. Users can either be members or guests in an instance of Microsoft Entra ID. Usually, members are internal to your organization and guests belong to an external organization like a mission partner or defense contractor. To learn more about guest users and collaboration between organizations, see [B2B collaboration overview](/azure/active-directory/external-identities/what-is-b2b).

**Service principals.** Service principals are nonperson entities (NPE) in Microsoft Entra ID. Service principals can represent applications, service / automation accounts, and Azure resources. Even [non-Azure resources](/azure/azure-arc/servers/managed-identity-authentication), such as on-premises servers, can have a service principal in Microsoft Entra ID and interact with other Azure resources. Service principals are useful in automating defense workflows and managing applications critical to defense operations. For more information, see [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals).

**Synchronizing identities.** You can use [Microsoft Entra Connect Sync](/azure/active-directory/hybrid/connect/how-to-connect-sync-whatis) or [Microsoft Entra Connect Cloud Sync](/azure/active-directory/hybrid/cloud-sync/what-is-cloud-sync) to synchronize user, group, and computer (device) objects in Active Directory Domain Services with Microsoft Entra ID. This configuration is called [hybrid identity](/azure/active-directory/hybrid/whatis-hybrid-identity).

## Permissions

Microsoft Entra ID uses a different approach to permissions than traditional on-premises Active Directory Domain Services (AD DS).

**Microsoft Entra roles.** You assign permissions in Microsoft Entra ID using [Microsoft Entra directory roles](/azure/active-directory/roles/permissions-reference). These roles grant access to specific APIs and scopes. [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) is the highest privileged role in Microsoft Entra ID. There are many built-in roles for various limited admin functions. You should delegate granular permissions to reduce attack surface area.

**Elevated permission assignment.** To enhance security and reduce unnecessary privileges, Microsoft Entra ID provides two principles for permission assignment:

*Just-in-Time (JIT)*: Microsoft Entra ID supports [just-in-time access](/azure/active-directory/privileged-identity-management/pim-configure). The JIT feature lets you assign permissions temporarily when needed. JIT access minimizes the exposure of unnecessary privileges and reduces the attack surface.

*Just-Enough-Admin (JEA)*: Microsoft Entra ID follows the just-enough-admin principle. [Built-in roles](/azure/active-directory/roles/permissions-reference) let you [delegate admin tasks](/azure/active-directory/roles/delegate-by-task) without granting excessive permissions. [Administrative Units](/azure/active-directory/roles/administrative-units) can further restrict permission scope for Microsoft Entra roles.

## Authentication

Unlike Active Directory, users in Microsoft Entra ID aren't limited to password or smartcard authentication. Microsoft Entra users can use passwords and many other [authentication and verification methods](/azure/active-directory/authentication/concept-authentication-methods). Microsoft Entra ID uses modern authentication protocols, protects against token-based attacks, and detects suspicious sign-in behavior.

**Authentication methods.** Microsoft Entra authentication methods include native support for smartcard certificates and derived credentials, Microsoft Authenticator passwordless, FIDO2 security keys (hardware passkey), and device credentials like Windows Hello for Business. Microsoft Entra ID offers passwordless, phishing-resistant methods in support of [Memorandum 22-09](/azure/active-directory/standards/memo-22-09-multi-factor-authentication) and [DODCIO Zero Trust Strategy capabilities](https://dodcio.defense.gov/Portals/0/Documents/Library/ZTCapabilitiesActivities.pdf).

**Authentication protocols.** Microsoft Entra ID doesn't use Kerberos, NTLM, or LDAP. It uses modern open protocols intended for use over the internet, such as [OpenID Connect](/azure/active-directory/develop/v2-protocols-oidc), [OAuth 2.0](/azure/active-directory/develop/v2-oauth2-auth-code-flow), [SAML 2.0](/azure/active-directory/develop/saml-protocol-reference), and [SCIM](/azure/active-directory/fundamentals/sync-scim).

**Protections against token attacks.** Traditional AD DS is susceptible to Kerberos-based attacks. AD DS uses security groups with well-known [security identifiers (SID)](/windows-server/identity/ad-ds/manage/understand-security-identifiers), such as `S-1-5-domain-512` for *Domain Admins*. When a Domain Administrator performs a local or network sign-in, the Domain Controller issues a Kerberos ticket containing the Domain Admins SID and stores it in a [credential cache](/windows-server/security/windows-authentication/credentials-processes-in-windows-authentication). Threat actors commonly exploit this mechanism using [lateral movement](/defender-for-identity/lateral-movement-alerts) and [privilege escalation](/defender-for-identity/persistence-privilege-escalation-alerts) techniques like pass-the-hash and pass-the-ticket.

However, Microsoft Entra ID isn't susceptible to Kerberos attacks. The cloud equivalent is man-in-the-middle techniques, such as session hijacking and session replay, to steal session tokens (sign-in token). Client applications, [Web Account Manager (WAM)](/azure/active-directory/develop/scenario-desktop-acquire-token-wam), or the user's web browser (session cookies) store these session tokens. To protect against token-theft attacks, Microsoft Entra ID records token use to prevent replay and can require tokens be [cryptographically bound](/azure/active-directory/conditional-access/concept-token-protection) to the user's device.

**Detect suspicious sign-in behavior.** [Microsoft Entra ID Protection](/azure/active-directory/identity-protection/overview-identity-protection) detects and blocks risky sign-ins while [Continuous Access Evaluation (CAE)](/azure/active-directory/conditional-access/concept-continuous-access-evaluation) enforces access policies in real-time.

## Applications

Microsoft Entra ID isn't just for Microsoft applications and services. Microsoft Entra ID can be the identity provider for any application, cloud service provider, SaaS provider, or identity system that uses the same protocols. It easily supports interoperability with allied defense forces and contractors.

**Policy Enforcement Point (PEP) and Policy Decision Point (PDP).** Microsoft Entra ID is a common [policy enforcement point (PEP)](https://csrc.nist.gov/glossary/term/policy_enforcement_point) and [policy decision point (PDP)](https://csrc.nist.gov/glossary/term/policy_decision_point) in zero trust architectures. It enforces security policies and access controls for applications.

**Microsoft Entra ID Governance.** [Microsoft Entra ID Governance](/azure/active-directory/governance/identity-governance-overview) is a Microsoft Entra feature. It helps you manage user access and automate the access lifecycle. It ensures that users have appropriate and timely access to applications and resources.

**Conditional access.** Conditional access allows you to use attributes to fine-grained authorization for applications. You can define access policies based on various factors. These factors include user attributes, credential strength, application attributes, user and sign-in risk, device health, and location. For more information, see [zero trust security](/azure/security/fundamentals/zero-trust).

## Devices

Microsoft Entra ID provides secure and seamless access to Microsoft services through device management. You can manage and join Windows devices to Microsoft Entra similar to the way you would with Active Directory Domain Services.

**Microsoft Entra joined devices:** When users sign into a Microsoft Entra joined device, a device-bound key is unlocked using a PIN or gesture. Post validation, Microsoft Entra ID issues a [primary refresh token (PRT)](/azure/active-directory/devices/concept-primary-refresh-token) to the device. This PRT facilitates single sign-on access to Microsoft Entra ID protected services like Microsoft Teams.

Microsoft Entra joined devices enrolled in Microsoft Endpoint Manager (Intune) can use device compliance as a grant control within [conditional access](/azure/active-directory/conditional-access/overview).

**Microsoft Entra hybrid joined devices.** [Microsoft Entra hybrid join](/azure/active-directory/devices/howto-hybrid-azure-ad-join) allows Windows devices to be simultaneously connected to both Active Directory Domain Services and Microsoft Entra ID. These devices first authenticate users against Active Directory, and then they retrieve a primary refresh token from Microsoft Entra ID.

## Microsoft 365 and Azure

Microsoft Entra ID is Microsoft's identity platform. It serves both Microsoft 365 and Azure services. Microsoft 365 subscriptions create and use a Microsoft Entra tenant. Azure services also rely on a Microsoft Entra tenant.

**Microsoft 365 identity.** Microsoft Entra ID is integral to all identity operations within Microsoft 365. It handles user sign-in, collaboration, sharing, and permissions assignment. It supports identity management for Office 365, Intune, and Microsoft 365 Defender services. Your users use Microsoft Entra every time they sign into an Office application like Word or Outlook, share a document using OneDrive, invite an external user to a SharePoint site, or create a new team in Microsoft Teams.

**Azure identity.** In Azure, each resource is associated with an [Azure subscription](/azure/cloud-adoption-framework/ready/considerations/fundamental-concepts#azure-subscription-purposes), and subscriptions are [linked](/azure/active-directory/fundamentals/how-subscriptions-associated-directory) to a single Microsoft Entra tenant. You delegate permissions for managing Azure resources by assigning [role-based access control (RBAC)](/azure/role-based-access-control/overview) roles to users, security groups, or service principals.

Managed identities play a crucial role in enabling Azure resources to interact securely with other resources. These managed identities are security principals within the Microsoft Entra tenant. You grant permissions to them on a least-privilege basis. You can authorize a managed identity to access APIs protected by Microsoft Entra ID, such as Microsoft Graph. When an Azure resource uses a managed identity, the managed identity is a [service principal object](/azure/active-directory/develop/app-objects-and-service-principals#service-principal-object). The service principle object resides within the same Microsoft Entra tenant as the subscription associated with the resource.

## Microsoft Graph

Microsoft web portals for Microsoft Entra, Azure, and Microsoft 365 provide a graphical interface to Microsoft Entra ID. You can automate programmatic access to read and update Microsoft Entra objects and configuration policies using RESTful APIs called Microsoft Graph. Microsoft Graph supports clients in various languages. Supported languages include [PowerShell](/powershell/microsoftgraph/overview), Go, Python, Java, .NET, Ruby, and more. Explore the [Microsoft Graph repositories](https://github.com/orgs/microsoftgraph/repositories) on GitHub.

## Sovereign clouds

There are two separate versions of the Microsoft Entra services defense organizations might use on public (internet-connected) networks: Microsoft Entra Global and Microsoft Entra Government.

**Microsoft Entra Global.** Microsoft Entra Global is for commercial Microsoft 365 and Azure, Microsoft 365 GCC Moderate. The sign-in service for Microsoft Entra Global is [login.microsoftonline.com](https://login.microsoftonline.com).

**Microsoft Entra Government.** Microsoft Entra Government is Azure Government (IL4), DoD (IL5), Microsoft 365 GCC High, Microsoft 365 DoD (IL5). The sign-in service for Microsoft Entra Government is [login.microsoftonline.us](https://login.microsoftonline.us).

**Service URLS.** Different Microsoft Entra services use different sign-in URLs. As a result, you need to use separate web portals. You also need to supply environment switches to connect with Microsoft Graph clients and PowerShell modules for managing Azure and Microsoft 365 (*see table 1*).

*Table 1. Sovereign cloud endpoints for US Government.*

| Endpoint | Global | GCC High | DoD Impact Level 5 (IL5) |
| --- | --- | --- | --- |
| Microsoft Entra admin center | [entra.microsoft.com](https://entra.microsoft.com) | [entra.microsoft.us](https://entra.microsoft.us) | [entra.microsoft.us](https://entra.microsoft.us) |
| Azure portal | [portal.azure.com](https://portal.azure.com) | [portal.azure.us](https://portal.azure.us) | [portal.azure.us](https://portal.azure.us) |
| Defender Admin Center | [security.microsoft.com](https://security.microsoft.com) | [security.microsoft.us](https://security.microsoft.us) | [security.apps.mil](https://security.apps.mil) |
| MS Graph PowerShell |`Connect-MgGraph<br>-Environment Global` | `Connect-MgGraph<br>-Environment USGov` | `Connect-MgGraph<br>-Environment USGovDoD` |
| Az PowerShell module | `Connect-AzAccount<br>-Environment AzureCloud` | `Connect-AzAccount<br>-Environment AzureUSGovernment` | `Connect-AzAccount<br>-Environment AzureUSGovernment` |
| Azure CLI | `az cloud set --name AzureCloud` | `az cloud set --name AzureUSGovernment` | `az cloud set --name AzureUSGovernment` |

## Next step

> [!div class="nextstepaction"]
> [Zero trust configurations](zero-trust-configuration.md)

## Related links

- [Manage multi-tenant operations](manage-operations.md)
- [Centralized security operations](security-operations.md)
