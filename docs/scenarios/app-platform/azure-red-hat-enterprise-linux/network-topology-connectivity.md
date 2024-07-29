---
title: Network topology and connectivity considerations for Red Hat Enterprise Linux
description: Learn about key design considerations and recommendations for network topology and connectivity in RHEL on Azure infrastructure.
author: parmstro
ms.author: kupole
ms.date: 07/24/2024
ms.topic: conceptual
ms.custom: e2e-alz
---

# Network topology and connectivity considerations for Red Hat Enterprise Linux on Azure

This article describes Red Hat Enterprise Linux (RHEL) network considerations and recommendations that are based on the guidance in [Azure landing zone design area for network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

## Architecture

The following RHEL architecture is a starting point that you can further adapt to meet your specific business and technical requirements. You can deploy the various RHEL platform components and roles on virtual machines (VMs) with specific sizing and redundancy as needed. The simplified network layout in these examples demonstrates architectural principles and doesn't describe an entire enterprise network.

:::image type="content" source="images/network-topology-connectivity/landing-zone-architecture.png" alt-text="Diagram that shows a RHEL reference architecture." border="false" lightbox="images/network-topology-connectivity/landing-zone-architecture.png":::

*Download a [Visio file](https://github.com/Microsoft/CloudAdoptionFramework/tree/main/scenarios/app-platform/azure-rhel/azure-landing-zone-rhel-full-view.vsdx) of this architecture.*

|      Element         |                Description                 |
|:-------------:|:--------------------------------|
|  A | Components in the Microsoft Customer Agreement and billing |
|  B | Components in Microsoft Entra identity and access management |
|  C | Components in Azure management groups |
|  D | Components in the Windows Server Active Directory identity management subscription |  
|  E | Components in the network hub subscription |
|  F | Components in the RHEL Management and Identity subscription |
|  G | Components in the Azure Management Group subscription |
|  H | Components in the RHEL Production Workload subscription |  
|  I | Components on-premises |
|  J | Red Hat Cloud Services |

### Design considerations for RHEL landing zones networking

Consider the following recommendations for the landing zone networking design:

- Use a hub-and-spoke network topology for single region or multiregion deployments. [Azure Virtual WAN Hub](/azure/virtual-wan/virtual-wan-about) provides extra features, or you can use a traditional virtual network hub. For more information, see [Azure landing zone networking](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

- Use [infrastructure as code](/azure/well-architected/operational-excellence/infrastructure-as-code-design) to automate your deployments, configuration management, and day-2 operations for all landing zone network-related components.
- Use [private endpoints](/azure/private-link/private-endpoint-overview) for all supported Azure services to improve security. Private endpoints ensure that all traffic routes through your private networking rather than over public IP addresses.

#### Firewall considerations

The following diagram shows a hybrid Azure region RHEL landing zone architecture.

:::image type="content" source="images/network-topology-connectivity/hybrid-regional-platform-landing-zone-network.png" alt-text="Diagram that shows a hybrid Azure region RHEL landing zone architecture." border="false" lightbox="images/network-topology-connectivity/hybrid-regional-platform-landing-zone-network.png":::

|     Element          |             Description                    |
|:-------------:|:--------------------------------|
|  A | Components in the Red Hat Management virtual network contained via the Red Hat Management subscription |
|  B | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription |
|  C | Components in the Identity Management virtual network contained via the Red Hat Identity Management subscription |
|  D | Components in the RHEL Workloads virtual network contained via the RHEL Production Workloads subscription |

- For Virtual WAN topologies, consider using Azure Firewall to route traffic across landing zones. Azure Firewall provides traffic filtering and logging capabilities.

- An Azure VPN gateway or an Azure ExpressRoute gateway controls hybrid connectivity to the hub. To monitor and control the traffic, use Azure Firewall or a virtual network appliance (NVA) in the hub.

- You can use an on-premises firewall to protect and route all ingress and egress internet traffic. A firewall might introduce latency for cloud-based resources. Understand your performance and security requirements to determine how you should route ingress and egress traffic.
  
#### Subnet considerations

The following diagram shows Management and Workload subnets in a zone-resilient configuration.

:::image type="content" source="images/network-topology-connectivity/simplified-networking.png" alt-text="Diagram that shows Management and Workload subnets in a zone-resilient configuration." border="false":::

- When you plan for IP address scopes and virtual network size for the RHEL landing zone, consider dedicated subnets for application, database, and storage resources.
  
- Adopt a Zero Trust-based approach for your perimeter networking and traffic security. For more information, see [Network security strategies on Azure](/azure/well-architected/security/networking).

#### Network security group considerations

:::image type="content" source="images/network-topology-connectivity/network-security-group-segmentation.png" alt-text="Diagram that shows an NSG configuration for traffic security." border="false" lightbox="images/network-topology-connectivity/network-security-group-segmentation.png":::

- Use network security groups (NSGs) to help protect traffic across subnets and east and west traffic across the platform (traffic between landing zones). [Azure Policy](/azure/networking/policy-reference) can make this configuration default for all subnets.

- Use NSGs and [application security groups](/azure/virtual-network/application-security-groups) to micro-segment traffic within the landing zone and avoid using a central NVA to filter traffic flows.

- Enable NSG flow logs and feed them into [traffic analytics](/azure/network-watcher/traffic-analytics). To optimize audit-ability and security, enable flow logs on all critical virtual networks and subnets in your subscription.

- Use NSGs to selectively allow connectivity between landing zones.

- The application team should use application security groups at the subnet-level NSGs to help protect multi-tier VMs within the landing zone.

- If your organization implements forced tunneling, or an advertised default route, to on-premises locations, consider incorporating outbound NSG rules to deny egress traffic from the virtual network directly to the internet. This configuration provides resiliency if the Border Gateway Protocol (BGP) session drops. For more information, see [Plan for landing zone network segmentation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation).

#### Other considerations

- **Enable internet and filtering and inspecting traffic**. Outbound options to enable internet and filtering and inspecting traffic include:
  - Outbound access to Red Hat Cloud via the hub network.
  - On-premises default route that uses on-premises internet access.
  - Virtual WAN or traditional virtual network hub that's secured with Azure Firewall or an NVA.

- **Deliver content and applications**. Inbound options to deliver content and applications include:
  - Azure Application Gateway with L7, Transport Layer Security (TLS) termination, and Web Application Firewall.
  - Dynamic Network Translation (DNAT) and a load balancer from on-premises.
  - Azure Virtual Network with Azure Firewall or an NVA, and Azure Route Server in various scenarios.
  - Virtual WAN hub with Azure Firewall, with L4 and DNAT.
  - Virtual WAN hub with NVA in various scenarios.

- **Configure domain name resolution for on-premises and Azure resources**. The RHEL environment often uses both on-premises and Azure resources, which requires effective name resolution of resources. Consider the following recommendations:
  - Azure provides a default internal name resolution within a virtual network. This scenario doesn't require any configuration. You can't modify the domain name resolution suffix or perform manual registration. For more information, see [Name resolution that Azure provides](/azure/virtual-machines/linux/azure-dns#name-resolution-that-azure-provides).
  - For name resolution across virtual networks, RHEL deployments often use Domain Name System (DNS) services from Redhat Identity Management Server (IdM) or [Azure DNS](/azure/dns/dns-overview). To provide rule-based forwarding, combine [Azure Private DNS Resolver](/azure/dns/dns-private-resolver-overview) and existing DNS infrastructure.

## Next step

- [Resource organization for Red Hat Enterprise Linux on Azure](./resource-organization.md)
