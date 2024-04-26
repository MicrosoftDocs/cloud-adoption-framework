---
title: Landing zone regions
description: Overview of how Azure Landing Zones use regions, and how to add or move regions.
author: johndowns
ms.author: jodowns
ms.date: 11/27/2023
ms.topic: conceptual
ms.custom: internal
---

# Landing zone regions

Azure landing zone architecture itself is region-agnostic. However, you're asked to specify Azure regions to deploy your Azure landing zone architecture. This article explains how landing zones use Azure regions. It also explains how to add a region to an existing landing zone, and some considerations when you migrate your Azure estate to a different region.

It is strongly recommended to deploy your application in two or more Azure regions for high availability and your Azure landing zone platform should support these multiple regions in relation to central connectivity, identity and management services.

For more guidance about choosing Azure regions, see [Select Azure regions](../azure-setup-guide/regions.md).

## How landing zones use Azure regions

Azure landing zones consist of a set of resources and configuration. Some of these items, like management groups, policies, and role assignments, are stored at either a tenant or management group level within the Azure landing zone architecture, so these resources aren't "deployed" to a particular region and instead are deployed globally. However, you still need to specify a deployment region because Azure tracks some of the resource metadata in a regional metadata store.

Other resources are deployed regionally. Depending on your own landing zone configuration, you might have some or all of the following regionally deployed resources:

- Log Analytics workspace (including selected solutions)
- Automation account
- Resource groups (for the other resources)

If you deploy a networking topology, you also need to select an Azure region to deploy the networking resources to. This region can be different from the region that you use for the resources listed in the preceding list. Depending on the topology you select, the networking resources that you deploy might include:

- Azure Virtual WAN (including Virtual WAN Hub)
- Azure virtual networks
- VPN gateway
- ExpressRoute gateway
- Azure Firewall
- Azure DDoS Protection plans
- Azure Private DNS zones, including for Azure Private Link
- Resource groups, to contain the resources listed above

## Add a new region to an existing landing zone

You should consider a multi-region strategy, either from the start of your cloud journey, or by expanding into more Azure regions once you've completed the initial deployment of your Azure landing zone architecture. For example, if you enable disaster recovery for your virtual machines by using Azure Site Recovery, you might want to replicate them to a different Azure region. To add Azure regions within Azure landing zone architecture, consider the following areas and recommendations:

