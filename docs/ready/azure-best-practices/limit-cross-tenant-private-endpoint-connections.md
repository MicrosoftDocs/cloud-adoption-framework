---
title: Limit cross-tenant private endpoint connections in Azure
description: Learn how to limit cross-tenant private endpoint connections to prevent data leakage and meet security and compliance goals.
author: MarvinBuss
ms.author: mabuss
ms.date: 09/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Limit cross-tenant private endpoint connections in Azure

Customers are increasingly using private endpoints in their tenants to connect to their Azure platform as a service (PaaS) services privately and securely. Private endpoints can connect to services across Azure Active Directory (Azure AD) tenants. For security and compliance, you might need to block cross Azure AD tenants connections on your private endpoints. This guidance shows you recommended configuration options to limit or prevent cross-tenant private endpoint connections. These options can help you create data leakage prevention (DLP) controls inside your Azure environment.

## Introduction

Private endpoints can be used to control the traffic within your Azure environment using an existing network perimeter. However, there are scenarios where you need to ensure that private endpoint connections are kept within the corporate Azure AD tenant only. The following examples show connections that can create security risks.

- **Connection A:** A rogue administrator creates private endpoints on the customer virtual network. These endpoints are linked to services that are hosted outside the customer environment, like another Azure AD tenant.
- **Connection B:** A rogue administrator creates private endpoints in other Azure AD tenants that are linked to services hosted in the customers Azure AD tenant.

![Diagram that shows cross-tenant private endpoint connection scenarios.](./media/cross-tenant-pe-provisioning.png)

*Figure 1: Illustration of private endpoint cross-tenant scenarios.*

For both scenarios, it's as simple as specifying the resource ID of the service and manually approving the private endpoint connection. The user also requires some role-based access control (RBAC) access to execute these actions.

The following information gives you options to prevent the provisioning of private endpoints across Azure AD tenants.

## Deny private endpoints linked to services in other tenants

**Scenario one**: a rogue administrator requires the following rights in a subscription in the customers Azure AD tenant.

- **Microsoft.Network/virtualNetworks/join/action** rights on a subnet with **privateEndpointNetworkPolicies** set to **Disabled**.
- **Microsoft.Network/privateEndpoints/write** access to a resource group in the customer environment.

With these rights, a rogue administrator can create a private endpoint in the customers Azure AD tenant. This private endpoint is linked to a service in a separate subscription and Azure AD tenant. This scenario is illustrated in Figure 1 as connection A.

For this scenario, the user sets up an external Azure AD tenant and Azure subscription. Next, the private endpoint is created in the customer environment by manually specifying the resource ID of the service. Finally, the rogue administrator approves the private endpoint on the linked service hosted in the external Azure AD tenant to allow traffic over the connection.

Once the rogue administrator approves the private endpoint connection, corporate data could be copied from the corporate virtual network to an Azure service on an external Azure AD tenant. This security risk can only occur if access was granted using Azure RBAC.

### Mitigation for scenario one

Use the following [Azure policy](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/PrivateEndpoint/params.policyDefinition.Deny-PrivateEndpoint-PrivateLinkServiceConnections.json) to automatically deny the creation of a private endpoint in the corporate Azure AD tenant that's linked to an outside Azure service.

```json
"if": {
    "allOf": [
        {
            "field": "type",
            "equals": "Microsoft.Network/privateEndpoints"
        },
        {
            "anyOf": [
                {
                    "count": {
                        "field": "Microsoft.Network/privateEndpoints/manualprivateLinkServiceConnections[*]",
                        "where": {
                            "allOf": [
                                {
                                    "field": "Microsoft.Network/privateEndpoints/manualprivateLinkServiceConnections[*].privateLinkServiceId",
                                    "notEquals": ""
                                },
                                {
                                    "value": "[split(concat(first(field('Microsoft.Network/privateEndpoints/manualprivateLinkServiceConnections[*].privateLinkServiceId')), '//'), '/')[2]]",
                                    "notEquals": "[subscription().subscriptionId]"
                                }
                            ]
                        }
                    },
                    "greaterOrEquals": 1
                },
                {
                    "count": {
                        "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*]",
                        "where": {
                            "allOf": [
                                {
                                    "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].privateLinkServiceId",
                                    "notEquals": ""
                                },
                                {
                                    "value": "[split(concat(first(field('Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].privateLinkServiceId')), '//'), '/')[2]]",
                                    "notEquals": "[subscription().subscriptionId]"
                                }
                            ]
                        }
                    },
                    "greaterOrEquals": 1
                }
            ]
        }
    ]
},
"then": {
    "effect": "Deny"
}
```

