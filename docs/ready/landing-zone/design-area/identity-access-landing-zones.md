---
title: Azure identity for landing zones
description: See considerations and recommendations for implementing identity and access control within an Azure landing zone.
author: anlucen
ms.author: martinek
ms.date: 06/24/2022
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency.5
---

# Azure identity and access for landing zones

Thoroughly assess and incorporate authentication requirements when you plan landing zone deployments for:

- Windows Server Active Directory Domain Services (AD DS) on-premises or in the cloud.
- Azure Active Directory Domain Services (Azure AD DS) in the cloud.

## Design considerations

Consider the following identity and access management solutions for landing zone deployments:

### Managed identities

- Evaluate using managed identities for Azure resources that don't need to use credentials.

- Decide which tasks and functions your organization should control with managed identities. To check which Azure resources managed identities support, see [Azure services that can use managed identities to access other services](/azure/active-directory/managed-identities-azure-resources/managed-identities-status). For more information, see [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

- There are two options for managed identities: system-assigned or user-assigned. For guidance in choosing system-assigned or user-assigned managed identities, see [Choose system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities).

- Applications that need to authenticate against an Azure service can use managed identities. Find out which services or applications within your landing zone support Azure AD authentication. To check which Azure services support Azure AD authentication, see [Azure services that support Azure AD authentication](/azure/active-directory/managed-identities-azure-resources/services-azure-active-directory-support).

- System-assigned managed identity is part of a solution you can configure to sign in to a VM using Azure AD authentication. For more information, see [Sign in to Windows virtual machine in Azure using Azure Active Directory authentication](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows).

- It's easy to confuse how service principals and managed identities access Azure resources. For an explanation, see [Demystifying Service Principals - Managed Identities](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities).

- You can't transfer Azure resources with user-assigned or system-assigned identities to another Azure subscription. You must move the resources manually.

### Role-based access control (RBAC)

- For built-in role-based access control (RBAC) roles, you can use the free version of Azure AD, but for custom roles, you need Azure AD Premium. For more information, see [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview#:~:text=Azure%20role-based%20access%20control%20%28Azure%20RBAC%29%20helps%20you,that%20provides%20fine-grained%20access%20management%20of%20Azure%20resources.)

- When you lay down a framework for identity and access management (IAM) and governance, consider the following maximum service limits for roles, role assignments, and custom roles. For more information, see [Azure RBAC service limits](/azure/role-based-access-control/troubleshooting).

  - 4,000 role assignments per subscription.
  - 500 role assignments per management group.
  - 30 Azure AD custom roles in an Azure AD organization.

### Azure Classic deployments

You can migrate Azure Classic environments to the Azure Resource Manager (ARM) deployment model, but you can't migrate virtual machines (VMs) and virtual networks. You must upgrade automated scripts to accommodate the new schema. For more information, see [Migrate from classic to Resource Manager](/azure/azure-resource-manager/management/deployment-models#migrate-from-classic-to-resource-manager).

For Azure Classic subscription administrator roles, the Account Administrator has the Service Administrator attached by default. These roles together allow managing Azure resource billing, as well as the resources themselves. To separate the duties, you can transfer the ownership of the Service Administrator to another account. However, since the Service Administrator has the same function as the Azure Owner role, it's best practice to remove the Service Administrator role and use role-based access control to manage Azure resource access. For more information, see [Change the Service Administrator](/azure/role-based-access-control/classic-administrators#change-the-service-administrator).

## Design recommendations

- Deploy Azure AD [Conditional Access](/azure/active-directory/conditional-access/overview) policies for users with rights to Azure environments. Conditional Access provides another mechanism to help protect a controlled Azure environment from unauthorized access. If you use authentication outside of Azure AD, see [Custom controls (preview)](/azure/active-directory/conditional-access/controls) for information about limitations.

- Enforce [multifactor authentication (MFA)](/azure/active-directory/authentication/concept-mfa-howitworks) for users with rights to the Azure environments. Many compliance frameworks require multifactor authentication enforcement. Multifactor authentication greatly lowers the risk of credential theft and unauthorized access.

- Consider using [service principals](/azure/active-directory/develop/app-objects-and-service-principals) for non-interactive resource sign-ins, so multifactor authentication and token refreshes won't affect operations.

- Use Azure AD managed identities for Azure resources to avoid credential-based authentication. Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

- Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) for just-in-time access to all infrastructure as a service (IaaS) resources. Defender for Cloud lets you enable network-level protection for ephemeral user access to IaaS virtual machines.

### Privileged Identity Management (PIM)

- Use Azure AD [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to establish zero-trust and least privilege access. Map your organization's roles to the minimum access levels needed. Azure AD PIM can use Azure native tools, extend current tools and processes, or use both current and native tools as needed.

- Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations already have an access review process in place.

- Use privileged identities for automation runbooks that require elevated access permissions. Use the same tools and policies to govern automated workflows that access critical security boundaries as you use to govern users of equivalent privilege.

### RBAC recommendations

- Use [Azure RBAC](/azure/role-based-access-control/overview) to manage data plane access to resources, if possible. Examples of data plane endpoints are Azure Key Vault, a storage account, or an SQL Database.

- Don't add users directly to Azure resource scopes. Direct user assignments circumvent centralized management, making it more difficult to prevent unauthorized access to restricted data. Instead, add users to defined roles, and assign the roles to resource scopes.

- Use [Azure AD built-in roles](/azure/role-based-access-control/built-in-roles) to manage the following identity settings:

   | Role | Usage | Note
   |---|---|---|
   | Global Admin | | Don't assign more than five people to this role.
   | Hybrid Environment | Hybrid Identity Administrator | |
   | Authentication | Security Administrator | |
   | Enterprise Application or Application Proxy | Application Administrator | No consent global admin.|

- If the Azure built-in roles don't meet your organization's specific needs, you can create your own custom roles. Consider the following key role definitions when you create custom roles within the Azure AD tenant. The wildcard \* under `Actions` means the principal assigned to this role can do all actions. The actions under `NotActions` are subtracted from `Actions`.

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