| Area | Recommendation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ---- |--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Management groups | No action necessary. Management groups aren't tied to a region, and it's not a good practice to create a management group structure based on regions.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Subscriptions | Subscriptions aren't tied to a region.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Azure Policy | Make changes here if you assigned policies to deny resource deployment to all regions by specifying a list of "allowed" Azure regions. These assignments must be updated to allow resource deployments to the new region you want to enable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Role-based access control | No action necessary. Azure RBAC isn't tied to a region.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Monitoring and logging | Decide whether to use a single Log Analytics workspace for all regions, or to create multiple workspaces to cover different geographical regions. There are advantages and disadvantages of each approach, including potential cross-region networking charges. For more information, see [Design a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design#azure-regions).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Networking | If you deployed a networking topology, [Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or [traditional hub and spoke](../azure-best-practices/traditional-azure-networking-topology.md), expand the networking to the new Azure region. Create another networking hub by deploying the required networking resources into the existing Connectivity subscription in the new Azure region. [Azure Virtual Network Manager](../azure-best-practices/azure-virtual-network-manager.md) can make it easier to expand and manage virtual networks at scale in multiple regions. From a DNS perspective, you might also want to deploy forwarders, if used, into the new Azure region. Use forwarders for spoke virtual networks in the new region for resolution. Azure DNS zones are global resources and not tied to a single Azure region, so nothing needs to be done to them. |
| Identity | If you deployed Active Directory Domain Services or Microsoft Entra Domain Services into your *Identity* subscription/spoke, expand the service into the new Azure region.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

> [!NOTE]
> You should also use [availability zones](/azure/reliability/availability-zones-overview) for high availability within a region. Check whether [availability zones are supported](/azure/reliability/availability-zones-service-support) in your chosen regions and for the services you want to use.

Microsoft Cloud for Sovereignty has guidelines for restricting services and regions. You can use these guidelines to enforce service configuration to help customers achieve their [data residency](/industry/sovereignty/data-residency) needs.

### High-level approach

When you expand an Azure landing zone into a new region, consider following the steps in these sections. Before you start, you need to decide on a new Azure region, or multiple Azure regions, to expand into.

#### Networking

##### Traditional hub & spoke architecture

> [!TIP]
> Review the Azure landing zone design area for [traditional hub and spoke architecture](../azure-best-practices/traditional-azure-networking-topology.md).

1. Decide on whether a new platform landing zone subscription is needed. We recommend that most customers use their existing *Connectivity* subscriptions, even when they use multiple regions.
1. Within the subscription, create a new resource group in the new target region.
1. Create a new hub virtual network in the new target region.
1. If applicable, deploy Azure Firewall or network virtual appliances (NVAs) into your new hub virtual network.
1. If applicable, deploy virtual network gateways for VPN and/or ExpressRoute connectivity, and establish connections. Ensure that your ExpressRoute circuits and on-premises locations follow Microsoft's resiliency recommendations. For more information, see [Designing for disaster recovery with ExpressRoute private peering](/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering).
1. Establish virtual network peering between the new hub virtual network and the other hub virtual networks.
1. Create and configure any required routing, such as Azure Route Server or user-defined routes.
1. If required, enable name resolution by deploying DNS forwarders for the new target region and linking to any private DNS zones.
   - Some customers might configure name resolution on their Active Directory domain controllers within the *Identity* platform landing zone subscription.

To host your workloads, you can then connect application landing zone spokes to the new hub virtual network in the new region by using virtual network peering.

> [!TIP]
> [Azure Virtual Network Manager](../azure-best-practices/azure-virtual-network-manager.md) can make it easier to expand and manage virtual networks at scale in multiple regions.

##### Virtual WAN architecture

> [!TIP]
> Review the Azure landing zone design area for [Virtual WAN architecture](../azure-best-practices/virtual-wan-network-topology.md).

1. Within your existing virtual WAN, create a new virtual hub in the new target region.
1. Deploy Azure Firewall or other supported network virtual appliances (NVAs) into your new virtual hub. Configure [Azure Virtual WAN routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) to route traffic through the new secured virtual hub.
1. If applicable, deploy virtual network gateways for VPN and/or ExpressRoute connectivity in the new virtual hub and establish connections. Ensure that your ExpressRoute circuits and on-premises locations follow Microsoft's resiliency recommendations. For more information, see [Designing for disaster recovery with ExpressRoute private peering](/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering).
1. If applicable, create and configure any other routing that you require, such as virtual hub static routes.
1. If applicable, deploy DNS forwarders for the new target region and link to any private DNS zones to enable resolution.
   - Some customers might configure name resolution on their Active Directory domain controllers within the *Identity* platform landing zone subscription.
   - In Virtual WAN deployments this must be in a spoke virtual network that is connected to the virtual hub via a virtual network connection, following the [Virtual hub extension pattern](/azure/architecture/guide/networking/private-link-virtual-wan-dns-virtual-hub-extension-pattern).

To host your workloads, you can then connect application landing zone spokes to the virtual WAN's new virtual hub in the new region by using virtual network connections.

#### Identity

> [!TIP]
> Review the Azure landing zone design area for [identity and access management](../landing-zone/design-area/identity-access.md).

1. Decide whether you need a new platform landing zone subscription. We recommend that most customers use their existing *Identity* subscription, even when they use multiple regions.
1. Create a new resource group in the new target region.
1. Create a new virtual network in the new target region.
1. Establish virtual network peering back to the newly created regional hub virtual network in the *Connectivity* subscription.
1. Deploy identity workloads, like Active Directory domain controller virtual machines, into the new virtual network.
    - You might need to perform more setup of the workloads once they're provisioned, such as the following configuration steps:
      - Promote the Active Directory domain controller virtual machines to the existing Active Directory domain.
      - Create new Active Directory sites and subnets.
      - Configure DNS server settings like conditional forwarders.

## Move your Azure estate to a new region

Occasionally, you might need to move your entire Azure estate to a different region. For example, suppose you deployed your landing zone and workloads into an Azure region in a neighboring country/region, and then a new Azure region launches in your home country/region. You might elect to move all of your workloads to the new region to improve the communication latency, or to comply with data residency requirements.

> [!NOTE]
> This document only provides information about migrating the landing zone components of your estate. For more information about relocating your workload components, see [Relocate cloud workloads](../../relocate/index.md).

### Global landing zone configuration

Most of the globally deployed landing zone configuration doesn't typically need to be modified when you move regions. However, ensure that you check for any policy assignments that restrict region deployments and update the policy to allow deployments into the new region.

### Regional landing zone resources

Region-specific landing zone resources often require more consideration because some Azure resources can't be moved between regions. Consider the following approach:

1. **Add the destination region as an additional region to your landing zone.** Follow the guidance in [Add a new region to an existing landing zone](#add-a-new-region-to-an-existing-landing-zone).
1. **Deploy centralized components in the destination region.** For example, deploy a new Log Analytics workspace in your destination region so that workloads can begin to use the new component when they're migrated.
1. **Migrate your workloads from the source region to the destination region.** During the workload migration process, reconfigure the resources to use the destination region's networking components, identity components, Log Analytics workspace, and other regional resources.
1. **Decommission the resources in the source region after the migration is complete.**

Consider the following tips when migrating landing zone resources across regions:

- **Use infrastructure as code:** Complex configuration, such as rules for Azure Firewall, can be exported and reimported by using Bicep, ARM templates, Terraform, scripting, or a similar approach.
- **Azure Automation:** Azure Automation provides [guidance and scripts](https://github.com/azureautomation/Migrate-automation-account-assets-from-one-region-to-another) to assist with inter-region migration of Azure Automation resources.
- **ExpressRoute:** Consider whether you can use [ExpressRoute Local](/azure/expressroute/expressroute-faqs#expressroute-local) in your destination region. If your on-premises environments are within the same metropolitan area as your Azure region, ExpressRoute Local can provide a lower-cost option than other ExpressRoute SKUs.

## Next steps

> [!div class="nextstepaction"]
> [Improve landing zone governance](/azure/cloud-adoption-framework/ready/considerations/landing-zone-governance)
