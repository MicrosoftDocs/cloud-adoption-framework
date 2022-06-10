---
title: Azure Identity Landing Zones
description: Understand how to implement identity within a landing zone.
author: anlucen
ms.author: doalle
ms.date: 06/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Prerequisites for a landing zone - design considerations

Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server on premises or in the cloud, or Azure AD Domain Services (Azure AD DS) in the cloud.

## Role-based access control (RBAC) design considerations

- For built-in RBAC roles the free version of Azure Active Directory can be used, but for custom roles Azure AD Premium P1 is required. [Overview of Azure Active Directory role-based access control (RBAC)](/azure/role-based-access-control/overview#:~:text=Azure%20role-based%20access%20control%20%28Azure%20RBAC%29%20helps%20you,that%20provides%20fine-grained%20access%20management%20of%20Azure%20resources.)

- Limits exist for the number of custom roles and role assignments that you must consider when you lay down a framework around IAM and governance. For more information, see [Azure RBAC service limits](/azure/role-based-access-control/troubleshooting).

    - There's a limit of 4,000 role assignments per subscription.

    - There's a limit of 500 role assignments per management group.

    - A maximum of 30 Azure AD custom roles can be created in an Azure AD organization.

- Environments deployed in the Classic deployment model should be migrated to the Azure Resource Manager (ARM) model. Understand that virtual machines and virtual networks cannot be migrated from the Classic model to the Resource Manger model and that automated scripts need to be updated to accommodate the new schema. Guidance can be found in this link: [Migrate from classic to Resource Manager](/azure/azure-resource-manager/management/deployment-models#migrate-from-classic-to-resource-manager)

- For Azure Classic Subscription Administrator roles, the Account Administrator has the Service Administrator attached by default. Both of these roles together provide the ability to manage the billing for Azure resources as well as the resources themselves. To separate the duties properly, you can transfer the ownership of the Services Administrator to another account. However, since the Service Administrator has the same function as the Owner Azure role, you can consider removing the Service Administrator role and keeping the RBAC as best practice to manage access to Azure resources. For further information, please see [Changing the Service Administrator role](/azure/role-based-access-control/classic-administrators#change-the-service-administrator)

## Managed Identities - design considerations

- Evaluate using Managed Identities for Azure resources that don’t need to manage credentials. There are two options: system-assigned or user-assigned managed identity. See this link for more information [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview)

- Consider reading this [guidance](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations) for choosing the right identities (user- assigned or system-assigned) option based on your scenario.

- Verify which Azure resources are supported by this feature [Azure Services with managed identities support](/azure/active-directory/managed-identities-azure-resources/managed-identities-status).

- Managed Identity can be used by applications that need to be authenticated against an Azure service. Verify which services support Azure AD authentication [Azure Ad auth Services](/azure/active-directory/managed-identities-azure-resources/services-azure-active-directory-support).

- System-assigned is part of the solution that can be configured to login into a VM using Azure Ad authentication. See this link for more information [VM Sign-in Azure](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows)

- Service Principal with Managed Identities can be easy to confuse in how is used getting access to Azure Resources. See this article for further analysis [SP vs MSI](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities/)

- Transferring resources to another Azure AD Subscriptions, for user-assigned or system-assigned cannot be updated automatically. It needs to move this manually.

- Which tasks and functions should the organization control with managed identities?

- Which services or applications within your landing zone support Azure Active Directory authentication?

## Landing zones - design recommendations

- Use [Azure RBAC](/azure/role-based-access-control/overview) to manage data-plane access to resources, where possible. Examples are Azure Key Vault, a storage account, or an SQL database.

- Deploy Azure AD conditional-access policies for any user with rights to Azure environments. Doing so provides another mechanism to help protect a controlled Azure environment from unauthorized access.

    - If authentication originates from outside of Azure, please check the information about any limitation on this link: [Custom controls CA](/azure/active-directory/conditional-access/controls)

- Enforce multifactor authentication for any user with rights to the Azure environments. Multifactor authentication enforcement is a requirement of many compliance frameworks. It greatly lowers the risk of credential theft and unauthorized access.

    - Consider using service principles for non-interactive resource logins so that MFA and token refreshes will not affect the operation.

- Don't add users directly to Azure resource scopes. Instead add users to defined roles, which are then assigned to resource scopes. Direct user assignments circumvent centralized management, greatly increasing the management required to prevent unauthorized access to restricted data.

Use custom role definitions within the Azure AD tenant while you consider the following key roles:

   | Role | Usage | Actions | No actions |
   |---|---|---|---|
   | Azure platform owner (such as the built-in Owner role)               | Management group and subscription lifecycle management                                                           | `*`                                                                                                                                                                                                                  |                                                                                                                                                                                         |
   | Network management (NetOps)        | Platform-wide global connectivity management: virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others            | `*/read`, `Microsoft.Network/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Support/*`                            |                                                                                                                                                                               |
   | Security operations (SecOps)       | Security Administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy | `*/read`, `*/register/action`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`, `Microsoft.PolicyInsights/*`, `Microsoft.Authorization/policyAssignments/*`, `Microsoft.Authorization/policyDefinitions/*`, `Microsoft.Authorization/policyExemptions/*`, `Microsoft.Authorization/policySetDefinitions/*`, `Microsoft.Insights/alertRules/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Security/*`, `Microsoft.Support/*` |                                                                            |
   | Subscription owner                 | Delegated role for subscription owner generated from subscription Owner role                                       | `*`                                                                                                                                                                                                                  | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`, `Microsoft.Network/expressRouteCircuits/*`, `Microsoft.Network/routeTables/write`, `Microsoft.Network/vpnSites/*` |
   | Application owners (DevOps/AppOps) | Contributor role granted for application/operations team at resource group level                                 | `*`                                                                                                                                                                                                                   | `Microsoft.Authorization/*/write`, `Microsoft.Network/publicIPAddresses/write`, `Microsoft.Network/virtualNetworks/write`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`                                         |

- [Azure Ad roles built-in](/azure/role-based-access-control/built-in-roles) suggestions to manage the Identity settings:

| Role | Usage | Note
|---|---|---|
| Global Admin | | It is recommended to not have more than 5 people assigned in this role
| Hybrid Environment | Hybrid Identity Administrator | |
| Authentication | Security Administrator | |
| Enterprise application/Application Proxy | Application Administrator | No consent global admin |

- Use Azure AD-managed identities for Azure resources to avoid authentication based on usernames and passwords. Many security breaches of public cloud resources originate with credential theft embedded in code or other text sources. For this reason, enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

- Use Microsoft Defender for Cloud just-in-time access for all infrastructure as a service (IaaS) resources. Doing so lets you enable network-level protection for ephemeral user access to IaaS virtual machines.

- Use Azure [AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to establish zero-standing access and least privilege. Map your organization's roles to the minimum level of access needed. Azure AD PIM can:

     - Be an extension of current tools and processes

     - Use Azure native tools as outlined

     - Use both as needed

- Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks. As a result, many organizations will already have a process in place to address this requirement.

- Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies users of equivalent privilege are.

## Identity and access management in the Azure landing zone accelerator

Identity and access management are core features of the Azure landing zone accelerator implementation. The deployment includes a subscription dedicated to identity, where customers can deploy the Active Directory domain controllers required for their environment.

The implementation also includes options to assign recommended policies to govern identity and domain controllers. Additionally, it could create a virtual network and connect to the hub via VNET peering.
