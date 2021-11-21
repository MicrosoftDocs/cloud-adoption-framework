---
title: Network architecture considerations
description: Learn network architecture considerations for data management and analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 10/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Network architecture considerations

The Cloud Adoption Framework data management and analytics promise the possibility to easily share and access datasets across multiple data domains and data landing zones without critical bandwidth limitations and without creating multiple copies of the same dataset. To deliver on that promise, different network designs have been considered, evaluated, and tested to make sure that these are compatible with the existing hub and spoke and Virtual WAN deployments of corporations.

Based on the current capabilities of Azure networking services, it's recommended to rely on a meshed network architecture. Set up VNet peering between:

1. The connectivity hub and data management zone,
2. The connectivity hub and each data landing zone,
3. The data management zone and each data landing zone
4. Each data landing zone.

:::image type="content" source="./images/network-options-network-mesh.png" alt-text="Network architecture":::

*Figure 1: Basic networking diagram for Cloud Adoption Framework data management and analytics.*

To explain the rationale behind the design, this article illustrates the advantages and disadvantages that come with each of the different network architecture approaches that were considered when designing the Cloud Adoption Framework data management and analytics. Every design pattern will be evaluated along the following criteria:

- Cost
- User access management
- Service management
- Bandwidth

> [!NOTE]
> Each scenario has been analyzed with the following cross-data landing zone use case in mind:
>
> Virtual machine B hosted in data landing zone B loads a dataset from storage account A hosted in data landing zone A. Next, it processes the dataset and finally it stores the processed dataset and in storage account B hosted in data landing zone B.

## Hub and spoke design

Many enterprises have adopted a hub and spoke network architecture.

:::image type="content" source="./images/network-options-hub-and-spoke.png" alt-text="Hub and spoke architecture" lightbox="./images/network-options-hub-and-spoke.png":::

*Figure 2: Hub and spoke architecture."

As Figure 2 illustrates, network transitivity would have to be setup in the connectivity hub in order to be able to access data in storage account A from virtual machine B. Data would traverse two VNet peerings ((2) and (5)) as well as a network virtual appliance (NVA) hosted inside the connectivity hub ((3) and (4)) before it gets loaded by the virtual machine (6) and then stored back into the storage account B (8).

### Hub and spoke user access management

With this approach, data product teams will only require write access to a resource group in the respective data landing zone and join access to their designated subnet to be able to create new services including the private endpoints in a self-service manner. Therefore, data product teams can deploy private endpoints themselves and don't require support to set up the necessary connectivity given that they get the necessary access rights to connect private endpoints to a subnet in that spoke.

### Hub and spoke service management

The most relevant benefit of this network architecture design is that it's well-known and consistent with the existing network setup of most organizations. Therefore, it's easy to explain and implement.

In addition, a centralized and Azure native DNS solution with private DNS zones can be used to provide FQDN resolution inside the Azure tenant. The use of private DNS zones also allows for the automation of the DNS A-record lifecycle through [Azure policies](architectures/policies.md). Since traffic is routed through a central network virtual appliance, network traffic that is sent from one spoke to another one can also be logged and inspected, which can be another benefit of this design.

A downside of this solution, from a service management perspective, is that the central Azure platform team must manage route tables manually. This is required to ensure the necessary transitivity between spokes to enable the process of sharing data assets across multiple data landing zones. The management of routes can become complex and error prone over time and is something that should be considered upfront. The more critical disadvantage of this network setup is the central network virtual appliance. Firstly, the network virtual appliance acts as a single point of failure and can cause serious downtime inside the data platform if there was a failure. Secondly, as the dataset sizes grow inside the data platform and as the number of cross-data landing zone use cases increases more traffic will be sent through the central network virtual appliance. Over time, this can result in gigabytes or terabytes of data that is sent through the central instance. However, the bandwidth of existing network virtual appliances is often limited to a one-or two-digit gigabyte bandwidth. Therefore, the appliance can act as a critical bottleneck limiting the traffic flowing between data landing zones and therefore limiting the shareability of data assets. The only way to overcome this issue would be to scale out the central network virtual appliance across multiple instances, which will have huge implications on cost of this solution.

