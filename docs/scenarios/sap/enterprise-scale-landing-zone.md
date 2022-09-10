---
title: SAP on Azure landing zone accelerator
description: Learn about SAP on Azure landing zone accelerator.
author: JefferyMitchell
ms.author: brblanch
ms.date: 09/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP on Azure landing zone accelerator

SAP on Azure landing zone accelerator lets you set up and operate platform workload landing zones within the Cloud Adoption Framework enterprise-scale landing zone. SAP on Azure landing zone accelerator provides a specific architectural approach and reference implementation. Use SAP on Azure landing zone accelerator after you successfully implement an enterprise-scale landing zone. Review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before you deploy SAP on Azure landing zone accelerator.

## Adopt SAP on Azure landing zone accelerator

Architecture for SAP on Azure landing zone accelerator varies by customer. Technical considerations and design recommendations lead to trade-offs based on each organization's particular scenario. Follow the core recommendations to find an architecture that sets your organization on a path to sustainable scaling. SAP on Azure landing zone accelerator is modular by design and you can customize environmental variables. This approach to landing zones includes the following assets to support your cloud teams:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

You must make crucial decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. Consider the following six critical design areas:

- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

The following diagram of a conceptual reference architecture shows the critical design areas:

:::image type="content" source="./media/overview-architecture.png" alt-text="A diagram depicting the SAP on Azure landing zone accelerator conceptual reference architecture." lightbox="./media/overview-architecture.png":::


## SAP system high-level architecture
 
The following diagram shows reference architecture with an overall SAP system landscape that includes production and non-production systems. This architecture is just one of your options for deploying SAP systems on Azure using availability sets configuration.

Use the architecture here as a starting point. Download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/sap/media/sap-landscape-multiplesystems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when planning your landing zone implementation.

:::image type="content" source="./media/sap-landscape-hla.png" alt-text="A diagram showing high-level architecture of an SAP system landscape on Azure with production and non-production systems." lightbox="./media/sap-landscape-hla.png":::

**Workflow:**

The reference architecture includes an SAP system landscape with production and non-production systems that deploys with virtual machines. You can change the sizes and numbers of virtual machines to accommodate your organization's needs. The intent of this article is to show high-level, overall SAP architecture across different tiers.

> [!NOTE]
> There are multiple options to deploy SAP systems into Azure depending on a customer’s requirements. This section describes just one of the options to deploy SAP systems into Azure using availability sets configuration. The network layout here is greatly simplified to demonstrate architectural principles and isn't intended to describe a full enterprise network.

**Recommendations:**

Your deployment will differ based on your business requirements. Consider these recommendations as a starting point.

**Subscriptions:**

The architecture uses the following three subscriptions:

   - Azure Hub Subscription where the Hub vnet exists for the primary and secondary regions.

   - Azure SAP Production Subscription where the production systems and disaster recovery systems are configured.

   - Azure SAP Non-Prod Subscription  with a non-production system that includes sandbox, development, quality assurance, or pre-production systems. This configuration is optional and you can use a subscription for each workload zone.


**Networking:**

This architecture uses a hub-spoke topology, where the hub vnet acts as a central point of connectivity to an on-premises network. The spokes are an SAP vnet that peer with the hub. You can use the spokes to isolate workloads. This architecture uses one SAP vnet per workload zone, meaning a different SAP vnet for production, development, quality assurance, and the sandbox. In the Architecture, you peer the Hub vnet with production, development, quality assurance, and the sandbox vnet. Traffic flows between the on-premises datacenter and the hub through a gateway connection.

  > [!NOTE]
> Consider configuring S2S VPN as a backup of ExpressRoute or for any third-party route requirements. For more information, see [Use S2S VPN as a backup for ExpressRoute private peering](/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering).


**Subnets and NSGs:**

The architecture subdivides the vnet address space into subnets. You can associate each subnet with an NSG that defines the access policies for the subnet. Place application servers on a separate subnet so you can secure them more easily by managing the subnet security policies, rather than the individual servers. When associated with a subnet, an NSG applies to all the servers within the subnet and offers fine-grained control over the servers. 

