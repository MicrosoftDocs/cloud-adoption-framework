---
title: Manage multi-tenant operations for defense
description: Guidance for managing identity in a multi-tenant cloud environment
author: stephen-sumner
ms.author: andrmass
ms.reviewer: ssumner
ms.date: 06/30/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Manage multi-tenant operations for defense

This article defines how multi-tenant defense organizations should manage operations across Azure Active Directory (Azure AD) tenants. It covers application management, identity governance, and security operations. The primary and secondary Azure AD tenant administrators have distinct responsibilities in each area. Primary and secondary tenant(s) must coordinate application onboarding, entitlement management, and threat detection and response (*see figure 1*). For more information, see [identifying tenant types](zero-trust-configuration.md#identify-tenant-types).

:::image type="content" source="./images/management-operations.png" alt-text="Diagram showing the management responsibilities of the primary tenant and secondary tenant." lightbox="./images/management-operations.png" border="false":::
*Figure 1. Shared responsibilities by tenant for multi-tenant defense organizations*

## Application management

The primary Azure AD tenant and the secondary Azure AD tenant(s) share application management responsibilities. The primary tenant is responsible for completing Azure AD tasks like enterprise app management and app registration. The secondary tenant is responsible for Azure platform operations like performance monitoring, resource configuration, scaling, and managing DevSecOps pipelines.

### Primary tenant application management

You should onboard all modern applications that need to sign in users as enterprise applications in the primary tenant.

You should register Azure applications running in secondary tenant subscriptions with the primary tenant. The primary tenant is where users and licenses are. Registering applications in the primary tenant allows users to sign in with the same identity they use for Microsoft 365. This configuration offers the most seamless experience and lets you apply the same zero trust policy baseline to all application access.

The location of the application infrastructure (virtual machines, databases, web apps) has not effect on the tenant you can use for user sign-in. The team managing the primary tenant is responsible for app registrations and enterprise applications. They're also responsible for conditional access policies applied to applications hosted in the primary tenant and any secondary tenants.

**App registrations.** You register web applications and APIs the organization use with the primary tenant. The app registration creates an [application object](/azure/active-directory/develop/app-objects-and-service-principals?tabs=browser#application-object) in Azure AD. The application object represents the application definition. The application definition includes an application manifest, token claims configuration, app role definitions, and client secrets. Activities involved in primary tenant app registrations include:

- [Delegating app registration permissions](/azure/active-directory/roles/delegate-app-roles) in Azure AD
- Managing the assignment of the [Application Developer](/azure/active-directory/roles/permissions-reference#application-developer) Azure AD role
- Creating and assigning [custom roles](/azure/active-directory/roles/custom-create) for app registration
- [Creating App Registrations](/azure/active-directory/develop/quickstart-register-app) for applications and APIs
- [Exposing web APIs](/azure/active-directory/develop/quickstart-configure-app-expose-web-apis) and adding scopes to a registered app
- Creating and managing [App Roles](/azure/active-directory/develop/howto-add-app-roles-in-apps) for a registered application
- Defining [API permissions](/azure/active-directory/develop/permissions-consent-overview) for an application

**Enterprise applications.** Enterprise applications are the [service principals](/azure/active-directory/develop/app-objects-and-service-principals) for a distinct instance of an application in your directory. When you create an app registration in the Azure portal, the enterprise application creates automatically and inherits certain properties from the application object. Activities involved managing enterprise applications in the primary tenant include:

- Creating enterprise applications from the [Azure AD Gallery](/azure/active-directory/manage-apps/overview-application-gallery) and deploying non-gallery SAML apps
- Delegate enterprise application management by [assigning owners](/azure/active-directory/manage-apps/assign-app-owners)
- Managing the name, logo, [visibility in My Apps](/azure/active-directory/manage-apps/myapps-overview) for an enterprise application
- [Assigning users and groups](/azure/active-directory/manage-apps/what-is-access-management#assigning-users-and-groups-to-an-app) for accessing the enterprise application
- [Managing signing certificates](/azure/active-directory/manage-apps/certificate-signing-options#change-certificate-signing-options-and-signing-algorithm) for SAML apps
- Granting [consent](/azure/active-directory/manage-apps/user-admin-consent-overview) for API permissions
- Deploying and managing [Azure AD application proxy](/azure/active-directory/app-proxy/what-is-application-proxy) for on-premises applications

**Conditional access policies.** Conditional Access policies enforce zero trust policies for accessing resources protected by Azure AD. When you register applications in the primary tenant, the primary tenant administrator [controls which policies apply](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps) during user sign-in.

### Secondary tenant application management

Secondary tenants host the infrastructure and platform resources for workloads in Azure. The team managing any secondary tenant is responsible for performance monitoring, resource configuration, scaling, and managing DevSecOps pipelines.

**Performance monitoring.** Azure includes several tools for monitoring performance of hosted applications, including [Azure Monitor](/azure/azure-monitor/overview) and [Application Insights](/azure/azure-monitor/app/azure-web-apps#enable-application-insights). The secondary tenant administrators should set up monitoring to collect performance metrics for application workloads in subscriptions linked to their secondary tenant.

**Application infrastructure.** The administrators in the Azure environment must manage the infrastructure running the applications. The infrastructure includes networking, platform services, and virtual machines. The requirement applies to applications running on [Azure Kubernetes Service](/azure/aks/tutorial-kubernetes-deploy-application), [App Service](/azure/app-service/), or virtual machines.

Application owners should use [Defender for Cloud](/azure/defender-for-cloud/concept-cloud-security-posture-management) to manage the security posture of the environment and view alerts and recommendations for the deployed resources. They should use Azure Policy Initiatives to meet the [compliance requirements](/azure/compliance/offerings/offering-dod-il2).

[Connecting Defender for Cloud telemetry to Microsoft Sentinel](/azure/sentinel/connect-defender-for-cloud) allows your security operations center (SOC) to better protect cloud applications. The SOC can still maintain their standard security workflow and automation procedures. Connecting Defender to Sentinel provides visibility to correlate events across the enterprise. It can monitor the cloud and [on-premises](/azure/architecture/hybrid/hybrid-security-monitoring). To monitor on-premises components, you need to manage them with (1) [Azure Arc](/azure/azure-arc/overview) or (2) connect them via an API, [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage), or [Syslog Forwarder](/azure/sentinel/connect-log-forwarder).

**DevSecOps pipelines.** When you host applications in Azure, a [DevSecOps](/devops/devsecops/enable-devsecops-azure-github) pipeline deploys infrastructure resources and application code to Azure. Secondary tenant administrators are responsible for managing service principals automating code deployment. [Entra Workload Identities](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities) premium helps to secure service principals. Entra Workload Identities also reviews existing access and provides extra protections based on service principal risk.

## Identity Governance

Multi-tenant defense organizations need to govern access to applications in the primary Azure AD tenant and manage external guest identities in the secondary tenant for the Azure environment.

### Primary tenant identity governance

When you register applications in the primary tenant, the primary tenant governs application access. The team managing the primary tenant configures entitlement management and conduct access reviews to audit existing access. They also manage external identities and privileged identity management in the primary tenant.

**Entitlement management.** Azure AD [entitlement management](/azure/active-directory/governance/entitlement-management-overview) helps govern access to Azure AD applications, groups, SharePoint Sites, and Teams by bundling entitlement into assignable access packages. The primary tenant administrators manage the Azure AD objects used for application governance. Activities involved in entitlement management in the primary tenant include (*see figure 2*):

- Creating [Azure AD security groups](/azure/active-directory/fundamentals/how-to-manage-groups) for assigning application roles
- [Delegating group ownership](/azure/active-directory/enterprise-users/groups-self-service-management) for application assignment
- Configuring entitlement management [catalogs](/azure/active-directory/governance/entitlement-management-catalog-create) and [access packages](/azure/active-directory/governance/entitlement-management-access-package-create)
- [Delegating roles in entitlement management](/azure/active-directory/governance/entitlement-management-delegate)
- [Automating Identity Governance tasks](/azure/active-directory/governance/identity-governance-automation)
- Creating [access reviews](/azure/active-directory/governance/entitlement-management-access-reviews-create) for access packages and Azure AD security groups

:::image type="content" source="./images/access-to-primary-tenant.png" alt-text="Diagram showing the process to set up entitlement management for application access." lightbox="./images/access-to-primary-tenant.png" border="false":::
*Figure 2. Entitlement management for application assignment, using contoso.com as an example domain name.*

You should set up application governance using an entitlement management access package and follow this process (*see figure 2*):

1. A primary tenant application administrator must coordinate with the developer to create a new app registration for a web app deployed in a secondary tenant.
1. [Identity governance administrator](/azure/active-directory/roles/permissions-reference#identity-governance-administrator) needs to create an [access package](/azure/active-directory/governance/entitlement-management-access-package-create). The administrator adds the application as an entitlement and allows users to request the package. The administrator sets the maximum duration for access before an access review. Optionally, the entitlement management administrator can [delegate](/azure/active-directory/governance/entitlement-management-delegate) permissions for others to manage access packages.
1. The user [requests](/azure/active-directory/governance/entitlement-management-request-access) the access package. They must include the duration of the access request along with justification to help an approver make a decision. They can request any duration up to the maximum duration the administrator set.
1. The access package approver [approves the request](/azure/active-directory/governance/entitlement-management-request-approve).
1. The package assigns the user access to the application in the secondary tenant for the requested duration.
1. The user signs in with their primary tenant identity to access the application hosted in a subscription linked to a secondary tenant.

**External identities.** [Azure AD external identities](/azure/active-directory/external-identities/external-identities-overview) enables secure interaction with users outside of your organization. The primary tenant administrators have several configuration responsibilities for applications registered in the primary tenant. They must configure external (B2B) collaboration and cross-tenant access policies with their partner organizations. They must also configure any lifecycle workflows for the guest users and their access. Activities involved in managing external identities in the primary tenant include:

- [Governing access for users outside your organization](/azure/active-directory/governance/entitlement-management-scenarios#govern-access-for-users-outside-your-organization)
- Managing [B2B collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) and [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) for partner organizations
- Configuring Entra Identity Governance to [review and remove external users](/azure/active-directory/governance/access-reviews-external-users) who no longer have resource access

**Privileged Identity Management.** [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time administration of [Azure AD roles](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user), [Azure RBAC roles](/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles), and [Azure AD security groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups). Primary tenant administrators are responsible for configuring and managing Azure AD PIM in the primary tenant.

### Secondary tenant identity governance

You should use primary tenant identities to manage secondary tenants. This management model reduces the number of separate accounts and credentials administrators need to maintain. Configuring identity governance features in secondary tenants simplifies management even more. You can use a self-service model to onboard external users (B2B guests) from the primary tenant.

The team managing a secondary tenant has several responsibilities in their secondary tenant. They configure entitlement management. They conduct access reviews to audit existing access. They manage external identities and configuring privileged identity management.

**Entitlement management.** You need to configure external user governance for Azure management. You should onboard external identities (B2B guests) from the primary tenant to manage Azure resources using an [end user-initiated scenario using entitlement management](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) (*see figure 3*).

:::image type="content" source="./images/access-to-secondary-tenant.png" alt-text="Diagram showing the process to set up an access package for Azure management in the secondary tenant." lightbox="./images/access-to-secondary-tenant.png" border="false":::
*Figure 3. Entitlement management for external (B2B) guest access, using contoso.com as an example domain name.*

You should set up external (B2B) guest access using an entitlement management access package and follow this process (*see figure 3*):

1. An administrator in the secondary tenant adds the primary tenant as a [connected organization](/azure/active-directory/governance/entitlement-management-organization) and [creates an access package](/azure/active-directory/governance/entitlement-management-access-package-create) for primary tenant users to request.
2. Primary tenant user requests the access package in the secondary tenant.
3. Optionally, an approver completes the request.
4. An external guest object is created for the user in the secondary tenant.
5. Access package is assigned granting eligibility for an Azure RBAC role.
6. The user manages Azure resources using their external identity.

For more information, see [Govern access for external users in entitlement management](/azure/active-directory/governance/entitlement-management-external-users).

**External identities.** [Azure AD external identities](/azure/active-directory/external-identities/external-identities-overview) enables users in the primary tenant to interact with resources in the secondary tenant. The process outlined in *figure 3* uses external identities from the primary tenant to manage Azure subscriptions attached to the secondary tenant. Activities involved in managing external identities in the secondary tenant include:

- Managing [B2B collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) and [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) for the primary tenant and other partner organizations
- Using Identity Governance to [review and remove external users](/azure/active-directory/governance/access-reviews-external-users) who no longer have resource access

**Privileged Identity Management.** [Azure AD PIM](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time administration for [Azure AD roles](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user), [Azure RBAC roles](/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles), and [privileged security groups](/azure/active-directory/privileged-identity-management/groups-assign-member-owner). Secondary tenant administrators are responsible for configuring and managing Azure AD PIM for administrative roles used to manage the secondary Azure AD tenant and Azure environment.

## Security operations

The security operations team for a defense organization must protect, detect, and respond to threats across on-premises, hybrid, and multicloud environments. They need to protect their users, control sensitive data, investigate threats on user devices and servers. They also need to remediate insecure configuration of cloud and on-premises resources. Security operators in multi-tenant defense organizations usually operate from the primary tenant but might pivot between tenants for certain actions.

### Primary tenant security operations

Security operators in the primary tenant need to monitor and manage alerts from Microsoft 365 in the primary tenant. This work involves managing Microsoft Sentinel and Microsoft 365 Defender services like Microsoft Defender for Endpoint (MDE).

**Sentinel and Microsoft 365.** You deploy a Microsoft Sentinel instance to a subscription attached to the primary tenant. You should configure data connectors for this Sentinel instance. The data connectors allow the Sentinel instance to ingest security logs from various sources. These sources include Office 365, Microsoft 365 Defender, Azure AD, Identity Protection, and other workloads in the primary tenant. Security operators monitoring incidents and alerts for Microsoft 365 should use the primary tenant. Activities involved in managing Sentinel for Microsoft 365 in the primary tenant include:

- Monitoring and remediating [risky users](/azure/active-directory/identity-protection/howto-identity-protection-remediate-unblock) and [service principals](/azure/active-directory/fundamentals/service-accounts-principal) in the primary tenant
- Configuring [data connectors](/azure/sentinel/connect-data-sources) for Microsoft 365 and other available primary tenant data sources to Microsoft Sentinel
- Building [workbooks](/azure/sentinel/monitor-your-data), [notebooks](/azure/sentinel/notebooks), [analytics rules](/azure/sentinel/detect-threats-custom), and [security orchestration and response (SOAR)](/azure/sentinel/automation) within the Microsoft 365 environment

**Microsoft 365 Defender.** You manage Microsoft 365 Defender in the primary tenant. The primary tenant is where you use Microsoft 365 services. Microsoft 365 Defender helps you monitor alerts and remediate attacks against users, devices, and service principals. Activities include managing components of [Microsoft 365 Defender](/microsoft-365/security/defender/microsoft-365-defender). These components include Defender for Endpoint, Defender for Identity, Defender for Cloud Apps, Defender for Office.

**Microsoft Defender for Endpoint (MDE) response (workstations).** You need to join end-user workstations to the primary tenant and use Microsoft Intune to manage them. Security operators need to use MDE to respond to detected attacks. The response can be isolating workstations or collecting an investigating package. [Defender for Endpoint response](/microsoft-365/security/defender-endpoint/respond-machine-alerts) actions for user devices takes place in the primary tenant MDE service. Activities involved in managing MDE response in the primary tenant include managing [device groups](/microsoft-365/security/defender-endpoint/machine-groups) and [roles](/microsoft-365/security/defender-endpoint/user-roles).

### Secondary tenant security operations

This section describes how you should monitor and protect Azure resources in subscriptions in secondary tenants. You need to Defender for Cloud, Microsoft Sentinel, and Microsoft Defender for Endpoint (MDE). You need to use [Azure Lighthouse](/azure/lighthouse/overview) and [external identities](/azure/active-directory/external-identities/external-identities-overview) to assign permissions to security operators in the primary tenant. This setup allows security operators to use one account and [privileged access device](/security/privileged-access-workstations/privileged-access-devices) to manage security across tenants.

**Sentinel (cloud, on-premises).** You need to assign permissions and configure Sentinel to ingest security telemetry from Azure resources deployed in subscriptions linked to the secondary tenant.

*Assign permissions.* For security operators in the primary tenant to use Microsoft Sentinel, you have to assign permissions using [Azure Resource Manager](/azure/azure-resource-manager/management/overview) RBAC roles. You can use [Azure Lighthouse](/azure/lighthouse/overview) to assign these roles to users and security groups in the primary tenant. This configuration lets security operators operate [across Sentinel workspaces](/azure/sentinel/extend-sentinel-across-workspaces-tenants) in different tenants. Without Lighthouse, security operators would need guest accounts or separate credentials to manage Sentinel in the secondary tenants.

*Configure Sentinel.* You should configure Microsoft Sentinel in a secondary tenant to ingest security logs from several sources. These sources include logs from Azure resources in the secondary tenant, on-premises servers, and network appliances owned and managed in the secondary tenant. Activities involved in managing Sentinel and on-premises in the secondary tenant include:

- Assigning [Sentinel roles](/azure/sentinel/roles) and configuring Azure Lighthouse to grant access to primary tenant security operators
- Configuring [data connectors](/azure/sentinel/connect-data-sources) for Azure Resource Manager, Defender for Cloud, and other available secondary tenant data sources to Microsoft Sentinel
- Building [workbooks](/azure/sentinel/monitor-your-data), [notebooks](/azure/sentinel/notebooks), [analytics rules](/azure/sentinel/detect-threats-custom), and [security orchestration and response (SOAR)](/azure/sentinel/automation) within the secondary tenant Azure environment

**Microsoft Defender for Cloud.** Defender for Cloud surfaces security recommendations and alerts for resources in Azure, on-premises, or other cloud providers. You need to assign permissions to configure and manage Defender for Cloud.

*Assign permissions.* You need to assign permissions to security operators in the primary tenant. Like Sentinel, Defender for Cloud also uses [Azure RBAC roles](/azure/defender-for-cloud/permissions). You can assign Azure RBAC roles to primary tenant security operators using Azure Lighthouse. This configuration allows security operators in the primary tenant see recommendations and alerts from the Defender for Cloud without switching directories or signing in with a separate account in the secondary tenant.

*Configure Defender for Cloud.* You need to enable Defender for Cloud and [manage recommendations and alerts](/azure/defender-for-cloud/managing-and-responding-alerts). Turn on [enhanced workload protections](/azure/defender-for-cloud/defender-for-cloud-introduction#protect-cloud-workloads) for resources in subscriptions linked to secondary tenants.

**Microsoft Defender for Endpoint (MDE) response (servers).** [Defender for Servers](/azure/defender-for-cloud/plan-defender-for-servers) is a Defender for Cloud [enhanced protection](/azure/defender-for-cloud/get-started) for servers that includes MDE.

*Assign permissions.* When you enable a Defender for Server plan in a secondary tenant, the [MDE extension](/azure/defender-for-cloud/integration-defender-for-endpoint) automatically deploys to your VMs. This MDE extension onboards the server to the MDE service for the secondary tenant.

MDE uses the [Microsoft 365 Defender portal](/microsoft-365/security/defender/microsoft-365-defender-portal) and [permissions model](/microsoft-365/admin/add-users/about-admin-roles). So you must use external identities (B2B guests) to give security operators in the primary tenant access to MDE. Assign MDE roles to Azure AD security groups and add the guests as group members so they can [take response actions](/microsoft-365/security/defender-endpoint/respond-machine-alerts) on servers.

*Configure MDE.* You need to configure a manage [device groups](/microsoft-365/security/defender-endpoint/machine-groups) and [roles](/microsoft-365/security/defender-endpoint/user-roles) in Microsoft Defender for Endpoint for the secondary tenant.

## Next step

> [!div class="nextstepaction"]
> [Centralized security operations](security-operations.md)

## Related links

- [Identity essentials](essentials.md)
- [Zero trust configurations](zero-trust-configuration.md)
- [Manage multi-tenant operations](manage-operations.md)
