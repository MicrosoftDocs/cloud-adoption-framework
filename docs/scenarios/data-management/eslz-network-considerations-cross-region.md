---
title: Cross-region connectivity for data cloud scale analytics landing zones
description: Learn cross-region connectivity for cloud scale analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 03/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Cross-region data landing zone connectivity

If you have a presence in more than a single Azure region and want to host their data platform and data applications across multiple geographies, the connectivity becomes slightly more complicated.

Deployments with a multi-region setup generally have a connectivity hub subscription in each of the individual Azure locations. For instance, if services are running in East US and West Europe, a connectivity hub subscription with shared network resources would exist in both regions. Shared network resources include services like a network virtual appliance such as an Azure Firewall, an ExpressRoute Gateway, a VPN Gateway, the Hub Virtual Network in a hub and spoke architecture or the vWAN Hub in a vWan setup.

:::image type="content" source="./images/cross-region-connectivity.png" alt-text="Cross-region Connectivity":::
*Figure 1: Cross-region Connectivity.*

In a hub and spoke architecture the hub virtual networks of these connectivity hubs are often connected using Global Vnet peering. Another alternative that is common in larger environments is the use of ExpressRoute Global Reach. Using either of these connectivity options, you can achieve global routing and connectivity between spoke networks across multiple geographies and hence will also be able to move data across regions, given that the traffic doesn't get blocked in either of the connectivity subscriptions by using network virtual appliances, network security groups and Route Tables.

[!INCLUDE [network-important](includes/network-important.md)]

## Global vnet peering (Recommended)

The first option relies on direct global Vnet peering to connect data landing zones across regions. With such a setup, the virtual machine in West Europe would access the private endpoint of the storage account in East US directly without relying on any hub and spoke or vWAN network architectures. Data would be directly loaded by the virtual machine over the private endpoint, would then be processed before it gets stored back on the storage account in West Europe.

### User access management in global vnet peering

There are no particular pros or cons that are related to any of the proposed options for cross-region data landing zone connectivity.

Summary: :::image type="icon" source="./images/plusicon.png":::/:::image type="icon" source="./images/minusicon.png":::

### Service management in global vnet peering

With this network design, there's no network virtual appliance in between acting as a single point of failure or throttling throughput. By not sending the data through the connectivity hubs, the management overhead for the core Azure platform team will also be reduced, as there will be no need to scale the virtual appliances and gateways in the connectivity hubs. In addition, the need for allow-listing individual cross-region connections will be omitted. Data team will no longer have to wait for route table changes in order to be able to access data from another data landing zone in another region.

This network design change also has the impact that the platform team can no longer inspect and log all traffic using a layer 7 firewall. However, this isn't considered as disadvantage as cloud-based analytics scenario can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. Also, other platform capabilities such as Network Security Group Flow Logs and service specific Diagnostic Settings can be used to capture necessary network and service logs that can be used to inspect traffic. Such logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/).

In some scenarios, traffic needs to be limited due to regulatory or legal implications. For instance, you could have a local regulation that requires certain datasets to stay within a particulate datacenter and therefore wouldn't allowed to be transferred across regions. To comply with such rules and only allow traffic to be sent one direction from East US to West Europe but not vice versa, you can rely on network security groups. Within the network security groups you can define that traffic originating from East US is denied whereas traffic originating from West Europe would be allowed. This solution approach doesn't have implications on the bandwidth and latency, but will allow customer to stay compliant while still being able to combine datasets from multiple regions.

