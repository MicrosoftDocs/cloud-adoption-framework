---
title: Centralized security operations with external identities for multi-tenant defense organizations
description: Guidance for centralized security operations with external identities
author: stephen-sumner
ms.author: andrmass
ms.reviewer: ssumner
ms.date: 06/30/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Centralized security operations with external identities

This article is for multi-tenant defense organizations with a centralized security operations team. It explains they can manage multiple tenants with a single identity and [privileged access device](/security/privileged-access-workstations/privileged-access-deployment). Security operators don't need multiple user accounts, credentials, and workstations to secure your environment. This configuration requires Azure Lighthouse and supports zero trust capabilities in secondary tenants.

**Use Azure Lighthouse to manage secondary tenants.** You need to use [Azure Lighthouse](/azure/lighthouse/overview) to manage Azure subscriptions attached to secondary tenants. Azure Lighthouse enables multi-tenant management with scalability, higher automation, and enhanced governance across resources.

Azure Lighthouse assigns a security principal (user, group, or service principal) in one tenant permissions via an Azure RBAC role to manage a different tenant. With this setup, security operators in a primary tenant can seamlessly manage both [Sentinel](/azure/sentinel/extend-sentinel-across-workspaces-tenants) and [Defender for Cloud](/azure/defender-for-cloud/cross-tenant-management) across tenants.

**Use external identities to manage Microsoft Defender for Endpoint.** You can't use Azure Lighthouse to share Microsoft Defender for Endpoint (MDE) between tenants, so you need to use [external identities](/azure/active-directory/external-identities/what-is-b2b) (B2B guests). External identities let security operators in the primary tenant manage MDE in a secondary tenant without signing in with a different account or credential. For this setup, you need to configure [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) in the secondary tenant to trust multi-factor authentication (MFA) and device compliance from the primary tenant.

 When you enable Defender for Server in a secondary tenant, the MDE extension reports security telemetry to the MDE service associated secondary tenant. It can't report security telemetry to the primary tenant. As a result, you must assign role permissions in that secondary tenant to security principals in the primary tenant. The role permissions allow security principals in the primary tenant to use response actions in MDE for that secondary tenant.

