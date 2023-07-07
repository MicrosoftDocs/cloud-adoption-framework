---
title: Zero trust configuration for multi-tenant defense organizations
description: Guidance for configuring zero trust identity for multi-tenant defense organizations
author: stephen-sumner
ms.author: andrmass
ms.reviewer: ssumner
ms.date: 07/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Zero trust configuration for multi-tenant defense organizations

This article shows multi-tenant organizations how to apply configurations in Azure Active Directory (Azure AD) and meet common defense zero trust requirements. Follow these recommendations as part of your multi-tenant identity strategy to establish the right architecture for implementing zero trust in your environment.

:::image type="content" source="./images/multi-tenant-architecture.png" alt-text="Diagram showing a sample multi-tenant architecture with zero trust configurations. It shows a primary tenant and two secondary tenants." lightbox="./images/multi-tenant-architecture.png" border="false":::

*Figure 1: Sample multi-tenant defense architecture with zero trust configurations.*

## Determine identity architecture

Azure Active Directory (Azure AD) tenants are the foundation of your identity architecture. A tenant is an identity boundary in Azure AD. An organization with one Azure AD tenant has a single tenant architecture. Organizations using more than one Azure AD tenant have a multi-tenant architecture.

**Benefits of a single tenant.** A single tenant is easier to manage and lower costs through operational efficiency. It allows you to configure a zero trust environment more easily. A single tenant avoids fragmenting the user experience with multiple sign-in credentials. It also helps prevent siloed solutions that you need to integrate later. You should strive to have your data, Microsoft 365, and Azure cloud services in a single tenant. If you already have multiple Azure AD tenants, you should consider consolidating your environment to use a single tenant. You can consolidate tenants by transferring Azure subscriptions from your secondary tenants to the primary tenant. For more information, see [transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription).

**Multi-tenant use cases.** There are reasons for a defense organization to use a multi-tenant architecture. Large and complex defense organizations might need multiple Azure AD tenants for security, compliance, and collaboration (*see table 1*).

*Table 1. Reasons to have or create multiple tenants.*

| Reason         | Example                                                                |
|:---------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------|
| Privacy or Security requires a deeper separation of data | An Office of Inspector General organization must have independence.                                   |
| Delegation and Segmentation of administration      | One organization doesn't have the ability to manage another organization.                               |
| Data Sovereignty and/or Ownership            | One organization doesn't have the legal authority to manage data of another organization.                      |
| Network and IT Organization               | It’s not possible nor favorable to collapse multiple large corporate enterprise IT architectures into a single enterprise architecture. |
| SOC Monitoring and Incident Response           | SOC needs separate tenant to manage their roles and responsibilities.

If you require multiple Azure AD tenants, you should use [Azure AD external identities (B2B)](/azure/active-directory/external-identities/what-is-b2b) and [Azure Lighthouse](/azure/lighthouse/overview). These features help support multi-tenant defense environments. For more information, see [Tenancy models for a multitenant solution](/azure/architecture/guide/multitenant/considerations/tenancy-models).

## Identify tenant types

Multi-tenant defense organizations can categorize Azure AD instances they use as either primary or secondary. Each organization should identify and designate one tenant as the primary tenant. All other tenants are secondary. *Figure 1* shows a defense organization with a primary tenant and *n* secondary tenants (two secondary tenants shown).

**Identify the primary tenant.** Most defense organizations create the primary tenant when they sign up for Microsoft 365. The primary tenant contains (1) all user identities and Microsoft 365 licenses, (2) devices, and (3) applications (*see figure 1*). Defense organizations often use [Azure AD Connect](/azure/active-directory/hybrid/connect/whatis-azure-ad-connect) to synchronize the identities from Active Directory on-premises to the primary Azure AD tenant.

Some defense organizations consume Microsoft 365 in a shared tenant owned and operated by an outside agency. This agency acts as a shared service provider for Microsoft 365. Your organization might not manage or control the shared tenant, but it contains the licensed Azure AD identities your users likely use for Office 365 and other applications. In this scenario, the shared service provider tenant is your primary tenant.

**Identify all secondary tenants (if multi-tenant).** All other tenants that the organization manages are secondary tenants. You might have secondary tenants if you migrated applications to the cloud before standing up an [enterprise-scale Azure landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation). You typically use secondary tenants to manage (4) Azure workloads with external users (B2B guests) or (5) cloud only accounts (*see figure 1*).

**Use the decision tree.** The easiest way to find your primary tenant is to consider the identity licenses you have in Azure AD.

