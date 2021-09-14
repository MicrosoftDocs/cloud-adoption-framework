---
title: Limiting Cross-Tenant Private Endpoint Connections
description: Limiting Cross-Tenant Private Endpoint Connections
author: MarvinBuss
ms.author: mabuss
ms.date: 09/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Limiting Cross-Tenant Private Endpoint Connections

Customers are increasingly using private endpoints in their tenants to connect to their Azure PaaS services privately and securely. Some users are not aware of the fact that Private Endpoints can connect to services across Azure AD tenants. For compliance and security reasons, some customers require to block cross Azure AD tenants’ connections on their Private Endpoints.  This article describes recommended configuration options to limit or prevent cross-tenant private endpoint connections to help meet the data leakage prevention (DLP) controls inside your Azure environment.

## Introduction

Private Endpoints can be used to control the traffic within a customer’s Azure environment using an existing network perimeter, however there are scenarios where customers are required to ensure that private endpoint connections are kept within the corporate Azure AD tenant only. These scenarios are summarized below and arise  from the fact that a rogue admin could:

1. **Scenario 1** (represented as connection A in Figure 1): Create private endpoints on the customer virtual network, which are linked to services that are hosted outside the customer environment (another Azure AD tenant).
2. **Scenario 2** (represented as connection B in Figure 1): Create private endpoints in other Azure AD tenants that are linked to services hosted in the customers Azure AD tenant.

These two scenarios are depicted in figure 1 below:

![Cross-tenant private endpoint scenarios](./media/cross-tenant-pe-provisioning.png)

*Figure 1: Ilustration of private endpoint cross-tenant scenarios.*

For both scenarios, it is as simple as specifying the resource ID of the service and manually approving the private endpoint connection on the respective service. In addition, the user requires some RBAC access to execute these actions. This will be further described in the sections below.

The following sections on this article will describe options to prevent the provisioning of private endpoints across Azure AD tenants as explained on the respective scenarios mentioned above.

## Scenario 1: Deny private endpoints linked to services in other tenants

### Description

For the first scenario, a rogue admin requires the following rights in a subscription in the customers Azure AD tenant:

1. “Microsoft.Network/virtualNetworks/join/action” rights on a subnet with “privateEndpointNetworkPolicies” set to “Disabled” and
2. “Microsoft.Network/privateEndpoints/write” access to a resource group in the customer environment.

With these rights, a rogue admin has the possibility to create a private endpoint in the customers Azure AD tenant that is linked to a service in a separate subscription and Azure AD tenant. The scenario is illustrated in Figure 1 (represented as connection A).

To do so, the user first needs to setup an external Azure AD tenant and Azure subscription. As a next step, the private endpoint needs to be created in the customer environment, by manually specifying the resource id of the service. Finally, the rogue admin needs to approve the private endpoint on the linked service hosted in the external Azure AD tenant to allow traffic over the connection.

Once the private endpoint connection is approved by the rogue admin, corporate data could be copied over the corporate virtual network to an Azure service on an external Azure AD tenant (in case access was granted via Azure RBAC).

### Mitigation

Customers can use the [following Azure policy](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/PrivateEndpoint/params.policyDefinition.Deny-PrivateEndpoint-PrivateLinkServiceConnections.json), to automatically deny the creation of a private endpoint in the corporate Azure AD tenant which is linked to Azure services hosted outside the corporate Azure AD tenant:

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

The policy shown above denies any private endpoints being created outside of the subscription of the linked service (represented as connections A and D in Figure 1). The policy also provides the flexibility to use *manualprivateLinkServiceConnections* as well as *privateLinkServiceConnections*.

This policy can be updated so that private endpoints are only allowed to be created inside a certain set of subscriptions. This can be done by adding a parameter of type List and by using the `"notIn": "[parameters('allowedSubscriptions')]"` construct. However, this is not the recommended approach as this would mean that customers would have to constantly maintain the list of subscriptions for this policy. Whenever a new subscription gets created inside the customer tenant, the subscription ID would have to be added to the parameter.

It is recommended to assign the policy to the top-level management group and use exemptions where required.

### Considerations when assigning this policy definition

The policy shown above blocks the creation of private endpoints in a different subscription than the service itself (represented as connections A and D in Figure 1). If this is a requirement for certain use-cases, we recommend using policy exemptions.

## Scenario 2: Deny connections from private endpoints created in other tenants

### Description

For the second scenario, a rogue admin requires the following rights in the customer environment:

1. “*/write” rights on the service in the customer environment for which a private endpoint should be created.

With these rights, a rogue admin has the possibility to create a private endpoint in an external Azure AD tenant and subscription that is linked to a service in the customer’s Azure AD tenant. The scenario is illustrated in Figure 1 (represented as connection B).

