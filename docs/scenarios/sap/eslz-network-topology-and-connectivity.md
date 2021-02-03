---
title: "Enterprise-Scale network topology and connectivity for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve network topology and connectivity of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network topology and connectivity
This article examines key design considerations and recommendations surrounding networking and connectivity for SAP Deployments and within, to and from Microsoft Azure.

## Plan for IP Addressing
It's vital that your organization plans for IP addressing in Azure to ensure that IP address space doesn't overlap across on-premises locations and Azure regions, but also, to ensure that the right address space within the VNet, as well as proper planning for subnet configuration is planned in advance. Considerations for Enterprise scale networking have been made in the SAP on Azure Construction Set, review the below architecture.

 ![Sap on Azure Construction Set](media/ntc_arch.jpg)

### Design considerations for SAP Implementations:
Dedicated and Delegated Subnets: You can dedicate and delegate subnets to certain services to create instances of a service within the subnet. Azure enables you to create multiple delegated subnets in a VNet., However you can have only a single delegated subnet in a VNet for Azure Netapp files. Any attempts to create a new volume will fail if you use more than one delegated subnet for Azure NetApp Files.

### Use Case:

- Delegated subnets are required for Azure NetApp files implementations which is popular in SAP deployments for shared file systems.
- In the SAP scenarios where the Azure App Gateway is used, like SAP Fiori Launchpad load balancing or load balancing SAP Web Application Server (SAP BOBI) it is required to have a delegated subnet for Azure Application Gateway only.

## Configure DNS and name resolution for on-premises and Azure resources
Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

### Design Recommendations for SAP implementations
Recommendation will be for not changing the DNS names / Virtual names for a VM while Migration.

### Use Case:
- In SAP landscape many system interfaces are connected using the DNS names and virtual names in the background. Not in all the cases, customers are aware of all the interfaces defined over the years by developers. After the migration if the Virtual names or DNS names changes, this poses challenges while connection of various systems. In this type of cases, we recommend maintaining the aliases in DNS to avoid difficulties after migration.
- Use different DNS Zones for each environment (sandbox, dev, pre-production and production), to ensure each environment is separate from each other.
- Exception will be if SAP deployments have their own VNET then private DNS zones may not be a necessity.

## Define an Azure Network Topology 
Enterprise-Scale landing Zones supports two different network technologies: VWAN-based and traditional network topology based on the hub and spoke architecture. This section describes the recommended SAP configuration and practices for each of these deployment models. 

Use a network topology based on Azure Virtual WAN if any of the following are true:
- Your organization intends to deploy resources across several Azure regions and needs to connect your global locations to both Azure and on-premises.
- Your organization intends to use software-defined WAN (SD-WAN) deployments fully integrated with Azure.
- You intend to deploy up to 2,000 virtual machine workloads across all VNets connected to a single Azure Virtual WAN hub.

Virtual WAN is used to meet large-scale interconnectivity requirements. Because it's a Microsoft-managed service, it also reduces overall network complexity and helps to modernize your organization's network.

Use a traditional Azure network topology based on the hub and spoke architecture if any of the following are true:
- Your organization intends to deploy resources in only a few Azure regions.
- You don't need a global interconnected network.
- You have a low number of remote or branch locations per region. That is, you need fewer than 30 IP security (IPsec) tunnels.
- You require full control and granularity for manually configuring your Azure network.

## Design recommendations for SAP Implementations:
- For SAP deployments we recommend Virtual WAN for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. That way, you don't have to manually set up transitive routing for Azure networking. This helps to stick to standard of SAP on Azure deployments.
- Deploying NVA between regions – Can be considered only if the partner NVAs are used. If there are native NVAs then its not required to have NVAs between regions or between VNETs. When you're deploying partner networking technologies and NVAs, follow the partner vendor's guidance to ensure there are no conflicting configurations with Azure networking.
- For Virtual WAN based topologies, connectivity between spoke VNets is managed by the VWAN (there is no need to setup UDRs or NVAs), and maximum network throughput for VNet to VNet traffic in the same Virtual Hub is 50 Gbps. SAP Landing zone could be connected directly to other landing zones via VNet peering to overcome this bandwidth limitation (if required). 
- It is not supported to deploy any NVA between SAP application and SAP Database server. 
- Ensure where there is connectivity between landing zones for SAP deployments across multiple Azure regions. VNET / Global VNET peering provides connectivity and is always preferred communication path. 

## Plan for Inbound and Outbound Internet Connectivity
This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.
Azure-native network security services such as Azure Firewall, Azure Web Application Firewall (WAF) on Azure Application Gateway, and Azure Front Door Service are fully managed services. So, you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale.

