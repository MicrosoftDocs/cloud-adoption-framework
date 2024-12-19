---
title: Network Topology and Connectivity for Azure HPC
description: Learn about network topology and connectivity considerations in the Azure landing zone for high-performance computing (HPC).
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 12/05/2024
---

# Network topology and connectivity for Azure HPC

The guidance in this article can help you examine design considerations and best practices that relate to networking and connectivity for Microsoft Azure and high-performance computing (HPC) deployments.

## Plan for IP addressing

It's crucial that you plan for IP addressing in Azure to help ensure that:

- The IP address space doesn't overlap across on-premises locations and Azure regions.
- Future virtual network peering to existing or planned virtual networks is possible.
- The virtual network contains the right address space.
- Proper planning for subnet configuration happens in advance.
- Sufficient excess addressing is considered for future expansion or other services.

### Design considerations and recommendations

- Consider creating separate subnets to assign IP addresses across functional components of the environment. For example, a dedicated HPC virtual network could include the following subnets:

  - Compute
  - Storage
  - Infrastructure
  - Visualization
  - Sign in
  - Azure NetApp Files
  - Azure HPC Cache

- Several services like Azure NetApp Files, HPC Cache, and future storage offerings require dedicated delegated subnets for proper operation. If you consider using any of these services, make sure that you plan appropriate addressing space. Delegated subnets are required if you want to implement Azure NetApp Files, which is used frequently in HPC deployments with shared file systems. You can [dedicate](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network) and delegate subnets to specific services and then create instances of those services within subnets.

- Azure helps you create multiple delegated subnets in a virtual network, but only one delegated subnet can exist in a virtual network for Azure NetApp Files. Attempts to create a new volume fail if you use more than one delegated subnet for Azure NetApp Files. If you use HPC Cache for storage, create a dedicated subnet. For more information about this subnet prerequisite, see [Cache subnet](/azure/hpc-cache/hpc-cache-prerequisites#cache-subnet). To learn more about how to create a subnet, see [Add a virtual network subnet](/azure/virtual-network/virtual-network-manage-subnet).

## DNS and name resolution for on-premises and Azure resources

Domain name system (DNS) is a crucial design element in the overall Azure landing zone architecture. Some organizations might want to use their existing investments in DNS. Other organizations might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities. The following recommendations apply when a virtual machine's DNS or virtual name doesn't change during migration.

### Design considerations and recommendations

- Background DNS and virtual names connect multiple system interfaces in HPC environments. Customers are only sometimes aware of the interfaces that developers define over time. Connection challenges can occur between various systems when virtual or DNS names change after migrations, so you should retain DNS aliases to prevent these types of problems.

- Use different DNS zones to distinguish environments from each other. These environments include sandbox, development, preproduction, and production. The exception is for HPC deployments that have their own virtual network, which might not require private DNS zones.

- DNS support is mandatory when you use HPC Cache so that they can access storage and other resources.

- DNS and name resolution are crucial in the finance sector when you use resource location and service records. We recommend that you use the DNS resolution that the Microsoft Entra Domain Services domain controller provides. For more information, see [Deploy Microsoft Entra Domain Services in an Azure virtual network](/azure/architecture/reference-architectures/identity/adds-extend-domain).

## High-performance network services

- **Accelerated networking:** Many HPC workloads, including seismic processing, handle vast amounts of data stored in shared file systems such as Azure Blob, Azure NetApp Files, and Lustre ClusterStor. These storage solutions and custom solutions are accessed through the network. A high-performance network is crucial to reduce the time for data transfers. [Accelerated networking](/azure/virtual-network/accelerated-networking-overview) provides a high-throughput, low-latency connection between the virtual machines (VMs) and to Azure services. Other benefits include reduced jitter and minimal CPU utilization.

- **InfiniBand:** Parallel HPC applications that rely on Message Passing Interface (MPI) libraries might need to transfer significant amounts of data between multiple VMs. The InfiniBand interconnect, available on remote direct memory access (RDMA)-capable [H-series](/azure/virtual-machines/sizes-hpc) and [N-series](/azure/virtual-machines/sizes-gpu) VMs, provides a low-latency, high-bandwidth connection to maximize the performance and scalability of HPC and deep learning applications.

  - If you run financial applications that require low latency between machines, and information must be transferred between nodes to get results, use low-latency and high-throughput interconnections. [RDMA-capable H-series](/azure/virtual-machines/sizes-hpc#rdma-capable-instances) and [N-series](/azure/virtual-machines/sizes-gpu) VMs communicate over the low-latency and high-bandwidth InfiniBand network. The RDMA network capability over such a connection is crucial to boost the scalability and performance of distributed-node HPC and AI workloads. This network can improve the performance of applications that run under Microsoft MPI or Intel MPI. Some examples of MPI jobs include molecular dynamics, computational fluid dynamics, oil and gas reservoir simulation, and emerging distributed machine learning workloads.
  
  - InfiniBand connections are possible only between VMs that are allocated within the same [placement group](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups). For more information, see [Enable InfiniBand](/azure/virtual-machines/workloads/hpc/enable-infiniband). To learn how to set up MPI, see [Set up Message Passing Interface for HPC](/azure/virtual-machines/workloads/hpc/setup-mpi).

  :::image type="content" alt-text="Diagram that shows InfiniBand connection between VMs." source="media/infiniband.png" lightbox="media/infiniband.png":::

- **Azure ExpressRoute:** ExpressRoute connections don't use the public internet, and they provide more reliability, faster speeds, and lower latencies than typical internet connections. For point-to-site VPN and site-to-site VPN, you can connect on-premises devices or networks to a virtual network by using any combination of these VPN options and ExpressRoute.

  - For burst applications like a hybrid setup for reservoir simulation and modeling, where on-premises datasets are shared and the Azure compute becomes an extension, ExpressRoute connects your on-premises environment to the Microsoft cloud over a private connection. ExpressRoute provides enterprise-grade resiliency and availability, and the advantage of a Global ExpressRoute partner ecosystem. For more information about how to connect your network to Microsoft by using ExpressRoute, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).

  - For hybrid applications like risk grid computing solutions, where your on-premises trading systems and analytics are functional and Azure becomes an extension, you can use ExpressRoute to connect your on-premises environment to Azure over a private connection, with the help of a connectivity provider. ExpressRoute provides enterprise-grade resiliency and availability and the advantage of a global ExpressRoute partner ecosystem. For information about how to connect your network to Azure by using ExpressRoute, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).

