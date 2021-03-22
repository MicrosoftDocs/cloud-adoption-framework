---
title: Plan for IP addressing
description: Examine key design considerations and recommendations surrounding IP addressing in Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- docutune:ignore "Azure VPN Gateway" -->

# Plan for IP addressing

It's vital that your organization plans for IP addressing in Azure to ensure that the IP address space doesn't overlap across on-premises locations and Azure regions.

**Design considerations:**

- Overlapping IP address spaces across on-premises and Azure regions will create major contention challenges.

- You can add address space after you create a virtual network. This process requires an outage if the virtual network is already connected to another virtual network via virtual network peering because the peering must be deleted and re-created.

- Azure reserves five IP addresses within each subnet. Factor in those addresses when you're sizing virtual networks and encompassed subnets.

- Some Azure services require [dedicated subnets](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network). These services include Azure Firewall and Azure VPN Gateway.

- You can delegate subnets to certain services to create instances of a service within the subnet.

**Design recommendations:**

- Plan for non-overlapping IP address spaces across Azure regions and on-premises locations well in advance.

- Use IP addresses from the address allocation for private internets (RFC 1918).

- For environments that have limited availability of private IP addresses (RFC 1918), consider using IPv6.

- Don't create unnecessarily large virtual networks (for example, `/16`) to ensure that IP address space isn't wasted.

- Don't create virtual networks without planning the required address space in advance. Adding address space will cause an outage after a virtual network is connected via virtual network peering.

- Don't use public IP addresses for virtual networks, especially if the public IP addresses don't belong to your organization.
