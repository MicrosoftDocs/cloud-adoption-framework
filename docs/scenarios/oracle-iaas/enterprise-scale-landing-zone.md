---
title: Oracle on Azure landing zone accelerator
description: Learn about the Oracle on Azure landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Oracle on Azure landing zone accelerator

Use the guidance in this article to set up and operate Oracle workloads inside your Azure landing zone. The article provides a specific architectural approach and reference implementation for your Oracle database systems on Azure.

The implementation guidance in this article presupposes that you have implemented Azure landing zone in your environment. For more information, see [What is an Azure landing zone](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options.](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) 

Adapt the architecture to your organization:

Oracle on Azure landing zone architectures vary by organization. Technical considerations and design recommendations lead to configurations that are unique to your organization's specific scenario. The recommendations that this article describes should lead to an architecture that puts your organization on a path to sustainable scaling. 

## Design guidelines

As you plan the implementation of your Oracle landing zone, you need to make design decisions relating to several areas. These articles provide design guidelines and recommendations for each area:

Network topology and connectivity (link to article)

Management and monitoring (link to article)

Business continuity and disaster recovery (link to article)

Security, governance, and compliance (link to article) 

## Architecture 

You need to understand and plan for all critical areas of your deployment architecture. This article describes the key components of the landing zone architecture in Azure about Oracle database services.

## Landing zone architecture

The following diagram is a conceptual reference architecture that shows the critical design areas in an Oracle on Azure landing zone accelerator.  

:::image type="content" source="media/reference-architecture-oracle-landing-zone-accelerator.png" alt-text="Diagram showing the reference architecture of Oracle on Azure landing zone accelerator.":::

## High-level Oracle landing zone architecture

