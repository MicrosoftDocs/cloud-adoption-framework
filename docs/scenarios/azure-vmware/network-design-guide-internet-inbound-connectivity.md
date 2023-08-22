---
title: Azure VMware Solution Network Design Guide - Internet inbound connectivity
description: Learn how to design Internet inbound connectivity for Azure VMware Solution.
author: fguerri
ms.author: fguerri
ms.date: 06/06/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase #3: Internet inbound connectivity

Design Phase #3 is driven by the requirements of the applications running on Azure VMware Solution that must be reachable over public IP addresses. Almost invariably, Internet-facing applications are published through network devices that provide security (next generation firewalls, web application firewalls) and load balancing (layer-3/layer-4 load balancers, application delivery controllers, …) functions. Such devices can be deployed on the private cloud itself, or in an Azure virtual network connected to the private cloud, based on the following considerations:
-  Pre-existing NVAs deployed in Azure virtual networks (firewalls, application delivery controllers, ...) can be used to publish applications running on your private cloud(s), for cost optimization and for consistency.
- Azure PaaS services that can be used for publishing Internet-facing applications such as [Azure Firewall](/azure/firewall/tutorial-firewall-dnat) (both when deployed in a customer-managed virtual network and when deployed in a Virtual WAN Hub) and [Azure Application Gateway](/azure/application-gateway/overview) may help reduce management overhead.
- Firewalls and application delivery controllers can be deployed as virtual appliances on Azure VMware Solution, if supported by the vendor.

The flow chart below summarizes how to approach Phase #3:

:::image type="content" source="media/network-design-guide-figure16.png" alt-text="Figure16. Flowchart that shows the design decision making process for inbound Internet connectivity." lightbox="media/network-design-guide-figure16.png":::
*Design Phase #3: Design inbound Internet connectivity based on where NVAs for application publishing will be hosted (Azure VMware Solution or Azure virtual network).*

## NVAs hosted in an Azure virtual network
Publishing Azure VMware Solution applications via Azure first-party services (Azure Firewall, Azure Application Gateway) or third-party NVAs hosted in a virtual network only requires layer-3 connectivity between the virtual network and the Azure VMware Solution private cloud, covered in section [Azure virtual network connectivity](network-design-guide-vnet-connectivity.md). 

The following sections provide guidance for each option.

### Considerations for Azure Firewall
[Azure Firewall](/azure/firewall/overview) is the preferred option for exposing generic TCP or UDP endpoints through a first party layer-3/layer-4 device. To publish an Azure VMware Solution application through Azure Firewall, a DNAT rule must be configured, which maps the one of the firewall's public IPs to the Azure VMware Solution application endpoint's private IP. Azure Firewall automatically Source-NATs inbound connections from the Internet behind its private IP address. As a result, Azure VMware Solution virtual machines receive traffic whose source IP address is the Firewall's IP. For more information, see [how to configure DNAT rules on Azure Firewall](/azure/firewall/tutorial-firewall-dnat). 

### Considerations for Azure Application Gateway
[Azure Application Gateway](/azure/application-gateway/overview-v2) is the preferred option for exposing HTTP(S) applications running on Azure VMware Solution. As a first-party HTTP reverse proxy it provides:
- HTTP request routing
- WAF capabilities

When Azure Application Gateway is used, application servers running in the Azure VMware Solution private cloud receive traffic whose source IP address is the Application Gateway's IP. It should be noted that the client's IP address can be carried in HTTP requests (typically, as a [custom "X-Forwarded-For" header](/azure/application-gateway/how-application-gateway-works#modifications-to-the-request)) if the application logic requires access to such information. For more information, see [how to publish an Azure VMware Solution application through Application Gateway](/azure/application-gateway/quick-create-portal).

> [!NOTE]
> Azure Application Gateway is currently the only supported first-party load balancer to expose web apps running on Azure VMware Solution virtual machines. This is because it allows pointing directly to the private IP addresses of virtual machines running on Azure VMware Solution when configuring its backend pool. In contrast, other load balancing services, such as Azure Load Balancer, do not allow this currently.

### Considerations for third-party NVAs
Third-party NVAs can provide layer-3/layer-4 firewall capabilities or layer-7 reverse-proxy/WAF capabilities. Guidance from the NVA vendor should be followed for deployment in Azure virtual networks. Detailed guidance on how to build highly-available clusters of NVAs in Azure is beyond the scope of this guide. The following high-level considerations are general enough to apply to any NVA technology:

- High availability is the user's responsibility. NVA clusters should be comprised of two or more **active** NVA instances (N-active HA model. Active/Passive HA should be avoided as it prevents horizontal scalability).
- Inbound Internet connections should be distributed to all running instances using a [Standard SKU Azure Load Balancer](/azure/load-balancer/skus).  
- Layer-3/layer-4 NVAs must be configured to destination-NAT inbound Internet connections to the private IP of the Azure VMware Solution application(s) to be published.
- Layer-3/layer-4 NVAs must be configured to source-NAT inbound Internet connections behind their egress interface's private IP address, to preserve flow symmetry.  
- Layer-7 NVAs act as reverse-proxies and maintain two distinct TCP sessions for each inbound client connection: One between the client and the NVA and one between the NVA and the upstream application server. The latter session originates from the NVA egress interface's private IP address. HTTP(S) applications allow layer-7 NVAs to pass the client's public IP address to the application servers in HTTP request headers.

## NVAs hosted in Azure VMware Solution (Public IPs on the NSX-T edge)
Publishing Azure VMware Solution applications via third-party NVAs deployed on Azure VMware Solution requires enabling [Public IPs on the NSX-T edge](/azure/azure-vmware/enable-public-ip-nsx-edge) for the private cloud. The functionality associates Azure Public IPs from an [Azure Public IP Prefix](/azure/virtual-network/ip-services/public-ip-address-prefix) to the private cloud and configures the Microsoft backbone to route Internet traffic destined those IPs to the private cloud's NSX-T T0/T1 gateways. T1 gateways can then be configured to destination-NAT inbound connections to the private IPs of NVAs attached to NSX-T segments. Detailed guidance for configuring Public IPs to the NSX-T edge and destination-NAT rules for inbound Internet connectivity is [available in the public doc](/azure/azure-vmware/enable-public-ip-nsx-edge#inbound-internet-access-for-vms). When using Azure VMware Solution with Public IPs to the NSX-T edge, the following considerations apply:
- NAT should be done on T1 gateways, not on T0 gateways. In Azure VMware Solution private clouds, T0 gateways are active/active device pairs and, as such, cannot handle stateful NAT sessions. 
- Public IPs must be associated to an Azure Public IP Prefix. It is currently unsupported to use IPs from [Custom IP Prefixes (BYOIP)](/azure/virtual-network/ip-services/custom-ip-address-prefix).
- When an Azure VMware Solution Private Cloud is configured with Public IPs to the NSX-T edge, a default route is installed in T0/T1 gateways, which routes outbound Internet connections via the Microsoft backbone's edge. As a result, using Public IPs on the NSX-T edge for Internet inbound connectivity also defines the implementation option for outbound connectivity, covered in the [next section](network-design-guide-internet-outbound-connectivity.md).

## Next Steps
Learn about outbound Internet connectivity.

> [!div class="nextstepaction"]
> [Outbound Internet connectivity](network-design-guide-internet-outbound-connectivity.md)