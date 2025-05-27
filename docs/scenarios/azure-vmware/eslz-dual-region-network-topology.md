---
title: Network considerations for Azure VMware Solution dual-region deployments
description: Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions for disaster resilience purposes.
author: fguerri
ms.author: fguerri
ms.date: 02/09/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Network considerations for Azure VMware Solution dual-region deployments

This article describes how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions for disaster resilience purposes. If there are partial or complete regional outages, the network topology in this article allows the surviving components (private clouds, Azure-native resources, and on-premises sites) to maintain connectivity with each other and with the internet.

## Dual-region scenario

This article focuses on a typical dual-region scenario, shown in the following Figure 1:

- An Azure hub and spoke network exists in each region.
- A disaster-resilient configuration for Azure ExpressRoute (two circuits in two different peering locations, with each circuit connected to hub virtual networks in both regions) has been deployed. The guidance provided in the following sections stays the same in case [fall-back VPN connectivity](/azure/expressroute/expressroute-howto-coexist-resource-manager#configure-a-site-to-site-vpn-as-a-failover-path-for-expressroute) is configured.
- An Azure VMware Solution private cloud has been deployed in each region.

:::image type="content" source="media/dual-region-figure-1.png" alt-text="Diagram of Figure 1, which shows the dual-region scenario covered in this article." lightbox="media/dual-region-figure-1.png":::

*Figure 1: A dual-region scenario that shows how global Virtual Network peering connects two virtual networks in different regions*

> [!NOTE]
> In the reference scenario of Figure 1, the two regional hub virtual networks are connected via global VNet peering. While not strictly necessary, as traffic between Azure virtual networks in the two regions could be routed over ExpressRoute connections, we strongly recommend this configuration. VNet Peering minimizes latency and maximizes throughput, as it removes the need to hairpin traffic through the ExpressRoute meet-me edge routers.

## Dual-region communication patterns

The next sections describe the Azure VMware Solution network configuration that is necessary to enable, in the reference dual-region scenario, the following communication patterns:

- Azure VMware Solution to Azure VMware Solution (covered in the section [Azure VMware Solution cross-region connectivity](#azure-vmware-solution-cross-region-connectivity));
- Azure VMware Solution to on-premises sites connected over ExpressRoute (covered in the section [Hybrid connectivity](#hybrid-connectivity));
- Azure VMware Solution to Azure Virtual Network (covered in the section [Azure Virtual Network connectivity](#azure-virtual-network-connectivity));
- Azure VMware Solution to internet (covered in the section [Internet connectivity](#internet-connectivity)).

### Azure VMware Solution cross-region connectivity

When multiple Azure VMware Solution private clouds exist, Layer 3 connectivity among them is often a requirement for tasks such as supporting data replication.

Azure VMware Solution natively supports direct connectivity between two private clouds deployed in different Azure regions. Private clouds connect to the Azure network in their own region through ExpressRoute circuits, managed by the platform and terminated on dedicated ExpressRoute meet-me locations. Throughout this article, these circuits are referred to as *Azure VMware Solution managed circuits*. Azure VMware Solution managed circuits shouldn't be confused with the normal circuits that customers deploy to connect their on-premises sites to Azure. The normal circuits that customers deploy are *customer managed circuits* (see Figure 2).

Direct connectivity between private clouds is based on [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) connections between Azure VMware Solution managed circuits, as shown by the green line in the following diagram. For more information, see [Tutorial: Peer on-premises environments to Azure VMware Solution](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud). The article describes the procedure for connecting an Azure VMware Solution managed circuit with a customer-managed circuit. The same procedure applies to connecting two Azure VMware Solution managed circuits.

:::image type="complex" source="media/dual-region-figure-2.png" alt-text="Diagram of Figure 2, which shows private clouds in different regions connected over a Global Reach connection between managed ExpressRoute circuits." lightbox="media/dual-region-figure-2.png":::
   Diagram of Figure 2, which shows Azure VMware Solution private clouds in different regions are directly connected to each other over a Global Reach connection between the private clouds' managed ExpressRoute circuits. In each Azure region where Azure VMware Solution is available, network infrastructure that terminates the Azure VMware Solution side of the Azure VMware Solution managed circuits is present. It's referred to as a Dedicated ExpressRoute meet-me location in the picture.
:::image-end:::

*Figure 2: This reference scenario shows Azure VMware Solution private clouds in different regions. A Global Reach connection directly connects the clouds between their managed ExpressRoute circuits.*

### Hybrid connectivity

The recommended option for connecting Azure VMware Solution private clouds to on-premises sites is ExpressRoute Global Reach. Global Reach connections can be established between customer managed ExpressRoute circuits and Azure VMware Solution managed ExpressRoute circuits. Global Reach connections aren't transitive, therefore a full mesh (each Azure VMware Solution managed circuit connected to each customer managed circuit) is necessary for disaster resilience, as shown in the following Figure 3 (represented by orange lines).

:::image type="complex" source="media/dual-region-figure-3.png" alt-text="Diagram of Figure 3, which shows Global Reach connections connecting customer managed ExpressRoute circuits and VMware Solution ExpressRoute circuits." lightbox="media/dual-region-figure-3.png":::
   Diagram of Figure 3, which shows Global Reach connections can be established between customer managed ExpressRoute circuits and Azure VMware Solution managed ExpressRoute circuits.
:::image-end:::

*Figure 3: This reference scenario shows Global Reach connections between customer-managed ExpressRoute circuits and Azure VMware Solution ExpressRoute circuits.* 

### Azure Virtual Network connectivity

Azure Virtual Network can be connected to Azure VMware Solution private clouds through connections between ExpressRoute Gateways and Azure VMware Solution managed circuits. This connection is exactly the same way that Azure Virtual Network can be connected to on-premises sites over customer managed ExpressRoute circuits. See [Connect to the private cloud manually](/azure/azure-vmware/tutorial-configure-networking#connect-to-the-private-cloud-manually) for configuration instructions.

In dual region scenarios, we recommend a full mesh for the ExpressRoute connections between the two regional hub Virtual Network and private clouds, as shown in Figure 4 (represented by yellow lines).

:::image type="complex" source="media/dual-region-figure-4.png" alt-text="Diagram of Figure 4, which shows that Azure native resources in each region have direct L3 connectivity to Azure VMware Solution private clouds." lightbox="media/dual-region-figure-4.png":::
   Diagram of Figure 4, which shows that Azure native resources in each region have direct L3 connectivity to Azure VMware Solution private clouds as the result of connecting each hub virtual network's ExpressRoute Gateway to each Azure VMware Solution private cloud's managed ExpressRoute circuit. (The global virtual network peering connection between the two hub virtual networks, shown in the previous diagrams, has been omitted for clarity.)
:::image-end:::

*Figure 4: This reference scenario shows Azure native resources in each region that have direct L3 connectivity to Azure VMware Solution private clouds.*

### Internet connectivity

When deploying Azure VMware Solution private clouds in multiple regions, we recommend native options for internet connectivity (managed source network address translation (SNAT) or public IPs down to the NSX-T). Either option can be configured through the Azure portal (or via PowerShell, CLI or ARM/Bicep templates) at deployment time, as shown in the following Figure 5.

:::image type="content" source="media/dual-region-figure-5.png" alt-text="Diagram of Figure 5, which shows the Azure VMware Solution native options for internet connectivity in the Azure portal." lightbox="media/dual-region-figure-5.png":::

*Figure 5: This screenshot highlights the Azure VMware Solution native options for internet connectivity in the Azure portal.*

Both the options highlighted in Figure 5 provide each private cloud with a direct internet breakout in its own region. The following considerations should inform the decision as to which native internet connectivity option to use:

- Managed SNAT should be used in scenarios with basic and outbound-only requirements (low volumes of outbound connections and no need for granular control over the SNAT pool).
- Public IPs down to the NSX-T edge should be preferred in scenarios with large volumes of outbound connections or when you require granular control over NAT IP addresses. For example, which Azure VMware Solution VMs use SNAT behind which IP addresses. Public IPs down to the NSX-T edge also support inbound connectivity via DNAT. Inbound internet connectivity isn't covered in this article.

Changing a private cloud's internet connectivity configuration after the initial deployment is possible. But the private cloud loses connectivity to internet, Azure Virtual Network, and on-premises sites while the configuration is being updated. When either one of the native internet connectivity options in the preceding Figure 5 is used, no extra configuration is necessary in dual region scenarios (the topology stays the same as the one shown in Figure 4). For more information on internet connectivity for Azure VMware Solution, see [Internet connectivity design considerations](/azure/azure-vmware/concepts-design-public-internet-access).

#### Azure-native internet breakout

If a secure internet edge was built in Azure Virtual Network prior to Azure VMware Solution adoption, it might be necessary to use it for internet access for Azure VMware Solution private clouds. Using a secure internet edge in this way is necessary for the centralized management of network security policies, cost optimization, and more. Internet security edges in Azure Virtual Network can be implemented using Azure Firewall or third-party firewall and proxy network virtual appliances (NVAs) available on the Azure Marketplace.

Internet-bound traffic emitted by Azure VMware Solution virtual machines can be attracted to an Azure VNet by originating a default route and announcing it, over border gateway protocol (BGP), to the private cloud's managed ExpressRoute circuit. This internet connectivity option can be configured through the Azure portal (or via PowerShell, CLI or ARM/Bicep templates) at deployment time, as shown in the following Figure 6. For more information, see [Disable internet access or enable a default route](/azure/azure-vmware/disable-internet-access).

:::image type="content" source="media/dual-region-figure-6.png" alt-text="Diagram of Figure 6, which shows the Azure VMware Solution configuration to enable internet connectivity via internet edges in Azure Virtual Network." lightbox="media/dual-region-figure-6.png":::

*Figure 6: This screenshot highlights the Azure VMware Solution configuration that you must select to enable internet connectivity via internet edges in Virtual Network.*

The internet edge NVAs can originate the default route if they support BGP. If not, you must deploy other BGP-capable NVAs. For more information on how to implement internet outbound connectivity for Azure VMware Solution in a single region, see [Implementing internet connectivity for Azure VMware Solution with Azure NVAs](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Networking/Step-By-Step-Guides/Implementing%20internet%20connectivity%20for%20AVS%20with%20Azure%20NVAs). In the dual-region scenario discussed in this article, the same configuration must be applied to both regions.

The key consideration in dual-region scenarios is that the default route originated in each region should be propagated over ExpressRoute only to the Azure VMware Solution private cloud in same region. This propagation allows Azure VMware Solution workloads to access the internet through a local (in-region) breakout. However, if you use the topology shown in Figure 4, each Azure VMware Solution private cloud also receives an equal-cost default route from the remote region over the cross-region ExpressRoute connections. The red dashed lines represent this unwanted cross-region default route propagation in Figure 7.

:::image type="complex" source="media/dual-region-figure-7.png" alt-text="Diagram of Figure 7, which shows the cross-region connections between ExpressRoute Gateways and VMware Solution-managed ExpressRoute circuits must be removed." lightbox="media/dual-region-figure-7.png":::
   Diagram of Figure 7, which shows the cross-region connections between ExpressRoute Gateways and Azure VMware Solution-managed ExpressRoute circuits must be removed to avoid cross-region propagation of the default route.
:::image-end:::

*Figure 7: This reference scenario shows the cross-region connections between ExpressRoute gateways and ExpressRoute circuits managed by Azure VMware Solution that you must remove to prevent cross-region propagation of the default route.*

Removing the Azure VMware Solution cross-region ExpressRoute connections achieves the goal of injecting, in each private cloud, a default route to forward internet-bound connections to the Azure internet edge in the local region.

It should be noted that if the cross-region ExpressRoute connections (red dashed lines in Figure 7) are removed, cross-region propagation of the default route still occurs over Global Reach. However, routes propagated over Global Reach have a longer AS Path than the locally originated ones and get discarded by the BGP route selection process.

The cross-region propagation over Global Reach of a less preferred default route provides resiliency against faults of the local internet edge. If a region's internet edge goes offline, it stops originating the default route. In that event, the less-preferred default route learned from the remote region installs in the Azure VMware Solution private cloud, so that internet-bound traffic is routed via the remote region's breakout.

The recommended topology for dual-region deployments with internet breakouts in Azure VNets is shown in the following Figure 8.

:::image type="complex" source="media/dual-region-figure-8.png" alt-text="Diagram of Figure 8, which shows the recommended topology for dual region deployments with internet outbound access through internet edges." lightbox="media/dual-region-figure-8.png":::
   Diagram of Figure 8, which shows the recommended topology for dual region Azure VMware Solution deployments with internet outbound access through internet edges in Azure Virtual Network. Cross-region connections between ExpressRoute Gateways and Azure VMware Solution managed circuits must not be established to prevent unwanted cross-region propagation of the default route.
:::image-end:::

*Figure 8: This reference scenario shows the recommended topology for dual-region deployments that have internet outbound access through internet edges in Azure Virtual Network.*

When you originate default routes in Azure, special care must be taken to avoid propagation to on-premises sites, unless there's a requirement to provide internet access to on-premises sites via an internet edge in Azure. The customer-operated devices that terminate the customer managed ExpressRoute circuits must be configured to filter default routes received from Azure, as shown in Figure 9. This configuration is necessary to avoid disrupting internet access for the on-premises sites.

:::image type="content" source="media/dual-region-figure-9.png" alt-text="Diagram of Figure 9, which shows the BGP speakers that terminate the customer-managed ExpressRoute circuits are filtering Azure NVAs' default routes." lightbox="media/dual-region-figure-9.png":::

*Figure 9: This reference scenario shows the Border Gateway Protocol speakers that terminate the customer-managed ExpressRoute circuits and filter Azure Network Virtual Appliances default routes.*

## Next steps

- For more information on Azure VMware Solution network features, see [Azure VMware Solution networking and interconnectivity concepts](/azure/azure-vmware/concepts-networking).
- For more information on internet connectivity for Azure VMware Solution, see [Internet connectivity design considerations](/azure/azure-vmware/concepts-design-public-internet-access).

  > [!div class="nextstepaction"]
  > [Example architectures for Azure VMware Solution](./example-architectures.md)
