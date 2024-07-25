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

* Azure Express Route -* [ExpressRoute Traffic Collector](/azure/expressroute/traffic-collector) can be used to gain visibility into traffic traversing Express Route circuits, evaluating the amount of traffic going through ExpressRoute for trending analysis, separating between inbound/outbound and outbound traffic. It enables sampling of network flows traversing the external interfaces of the Microsoft edge routers for ExpressRoute. Flow logs get sent to a Log Analytics workspace where you can create your own log queries for further analysis. ExpressRoute Traffic Collector supports both provider-managed circuits and ExpressRoute Direct circuits with bandwidth 1 Gbps or greater and private or Microsoft peering configured.

*Azure Network Watcher* has multiple tools you should consider if you're using infrastructure-as-a-service (IaaS) solutions:

- *Packet capture -* Network Watcher lets you create temporary capture packet sessions on traffic headed to and from a virtual machine. Each packet capture session has a time limit. When the session ends, packet capture creates a `pcap` file that you can download and analyze. Network Watcher packet capture can't give you continuous port mirroring with these time constraints. For more information, see [packet capture overview](/azure/network-watcher/network-watcher-packet-capture-overview).
  
- *Network Security Group (NSG) flow logs -* NSG flow logs capture information about IP traffic flowing through your NSGs. Network Watcher stores NSG flow logs as JSON files in Azure Storage account. You can export the NSG flow logs to an external tool for analysis. For more information, see NSG flow logs [overview](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) and [data analysis options](/azure/network-watcher/network-watcher-visualize-nsg-flow-logs-power-bi).

- *Virtual network flow logs* - Virtual network flow logs provide similar capabilities compared to NSG [flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). You can use them to log information about IP traffic flowing through a virtual network. Flow data from virtual network flow logs is sent to Azure Storage. From there, you can access the data and export it to any visualization tool, security information and event management (SIEM) solution, or intrusion detection system (IDS). For more information, see Virtual network [flow logs](/azure/network-watcher/vnet-flow-logs-overview) overview.

## Design recommendations

- Prefer [Virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) over [NSG flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). For a comparison, see [Virtual network flow logs compared to network security group flow logs](/azure/network-watcher/vnet-flow-logs-overview#virtual-network-flow-logs-compared-to-network-security-group-flow-logs).

- Do not enable  [Virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) and [NSG flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) simultaneously on the same target scope. If you enable network security group flow logs on the network security group of a subnet, then you enable virtual network flow logs on the same subnet or parent virtual network, you might get duplicate logging and additional costs.

- Enable Traffic Analytics. The tool lets you easily capture and analyze network traffic with out-of-the-box dashboard visualization and security analysis.

- If you need more capabilities than Traffic Analytics offers, you can supplement Traffic Analytics with one of our partner solutions. You can find available partner solutions in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home).

- Use Network Watcher packet capture regularly to get a more detailed understanding of your network traffic. Run packet capture sessions at various times throughout the week to get a good understanding of the types of traffic traversing your network.

- Don't develop a custom solution to mirror traffic for large deployments. The complexity and supportability issues tend to make custom solutions inefficient.

## Other platforms

- Manufacturing plants often have operational technology (OT) requirements that include traffic mirroring. Microsoft Defender for IoT can connect to a mirror on a switch or a terminal access point (TAP) for industrial control systems (ICS) or supervisory control and data acquisition (SCADA) data. For more information, see [traffic mirroring methods for OT monitoring](/azure/defender-for-iot/organizations/best-practices/traffic-mirroring-methods).

- Traffic mirroring supports advanced workload deployment strategies in application development. With traffic mirroring, you can perform pre-production regression testing on live workload traffic or assess quality assurance and security assurance processes offline.

- When using Azure Kubernetes Service (AKS), ensure your ingress controller supports traffic mirroring if it's a part of your workload. Common ingress controllers that support traffic mirroring are [Istio](https://istio.io/latest/docs/tasks/traffic-management/mirroring/), [NGINX](https://nginx.org/en/docs/http/ngx_http_mirror_module.html), [Traefik](https://doc.traefik.io/traefik/routing/services/#mirroring-service).