On this scenario, the rogue admin needs to first setup an external private Azure AD tenant and Azure subscription. As a next step, a private endpoint needs to be created in the environment of the rogue admin, by manually specifying the resource id and group id of the service in the corporate Azure AD tenant. Finally, the rogue admin needs to approve the private endpoint on the linked service to allow traffic over the connection across Azure AD tenants.

Once the private endpoint is approved by the rogue admin or service owner, data can be accessed from the external virtual network.

### Mitigation

Service specific policies should be used to deny these scenarios across the customer tenant. Private endpoint connections are sub-resources of the respective services and therefore show up under their properties section. Incompliant connections can be denied using the [following policy definition (example for Azure Storage)](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/Storage/params.policyDefinition.Deny-Storage-PrivateEndpointConnections.json):

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

The policy above shows an example for Azure Storage. The same policy definition needs to be replicated for other services such as [Key Vault](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/KeyVault/params.policyDefinition.Deny-KeyVault-PrivateEndpointConnections.json), [Cognitive Services](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/CognitiveServices/params.policyDefinition.Deny-CognitiveServices-PrivateEndpointConnections.json), [SQL Server](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/Sql/params.policyDefinition.Deny-Sql-PrivateEndpointConnections.json) etc. In order to further improve manageability, it is suggested bundling the service specific policies into an Initiative. The policy denies the approval of private endpoint connections to private endpoints that are hosted outside of the subscription of the respective service. It does not deny the rejection or removal of private endpoint connections, which is the desired behavior of customers. Auto-approval workflows are also not affected by this policy (represented as connection C in Figure 1). However, the approval of compliant private endpoint connections within the portal is blocked with this method, because the portal UI does not send the resource ID of the connected private endpoint in their payload. Therefore, we are advising customers to use [ARM (storage example)](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/Storage/SampleDeployPrivateEndpointConnection), [Azure PowerShell](/powershell/module/az.network/approve-azprivateendpointconnection) or [Azure CLI](/cli/azure/network/private-link-service/connection#az_network_private_link_service_connection_update) for approving the private endpoint connection.

It is recommended to assign the policy to the top-level management group and use exemptions where required.

### Considerations when assigning this policy definition

With the introduction of managed virtual networks and managed private endpoints in Synapse and Data Factory, this policy is blocking the secure and private usage of these services. In general, this means that the development of (data) solutions on top of these services will be blocked across the tenant.

Therefore, we are recommending the use of an “Audit” effect instead of a “Deny” affect in the policy definition described in [Scenario 2 - Mitigation](#mitigation-1) of this article to keep track of private endpoints being created in separate subscriptions and tenants or to use policy exemptions for the respective data platform scopes. Additional policies must be created for Data Factory and Synapse to make sure managed private endpoints hosted on the managed virtual network can only connect to services hosted within the customers Azure AD tenant.

### Azure Data Factory

To overcome the [Scenario 1](#scenario-1-deny-private-endpoints-linked-to-services-in-other-tenants) on the managed virtual network of Data Factory, customers can use the [following policy definition](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/DataFactory/params.policyDefinition.Deny-DataFactory-ManagedPrivateEndpoints.json):

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

The policy shown above denies managed private endpoints that are linked to services that are hosted outside the subscription of the data factory. This policy can be changed to allow connections to services hosted in a set of subscriptions by adding a parameter of type List and by using the `"notIn": "[parameters('allowedSubscriptions')]"` construct. This change is recommended for the data platform scope inside the tenant or environments where services with managed virtual networks and managed private endpoints are extensively used.

It is recommended to assign the policy shown above to the top-level management group and use exemptions where required. For the data platform, it is recommended to make the changes mentioned above and assign the policy to the set of data platform subscriptions.

### Azure Synapse

Azure Synapse also uses managed virtual networks and therefore a similar policy to the one proposed for Data Factory must be applied to cover [Scenario 1](#scenario-1-deny-private-endpoints-linked-to-services-in-other-tenants). Azure Synapse does not provide a policy alias for managed private endpoints, but introduced a data exfiltration prevention feature, which can be enforced for workspaces via the following policy:

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

The policy above enforces the use of the data exfiltration feature of Synapse. Synapse also allows to deny any private endpoint that is coming from a service that is hosted outside of the customer tenant or a specified set of tenant ids. The policy above enforces exactly that and only allows the creation of managed private endpoints that are linked to services that are hosted in the customer tenant.

These policies are now available as built-in:

1. Azure Synapse workspaces should allow outbound data traffic only to approved targets

   Definition ID: /providers/Microsoft.Authorization/policyDefinitions/3484ce98-c0c5-4c83-994b-c5ac24785218

2. Synapse managed private endpoints should only connect to resources in approved Azure Active Directory tenants

   Definition ID: “/providers/Microsoft.Authorization/policyDefinitions/3a003702-13d2-4679-941b-937e58c443f0”

It is recommended to assign the policy to the top-level management group and use exemptions where required.
