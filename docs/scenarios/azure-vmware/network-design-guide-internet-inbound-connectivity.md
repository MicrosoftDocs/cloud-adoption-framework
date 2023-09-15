---
title: 'Azure VMware Solution network design guide: Inbound internet  connectivity'
description: Learn how to design inbound internet connectivity for Azure VMware Solution. This article is part of the Azure VMware Solution design guide.
author: fguerri
ms.author: fguerri
ms.date: 09/19/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase 3: Inbound internet connectivity

The choices you make during this design phase are determined by the requirements of the applications running on Azure VMware Solution that must be reachable over public IP addresses. Almost invariably, internet-facing applications are published via network devices that provide security (next-generation firewalls, web application firewalls) and load balancing (Layer 3 or Layer 4 load balancers, application delivery controllers). You can deploy these devices in the private cloud itself or in an Azure virtual network that's connected to the private cloud. Your choice is based on these considerations:

-  For cost optimization and consistency, you can use pre-existing NVAs that are deployed in Azure virtual networks (like firewalls and application delivery controllers) to publish applications running on your private clouds.
- Azure PaaS services that can be used for publishing internet-facing applications, like [Azure Firewall](/azure/firewall/tutorial-firewall-dnat) (both when deployed in a customer-managed virtual network and when deployed in an Azure Virtual WAN hub) and [Azure Application Gateway](/azure/application-gateway/overview), might help reduce management overhead.
- You can deploy firewalls and application delivery controllers as virtual appliances on Azure VMware Solution, if that's supported by the vendor.

The following flowchart summarizes how to approach this phase:

:::image type="content" source="media/network-design-guide-figure-16.png" alt-text="Flowchart that shows the design-decision making process for inbound internet connectivity." lightbox="media/network-design-guide-figure-16.png" border="false":::

## NVAs hosted in an Azure virtual network

Publishing Azure VMware Solution applications via Azure services (Azure Firewall, Application Gateway) or third-party NVAs that are hosted in a virtual network only requires Layer 3 connectivity between the virtual network and the Azure VMware Solution private cloud. For more information, see [Design phase 2: Connectivity with Azure virtual networks](virtual-network-connectivity.md).

The following sections provide guidance for each option.

### Considerations for Azure Firewall

[Azure Firewall](/azure/firewall/overview) is the preferred option for exposing generic TCP or UDP endpoints through a Microsoft Layer 3 or layer 4 device. To publish an Azure VMware Solution application through Azure Firewall, you need to configure a Destination Network Address Translation (DNAT) rule that maps one of the firewall's public IPs to the Azure VMware Solution application endpoint's private IP. Azure Firewall automatically uses Source Network Address Translation (SNAT) to translate IP addresses that are inbound from the internet to its own private IP address. As a result, Azure VMware Solution virtual machines (VMs) receive traffic whose source IP address is the firewall's IP. For more information, see [Filter inbound internet traffic with Azure Firewall DNAT using the Azure portal](/azure/firewall/tutorial-firewall-dnat).

### Considerations for Azure Application Gateway

[Application Gateway](/azure/application-gateway/overview-v2) is the preferred option for exposing HTTP(S) applications running on Azure VMware Solution. This Microsoft HTTP reverse proxy provides:

- HTTP request routing.
- Web application firewall (WAF) capabilities.

When you use Application Gateway, application servers running in the Azure VMware Solution private cloud receive traffic whose source IP address is the application gateway's IP. The client's IP address can be carried in HTTP requests (typically as a [custom x-forwarded-for header](/azure/application-gateway/how-application-gateway-works#modifications-to-the-request)) if the application logic requires access to that information. For more information, see [this article about publishing an Azure VMware Solution application through Application Gateway](/azure/application-gateway/quick-create-portal).

> [!NOTE]
> Application Gateway is currently the only Microsoft load balancer that you can use to expose web apps running on Azure VMware Solution VMs. This is because it allows you to point directly to the private IP addresses of VMs running on Azure VMware Solution when you configure the backend pools of the VMs. 

### Considerations for third-party NVAs

Third-party NVAs can provide Layer 3 or Layer 4 firewall capabilities or Layer 7 reverse-proxy/WAF capabilities. Follow the guidance from the NVA vendor to deploy the device in Azure virtual networks. Detailed guidance on how to create highly available clusters of NVAs on Azure is beyond the scope of this guide. The following high-level considerations are general enough to apply to any NVA technology:

- High availability (HA) is your responsibility. NVA clusters should include two or more active NVA instances (the *N*-active HA model). You should avoid active-passive HA because it prevents horizontal scalability.
- You should distribute all inbound internet connections to all running instances by using a [Standard SKU Azure Load Balancer](/azure/load-balancer/skus).  
- Layer 3 and Layer 4 NVAs must be configured to use DNAT to translate inbound internet connections to the private IP of the Azure VMware Solution application that you want to publish.
- To preserve flow symmetry, you need to configure Layer 3 and Layer 4 NVAs to use SNAT to translate inbound internet connections to their egress interface's private IP address.  
- Layer 7 NVAs act as reverse proxies and maintain two distinct TCP sessions for each inbound client connection: one between the client and the NVA and one between the NVA and the upstream application server. The latter session originates from the NVA egress interface's private IP address. HTTP(S) applications allow Layer 7 NVAs to pass the client's public IP address to the application servers in HTTP request headers.

## NVAs hosted in Azure VMware Solution (Public IP on the NSX-T Data Center Edge)

To publish Azure VMware Solution applications via third-party NVAs that are deployed on Azure VMware Solution, you need to enable [Public IP on the NSX-T Data Center Edge](/azure/azure-vmware/enable-public-ip-nsx-edge) for the private cloud. This feature associates Azure Public IPs from an [Azure Public IP prefix](/azure/virtual-network/ip-services/public-ip-address-prefix) with the private cloud and configures the Microsoft backbone to route internet traffic destined those IPs to the private cloud's NSX-T T0 or T1 gateways. T1 gateways can then be configured to use DNAT to translate inbound connections to the private IPs of NVAs that are attached to NSX-T segments. For guidance on configuring Public IP on the NSX-T Data Center Edge and configuring DNAT rules for inbound internet connectivity, see [Enable Public IP on the NSX-T Data Center Edge](/azure/azure-vmware/enable-public-ip-nsx-edge#inbound-internet-access-for-vms). When you use Azure VMware Solution with Public IP on the NSX-T Data Center Edge, the following considerations apply:

- Perform NAT on T1 gateways, not on T0 gateways. In Azure VMware Solution private clouds, T0 gateways are active-active device pairs, so they can't handle stateful NAT sessions. 
- You need to associate Public IPs to an Azure Public IP prefix. Using IPs from [custom IP address prefixes (BYOIP)](/azure/virtual-network/ip-services/custom-ip-address-prefix) isn't currently supported.
- When an Azure VMware Solution private cloud is configured with Public IP on the NSX-T Data Center Edge, a default route is installed in T0/T1 gateways. It routes outbound internet connections via the Microsoft backbone's edge. As a result, the use of Public IP on the NSX-T Data Center Edge for inbound internet connectivity also determines the implementation option for outbound connectivity, which is covered in the [next article in this guide](network-design-guide-internet-outbound-connectivity.md).

## Next steps 

Learn about outbound internet connectivity.

> [!div class="nextstepaction"]
> [Outbound internet connectivity](network-design-guide-internet-outbound-connectivity.md)