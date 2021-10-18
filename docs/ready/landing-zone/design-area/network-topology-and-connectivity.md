---
title: Network topology and connectivity overview
description: Examine key design considerations and best practice surrounding networking and connectivity to, from, and within Microsoft Azure.
author: DominicAllen
ms.author: doallen
ms.date: 10/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- docutune:casing "Azure VPN Gateway" L7 -->
<!-- cSpell:ignore autoregistration BGPs MACsec MPLS MSEE onprem privatelink VPNs -->

# Network topology and connectivity overview

This series of articles examines key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure.

## Topology

|Scope|Context|
|-|-|
| Define an Azure network topology |Network topology is a critical element of the enterprise-scale architecture because it defines how applications can communicate with each other. <br>  [This section explores technologies and topology approaches for Azure deployments.](../azure-best-practices/define-an-azure-network-topology.md) It focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies. |
| Traditional Azure networking topology |[This section explores the option for implementing a traditional Azure networking topology.](../azure-best-practices/traditional-azure-networking-topology.md) |
| Virtual WAN network topology | [This section explores the option for implementing an Azure Virtual WAN network topology.](../azure-best-practices/virtual-wan-network-topology.md) |
| Plan for IP addressing | It's vital that your organization plans for IP addressing in Azure to ensure that the IP address space doesn't overlap across on-premises locations and Azure regions. <br> [This section provides guidance on planning IP addressing for a hybrid implementation](../azure-best-practices/plan-for-ip-addressing.md) | 



## Connectivity 

|Scope|Context|
|-|-|
| Connectivity to Azure |[This section expands on the network topology to consider recommended models for connecting on-premises locations to Azure.](../azure-best-practices/connectivity-to-azure.md)|
| Connectivity to Azure PaaS services |Building on the previous connectivity sections, [this section explores recommended connectivity approaches for using Azure PaaS services.](../azure-best-practices/connectivity-to-azure-paas-services.md)|
| Limit cross-tenant private endpoint connections| [This section explores how to limit cross-tenant private endpoint connections to prevent data leakage and meet security and compliance goals](../azure-best-practices/limit-cross-tenant-private-endpoint-connections.md) |
|Connectivity to other cloud providers | [This section provides different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to other cloud providers](../azure-best-practices/connectivity-to-other-providers.md).|
| Connectivity to Oracle Cloud Infrastructure| [Evaluate key design considerations and recommendations surrounding different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI)](../azure-best-practices/connectivity-to-other-providers-oci.md)
|Plan for application delivery | [This section explores key recommendations to deliver internal-facing and external-facing applications in a secure, highly scalable, and highly available way.](../azure-best-practices/plan-for-app-delivery.md)|

## Security

|Scope|Context|
|-|-|
| Plan for inbound and outbound internet connectivity | [This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.](../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md)|
| Plan for landing zone network segmentation | [This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network zero-trust implementation.](../azure-best-practices/plan-for-landing-zone-network-segmentation.md)|
| Define network encryption requirements | [This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.](../azure-best-practices/define-network-encryption-requirements.md)|
|Plan for traffic inspection |In many industries, organizations require that traffic in Azure is mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. [This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network](../azure-best-practices/plan-for-traffic-inspection.md).|

## Resources

|Scope|Context|
|-|-|
|Private Link and DNS integration at scale| [This section describes how to integrate Azure Private Link for PaaS services with Azure Private DNS zones in hub and spoke network architectures.](../azure-best-practices/private-link-and-dns-integration-at-scale.md)|
|Configure DNS and name resolution for on-premises and Azure resources| Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.
[This section explores guidance on planning DNS and name resolution for hybrid implementations.](../azure-best-practices/dns-for-on-premises-and-azure-resources.md)|

