---
title: Centralized security operations with external identities for multi-tenant defense organizations
description: Guidance for centralized security operations with external identities
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 06/30/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Centralized security operations with external identities

Defense organizations with a centralized security operations team can monitor, detect, and respond to security threats across all tenants and services with a single identity and [privileged access device](/azure/security/privileged-access-workstations/privileged-access-deployment). This setup avoids multiple user accounts, credentials, and workstations for security operators without sacrificing zero trust capabilities in secondary tenants. Features enabling this operations pattern are described below.

**Azure Lighthouse.** Azure subscriptions attached to secondary tenants can be managed by primary tenant identities using [Azure Lighthouse](/azure/lighthouse/overview). This setup assigns an Azure RBAC role to a security principal (user, group, or service principal) in a different tenant. With this setup, Security operators in a primary tenant can seamlessly manage both [Sentinel](/azure/sentinel/extend-sentinel-across-workspaces-tenants) and [Defender for Cloud](/azure/defender-for-cloud/cross-tenant-management) across tenants.

**External Identities.** When Defender for Server is enabled in a secondary tenant subscription, the MDE extension reports security telemetry to MDE service attached to the same secondary tenant. Role permissions for response actions in Microsoft Defender for Endpoint (MDE) must be assigned to security <a id="_Int_qFWDFlES"></a>principals within the tenant. Azure Lighthouse is not an option for sharing MDE between tenants.

[External identities](/azure/active-directory/external-identities/what-is-b2b) (B2B guests) let primary tenant security operators pivot to manage MDE in a secondary tenant without signing in with a different account or credential. [Cross-tenant access policies (XTAP](/azure/active-directory/external-identities/cross-tenant-access-overview)) are configured in the secondary tenant to trust multi-factor authentication (MFA) and device compliance from the primary tenant.

**Privileged Identity Management.** [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time role elevation for Azure and Azure AD roles. [PIM for Groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups)**** extends this functionality to group membership for M365 groups and Azure AD security groups. Once PIM for groups is set up, review active and eligible membership of the privileged group by [creating an access review of PIM for Groups (preview)](/azure/active-directory/governance/create-access-review-pim-for-groups).

The multi-tenant security operations setup in the next section describes configuring these features so a primary tenant security operator can sign in once and manage security operations across all tenants and services.

### Setup

Azure Lighthouse, external identities, and Azure AD Privileged Identity Management are configured (*figure 5) *so a security operator is eligible to request privileged access to respond to threats across tenants and services.

![A picture containing text, screenshot, diagram

Description automatically generated]

Figure . Security operations setup for multi-tenant organizations

1. Microsoft Sentinel is deployed in subscriptions for security operations (SecOps) in both the primary and secondary tenants. Connectors and Analytics rules are enabled for all applicable data sources including Defender for Cloud. [Enhanced workload protections](/azure/defender-for-cloud/enable-enhanced-security) are enabled for hosted workloads, including Defender for Server.
2. A SecOps [privileged access group](/azure/active-directory/privileged-identity-management/concept-pim-for-groups) is assigned Azure RBAC roles for primary tenant subscriptions, including [roles and permissions for Microsoft Sentinel](/azure/sentinel/roles):** Sentinel Contributor** and** Log Analytics Contributor.** 
3. [M365 Defender role group](/azure/microsoft-365/security/defender-endpoint/user-roles?view=o365-worldwide) is assigned to SecOps Azure AD Group.
4. [Azure Lighthouse](/azure/lighthouse/overview) is used to configure RBAC role assignment for Secondary tenant Azure resource subscriptions. The security principal for the assignment is a SecOps group in the primary tenant.
5. Azure AD Privileged Identity Management (PIM) role is configured for the SecOps group. The Security Operator is assigned eligible to request the PIM role.**** Optionally, permanent read access without elevation can be set up to facilitate monitoring operations.
6. The security operator is added to the Secondary tenant as an external user (B2B guest) and assigned to an MDE role group. Cross-tenant access policies (XTAP) in the secondary tenant are configured to trust MFA and device compliance claims from the primary tenant. Optionally, PIM can be set up with a privileged access group in the secondary tenant (steps 2,3,5).

Operations

Once security operators are set up with the accounts and eligible access needed to secure the environment, they must understand how to elevate their access and pivot between primary and secondary Azure AD tenants. *Figure 6 *details investigation and response in multiple tenants using the operational setup from *figure 5.*

![A picture containing text, screenshot, diagram, font

Description automatically generated]

Figure . Multi-tenant security operations for Sentinel, M365 Defender, Defender for Cloud

1. The security operator signs into the Azure Portal and requests the SecOps role just-in-time using Azure AD Privileged Identity Management.
2. Sentinel [cross-workspace queries](/azure/sentinel/extend-sentinel-across-workspaces-tenants) can detect security events in Primary and Secondary instances. Since all [M365 Defender](/azure/sentinel/connect-microsoft-365-defender?tabs=MDE) and [Defender for Cloud](/azure/sentinel/connect-defender-for-cloud) is connected to Sentinel with Azure Lighthouse configured, all incident management and investigations start here.
3. The security operator can pivot to M365 Defender for advanced hunt and endpoint response.
4. Defender for Endpoint response actions for servers in a secondary tenant Azure subscription need to use an identity in the secondary tenant. The security operator must switch directories in the portal to ensure they are using M365 Defender in the secondary tenant. If just-in-time access is configured, they must request the privileged access group assigned to the M365 role using Azure AD PIM.
5. Defender for Cloud alerts are connected to Sentinel. The security operators can use the Azure Portal to see recommendations and alerts via [Azure Lighthouse](/azure/defender-for-cloud/cross-tenant-management) without switching directory context in the Azure portal.

### Additional security operations patterns

The management pattern presented here is one of many patterns possible using external identities and Azure Lighthouse. Your organization may decide to implement a different pattern that better meets the needs of your security operators.