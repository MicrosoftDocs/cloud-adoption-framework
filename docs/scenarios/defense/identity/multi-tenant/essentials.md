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

This article cover identity essentials for multi-tenant defense organizations implementing zero trust with Azure Active Directory (Azure AD).

Zero trust is a key strategy for ensuring the integrity and confidentiality of sensitive information. Identity is a foundational pillar of zero trust. Azure Active Directory (Azure AD) is the Microsoft cloud identity service. Azure AD is a critical zero trust component that all Microsoft cloud customers use. 

Architects and decision makers must understand the core capabilities of Azure AD and its role in zero trust before building the defense enterprise strategy. Defense organizations can meet many zero trust requirements with Azure AD. Many already have access to essential Azure AD features through their Microsoft 365 licenses.

## Tenants

An instance of Azure AD is called an Azure AD tenant. An Azure AD tenant is an identity platform and security boundary. It's the identity platform for your organization. security boundary for the Microsoft cloud services you use. As such, it's ideal for protecting sensitive defense identity data.

**Consolidate Azure AD tenants.** Microsoft recommends one Azure AD tenant per organization. A single Azure AD tenant provides the most seamless identity management experience for users and administrators. It provides the most comprehensive zero trust capabilities. Organizations with multiple Azure AD tenants must manage different sets of users, groups, applications, and policies, increasing cost and adding administrative complexity. A single tenant also minimizes licensing cost.

You should try to have Microsoft 365, Azure services, Power Platform, line-of-business (LOB) applications, software-as-a-service (SaaS) applications, and other cloud service providers (CSP) use a single Azure AD tenant.

**Azure AD is not Active Directory.** Azure AD isn’t an evolution of Active Directory Domain Services (AD DS). The tenant concept is like an Active Directory Forest, but the underlying architecture is different. Azure AD is a hyperscale, modern, and cloud-based identity service.

**Tenant domain name and ID.** Each tenant has a unique initial domain name and tenant ID. For example, an organization named *Contoso* might have the initial domain name `contoso.onmicrosoft.com` for Azure AD and `contoso.onmicrosoft.us` for Azure AD Government.

Tenant IDs are globally unique identifiers (GUID) like `a976dd56-c1d8-485c-8ea7-facbce6726c2`. Each tenant only has one initial domain and tenant ID. Both values are immutable and can't be changed after tenant creation.

Member users in your tenant need to have a username with a suffix that matches the initial domain, or they need to use a [custom domain](/azure/active-directory/fundamentals/add-custom-domain). You have to create and verify the custom domain via DNS records. Custom domains allow users to sign in with a friendly username. The username is usually an email address (`user@contoso.com`).

You can only verify a custom domain in one Azure AD tenant globally. Custom domains aren't security or trust boundaries like Active Directory Domain Services (AD DS) Forests. They're a DNS namespace for globally identifying Azure AD users.

## Architecture

Azure AD has no domain controllers, organizational units, group policy objects, domain/forest trusts, or Flexible Single Master Operation (FSMO) roles. Azure AD is a software-as-a-service, identity management solution. You can access Azure AD via RESTful APIs. You can use modern authentication and authorization protocols and have a flat structure with resource-based delegation.

Each Azure AD tenant is a [highly available](/azure/active-directory/fundamentals/active-directory-architecture) data store for identity management data. It stores identity, policy, and configuration objects and replicates them across Azure regions. An Azure AD tenant provides data redundancy for critical defense information.

## Identity types

Azure AD has two types of identities. The two identity types are users and service principals.

**Users.** Users are identities for individuals accessing Microsoft and federated cloud services. Users can either be members or guests in an instance of Azure AD. Usually, members are internal to your organization and guests belong to an external organization like a mission partner or defense contractor. To learn more about guest users and collaboration between organizations, see [B2B collaboration overview](/azure/active-directory/external-identities/what-is-b2b).

**Service principals.** Service principals are nonperson entities (NPE) in Azure AD. Service principals can represent applications, service / automation accounts, and Azure resources. Even [non-Azure resources](/azure/azure-arc/servers/managed-identity-authentication), such as on-premises servers, can have a service principal in Azure AD and interact with other Azure resources. Service principals are useful in automating defense workflows and managing applications critical to defense operations. For more information, see [Application and service principal objects in Azure Active Directory](/azure/active-directory/develop/app-objects-and-service-principals).