### Design Recommendations for SAP Implementations:
- For SAP deployments use of Azure Front Door services provide a good experience for WAF and Internet facing application. Use Azure Front Door Service with WAF policies to deliver and help protect global HTTP/S apps that span Azure regions. This can be very good option for enterprise customers having global footprints. For more information on Azure front door refer: https://docs.microsoft.com/en-us/azure/frontdoor/front-door-overview
- When you're using Azure Front Door Service and Azure Application Gateway to help protect HTTP/S apps, use WAF policies in Azure Front Door Service. Lock down Azure Application Gateway to receive traffic only from Azure Front Door Service.
- When using Azure Application Gateway as a reverse proxy for SAP web apps, AAG + WAF have limitations as shown in the picture (comparison between AAG, SAP Web Dispatcher and 3rd Party such as Netscaler). AAG does not have intelligence of SAP appliations like WD or Netscaler. Extensive testing necessary if replacing WD with AAG. Verify latest status and possibly list all supported and not supported (or tested/not tested) scenarios. 
- When the traffic is exposed to the internet its recommended to use a Web Application Firewall (WAF) to scan your traffic or on top of your load balancer or resources which has in built firewall capabilities like Azure application Application gateway Gateway or third party solutions.
- Use Azure private link for securely and privately access to your PaaS resources like blob storage, Files, Data Lake Gen 2, ADF etc to protect data leakage. You can also use private end point to secure your traffic between VNET and service like Azure Storage, Azure Backup etc. Traffic between your virtual network and the private endpoint enabled service traverses over the Microsoft backbone network, eliminating exposure from the public Internet.

## Define Network Encryption Requirements
This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.

### Design considerations for SAP Implementations:
- When you're using ExpressRoute with private peering, traffic isn't currently encrypted.
- For SAP deployments it’s not necessary to encrypt the traffic over ExpressRoute. SAP traffic is usually heavy in bandwidth consumption and sensitive to performance. Encryption and decryption might have inverse effects on performance. Traffic is encrypted over the internet via IPsec tunnels by default.
- However, it is on customer’s requirement if the SAP traffic needs to be encrypted or not. Refer the following article for network encryption options in Enterprise-Scale Landing Zones: https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity#define-network-encryption-requirements

## Segregation of Systems:
In a typical SAP scenario, we have different types of landscapes like Dev, test, quality, pre-production, production etc. Due to security and compliance reasons customers usually like to segregate these systems in logical/physical constructs. This segregation can be done on various level like subscription or resource group level. The idea is to maintain all the systems having the same lifecycle in the one common resource group. One should also keep in my mind the security and policy structure while grouping the resources in the SAP landscape.
However, to SAP transports to flow between different dev, test, quality and production, we might need to have:
- VNET peering and associated costs
- Firewall port openings between VNETS
- UDR and NSG rules
- It is not recommended at all to host DBMS layer and application layer of SAP systems in different VNets and connect them with VNet peering due to substantial costs that can be generated based on the excessive network traffic between the SAP application layer and DBMS layer 

## Additional Recommendations:
- Placement of the SAP application layer and SAP DBMS in different Azure virtual networks that aren't peered isn't supported.
- You can use application security group and network security group rules to define network security ACLs between the SAP application layer and the SAP DBMS layer. Application Security Groups helps to manage the security of Virtual Machines by grouping them.
- Make sure that Azure Accelerated Networking is enabled on the VMs used in the SAP application layer and the SAP DBMS layer. Keep in mind that different OS levels are needed to support Accelerated Networking in Azure:
  - Windows Server 2012 R2 or later.
  - SUSE Linux 12 SP3 or later.
  - RHEL 7.4 or later.
  - Oracle Linux 7.5. If you're using the RHCKL kernel, release 3.10.0-862.13.1.el7 is required. If you're using the Oracle UEK kernel, release 5 is required.
- Make sure Standard ILB Internal Load Balancer (ILB) deployments are set up to use Direct Server Return (DSR). This setting will reduce latency when Azure ILBs are used for high availability configurations on the DBMS layer.
- If you're using Azure Load Balancer together with Linux guest operating systems, check that the Linux network parameter net.ipv4.tcp_timestamps is set to 0. 
- Consider using Azure proximity placement groups to get optimal network latency. For more information, see Azure proximity placement groups for optimal network latency with SAP applications.
- Checkout SAP support note: https://launchpad.support.sap.com/#/notes/2931465 
