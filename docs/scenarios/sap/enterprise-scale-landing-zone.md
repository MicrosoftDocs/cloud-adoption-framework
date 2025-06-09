---
title: SAP on Azure landing zone accelerator
description: Use the SAP on Azure landing zone accelerator to deploy SAP systems on Azure. See a reference implementation for SAP workload landing zones.
author: PmeshramPM
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 01/10/2023
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-sap
  - engagement-fy23
---

# SAP on Azure landing zone accelerator

Use the SAP on Azure landing zone accelerator to set up and operate workload landing zones inside your Cloud Adoption Framework enterprise-scale landing zone. The landing zone accelerator provides a specific architectural approach and reference implementation for your SAP systems on Azure.

Deploy the SAP on Azure landing zone accelerator after you successfully implement an enterprise-scale landing zone. Before you deploy the SAP on Azure landing zone accelerator, review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Adapt the accelerator to your architecture

The architecture of the SAP on Azure landing zone accelerator varies by organization. Technical considerations and design recommendations lead to configurations that are unique to your organization's specific scenario. The recommendations that this article describes can lead to an architecture that puts your organization on a path to sustainable scaling.

The SAP on Azure landing zone accelerator is modular. You can customize environment variables. The customizable approach to landing zones includes the following assets to support your planning and implementation:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

As you plan the implementation of your enterprise-scale landing zone, you need to make design decisions relating to several overall areas. These articles provide design guidelines and recommendations for each area:

- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

You need to understand and plan for all critical areas of your deployment architecture. This article describes the key components of the landing zone architecture in Azure and your SAP systems architecture.

### Landing zone architecture

The following diagram is a conceptual reference architecture that shows the critical design areas in an SAP on Azure landing zone accelerator:

:::image type="content" source="./media/enterprise-scale-architecture-sap.svg" border="false" alt-text="Diagram that shows the SAP on Azure landing zone accelerator architecture." lightbox="./media/enterprise-scale-architecture-sap.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/enterprise-scale-architecture-sap.vsdx) of this architecture.*

> [!NOTE]
> When you deploy a high-availability SAP workload on Azure, it's important to consider the various deployment types that are available. Also consider how to apply them across different Azure regions, such as across zones, in a single zone, or in a region with no zones.
>
> For the highest availability, deploy SAP systems across different zones in a region.
>
> We recommend that you use a flexible virtual machine scale set with a `platformFaultDomainCount` (FD) value of **1** to achieve this availability level. For more information and a discussion of various high-availability deployment options for an SAP workload, see [High-availability architecture and scenarios for SAP NetWeaver](/azure/sap/workloads/sap-high-availability-architecture-scenarios).

### High-level SAP systems architecture

The following diagram is a reference architecture of an SAP systems landscape that includes production and non-production systems. This architecture is one of many options that you can use to deploy SAP systems on Azure. The implementation you choose depends on your requirements.

Use the reference architecture as a starting point. You can download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/sap-landscape-multiple-systems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

:::image type="content" source="./media/sap-landscape-high-level-architecture.svg" border="false" alt-text="Diagram that shows the high-level architecture of an SAP systems landscape, with production and non-production systems, on Azure." lightbox="./media/sap-landscape-high-level-architecture.svg":::

### Workflow

This article provides an example of a high-level, overall SAP architecture that's spread across different tiers.

The SAP systems example architecture describes an SAP systems landscape that has production and non-production systems. Both systems are deployed on virtual machines. You can change the sizes and numbers of virtual machines to accommodate your organization's needs.

This example architecture uses virtual machine scale sets to deploy SAP systems on Azure. The network layout in this example is simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

### Recommendations

Your deployment might be different, depending on your business requirements. These recommendations provide a starting point.

#### Subscriptions

The example SAP systems architecture uses the following three subscriptions:

- **An Azure virtual hub subscription** that contains the hub virtual network for the primary and secondary regions.

- **An Azure SAP production subscription**, where the production and disaster recovery systems are configured.

- **An Azure SAP non-production subscription**, where a non-production system includes a sandbox or development, quality assurance, or pre-production systems. This configuration is optional. You can use a subscription for each workload zone.

#### Networking

The example SAP systems architecture uses a hub-spoke topology. The hub virtual network acts as a central point of connectivity to an on-premises network. The spokes are SAP virtual networks that are peered with the hub. You can use the spokes to isolate workloads.

The architecture uses one SAP virtual network per workload zone. It uses a different SAP virtual network for production, development, quality assurance, and the sandbox. In the architecture, the Azure hub virtual network is peered with the production, development, quality assurance, and sandbox virtual networks. Traffic flows between the on-premises datacenter and the hub through a gateway connection.

