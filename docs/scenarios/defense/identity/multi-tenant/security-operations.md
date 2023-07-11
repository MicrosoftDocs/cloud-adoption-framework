---
title: Centralized security operations with external identities for multi-tenant defense organizations
description: Guidance for centralized security operations with external identities for multi-tenant defense organizations with zero trust requirements
author: amasse3
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 07/10/2023
ms.topic: conceptual
ms.subservice: scenario
---

# Centralized security operations with external identities for defense organizations

This article is for multi-tenant defense organizations with a centralized security operations team. It explains how you can manage multiple tenants and meet zero trust requirements with a single identity and [privileged access device](/security/privileged-access-workstations/privileged-access-deployment). With this configuration, security operators don't need multiple user accounts, credentials, and workstations to secure your environment. The setup supports zero trust capabilities in secondary tenants.

## Understand configuration components

This configuration requires Azure Lighthouse, external identities, and Privileged Identity Management.

**Use Azure Lighthouse to manage secondary tenants.** You need to use [Azure Lighthouse](/azure/lighthouse/overview) to manage Azure subscriptions attached to secondary tenants. Azure Lighthouse enables multi-tenant management with scalability, higher automation, and enhanced governance across resources.

Azure Lighthouse allows a security principal (user, group, or service principal) in one tenant have an Azure RBAC role to manage resources in a different tenant. With this setup, security operators in a primary tenant can seamlessly manage both [Sentinel](/azure/sentinel/extend-sentinel-across-workspaces-tenants) and [Defender for Cloud](/azure/defender-for-cloud/cross-tenant-management) across tenants.

**Use external identities to manage Microsoft Defender for Endpoint.** You can't use Azure Lighthouse to share Microsoft Defender for Endpoint (MDE) between tenants, so you need to use [external identities](/azure/active-directory/external-identities/what-is-b2b) (B2B guests). External identities let security operators in the primary tenant manage MDE in a secondary tenant without signing in with a different account or credential. The security operator needs to specify the tenant they're using. They should include the tenant ID in the Microsoft 365 Defender portal URL to specify the tenant. Your operators should bookmark the Microsoft 365 Defender portals for each tenant they need to manage. To complete the setup, you need to configure [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) in the secondary tenant. The XTAP policies should trust multi-factor authentication (MFA) and device compliance from the primary tenant. This configuration lets the guest users manage MDE without creating exceptions for existing conditional access policies for secondary tenants.

 When you enable Defender for Server in a subscription linked to the secondary tenant, the MDE extension automatically deploys and begins providing security telemetry to the MDE service. It uses the same secondary tenant. MDE permissions can't use Azure Lighthouse. You must assign them to users or groups in the local (secondary) Azure AD. You need to onboard security operators as external identities (B2B guests) in the secondary tenant. Then you can add the guest to an MDE role using an Azure AD security group. With this configuration, a primary tenant security operator can take response actions on servers protected by MDE in the secondary tenant.

