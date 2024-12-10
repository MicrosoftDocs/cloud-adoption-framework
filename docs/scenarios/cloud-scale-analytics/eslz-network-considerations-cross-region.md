---
title: Cross-region data landing zone connectivity
description: Learn cross-region connectivity for cloud-scale analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Cross-region data landing zone connectivity

If you have a presence in more than one Azure region and need to host your data platform and data applications across multiple geographies, connectivity becomes slightly more complicated.

Multi-region deployments generally have a connectivity hub subscription in each individual Azure location. For instance, if you have services running in both East US and West Europe, you set up a connectivity hub subscription with shared network resources in each region. Shared network resources include:

- Network virtual appliances (like Azure Firewall)
- ExpressRoute Gateways
- VPN Gateways
- Hub Virtual Networks (in a hub and spoke architecture) or vWAN Hubs (in a vWan setup)

:::image type="content" source="./media/cross-region-connectivity.png" alt-text="Cross-region Connectivity" lightbox="./media/cross-region-connectivity.png":::
*Figure 1: Cross-region Connectivity.*

In hub-spoke-spoke-hub architecture, connectivity hubs' virtual networks are often connected using Global virtual network Peering. For larger environments, a common alternative is to use ExpressRoute Global Reach. Whichever connectivity option you choose, you can achieve global routing and connectivity between spoke networks across multiple geographies. This means you can move data across regions using network virtual appliances, network security groups, and Route Tables, given that your traffic doesn't get blocked in either connectivity subscription.

[!INCLUDE [network-important](includes/network-important.md)]

## Global virtual network Peering (recommended)

You can connect data landing zones across regions using direct Global virtual network Peering. In this setup, if we continue our previous example scenario, the virtual machine in West Europe accesses the East US storage account's private endpoint directly, without relying on any hub and spoke or vWAN network architectures. Data is directly loaded by the virtual machine over a private endpoint, processed, and then stored back on the storage account in West Europe.

### User access management in Global virtual network Peering

There are no particular pros or cons for either of the proposed cross-region data landing zone connectivity options.

Summary: :::image type="icon" source="./media/plus-icon.png":::/:::image type="icon" source="./media/minus-icon.png":::

### Service management in Global virtual network Peering

Global virtual network Peering has no network virtual appliance that acts as a single point of failure or throttling throughput. Data isn't sent through your connectivity hubs, so you don't need to scale the virtual appliances and gateways within the connectivity hubs. This lack of scaling reduces management overhead for your core Azure platform team. You also don't need to allowlist individual cross-region connections. Your data teams can access data from data landing zones in other regions without having to wait for route table changes.

In this network design, your central Azure platform team can no longer inspect and log all traffic using a layer 7 firewall. However, the cloud-scale analytics scenario is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage. You can capture network logs by using Network Security Group Flow Logs. You can consolidate and store other application and service level logs by using service-specific Diagnostic Settings.

You can capture all of these logs at scale by using [Azure Policy definitions for diagnostic settings](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/DiagnosticSettings).

In some scenarios, you need to limit due to regulatory or legal implications. For instance, you might have a local regulation that requires certain datasets to stay within a particulate datacenter, so you're not allowed to transfer them across regions. You can rely on network security groups to help you comply with this kind of rule, only allowing traffic to move in one direction from East US to West Europe and not vice versa. Within your network security groups, you can ensure that traffic originating from East US is denied while traffic originating from West Europe is allowed.

This solution approach doesn't impact bandwidth and latency, and allows customers to remain compliant while still combining datasets from multiple regions. This option also has no impact on your DNS architecture and allows you to use an Azure-native solution based on Azure Private DNS Zones.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Global virtual network Peering cost

