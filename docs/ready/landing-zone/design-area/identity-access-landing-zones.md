---
title: Azure landing zone identity and access management
description: See considerations and recommendations for implementing identity and access control within Azure application and platform landing zones.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 12/05/2023
---

# Landing zone identity and access management

Once you have identified your Identity architecture, the next step is about authorization to manage and access resources in application and platform landing zones. Consider which resources each authenticated principal has or needs access to, and how to mitigate risks of unauthorized access to your resources. For more information, see [Identity architecture design](/azure/architecture/identity/identity-start-here). This design area helps you implement [Enterprise access strategy in Azure](/security/privileged-access-workstations/privileged-access-access-model#evolution-from-the-legacy-ad-tier-model), and the different control planes that need to be secured.

The design principles of [Subscription Democratization](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization) allows application teams to manage their own workloads within the policy guardrails set by the platform teams, which follows the [policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance) principle. The provisioning of new application landing zones, or subscriptions, is carried out by the platform team. When a landing zone is provisioned for an application owner, it should be configured with the appropriate access controls to allow the application owner to manage their own resources. This includes the ability to create and manage users and groups within Microsoft Entra ID, and to assign roles to those users and groups. The application owner can then manage access to their own resources, and delegate access to other users and groups as required. It should also have network connectivity to Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services in the Identity Platform subscription, if required.

Use Azure role-based access control (RBAC) to manage administrative access to Azure resources. Consider whether users require permissions on a narrow scope, such as an administrator for a single application; or broad scope, such as a network administrator across multiple application workloads. In either case, follow the principle of just-enough-access, and ensure that the user has only the roles required for their normal activities, using custom roles and privileged identity management (PIM) where necessary to enforce just-in-time (JIT) access. Although the platform team is responsible for the identity and access management foundation, both platform and application teams are consumers of the service, and should follow the same principles.

Identity and access management underpins the separation of one landing zone from another, and the isolation of workloads within an organization. It is a critical design area for both platform and application landing zones.

Organizations using a subscription vending process can automate much of the identity and access configuration for application landing zones. Subscription vending helps to standardize landing zone creation, and facilitates self-service by application teams. For more information, see [Subscription vending](./subscription-vending.md).

## Design considerations

### Role-Based Access Control (RBAC)

> [!IMPORTANT]
>
> Classic resources and classic administrators will be [retired on August 31, 2024](https://azure.microsoft.com/updates/cloud-services-retirement-announcement/). Remove unnecessary Co-Administrators and use Azure RBAC for fine-grained access control.

- Understand the difference between Microsoft Entra ID roles and Azure RBAC roles.

  - Entra ID roles control the administrative privileges to tenant-wide services such as Microsoft Entra ID, and other Microsoft services including Teams, Exchange Online, and Intune.

  - Azure RBAC roles control the administrative privileges to Azure resources such as virtual machines, subscriptions, and resource groups. For more information, see [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview).

  - The Azure RBAC Owner and User Access Administrator roles can modify the role assignments on Azure resources. By default, the Microsoft Entra Global Administrator role doesn't have permission to manage access to Azure resources, as it must be explicitly enabled. For more information, see [Elevate access to manage all Azure subscriptions and management groups](/azure/role-based-access-control/elevate-access-global-admin).

The relationship between Microsoft Entra ID roles and Azure RBAC roles is shown in the diagram.

![Diagram showing the relationship between Microsoft Entra ID and Azure RBAC roles.](media/azure-rbac-roles.png)

- Microsoft Entra roles can be assigned to groups with the `isAssignableToRole` property set to `true` (‘Role-assignable groups’). Groups with this property set are protected and their membership can only be modified by Global Administrators or Privileged Role Administrators, or the group’s owner. See [Use Microsoft Entra groups to manage role assignments](/entra/identity/role-based-access-control/groups-concept).

- Only some roles can reset the password or MFA settings for another administrator. This behavior prevents an administrator from gaining extra permissions by resetting the credentials of a higher-privileged account. See [Microsoft Entra built-in roles - who can reset passwords](/entra/identity/role-based-access-control/permissions-reference#who-can-reset-passwords) to understand administrator password reset rights.

- If the Azure built-in roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals at tenant, management group, subscription, and resource group scopes. For more information, see [Azure custom roles - Azure RBAC](/azure/role-based-access-control/custom-roles). Aim to use Azure built-in roles where possible, and only create custom roles when necessary.

- For built-in Microsoft Entra role-based access control (RBAC) roles, you can use the free version of Microsoft Entra ID, but for custom Microsoft Entra roles, you need Microsoft Entra ID Premium. For more information, see [Create and assign a custom role in Microsoft Entra ID](/entra/identity/role-based-access-control/custom-create#prerequisites).

- When you design your access control strategy, be aware of the service limits for roles, role assignments, and custom roles. For more information, see [Troubleshoot Azure RBAC limits](/azure/role-based-access-control/troubleshoot-limits).

- Some Azure RBAC roles support Attribute-Based Access Control (ABAC), or role assignment conditions. Conditions allow administrators to dynamically assign roles based on attributes of the resource. For example, you can assign the Storage Blob Data Contributor role, but only for blobs that have a specific index tag applied rather than all the blobs in a container. See [What is Azure attribute-based access control (Azure ABAC)?](/azure/role-based-access-control/conditions-overview) for more information.

## Design recommendations

### General recommendations

- Enforce [multifactor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) for users with rights to the Azure environments. Many compliance frameworks require multifactor authentication enforcement. Multifactor authentication greatly lowers the risk of credential theft and unauthorized access.

- Use Microsoft Entra [Conditional Access](/entra/identity/conditional-access/overview) policies for users with rights to Azure environments. Conditional Access provides another mechanism to help protect a controlled Azure environment from unauthorized access.

- Enable [Defender for Identity](/defender-for-identity/what-is) to protect user identities and make it harder to compromise user credentials. Defender for Identity identifies suspicious user activities, provides incident timelines, and can be used with Conditional Access to deny high-risk authentication attempts.

- Use Microsoft Sentinel to provide more threat intelligence and investigative capability. Sentinel uses logs from Log Analytics, Microsoft Entra ID, Microsoft 365 and other services for proactive threat detection, investigation, and response. For more information on integrating Sentinel into your Azure environment, see [Design your Microsoft Sentinel workspace architecture](/azure/sentinel/design-your-workspace-architecture).

- Use separate, cloud-only accounts for privileged roles. Don't use the same account for web browsing and e-mail access as you do for privileged administration. For more information, see [isolate privileged identities](/entra/architecture/protect-m365-from-on-premises-attacks#specific-security-recommendations). For roles with access to manage Azure resources, consider whether separate administrative accounts are required, or whether the use of [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) can be used to control administrative access.

- To make role assignments more manageable, avoid assigning roles directly to users. Instead, assign roles to groups. Assigning roles to groups instead of users also helps minimize the number of role assignments, which has a [limit of role assignments per subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-rbac-limits). Use [Privileged Identity Management (PIM) for Groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups) to apply just-in-time administrative access controls to privileged users.

- Create [emergency access or “break glass” accounts](/entra/identity/role-based-access-control/security-emergency-access) to avoid accidentally being locked out of your Microsoft Entra ID organization. Emergency access accounts are highly privileged and aren't assigned to specific individuals. Store the credentials for the accounts securely, monitor their use, and test them regularly to ensure they can be used in the event of a disaster.

- For more information on securing administrative access, see [Secure access practices for administrators in Microsoft Entra](/entra/identity/role-based-access-control/security-planning).

### Microsoft Entra ID recommendations

- Integrate Microsoft Entra ID with Azure Monitor so your sign-in activity and the audit trail of changes within your tenant can be analyzed. Create a diagnostic setting to send sign-in logs and audit logs to the platform-central Log Analytics workspace. For more information, see [Integrate Microsoft Entra ID with Azure Monitor logs](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs).

- Use Entra identity governance and create access packages to control group membership, with an approval process and regular access reviews for privileged group members. See [What is entitlement management? - Microsoft Entra](/entra/id-governance/entitlement-management-overview) for more information.

- Use [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) to manage the following identity settings from a tenant level:

   | Role | Usage | Note
   |---|---|---|
   | Global Admin | Can manage all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identities. | Don't assign more than five people to this role.|
   | Hybrid Identity Administrator | Can manage Active Directory to Microsoft Entra cloud provisioning, Microsoft Entra Connect, Pass-through Authentication (PTA), Password hash synchronization (PHS), Seamless Single sign-on (Seamless SSO), and federation settings. | |
   | Security Administrator | Can read security information and reports, and manage configuration in Microsoft Entra ID and Office 365. | |
   | Application Administrator | Can create and manage all aspects of app registrations and enterprise apps. | Can't grant tenant-wide admin consent|

- Don't use a higher-privileged role to carry out an activity that could be done with a lower-privileged role. For example, use the User Administrator role to manage users, not the Global Administrator role. For details of roles and their permissions, refer to the [Microsoft Entra build-in roles permissions](/entra/identity/role-based-access-control/permissions-reference). Additionally, the Azure portal indicates which roles and role permissions are privileged. For more information, see [Privileged roles and permissions in Microsoft Entra ID](/entra/identity/role-based-access-control/privileged-roles-permissions).

- Use [administrative units](/entra/identity/role-based-access-control/administrative-units) to provide restricted management of specific objects in your tenant from modification to a specific set of administrators. Administrative units allow for delegated administration of a subset of the directory, such as a service desk that serves only a single business unit within a wider organization. Use the [Restricted management administrative units](/entra/identity/role-based-access-control/admin-units-restricted-management) feature to further protect specific objects from modification.

### Azure RBAC recommendations

- Standardize roles and role assignments across all application landing zones to simplify administration and reduce the risk of misconfiguration. For example, if you have a role that allows users to manage virtual machines, use the same role in all application landing zones. This approach also simplifies the process of moving resources between landing zones.

- When provisioning an application landing zone, the platform team should ensure that all required identity and access management objects are created, such as security groups, standard role assignments, and user-assigned managed identities.

- Create role assignments at the subscription or resource group scope. Azure Policy assignments occur at the Management Group scope, so landing zone role assignments should be provisioned at a lower scope to ensure that landing zone administrators can have full autonomy over their resources without having the ability to modify the Azure Policy assignments that govern their landing zone.

- Each application landing zone should have its own groups and role assignments. Do not create generic groups and assign them to multiple landing zones. This approach can lead to misconfiguration and security breaches, and it is difficult to manage at scale. If one user requires access to multiple landing zones, assign them to the appropriate groups in each landing zone and use Identity Governance to manage their group membership.

- Assign roles to groups, not to users. This approach helps to ensure that users have the correct permissions when they join or leave the organization. It also helps to ensure that users have the correct permissions when they move between teams. For example, if a user moves from the network team to the security team, they should be removed from the network group and added to the security group. If the user was assigned a role directly, they would retain the role after moving to the security team. Use Microsoft Entra Identity Governance to manage group membership, rather than manually adding and removing group members.

- Maintain separate security configuration for different environments of the same application, such as dev, test, and production. Create separate groups and role assignments for each environment. Do not share managed identities or SPNs across environments, and treat each environment as a separate landing zone. This approach helps to ensure isolation between dev/test and production, and standardizes the process of moving application deployments between environments.

- Azure Policy assignments with the `DeployIfNotExists` effect require a managed identity to remediate noncompliant resources. If using a system-assigned managed identity as part of the Azure Policy assignment process, the Azure Portal will automatically grant the permissions required. If using a user-assigned managed identity, the permissions must be granted manually. The managed identity role assignments must follow the principle of least privilege and allow only the permissions required to carry out the policy remediation on the target scope. Policy remediation managed identities do not support custom role definitions. Role assignments for managed identities should be applied directly to the identity, not to a group. For more information, see [Managed identity best practice recommendations](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations).

- Consider whether platform administrators require permissions on application landing zones. If so, use Privileged Identity Management to control access to those resources, and assign the least-privileged permissions required. For example, a platform administrator may require access to a specific application landing zone to troubleshoot an issue. In this case, the platform administrator can request access to the application. The request is approved by a Privileged Role Administrator, and the platform administrator is granted the required permissions for the specified time period. This approach helps enforce separation of duties and protects application landing zones from accidental or malicious misconfiguration.

- Use [Azure RBAC](/azure/role-based-access-control/overview) to manage data plane access to resources, if possible. Examples of data plane endpoints are Azure Key Vault, a storage account, or an SQL Database.

- Ensure that Log Analytics workspaces are configured with the appropriate permission model. When using a centralized Log Analytics workspace, use resource permissions to ensure that application teams have access to their own logs, but not to logs from other teams. For more information, see [Log Analytics workspace permissions](/azure/azure-monitor/logs/manage-access).

- When delegating administrative responsibility to others, such as application teams, consider whether they require the full set of privileges, or only a subset. For example, the User Access Administrator or Role Based Access Control Administrator roles may be assigned to a user who needs to manage access to Azure resources, but not manage the resources themselves. To restrict the identities, identity types and roles to which they can delegate and assign Azure RBAC assignments to, use [delegated role assignments with conditions](/azure/role-based-access-control/delegate-role-assignments-overview).

- Consider whether builtin roles are suitable for your requirements. In many cases, assigning a combination of builtin roles to a security group provides the appropriate access for a user. In some cases, it is not possible to enforce the principle of least privilege using the built-in roles, as they may include permissions that exceed what your users require. For more granular control, consider creating a custom role that reflects the specific permissions required to carry out a job function.
  - Many [Azure built-in roles](/azure/role-based-access-control/built-in-roles) exist to provide predefined role assignments at platform and resource level. When several role assignments are combined, review [multiple role assignments](/azure/role-based-access-control/overview#multiple-role-assignments) to understand the effects.
  - The Azure Landing Zones Accelerator includes a number of custom roles for common administrative functions. These roles are designed to be used in conjunction with the Azure built-in roles.

   | Administrative function | Usage | Actions | NotActions |
   |---|---|---|---|
   | Azure platform owner (such as the built-in Owner role) | Management group and subscription lifecycle management | `*` | |
   | Network management (NetOps) | Platform-wide global connectivity management: Virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others  | `*/read`, <br>`Microsoft.Network/*`,<br> `Microsoft.Resources/deployments/*`,<br> `Microsoft.Support/*` | |
   | Security operations (SecOps) | Security Administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy | `*/read`,<br> `*/register/action`,<br> `Microsoft.KeyVault/locations/deletedVaults/purge/action`, <br>`Microsoft.PolicyInsights/*`,<br> `Microsoft.Authorization/policyAssignments/*`,<br>`Microsoft.Authorization/policyDefinitions/*`,<br>`Microsoft.Authorization/policyExemptions/*`,<br>`Microsoft.Authorization/policySetDefinitions/*`,<br>`Microsoft.Insights/alertRules/*`, <br> `Microsoft.Resources/deployments/*`, <br>`Microsoft.Security/*`, <br>`Microsoft.Support/*` | |
   | Subscription owner  | Delegated role for subscription owner generated from subscription Owner role  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`,<br> `Microsoft.Network/expressRouteCircuits/*`,<br> `Microsoft.Network/routeTables/write`,<br> `Microsoft.Network/vpnSites/*` |
   | Application owners (DevOps, AppOps) | Contributor role granted for application/operations team at Subscription scope  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/publicIPAddresses/write`, <br>`Microsoft.Network/virtualNetworks/write`, <br>`Microsoft.KeyVault/locations/deletedVaults/purge/action`  |

### Privileged Identity Management (PIM) recommendations

- Use Microsoft Entra [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to establish zero-trust and least privilege access. Map your organization's roles to the minimum access levels needed. Microsoft Entra PIM can use Azure native tools, extend current tools and processes, or use both current and native tools as needed.

- Use [PIM access reviews](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) to regularly validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations already have an access review process in place.

- Use privileged identities for automation runbooks that require elevated access permissions, or for privileged deployment pipelines. Use the same tools and policies to govern automated workflows that access critical security boundaries as you use to govern users of equivalent privilege. Automation and deployment pipelines for application teams should not have role assignments that would allow an application owner to escalate their own privileges.

- Control highly privileged Azure RBAC roles, such as Owner or User Access Administrator assigned to Platform or Application landing zone team members on a subscription or management group, using [Privileged Identity Management (PIM) for Groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups). With PIM for groups, Azure RBAC roles can be configured to require the same elevation process as Microsoft Entra ID roles.

- Use Protected actions with PIM (Privileged Identity Management) to add extra layers of protection. Protected actions in Microsoft Entra ID are permissions that have been assigned [Conditional Access policies](/entra/identity/conditional-access/overview). When a user attempts to perform a protected action, they must first satisfy the Conditional Access policies assigned to the required permissions. For example, to allow administrators to update cross-tenant access settings, you can require that they first satisfy the [Phishing-resistant MFA policy](/entra/identity/authentication/concept-authentication-strengths#built-in-authentication-strengths). For more information, see [What are protected actions in Microsoft Entra ID](/entra/identity/role-based-access-control/protected-actions-overview).

## Identity and access management in the Azure landing zone accelerator

Identity and access management are core features of the Azure landing zone accelerator implementation. The deployment includes a subscription dedicated to identity, where organizations can deploy Active Directory domain controllers required for their environments.

The implementation also includes options to:

- Assign recommended policies to govern identity and domain controllers.
- Create a virtual network, and connect to the hub via virtual network peering.

### Next Steps

>
> [!div class="nextstepaction"]
> [Application identity and access management](identity-access-application-access.md)
