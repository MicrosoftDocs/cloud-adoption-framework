---
title: Azure VMware Solution Network Design Guide - Internet outbound connectivity
description: Learn how to design Internet outbound connectivity for Azure VMware Solution.
author: fguerri
ms.author: fguerri
ms.date: 06/06/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase #4: Internet outbound connectivity
Design Phase #4 is driven by the outbound Internet connectivity requirements of the applications deployed on Azure VMware Solution. Basic Internet access may be sufficient for virtual machines hosted on the private cloud to download software updates. B2B collaboration scenarios where access to a third party API is allowed only from authorized IP addresses may require granular control over the NAT pool. In VDI scenarios, the volume of internet browsing sessions to be supported may require control over the size of the NAT pool.

Almost invariably, outbound Internet access must be secured, by routing connections through a firewall or proxy device. Azure VMware Solution supports deploying such devices in the private cloud itself, or in an Azure virtual network connected to the private cloud. Choosing between these two options is the main goal of Design Phase #4, based on the following considerations:
- Pre-existing secure internet access NVAs (firewalls, forward proxies) deployed in Azure virtual networks can be used for cost optimization and consistency.
- PaaS solutions available on Azure may help reduce management overhead. Azure Firewall (especially when the Premium SKU features are enabled) can be used for secure Internet access. 
- 3rd-party firewalls and/or proxy devices can be deployed as virtual appliances on Azure VMware Solution. Refer to the vendor's documentation for installation instructions and recommended topologies.

Design phase #4 has a dependency on the choices made in Phase #3. If ["Public IPs to the NSX-T edge"](network-design-guide-internet-inbound-connectivity.md#nvas-hosted-in-azure-vmware-solution-public-ips-on-the-nsx-t-edge) has been selected as the inbound Internet connectivity option, then it must be used for outbound connectivity too. All outbound connections initiated by virtual machines in Azure VMware Solution are managed on the NSX-T edge. Connections are source-NATted behind addresses in the Azure Public IP Prefix associated with the private cloud's NSX-T edge. The flow chart below describes how to approach Design Phase #4.

:::image type="content" source="media/network-design-guide-figure17.png" alt-text="Figure 17. Flowchart that shows the design decision making process for outbound Internet connectivity." lightbox="media/network-design-guide-figure17.png":::
*Design Phase #4: Outbound Internet connectivity.*

