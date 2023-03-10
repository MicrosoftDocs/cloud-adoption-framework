---
title: Network topology and connectivity considerations for the Azure Integration Services landing zone accelerator
description: Learn about design considerations and recommendations for network topology and connectivity in the Azure Integration Services landing zone accelerator.
author: claytonsiemens77
ms.author: csiemens
ms.date: 03/10/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-integration-services
---

# Network topology and connectivity considerations for the Integration Services landing zone accelerator

This article provides design considerations and recommendations for network topology and connectivity that you can apply when you use the Azure Integration Services (AIS) landing zone accelerator. Networking is central to almost everything in a landing zone.

The network topology and connectivity considerations for this architecture depend on the requirements of the workloads being hosted and on the security and compliance requirements of your organization.

## Design considerations

Use a network topology based on [Virtual WAN](/azure/cloud-adoption-framework/ready/azure-best-practices/virtual-wan-network-topology) if your organization:

- Plans to deploy resources across several Azure regions and requires global connectivity between VNets in these Azure regions and multiple on-premises locations.
- Needs to integrate a large-scale branch network directly into Azure, either via a software-defined WAN (SD-WAN) deployment or requires more than 30 branch sites for native IPsec termination.
- You require transitive routing between VPN and ExpressRoute, such as remote branches connected via Site-to-Site VPN or remote users connected via Point-to-Site VPN, require connectivity to an ExpressRoute connected DC, via Azure.

Organizations use Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps reduce overall network complexity and modernizes your organization's network.

Use a [traditional Azure network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology) based around a hub-and-spoke architecture if your organization:

- Plans to deploy resources in only select Azure regions.
- Doesn't need a global, interconnected network.
- Has few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels.
- Requires full control of the configuration or requires manual custom configuration of your Azure network.

### Reference network topology

The following architecture diagram shows the reference architecture for an AIS enterprise deployment:

[![Diagram that shows Azure Integration Services landing zone accelerator architecture.](./media/s)](./media/#lightbox)

## Plan for IP addressing

Enterprise deployments of AIS should include the use of Private Endpoints and Virtual Networks. The following design considerations should be taken into account when planning your IP addressing:

- Some AIS services require [dedicated subnets](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network)
    - [API Management](/azure/api-management/api-management-using-with-vnet?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=stv2#enable-vnet-connectivity-using-the-azure-portal-stv2-compute-platform)
    - [Logic Apps](/azure/logic-apps/secure-single-tenant-workflow-virtual-network-private-endpoint#prerequisites)
    - You can delegate subnets to certain services to create instances of a service within the subnet.
    - Azure VPN Gateway can connect overlapping, on-premises sites with overlapping IP address spaces through its [network address translation (NAT) capability](/azure/vpn-gateway/nat-howto).

## Custom DNS

Most AIS services allow customers to use their own DNS names for public endpoints, either using their own DNS servers, or via the Azure DNS offering. Configuration of these is done on a resource by resource basis, but the supported resources are listed below:

- API Management supports [custom domains](/azure/api-management/configure-custom-domain?tabs=custom)
- Function Apps and Logic Apps support [custom domains](/azure/app-service/app-service-web-tutorial-custom-domain?tabs=a%2Cazurecli), as part of the core App Service functionality