**Synchronizing identities.** You can use Azure AD Connect Sync or Azure AD Connect Cloud Sync to synchronize user, group, and computer (device) objects in Active Directory Domain Services with Azure AD. This configuration is called [hybrid identity](/azure/active-directory/hybrid/whatis-hybrid-identity).

## Permissions

Azure AD uses a different approach compared to traditional Domain Admins security group found in on-premises Active Directory environments. Azure AD relies on Azure AD directory roles to grant permissions for managing Azure AD objects and configuration. There's a security benefit to this permissions change. Azure AD doesn't use Kerberos and isn't vulnerable to privilege escalation attacks like pass-the-hash or pass-the-ticket.

**Azure AD roles.** [Azure AD directory roles](/azure/active-directory/roles/permissions-reference) grant permissions to manage Azure AD objects and configuration. [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) is the highest privileged role in Azure AD. There are many built-in roles for various limited admin functions.

**Elevated permission assignment.** To enhance security and reduce unnecessary privileges, Azure AD provides two principles for permission assignment.

*Just-in-time access.* Azure supports [just-in-time (JIT)](/azure/active-directory/privileged-identity-management/pim-configure) access. The JIT feature lets you assign permissions temporarily when needed. JIT access minimizes the exposure of unnecessary privileges and reduces the attack surface.

*Just-enough-admin.* Azure AD supports the [just-enough-admin (JEA)](/azure/active-directory/roles/delegate-by-task) principle. The JEA feature lets you delegate admin tasks with limited privileges. JEA ensures administrators have the necessary permissions for specific tasks without granting excessive permissions.

## Authentication

Unlike Active Directory, users in Azure AD aren't limited to password or smartcard authentication. Azure AD users can use passwords and many other [authentication and verification methods](/azure/active-directory/authentication/concept-authentication-methods).

