---
title: Private Link and DNS Integration at Scale
description: Learn how to integrate Azure Private Link for PaaS services with Azure Private DNS zones in hub-and-spoke network architectures.
author: JefferyMitchell
ms.author: jemitche
ms.date: 01/10/2025
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency2
---

# Private Link and DNS integration at scale

This article describes how to integrate Azure Private Link for platform as a service (PaaS) solutions that have Azure Private DNS zones in hub-and-spoke network architectures.

## Introduction

Many customers build their network infrastructure in Azure using the hub-and-spoke network architecture, where:

- Networking shared services, such as network virtual appliances (NVAs), ExpressRoute/VPN gateways, or DNS servers, deploy in the **hub** virtual network.
- **Spoke** virtual networks consume the shared services via virtual network peering.

In hub-and-spoke network architectures, application owners typically have an Azure subscription, which includes a virtual network (*a spoke*) that's connected to the *hub* virtual network. In this architecture, they can deploy their virtual machines and have private connectivity to other virtual networks or to on-premises networks via ExpressRoute or VPN.

A central NVA, like Azure Firewall, provides internet-outbound connectivity. Additionally, that device, combined with another service, like an [Azure Firewall DNS proxy](/azure/firewall/dns-details), that's in or near the hub is typically used to customize DNS forwarding.

Many application teams build their solutions by using a combination of Azure IaaS and PaaS resources. Some Azure PaaS services, such as Azure SQL Managed Instance, can be deployed in customer virtual networks. As a result, traffic stays private within the Azure network and is fully routable from on-premises.

But some Azure PaaS services, such as Azure Storage or Azure Cosmos DB, can't be deployed in a customer's virtual networks and are accessible over their public endpoint. In some cases, this configuration causes a contention with a customer's security policies. Corporate traffic might not allow the deployment or access of corporate resources, such as a SQL database, over public endpoints.

[Private Link][link-1] supports access to a [list of Azure services][link-2] over private endpoints, but it requires that you register those private endpoint records in a corresponding [private DNS zone][link-3].

This article describes how application teams can deploy Azure PaaS services in their subscriptions that are only accessible over private endpoints.

This article also describes how application teams can ensure that services automatically integrate with private DNS zones. They do the automation through Azure Private DNS, which removes the need to manually create or delete records in DNS.

## Private Link and DNS integration in hub-and-spoke network architectures

Private DNS zones are typically hosted centrally in the same Azure subscription where the hub virtual network deploys. This central hosting practice is driven by [cross-premises DNS name resolution][link-4] and other needs for central DNS resolution such as Windows Server Active Directory. In most cases, only networking and identity administrators have permissions to manage DNS records in the zones.

Application teams have permissions to create Azure resource in their own subscription. They don't have any permissions in the central networking connectivity subscription, which includes managing DNS records in the private DNS zones. This access limitation means that they don't have the ability to [create the DNS records required][link-4] when deploying Azure PaaS services with private endpoints.

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution and name resolution for Private Link resources via Azure Private DNS:

:::image type="content" source="./media/private-link-example-central-dns.png" alt-text="A diagram of a high-level architecture with central DNS resolution and name resolution for Private Link resources." lightbox="./media/private-link-example-central-dns.png" border="false":::

In the previous diagram, it's important to highlight that:

- On-premises DNS servers have conditional forwarders configured for each private endpoint public DNS zone, pointing to the DNS private resolver hosted in the hub virtual network.

- The DNS private resolver hosted in the hub virtual network uses the Azure-provided DNS (168.63.129.16) as a forwarder.
- The hub virtual network must be linked to the Private DNS zone names for Azure services, such as `privatelink.blob.core.windows.net`, as shown in the diagram.
- All Azure virtual networks use the DNS private resolver that's hosted in the hub virtual network.
- The DNS private resolver isn't authoritative for customer's corporate domains, like Active Directory domain names, because it's just a forwarder. The DNS private resolver should have outbound endpoint forwarders to the customer's corporate domains, pointing to the on-premises DNS servers (172.16.1.10 and 172.16.1.11) or DNS servers deployed in Azure that are authoritative for such zones.

