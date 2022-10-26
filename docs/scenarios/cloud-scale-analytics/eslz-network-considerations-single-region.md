---
title: Single-region data landing zone connectivity
description: Learn single-region connectivity for cloud-scale analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 03/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Single-region data landing zone connectivity

The data management landing zone, the data landing zones, and all the services within them are set up in the same region in a single-region setup. All landing zones are within the same connectivity hub subscription. This subscription hosts shared network resources, which can include a network virtual appliance (like Azure firewall), an ExpressRoute gateway, a virtual private network (VPN) gateway, a hub virtual network, or a virtual WAN (vWAN hub).

:::image type="content" source="./media/single-region-connectivity.png" alt-text="Single Region Connectivity" lightbox="./media/single-region-connectivity.png":::

*Figure 1: Single Region Connectivity.*

Based on Azure Networking Services' current capabilities, we recommend you use a meshed network architecture. You should set up Vnet peering between:

- The Connectivity Hub and Data Management Zone
- The Connectivity Hub and each Data Landing Zone
- The Data Management Zone and each Data Landing Zone
- Each Data Landing Zone

This article describes the pros and cons of each network architecture option we considered for cloud-scale analytics.

The first section of this article focuses on a single-region pattern, where the Data Management Zone and all Data Landing Zones are hosted in the same region.

Each design pattern is evaluated using the following criteria:

- Cost
- User access management
- Service management
- Bandwidth
- Latency

We'll analyze each design option with the following cross-data landing zone use-case in mind:

> [!NOTE]
> *Virtual machine B (VM B) hosted in data landing zone B loads a dataset from storage account A hosted in data landing zone A. Then VM B processes that dataset and stores it in Storage Account B, which is hosted in data landing zone B.*

[!INCLUDE [network-important](includes/network-important.md)]

## Meshed network architecture (recommended)

We recommend that you use a network mesh architecture when adopting cloud-scale analytics. In addition to the existing hub and spoke network design set up within your tenant, you have to do two things to implement a network mesh architecture:

- Add Vnet peerings between all data landing zone Vnets.
- Add Vnet pairings between your data management landing zone and all data landing zones.

In our example scenario, data loaded from Storage Account A transits a Vnet peering connection (2) set up between the two data landing zone Vnets. It's loaded and processed by VM B ((3) and (4)), then sent through the local Private Endpoint (5) to be stored in Storage Account B.

In this scenario, the data doesn't pass the Connectivity Hub. It stays within the Data Platform that consists of a data management landing zone and one or more data landing zones.

:::image type="content" source="./images/network-options-meshed-network-architecture.png" alt-text="Meshed Network Architecture" lightbox="./images/network-options-meshed-network-architecture.png":::

*Figure 2: Meshed Network architecture.*

### User access management in meshed network architecture

In a meshed network architecture design, data application teams only require two things to be able to create new services (including Private Endpoints):

- Write access to their dedicated resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy Private Endpoints themselves. As long they have the necessary access rights to connect Private Endpoints to a subnet in a given spoke, your teams need no support when setting up the necessary connectivity.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Service management in meshed network architecture

In a meshed network architecture design, no network virtual appliance acts as a single point of failure or throttling. The lack of datasets being sent through the Connectivity Hub reduces your central Azure platform team's overhead, provided you don't need to scale out that virtual appliance.

This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, your central Azure platform team no longer inspects all data in the central Connectivity Hub, either. You can still capture network logs by using Network Security Group Flow Logs. You can consolidate and store other application and service level logs by using service-specific Diagnostic Settings.

You can capture all of these logs at scale by using [Azure Policy definitions for diagnostic settings](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/DiagnosticSettings).