This option also has no impact on the DNS architecture and allows using an Azure-native solution based on Azure Private DNS Zones.

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Cost in global vnet peering

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design you'll only pay for the two Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints. In addition, you'll have to pay [data transfer cost](https://azure.microsoft.com/pricing/details/bandwidth/) for traffic between regions. However, due to the statement above, you'll NOT be charged for the global Vnet peering ingress and egress cost. In summary, this first option has noteworthy cost benefits compared to the option mentioned below.

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Bandwidth and latency in global vnet peering

Because there are no network virtual appliances limiting throughput and a lower number of hops for cross-region data landing zone data exchange, the bandwidth and latency will be much lower compared to option 2. Physical limits in our datacenters will dictate the bandwidth and latency that can be achieved for cross-region traffic (speed of fibre cables/light, gateways and routers).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Summary global vnet peering

Global Vnet peering between data landing zones in different regions can have tremendous benefits especially as the cross-region data traffic increases inside the data platform. Service management will be much simplified, the core Azure platform team will be relieved and use cases that require low latency and high bandwidth will benefit from this option. Also, from a cost perspective there are benefits that should be considered when deciding about cross-region data landing zone connectivity.

## Traditional spoke-hub-hub-spoke design (NOT Recommended)

The second option proposes to rely on the traditional Spoke-Hub-Hub-Spoke design to transfer data cross-regions. In this scenario, if a virtual machine in a data landing zone A hosted in West Europe loads a dataset that is stored in a storage account hosted in a data landing zone B hosted in East US, data would traverse two local Vnet peerings (connectivity between hub and spokes), one global Vnet peering (connectivity between hubs) and two Gateways or network virtual appliances before it gets loaded by the virtual machine and then stored back into the local storage account.

### User Access Management in traditional spoke-hub-hub-spoke design

There are no particular pros or cons that are related to any of the proposed options for cross-region data landing zone connectivity.

Summary: :::image type="icon" source="./images/plusicon.png":::/:::image type="icon" source="./images/minusicon.png":::

### Service Management in traditional spoke-hub-hub-spoke design

A benefit of this solution approach is that it's well-known and consistent with other cross-region connectivity patterns. Therefore, this option is easy to adopt and implement by you. This option also has no impact on the DNS architecture and allows using an Azure-native solution based on Azure Private DNS Zones.

This connectivity option works seamless if set up correctly, but also has certain downsides based on our experience. By default, such cross-region traffic is most often denied and needs to be enabled on a case-by-case basis. This means, that for each and every required cross-region data access requirement, a ticket would have to be submitted to the core Azure platform team to allowlist the particular connection between the virtual machine and storage account cross-region. This can create a serious management overhead and can slow down data project teams, because they aren't able to access the data they need to.

Another point that should be considered when choosing this option is that the connectivity hubs act as single point of failures. In a downtime of the network virtual appliances or the Gateways, connectivity will fail and corresponding data pipelines will also fail. In addition, there's a high risk of misconfiguration of routes in the connectivity hubs. Such misconfiguration can again cause serious downtime in the data platform and can lead to a series of failures of dependent workflows and data products.

Lastly, you should monitor the amount of data that needs to be transferred across regions. Over time, this can result in gigabytes or terabytes of data that is sent through the central instances. However, the bandwidth of existing network virtual appliances is often limited to a one- or two-digit gigabyte throughput. Therefore, the appliances can act as a critical bottleneck limiting the traffic flowing between regions and therefore limiting the shareability of data assets. This can require scaling mechanisms for the shared network resources, which can be a time consuming and costly exercise that can have an impact on other workloads in the tenant.

Summary: :::image type="icon" source="./images/minusicon.png":::

### Cost in traditional Spoke-Hub-Hub-Spoke design

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

You'll have to pay for the two Private Endpoints of the Storage Accounts (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw and store the processed dataset. In addition, the customer will be charged for the ingress and egress of one local Vnet peering as well as the global Vnet peering between the connectivity hubs. Due to the statement above, the first Vnet peering in the East US region won't be charged. Lastly, you'll end up with significant cost for the central network virtual appliances when choosing this network design. The high cost will be generated either because extra licenses need to be purchased to scale out based on demand or it will be generated because of the charge per processed gigabyte as it is done with Azure Firewall.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Bandwidth and latency in traditional spoke-hub-hub-spoke design

This network design has serious limitations from a bandwidth perspective. The central network virtual appliances will become critical bottlenecks as the platform grows, which will limit cross-region data landing zone use cases and sharing of datasets and most likely lead to a situation where multiple copies of datasets will be created over time. In addition to bandwidth, latency will be heavily affected by that network design, which is especially critical for real-time analytics scenarios, as data will have to traverse a large number of hops.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Summary traditional spoke-hub-hub-spoke design

This setup is well-known and established at many you and therefore is easy to establish in an existing environment. However, you should consider the downsides that come with the Spoke-Hub-Hub-Spoke connectivity especially from a service management, cost, bandwidth and latency perspective. Especially as the number of cross-region use cases grows, this setup will show its challenges.

## Conclusion

After reviewing the two options for cross-region data landing zone connectivity, it becomes clear that [Global vnet peering (Recommended)](#global-vnet-peering-recommended) between data landing zone has many advantages compared to option 2 and therefore is the recommended approach as the amount of data that needs to be exchanged across regions grows. This option can be easily managed and provides compliant, cost effective and performant connectivity across regions.

Nonetheless, [Traditional Spoke-Hub-Hub-Spoke Design (NOT Recommended)](#traditional-spoke-hub-hub-spoke-design-not-recommended) can be a viable option while the need for cross-region data exchange and the data volume is low.

## Next steps

- [Limit cross-tenant private endpoint connections in Azure](../../ready/azure-best-practices/limit-cross-tenant-private-endpoint-connections.md)
- [Resource organization for cloud-scale analytics](eslz-resource-organization.md)