**Use Privileged Identity Management.** [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time role elevation for Azure and Azure AD roles. [PIM for Groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) extends this functionality to group membership for Microsoft 365 groups and Azure AD security groups. Once you set up PIM for Groups, you need to review active and eligible membership of the privileged group by [creating an access review of PIM for Groups](/azure/active-directory/governance/create-access-review-pim-for-groups).

## Configure centralized security operations

To set up centralized security operations for a multi-tenant environment, you must configure Azure Lighthouse, external identities, and Azure AD Privileged Identity Management. A security operator in the primary tenant can use a single identity secure multiple tenants. They sign in once, elevate their access with PIM, monitor resources across tenants and services, and respond to threats across tenants (*see figure 1*).

:::image type="content" source="./images/lighthouse-setup.png" alt-text="Diagram showing the configuration for centralized security operations across primary and secondary Azure AD tenants." lightbox="./images/lighthouse-setup.png" border="false":::
*Figure 1. How to set up security operations in multi-tenant defense organizations.*

**1. Deploy Sentinel and enable Defender for Cloud**. [Create a Microsoft Sentinel instance](/azure/sentinel/quickstart-onboard#enable-microsoft-sentinel-) in subscriptions associated with each tenant. Configure relevant [data connectors](/azure/sentinel/connect-data-sources) and [enable analytics rules](/azure/sentinel/detect-threats-built-in). Enable Defender for Cloud [enhanced workload protections](/azure/defender-for-cloud/enable-enhanced-security) for hosted workloads, including Defender for Server, in all Azure environments, and [connect Defender for Cloud to Microsoft Sentinel](/azure/sentinel/connect-defender-for-cloud).

**2. Configure PIM for Azure security operations.** Create a [role-assignable group](/azure/active-directory/roles/groups-concept) (Azure SecOps in *Figure 1*) and permanently assign the group to Azure RBAC roles the security operators need. The example uses [Microsoft Sentinel Contributor](/azure/sentinel/roles) and [Security Reader](/azure/role-based-access-control/built-in-roles#security-reader), but you might also consider [Logic App Contributor](/azure/role-based-access-control/built-in-roles#logic-app-contributor) and [other roles](/azure/role-based-access-control/built-in-roles) they need. Configure [PIM for Groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) to assign Security Operators as eligible for the Azure SecOps group. This approach lets the Security Operator elevate access for all the RBAC roles they need in one PIM request. Configure permanent RBAC role assignments for read access if necessary.

**3. Configure PIM for Microsoft 365 Defender security operations.** Create a [role-assignable group](/azure/active-directory/roles/groups-concept) (Microsoft 365 Role Group in *Figure 1*) for assigning [Microsoft 365 Defender permissions](/microsoft-365/security/defender/manage-rbac). Next create a [PIM role](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) for Microsoft 365 Role Group and assign eligibility for the Security Operator. If you don't want to manage multiple roles, you can use the same group (Azure SecOps) you configured in step 1 to assign Microsoft 365 Defender permissions and Azure RBAC roles.

**4. Configure Azure Lighthouse**. Use [Azure Lighthouse](/azure/lighthouse/overview) to assign RBAC roles for Secondary tenant Azure resource subscriptions. Use the object ID of the Azure SecOps group and the tenant ID of the primary tenant. The example in *Figure 1* uses [Microsoft Sentinel Responder](/azure/sentinel/roles) and [Security Reader](/azure/role-based-access-control/built-in-roles#security-reader) roles. Configure permanent RBAC role assignments using Azure Lighthouse to provide permanent read access if needed.

**5. Configure external user access in the secondary tenant.** Use entitlement management to configure [end user-initiated scenario](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) or use a [guest invitation](/azure/active-directory/external-identities/add-users-administrator) to bring primary tenant security operators as external identities in the secondary tenant. Configure [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview#manage-external-access-with-inbound-and-outbound-settings) in the secondary tenant are configured to trust MFA and device compliance claims from the primary tenant. Create a role-assignable group (Microsoft 365 Role Group in *Figure 1*), assign Microsoft Defender for Endpoint permissions, and configure a PIM role following the same process as step 2.

## Manage centralized security operations

Security operators need accounts and eligible access to secure the environment and respond to threats. Security operators should know which roles they're eligible for and how to elevate their permissions using Azure AD PIM. For Microsoft Defender for Endpoint (MDE), they must know how to switch between tenants to hunt and respond to threats using MDE.

Security operators use the multi-tenant security operations setup (*see figure 1*) to secure multiple tenants. They can monitor, investigate, and respond to threats across Microsoft 365 and Azure across Azure AD tenants (*see figure 2*).

:::image type="content" source="./images/lighthouse-operations.png" alt-text="Diagram showing multi-tenant security operations for Sentinel, Microsoft 365 Defender, Defender for Cloud." lightbox="./images/lighthouse-operations.png" border="false":::
*Figure 2. How to use a multi-tenant security operations setup.*

**1. Request Sentinel and Defender for cloud access.** The security operator needs to sign into the Azure portal to [request and activate](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role) the Azure SecOps role using PIM. Once their role is active, they can access Microsoft Sentinel and Defender for Cloud.

**2. Use Sentinel across workspaces and tenants.** When their Azure SecOps role is active, the security operator can navigate to Microsoft Sentinel and perform operations [across tenants](/azure/sentinel/extend-sentinel-across-workspaces-tenants). You configure [Microsoft 365 Defender](/azure/sentinel/connect-microsoft-365-defender) and [Defender for Cloud](/azure/sentinel/connect-defender-for-cloud) data connectors for the Sentinel instances in the primary tenant and secondary tenant. When you configure Azure Lighthouse for the Azure SecOps role, the security operator can see all Sentinel alerts, query across workspaces, and manage incidents and investigations across all tenants.

**3. Use Microsoft 365 Defender in the primary tenant to respond to workstation threats.** When the security operator needs access to Microsoft 365 Defender, they use Azure AD PIM to activate their Microsoft 365 Role. This group membership assigns permissions needed to respond to the security threats on workstation devices managed by Intune and onboarded to MDE in the primary tenant. The security operator uses the Microsoft 365 Defender portal to [take a response action](/microsoft-365/security/defender-endpoint/respond-machine-alerts) and isolate a workstation.

**4. Use Microsoft 365 Defender in the secondary tenant to respond to server threats.** When security operators need to respond to threats detected by MDE for servers in secondary tenant subscriptions, they need to use Microsoft 365 Defender for the secondary tenant. The operator needs to elevate their MDE access in the secondary tenant using PIM before using the Microsoft 365 Defender portal for the secondary tenant. First, the security operator must [switch to the secondary tenant directory](/azure/azure-portal/get-subscription-tenant-id) using the Azure portal. Next, the security operator must use PIM to activate the Microsoft 365 Role Group. Once the role is active, the operator can navigate to the Microsoft 365 Defender portal specifying the tenant ID for the secondary tenant in the URL: `https://security.microsoft.us/homepage?tid=<tenantID>`. From here, the security operator can [initiate a live response](/microsoft-365/security/defender-endpoint/troubleshoot-collect-support-log) to collect logs from the server or perform other MDE response actions.

**5. Use Lighthouse to manage Defender for Cloud across tenants.** The security operator should check Defender for Cloud recommendations. The operator needs to use the Azure portal to [switch directories](/azure/azure-portal/get-subscription-tenant-id) back to the primary tenant. Azure Lighthouse enables the security operator to find secondary tenant Azure resources from the primary tenant. Defender for Cloud might show several recommendations. These recommendations might be enabling just-in-time virtual machine access and the management ports accessible via the internet. In this scenario, the security operator doesn't have the Azure RBAC permissions to implement Defender for Cloud recommendations. The security operator must contact the secondary tenant infrastructure management team to remediate the vulnerability. The security operator must also assign Azure Policy to prevent deploying virtual machines with exposed management ports.

## Other security operations patterns

The management pattern presented in this article is one of many patterns possible using a combination of external identities and Azure Lighthouse. Your organization might decide to implement a different pattern that better meets the needs of your security operators.

## Related links

- [Identity essentials](essentials.md)
- [Zero trust configurations](zero-trust-configuration.md)
- [Manage multi-tenant operations](manage-operations.md)
- [Centralized security operations](security-operations.md)
