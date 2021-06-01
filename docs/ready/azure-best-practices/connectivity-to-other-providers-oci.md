---
title: Connectivity to Oracle Cloud Infrastructure
description: Evaluate key design considerations and recommendations surrounding different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI).
author: alexandreweiss
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Connectivity to Oracle Cloud Infrastructure

This section provides different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to Oracle Cloud Infrastructure (OCI).

**Design considerations:**

- Using ExpressRoute and FastConnect, customers can connect a virtual network in Azure with a virtual cloud network in OCI, if the private IP address space doesn't overlap. Once you establish connectivity, resources in the Azure virtual network can communicate with resources in the OCI virtual cloud network as if they were both in the same network.

- Azure ExpressRoute [FastPath](/azure/expressroute/about-fastpath) is designed to improve the data path performance between two networks, both on-premises and Azure, and for this scenario, between OCI and Azure. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the ExpressRoute gateway.

  - FastPath is available on all ExpressRoute circuits.

  - FastPath still requires a virtual network gateway to be created for route exchange purposes. The virtual network gateway must use either the Ultra Performance SKU or the ErGw3AZ SKU for the ExpressRoute gateway to enable route management.

- There are features that are currently [not supported](/azure/expressroute/about-fastpath#supported-features) in ExpressRoute FastPath, such as Azure Virtual WAN hubs or VNet peering.

- While you can use [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach) to enable communication from on-premises to OCI via ExpressRoute circuits, it might incur more bandwidth costs that you can calculate by using the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/). It's important to consider any extra costs when you migrate large amounts of data from on-premises to Oracle by using ExpressRoute circuits.

- In Azure regions that support [Availability Zones](/azure/availability-zones/az-overview#availability-zones), placing your Azure workloads in one zone or the other can have a small effect on latency. Design your application to balance availability and performances requirements.

- Interconnectivity between Azure and OCI is only available for [specific regions](/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

- For more in-depth documentation about interconnectivity between Azure and OCI, see [Oracle application solutions to integrate Microsoft Azure and Oracle Cloud Infrastructure](/azure/virtual-machines/workloads/oracle/oracle-oci-overview) or see [Oracle documentation](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/azure.htm).

**Design recommendations:**

- Create the ExpressRoute circuit that will be used to interconnect Azure with OCI in the **connectivity** subscription.

- You can interconnect an Azure network architecture based on the traditional hub and spoke architecture or Azure Virtual WAN-based network topologies. It can be done by connecting the ExpressRoute circuit that will be used to interconnect Azure to OCI to the hub VNet or Virtual WAN hub as shown in the following diagram.

  ![Diagram that shows interconnectivity between Azure and OCI via ExpressRoute.](./media/azure-oci-hub-and-spoke.png)

  *Figure 1: Interconnectivity between Azure and OCI via ExpressRoute.*

- If your application requires the lowest possible latency between Azure and OCI, consider deploying your application in a single VNet with an ExpressRoute gateway and FastPath enabled.

  ![Diagram that shows Azure to OCI - single vNet.](./media/azure-oci-one-vnet.png)

  *Figure 2: Interconnectivity between Azure and OCI with a single VNet.*

- When you deploy Azure resources across Availability Zones, perform latency tests from Azure VMs located in different Availability Zones to OCI resources to understand which of the three Availability Zones provides the lowest latency to the OCI resources.

- To operate Oracle resources hosted in OCI by using Azure resources and technologies, you could:

  - **From Azure:** Deploy a jumpbox in a spoke VNet. The jumpbox provides access to the virtual cloud network in OCI as shown in the following picture:

    ![Diagram that shows Azure to OCI Jumpbox on one VNet.](./media/azure-oci-jump-box-one-vnet.png)

    *Figure 3: Managing OCI resources from Azure via a jumpbox.*

  - **From on-premises:** Use ExpressRoute Global Reach to bind an existing ExpressRoute circuit that connects on-premises to Azure, to an OCI ExpressRoute circuit that interconnects Azure to OCI. In this way, the Microsoft Enterprise Edge (MSEE) router becomes the central routing point between both ExpressRoute circuits.

    ![Diagram that shows Azure to OCI via Global Reach.](./media/azure-oci-gr-hub-and-spoke.png)

  *Figure 4: Managing OCI resources from on-premises via ExpressRoute Global Reach.*

## Next steps

For information on connectivity to other cloud providers, see [Connectivity to other cloud providers](./connectivity-to-other-providers.md).