This policy denies any private endpoints created outside of the subscription of the linked service, like connections A and D. The policy also provides the flexibility to use *manualprivateLinkServiceConnections* and *privateLinkServiceConnections*.

You can update this policy so private endpoints can only be created in a certain set of subscriptions. This change can be done by adding a `list` parameter and by using the `"notIn": "[parameters('allowedSubscriptions')]"` construct. However, this approach isn't recommended, as it means that you would have to constantly maintain the list of subscriptions for this policy. Whenever a new subscription gets created inside your tenant, the subscription ID must be added to the parameter.

We recommend assigning the policy to the top-level management group, and then use exemptions where required.

### Considerations for scenario one

This policy blocks the creation of private endpoints that are in a different subscription than the service itself. If these endpoints are a requirement for certain use cases, we recommend using policy exemptions. Create more policies for Data Factory and Azure Synapse to make sure that managed private endpoints hosted on the managed virtual network can only connect to services hosted within your Azure AD tenant.

## Deny connections from private endpoints created in other tenants

**Scenario two**: a rogue administrator requires **write** rights on the service in the customer environment for which a private endpoint should be created.

With this right, a rogue administrator has the possibility to create a private endpoint in an external Azure AD tenant and subscription. This endpoint is linked to a service in the customer’s Azure AD tenant. This scenario is illustrated in Figure 1 as connection B.

In this scenario, the rogue administrator needs to first set up an external private Azure AD tenant and Azure subscription. Next, they create a private endpoint in their environment by manually specifying the resource ID and group ID of the service in the corporate Azure AD tenant. Finally, they approve the private endpoint on the linked service to allow traffic over the connection across Azure AD tenants.

Once the private endpoint is approved by the rogue administrator or service owner, data can be accessed from the external virtual network.

### Mitigation for scenario two

Use service-specific policies to prevent this scenario across the customer tenant. Private endpoint connections are subresources of the respective services and show up under their properties section. Noncompliant connections can be denied by using the following [policy definition](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/Storage/params.policyDefinition.Deny-Storage-PrivateEndpointConnections.json):

```json
"if": {
    "allOf": [
        {
            "field": "type",
            "equals": "Microsoft.Storage/storageAccounts/privateEndpointConnections"
        },
        {
            "field": "Microsoft.Storage/storageAccounts/privateEndpointConnections/privateLinkServiceConnectionState.status",
            "equals": "Approved"
        },
        {
            "anyOf": [
                {
                    "field": "Microsoft.Storage/storageAccounts/privateEndpointConnections/privateEndpoint.id",
                    "exists": false
                },
                {
                    "value": "[split(concat(field('Microsoft.Storage/storageAccounts/privateEndpointConnections/privateEndpoint.id'), '//'), '/')[2]]",
                    "notEquals": "[subscription().subscriptionId]"
                }
            ]
        }
    ]
},
"then": {
    "effect": "Deny"
}
```

This policy shows an example for Azure Storage. The same policy definition should be replicated for other services like [Key Vault](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/KeyVault/params.policyDefinition.Deny-KeyVault-PrivateEndpointConnections.json), [Cognitive Services](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/CognitiveServices/params.policyDefinition.Deny-CognitiveServices-PrivateEndpointConnections.json), and [SQL Server](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/Sql/params.policyDefinition.Deny-Sql-PrivateEndpointConnections.json). To further improve manageability, we suggest bundling the service-specific policies into an initiative. The policy denies the approval of private endpoint connections to private endpoints that are hosted outside of the subscription of the respective service. It doesn't deny the rejection or removal of private endpoint connections, which is the behavior customers want. Auto-approval workflows, such as connection C, aren't affected by this policy.

However, the approval of compliant private endpoint connections within the portal is blocked with this method. This block occurs because the portal UI doesn't send the resource ID of the connected private endpoint in their payload. We advise you to use [Azure Resource Manager](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/Storage/SampleDeployPrivateEndpointConnection), [Azure PowerShell](/powershell/module/az.network/approve-azprivateendpointconnection?view=azps-6.3.0), or [Azure CLI](/cli/azure/network/private-link-service/connection#az_network_private_link_service_connection_update) to approve the private endpoint connection.

