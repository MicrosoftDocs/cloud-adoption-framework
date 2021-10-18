---
title: Network Architecture Considerations
description: Learn Network Architecture Considerations for data management and analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 09/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network Architecture Considerations

Cloud adoption framework data management and analytics promise the possibility to easily share and access datasets across multiple data domains and Data Landing Zones without critical bandwidth limitations and without creating multiple copies of the same dataset. To deliver on that promise, different network designs have been considered, evaluated, and tested to make sure that these are compatible with the existing hub and spoke and vWAN deployments of corporations. Based on the current capabilities of Azure Networking Services it is recommended to rely on a meshed network architecture. It is recommended to setup vNet peering between:

1. The Connectivity hub and Data Management Zone,
2. The Connectivity hub and each Data Landing Zone,
3. The Data Management Zone and each Data Landing Zone
4. Each Data Landing Zone.

:::image type="content" source="images/network-options-network-mesh.png" alt-text="Network architecture":::

Figure 1: Basic networking diagram for Cloud Adoption Framework data management and analytics

To explain the rationale behind the design, this article illustrates the advantages and disadvantages that come with each of the different network architecture approaches that were considered when designing Enterprise-Scale Analytics. Every design pattern will be evaluated along the following criteria: Cost, User Access Management, Service Management, and Bandwidth.

> [!NOTE]
> Each scenario has been analyzed with the following cross-Data Landing Zone use-case in mind:
>Virtual machine B (VM B) hosted in Data Landing Zone B loads a dataset from Storage Account A hosted in Data Landing Zone A. Next, it processes the dataset and finally it stores the processed dataset and in Storage Account B hosted in Data Landing Zone B.

## Option 1: Traditional hub and spoke Design

Many enterprise have adopted the traditional hub and spoke network architecture.

:::image type="content" source="images/network-options-hub-and-spoke.png" alt-text="hub and spoke architecture" lightbox="images/network-options-hub-and-spoke.png":::

Figure 2: hub and spoke architecture

As figure 2 illustrates, network transitivity would have to be setup in the Connectivity hub in order to be able to access data in Storage Account A from VM B. Data would traverse two Vnet peerings ((2) and (5)) as well as a Network Virtual Appliance (NVA) hosted inside the Connectivity hub ((3) and (4)) before it gets loaded by the virtual machine (6) and then stored back into the Storage Account B (8).

### Option 1: User Access Management

With this solution approach, Data Product teams will only require write access to a resource group in the respective Data Landing Zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner. Therefore, Data Product teams can deploy Private Endpoints themselves and don't require support to setup the necessary connectivity given that they get the necessary access rights to connect Private Endpoints to a subnet in that spoke.

### Option 1: Service Management

The most relevant benefit of this network architecture design is that it is well-known and consistent with the existing network setup of most organizations. Therefore, it is easy to explain and implement. In addition, a centralized and Azure native DNS solution with Private DNS Zones can be used to provide FQDN resolution inside the Azure tenant. The use of Private DNS Zones also allows for the automation of the DNS A-record lifecycle through [Azure Policies](architectures/policies.md). Since traffic is routed through a central network virtual appliance, network traffic that is sent from one spoke to another one can also be logged and inspected, which can be another benefit of this design.

A downside of this solution from a Service Management perspective is that the central Azure Platform team must manage Route Tables manually. This is required to ensure the necessary transitivity between spokes to enable the process of sharing data assets across multiple Data Landing Zones. The management of routes can become complex and error prone over time and is something that should be considered upfront. The more critical disadvantage of this network setup is the central network virtual appliance. Firstly, the network virtual appliance acts as a single point of failure and can cause serious downtime inside the data platform if there was a failure. Secondly, as the dataset sizes grow inside the data platform and as the number of cross-Data Landing Zone use cases increases more traffic will be sent through the central network virtual appliance. Over time, this can result in gigabytes or terabytes of data that is sent through the central instance. However, the bandwidth of existing network virtual appliances is often limited to a one or two-digit gigabyte bandwidth. Therefore, the appliance can act as a critical bottleneck limiting the traffic flowing between Data Landing Zones and therefore limiting the shareability of data assets. The only way to overcome this issue would be to scale out the central network virtual appliance across multiple instances, which will have huge implications on cost of this solution.

### Option 1: Cost

