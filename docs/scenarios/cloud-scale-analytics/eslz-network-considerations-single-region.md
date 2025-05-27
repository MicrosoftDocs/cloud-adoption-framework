---
title: Single-Region Data Landing Zone Connectivity
description: Learn about single-region data landing zone connectivity for cloud-scale analytics in Azure, including service management, costs, and bandwidth considerations.
author: marvinbuss
ms.author: mabuss
ms.date: 02/21/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Single-region data landing zone connectivity

In a single-region setup, the data management landing zone, data landing zones, and all related services are established in the same region. Also, all landing zones reside in the same connectivity hub subscription. This subscription hosts shared network resources, such as a network virtual appliance (NVA) like Azure Firewall, an Azure ExpressRoute gateway, a virtual private network gateway, a hub virtual network, or an Azure Virtual WAN hub.

:::image type="content" source="./media/single-region-connectivity.png" alt-text="Diagram that shows single-region connectivity." lightbox="./media/single-region-connectivity.png" border="false":::

Based on the capabilities of Azure networking services, we recommend that you use a meshed network architecture. Establish virtual network peering between:

- The connectivity hub and the data management zone.
- The connectivity hub and each data landing zone.
- The data management zone and each data landing zone.
- Each data landing zone.

This article describes the pros and cons of each network architecture option for cloud-scale analytics.

The first section of this article focuses on a single-region pattern, where the data management zone and all data landing zones are hosted in the same region.

Each design pattern is evaluated by using the following criteria:

- Costs
- User access management
- Service management
- Bandwidth
- Latency

Each design option is analyzed with the following cross-data landing zone use case in mind.

> [!NOTE]
> Virtual machine (VM) B that's hosted in data landing zone B loads a dataset from storage account A that's hosted in data landing zone A. Then VM B processes that dataset and stores it in storage account B, which is hosted in data landing zone B.

[!INCLUDE [network-important](includes/network-important.md)]

## Meshed network architecture (Recommended)

Use a network mesh architecture when you adopt cloud-scale analytics. To implement a network mesh architecture, in addition to the existing hub-and-spoke network design setup in your tenant, you need to do two things:

- Add virtual network peerings between all data landing zone virtual networks.
- Add virtual network peerings between your data management landing zone and all data landing zones.

In the following architecture, data loaded from storage account A transits a virtual network peering connection (2) set up between the two data landing zone virtual networks. VM B (3) and (4) loads and processes the data, then sends it through the local private endpoint (5) to be stored in storage account B.

In this scenario, the data doesn't pass through the connectivity hub. It stays in the data platform that consists of a data management landing zone and one or more data landing zones.

:::image type="content" source="./images/network-options-meshed-network-architecture.png" alt-text="Diagram that shows the meshed network architecture." lightbox="./images/network-options-meshed-network-architecture.png" border="false":::

### User access management in a meshed network architecture

In a meshed network architecture design, data application teams need only two things to create new services, including private endpoints:

- Write access to their dedicated resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy private endpoints themselves. If they have the necessary access rights to connect private endpoints to a subnet in a given spoke, they can set up the necessary connectivity without extra support.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

The plus icon indicates the pros and cons of each scenario.

### Service management in a meshed network architecture

A meshed network architecture design doesn't have a NVA that might serve as a single point of failure or limit throughput. Datasets aren't sent through the connectivity hub, so your central Azure platform team has less overhead, as long as you don't need to scale out that NVA.

This design implies that the central Azure platform team can no longer inspect and log all traffic that's sent between data landing zones. However, cloud-scale analytics is a coherent platform that spans multiple subscriptions. This capability allows for scale and overcomes platform-level limitations.

With all resources hosted in a single subscription, your central Azure platform team no longer inspects all data in the central connectivity hub, either. You can still capture network logs by using network security group (NSG) flow logs. You can consolidate and store other application-level and service-level logs by using service-specific diagnostic settings.

You can capture all these logs at scale by using [Azure policy definitions for diagnostic settings](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/DiagnosticSettings).

This design also allows you to create an Azure-native Domain Name System (DNS) solution that's based on private DNS zones. You can automate the DNS A-record lifecycle via [Azure policy definitions for private DNS groups](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture cost

