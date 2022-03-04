---
title: Single-region data landing zone Connectivity
description: Learn single-region connectivity for cloud scale analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 02/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Single-region data landing zone Connectivity

In the single-region setup, the data management landing zone, the data landing zones as well as all the services within them are set up in the same region. Also, all landing zones are connected to the same connectivity hub subscription, where shared network resources including a network virtual appliance (network virtual appliance) like an Azure Firewall, an ExpressRoute Gateway, a virtual private network (VPN) Gateway, the hub virtual network in a hub and spoke architecture or the virtual WAN (vWAN) Hub in a vWan setup are hosted.

:::image type="content" source="./images/single-region-connectivity.png" alt-text="Single Region Connectivity":::
*Figure 1: Single Region Connectivity.*

Based on the current capabilities of Azure Networking Services it's recommended to rely on a meshed network architecture. What this means is that it's recommended to set up Vnet peering between:

1. The Connectivity Hub and Data Management Zone,
2. The Connectivity Hub and each Data Landing Zone,
3. The Data Management Zone and each Data Landing Zone and
4. Each Data Landing Zone.

To explain the rationale behind the recommended design, this article will illustrate the advantages and disadvantages that come with each of the different network architecture approaches that were considered when designing the Data Management and Analytics Scenario. The first section of this article will only look at a single-region pattern, where the Data Management Zone as well as all the Data Landing Zones are hosted in the same region.

Every considered design pattern will be evaluated along the following criteria:

- Cost
- User Access Management
- Service Management
- Bandwidth
- Latency

Each scenario will be analyzed with the following cross-data landing zone use-case in mind:

> [!NOTE]
> *Virtual machine B (VM B) hosted in data landing zone B loads a dataset from Storage Account A hosted in data landing zone A. Next, it processes the dataset and finally it stores the processed dataset and in Storage Account B hosted in data landing zone B.*

[!INCLUDE [network-important](includes/network-important.md)]

## Meshed Network Architecture (Recommended)

The recommended design proposes the use of a network mesh, which means adding Vnet peerings between all data landing zone Vnets and between the data management landing zone and each data landing zone in addition to the existing hub and spoke network design that most organizations have setup inside their tenant. For the scenario mentioned in the introduction, data loaded from Storage Account A would first transition a Vnet peering connection (2) that is set up between the two data landing zone Vnets before it would be loaded and processed by VM B ((3) and (4)). Lastly, the data can be stored on Storage Account B by sending the data through the local Private Endpoint (5). With this option, the data doesn't pass the Connectivity Hub and stays within the Data Platform consisting of a data management landing zone and one or multiple data landing zones.

:::image type="content" source="./images/network-options-meshed-network-architecture.png" alt-text="Meshed Network Architecture":::
*Figure 2: Meshed Network Architecture.*

### User Access Management in a Meshed Network Architecture

With this solution approach data application teams will only require write access to their dedicated resource group in the data landing zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner. Therefore, data application teams can deploy Private Endpoints themselves and don't require support to set up the necessary connectivity if they get the necessary access rights provided to connect Private Endpoints to a subnet in that Spoke.

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Service Management in a Meshed Network Architecture

This network design has the benefit that there's no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity Hub also reduces the management overhead for the central Azure platform team, as there's no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this isn't seen as disadvantage since the Data Management and Analytics Scenario can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity Hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and other application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/). Also, this pattern allows for an Azure native DNS solution based on Private DNS Zones and allows for the automation of the DNS A-record lifecycle through [Azure Policies](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Cost in a Meshed Network Architecture

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, you only pay for the Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (6). Due to the statement above, the Vnet peering won't be charged (2), which is why we end up with minimal cost with this option.

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Bandwidth and Latency in a Meshed Network Architecture

Because there are no network virtual appliances limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth and latency perspective. Physical limits in our datacenters are the only limiting factor (speed of fibre cables/light).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Summary Meshed Network Architecture

The meshed network design offers maximum bandwidth and low latency at minimal cost without any compromises from a user access management perspective or on the DNS layer. Hence, this network architecture design is the recommended for you wanting to adopt the Data Management and Analytics Scenario. If other network policies need to be enforced within the Data Platform, it's advised to use Network Security Groups instead of central network virtual appliances.