### Hub and spoke cost

From a network perspective, customers have to pay for the two private endpoints of the storage accounts (charged per hour) and the ingress and egress traffic that is sent through the private endpoints to load the raw (1) and store the processed dataset (8). In addition, the customer will be charged for the ingress and egress of one VNet peering (5). Due to the statement above, the first VNet peering will not be charged (2). Lastly, customers will end up with significant cost for the central network virtual appliance when choosing this network design ((3) and (4)). The high cost will be generated either because extra licenses need to be purchased to scale out based on demand or it will be generated because of the charge per processed gigabyte as it's done with Azure Firewall.

> [!NOTE]
> When accessing a private endpoint across a peered network customers will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

### Hub and spoke bandwidth

This network design has serious limitations from a bandwidth perspective. The central network virtual appliance will become a critical bottleneck as the platform grows, which will limit cross-data landing zone use cases and sharing of datasets and most likely lead to a situation where multiple copies of datasets will be created over time.

### Hub and spoke summary

From an access management and partially from a service management perspective, this setup has benefits. But due to the critical limitations pointed out in the service management, cost and bandwidth section, this network design cannot be recommended for cross-data landing zone use cases.

## Private endpoint projection

Another design alternative that was evaluated was the projection of private endpoints across each and every landing zone. With this approach, a private endpoint for storage account A would be created each data landing zone. Therefore, this option leads to a first private endpoint in data landing zone A that is connected to the VNet in data landing zone A, a second private endpoint in data landing zone B that is connected to the VNet in data landing zone B, and so on. The same applies to storage account B and potentially other services inside the data landing zones. If the number of data landing zones is defined as *n*, one would end up with *n* private endpoints for at least all of the storage accounts and potentially other services within the data landing zones leading to an exponential growth of the number of private endpoints.

:::image type="content" source="./images/network-options-private-endpoint-projection.png" alt-text="Private endpoint projection architecture":::

Since all private endpoints of a particular service (such as storage account A) have the same FQDN (such as `storageaccounta.privatelink.blob.core.windows.net`), this solution creates challenges on the DNS layer that cannot be solved with private DNS zones. A custom DNS solution is required that is capable of resolving DNS names based on the origin/IP-address of the requestor in order to make virtual machine A connect to the private endpoints connected to the VNet in data landing zone A and make virtual machine B connect to the private endpoints connected to the VNet in data landing zone B. This can be done with a setup based on Windows servers, whereas the lifecycle of DNS A-records can be automated through a combination of activity log and Azure Functions.

With this setup, virtual machine B can load the raw dataset in storage account A by accessing it through the local private endpoint (1). After the dataset has been loaded and processed ((2) and (3)), the dataset can be stored on storage account B by directly accessing the local private endpoint (4). Data must not traverse any VNet peerings within this scenario.

### Private endpoint projection user access management

From a user access management perspective, this scenario is similar to the first option except for the fact that access rights may also be required for other data landing zones to not just create private endpoints within the designated data landing zone and VNet but also in the other data landing zones and their respective VNets. Hence, data product teams may not only require write access to a resource group in the designated data landing zone and join access to their designated subnet to be able to create new services including the private endpoints in a self-service manner, but they may also require access to a resource group and subnet inside the other data landing zones to create the respective local private endpoints.

