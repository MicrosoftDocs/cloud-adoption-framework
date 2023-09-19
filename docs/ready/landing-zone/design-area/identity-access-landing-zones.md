---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm 
ms.service: cloud-adoption-framework
ms.topic: conceptual
ms.date: 09/19/2023
---

# Identity and resource access management

Once you have identified your Identity architecture, the next step is about authorization. Consider what resources each authenticated principal has or needs access to, and how to mitigate risks of unauthorized access to your resources. Refer to this document to understand more about Enterprise access strategy in Azure, and the different control planes that need to be secured.

Use Azure role-based access control (RBAC) to manage administrative access to Azure resources. The design principle of subscription democratisation allows application administrators to manage their own workloads within the policy guiderails set by the platform owner.

Consider whether users require permissions on a narrow scope, such as an administrator for a single application, or broad scope, such as a network administrator across multiple application workloads. In either case, follow the principle of just-enough-access, and ensure that the user has only the roles required for their normal activities, using custom roles and privileged identity management (PIM) where necessary.

## Design considerations

### Role-Based Access Control (RBAC)

> [!IMPORTANT]
> Classic resources and classic administrators will be [retired on August 31, 2024](https://azure.microsoft.com/updates/cloud-services-retirement-announcement/). Remove unnecessary Co-Administrators and use Azure RBAC for fine-grained access control.

- Understand the difference between Microsoft Entra ID roles and Azure RBAC roles.

  - Entra ID roles control the administrative privileges to tenant-wide services such as Microsoft Entra ID, as well as other Microsoft services including Teams, Exchange Online, and Intune.

  - Azure RBAC roles control the administrative privileges to Azure resources such as virtual machines, subscriptions, and resource groups. For more information, see What is Azure role-based access control (Azure RBAC)?

  - The Global Administrator Microsoft Entra role (if allowed), and the Owner and User Access Administrator Azure RBAC roles, can modify the role assignments on Azure resources.

  - Classic resources and classic administrators will be retired on August 31, 2024. Remove unnecessary Co-Administrators and use Azure RBAC for fine-grained access control. See Resource Manager and classic deployment - Azure Resource Manager | Microsoft Learn for more information on migrating from Classic resources to Azure Resource Manager.

  - Microsoft Entra ID roles can be assigned to groups with the isAssignableToRole property set to true (‘Role-assignable groups’). Groups with this property set are protected and their membership can only be modified by, Global Administrators or Privileged Role Administrators, or the group’s owner. See Use Microsoft Entra groups to manage role assignments - Microsoft Entra | Microsoft Learn

  - Only some roles can reset the password or MFA settings for another administrator. This is to prevent an administrator from gaining extra permissions by resetting the credentials of a higher-privileged account. See Microsoft Entra built-in roles - who can reset passwords to understand administrator password reset rights.

  - Some roles support Attribute-Based Access Control (ABAC), or role assignment conditions. These allow you administrators to dynamically assign roles based on attributes of the resource. For example, assigning the Storage Blob Data Contributor role, but only for blobs that have a specific index tag applied rather than all the blobs in a container. See What is Azure attribute-based access control (Azure ABAC)? | Microsoft Learn for more information.

- The relationship between Microsoft Entra ID roles and Azure RBAC roles is shown in the diagram below.

- If the Azure built-in roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals at management group, subscription, and resource group scopes. For more information, see Azure custom roles - Azure RBAC | Microsoft Learn

- For built-in Microsoft Entra role-based access control (RBAC) roles, you can use the free version of Microsoft Entra ID, but for custom Microsoft Entra roles, you need Microsoft Entra ID Premium. For more information, see  Create custom roles in Microsoft Entra role-based access control - Microsoft Entra | Microsoft Learn

- When you lay down a framework for identity and access management (IAM) and governance, consider the following maximum service limits for roles, role assignments, and custom roles. For more information, see  Troubleshoot Azure RBAC limits - Azure RBAC | Microsoft Learn.

  - 4,000 role assignments per subscription.

  - 500 role assignments per management group.

  - 30 Microsoft Entra custom roles in an Microsoft Entra organization.

## Design recommendations

- Enforce multifactor authentication (MFA) for users with rights to the Azure environments. Many compliance frameworks require multi-factor authentication enforcement. Multi-factor authentication greatly lowers the risk of credential theft and unauthorized access.

- Use Microsoft Entra Conditional Access policies for users with rights to Azure environments. Conditional Access provides another mechanism to help protect a controlled Azure environment from unauthorized access.

- Enable Defender for Identity to protect user identities and make it harder to  compromise user credentials. Defender for Identity identifies suspicious user activities and provides incident timelines, and can be used with Conditional Access to deny high-risk authentication attempts.

- Use Azure Sentinel to provide additional threat intelligence and investigative capability. Sentinel uses logs from Log Analytics, Microsoft Entra ID, Microsoft 365 and other services for proactive threat detection, investigation, and response. For more informaition, see Identify advanced threats with User and Entity Behavior Analytics (UEBA) in Microsoft Sentinel | Microsoft Learn

- Use separate, cloud-only accounts for administrative activity. Do not use the same account for web browsing and e-mail access as you do for Azure administration. For more information on securing administrative access, see Secure access practices for administrators in Microsoft Entra | Microsoft Learn.

- Create emergency access or “break glass” accounts to avoid accidentally being locked out of your Microsoft Entra ID organisation. Emergency access accounts are highly privileged and are not assigned to specific individuals. Store the credentials for the accounts securely, monitor their use, and test them regularly to ensure they can be used in the event of a disaster.

- Use Entra Identity Governance and create Access Packages to control group membership, with an approval process and regular access reviews for privileged group members. See What is entitlement management? - Microsoft Entra | Microsoft Learn for more information.

- To make role assignments more manageable, avoid assigning roles directly to users. Instead, assign roles to groups. Assigning roles to groups instead of users also helps minimize the number of role assignments, which has a limit of role assignments per subscription.

### Privileged Identity Management (PIM)

- Use Microsoft Entra Privileged Identity Management (PIM) to establish zero-trust and least privilege access. Map your organization's roles to the minimum access levels needed. Microsoft Entra PIM can use Azure native tools, extend current tools and processes, or use both current and native tools as needed.

- Use PIM access reviews to regularly validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations already have an access review process in place.

- Use privileged identities for automation runbooks that require elevated access permissions, or for privileged deployment pipelines. Use the same tools and policies to govern automated workflows that access critical security boundaries as you use to govern users of equivalent privilege.

- Control highly privileged Azure RBAC roles, such as Owner or User Access Administrator on a subscription or management group, using Privileged Identity Management (PIM) for Groups - Microsoft Entra | Microsoft Learn. With PIM for groups, Azure RBAC roles can be configured to require the same elevation process as Microsoft Entra ID roles.

- Use Administrative Units to provide restricted management of specific objects in your tenant from modification to a specific set of administrators. This allows delegated administration of a subset of the directory, such as a service desk that serves only a single business unit within a wider organisation. Use the Restricted management administrative units feature to further protect specific objects from modification.

- Use Protected actions with PIM (Privileged Identity Management) to add additional layer of protection. Protected actions in Microsoft Entra ID are permissions that have been assigned Conditional Access policies. When a user attempts to perform a protected action, they must first satisfy the Conditional Access policies assigned to the required permissions. For example, to allow administrators to update cross-tenant access settings, you can require that they first satisfy the Phishing-resistant MFA policy. See What are protected actions in Microsoft Entra | Microsoft Learn for more information.

- Use [Microsoft Entra built-in roles](/azure/role-based-access-control/built-in-roles) to manage the following identity settings:

   | Role | Usage | Note
   |---|---|---|
   | Global Admin | | Don't assign more than five people to this role.
   | Hybrid Environment | Hybrid Identity Administrator | |
   | Authentication | Security Administrator | |
   | Enterprise Application or Application Proxy | Application Administrator | No consent global admin.|

- If the Azure built-in roles don't meet your organization's specific needs, you can create your own custom roles. Consider the following key role definitions when you create custom roles within the Microsoft Entra Tenant. The wildcard \* under `Actions` means the principal assigned to this role can do all actions. The actions under `NotActions` are subtracted from `Actions`.

   | Role | Usage | Actions | NotActions |
   |---|---|---|---|
   | Azure platform owner (such as the built-in Owner role) | Management group and subscription lifecycle management | `*` | |
   | Network management (NetOps) | Platform-wide global connectivity management: Virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others  | `*/read`, `Microsoft.Network/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Support/*` | |
   | Security operations (SecOps) | Security Administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy | `*/read`, `*/register/action`, `Microsoft.KeyVault/locations/`<br>`deletedVaults/purge/action`, `Microsoft.PolicyInsights/*`, `Microsoft.Authorization/`<br>`policyAssignments/*`,<br>`Microsoft.Authorization/`<br>`policyDefinitions/*`,<br>`Microsoft.Authorization/`<br>`policyExemptions/*`,<br>`Microsoft.Authorization/`<br>`policySetDefinitions/*`,<br>`Microsoft.Insights/alertRules/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Security/*`, `Microsoft.Support/*` | |
   | Subscription owner  | Delegated role for subscription owner generated from subscription Owner role  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`, `Microsoft.Network/`<br>`expressRouteCircuits/*`, `Microsoft.Network/routeTables/write`, `Microsoft.Network/vpnSites/*` |
   | Application owners (DevOps, AppOps) | Contributor role granted for application/operations team at Subscription scope  | `*` | `Microsoft.Authorization/*/write`, `Microsoft.Network/`<br>`publicIPAddresses/write`, `Microsoft.Network/`<br>`virtualNetworks/write`, `Microsoft.KeyVault/locations/`<br>`deletedVaults/purge/action`  |

## Identity and access management in the Azure landing zone accelerator

Identity and access management are core features of the Azure landing zone accelerator implementation. The deployment includes a subscription dedicated to identity, where customers can deploy the Active Directory domain controllers their environments require.

The implementation also includes options to:

- Assign recommended policies to govern identity and domain controllers.
- Create a virtual network, and connect to the hub via virtual network peering.
