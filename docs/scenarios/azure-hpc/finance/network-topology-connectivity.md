---
title: 'Finance HPC Network topology and connectivity | Microsoft Docs'
description: 'This finance HPC guidance builds on considerations and recommendations defined in the Azure landing zone article for network topology and connectivity.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Network topology and connectivity for finance HPC

This guidance builds on considerations and recommendations defined in the Azure landing zone article for network topology and connectivity. Following the guidance in this article will help examine key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure and HPC deployments.

## Plan for IP addressing

It's vital to plan for IP addressing in Azure to ensure that:

 - The IP address space doesn't overlap across on-premises locations and Azure regions.
 - The virtual network (VNet) contains the right address space.
 - Proper planning for subnet configuration happens in advance.

**Design considerations and recommendations**

 - Delegated subnets are required for implementing Azure NetApp Files, which is popular during HPC deployments with shared file systems. You can [dedicate](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network) and delegate subnets to certain services, and then create instances of those services within subnets. While Azure does help you to create multiple delegated subnets in a VNet, only one delegated subnet can exist in a VNet for Azure NetApp Files. Attempts to create a new volume will fail if you use more than one delegated subnet for Azure NetApp Files.
 - You need to create a dedicated subnet if you are using Azure HPC Cache for storage. [Refer](/azure/hpc-cache/hpc-cache-prerequisites#cache-subnet) here for more information on the prerequisite of the subnet, and learn more on how to create a subnet [here](/azure/virtual-network/virtual-network-manage-subnet).

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall Azure landing zone architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design recommendations**

The following recommendations are for when a virtual machine's DNS or virtual name doesn't change during migration.

 - Background DNS and virtual names connect many system interfaces in the HPC environments, and customers are only sometimes aware of the interfaces that developers define over time. Connection challenges arise between various systems when virtual machine or DNS names change after migrations, and it's recommended to retain DNS aliases to prevent these types of difficulties.
 - Use different DNS zones to distinguish each environment (sandbox, development, preproduction, and production) from each other. The exception is for HPC deployments with their own VNet; here, private DNS zones might not be necessary.
 - DNS support is mandatory while using HPC cache so they can access storage and other resources
 - To learn more about DNS and name resolution which is critical in finance industry with the usage of resource location and SRV records, we recommend that you use DNS resolution provided by the ADDS Domain controller, you can find more details on how to do it [here](/azure/architecture/reference-architectures/identity/adds-extend-domain).

## High performance network services

**InfiniBand:**

 - If you are running financial applications where you have a requirement for very low latency between machines and information must be transferred between nodes to arrive at results, you would need low latency and high throughput interconnections. [RDMA capable H-series](/azure/virtual-machines/sizes-hpc#rdma-capable-instances) and [N-series](/azure/virtual-machines/sizes-gpu) VMs communicate over the low latency and high bandwidth InfiniBand network. The RDMA network capability over such an interconnect is critical to boost the scalability and performance of distributed-node HPC and AI workloads. This network can improve the performance of applications running under Microsoft MPI or Intel MPI. You can enable InfiniBand by following the steps mentioned [here](/azure/virtual-machines/workloads/hpc/enable-infiniband) and learn to set up MPI using this [guide](/azure/virtual-machines/workloads/hpc/setup-mpi).

**Azure ExpressRoute**

 - In case of a hybrid application like risk grid computing solution, where your on-premises trading systems, analytics etc. are functional and Azure becomes an extension, Express Route will help you to connect your on-prem environment into the Microsoft cloud over a private connection with the help of a connectivity provider. It provides enterprise-grade resiliency and availability, and the advantage of a Global ExpressRoute partner ecosystem. For information on how to connect your network to Microsoft using ExpressRoute, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).
 - ExpressRoute connections do not go over the public internet, and they offer more reliability, faster speeds, and lower latencies than typical internet connections. For point-to-site VPN and site-to-site VPN, you can connect on-premises devices or networks to a virtual network using any combination of these VPN options and Azure ExpressRoute.

## Define an Azure network topology

Enterprise-scale landing zones support two network topologies: one based on Azure Virtual WAN and the other a traditional network topology based on hub-and-spoke architecture. This section recommends HPC configurations and practices for both deployment models.

Use a network topology based on Virtual WAN if your organization plans to:

 - Deploy resources across several Azure regions and connect your global locations to both Azure and on-premises.
 - Fully integrate software-defined WAN deployments with Azure.
 - Deploy up to 2,000 virtual machine workloads across all VNets connected to one Virtual WAN hub.

Organizations use Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps to reduce overall network complexity and modernize your organization's network.

Use a traditional Azure network topology based on [hub-and-spoke architecture](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) if your organization:

 - Plans to deploy resources in only select Azure regions
 - Doesn't need a global, interconnected network
 - Have few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels
 - Requires full control and granularity to manually configure your Azure network

Document your network topology and firewall rules. NSGs are often implemented within extreme detail. Use Application Security Groups where it makes sense to label traffic to greater granularity where simply VirtualNetwork is not granular enough. Understand NSG Prioritization rules and which rules take precedence over another.

## Plan for inbound and outbound internet connectivity

This section recommends connectivity models for inbound and outbound connectivity to and from the public internet. Since Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

**Design considerations & recommendations**

 - For customers with a global footprint, [Azure Front Door](/azure/frontdoor/front-door-overview) helps HPC deployments by using [Azure Web Application Firewall policies](/azure/web-application-firewall/ag/policy-overview) to deliver and protect global HTTP/S applications across Azure regions.
 - Take advantage of Web Application Firewall policies in Azure Front Door when you're using this service and Application Gateway to protect HTTP/S applications. Learn how to create WAF policies [here](/azure/web-application-firewall/ag/create-waf-policy-ag). Lock down Application Gateway to receive traffic only from Azure Front Door. Refer here to learn more on [how to limit the access](/azure/frontdoor/front-door-faq#how-do-i-lock-down-the-access-to-my-backend-to-only-azure-front-door-).
 - Local and global VNet peering connectivity and are the preferred approaches to ensure connectivity between landing zones for HPC deployments across multiple Azure regions.

## Define network encryption requirements

This section explores key recommendations for encrypting networks between on-premises and Azure, and across Azure regions.

**Design considerations and recommendations:**

 - Traffic performance should be an important consideration when enabling encryption. IPsec tunnels encrypt internet traffic by default, and any additional encryption or decryption could negatively affect the performance. With Express route, traffic is not encrypted by default , however it's up to you to determine whether HPC traffic should be encrypted. Explore network topology and connectivity to understand network encryption options in enterprise-scale landing zones.

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
