---
title: Private Link and DNS integration at scale
description: Private Link and DNS integration at scale
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Private Link and DNS integration at scale

> This article describes how to integrate Azure Private Link for PaaS services with Azure Private DNS zones in hub and spoke network architectures.

## Introduction

Many customers build their network infrastructure in Azure using the hub and spoke network architecture, where:

- Networking shared services (such as network virtual appliances, ExpressRoute/VPN gateways, or DNS servers) are deployed in the **hub** virtual network (VNet)
- **Spoke** VNets consume those shared services via VNet peering.

In hub and spoke network architectures, application owners are typically provided with an Azure subscription, which includes a VNet (*a spoke*) connected to the *hub* VNet. In this architecture, they can deploy their virtual machines and have private connectivity to other VNets or to on-premises networks via ExpressRoute or VPN.

Internet-outbound connectivity is provided via a central network virtual appliance (NVA) such as Azure Firewall.

Many application teams build their solutions using a combination of Azure IaaS and PaaS resources. Some Azure PaaS services (such as SQL Managed Instance) can be deployed in customer VNets. As a result, traffic will stay private within the Azure network and would be fully routable from on-premises.

However, some Azure PaaS services (such as Azure Storage or Azure Cosmos DB) cannot be deployed in a customer's VNets and are accessible over their public endpoint. In some instances, this can cause a contention with a customer's security policies, as corporate traffic might not allow the deployment or accessing of corporate resources (such as a SQL database) over public endpoints.

[Azure Private Link][link-1] allows access to a [list of Azure services][link-2] over private endpoints, but it requires that those private endpoint records are registered in a corresponding [private DNS zone][link-3].

This article describes how application teams can deploy Azure PaaS services in their subscriptions which are only accessible over private endpoints.

This article will also describe how application teams can ensure that services are automatically integrated with private DNS zones via Azure Private DNS. Removing the need for manual creation or deletion of records in DNS.

## Private Link and DNS integration in hub and spoke network architectures

Private DNS zones are typically hosted centrally in the same Azure subscription where the hub VNet is deployed. This central hosting practice is driven by [cross-premises DNS name resolution][link-4] and other needs for central DNS resolution such as Active Directory. In most cases, only networking/identity admins have permissions to manage DNS records in these zones.

Application teams do have permissions to create Azure resource in their own subscription. They do not have any permissions in the central networking connectivity subscription, which includes managing DNS records in the private DNS zones. This access limitation means they do not have the possibility to [create the DNS records required][link-4] when deploying Azure PaaS services with private endpoints.

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution and where name resolution for Private Link resources is done via Azure Private DNS:

![image-1][image-1]

From the previous diagram, it is important to highlight that:

- On-premises DNS servers have conditional forwarders configured for each private endpoint public DNS zone, pointing to the DNS servers 10.100.2.4 and 10.100.2.5 hosted in the hub VNet.
- The DNS servers 10.100.2.4 and 10.100.2.5 hosted in the hub VNet use the Azure-provided DNS resolver (168.63.129.16) as a forwarder. 
- The hub VNet must be linked to the Private DNS zone names for Azure services (such as privatelink.blob.core.windows.net, as shown in the picture).
- All Azure VNets use the DNS servers hosted in the hub VNet (10.100.2.4 and 10.100.2.5) as the primary and secondary DNS servers.
- If the DNS servers 10.100.2.4 and 10.100.2.5 are not authoritative for customer’s corporate domains (for example, Active Directory domain names), they should have conditional forwarders for the customer’s corporate domains, pointing to the on-premises DNS Servers (172.16.1.10 & 172.16.1.11) or DNS servers deployed in Azure which are authoritative for such zones. 

Please note that while the previous diagram depicts a single hub and spoke architecture, this guidance is applicable to scenarios where there are multiple hub and spoke networks across multiple Azure regions. In this case, the hub VNets in all regions should be linked to the same Azure Private DNS zones.

