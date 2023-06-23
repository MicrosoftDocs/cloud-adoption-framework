---
title: Zero trust configuration for multi-tenant defense organizations
description: Guidance for configuring zero trust identity for multi-tenant defense organizations
author: stephen-sumner
ms.author: andrmass
ms.reviewer: ssumner
ms.date: 06/30/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Zero trust configuration for multi-tenant Defense organizations

This article helps you apply baseline zero trust configurations to meet consensus defense requirements. Follow these recommendations to establish the right identity architecture and zero trust environment for zero trust.

:::image type="content" source="./images/multi-tenant-architecture.png" alt-text="Diagram showing a sample multi-tenant architecture with zero trust configurations." lightbox="./images/multi-tenant-architecture.png" border="false":::

*Figure 1: Sample multi-tenant defense architecture with zero trust configurations.*

## Determine identity architecture

Azure Active Directory (Azure AD) tenants are the foundation of your identity architecture. An organization with one Azure AD tenant has a single tenant architecture. Organizations using more than one Azure AD tenant have a multi-tenant architecture.

**Single tenant benefits.** You should strive for a single tenant across their data estate. Microsoft 365 and Azure cloud services. A single tenant is easier to manage and lower costs through operational efficiency. You can more easily configure a zero trust environment without fragmenting or creating siloed solutions that might need to be integrated down the road. If you already have multiple Azure AD tenants, you can consolidate to a single tenant. You need to transfer the Azure subscriptions in your secondary tenants to the primary tenant. For more information, see [Transfer an Azure Subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription).

**Multi-tenant use cases.** There are reasons for a defense organization to use a multi-tenant architecture. Large and complex defense organizations need multiple Azure AD tenants for security, compliance, and collaboration (*see table 1*).

*Table 1. Reasons to have or create multiple tenants.*
| Reason         | Example                                                                |
|:---------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------|
| Privacy or Security requires a deeper separation of data | An Office of Inspector General organization must have independence                                   |
| Delegation and Segmentation of administration      | One organization does not have the ability to manage another organization                               |
| Data Sovereignty and/or Ownership            | One organization does not have the legal authority to manage data of another organization                       |
| Network and IT Organization               | It’s not possible nor favorable to collapse multiple large corporate enterprise IT architectures into a single enterprise architecture |
| SOC Monitoring and Incident Response           | SOC needs separate tenant to manage their roles and responsibilities.

If you require multiple Azure AD tenants, you should understand B2C and B2B features in Azure AD. These features help support multi-tenant defense environments. For more information, see [Tenancy models for a multitenant solution](/azure/architecture/guide/multitenant/considerations/tenancy-models).

## Identify tenant types

When you manage more than one Azure AD tenant, you need to identify the primary tenant and all secondary tenants (*see figure 1*).

**Identity the primary tenant:** Most defense organizations create the primary tenant to use Microsoft 365 (M365). The primary tenant contains all your user identities (1) M365 licenses (2), devices (3), and applications (3). Defense organizations often use Azure AD Connect to synchronize the identities in the primary tenant with Active Directory on-premises.

Some defense organizations consume services from a parent or partner organization. We call this parent or partner organization a shared service provider. Many defense organizations access M365 from a shared service provider. The tenant with your M365 licenses is your primary tenant even if your organization doesn’t manage or control the tenant.

**Identify all secondary tenants (if multi-tenant).** All other tenants that the organization manages are secondary tenants. You might have secondary tenants if components within your organization moved to the cloud before an [enterprise scale landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) was stood up. You typically use secondary tenants to manage Azure workloads (4) with external users (B2B guests) or cloud only accounts (5) (*see figure 1*).

**Use the decision tree.** The easiest way to find your primary tenant is to consider the identity services available and licensed in Azure AD.

