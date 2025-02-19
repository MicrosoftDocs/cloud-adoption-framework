---
title: Single-Region Data Landing Zone Connectivity
description: Learn about single-region data landing zone connectivity for cloud-scale analytics in Azure and how to improve data management and processing.
author: marvinbuss
ms.author: mabuss
ms.date: 02/21/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Single-region data landing zone connectivity

In a single-region setup, the data management landing zone, data landing zones, and all associated services are established within the same region. All landing zones reside within the same connectivity hub subscription. This subscription hosts shared network resources, which can include a network virtual appliance (such as Azure Firewall), an Azure ExpressRoute gateway, a virtual private network gateway, a hub virtual network, or a virtual WAN hub.

:::image type="content" source="./media/single-region-connectivity.png" alt-text="Diagram that shows single-region connectivity." lightbox="./media/single-region-connectivity.png":::

Based on the current capabilities of Azure networking services, we recommend that you use a meshed network architecture. Set up virtual network peering between:

- The connectivity hub and the data management zone
- The connectivity hub and each data landing zone
- The data management zone and each data landing zone
- Each data landing zone

This article describes the pros and cons of each network architecture option considered for cloud-scale analytics.

The first section of this article focuses on a single-region pattern, where the data management zone and all data landing zones are hosted in the same region.

Each design pattern is evaluated by using the following criteria:

- Costs
- User access management
- Service management
- Bandwidth
- Latency

Each design option is analyzed with the following cross-data landing zone use-case in mind.

> [!NOTE]
> *Virtual machine B (VM B) hosted in data landing zone B loads a dataset from storage account A hosted in data landing zone A. Then VM B processes that dataset and stores it in storage account B, which is hosted in data landing zone B.*

[!INCLUDE [network-important](includes/network-important.md)]

## Meshed network architecture (Recommended)

Use a network mesh architecture when you adopt cloud-scale analytics. In addition to the existing hub-and-spoke network design set up within your tenant, you need to do two things to implement a network mesh architecture:

- Add virtual network peerings between all data landing zone virtual networks.
- Add virtual network peerings between your data management landing zone and all data landing zones.

In our example scenario, data loaded from storage account A transits a virtual network peering connection (2) set up between the two data landing zone virtual networks. It's loaded and processed by VM B (3) and (4), then sent through the local private endpoint (5) to be stored in storage account B.

In this scenario, the data doesn't pass through the connectivity hub. It stays within the data platform that consists of a data management landing zone and one or more data landing zones.

:::image type="content" source="./images/network-options-meshed-network-architecture.png" alt-text="Diagram that shows the meshed network architecture." lightbox="./images/network-options-meshed-network-architecture.png":::

### User access management in a meshed network architecture

In a meshed network architecture design, data application teams only require two things to create new services (including private endpoints):

- Write access to their dedicated resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy private endpoints themselves. As long as they have the necessary access rights to connect private endpoints to a subnet in a given spoke, your teams need no support when they set up the necessary connectivity.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Service management in meshed network architecture

In a meshed network architecture design, no network virtual appliance acts as a single point of failure or throttling. The lack of datasets being sent through the connectivity hub reduces your central Azure platform team's overhead, provided you don't need to scale out that virtual appliance.

This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform that spans multiple subscriptions. This capability allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, your central Azure platform team no longer inspects all data in the central connectivity hub, either. You can still capture network logs by using  network security group (NSG) flow logs. You can consolidate and store other application and service level logs by using service-specific diagnostic settings.

You can capture all of these logs at scale by using [Azure policy definitions for diagnostic settings](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/DiagnosticSettings).

