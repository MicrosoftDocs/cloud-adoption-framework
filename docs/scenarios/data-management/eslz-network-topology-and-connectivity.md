---
title: Enterprise Scale Analytics and AI Networking
description: Enterprise Scale Analytics and AI Architecture Networking.
author: 
ms.author:  # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise Scale Analytics and AI Networking

This section outlines the networking patterns to assist with:

- integrating across clouds
- restricting data exfiltration
- facilitating remote workers
- interfacing with on-premises and Software-as-a-Service solutions

It builds upon the Cloud Adoption Framework for [Network topology and connectivity](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity).

## Private Endpoints

The Enterprise Scale Analytics and AI Framework uses [Private Link](https://docs.microsoft.com/azure/private-link/private-link-service-overview), where available, for shared PaaS services. Private Link is generally available for several services and is in public preview for numerous additional services. Private Link addresses data exfiltration concerns associated with service endpoints.

For the current list of supported products, see [Private Link Resources](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource).

>[!CAUTION]
>By design, Enterprise Scale Analytics and AI Networking uses Private Endpoints where available for connectivity to PaaS services.

### Azure DNS Resolver Implementation for Private Endpoints

DNS resolution for private endpoints should be handled through central [Azure Private DNS](https://docs.microsoft.com/azure/dns/private-dns-overview) zones. Required DNS records for private endpoints can be automatically created using Azure Policy to allow access through FQDNs (Fully Qualified Domain Name). The lifecycle of the DNS records will follow the lifecycle of the private endpoints and will be automatically removed when the private endpoint is deleted.

The first challenge when trying to resolve Private Endpoints from on-premises networks, when leveraging Azure Private DNS zones, is how to retrieve the Private Endpoint IP via 168.63.129.16 since this IP address is not reachable from on-premises networks.

>[!NOTE]
>As of July 2020, you should use a custom DNS forwarder deployed in the Azure VNet (Azure Virtual Network) and have on-premises DNS Servers forward requests to them for each private endpoint.

It is important that on-premises DNS Servers are configured correctly to forward the appropriate requests to the Custom DNS server in Azure. There are multiple ways to do this.

- If you have Custom DNS already in Azure, you just need to setup conditional forwarders on your on-premises DNS server pointing to it.
- If you do not have a Custom DNS VM in Azure, you can deploy the Azure Virtual Machine Scale Set that includes Nginx already configured to forward DNS requests to Azure-provided DNS IP **168.63.129.16**. Refer to [Deploy VMSS of a NGINX DNS Proxy into an existing Virtual Network](https://github.com/Microsoft/PL-DNS-Proxy).

![Example of DNS Setup](./images/dns_setup.png)

When Custom DNS servers are pointing to other DNS servers as forwarders, you may face similar name resolution challenges when dealing with on-premises DNS Servers to resolve Private Endpoints records stored in Azure Private DNS zones. Most of those challenges can be easily resolved by having your on-premises DNS Server use conditional forwarders for original PaaS service names (*e.g.* `blob.core.windows.net`).

### IPv6 Usage

Azure's original IPv6 connectivity makes it easy to provide dual stack (IPv4/IPv6) Internet connectivity for applications hosted in Azure. It allows for simple deployment of VMs with load balanced IPv6 connectivity for both inbound and outbound initiated connections.

IPv6 usage has the following limitations:

- ExpressRoute gateways CAN be used for IPv4-only traffic in a VNet with IPv6 enabled.
- VPN gateways CANNOT be used in a VNet with IPv6 enabled, either directly or peered with "UseRemoteGateway".
- The Azure platform does not support IPv6 communication for Containers. (*e.g.* Azure Kubernetes Service)
- IPv6 can be load balanced only to the primary network interface controller (NIC) on Azure VMs. Load balancing IPv6 traffic to secondary NICs is not supported.
- IPv6-only Virtual Machines or Virtual Machines Scale Sets are not supported; each NIC must include at least one IPv4 IP configuration.
- Forward DNS for IPv6 is supported for Azure public DNS today but Reverse DNS is not yet supported.

>[!WARNING]
>As of July 2020, we do not recommend using dual stack within the Enterprise Scale Analytics and AI Framework and will update our guidance should this change.

## Data Management Landing Zone Networking

The Data Management Landing Zone will connect to the Azure Networking Management Subscription via VNet Peering, which will connect to on-premises resources via ExpressRoute circuits and third-party clouds.

Data Management Landing Zone services which support Private Link such as Azure Purview will be injected into the Data Management Landing Zone VNet.

![High Level Overview of Networking for Enterprise Scale Analytics and AI](./images/networking_overview.png)
Figure 1: High Level Overview of Networking for Enterprise Scale Analytics and AI

## Data Management Landing Zone to Data Landing Zone

For every new Data Landing Zone, you should create a VNet peering from the Data Management Landing Zone to the Data Landing Zone.

You can connect virtual networks to each other with virtual network peering. These virtual networks can be in the same region or different regions (also known as Global VNet peering). Once virtual networks are peered, resources in both virtual networks can communicate with each other with the same latency and bandwidth as if the resources were in the same virtual network.

>[!IMPORTANT]
>Data Management Landing Zone will connect to Analytics and AI Landing Zone(s) via Virtual Network Peering

## Data Landing Zones to Data Landing Zones

Data Landing Zones are connected to the other Data Landing Zones via VNet Peering.

## Data Management Landing Zone to Third-Party Clouds

To enable connectivity between a Data Management Landing Zone and a third-party cloud, a [Site-to-Site VPN](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-tutorial-vpnconnection-powershell) gateway connection is used. It can connect your on-premises or third-party cloud Landing Zone to an Azure Virtual Network over an IPsec or Internet Key Exchange (IKEv1 or IKEv2) VPN tunnel.

Site-to-Site VPN can provide better continuity for your workloads in a hybrid cloud setup with Azure.

>[!IMPORTANT]
>For connections to a third-party cloud, we recommend implementing a Site-to-Site VPN between Azure Connectivity Subscription and third-party clouds Connectivity Subscription.
