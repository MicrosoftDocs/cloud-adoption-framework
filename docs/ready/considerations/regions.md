---
title: Landing zone regions
description: Overview of how Azure landing zones use regions and how to add or move regions.
author: johndowns
ms.author: jodowns
ms.date: 05/21/2024
ms.topic: conceptual
ms.custom: internal
---
 
# Landing zone regions

This article explains how landing zones use Azure regions. The Azure landing zone architecture is region-agnostic, but you need to specify Azure regions to deploy your Azure landing zone architecture. The following guidance describes how to add a region to an existing landing zone and also provides considerations for when you migrate your Azure estate to a different region.

In some situations, you should deploy applications into multiple Azure regions to support your high availability and disaster recovery business requirements. You might not have an immediate need for multi-region applications, but you should design your Azure landing zone platform to support multiple regions, especially for connectivity, identity, and management services. Ensure that you can quickly enable and support multi-region application landing zones.

For more information, see [Select Azure regions](../azure-setup-guide/regions.md).

## Landing zones and Azure regions

Azure landing zones consist of a set of resources and configuration. Some of these items, like management groups, policies, and role assignments, are stored at either a tenant or management group level within the Azure landing zone architecture. These resources aren't *deployed* to a particular region and instead are deployed globally. However, you still need to specify a deployment region because Azure tracks some of the resource metadata in a regional metadata store.

Other resources are deployed regionally. Depending on your own landing zone configuration, you might have some or all of the following regionally deployed resources:

- An Azure Monitor Logs workspace, including selected solutions
- An Azure Automation account
- Resource groups, for the other resources

If you deploy a networking topology, you also need to select an Azure region to deploy the networking resources to. This region can be different from the region that you use for the resources listed in the preceding list. Depending on the topology you select, the networking resources that you deploy might include:

- Azure Virtual WAN, including a Virtual WAN hub
- Azure virtual networks
- VPN gateway
- Azure ExpressRoute gateway
- Azure Firewall
- Azure DDoS Protection plans
- Azure private DNS zones, including zones for Azure Private Link
- Resource groups, to contain the preceding resources