There are two conditions that must be true to allow application teams the freedom to create any required Azure PaaS resources in their subscription:

- Central networking and/or central platform team must ensure that application teams can only deploy and access Azure PaaS services via private endpoints.
- Central networking and/or central platform teams must ensure that whenever private endpoints are created, the corresponding records are automatically created in the centralized private DNS zone that matches the service created.
  - DNS record needs to follow the lifecycle of the private endpoint and automatically remove the DNS record when the private endpoint is deleted.

The following sections describe how application teams can enable these conditions by using [Azure Policy][link-10]. We will use Azure Storage as the Azure service that application teams need to deploy in our example below, but the same principle can be applied to most Azure services that [support][link-2] Private Link.

## Configuration required by platform team

### Create private DNS zones

Create private DNS zones in the central connectivity subscription for the supported Private Link services as per [documentation][link-4].

In our case, as we will use **Storage account with blob** as our example, it translates to us creating a `privatelink.blob.core.windows.net` private DNS zone in the connectivity subscription.

![image-2][image-2]

### Policy definitions

In addition to the private DNS zones, we also need to [create a set of custom Azure Policy definitions][link-5] to enforce the use of private endpoints and automate the DNS record creation in the DNS zone we created:

1. `Deny` public endpoint for PaaS services policy.

   This policy will prevent users from creating Azure PaaS services with public endpoints and give them an error message if private endpoint is not selected at resource creation.

   ![image-3][image-3]

   ![image-4][image-4]

   ![image-5][image-5]

   The exact policy rule may differ between PaaS services. For Azure Storage accounts, we look at the **networkAcls.defaultAction** property that defines whether requests from public network are allowed or not. In our case, we will set a condition to deny the creation of the **Microsoft.Storage/storageAccounts** resource type if the property **networkAcls.defaultAction** is not `Deny`. This policy definition is listed below:

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

2. `Deny` creation of a private DNS zone with the `privatelink` prefix policy.

   Since we use a centralized DNS architecture with a conditional forwarder and private DNS zones hosted in the subscriptions managed by the platform team, we need to prevent the application teams owners from creating their own Private Link private DNS zones and linking services into their subscriptions.

   To accomplish this, we need to ensure that when application teams create a private endpoint, the option to `Integrate with private DNS zone` must be set to `No` when using the Azure portal.

   ![image-6][image-6]

   If `Yes` is selected, Azure Policy will prevent the creation of the private endpoint. In our policy definition, we will deny the creation of the **Microsoft.Network/privateDnsZones** resource type if the zone has the `privatelink` prefix. This policy definition is described below:

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

3. `DeployIfNotExists` policy to automatically create the required DNS record in the central private DNS zone.

   This policy will be triggered if a private endpoint resource is created with a service-specific `groupId`. The `groupId` is the ID of the group obtained from the remote resource (service) that this private endpoint should connect to. We then trigger a deployment of a [`privateDNSZoneGroup`][link-6] within the private endpoint, which is used to associate the private endpoint with our private DNS zone. For our example, the `groupId` for Azure Storage blobs is `blob` (`groupId` for other Azure services can be found on [this][link-4] article, under the **Subresource** column). When policy finds that `groupId` in the private endpoint created, it will deploy a [`privateDNSZoneGroup`][link-6] within the private endpoint, and it will be linked to the private DNS zone resource ID that is specified as parameter. For our example, the private DNS zone resource ID would be:

   `/subscriptions/<subscription-id>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net`

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

### Policy assignments

Once policy definitions have been deployed, [assign the policies][link-7] at the desired scope in your management group hierarchy. Ensure that the policy assignments target the Azure subscriptions that will be used by the application teams to deploy PaaS services with private endpoint access exclusively.

