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

This series of articles examines key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure.

## Plan for IP addressing

It's vital that your organization plans for IP addressing in Azure to ensure that the IP address space doesn't overlap across on-premises locations and Azure regions.

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

## Define an Azure network topology

Network topology is a critical element of the enterprise-scale architecture because it defines how applications can communicate with each other. This section explores technologies and topology approaches for Azure deployments. It focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

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

This section provides different connectivity approaches to integrate an Azure Enterprise Scale Landing Zone architecture to other Cloud providers.
