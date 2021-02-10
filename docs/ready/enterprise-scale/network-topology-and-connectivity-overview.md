---
title: Network topology and connectivity
description: Examine key design considerations and best practice surrounding networking and connectivity to, from, and within Microsoft Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- docutune:casing "Azure VPN Gateway" L7 -->
<!-- cSpell:ignore autoregistration BGPs MACsec MPLS MSEE onprem privatelink VPNs -->

# Network topology and connectivity

This article examines key design considerations and recommendations surrounding networking and connectivity to, from, and within Microsoft Azure.

## Plan for IP addressing

It's vital that your organization plans for IP addressing in Azure to ensure that the IP address space doesn't overlap across on-premises locations and Azure regions.

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

## Define an Azure network topology

Network topology is a critical element of the enterprise-scale architecture because it defines how applications can communicate with each other. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

Virtual WAN is used to meet large-scale interconnectivity requirements. Because it is a Microsoft-managed service, it also reduces overall network complexity and helps to modernize your organization's network. A Virtual WAN based topology may be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across several Azure regions and requires global connectivity between VNets in these Azure regions and multiple on-premises locations.
- Your organization intends to integrate a large-scale branch network directly in to Azure, either via a software-defined WAN (SD-WAN) deployment or requires more than 30 branch sites for native IPsec termination.
- You require transitive routing between VPN and ExpressRoute. E.g. Remote branches connected via Site-to-site VPN or remote users connected via Point-to-site VPN, require connectivity to an ExpressRoute connected DC, via Azure.

A traditional hub-and-spoke network topology helps you build customized secure large-scale networks in Azure with routing and security managed by the customer. A traditional topology may be most appropriate if any of the following points meet your requirements:

- Your organization intends to deploy resources across one or several Azure regions and while some traffic across Azure regions is expected (for example, traffic between two virtual networks across two different Azure regions), a full mesh network across all Azure regions is not required.
- You have a low number of remote or branch locations per region. That is, you need fewer than 30 IP security (IPsec) site-to-site tunnels.
- You require full control and granularity for manually configuring of your Azure network routing policy.

## Virtual WAN network topology (Microsoft-managed)

![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)
_Figure 1: Virtual WAN network topology._

## Traditional Azure networking topology

![Diagram that illustrates a traditional Azure network topology.](./media/customer-managed-topology.png)

_Figure 4: A traditional Azure network topology._

## Connectivity to Azure

This section expands on the network topology to consider recommended models for connecting on-premises locations to Azure.

## Connectivity to Azure PaaS services

Building on the previous connectivity sections, this section explores recommended connectivity approaches for using Azure PaaS services.

## Plan for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.

## Plan for app delivery

This section explores key recommendations to deliver internal-facing and external-facing apps in a secure, highly scalable, and highly available way.

## Plan for landing zone network segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network zero-trust implementation.

## Define network encryption requirements

This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

## Plan for traffic inspection

In many industries, organizations require that traffic in Azure is mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

## Connectivity to other Cloud provider

This section provides different connectivity approaches to integrate an Azure Enterprise Scale landing zone architecture to other Cloud providers
