---
title: SAP on Azure landing zone accelerator
description: Learn about the SAP on Azure landing zone accelerator.
author: JefferyMitchell
ms.author: brblanch
ms.reviewer: tozimmergren
ms.date: 10/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-sap
  - engagement-fy23
---

# SAP on Azure landing zone accelerator

Use the SAP on Azure landing zone accelerator to set up and operate workload landing zones inside your Cloud Adoption Framework enterprise-scale landing zone. The landing zone accelerator provides a specific architectural approach and reference implementation for your SAP systems on Azure.

Deploy the SAP on Azure landing zone accelerator after successfully implementing an enterprise-scale landing zone. Before you deploy the SAP on Azure landing zone accelerator, review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Adopt the accelerator for your architecture

The architecture of the SAP on Azure landing zone accelerator varies by customer. Technical considerations and design recommendations lead to trade-offs based on each organization's specific scenario. Follow the core recommendations this article describes to find an architecture that sets your organization on a path to sustainable scaling.

The SAP on Azure landing zone accelerator is modular by design, and you can customize environmental variables. A customizable approach to landing zones includes the following assets to support your planning and implementation:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

As you plan your implementation of the Cloud Adoption Framework for Azure enterprise-scale landing zone, you must make decisions in critical design areas. The following articles give you detailed design guidelines and recommendations for each area:

- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

Understanding and planning for all critical areas of your deployment architecture is essential. This article describes the key components of the landing zone architecture in Azure and your SAP systems architecture.

### Landing zone architecture

The following diagram is a conceptual reference architecture that shows the critical design areas in an SAP on Azure landing zone accelerator:

:::image type="content" source="./media/enterprise-scale-architecture-sap.svg" border="false" alt-text="Diagram that depicts the SAP on Azure landing zone accelerator conceptual reference architecture." lightbox="./media/enterprise-scale-architecture-sap.svg":::

### SAP systems high-level architecture

The following diagram is a reference architecture of an SAP systems landscape that includes production and non-production systems. This architecture is one of many options you can use to deploy SAP systems in Azure. The implementation you choose depends on your requirements.

