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

# Manage multi-tenant operations

This article defines how defense organizations should manage operations across multiple Azure Active Directory (Azure AD) tenants. An Azure AD tenant is a security boundary and working across these security boundaries introduces operational challenges. There are three primary areas of shared operational responsibility: application management, identity governance, and security operations. *Figure 1* provides a blueprint that you should adopt and modify to meet your needs.

:::image type="content" source="./images/management-operations.png" alt-text="Diagram showing the management responsibilities of the primary tenant and secondary tenant." lightbox="./images/management-operations.png" border="false":::
*Figure 1. Operational responsibilities by tenant for multi-tenant defense organizations*

The arrows in *figure 1* represent coordinated activities for application onboarding, entitlement assignment, and detection and response for a multi-tenant organization.

## Application management

The primary Azure AD tenant and the secondary Azure AD tenant(s) share application management responsibilities. The primary tenant is responsible for enterprise app management and app registration. The secondary tenant is responsible for performance monitoring, application infrastructure, and DevSecOps pipeline to deploy and manage application resources in subscriptions attached to the secondary tenant. The applications the DevSecOps pipeline deploy need to sign in users from the primary tenant.

### Primary tenant application management

All modern applications within the organization should use the primary tenant for identity. You should register all applications deployed to subscriptions in the secondary tenant with the primary tenant. Registering applications in the secondary tenant with the primary tenant enables users to sign into these applications with the same identity they use for Microsoft 365 (M365). The team managing the primary tenant is responsible for app registrations, enterprise applications, and conditional access policies:

