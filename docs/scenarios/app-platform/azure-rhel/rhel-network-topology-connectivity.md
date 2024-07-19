---
title: Network topology and connectivity considerations for Red Hat Enterprise Linux
description: Redhat Enterprise Linux Azure Landing Zone Accelerator - Guidance and considerations on Network Topology & Connectivity
author: humblejay, Paul Armstrong, and Mike Savage
ms.author: kupole
ms.date: 07/24/2024
ms.topic: conceptual
ms.custom: e2e-alz
---

# Network topology and connectivity considerations for Red Hat Enterprise Linux on Azure

This article describes Red Hat Enterprise Linux (RHEL) network considerations and recommendations that are based on the guidance in [Azure landing zone design area for network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

## Architecture

The RHEL reference architecture is a starting point and should be further adapted to meet your specific business and technical requirements. The various RHEL platform components and roles can be deployed on virtual machines with specific sizing and redundancy as needed. The network layout in these examples is simplified to demonstrate architectural principles and not intended to describe an entire enterprise network.

:::image type="content" source="images/rhel-landing-zone-architecture.png" alt-text="Diagram that shows a RHEL reference architecture." border="false" lightbox="images/rhel-landing-zone-architecture.png":::

*Download a [Visio file](azure-landing-zone-rhel-full-view.vsdx) of this architecture.*

|      Element         |                Description                 |
|:-------------:|:--------------------------------|
|  A | Components in the Microsoft Customer Agreement and billing |
|  B | Components in Microsoft Entra identity and access management |
|  C | Components in Azure management groups |
|  D | Components in Windows Server Active Directory identity management subscription |  
|  E | Components in network hub subscription |
|  F | Components in the RHEL Management and Identity subscription |
|  G | Components in the Azure Management Group subscription |
|  H | Components in the RHEL Production Workload subscription |  
|  I | Components on-premises |
|  J | Red Hat Cloud Services |

### Design considerations for RHEL landing zones networking

Consider the following recommendations for the landing zone networking design:

- We recommend that you use a hub-and-spoke network topology for single or multiregion deployments. [Azure Virtual WAN Hub](/azure/virtual-wan/virtual-wan-about) provides extra features. You can also use a traditional virtual network hub. For more information, see [Azure landing zone networking](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

- For Virtual WAN topologies, consider using Azure Firewall to route traffic across landing zones. Azure Firewall provides traffic filtering and logging capabilities.

- An Azure VPN gateway or an Azure ExpressRoute gateway controls hybrid connectivity to the hub. To monitor and control the traffic, use Azure Firewall or a virtual network appliance (NVA) in the hub.

- You can use an on-premises firewall to protect and route all ingress and egress internet traffic. A firewall might introduce latency for cloud-based resources. Understand your performance and security requirements to determine how you should route ingress and egress traffic.

:::image type="content" source="images/hybrid-regional-rhel-platform-landing-zone-network.png" alt-text="Diagram that shows a hybrid Azure region RHEL landing zone architecture." border="false" lightbox="images/hybrid-regional-rhel-platform-landing-zone-network.png":::

|     Element          |             Description                    |
|:-------------:|:--------------------------------|
|  A | Components in the Red Hat Management virtual network contained via the Red Hat Management subscription. |
|  B | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |
|  C | Components in the Identity Management virtual network contained via the Red Hat Identity Management subscription. |
|  D | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription. |
  
:::image type="content" source="images/simplified-rhel-networking.png" alt-text="Diagram that shows Management and Workload subnets in a zone-resilient configuration." border="false" lightbox="images/simplified-rhel-networking.png":::

|       Element        |               Description                  |
|:-------------:|:--------------------------------|
|  A | Components in the Red Hat Management virtual network contained via the Red Hat Management subscription |
|  B | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription |
|  C | Components in the Identity Management virtual network contained via the Red Hat Identity Management subscription |
|  D | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription |

- Use [private endpoints](/azure/private-link/private-endpoint-overview) for all supported Azure services to improve security. Private endpoints ensure that all traffic routes through your private networking rather than over public IP addresses.

- IP address scopes and virtual network size planning for the RHEL landing zone should consider dedicated subnets for application, database, and storage resources.
  
- Adopt a Zero Trust-based approach for your perimeter networking and traffic security. For more information, see [Network security strategies on Azure](/azure/well-architected/security/networking).

- Use network security groups (NSGs) to help protect traffic across subnets and east and west traffic across the platform (traffic between landing zones). [Azure Policy](/azure/networking/policy-reference) can make this configuration default for all subnets.

- Use NSGs and [application security groups](/azure/virtual-network/application-security-groups) to micro-segment traffic within the landing zone and avoid using a central NVA to filter traffic flows.

- Enable NSG flow logs and feed them into [traffic analytics](/azure/network-watcher/traffic-analytics). To optimize audit-ability and security, enable flow logs on all critical virtual networks and subnets in your subscription.

:::image type="content" source="images/nsg-segmentation.png" alt-text="Diagram that shows an NSG for traffic security." border="false" lightbox="images/nsg-segmentation.png":::

- Use NSGs to selectively allow connectivity between landing zones.

- The application team should use application security groups at the subnet-level NSGs to help protect multi-tier VMs within the landing zone.

- If your organization implements forced tunneling, or an advertised default route, to on-premises, consider incorporating outbound NSG rules to deny egress traffic from the virtual network directly to the internet. This configuration provides resiliency if the Border Gateway Protocol (BGP) session drops. For more information, see [Plan for landing zone network segmentation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation).

- Automate your deployments, configuration management, and day-2 operations for all landing zone network-related components through [infrastructure as code](/azure/well-architected/operational-excellence/infrastructure-as-code-design).

## Outbound options for enabling internet and filtering and inspecting traffic

- Outbound access to Red Hat Cloud via the hub network.
- On-premises default route should use on-premises internet access.
- Virtual WAN or traditional virtual network hub that's secured with Azure Firewall or an NVA.

## Inbound options for delivering content and applications

- Azure Application Gateway with L7, Transport Layer Security (TLS) termination, and Web Application Firewall.
- Dynamic Network Translation (DNAT) and load balancer from on-premises.
- Azure Virtual Network  with Azure Firewall or an NVA, and Azure Route Server in various scenarios.
- Virtual WAN hub with Azure Firewall, with L4 and DNAT.
- Virtual WAN hub with NVA in various scenarios.

## Domain name resolution for on-premises and Azure resources

The RHEL environment often uses both on-premises and Azure resources, which requires effective name resolution of resources. Consider the following recommendations:

- Azure provides a default internal name resolution within a virtual network. There's no configuration required for this scenario. You can't modify the domain name resolution (DNS) suffix or perform manual registration. For more information, see [Name resolution that Azure provides](/azure/virtual-machines/linux/azure-dns#name-resolution-that-azure-provides).

- For name resolution across virtual networks, RHEL deployments often use DNS services from Redhat Identity Management Server (IdM) or [Azure DNS](/azure/dns/dns-overview). To provide rule-based forwarding if needed, combine [Azure Private DNS Resolver](/azure/dns/dns-private-resolver-overview) and existing DNS infrastructure.

## Next step

Learn about deployment, management, and patching considerations for RHEL systems.
