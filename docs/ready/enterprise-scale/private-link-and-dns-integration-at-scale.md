---
title: Private Link and DNS integration at scale
description: Private Link and DNS integration at scale
author: JefferyMitchell
ms.author: jemitche
ms.date: 02/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---


# Private Link and DNS integration at scale

> This article describes how to integrate Azure Private Link for PaaS services with Azure Private DNS Zones in hub and spoke network architectures.

## Introduction

Many customers build their network infrastructure in Azure using the hub and spoke network architecture, where:

- Networking shared services (such as network virtual appliances, ExpressRoute/VPN gateways, or DNS servers) are deployed in the **hub** virtual network (VNet)
- **Spoke** VNets consume those shared services via VNet peering.

In hub and spoke network architectures, application owners are typically provided with an Azure subscription, which includes a VNet (a spoke) connected to the hub VNet. In this architecture, they can deploy their virtual machines and have private connectivity to other VNets or to on-premises networks via ExpressRoute or VPN.

Internet-outbound connectivity is provided via central Network Virtual Appliance (NVA), for example, Azure Firewall.

Many application teams build their solutions using a combination or Azure IaaS and PaaS resources. Some Azure PaaS services (such as SQL Managed Instance) can be deployed in customer VNets. As a result, traffic will stay private within the Azure network and would be fully routable from on-premises.

However, some Azure PaaS services (such as Storage or Cosmos DB) cannot be deployed in customer’s VNets and are accessible over their public endpoint.
In some instances, this can cause a contention with customers security policies as corporate traffic might not allow the deployment or accessing of corporate resources (such as a SQL database) over public endpoints.

[Azure Private Link][link-1] allows access to a [list][link-2] of Azure services over private endpoints, but it requires that those private endpoint records are registered in a corresponding [Private DNS Zone][link-3].

This article describes how application teams can deploy Azure PaaS services in their subscriptions which are only accessible over private endpoints.

This article will also describe how application teams can ensure that services are automatically integrated with Azure Private DNS Zones. Removing the need for manual creation or deletion of records in DNS.

## Private Link and DNS integration in hub and spoke network architectures

Azure Private DNS Zones are typically hosted centrally in the same Azure subscription where the hub VNet is deployed. This central hosting practice is driven by [cross-premises DNS name resolution][link-4] and other needs for central DNS resolution such as Active Directory. In most cases, only networking/identity admins have permissions to manage DNS records in these zones.

Application teams do have permissions to create Azure resource in their own subscription. They do not have any permissions in the central networking connectivity subscription, which includes managing DNS records in the Azure Private DNS Zones. This access limitation means they do not have the possibility to [create the DNS records required][link-4] when deploying Azure PaaS services with private endpoints.

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution and where name resolution for private link resources is done via Azure Private DNS Zones:

![image-1][image-1]

From the previous diagram, it is important to highlight that:

- On-premises DNS servers have conditional forwarders configured for each private endpoint [public DNS zone forwarder][link-3] pointing to the DNS forwarders (10.100.2.4 and 10.100.2.5) hosted in the HUB VNet.
- All Azure VNets have the DNS forwarders (10.100.2.4 and 10.100.2.5) configured as the primary and secondary DNS servers.

There are two conditions that must be true to allow application teams the freedom to create any Azure PaaS resources they want in their subscription:

- Central networking and/or central platform team must ensure that application teams can only deploy and access Azure PaaS services via private endpoints.
- Central networking and/or central platform teams must ensure that whenever private endpoints are created, the corresponding records are automatically created in centralized Azure Private DNS Zone that matches the service created.
  - DNS record needs to follow the lifecycle of the private endpoint and automatically remove the DNS record when the private endpoint is deleted.

The following sections describe how application teams can enable these conditions by using [Azure policy][link-10]. We will use Azure Storage as the Azure service that application teams need to deploy in our example below, but the same principle can be applied to most Azure services that [support][link-2] private link.

## Configuration required by platform team

### Create Private DNS zone(s)

Create Private DNS Zone(s) in the central connectivity subscription for the supported private link services as per [documentation][link-4].

In our case, as we will use **Storage account with blob** as our example, it translates to us creating a **privatelink.blob.core.windows.net** private DNS zone in the connectivity subscription.

![image-2][image-2]

### Policy definitions