## Define an Azure network topology

Enterprise-scale landing zones support two network topologies. One topology is based on Azure Virtual WAN and the other on a traditional network topology that's based on hub-and-spoke architecture. This section recommends HPC configurations and practices for both deployment models.

Use a network topology that's based on a virtual WAN if your organization plans to:

- Deploy resources across several Azure regions and connect your global locations to both Azure and on-premises environments.

- Integrate software-defined WAN deployments fully with Azure.

- Deploy up to 2,000 VM workloads across all virtual networks connected to one virtual WAN hub.

Organizations use Azure Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps to reduce overall network complexity and modernize your organization's network. Use a traditional Azure network topology based on the [hub-and-spoke architecture](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) if your organization:

- Plans to deploy resources in only select Azure regions.

- Has no need for a global, interconnected network.

- Has few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels.

- Requires full control and granularity to manually configure your Azure network.

- Uses local and global virtual network peering to provide connectivity.
  
Local and global virtual network peering provide connectivity and are the preferred approaches to help ensure connectivity between landing zones for HPC deployments across multiple Azure regions. Document your network topology and firewall rules. Network security groups (NSGs) are often implemented with considerable complexity. Use application security groups when it makes sense to label traffic at a greater granularity than virtual networks can provide. Understand NSG prioritization rules and which rules take precedence over others.

## Inbound and outbound internet connectivity

The following section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet. Because Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Azure Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs that are associated with infrastructure deployments, which can become complex at scale.

### Design considerations and recommendations

- Consider using [Azure Front Door](/azure/frontdoor/front-door-overview) for your HPC deployment if your organization has a global footprint. Azure Front Door uses [Azure Web Application Firewall policies](/azure/web-application-firewall/ag/policy-overview) to deliver and help protect global HTTP and HTTPS applications across Azure regions.

- Take advantage of [Web Application Firewall policies](/azure/web-application-firewall/ag/create-waf-policy-ag) when you use Azure Front Door and Application Gateway to help protect HTTP and HTTPS applications. Lock down Application Gateway to receive traffic only from Azure Front Door. For more information, see [How do I lock down access?](/azure/frontdoor/front-door-faq#what-are-the-steps-to-restrict-the-access-to-my-backend-to-only-azure-front-door-).

- Use local and global virtual network peering connectivity. These methods are preferred to help ensure connectivity between landing zones for HPC deployments across multiple Azure regions.

## Define network encryption requirements

The following section provides key recommendations for encrypting networks between on-premises environments and Azure, and across Azure regions.

### Design considerations and recommendations

- Consider traffic performance when you enable encryption. IPsec tunnels encrypt internet traffic by default. Any extra encryption or decryption can negatively affect performance. When you use ExpressRoute, traffic isn't encrypted by default. Determine whether you should encrypt HPC traffic. For more information about network encryption options in enterprise-scale landing zones, see [network topology](../../ready/azure-best-practices/define-an-azure-network-topology.md) and [connectivity](../../ready/azure-best-practices/connectivity-to-azure.md).

The following recommendations are for encrypting networks between on-premises and Azure, and across Azure regions:

- Determine whether HPC traffic should be encrypted. For more information, see [Network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md).

- Plan for IP addressing in Azure to help ensure that:

  - The IP address space doesn't overlap across on-premises locations and Azure regions.
  - The virtual network contains the right address space.
  - Proper planning for subnet configuration happens in advance.

## Define and throughput latency bandwidth network requirements

HPC in the Cloud Only and HPC Cloud Hybrid deployment models each have their own networking and connectivity latency and throughput needs. These needs depend on how you submit and run the manufacturing workflow and workload jobs on-premises versus the cloud. Users can submit HPC jobs in many deployment modes from on-premises or the cloud.

- Single jobs
  - On-premises to Azure connectivity considerations if you use remote visualization desktop

- Burst jobs
  - Scheduler setup network considerations, which submit the jobs in the cloud
  - Azure Batch network considerations

- Parallel workflows for on-premises and cloud environments
- Hybrid
  - HPC cache

- Cloud native
  - KS containers
  - Functions

MPI environments are dedicated because they have unique requirements that need low-latency communications between nodes. The nodes connect via high-speed interconnect and aren't amenable to sharing with other workloads. MPI applications use the entire high-performance interconnects by way of pass-through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre that's also accessed via the high-speed interconnect.

## Next steps

The following articles provide guidance for each step in the cloud adoption journey for HPC environments.

- [Azure Billing and Microsoft Entra tenants for energy HPC](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/azure-billing-active-directory-tenant)
- [Resource organization for HPC in the energy industry](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/resource-organization)
- [Governance for HPC in energy industries](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/security-governance-compliance)
- [Security for Azure HPC in energy](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/security)
- [Compute large-scale HPC application workloads in Azure VMs](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/compute)
- [Storage for HPC energy environments](/azure/cloud-adoption-framework/scenarios/azure-hpc/energy/storage)
- [Azure high-performance computing (HPC) landing zone accelerator](azure-hpc-landing-zone-accelerator.md)