- If your organization uses M365, the tenant with your M365 licensed users is the primary tenant (*see figure 2*). Your M365 tenant is primary even if other Azure AD tenants used for Azure workload migration preceded it.
- If your organization doesn’t use M365, any Azure AD tenant with EMS licenses is your primary tenant. This tenant is where you have registered and verified your domain name. The tenant often uses hybrid identity or integrates with a human resources (HR) system (*see figure 2*).

:::image type="content" source="./images/tenant-decision-tree.png" alt-text="Diagram showing a decision tree to determine if an Azure AD tenant is primary or secondary. If it is a Microsoft 365 tenant, then it's the primary tenant. If the tenant has hybrid identity configured and has enterprise mobility and security licenses, then its a primary tenant. All other tenants are secondary." lightbox="./images/tenant-decision-tree.png" border="false":::
*Figure 2. Decision tree to determine the Azure AD tenant type.*

If your organization does not use M365, consider [Enterprise Mobility \+ Security E5](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/compare-plans-and-pricing) to establish a cloud-based identity provider for zero trust. For more information, see [Choosing your identity authority](/azure/azure-government/documentation-government-plan-identity#choosing-your-identity-authority).

## Configure zero trust

When managing identities in Azure AD, you should consider the following recommendations for each tenant type. There are general recommendations for all tenant types that you should adopt first. After implementing those general recommendations, find the recommendations for your specific tenant type (primary or secondary) and then apply those recommendations.

### All tenants

You should implement the following recommendations in all Azure AD tenants.

**Establish emergency access accounts and procedures.** Create two or more emergency access accounts to avoid being locked out of your Azure AD tenant. You need to assign the Global Administrator role to these accounts. The accounts should be cloud-only accounts. Cloud-only accounts use the *\*.onmicrosoft.com* domain. See [Manage emergency access admin accounts](/azure/active-directory/roles/security-emergency-access) for more information.

**Protect Azure AD from on-premises attacks.** Follow best practices outlined in [Securing Privileged Access](https://aka.ms/privsec). Only assign Azure AD permissions to cloud-only user accounts with phishing-resistant credential like Hardware Passkey or Certificate-Based authentication. Do not use federated identities for administrative purposes. See [Protect Microsoft 365 from on-premises attacks](/azure/active-directory/fundamentals/protect-m365-from-on-premises-attacks) for more information.

**Use Privileged Identity Management.** Use Azure AD PIM to manage role assignments for Azure AD and Azure roles, and eligible group membership for privileged security groups. Establish periodic [access reviews](/azure/active-directory/governance/manage-access-review) for eligible administrators and external users (B2B guests).

**Enable Cloud-Based authentication for all users.** Federated authentication exposes Azure AD to on-premises Active Directory compromises. Cloud-based authentication methods are more secure and, when combined with Azure AD joined devices, offer a better single sign-on experience.

With the general availability of [Azure AD certificate-based authentication](/azure/active-directory/authentication/concept-certificate-based-authentication), there is no technical reason to federate Azure AD domains. Azure AD Authentication supports the following [passwordless authentication methods:](/azure/active-directory/authentication/concept-authentication-methods)

- Security Keys (FIDO2 / Passkey)
- Certificate-Based Authentication
- Microsoft authenticator
- Windows Hello for Business

**Establish baseline Conditional Access Policy set.** Conditional Access baseline varies by organization and requirements. Establish a core set of Conditional Access policies for all Azure AD tenants. Consider implementing a policy baseline including the policies in *table 2*.

*Table 2: Conditional access policy checklist.*
| Policy Name          | Users   | Applications   | Conditions  | Grant Control         |
|:-------------------------------|:----------|:------------------|:-------------|:-------------------------------|
|MFA for all users|All Users|All Apps|None|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA
|Require Managed Devices|All Users|All Apps|None|[Require hybrid Azure AD Joined or compliant device](/azure/active-directory/conditional-access/howto-conditional-access-policy-compliant-device)
|Block risky sign ins|All Users|All Apps|[High Sign-in Risk](/azure/active-directory/identity-protection/concept-identity-protection-policies#sign-in-risk-based-conditional-access-policy)|[Block](/azure/active-directory/conditional-access/howto-conditional-access-policy-block-access)
|Secure Azure AD Administration|[AAD Roles](/azure/active-directory/roles/concept-understand-roles)|All Apps|None|Require Compliant [Privileged Access Workstation](/azure/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)
|Secure Cloud Management|All Users|Azure Management<br>[Google Cloud Platform](/azure/active-directory/saas-apps/google-apps-tutorial)<br>[Amazon Web Services](/azure/active-directory/saas-apps/aws-multi-accounts-tutorial)|None|Require Compliant [Privileged Access Workstation](/azure/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)

For more information, see [Zero Trust identity and device access configuration](/azure/microsoft-365/security/office-365-security/microsoft-365-policies-configurations?view=o365-worldwide).

**Use the primary tenant identities for accessing all applications.** Applications should use the primary tenant identity for end user access. Establish a policy to [register applications](/azure/active-directory/develop/quickstart-register-app) with the primary tenant, regardless of the application infrastructure hosting location.

For legacy applications that do not support modern authentication protocols, use [Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy) service in the primary tenant to bring Azure AD zero trust features to existing legacy applications without code changes.

If the primary tenant is controlled by a service provider or external agency that does not [delegate application registration permissions](/azure/active-directory/roles/delegate-app-roles), register applications with the secondary tenant your organization controls instead. Assign user access using [external identities](/azure/active-directory/external-identities/external-identities-overview) (B2B guests) for your organization’s users homed in the primary tenant.

For more information, see [Secure applications with zero trust](/azure/security/zero-trust/deploy/applications).

**Use Azure AD for managing other cloud environments.** Azure AD is not just an identity platform for Azure and M365. Use Azure AD to gain access to other cloud environments for popular Software as a Service (SaaS) and cloud platforms like AWS and GCP. See the [Azure AD Application gallery](/azure/active-directory/manage-apps/overview-application-gallery) for more information.

**Use SCCA architecture.** Each Defense organization should deploy [SCCA-compliant](/azure/azure-government/compliance/secure-azure-computing-architecture) landing zone architecture in subscriptions attached to the primary tenant.

**Segment Azure resource management in a single tenant.** You should use Azure RBAC for resource and management isolation for subscriptions within an [Azure Mission Landing Zone](https://github.com/Azure/missionlz). Consider [transferring subscriptions](/azure/role-based-access-control/transfer-subscription) from secondary tenants to the primary tenant.

**Use Entra Permissions Management.** [Entra Permission’s Management](/azure/active-directory/cloud-infrastructure-entitlement-management/overview) is Microsoft’s Cloud Infrastructure Entitlement Management (CIEM) solution. You should use Entra Entitlement’s Management for visibility into permissions assigned to all identities within the tenant.

**Use Entra Identity Governance.** Use [Entra Identity Governance](/azure/active-directory/governance/identity-governance-overview) to automate access assignment lifecycle for users and guests. Conduct access reviews to avoid proliferation of access within your cloud environment.

**Secure workload identities.** Use [Entra Workload Identities](/azure/active-directory/workload-identities/workload-identities-overview) features to manage and apply adaptive zero trust policies for non-person identities including applications and identities Azure resources.

**Enable Defender for Cloud for your enterprise.** Use [Defender for Cloud for your multicloud environment](/azure/defender-for-cloud/multicloud) and [turn on the enhanced security features](/azure/defender-for-cloud/enable-enhanced-security) to monitor Azure resources, remediate configuration risk, and detect threats within Azure subscriptions, on-premises, and in other clouds.

**Deploy Sentinel and connect all available data sources.** Aggregate security telemetry in a SIEM like [Microsoft Sentinel](/azure/sentinel/quickstart-onboard). Deploy Sentinel and connect all security signal data sources by configuring [data connectors](/azure/sentinel/connect-data-sources).

### Primary tenants

You should implement the following recommendations in the primary tenant only.

**End users only have one identity in Azure AD.** [Synchronize on-premises Active Directory Domain Services](/azure/security/zero-trust/deploy/identity#connect-all-of-your-users-to-azure-ad-and-federate-with-on-premises-identity-systems) with the primary Azure AD tenant. This populates Azure AD with users, groups, and devices for the organization. External B2B guests might exist in secondary tenants, but users only need to remember one username for all applications and services. The user experience and zero trust outcomes are best when you use the identities in the primary tenant for Windows logon and application access.

**Join and manage devices with the Primary tenant.** The primary Azure AD tenant contains all users and devices within the organization. Azure AD Join (or hybrid Azure AD Join) Windows devices to the primary tenant and manage with Microsoft Intune. [Use Intune policy to deploy Microsoft Defender for Endpoint](/azure/mem/intune/protect/mde-security-integration) enabling extended detection and response (XDR) capability.

**Delegate application registration permissions.** Enterprise Apps, including application code running in any Azure subscription, use the primary Azure AD for user identity. Make developers eligible for the [Application Developer Azure AD role](/azure/active-directory/roles/permissions-reference#application-developer) or a [custom app registration role](/azure/active-directory/roles/custom-available-permissions) using Privileged Identity Management. This will allow developers building applications in secondary tenants to register them with the primary tenant for identity.

**Attach platform-as-a-service (PaaS) services that need end user identity.** Azure Files and Azure Virtual Desktop must run in subscriptions attached to the primary Azure AD tenant. See [Azure Virtual Desktop](#_Azure_Virtual_Desktop) for more information.

### <a id="_Secondary_tenants"></a>Secondary tenants

You should implement the following recommendations in the secondary tenant only.

**Procure licenses required for Azure AD management**. [Azure AD Premium P2](https://www.microsoft.com/security/business/identity-access/azure-active-directory-pricing) licenses should be procured for tenant administrators and emergency access accounts. Using an external identity (B2B guest) management model, at least one Azure AD P2 license must be assigned to a local user in the tenant for enabling premium features like Conditional Access and Entra Identity Governance. For more information, see [Common considerations for multi-tenant user management](/azure/active-directory/fundamentals/multi-tenant-common-considerations#azure-ad-conditional-access-considerations).

Workload identities with access to resources in the primary tenant, including MS Graph API, should be secured using [Workload Identities Premium](/azure/active-directory/workload-identities/workload-identities-overview).

If device management with Intune or Azure Information Protection is needed for some users in the secondary tenant, you will also need to procure [Enterprise Mobility and Security](/azure/enterprise-mobility-security/solutions/ems-govt-service-description) licenses.

**Configure Cross-Tenant Access Policies (XTAP).** Azure AD external identities (Azure AD B2B) [cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview) allow a secondary tenant to trust certain claims from the home primary tenant. Add the primary Azure AD tenant as an organization and update the Inbound access trust settings to include:

- Trust multifactor authentication (MFA) from Azure AD tenants
- Trust compliant devices
- Trust hybrid Azure AD joined devices
- Optional: Automatically redeem invitations with the tenant.

**Manage the secondary tenant with identities from the primary tenant.** Reduce administrative overhead and cost by using external users (B2B guests) from the primary tenant to manage the secondary tenant and Azure resources. Assign Azure AD roles following [least-privilege Azure AD role by task](/azure/active-directory/roles/delegate-by-task) using [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user). Use [end-user initiated access](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) or [cross-tenant synchronization](/azure/active-directory/fundamentals/multi-tenant-user-management-introduction#cross-tenant-synchronizationv) to reduce management overhead onboarding external identities in the secondary tenant.

**Use Azure Lighthouse to facilitate Sentinel access from the primary tenant**. Using [Azure Lighthouse](/azure/lighthouse/overview), users from a primary tenant can manage Azure resources in subscriptions attached to secondary tenants. This approach is recommended for [managing Microsoft Sentinel across multiple tenants](/azure/sentinel/multiple-tenants-service-providers).