Use the reference architecture as a starting point. You can download the [Visio file](https://microsof.sharepoint.com/:u:/t/DataMod/ETuAV2_4kd9ErT3xmusXJL8B9nIv8xKMQi709VE2iV_omA?e=fC5kNW) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

As shown in  the reference architectural diagram, the Oracle databases are deployed on virtual machines. You can change the sizes and numbers of virtual machines to accommodate your organization's needs. The network layout in this example is simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

## Subscriptions

 The example Oracle workload architecture uses the following two subscriptions:

**An Azure virtual hub subscription** that contains the hub virtual network if necessary for hybrid connectivity. If your Oracle workloads are internet facing only, they may not require this specifically.  

**An Azure Oracle production subscription**, where the production and disaster recovery systems are configured.  

**An Azure Oracle non-production subscription**, where a non-production system includes a sandbox or development, quality assurance, or preproduction systems. This configuration is optional. You can use a subscription for each workload zone.

## Networking

The example Oracle on Azure architecture is contained inside a single or potentially two VNETs. This can be used for either a hybrid connectivity scenario, or for scenarios where your Oracle workload isn't enabled for hybrid connectivity. For hybrid connectivity scenarios the Oracle spoke virtual network should be connected to a hub virtual network in accordance with ALZ general principles, either through regular peering or through Virtual WAN.  

The architecture subdivides the virtual network address space into subnets. You can associate each subnet with a network security group that defines the access policies for the subnet. Place application servers on a separate subnet so that you can more easily provide security for them.

You can manage the subnet security policies instead of managing individual servers. When you associate a network security group with a subnet, the network security group applies to all the servers in the subnet, and you have fine-grained control over the servers.

This architecture has three or four subnets, depending on the tier. For example, a production system might have the following four subnets.

**Azure NetApp Files**: [A delegated subnet](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) for using Azure NetApp Files for different Oracle on Azure scenarios.

**Azure Application Gateway**: A subnet that handles traffic coming from the internet.  

**Oracle applications**: A subnet that contains Oracle application servers.

**Database**: A subnet that contains only database virtual machines.

As Oracle Databases are backend services for a host of different applications with different architectures and requirements, more subnets may be required. For example, if you have a three-tier architecture, you might have a separate subnet for the web tier.

## Virtual machines and availability sets

For the basic HA configuration, the virtual machines in the Data Guard setup are grouped in an availability set. There's no charge for creating an availability set. You pay only for each virtual machine that you create.  Azure uptime SLA for virtual machines in an availability set is 99.95%. 

For more information about Basic HA configuration, see the [Oracle BCDR documentation](Oracle BCDR documentation).

## Virtual machines and availability zones

An Azure availability zone is a unique physical location within a region. Each zone is made up of one or more datacenters that are equipped with independent power, cooling, and networking.

For Oracle implementations latency between availability zones may be a concern, specifically regarding traffic between application servers and database servers if in different availability zones. The advanced HA/DR configuration places the database servers in different availability zones.

Depending on your application requirements you should  ensure that application servers are configured for zone redundancy. This configuration can be achieved through such technologies as [Virtual machine scale sets Flex](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration),[Azure Site Recovery]( <https://learn.microsoft.com/azure/site-recovery/azure-to-azure-how-to-enable-zone-to-zone-disaster-recovery>) or other options. This also extends to other parts of the infrastructure such as Application Gateway, or ExpressRoute. The Azure uptime SLA for virtual machines configured for availability zones is 99.99%

For more information about advanced HA/DR configuration, see (link to Oracle BCDR documentation).

## Azure NetApp Files and Azure Files

Azure NetApp Files and Azure Files with Network File System (NFS) provide high-availability file share services for Oracle database servers and redo log archiving.

Azure NetApp Files can host Oracle data and log files. Use this configuration for situations where performance requirements for the Oracle database installation exceed what is possible with managed disks.

[Azure Files](https://learn.microsoft.com/azure/storage/files/storage-files-introduction) provides two main types of endpoints for accessing Azure file shares:

**Public endpoints** have a public IP address that can be accessed from anywhere in the world.

**Private endpoints** are in a virtual network and have a private IP address within the address space of that virtual network.

The example Oracle database server architecture uses [private endpoints](https://learn.microsoft.com/azure/private-link/private-endpoint-overview) so that database servers access them only over [private link](https://learn.microsoft.com/azure/private-link/private-link-overview), which improves security.

## Landscape consolidation

Consider setting up landscape consolidation for nonproduction systems like sandbox and development environments. For example, consider different use cases:

Oracle database scenarios typically run an application and a database in separate virtual machines.

Oracle scenario might have two-tier deployments in which the Oracle application and database run on the same virtual machine. This configuration is more typical for dev/sandbox scenarios.

The components are separate in the example Oracle systems architecture to provide greater flexibility for maintenance, sizing, monitoring, and change control. Choose a design based on your requirements.

## Component information

The example architecture has components that you can use for Oracle operations. There are different strategies for [Backup services on Azure for Oracle database](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-database-backup-strategies) that helps you to extend and improve your Oracle data platform with cloud-native Azure data services. A few of the backup recommendations are:

- [Azure storage-based backup and recovery](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-database-backup-azure-storage?tabs=azure-portal)

- [Azure Backup services-based backup and recovery](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-database-backup-azure-backup?tabs=azure-portal)

- [RMAN Based streaming backup](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-rman-streaming-backup?branch=pr-en-us-234143)

Apart from backup Azure provides methods for setting up [disaster recovery](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-disaster-recovery) capabilities for Oracle on Azure VMs.

## Oracle landscape architecture examples  

The following reference architectures are an extension of the high-level architecture that appears earlier in this article. The below table describes example use cases with differing resiliency features.  

To implement the reference architecture, you can either follow the guidance provided in this and supporting documents or you can choose to apply the Oracle Infrastructure landing zone accelerator (link to GitHub repo). For step-to-step guidance on how to deploy the infrastructure automatically  see [Oracle LZA deployment guide](link to Oracle LZA deployment guide).

## Next steps

Review the following design areas for your Oracle on Azure landing zone accelerator architecture:

- Network topology and connectivity
- Management and monitoring
- Business continuity and disaster recovery + Backup and recovery
- Security, governance, and compliance