> [!NOTE] 
> You can deploy a DNS private resolver in your hub virtual network alongside your ExpressRoute gateway. However, you must ensure that the resolution of public FQDNs is permitted and replies with a valid response via a DNS forwarding ruleset rule to the targeted DNS server. Some Azure services rely on the ability to resolve public DNS names to function. For more information, see [DNS forwarding ruleset rules](/azure/dns/private-resolver-endpoints-rulesets#rules).

While the previous diagram depicts a single hub-and-spoke architecture, customers might need to extend their Azure footprint across multiple regions to address resiliency, proximity, or data-residency requirements. In several scenarios, the same Private Link-enabled PaaS instance must be accessed through multiple private endpoints.

The following diagram shows a typical high-level architecture for enterprise environments that have central DNS resolution deployed in the hub (one for each region) where name resolution for Private Link resources is done via Azure Private DNS.

:::image type="content" source="./media/private-link-example-central-dns-multi-regions.png" alt-text="A diagram of a high-level architecture with central DNS resolution and name resolution for Private Link resources in multiple regions." lightbox="./media/private-link-example-central-dns-multi-regions.png" border="false":::

You should deploy multiple regional private endpoints associated to the PaaS instance, one in each region where clients exist. Enable Private Link and Private DNS zones for each region. When you work with PaaS services that have built-in disaster recovery capabilities, such as geo-redundant storage accounts and SQL database failover groups, you must have private endpoints in multiple regions.

This scenario requires manual maintenance and updates of the Private Link DNS record set in every region because there's currently no automated lifecycle management for these.

For other use cases, a single global private endpoint can be deployed, making it accessible to all clients by adding routing from the relevant regions to the single private endpoint in a single region. 

To enable resolution, and therefore connectivity, from on-premises networks to the `privatelink` private DNS zone and private endpoints, provision the appropriate DNS configuration, such as conditional forwarders, in the DNS infrastructure.

Two conditions that must be true for application teams to create any required Azure PaaS resources in their subscription:

- Central networking or central platform teams must ensure that application teams can only deploy and access Azure PaaS services via private endpoints.

- Central networking or central platform teams must ensure that when they create private endpoints, they set up how to handle the corresponding records. Set up the corresponding records so that they're automatically created in the centralized private DNS zone that matches the service being created.
- DNS records must follow the lifecycle of the private endpoint so that the records are automatically removed when the private endpoint is deleted.

> [!NOTE]
> Based on DNS resolution, if you need [FQDNs in network rules](/azure/firewall/fqdn-filtering-network-rules) for Azure Firewall and Azure Firewall policy, enable the Azure Firewall DNS proxy to use FQDNs in your network rules. Then the spoke virtual networks must change their DNS setting from the custom DNS server to the Azure Firewall DNS proxy. FQDNs in network rules allow you to filter outbound traffic with any TCP or UDP protocol, including NTP, SSH, and RDP. When you change the DNS settings of a spoke virtual network, you must reboot all VMs inside that virtual network.

The following sections describe how application teams enable these conditions by using [Azure Policy][link-10]. The example uses Azure Storage as the Azure service that application teams need to deploy. But the same principle applies to most [Azure services that support Private Link][link-2].

## Platform team configuration requirements

The platform team configuration requirements include creating the private DNS zones, setting up policy definitions, deploying policies, and setting up the policy assignments.

### Create private DNS zones

Create private DNS zones in the central connectivity subscription for the supported Private Link services. For more information, see [Azure private endpoint DNS configuration][link-4].

In this case, **Storage account with blob** is the example. It translates to creating a `privatelink.blob.core.windows.net` private DNS zone in the connectivity subscription.

![A screenshot that shows the private DNS zone in the connectivity subscription.][image-2]

### Create policy definitions

In addition to the private DNS zones, you also need to [create a set of custom Azure Policy definitions][link-5]. These definitions enforce the use of private endpoints and automate creating the DNS record in the DNS zone that you create:

1. The `Deny` public endpoint for PaaS services policy.

   This policy prevents users from creating Azure PaaS services with public endpoints.

   ![A screenshot that shows the public endpoint for all networks option selected.][image-3]

   Users receive an error message if they don't select the private endpoint when they create the resource.

   ![A screenshot that shows the error message that results from picking a public endpoint.][image-4]

   ![A screenshot that shows the full error details from picking a public endpoint.][image-5]

   The exact policy rule might differ between PaaS services. For Azure Storage accounts, the **networkAcls.defaultAction** property defines whether requests from public networks are allowed or not. In this case, set a condition to deny creating the **Microsoft.Storage/storageAccounts** resource type if the property **networkAcls.defaultAction** isn't `Deny`. The following policy definition shows the behavior:

   ```json
   {
     "mode": "All",
     "policyRule": {
       "if": {
         "allOf": [
           {
             "field": "type",
             "equals": "Microsoft.Storage/storageAccounts"
           },
           {
             "field": "Microsoft.Storage/storageAccounts/networkAcls.defaultAction",
             "notEquals": "Deny"
           }
         ]
       },
       "then": {
         "effect": "Deny"
       }
     }
   }
   ```

2. `Deny` the ability to create a private DNS zone with the `privatelink` prefix policy.

   Use a centralized DNS architecture with a conditional forwarder and private DNS zones hosted in the subscriptions managed by the platform team. It's necessary to prevent the application teams owners from creating their own Private Link private DNS zones and linking services into their subscriptions.

   Ensure that when your application team creates a private endpoint, the option to `Integrate with private DNS zone` is set to `No` in the Azure portal.

   ![A screenshot that shows the Integrate with private DNS zone option set to no in the Azure portal.][image-6]

   If you select `Yes`, Azure Policy prevents you from creating the private endpoint. In the policy definition, it denies the ability to create the **Microsoft.Network/privateDnsZones** resource type if the zone has the `privatelink` prefix. The following policy definition shows the `privatelink` prefix:

   ```json
   {
     "description": "This policy restricts creation of private DNS zones with the `privatelink` prefix",
     "displayName": "Deny-PrivateDNSZone-PrivateLink",
     "mode": "All",
     "parameters": null,
     "policyRule": {
       "if": {
         "allOf": [
           {
             "field": "type",
             "equals": "Microsoft.Network/privateDnsZones"
           },
           {
             "field": "name",
             "contains": "privatelink."
           }
         ]
       },
       "then": {
         "effect": "Deny"
       }
     }
   }
   ```

3. `DeployIfNotExists` policy to automatically create the required DNS record in the central private DNS zone.

    The following policy examples show two approaches for identifying which `privateDNSZoneGroup` is created on a private endpoint.

    The [first policy](#deployifnotexists-policy-for-groupid-only) relies on the `groupId` while the [second policy](#deployifnotexists-policy-for-groupid-and-privatelinkserviceid) uses both `privateLinkServiceId` and `groupID`. Use the [second policy](#deployifnotexists-policy-for-groupid-and-privatelinkserviceid) when `groupId` clashes or collides with another resource.

    For a list of the `groupId` for Private Link resources, see the subresources column in [What is a private endpoint?][link-14].

> [!TIP]
> Azure Policy built-in definitions are constantly being added, deleted, and updated. You should use built-in policies instead of managing your own policies, where available. Use the [AzPolicyAdvertizer][link-12] to find existing built-in policies that have the following name of 'xxx ... to use private DNS zones'. In addition, Azure Landing Zones (ALZ) has a policy initiative, [Configure Azure PaaS services to use private DNS zones][link-13], that contains built-in policies that are periodically updated. If a built-in policy isn't available for your situation, consider creating an idea on the `azure-policy` feedback site [Azure Governance Community][link-15] by following the [built-in policy proposals process on the Azure Policy GitHub repo][link-16].

#### DeployIfNotExists policy for groupId only

This policy triggers if you create a private endpoint resource that has a service-specific `groupId`. The `groupId` is the ID of the group obtained from the remote resource (service) that this private endpoint should connect to. It then triggers a deployment of a [`privateDNSZoneGroup`][link-6] within the private endpoint, which associates the private endpoint with the private DNS zone. In the example, the `groupId` for Azure Storage blobs is `blob`. For more information about the `groupId` for other Azure services, see the *Subresource* column in [Azure private endpoint DNS configuration][link-4]. When the policy finds the `groupId` in the private endpoint, it deploys a `privateDNSZoneGroup` within the private endpoint, and links it to the private DNS zone resource ID that's specified as the parameter. In the example, the private DNS zone resource ID is:

   `/subscriptions/<subscription-id>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net`

   The following code sample shows the policy definition:

   ```json
   {
     "mode": "Indexed",
     "policyRule": {
       "if": {
         "allOf": [
           {
             "field": "type",
             "equals": "Microsoft.Network/privateEndpoints"
           },
           {
             "count": {
               "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]",
               "where": {
                 "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]",
                 "equals": "blob"
               }
             },
             "greaterOrEquals": 1
           }
         ]
       },
       "then": {
         "effect": "deployIfNotExists",
         "details": {
           "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
           "roleDefinitionIds": [
             "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
           ],           
           "deployment": {
             "properties": {
               "mode": "incremental",
               "template": {
                 "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                 "contentVersion": "1.0.0.0",
                 "parameters": {
                   "privateDnsZoneId": {
                     "type": "string"
                   },
                   "privateEndpointName": {
                     "type": "string"
                   },
                   "location": {
                     "type": "string"
                   }
                 },
                 "resources": [
                   {
                     "name": "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]",
                     "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
                     "apiVersion": "2020-03-01",
                     "location": "[parameters('location')]",
                     "properties": {
                       "privateDnsZoneConfigs": [
                         {
                           "name": "storageBlob-privateDnsZone",
                           "properties": {
                             "privateDnsZoneId": "[parameters('privateDnsZoneId')]"
                           }
                         }
                       ]
                     }
                   }
                 ]
               },
               "parameters": {
                 "privateDnsZoneId": {
                   "value": "[parameters('privateDnsZoneId')]"
                 },
                 "privateEndpointName": {
                   "value": "[field('name')]"
                 },
                 "location": {
                   "value": "[field('location')]"
                 }
               }
             }
           }
         }
       }
     },
     "parameters": {
       "privateDnsZoneId": {
         "type": "String",
         "metadata": {
           "displayName": "privateDnsZoneId",
           "strongType": "Microsoft.Network/privateDnsZones"
         }
       }
     }
   }
   ```

#### DeployIfNotExists policy for groupId and privateLinkServiceId

This policy triggers if you create a private endpoint resource with a service-specific `groupId` and  `privateLinkServiceId`. The `groupId` is the ID of the group obtained from the remote resource (service) that this private endpoint should connect to. The `privateLinkServiceId` is the resource ID of the remote resource (service) this private endpoint should connect to. Then, trigger a deployment of a [`privateDNSZoneGroup`][link-6] within the private endpoint, which associates the private endpoint with the private DNS zone.

In the example, the `groupId` for Azure Cosmos DB (SQL) is `SQL` and the `privateLinkServiceId` must contain `Microsoft.DocumentDb/databaseAccounts`. For more information about the `groupId` and `privateLinkServiceId` for other Azure services, see the *Subresource* column in [Azure private endpoint DNS configuration][link-4]. When the policy finds `groupId` and `privateLinkServiceId` in the private endpoint, it deploys a `privateDNSZoneGroup` within the private endpoint. And it's linked to the private DNS zone resource ID that's specified as the parameter. The following policy definition shows the private DNS zone resource ID:

   `/subscriptions/<subscription-id>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com`

   The following code sample shows the policy definition:

   ```json
   {
     "mode": "Indexed",
     "policyRule": {
       "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Network/privateEndpoints"
          },
          {
            "count": {
              "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*]",
              "where": {
                "allOf": [
                  {
                    "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].privateLinkServiceId",
                    "contains": "Microsoft.DocumentDb/databaseAccounts"
                  },
                  {
                    "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]",
                    "equals": "[parameters('privateEndpointGroupId')]"
                  }
                ]
              }
            },
            "greaterOrEquals": 1
          }
        ]
      },
       "then": {
         "effect": "[parameters('effect')]",
         "details": {
           "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
           "roleDefinitionIds": [
             "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
           ],           
           "deployment": {
             "properties": {
               "mode": "incremental",
               "template": {
                 "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                 "contentVersion": "1.0.0.0",
                 "parameters": {
                   "privateDnsZoneId": {
                     "type": "string"
                   },
                   "privateEndpointName": {
                     "type": "string"
                   },
                   "location": {
                     "type": "string"
                   }
                 },
                 "resources": [
                   {
                     "name": "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]",
                     "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
                     "apiVersion": "2020-03-01",
                     "location": "[parameters('location')]",
                     "properties": {
                       "privateDnsZoneConfigs": [
                         {
                           "name": "cosmosDB-privateDnsZone",
                           "properties": {
                             "privateDnsZoneId": "[parameters('privateDnsZoneId')]"
                           }
                         }
                       ]
                     }
                   }
                 ]
               },
               "parameters": {
                 "privateDnsZoneId": {
                   "value": "[parameters('privateDnsZoneId')]"
                 },
                 "privateEndpointName": {
                   "value": "[field('name')]"
                 },
                 "location": {
                   "value": "[field('location')]"
                 }
               }
             }
           }
         }
       }
     },
     "parameters": {
        "privateDnsZoneId": {
          "type": "String",
          "metadata": {
            "displayName": "Private Dns Zone Id",
            "description": "The private DNS zone to deploy in a new private DNS zone group and link to the private endpoint",
            "strongType": "Microsoft.Network/privateDnsZones"
          }
        },
        "privateEndpointGroupId": {
          "type": "String",
          "metadata": {
            "displayName": "Private Endpoint Group Id",
            "description": "A group Id for the private endpoint"
          }
        },
        "effect": {
          "type": "String",
          "metadata": {
            "displayName": "Effect",
            "description": "Enable or disable the execution of the policy"
          },
          "allowedValues": [
            "DeployIfNotExists",
            "Disabled"
          ],
          "defaultValue": "DeployIfNotExists"
        }
     }
   }
   ```

### Policy assignments

After policy definitions are deployed, [assign the policies][link-7] at the desired scope in your management group hierarchy. Ensure that the policy assignments target the Azure subscriptions the application teams use to deploy PaaS services with private endpoint access exclusively.

> [!IMPORTANT]
> In addition to [assigning the roleDefinition][link-11] defined in the policy, assign the [Private DNS Zone Contributor role][link-8] to the [managed identity created by the `DeployIfNotExists` policy assignment][link-9]. This role should be assigned in the subscription and resource group where the private DNS zones are hosted. The managed identity creates and manages the private endpoint DNS record in the private DNS zone. This configuration is necessary because the private endpoint is located in the application owner Azure subscription, while the private DNS zone is located in a different subscription, such as a central connectivity subscription.

After the platform team finishes the configuration:

* The applications teams' Azure subscriptions are ready for the team to create Azure PaaS services that have exclusive private endpoint access.

* The team must ensure that the DNS records for private endpoints are automatically registered to the corresponding private DNS zones, and that the DNS records are removed after a private endpoint is deleted.

## Application owner deploys an Azure PaaS service

After the platform team deploys the platform infrastructure components (private DNS zones and policies), the application owner does the following steps when they try to deploy an Azure PaaS service into the Azure subscription. These steps are the same whether they do their activities through the Azure portal or other clients, such as PowerShell or CLI, because Azure policies govern their subscriptions.

1. Create a storage account through the Azure portal. In the **Basics** tab, choose the settings you want, provide a name for your storage account, and select **Next**.

   ![A screenshot that shows the Basics tab and options for creating your storage account in the Azure portal.][image-7]

2. In the networking tab, select **Private endpoint**. If you select an option other than **Private endpoint**, the Azure portal doesn't allow you to create the storage account in the **Review + create** section of the deployment wizard. The policy prevents you from creating this service if the public endpoint is enabled.

   ![A screenshot that shows the Networking tab and the private endpoints option.][image-8]

3. It's possible to create the private endpoint now or after you create the storage account. This example shows creating the private endpoint after the storage account is created. Select **Review + create** to complete the step.

4. After you create the storage account, make a private endpoint through the Azure portal.

   ![A screenshot that shows the private endpoints settings.][image-9]

5. In the **Resource** section, locate the storage account you created in the previous step. Under target subresource, select **Blob**, and then select **Next**.

   ![A screenshot that shows the Resources tab for selecting the target subresource.][image-10]

6. In the **Configuration** section, after selecting your virtual network and subnet, be sure that **Integrate with private DNS zone** is set to **No**. Otherwise, the Azure portal prevents you from creating the private endpoint. Azure Policy won't allow you to create a private DNS zone with the `privatelink` prefix.

   ![A screenshot that shows the Configuration tab for setting the integrate with private DNS zone option to no.][image-11]

7. Select **Review + create**, and then select **Create** to deploy the private endpoint.

8. After a few minutes, the `DeployIfNotExists` policy triggers. The subsequent `dnsZoneGroup` deployment then adds the required DNS records for the private endpoint in the centrally managed DNS zone.

9. After you create the private endpoint, select it, and review its FQDN and private IP:

   ![A screenshot that shows where to review the private endpoint, FQDN, and private IP.][image-12]

10. Check the activity log for the resource group where the private endpoint was created. Or you can check the activity log of the private endpoint itself. After a few minutes, a `DeployIfNotExist` policy action runs, which configures the DNS zone group on the private endpoint:

    ![A screenshot that shows the activity log for the resource group and the private endpoint.][image-13]

11. If the central networking team goes to the `privatelink.blob.core.windows.net` private DNS zone, they confirm that the DNS record is there for the private endpoint that you created, and both the name and IP address match the values within the private endpoint.

    ![A screenshot that shows the private DNS zone and where to confirm that the DNS record exists.][image-14]

At this point, application teams can use the storage account through a private endpoint from any virtual network in the hub-and-spoke network environment and from on-premises. The DNS record has been automatically recorded in the private DNS zone.

If an application owner deletes the private endpoint, the corresponding records in the private DNS zone are automatically removed.

> [!IMPORTANT]
> You can still create private endpoints in your infrastructure as code tooling. But if you use the `DeployIfNotExists` policy approach in this article, you shouldn't integrate DNS in your code. The `DeployIfNotExists` policies that have the required RBAC to the private DNS zones manage the DNS integration.

## Next steps

- [DNS for on-premises and Azure resources](./dns-for-on-premises-and-azure-resources.md)
- [Use Azure Bastion for virtual machine remote access](./plan-for-virtual-machine-remote-access.md)
- [Quickstart: Create a private endpoint by using Bicep](/azure/private-link/create-private-endpoint-bicep).
- Create a private endpoint by using the [azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) resource in the Terraform Registry.






[link-1]: /azure/private-link/private-link-overview
[link-2]: /azure/private-link/availability
[link-3]: /azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration
[link-4]: /azure/private-link/private-endpoint-dns
[link-5]: /azure/governance/policy/tutorials/create-custom-policy-definition
[link-6]: /azure/templates/microsoft.network/privateendpoints/privatednszonegroups
[link-7]: /azure/governance/policy/assign-policy-portal
[link-8]: /azure/dns/dns-protect-private-zones-recordsets
[link-9]: /azure/governance/policy/how-to/remediate-resources
[link-10]: /azure/governance/policy/overview
[link-11]: /azure/governance/policy/how-to/remediate-resources#configure-policy-definition
[link-12]: https://www.azadvertizer.net/azpolicyadvertizer_all.html#%7B%22col_3%22%3A%7B%22flt%22%3A%22to%20use%20private%20DNS%20zones%22%7D%7D
[link-13]: https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-Private-DNS-Zones.html
[link-14]: /azure/private-link/private-endpoint-overview#private-link-resource
[link-15]: https://feedback.azure.com/d365community/forum/675ae472-f324-ec11-b6e6-000d3a4f0da0
[link-16]: https://github.com/Azure/azure-policy#new-built-in-policy-proposals
[image-2]: ./media/create-private-dns-zones.jpg
[image-3]: ./media/create-storage-account-blob.jpg
[image-4]: ./media/validation.jpg
[image-5]: ./media/validation-error-detail.jpg
[image-6]: ./media/private-dns-integration.jpg
[image-7]: ./media/create-storage-account.jpg
[image-8]: ./media/private-link-network-private.jpg
[image-9]: ./media/create-private-endpoint.jpg
[image-10]: ./media/create-private-endpoint-resources.jpg
[image-11]: ./media/create-private-endpoint-configuration.jpg
[image-12]: ./media/private-endpoint-ip-fqdn.jpg
[image-13]: ./media/private-endpoint-activity-log.jpg
[image-14]: ./media/private-dns-zones.png