## Default routes and outbound Internet connectivity in Azure VMware Solution
Routing for outbound Internet connections initiated by virtual machines in an Azure VMware Solution private cloud is determined by the configured default routes. Different default routes are used for management and workload segments: 
- The private cloud's management network (which hosts vCenter Server and NSX-T Manager) always uses a default route that provides direct Internet access through a platform-managed Internet breakout. This default route cannot be overridden and users have no control over the source-NAT pool for connections initiated from the management network.
- All workload segments share the same default route configuration, which can be one of the following:
    - Internet access through a platform-managed breakout, with Source-NAT provided by the platform. Users have no control over the public IP addresses in the source-NAT pool. For more information, see [this article](/azure/azure-vmware/concepts-design-public-internet-access#azure-vmware-solution-managed-snat).
    - Internet access through a platform-managed breakout, with Source-NAT configured by the user in NSX-T. Users are responsible for: (i) Provisioning Azure Public IP Prefixes for the source-NAT pool; (ii) Defining NAT rules on the NSX-T edge. For more information, see [this article](/azure/azure-vmware/concepts-design-public-internet-access#azure-public-ipv4-address-to-nsx-t-data-center-edge). 
    - Default route announced over the private cloud's ExpressRoute circuit. This default route can be originated by a BGP-capable device in an Azure virtual network or in an on-premises site. Source-NAT is the user's responsibility and must be performed by network devices in Azure virtual networks or on-premises. For more information, see [this article](/azure/azure-vmware/concepts-design-public-internet-access#internet-service-hosted-in-azure).

Outbound internet connectivity for workload segments can be configured through the Azure portal, by selecting one of the options discussed in the next sections. See [this documentation article](/azure/azure-vmware/concepts-design-public-internet-access) for more information.

### Use Azure VMware Solution managed source-NAT
Managed source-NAT is the lowest complexity option for outbound Internet access in Azure VMware Solution. When enabled on a private cloud, a default route in installed on T0/T1 gateways that forwards Internet-bound traffic to a platform-managed edge. The platform managed edge performs source-NAT. Users have no control on the NAT pool. Managed source-NAT can be used to provide direct Internet access to Azure VMware Solution virtual machines. It is however possible to define NSX-T topologies whereby Internet-bound connections initiated by virtual machines are routed to secure Internet edge devices (firewall, forward proxies) deployed as virtual appliances in the private cloud itself. Typical reasons for discarding Azure VMware Solution managed source-NAT for outbound connectivity are listed below:

- Granular control over the NAT pool is a requirement. For example, specific Azure Public IPs must be used to source-NAT connections initiated by specific virtual machines towards specific public endpoints. In this case, Public IPs on the NSX-T edge, [covered below](network-design-guide-internet-outbound-connectivity.md#deploy-pips-at-the-nsx-t-edge), should be considered.
- Public IPs on the NSX-T edge have been selected for Internet inbound connectivity in [Design Phase #3](network-design-guide-internet-inbound-connectivity.md). In this case, Public IPs on the NSX-T must also be used for outbound Internet connectivity. See [next section](network-design-guide-internet-outbound-connectivity.md#deploy-pips-at-the-nsx-t-edge).
- Outbound Internet connections should be routed via a secure Internet edge hosted in an Azure VNet (or in an on-premises site). In this case, a default route must be originated from the Internet edge in Azure and advertised to the private cloud (covered in section [Originate default route from Azure](#originate-default-route-from-azure-customer-managed-virtual-network-or-virtual-wan)).

### Deploy PIPs at the NSX-T edge
When Public IPs to the NSX-T edge are configured, a default route that forwards traffic from T1/T0 gateways towards the Azure network's Internet edge exists in the private cloud. Outbound Internet connections must be source-NATted on T1 gateways using  one of the Public IPs associated to the private cloud. Detailed instructions on how to configure NAT rules on T1 gateways are provided in the [documentation](/azure/azure-vmware/enable-public-ip-nsx-edge#outbound-internet-access-for-vms). This option can be used to provide direct Internet access to Azure VMware Solution virtual machines. It is however possible to define NSX-T topologies whereby Internet-bound connections initiated by Azure VMware Solution virtual machines are routed to secure Internet edge devices (firewall, forward proxies) deployed as virtual appliances in the private cloud. 

### Originate default route from Azure (customer-managed virtual network or Virtual WAN)
Internet-bound traffic emitted by Azure VMware Solution virtual machines can be routed to an Azure-native NVA by announcing a default route over the private cloud's managed ExpressRoute circuit. The private cloud's T0 gateways honor the default route received from Azure and send Internet-bound traffic to the next hop specified by the received default route. If the Internet edge NVAs in Azure support BGP, then they can be used as BGP speakers to originate the default route. If the NVAs do not support BGP (or cannot be used as BGP speakers due to security-related constraints), other NVAs can be deployed to act as BGP speakers. A typical scenario that requires extra BGP-capable NVAs is when the Azure Internet edge is Azure Firewall (Azure Firewall does not support BGP). The resulting network topology is shown in the figure below.

:::image type="content" source="media/network-design-guide-figure19.png" alt-text="Figure 19. Default route origination from Azure virtual networks." lightbox="media/network-design-guide-figure19.png":::
*Default route origination from Azure virtual networks.*

## Next Steps
Learn about governance for Azure VMware Solution.

> [!div class="nextstepaction"]
> [Governance for Azure VMware Solution](eslz-security-governance-and-compliance.md)