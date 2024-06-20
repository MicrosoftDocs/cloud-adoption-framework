---
title: Network topology and connectivity considerations for Red Hat Enterprise Linux
description: Redhat Enterprise Linux Azure Landing Zone Accelerator - Guidance and considerations on Network Topology & Connectivity
author: humblejay
ms.author: kupole
ms.date: 04/05/2024
ms.topic: conceptual
ms.custom: e2e-alz
---

# In this article

- Overview
- Architecture
- Design considerations
- Next steps

## Overview

The Red Hat Enterprise Linux (RHEL) specific network topology builds on number of considerations and recommendations defined in Azure landing zone article [Azure landing zone design area for network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).



## Architecture

The RHEL reference architecture is a starting point and should be further adapted to specific business and technical requirements for the landing zone implementation. The various RHEL platform components and roles can be deployed on virtual machines with specific sizing and redundancy as needed.The network layout in these examples are simplified to demonstrate architectural principles and are not intended to describe an entire enterprise network.

![Diagram of RHEL reference architecture](images/rhel-landing-zone-architecture.png)
[Download the Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/azure-landing-zone-rhel-full-view.vsdx)

## Design considerations for RHEL Platform landing zones networking

During the design phase decisions will be made to adapt the architecture as per requirements and any constraints. The following questions can assist in the design process.

- What type of workload deployment is planned? Greenfield? Migration?
- Is the deployment for POC, Development or Testing with shorter timeline?
- Are there any business continuity requirements to consider during the migration?
- Are mature processes for operations, security and governance in place for this environment?

Following are some key considerations in the design.

- Hub & Spoke Network is recommended topology, multi-region deployment can take advantage of [Azure VWAN Hub](https://learn.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about) or use the traditional Virtual Network as Hub per region. Refer [Azure Landing Zone Networking](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) for more details.

- For Virtual WAN topologies, route traffic across landing zones via Azure Firewall if your organization requires filtering and logging capabilities for traffic flowing across landing zones.

- Hybrid connectivity to the Hub will be using Azure VPN Gateway or Express route circuit with bi-directional traffic control & monitoring using Azure Firewall or 3rd party Network appliances in the Hub. 
	
- RHEL Landing Zone, RHEL Management & Identity Services are separate Virtual Network for segmentation and in their own dedicated subscriptions. 

  >![Hybrid Azure Region RHEL Landing Zone Architecture](images/hybrid-regional-rhel-platform-landing-zone-network.png)


|                                     |                                                                 |   
|:--------------------------------------------------:|:-----------------------------------------------------------------------|
| 
| Element A | Components in the Azure Region 1 Hub VNet contained via the Hub Region 1 subscription.|
| Element B | Components in the Red Hat Management VNet contained via the Red Hat Management subscription.|
| Element C | Components in the Identity Management VNet contained via the Red Hat Identity Management subscription.|  
  

- IP address and Virtual Network size for RHEL Landing Zone should consider dedicated subnets for application, database and storage. 

- Zero-trust-based network for perimeter and traffic security. For more information see [Network security strategies on Azure](https://learn.microsoft.com/en-us/azure/well-architected/security/networking)

  >![Management and Workload in Zone Resilient Configuration](images/simplified-rhel-networking.png)

|               |                                 |   
|:-------------:|:--------------------------------|
| Element A | Components in the Red Hat Management VNet contained via the Red Hat Management subscription. |
| Element B | Components in the RHEL Workloads VNet contained via the RHEL Production Workloads subscription. |

- Use NSGs to help protect traffic across subnets, as well as east/west traffic across the platform (traffic between landing zones). The platform team can utilize Azure Policy to ensure this is implemented by default on all subnets.

- Use NSGs and application security groups to micro-segment traffic within the landing zone and avoid using a central Network Virtualization Appliance (NVA) to filter traffic flows.

- Enable NSG flow logs and feed them into [Traffic Analytics](https://learn.microsoft.com/en-us/azure/network-watcher/traffic-analytics) to gain insights into internal and external traffic flows. Flow logs should be enabled on all critical VNets/subnets in your subscription as an audit-ability and security best practice.

  >![Use of NSG for traffic security](images/nsg-segmentation.png)

- Use NSGs to selectively allow connectivity between landing zones.

- The application team should use application security groups at the subnet-level NSGs to help protect multi-tier VMs within the landing zone.


- If your organization decides to implement forced tunneling (advertise default route) to on-premises, we recommend incorporating outbound NSG rules to deny egress traffic from VNets directly to the internet should the BGP session drop. See [Plan for landing zone network segmentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation) for more information.

- Implement automation and Configuration as Code for deployment, configuration, and day-2 operation of all landing zone network-related components.


## Outbound options for enabling internet and filtering and inspecting traffic

- Outbound access to Red Hat Cloud via Hub
- On-premises default route should use on-premises internet access
- Virtual WAN or traditional Virtual Network Hub secured with Azure Firewall or 3rd party Network Virtual Appliance (NVA)

## Inbound options for delivering content and applications

-Azure Application Gateway with L7, Secure Sockets Layer (SSL) termination, and Web Application Firewall.
- DNAT and load balancer from on-premises.
- Azure Virtual Network  with Azure Firewall or 3rd party NVA, and Azure Route Server in various scenarios.
- Virtual WAN secured hub with Azure Firewall, with L4 and DNAT.
- Virtual WAN secured hub with NVA in various scenarios.

## Domain name resolution for on-premises and Azure resources

Redhat Enterprise environment will utilize both On-Premises & Azure Resources which makes name resolution an important area.  The following considerations will help in this design area.

- Azure provides internal name resolution within a virtual network, no configuration is required to use this.  Do note, the DNS suffix cannot be modified and manual registration is not possible.  Refer  [Name resolution that Azure Provides](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/azure-dns?tabs=ubuntu#name-resolution-that-azure-provides) for more details. 

- Name resolution across virtual networks, common with RHEL deployment will be use of DNS in  enabled on Redhat Identity Management Server (IDm) or [Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-overview).  Combination of [Azure Private DNS Resolver](https://learn.microsoft.com/en-us/azure/dns/dns-private-resolver-overview) and existing DNS infrastructure can utilize rule base forwarding if needed. 


## Next Steps

Learn about deployment, management, and patching considerations for Red Hat Enterprise Linux systems