> [!NOTE]
> When accessing a private endpoint across a peered network, you will only ever be charged for the private endpoint itself and not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, you're charged for your Private Endpoints (per hour) and all ingress and egress traffic sent through them. You also have to pay a [data transfer cost](https://azure.microsoft.com/pricing/details/bandwidth/) for traffic between regions. However, you won't be charged any Global virtual network Peering ingress and egress costs and it has noteworthy cost benefits compared to the [traditional spoke-hub-hub-spoke option](#traditional-spoke-hub-hub-spoke-design-not-recommended).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in Global virtual network Peering

Impact on bandwidth and latency is lower in Global virtual network Peering than in the traditional spoke-hub-hub-spoke option. Global virtual network Peering contains a lower number of hops for cross-region data landing zone data exchange and has no network virtual appliances limiting throughput. The only things dictating the bandwidth and latency you can achieve for cross-region traffic are the physical limits of our datacenters (speed of fiber-optic cables, gateways, and routers).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Global virtual network Peering summary

Global virtual network Peering between data landing zones in different regions offers tremendous benefits, especially as cross-region data traffic increases within your data platform. It simplifies service management for your core Azure platform team, and especially benefits use cases that require low latency and high bandwidth. It also offers significant cost benefits over the traditional spoke-hub-hub-spoke design option.

## Traditional spoke-hub-hub-spoke design (not recommended)

Your other option for cross-region data transfers is the traditional spoke-hub-hub-spoke design. In our example scenario, if a virtual machine in data landing zone A hosted in West Europe loads a dataset stored in a storage account from data landing zone B hosted in East US, data traverses two local virtual network peerings (connectivity between hub and spokes), one Global virtual network Peering (connectivity between hubs) and two Gateways or network virtual appliances before loaded by the virtual machine and then moved back into the local storage account.

### User Access Management in traditional spoke-hub-hub-spoke design

There are no particular pros or cons for either of the proposed cross-region data landing zone connectivity options.

Summary: :::image type="icon" source="./media/plus-icon.png":::/:::image type="icon" source="./media/minus-icon.png":::

### Service management in traditional spoke-hub-hub-spoke design

This solution approach is well-known and consistent with other cross-region connectivity patterns, which makes it easy to adopt and implement. It also has no impact on DNS architecture and allows you to use an Azure-native solution based on Azure Private DNS Zones.

While this connectivity option works seamlessly if you set it up correctly, it does have downsides. Cross-region traffic is often denied by default and has to be enabled on a case-by-case basis. A ticket has to be submitted to your core Azure platform team for every single required cross-region data access requirement so your team can allowlist each specific connection between a virtual machine and cross-region storage account. This process significantly increases management overhead. It also slows down your data project teams, because they can't access the data they need.

You should also note that in this option, connectivity hubs act as single points of failure. In network virtual appliance or Gateway downtime, connectivity and corresponding data platforms fail. You also have a high risk of misconfiguring routes in the connectivity hubs. This misconfiguration can cause more serious downtime in your data platform and lead to a series of dependent workflow and data product failures.

You should monitor the amount of data you need to transfer across regions while using this solution approach. Over time, this monitoring can involve gigabytes or terabytes of data moving through your central instances. Since the bandwidth of network virtual appliances is often limited to a one- or two-digit gigabyte throughput, the appliances can act as a critical bottleneck limiting the traffic flow between regions and the shareability of your data assets. Because of this bottleneck, your shared network resources can require scaling mechanisms, which are often time consuming and costly, and can impact other workloads in your tenant.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Traditional Spoke-Hub-Hub-Spoke design cost

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In the traditional spoke-hub-hub-spoke design, you're charged your two storage accounts' Private Endpoints (per hour) and all ingress and egress traffic sent through them. You're also charged for the ingress and egress traffic of one local virtual network peering and the global virtual network peering between your connectivity hubs. However, you aren't charged for the first virtual network peering, as we explained in the previous note.

Your central network virtual appliances also incur significant costs if you choose this network design. This cost is because you either have to purchase extra licenses to scale the appliances based on demand or pay the charge per processed gigabyte, as with Azure Firewall.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Bandwidth and latency in traditional spoke-hub-hub-spoke design

This network design has serious bandwidth limitations. Your central network virtual appliances become critical bottlenecks as your platform grows, which limits cross-region data landing zone use cases and sharing of your datasets. It also makes it likely that multiple copies of your datasets get created over time. This design also heavily affects latency, which is especially critical for real-time analytics scenarios, since your data traverses many hops.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Design of traditional spoke-hub-hub-spoke

The spoke-hub-hub-spoke design is well-known and established at many organizations, which makes it easy to establish in an existing environment. However, it has significant downsides for service management, cost, bandwidth, and latency. These issues are especially noticeable as your number of cross-region use cases grows.

## Conclusion

[Global virtual network Peering](#global-virtual-network-peering-recommended) has many advantages over the [traditional spoke-hub-hub-spoke design](#traditional-spoke-hub-hub-spoke-design-not-recommended), as it's cost effective, easily managed, and offers reliable connectivity across regions. While traditional spoke-hub-hub-spoke design can be a viable option while your data volume and need for cross-region data exchange is low, we recommend you use the Global virtual network Peering approach as the amount of data you need to exchange across regions grows.

## Next steps

- [Limit cross-tenant private endpoint connections in Azure](../../ready/azure-best-practices/limit-cross-tenant-private-endpoint-connections.md)
- [Resource organization for cloud-scale analytics](../data-management/eslz-resource-organization.md)
