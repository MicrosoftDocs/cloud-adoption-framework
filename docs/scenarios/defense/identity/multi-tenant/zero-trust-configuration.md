---
title: Zero trust configuration for multitenant defense organizations
description: Guidance for configuring zero trust identity for multitenant defense organizations
author: amasse3
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 07/10/2023
ms.topic: conceptual
---

# Zero trust configuration for multitenant defense organizations

This article shows multitenant organizations how to apply configurations in Microsoft Entra ID and meet common defense zero trust requirements. Follow these recommendations to establish the right multitenant identity architecture and implement zero trust in your environment.

:::image type="content" source="./images/multi-tenant-architecture.png" alt-text="Diagram showing a sample multitenant architecture with zero trust configurations. It shows a primary tenant and two secondary tenants." lightbox="./images/multi-tenant-architecture.png" border="false":::
*Figure 1: Sample multitenant defense architecture with zero trust configurations.*

## Determine identity architecture

Microsoft Entra tenants are the foundation of your identity architecture. A tenant is an identity boundary in Microsoft Entra ID. An organization with one Microsoft Entra tenant has a single tenant architecture. Organizations using more than one Microsoft Entra tenant have a multitenant architecture.

**Benefits of a single tenant.** A single tenant is easier to manage and lower costs through operational efficiency. It allows you to configure a zero trust environment more easily. A single tenant avoids fragmenting the user experience with multiple sign-in credentials. It also helps prevent siloed solutions that you need to integrate later. You should strive to have your data, Microsoft 365, and Azure cloud services in a single tenant. If you already have multiple Microsoft Entra tenants, you should consider consolidating your environment to use a single tenant. You can consolidate tenants by transferring Azure subscriptions from your secondary tenants to the primary tenant. For more information, see [transfer an Azure subscription to a different Microsoft Entra directory](/azure/role-based-access-control/transfer-subscription).

**Multi-tenant use cases.** There are reasons for a defense organization to use a multitenant architecture. Large and complex defense organizations might need multiple Microsoft Entra tenants for security, compliance, and collaboration (*see table 1*).

*Table 1. Reasons to have or create multiple tenants.*

| Reason  | Example  |
|:-----|:----|
| Privacy or Security requires a deeper separation of data | An Office of Inspector General organization must have independence.                                   |
| Delegation and Segmentation of administration      | One organization doesn't have the ability to manage another organization.                               |
| Data Sovereignty and/or Ownership            | One organization doesn't have the legal authority to manage data of another organization.                      |
| Network and IT Organization               | It’s not possible nor favorable to collapse multiple large corporate enterprise IT architectures into a single enterprise architecture. |
| SOC Monitoring and Incident Response           | SOC needs separate tenant to manage their roles and responsibilities.

If you require multiple Microsoft Entra tenants, you should use [Microsoft Entra External ID (B2B)](/azure/active-directory/external-identities/what-is-b2b) and [Azure Lighthouse](/azure/lighthouse/overview). These features help support multitenant defense environments. For more information, see [Tenancy models for a multitenant solution](/azure/architecture/guide/multitenant/considerations/tenancy-models).

## Identify tenant types

Multitenant defense organizations can categorize Microsoft Entra instances they use as either primary or secondary. Each organization should identify and designate one tenant as the primary tenant. All other tenants are secondary. *Figure 1* shows a defense organization with a primary tenant and *n* secondary tenants (two secondary tenants shown).

**Identify the primary tenant.** Most defense organizations create the primary tenant when they sign up for Microsoft 365. The primary tenant contains (1) all user identities and Microsoft 365 licenses, (2) devices, and (3) applications (*see figure 1*). Defense organizations often use [Microsoft Entra Connect](/azure/active-directory/hybrid/connect/whatis-azure-ad-connect) to synchronize the identities from Active Directory on-premises to the primary Microsoft Entra tenant.

Some defense organizations consume Microsoft 365 in a shared tenant owned and operated by an outside agency. This agency acts as a shared service provider for Microsoft 365. Your organization might not manage or control the shared tenant, but it contains the licensed Microsoft Entra identities your users likely use for Office 365 and other applications. In this scenario, the shared service provider tenant is your primary tenant.

