---
title: Plan for traffic inspection
description: Find guidance on capturing and analyzing network traffic in Azure.
author: stephen-sumner
ms.author: ssumner
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Plan for traffic inspection

Knowing what comes in and out of your network is essential to your security posture. You should capture all inbound and outbound traffic and perform near real-time analysis on that traffic. This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network.

**Design considerations:**

<!-- docutune:ignore TAP -->

*Azure VPN Gateway -* VPN Gateway lets you run a packet capture on the VPN gateway, a specific connection, multiple tunnels, one-way traffic, or bi-directional traffic. A maximum of five packet captures can run in parallel per gateway. They can be gateway-wide and per-connection packet captures. For more information, see [VPN packet capture](/azure/vpn-gateway/packet-capture)

*Azure Network Watcher* has multiple tools you should consider if you're using infrastructure-as-a-service (IaaS) solutions:

- *Packet capture -* Network Watcher lets you create temporary capture packet sessions to and from a virtual machine. Each packet capture session has a time limit and creates a `pcap` file for analysis. Network Watcher packet capture can't give you continuous port mirroring with these time constraints. For more information, see [packet capture overview](/azure/network-watcher/network-watcher-packet-capture-overview).
  
- *Network Security Group (NSG) flow Logs -* NSG flow logs capture information about IP traffic flowing through your NSGs. Network Watcher stores NSG flow logs in as JSON files in Azure Storage account. [You can export the NSG flow logs to an external tool for analysis. For more information, see NSG flow logs [overview](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) and [data analysis options](/azure/network-watcher/network-watcher-visualize-nsg-flow-logs-power-bi).
  
- *Traffic Analytics -* Traffic Analytics ingests and analyzes NSG flow logs. It creates a dashboard of insights on all inbound and outbound network traffic. It creates a geo-map view of your resources and traffic with detailed dashboard analysis. For more information, see [Traffic Analytics overview](/azure/network-watcher/traffic-analytics).

**Design recommendations:**

- Use Traffic Analytics to capture inbound and outbound network traffic with out-of-the-box dashboard visualization and security analysis.

- Configure Network Watcher packet capture to get a more detailed understanding of your network traffic. Run packet capture sessions at different times and days to get a more comprehensive view of your network traffic.

- Find and deploy partner solutions for supplementary or enhanced traffic monitoring solutions. You can find available solutions in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home).

- Don't develop a custom solution to mirror traffic for large deployments. The complexity and supportability issues tend to make custom solutions difficult to generate value.
