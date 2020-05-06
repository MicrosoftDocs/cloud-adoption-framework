---
title: "Identity and access management"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - identity and access management
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

<!-- cSpell:ignore rkuehfus CAF -->

# B. Identity and access management

[![Identity and access management](./media/IAM.png "identity and access management")](./media/iam.png)

Figure 4: Identity and access management

This section will examine design considerations and recommendations surrounding identity and access management in an enterprise context.

## 1. Planning for access management

<!-- docsTest:ignore JML -->

Enterprise organizations will typically follow a least-privileged approach to operational access and this model should be expanded to consider Microsoft Azure through Azure Active Directory (AD) role-based access control (RBAC) and custom role definitions. It is critical to appropriately plan how to govern control plane and data plane access to resources in Azure while also fully aligning with joiner/mover/leaver processes.

**Design considerations:**

- There is a limit of 2000 custom RBAC role assignments per subscription.

- There is a limit of 500 custom RBAC role assignments per management group.

- Centralized versus federated resource ownership.
  - Shared resources such as the network will need to be managed centrally.

  - Managing application resources can be delegated to application teams.

- Custom role definitions can be used to map responsibility boundaries between central and application teams.

**Design recommendations:**

- Use Azure AD RBAC to manage data plane access to resources where possible (such as Key Vault, storage accounts, and Azure SQL Database).

- Use Azure AD Privileged Identity Management (PIM) to establish zero standing access.

- Use "Azure AD only" groups for Azure control plane resources in PIM when creating entitlements.

  - Add on-premises groups to the "Azure AD only" group if there is an existing group management system already in place.

- Use Azure AD PIM access reviews to periodically validate resource entitlements.

- Integrate Azure AD logs with Azure Log Analytics.

- Use custom RBAC role definitions within the Azure AD tenant while considering the following key roles:

<!-- cSpell:ignore NetOps SecOps DevOps/AppOps -->

|----------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Azure Platform Owner             | Management group and subscription lifecycle management                                                    | *                                                                                                                                                                                                                  |                                                                                                                                                                               |
| Network Management (NetOps)      | Platform-wide global connectivity management: VNets, UDRs, NSGs, NVAs, VPN, ER, etc.                       | */read, Microsoft.Authorization/*/write, Microsoft.Network/vpnGateways/*, Microsoft.Network/expressRouteCircuits/*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/*                              |                                                                                                                                                                               |
| Security Operations (SecOps)     | Security Administrator role with a horizontal view across the entire Azure estate and the KV Purge Policy | */read, */register/action, Resource Policy Contributor, Microsoft.KeyVault/locations/deletedVaults/purge/action Microsoft.Insights/alertRules/*, Microsoft.Authorization/policyDefinitions/*, Microsoft.Security/* |                                                                                                                                                                               |
| Subscription Owner               | Delegated role for Subscription Owner derived from Subscription Owner role                                | *                                                                                                                                                                                                                  | Microsoft.Authorization/*/write, Microsoft.Network/vpnGateways/*, Microsoft.Network/expressRouteCircuits/*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/* |
| Application Owners DevOps/AppOps | Contributor role granted for application/operations team at the resource group level                          |                                                                                                                                                                                                                    | Microsoft.Network/publicIPAddresses/write, Microsoft.Network/virtualNetworks/write, Microsoft.KeyVault/locations/deletedVaults/purge/action                                   |

- Use just-in-time for all IaaS resources to enable network level protection.

- Use Azure AD Managed Service Identities for Azure resources while avoiding username and password-based authentication.

- Use privileged identities for automation runbooks that require elevated access permissions.

<!-- -->

- Do not add users directly to Azure resource scopes.

## 2. Planning for authentication inside the landing zone

A critical design decision enterprise organization must make when adopting Azure is whether to extend and existing on-premises identity domain into Azure or create a brand new one. Requirements for authentication inside the "landing zone" should be thoroughly assessed and incorporated into plans to deploy Azure AD, Azure AD Domain Services (DS), or both.

**Design considerations:**

- Centralized and delegated responsibilities to manage resources deployed inside the "landing zone”.

- Capability and performance differences between Active AD and Azure AD Domain Services.

- Some Azure services such as HDInsight, Azure Files, and Windows Virtual Desktop rely on Azure AD DS.

- Handling of privileged operations, such as creating a service principal within the Azure AD tenant, registering graph applications inside Azure AD, and procuring a wildcard certificate.

- Azure AD proxy front-end authentication for applications relying on integrated Windows authentication (IWA), forms/header based authentication as well as rich client apps integrated with ADAL.

**Design recommendations:**

- Evaluate the compatibility of workloads for Azure AD and Azure AD DS.

- Deploy Azure AD DS within the primary region, as this service can be projected into only one subscription.

  - Use virtual network peering to support its usage as an authentication service.

- Use managed identities instead of service principles for authentication to Azure services.

- Use just-in-time access for both virtual machine access and Azure control plane administration.

<!-- -->

- Do not assume existing workloads are agnostic of Active Directory and Azure AD DS authentication, as there are differences between both approaches.

## Next steps

Suggested design for [management group and subscription organization](./c-management-group-and-subscription-organization.md).

> [!div class="nextstepaction"]
> [Management group and subscription organization](./c-management-group-and-subscription-organization.md)
