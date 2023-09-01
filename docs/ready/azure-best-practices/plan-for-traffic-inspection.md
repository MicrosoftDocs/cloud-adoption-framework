---
title: Plan for traffic inspection
description: Capturing and analyzing network traffic in Azure.
author: stephen-sumner
ms.author: ssumner
ms.date: 09/15/2022
ms.topic: conceptual
ms.custom: think-tank
---

# Plan for traffic inspection

Knowing what goes in and out of your network is essential to maintaining your security posture. You should capture all inbound and outbound traffic and perform near real-time analysis on that traffic to detect threats and mitigate network vulnerabilities.

This section explores key considerations and recommended approaches for capturing and analyzing traffic within an Azure virtual network.

## Design considerations

*Azure VPN Gateway -* VPN Gateway lets you run a packet capture on a VPN gateway, a specific connection, multiple tunnels, one-way traffic, or bi-directional traffic. A maximum of five packet captures can run in parallel per gateway. They can be gateway-wide and per-connection packet captures. For more information, see [VPN packet capture](/azure/vpn-gateway/packet-capture).

*Azure Network Watcher* has multiple tools you should consider if you're using infrastructure-as-a-service (IaaS) solutions:

- *Packet capture -* Network Watcher lets you create temporary capture packet sessions on traffic headed to and from a virtual machine. Each packet capture session has a time limit. When the session ends, packet capture creates a `pcap` file that you can download and analyze. Network Watcher packet capture can't give you continuous port mirroring with these time constraints. For more information, see [packet capture overview](/azure/network-watcher/network-watcher-packet-capture-overview).
  
- *Network Security Group (NSG) flow logs -* NSG flow logs capture information about IP traffic flowing through your NSGs. Network Watcher stores NSG flow logs as JSON files in Azure Storage account. You can export the NSG flow logs to an external tool for analysis. For more information, see NSG flow logs [overview](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) and [data analysis options](/azure/network-watcher/network-watcher-visualize-nsg-flow-logs-power-bi).
  
- *Traffic Analytics -* Traffic Analytics ingests and analyzes NSG flow logs. It creates a dashboard of insights on the NSG flow logs and generates a geo-map view of your resources for easy analysis. For more information, see [Traffic Analytics overview](/azure/network-watcher/traffic-analytics).

## Design recommendations

- Enable Traffic Analytics. The tool lets you easily capture and analyze network traffic with out-of-the-box dashboard visualization and security analysis.

- If you need more capabilities than Traffic Analytics offers, you can supplement Traffic Analytics with one of our partner solutions. You can find available partner solutions in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home).

- Use Network Watcher packet capture regularly to get a more detailed understanding of your network traffic. Run packet capture sessions at various times throughout the week to get a good understanding of the types of traffic traversing your network.

- Don't develop a custom solution to mirror traffic for large deployments. The complexity and supportability issues tend to make custom solutions inefficient.

## Other platforms

- Manufacturing plants often have operational technology (OT) requirements that include traffic mirroring. Microsoft Defender for IoT can connect to a mirror on a switch or a terminal access point (TAP) for industrial control systems (ICS) or supervisory control and data acquisition (SCADA) data. For more information, see [traffic mirroring methods for OT monitoring](/azure/defender-for-iot/organizations/best-practices/traffic-mirroring-methods).

- Traffic mirroring supports advanced workload deployment strategies in application development. With traffic mirroring, you can perform pre-production regression testing on live workload traffic or assess quality assurance and security assurance processes offline.

- When using Azure Kubernetes Service (AKS), ensure your ingress controller supports traffic mirroring if it's a part of your workload. Common ingress controllers that support traffic mirroring are [Istio](https://istio.io/latest/docs/tasks/traffic-management/mirroring/), [NGINX](https://nginx.org/en/docs/http/ngx_http_mirror_module.html), [Traefik](https://doc.traefik.io/traefik/routing/services/#mirroring-service).
