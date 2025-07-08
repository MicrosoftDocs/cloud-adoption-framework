---
title: Network topology and connectivity considerations for Azure API Management
description: Learn about design considerations and recommendations for network topology and connectivity in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Network topology and connectivity considerations for the API Management landing zone accelerator

This article provides design considerations and recommendations for network topology and connectivity when using the API Management landing zone accelerator. Networking is central to almost everything inside a landing zone. It enables connectivity to other Azure services, external users, and internal and external APIs.

Learn more about the [network topology and connectivity](../../../ready/landing-zone/design-area/network-topology-and-connectivity.md) design area.

## Design considerations

- Decide if the APIs are accessible externally or internally.
- Decide if there should be multiple gateways deployed and how these are load balanced - for example, by using [Application Gateway](/azure/application-gateway/overview).
- Decide if the network setup requires cross-region connectivity.
- Decide if [private endpoint connectivity](/azure/api-management/private-endpoint) to the API Management instance is required.
- Decide how to connect to external (3rd party) workloads.
- Decide whether [virtual network connection](/azure/virtual-network/virtual-networks-overview) is required and the access type for virtual network connection ([external](/azure/api-management/api-management-using-with-vnet) or [internal](/azure/api-management/api-management-using-with-internal-vnet)).
- Decide whether connectivity to on-premises or multi-cloud environments is required.
- Decide if [multi-region deployment](/azure/api-management/api-management-howto-deploy-multi-region) is required to service geographically distributed API consumers.
- Consider using a load balancing solution such as [Application Gateway](/azure/application-gateway/overview) or [Azure Front Door](/azure/frontdoor/front-door-overview).
- If you are using Azure ExpressRoute for hybrid connectivity, consider designing for high availability. For more information, see [Designing for high availability with ExpressRoute](/azure/expressroute/designing-for-high-availability-with-expressroute). To ensure ExpressRoute resiliency, see [Azure Proactive Resiliency Library](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-gateway/).

## Design recommendations

- Use [Application Gateway](/azure/api-management/api-management-howto-integrate-internal-vnet-appgateway) for external access to API Management when the API Management instance is deployed in a VNet in internal mode.
- Use Azure Front Door for multi-region deployment.
- Ensure [required ports](/azure/api-management/virtual-network-reference) (such as `80`, `443`) are open between the calling client and the backend API Management gateway.
- Deploy the API Management gateway in a VNet to allow access to backend services in the network.
- VNet peering supports high performance in a region but has a scalability limit of 500 networks. If you require more workloads to be connected, use a [hub spoke](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) architecture or [Private Endpoint](/azure/private-link/private-endpoint-overview).
- When a VNet is used in internal mode, make it easy for consumers to onboard (connect) to your API Management platform. Provide an open network path (through upstream hub or network security group setup) to remove friction when connecting to API Management.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the API Management landing zone accelerator:

- Deployment of the API Management instance in a dedicated VNet subnet in internal mode.
- External access to API Management using Azure Application Gateway.
