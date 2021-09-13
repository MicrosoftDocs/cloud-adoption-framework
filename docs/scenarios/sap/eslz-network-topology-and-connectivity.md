---
title: Network topology and connectivity for an SAP migration
description: Understand design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure and SAP deployments.
author: JefferyMitchell
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Network topology and connectivity for an SAP migration

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [enterprise-scale design area for network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md). Following the guidance in this article will help examine key design considerations and best practices surrounding networking and connectivity to, from, and within Microsoft Azure and SAP deployments. Since SAP is an mission-critical platform, the guidance on the enterprise-scale design areas should also be included in your design.

## Plan for IP addressing

It's vital to plan for IP addressing in Azure to ensure that:

- The IP address space doesn't overlap across on-premises locations and Azure regions.
- The virtual network (VNet) contains the right address space.
- Proper planning for subnet configuration happens in advance.

The following architecture diagram shows networking considerations in enterprise-scale for SAP on Azure:

 ![A diagram of networking considerations in Enterprise-scale for SAP on Azure.](./media/ntc-architecture.png#lightbox)

*Figure 1: A diagram of networking considerations in Enterprise-scale for SAP on Azure.*

**Design considerations for SAP implementation:**

You can [dedicate](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network) and delegate subnets to certain services, and then create instances of those services within subnets. While Azure does help you to create multiple delegated subnets in a VNet, only one delegated subnet can exist in a VNet for Azure NetApp Files. Attempts to create a new volume will fail if you use more than one delegated subnet for Azure NetApp Files.

**Use case:**

Delegated subnets are required for implementing Azure NetApp Files, which is popular during SAP deployments with shared file systems. A delegated subnet is required only for Application Gateway during Azure Application Gateway SAP scenarios like load balancing or SAP BusinessObjects Business Intelligence, a load-balancing SAP web application server.

## Configure DNS and name resolution for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design recommendations for SAP implementation:**

The following recommendations are for when a virtual machine's DNS or virtual name doesn't change during migration.

**Use case:**

- Background DNS and virtual names connect many system interfaces in the SAP landscape, and customers are only sometimes aware of the interfaces that developers define over time. Connection challenges arise between various systems when virtual or DNS names change after migrations, and it's recommended to retain DNS aliases to prevent these types of difficulties.

- Use different DNS zones to distinguish each environment (sandbox, development, preproduction, and production) from each other. The exception is for SAP deployments with their own VNet; here, private DNS zones might not be necessary.

## Define an Azure network topology

Enterprise-scale landing zones support two network topologies: one based on Azure Virtual WAN and the other a traditional network topology based on hub-and-spoke architecture. This section recommends SAP configurations and practices for both deployment models.

Use a network topology based on Virtual WAN if your organization plans to:

- Deploy resources across several Azure regions, and connect your global locations to both Azure and on-premises.
- Fully integrate software-defined WAN deployments with Azure.
- Deploy up to 2,000 virtual machine workloads across all VNets connected to one Virtual WAN hub.

Organizations use Virtual WAN to meet large-scale interconnectivity requirements. Microsoft manages this service, which helps to reduces overall network complexity and modernize your organization's network.

Use a traditional Azure network topology based on hub-and-spoke architecture if your organization:

- Plans to deploy resources in only select Azure regions
- Doesn't need a global, interconnected network
- Has few remote or branch locations per region and needs fewer than 30 IP security (IPsec) tunnels
- Requires full control and granularity to manually configure your Azure network

**Design recommendations for SAP implementation:**

- Use Virtual WAN for Azure deployments in new, large, or global networks where you need global transit connectivity across Azure regions and on-premises locations. With this approach, you won't need to manually set up transitive routing for Azure networking, and you can follow a standard for SAP on Azure deployments.

- Consider deploying network virtual appliances (NVAs) between regions only if partner NVAs are used. NVAs between regions or VNets aren't required if native NVAs are present. When you're deploying partner networking technologies and NVAs, follow the vendor's guidance to verify conflicting configurations with Azure networking.

- Virtual WAN manages connectivity between spoke VNets for virtual-WAN-based topologies (no need to set up user-defined routing [UDR] or NVAs), and maximum network throughput for VNet-to-VNet traffic in the same virtual hub is 50 gigabits per second. If necessary, SAP landing zones can use VNet peering to connect to other landing zones and overcome this bandwidth limitation.

- Deploying NVAs between an SAP application and database server isn't supported.

- Local and global VNet peering provide connectivity and are the preferred approaches to ensure connectivity between landing zones for SAP deployments across multiple Azure regions.

## Plan for in- and outbound internet connectivity

This section recommends connectivity models for in- and outbound connectivity to and from the public internet. Since Azure-native network security services like Azure Firewall, Azure Web Application Firewall on Application Gateway, and Azure Front Door are fully managed services, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

**Design recommendations for SAP implementation:**

- For customers with a global footprint, [Azure Front Door](/azure/frontdoor/front-door-overview) helps SAP deployments by using Azure Web Application Firewall policies to deliver and protect global HTTP/S applications across Azure regions.

- Take advantage of Web Application Firewall policies in Azure Front Door when you're using this service and Application Gateway to protect HTTP/S applications. Lock down Application Gateway to receive traffic only from Azure Front Door.

- Application Gateway and Web Application Firewall have limitations when Application Gateway serves as a reverse proxy for SAP web apps, as shown in the comparison between Application Gateway, SAP Web Dispatcher, and a third-party service, NetScaler.

Since SAP Web Dispatcher and NetScaler are more intelligent than Application Gateway, extensive testing is necessary to replace them with this service. Verify the most current status and list all supported and not supported (or tested/not tested) scenarios, if possible.

- Use a web application firewall to scan your traffic when it's exposed to the internet. Another option is to use it with your load balancer or with resources that have built-in firewall capabilities like Application Gateway or third-party solutions.

- To prevent data leakage, use Azure Private Link to securely access platform as a service resources like Azure Blob Storage, Azure Files, Azure Data Lake Storage Gen2, Azure Data Factory, and more. Azure Private Endpoint can also help to secure traffic between VNets and services like Azure Storage, Azure Backup, and more. Traffic between your VNet and the Private Endpoint enabled service travels across the Microsoft global network, which prevents its exposure to the public internet.

## Define network encryption requirements

This section explores key recommendations for encrypting networks between on-premises and Azure, and across Azure regions.

**Design considerations for SAP Implementations:**

- Traffic isn't currently encrypted when Azure ExpressRoute is used to configure private peering.

- It isn't necessary to encrypt traffic over ExpressRoute for SAP deployments. SAP traffic typically consumes a lot of bandwidth and is sensitive to performance. IPsec tunnels encrypt internet traffic by default, and encryption or decryption could negatively affect the traffic's performance.

- It's up to the customer to determine whether SAP traffic should be encrypted. Explore [network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md#define-network-encryption-requirements) to understand network encryption options in enterprise-scale landing zones.

## Segregate systems

Since different environments like development, testing, quality, preproduction, production, and more exist in an SAP scenario, customers tend to categorize these systems to logical/physical constructs to uphold security and compliance standards. The idea is to manage all systems with the same lifecycle in one common resource group, and grouping can be defined at various levels, like at the subscription or resource-group level. Organizations should also consider the security and policy structure while grouping resources in an SAP landscape. However, for SAP transports to flow between development, testing, quality, and production, an organization could need:

- VNet peering and associated costs
- Firewall port openings between VNets
- UDR and network security group (NSG) rules

It isn't recommended to host the database management system (DBMS) and application layers of SAP systems in different VNets and connect them with VNet peering because of the substantial costs that excessive network traffic between the layers can produce.

**Additional recommendations for SAP implementations:**

- Placing of the SAP application layer and SAP DBMS in different Azure VNets that aren't peered isn't supported.

- You can use application security group (ASG) and NSG rules to define network security access-control lists between the SAP application and DBMS layers. ASGs group virtual machines to help manage their security.

- Make sure that Azure accelerated networking is enabled on the VMs used in the SAP application and DBMS layers. Consider that different operating system levels support accelerated networking in Azure:

  - Windows Server 2012 R2 or later
  - SUSE Linux 12 SP3 or later
  - Red Hat Enterprise Linux 7.4 or later
  - Oracle Linux 7.5 release 3.10.0-862.13.1.el7 is required for the kernel compatible with Red Hat Enterprise Linux. Release 5 is required for the Oracle Unbreakable Enterprise Kernel.

- Make sure that internal deployments for Azure Load Balancer are set up to use Direct Server Return (DSR). This setting will reduce latency when internal load balancer configurations are used for high-availability configurations on the DBMS layer.

- If using Load Balancer with Linux guest operating systems, check that the Linux network parameter `net.ipv4.tcp_timestamps` is set to `0`.

- For optimal network latency with SAP applications, consider using [Azure proximity placement groups](/azure/virtual-machines/workloads/sap/sap-proximity-placement-scenarios).

- Explore the [SAP support portal](https://support.sap.com/en/index.html) and [SAP Note 2391465](https://launchpad.support.sap.com/#/notes/2931465) to learn more about implementing SAP.
