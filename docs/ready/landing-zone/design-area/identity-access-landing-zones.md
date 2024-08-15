---
title: Landing zone identity and access management
description: Learn about considerations and recommendations for implementing identity and access control within Azure application and platform landing zones.
author: soderholmd
ms.author: dsoderholm
ms.topic: conceptual
ms.date: 08/14/2024
---

# Landing zone identity and access management

After you identify your identity architecture, you need to manage the authorization and access for resources in application and platform landing zones. Consider which resources each authenticated principal has access to and needs access to, and how to mitigate the risk of unauthorized access to your resources. For more information, see [Identity architecture design](/azure/architecture/identity/identity-start-here).

## Overview

The identity and access management design area provides guidance to help you implement the [enterprise access model in Azure](/security/privileged-access-workstations/privileged-access-access-model#evolution-from-the-legacy-ad-tier-model) and implement and secure control planes. When you incorporate the design principle of [subscription democratization](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization), your application team can manage their own workloads within the policy guardrails that the platform team sets. This approach also follows the [policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance) principle.

The platform team is responsible for provisioning new application landing zones or subscriptions. When they provision a landing zone for an application owner, the platform team should configure it with the appropriate access controls so the application owner can manage their own resources. The application owner should be able to create and manage users and groups within Microsoft Entra ID, and assign roles to those users and groups. The application owner can then manage access to their own resources and delegate access to other users and groups as required. The landing zone should also have optional network connectivity to Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services in the Microsoft identity platform subscription, depending on the requirements of the application.

Use Azure role-based access control (RBAC) to manage administrative access to Azure resources. Consider whether users require permissions on a narrow scope, such as an Administrator for a single application, or a broad scope, such as a Network Administrator across multiple application workloads. In either case, follow the principle of just-enough access, and ensure that the user has only the roles required for their normal activities. Use custom roles and Microsoft Entra Privileged Identity Management (PIM) where necessary to enforce just-in-time (JIT) access. Although the platform team is responsible for the identity and access management foundation, both platform and application teams are consumers of the service and should follow the same principles.

Identity and access management is important for the successful separation of one landing zone from another and the isolation of workloads within an organization. It's a critical design area for both platform and application landing zones.

If your organization uses a [subscription-vending process](./subscription-vending.md), you can automate many of the identity and access configurations for application landing zones. Implement subscription vending to help standardize landing zone creation and so application teams can manage their own resources.

## Design considerations

Some organizations share services between multiple applications. For example, there might be a centralized integration service used by several independent applications. In that scenario, consider which services are managed centrally and which are devolved to application teams, and understand where security boundaries need to be enforced. Giving application teams administrative access to the shared service might be helpful for developer productivity, but might provide more access than is required.

Managing application resources that don't cross security boundaries can be delegated to application teams. Consider delegating other aspects that are required to maintain security and compliance as well. Letting users provision resources within a securely managed environment lets organizations take advantage of the agile nature of the cloud and prevent violation of any critical security or governance boundary.

### RBAC

> [!IMPORTANT]
>
> Classic resources and classic administrators are [retiring on August 31, 2024](https://azure.microsoft.com/updates/cloud-services-retirement-announcement/). Remove unnecessary co-administrators, and use Azure RBAC for fine-grained access control.

Understand the difference between Microsoft Entra ID roles and Azure RBAC roles.

  - [Microsoft Entra ID roles](/entra/identity/role-based-access-control/custom-overview) control the administrative privileges to tenant-wide services such as Microsoft Entra ID, and other Microsoft services including Microsoft Teams, Microsoft Exchange Online, and Microsoft Intune.

  - [Azure RBAC](/azure/role-based-access-control/overview) roles control the administrative privileges to Azure resources such as virtual machines, subscriptions, and resource groups.

  - The Azure RBAC Owner and User Access Administrator roles can modify the role assignments on Azure resources. By default, the Microsoft Entra Global Administrator role doesn't have permission to manage access to Azure resources. It must be explicitly enabled. For more information, see [Elevate access to manage all Azure subscriptions and management groups](/azure/role-based-access-control/elevate-access-global-admin).

[!INCLUDE [global admin warning](../../../includes/global-admin-warning.md)]

The following diagram shows the relationship between Microsoft Entra ID roles and Azure RBAC roles:

![Diagram showing the relationship between Microsoft Entra ID and Azure RBAC roles.](media/azure-rbac-roles.png)

- You can create role-assignable groups and [assign Microsoft Entra roles to the groups](/entra/identity/role-based-access-control/groups-concept) if you set the `isAssignableToRole` property to `true`. Only groups with this property set are protected. The only roles that can modify a group's membership are Global Administrators, Privileged Role Administrators, or the group’s owner.

- Only [some roles can reset the password](/entra/identity/role-based-access-control/privileged-roles-permissions#who-can-reset-passwords) or multifactor authentication (MFA) settings for another administrator. This restriction prevents unauthorized administrators from resetting the credentials of a higher-privileged account to get more permissions.

- If the Azure built-in roles don't meet the specific needs of your organization, you can [create your own custom roles](/azure/role-based-access-control/custom-roles). Just like built-in roles, you can assign custom roles to users, groups, and service principals at tenant, management group, subscription, and resource group scopes. Aim to use Azure built-in roles where possible, and only create custom roles when necessary.

- When you design your access control strategy, know the [service limits for roles](/azure/role-based-access-control/troubleshoot-limits), role assignments, and custom roles.

- Some Azure RBAC roles support [attribute-based access control (ABAC)](/azure/role-based-access-control/conditions-overview), or role assignment conditions. When you use conditions, administrators can dynamically assign roles based on the attributes of the resource. For example, you can assign the Storage Blob Data Contributor role but only for blobs that have a specific index tag rather than all blobs in a container.

- You can use built-in and custom RBAC roles with `Microsoft.Authorization/roleAssignments/write` or `Microsoft.Authorization/roleAssignments/delete` permissions to create, delete, and update role assignments. Anyone that has this role can decide who has write, read, and delete permissions for any resource in the assignment scope. Platform or application landing zone team members should consider how to delegate privileged roles to other users and groups to grant them necessary autonomy. To ensure compliance with least-privilege access principles, they can use [conditions](/azure/role-based-access-control/delegate-role-assignments-overview#a-more-secure-method-delegate-role-assignment-management-with-conditions) to delegate users.

## Design recommendations

### General recommendations

- Enforce [Microsoft Entra multifactor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) for users that have rights to the Azure environment, including the platform subscription, the application subscription, and the Microsoft Entra ID tenant. Many compliance frameworks require MFA enforcement. MFA helps to reduce the risk of credential theft and unauthorized access. To prevent unauthorized access to sensitive information, ensure that you include users with Reader roles in MFA policies.

- Use [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview) policies for users that have rights to the Azure environment. Conditional Access is another feature that helps protect a controlled Azure environment from unauthorized access. Application and platform administrators should have Conditional Access policies that reflect the risk profile of their role. For example, you might have requirements to carry out administrative activities only from specific locations or specific workstations. Or the sign-in risk tolerance for users with administrative access to Azure resources might be lower than it is for standard Microsoft Entra ID users.

- Enable [Microsoft Defender for Identity](/defender-for-identity/what-is) to help protect user identities and secure user credentials. Defender for Identity is part of Microsoft Defender XDR. You can use Defender for Identity to identify suspicious user activities and get incident timelines. You can also use it with Conditional Access to deny high-risk authentication attempts. Deploy Defender for Identity sensors onto on-premises domain controllers and domain controllers in the Azure identity subscription.

- Use [Microsoft Sentinel](/azure/sentinel/design-your-workspace-architecture) to provide threat intelligence and investigative capabilities. Sentinel uses logs from Azure Monitor Logs, Microsoft Entra ID, Microsoft 365, and other services to provide proactive threat detection, investigation, and response.

- Separate administrative access from nonadministrative, day-to-day access, such as web browsing and email access. Web and email are common attack vectors. When a user account is compromised, it's less likely to result in a security breach if the account isn't used for administrative access.
  - Use [separate, cloud-only accounts for privileged roles](/entra/architecture/protect-m365-from-on-premises-attacks#specific-security-recommendations). Don't use the same account for daily use that you do for privileged administration. Privileged Microsoft Entra ID and Azure RBAC roles are marked as *PRIVILEGED* in the Azure portal and in documentation.

  - For nonprivileged job function roles that can manage Azure application resources, consider whether you require separate administrative accounts or use [Microsoft Entra PIM](/entra/id-governance/privileged-identity-management/pim-configure) to control administrative access. PIM ensures that the account has the required permissions only when needed and that the permissions are removed when the task is complete (also known as *just-in-time access*).

- To make role assignments more manageable, don't assign roles directly to users. Instead, assign roles to groups to help minimize the number of role assignments, which has a [limit for each subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-rbac-limits).

  - Use [Microsoft Entra PIM for groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups) to apply just-in-time administrative access controls to privileged users. Consider controlling group membership with [entitlement management](/entra/id-governance/entitlement-management-overview). You can use the entitlement management feature to add approval and auditing workflows to group membership operations and help ensure that administrative group members aren't unnecessarily added or removed.
  
  - When you grant access to resources, use Microsoft Entra-only groups for Azure control-plane resources. Both Entra-only users and groups, and those synchronized from on-premises using Microsoft Entra Connect, can be added to an Entra-only group. Add on-premises groups to the Microsoft Entra-only group if a group management system is already in place. Using Entra-only groups helps protect the cloud control plane from unauthorized modification of on-premises directory services. Note that *Microsoft Entra-only* is also known as *cloud only*.

- Create [emergency-access](/entra/identity/role-based-access-control/security-emergency-access) accounts, or break-glass accounts, to avoid accidentally being locked out of your Microsoft Entra ID organization. Emergency-access accounts are highly privileged and are only assigned to specific individuals. Store the credentials for the accounts securely, monitor their use, and test them regularly to ensure that you can use them if there's a disaster.

  For more information, see [Secure access practices for administrators in Microsoft Entra ID](/entra/identity/role-based-access-control/security-planning).

### Microsoft Entra ID recommendations

- [Integrate Microsoft Entra ID with Azure Monitor](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs) so you can analyze your sign-in activity and the audit trail of changes within your tenant. Configure a diagnostic setting to send sign-in logs and audit logs to the platform central Azure Monitor Logs workspace in the management subscription.

- Use the entitlement management feature of Microsoft Entra ID Governance to [create access packages](/entra/id-governance/entitlement-management-overview) that control group membership via automatic approval processes and regular access reviews for privileged group members.

- Use [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) to manage the following identity settings from a tenant level:

   | Role | Description | Note
   |---|---|---|
   | Global Administrator | Manages all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identities. | Don't assign more than five people to this role.|
   | Hybrid Identity Administrator | Manages cloud provisioning from Active Directory to Microsoft Entra ID and also manages Microsoft Entra Connect, Microsoft Entra pass-through authentication, Microsoft Entra password hash synchronization, Microsoft Entra seamless single sign-on (SSO), and federation settings. | |
   | Security Administrator | Reads security information and reports, and manages configurations in Microsoft Entra ID and Microsoft 365. | |
   | Application Administrator | Creates and manages all aspects of app registrations and enterprise apps. | You can't grant tenant-wide administrative consent.|

- Don't assign a higher-privileged role to a task that a lower-privileged role can do. For example, assign the User Administrator role to manage users, not the Global Administrator role. For more information, see [Microsoft Entra built-in roles permissions](/entra/identity/role-based-access-control/permissions-reference).

- Use [administrative units](/entra/identity/role-based-access-control/administrative-units) to restrict a set of administrators so they can only manage specific objects in your tenant. You can use administrative units to delegate the administration of a subset of the directory. For example, you can delegate the administration of a service desk to a single business unit within a wider organization.

  Administrative units can also help eliminate the need for separate Microsoft Entra ID tenants as a security boundary, where separate teams manage the Microsoft 365 platform and the Azure platform in the same organization. For example, you can use administrative units to delegate the management of Azure application security principals to the application team without granting privileges on the entire Microsoft Entra ID tenant.

- Use [restricted management administrative units](/entra/identity/role-based-access-control/admin-units-restricted-management) to provide further protection. Prevent anyone other than a specific set of administrators that you designate from modifying specific objects. For example, your separation of duty policies might require that you use this feature to prevent anyone from modifying a specific user account, even users with the User Administrator role. This restriction is useful for service accounts that applications use and that even administrators shouldn't modify. You can also prevent privilege escalation, for example if someone modifies a user account or group that has platform or landing zone administration privileges.

### Azure RBAC recommendations

- To simplify administration and reduce the risk of misconfiguration, standardize roles and role assignments across all application landing zones. For example, if you have a role that delegates users to manage virtual machines, use the same role in all application landing zones. This approach also simplifies the process of moving resources between landing zones.

- Use [Azure RBAC](/azure/role-based-access-control/overview) to manage data plane access to resources, if possible. Examples of data plane endpoints are Azure Key Vault, a storage account, or a SQL database.

- Ensure that Azure Monitor Logs workspaces are configured with the appropriate permission model. When you use a centralized Azure Monitor Logs workspace, use [resource permissions](/azure/azure-monitor/logs/manage-access) to ensure that application teams have access to their own logs but not to logs from other teams.

##### Built-in roles

- Consider whether [built-in roles](/azure/role-based-access-control/built-in-roles) are suitable for your requirements. In many cases, you can assign multiple built-in roles to a security group to provide the appropriate access for a user. But sometimes, you can't use built-in roles and also comply with least-privilege access because the roles might include permissions that exceed what your users require. For more granular control, consider creating a custom role that reflects the specific permissions required to carry out a job function. For more information, see [Provide role-based authorization](/azure/well-architected/security/identity-access#role-assignment).
- Many Azure built-in roles provide predefined role assignments at the platform and resource level. When you [combine several role assignments](/azure/role-based-access-control/overview#multiple-role-assignments), consider the overall effects.

- The Azure landing zone accelerator includes several custom roles for common administrative functions. You can use these roles alongside Azure built-in roles. The following table describes the custom administrative roles or areas for the Azure landing zone accelerator:

   | Administrative role or area | Description | Actions | NotActions |
   |---|---|---|---|
   | Azure Platform Owner (such as the built-in Owner role) | Manages management groups and subscription lifecycles | `*` | |
   | Subscription Owner  | Delegated role for the subscription owner  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`,<br> `Microsoft.Network/expressRouteCircuits/*`,<br> `Microsoft.Network/routeTables/write`,<br> `Microsoft.Network/vpnSites/*` |
   | Application Owner (DevOps, App operations) | Contributor role for the application or operations team at the subscription scope  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/publicIPAddresses/write`, <br>`Microsoft.Network/virtualNetworks/write`, <br>`Microsoft.KeyVault/locations/deletedVaults/purge/action`  |
   | Network management (NetOps) | Manages platform-wide global connectivity, such as virtual networks, UDRs, NSGs, NVAs, VPNs, Azure ExpressRoute, and others  | `*/read`, <br>`Microsoft.Network/*`,<br> `Microsoft.Resources/deployments/*`,<br> `Microsoft.Support/*` | |
   | Security operations (SecOps) | Security Administrator role with a horizontal view across the entire Azure estate and the Key Vault purge policy | `*/read`,<br> `*/register/action`,<br> `Microsoft.KeyVault/locations/deletedVaults/purge/action`, <br>`Microsoft.PolicyInsights/*`,<br> `Microsoft.Authorization/policyAssignments/*`,<br>`Microsoft.Authorization/policyDefinitions/*`,<br>`Microsoft.Authorization/policyExemptions/*`,<br>`Microsoft.Authorization/policySetDefinitions/*`,<br>`Microsoft.Insights/alertRules/*`, <br> `Microsoft.Resources/deployments/*`, <br>`Microsoft.Security/*`, <br>`Microsoft.Support/*` | |

   Those roles might need extra rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. In organizations that need a more centralized approach, you can enrich the NetOps role with more allowed actions, such as creating peering between hubs and their spokes.

##### Role assignments and groups

- When the platform team provisions an application landing zone, they should ensure that all required identity and access management objects are created, such as security groups, standard role assignments, and user-assigned managed identities.

- Create landing zone role assignments at the subscription or resource group scope. Azure Policy assignments occur at the management group scope, so you should provision landing zone role assignments at a lower scope. Use this approach to ensure that landing zone administrators have full autonomy over their resources but can't modify the Azure Policy assignments that govern their landing zone.

- Each application landing zone should have its own groups and role assignments. Don't create generic groups and assign them to multiple landing zones. This approach can lead to misconfiguration and security breaches, and it's difficult to manage at scale. If one user requires access to multiple landing zones, assign them to the appropriate groups in each landing zone. Use ID Governance to manage their group membership.

- Assign roles to groups, not to users. This approach helps to ensure that users have the correct permissions when they join or leave your organization. It also helps to ensure that users have the correct permissions when they move between teams. For example, if a user moves from the network team to the security team, you should remove them from the network group and add them to the security group. If you assign a role directly to a user, they retain the role after moving to a different team. Use ID Governance to manage group membership rather than manually adding and removing group members.

- Maintain separate security configurations for different environments of the same application, such as dev/test and production. Create separate groups and role assignments for each environment. Don't share managed identities or service principals across environments. Treat each environment as a separate landing zone. This approach helps to ensure isolation between dev/test and production, and standardizes the process of moving application deployments between environments. If the same individual requires access to several landing zones, you should assign them to the appropriate groups in each landing zone.

- Consider whether platform administrators require permissions on application landing zones. If so, use Microsoft Entra PIM to control access to those resources, and assign the least-privileged permissions required. For example, a platform administrator might require access to a specific application landing zone to troubleshoot an issue but shouldn't have routine access to the application data or code. In this case, the platform administrator can request access to the application. A privileged role administrator approves the request, and the platform administrator is granted the required permissions for the specified time period. This approach helps enforce separation of duties and protects application landing zones from accidental or malicious misconfiguration.

- When you delegate administrative responsibility to others, such as application teams, consider whether they require the full set of privileges or only a subset. Follow the principle of least privilege (PoLP). For example, you might assign the User Access Administrator role or RBAC Administrator role to a user who needs to manage access to Azure resources but doesn't need to manage the resources themselves. To limit the identities, identity types, and roles that users can delegate and assign Azure RBAC assignments to, use [delegated role assignments with conditions](/azure/role-based-access-control/delegate-role-assignments-overview). Application teams can use conditions to manage their own security principals within the constraints that the platform team sets. More privileged role assignments require escalation to the platform team. Consider the following factors when you use conditions to delegate RBAC roles:

  - Review current role assignments for built-in and custom privileged roles and evaluate if you should add appropriate conditions to those existing assignments. For example, you can add conditions to the Subscription Owner and Application Owner custom roles that the Azure landing zone accelerator provides. These conditions can restrict the principal types that they can assign roles to or limit specific roles that they can assign.
  
  - Follow the PoLP when you add conditions to role assignments. For example, limit delegates to only assign roles to groups or enable delegates to assign all roles except privileged administrator roles like Owner, User Access Administrator, and RBAC Administrator.
  
  - Build your own conditions if the available condition templates don't fulfill your requirements or policies.

    :::image type="content" source="./media/azure-landing-zone-rbac-conditions.png" alt-text="Screenshot that shows the condition templates for RBAC constrained delegation." lightbox="./media/azure-landing-zone-rbac-conditions.png":::

  - Review the [known limitations](/azure/role-based-access-control/delegate-role-assignments-overview#known-issues) of delegating Azure access management to others.
  
- The following table shows an example role assignment structure for an Azure landing zone environment. It provides a balance between security and ease of administration. You can adapt the structure to suit your organization's requirements. You can assign the same individual to multiple groups, depending on their role within the organization. But you should apply the RBAC assignments to a specific group within a specific landing zone.

  | Resource | User | Role assignment | Assignment target | Assignment scope |
  |--|--|--|--|--|
  | Application *X* landing zone | Application *X* owners | Application Owner (custom, included in Azure landing zone accelerator) | `Application X Admins` security group | Application *X* production and dev/test subscriptions |
  | Application *X* landing zone | Application *X* owners | Application Access Administrator (custom, with role assignment conditions to manage access to their own application) | `Application X Admins` security group | Application *X* production and dev/test subscriptions |
  | Application *X* landing zone | Application *X* data administrator | Data Administrator (custom, with permissions on required data resources) | `Application X Data Team` security group | Application *X* production and dev/test subscriptions |
  | Application *Y* landing zone | Application *Y* owners | Application Owner (custom, included in Azure landing zone accelerator) | `Application Y Admins` security group | Application *Y* production and dev/test subscriptions |
  | Application *Y* landing zone | Application *Y* testing team | Test Contributor (custom, with permissions required for application testing) | `Application Y Test Team` security group | Application *Y* dev/test subscription |
  | Sandbox | Application Z development team | Owner (built-in) | `Application Z developers` security group | Application Z resource groups in sandbox subscription |
  | Platform resources | Platform management team | Contributor (built-in) | `Platform Admins` PIM group | `Platform` management group |
  | Platform landing zones | Platform management team | Reader (built-in) | `Platform Team` security group | Organizational top-level management group |
  | Tenant-wide | Security team | Security Operations (custom, included in Azure landing zone accelerator) | `Security Ops` security group | Organizational top-level management group |
  | Tenant-wide | Security team | Conditional Access Administrator (built-in, with protected actions enabled) | `Security administrators` security group | Microsoft Entra ID tenant |
  | Tenant-wide | Network team | Network Operations (Custom, included in Azure landing zone accelerator) | `Network Ops` security group | All subscriptions |
  | Tenant-wide | FinOps team | Billing Reader (built-in) | `FinOps Team` security group | Organizational top-level management group |

- Azure Policy assignments that have the `DeployIfNotExists` effect require a [managed identity](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations) to remediate noncompliant resources. If you use a system-assigned managed identity as part of the Azure Policy assignment process, Azure automatically grants the required permissions. If you use a user-assigned managed identity, the permissions must be granted manually. The managed identity role assignments must follow the PoLP and enable only the required permissions to carry out the policy remediation on the target scope. Policy remediation managed identities don't support custom role definitions. Apply role assignments directly to managed identities and not to groups.

### Microsoft Entra PIM recommendations

- Use [Microsoft Entra PIM](/entra/id-governance/privileged-identity-management/pim-configure) to comply with the Zero Trust model and least-privilege access. Correlate your organization's roles to the minimum access levels needed. In Microsoft Entra PIM, you can use Azure-native tools, extend existing tools and processes, or use both existing and native tools as needed.

- Use [Microsoft Entra PIM access reviews](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) to regularly validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations already have an access review process in place.

- Use privileged identities for automation runbooks that require elevated access permissions, or for privileged deployment pipelines. You can use the same tools and policies to govern automated workflows that access critical security boundaries that you use to govern users of equivalent privilege. Automation and deployment pipelines for application teams should have role assignments that prevent an application owner from escalating their own privileges.

- Control highly privileged Azure RBAC roles, such as Owner or User Access Administrators that are assigned to platform or application landing zone team members on a subscription or management group. Use [Microsoft Entra PIM for groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups) to configure Azure RBAC roles so they require the same elevation process as Microsoft Entra ID roles.

   For example, a user might routinely require limited administrative access to resources in an application landing zone. Occasionally, they might require the Owner role. You can create two security groups: Application Administrators and Application Owners. Assign the least-privilege roles to the Application Administrators group, and assign the owner role to the Application Owners role. Use PIM groups so the user can request the Owner role when required. At all other times, the user has only the permissions required to carry out their typical activities.

- Use [protected actions](/entra/identity/role-based-access-control/protected-actions-overview) with Microsoft Entra PIM to add extra layers of protection. In Microsoft Entra ID, protected actions are permissions that are assigned [Conditional Access policies](/entra/identity/conditional-access/overview). When a user attempts to perform a protected action, they must first satisfy the Conditional Access policies that are assigned to the required permissions. For example, to allow administrators to update cross-tenant access settings, you can require that they first satisfy the [phishing-resistant MFA policy](/entra/identity/authentication/concept-authentication-strengths#built-in-authentication-strengths).

## Identity and access management in the Azure landing zone accelerator

Identity and access management are core features of Azure landing zone accelerator implementation. The deployment includes a subscription that's dedicated to identity, where organizations can deploy AD DS domain controllers or other identity services, such as Microsoft Entra Connect servers, that are required for their environment. Not all organizations require services in the subscription. For example, some organizations might have applications that are already fully integrated with Microsoft Entra ID.

The identity subscription has a virtual network that's peered to the hub virtual network in the platform subscription. With this configuration, the platform team can manage the identity subscription, and application owners have access to identity services as required. You must secure the identity subscription and virtual network to protect identity services from unauthorized access.

Azure landing zone accelerator implementation also includes options to:

- Assign recommended policies to govern identity and domain controllers.
- Create a virtual network, and connect to the hub via virtual network peering.

### Next steps
>
> [!div class="nextstepaction"]
> [Application identity and access management](identity-access-application-access.md)
