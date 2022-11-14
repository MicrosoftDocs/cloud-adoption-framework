---
title: Network topology and connectivity for energy HPC
description: Learn about network topology and connectivity considerations in the Azure landing zone for high-performance computing (HPC) in the energy industry.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/11/2022
---

# Network topology and connectivity for energy HPC

The guidance in this article can help you examine design considerations and best practices that relate to networking and connectivity for Microsoft Azure and high-performance computing (HPC) deployments. The following suggestions build on considerations and recommendations defined in the Azure landing zone article for [network topology and connectivity](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity).

## IP addressing, virtual networks, and subnets

It's vital to plan for IP addressing in Azure to ensure that:

- The IP address space doesn't overlap across on-premises locations and Azure regions.
- Future virtual network (VNet) peering to existing or planned VNets is possible.
- The VNet contains the right address space.
- Proper planning for subnet configuration happens in advance.
- Sufficient excess addressing is considered for future expansion or other services.

## Design considerations

Consider creating separate subnets to assign IP addresses across functional components of the environment. For example, a dedicated HPC VNet could include the following subnets:
- Compute
- Storage
- Infrastructure
- Visualization
- Sign in
- Azure NetApp Files
- Azure HPC Cache

Services like Azure NetApp Files, Azure HPC Cache, and future storage offerings require dedicated delegated subnets for proper operation. Ensure that appropriate addressing space is planned if any of these services are under consideration.

## DNS and name resolution for on-premises and Azure resources

Domain name system (DNS) is a critical design topic in the overall Azure landing zone architecture. Some organizations might want to use their existing investments in DNS, while others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**DNS design considerations**: Follow these recommendations when a virtual machine's DNS or virtual name doesn't change during migration.

- Background DNS and virtual names connect many system interfaces in HPC environments, and customers are only sometimes aware of the interfaces that developers define over time. Connection challenges arise between various systems when virtual or DNS names change after migrations, so you should retain DNS aliases to prevent these types of difficulties.
- Use different DNS zones to distinguish environments from each other, such as sandbox, development, preproduction, and production. The exception is for HPC deployments with their own VNet, which might not require private DNS zones.
- DNS support is mandatory while using HPC cache so they can access storage and other resources.

## High-performance network services

- **Accelerated networking**: Many HPC workloads, such as seismic processing, process large amounts of data stored in shared file systems like Azure Blob, Azure NetApp Files, Lustre ClusterStor, and other custom storage solutions that are accessed through the network. A high-performance network is critical to reduce the time for data transfers.

  [Accelerated networking](/azure/virtual-network/accelerated-networking-overview) provides a high-throughput, low-latency connection between the VMs and to Azure services. Other benefits include reduced jitter and minimal CPU utilization.

- **InfiniBand**: Parallel HPC applications that rely on Message Passing Interface (MPI) libraries might need to transfer significant amounts of data between many VMs. The InfiniBand interconnect, available on RDMA capable [H-series](/azure/virtual-machines/sizes-hpc) and [N-series](/azure/virtual-machines/sizes-gpu) VMs, provides a low-latency, high-bandwidth connection to maximize the performance and scalability of HPC and deep learning applications.

  :::image type="content" alt-text="Diagram of InfiniBand connection between VMs." source="../media/infiniband.png" lightbox="../media/infiniband.png":::

  Some examples of MPI jobs include molecular dynamics, computational fluid dynamics, oil and gas reservoir simulation, and emerging distributed machine learning workloads.

  InfiniBand connections are possible only between VMs allocated within the same [placement group](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups).

- **Azure ExpressRoute**: In the case of a burst application like a hybrid setup for reservoir simulation and modeling, where on-premises datasets are shared and the Azure compute becomes an extension, ExpressRoute connects your on-premises environment to the Microsoft cloud over a private connection. ExpressRoute provides enterprise-grade resiliency and availability, and the advantage of a Global ExpressRoute partner ecosystem. For information on how to connect your network to Microsoft using ExpressRoute, see [ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models).

  ExpressRoute connections don't go over the public internet, and they offer more reliability, faster speeds, and lower latency than typical internet connections. For point-to-site VPN and site-to-site VPN, you can connect on-premises devices or networks to a virtual network using any combination of these VPN options and Azure ExpressRoute.

## Defining an Azure network topology

Enterprise-scale landing zones support two network topologies: one based on Azure Virtual WAN, and the other on a traditional network topology based on hub-and-spoke architecture. This section recommends HPC configurations and practices for both deployment models.

- **Azure Virtual WAN**: Use a network topology based on a virtual WAN if your organization plans to:
  - Deploy resources across several Azure regions and connect your global locations to both Azure and on-premises.
  - Fully integrate software-defined WAN deployments with Azure.
  - Deploy up to 2,000 VM workloads across all VNets connected to one virtual WAN hub.

  Organizations use Azure Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps to reduce overall network complexity and modernize your organization's network.

- **Hub-and-spoke architecture**: Use a traditional Azure network topology based on [hub-and-spoke architecture](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) if your organization:
  - Plans to deploy resources in only select Azure regions.
  - Doesn't need a global, interconnected network.
  - Has few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels.
  - Requires full control and granularity to manually configure your Azure network.
  - Local and global VNet peering provide connectivity and are the preferred approaches to ensure connectivity between landing zones for HPC deployments across multiple Azure regions.

## Inbound and outbound internet connectivity

Since Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

Design recommendations for HPC implementation:

- For customers with a global footprint, Azure Front Door helps HPC deployments by using Azure Web Application Firewall policies to deliver and protect global HTTP/S applications across Azure regions.
- Take advantage of Web Application Firewall policies in Azure Front Door when you're using this service and Application Gateway to protect HTTP/S applications. Lock down Application Gateway to receive traffic only from Azure Front Door.

## Network encryption requirements

Design considerations for HPC implementations:

- Traffic isn't currently encrypted when Azure ExpressRoute is used to configure private peering.
- Traffic over ExpressRoute for HPC deployments doesn't need to be encrypted. IPsec tunnels encrypt internet traffic by default, and encryption or decryption could negatively affect the traffic's performance.

Key recommendations for encrypting networks between on-premises and Azure, and across Azure regions:

- Determine whether HPC traffic should be encrypted. Explore network topology and connectivity to understand network encryption options in enterprise-scale landing zones.
- Plan for IP addressing in Azure to ensure that:
  - The IP address space doesn't overlap across on-premises locations and Azure regions.
  - The VNet contains the right address space.
  - Proper planning for subnet configuration happens in advance.

## Throughput latency bandwidth network requirements

Both HPC in the cloud only and hybrid cloud deployment models have their own latency and throughput requirements depending on how the energy workloads are submitted and executed in the on-premises compared to cloud environments. Users can submit HPC jobs in many deployment modes, from on-premises or in the cloud.
- Single jobs
  - On-premises to Azure connectivity considerations if remote visualization desktop is used
- Burst jobs
  - Scheduler setup network considerations that submit the jobs in the cloud
  - Azure Batch network considerations  
- Parallel workflows, both on-premises and in the cloud
- Hybrid
  - HPC cache
- Cloud native
  - Azure Kubernetes Service containers
  - Functions

MPI environments are dedicated as they have unique requirements with the need for low-latency communications between nodes. The nodes are connected via high-speed interconnect and can't be shared with other workloads. MPI applications use the entire high-performance interconnects using pass-through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre, also accessed via the high-speed interconnect.

## Next steps

The following articles provide guidance for each step in the cloud adoption journey for energy HPC environments.

- [Azure billing and Azure Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelator.md)
