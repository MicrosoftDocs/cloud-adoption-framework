---
title: Network Topology and Connectivity for Oracle Database@Azure - Get Started
description: Learn about key design considerations and recommendations for Oracle Database@Azure network topology and connectivity for your landing zone.
author: moisesjgomez
ms.author: mgomezcortez
ms.reviewer: sihbher
ms.date: 09/03/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure

This article provides network topology and connectivity guidance for Oracle Database@Azure deployments within your Azure landing zone. These recommendations enable successful network design that supports Oracle Exadata Database@Azure workloads while maintaining security and operational efficiency.

Oracle Database@Azure requires specialized network configuration within Azure landing zones to support Oracle Cloud Infrastructure (OCI) integration. Implement these recommendations to establish proper connectivity patterns that support your Oracle workloads while maintaining consistency with [Cloud Adoption Framework for Azure network design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

## Follow a sequential network design approach

Implement Oracle Database@Azure network topology using a structured approach that addresses foundational requirements before advanced connectivity scenarios. This sequential method ensures proper network foundation and reduces implementation complexity.

1. **Start with core network design fundamentals.** Begin your Oracle Database@Azure network implementation with [core network design guidance](core-network-design.md). This foundational step introduces essential networking principles and constraints specific to Oracle Exadata Database@Azure that must be understood before you implement any connectivity scenarios.

1. **Design application connectivity after core network completion.** Implement [application connectivity design](application-connectivity-design.md) only after you complete core network design. This approach ensures that your application tier connectivity aligns with Oracle Database@Azure network requirements and maintains proper security boundaries.

1. **Plan business continuity connectivity for redundancy requirements.** Configure [business continuity and disaster recovery (BCDR) connectivity design](business-continuity-disaster-recovery-connectivity-design.md) to establish both in-region and cross-region redundancy. This step ensures that your Oracle Database@Azure deployment supports business continuity requirements and disaster recovery capabilities.

1. **Integrate migration connectivity for data movement scenarios.** Implement [migration connectivity design](migration-connectivity-design.md) when you plan to migrate existing Oracle workloads. This design addresses connectivity requirements between your current source environment and Oracle Exadata Database@Azure for successful data migration.

1. **Enable Azure Arc connectivity for hybrid management.** Configure [Azure Arc connectivity design](azure-arc-connectivity-design.md) to enable unified governance and monitoring across your hybrid Oracle environment. This integration provides Azure-native management capabilities while preserving existing OCI console functionality.

## Implement network security groups with Oracle considerations

Configure network security groups (NSGs) that support Oracle Database@Azure requirements while maintaining security boundaries. NSG configuration for Oracle Database@Azure requires coordination between Azure and OCI security rules to prevent access conflicts.

1. **Validate NSG support based on network features configuration.** NSG support depends on specific network features configuration for Oracle Database@Azure deployments. Review your planned network configuration to determine NSG compatibility before you implement security rules. For complete network planning requirements, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan).

1. **Coordinate Azure NSG rules with OCI security configurations.** When you use NSGs on Azure-delegated subnets, review and coordinate security rules configured on the Oracle OCI side to avoid conflicts. Misaligned security rules between platforms can lead to access problems or operational disruptions that affect database connectivity and performance.

1. **Plan for predefined TCP port requirements.** Oracle Exadata Database@Azure uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7) that NSGs within OCI manage by default. These ports are inaccessible from other subnets unless specifically configured. This approach ensures secure database access while maintaining operational functionality.

1. **Use advanced networking features for enhanced capabilities.** Implement [Oracle Database@Azure advanced networking features](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features) when your deployment requires enhanced networking capabilities beyond standard configurations. These features provide more flexibility for complex network requirements while maintaining security and performance standards.

## Next steps

The following table outlines the sequential network design areas that support comprehensive Oracle Database@Azure connectivity.

| Design area | Objective | Implementation sequence |
|-------------|-----------|-------------------------|
| [Core network design](core-network-design.md) | Establish foundational networking concepts for Oracle Exadata Database@Azure | Step 1 – Required as the base layer. |
| [Application connectivity design](application-connectivity-design.md) | Connect application tier to Oracle Exadata Database@Azure | Step 2 – Depends on core network setup. |
| [BCDR connectivity design](business-continuity-disaster-recovery-connectivity-design.md) | Establish in-region and cross-region redundancy strategies | Step 3 – Adds resilience after connectivity is established. |
| [Migration connectivity design](migration-connectivity-design.md) | Integrate current source environment with Oracle Exadata Database@Azure | Step 4 – Enables data movement into target environment. |
| [Azure Arc connectivity design](azure-arc-connectivity-design.md) | Enable Azure Arc on Oracle Database@Azure infrastructure | Step 5 – Completes hybrid management integration. |