In addition to the Private DNS zones, we also need to [create a set of custom Azure Policy definitions][link-5] to enforce the use of private endpoints and automate the DNS record creation in the DNS zone we created:

1. **Deny** public endpoint for PaaS services policy

   This policy will prevent users from creating Azure PaaS services with public endpoints and give them an error message if private endpoint is not selected at resource creation.

   ![image-3][image-3]

   ![image-4][image-4]

   ![image-5][image-5]

   The exact policy rule may differ between PaaS services. For Storage account specifically, we look at the **networkAcls.defaultAction** property that depicts whether requests from Public Network are allowed or not. In our case, we will set a condition to deny the creation of the **Microsoft.Storage/storageAccounts** resource type if the property **networkAcls.defaultAction** is not ‘Deny’. This policy definition is listed below:

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
             "notequals": "Deny"
           }
         ]
       },
       "then": {
         "effect": "Deny"
       }
     }
   }
   ```

2. **Deny** creation of private DNS Zone with the privatelink prefix policy

   Since we use a centralized DNS architecture with a conditional forwarder and private DNS zones hosted in the subscriptions managed by the platform team, we need to prevent the application teams owners from creating their own private link private DNS zones and linking services into their subscriptions.

   To accomplish this, we need to ensure that when application teams create a private endpoint, the option to “Integrate with private DNS zone” needs to be set to ‘No’ when using the Azure portal.

   ![image-6][image-6]

   If “Yes” is selected, Azure policy will prevent the creation of the Private Endpoint. In our policy definition, we will deny the creation of the **Microsoft.Network/privateDnsZones** resource type if the zone has the privatelink prefix. This policy definition is described below:

   ```json
   {
     "description": "This policy restrict creation Private DNS Zones with the private link prefix",
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
             "like": "privatelink*"
           }
         ]
       },
       "then": {
         "effect": "Deny"
       }
     }
   }
   ```

3. **DeployIfNotExists** policy to automatically create the required DNS record in the central Private DNS zone

   This policy will be triggered if a private endpoint resource is created with a service-specific **groupId**. The **groupId** is the id of the group obtained from the remote resource (service) that this private endpoint should connect to. We then trigger a deployment of a [privateDNSZoneGroup][link-6] within the private endpoint, which is used to associate the private endpoint with our Azure Private DNS zone. For our example, the **groupId** for Storage Blobs are “blob” (**groupId** for other Azure services can be found on [this][link-4] article, under the **Subresource** column). When policy finds that **groupId** in the Private Endpoint created, it will deploy a [privateDnsZoneGroup][link-6] within the private endpoint, and it will be linked to the Private DNS Zone resource ID that is specified as parameter. For our example, the Private DNS Zone resource id would be like:

   _/subscriptions/<subscription-id>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net_

   This policy definition is listed below:

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
             "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
           ],
           "existenceCondition": {
             "allOf": [
               {
                 "field": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups/privateDnsZoneConfigs[*].privateDnsZoneId",
                 "equals": "[parameters('privateDnsZoneId')]"
               }
             ]
           },
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
                     "name": "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]",
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

### Policy assignments

Once policy definitions have been deployed, [assign the policies][link-7] at the desired scope in your management group hierarchy. Ensure that the policy assignments target the Azure subscriptions that will be used by the application teams to deploy PaaS services with private endpoint access exclusively.

**IMPORTANT**
_Remember to assign the “[Private DNS Zone Contributor][link-8]” role in the subscription/resource group where the private DNS zones are hosted to the [managed identity created by the deployIfNotExists policy assignment][link-9] that will be responsible to create and manage the private endpoint DNS record in the Private DNS Zone. This is because the private endpoint is located in the application owner Azure subscription, while the Private DNS Zone is located in a different subscription (such as central connectivity subscription)._

Once the platform team finishes this configuration, Azure subscriptions from applications teams are ready for them to create Azure PaaS services with private endpoint access exclusively, and ensuring private endpoints DNS records are automatically registered (and removed once private endpoint is deleted) from corresponding Azure Private DNS Zones.

## App Owner experience

Once the platform team has deployed the platform infrastructure components (Azure Private DNS Zones and Azure Policies) described in the previous section, when an application owner tries to deploy an Azure PaaS service in his/her Azure subscription, application owner will have the following experience, which will be the same if they do activities via the Azure Portal or via other clients such as PowerShell or CLI, as their subscriptions are being governed by Azure policies.

1. Create a storage account through the Azure portal. In the basic tab, provide a name and your desired settings and click on Next.

   ![image-7][image-7]

2. In the networking section, ensure **Private endpoint** is selected. If an option other than Private endpoint is selected, the Azure portal will not allow the creation of the storage account in the **Review + create** section of the deployment wizard, as policy is preventing the creation of this service if the public endpoint is enabled.

   ![image-8][image-8]

3. It is possible to create the private endpoint on this screen or can be done after the storage account has been created. For this exercise, we will create the private endpoint after the storage account has been created. Click on **Review + create** and complete the creation of the storage account.

4. Once the storage account is created, create a private endpoint through the Azure portal

   ![image-9][image-9]

5. In the **Resource** section, locate the storage account created in the previous step, and for target subresource select blob, and then click on Next.

   ![image-10][image-10]

6. In the **Configuration** section, after selecting your VNet and subnet, ensure that the **Integrate with private DNS zone** is set to **No**. Otherwise, the Azure portal will prevent the creation of the private endpoint as Azure policy will not allow the creation of a private DNS Zone with the privatelink prefix.

   ![image-11][image-11]

7. Click on **Review + create** and click on **Create** to deploy the private endpoint.

8. After a few minutes, the **deployIfNotExists** policy will be triggered and the subsequent **dnsZoneGroup** deployment will add the required DNS records for the private endpoint in the centrally managed DNS zone.

9. Once the private endpoint has been created, select it, and review its FQDN and Private IP:

   ![image-12][image-12]

10. Check the activity log for the resource group where the private endpoint was created, or you can check the activity log of the private endpoint itself. You will notice that after a few minutes, a ‘**deployIfNotExist**’ Policy action is executed, which configures the DNS Zone Group on the Private endpoint:

    ![image-13][image-13]

11. If central networking team goes to the **privatelink.blob.core.windows.net** private DNS Zone, they will confirm that the DNS record has been created for the private endpoint we created, and both, the name and IP address match to the values within the private endpoint.

    ![image-14][image-14]

At this point, application teams can use the storage account via a private endpoint from any VNet in the hub & spoke network environment and from on-premises, as DNS record has been automatically recorded in the Private DNS Zone.

If application owner deletes the private endpoint, the corresponding records in the Private DNS Zone will automatically be removed.

[link-1]: https://docs.microsoft.com/azure/private-link/private-link-overview
[link-2]: https://docs.microsoft.com/azure/private-link/private-link-overview#availability
[link-3]: https://docs.microsoft.com/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration
[link-4]: https://docs.microsoft.com/azure/private-link/private-endpoint-dns
[link-5]: https://docs.microsoft.com/azure/governance/policy/tutorials/create-custom-policy-definition
[link-6]: https://docs.microsoft.com/azure/templates/microsoft.network/2020-05-01/privateendpoints/privatednszonegroups
[link-7]: https://docs.microsoft.com/azure/governance/policy/assign-policy-portal
[link-8]: https://docs.microsoft.com/azure/dns/dns-protect-private-zones-recordsets
[link-9]: https://docs.microsoft.com/azure/governance/policy/how-to/remediate-resources
[link-10]: https://docs.microsoft.com/azure/governance/policy/overview
[image-1]: https://lytill.blob.core.windows.net/images/image001.png
[image-2]: https://lytill.blob.core.windows.net/images/image002.jpg
[image-3]: https://lytill.blob.core.windows.net/images/image003.jpg
[image-4]: https://lytill.blob.core.windows.net/images/image004.jpg
[image-5]: https://lytill.blob.core.windows.net/images/image005.jpg
[image-6]: https://lytill.blob.core.windows.net/images/image006.jpg
[image-7]: https://lytill.blob.core.windows.net/images/image007.jpg
[image-8]: https://lytill.blob.core.windows.net/images/image008.jpg
[image-9]: https://lytill.blob.core.windows.net/images/image009.jpg
[image-10]: https://lytill.blob.core.windows.net/images/image010.jpg
[image-11]: https://lytill.blob.core.windows.net/images/image011.jpg
[image-12]: https://lytill.blob.core.windows.net/images/image012.jpg
[image-13]: https://lytill.blob.core.windows.net/images/image013.jpg
[image-14]: https://lytill.blob.core.windows.net/images/image014.jpg