> [!IMPORTANT]
> Remember to assign the [Private DNS Zone Contributor role][link-8] role in the subscription/resource group where the private DNS zones are hosted to the [managed identity created by the `DeployIfNotExists` policy assignment][link-9] that will be responsible to create and manage the private endpoint DNS record in the private DNS zone. This is because the private endpoint is located in the application owner Azure subscription, while the private DNS zone is located in a different subscription (such as central connectivity subscription).

Once the platform team finishes this configuration, Azure subscriptions from applications teams are ready for them to create Azure PaaS services with private endpoint access exclusively, and ensuring the DNS records for private endpoints are automatically registered (and removed once private endpoint is deleted) from corresponding private DNS zones.

## Application owner experience

Once the platform team has deployed the platform infrastructure components (private DNS zones and policies) described in the previous section, when an application owner tries to deploy an Azure PaaS service into the Azure subscription, the application owner will have the following experience, which will be the same if they do activities via the Azure portal or via other clients such as PowerShell or CLI, as their subscriptions are being governed by Azure policies.

1. Create a storage account through the Azure portal. In the basic tab, provide a name and your desired settings and click on **Next**.

   ![image-7][image-7]

2. In the networking section, ensure **Private endpoint** is selected. If an option other than **Private endpoint** is selected, the Azure portal will not allow the creation of the storage account in the **Review + create** section of the deployment wizard, as policy is preventing the creation of this service if the public endpoint is enabled.

   ![image-8][image-8]

3. It is possible to create the private endpoint on this screen or it can be done after the storage account has been created. For this exercise, we will create the private endpoint after the storage account has been created. Click on **Review + create** and complete the creation of the storage account.

4. Once the storage account is created, create a private endpoint through the Azure portal

   ![image-9][image-9]

5. In the **Resource** section, locate the storage account created in the previous step, and for target subresource select **Blob**, and then select **Next**.

   ![image-10][image-10]

6. In the **Configuration** section, after selecting your VNet and subnet, ensure that **Integrate with private DNS zone** is set to **No**. Otherwise, the Azure portal will prevent the creation of the private endpoint, as Azure Policy will not allow the creation of a private DNS zone with the `privatelink` prefix.

   ![image-11][image-11]

7. Select **Review + create**, and then select **Create** to deploy the private endpoint.

8. After a few minutes, the `DeployIfNotExists` policy will be triggered and the subsequent `dnsZoneGroup` deployment will add the required DNS records for the private endpoint in the centrally managed DNS zone.

9. Once the private endpoint has been created, select it, and review its FQDN and private IP:

   ![image-12][image-12]

10. Check the activity log for the resource group where the private endpoint was created, or you can check the activity log of the private endpoint itself. You will notice that after a few minutes, a `DeployIfNotExist` policy action is executed, which configures the DNS zone group on the private endpoint:

    ![image-13][image-13]

11. If the central networking team goes to the `privatelink.blob.core.windows.net` private DNS zone, they will confirm that the DNS record has been created for the private endpoint we created, and both the name and IP address match to the values within the private endpoint.

    ![image-14][image-14]

At this point, application teams can use the storage account via a private endpoint from any VNet in the hub and spoke network environment and from on-premises, as the DNS record has been automatically recorded in the private DNS zone.

If an application owner deletes the private endpoint, the corresponding records in the private DNS zone will automatically be removed.

[link-1]: /azure/private-link/private-link-overview
[link-2]: /azure/private-link/private-link-overview#availability
[link-3]: /azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration
[link-4]: /azure/private-link/private-endpoint-dns
[link-5]: /azure/governance/policy/tutorials/create-custom-policy-definition
[link-6]: /azure/templates/microsoft.network/2020-05-01/privateendpoints/privatednszonegroups
[link-7]: /azure/governance/policy/assign-policy-portal
[link-8]: /azure/dns/dns-protect-private-zones-recordsets
[link-9]: /azure/governance/policy/how-to/remediate-resources
[link-10]: /azure/governance/policy/overview
[image-1]: ./media/private-link-example-central-dns.png
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
