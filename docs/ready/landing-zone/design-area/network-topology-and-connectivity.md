---
title: Overview of network topology and connectivity for Azure
description: Examine key design considerations and best practices surrounding networking and connectivity.
author: timwarner-msft
ms.author: timwarner
ms.date: 06/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, UpdateFrequency.5
---

# Network topology and connectivity

The network topology and connectivity design area is critical for establishing a foundation for your cloud network design.

## Design area review

**Involved roles or functions:** This design area probably requires support from one or more [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) functions to make and implement decisions.

**Scope:** The goal of network design is to align your cloud network design with overall cloud adoption plans. If your cloud adoption plans include hybrid or multicloud dependencies, or if you need connectivity for other reasons, your network design should also incorporate those connectivity options and expected traffic patterns.

**Out of scope:** This design area establishes the foundation for networking. It doesn't address compliance-related issues like advanced network security or automated enforcement guardrails. That guidance comes when you review the [security](./security.md) and [governance](./governance.md) compliance design areas. Postponing security and governance discussions lets the cloud platform team address initial networking requirements before they expand their audience for more complex topics.

**New (greenfield) cloud environment:** To start your cloud journey with a small set of subscriptions, see [Create your initial Azure subscriptions](../../azure-best-practices/initial-subscriptions.md). Also, consider using Bicep deployment templates in building out your new Azure landing zones. For more information, see [Azure Landing Zones Bicep - Deployment Flow](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow).

**Existing (brownfield) cloud environment:** Consider the following if you are interested in applying proven-practice Azure virtual network (VNet) design principles to existing Azure environments:

- Review our best practices for planning, deploying, and maintaining [Azure VNet hub and spoke topologies](../../azure-best-practices/hub-spoke-network-topology.md)
- Consider [Azure Virtual Network Manager (Preview)](/azure/virtual-network-manager/overview) to centralize network security group (NSG) security rules across multiple VNets
- [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) unifies networking, security, and routing to help businesses build hybrid cloud architectures safer and faster
- Access Azure data services privately with [Azure Private Link](/azure/private-link/private-link-overview). The Private Link service ensures your users and applications communicate with key Azure services by using the Azure backbone network and private IP addresses instead of using the public Internet.

The [Azure Landing Zones Bicep - Deployment Flow](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow) repository contains a number of Bicep deployment templates that can accelerate your greenfield and brownfield Azure landing zone deployments. These templates already have Microsoft proven-practice network design and configuration guidance integrated within them.

For instance, the [Azure Landing Zones Bicep - Deployment Flow - Hub and Spoke](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlowHS) workflow includes Bicep modules to accelerate Azure virtual network hub-and-spoke architectures.

For more information on working in brownfield cloud environments, see [Brownfield environment considerations](../brownfield-considerations.md).

## Design area overview

Network topology and connectivity are fundamental for organizations that are planning their landing zone design. Networking is central to almost everything inside a landing zone. It enables connectivity to other Azure services, external users, and on-premises infrastructure. Network topology and connectivity are in the [environmental group](../design-areas.md#environment-design-areas) of Azure landing zone design areas. This grouping is based on their importance in core design and implementation decisions.

This series of articles examines key design considerations and best practices around networking and connectivity to, from, and within Azure.

## Topology

Network topology is a critical element of landing zone architecture because it defines how applications communicate with each other. This section focuses on two core approaches: topologies based on Azure Virtual WAN and traditional topologies.

- [Define an Azure network topology](../../azure-best-practices/define-an-azure-network-topology.md) explores technologies and topology approaches for Azure deployments.
- [Traditional Azure networking topology](../../azure-best-practices/traditional-azure-networking-topology.md) explores the option of implementing a traditional Azure networking topology.
- [Virtual WAN network topology (Microsoft-managed)](../../azure-best-practices/virtual-wan-network-topology.md) explores the option of implementing a Virtual WAN network topology.
- [Plan for IP addressing](../../azure-best-practices/plan-for-ip-addressing.md) provides guidance on planning IP addressing for a hybrid implementation. Your organization's IP address space shouldn't overlap across on-premises locations and Azure regions.

## Connectivity

- [Connectivity to Azure](../../azure-best-practices/connectivity-to-azure.md) expands on network topology to consider recommended models for connecting on-premises locations to Azure.
- [Connectivity to Azure platform as a service (PaaS)](../../azure-best-practices/connectivity-to-azure-paas-services.md) builds on previous connectivity sections to explore recommended connectivity approaches for Azure PaaS services.
- [Limit cross-tenant private endpoint connections](../../azure-best-practices/limit-cross-tenant-private-endpoint-connections.md) explores how to limit cross-tenant private endpoint connections to prevent data leakage and meet security and compliance goals.
- [Connectivity to other cloud providers](../../azure-best-practices/connectivity-to-other-providers.md) describes different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture with other cloud providers.
- [Connectivity to Oracle Cloud Infrastructure (OCI)](../../azure-best-practices/connectivity-to-other-providers-oci.md) evaluates key design considerations and different approaches to integrate Azure enterprise-scale landing zone architecture to OCI.
- [Plan for application delivery](../../azure-best-practices/plan-for-app-delivery.md) explores key recommendations to deliver secure, scalable, and highly available internal- and external-facing applications.

## Network security

- [Plan for inbound and outbound internet connectivity](../../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md) describes recommended connectivity models to and from the public internet.
- [Plan for landing zone network segmentation](../../azure-best-practices/plan-for-landing-zone-network-segmentation.md) explores key recommendations for highly secure internal network segmentation within a landing zone to support a zero-trust network implementation.
- [Define network encryption requirements](../../azure-best-practices/define-network-encryption-requirements.md) explores key recommendations for network encryption between on-premises and Azure and across Azure regions.
- [Plan for traffic inspection](../../azure-best-practices/plan-for-traffic-inspection.md) explores key considerations and recommended approaches for mirroring or tapping traffic in Azure Virtual Network. Many organizations require Azure traffic to be mirrored to a network packet collector for deep inspection and packet analysis. This requirement typically focuses on inbound and outbound internet traffic.

## Resources

- [Azure Private Link and Domain Name System (DNS) integration at scale](../../azure-best-practices/private-link-and-dns-integration-at-scale.md) describes how to integrate Private Link for PaaS services with Azure Private DNS zones in hub-and-spoke network architectures.
- [Configure DNS and name resolution for on-premises and Azure resources](../../azure-best-practices/dns-for-on-premises-and-azure-resources.md) explores guidance on planning DNS and name resolution for hybrid implementations. DNS is a critical design topic in enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.
- [Plan for virtual machine remote access](../../azure-best-practices/plan-for-virtual-machine-remote-access.md) describes how to securely connect into Azure virtual machines.
