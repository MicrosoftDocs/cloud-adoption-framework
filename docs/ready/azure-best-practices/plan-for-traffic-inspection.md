---
title: Plan for traffic inspection
description: Examine key design considerations and recommendations surrounding mirroring or tapping traffic within an Azure virtual network.
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Plan for traffic inspection

In many industries, organizations require that traffic in Azure is mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

**Design considerations:**

<!-- docutune:ignore TAP -->

- The [Azure Virtual Network terminal access point (TAP)](/azure/virtual-network/virtual-network-tap-overview) preview is currently on hold in all Azure regions.

- Packet capture in Azure Network Watcher is generally available, but captures are limited to a maximum period of five hours.

**Design recommendations:**

As an alternative to Azure Virtual Network TAP, evaluate the following options:

- Use Network Watcher packets to capture despite the limited capture window.

- Evaluate whether the latest version of NSG flow logs provides the level of detail that you need.

- Use partner solutions for scenarios that require deep packet inspection.

- Don't develop a custom solution to mirror traffic. Although this approach might be acceptable for small-scale scenarios, we don't encourage it at scale because of complexity and the supportability issues that might arise.