In this architecture, there are three or four Subnets depending on the tier. An Example for the production systems is four Subnets 

   - NetApp Subnet – [A delegated Subnet](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) when using ANF for different SAP on Azure Scenarios. 

   - Application Gateway Subnet -  Handles the traffic coming from the Internet, for example, the Fiori Apps.

   - SAP Application Subnet - SAP application servers, SAP Central Services / Enqueue replication services Instances and Web Dispatchers. 

   - Database Subnet - For the Database Virtual Machines.
   
 **Note:** - The architecture shows explicit definition of Web Dispatchers in a separate availability set. The Web Dispatcher component is used as a load balancer for SAP traffic among the SAP application servers. To achieve [high availability of the SAP Web Dispatcher](https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-US/48/9a9a6b48c673e8e10000000a42189b/frameset.htm), Azure Internal Load Balancer implements either the failover cluster or the parallel Web Dispatcher setup. For internet facing communications a stand-alone solution in DMZ would be the recommended architecture to satisfy security concerns. [Embedded Web Dispatcher on ASCS](https://help.sap.com/docs/SLTOOLSET/00b4e4853ef3494da20ebcaceb181d5e/2e708e2d42134b4baabdfeae953b24c5.html?locale=en-US&version=CURRENT_VERSION) is a special option, proper sizing due to other workload on ASCS should be taken into account.


**Virtual machines and availability sets:**  

For all pools and clusters (Web Dispatcher, SAP application servers, Central Services, and HANA) the virtual machines are grouped into separate availability sets. There's no cost for the availability set. You only pay for each VM instance that you create.

**Virtual machines and availability zones:**

An Azure Availability Zone is defined as: "Unique physical locations within a region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking". When designing for availability zones, check the latency between zones. Knowing the network latency between the zones of a region is going to enable you to choose the zones with the least network latency in cross-zone network traffic. For Availability Zone configuration, use zone redundant services for [ExpressRoute/VPN Gateways](https://docs.microsoft.com/en-us/azure/vpn-gateway/about-zone-redundant-vnet-gateways) and [Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/overview-v2). 

For more information, see [SAP HA availability zones](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/sap-ha-availability-zones) to gain deeper understanding on Availability Zone Architecture for SAP on Azure. 

**Azure NetApp Files and Azure Files:**

Azure NetApp Files and Azure files with NFS/SMB provides high availability file share requirements for SAP Central services, shared SAP Mount, and global transport directory.

To handle the transport directory requirements, create the transport groups option as described in the [Azure Virtual Machines planning and implementation for SAP NetWeaver](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/planning-guide) article. Another way to handle the transport requirements is to make one of the SAP tiers the main production system that provides transport directory share to other systems in the landscape. 

The high availability requirements for SAP Central Services differ based on the operating system. For example: 

   - For the Linux operating system, the shared file systems are typically placed on high availability NFS storage or NetApp files to provide a high-availability NFS share. For more information, see [NFS over Azure files](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/high-availability-guide-suse-nfs-azure-files) or [Azure NetApp files](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files).

   - For Windows operating system, see [Azure Files with SMB](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/high-availability-guide-windows-azure-files-smb) and [Azure NetApp Files SMB](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/high-availability-guide-windows-netapp-files-smb).

Azure NetApp Files shares can host the SAP HANA data and log files. This configuration enables the HANA scale-out deployment model with standby nodes. ANF Supports HANA Scale-up or [HANA Scale-out](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/sap-hana-scale-out-standby-netapp-files-suse) with Standby node.

[Azure Files](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction) provides two main types of endpoints for accessing Azure file shares:

   - Public endpoints, which have a public IP address and can be accessed from anywhere in the world.

   - Private endpoints, which exist within a virtual network and have a private IP address from within the address space of that virtual network.

  The architecture uses [Private Endpoints](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) to let clients on a virtual network (Vnet) and securely access data over a [Private Link](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview). 


**BTP Connectivity:** 

Azure Private Link service is now Generally Available (GA). SAP Private Link service currently supports connections from SAP BTP, Cloud Foundry runtime, and other services on top of [Azure Private Link resources](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/e8bc0c6440834a47a0ff57cb4efc0dc2.html?locale=en-US) for the most common load balancer + VM scenario with for example, SAP S/4HANA or SAP ERP running on the VM, and the scenario of connecting to Azure native services, in particular to:

   - [Azure Database for MariaDB](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/862fa2958c574c3cbfa12a927ce1d5fe.html?locale=en-US)

   - [Azure Database for MySQL](https://help.sap.com/docs/PRIVATE_LINK/42acd88cb4134ba2a7d3e0e62c9fe6cf/5c70499ee70b415d954145a795e43355.html?locale=en-US)

The architecture depicts SAP private link service connection to BTP environments. SAP Private Link service establishes a private connection between selected SAP BTP services and selected services in your own IaaS provider accounts. Reusing the private link functionality lets BTP services access your S/4 HANA environment through private network connections, which avoids data transfer via the public Internet. For more information on different scenarios for connection to BTP services, see the [SAP Community blog post on the Architecture impact of Private Link Service](https://blogs.sap.com/2021/07/27/btp-private-linky-swear-with-azure-how-many-pinkies-do-i-need/). 


**Considerations:** 

**Landscape consolidation:**

Consider setting up landscape consolidation for the non-production systems, for example, sandbox and development environments. See different use cases 

  - HANA DB scenarios generally run App and DB in separate VMs.

  - AnyDB scenarios could have two-tier deployments where SAP App and DB are running in the Same VM. 

  You might choose to design based on different customer requirements. The components are separate in the architecture to provide greater flexibility for maintenance, sizing, monitoring, and change control. 

**Component Information:**

The architecture also mentions components you can use for day two operations. The components include Recovery Services Vault to back up SAP systems, and others that help customers extend and improve their SAP Data platform with cloud native Azure data services. Azure services like Synapse, data factory, and data lake help customers unlock business insights by combining SAP Data with non-SAP Data and creating the analytics platform. To evaluate solution development environment design, see the [best practices](https://docs.microsoft.com/en-us/azure/synapse-analytics/guidance/implementation-success-evaluate-solution-development-environment-design). There are different instances of data factory and data lake based on SAP Tier and best practices for environment design. 

[The Integration Runtime (IR)](https://docs.microsoft.com/en-us/azure/data-factory/concepts-integration-runtime) is the compute infrastructure that Azure Data Factory and Azure Synapse pipelines use to provide data integration capabilities. Consider the deployment of runtime Virtual Machines for these services per Tier. Refer to the examples of different ways to connect with SAP systems and how to deploy Integration Runtime. 

   -	[SAP change data capture solution (Preview) - SHIR preparation - Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/sap-change-data-capture-shir-preparation)

   -	[Copy data from SAP ECC - Azure Data Factory and Azure Synapse](https://docs.microsoft.com/en-us/azure/data-factory/connector-sap-ecc?tabs=data-factory)

   -	[Copy data from SAP HANA - Azure Data Factory and Azure Synapse](https://docs.microsoft.com/en-us/azure/data-factory/connector-sap-hana?tabs=data-factory)

   -	[Copy data from an SAP table - Azure Data Factory and Azure Synapse] (https://docs.microsoft.com/en-us/azure/data-factory/connector-sap-table?tabs=data-factory)

   -	[Copy data from SAP Business Warehouse via Open Hub - Azure Data Factory and Azure Synapse](https://docs.microsoft.com/en-us/azure/data-factory/connector-sap-business-warehouse-open-hub)

To gain deeper understanding of all the components in the architecture, see the [SAP S/4HANA in Linux on Azure](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/sap/sap-s4hana) article.

## SAP landscape architecture - three SAP products

The following diagram is reference architecture that describes an example use case of three SAP products and is an extension of the high-level architecture. This diagram shows one of the options to deploy SAP systems into Azure using Availability Sets Configuration.

Use this architecture as a starting point. Download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/sap/media/sap-landscape-multiplesystems-ref-architecture.vsdx) and modify it to fit your specific business and technical requirements when planning your landing zone implementation.

:::image type="content" source="./media/sap-landscape-multiple-sap-system-example.png" alt-text="A diagram depicting an example use case of three SAP products." lightbox="./media/sap-landscape-multiple-sap-system-example.png":::


**Workflow:**
SAP customers run various SAP products based on different industry use case. This architecture diagram is showcasing an example use case where it narrates three commonly used SAP products. The intention is to illustrate an overall SAP architecture across different tiers and beyond Single SAP SID. 

ERP represents legacy ECC system or next generation SAP S/4 HANA system, BW is SAP Business Warehouse and PI/PO is Process Integration or Process Orchestration. Different colors have been used to illustrate various SAP products. 

The architecture is an extension of High Level architecture portraying SAP Production and Non-Production systems with an example of three SAP products. Consider these recommendations as a starting point. 


## Implementation

The **SAP on Azure deployment automation framework** is a collection of processes combined with a flexible workflow. The [SAP deployment automation framework repository](https://github.com/Azure/sap-hana) contains code for automatic deployment of SAP landscapes in the Azure cloud. Templates are split into the following categories:

- Terraform modules that deploy infrastructure components in Azure include:
  - VMs
  - Network
  - Storage
- Ansible playbooks that let you:
  - Set up and deploy VMs
  - Install SAP HANA
  - Install other required applications

Deploy and install Ansible playbook components on the infrastructure that the Terraform modules build.

![Diagram showing an overview of a SAP reference implementation.](./media/overview-automation.png)

## Next steps

Review the design areas of SAP on Azure landing zone accelerator that provide considerations and recommendations for your SAP on Azure landing zone accelerator architecture.

- [Identity and access management](./eslz-identity-and-access-management.md)
