---
title: Network topology and connectivity considerations for Red Hat Enterprise Linux
description: Redhat Enterprise Linux Azure Landing Zone Accelerator - Guidance and considerations on Network Topology & Connectivity
author: humblejay
ms.author: kupole
ms.date: 04/05/2024
ms.topic: conceptual
ms.custom: e2e-alz
---

## Overview

The Red Hat Enterprise Linux (RHEL) network considerations and recommendations are based on Azure landing zone article [Azure landing zone design area for network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

## Architecture

The RHEL reference architecture is a starting point and should be further adapted to specific business and technical requirements for the landing zone implementation. The various RHEL platform components and roles can be deployed on virtual machines with specific sizing and redundancy as needed. The network layout in these examples is simplified to demonstrate architectural principles and not intended to describe an entire enterprise network.

![Diagram of RHEL reference architecture](images/rhel-landing-zone-architecture.png)
[Download the Visio file](azure-landing-zone-rhel-full-view.vsdx)

|               |                                 |
|:-------------:|:--------------------------------|
| Element A | Components in the Microsoft Customer Agreement and Billing. |
| Element B | Components in Microsoft Entra Identity and Access Management. |
| Element C | Components in Azure Management Groups. |
| Element D | Components in Active Directory Identity Management Subscription. |  
| Element E | Components in Network Hub Subscription. |
| Element F | Components in the RHEL Management and Identity subscription. |
| Element G | Components in the Azure Management Group Subscription. |
| Element H | Components in the RHEL Production Workload subscription. |  
| Element I | Components on-premises. |
| Element J | Red Hat Cloud Services. |

## Design considerations for RHEL Platform landing zones networking

Following are some key considerations in the design.

- Hub & Spoke Network is recommended topology within a region. A Multi-region deployment [Azure Virtual WAN Hub](https://learn.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about) can provide extra features or a traditional Virtual Network Hub can be used. For more information, see the article [Azure Landing Zone Networking](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

- For Virtual WAN topologies, route traffic across landing zones using Azure Firewall if your organization requires filtering and logging capabilities.

- Hybrid connectivity to the Hub implemented with Azure VPN Gateway or Express route circuit. The traffic can be monitored and controlled with Azure Firewall or a Network appliance in the Hub.

- On premises Firewall can be used for traffic to and from cloud, avoid hair-pinning all cloud traffic through on premises Firewall.

  >![Hybrid Azure Region RHEL Landing Zone Architecture](images/hybrid-regional-rhel-platform-landing-zone-network.png)

|               |                                 |
|:-------------:|:--------------------------------|
| Element A | Components in the Red Hat Management virtual network contained via the Red Hat Management subscription. |
| Element B | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |
| Element C | Components in the Identity Management virtual network contained via the Red Hat Identity Management subscription. |
| Element D | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |
  
- IP address and Virtual Network size for RHEL Landing Zone should consider dedicated subnets for application, database, and storage.

  >![Management and Workload in Zone Resilient Configuration](images/simplified-rhel-networking.png)

|               |                                 |
|:-------------:|:--------------------------------|
| Element A | Components in the Red Hat Management virtual network contained via the Red Hat Management subscription. |
| Element B | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |
| Element C | Components in the Identity Management virtual network contained via the Red Hat Identity Management subscription. |
| Element D | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |

- Utilize private endpoints for all Azure services supporting the feature to improve security.

- IP address and Virtual Network size for RHEL Landing Zone should consider dedicated subnets for application, database, or storage.

- Zero-trust-based network for perimeter, and traffic security. For more information about this article, see [Network security strategies on Azure](https://learn.microsoft.com/en-us/azure/well-architected/security/networking)

- Use Network Security Groups (NSGs) to help protect traffic across subnets and east/west traffic across the platform (traffic between landing zones). Azure Policy can make it default for all subnets.

- Use NSGs and application security groups to micro-segment traffic within the landing zone and avoid using a central Network Virtualization Appliance (NVA) to filter traffic flows.

- Enable NSG flow logs and feed them into [Traffic Analytics](https://learn.microsoft.com/en-us/azure/network-watcher/traffic-analytics). Flow logs should be enabled on all critical VNets/subnets in your subscription as an audit-ability and security best practice.

  >![Use of NSG for traffic security](images/nsg-segmentation.png)

- Use NSGs to selectively allow connectivity between landing zones.

- The application team should use application security groups at the subnet-level NSGs to help protect multi-tier VMs within the landing zone.

- If your organization decides to implement forced tunneling (advertise default route) to on-premises, we recommend incorporating outbound NSG rules to deny egress traffic from virtual network directly to the internet, in case the Border Gateway Protocol (BGP) session drops. For more information, see the article [Plan for landing zone network segmentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation).

- Implement automation and Configuration as Code for deployment, configuration, and day-2 operation of all landing zone network-related components.

## Outbound options for enabling internet and filtering and inspecting traffic

- Outbound access to Red Hat Cloud via Hub
- On-premises default route should use on-premises internet access
- Virtual WAN or traditional Virtual Network Hub secured with Azure Firewall or Network Virtual Appliance (NVA)

## Inbound options for delivering content and applications

- Azure Application Gateway with L7, Transport Layer Security (TLS) termination, and Web Application Firewall.
- Dynamic Network Translation (DNAT) and load balancer from on-premises.
- Azure Virtual Network  with Azure Firewall or NVA, and Azure Route Server in various scenarios.
- Virtual WAN hub with Azure Firewall, with L4 and DNAT.
- Virtual WAN hub with NVA in various scenarios.

## Domain Name Resolution for on-premises and Azure Resources

Redhat Enterprise environment often uses both on-premises & Azure Resources requiring effective name resolution of resources. The following recommendations should be considered.

- Azure provides a default internal name resolution within a virtual network. There's no configuration required. Do note, the Domain Name Resolution (DNS) suffix can't be modified and manual registration isn't possible. For more information, see the article [Name resolution that Azure Provides](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/azure-dns?tabs=ubuntu#name-resolution-that-azure-provides).

- Name resolution across virtual networks, RHEL deployment often uses DNS within the Redhat Identity Management Server (IDm) or [Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-overview). Combination of [Azure Private DNS Resolver](https://learn.microsoft.com/en-us/azure/dns/dns-private-resolver-overview) and existing DNS infrastructure can utilize rule base forwarding if needed.

## Next Steps

Learn about deployment, management, and patching considerations for Red Hat Enterprise Linux systems