**App registrations.** Web applications and APIs used by the organization are registered with the primary tenant. The app registration creates an [application object](/azure/active-directory/develop/app-objects-and-service-principals?tabs=browser#application-object) in Azure AD that represents the application definition including application manifest, token claims configuration, app role definitions, and client secrets. Activities include:

- [Delegating app registration permissions](/azure/active-directory/roles/delegate-app-roles) in Azure AD
- Managing the assignment of the [Application Developer](/azure/active-directory/roles/permissions-reference#application-developer) Azure AD role
- Creating and assigning [custom roles](/azure/active-directory/roles/custom-create) for app registration
- [Creating App Registrations](/azure/active-directory/develop/quickstart-register-app) for applications and APIs
- [Exposing web APIs](/azure/active-directory/develop/quickstart-configure-app-expose-web-apis) and adding scopes to a registered app
- Creating and managing [App Roles](/azure/active-directory/develop/howto-add-app-roles-in-apps) for a registered application
- Defining [API permissions](/azure/active-directory/develop/permissions-consent-overview) for an application

**Enterprise applications.** Enterprise Applications are the [service principals](/azure/active-directory/develop/app-objects-and-service-principals) for a distinct instance of an application in your directory. When you create an app registration using the Azure Portal, the Enterprise Application is created automatically and inherits certain properties from the application object. Activities include:

- Creating enterprise applications from the [Azure AD Gallery](/azure/active-directory/manage-apps/overview-application-gallery) and non-gallery SAML apps
- Delegate enterprise application management by [assigning owners](/azure/active-directory/manage-apps/assign-app-owners)
- Managing name, logo, [visibility in My Apps](/azure/active-directory/manage-apps/myapps-overview) for an enterprise application
- [Assigning users and groups](/azure/active-directory/manage-apps/what-is-access-management#assigning-users-and-groups-to-an-app) for accessing the enterprise application
- [Managing signing certificates](/azure/active-directory/manage-apps/certificate-signing-options#change-certificate-signing-options-and-signing-algorithm) for SAML apps
- Granting [consent](/azure/active-directory/manage-apps/user-admin-consent-overview) for API permissions
- Deploying and managing [Azure AD application proxy](/azure/active-directory/app-proxy/what-is-application-proxy) for on-premises applications

**Conditional Access Policies.** Conditional Access policies enforce zero trust policies for accessing resources protected by Azure AD. When applications are integrated with the primary tenant, the primary tenant administrator [controls which policies should apply](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps) during user sign-in.

### Secondary tenant application management

Secondary tenants host the infrastructure and platform resources for workloads in Azure. The team managing any secondary tenant is responsible for performance monitoring, application infrastructure, and DevSecOps pipelines.

**Performance monitoring.** Azure includes several tools for monitoring performance of hosted applications including [Azure Monitor](/azure/azure-monitor/overview) and [Application Insights](/azure/azure-monitor/app/azure-web-apps#enable-application-insights). The secondary tenant administrators should set up monitoring to collect performance metrics for application workloads within Azure.

**Application infrastructure.** Whether applications are running in [Azure Kubernetes Service](/azure/aks/tutorial-kubernetes-deploy-application), [App Service](/azure/app-service/), or hosted on web servers, the administrators in the Azure environment must manage the infrastructure running the applications including networking, platform services, and virtual machines. Application owners should use [Defender for Cloud](/azure/defender-for-cloud/concept-cloud-security-posture-management) to manage security posture and view alerts and recommendations for the deployed resources, and use Azure Policy Initiatives to meet the organization’s [compliance requirements](/azure/compliance/offerings/offering-dod-il2).

[Connecting Defender for Cloud telemetry to Sentinel](/azure/sentinel/connect-defender-for-cloud) allows the organization’s SOC to have visibility across all cloud environments, including any [on-premises resources](/azure/architecture/hybrid/hybrid-security-monitoring) managed with [Azure Arc](/azure/azure-arc/overview) and connected via API, [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage), or [Syslog Forwarder](/azure/sentinel/connect-log-forwarder).

**DevSecOps pipelines.** When applications are hosted in Azure subscriptions, [DevSecOps](/devops/devsecops/enable-devsecops-azure-github) pipelines deploying infrastructure resources and application code are integrated with the Azure AD tenant where the subscription is attached. Secondary tenant administrators are responsible for managing service principals automating code deployment. [Entra workload identities](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities) premium helps secure service principals, periodically review existing access, and provide extra protections against leaked credentials.

## Identity Governance

Multi-tenant defense organizations need to govern access to applications in the primary Azure AD tenant and manage external guest identities in the secondary tenant for the Azure environment.

### Primary tenant identity governance

Application access is governed in the same Azure AD tenant where applications are registered – the primary tenant. The team managing the primary tenant is responsible for entitlements management, external identities, privileged identity management, and Audit via access reviews.

**Entitlements management.** Azure AD [entitlement management](/azure/active-directory/governance/entitlement-management-overview) helps govern access to Azure AD applications, groups, SharePoint Sites, and Teams by bundling entitlements into assignable access packages. The primary tenant administrators manage the Azure AD objects used for application governance. Activities include:

- Creating [Azure AD security groups](/azure/active-directory/fundamentals/how-to-manage-groups) for assigning application roles
- [Delegating group ownership](/azure/active-directory/enterprise-users/groups-self-service-management) for application assignment
- Configuring entitlements management [catalogs](/azure/active-directory/governance/entitlement-management-catalog-create) and [access packages](/azure/active-directory/governance/entitlement-management-access-package-create)
- [Delegating roles in entitlement management](/azure/active-directory/governance/entitlement-management-delegate)
- [Automating Identity Governance tasks](/azure/active-directory/governance/identity-governance-automation)
- Creating [access reviews](/azure/active-directory/governance/entitlement-management-access-reviews-create) for access packages and Azure AD security groups

You should set up application governance using an entitlement management access packages (*see figure 2*). Here's the process for setting up application governance using an entitlement management access package:

:::image type="content" source="./images/access-to-primary-tenant.png" alt-text="Diagram showing the process to set up entitlements management for application assignment." lightbox="./images/access-to-primary-tenant.png" border="false":::

*Figure 2. Entitlements management for application assignment. Using the Contoso domain as an example.*

1. A primary tenant application administrator works with the developer to create a new app registration for a web app deployed in a secondary tenant.
2. [Identity governance administrator](/azure/active-directory/roles/permissions-reference#identity-governance-administrator) creates an [access package](/azure/active-directory/governance/entitlement-management-access-package-create) and adds the application as an entitlement and enables the package for request with approval for a 6-month duration. Optionally, the entitlements management administrator can [delegate](/azure/active-directory/governance/entitlement-management-delegate) permissions for managing access packages.
3. A user [requests](/azure/active-directory/governance/entitlement-management-request-access) the access package for 6 months.
4. The access package approver [approves the request](/azure/active-directory/governance/entitlement-management-request-approve).
5. The user assigned application access for the requested duration.
6. When the user needs to access the application, they can sign in with their Azure AD identity.

**External identities.** [Azure AD external identities](/azure/active-directory/external-identities/external-identities-overview) enables secure interaction with users outside of your organization. When applications are integrated with the primary tenant, the primary tenant administrators are responsible for configuring B2B collaboration, cross-tenant access policies with partner organizations, and any lifecycle workflows for the guest users and their access. Activities include:

- [Governing access for users outside your organization](/azure/active-directory/governance/entitlement-management-scenarios#govern-access-for-users-outside-your-organization)
- Managing [B2B collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) and [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) for partner organizations
- Configuring Entra Identity Governance to [review and remove external users](/azure/active-directory/governance/access-reviews-external-users) who no longer have resource access

**Privileged Identity Management.** [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time administration for [Azure AD roles](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user), [Azure RBAC roles](/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles), and [Azure AD security groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups). Primary tenant administrators are responsible for configuring and managing Azure AD PIM in the primary tenant.

### Secondary tenant identity governance

You should use your primary tenant identities to manage operations in the secondary tenant. A self-service model is best. The team managing any secondary tenant is also responsible for entitlements management, external identities, privileged identity management, and Audit in their tenant. Here's the process for setting up external (B2b) guest using an entitlement management access package:

**Entitlements management.** You need to configure external user governance for Azure management. You should use entitlements management in the secondary tenant to onboard guest users to manage Azure resources using an [end user-initiated scenario using entitlements management](/azure/active-directory/fundamentals/multi-tenant-user-management-scenarios#end-user-initiated-scenario) (*figure 3*).

:::image type="content" source="./images/access-to-primary-tenant.png" alt-text="Diagram showing the process to set up entitlements management for application assignment." lightbox="./images/access-to-primary-tenant.png" border="false":::
*Figure 3. Entitlements management for external (B2B) guest access. Using the Contoso domain as an example.*

1. An administrator in the secondary tenant adds the primary tenant as a [connected organization](/azure/active-directory/governance/entitlement-management-organization) and [creates an access package](/azure/active-directory/governance/entitlement-management-access-package-create) for primary tenant users to request.
2. Primary tenant user requests the access package in the secondary tenant.
3. Optionally, an approver completes the request.
4. A guest object is created for the user.
5. Access package is assigned granting eligibility for an Azure RBAC role.
6. The user manages Azure resources using their guest identity.

For more information, see [Govern access for external users in entitlement management](/azure/active-directory/governance/entitlement-management-external-users).

**External identities.** [Azure AD external identities](/azure/active-directory/external-identities/external-identities-overview) enables users in the primary tenant to interact with resources in the secondary tenant. The process outlined in *Figure 4* uses external identities from the primary tenant to manage Azure subscriptions attached to the secondary tenant. Activities include:

- Managing [B2B collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) and [cross-tenant access policies (XTAP)](/azure/active-directory/external-identities/cross-tenant-access-overview) for partner organizations
- Using Identity Governance to [review and remove external users](/azure/active-directory/governance/access-reviews-external-users) who no longer have resource access

**Privileged Identity Management.** [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) enables just-in-time administration for [Azure AD roles](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user), [Azure RBAC roles](/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles), and [privileged access groups (PAGs)](/azure/active-directory/privileged-identity-management/groups-assign-member-owner). Secondary tenant administrators are responsible for configuring and managing Azure AD PIM for administrative roles used to manage the secondary tenant and Azure environment.

## Security operations

Defense security teams must protect, detect, and respond to threats across on-premises and hybrid cloud / multi-cloud services and pivot between primary and secondary Azure AD tenants. They need to protect their users, control sensitive data, investigate threats on user devices and servers, and remediate insecure configuration of cloud and on-premises resources.

### Primary tenant security operations

Security operators in the primary Azure AD tenant need to monitor and manage alerts generated by the M365 environment and any workloads attached to the primary tenant.

**Sentinel (M365).** A Microsoft Sentinel instance attached to the primary tenant ingests security logs from M365 Defender, Identity Protection, and other workloads in the same tenant. Security operators monitoring incidents and alerts for M365 use the primary tenant. Activities include:

- Monitoring and remediating [risky users](/azure/active-directory/identity-protection/howto-identity-protection-remediate-unblock) and service principals in the primary tenant
- Configuring [data connectors](/azure/sentinel/connect-data-sources) for M365 and other available primary tenant data sources to Microsoft Sentinel
- Building [workbooks](/azure/sentinel/monitor-your-data), [notebooks](/azure/sentinel/notebooks), [analytics rules](/azure/sentinel/detect-threats-custom), and [security orchestration and response (SOAR)](/azure/sentinel/automation) within the M365 environment.

**M365 Defender.** You manage M365 Defender in the primary tenant where you use M365 services. M365 Defender helps you monitor alerts and remediate attacks against users, devices, and service principals. Activities include managing components of [Microsoft 365 Defender](/microsoft-365/security/defender/microsoft-365-defender). These components include Defender for Endpoint, Defender for Identity, Defender for Cloud Apps, Defender for Office.

**MDE Response (workstations).** End user devices are joined to and managed by the primary tenant. [Defender for Endpoint response](/microsoft-365/security/defender-endpoint/respond-machine-alerts) actions for user devices takes place in the primary tenant MDE service. Activities include:

- Managing [device groups](/microsoft-365/security/defender-endpoint/machine-groups) and [roles](/microsoft-365/security/defender-endpoint/user-roles) in Microsoft Defender for Endpoint for the primary tenant

### Secondary tenant security operations

Security operations permissions for Microsoft Sentinel and Defender for Cloud use Azure RBAC roles assigned to cloud-only Azure AD users in the secondary tenant or, using Azure Lighthouse, to security operators in the primary tenant.

Azure Virtual Machines (VMs) and on-premises servers onboarded with Azure Arc protected by Defender for Server are automatically onboarded to Microsoft Defender for Endpoint to the tenant where the Azure subscriptions are managed. Security operations using MDE must be performed by identities in the secondary Azure AD.

External identities (B2B guests) can be used to provide primary tenant security operators access to MDE in secondary tenants. For more information, see [multi-tenant security operations with external identities and Azure Lighthouse](security-operations.md) for example security operations architecture.

**Sentinel (cloud, on-prem).** A Microsoft Sentinel instance attached to the secondary tenant ingests security logs from Azure resources in subscriptions attached to the secondary tenant. Activities include:

- Assigning [Sentinel roles](/azure/sentinel/roles) and configuring Azure Lighthouse to grant access to primary tenant security operators
- Configuring [data connectors](/azure/sentinel/connect-data-sources) for Azure resource manager, Defender for Cloud, and other available secondary tenant data sources to Microsoft Sentinel
- Building [workbooks](/azure/sentinel/monitor-your-data), [notebooks](/azure/sentinel/notebooks), [analytics rules](/azure/sentinel/detect-threats-custom), and [security orchestration and response (SOAR)](/azure/sentinel/automation) within the secondary tenant Azure environment.

**Microsoft Defender for Cloud.** Defender for Cloud surfaces security recommendations and alerts for resources in Azure, on-premises, or other cloud providers. Activities include:

- [Managing recommendations and alerts](/azure/defender-for-cloud/managing-and-responding-alerts) for in Defender for Cloud
- Assigning [Defender for Cloud roles](/azure/defender-for-cloud/permissions) and configuring Azure Lighthouse to grant access to primary tenant security operators

**MDE Response (servers).** Servers in secondary tenant Azure subscriptions are onboarded to MDE in the secondary tenant when Defender for Server enhanced protection is enabled in Defender for Cloud. [Defender for Endpoint response](/microsoft-365/security/defender-endpoint/respond-machine-alerts) actions for servers takes place in the secondary tenant MDE service. Activities include:

- Managing [device groups](/microsoft-365/security/defender-endpoint/machine-groups) and [roles](/microsoft-365/security/defender-endpoint/user-roles) in Microsoft Defender for Endpoint for the secondary tenant
- Delegating MDE roles to external users (B2B guests) from the primary tenant

## Related links

- [Identity essentials](essentials.md)
- [Zero trust configurations](zero-trust-configuration.md)
- [Manage multi-tenant operations](manage-operations.md)
- [Centralized security operations](security-operations.md)
