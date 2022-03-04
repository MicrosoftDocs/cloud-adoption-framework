---
title: Network topology and connectivity for data management and analytics landing zones
description: Learn about the network topology and connectivity for data management and analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 03/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview

This article has design considerations and guidelines for networking and connectivity to or from data management landing zones and data landing zones. It builds on information in the design area for network topology and connectivity article.

Since data management and data landing zones are important, you should also include the guidance for the design areas in your design.

The Data Management and Analytics Scenario promises the possibility to easily share and access datasets across multiple data domains and Data Landing Zones without critical bandwidth or latency limitations and without creating multiple copies of the same dataset. To deliver on that promise, different network designs had to be considered, evaluated and tested to make sure that these are compatible with the existing Hub and Spoke and vWAN deployments of corporations. Based on the current capabilities of Azure Networking Services it's recommended to rely on a meshed network architecture. What this means is that it's recommended to set up Vnet peering between

1. The Connectivity Hub and Data Management Zone,
2. The Connectivity Hub and each Data Landing Zone,
3. The Data Management Zone and each Data Landing Zone and
4. Each Data Landing Zone.

:::image type="content" source="./images/network-options-network-mesh.png" alt-text="Network architecture":::
*Figure 1: Basic networking diagram for Cloud Adoption Framework data management and analytics.*

To explain the rationale behind the recommended design, this article will illustrate the advantages and disadvantages that come with each of the different network architecture approaches that were considered when designing the Data Management and Analytics Scenario. The first section of this article will only look at a single-region pattern, where the Data Management Zone as well as all the Data Landing Zones are hosted in the same region. The second chapter will specifically focus on the cross-region setup and will provide recommendations for such data access patterns.

This article has design considerations and guidelines for networking and connectivity to or from data management landing zones and data landing zones. It builds on information in the [design area for network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md) article.

Since data management and data landing zones are important, you should also include the guidance for the design areas in your design.

This section outlines networking patterns that can help with:

- Integrating across clouds.
- Restricting data exfiltration.
- Creating access for remote workers.
- Interfacing with on-premises and software as a service (SaaS) solutions.

:::image type="content" source="./images/network-options-network-mesh.png" alt-text="Diagram that shows a high-level overview of networking for data management and analytics scenario." lightbox="./images/network-options-network-mesh.png":::

## Data management landing zone networking

You can connect virtual networks to each other with virtual network peering. These virtual networks can be in the same or different regions, and are also known as global VNet peering. After peering the virtual networks, resources in both virtual networks communicate with each other. This communication has the same latency and bandwidth as if the resources were in the same virtual network.

The data management landing zone connects to the Azure networking management subscription using virtual network peering. The virtual network peering then connects to on-premises resources using ExpressRoute circuits and third-party clouds.

Data management landing zone services that support Azure Private Link are injected into the data management landing zone virtual network. For example, Azure Purview supports Private Link.

## Data management landing zone to data landing zone

For every new data landing zone, you should create a virtual network peering from the data management landing zone to the data landing zone.

> [!IMPORTANT]
> A data management landing zone connects to an data landing zone using virtual network peering.

## Data landing zones to data landing zones

Data landing zones connect to other data landing zones using virtual network peering.

## Data management landing zone to third-party clouds

To set up connectivity between a data management landing zone and a third-party cloud, use a [Site-to-Site VPN](/azure/vpn-gateway/vpn-gateway-create-site-to-site-rm-powershell) gateway connection. This VPN can connect your on-premises or third-party cloud landing zone to an Azure virtual network. This connection is created over an IPsec or internet key exchange v1 or v2 (IKEv1 or IKEv2) VPN tunnel.

Site-to-Site VPNs can provide better continuity for your workloads in a hybrid cloud setup with Azure.

> [!IMPORTANT]
> For connections to a third-party cloud, we recommend implementing a Site-to-Site VPN between your Azure connectivity subscription and the third-party cloud connectivity subscription.

## Private endpoints

The data management and analytics scenario uses [Private Link](/azure/private-link/private-link-service-overview), where available, for shared platform as a service (PaaS) functionality. Private Link is available for several services and is in public preview for more services. Private Link addresses data exfiltration concerns related to service endpoints.

For the current list of supported products, see [Private Link resources](/azure/private-link/private-endpoint-overview#private-link-resource).

If you are planning on implementing cross tenant private endpoints, it's recommend that you review [Limit cross-tenant private endpoint connections in Azure](../../ready/azure-best-practices/limit-cross-tenant-private-endpoint-connections.md).

> [!CAUTION]
> By design, data management and analytics scenario networking uses private endpoints where available to connect to PaaS services.

### Implement Azure DNS resolver for private endpoints

Handle DNS resolution for private endpoints through central [Azure Private DNS](/azure/dns/private-dns-overview) zones. Required DNS records for private endpoints can be automatically created using Azure Policy to allow access through fully qualified domain names (FQDNs). The lifecycle of the DNS records follows the lifecycle of the private endpoints. It's automatically removed when the private endpoint is deleted.

## Next steps

- [Single-region Data Landing Zone Connectivity](eslz-network-considerations-single-region.md)