> [!NOTE]
> When you [access a private endpoint across a peered network](https://azure.microsoft.com/pricing/details/private-link/), you're only charged for the private endpoint itself and not for the virtual network peering.

In this network design, you only pay for:

- Your private endpoints, per hour.

- The ingress and egress traffic sent through your private endpoints to load your raw dataset (1) and store your processed dataset (6).

Virtual network peering isn't charged (2), which is why this option has minimal cost.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in a meshed network architecture

This design has no known bandwidth or latency limitations because no NVAs limit throughput for its cross-data landing zone data exchange. The design is limited only by the speed of fiber-optic cables in the datacenters.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Meshed network architecture summary

If you plan to adopt cloud-scale analytics, we recommend that you use the meshed network design. A meshed network provides maximum bandwidth and low latency at minimal cost without compromising user access management or the DNS layer.

If you need to enforce other network policies in the data platform, use NSGs instead of central NVAs.

## Traditional hub-and-spoke architecture (Not recommended)

The hub-and-spoke network architecture design is a common choice that many enterprises use. In this design, network transitivity is established in the connectivity hub to access data in storage account A from VM B. Data traverses two virtual network peerings (2) and (5) and an NVA that's hosted inside the connectivity hub (3) and (4). The VM (6) loads the data and stores it back into storage account B (8).

:::image type="content" source="./images/network-options-hub-and-spoke.png" alt-text="Diagram that shows a hub-and-spoke architecture." lightbox="./images/network-options-hub-and-spoke.png" border="false":::

### User access management in a traditional hub-and-spoke architecture

In a traditional hub-and-spoke design, data application teams need only two things to create new services, including private endpoints:

- Write access to their resource group in the data landing zone
- Join access to their designated subnet

In this design, data application teams can deploy private endpoints themselves. If they have the necessary access rights to connect private endpoints to a subnet in a given spoke, they can set up the necessary connectivity without extra support.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Service management in a traditional hub-and-spoke architecture

This network design is well-known and consistent with existing network setups for most organizations. This familiarity makes the design easy to explain and implement. You can also use a centralized Azure-native DNS solution with private DNS zones to provide FQDN resolution inside your Azure tenant. You can use private DNS zones to automate the DNS A-record lifecycle via [Azure policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Another benefit of this design is that traffic is routed through a central NVA, so network traffic sent from one spoke to another spoke can be logged and inspected.

One downside of this design is that your central Azure platform team has to manually manage route tables. This requirement helps ensure transitivity between spokes, which enables data asset sharing across multiple data landing zones. Route management can become complex and error-prone over time, so you must consider it from the start.

Another downside to this network setup is how your central NVA is set up. The NVA functions as a single point of failure and can cause serious downtime inside the data platform if a failure occurs. As dataset sizes increase in a data platform and the number of cross-data landing zone use cases increases, more traffic is sent through the central NVA.

Over time, this situation can result in gigabytes or even terabytes of data being sent through the central instance. Because the bandwidth of existing NVAs is often limited to just one-digit or two-digit gigabyte throughput, the central NVA can become a bottleneck that severely limits traffic flow between data landing zones and limits data asset shareability.

The only way to avoid this problem is to scale out your central NVA across multiple instances, which has major cost implications for this design.

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Traditional hub-and-spoke architecture cost

> [!NOTE]
> When you [access a private endpoint across a peered network](https://azure.microsoft.com/pricing/details/private-link/), you're only charged for the private endpoint itself and not for the virtual network peering.

For this network, you're charged per hour for the private endpoints of your storage accounts. You're also charged for ingress and egress traffic sent through the private endpoints to load a raw dataset (1) and store the processed dataset (8).

Your customer is charged for the ingress and egress of one virtual network peering (5). The first virtual network peering isn't charged (2).

This network design (3) and (4) results in a high central NVA cost. You have to either purchase extra licenses and scale out the central NVA based on demand or pay the charge processed per gigabyte, similar to Azure Firewall charges.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Bandwidth and latency in a traditional hub-and-spoke architecture

This network design has serious bandwidth limitations. The central NVA becomes a critical bottleneck as your platform grows, which limits cross-data landing zone use cases and dataset sharing. It can also create multiple copies of datasets over time.

This design also heavily affects latency, which becomes especially critical in real-time analytics scenarios.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Traditional hub-and-spoke architecture summary

This hub-and-spoke network design has access management and some service management benefits. But because of critical limitations of service management and bandwidth and latency, we can't recommend this network design for cross-data landing zone use cases.

## Private endpoint projection architecture (Not recommended)

Another design option is the projection of private endpoints across all landing zones. In this design, a private endpoint for storage account A is created in each landing zone. So the first private endpoint in data landing zone A connects to the virtual network in data landing zone A and the second private endpoint connects to the virtual network in data landing zone B. This configuration repeats for each landing zone so that they all have their own dedicated connection.

The same setup applies to storage account B, and potentially to other services inside the data landing zones. If you define the number of data landing zones as *n*, then you have *n* private endpoints for at least all the storage accounts and potentially other services in the data landing zones. This situation results in an exponential increase in the number of private endpoints.

:::image type="content" source="./images/network-options-private-endpoint-projection.png" alt-text="Diagram that shows the private endpoint projection architecture." lightbox="./images/network-options-private-endpoint-projection.png" border="false":::

Because all private endpoints of a specific service (like storage account A) have the same FQDN (like `storageaccounta.privatelink.blob.core.windows.net`), this solution creates challenges in the DNS layer that private DNS zones can't solve. You need a custom DNS solution that can resolve DNS names based on the origin or IP address of the requestor. This setup allows you to make VM A connect to the private endpoints connected to the virtual network in data landing zone A, and to make VM B connect to the private endpoints that are connected to the virtual network in data landing zone B. You can achieve this connection by using a Windows Server-based setup. In contrast, you can automate the DNS A-records lifecycle through a combination of the Azure Monitor activity log and Azure Functions.

In this setup, you can load the raw dataset in storage account A into VM B by accessing the dataset through the local private endpoint (1). After you load and process the dataset (2) and (3), you can store it in storage account B by directly accessing the local private endpoint (4). In this scenario, data must not traverse any virtual network peerings.

### User access management in the private endpoint projection architecture

This design's approach to user access management is similar to that of the [meshed network architecture](#meshed-network-architecture-recommended). In this design, you can require access rights for other data landing zones to create private endpoints, not only in a designated data landing zone and virtual network, but also in other data landing zones and their respective virtual networks. Because of this approach, your data application teams require three things to create new services themselves:

- Write access to a resource group in a designated data landing zone

- Join access to their designated subnet

- Access to a resource group and subnet inside all the other data landing zones to create their respective local private endpoints

This network design increases complexity in your access management layer because your data application teams require permissions in all data landing zones. The design can also be confusing and result in inconsistent role-based access control over time.

If data landing zone teams and data application teams aren't given necessary access rights, problems can occur, similar to the problems in the [traditional hub-and-spoke architecture](#traditional-hub-and-spoke-architecture-not-recommended).

Summary: :::image type="icon" source="./media/minus-icon.png":::

### Service management in the private endpoint projection architecture

This network design is similar to the [meshed network architecture](#meshed-network-architecture-recommended) design, but it has the advantage of not relying on an NVA, which can become a single point of failure or limit throughput.

It also reduces management overhead for your central Azure platform team by not sending datasets through the connectivity hub because there's no need to scale out the NVA. This change implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform that spans multiple subscriptions. This capability allows for scale and overcomes platform-level limitations.

With all resources hosted in a single subscription, traffic isn't inspected in the central connectivity hub. You can still capture network logs by using NSG flow logs, and you can consolidate and store other application and service-level logs by using service-specific diagnostic settings. You can capture all these logs at scale by using Azure policies. However, the network address space that your data platform requires increases because of the exponential increase in required private endpoints, which isn't optimal.

The major concerns about this network architecture are its DNS challenges. You can't use an Azure-native solution in the form of private DNS zones, so this architecture requires a non-Microsoft solution that can resolve FQDNs based on the origin or IP address of the requestor. You also have to develop and maintain tools and workflows to automate private DNS A-records, which significantly increase management overhead compared to the [Azure policy-driven solution](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

You can create a distributed DNS infrastructure by using private DNS zones, but this infrastructure creates DNS islands. DNS islands can cause problems when you try to access private link services hosted in other landing zones in your tenant. Therefore, this design isn't a viable option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Private endpoint projection architecture cost

> [!NOTE]
> When you [access a private endpoint across a peered network](https://azure.microsoft.com/pricing/details/private-link/), you're only charged for the private endpoint itself and not for the virtual network peering.

In this network design, you're only charged for the private endpoints per hour and the ingress and egress traffic sent through those private endpoints to load raw datasets (1) and store processed datasets (4). However, you can expect extra costs because of the exponential increase in the number of your data platform's private endpoints. Because you're charged per hour, the amount of extra cost highly depends on how many private endpoints are created.

Summary: :::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in the private endpoint projection architecture

This design has no known bandwidth and latency limitations because it doesn't have NVAs to limit throughput for cross-data landing zone data exchange. The design is limited only by the speed of fiber-optic cables in the datacenters.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Private endpoint projection architecture summary

The exponential growth of private endpoints in this network architecture can cause you to lose track of which private endpoints are used for what purpose and in which location. You're also limited by access management problems and DNS layer complexities. Because of these problems, we don't recommend this network design for cross-data landing zone use cases.

## Private endpoints in connectivity hub architecture (Not recommended)

Another network option is to host private endpoints in your connectivity hub and connect them to the hub virtual network. In this solution, you host a single private endpoint for each service on your corporate virtual network. Because of the existing hub-and-spoke network architecture at most corporations, and the fact that your connectivity hub hosts your private endpoints in this solution, transitivity isn't required. Virtual network peering between your connectivity hub and data landing zones enables direct access.

Data traverses a single virtual network peering between the connectivity hub and data landing zone to load a dataset that's stored in storage account A in VM B. After that dataset is loaded and processed (3) and (4), it traverses the same virtual network peering a second time (5) before finally getting stored in storage account B through the private endpoint that's connected to the hub virtual network (6).

:::image type="content" source="./images/network-options-private-endpoints-in-connectivity-hub.png" alt-text="Diagram that shows private endpoints in the connectivity hub architecture." lightbox="./images/network-options-private-endpoints-in-connectivity-hub.png" border="false":::

### User access management in the connectivity hub architecture

In this network design, your data landing zone teams and data application teams need two things to be able to connect private endpoints to the hub virtual network:

- Write permissions to a resource group in your connectivity hub subscription
- Join permissions to the hub virtual network

Your connectivity hub is designated for your organization's Azure platform team and is dedicated to hosting your organization's necessary and shared network infrastructure. This infrastructure includes firewalls, gateways, and network management tools. This network option makes that design inconsistent because it doesn't follow access management principles from the enterprise-scale landing zone base principles. Therefore, most Azure platform teams are unlikely to approve this design option.

Summary: :::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png"::::::image type="icon" source="./media/minus-icon.png":::

### Service management in the connectivity hub architecture

This design is similar to the [meshed network architecture](#meshed-network-architecture-recommended) but has no NVA that could serve as a single point of failure or limit throughput. It also reduces management overhead for your central Azure platform team by not sending datasets through the connectivity hub because there's no need to scale out the virtual appliance. This design implies that the central Azure platform team can no longer inspect and log all traffic sent between data landing zones. However, cloud-scale analytics is a coherent platform that spans multiple subscriptions, which allows for scale and overcomes platform-level limitations.

With all resources hosted in a single subscription, traffic isn't inspected in the central connectivity hub. You can still capture network logs by using NSG flow logs, and you can consolidate and store other application and service-level logs by using service-specific diagnostic settings. You can capture all these logs at scale by using Azure policies.

This design also allows you to create an Azure-native DNS solution that's based on private DNS zones and automate the DNS A-record lifecycle through [Azure policies](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Connectivity hub architecture cost

> [!NOTE]
> When you [access a private endpoint across a peered network](https://azure.microsoft.com/pricing/details/private-link/), you're only charged for the private endpoint itself and not for the virtual network peering.

In this network design, you're only charged for your private endpoints per hour and ingress and egress traffic sent through those private endpoints to load a raw dataset (1) and store the processed dataset (6).

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Bandwidth and latency in the connectivity hub architecture

This design has no known bandwidth and latency limitations because it doesn't have NVAs to limit throughput for cross-data landing zone data exchange. The design is limited only by the speed of fiber-optic cables in the datacenters.

Summary: :::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png"::::::image type="icon" source="./media/plus-icon.png":::

### Private endpoints in the connectivity hub architecture summary

This network architecture design has multiple benefits, but its access management inconsistencies make it subpar. So we don't recommend this design choice.

## Single-region data landing zone connectivity conclusion

Out of all the reviewed network architecture options and their advantages and disadvantages, the [meshed network architecture](#meshed-network-architecture-recommended) is the most suitable. It provides significant benefits for throughput, cost, and management. These benefits make it the preferred choice for deploying cloud-scale analytics. Peering spoke virtual networks isn't common, which results in problems with sharing datasets across domains and business units.

Cloud-scale analytics is a coherent solution that spans multiple subscriptions. In a single subscription setup, network traffic flow equals the flow in the meshed network architecture. Users are likely to reach the platform's [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits), which cloud-scale analytics tries to prevent.

## Next step

> [!div class="nextstepaction"]
> [Cross-region data landing zone connectivity](eslz-network-considerations-cross-region.md)
