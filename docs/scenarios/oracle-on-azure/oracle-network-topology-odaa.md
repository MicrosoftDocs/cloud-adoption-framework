---
title: Network Topology and Connectivity for Oracle Database@Azure - Get Started
description: Learn about key design considerations and recommendations for Oracle Database@Azure network topology and connectivity for your landing zone.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure - Get started

Before you begin cloud adoption, create a landing zone to host the workloads that you plan to build in or migrate to Azure. This section of the framework guides you through how to establish connectivity within your landing zone. This article builds on the Cloud Adoption Framework for Azure [network landing zone](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) design principles.

The following articles help guide you through the process of creating a network connectivity and topology for your landing zone to support cloud adoption for Oracle Exadata Database@Azure.

| Design area                 | Objective                                                                                                                                                |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Core network design](core-network-design.md)            | Understand the foundational networking concepts for Oracle Exadata Database@Azure.                                                        |
| [Application connectivity design](application-connectivity-design.md) | Guidance on how to connect your application tier to Oracle Exadata Database@Azure.                                                            |
| [Business continuity and disaster recovery (BCDR) connectivity design](business-continuity-disaster-recovery-connectivity-design.md)        | Strategies for how to establish in-region and cross-region redundancy.                                                                                        |
| [Migration connectivity design](migration-connectivity-design.md)   | Approaches and best practices for how to integrate your current source environment with Oracle Exadata Database@Azure for migration scenarios. |
| [Azure Arc connectivity design](azure-arc-connectivity-design.md) | Network connectivity requirements and configuration guidance for enabling Azure Arc on Oracle Database@Azure infrastructure. |

Start with the [core network design](core-network-design.md) guidance, which introduces foundational networking principles and constraints for Oracle Exadata Database@Azure. Complete this step before you explore application connectivity, BCDR, or migration scenarios.

## Network Security Groups (NSGs) considerations

When planning network security for Oracle Database@Azure, consider the following NSG-related guidance:

- Network Security Groups (NSGs) security considerations: NSG support depends on network features configuration. When using NSGs on Azure-delegated subnets, review security rules configured on the Oracle (OCI) side to avoid conflicts that can lead to access issues or operational disruptions. For complete network planning and NSG configuration details, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan).

- For advanced networking capabilities and features, see [Oracle Database@Azure advanced networking features](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features).

- The Oracle Exadata Database@Azure solution uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/en-us/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). By default, these ports are inaccessible from other subnets because the NSGs within OCI manage them.