This design also allows you to create an Azure native DNS solution based on private DNS zones. You can automate the DNS A-record lifecycle through [Azure policy definitions for private DNS groups](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture cost

> [!NOTE]
> When you access a private endpoint across a peered network, you're only charged for the private endpoint itself, not for the virtual network peering. For more information, see [FAQ: How will billing work when you access a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you only pay for:

- Your private endpoints (per hour)
- The ingress and egress traffic sent through your private endpoints to load your raw dataset (1) and store your processed dataset (6)

Virtual network peering won't be charged (2), which is why this option has minimal cost.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in a meshed network architecture

This design has no known bandwidth or latency limitations because no network virtual appliances limit throughput for its cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture summary

If you plan to adopt cloud-scale analytics, we recommend that you use the meshed network design. A meshed network offers maximum bandwidth and low latency at minimal cost, yet makes no compromises regarding user access management or the DNS layer.

If you need to enforce other network policies within the data platform, use NSGss rather than central network virtual appliances.

## Traditional hub-and-spoke architecture (Not recommended)

Hub and spoke network architecture design is the most obvious option, and one that many enterprises have adopted. In it, network transitivity is set up in the connectivity hub to access data in storage account A from VM B. Data traverses two virtual network peerings (2) and (5) and a network virtual appliance hosted inside the connectivity hub (3) and (4). The VM (6) loads the data and stores it back into storage account B.(8).

:::image type="content" source="./images/network-options-hub-and-spoke.png" alt-text="Diagram that shows a hub-and-spoke architecture." lightbox="./images/network-options-hub-and-spoke.png":::

### User access management in traditional hub-and-spoke architecture

In a traditional hub and spoke design, data application teams only require two things to create new services (including private endpoints):

- Write access to their resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy private endpoints themselves. As long as they have the necessary access rights to connect private endpoints to a subnet in a given spoke, your teams need no support when setting up the necessary connectivity.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Service management in traditional hub-and-spoke architecture

This network design is well-known and consistent with the existing network setup for most organizations. This familiarity makes the design easy to explain and implement. You can also use a centralized Azure-native DNS solution with private DNS zones to provide FQDN resolution inside your Azure tenant. Using private DNS zones allows you to automate the DNS A-record lifecycle through [Azure policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Another benefit of this design is that traffic is routed through a central network virtual appliance, so network traffic sent from one spoke to another can be logged and inspected.

One downside of this design is that your central Azure Platform team has to manually manage Route Tables. This is necessary to ensure transitivity between spokes, which enables data asset sharing across multiple data landing zones. Route management can become complex and error-prone over time and must be considered upfront.

Another downside to this network setup is the way your central network virtual appliance is set up. The network virtual appliance functions as a single point of failure and can cause serious downtime inside the data platform if a failure occurs. Also, as dataset sizes increase within a data platform and the number of cross-data landing zone use cases increases, more traffic is sent through the central network virtual appliance.

Over time, this can result in gigabytes or even terabytes of data being sent through the central instance. Because the bandwidth of existing network virtual appliances is often limited to just a one- or two-digit gigabyte throughput, the central network virtual appliance can become a bottleneck that critically limits traffic flow between data landing zones and limits data asset shareability.

The only way to avoid this problem is to scale out your central network virtual appliance across multiple instances, which has major cost implications for this design.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Traditional hub-and-spoke architecture cost

> [!NOTE]
> When you access a private endpoint across a peered network, you're only ever charged for the private endpoint itself and not for the virtual network peering. You can read the official statement in [FAQ: How will billing work when you access a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

For this network, you're charged per hour for your storage accounts' private endpoints. You're also charged for ingress and egress traffic sent through the private endpoints to load a raw dataset (1) and store the processed dataset (8).

Your customer is charged for the ingress and egress of one virtual network peering (5). As previously mentioned, the first virtual network peering isn't charged (2).

You end up with a high central network virtual appliance cost if you use this network design ((3) and (4)). You have to either purchase extra licenses and scale the central network virtual appliance out based on demand or pay the charge processed per gigabyte as it's done with Azure Firewall.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Bandwidth and latency in traditional hub-and-spoke architecture

This network design has serious bandwidth limitations. The central network virtual appliance becomes a critical bottleneck as your platform grows, which limits cross-data landing zone use cases and dataset sharing. It also likely creates multiple copies of datasets over time.

This design also heavily affects latency, which becomes especially critical in real-time analytics scenarios.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Traditional hub-and-spoke architecture summary

This hub and spoke network design has access management and some service management benefits, but due to critical limitations of service management and bandwidth and latency, we can't recommend this network design for cross-data landing zone use cases.

## Private endpoint projection architecture (Not recommended)

Another design option is the projection of private endpoints across each and every landing zone. In this design, a private endpoint for storage account A is created in each landing zone. This results in a first private endpoint in data landing zone A connected to the virtual network in data landing zone A, a second private endpoint connected to the virtual network in data landing zone B, and so on.

The same applies to storage account B, and potentially to other services inside the data landing zones. If we define the number of data landing zones as *n*, then we end up with *n* private endpoints for at least all the storage accounts and potentially other services within the data landing zones as well. This results in an exponential increase in the number of private endpoints.

:::image type="content" source="./images/network-options-private-endpoint-projection.png" alt-text="Diagram that shows the private endpoint projection." lightbox="./images/network-options-private-endpoint-projection.png":::

Because all private endpoints of a specific service (for example, storage account A) have the same FQDN (such as `storageaccounta.privatelink.blob.core.windows.net`), this solution creates challenges in the DNS layer that can't be solved by using private DNS zones. You instead need a custom DNS solution capable of resolving DNS names based on the origin/IP address of the requestor. This allows you to make VM A connect to the private endpoints connected to the virtual network in data landing zone A, and to make VM B connect to the private endpoints connected to the virtual network in data landing zone B. You can do this with a Windows Server-based setup, whereas you can automate the DNS A-records lifecycle through a combination of Activity Log and Azure Functions.

In this setup, you can load the raw dataset in storage account A into VM B by accessing the dataset through the local private endpoint (1). After you load and process the dataset ((2) and (3)), you can store it on storage account B by directly accessing the local private endpoint (4). In this scenario, data must not traverse any virtual network peerings.

### User access management in the private endpoint Projection architecture

This design's approach to user access management is similar to that of the [meshed network architecture](#meshed-network-architecture-recommended). However, in this design, you can require access rights for other data landing zones, to create private endpoints not just within a designated data landing zone and virtual network but also in other data landing zones and their respective virtual networks.

Because of this, your data application teams require three things, not two, to be able to create new services themselves:

- Write access to a resource group in a designated data landing zone
- Join access to their designated subnet
- Access to a resource group and subnet inside all the other data landing zones to create their respective local private endpoints

This network design increases complexity in your access management layer Because your data application teams require permissions in every single data landing zone. The design can also be confusing and lead to inconsistent role-based access control over time.

If data landing zone teams and data application teams aren't given necessary access rights, problems described in [traditional hub-and-spoke architecture](#traditional-hub-and-spoke-architecture-not-recommended) will occur.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Service management in the private endpoint projection architecture

This network design is similar to the [meshed network architecture](#meshed-network-architecture-recommended) design, but it provides the advantage of not relying on a network virtual appliance, which can become a single point of failure or throttle throughput.

It also reduces management overhead for your central Azure platform team by not sending datasets through the connectivity hub, because there's no need to scale out the virtual appliance. This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, traffic isn't inspected in the central connectivity hub. You can still capture network logs by using NSG flow logs, and you can consolidate and store other application and service level logs by using service-specific Diagnostic Settings. You can capture all of these logs at scale by using Azure policies. On the other hand, the network address space required by your data platform increases due to the exponential increase in required private endpoints, which isn't optimal.

The major concerns regarding this network architecture are its previously mentioned DNS challenges. You can't use an Azure native solution in the form of private DNS zones, so this architecture requires a non-Microsoft solution capable of resolving FQDNs based on the origin/IP address of the requestor. You also have to develop and maintain tools and workflows to automate Private DNS A-records, which drastically increase management overhead compared to the proposed [Azure policy driven solution](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

You can create a distributed DNS infrastructure by using private DNS zones, but this creates DNS islands, which ultimately cause problems when you try to access private link services hosted in other landing zones within your tenant. Therefore, this design isn't a viable option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Private endpoint projection architecture cost

> [!NOTE]
> When you access a private endpoint across a peered network, you're only ever charged for the private endpoint itself and not for the virtual network peering. You can read the official statement in [FAQ: How will billing work when you access a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you're only charged for the private endpoints (per hour) and the ingress and egress traffic sent through those private endpoints to load raw datasets (1) and store processed datasets (4). However, extra costs must be expected because of the exponential increase in the number of your data platform's private endpoints. Because you're charged per hour, the amount of extra cost highly depends on how many private endpoints are created.

Summary: :::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in the private endpoint projection architecture

This design has no known bandwidth and latency limitations because it has no network virtual appliances limiting throughput for cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Private endpoint projection architecture summary

The exponential growth of private endpoints in this network architecture can cause you to lose track of which private endpoints are used for what purpose in which location. You're also limited by access management problems and DNS layer complexities. Because of these problems, we can't recommend this network design for cross-data landing zone use cases.

## Private endpoints in connectivity hub architecture (Not recommended)

Another network option is to host private endpoints in your connectivity hub and connect them to the hub virtual network. In this solution, you host a single private endpoint for each service on your corporate virtual network. Due to the existing hub and spoke network architecture at most corporations, and the fact that your connectivity hub hosts your private endpoints in this solution, transitivity isn't required. Virtual network peering between your connectivity hub and data landing zones allows for direct access.

Data traverses a single virtual network peering between the connectivity hub and data landing zone in order to load a dataset stored in storage account A in VM B. After that dataset is loaded and processed ((3) and (4)), it traverses the same virtual network peering a second time (5) before finally getting stored in storage account B through the private endpoint connected to the hub virtual network (6).

:::image type="content" source="./images/network-options-private-endpoints-in-connectivity-hub.png" alt-text="Diagram that shows private endpoints in the connectivity hub." lightbox="./images/network-options-private-endpoints-in-connectivity-hub.png":::

### User access management in connectivity hub architecture

In this network design, your data landing zone teams and data application teams need two things to be able to connect private endpoints to the hub virtual network:

- Write permissions to a resource group in your connectivity hub subscription
- Join permissions to the hub virtual network

Your connectivity hub is designated for your organization's Azure platform team and is dedicated to hosting your organization's necessary and shared network infrastructure (including firewalls, gateways, and network management tools). This network option makes that design inconsistent because it doesn't follow access management principles from the enterprise-scale landing zone base principles. Therefore, most Azure platform teams won't approve this design option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Service management in connectivity hub architecture

This design, while similar to the [meshed network architecture](#meshed-network-architecture-recommended), has no network virtual appliance acting as a single point of failure or throttling throughput. It also reduces management overhead for your central Azure platform team by not sending datasets through the connectivity hub, because there's no need to scale out the virtual appliance. This implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform spanning multiple subscriptions, which allows for scale and overcomes platform-level limitations, so that isn't a disadvantage.

With all resources hosted within a single subscription, traffic isn't inspected in the central connectivity hub. You can still capture network logs by using NSG flow logs, and you can consolidate and store other application and service level logs by using service-specific Diagnostic Settings. You can capture all of these logs at scale by using Azure policies.

This design also allows you to create an Azure native DNS solution based on private DNS zones, and allows you to automate the DNS A-record lifecycle through [Azure policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Connectivity hub architecture cost

> [!NOTE]
> When you access a private endpoint across a peered network, you're only charged for the private endpoint itself and not for the virtual network peering. You can read the official statement in [FAQ: How will billing work when you access a private endpoint from a peered network?](https://azure.microsoft.com/pricing/details/private-link/).

In this network design, you're only charged for your private endpoints (per hour) and ingress and egress traffic sent through those private endpoints to load a raw dataset (1) and store the processed dataset (6).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in connectivity hub architecture

This design has no known bandwidth and latency limitations because it has no network virtual appliances limiting throughput for cross-data landing zone data exchange. The design's only limiting factor is the physical limit of our datacenters (speed of fiber-optic cables).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Private endpoints in connectivity hub architecture summary

This network architecture design has multiple benefits, but its access management inconsistencies make it subpar. So, we can't recommend this design approach.

## Single-region data landing zone connectivity conclusion

Out of all reviewed network architecture options and their pros and cons, [meshed network architecture](#meshed-network-architecture-recommended) is the clear winner. It has tremendous benefits for throughput and for cost and management, which is why we recommend you use it when you deploy cloud-scale analytics. Peering spoke virtual networks isn't common, and this results in problems with sharing datasets across domains and business units.

You can view cloud-scale analytics as a coherent solution that spans multiple subscriptions. In a single subscription setup, network traffic flow equals the flow in the meshed network architecture. Within a single subscription setup, users will most likely hit the platform's [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits), which cloud-scale analytics aims to avoid.

## Next step

- [Cross-region data landing zone connectivity](eslz-network-considerations-cross-region.md)