**Privileged Identity Management.** [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time role elevation for Azure and Azure AD roles. [PIM for Groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) extends this functionality to group membership for Microsoft 365 groups and Azure AD security groups. Once you set up PIM for Groups, you need to review active and eligible membership of the privileged group by [creating an access review of PIM for Groups](/azure/active-directory/governance/create-access-review-pim-for-groups).

## Configure centralized security operations

To set up centralized security operations for a multi-tenant environment, you must configure Azure Lighthouse, external identities, and Azure AD Privileged Identity Management. A security operator in the primary tenant can use a single identity secure multiple tenants. They sign in once, elevate their access with PIM, monitor resources across tenants and services, and respond to threats across tenants (*see figure 1*).

:::image type="content" source="./images/lighthouse-setup.png" alt-text="Diagram showing the process to set up entitlements management for application assignment." lightbox="./images/lighthouse-setup.png" border="false":::
*Figure 1. How to set up security operations in multi-tenant defense organizations.*

**1. Deploy Sentinel and enable Defender for Cloud**. [Create a Microsoft Sentinel instance](/azure/sentinel/quickstart-onboard#enable-microsoft-sentinel-) in subscriptions attached to each tenant. Configure relevant [data connectors](/azure/sentinel/connect-data-sources) and [enable analytics rules](/azure/sentinel/detect-threats-built-in). Enable Defender for Cloud [enhanced workload protections](/azure/defender-for-cloud/enable-enhanced-security) for hosted workloads, including Defender for Server, in all Azure environments.

**2. Configure PIM for Azure security operations.** Create a [role-assignable group](/azure/active-directory/roles/groups-concept) (Azure SecOps in *Figure 1*) and permanently assign the group to Azure RBAC roles the security operators need. The example uses [Microsoft Sentinel Contributor](/azure/sentinel/roles) and [Security Reader](/azure/role-based-access-control/built-in-roles#security-reader), but you may also consider [Logic App Contributor](/azure/role-based-access-control/built-in-roles#logic-app-contributor) and [other roles](/azure/role-based-access-control/built-in-roles) they need. Configure [PIM for Groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) to assign Security Operators as eligible for the Azure SecOps group. This approach lets the Security Operator elevate access for all the RBAC roles they need in one PIM request. Configure permanent RBAC role assignments for read access if necessary.

**3. Configure PIM for Microsoft 365 Defender security operations.** Create a [role-assignable group](/azure/active-directory/roles/groups-concept) (Microsoft 365 Role Group in *Figure 1*) for assigning [Microsoft 365 Defender permissions](/microsoft-365/security/defender/manage-rbac). Next create a [PIM role](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) for Microsoft 365 Role Group and assign eligibility for the Security Operator. If you don't want to manage multiple roles, you can use the same group (Azure SecOps) configured in step 1 to assign Microsoft 365 Defender permissions and Azure RBAC roles.

**4. Configure Azure Lighthouse**. Use [Azure Lighthouse](/azure/lighthouse/overview) to assign RBAC roles for Secondary tenant Azure resource subscriptions. Use the object ID of the Azure SecOps group and the tenant ID of the primary tenant. The example in *Figure 1* uses [Microsoft Sentinel Responder](/azure/sentinel/roles) and [Security Reader](/azure/role-based-access-control/built-in-roles#security-reader) roles. Configure permanent RBAC role assignments for read access if necessary.

**5. Configure external user access in the secondary tenant.** Use entitlement management to configure [end user-initiated scenario](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) or use a [guest invitation](/azure/active-directory/external-identities/add-users-administrator) to bring primary tenant security operators as external identities in the secondary tenant. Configure [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview#manage-external-access-with-inbound-and-outbound-settings) in the secondary tenant are configured to trust MFA and device compliance claims from the primary tenant. Create a role-assignable group (Microsoft 365 Role Group in *Figure 1*), assign Microsoft Defender for Endpoint permissions, and configure a PIM role following the same process as step 2.

## Manage centralized security operations

Security operators need accounts and eligible access to secure the environment and respond to threats. Security operators should know which roles they're eligible for and how to elevate their permissions using Azure AD PIM. For Microsoft 365 Defender, specifically Microsoft Defender for Endpoint, they must know how to switch between tenants to hunt and respond to threats using MDE. *Figure 1* shows a multi-tenant security operations setup. Security operator can use their access to monitor, investigate, and respond to threats across Microsoft 365 and Azure across Azure AD tenants (*see figure 2*).

:::image type="content" source="./images/lighthouse-operations.png" alt-text="Diagram showing multi-tenant security operations for Sentinel, Microsoft 365 Defender, Defender for Cloud." lightbox="./images/lighthouse-operations.png" border="false":::
*Figure 2. Multi-tenant security operations for Sentinel, Microsoft 365 Defender, Defender for Cloud.*

1. **Request Sentinel and Defender for cloud access.** The security operator needs to sign into the Azure portal to [request and activate](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role) the Azure SecOps role using PIM.
2. **Sentinel operations across workspaces and tenants.** After you activate the Azure SecOps role, the security operator can navigate to Microsoft Sentinel and perform operations [across tenants](/azure/sentinel/extend-sentinel-across-workspaces-tenants). Since data connectors for [Microsoft 365 Defender](/azure/sentinel/connect-microsoft-365-defender) and [Defender for Cloud](/azure/sentinel/connect-defender-for-cloud) are connected to both Sentinel instances and Azure Lighthouse is configured, the security operator can start all incident management, investigations, and event correlation here.
3. **Pivot to Microsoft 365 Defender.** The security operator sees a Sentinel alert was created based on a Microsoft Defender for Endpoint detection. The detection is for a workstation and is coming from MDE in the primary tenant.  The security operator activates their Microsoft 365 Role using PIM. This group membership assigns permissions needed to respond to the security threat. The security operator pivots to the Microsoft 365 Defender portal and [takes a response action](/microsoft-365/security/defender-endpoint/respond-machine-alerts) to isolate the device.
4. **Multi-tenant operations for Microsoft 365 Defender.** Later on, the security operator sees several Sentinel alert for an Azure virtual machine running in a subscription attached to the secondary tenant. Defender for Endpoint detected a malicious payload was executed on the server. The security operator wants to conduct a live response using MDE. In the Azure portal, the security operator [switches directories](/azure/azure-portal/get-subscription-tenant-id) to the secondary tenant and uses PIM to activate the Microsoft 365 Role Group in the secondary tenant. The operator navigates to the Microsoft 365 Defender portal for the secondary tenant. The security operator uses a bookmarked link containing the secondary tenant ID in the URL: `https://security.microsoft.us/homepage`. The security operator can [initiate a live response](/microsoft-365/security/defender-endpoint/troubleshoot-collect-support-log) to collect logs from the server.
5. **Use Lighthouse to manage Defender for Cloud across tenants.** After you remediate the threat to the Azure virtual machine, the security operator wants to check Defender for Cloud recommendations. The operator uses the Azure portal to [switch directories](/azure/azure-portal/get-subscription-tenant-id) back to the primary tenant. Since Azure Lighthouse is set up, the security operators can find secondary tenant Azure resources from the primary tenant. Defender for Cloud shows several recommendations, including enabling just-in-time virtual machine access. The management ports accessible via the internet. The security operator must contact the secondary tenant infrastructure management team to remediate the vulnerability. They should create an Azure Policy to block deployment if virtual machines have management ports accessible via the internet.

## Other security operations patterns

The management pattern presented in this article is one of many patterns possible using a combination of external identities and Azure Lighthouse. Your organization might decide to implement a different pattern that better meets the needs of your security operators.

## Related links

- [Identity essentials](essentials.md)
- [Zero trust configurations](zero-trust-configuration.md)
- [Manage multi-tenant operations](manage-operations.md)
- [Centralized security operations](security-operations.md)
