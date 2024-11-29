---
title: Network topology and connectivity for cloud-scale analytics landing zones
description: Learn about the network topology and connectivity for cloud-scale analytics landing zones in Azure.
author: marvinbuss
ms.author: mabuss
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Networking overview

This article has design considerations and guidelines for networking and connectivity to or from data management landing zones and data landing zones. It builds on information in the [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md) article.

Since data management and data landing zones are important, you should also include the guidance for the Azure landing zone design areas in your design.

This section outlines gives a high level overview of the networking pattern with further links to deploying in both single and multiple Azure regions.

Cloud-scale analytics promises the possibility to easily share and access datasets across multiple data domains and data landing Zones without critical bandwidth or latency limitations and without creating multiple copies of the same dataset. To deliver on that promise, different network designs have to be considered, evaluated, and tested to make sure that these are compatible with the existing hub and spoke and vWAN deployments of corporations.

:::image type="content" source="images/networking-overview.png" alt-text="Networking overview" lightbox="images/networking-overview.png":::

*Figure 1: Networking overview for cloud-scale analytics.*

[!INCLUDE [network-important](../cloud-scale-analytics/includes/network-important.md)]

## Data management landing zone networking

You can connect virtual networks to each other with virtual network peering. These virtual networks can be in the same or different regions, and are also known as global virtual network peering. After peering the virtual networks, resources in both virtual networks communicate with each other. This communication has the same latency and bandwidth as if the resources were in the same virtual network.

The data management landing zone connects to the Azure networking management subscription using virtual network peering. The virtual network peering then connects to on-premises resources using ExpressRoute circuits and third-party clouds.

Data management landing zone services that support Azure Private Link are injected into the data management landing zone virtual network.

## Data management landing zone to data landing zone

For every new data landing zone, you should create a virtual network peering from the data management landing zone to the data landing zone.

> [!IMPORTANT]
> A data management landing zone connects to an data landing zone using virtual network peering.

## Data landing zones to data landing zones

There are options on how to make this connectivity and depending on if you have a single or multiple region deployments it's recommended that you consider the guidance in:

- [Single-region data landing zone Connectivity](../cloud-scale-analytics/eslz-network-considerations-single-region.md)
- [Cross-region data landing zone connectivity](../cloud-scale-analytics/eslz-network-considerations-cross-region.md)

## Data management landing zone to third-party clouds

To set up connectivity between a data management landing zone and a third-party cloud, use a [Site-to-Site VPN](/azure/vpn-gateway/vpn-gateway-create-site-to-site-rm-powershell) gateway connection. This VPN can connect your on-premises or third-party cloud landing zone to an Azure virtual network. This connection is created over an IPsec or internet key exchange v1 or v2 (IKEv1 or IKEv2) VPN tunnel.

Site-to-Site VPNs can provide better continuity for your workloads in a hybrid cloud setup with Azure.

> [!IMPORTANT]
> For connections to a third-party cloud, we recommend implementing a Site-to-Site VPN between your Azure connectivity subscription and the third-party cloud connectivity subscription.

## Private endpoints

Cloud-scale analytics uses [Private Link](/azure/private-link/private-link-service-overview), where available, for shared platform as a service (PaaS) functionality. Private Link is available for several services and is in public preview for more services. Private Link addresses data exfiltration concerns related to service endpoints.

For the current list of supported products, see [Private Link resources](/azure/private-link/private-endpoint-overview#private-link-resource).

If you're planning on implementing cross tenant private endpoints, it's recommended that you review [Limit cross-tenant private endpoint connections in Azure](../../ready/azure-best-practices/limit-cross-tenant-private-endpoint-connections.md).

> [!CAUTION]
> By design, cloud-scale analytics networking uses private endpoints where available to connect to PaaS services.

### Implement Azure DNS resolver for private endpoints

Handle DNS resolution for private endpoints through central [Azure Private DNS](/azure/dns/private-dns-overview) zones. Required DNS records for private endpoints can be automatically created using Azure Policy to allow access through fully qualified domain names (FQDNs). The lifecycle of the DNS records follows the lifecycle of the private endpoints. It's automatically removed when the private endpoint is deleted.

## Next steps

- [Single-region Data Landing Zone Connectivity](../cloud-scale-analytics/eslz-network-considerations-single-region.md)
