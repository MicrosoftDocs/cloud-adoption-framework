---
title: Identity Baseline tools in Azure
description: See how Azure native tools can help mature policies and processes that support the Identity Baseline discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Identity Baseline tools in Azure

The [Identity Baseline discipline](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on ways of establishing policies that ensure consistency and continuity of user identities regardless of the cloud provider that hosts the application or workload.

The following tools are included in the discovery guide for hybrid identity.

**Active Directory (on-premises):** Active Directory is the identity provider most frequently used in the enterprise to store and validate user credentials.

**Azure Active Directory:** A software as a service (SaaS) equivalent to Active Directory, capable of federating with an on-premises Active Directory.

**Active Directory (IaaS):** An instance of the Active Directory application running in a virtual machine in Azure.

Identity is the control plane for IT security. So authentication is an organization's access guard to the cloud. Organizations need an identity control plane that strengthens their security and keeps their cloud applications safe from intruders.

## Cloud authentication

Choosing the correct authentication method is the first concern for organizations wanting to move their applications to the cloud.

When you choose this method, Azure AD handles users' sign-in process. Coupled with seamless single sign-on (SSO), users can sign in to cloud applications without having to reenter their credentials. With cloud authentication, you can choose from two options:

**Azure AD password hash synchronization:** The simplest way to enable authentication for on-premises directory objects in Azure AD. This method can also be used with any method as a back-up failover authentication method in case your on-premises server goes down.

**Azure AD Pass-through Authentication:** Provides a persistent password validation for Azure AD authentication services by using a software agent that runs on one or more on-premises servers.

<!-- docutune:casing "the pass-through authentication method" -->

> [!NOTE]
> Companies with a security requirement to immediately enforce on-premises user account states, password policies, and sign-in hours should consider the pass-through authentication method.

**Federated authentication:**

When you choose this method, Azure AD passes the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS) or a trusted third-party federation provider, to validate the user's password.

For a decision tree that helps you choose the best solution for your organization, see [Choose the right authentication method for Azure Active Directory](/azure/active-directory/hybrid/choose-ad-authn).

The following table lists the native tools that can help mature the policies and processes that support this discipline.

<!-- docutune:casing UserPrincipalName SamAccountName "conditional access options" -->