In summary, this setup increases the complexity on the access management layer since data product teams may require few permissions not just in a single but in each and every data landing zone. In addition, it may lead to confusion and inconsistent role-based access control over time. If necessary access rights are not provided to data landing zone teams or data product teams, problems described in [Hub and spoke design](#hub-and-spoke-design) will be applicable.

### Private endpoint projection service management

Private endpoint projection has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this is not seen as disadvantage since Cloud Adoption Framework data management and analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central connectivity hub. In addition, network logs can still be captured by using network security group flow logs and other application and service level logs can be consolidated and stored by using service specific diagnostic settings. All of these logs can be captured at scale by using [Azure policies](/azure/templates/microsoft.insights/diagnosticsettings).

On the other hand, the exponential growth of the number of required private endpoints also increases the network address space required by the data platform, which is not optimal. Lastly, the above-mentioned DNS challenges are the biggest concern of this network architecture. An Azure native solution in the form of private DNS zones cannot be used. Hence, a third-party solution will be required that is capable of resolving FQDNs based on the origin/IP-address of the requestor. In addition, tools and workflows must be developed and maintained to automate the lifecycle of private DNS A-records that drastically increases the management overhead compared to the proposed [Azure Policy-driven solution](/azure/templates/microsoft.network/privateendpoints/privatednszonegroups). It would also be possible to create a distributed DNS infrastructure using private DNS zones, but with this solution DNS silos would be created which ultimately lead to issues when trying to access Private Link services hosted other landing zones within the tenant. Therefore, this is not a viable alternative.

### Private endpoint projection cost

With this network design, customers only pay for the private endpoints (charged per hour) and the ingress and egress traffic that is sent through the private endpoints to load the raw (1) and store the processed dataset (4). However, due to the exponential growth of the number of private endpoints inside the data platform extra costs must be expected and will highly depend on the number of private endpoints that are created since these are charged per hour.

> [!NOTE]
> When accessing a private endpoint across a peered network customers will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

### Private endpoint projection bandwidth

Because there are no network virtual appliances, limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

### Private endpoint projection summary

This network architecture suffers from the potential exponential growth of private endpoints, which may even cause losing track of which private endpoints are used where and for which purpose. Another limiting factor is the access management issues described above and the complexities created on the DNS layer. Therefore, this network design cannot be recommended.

## Private endpoints in connectivity hub

The third option proposes to host the private endpoints in the connectivity hub and connect them to the hub VNet. With this solution, a single private endpoint for each service would be hosted on the corporate VNet. Transitivity would also not be required due to the existing hub and spoke network architecture at most corporations and the fact that the private endpoints would be hosted in the connectivity hub with this solution. The VNet peering between the connectivity hub and data landing zones allow for a direct access.

In order to load a dataset stored in storage account A in virtual machine B, data would have to traverse a single VNet peering between the connectivity hub and the data landing zone (5). Once the dataset has been loaded and processed ((3) and (4)) the dataset must traverse the VNet peering a second time (5) before it can be stored on storage account B by accessing the private endpoint connected to the hub VNet (6).

:::image type="content" source="./images/network-options-private-endpoints-in-connectivity-hub.png" alt-text="Private endpoints in connectivity hub":::

### Private endpoints in connectivity hub user access management

When opting for this network design, data landing zone teams and data product teams must be given write permissions to a resource group in the connectivity hub subscription and join permissions to the hub VNet to be able to connect private endpoints to the hub VNet. This is not in line with the enterprise-scale landing zone base principles, since the connectivity hub is a subscription that is designated for the Azure platform team of an organization and is dedicated for hosting the necessary and shared network infrastructure of an organization, including firewalls, gateways, and network management tools. This network option would make the design inconsistent since access management principles are not followed and therefore this design alternative is something that most Azure platform teams won't approve.

### Private endpoints in connectivity hub service management

Similar to [private endpoint projection](#private-endpoint-projection), this network design has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this is not seen as disadvantage since Cloud Adoption Framework data management and analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central connectivity hub. In addition, network logs can still be captured by using network security group flow logs and extra application and service level logs can be consolidated and stored by using service specific diagnostic settings. All of these logs can be captured at scale by using [Azure policies](/azure/templates/microsoft.insights/diagnosticsettings). Also, this pattern allows for an Azure native DNS solution based on private DNS zones and allows for the automation of the DNS A-record lifecycle through [Azure policies](/azure/templates/microsoft.network/privateendpoints/privatednszonegroups).

### Private endpoints in connectivity hub cost

With this network design, customers only pay for the private endpoints (charged per hour) and the ingress and egress traffic that is sent through the private endpoints to load the raw (1) and store the processed dataset (6).

> [!NOTE]
> When accessing a private endpoint across a peered network customers will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

### Private endpoints in connectivity hub bandwidth

Because there are no network virtual appliances limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

### Private endpoints in connectivity hub summary

There are many benefits that come with this network architecture design. However, the above-mentioned inconsistencies from an access management perspective make the design subpar and so the approach does not qualify as a recommended design.

## Meshed network architecture (recommended)

The recommended design proposes the use of a network mesh, which means adding VNet peerings between all data landing zone VNets and between the data management zone and each data landing zone in addition to the existing hub and spoke network design that most organizations have setup inside their tenant. For the scenario mentioned in the introduction, data loaded from storage account A would first transition a VNet peering connection (2) that is set up between the two data landing zone VNets before it would be loaded and processed by virtual machine B ((3) and (4)). Lastly, the data can be stored on storage account B by sending the data through the local private endpoint (5). With this option, the data does not pass the connectivity hub and stays within the data platform consisting of a data management zone and one or multiple data landing zones.

:::image type="content" source="./images/network-options-meshed-network-architecture.png" alt-text="Meshed network architecture":::

### Meshed network architecture user access management

With this approach, data product teams will only require write access to their dedicated resource group in the data landing zone and join access to their designated subnet to be able to create new services including the private endpoints in a self-service manner. Therefore, data product teams can deploy private endpoints themselves and don't require support to set up the necessary connectivity if they get the necessary access rights provided to connect private endpoints to a subnet in that spoke.

### Meshed network architecture service management

Similar to [private endpoint projection](#private-endpoint-projection), this network design has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this is not seen as disadvantage since Cloud Adoption Framework data management and analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central connectivity hub. In addition, network logs can still be captured by using network security group flow logs and other application and service level logs can be consolidated and stored by using service specific diagnostic settings. All of these logs can be captured at scale by using [Azure policies](/azure/templates/microsoft.insights/diagnosticsettings). Also, this pattern allows for an Azure native DNS solution based on private DNS zones and allows for the automation of the DNS A-record lifecycle through [Azure policies](/azure/templates/microsoft.network/privateendpoints/privatednszonegroups).

### Meshed network architecture cost

With this network design, customers only pay for the private endpoints (charged per hour) and the ingress and egress traffic that is sent through the private endpoints to load the raw (1) and store the processed dataset (6). Due to the statement above, the VNet peering will not be charged (2), which is why we end up with minimal cost with this option.

> [!NOTE]
> When accessing a private endpoint across a peered network customers will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

### Meshed network architecture bandwidth

Because there are no network virtual appliances limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

### Meshed network architecture summary

The meshed network design offers maximum bandwidth at minimal cost without any compromises from a user access management perspective or on the DNS layer. Hence, this network architecture design is recommended for customers wanting to adopt Cloud Adoption Framework data management and analytics. If extra network policies need to be enforced within the data platform, it's advised to use network security groups instead of central network virtual appliances.

## Meshed network architecture conclusion

After reviewing all network architecture options from various angles and identifying pros and cons of each proposed pattern, a meshed network architecture is the clear winner. Not only from a throughput perspective, but also from a cost and management perspective the solution has tremendous benefits and therefore should be used when deploying Cloud Adoption Framework data management and analytics. Peering spoke virtual networks has not been common in the past, but not doing so has also led to various issues when starting to share datasets across domains and business units. In addition, one can also argue that Cloud Adoption Framework data management and analytics can be seen as coherent solution that just spans across multiple subscriptions. In a single subscription setup, the network traffic flow would be equal to the flow in the meshed network architecture, with the difference that, within a single subscription, users will most likely hit [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) of the platform, which is something that Cloud Adoption Framework data management and analytics wants to protect against.