This design also allows you to create an Azure native DNS solution based on Private DNS Zones. You can automate the DNS A-record lifecycle through [Azure Policy definitions for private DNS groups](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture cost

> [!NOTE]
> When accessing a private endpoint across a peered network, you will only ever be charged for the private endpoint itself, not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you only pay for:

- your Private Endpoints (per hour)
- the ingress and egress traffic sent through your Private Endpoints to load your raw dataset (1) and store your processed dataset (6)

Vnet peering won't be charged (2), which is why this option has minimal cost.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in a meshed network architecture

This design has no known bandwidth or latency limitations because no network virtual appliances limit throughput for its cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture summary

If you plan to adopt cloud-scale analytics, we recommend that you use the meshed network design. A meshed network offers maximum bandwidth and low latency at minimal cost, yet makes no compromises regarding user access management or on the DNS layer.

If you need to enforce other network policies within the data platform, use Network Security Groups rather than central network virtual appliances.

## Traditional hub and spoke architecture (not recommended)

Hub and spoke network architecture design is the most obvious option, and one that many enterprises have adopted. In it, network transitivity gets set up in the Connectivity Hub to access data in Storage Account A from VM B. Data traverses two Vnet peerings ((2) and (5)) and a network virtual appliance hosted inside the Connectivity Hub ((3) and (4)). Then the data is loaded by the virtual machine (6) and stored back into the Storage Account B (8).

:::image type="content" source="./images/network-options-hub-and-spoke.png" alt-text="Hub and spoke architecture" lightbox="./images/network-options-hub-and-spoke.png":::

*Figure 3: Hub and spoke architecture.*

### User access management in traditional hub and spoke architecture

In a traditional hub and spoke design, data application teams only require two things for them to be able to create new services (including Private Endpoints):

- Write access to their resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy Private Endpoints themselves. As long they have the necessary access rights to connect Private Endpoints to a subnet in a given spoke, your teams need no support when setting up the necessary connectivity.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Service Management in traditional hub and spoke architecture

This network design is well-known and consistent with most organizations' existing network setup. This makes the design easy to explain and implement. You can also use a centralized Azure-native DNS solution with Private DNS Zones to provide FQDN resolution inside your Azure tenant. Using Private DNS Zones allows you to automate the DNS A-record lifecycle through [Azure Policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Another benefit of this design is that traffic is routed through a central network virtual appliance, so network traffic sent from one Spoke to another can be logged and inspected.

One downside of this design is that your central Azure Platform team has to manually manage Route Tables. This is necessary to ensure transitivity between Spokes, which enables data asset sharing across multiple data landing zones. Route management can become complex and error-prone over time and must be considered up front.

Another downside to this network setup is the way your central network virtual appliance is set up. The network virtual appliance functions as a single point of failure and can cause serious downtime inside the data platform if a failure occurs. Also, as dataset sizes increase within a data platform and the number of cross-data landing zone use cases increases, more traffic is sent through the central network virtual appliance.

Over time, this can result in gigabytes or even terabytes of data being sent through the central instance. Since bandwidth of existing network virtual appliances is often limited to just a one- or two-digit gigabyte throughput, the central network virtual appliance can become a bottleneck that critically limits traffic flow between data landing zones and limits data asset shareability.

The only way to avoid this issue is to scale out your central network virtual appliance across multiple instances, which has major cost implications for this design.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Traditional hub and spoke architecture cost

> [!NOTE]
> When accessing a private endpoint across a peered network, you will only ever be charged for the private endpoint itself and not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

For this network, you're charged per hour for your storage accounts' Private Endpoints. You're also charged for ingress and egress traffic sent through the Private Endpoints to load a raw dataset (1) and store the processed dataset (8).

Your customer is charged for the ingress and egress of one Vnet peering (5). As previously mentioned, the first Vnet peering isn't charged (2).

You'll end up with a high central network virtual appliance cost if using this network design ((3) and (4)). You have to either purchase extra licenses and scale the central network virtual appliance out based on demand or pay the charge processed per gigabyte as it's done with Azure Firewall.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Bandwidth and latency in traditional hub and spoke architecture

This network design has serious bandwidth limitations. The central network virtual appliance becomes a critical bottleneck as your platform grows, which limits cross-data landing zone use cases and dataset sharing. It also likely creates multiple copies of datasets over time.

This design also heavily affects latency, which becomes especially critical in real-time analytics scenarios.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Traditional hub and spoke architecture summary

This hub and spoke network design has access management and some service management benefits, but due to critical limitations of service management and bandwidth and latency, we can't recommend this network design for cross-data landing zone use cases.

## Private Endpoint projection architecture (not recommended)

Another design option is the projection of Private Endpoints across each and every landing zone. In this design, a Private Endpoint for Storage Account A is created in each landing zone. This leads to a first Private Endpoint in data landing zone A connected to the Vnet in data landing zone A, a second Private Endpoint connected to the Vnet in data landing zone B, and so on.

The same applies to Storage Account B, and potentially to other services inside the data landing zones. If we define the number of data landing zones as *n*, then we end up with *n* Private Endpoints for at least all the storage accounts and potentially other services within the data landing zones as well. This leads to an exponential increase in the number of Private Endpoints.

:::image type="content" source="./images/network-options-private-endpoint-projection.png" alt-text="Private Endpoint Projection" lightbox="./images/network-options-private-endpoint-projection.png":::

*Figure 4: Private Endpoint projection architecture.*

Since all Private Endpoints of a particular service (for example, Storage Account A) have the same FQDN (such as `storageaccounta.privatelink.blob.core.windows.net`), this solution creates challenges in the DNS layer that can't be solved using Private DNS Zones. You instead need a custom DNS solution capable of resolving DNS names based on the origin/IP-address of the requestor. This allows you to make VMA connect to the Private Endpoints connected to the Vnet in data landing zone A, and to make VM B connect to the Private Endpoints connected to the Vnet in data landing zone B. You can do this with a Windows Servers-based setup, whereas you can automate the DNS A-records lifecycle through a combination of Activity Log and Azure Functions.

In this setup, you can load the raw dataset in Storage Account A into VM B by accessing the dataset through the local Private Endpoint (1). After you load and process the dataset ((2) and (3)), you can store it on Storage Account B by directly accessing the local Private Endpoint (4). In this scenario, data must not traverse any Vnet peerings.

### User access management in private endpoint projection architecture

This design's approach to user access management is similar to that of the [meshed network architecture](#meshed-network-architecture-recommended). However, in this design, you can require access rights for other data landing zones, to create Private Endpoints not just within a designated data landing zone and Vnet but also in other data landing zones and their respective Vnets.

Because of this, your data application teams require three things, not two, to be able to create new services themselves:

- write access to a resource group in a designated data landing zone
- join access to their designated subnet
- access to a resource group and subnet inside all the other data landing zones to create their respective local Private Endpoints

This network design increases complexity in your access management layer since your data application teams require permissions in every single data landing zone. The design can also be confusing and lead to inconsistent RBAC over time.

If data landing zone teams and data application teams aren't given necessary access rights, problems described in [traditional hub and spoke architecture (not recommended)](#traditional-hub-and-spoke-architecture-not-recommended) will occur.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Service management in private endpoint projection architecture

While again similar to the [meshed network architecture's](#meshed-network-architecture-recommended) design, this network design has the benefit of no network virtual appliance acting as a single point of failure or throttling throughput. It also reduces management overhead for your central Azure platform team by not sending datasets through the Connectivity Hub, because there's no need to scale out the virtual appliance. This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, traffic isn't inspected in the central Connectivity Hub.  You can still capture network logs by using Network Security Group Flow logs, and you can consolidate and store other application and service level logs by using service-specific Diagnostic Settings. You can capture all of these logs at scale by using [Azure Policies](../../strategy/monitoring-strategy.md). On the other hand, the network address space required by your data platform increases due to the exponential increase in required Private Endpoints, which isn't optimal.

The major concerns regarding this network architecture are its previously mentioned DNS challenges. You can't use an Azure native solution in the form of Private DNS Zones, so this architecture requires a third-party solution capable of resolving FQDNS based on the origin/IP-address of the requestor. You also have to develop and maintain tools and workflows to automate Private DNS A-records, which drastically increases management overhead compared to the proposed [Azure Policy driven solution](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

You can create a distributed DNS infrastructure using Private DNS zones, but this creates DNS islands, which ultimately cause issues when you try to access private link services hosted in other landing zones within your tenant. Therefore, this design isn't a viable option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Private endpoint projection architecture cost

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you're only charged for the Private Endpoints (per hour) and the ingress and egress traffic sent through those Private Endpoints to load raw datasets (1) and store processed datasets (4). However, extra costs must be expected because of the exponential increase in the number your data platform's Private Endpoints. Since you're charged per hour, the amount of extra cost highly depends on how many Private Endpoints are created.

Summary: :::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in private endpoint projection architecture

This design has no known bandwidth and latency limitations because it has no network virtual appliances limiting throughput for cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Private Endpoint projection architecture summary

The exponential growth of Private Endpoints in this network architecture can cause you to lose track of which Private Endpoints are used for what purpose in which location. You're also limited by access management issues and DNS layer complexities. Because of these problems, we can't recommend this network design for cross-data landing zone use cases.

## Private Endpoints in Connectivity Hub architecture (not recommended)

Another network option is to host Private Endpoints in your Connectivity Hub and connect them to the Hub Vnet. In this solution, you host a single Private Endpoint for each service on your corporate Vnet. Due to the existing hub and spoke network architecture at most corporations, and the fact that your Connectivity Hub hosts your Private Endpoints in this solution, transitivity isn't required. Vnet peering between your Connectivity Hub and data landing zones allows for direct access.

Data traverses a single Vnet peering between the Connectivity Hub and data landing zone in order to load a dataset stored in Storage Account A in VM B. Once that dataset is loaded and processed ((3) and (4)), it traverses the same Vnet peering a second time (5) before finally getting stored in Storage Account B through the Private Endpoint connected to the Hub Vnet (6).

:::image type="content" source="./images/network-options-private-endpoints-in-connectivity-hub.png" alt-text="Private Endpoints in Connectivity Hub" lightbox="./images/network-options-private-endpoints-in-connectivity-hub.png":::

*Figure 5: Private Endpoints in Connectivity Hub architecture.*

### User access management in Connectivity Hub architecture

In this network design, your data landing zone teams and data application teams need two things to be able to connect Private Endpoints to the Hub Vnet:

- write permissions to a resource group in your Connectivity Hub subscription
- join permissions to the Hub Vnet

Your Connectivity Hub is designated for your organization's Azure platform team and is dedicated for host your organization's necessary and shared network infrastructure (including firewalls, gateways, and network management tools). This network option makes that design inconsistent, because it doesn't follow access management principles from the Enterprise-Scale Landing Zone base principles. Therefore, most Azure platform teams won't approve this design option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Service management in Connectivity Hub architecture

While similar to the [meshed network architecture's](#meshed-network-architecture-recommended) design, this design has no network virtual appliance acting as a single point of failure or throttling throughput. It also reduces management overhead for your central Azure platform team by not sending datasets through the Connectivity Hub, because there's no need to scale out the virtual appliance. This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, traffic isn't inspected in the central Connectivity Hub. You can still capture network logs by using Network Security Group Flow logs, and you can consolidate and store other application and service level logs by using service-specific Diagnostic Settings. You can capture all of these logs at scale by using [Azure Policies](../../strategy/monitoring-strategy.md).

This design also allows you to create an Azure native DNS solution based on Private DNS Zones, and allows you to automate the DNS A-record lifecycle through [Azure Policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Connectivity Hub architecture cost

> [!NOTE]
> When accessing a private endpoint across a peered network, you will only ever be charged for the private endpoint itself and not for the VNet peering. You can read the official statement in [FAQ: How will billing work when accessing a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you're only charged for your Private Endpoints (per hour) and ingress and egress traffic sent through those Private Endpoints to load a raw dataset (1) and store the processed dataset (6).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in Connectivity Hub architecture

This design has no known bandwidth and latency limitations because it has no network virtual appliances limiting throughput for cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

#### Private Endpoints in Connectivity Hub architecture summary

While this network architecture design has multiple benefits, its previously mentioned access management inconsistencies make it subpar. Therefore, we can't recommend this design approach.

## Single-region data landing zone connectivity conclusion

Out of all reviewed network architecture options and their pros and cons, [meshed network architecture](#meshed-network-architecture-recommended) is the clear winner. It has tremendous benefits for throughput and for cost and management, which is why we recommend you use it when deploying cloud-scale analytics. Peering spoke virtual networks hasn't previously been common, and this has led to issues with sharing datasets across domains and business units.

You can view cloud-scale analytics as a coherent solution that spans multiple subscriptions. In a single subscription setup, network traffic flow equals the flow in the meshed network architecture. Within a single subscription setup, users will most likely hit the platform's [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits), which cloud-scale analytics aims to avoid.

## Next steps

- [Cross-region data landing zone Connectivity](eslz-network-considerations-cross-region.md)