The tenant with your Microsoft 365 licenses is your primary tenant (*see figure 2*). If your organization migrated workloads to Azure before adopting Microsoft 365, then your organization created an Azure AD tenant to manage the Azure subscriptions. However, the tenant with the Microsoft 365 licenses is still the primary tenant even though you have an older Azure AD tenant.

If your organization doesn’t use Microsoft 365, any Azure AD tenant with [Enterprise Mobility and Security (EMS)](/enterprise-mobility-security/) licenses is your primary tenant. This tenant is where you have added and verified your organization's [domain name](/azure/active-directory/enterprise-users/domains-manage). The tenant often uses hybrid identity or integrates with a human resources (HR) system (*see figure 2*).

:::image type="content" source="./images/tenant-decision-tree.png" alt-text="Diagram showing a decision tree to determine if an Azure AD tenant is primary or secondary. If it's a Microsoft 365 tenant, then it's the primary tenant. If the tenant has hybrid identity configured and has enterprise mobility and security licenses, then it's a primary tenant. All other tenants are secondary." lightbox="./images/tenant-decision-tree.png" border="false":::<br>
*Figure 2. A decision tree to determine the Azure AD primary tenant and secondary tenant.*

To establish Azure AD as a zero trust platform, you need a tenant populated with your user identities and licensed for user and device-based access policies.  Microsoft 365 licensing bundles these zero trust capabilities with Office 365. If you don't use Microsoft 365, consider [Enterprise Mobility \+ Security E5](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/compare-plans-and-pricing) to establish a cloud-based identity provider for zero trust. For more information, see [Choosing your identity authority](/azure/azure-government/documentation-government-plan-identity#choosing-your-identity-authority).

## Configure zero trust

When managing identities in Azure AD, you should consider the following recommendations for each tenant type. There are general recommendations for all tenant types that you should adopt first. After implementing those general recommendations, find the recommendations for your specific tenant type (primary or secondary) and then apply those recommendations.

### All tenants

You should implement the following recommendations in all Azure AD tenants.

**Establish emergency access accounts and procedures.** Create two or more emergency access accounts to avoid being locked out of your Azure AD tenant. You need to assign the Global Administrator role to these accounts. The accounts should be cloud-only accounts. Cloud-only accounts use the *\*.onmicrosoft.com* domain. For more information, see [Manage emergency access admin accounts](/azure/active-directory/roles/security-emergency-access).