From a network perspective, customers have to pay for the two Private Endpoints of the Storage Accounts (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (8). In addition, the customer will be charged for the ingress and egress of one Vnet peering (5). Due to the statement above, the first Vnet peering will not be charged (2). Lastly, customers will end up with significant cost for the central network virtual appliance when choosing this network design ((3) and (4)). The high cost will be generated either because extra licenses need to be purchased to scale out based on demand or it will be generated because of the charge per processed gigabyte as it is done with Azure Firewall.

> [!NOTE]
> When accessing a Private Endpoint across a peered network customers will only ever be charged for the private Endpoint itself and not for the Vnet peering. The official statement can be found [here (FAQ: How will billing work when accessing a Private Endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).


### Option 1: Bandwidth

This network design has serious limitations from a bandwidth perspective. The central network virtual appliance will become a critical bottleneck as the platform grows, which will limit cross-Data Landing Zone use cases and sharing of datasets and most likely lead to a situation where multiple copies of datasets will be created over time.

Summary: :heavy_minus_sign::heavy_minus_sign::heavy_minus_sign:

### Option 1: Summary

From an access management and partially from a Service Management perspective, this setup has benefits. But due to the critical limitations pointed out in the Service Management, cost and bandwidth section, this network design cannot be recommended for cross-Data Landing Zone use cases.

## Option 2: Private Endpoint Projection

Another design alternative that was evaluated was the projection of Private Endpoints across each and every Landing Zone. With this approach, a Private Endpoint for Storage Account A would be created each Data Landing Zone. Therefore, this option leads to a first Private Endpoint in Data Landing Zone A that is connected to the Vnet in Data Landing Zone A, a second Private Endpoint in Data Landing Zone B that is connected to the Vnet in Data Landing Zone B, etc. The same applies to Storage Account B and potentially other services inside the Data Landing Zones. If the number of Data Landing Zones is defined as _n_, one would end up with _n_ Private Endpoints for at least all of the storage accounts and potentially other services within the Data Landing Zones leading to an exponential growth of the number of Private Endpoints.

:::image type="content" source="images/network-options-private-endpoint-projection.png" alt-text="Private Endpoint Projection Architecture":::

Since all Private Endpoints of a particular service (for example, Storage Account A) have the same FQDN (for example, `storageaccounta.privatelink.blob.core.windows.net`) this solution creates challenges on the DNS layer that cannot be solved with Private DNS Zones. A custom DNS solution is required that is capable of resolving DNS names based on the origin/IP-address of the requestor in order to make VM A connect to the Private Endpoints connected to the Vnet in Data Landing Zone A and make VM B connect to the Private Endpoints connected to the Vnet in Data Landing Zone B. This can be done with a setup based on Windows Servers, whereas the lifecycle of DNS A-records can be automated through a combination of Activity Log and Azure Functions.

With this setup, VM B can load the raw dataset in Storage Account A by accessing it through the local Private Endpoint (1). After the dataset has been loaded and processed ((2) and (3)) the dataset can be stored on Storage Account B by directly accessing the local Private Endpoint (4). Data must not traverse any Vnet peerings within this scenario.

### Option 2: User Access Management

From a user access management perspective, this scenario is similar to the first option except for the fact that access rights may also be required for other Data Landing Zones to not just create Private Endpoints within the designated Data Landing Zone and Vnet but also in the other Data Landing Zones and their respective Vnets. Hence, Data Product teams may not only require write access to a resource group in the designated Data Landing Zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner, but they may also require access to a resource group and subnet inside the other Data Landing Zones to create the respective local Private Endpoints. In summary, this setup increases the complexity on the access management layer since Data Product teams may require few permissions not just in a single but in each and every Data Landing Zone. In addition, it may lead to confusion and inconsistent RBAC over time. If necessary access rights are not provided to Data Landing Zone teams or Data Product teams, problems described in [Option 1: Traditional hub and spoke Design](#option-1-traditional-hub--spoke-design) will be applicable.

Summary: :heavy_minus_sign:

### Option 2: Service Management

Option 2 has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between Data Landing Zones. Nonetheless, this is not seen as disadvantage since Enterprise-Scale Analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and other application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/).

On the other hand, the exponential growth of the number of required Private Endpoints also increases the network address space required by the data platform, which is not optimal. Lastly, the above-mentioned DNS challenges are the biggest concern of this network architecture. An Azure native solution in the form of Private DNS Zones cannot be used. Hence, a third-party solution will be required that is capable of resolving FQDNS based on the origin/IP-address of the requestor. In addition, tools and workflows must be developed and maintained to automate the lifecycle of Private DNS A-records that drastically increases the management overhead compared to the proposed [Azure Policy driven solution](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/). It would also be possible to create a distributed DNS infrastructure using Private DNS Zones, but with this solution DNS islands would be created which ultimately lead to issues when trying to access private link services hosted other Landing Zones within the tenant. Therefore, this is not a viable alternative.

Summary: :heavy_minus_sign::heavy_minus_sign::heavy_minus_sign:

### Option 2: Cost

> [!NOTE]
> When accessing a Private Endpoint across a peered network customers will only ever be charged for the private Endpoint itself and not for the Vnet peering. The official statement can be found [here (FAQ: How will billing work when accessing a Private Endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, customers only pay for the Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (4). However, due to the exponential growth of the number of Private Endpoints inside the data platform extra costs must be expected and will highly depend on the number of Private Endpoints that are created since these are charged per hour.

Summary: :heavy_plus_sign:

### Option 2: Bandwidth

Because there are no network virtual appliances limiting throughput for cross-Data Landing Zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 2: Summary

This network architecture suffers from the potential exponential growth of Private Endpoints, which may even cause losing track of which Private Endpoints are used where and for which purpose. Another limiting factor are the access management issues described above and the complexities created on the DNS layer. Therefore, this network design cannot be recommended.

## Option 3: Private Endpoints in Connectivity hub

The third option proposes to host the Private Endpoints in the Connectivity hub and connect them to the hub Vnet. With this solution, a single Private Endpoint for each service would be hosted on the corporate Vnet. Transitivity would also not be required due to the existing hub and spoke network architecture at most corporations and the fact that the Private Endpoints would be hosted in the Connectivity hub with this solution. The Vnet peering between the Connectivity hub and Data Landing Zones allow for a direct access.

In order to load a dataset stored in Storage Account A in VM B, data would have to traverse a single Vnet peering between the Connectivity hub and the Data Landing Zone (5). Once the dataset has been loaded and processed ((3) and (4)) the dataset must traverse the Vnet peering a second time (5) before it can be stored on Storage Account B by accessing the Private Endpoint connected to the hub Vnet (6).

:::image type="content" source="images/network-options-private-endpoints-in-connectivityhub.png" alt-text="Private Endpoints in Connectivity hub":::

### Option 3: User Access Management

When opting for this network design, Data Landing Zone teams and Data Product teams must be given write permissions to a resource group in the Connectivity hub subscription and join permissions to the hub Vnet to be able to connect Private Endpoints to the hub Vnet. This is not in line with the Enterprise-Scale Landing Zone base principles, since the Connectivity hub is a subscription that is designated for the Azure platform team of an organization and is dedicated for hosting the necessary and shared network infrastructure of an organization, including Firewalls, gateways and network management tools. This network option would make the design inconsistent since access management principles are not followed and therefore this design alternative is something that most Azure platform teams will not approve.

Summary: :heavy_minus_sign::heavy_minus_sign::heavy_minus_sign:

### Option 3: Service Management

Similar to Option 2, this network design has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between Data Landing Zones. Nonetheless, this is not seen as disadvantage since Enterprise-Scale Analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and extra application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/). Also, this pattern allows for an Azure native DNS solution based on Private DNS Zones and allows for the automation of the DNS A-record lifecycle through [Azure Policies](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 3: Cost

> [!NOTE]
> When accessing a Private Endpoint across a peered network customers will only ever be charged for the private Endpoint itself and not for the Vnet peering. The official statement can be found [here (FAQ: How will billing work when accessing a Private Endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, customers only pay for the Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (6).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 3: Bandwidth

Because there are no network virtual appliances limiting throughput for cross-Data Landing Zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 3: Summary

There are many benefits that come with this network architecture design. However, the above-mentioned inconsistencies from an access management perspectives make the design subpar and so the approach does not qualify as a recommended design.

## Option 4: Meshed Network Architecture (Recommended)

The recommended design proposes the use of a network mesh, which means adding Vnet peerings between all Data Landing Zone Vnets and between the Data Management Zone and each Data Landing Zone in addition to the existing hub and spoke network design that most organizations have setup inside their tenant. For the scenario mentioned in the introduction, data loaded from Storage Account A would first transition a Vnet peering connection (2) that is setup between the two Data Landing Zone Vnets before it would be loaded and processed by VM B ((3) and (4)). Lastly, the data can be stored on Storage Account B by sending the data through the local Private Endpoint (5). With this option, the data does not pass the Connectivity hub and stays within the Data Platform consisting of a Data Management Zones and one or multiple Data Landing Zones.

:::image type="content" source="images/network-options-meshed-network-architecture.png" alt-text="Meshed Network Architecture":::

### Option 4: User Access Management

With this solution approach Data Product teams will only require write access to their dedicated resource group in the Data Landing Zone and join access to their designated subnet to be able to create new services including the Private Endpoints in a self-service manner. Therefore, Data Product teams can deploy Private Endpoints themselves and don't require support to setup the necessary connectivity if they get the necessary access rights provided to connect Private Endpoints to a subnet in that spoke.

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 4: Service Management

Similar to Option 2, this network design has the benefit that there is no network virtual appliance acting as a single point of failure or throttling throughput. Not sending the datasets through the Connectivity hub also reduces the management overhead for the central Azure platform team, as there is no need for scaling out the virtual appliance. This has the implication that the central Azure platform team can no longer inspect and log all traffic that is sent between Data Landing Zones. Nonetheless, this is not seen as disadvantage since Enterprise-Scale Analytics can be considered as coherent platform that spans across multiple subscriptions to allow for scale and overcome platform level limitations. If all resources would be hosted inside a single subscription, traffic would also not be inspected in the central Connectivity hub. In addition, network logs can still be captured by using Network Security Group Flow Logs and other application and service level logs can be consolidated and stored by using service specific Diagnostic Settings. All of these logs can be captured at scale by using [Azure Policies](/infra/Policies/PolicyDefinitions/DiagnosticSettings/). Also, this pattern allows for an Azure native DNS solution based on Private DNS Zones and allows for the automation of the DNS A-record lifecycle through [Azure Policies](/infra/Policies/PolicyDefinitions/PrivateDnsZoneGroups/).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 4: Cost

> [!NOTE]
> When accessing a Private Endpoint across a peered network customers will only ever be charged for the private Endpoint itself and not for the Vnet peering. The official statement can be found [here (FAQ: How will billing work when accessing a Private Endpoint from a peered network?)](https://azure.microsoft.com/pricing/details/private-link/).

With this network design, customers only pay for the Private Endpoints (charged per hour) and the ingress and egress traffic that is sent through the Private Endpoints to load the raw (1) and store the processed dataset (6). Due to the statement above, the Vnet peering will not be charged (2), which is why we end up with minimal cost with this option.

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 4: Bandwidth

Because there are no network virtual appliances limiting throughput for cross-Data Landing Zone data exchange, there are no known limitations from a bandwidth perspective. Physical limits in our datacenters are the only limiting factor (speed of fiber cables/light).

Summary: :heavy_plus_sign::heavy_plus_sign::heavy_plus_sign:

### Option 4: Summary

The meshed network design offers maximum bandwidth at minimal cost without any compromises from a user access management perspective or on the DNS layer. Hence, this network architecture design is the recommended for customers wanting to adopt Enterprise-Scale Analytics. If extra network policies need to be enforced within the Data Platform, it is advised to use Network Security Groups instead of central network virtual appliances.

## Option 4: Conclusion

After reviewing all network architecture options from various angles and identifying pros and cons of each proposed pattern, [Option 4](#option-4-meshed-network-architecture-recommended) is the clear winner. Not only from a throughput perspective, but also from a cost and management perspective the solution has tremendous benefits and therefore should be used when deploying Enterprise-Scale Analytics. Peering spoke Virtual Networks has not been common in the past, but not doing so has also led to various issues when starting to share datasets across domains and business units. In addition, one can also argue that Enterprise-Scale Analytics can be seen as coherent solution that just spans across multiple subscriptions. In a single subscription setup, the network traffic flow would be equal to the flow in the meshed network architecture, with the difference that within a single subscription users will most likely hit [subscription level limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) of the platform, which is something that Enterprise-Scale Analytics wants to protect against.
