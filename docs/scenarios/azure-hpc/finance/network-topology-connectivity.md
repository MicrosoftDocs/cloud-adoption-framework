---
title: Network topology and connectivity for Azure HPC in the finance sector
description: This finance HPC guidance builds on considerations and recommendations described in the Azure landing zone article for network topology and connectivity.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/11/2022
---

# Network topology and connectivity for HPC in the finance sector

This article builds on considerations and recommendations that are described in the Azure landing zone article for [network topology and connectivity](../../../ready/landing-zone/design-area/network-topology-and-connectivity.md). The guidance in this article can help you examine key design considerations and best practices for networking and connectivity to, from, and within Azure and HPC deployments.

## Plan for IP addressing

It's important to plan for IP addressing on Azure to ensure that:

 - The IP address space doesn't overlap across on-premises locations and Azure regions.
 - The virtual network contains the right address space.
 - Proper planning for subnet configuration happens in advance.

### Design considerations and recommendations

 - Delegated subnets are required if you want to implement Azure NetApp Files, which is used frequently in HPC deployments with shared file systems. You can [dedicate](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network) and delegate subnets to certain services and then create instances of those services within subnets. Although Azure helps you create multiple delegated subnets in a virtual network, only one delegated subnet can exist in a virtual network for Azure NetApp Files. Attempts to create a new volume will fail if you use more than one delegated subnet for Azure NetApp Files.
 - You need to create a dedicated subnet if you use Azure HPC Cache for storage. For more information about this subnet prerequisite, see [Cache subnet](/azure/hpc-cache/hpc-cache-prerequisites#cache-subnet). To learn more about how to create a subnet, see [Add a virtual network subnet](/azure/virtual-network/virtual-network-manage-subnet).

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design element in the Azure landing zone architecture. Some organizations prefer to use their existing investments in DNS. Others see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

### Design recommendations

The following recommendations apply to scenarios in which a virtual machine's DNS or virtual name doesn't change during migration.

 - Background DNS and virtual names connect many system interfaces in HPC environments. You might not be aware of all the interfaces that developers define over time. Connection challenges arise between various systems when virtual machine or DNS names change after migrations. We recommend that you retain DNS aliases to prevent these difficulties.
 - Use different DNS zones to distinguish the environments (sandbox, development, preproduction, and production) from each other. The exception is for HPC deployments that have their own virtual networks. In these deployments, private DNS zones might not be necessary.
 - DNS support is required when you use HPC Cache. DNS enables it to access storage and other resources.
 - DNS and name resolution are critical in the finance sector when you use resource location and SRV records. We recommend that you use the DNS resolution provided by the Azure Active Directory Domain Services (Azure AD DS) domain controller. For more information, see [Deploy Azure AD DS in an Azure virtual network](/azure/architecture/reference-architectures/identity/adds-extend-domain).

## High-performance network services

### InfiniBand

 - If you run financial applications for which you need low latency between machines, and information must be transferred between nodes to get results, you need low-latency and high-throughput interconnections. [RDMA-capable H-series](/azure/virtual-machines/sizes-hpc#rdma-capable-instances) and [N-series](/azure/virtual-machines/sizes-gpu) VMs communicate over the low-latency and high-bandwidth InfiniBand network. The RDMA network capability over such a connection is critical to boost the scalability and performance of distributed-node HPC and AI workloads. This network can improve the performance of applications that run under Microsoft MPI or Intel MPI. For more information, see [Enable InfiniBand](/azure/virtual-machines/workloads/hpc/enable-infiniband). To learn how to set up MPI, see [Set up Message Passing Interface for HPC](/azure/virtual-machines/workloads/hpc/setup-mpi).

### Azure ExpressRoute

 - For hybrid applications like risk grid computing solutions, where your on-premises trading systems and analytics are functional and Azure becomes an extension, you can use ExpressRoute to connect your on-premises environment to Azure over a private connection, with the help of a connectivity provider. ExpressRoute provides enterprise-grade resiliency and availability and the advantage of a global ExpressRoute partner ecosystem. For information on how to connect your network to Azure by using ExpressRoute, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).
 - ExpressRoute connections don't use the public internet, and they provide more reliability, faster speeds, and lower latencies than typical internet connections. For point-to-site VPN and site-to-site VPN, you can connect on-premises devices or networks to a virtual network by using any combination of these VPN options and ExpressRoute.

## Define an Azure network topology

Enterprise-scale landing zones support two network topologies: one based on Azure Virtual WAN and the other a traditional network topology that's based on hub-and-spoke architecture. This section provides recommended HPC configurations and practices for both deployment models.

Use a network topology that's based on Virtual WAN if your organization plans to:

 - Deploy resources across several Azure regions and connect your global locations to both Azure and on-premises.
 - Fully integrate software-defined WAN deployments with Azure.
 - Deploy as many as 2,000 virtual machine workloads across all virtual networks connected to one Virtual WAN hub.

Organizations use Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps you reduce overall network complexity and modernize your organization's network.

Use a traditional Azure network topology based on [hub-and-spoke architecture](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) if your organization:

 - Plans to deploy resources in only select Azure regions.
 - Doesn't need a global, interconnected network.
 - Has few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels.
 - Requires full control and granularity to manually configure your Azure network.

Document your network topology and firewall rules. Network security groups (NSGs) are often implemented with considerable complexity. Use application security groups when it makes sense to label traffic at a greater granularity than virtual networks can provide. Understand NSG prioritization rules and which rules take precedence over others.

## Plan for inbound and outbound internet connectivity

This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet. Because Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Azure Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

### Design considerations and recommendations

 - If your organization has a global footprint, [Azure Front Door](/azure/frontdoor/front-door-overview) can be helpful in your HPC deployment. Azure Front Door uses [Azure Web Application Firewall policies](/azure/web-application-firewall/ag/policy-overview) to deliver and help protect global HTTP(S) applications across Azure regions.
 - Take advantage of [Web Application Firewall policies](/azure/web-application-firewall/ag/create-waf-policy-ag) in Azure Front Door when you're using Azure Front Door and Application Gateway to help protect HTTP(S) applications. Lock down Application Gateway to receive traffic only from Azure Front Door. For more information, see [How do I lock down access?](/azure/frontdoor/front-door-faq#how-do-i-lock-down-the-access-to-my-backend-to-only-azure-front-door-).
 - Use local and global virtual network peering connectivity. These are the preferred methods for ensuring connectivity between landing zones for HPC deployments across multiple Azure regions.

## Define network encryption requirements

This section provides key recommendations for encrypting networks between on-premises environments and Azure, and across Azure regions.

### Design considerations and recommendations

 - Traffic performance is an important consideration when you enable encryption. IPsec tunnels encrypt internet traffic by default. Any additional encryption or decryption can negatively affect performance. When you use ExpressRoute, traffic isn't encrypted by default. You need to determine whether HPC traffic should be encrypted. Explore [network topology](../../../ready/azure-best-practices/define-an-azure-network-topology.md) and [connectivity](../../../ready/azure-best-practices/connectivity-to-azure.md) to understand network encryption options in enterprise-scale landing zones.

## Next steps

The following articles provide guidance that you might find helpful during various stages of the cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC environments in the finance sector.

- [Azure billing offers and Active Directory tenants for finance HPC](./azure-billing-active-directory-tenant.md)
- [Finance HPC Azure identity and access management](./identity-access-management.md)
- [Management for HPC in the finance sector](./management.md)
- [Platform automation and DevOps for HPC in the finance sector](./platform-automation-devops.md)
- [Resource organization for Azure HPC in the finance sector](./resource-organization.md)
- [Governance for finance HPC](./security-governance-compliance.md)
- [Security for HPC in the finance sector](./security.md)
- [Storage for HPC in the finance sector](./storage.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)