---
title: Overview of network topology and connectivity for Azure
description: Examine key design considerations and best practices surrounding networking and connectivity.
author: DominicAllen
ms.author: doalle
ms.date: 12/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- docutune:casing "Azure VPN Gateway" L7 -->
<!-- cSpell:ignore autoregistration BGPs MACsec MPLS MSEE onprem privatelink VPNs -->

# Network topology and connectivity

The network topology and connectivity design area is critical for establishing a foundation for your cloud network design.

## Design area review

**Involved roles or functions:** This design area probably requires support from one or more [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) functions to make and implement decisions.

**Scope:** The goal of network design is to align your cloud network design with overall cloud adoption plans. If your cloud adoption plans include hybrid or multicloud dependencies, or if you need connectivity for other reasons, your network design should also incorporate those connectivity options and expected traffic patterns.

**Out of scope:** This design area establishes the foundation for networking, but doesn't address compliance-related issues like advanced network security or automated enforcement guardrails. That guidance comes when you review the [security](./security.md) and [governance](./governance.md) compliance design areas. Postponing security and governance discussions lets the cloud platform team address initial networking requirements before expanding their audience for more complex topics.

## Design area overview

Network topology and connectivity are fundamental for organizations planning their landing zone design. Networking is central to almost everything inside a landing zone, and enables connectivity to other Azure services, external users, and on-premises infrastructure. Network topology and connectivity are in the [environmental group](../design-areas.md#environment-design-areas) of Azure landing zone design areas, given their importance in core design and implementation decisions.

This series of articles examines key design considerations and best practices around networking and connectivity to, from, and within Azure.

## Topology

Network topology is a critical element of landing zone architecture, because it defines how applications communicate with each other. This section focuses on two core approaches: topologies based on Azure Virtual WAN, and traditional topologies.

- [Define an Azure network topology](../../azure-best-practices/define-an-azure-network-topology.md) explores technologies and topology approaches for Azure deployments.
- [Traditional Azure networking topology](../../azure-best-practices/traditional-azure-networking-topology.md) explores the option of implementing a traditional Azure networking topology.
- [Virtual WAN network topology (Microsoft-managed)](../../azure-best-practices/virtual-wan-network-topology.md) explores the option of implementing an Azure Virtual WAN network topology.
- It's important to plan for IP addressing in Azure, to ensure that your organization's IP address space doesn't overlap across on-premises locations and Azure regions. [Plan for IP addressing](../../azure-best-practices/plan-for-ip-addressing.md) provides guidance on planning IP addressing for a hybrid implementation.

## Connectivity

- [Connectivity to Azure](../../azure-best-practices/connectivity-to-azure.md) expands on network topology, to consider recommended models for connecting on-premises locations to Azure.
- [Connectivity to Azure PaaS services](../../azure-best-practices/connectivity-to-azure-paas-services.md) builds on previous connectivity sections, to explore recommended connectivity approaches for Azure platform as a service (PaaS) services.
- [Limit cross-tenant private endpoint connections](../../azure-best-practices/limit-cross-tenant-private-endpoint-connections.md) explores how to limit cross-tenant private endpoint connections to prevent data leakage and meet security and compliance goals.
- [Connectivity to other cloud providers](../../azure-best-practices/connectivity-to-other-providers.md) describes different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture with other cloud providers.
- [Connectivity to Oracle Cloud Infrastructure](../../azure-best-practices/connectivity-to-other-providers-oci.md) evaluates key design considerations and different approaches to integrate Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI).
- [Plan for application delivery](../../azure-best-practices/plan-for-app-delivery.md) explores key recommendations to deliver secure, scalable, and highly available internal- and external-facing applications.

## Network security

- [Plan for inbound and outbound internet connectivity](../../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md) describes recommended connectivity models to and from the public internet.
- [Plan for landing zone network segmentation](../../azure-best-practices/plan-for-landing-zone-network-segmentation.md) explores key recommendations for highly secure internal network segmentation within a landing zone, to support a zero-trust network implementation.
- [Define network encryption requirements](../../azure-best-practices/define-network-encryption-requirements.md) explores key recommendations for network encryption between on-premises and Azure, and across Azure regions.
- Many organizations require Azure traffic to be mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. [Plan for traffic inspection](../../azure-best-practices/plan-for-traffic-inspection.md) explores key considerations and recommended approaches for mirroring or tapping traffic in Azure Virtual Network.

## Resources

- [Private Link and Domain Name System (DNS) integration at scale](../../azure-best-practices/private-link-and-dns-integration-at-scale.md) describes how to integrate Azure Private Link for PaaS services with Azure Private DNS zones in hub-and-spoke network architectures.
- DNS is a critical design topic in enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities. [Configure DNS and name resolution for on-premises and Azure resources](../../azure-best-practices/dns-for-on-premises-and-azure-resources.md) explores guidance on planning DNS and name resolution for hybrid implementations.

- [Plan for virtual machine remote access](../../azure-best-practices/plan-for-virtual-machine-remote-access.md) describes how to securely connect into Azure virtual machine.
