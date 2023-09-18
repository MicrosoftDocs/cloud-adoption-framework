---
title: 'Azure VMware Solution network design guide: Outbound internet  connectivity'
description: Learn how to design outbound internet connectivity for Azure VMware Solution. This article is part of the Azure VMware Solution network design guide.
author: fguerri
ms.author: fguerri
ms.date: 09/20/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Design phase 4: Outbound internet connectivity

The choices you make during this design phase are determined by the outbound internet connectivity requirements of the applications that are deployed on Azure VMware Solution. Basic internet access might be sufficient to enable virtual machines that are hosted on the private cloud to download software updates. B2B collaboration scenarios in which access to a third-party API is allowed only from authorized IP addresses might require granular control over the NAT pool. In Virtual Desktop Infrastructure (VDI) scenarios, the volume of internet browsing sessions that need to be supported might necessitate control over the size of the NAT pool.

Almost invariably, you need to enhance the security of outbound internet access by routing connections through a firewall or proxy device. Azure VMware Solution supports deploying such devices in the private cloud itself or in an Azure virtual network that's connected to the private cloud. Choosing between these two options is the main goal of this design phase. Your choice is determined by these considerations:

- For cost optimization and consistency, you can use pre-existing enhanced-security internet access NVAs (like firewalls and forward proxies) that are deployed in Azure virtual networks.
- Azure platform as a service (PaaS) solutions might reduce management overhead. You can use Azure Firewall for enhanced-security internet access, especially if you enable Premium SKU features. 
- You can deploy third-party firewalls and/or proxy devices as virtual appliances on Azure VMware Solution. Refer to the vendor's documentation for installation instructions and recommended topologies.

