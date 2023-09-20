---
title: Network topology and connectivity for Oracle on Azure Virtual Machines  landing zone accelerator
description: Learn about network topology and connectivity for Oracle Virtual Machines landing zone accelerator.
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

# Network topology and connectivity for Oracle on Azure Virtual Machines landing zone accelerator

This article builds on several considerations and recommendations defined in [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It offers key design considerations and best practices for networking and connectivity of your Oracle instance running on Azure virtual machines (VMs). Since Oracle supports mission-critical workloads, the guidance on the Azure landing zone design areas should be included in your design.

## Security is always the priority

As with most production databases, securing an Oracle workload is essential.  The database must remain private with no public endpoints.  Access to the data should be deliberately controlled from authorized cloud services only (for example, a business application or web front-end services). A select few authorized individuals can manage any production database by using a secured service as described in [Plan for virtual machine remote access](../../ready/azure-best-practices/plan-for-virtual-machine-remote-access.md).

## High-level network design

The following architecture diagram shows networking considerations for Oracle instances within an Azure landing zone.

:::image type="content" source="media/network-considerations-oracle-landing-zone.png" alt-text="Diagram showing the conceptual architecture of Oracle on Azure landing zone accelerator.":::

- All solution services should reside within a single virtual network.
- Use Azure Firewall, Azure Application Gateway or other security mechanisms to ensure that only essential traffic is allowed to the solution.
- For more advanced network security measures, implement a network DMZ. For more information, see [Implement a Secure Hybrid Network](/azure/architecture/reference-architectures/dmz/secure-vnet-dmz).
-All virtual machines directly supporting the Oracle database should reside in a dedicated subnet and securely separated from the internet 
- Monitor and filter traffic using Azure Monitor, Azure network security groups (NSGs), or application security groups.
- The Oracle database subnet should include a network security group (NSG) that allows the following traffic:
  - Inbound port 22 or 3389 if Oracle database services are running on Windows from a secure source only. For more information on secure virtual machine access, see [Plan for virtual machine remote access](../../ready/azure-best-practices/plan-for-virtual-machine-remote-access.md).
  - Inbound port 1521 from the front-end subnet only.
  - Ports can be changed when security requires obfuscation (not use default ports).
- The front-end subnet should follow [best practices for internet facing workloads](https://learn.microsoft.com/events/azure-iaas-day-2021/best-practices-securing-internet-facing-cloud-architecture-azure).
- Oracle management access should be limited to a minimal number of authorized users using [Azure Bastion](/azure/bastion/) to connect securely to the Virtual Machines in the Oracle subnet.
- If using Azure Bastion to access the Oracle database server, the **AzureBastionSubnet** should include a Network Security Group (NSG) that allows inbound traffic on port 443.
- Remember to configure proximity placement groups for Oracle application servers and Oracle database servers to minimize network latency.
- All services should be deployed using [accelerated networking](/azure/virtual-network/accelerated-networking-overview)

## Next steps

[Business continuity and disaster recovery for Oracle Virtual Machines landing zone accelerator](oracle-disaster-recovery-oracle-landing-zone.md)
