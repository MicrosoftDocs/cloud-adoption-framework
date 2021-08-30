---
title: Azure enterprise-scale for analytics and AI networking
description: Learn about the network topology and connectivity for a data management and analytics Azure landing zone.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network topology and connectivity for a data management and analytics landing zone

This article has design considerations and guidelines for networking and connectivity to or from data management landing zones and data landing zones. It builds on information that's found in the [enterprise-scale design area for network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md) article.

Since data management and data landing zones are important, you should also include the guidance for the enterprise-scale design areas in your design.

This section outlines the networking patterns to assist with:

- Integrating across clouds.
- Restricting data exfiltration.
- Creating access for remote workers.
- Interfacing with on-premises and software as a service (SaaS) solutions.

:::image type="content" source="./images/networking-overview.png" alt-text="Diagram that shows a high-level overview of networking for enterprise-scale for analytics and AI." lightbox="./images/networking-overview.png":::

## Data management landing zone networking

You can connect virtual networks to each other with virtual network peering. These virtual networks can be in the same or different regions, and are also known as global VNet peering. After peering the virtual networks, resources in both virtual networks communicate with each other. This communication has the same latency and bandwidth as if the resources were in the same virtual network.

The data management landing zone connects to the Azure networking management subscription using virtual network peering. The virtual network peering then connects to on-premises resources using ExpressRoute circuits and third-party clouds.

Data management landing zone services that support Azure Private Link are injected into the data management landing zone virtual network. For example, Azure Purview supports Private Link.

## Data management landing zone to data landing zone

For every new data landing zone, you should create a virtual network peering from the data management landing zone to the data landing zone.

> [!IMPORTANT]
> A data management landing zone connects to an analytics and AI landing zone using virtual network peering.

## Data landing zones to data landing zones

Data landing zones connect to other data landing zones using virtual network peering.

## Data management landing zone to third-party clouds

To set up connectivity between a data management landing zone and a third-party cloud, use a [Site-to-Site VPN](/azure/vpn-gateway/vpn-gateway-create-site-to-site-rm-powershell) gateway connection. This VPN can connect your on-premises or third-party cloud landing zone to an Azure virtual network. This connection is created over an IPsec or internet key exchange v1 or v2 (IKEv1 or IKEv2) VPN tunnel.

Site-to-Site VPNs can provide better continuity for your workloads in a hybrid cloud setup with Azure.

> [!IMPORTANT]
> For connections to a third-party cloud, we recommend implementing a Site-to-Site VPN between your Azure connectivity subscription and the third-party cloud connectivity subscription.

## Private endpoints

The enterprise-scale for analytics and AI framework uses [Private Link](/azure/private-link/private-link-service-overview), where available, for shared platform as a service (PaaS) services. Private Link is available for several services and is in public preview for more services. Private Link addresses data exfiltration concerns related to service endpoints.

For the current list of supported products, see [Private Link resources](/azure/private-link/private-endpoint-overview#private-link-resource).

> [!CAUTION]
> By design, enterprise-scale for analytics and AI networking uses private endpoints where available for connectivity to PaaS services.

### Azure DNS resolver implementation for private endpoints

Handle DNS resolution for private endpoints through central [Azure Private DNS](/azure/dns/private-dns-overview) zones. Required DNS records for private endpoints can be automatically created using Azure Policy to allow access through fully qualified domain names (FQDNs). The lifecycle of the DNS records follows the lifecycle of the private endpoints. It's automatically removed when the private endpoint is deleted.