The choices you make during this design phase are dependent on the choices you make during phase 3. If you select [Public IP on the NSX-T Data Center Edge](network-design-guide-internet-inbound-connectivity.md#nvas-hosted-in-azure-vmware-solution-public-ip-on-the-nsx-t-data-center-edge) as your inbound internet connectivity option, you also need to use it for outbound connectivity. All outbound connections initiated by virtual machines in Azure VMware Solution are managed on the NSX-T edge. Connections are translated via Source Network Address Translation (SNAT) to addresses in the Azure Public IP prefix that's associated with the private cloud's NSX-T edge. 

The following flowchart summarizes how to approach this design phase:

:::image type="content" source="media/network-design-guide-figure-17.png" alt-text="Flowchart that shows the decision-making process for outbound internet connectivity." lightbox="media/network-design-guide-figure-17.png" border="false":::
 
## Default routes and outbound internet connectivity in Azure VMware Solution

Routing for outbound internet connections initiated by virtual machines in an Azure VMware Solution private cloud is determined by the configured default routes. Different default routes are used for management and workload segments:

- The private cloud's management network (which hosts vCenter Server and NSX-T management) always uses a default route that provides direct internet access via a platform-managed internet breakout. This default route can't be overridden. You have no control over the SNAT pool for connections that initiate from the management network.
- All workload segments share the same default route configuration. The route configuration can be one of the following:
    - Internet access through a platform-managed breakout, with SNAT provided by the platform. Users have no control over the public IP addresses in the SNAT pool. For more information, see [Azure VMware Solution managed SNAT](/azure/azure-vmware/concepts-design-public-internet-access#azure-vmware-solution-managed-snat).
    - Internet access through a platform-managed breakout, with SNAT configured by the user in NSX-T. Users are responsible for: 
       - Provisioning Azure Public IP prefixes for the SNAT pool. 
       - Defining NAT rules on the NSX-T edge. For more information, see [Azure Public IPv4 address to NSX-T Data Center Edge](/azure/azure-vmware/concepts-design-public-internet-access#azure-public-ipv4-address-to-nsx-t-data-center-edge).
    - A default route that's announced over the private cloud's Azure ExpressRoute circuit. This default route can be originated by a BGP-capable device in an Azure virtual network or in an on-premises site. SNAT is the user's responsibility and must be performed by network devices in Azure virtual networks or on-premises. For more information, see [Internet service hosted on Azure](/azure/azure-vmware/concepts-design-public-internet-access#internet-service-hosted-in-azure).

You can configure outbound internet connectivity for workload segments by using the Azure portal. Select one of the options that are discussed in the next sections. For more information, see [Internet connectivity design considerations](/azure/azure-vmware/concepts-design-public-internet-access).

### Use Azure VMware Solution managed SNAT

Managed SNAT is the easiest way to implement outbound internet access in Azure VMware Solution. When you enable this option on a private cloud, a default route is installed on T0/T1 gateways. The route forwards internet-bound traffic to a platform-managed edge. The platform managed-edge performs SNAT. You have no control over the NAT pool. You can use managed SNAT to provide direct internet access to Azure VMware Solution virtual machines. You can also define NSX-T topologies in which internet-bound connections initiated by virtual machines are routed to enhanced-security internet edge devices (firewalls or forward proxies) that are deployed as virtual appliances in the private cloud itself. Following are some typical reasons to decide not to use this option for outbound connectivity:

- You need granular control over the NAT pool. For example, if you need to use SNAT to translate, via Public IPs, connections initiated by specific virtual machines to point toward specific public endpoints. In this case, you should consider using [Public IP on the NSX-T Data Center Edge](network-design-guide-internet-outbound-connectivity.md#deploy-public-ip-on-the-nsx-t-data-center-edge).
- You selected Public IP on the NSX-T Data Center Edge for inbound internet inbound connectivity during [design phase 3](network-design-guide-internet-inbound-connectivity.md). In this case, you also need to use Public IP on the NSX-T Data Center Edge for outbound Internet connectivity. For more information, see the next section.
- You want to route outbound internet connections via an enhanced-security internet edge that's hosted in an Azure virtual network (or in an on-premises site). In this case, a default route must be originated from the internet edge on Azure and advertised to the private cloud. For more information, see the [Originate a default route from Azure](#originate-a-default-route-from-azure-customer-managed-virtual-network-or-azure-virtual-wan) section of this article.

### Deploy Public IP on the NSX-T Data Center Edge

When you use Public IP on the NSX-T Data Center Edge, a default route that forwards traffic from T1/T0 gateways toward the Azure network's internet edge exists in the private cloud. Outbound internet connections on T1 gateways must be translated via SNAT to use one of the Public IPs that's associated with the private cloud. For information about configuring NAT rules on T1 gateways, see [Outbound internet access for VMs](/azure/azure-vmware/enable-public-ip-nsx-edge#outbound-internet-access-for-vms). You can use this option to provide direct internet access to Azure VMware Solution virtual machines. You can also define NSX-T topologies that route internet-bound connections initiated by Azure VMware Solution virtual machines to enhanced-security internet edge devices (firewalls or forward proxies) that are deployed as virtual appliances in the private cloud.

### Originate a default route from Azure (customer-managed virtual network or Azure Virtual WAN)

You can route internet-bound traffic that's initiated by Azure VMware Solution virtual machines to an Azure-native NVA by announcing a default route over the private cloud's managed ExpressRoute circuit. The private cloud's T0 gateways use the default route received from Azure and send internet-bound traffic to the next hop specified by the received default route. If the internet-edge NVAs in Azure support BGP, you can use them as BGP speakers to originate the default route. If the NVAs don't support BGP (or can't be used as BGP speakers because of security constraints), you can deploy other NVAs to serve as BGP speakers. A typical scenario that requires extra BGP-capable NVAs is when you're using Azure Firewall at the Azure internet edge. (Azure Firewall doesn't support BGP.) The resulting network topology is shown in here: 

:::image type="content" source="media/network-design-guide-figure-19.png" alt-text="Diagram that shows a default route origination from Azure virtual networks." lightbox="media/network-design-guide-figure-19.png":::
 
## Next steps
Learn about governance for Azure VMware Solution.

> [!div class="nextstepaction"]
> [Governance for Azure VMware Solution](eslz-security-governance-and-compliance.md)