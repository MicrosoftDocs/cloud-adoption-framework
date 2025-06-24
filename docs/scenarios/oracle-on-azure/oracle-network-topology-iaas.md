---
title: Network topology and connectivity for Oracle on Azure Virtual Machines
description: Learn about network topology and connectivity for Oracle on Azure Virtual Machines.
author: jessiehaessler
ms.author: jhaessler
ms.reviewer: ramakoni
ms.date: 06/24/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle on the Azure Virtual Machines landing zone accelerator

This article builds on several considerations and recommendations defined in [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It offers key design considerations and best practices for networking and connectivity of your Oracle instance that runs on Azure Virtual Machines. Because Oracle supports mission-critical workloads, you should include the guidance for the Azure landing zone design areas in your design.

## Prioritize security for Oracle workloads

As with most production databases, securing an Oracle workload is essential. The database must remain private and have no public endpoints. Only authorized cloud services such as a business application or web front-end services should control access to the data. A select few authorized individuals can manage any production database by using a secured service. For more information, see [Plan for VM remote access](../../ready/azure-best-practices/plan-for-virtual-machine-remote-access.md).

## High-level network design

The following architecture diagram shows networking considerations for Oracle instances within an Azure landing zone.

:::image type="content" source="media/network-considerations-oracle-landing-zone.png" alt-text="Diagram showing the conceptual architecture of Oracle on Azure landing zone accelerator." border="false" lightbox="media/network-considerations-oracle-landing-zone.png":::

- Ensure that all solution services reside within a single virtual network.

- Use Azure Firewall, Azure Application Gateway, or other security mechanisms to ensure that only essential traffic is allowed to access the solution.

- Implement a network DMZ for more advanced network security measures. For more information, see [Implement a Secure Hybrid Network](/azure/architecture/reference-architectures/dmz/secure-vnet-dmz).

- Monitor and filter traffic by using Azure Monitor, Azure network security groups (NSGs), or application security groups.

- Ensure that all VMs that directly support the Oracle database reside in a dedicated subnet and are kept secure from the internet.

The Oracle database subnet should include an NSG that allows the following traffic:

- Inbound port 22 or 3389 if Oracle database services are running on Windows from a secure source only. For more information about secure VM access, see [Plan for VM remote access](../../ready/azure-best-practices/plan-for-virtual-machine-remote-access.md).

- Inbound port 1521 from the front-end subnet only. The front-end subnet should follow [best practices for internet facing workloads](/events/azure-iaas-day-2021-best-practices-securing-internet-facing-cloud-architecture-azure).

- Change ports when security requires obfuscation. Don't use default ports.

- Limit Oracle management access to a minimal number of authorized users by using [Azure Bastion](/azure/bastion/) to connect securely to the VMs in the Oracle subnet.

- If you use Azure Bastion to access the Oracle database server, make sure the **AzureBastionSubnet** includes an NSG that allows inbound traffic on port 443.

- If needed configure proximity placement groups for Oracle application servers and Oracle database servers to minimize network latency.

- Use [accelerated networking](/azure/virtual-network/accelerated-networking-overview) to deploy all services.

## Next step

[Security overview for Oracle on Azure virtual machines](oracle-security-overview-iaas.md)
