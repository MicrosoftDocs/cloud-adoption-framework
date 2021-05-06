---
title: Connectivity to other cloud providers
description: Examine key design considerations and recommendations surrounding different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI).
author: alexandreweiss
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Connectivity to other cloud providers

This section provides different options on how to establish connectivity from an Azure Enterprise-Scale landing zone architecture with other cloud providers such as Amazon Web Services (AWS) and Google Cloud Platform (GCP).

The options differ in terms of transfer speed, latency, reliability, service level agreements (SLAs), complexity, and costs. This article describes considerations and recommendations for the different options available.

For Oracle Cloud Infrastructure (OCI) where Microsoft and Oracle have partnered to provide low latency, high throughput cross-cloud connectivity, we have a specific guidance that can be found [here](#oracle-cloud-infrastructure-oci)

## General guidance

**Design considerations:**

- The following connectivity models are available:

  - Using Azure ExpressRoute and the other cloud providers equivalent private connection with customer-managed routing.

  - Using Azure ExpressRoute and other cloud provider equivalent private connection with a cloud exchange provider.

  - Using a site-to-site VPN over the Internet.

    The following diagram guides you to the high-level process of choosing one of the options depicted in this article through a simple flow chart.

    ![Inter-cloud connectivity flow chart](./media/cloud-interconnect-decision-tree.png)

    *Figure 1: Inter-cloud connectivity flow chart*

- Customers can only connect a virtual network in Azure with another cloud provider Virtual Private Cloud (VPC) if the private IP address space does not overlap.

- VPN can be more throughput and latency constrained than a combination of Azure ExpressRoute and other cloud provider equivalent connection.

- VPN is the fastest deployment option if Azure ExpressRoute and other cloud provider equivalent are not already in use.

- Routing complexity of Azure ExpressRoute and other cloud provider equivalent with customer-managed routing can be high if not done through a cloud exchange provider.

- DNS resolution between Azure and other cloud provider may be needed for interoperability between Azure and other cloud provider. This may incur additional costs.

- Azure ExpressRoute is designed to improve the data path performance between two networks (on-premises and Azure), and for this scenario, between other cloud providers and Azure. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the ExpressRoute gateway.

- FastPath is available on all ExpressRoute circuits.

- FastPath still requires a virtual network gateway to be created for route exchange purposes. The virtual network gateway must use either the Ultra Performance SKU or the ErGw3AZ SKU for the ExpressRoute gateway to enable route management.

    > [!NOTE] There are features that are currently [not supported](/azure/expressroute/about-fastpath#supported-features) in ExpressRoute FastPath, such as Azure Virtual WAN hubs or VNet peering.

**Design recommendations:**

- When you want to avoid connections over the public internet, require an SLA, want predictable throughput or going to transfer large volumes of data, use Azure ExpressRoute and other cloud provider equivalent private connection to connect between the clouds. If no ExpressRoute is established already, consider whether to use customer-managed routing or a cloud exchange provider.

- Create the Azure ExpressRoute circuit(s) that will be used to interconnect Azure with other cloud provider via customer router(s) or via cloud exchange provider in the connectivity subscription.

-   You can interconnect an Azure network architecture based on the traditional hub and spoke architecture or Azure Virtual WAN-based network topologies by connecting the ExpressRoute circuit that will be used to interconnect Azure to other cloud providers to the hub VNet or Virtual WAN hub as depicted in the following figure.

    ![Graphical user interface, application Description automatically generated]()

    *Figure 2: Azure ExpressRoute and the other cloud providers equivalent with customer-managed routing*

    ![Graphical user interface Description automatically generated]()

    *Figure 3: Azure ExpressRoute and other cloud provider equivalent with a cloud exchange provider.*

- If your application requires the lowest possible latency between Azure and other cloud provider, consider deploying your application in a single VNet with an ExpressRoute gateway and FastPath enabled.

    ![Diagram Description automatically generated]()

    *Figure 4: Azure ExpressRoute and other cloud provider equivalent with with FastPath enabled*

- If ExpressRoute is not required or not available, Site-to-Site VPN over the internet can be used to establish connectivity between Azure and other cloud provider.

    [Connect on-premises networks to Azure by using site-to-site VPN gateways - Learn \| Microsoft Docs](learn/modules/connect-on-premises-network-with-vpn-gateway/2-connect-on-premises-networks-to-azure-using-site-to-site-vpn-gateways)

    ![Diagram Description automatically generated]()

    *Figure 5: Cross-cloud connectivity using site-to-site VPN over the Internet.*

## Oracle Cloud Infrastructure (OCI)

This section provides different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI).

**Design considerations:**

- Using ExpressRoute and FastConnect, customers can connect a virtual network in Azure with a virtual cloud network in OCI, if the private IP address space does not overlap. Once this connectivity is established, resources in the Azure virtual network can communicate with resources in the OCI virtual cloud network as if they were both in the same network.

- Azure ExpressRoute [FastPath](/azure/expressroute/about-fastpath) is designed to improve the data path performance between two networks (on-premises and Azure), and for this scenario, between OCI and Azure. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the ExpressRoute gateway.

  - FastPath is available on all ExpressRoute circuits.

  - FastPath still requires a virtual network gateway to be created for route exchange purposes. The virtual network gateway must use either the Ultra Performance SKU or the ErGw3AZ SKU for the ExpressRoute gateway to enable route management.

- There are features that are currently [not supported](/azure/expressroute/about-fastpath#supported-features) in ExpressRoute FastPath, such as Azure Virtual WAN hubs or VNet peering.

- While you can use [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) to enable communication from on-premises to OCI via ExpressRoute circuits, this may incur additional bandwidth costs that can be calculated by using the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/). This is a particularly important consideration when you migrate large amounts of data from on-premises to Oracle by using ExpressRoute circuits.

- In Azure regions that support [Availability Zones](/azure/availability-zones/az-overview#availability-zones), placing your Azure workloads in one zone or the other can have a small impact on latency. Design your application to balance availability and performances requirements.

- Interconnectivity between Azure and OCI is only available for [specific regions](/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

- For more in-depth documentation about interconnectivity between Azure and OCI, refer to [Oracle application solutions integrating Microsoft Azure and Oracle Cloud Infrastructure](/azure/virtual-machines/workloads/oracle/oracle-oci-overview) or refer to the [Oracle documentation](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/azure.htm).

**Design recommendations:**

- Create the ExpressRoute circuit(s) that will be used to interconnect Azure with OCI in the **connectivity** subscription.

- You can interconnect an Azure network architecture based on the traditional hub and spoke architecture or Azure Virtual WAN-based network topologies by connecting the ExpressRoute circuit that will be used to interconnect Azure to OCI to the hub VNet or Virtual WAN hub as depicted in the following figure.

  ![Diagram that shows Azure to OCI - Hub and Spoke.](./media/azure-oci-hub-and-spoke.png)

  *Figure 1: Interconnectivity between Azure and OCI via ExpressRoute.*

- If your application requires the lowest possible latency between Azure and OCI, consider deploying your application in a single VNet with an ExpressRoute gateway and FastPath enabled.

  ![Diagram that shows Azure to OCI - single vNet.](./media/azure-oci-one-vnet.png)

  *Figure 2: Interconnectivity between Azure and OCI with a single VNet.*

- When deploying your Azure resources across Availability Zones, perform latency tests from Azure VMs located in different Availability Zones to OCI resources to understand which of the three Availability Zones provides the lowest latency to the OCI resources.

- To operate Oracle resources hosted in OCI by using Azure resources and technologies, you could:

  - **From Azure:** Deploy a jumpbox in a spoke VNet. The jumpbox provides access to the virtual cloud network in OCI as depicted in the following picture:

    ![Diagram that shows Azure to OCI - Jumpbox one VNet.](./media/azure-oci-jumpbox-one-vnet.png)

    *Figure 3: Managing OCI resources from Azure via a jumpbox.*

  - **From on-premises:** Use ExpressRoute Global Reach to bind existing ExpressRoute circuit (that connects on-premises to Azure) to OCI ExpressRoute circuit (that interconnects Azure to OCI). In this way, the Microsoft Enterprise Edge (MSEE) router becomes the central routing point between both ExpressRoute circuits.

    ![Diagram that shows Azure to OCI - via Global Reach.](./media/azure-oci-gr-hub-and-spoke.png)

  *Figure 4: Managing OCI resources from on-premises via ExpressRoute Global Reach.*