**Identify all secondary tenants (if multi-tenant).** All other tenants that the organization manages are secondary tenants. You might have secondary tenants if you migrated applications to the cloud before standing up an [enterprise-scale Azure landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation). You typically use secondary tenants to manage (4) Azure workloads with external users (B2B guests) or (5) cloud only accounts (*see figure 1*).

**Use the decision tree.** The easiest way to find your primary tenant is to consider the identity licenses you have in Microsoft Entra ID.

The tenant with your Microsoft 365 licenses is your primary tenant (*see figure 2*). The primary tenant might not be the first tenant created by your organization, but it should be the main tenant with all your users and Microsoft 365 licenses.

If your organization doesn’t use Microsoft 365, any Microsoft Entra tenant with [Enterprise Mobility and Security (EMS)](/enterprise-mobility-security/) licenses is your primary tenant. This tenant is where you added and verified your organization's [domain name](/azure/active-directory/enterprise-users/domains-manage). The tenant often uses hybrid identity or integrates with a human resources (HR) system (*see figure 2*).

:::image type="content" source="./images/tenant-decision-tree.png" alt-text="Diagram showing a decision tree to determine if a Microsoft Entra tenant is primary or secondary. If it's a Microsoft 365 tenant, then it's the primary tenant. If the tenant has hybrid identity configured and has enterprise mobility and security licenses, then it's a primary tenant. All other tenants are secondary." lightbox="./images/tenant-decision-tree.png" border="false":::<br>
*Figure 2. A decision tree to determine the Microsoft Entra primary tenant and secondary tenant.*

To establish Microsoft Entra ID as a zero trust platform, you need a tenant populated with your user identities and licensed for user and device-based access policies.  Microsoft 365 licensing bundles these zero trust capabilities with Office 365. If you don't use Microsoft 365, consider [Enterprise Mobility \+ Security E5](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/compare-plans-and-pricing) to establish a cloud-based identity provider for zero trust. For more information, see [Choosing your identity authority](/azure/azure-government/documentation-government-plan-identity#choosing-your-identity-authority).

## Configure zero trust

When managing identities in Microsoft Entra ID, you should consider the following recommendations for each tenant type. There are general recommendations for all tenant types that you should adopt first. After implementing those general recommendations, find the recommendations for your specific tenant type (primary or secondary) and then apply those recommendations. For more information, see the [Zero Trust Rapid Modernization Plan](/security/zero-trust/zero-trust-ramp-overview)[Security Rapid Modernization Plan](/security/privileged-access-workstations/security-rapid-modernization-plan).

### All tenants

You should implement the following recommendations in all Microsoft Entra tenants.

**Establish emergency access accounts and procedures.** Create two or more emergency access accounts to avoid being locked out of your Microsoft Entra tenant. You need to assign the Global Administrator role to these accounts. The accounts should be cloud-only accounts. Cloud-only accounts use the *\*.onmicrosoft.com* domain. For more information, see [Manage emergency access admin accounts](/azure/active-directory/roles/security-emergency-access).