**Protect Azure AD from on-premises attacks.** Follow best practices outlined in [Securing Privileged Access](https://aka.ms/privsec). Only assign Azure AD permissions to cloud-only user accounts with phishing-resistant credential like Hardware Passkey or Certificate-Based authentication. Don't use federated identities for administrative purposes. For more information, see [Protect Microsoft 365 from on-premises attacks](/azure/active-directory/fundamentals/protect-m365-from-on-premises-attacks).

**Use Privileged Identity Management.** Use [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to manage role assignments for Azure AD and Azure roles. You should also use PIM to manage eligible group membership for privileged security groups. Establish periodic [access reviews](/azure/active-directory/governance/manage-access-review) for eligible administrators and external users (B2B guests).

**Enable cloud-based authentication for all users.** Cloud-based authentication methods are more secure than federated authentication. They offer a better single sign-on experience when combined with Azure AD joined devices. Federated authentication exposes Azure AD to on-premises Active Directory compromises.

[Azure AD certificate-based authentication](/azure/active-directory/authentication/concept-certificate-based-authentication) makes it unnecessary to federate Azure AD domains. Azure AD Authentication supports the following [passwordless authentication methods](/azure/active-directory/authentication/concept-authentication-methods):

- Security Keys (FIDO2 / Passkey)
- Certificate-Based Authentication
- Microsoft authenticator
- Windows Hello for Business

**Establish baseline conditional access policies.** Conditional access baseline varies by organization and requirements. Establish a core set of conditional access policies for all Azure AD tenants. Use the conditional access policy checklist as you build your baseline (*see table 2*).

*Table 2: Conditional access policy checklist.*

| Policy name          | Users   | Applications   | Conditions  | Grant control         |
|:-------------------------------|:----------|:------------------|:-------------|:-------------------------------|
|MFA for all users|All Users|All Apps|None|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA
|Require Managed Devices|All Users|All Apps|None|[Require hybrid Azure AD Joined or compliant device](/azure/active-directory/conditional-access/howto-conditional-access-policy-compliant-device)
|Block risky sign ins|All Users|All Apps|[High Sign-in Risk](/azure/active-directory/identity-protection/concept-identity-protection-policies#sign-in-risk-based-conditional-access-policy)|[Block](/azure/active-directory/conditional-access/howto-conditional-access-policy-block-access)
|Secure Azure AD Administration|[Azure AD Roles](/azure/active-directory/roles/concept-understand-roles)|All Apps|None|Require Compliant [Privileged Access Workstation](/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)
|Secure Cloud Management|All Users|Azure Management<br>[Google Cloud Platform](/azure/active-directory/saas-apps/google-apps-tutorial)<br>[Amazon Web Services](/azure/active-directory/saas-apps/aws-multi-accounts-tutorial)|None|Require Compliant [Privileged Access Workstation](/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)

For more information, see [Zero Trust identity and device access configuration](/microsoft-365/security/office-365-security/microsoft-365-policies-configurations).

**Use primary tenant identities for accessing all applications.** Users should be able to access applications using their identity in the primary tenant. You need to register applications in the primary tenant. Establish a policy to [register applications](/azure/active-directory/develop/quickstart-register-app) with the primary tenant, regardless of the application infrastructure hosting location.

For legacy applications that don't support modern authentication protocols, use [Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy) service in the primary tenant. Azure AD Application Proxy brings Azure AD zero trust features to existing legacy applications without code changes.

When a shared service provider or an external agency controls your primary tenant, they should [delegate application registration permissions](/azure/active-directory/roles/delegate-app-roles). If the service provider doesn't offer this delegation, you need to register applications with the secondary tenant that your organization controls instead. However, users should still access these applications without creating a new identity in the secondary tenant. For this setup, assign user access using [external identities](/azure/active-directory/external-identities/external-identities-overview) (B2B guests) for your users in the primary tenant. For more information, see [Secure applications with zero trust](/security/zero-trust/deploy/applications).

**Use Azure AD for managing other cloud environments.** Azure AD isn't just an identity platform for Azure and Microsoft 365. Use Azure AD to gain access to other cloud environments. These environments include popular software-as-a-service (SaaS) products and cloud platforms like Amazon Web Services (AWS) and Google Cloud Platform (GCP). For more information, see the [Azure AD Application gallery](/azure/active-directory/manage-apps/overview-application-gallery).

**Use a secure cloud computing architecture (SCCA).** Each defense organization should deploy an [SCCA-compliant](/azure/azure-government/compliance/secure-azure-computing-architecture) landing zone architecture. The landing zone should be in Azure subscriptions attached to the primary tenant.

**Segment Azure resource management in a single tenant.** You should use Azure RBAC for resource and management isolation for subscriptions within an [enterprise-scale Azure landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation). Consider [transferring subscriptions](/azure/role-based-access-control/transfer-subscription) from secondary tenants to the primary tenant.

**Use Entra Permissions Management.** [Microsoft Entra Permissions Management](/azure/active-directory/cloud-infrastructure-entitlement-management/overview) is Microsoft’s Cloud Infrastructure Entitlement Management (CIEM) solution. You should use Entra Permissions Management for visibility into permissions assigned to all identities. You should also use it to track [permissions creep](/azure/active-directory/cloud-infrastructure-entitlement-management/faqs#what-is-the-permissions-creep-index) across your organization's multicloud environment.

**Use Entra Identity Governance.** Use [Entra Identity Governance](/azure/active-directory/governance/identity-governance-overview) to automate access assignment lifecycle for users and guests. Conduct access reviews to remove access to your cloud environment for users that no longer need it.

**Secure workload identities.** Use [Entra Workload Identities](/azure/active-directory/workload-identities/workload-identities-overview) features to manage and apply adaptive zero trust policies for application identities (service principals) in Azure AD.

**Enable Defender for Cloud for your enterprise.** Use [Defender for Cloud for your multicloud environment](/azure/defender-for-cloud/multicloud). Make sure you [turn on the enhanced security features](/azure/defender-for-cloud/enable-enhanced-security) to monitor Azure resources and remediate configuration risk. Defender for Cloud protection extends beyond Azure to help you [secure hybrid and multicloud environments](/azure/defender-for-cloud/plan-multicloud-security-get-started).

**Deploy Sentinel and connect all available data sources.** Aggregate security telemetry in a SIEM like [Microsoft Sentinel](/azure/sentinel/quickstart-onboard). Deploy Sentinel and connect all security signal data sources by configuring [data connectors](/azure/sentinel/connect-data-sources).

### Primary tenants

You should implement the following recommendations in the primary tenant only.

**End users only have one identity in Azure AD.** [Synchronize on-premises Active Directory Domain Services](/security/zero-trust/deploy/identity#connect-all-of-your-users-to-azure-ad-and-federate-with-on-premises-identity-systems) with the primary Azure AD tenant. The synchronization populates Azure AD with users, groups, and devices for the organization. External B2B guests might exist in secondary tenants, but users only need to remember one username for all applications and services. The user experience and zero trust outcomes are best when you use the identities in the primary tenant for Windows sign-in and application access.

**Join and manage devices with the primary tenant.** The primary Azure AD tenant contains all users and devices within the organization. Azure AD Join (or hybrid Azure AD Join) Windows devices to the primary tenant and manage with Microsoft Intune. [Use Intune policy to deploy Microsoft Defender for Endpoint](/mem/intune/protect/mde-security-integration) enabling extended detection and response (XDR) capability.

**Delegate application registration permissions.** Enterprise Apps, including application code running in any Azure subscription, use the primary Azure AD for user identity. Make developers eligible for the [Application Developer Azure AD role](/azure/active-directory/roles/permissions-reference#application-developer) or a [custom app registration role](/azure/active-directory/roles/custom-available-permissions) using Privileged Identity Management. This configuration allows developers building applications in secondary tenants to register them with the primary tenant for identity.

**Attach platform-as-a-service (PaaS) services that need end user identity.** Some PaaS services, like [Azure Files](/azure/storage/files/storage-files-introduction) and [Azure Virtual Desktop](/azure/virtual-desktop/overview), depend on hybrid identity configuration or license entitlements. You must deploy these services to Azure subscriptions in the primary tenant.

### Secondary tenants

You should implement the following recommendations in the secondary tenant.

**Procure licenses required for Azure AD management**. You need licenses to turn on advanced security features in secondary tenants. Consider the licenses you need for users, workloads, and devices.

*User identities.* You need to have [Azure AD Premium P2](https://www.microsoft.com/security/business/identity-access/azure-active-directory-pricing) licenses for tenant administrators and emergency access accounts. If you use an external identity (B2B guest) management model, you must assign at least one Azure AD P2 license to a local user in the tenant. This setup allows you to enable premium features like [Conditional Access](/azure/active-directory/conditional-access/overview) and [Identity Protection](/azure/active-directory/identity-protection/overview-identity-protection). For more information, see [Common considerations for multi-tenant user management](/azure/active-directory/fundamentals/multi-tenant-common-considerations#azure-ad-conditional-access-considerations).

*Workload identities.* You should use [workload identities premium](/azure/active-directory/workload-identities/workload-identities-overview) to secure workload identities with access to resources in the primary tenant, such as MS Graph API.

*Device management.* You may have scenarios where you want to manage devices with Intune in the secondary tenant. If so, you need to procure [Enterprise Mobility and Security (EMS)](/enterprise-mobility-security/solutions/ems-govt-service-description) licenses.

**Configure cross-tenant access policies (XTAP).** Azure AD external identities (Azure AD B2B) [cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview) allow a secondary tenant to trust certain claims from the home primary tenant. Add the primary Azure AD tenant as an organization and update the [inbound trust settings](/graph/api/resources/crosstenantaccesspolicy-overview) to include:

- Trust multifactor authentication (MFA) from Azure AD tenants
- Trust compliant devices
- Trust hybrid Azure AD joined devices
- Optional: Automatically redeem invitations with the tenant.

**Manage the secondary tenant with identities from the primary tenant.** Reduce administrative overhead and cost by using external users (B2B guests) from the primary tenant to manage the secondary tenant and Azure resources. Assign Azure AD roles following [least-privilege Azure AD role by task](/azure/active-directory/roles/delegate-by-task) using [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user). Use [end-user initiated access](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) or [cross-tenant synchronization](/azure/active-directory/fundamentals/multi-tenant-user-management-introduction#cross-tenant-synchronizationv) to reduce management overhead onboarding external identities in the secondary tenant.

**Use Azure Lighthouse to facilitate Sentinel access from the primary tenant.** With [Azure Lighthouse](/azure/lighthouse/overview), users from a primary tenant can manage Azure resources in subscriptions attached to secondary tenants. This approach is recommended for [managing Microsoft Sentinel across multiple tenants](/azure/sentinel/multiple-tenants-service-providers).

## Next step

> [!div class="nextstepaction"]
> [Manage multi-tenant operations](manage-operations.md)

## Related links

- [Zero trust configurations](zero-trust-configuration.md)
- [Centralized security operations](security-operations.md)