| Consideration | Password hash synchronization + Seamless SSO | Pass-through Authentication + Seamless SSO | Federation with AD FS |
| --- | --- | --- | --- |
| Where does authentication happen? | In the cloud | In the cloud after a secure password verification exchange with the on-premises authentication agent | On-premises |
| What are the on-premises server requirements beyond the provisioning system: Azure AD Connect? | None | One server for each additional authentication agent | Two or more AD FS servers <br><br> Two or more WAP servers in the perimeter network |
| What are the requirements for on-premises internet and networking beyond the provisioning system? | None | [Outbound internet access](/azure/active-directory/hybrid/how-to-connect-pta-quick-start) from the servers running authentication agents | [Inbound internet access](/windows-server/identity/ad-fs/overview/ad-fs-requirements) to WAP servers in the perimeter <br><br> Inbound network access to AD FS servers from WAP servers in the perimeter <br><br> Network load balancing |
| Is there an SSL certificate requirement? | No | No | Yes |
| Is there a health monitoring solution? | Not required | Agent status provided by [Azure Active Directory admin center](/azure/active-directory/hybrid/tshoot-connect-pass-through-authentication#general-issues) | [Azure AD Connect Health](/azure/active-directory/hybrid/how-to-connect-health-adfs) |
| Do users get single sign-on to cloud resources from domain-joined devices within the company network? | Yes with [Seamless SSO](/azure/active-directory/hybrid/how-to-connect-sso) | Yes with [Seamless SSO](/azure/active-directory/hybrid/how-to-connect-sso) | Yes |
| What sign-in types are supported? | UserPrincipalName + password <br><br> Integrated Windows authentication by using [Seamless SSO](/azure/active-directory/hybrid/how-to-connect-sso) <br><br> [Alternate login ID](/azure/active-directory/hybrid/how-to-connect-install-custom) | UserPrincipalName + password <br><br> Integrated Windows authentication by using [Seamless SSO](/azure/active-directory/hybrid/how-to-connect-sso) <br><br> [Alternate login ID](/azure/active-directory/hybrid/how-to-connect-pta-faq) | UserPrincipalName + password <br><br> SamAccountName + password <br><br> Integrated Windows authentication <br><br> [Certificate and smart card authentication](/windows-server/identity/ad-fs/operations/configure-user-certificate-authentication) <br><br> [Alternate login ID](/windows-server/identity/ad-fs/operations/configuring-alternate-login-id) |
| Is Windows Hello for Business supported? | [Key trust model](/windows/security/identity-protection/hello-for-business/hello-identity-verification) <br><br> [Certificate trust model with Intune](https://microscott.azurewebsites.net/2017/12/16/setting-up-windows-hello-for-business-with-intune/) | [Key trust model](/windows/security/identity-protection/hello-for-business/hello-identity-verification) <br><br> [Certificate trust model with Intune](https://microscott.azurewebsites.net/2017/12/16/setting-up-windows-hello-for-business-with-intune/) | [Key trust model](/windows/security/identity-protection/hello-for-business/hello-identity-verification) <br><br> [Certificate trust model](/windows/security/identity-protection/hello-for-business/hello-key-trust-adfs) |
| What are the multi-factor authentication options? | [Azure Multi-Factor Authentication](/azure/active-directory/authentication/) <br><br> [Custom controls with Azure AD Conditional Access*](/azure/active-directory/conditional-access/controls#custom-controls-preview) | [Azure Multi-Factor Authentication](/azure/active-directory/authentication/) <br><br> [Custom controls with Azure AD Conditional Access*](/azure/active-directory/conditional-access/controls#custom-controls-preview) | [Azure Multi-Factor Authentication](/azure/active-directory/authentication/) <br><br> [Azure Multi-Factor Authentication server](/azure/active-directory/authentication/howto-mfaserver-deploy) <br><br> [Third-party multi-factor authentication](/windows-server/identity/ad-fs/operations/configure-additional-authentication-methods-for-ad-fs) <br><br> [Custom controls with Azure AD access](/azure/active-directory/conditional-access/controls#custom-controls-preview) |
| What user account states are supported? | Disabled accounts <br> (Up to 30-minute delay) | Disabled accounts <br><br> Account locked out <br><br> Account expired <br><br> Password expired <br><br> Sign-in hours | Disabled accounts <br><br> Account locked out <br><br> Account expired <br><br> Password expired <br><br> Sign-in hours |
| What are the conditional access options in Azure AD? | [Azure AD Conditional Access](/azure/active-directory/conditional-access/overview) | [Azure AD Conditional Access](/azure/active-directory/conditional-access/overview) | [Azure AD Conditional Access](/azure/active-directory/conditional-access/overview) <br><br> [AD FS claim rules](https://adfshelp.microsoft.com/AadTrustClaims/ClaimsGenerator) |
| Is blocking legacy protocols supported? | [Yes](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) | [Yes](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) | [Yes](/windows-server/identity/ad-fs/operations/access-control-policies-w2k12) |
| Can you customize the logo, image, and description on the sign-in pages? | [Yes, with Azure AD Premium](/azure/active-directory/fundamentals/customize-branding) | [Yes, with Azure AD Premium](/azure/active-directory/fundamentals/customize-branding) | [Yes](/azure/active-directory/hybrid/how-to-connect-fed-management#customlogo) |
| What advanced scenarios are supported? | [Smart password lockout](/azure/active-directory/authentication/concept-sspr-howitworks) <br><br> [Leaked credentials reports](/azure/active-directory/identity-protection/overview-identity-protection) | [Smart password lockout](/azure/active-directory/authentication/howto-password-smart-lockout) | Multisite low-latency authentication system <br><br> [AD FS extranet lockout](/windows-server/identity/ad-fs/operations/configure-ad-fs-extranet-soft-lockout-protection) <br><br> [Integration with third-party identity systems](/azure/active-directory/hybrid/how-to-connect-fed-compatibility) |

> [!NOTE]
> Custom controls in Azure AD Conditional Access does not currently support device registration.

## Next steps

<!-- TODO: The download button for this white paper returns 404. -->

<!-- docutune:casing "Hybrid Identity Digital Transformation Framework" -->

The Hybrid Identity Digital Transformation Framework white paper outlines combinations and solutions for choosing and integrating each of these components.

The [Azure AD Connect tool](https://aka.ms/aadconnectwiz) helps you to integrate your on-premises directories with Azure AD.
