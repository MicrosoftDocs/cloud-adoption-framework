---
title: Landing zone regions
description: Overview of how Azure Landing Zones use regions, and how to add or move regions.
author: johndowns
ms.author: jodowns
ms.date: 07/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Landing zone regions

Azure landing zone architecture itself is region-agnostic. However, you're asked to specify Azure regions to deploy your Azure landing zone architecture. This article explains how landing zones use Azure regions, how to add a region to an existing landing zone, and some considerations when you migrate your Azure estate to a different region.

## How landing zones use Azure regions

Azure landing zones consist of a set of resources and configuration. Some of these items, like management groups, policies, and role assignments, are stored at either a tenant or management group level within the Azure landing zone architecture, so these resources aren't "deployed" to a particular region and instead are deployed globally. However, you still need to specify a deployment region because Azure tracks some of the resource metadata in a regional metadata store.

Other resources are deployed regionally. Depending on your own landing zone configuration, you might have some or all of the following regionally deployed resources:

- Log Analytics workspace (including selected solutions)
- Automation account
- Resource groups (for the other resources)

If you deploy a networking topology, you also need to select an Azure region to deploy the networking resources to. This region can be different from the region that you use for the resources listed in the preceding list. Depending on the topology you select, the networking resources that you deploy might include:

- Azure Virtual WAN (including Virtual WAN Hub)
- Azure Virtual Network
- VPN gateway
- ExpressRoute gateway
- Azure Firewall
- Azure DDoS Standard protection plan
- Azure Private DNS zones for Azure Private Link
- Resource groups (for these resources)

## Adding a new region to an existing landing zone

You might want to expand into or use more Azure regions once you've completed the initial deployment of Azure landing zone architecture. For example, if you enable disaster recovery for your virtual machines by using Azure Site Recovery, you might want to replicate them to a different Azure region. To add Azure regions within Azure landing zone architecture, consider the following areas and recommendations:

| Area | Recommendation |
| ---- | -------------- |
| Management groups | No action necessary. Management groups aren't tied to a region. |
| Azure Policy | Make changes here if you assigned policies to deny resource deployment to all regions by specifying a list of "allowed" Azure regions. These assignments must be updated to allow resource deployments to the new region you want to enable. |
| Role-based access control | No action necessary. Azure RBAC isn't tied to a region. |
| Logging | No action necessary. Keep sending and storing logs in the central Log Analytics Workspace in the Management subscription. See the recommendations in the Azure landing zone critical design area for [Management and monitoring](../landing-zone/design-area/management.md). |
| Networking | If you deployed a networking topology, [Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or [traditional hub and spoke](../azure-best-practices/traditional-azure-networking-topology.md), expand the networking to the new Azure region. Create another networking hub by deploying the required networking resources into the existing Connectivity subscription in the new Azure region. From a DNS perspective, you might also want to deploy forwarders, if used, into the new Azure region. Use forwarders for spoke VNETs in the new region for resolution. Remember that Azure DNS Zones are global resources and not tied to a single Azure region, so nothing needs to be done to them. |
| Identity | If you deployed Active Directory Domain Services or Azure Active Directory Domain Services into your Identity subscription/spoke, expand the service into the new Azure region. |

> [!NOTE]
> You might be able to use [Availability Zones](/azure/availability-zones/az-overview#availability-zones) instead of deploying into an additional Azure region. Review and assess whether this is possible based on your requirements and whether [Availability Zones are supported](/azure/availability-zones/az-region) in your region and for the services you want to use.

### High-level approach

The below high-level steps can be used as a set of steps to follow to expand into a new region in the context of Azure landing zone for Networking & Identity. First, decide on new Azure Region to expand into.

#### Networking

##### Traditional hub & spoke architecture

> [!TIP]
> Review the Azure landing zone design area for [traditional hub and spoke architecture](../azure-best-practices/traditional-azure-networking-topology.md)

1. Decide on whether a new platform landing zone subscription is needed or not
   - The same existing subscription is recommended to use for most customers across multiple regions for connectivity
1. Create new Resource Group in subscription in the new target region
1. Create new hub Virtual Network in the new target region
1. (optional) Deploy Azure Firewall or Network Virtual Appliances (NVA) into your new hub Virtual Network
1. (optional) Deploy Virtual Network Gateways for VPN and/or ExpressRoute connectivity and establish connections
1. Establish Virtual Network Peering between the new hub Virtual Network and the other hub Virtual Networks
1. Create and configure any required routing: Azure Route Server, User-Defined Routes, and more.
1. (optional) Deploy DNS Forwarders for new target region and link to any Azure Private DNS Zones to enable resolution
   - Some customers might do this on their Active Directory Domain Controllers that might be part of the Identity platform landing zone subscription

You can now connect application landing zone spokes via Virtual Network Peering to the new hub Virtual Network in the new region, to host your workloads.

##### Virtual WAN architecture

> [!TIP]
> Review the Azure landing zone design area for [Virtual WAN architecture](../azure-best-practices/virtual-wan-network-topology.md)

1. Create new Virtual Hub in the existing Virtual WAN in the new target region
1. (optional) Deploy Azure Firewall or supported Network Virtual Appliances (NVA) into your new Virtual Hub
1. (optional) Deploy Virtual Network Gateways for VPN and/or ExpressRoute connectivity in the new Virtual Hub and establish connections
1. (optional) Create and configure any additionally required routing: Virtual Hub Static Routes, and more.
1. (optional) Deploy DNS Forwarders for new target region and link to any Azure Private DNS Zones to enable resolution
   - Some customers might do this on their Active Directory Domain Controllers, which might be part of the Identity platform landing zone subscription
   - In Virtual WAN deployments, today, this must be in a spoke Virtual Network that is connected to the Virtual Hub via a Virtual Network Connection

You can now connect application landing zone spokes via Virtual Network Connections to the new Virtual Hub in Virtual WAN in the new region, to host your workloads.

#### Identity

> [!TIP]
> Review the Azure landing zone design area for [identity and access management](../landing-zone/design-area/identity-access.md)

1. Decide on whether a new platform landing zone subscription is needed or not
   - The same existing subscription is recommended to use for most customers across multiple regions for identity
1. Create new Resource Group in subscription in the new target region
1. Create new Virtual Network in the new target region
1. Establish Virtual Network Peering back to the newly created regional hub Virtual Network in the connectivity subscription
1. Deploy identity workloads, like Active Directory Domain Controller Virtual Machines into new Virtual Network
    - You might need to perform more setup and configuration of the workloads once provisioned, like:
      - Promoting the Active Directory Domain Controller Virtual Machines to the existing Active Directory Domain
      - Create new Active Directory sites & subnets
      - Configuring DNS Server settings like Conditional Forwarders

## Next steps

> [!div class="nextstepaction"]
> [Improve landing zone governance](/azure/cloud-adoption-framework/ready/considerations/landing-zone-governance)