> [!NOTE]
> To minimize the effect of regional outages, we recommend that you place resources in the same region as the resource group. For more information, see [Resource group location alignment](/azure/azure-resource-manager/management/overview#resource-group-location-alignment).

## Add a new region to an existing landing zone

You should consider a multi-region strategy, either from the start of your cloud journey, or by expanding into more Azure regions after you complete the initial deployment of your Azure landing zone architecture. For example, if you use Azure Site Recovery to enable disaster recovery for your virtual machines, you might want to replicate them to a different Azure region. To add Azure regions within your Azure landing zone architecture, consider the following recommendations:

| Area | Recommendation |
| ---- | -------------- |
| Management groups | No action necessary. Management groups aren't tied to a region. You shouldn't create a management group structure based on regions. |
| Subscriptions | Subscriptions aren't tied to a region. |
| Azure Policy | Make changes in Azure Policy if you assigned policies to deny resource deployment to all regions by specifying a list of "allowed" Azure regions. Update these assignments to allow resource deployments to the new region you want to enable. |
| Role-based access control (RBAC) | No action necessary. Azure RBAC isn't tied to a region. |
| Monitoring and logging | Decide whether to use a single Azure Monitor Logs workspace for all regions or to create multiple workspaces to cover various geographical regions. Each approach has advantages and disadvantages, including potential cross-region networking charges. For more information, see [Design a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design#azure-regions). |
| Networking | If you deploy a networking topology, [Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or [traditional hub and spoke](../azure-best-practices/traditional-azure-networking-topology.md), expand the networking to the new Azure region. Create another networking hub by deploying the required networking resources into the existing Connectivity subscription in the new Azure region. [Azure Virtual Network Manager](../azure-best-practices/azure-virtual-network-manager.md) can make it easier to expand and manage virtual networks at scale in multiple regions. From a Domain Name System (DNS) perspective, you might also want to deploy forwarders, if you use them, into the new Azure region. Use forwarders for spoke virtual networks in the new region for resolution. Azure DNS zones are global resources and not tied to a single Azure region, so they don't require any action. |
| Identity | If you deployed Active Directory Domain Services or Microsoft Entra Domain Services into your *Identity* subscription or spoke, expand the service into the new Azure region. |

> [!NOTE]
> You should also use [availability zones](/azure/reliability/availability-zones-overview) for high availability within a region. Check whether your [Azure regions support availability zones](/azure/reliability/availability-zones-region-support), and [how the services you use support availability zones](/azure/reliability/availability-zones-service-support).

Microsoft Cloud for Sovereignty has guidelines for restricting services and regions. You can use these guidelines to enforce service configuration to help customers achieve their [data residency](/industry/sovereignty/data-residency) needs.

### High-level approach

When you expand an Azure landing zone into a new region, consider following the steps in these sections. Before you start, you need to decide on a new Azure region, or multiple Azure regions, to expand into.

#### Networking

##### Traditional hub-and-spoke architecture

> [!TIP]
> See a [traditional hub-and-spoke architecture](../azure-best-practices/traditional-azure-networking-topology.md).

1. Decide on whether you need a new platform landing zone subscription. We recommend that most customers use their existing *Connectivity* subscriptions, even when they use multiple regions.

1. Within the subscription, create a new resource group in the new target region.

1. Create a new hub virtual network in the new target region.

1. If applicable, deploy Azure Firewall or network virtual appliances (NVAs) into your new hub virtual network.

1. If applicable, deploy virtual network gateways for VPN or ExpressRoute connectivity, and establish connections. Ensure that your ExpressRoute circuits and on-premises locations follow Microsoft resiliency recommendations. For more information, see [Designing for disaster recovery with ExpressRoute private peering](/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering).

1. Establish virtual network peering between the new hub virtual network and the other hub virtual networks.

1. Create and configure any required routing, such as Azure Route Server or user-defined routes.

1. If required, deploy DNS forwarders for the new target region and link to any private DNS zones to enable name resolution.

   - Some customers might configure name resolution on their Windows Server Active Directory domain controllers within the *Identity* platform landing zone subscription.

To host your workloads, you can then use virtual network peering to connect application landing zone spokes to the new hub virtual network in the new region.

> [!TIP]
> [Virtual Network Manager](../azure-best-practices/azure-virtual-network-manager.md) can make it easier to expand and manage virtual networks at scale in multiple regions.

##### Virtual WAN architecture

> [!TIP]
> See a [Virtual WAN architecture](../azure-best-practices/virtual-wan-network-topology.md).

1. Within your existing Virtual WAN, create a new virtual hub in the new target region.

1. Deploy Azure Firewall or other supported network virtual appliances (NVAs) into your new virtual hub. Configure [Virtual WAN routing intent and routing policies](/azure/virtual-wan/how-to-routing-policies) to route traffic through the new secured virtual hub.

1. If applicable, deploy virtual network gateways for VPN or ExpressRoute connectivity in the new virtual hub and establish connections. Ensure that your ExpressRoute circuits and on-premises locations follow Microsoft resiliency recommendations. For more information, see [Designing for disaster recovery with ExpressRoute private peering](/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering).

1. Create and configure any other routing that you require, such as virtual hub static routes.

1. If applicable, deploy DNS forwarders for the new target region and link to any private DNS zones to enable resolution.

   - Some customers might configure name resolution on their Active Directory domain controllers within the *Identity* platform landing zone subscription.

   - In Virtual WAN deployments, this must be in a spoke virtual network that is connected to the virtual hub through a virtual network connection, following the [Virtual hub extension pattern](/azure/architecture/guide/networking/private-link-virtual-wan-dns-virtual-hub-extension-pattern).

To host your workloads, you can then use virtual network peering to connect application landing zone spokes to the new hub virtual network in the new region.

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

You might occasionally need to move your entire Azure estate to a different region. For example, suppose you deployed your landing zone and workloads into an Azure region in a neighboring country or region, and then a new Azure region launches in your home country or region. You might elect to move all of your workloads to the new region to improve the communication latency, or to comply with data residency requirements.

> [!NOTE]
> This article provides information about migrating the landing zone components of your estate. For more information, see [Relocate cloud workloads](../../relocate/index.md).

### Global landing zone configuration

Most of the globally deployed landing zone configuration doesn't typically need to be modified when you move regions. However, ensure that you check for any policy assignments that restrict region deployments and update the policy to allow deployments into the new region.

### Regional landing zone resources

Region-specific landing zone resources often require more consideration because you can't move some Azure resources between regions. Consider the following approach:

1. **Add the destination region as an additional region to your landing zone**: For more information, see [Add a new region to an existing landing zone](#add-a-new-region-to-an-existing-landing-zone).

1. **Deploy centralized components in the destination region**: For example, deploy a new Azure Monitor Logs workspace in your destination region so that workloads can begin to use the new component after you migrate the workload.

1. **Migrate your workloads from the source region to the destination region**: During the workload migration process, reconfigure the resources to use the destination region's networking components, identity components, the Azure Monitor Logs workspace, and other regional resources.

1. **Decommission the resources in the source region after you complete the migration**.

Consider the following tips when you migrate landing zone resources across regions:

- **Use infrastructure as code**: Use Bicep, Azure Resource Manager templates (ARM templates), Terraform, scripting, or a similar approach to export and reimport complex configurations, such as rules for Azure Firewall.

- **Automation**: Use [scripts](https://github.com/azureautomation/Migrate-automation-account-assets-from-one-region-to-another) to migrate Automation resources between regions.

- **ExpressRoute**: Consider whether you can use the [ExpressRoute Local SKU](/azure/expressroute/expressroute-faqs#expressroute-local) in your destination region. If your on-premises environments are within the same metropolitan area as your Azure region, ExpressRoute Local can provide a lower-cost option compared to other ExpressRoute SKUs.

## Next step

> [!div class="nextstepaction"]
> [Improve landing zone governance](/azure/cloud-adoption-framework/ready/considerations/landing-zone-governance)