**Authentication methods.** Azure AD authentication methods include native support for smartcard certificates and derived credentials, Microsoft Authenticator passwordless, FIDO2 security keys (hardware passkey), and device credentials like Windows Hello for Business. Azure AD offers passwordless, phishing-resistant methods in support of [Memorandum 22-09](/azure/active-directory/standards/memo-22-09-multi-factor-authentication) and [DODCIO Zero Trust Strategy capabilities](https://dodcio.defense.gov/Portals/0/Documents/Library/ZTCapabilitiesActivities.pdf).

**Authentication protocols.** Azure AD doesn't use Kerberos, NTLM, or LDAP. It uses modern open protocols intended for use over the internet such as [OpenID Connect](/azure/active-directory/develop/v2-protocols-oidc), [OAuth 2.0](/azure/active-directory/develop/v2-oauth2-auth-code-flow), [SAML 2.0](/azure/active-directory/develop/saml-protocol-reference), and [SCIM](/azure/active-directory/fundamentals/sync-scim).

**Mission partners.** When mission partners use Azure AD, you can use [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) to collaborate with them. You can protect the access you grant to guests by using [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview).

## Applications

Azure AD isn't just for Microsoft applications and services. Azure AD can be the identity provider for any application, cloud service provider, SaaS provider, or identity system that uses the same protocols. It easily supports interoperability with allied defense forces and contractors.

**Policy Enforcement Point (PEP) and Policy Decision Point (PDP)**: Azure AD is a common [policy enforcement point (PEP)](https://csrc.nist.gov/glossary/term/policy_enforcement_point) and [policy decision point (PDP)](https://csrc.nist.gov/glossary/term/policy_decision_point) in zero trust architectures. It enforces security policies and access controls for applications.

**Entra Identity Governance:** [Entra Identity Governance](/azure/active-directory/governance/identity-governance-overview) is an Azure AD feature. It helps you manage user access and automate the access lifecycle. It ensures that users have appropriate and timely access to applications and resources.

**Conditional access:** Conditional access allows you to use attributes to fine-grained authorization for applications. You can define access policies based on various factors. These factors include user attributes, credential strength, application attributes, user and sign-in risk, device health, and location. For more information, see [zero trust security](/azure/security/fundamentals/zero-trust).

## Devices

Azure Active Directory (Azure AD) provides secure and seamless access to Microsoft services through device management. You can manage and join Windows devices to Azure AD similar to the way you would with Active Directory Domain Services.

**Azure AD joined devices:** When users sign into an Azure AD joined device, a device-bound key is unlocked using a PIN or gesture. Post validation, Azure AD issues a [primary refresh token (PRT)](/azure/active-directory/devices/concept-primary-refresh-token) to the device. This PRT facilitates single sign-on access to Azure AD protected services like Microsoft Teams. Azure AD Joined devices enrolled in Microsoft Endpoint Manager (Intune) can use device compliance as a grant control within [conditional access](/azure/active-directory/conditional-access/overview).

**Hybrid Azure AD joined devices.** [Hybrid Azure AD join](/azure/active-directory/devices/howto-hybrid-azure-ad-join) allows Windows devices to be simultaneously connected to both Active Directory Domain Services and Azure AD. These devices first authenticate users against Active Directory, and then they retrieve a primary refresh token from Azure AD.

Windows devices joined to AD DS and synchronized to Azure AD can be joined to both Active Directory and Azure AD simultaneously. This configuration is called a [hybrid Azure AD join]. Hybrid Azure AD devices authenticate users against Active Directory first. Then they retrieve a primary refresh token from Azure AD. Like device compliance, you can use hybrid Azure AD join state as a grant control within conditional access.

## Microsoft 365 and Azure

Azure Active Directory (Azure AD) is Microsoft's identity platform. It serves both Microsoft 365 and Azure services. Microsoft 365 subscriptions create and use an Azure AD tenant. Azure services also rely on an Azure AD tenant.

**Microsoft 365 identity.** Azure AD is integral to all identity operations within Microsoft 365. It facilitates sign-in, collaboration, sharing, and permissions assignment. It supports identity management for various Microsoft 365 services. These services include Microsoft Office, Intune, and Microsoft 365 Defender. With Azure AD, users can sign in to Microsoft Office. They can utilize the people picker feature in SharePoint and OneDrive. They can create new Teams or Microsoft 365 Groups.

**Azure identity.** In Azure, each resource is associated with an [Azure subscription](/azure/cloud-adoption-framework/ready/considerations/fundamental-concepts#azure-subscription-purposes), and subscriptions are linked to a single Azure AD tenant. At the subscription level, you can assign permissions for accessing Azure resources using [role-based access control (RBAC)](/azure/role-based-access-control/overview). The administrators that manage the subscription use Azure AD to manage authentication and authorization.

Managed identities play a crucial role in enabling Azure resources to interact securely with other resources. These managed identities are security principals within the Azure AD tenant. You grant permissions to them on a least-privilege basis. You can authorize a managed identity to access APIs protected by Azure AD, such as Microsoft Graph. When an Azure resource uses a managed identity, the managed identity is a [service principal object](/azure/active-directory/develop/app-objects-and-service-principals#service-principal-object). The service principle object resides within the same Azure AD tenant as the subscription associated with the resource.

## Microsoft Graph

Microsoft web portals for Entra, Azure, and Microsoft 365 provide a graphical interface to Azure AD. You can automate programmatic access to read and update Azure AD objects and configuration policies using RESTful APIs called Microsoft Graph. Microsoft Graph supports clients in various languages. Supported languages include [PowerShell](/powershell/microsoftgraph/overview), Go, Python, Java, .NET, Ruby, and more. Explore the [Microsoft Graph repositories](https://github.com/orgs/microsoftgraph/repositories) on GitHub.

## Sovereign clouds

There are two separate versions of the Azure AD services defense organizations might use on public (internet-connected) networks: Azure AD Global and Azure AD Government.

**Azure AD Global.** Azure AD Global is for commercial Microsoft 365 and Azure, Microsoft 365 GCC Moderate. The sign-in service for Azure AD Global is [login.microsoftonline.com](https://login.microsoftonline.com).

**Azure AD Government.** Azure AD Government is Azure Government (IL4), DoD (IL5), Microsoft 365 GCC High, Microsoft 365 DoD (IL5). The sign-in service for Azure AD Government is [login.microsoftonline.us](https://login.microsoftonline.us).

**Service URLS.** Different Azure AD services use different sign-in URLs. As a result, you need to use separate web portals. You also need to supply environment switches to connect with Microsoft Graph clients and PowerShell modules for managing Azure and Microsoft 365 (*see table 1*).

*Table 1. Sovereign cloud endpoints for US Government.*

| Endpoint | Global | GCC High | DoD IL5 |
| --- | --- | --- | --- |
| Entra Portal | [entra.microsoft.com](https://entra.microsoft.com) | [entra.microsoft.us](https://entra.microsoft.us) | [entra.microsoft.us](https://entra.microsoft.us) |
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