We also recommend assigning the policy to the top-level management group and use exemptions where required.

### Considerations for scenario two

Managed virtual networks and managed private endpoints have been introduced in Azure Synapse Analytics and Azure Data Factory. Because of  these new capabilities, the policy will block the secure and private usage of these services.

We recommend the use of an **Audit** effect instead of a **Deny** affect in the policy definition used in the [scenario two mitigation](#mitigation-for-scenario-two). This effect change can help you keep track of private endpoints being created in separate subscriptions and tenants. You can also use policy exemptions for the respective data platform scopes.

#### Azure Data Factory

To overcome [scenario one](#deny-private-endpoints-linked-to-services-in-other-tenants) on the managed virtual network of Data Factory, use the following [policy definition](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/DataFactory/params.policyDefinition.Deny-DataFactory-ManagedPrivateEndpoints.json):

```json
"if": {
    "allOf": [
        {
            "field": "type",
            "equals": "Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints"
        },
        {
            "anyOf": [
                {
                    "field": "Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints/privateLinkResourceId",
                    "exists": false
                },
                {
                    "value": "[split(field('Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints/privateLinkResourceId'), '/')[2]]",
                    "notEquals": "[subscription().subscriptionId]"
                }
            ]
        }
    ]
},
"then": {
    "effect": "[parameters('effect')]"
}
```

This policy denies managed private endpoints that are linked to services that are hosted outside the subscription of the data factory. You can change this policy to allow connections to services hosted in a set of subscriptions by adding a `list` parameter and by using the `"notIn": "[parameters('allowedSubscriptions')]"` construct. We recommend this change for the data platform scope inside the tenant or environments where services with managed virtual networks and managed private endpoints are extensively used.

We recommend assigning this policy to the top-level management group and use exemptions where required. For the data platform, we recommend you make these changes and assign the policy to the set of data platform subscriptions.

#### Azure Synapse

Azure Synapse also uses managed virtual networks. We recommend applying a similar policy to the Data Factory policy for [scenario one](#deny-private-endpoints-linked-to-services-in-other-tenants). Azure Synapse doesn't provide a policy alias for managed private endpoints. However, there's a data exfiltration prevention feature, which can be enforced for workspaces using the following policy:

```json
"if": {
    "allOf": [
        {
            "field": "type",
            "equals": "Microsoft.Synapse/workspaces"
        },
        {
            "anyOf": [
                {
                    "field": "Microsoft.Synapse/workspaces/managedVirtualNetworkSettings.preventDataExfiltration",
                    "exists": false
                },
                {
                    "field": "Microsoft.Synapse/workspaces/managedVirtualNetworkSettings.preventDataExfiltration",
                    "notEquals": true
                },
                {
                    "count": {
                        "field": "Microsoft.Synapse/workspaces/managedVirtualNetworkSettings.allowedAadTenantIdsForLinking[*]",
                        "where": {
                            "field": "Microsoft.Synapse/workspaces/managedVirtualNetworkSettings.allowedAadTenantIdsForLinking[*]",
                            "notEquals": "[subscription().tenantId]"
                        }
                    },
                    "greaterOrEquals": 1
                }
            ]
        }
    ]
},
"then": {
    "effect": "Deny"
}
```

This policy enforces the use of the data exfiltration feature of Azure Synapse. With Azure Synapse, you can deny any private endpoint that's coming from a service that's hosted outside of the customer tenant. You can also deny any private endpoint hosted outside of a specified set of tenant IDs. This policy only allows the creation of managed private endpoints that are linked to services that are hosted in the customer tenant.

These policies are now available as built-in.

- Azure Synapse workspaces should allow outbound data traffic only to approved targets.

   Definition ID: /providers/Microsoft.Authorization/policyDefinitions/3484ce98-c0c5-4c83-994b-c5ac24785218

- Azure Synapse managed private endpoints should only connect to resources in approved Azure Active Directory tenants.

   Definition ID: “/providers/Microsoft.Authorization/policyDefinitions/3a003702-13d2-4679-941b-937e58c443f0”

We recommend that you assign the policy to the top-level management group and use exemptions where required.

## Next steps

It's important to understand the recommended connectivity models for inbound and outbound connectivity to and from the public internet. The next article reviews design considerations, design recommendations, and recommended content for further reading.

> [!div class="nextstepaction"]
> [Inbound and outbound connectivity](../enterprise-scale/network-topology-and-connectivity.md)
