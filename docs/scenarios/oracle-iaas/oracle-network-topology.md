---
title: Network topology and connectivity for Oracle on Azure VMs  landing zone accelerator
description: Learn about network topology and connectivity for Oracle VMs landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/27/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Network topology and connectivity for Oracle on Azure VMs  landing zone accelerator

This article builds on several considerations and recommendations defined in [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It offers key design considerations and best practices for networking and connectivity of your Oracle instance running on Azure virtual machines (VMs). Since Oracle supports mission-critical workloads, the guidance on the Azure landing zone design areas should be included in your design.

## Security is always the priority

As with most production databases, securing an Oracle workload is essential.  The database must remain private with no public endpoints.  Access to the data should be deliberately controlled from authorized cloud services only (for example, a business application or web front-end services). A select few authorized individuals can manage any production database by using the secure Azure Bastion service.

## High-level network design

The following architecture diagram shows networking considerations for Oracle instances within an Azure landing zone.

:::image type="content" source="media/network-considerations-oracle-landing-zone.png" alt-text="Diagram showing the conceptual architecture of Oracle on Azure landing zone accelerator.":::

- All cloud services should reside within a single virtual network (VNet) to provide the client the opportunity to deploy within a Hub & Spoke, Virtual WAN, and others.
- Use Azure Firewall or any of the market-available network virtual appliances (NVAs).
- For more advanced network security measures, implement a network DMZ. For more information, see [Implement a Secure Hybrid Network](https://learn.microsoft.com/azure/architecture/reference-architectures/dmz/secure-vnet-dmz).
- All VMs that directly support the Oracle database should reside in a dedicated subnet and be securely separated from the internet and on-premises network by directing all traffic through the hub virtual network.
- Monitor and filter traffic using Azure Monitor, Azure network security groups (NSGs), or application security groups.
- The Oracle subnet should include a network security group (NSG) that allows the following traffic:
  - Inbound port 22 from the Azure Bastion Subnet only.
  - A Jumpbox VM can be used in place of Azure Bastion, which requires inbound port 3389.
  - Inbound port 1521 from the front-end subnet only.
  - Ports can be changed when security requires obfuscation (not use default ports). 
- The front-end subnet should follow [best practices for internet facing workloads](https://learn.microsoft.com/events/azure-iaas-day-2021/best-practices-securing-internet-facing-cloud-architecture-azure).
- Oracle management access should be limited to a minimal number of authorized users using [Azure Bastion](https://learn.microsoft.com/azure/bastion/) to connect securely to the VMs in the Oracle subnet.
- The **AzureBastionSubnet** should include a Network Security Group (NSG) that allows inbound traffic on port 443.
- Oracle workloads should be evaluated in advance and deployed on the proper sized VM and storage requirements.
- Because Oracle is optimized for Linux, it's recommended to run it on a Linux distribution. However, it functions properly on a virtualized Window platform as well.
- Use [Oracle DataGuard](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/configure-oracle-dataguard) or another backup strategy. For example, [Oracle GoldenGate](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/introduction-oracle-goldengate.htm) should be employed to enable high availability with a load balancer to properly route traffic to the primary or secondary database server.
- Oracle VMs should be strategically placed in either [Availability sets](https://learn.microsoft.com/azure/virtual-machines/availability-set-overview) or [Availability zones](https://learn.microsoft.com/azure/reliability/availability-zones-overview). The option choice depends on the level of availability or disaster recovery as described in the [High availability and disaster recovery for Oracle on Azure]() design guide
- All services should be deployed using [accelerated networking](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

## Next steps

Learn about design considerations for Oracle on Azure IaaS Compute & Storage guidelines in an enterprise-scale scenario. 

[Business continuity and disaster recovery for Oracle on Azure IaaS](oracle-disaster-recovery-oracle-landing-zone.md)