## Traditional hub and spoke Design (NOT Recommended)

The most obvious option is to use the traditional hub and spoke network architecture that many enterprises have adopted. Network transitivity would have to be set up in the Connectivity Hub in order to be able to access data in Storage Account A from VM B. Data would traverse two Vnet peerings ((2) and (5)) as well as a Network Virtual Appliance (network virtual appliance) hosted inside the Connectivity Hub ((3) and (4)) before it gets loaded by the virtual machine (6) and then stored back into the Storage Account B (8).

:::image type="content" source="./images/network-options-hub-and-spoke.png" alt-text="Hub and spoke architecture":::
*Figure 3: Hub and spoke architecture.*

### User Access Management in a traditional hub and spoke design

With this solution approach, data application teams will only require write access to a resource group in the respective data landing zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner. Therefore, data application teams can deploy Private Endpoints themselves and don't require support to set up the necessary connectivity given that they get the necessary access rights to connect Private Endpoints to a subnet in that Spoke.

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Service Management in a traditional hub and spoke design

The most relevant benefit of this network architecture design is that it's well-known and consistent with the existing network setup of most organizations. Therefore, it's easy to explain and implement. In addition, a centralized and Azure native DNS solution with Private DNS Zones can be used to provide FQDN resolution inside the Azure tenant. The use of Private DNS Zones also allows for the automation of the DNS A-record lifecycle through [Azure Policies](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/). Since traffic is routed through a central network virtual appliance, network traffic that is sent from one Spoke to another one can also be logged and inspected, which can be another benefit of this design.

A downside of this solution from a service management perspective is that the central Azure Platform team must manage Route Tables manually. This is required to ensure the necessary transitivity between Spokes to enable the process of sharing data assets across multiple data landing zones. The management of routes can become complex and error-prone over time and is something that should be considered upfront. The more critical disadvantage of this network setup is the central network virtual appliance. Firstly, the network virtual appliance acts as a single point of failure and can cause serious downtime inside the data platform in a failure. Secondly, as the dataset sizes grow inside the data platform and as the number of cross-data landing zone use cases increases more traffic will be sent through the central network virtual appliance. Over time, this can result in gigabytes or terabytes of data that is sent through the central instance. However, the bandwidth of existing network virtual appliances is often limited to a one- or two-digit gigabyte throughput. Therefore, the appliance can act as a critical bottleneck limiting the traffic flowing between data landing zones and therefore limiting the shareability of data assets. The only way to overcome this issue would be to scale out the central network virtual appliance across multiple instances, which will have huge implications on cost of this solution.

Summary: :::image type="icon" source="./images/minusicon.png":::

### Cost in a traditional hub and spoke design

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

