---
title: "Identity and Access Management"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF NorthStar landing zone - Identity and Access Management
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# B. Identity and Access Management

[![Identity and Access Management](./media/iam.png "Identity and Access Management")](./media/iam.png)

Figure 4 – Identity and Access Management

This section will examine design considerations and recommendations surrounding identity and access management in an enterprise context.

## 1. Planning for Access Management

Enterprise organisations will typically follow a least-privileged approach to operational access and this model should be expanded to consider Azure through AAD RBAC and custom role definitions. It is therefore critical to appropriately plan how to govern control plane and data plane access to resources in Azure, while also fully aligning with Joiner/Mover/Leaver (JML) processes.

***Design Considerations***

- There is a limit of 2000 custom RBAC role assignments per subscription.

- There is a limit of 500 custom RBAC role assignments per management group.

- Centralized versus federated resource ownership.

    - Shared resources such as the network will need managed centrally.

    - The management of application resources can be delegated to application teams.

- Custom role definitions can be used to map responsibility boundaries between central and application teams.

***Design Recommendations***

- Use AAD RBAC to manage data plane access to resources where possible (e.g. Key Vault, Storage Account, Azure SQL DB).

- Use AAD PIM to establish zero standing access.

- Use “AAD only” groups for Azure control plane resources in PIM when creating entitlements.

    - Add on-premise groups to the “AAD only” group if there is an existing group management system already in place.

- Use AAD PIM access reviews to periodically validate resource entitlements.

- Integrate Azure AD logs with Azure Log Analytics.

- Use Custom RBAC role definitions within the AAD tenant, considering the following key roles

| Role                             | Usage                                                                                                     | Actions:                                                                                                                                                                                                           | No Actions:                                                                                                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Azure Platform Owner             | Management Group and Subscription lifecycle management                                                    | *                                                                                                                                                                                                                  |                                                                                                                                                                               |
| Network Management (NetOps)      | Platform wide Global Connectivity management; VNets, UDRs, NSGs, NVAs, VPN, ER etc.                       | */read, Microsoft.Authorization/*/write, Microsoft.Network/vpnGateways/*, Microsoft.Network/expressRouteCircuits/*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/*                              |                                                                                                                                                                               |
| Security Operations (SecOps)     | Security Administrator role with a horizontal view across the entire Azure estate and the KV Purge Policy | */read, */register/action, Resource Policy Contributor, Microsoft.KeyVault/locations/deletedVaults/purge/action Microsoft.Insights/alertRules/*, Microsoft.Authorization/policyDefinitions/*, Microsoft.Security/* |                                                                                                                                                                               |
| Subscription Owner               | Delegated Role for Subscription Owner derived from subscription Owner role                                | *                                                                                                                                                                                                                  | Microsoft.Authorization/*/write, Microsoft.Network/vpnGateways/*, Microsoft.Network/expressRouteCircuits/*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/* |
| Application Owners DevOps/AppOps | Contributor role granted for application/operations team at resource group level                          |                                                                                                                                                                                                                    | Microsoft.Network/publicIPAddresses/write, Microsoft.Network/virtualNetworks/write, Microsoft.KeyVault/locations/deletedVaults/purge/action                                   |

- Use JIT for all IaaS Resources to enable network level protection.

- Use AAD Managed Service Identities (MSI) for Azure resources, avoiding username and password-based authentication.

- Use privileged identities for automation runbooks that require elevated access permissions.

<!-- -->

- Do not add users directly to Azure resource scopes.

## 2. Planning for Authentication Inside the landing zone

A critical design decision enterprise organisation must make when adopting Azure is whether to extend and existing on-premises identity domain into Azure or create a brand new one. Requirements for authentication inside the “landing zone” should therefore be thoroughly assessed and incorporated into plans to deploy AD, AAD-DS or both.

***Design Considerations***

- Centralized and delegated responsibilities to manage resources deployed inside the “landing zone”.

- Capability and performance differences between AD, AAD, and AAD Domain Services.

- There are some Azure services that rely on AAD-DS, such as HDInsight, Azure File Service, WVD.

- Handling of privileged operations, such as creating a Service Principal within the AAD tenant, Registering Graph applications inside AAD, and procuring a wildcard certificate.

- AAD Proxy frontend authentication for applications relying on Integrated Windows Authentication (IWA), Forms/Header based authentication as well as rich client apps integrated with ADAL.

***Design Recommendations***

- Evaluate the compatibility of workloads for AD and AAD-DS.

- Deploy AAD-DS within the primary region as this service can be projected into only one subscription.

    - Use Virtual Network Peering to support its usage as an authentication service.

- Use Manged Identities instead of Service Principles for authentication to Azure services.

- Use Just-In-Time access for both VM access and Azure control plane administration.

<!-- -->

- Do not assume existing workloads are agnostic of AD and AAD-DS authentication, as there are differences between both approaches.

## Next steps

Suggested design for [Management Group and Subscription Organization](./C-Management-Group-and-Subscription-Organization.md)

> [!div class="nextstepaction"]
> [Management Group and Subscription Organization](./C-Management-Group-and-Subscription-Organization.md)