Use the reference architecture as a starting point. You can download the associated [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/sap-landscape-multiple-systems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

:::image type="content" source="./media/sap-landscape-high-level-architecture.svg" border="false" alt-text="Diagram that shows the high-level architecture of an SAP systems landscape in Azure with production and non-production systems." lightbox="./media/sap-landscape-high-level-architecture.svg":::

### Workflow

This article shows an example of a high-level, overall SAP architecture across different tiers.

The SAP systems example reference architecture describes an SAP systems landscape with production and non-production systems. Both systems are deployed by using virtual machines. You can change the sizes and numbers of virtual machines to accommodate your organization's needs.

This example architecture uses availability sets to deploy SAP systems in Azure. The network layout in this example is greatly simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

### Recommendations

Your deployment might be different depending on your business requirements. Consider these recommendations a starting point.

#### Subscriptions

The example SAP systems architecture uses the following three subscriptions:

- **An Azure virtual hub subscription** where the hub virtual network exists for the primary and secondary regions.

- **An Azure SAP production subscription** where the production and disaster recovery systems are configured.

- **An Azure SAP non-production subscription** where a non-production system includes a sandbox, development, quality assurance, or pre-production systems. This configuration is optional. You can use a subscription for each workload zone.

#### Networking

The example SAP systems architecture uses a hub-spoke topology. The hub virtual network acts as a central point of connectivity to an on-premises network. The spokes are an SAP virtual network that's peered with the hub. You can use the spokes to isolate workloads.

The architecture uses one SAP virtual network per workload zone. It uses a different SAP virtual network for production, development, quality assurance, and the sandbox. In the architecture, you peer the Azure hub virtual network with the production, development, quality assurance, and sandbox virtual networks. Traffic flows between the on-premises datacenter and the hub through a gateway connection.

> [!NOTE]
> Consider setting up a site-to-site (S2S) VPN as a backup of Azure ExpressRoute or for any third-party route requirements. For more information, see [Use S2S VPN as a backup for ExpressRoute private peering](/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering).

#### Subnets and network security groups

The architecture subdivides the virtual network address space into subnets. You can associate each subnet with a network security group that defines the access policies for the subnet. Place application servers on a separate subnet to secure them more easily. You can manage the subnet security policies instead of managing individual servers. When you associate a network security group with a subnet, the network security group applies to all the servers in the subnet, and you have fine-grained control over the servers.

This architecture has three or four subnets depending on the tier. For example, a production system might have the following four subnets:

- **Azure NetApp Files**: [A delegated subnet](/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) for using NetApp Files for different SAP on Azure scenarios.
- **Azure Application Gateway**: A subnet that handles traffic coming from the internet. For example, this subnet might handle Fiori apps.
- **SAP applications**: This subnet contains SAP application servers, SAP Central Services, SAP enqueue replication services instances and web dispatchers.
- **Database**: This subnet contains only database virtual machines.
  
> [!NOTE]
> The example SAP systems architecture shows the explicit definition of web dispatchers in a separate availability set. The web dispatcher component is a load balancer for SAP traffic among the SAP application servers. To achieve [high availability for SAP Web Dispatcher](https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-US/48/9a9a6b48c673e8e10000000a42189b/frameset.htm), Azure Load Balancer implements either the failover cluster or the parallel web dispatcher setup. Set up a standalone solution architecture in a perimeter network for internet-facing communications to satisfy security concerns. [Embedded Web Dispatcher on ASCS](https://help.sap.com/docs/SLTOOLSET/00b4e4853ef3494da20ebcaceb181d5e/2e708e2d42134b4baabdfeae953b24c5.html?locale=en-US&version=CURRENT_VERSION) describes a specific option. Take into account the sizing that's required due to other workloads on SAP ASCS.

#### Virtual machines and availability sets

For all pools and clusters (SAP Web Dispatcher, SAP application servers, SAP Central Services, and SAP HANA), group the virtual machines in separate availability sets. No cost is associated with creating an availability set. You pay only for each virtual machine you create.

#### Virtual machines and availability zones

An Azure availability zone is a unique physical location within a region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking.

When you design for availability zones, check the latency between zones. Knowing the network latency between the zones of a region helps you choose availability zones that have the least network latency in cross-zone network traffic.

When you set up your availability zones, use zone-redundant services for your instances of Azure ExpressRoute, [Azure VPN Gateway](/azure/vpn-gateway/about-zone-redundant-vnet-gateways), and [Azure Application Gateway](/azure/application-gateway/overview-v2).

For more information about the availability zone architecture for SAP on Azure, see [SAP HA availability zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

#### Azure NetApp Files and Azure Files

Azure NetApp Files and Azure Files with Network File System (NFS) and Server Message Block (SMB) provide high-availability file share requirements for SAP Central Services, a shared SAP mount, and a global transport directory.

To handle the transport directory requirements, create the transport groups option as described in [Azure Virtual Machines planning and implementation for SAP NetWeaver](/azure/virtual-machines/workloads/sap/planning-guide). Another way to handle the transport requirements is to make one of the SAP tiers the primary production system that provides the transport directory share to other systems in the landscape.

The high-availability requirements for SAP Central Services differ based on the operating system. For example:

- For a Linux operating system, the shared file systems typically are placed on high-availability NFS storage or NetApp Files instances to provide a high-availability NFS share. For more information, see [NFS over Azure Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-nfs-azure-files) or [Azure NetApp Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files).

- For a Windows operating system, see [Azure Files with SMB](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-azure-files-smb) and [Azure NetApp Files with SMB](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-netapp-files-smb).

Azure NetApp Files shares can host SAP HANA data and log files. Use this configuration for a HANA scale-out deployment model with standby nodes. NetApp Files supports HANA scale-up or [HANA scale-out](/azure/virtual-machines/workloads/sap/sap-hana-scale-out-standby-netapp-files-suse) with standby nodes.

[Azure Files](/azure/storage/files/storage-files-introduction) provides two main types of endpoints for accessing Azure file shares:

- **Public endpoints** have a public IP address accessible from anywhere in the world.

- **Private endpoints** exist inside a virtual network and have a private IP address within the address space of that virtual network.

The example SAP systems architecture uses [private endpoints](/azure/private-link/private-endpoint-overview) so that clients on a virtual network can securely access data over a [private link](/azure/private-link/private-link-overview).

#### SAP BTP connectivity

Azure Private Link is now generally available. SAP Private Link Service currently supports connections from SAP BTP, the Cloud Foundry runtime, and other services on top of [Azure Private Link resources](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/e8bc0c6440834a47a0ff57cb4efc0dc2.html?locale=en-US) for the most common load balancer plus virtual machine scenarios. Example scenarios include SAP S/4HANA or SAP ERP running on the virtual machine and connecting to Azure native services like [Azure Database for MariaDB](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/862fa2958c574c3cbfa12a927ce1d5fe.html?locale=en-US) or [Azure Database for MySQL](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/5c70499ee70b415d954145a795e43355.html?locale=en-US).

The example architecture depicts an SAP Private Link Service connection to BTP environments. SAP Private Link Service establishes a private connection between specific SAP BTP services and specific services in your infrastructure as service provider accounts. If you reuse the private link functionality, BTP services can access your S/4 HANA environment through private network connections, which avoids data transfer via the public internet.

For more information about scenarios to connect to BTP services, see the SAP Community blog post about the [architecture effect of Private Link Service](https://blogs.sap.com/2021/07/27/btp-private-linky-swear-with-azure-how-many-pinkies-do-i-need/).

### Considerations

Incorporate the following architecture considerations into your landing zone design.

#### Landscape consolidation

Consider setting up landscape consolidation for non-production systems like sandbox and development environments. For example, consider different use cases:

- HANA database scenarios typically run an application and a database in separate virtual machines.

- AnyDB scenarios might have two-tier deployments in which the SAP application and database run on the same virtual machine.

The components are separate in the example SAP systems architecture to provide greater flexibility for maintenance, sizing, monitoring, and change control. Choose a design based on your specific requirements.

#### Component information

The example architecture also has components you can use for day two operations. The components include an Azure Recovery Services vault to back up SAP systems and others that help you extend and improve your SAP data platform with cloud-native Azure data services.

Services like Azure Synapse Analytics, Azure Data Factory, and Azure Data Lake Storage help unlock business insights by combining SAP data with non-SAP data and creating the analytics platform. To evaluate solution development environment design, review [best practices](/azure/synapse-analytics/guidance/implementation-success-evaluate-solution-development-environment-design). You can use different instances of Azure Data Factory and Azure Data Lake Storage based on the SAP tier and best practices for your environment design.

The Azure [integration runtime](/azure/data-factory/concepts-integration-runtime) is the compute infrastructure that Azure Data Factory and Azure Synapse Analytics pipelines use to provide data integration capabilities. Consider the deployment of runtime virtual machines for these services per tier. For examples of ways to connect with SAP systems and deploy the Azure integration runtime, see these articles:

- [Set up a self-hosted integration runtime to use in the SAP CDC solution (preview)](/azure/data-factory/sap-change-data-capture-shir-preparation)

- [Copy data from SAP ECC](/azure/data-factory/connector-sap-ecc?tabs=data-factory)

- [Copy data from SAP HANA](/azure/data-factory/connector-sap-hana?tabs=data-factory)

- [Copy data from an SAP table](/azure/data-factory/connector-sap-table?tabs=data-factory)

- [Copy data from SAP Business Warehouse via Open Hub](/azure/data-factory/connector-sap-business-warehouse-open-hub)

For more information about all architecture components, see [SAP S/4HANA in Linux on Azure](/azure/architecture/reference-architectures/sap/sap-s4hana).

### SAP landscape architecture example of three SAP products

The following diagram is an example reference architecture that's an extension of the high-level architecture shown earlier in the article. The diagram describes an example use case of three SAP products. It shows just one of the options you can use to deploy SAP systems to Azure by using availability sets configuration.

Use this architecture as a starting point. Download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/sap-landscape-multiple-systems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

:::image type="content" source="./media/sap-landscape-multiple-sap-system-example.svg" border="false" alt-text="Diagram that depicts an example use case of three SAP products." lightbox="./media/sap-landscape-multiple-sap-system-example.svg":::

#### Example workflow

SAP customers run various SAP products based on different industry use cases. The architecture diagram shows an example use case that uses three common SAP products. The diagram illustrates an example overall SAP architecture across different tiers and beyond a single SAP solution.

In the workflow diagram, *ERP* represents a legacy SAP ECC system or a next-generation SAP S/4 HANA system. *BW* is SAP Business Warehouse. *PI/PO* refers to process integration or process orchestration. Different colors illustrate different SAP products as they appear in the workflow.

## Implementation

The [SAP deployment automation framework on Azure](https://github.com/azure/sap-automation) is a collection of processes combined with a flexible workflow. The framework repository contains code to deploy SAP landscapes in Azure Cloud Services automatically. Templates are separated into the following categories:

- **Terraform on Azure modules.** Use Terraform modules to deploy infrastructure components in Azure, including:
  - Virtual machines
  - Network
  - Storage
- **Ansible playbooks.** Use Ansible playbooks to:
  - Set up and deploy virtual machines
  - Install SAP HANA
  - Install other required applications

Deploy and install Ansible playbook components on your infrastructure using Terraform on Azure modules.

:::image type="content" source="./media/overview-automation.png" border="false" alt-text="Diagram that shows an overview of an SAP reference implementation.":::

## Next steps

Review the design areas for considerations and recommendations for your SAP on Azure landing zone accelerator architecture.

- [Identity and access management](./eslz-identity-and-access-management.md)
