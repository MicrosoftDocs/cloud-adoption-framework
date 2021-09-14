---
title: Network topology and connectivity overview
description: Examine key design considerations and best practice surrounding networking and connectivity to, from, and within Microsoft Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- docutune:casing "Azure VPN Gateway" L7 -->
<!-- cSpell:ignore autoregistration BGPs MACsec MPLS MSEE onprem privatelink VPNs -->

# Network topology and connectivity overview

The following series of articles examines key design considerations and best practices for Azure networking and connectivity.

## Plan for IP addressing

Plan for IP addressing in Azure to ensure that IP address spaces don't overlap across on-premises locations and Azure regions. For guidance on planning IP addressing for a hybrid implementation, see [Plan for IP addressing](../azure-best-practices/plan-for-ip-addressing.md).

## Configure DNS and name resolution

Domain Name System (DNS) is an important design factor in enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Other organizations might see cloud adoption as an opportunity to modernize their internal DNS infrastructure to use native Azure capabilities.

For guidance on planning DNS and name resolution for hybrid implementations, see [DNS for on-premises and Azure resources](../azure-best-practices/dns-for-on-premises-and-azure-resources.md).

## Define an Azure network topology

Network topology is a critical element of enterprise-scale architecture that defines how applications can communicate with each other. For information about technologies and topologies for Azure deployments, see [Define an Azure network topology](../azure-best-practices/define-an-azure-network-topology.md). The article discusses two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

- The article [Virtual WAN network topology (Microsoft-managed)](../azure-best-practices/virtual-wan-network-topology.md) explores implementing an Azure Virtual WAN network topology.
- The article [Traditional Azure networking topology](../azure-best-practices/traditional-azure-networking-topology.md) covers implementing a traditional Azure networking topology.

## Connect to Azure

[Connectivity to Azure](../azure-best-practices/connectivity-to-azure.md) expands on network topology to describe recommended models to connect on-premises locations to Azure.

## Integrate Private Link and DNS zones

[Private Link and DNS integration at scale](../azure-best-practices/private-link-and-dns-integration-at-scale.md) describes how to integrate Azure Private Link for platform-as-a-service (PaaS) services with Azure Private DNS zones in hub-and-spoke network architectures.

## Connect to Azure PaaS services

Building on the previous connectivity articles, [Connectivity to Azure PaaS services](../azure-best-practices/connectivity-to-azure-paas-services.md) explores recommended connectivity approaches for Azure PaaS services.

## Limit cross-tenant private endpoint connections

To add to the previous article, [Limit cross-tenant Private Endpoint connections](../azure-best-practices/limiting-cross-tenant-pe-connections.md) explores recommended methods to limit private endpoint connections across Azure Active Directory (Azure AD) tenants.

## Plan for inbound and outbound internet connectivity

[Plan for inbound and outbound internet connectivity](../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md) describes recommended connectivity models to and from the public internet.

## Plan for application delivery

[Plan for application delivery](../azure-best-practices/plan-for-app-delivery.md) explores key recommendations to deliver internal- and external-facing applications in a secure, scalable, and highly available way.

## Plan for landing zone network segmentation

[Plan for landing zone network segmentation](../azure-best-practices/plan-for-landing-zone-network-segmentation.md) explores key recommendations to deliver highly secure internal network segmentation within a landing zone. This strategy supports a network zero-trust implementation.

## Define network encryption requirements

[Define network encryption requirements](../azure-best-practices/define-network-encryption-requirements.md) explores key recommendations for network encryption between on-premises locations and Azure, and across Azure regions.

## Plan for traffic inspection

Many industries require Azure traffic to be mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. [Plan for traffic inspection](../azure-best-practices/plan-for-traffic-inspection.md) explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

## Connect to other cloud providers

[Connectivity to other cloud providers](../azure-best-practices/connectivity-to-other-providers.md) describes different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture with other cloud providers.
