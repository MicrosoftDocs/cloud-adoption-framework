---
title: Network Topology and Connectivity for Oracle Database@Azure - Get Started
description: Learn about key design considerations and recommendations for Oracle Database@Azure network topology and connectivity for your landing zone.
author: moisesjgomez
ms.author: mgomezcortez
ms.reviewer: sihbher
ms.date: 09/03/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---


# Network topology and connectivity for Oracle Database@Azure

This article provides network topology and connectivity guidance for Oracle Database@Azure deployments within your Azure landing zone. These recommendations enable successful network design that supports Oracle Exadata Database@Azure workloads while maintaining security and operational efficiency.

Oracle Database@Azure requires specialized network configuration within Azure landing zones to support Oracle Cloud Infrastructure (OCI) integration. Implement these recommendations to establish proper connectivity patterns that support your Oracle workloads while maintaining consistency with [Cloud Adoption Framework network design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

## Follow sequential network design approach

Implement Oracle Database@Azure network topology using a structured approach that addresses foundational requirements before advanced connectivity scenarios. This sequential method ensures proper network foundation and reduces implementation complexity.

1. **Start with core network design fundamentals**. Begin your Oracle Database@Azure network implementation with [core network design](core-network-design.md) guidance. This foundational step introduces essential networking principles and constraints specific to Oracle Exadata Database@Azure that must be understood before implementing any connectivity scenarios.

2. **Design application connectivity after core network completion**. Implement [application connectivity design](application-connectivity-design.md) only after completing core network design. This approach ensures your application tier connectivity aligns with Oracle Database@Azure network requirements and maintains proper security boundaries.

3. **Plan business continuity connectivity for redundancy requirements**. Configure [business continuity and disaster recovery connectivity design](business-continuity-disaster-recovery-connectivity-design.md) to establish both in-region and cross-region redundancy. This step ensures your Oracle Database@Azure deployment supports business continuity requirements and disaster recovery capabilities.

4. **Integrate migration connectivity for data movement scenarios**. Implement [migration connectivity design](migration-connectivity-design.md) when planning to migrate existing Oracle workloads. This design addresses connectivity requirements between your current source environment and Oracle Exadata Database@Azure for successful data migration.

5. **Enable Azure Arc connectivity for hybrid management**. Configure [Azure Arc connectivity design](azure-arc-connectivity-design.md) to enable unified governance and monitoring across your hybrid Oracle environment. This integration provides Azure-native management capabilities while preserving existing OCI console functionality.

## Implement Network Security Groups with Oracle considerations

Configure Network Security Groups that support Oracle Database@Azure requirements while maintaining security boundaries. NSG configuration for Oracle Database@Azure requires coordination between Azure and OCI security rules to prevent access conflicts.

1. **Validate NSG support based on network features configuration**. NSG support depends on specific network features configuration for Oracle Database@Azure deployments. Review your planned network configuration to determine NSG compatibility before implementing security rules. For complete network planning requirements, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan).

2. **Coordinate Azure NSG rules with OCI security configurations**. When using NSGs on Azure-delegated subnets, review and coordinate security rules configured on the Oracle (OCI) side to avoid conflicts. Misaligned security rules between platforms can lead to access issues or operational disruptions that affect database connectivity and performance.

3. **Plan for predefined TCP port requirements**. Oracle Exadata Database@Azure uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/en-us/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7) that are managed by NSGs within OCI by default. These ports are inaccessible from other subnets unless specifically configured, ensuring secure database access while maintaining operational functionality.

4. **Leverage advanced networking features for enhanced capabilities**. Implement [Oracle Database@Azure advanced networking features](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features) when your deployment requires enhanced networking capabilities beyond standard configurations. These features provide additional flexibility for complex network requirements while maintaining security and performance standards.

## Network design guidance areas

The following table outlines the sequential network design areas that support comprehensive Oracle Database@Azure connectivity:

| Design area | Objective | Implementation sequence |
|-------------|-----------|------------------------|
| [Core network design](core-network-design.md) | Establish foundational networking concepts for Oracle Exadata Database@Azure | First - Required foundation |
| [Application connectivity design](application-connectivity-design.md) | Connect application tier to Oracle Exadata Database@Azure | Second - After core network |
| [Business continuity and disaster recovery connectivity design](business-continuity-disaster-recovery-connectivity-design.md) | Establish in-region and cross-region redundancy strategies | Third - For resilience requirements |
| [Migration connectivity design](migration-connectivity-design.md) | Integrate current source environment with Oracle Exadata Database@Azure | Fourth - For migration scenarios |
| [Azure Arc connectivity design](azure-arc-connectivity-design.md) | Enable Azure Arc on Oracle Database@Azure infrastructure | Fifth - For hybrid management |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Network Planning | [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan) | Comprehensive network configuration guidance |
| Landing Zone Design | [Network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) | Cloud Adoption Framework network design principles |
| Security | [Network Security Groups](/azure/virtual-network/network-security-groups-overview) | Azure network security configuration and management |
| Advanced Features | [Oracle Database@Azure advanced networking](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features) | Enhanced networking capabilities for complex requirements |

## Next steps

> [!div class="nextstepaction"]
> [Core network design](core-network-design.md)
