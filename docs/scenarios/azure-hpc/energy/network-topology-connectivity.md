---
title: 'Energy HPC Network Topology and Connectivity| Microsoft Docs'
description: 'This HPC energy guidance builds on considerations and recommendations defined in the Azure landing zone article for network topology and connectivity.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Network Topology and Connectivity for Energy HPC

This guidance builds on considerations and recommendations defined in the Azure landing zone article for [network topology and connectivity](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity). Following the guidance in this article will help examine key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure and HPC deployments.

## Plan for IP addressing, virtual network and subnets

It's vital to plan for IP addressing in Azure to ensure that:

 - The IP address space doesn't overlap across on-premises locations and Azure regions.
 - Future VNet peering to existing or planned VNets is possible
 - The virtual network (VNet) contains the right address space.
 - Proper planning for subnet configuration happens in advance.
 - Sufficient excess addressing is considered for future expansion or additional services

## HPC Design considerations

1.	Consider creating separate subnets to assign IP addresses across functional components of the environment. For example, a dedicated HPC VNet could include the following subnets:
    1.	Compute
    2.	Storage
    3.	Infrastructure
    4.	Visualization
    5.	Login
    6.	ANF
    7.	HPC Cache

2.	Several services like Azure NetApp Files, Azure HPC Cache and future storage offerings, require dedicated delegated subnets for proper operation. Ensure that appropriate addressing space is planned if any of these services are under consideration.

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall Azure landing zone architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**HPC Design considerations**

The following recommendations are for when a virtual machine's DNS or virtual name doesn't change during migration.

Use case:

 - Background DNS and virtual names connect many system interfaces in the HPC environments, and customers are only sometimes aware of the interfaces that developers define over time. Connection challenges arise between various systems when virtual or DNS names change after migrations, and it's recommended to retain DNS aliases to prevent these types of difficulties.
 - Use different DNS zones to distinguish each environment (sandbox, development, preproduction, and production) from each other. The exception is for HPC deployments with their own VNet; here, private DNS zones might not be necessary.
 - DNS support is mandatory while using HPC cache so they can access storage and other resources

## High performance network services

### HPC Design considerations:

**Accelerated Networking:**

Many HPC workloads (e.g. Seismic Processing) require the processing of large amount of data that is stored in large shared file systems like Azure Blob, Azure NetApp Files, Lustre ClusterStor and other custom storage solutions that are accessed through the network. It becomes paramount to rely on a high performance network to reduce the time for data transfers.

Enabling [Accelerated Networking](/azure/virtual-network/accelerated-networking-overview) provides the VMs a high-throughput and low latency connection between them and to/from Azure services together with reduced jitter and minimal CPU utilization.

**InfiniBand:**

Parallel HPC applications that rely on Message Passing Interface (MPI) libraries might require significant amount of information to be transferred between many VMs. The InfiniBand interconnect available on RDMA capable [H-series](/azure/virtual-machines/sizes-hpc) and [N-series](/azure/virtual-machines/sizes-gpu) VMs provides the required low latency and high bandwidth to maximize the performance and scalability of HPC and AI applications.

:::image type="content" alt-text="Infini Band" source="../media/infiniband.png" lightbox="../media/infiniband.png":::

Some examples of MPI jobs include molecular dynamics, computational fluid dynamics, oil and gas reservoir simulation, and emerging distributed machine learning workloads in Energy.

InfiniBand connection is possible only between VMs allocated within the same [placement group](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups).

**Azure ExpressRoute**

 - In the case of a  burst application like a hybrid setup for reservoir simulation and modeling, where the  on-premises data sets. are shared and the Azure compute becomes an extension, Express Route will help you to connect your on-premises environment into the Microsoft cloud over a private connection with the help of a connectivity provider.  It provides enterprise-grade resiliency and availability, and the advantage of a Global ExpressRoute partner ecosystem. For information on how to connect your network to Microsoft using ExpressRoute, see ExpressRoute connectivity models.
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
 - Local and global VNet peering provide connectivity and are the preferred approaches to ensure connectivity between landing zones for HPC deployments across multiple Azure regions.

## Plan for inbound and outbound internet connectivity

This section recommends connectivity models for inbound and outbound connectivity to and from the public internet. Since Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

Design recommendations for HPC implementation:

 - For customers with a global footprint, Azure Front Door helps HPC deployments by using Azure Web Application Firewall policies to deliver and protect global HTTP/S applications across Azure regions.
 - Take advantage of Web Application Firewall policies in Azure Front Door when you're using this service and Application Gateway to protect HTTP/S applications. Lock down Application Gateway to receive traffic only from Azure Front Door.

## Define network encryption requirements

This section explores key recommendations for encrypting networks between on-premises and Azure, and across Azure regions.

Design considerations for HPC Implementations:

 - Traffic isn't currently encrypted when Azure ExpressRoute is used to configure private peering.
 - It isn't necessary to encrypt traffic over ExpressRoute for HPC deployments. IPsec tunnels encrypt internet traffic by default, and encryption or decryption could negatively affect the traffic's performance.

It's up to the customer to determine whether HPC traffic should be encrypted. Explore network topology and connectivity to understand network encryption options in enterprise-scale landing zones.

It's vital to plan for IP addressing in Azure to ensure that:

 - The IP address space doesn't overlap across on-premises locations and Azure regions.
 - The virtual network (VNet) contains the right address space.
 - Proper planning for subnet configuration happens in advance.

## Define and throughput latency bandwidth network requirements

 - Both HPC in the Cloud Only and HPC Cloud Hybrid deployment model will have their own networking and connectivity latency /throughput needs depending on how the energy workflow / workload jobs are submitted and executed in the on-premises vs Cloud. The users can submit HPC jobs in many deployment modes (from on-premises or in the cloud)
     - Single Jobs
         - On-premises to Azure connectivity considerations if remote visualization desktop are used
     - Burst Jobs
         - Scheduler setup network considerations which submit the jobs in the cloud
         - Azure Batch network considerations  
     - Parallel Workflows (both on-premises and in the cloud)
     - Hybrid
         - HPC Cache
     - Cloud Native
         - AKS Containers
         - Functions

 - MPI environments are dedicated as they have unique requirements with the need for low latency communications between nodes. The nodes are connected via high-speed interconnect and are not very amenable to sharing with other workloads. MPI applications leverage the entire high-performance interconnects using Pass-Through mode in virtualized environments. Storage for MPI nodes is usually a parallel file system like Lustre also accessed via the high-speed interconnect.

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)

