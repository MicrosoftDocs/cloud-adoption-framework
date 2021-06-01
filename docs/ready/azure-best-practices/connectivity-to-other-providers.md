---
title: Connectivity to other cloud providers
description: Evaluate key design considerations and recommendations for different connectivity approaches to integrate an Azure enterprise-scale landing zone architecture to other cloud providers
author: daltondhcp
ms.author: brblanch
ms.date: 05/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Connectivity to other cloud providers

This guidance provides different options on how to establish connectivity from an Azure Enterprise-Scale landing zone architecture with other cloud providers such as Amazon Web Services (AWS) and Google Cloud Platform (GCP).

The options differ for transfer speed, latency, reliability, service level agreements (SLAs), complexity, and costs. This article describes considerations and recommendations for the different options available.

For Oracle Cloud Infrastructure (OCI) where Microsoft and Oracle have partnered to provide low latency, high throughput cross-cloud connectivity, we have a specific guidance. For more information, see [Connectivity to Oracle Cloud Infrastructure](connectivity-to-other-providers-oci.md).

**Design considerations:**

- The following connectivity models are available:

  - Use Azure ExpressRoute and the other cloud providers equivalent private connection with customer-managed routing.

  - Use Azure ExpressRoute and other cloud provider equivalent private connection with a cloud exchange provider.

  - Use a site-to-site VPN over the Internet.

    The following diagram guides you to the high-level process of choosing one of the options shown in this article through a simple flow chart.

    ![Diagram of the inter-cloud connectivity flow chart](./media/cloud-interconnect-decision-tree.png)

    *Figure 1: Inter-cloud connectivity flow chart*

- Customers can only connect a virtual network in Azure with another cloud provider Virtual Private Cloud (VPC) if the private IP address space doesn't overlap.

- VPN can be more throughput and latency constrained than a combination of Azure ExpressRoute and other cloud provider equivalent connection.

- VPN is the fastest deployment option if Azure ExpressRoute and other cloud provider equivalent aren't already in use.

- Routing complexity of Azure ExpressRoute and other cloud provider equivalent with customer-managed routing can be high if not done through a cloud exchange provider.

- DNS resolution between Azure and other cloud provider might be needed for interoperability between Azure and other cloud provider. This might incur additional costs.

- Azure ExpressRoute is designed to improve the data path performance between two networks, on-premises and Azure, and for this scenario, between other cloud providers and Azure. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the ExpressRoute gateway.

- FastPath is available on all ExpressRoute circuits.

- FastPath still requires a virtual network gateway to be created for route exchange purposes. The virtual network gateway must use either the Ultra Performance SKU or the ErGw3AZ SKU for the ExpressRoute gateway to enable route management.

- There are features that are currently [not supported](/azure/expressroute/about-fastpath#supported-features) in ExpressRoute FastPath, such as Azure Virtual WAN hubs or VNet peering.

**Design recommendations:**

- When you want to avoid connections over the public internet, require an SLA, want predictable throughput or plan to transfer large volumes of data, use Azure ExpressRoute and other cloud provider equivalent private connection to connect between the clouds. If no ExpressRoute is established already, consider whether to use customer-managed routing or a cloud exchange provider.

- Create the Azure ExpressRoute circuit that will be used to interconnect Azure with another cloud provider via a customer router or via a cloud exchange provider in the connectivity subscription.

- You can interconnect an Azure network architecture based on the traditional hub and spoke architecture or Azure Virtual WAN-based network topologies by connecting the ExpressRoute circuit that will be used to interconnect Azure to other cloud providers to the hub VNet or Virtual WAN hub as depicted in the following figure.

    ![Figure 2: Azure ExpressRoute and the other cloud providers equivalent private connection with customer-managed routing](./media/eslz-other-cloud-providers.png)

    *Figure 2: Azure ExpressRoute and the other cloud providers equivalent private connection with customer-managed routing*

    ![Figure 3: Azure ExpressRoute and other cloud provider equivalent private connection with a cloud exchange provider.](./media/other-cloud-exchange-provider.png)

    *Figure 3: Azure ExpressRoute and other cloud provider equivalent private connection with a cloud exchange provider.*

- If your application requires the lowest possible latency between Azure and other cloud provider, consider deploying your application in a single VNet with an ExpressRoute gateway and FastPath enabled.

    ![Figure 4: Azure ExpressRoute and other cloud provider equivalent with with FastPath enabled](./media/other-cloud-fast-path.png))

    *Figure 4: Azure ExpressRoute and other cloud provider equivalent with FastPath enabled*

- If ExpressRoute isn't required or not available, Site-to-Site VPN over the internet can be used to establish connectivity between Azure and other cloud providers. For more information, see [Connect on-premises networks to Azure by using site-to-site VPN gateways](/learn/modules/connect-on-premises-network-with-vpn-gateway/2-connect-on-premises-networks-to-azure-using-site-to-site-vpn-gateways).

    ![Cross-cloud connectivity using site-to-site VPN over the Internet.](./media/other-cloud-s2s-vpn.png)

    *Figure 5: Cross-cloud connectivity using site-to-site VPN over the Internet.*
  
## Next steps
=======
  
> [!div class="nextstepaction"]
> [Connectivity to Oracle Cloud Infrastructure](connectivity-to-other-providers-oci.md)
