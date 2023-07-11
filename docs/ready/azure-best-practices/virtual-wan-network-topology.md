---
title: Virtual WAN network topology
description: Examine key design considerations and recommendations surrounding virtual wide area networks in Microsoft Azure.
author: JefferyMitchell
ms.author: martinek
ms.date: 08/11/2022
ms.topic: conceptual
ms.subservice: ready
ms.custom: think-tank
---

<!-- docutune:casing "Local, Standard, or Premium SKU" "ExpressRoute Standard or Premium circuits"-->

# Virtual WAN network topology

Explore key design considerations and recommendations for virtual wide area networks (Virtual WAN) in Microsoft Azure.

![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)

*Figure 1: Virtual WAN network topology.*

## Virtual WAN network design considerations

[Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) is a Microsoft-managed solution that provides end-to-end, global, and dynamic transit connectivity by default. Virtual WAN hubs eliminate the need to manually configure network connectivity. For example, you don't need to manage user-defined routes (UDR) or network virtual appliances (NVAs) to enable global transit connectivity.

- Azure Virtual WAN simplifies end-to-end network connectivity in Azure, and to Azure from on-premises, by creating a [hub-and-spoke network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture). The architecture easily scales to support multiple Azure regions and on-premises locations (any-to-any connectivity) as shown in the following figure:

  ![Diagram that illustrates a global transit network with Virtual WAN.](./media/global-transit.png)

 *Figure 2: Global transit network with Virtual WAN.*

- Azure Virtual WAN any-to-any transitive connectivity supports the following paths (within the same region and across regions):

  - Virtual network to virtual network
  - Virtual network to branch
  - Branch to virtual network
  - Branch to branch

- Azure Virtual WAN hubs are restricted to the deployment of Microsoft managed resources. The only resources that you can deploy within the WAN hubs are:
   - Virtual network gateways (point-to-site VPN, site-to-site VPN, and Azure ExpressRoute)
   - Azure Firewall via Firewall Manager
   - Route tables
   - Some [network virtual appliances (NVA)](/azure/virtual-wan/about-nva-hub) for vendor-specific SD-WAN capabilities

- Virtual WAN is bound by [Azure subscription limits for Virtual WAN](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-wan-limits).

- Network-to-network transitive connectivity (within a region and across regions via hub-to-hub) is in general availability (GA).

- The Microsoft-managed routing function that's a part of every virtual hub enables the transit connectivity between virtual networks in Standard Virtual WAN. Each hub supports an aggregate throughput of up to 50 Gbps for VNet-to-VNet traffic.

- A single Azure Virtual WAN hub supports a specific maximum number of VM workloads across all directly attached VNets. For more information, see [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-wan-limits).

- You can deploy multiple Azure Virtual WAN hubs in the same region to scale beyond the single hub limits.

- Virtual WAN integrates with various [SD-WAN providers](/azure/virtual-wan/virtual-wan-locations-partners).

- Many managed service providers offer [managed services](/azure/networking/networking-partners-msp) for Virtual WAN.

- User VPN (point-to-site) gateways in Virtual WAN scale up to 20-Gbps aggregated throughput and 100,000 client connections per virtual hub. For more information, see [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-wan-limits).

- Site-to-site VPN gateways in Virtual WAN scale up to 20-Gbps aggregated throughput.

- You can connect ExpressRoute circuits to a Virtual WAN hub by using a Local, Standard, or Premium SKU.

- ExpressRoute Standard or Premium circuits, in locations supported by Azure ExpressRoute Global Reach, can connect to a Virtual WAN ExpressRoute gateway. And they have all the Virtual WAN transit capabilities (VPN-to-VPN, VPN, and ExpressRoute transit). ExpressRoute Standard or Premium circuits that are in locations not supported by Global Reach can connect to Azure resources, but can't use Virtual WAN transit capabilities.

-  Azure Virtual WAN hub supports ExpressRoute Local if the spoke VNets connected to a Virtual WAN hub are in the same region as the Virtual WAN hub.

