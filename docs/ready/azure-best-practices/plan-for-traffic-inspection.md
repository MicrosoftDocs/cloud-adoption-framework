---
title: Plan for traffic inspection
description: Capturing and analyzing network traffic in Azure.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/31/2024
ms.topic: conceptual
ms.custom: think-tank
---

# Plan for traffic inspection

Knowing what goes in and out of your network is essential to maintaining your security posture. You should capture all inbound and outbound traffic and perform near real-time analysis on that traffic to detect threats and mitigate network vulnerabilities.

This section explores key considerations and recommended approaches for capturing and analyzing traffic within an Azure virtual network.

## Design considerations

*Azure VPN Gateway:* VPN Gateway lets you run a packet capture on a VPN gateway, a specific connection, multiple tunnels, one-way traffic, or bi-directional traffic. A maximum of five packet captures can run in parallel per gateway. They can be gateway-wide and per connection packet capture. For more information, see [VPN packet capture](/azure/vpn-gateway/packet-capture).

*Azure ExpressRoute:* You can use [Azure Traffic Collector](/azure/expressroute/traffic-collector) to gain visibility into traffic that traverses ExpressRoute circuits. To perform trending analysis, evaluate the amount of inbound and outbound traffic that goes through ExpressRoute. You can sample network flows that traverse the external interfaces of the Microsoft edge routers for ExpressRoute. A Log Analytics workspace receives the flow logs, and you can create your own log queries for further analysis. Traffic Collector supports both provider-managed circuits and ExpressRoute Direct circuits that have 1 Gbps or more bandwidth. Traffic Collector also supports private peering or Microsoft peering configurations.

*Azure Network Watcher* has multiple tools you should consider if you're using infrastructure as a service (IaaS) solutions:

- *Packet capture:* Network Watcher lets you create temporary capture packet sessions on traffic headed to and from a virtual machine. Each packet capture session has a time limit. When the session ends, packet capture creates a `pcap` file that you can download and analyze. Network Watcher packet capture can't give you continuous port mirroring with these time constraints. For more information, see [Packet capture overview](/azure/network-watcher/network-watcher-packet-capture-overview).
  
- *Network security group (NSG) flow logs:* NSG flow logs capture information about IP traffic flowing through your NSGs. Network Watcher stores NSG flow logs as JSON files in Azure Storage account. You can export the NSG flow logs to an external tool for analysis. For more information, see NSG flow logs [overview](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) and [data analysis options](/azure/network-watcher/network-watcher-visualize-nsg-flow-logs-power-bi).

- *Virtual network flow logs:* [Virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) provide similar capabilities compared to NSG flow logs. You can use virtual network flow logs to log information about Layer 3 traffic that flows through a virtual network. Azure Storage receives flow data from virtual network flow logs. You can access the data and export it to any visualization tool, security information and event management solution, or intrusion detection system.

## Design recommendations

- Prefer [virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) over [NSG flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). Virtual network flow logs:

  - Simplify the scope of traffic monitoring. You can enable logging at the virtual network level so that you don't need to enable multiple-level flow logging to cover both subnet and NIC levels.
  
  - Add visibility for scenarios where you can't use NSG flow logs because of platform restrictions on NSG deployments.
  - Provide extra details about the [Virtual Network encryption](/azure/virtual-network/virtual-network-encryption-overview) status and the presence of [Azure Virtual Network Manager security admin rules](/azure/virtual-network-manager/concept-virtual-network-flow-logs).

  For a comparison, see [Virtual network flow logs compared to network security group flow logs](/azure/network-watcher/vnet-flow-logs-overview#virtual-network-flow-logs-compared-to-network-security-group-flow-logs).

- Don't enable virtual network flow logs and NSG flow logs simultaneously on the same target scope. If you enable NSG flow logs on the NSG of a subnet, and then you enable virtual network flow logs on the same subnet or parent virtual network, you duplicate logging and add extra costs.

- Enable traffic analytics. The tool lets you easily capture and analyze network traffic with out-of-the-box dashboard visualization and security analysis.

- If you need more capabilities than traffic analytics offers, you can supplement traffic analytics with one of our partner solutions. You can find available partner solutions in [Azure Marketplace](https://azuremarketplace.microsoft.com/home).

- Use Network Watcher packet capture regularly to get a more detailed understanding of your network traffic. Run packet capture sessions at various times throughout the week to get a good understanding of the types of traffic traversing your network.

- Don't develop a custom solution to mirror traffic for large deployments. The complexity and supportability issues tend to make custom solutions inefficient.

## Other platforms

- Manufacturing plants often have operational technology (OT) requirements that include traffic mirroring. Microsoft Defender for IoT can connect to a mirror on a switch or a terminal access point (TAP) for industrial control systems (ICS) or supervisory control and data acquisition (SCADA) data. For more information, see [traffic mirroring methods for OT monitoring](/azure/defender-for-iot/organizations/best-practices/traffic-mirroring-methods).

- Traffic mirroring supports advanced workload deployment strategies in application development. With traffic mirroring, you can perform pre-production regression testing on live workload traffic or assess quality assurance and security assurance processes offline.

- When using Azure Kubernetes Service (AKS), ensure your ingress controller supports traffic mirroring if it's a part of your workload. Common ingress controllers that support traffic mirroring are [Istio](https://istio.io/latest/docs/tasks/traffic-management/mirroring/), [NGINX](https://nginx.org/en/docs/http/ngx_http_mirror_module.html), [Traefik](https://doc.traefik.io/traefik/routing/services/#mirroring-service).