> [!NOTE]
> Consider setting up a site-to-site (S2S) VPN as a backup of Azure ExpressRoute or for any third-party route requirements. For more information, see [Use S2S VPN as a backup for ExpressRoute private peering](/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering).

#### Subnets and network security groups

The architecture subdivides the virtual network address space into subnets. You can associate each subnet with a network security group that defines the access policies for the subnet. Place application servers on a separate subnet so that you can more easily provide security for them. You can manage the subnet security policies instead of managing individual servers. When you associate a network security group with a subnet, the network security group applies to all the servers in the subnet, and you have fine-grained control over the servers.

This architecture has three or four subnets, depending on the tier. For example, a production system might have the following four subnets.

- **Azure NetApp Files**: A [delegated subnet](/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) for using Azure NetApp Files for different SAP on Azure scenarios.
- **Azure Application Gateway**: A subnet that handles traffic coming from the internet. For example, this subnet might handle Fiori apps.
- **SAP applications**: A subnet that contains SAP application servers, SAP Central Services, SAP enqueue replication services instances, and web dispatchers.
- **Database**: A subnet that contains only database virtual machines.
  
> [!NOTE]
> The example SAP systems architecture shows the explicit definition of web dispatchers in a separate virtual machine scale set. The web dispatcher component is a load balancer for SAP traffic among the SAP application servers. To achieve [high availability for SAP Web Dispatcher](https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-US/48/9a9a6b48c673e8e10000000a42189b/frameset.htm), Azure Load Balancer implements either the failover cluster or the parallel web dispatcher setup. Set up a standalone solution architecture in a perimeter network for internet-facing communications to help satisfy security concerns. [Embedded Web Dispatcher on ASCS](https://help.sap.com/docs/SLTOOLSET/00b4e4853ef3494da20ebcaceb181d5e/2e708e2d42134b4baabdfeae953b24c5.html?locale=en-US&version=CURRENT_VERSION) describes a specific option. Take into account the sizing that's required because of other workloads on SAP ASCS.

#### Virtual machine scale sets

For all pools and clusters (SAP Web Dispatcher, SAP application servers, SAP Central Services, and SAP HANA), group the virtual machines in separate virtual machine scale sets. There's no charge for creating a virtual machine scale set. You pay only for each virtual machine that you create.

#### Virtual machines and availability zones

An Azure availability zone is a unique physical location within a region. Each zone is made up of one or more datacenters that are equipped with independent power, cooling, and networking.

When you design for availability zones, check the latency between zones. Knowing the network latency between the zones of a region helps you choose availability zones that have the least network latency for cross-zone network traffic.

When you set up your availability zones, use zone-redundant services for your instances of ExpressRoute, [Azure VPN Gateway](/azure/vpn-gateway/about-zone-redundant-vnet-gateways), and [Application Gateway](/azure/application-gateway/overview-v2).

For more information about the availability zone architecture for SAP on Azure, see [SAP HA availability zones](/azure/virtual-machines/workloads/sap/sap-ha-availability-zones).

It is important to ensure all Azure resources used in your workload are set up with Zone-redundant or across availability zones for zonal components. In order to assist in the process assign [Azure Policy Initiative for Zone Resilience](/azure/governance/policy/samples/built-in-initiatives#resilience) to intermediate Management Group. This ensures “start resilient & stay resilient” approach. The Zone Resilient built-in policies aim to:

- Deliver clear and actionable information that assists in the design, planning, and automation of AZ-resilient deployments.
- Detect: Audit subscriptions for non-compliance of these policies.
- Prevent configurations using the Deny effect for resources that do not adhere to zone resiliency standards.

Compliance with this initiative can be checked at the end of the Implementation process. More information of the Azure Policy Initiative for Zone Resilience can be found here.

#### Azure NetApp Files and Azure Files

Azure NetApp Files and Azure Files with Network File System (NFS) and Server Message Block (SMB) provide high-availability file share requirements for SAP Central Services, a shared SAP mount, and a global transport directory.

To handle transport directory requirements, use the transport groups option as described in [Azure Virtual Machines planning and implementation for SAP NetWeaver](/azure/virtual-machines/workloads/sap/planning-guide). Another way to handle the transport requirements is to make one of the SAP tiers the primary production system that provides the transport directory share to other systems in the landscape.

The high-availability requirements for SAP Central Services differ depending on the operating system. For example:

- For a Linux operating system, the shared file systems are typically placed on high-availability NFS storage or Azure NetApp Files instances to provide a high-availability NFS share. For more information, see [NFS over Azure Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-nfs-azure-files) or [Azure NetApp Files](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files).

- For information about high availability on Windows, see [Azure Files with SMB](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-azure-files-smb) and [Azure NetApp Files with SMB](/azure/virtual-machines/workloads/sap/high-availability-guide-windows-netapp-files-smb).

Azure NetApp Files shares can host SAP HANA data and log files. Use this configuration for a HANA scale-out deployment model with standby nodes. Azure NetApp Files supports HANA scale-up or [HANA scale-out](/azure/virtual-machines/workloads/sap/sap-hana-scale-out-standby-netapp-files-suse) with standby nodes.

[Azure Files](/azure/storage/files/storage-files-introduction) provides two main types of endpoints for accessing Azure file shares:

- **Public endpoints** have a public IP address that can be accessed from anywhere in the world.

- **Private endpoints** are in a virtual network and have a private IP address within the address space of that virtual network.

The example SAP systems architecture uses [private endpoints](/azure/private-link/private-endpoint-overview) so that clients on a virtual network can access data over a [private link](/azure/private-link/private-link-overview), which improves security.

#### SAP BTP connectivity

Azure Private Link is now generally available. SAP Private Link Service currently supports connections from SAP BTP, the Cloud Foundry runtime, and other services on top of [Private Link resources](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/e8bc0c6440834a47a0ff57cb4efc0dc2.html?locale=en-US) for the most common load balancer plus virtual machine scenarios. Example scenarios include SAP S/4HANA or SAP ERP running on the virtual machine and connecting to Azure native services like [Azure Database for MySQL](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/5c70499ee70b415d954145a795e43355.html?locale=en-US).

The example architecture shows an SAP Private Link Service connection to BTP environments. SAP Private Link Service establishes a private connection between specific SAP BTP services and specific services in your infrastructure as service provider accounts. If you reuse the private link functionality, BTP services can access your S/4 HANA environment through private network connections, which avoids data transfer over the public internet.

For more information about scenarios for connecting to BTP services, see the SAP Community blog post about the [architecture effect of Private Link Service](https://blogs.sap.com/2021/07/27/btp-private-linky-swear-with-azure-how-many-pinkies-do-i-need/).

### Considerations

Take into account the following considerations when you design your landing zone.

#### Landscape consolidation

Consider setting up landscape consolidation for non-production systems like sandbox and development environments. For example, consider different use cases:

- HANA database scenarios typically run an application and a database in separate virtual machines.

- AnyDB scenarios might have two-tier deployments in which the SAP application and database run on the same virtual machine.

The components are separate in the example SAP systems architecture to provide greater flexibility for maintenance, sizing, monitoring, and change control. Choose a design based on your requirements.

#### Component information

The example architecture has components that you can use for day-2 operations. These components include an Azure Recovery Services vault to back up SAP systems and others that help you extend and improve your SAP data platform with cloud-native Azure data services.

Services like Azure Synapse Analytics, Azure Data Factory, and Azure Data Lake Storage can help you unlock business insights by combining SAP data with non-SAP data and creating an analytics platform. To evaluate solution development environment design, review the [best practices](/azure/synapse-analytics/guidance/implementation-success-evaluate-solution-development-environment-design). You can use different instances of Data Factory and Data Lake Storage based on the SAP tier and best practices for your environment design.

The Azure [integration runtime](/azure/data-factory/concepts-integration-runtime) is the compute infrastructure that Data Factory and Azure Synapse pipelines use to provide data integration capabilities. Consider deploying runtime virtual machines for these services in each tier. For examples of how to connect with SAP systems and deploy the Azure integration runtime, see these articles:

- [Set up a self-hosted integration runtime to use in the SAP CDC solution](/azure/data-factory/sap-change-data-capture-shir-preparation)

- [Copy data from SAP ECC](/azure/data-factory/connector-sap-ecc?tabs=data-factory)

- [Copy data from SAP HANA](/azure/data-factory/connector-sap-hana?tabs=data-factory)

- [Copy data from an SAP table](/azure/data-factory/connector-sap-table?tabs=data-factory)

- [Copy data from SAP Business Warehouse via Open Hub](/azure/data-factory/connector-sap-business-warehouse-open-hub)

For more information about all architecture components, see [SAP S/4HANA in Linux on Azure](/azure/architecture/reference-architectures/sap/sap-s4hana).

### SAP landscape architecture example with three SAP products

The following reference architecture is an extension of the high-level architecture that appears earlier in this article. The diagram describes an example use case with three SAP products. It shows just one of the options you can use to deploy SAP systems to Azure by using virtual machine scale sets.

Use this architecture as a starting point. Download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/sap-landscape-multiple-systems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

:::image type="content" source="./media/sap-landscape-multiple-sap-system-example.svg" border="false" alt-text="Diagram that shows an example use case with three SAP products." lightbox="./media/sap-landscape-multiple-sap-system-example.svg":::

#### Example workflow

SAP customers run various SAP products based on their specific use cases. The architecture diagram shows an example use case with three common SAP products. It illustrates an example SAP architecture that's spread across different tiers.

In the workflow diagram, *ERP* represents a legacy SAP ECC system or a next-generation SAP S/4HANA system. *BW* is SAP Business Warehouse. *PI/PO* refers to process integration or process orchestration. Different colors represent various SAP products as they appear in the workflow.

## Implementation

There are two implementation options.

### Option 1

The [SAP deployment automation framework on Azure](https://github.com/azure/sap-automation) is a collection of processes combined with a flexible workflow. The framework repository contains code to automatically deploy SAP landscapes on Azure. Templates are separated into the following categories.

- **Terraform on Azure modules.** Use Terraform modules to deploy infrastructure components on Azure, including:
  - Virtual machines
  - Network
  - Storage
- **Ansible playbooks.** Use Ansible playbooks to:
  - Set up and deploy virtual machines.
  - Install SAP HANA.
  - Install other required applications.

Deploy and install Ansible playbook components on your infrastructure by using Terraform on Azure modules.

:::image type="content" source="./media/overview-automation.png" border="false" alt-text="Diagram that shows an overview of an SAP reference implementation.":::

### Option 2

[Azure Center for SAP solutions](/azure/center-sap-solutions/overview) is a set of Azure services that provides a unified solution for deploying and managing SAP workloads by bringing services, tools, and frameworks together.

Virtual Instance for SAP solutions is the foundation of Azure Center for SAP solutions. You can use Virtual Instance for SAP solutions to create and manage SAP systems in a way that makes sense to you, at the SID level or at the individual component level.

You can use the Azure Center for SAP solutions to take the following steps:

1. Deploy. Choose how to deploy your SAP system on Azure.
1. Represent. Create a logical representation of each system as you deploy or register existing deployments.
1. Manage. Configure operations with management capabilities.

:::image type="content" source="./media/center-sap-solutions.png" border="false" alt-text="Diagram that describes how Azure Center for SAP solutions works.":::

Azure Center for SAP solutions provides these capabilities:

**Guided SAP deployment**

Azure Center for SAP solutions automates the deployment of SAP S/4HANA systems on Azure. It provides a guided solution for deploying the infrastructure and automatically installs S/4HANA software.

You provide minimal input and can choose the right type of deployment. The deployments are based on the latest best practices and reference architectures. You can get sizing recommendations to deploy the SAP system based on SAPS and database memory requirements. 

**Registration of existing SAP systems**

If you're already running SAP systems on Azure or are in the process of a migration, you can use Azure Center for SAP solutions to integrate your existing systems by using a simple registration process. This registration process is supported for SAP S/4HANA and NetWeaver ABAP systems that run on Linux and Windows.

**Intelligent SAP management**

Whether you're creating a new SAP system or registering an existing system, Azure Center for SAP solutions provides these benefits:

- Quality checks, integrated with Azure Advisor, so you know when infrastructure and operating system configurations deviate from documented best practices and standards. These checks can save time during troubleshooting and increase system quality by prompting you to act before the deviations cause problems.
- Ability to view SAP status and health across multiple SAP systems from a centralized tool. This capability enables you to quickly identify problems that affect SAP systems and their components.
- Ability to stop and start an SAP system directly from Azure.
- Ability to view post-deployment costs at the SAP SID level. 
- Integration with [Azure Monitor for SAP solutions](/azure/virtual-machines/workloads/sap/monitor-sap-on-azure). This integration provides technical monitoring and enables you to correlate the telemetry of the SAP system with the telemetry of the OS, DBMS, and underlying Azure infrastructure.
- Ability to search across your SAP systems based on an SID by using [Azure Resource Graph](/azure/governance/resource-graph/overview). This capability makes it easier to discover which Azure resources are part of the SAP landscape. Resource Graph is an Azure service that provides efficient resource exploration by enabling you to query at scale across subscriptions.

## Next steps

Review the following design areas for your SAP on Azure landing zone accelerator architecture:

- [Enterprise enrollment](eslz-enterprise-enrollment.md)
- [Identity and access management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Resource organization](eslz-resource-organization.md)
- [Governance](eslz-security-governance-and-compliance.md)
- [Operations baseline](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](eslz-platform-automation-and-devops.md)