- Azure Firewall Manager supports deployment of Azure Firewall in the Virtual WAN hub, known as secured virtual hub. For more information, see the [Azure Firewall Manager overview](/azure/firewall-manager/overview) for secured virtual hubs and the latest [constraints](/azure/firewall-manager/overview#known-issues).

- Virtual WAN hub-to-hub traffic, by way of Azure Firewall, isn't currently supported when the Azure Firewall deploys inside of the Virtual WAN hub itself (secured virtual hub). Depending on your requirements, you have workarounds. You can place the [Azure Firewall in a spoke virtual network](/azure/virtual-wan/scenario-route-through-nva), or use NSGs for traffic filtering.

- The Virtual WAN portal experience requires that all Virtual WAN resources deploy together into the same resource group.

- You can share an Azure DDoS Protection Standard plan across all VNets in a single Azure AD tenant to protect resources with public IP addresses. For more information, see [Azure DDoS Protection Standard](/azure/ddos-protection/ddos-protection-overview).

  - Virtual WAN secure virtual hubs don't support Azure DDoS standard protection plans. For more information, see [Azure Firewall Manager known issues](/azure/firewall-manager/overview#known-issues) and [Hub virtual network and secured virtual hub comparison](/azure/firewall-manager/vhubs-and-vnets#comparison).

  - Azure DDoS Protection Standard plans only cover resources with public IP addresses.

    - An Azure DDoS Protection Standard plan includes 100 public IP addresses. These public IP addresses span all protected VNets associated with the DDoS protection plan. Any other public IP addresses, beyond the 100 included with the plan, are charged separately. For more information on Azure DDoS Protection Standard protection pricing, see the [pricing page](https://azure.microsoft.com/pricing/details/ddos-protection/) or the [FAQ](/azure/ddos-protection/ddos-faq#how-does-pricing-work).

  - Review the [supported resources of Azure DDoS Protection Standard plans](/azure/ddos-protection/ddos-faq#what-are-the-supported-protected-resource-types).

## Virtual WAN network design recommendations

We recommend Virtual WAN for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. That way, you don't have to manually set up transitive routing for Azure networking.

  The following figure shows a sample global enterprise deployment with datacenters spread across Europe and the United States. The deployment contains many branch offices within both regions. The environment is globally connected via Azure Virtual WAN and [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach).

  ![Diagram of a sample network topology.](./media/global-reach-topology.png)

 *Figure 3: Sample network topology.*

- Use a Virtual WAN hub per Azure region to connect multiple landing zones together across Azure regions by way of a common global Azure Virtual WAN.

- Deploy all Virtual WAN resources into a single resource group in the connectivity subscription, including when you're deploying across multiple regions.

- Use [virtual hub routing](/azure/virtual-wan/about-virtual-hub-routing) features to further segment traffic between VNets and branches.

- Connect Virtual WAN hubs to on-premises datacenters by using ExpressRoute.

- Deploy required shared services, like DNS servers, in a dedicated spoke virtual network. Customer deployed shared resources can't be deployed inside the Virtual WAN hub itself.

- Connect branches and remote locations to the nearest Virtual WAN hub via Site-to-Site VPN, or enable branch connectivity to Virtual WAN via an SD-WAN partner solution.

- Connect users to the Virtual WAN hub via a Point-to-Site VPN.

- Follow the principle of "traffic in Azure stays in Azure" so that communication across resources in Azure occurs via the Microsoft backbone network, even when the resources are in different regions.

- For internet outbound protection and filtering, consider deploying Azure Firewall in the virtual hub.

- [Security provided by NVA firewalls](/azure/virtual-wan/about-nva-hub#security-provided-by-nva-firewalls). Customers can also deploy NVAs into a Virtual WAN hub that perform both SD-WAN connectivity and Next-Generation Firewall capabilities. Customers can connect on-premises devices to the NVA in the hub and also use the same appliance to inspect all North-South, East-West, and Internet-bound traffic.

- When you're deploying partner networking technologies and NVAs, follow the partner vendor's guidance to ensure there are no conflicting configurations with Azure networking.

- For brownfield scenarios where you're migrating from a hub-and-spoke network topology not based on Virtual WAN, see [Migrate to Azure Virtual WAN](/azure/virtual-wan/migrate-from-hub-spoke-topology).

- Create Azure Virtual WAN and Azure Firewall resources within the connectivity subscription.

- Don't create more than 500 virtual network connections per Virtual WAN virtual hub.

  - If you need more than 500 virtual network connections per Virtual WAN virtual hub, you can deploy another Virtual WAN virtual hub. Deploy it in the same region as part of the same Virtual WAN and resource group.

- Plan your deployment carefully, and ensure that your network architecture is within the [Azure Virtual WAN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-wan-limits).

- Use [insights in Azure Monitor for Virtual WAN (preview)](/azure/virtual-wan/azure-monitor-insights) to monitor the end-to-end topology of your Virtual WAN and status and [key metrics](/azure/virtual-wan/azure-monitor-insights#detailed).

- Deploy a single Azure DDoS standard protection plan in the connectivity subscription.

  - All landing zone and platform VNets should use this plan.