**Protect Microsoft Entra ID from on-premises attacks.** Follow best practices outlined in [Securing Privileged Access](https://aka.ms/privsec). Only assign Microsoft Entra permissions to cloud-only user accounts with phishing-resistant credential like Hardware Passkey or Certificate-Based authentication. Don't use federated identities for administrative purposes. For more information, see [Protect Microsoft 365 from on-premises attacks](/azure/active-directory/fundamentals/protect-m365-from-on-premises-attacks).

**Use Privileged Identity Management.** Use [Microsoft Entra Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to manage role assignments for Microsoft Entra ID and Azure roles. You should also use PIM to manage eligible group membership for privileged security groups. Establish periodic [access reviews](/azure/active-directory/governance/manage-access-review) for eligible administrators and external users (B2B guests).

**Enable cloud-based authentication for all users.** Cloud-based authentication methods are more secure than federated authentication. They offer a better single sign-on experience when combined with Microsoft Entra joined devices. Federated authentication exposes Microsoft Entra ID to on-premises Active Directory compromises.

[Microsoft Entra certificate-based authentication](/azure/active-directory/authentication/concept-certificate-based-authentication) makes it unnecessary to federate Microsoft Entra domains. Microsoft Entra authentication supports the following [passwordless authentication methods](/azure/active-directory/authentication/concept-authentication-methods):

- Security Keys (FIDO2 / Passkey)
- Certificate-Based Authentication
- Microsoft authenticator
- Windows Hello for Business

**Establish baseline conditional access policies.** Conditional access baseline varies by organization and requirements. Establish a core set of conditional access policies for all Microsoft Entra tenants. Use identity, device, application, and risk conditions within your policy set. Risk conditions use risk level detected by [Microsoft Entra ID Protection](https://learn.microsoft.com/en-us/entra/id-protection/overview-identity-protection). This feature helps organizations detect, investigate, and remediate [identity-based risks](/entra/id-protection/concept-identity-protection-risks). To protect risky sign-ins and users, create Conditional Access baseline policies with risk conditions, increasing protection controls with risk level. Build your baseline using the Conditional Access policy checklist (*see table 2*).

> [!NOTE]
> User risk is remediated by password change using the **Require password change** grant control in [Conditional Access](/entra/identity/authentication/tutorial-risk-based-sspr-mfa#enable-user-risk-policy-for-password-change). Passwordless users, including users who sign-in with certificate-based authentication, may be blocked by this control. The policy set in *table 2* assumes users are passwordless and uses authentication strength and sign-in frequency controls instead of requiring password change. These controls do not remediate the user's risk level in Microsoft Entra ID Protection. Your security operations team should [investigate](/entra/id-protection/howto-identity-protection-investigate-risk) and [remediate](/entra/id-protection/howto-identity-protection-remediate-unblock) high risk users accordingly.

*Table 2: Conditional Access policy checklist.*

| Policy name          | Users   | Applications   | Conditions  | Grant control         |
|:-------------------------------|:----------|:------------------|:-------------|:-------------------------------|
|MFA for all users|All Users|All Apps|None|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA|
|Require Managed Devices|All Users|All Apps|None|[Require Microsoft Entra hybrid joined or compliant device](/azure/active-directory/conditional-access/howto-conditional-access-policy-compliant-device)|
|Protect medium risk sign-ins|All Users|All Apps|[Medium sign-in risk](/azure/active-directory/identity-protection/concept-identity-protection-policies#sign-in-risk-based-conditional-access-policy)|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA<br>[Sign-in Frequency](/entra/identity/conditional-access/howto-conditional-access-session-lifetime): 1 Hour|
|Protect high risk sign-ins|All Users|All Apps|[High sign-in risk](/azure/active-directory/identity-protection/concept-identity-protection-policies#sign-in-risk-based-conditional-access-policy)|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA<br>[Sign-in Frequency](/entra/identity/conditional-access/howto-conditional-access-session-lifetime): Every Time|
|Protect high risk users|All Users|All Apps|[High user risk](/entra/identity/authentication/tutorial-risk-based-sspr-mfa#enable-sign-in-risk-policy-for-mfa)|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA<br>[Sign-in Frequency](/entra/identity/conditional-access/howto-conditional-access-session-lifetime): Every Time|
|Secure Microsoft Entra Administration|[Microsoft Entra roles](/azure/active-directory/roles/concept-understand-roles)|All Apps|None|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA<br>Require Compliant [Privileged Access Workstation](/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)|
|Secure Cloud Management|All Users|Azure Management<br>[Google Cloud Platform](/azure/active-directory/saas-apps/google-apps-tutorial)<br>[Amazon Web Services](/azure/active-directory/saas-apps/aws-multi-accounts-tutorial)|None|[Authentication strength](/azure/active-directory/authentication/concept-authentication-strengths): phishing-resistant MFA<br>Require Compliant [Privileged Access Workstation](/security/privileged-access-workstations/privileged-access-deployment) (PAW) using [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices)|

For more information, see [Zero Trust identity and device access configuration](/microsoft-365/security/office-365-security/microsoft-365-policies-configurations).

**Use primary tenant identities for accessing all applications.** Users should be able to access applications using their identity in the primary tenant. You need to register applications in the primary tenant. Establish a policy to [register applications](/azure/active-directory/develop/quickstart-register-app) with the primary tenant, regardless of the application infrastructure hosting location.

For legacy applications that don't support modern authentication protocols, use [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy) service in the primary tenant. Microsoft Entra application proxy brings Microsoft Entra zero trust features to existing legacy applications without code changes.

When a shared service provider or an external agency controls your primary tenant, they should [delegate application registration permissions](/azure/active-directory/roles/delegate-app-roles). If the service provider doesn't offer this delegation, you need to register applications with the secondary tenant that your organization controls instead. However, users should still access these applications without creating a new identity in the secondary tenant. For this setup, assign user access using [external identities](/azure/active-directory/external-identities/external-identities-overview) (B2B guests) for your users in the primary tenant. For more information, see [Secure applications with zero trust](/security/zero-trust/deploy/applications).

**Use Microsoft Entra ID to manage other cloud environments.** Microsoft Entra ID isn't just an identity platform for Azure and Microsoft 365. Use Microsoft Entra ID to gain access to other cloud environments. These environments include popular software-as-a-service (SaaS) products and cloud platforms like Amazon Web Services (AWS) and Google Cloud Platform (GCP). For more information, see the [Microsoft Entra Application gallery](/azure/active-directory/manage-apps/overview-application-gallery).

**Use a secure cloud computing architecture (SCCA).** Each defense organization should deploy an [SCCA-compliant](/azure/azure-government/compliance/secure-azure-computing-architecture) landing zone architecture. The landing zone should be in Azure subscriptions attached to the primary tenant.

**Segment Azure resource management in a single tenant.** You should use Azure roles for resource and management isolation for subscriptions within an [enterprise-scale Azure landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation). Consider [transferring subscriptions](/azure/role-based-access-control/transfer-subscription) from secondary tenants to the primary tenant.

**Use Microsoft Entra Permissions Management.** [Microsoft Entra Permissions Management](/azure/active-directory/cloud-infrastructure-entitlement-management/overview) is Microsoft’s Cloud Infrastructure Entitlement Management (CIEM) solution. You should use Microsoft Entra Permissions Management for visibility into permissions assigned to all identities. You should also use it to track [permissions creep](/azure/active-directory/cloud-infrastructure-entitlement-management/faqs#what-is-the-permissions-creep-index) across your organization's multicloud environment.

**Use Microsoft Entra ID Governance.** Use [Microsoft Entra ID Governance](/azure/active-directory/governance/identity-governance-overview) to automate access assignment lifecycle for users and guests. Conduct access reviews to remove access to your cloud environment for users that no longer need it.

**Secure workload identities.** Use [Microsoft Entra Workload ID](/azure/active-directory/workload-identities/workload-identities-overview) features to manage and apply adaptive zero trust policies for application identities (service principals) in Microsoft Entra ID.

**Enable Defender for Cloud for your enterprise.** Use [Defender for Cloud for your multicloud environment](/azure/defender-for-cloud/multicloud). Make sure you [turn on the enhanced security features](/azure/defender-for-cloud/enable-enhanced-security) to monitor Azure resources and remediate configuration risk. Defender for Cloud protection extends beyond Azure to help you [secure hybrid and multicloud environments](/azure/defender-for-cloud/plan-multicloud-security-get-started).

**Deploy Sentinel and connect all available data sources.** Aggregate security signals in a SIEM like [Microsoft Sentinel](/azure/sentinel/quickstart-onboard). Deploy Sentinel and connect all security signal data sources by configuring [data connectors](/azure/sentinel/connect-data-sources).

### Primary tenants

You should implement the following recommendations in the primary tenant only.

**End users only have one identity in Entra ID.** [Synchronize on-premises Active Directory Domain Services](/security/zero-trust/deploy/identity#connect-all-of-your-users-to-azure-ad-and-federate-with-on-premises-identity-systems) with the primary Microsoft Entra tenant. The synchronization populates Microsoft Entra ID with users, groups, and devices for the organization. External B2B guests might exist in secondary tenants, but users only need to remember one username for all applications and services. The user experience and zero trust outcomes are best when you use the identities in the primary tenant for Windows sign-in and application access.

**Join and manage devices with the primary tenant.** The primary Microsoft Entra tenant contains all users and devices within the organization. Microsoft Entra join (or Microsoft Entra hybrid join) Windows devices to the primary tenant and manage with Microsoft Intune. [Use Intune policy to deploy Microsoft Defender for Endpoint](/mem/intune/protect/mde-security-integration) enabling extended detection and response (XDR) capability.

**Delegate application registration permissions.** Enterprise Apps, including application code running in any Azure subscription, use the primary Microsoft Entra ID tenant for user identity. Make developers eligible for the [Application Developer Microsoft Entra role](/azure/active-directory/roles/permissions-reference#application-developer) or a [custom app registration role](/azure/active-directory/roles/custom-available-permissions) using Privileged Identity Management. This configuration allows developers building applications in secondary tenants to register them with the primary tenant for identity.

**Attach platform-as-a-service (PaaS) services that need end user identity.** Some PaaS services, like [Azure Files](/azure/storage/files/storage-files-introduction) and [Azure Virtual Desktop](/azure/virtual-desktop/overview), depend on hybrid identity configuration or license entitlements. You must deploy these services to Azure subscriptions in the primary tenant.

### Secondary tenants

You should implement the following recommendations in the secondary tenant.

**Procure licenses required for Microsoft Entra management**. You need licenses to turn on advanced security features in secondary tenants. Consider the licenses you need for users, workloads, and devices.

*User identities.* You need to have [Microsoft Entra ID P2](https://www.microsoft.com/security/business/identity-access/azure-active-directory-pricing) licenses for tenant administrators and emergency access accounts. If you use an external identity (B2B guest) management model, you must assign at least one Microsoft Entra ID P2 license to a local user in the tenant. This setup allows you to enable premium features like [Conditional Access](/azure/active-directory/conditional-access/overview) and [Identity Protection](/azure/active-directory/identity-protection/overview-identity-protection). For more information, see [Common considerations for multitenant user management](/azure/active-directory/fundamentals/multi-tenant-common-considerations#azure-ad-conditional-access-considerations).

*Workload identities.* You should use [workload identities premium](/azure/active-directory/workload-identities/workload-identities-overview) to secure workload identities with access to resources in the primary tenant, such as MS Graph API.

*Device management.* You might need manage devices with Microsoft Intune in the secondary tenant. If so, you need to procure [Enterprise Mobility and Security (EMS)](/enterprise-mobility-security/solutions/ems-govt-service-description) licenses.

**Configure cross-tenant access policies (XTAP).** Microsoft Entra External ID (Microsoft Entra B2B collaboration) [cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview) allow a secondary tenant to trust certain claims from the home primary tenant. Add the primary Microsoft Entra tenant as an organization and update the [inbound trust settings](/graph/api/resources/crosstenantaccesspolicy-overview) to include:

- Trust multifactor authentication (MFA) from Microsoft Entra tenants
- Trust compliant devices
- Trust Microsoft Entra hybrid joined devices
- Optional: Automatically redeem invitations with the tenant.

**Manage the secondary tenant with identities from the primary tenant.** Reduce administrative overhead and cost by using external users (B2B guests) from the primary tenant to manage the secondary tenant and Azure resources. Assign Microsoft Entra roles following [least-privilege Microsoft Entra role by task](/azure/active-directory/roles/delegate-by-task) using [Microsoft Entra Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user). Use [end-user initiated access](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) or [cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview) to reduce management overhead onboarding external identities in the secondary tenant.

**Use Azure Lighthouse to facilitate Sentinel access from the primary tenant.** [Azure Lighthouse](/azure/lighthouse/overview) gives you another way to manage Azure across tenants. Azure Lighthouse uses [Azure Resource Manager (ARM) templates](/azure/lighthouse/how-to/onboard-customer) to assign Azure roles to identities in an external tenant. This approach doesn't use B2B guest user objects. When an administrator signs in to the portal to manage Azure, they see all resources across all tenants. This consolidated view includes subscriptions with permissions assigned by Azure Lighthouse. Since there's no B2B guest object, the administrator doesn't need to switch directories. Use Azure Lighthouse to facilitate [managing Microsoft Sentinel across tenants](/azure/sentinel/multiple-tenants-service-providers).

## Next step

> [!div class="nextstepaction"]
> [Manage multi-tenant operations](manage-operations.md)

## Related links

- [Identity essentials](essentials.md)
- [Zero trust configurations](zero-trust-configuration.md)
- [Centralized security operations](security-operations.md)