From a network perspective, you have to pay for the two Private Endpoints of the Storage Accounts (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (8). In addition, the customer will be charged for the ingress and egress of one Vnet peering (5). Due to the statement above, the first Vnet peering won't be charged (2). Lastly, you'll end up with significant cost for the central network virtual appliance when choosing this network design ((3) and (4)). The high cost will be generated either because extra licenses need to be purchased to scale out based on demand or it will be generated because of the charge per processed gigabyte as it is done with Azure Firewall.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Bandwidth & Latency in a traditional hub and spoke design

This network design has serious limitations from a bandwidth perspective. The central network virtual appliance will become a critical bottleneck as the platform grows, which will limit cross-data landing zone use cases and sharing of datasets and most likely lead to a situation where multiple copies of datasets will be created over time. In addition to bandwidth, latency will be heavily affected by that network design, which is especially critical for real-time analytics scenarios.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Summary Traditional hub and spoke Design

From an access management and partially from a service management perspective, this setup has benefits. But due to the critical limitations pointed out in the service management, cost and bandwidth & latency section, this network design cannot be recommended for cross-data landing zone use cases.

## Private Endpoint Projection (NOT Recommended)

Another design alternative that was evaluated was the projection of Private Endpoints across each and every Landing Zone. With this approach, a Private Endpoint for Storage Account A would be created each data landing zone. Therefore, this option leads to a first Private Endpoint in data landing zone A that is connected to the Vnet in data landing zone A, a second Private Endpoint in data landing zone B that is connected to the Vnet in data landing zone B and so on. The same applies to Storage Account B and potentially other services inside the data landing zones. If the number of data landing zones is defined as *n*, one would end up with *n* Private Endpoints for at least all of the storage accounts and potentially other services within the data landing zones leading to an exponential growth of the number of Private Endpoints.

:::image type="content" source="./images/network-options-private-endpoint-projection.png" alt-text="Private Endpoint Projection":::
*Figure 4: Private Endpoint Projection.*

Since all Private Endpoints of a particular service (for example, Storage Account A) have the same FQDN (for example, `storageaccounta.privatelink.blob.core.windows.net`) this solution creates challenges on the DNS layer that can't be solved with Private DNS Zones. A custom DNS solution is required that is capable of resolving DNS names based on the origin/IP-address of the requestor in order to make VM A connect to the Private Endpoints connected to the Vnet in data landing zone A and make VM B connect to the Private Endpoints connected to the Vnet in data landing zone B. This can be done with a setup based on Windows Servers, whereas the lifecycle of DNS A-records can be automated through a combination of Activity Log and Azure Functions.

With this setup, VM B can load the raw dataset in Storage Account A by accessing it through the local Private Endpoint (1). After the dataset has been loaded and processed ((2) and (3)) the dataset can be stored on Storage Account B by directly accessing the local Private Endpoint (4). Data must not traverse any Vnet peerings within this scenario.

### User Access Management in private endpoint projection

From a user access management perspective, this scenario is similar to the first option except for the fact that access rights can also be required for other data landing zones to not just create Private Endpoints within the designated data landing zone and Vnet but also in the other data landing zones and their respective Vnets. Hence, data application teams don't only require write access to a resource group in the designated data landing zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner, but they also require access to a resource group and subnet inside the other data landing zones to create the respective local Private Endpoints. In summary, this setup increases the complexity on the access management layer since data application teams require few permissions not just in a single but in each and every data landing zone. In addition, it can lead to confusion and inconsistent RBAC over time. If necessary access rights aren't provided to data landing zone teams or data application teams, problems described in [Traditional hub and spoke Design (NOT Recommended)](#traditional-hub-and-spoke-design-not-recommended) will be applicable.

Summary: :::image type="icon" source="./images/minusicon.png":::

### Service Management in private endpoint projection

Similar to [Meshed Network Architecture (Recommended)](#meshed-network-architecture-recommended), this network design has the benefit that there's no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity Hub also reduces the management overhead for the central Azure platform team, as there's no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this isn't seen as disadvantage since the Data Management and Analytics Scenario can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity Hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and other application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/).

On the other hand, the exponential growth of the number of required Private Endpoints also increases the network address space required by the data platform, which isn't optimal. Lastly, the above-mentioned DNS challenges are the biggest concern of this network architecture. An Azure native solution in the form of Private DNS Zones can't be used. Hence, a third-party solution will be required that is capable of resolving FQDNS based on the origin/IP-address of the requestor. In addition, tools and workflows must be developed and maintained to automate the lifecycle of Private DNS A-records that drastically increases the management overhead compared to the proposed [Azure Policy driven solution](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/). It would also be possible to create a distributed DNS infrastructure using Private DNS Zones, but with this solution DNS islands would be created which ultimately lead to issues when trying to access private link services hosted other landing zones within the tenant. Therefore, this isn't a viable alternative.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Cost in private endpoint projection

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, you only pay for the Private Endpoints (charged per hour) as well as the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (4). However, due to the exponential growth of the number of Private Endpoints inside the data platform extra costs must be expected and will highly depend on the number of Private Endpoints that are created since these are charged per hour.

Summary: :::image type="icon" source="./images/plusicon.png":::

### Bandwidth and Latency in private endpoint projection

Because there are no network virtual appliances limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth and latency perspective. Physical limits in our datacenters are the only limiting factor (speed of fibre cables/light).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Summary Private Endpoint Projection

This network architecture suffers from the potential exponential growth of Private Endpoints that can cause losing track of which Private Endpoints are used where and for which purpose. Another set of limiting factors is the access management issues described above and the complexities created on the DNS layer. Therefore, this network design can't be recommended.

## Private Endpoints in Connectivity Hub (NOT Recommended)

The fourth option proposes to host the Private Endpoints in the Connectivity Hub and connect them to the Hub Vnet. With this solution, a single Private Endpoint for each service would be hosted on the corporate Vnet. Transitivity would also not be required due to the existing hub and spoke network architecture at most corporations and the fact that the Private Endpoints would be hosted in the Connectivity Hub with this solution. The Vnet peering between the Connectivity Hub and data landing zones allow for a direct access.

In order to load a dataset stored in Storage Account A in VM B, data would have to traverse a single Vnet peering between the Connectivity Hub and the data landing zone (5). Once the dataset has been loaded and processed ((3) and (4)) the dataset must traverse the Vnet peering a second time (5) before it can be stored on Storage Account B by accessing the Private Endpoint connected to the Hub Vnet (6).

:::image type="content" source="./images/network-options-private-endpoints-in-connectivity-hub.png" alt-text="Private Endpoints in Connectivity Hub":::
*Figure 5: Private Endpoints in Connectivity Hub.*

### User Access Management in a connectivity hub

When opting for this network design, data landing zone teams and data application teams must be given write permissions to a resource group in the Connectivity Hub subscription and join permissions to the Hub Vnet to be able to connect Private Endpoints to the Hub Vnet. This isn't in line with the Enterprise-Scale Landing Zone base principles, since the Connectivity Hub is a subscription that is designated for the Azure platform team of an organization and is dedicated for hosting the necessary and shared network infrastructure of an organization, including Firewalls, gateways and network management tools. This network option would make the design inconsistent since access management principles aren't followed and therefore this design alternative is something that most Azure platform teams won't approve.

Summary: :::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png"::::::image type="icon" source="./images/minusicon.png":::

### Service Management in a connectivity hub

Similar to [Meshed Network Architecture (Recommended)](#meshed-network-architecture-recommended), this network design has the benefit that there's no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity Hub also reduces the management overhead for the central Azure platform team, as there's no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between data landing zones. Nonetheless, this isn't seen as disadvantage since the Data Management and Analytics Scenario can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity Hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and other application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/). Also, this pattern allows for an Azure native DNS solution based on Private DNS Zones and allows for the automation of the DNS A-record lifecycle through [Azure Policies](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Cost in a connectivity hub

> [!NOTE]
> When accessing a private endpoint across a peered network you will only ever be charged for the private endpoint itself and not for the VNet peering. The official statement can be found [here (FAQ: How will billing work when accessing a private endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, you only pay for the Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (6).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

### Bandwidth and Latency in a connectivity hub

Because there are no network virtual appliances limiting throughput for cross-data landing zone data exchange, there are no known limitations from a bandwidth and latency perspective. Physical limits in our datacenters are the only limiting factor (speed of fibre cables/light).

Summary: :::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png"::::::image type="icon" source="./images/plusicon.png":::

#### Summary Private Endpoints in Connectivity Hub

There are many benefits that come with this network architecture design. However, the above-mentioned inconsistencies from an access management perspective make the design subpar and so the approach doesn't qualify as a recommended design.

## Conclusion - Single-region data landing zone Connectivity

After reviewing all network architecture options from various angles and identifying pros and cons of each proposed pattern, [Meshed Network Architecture (Recommended)](#meshed-network-architecture-recommended) is the clear winner. Not only from a throughput perspective, but also from a cost and management perspective the solution has tremendous benefits and therefore should be used when deploying the Data Management and Analytics Scenario. Peering spoke Virtual Networks hasn't been common in the past, but not doing so has also led to various issues when starting to share datasets across domains and business units. In addition, one can also argue that the Data Management and Analytics Scenario can be seen as coherent solution that just spans across multiple subscriptions. In a single subscription setup, the network traffic flow would be equal to the flow in the meshed network architecture, with the difference that within a single subscription users will most likely hit [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) of the platform, which is something that the Data Management and Analytics Scenario wants to protect against.

## Next steps

- [Cross-region data landing zone Connectivity](eslz-network-considerations-cross-region.md)
