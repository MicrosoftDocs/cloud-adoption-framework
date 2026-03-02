---
title: Security for Oracle Database@Azure
description: Implement defense-in-depth security architecture and threat protection for Oracle Database@Azure by using Azure Arc integration and Microsoft Defender for Cloud.
author: terrymandin
ms.author: temandin
ms.reviewer: terrymandin
ms.date: 09/01/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Security for Oracle Database@Azure

Databases contain sensitive data that requires defense-in-depth security architecture beyond database-level protections. A comprehensive security strategy protects Oracle Database@Azure workloads through multiple defense mechanisms including strong authentication, network security, data encryption, and threat monitoring.

This article provides security recommendations for Oracle Database@Azure deployments. Defense mechanisms include authentication and authorization frameworks, network security controls, encryption of data at rest and in transit, and integrated threat protection through Azure Arc and Microsoft Defender for Cloud.

For Oracle-specific security guidance, see [Security guide for Oracle Exadata Database@Azure](https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-security-guide.html#GUID-EBDA0EB5-734A-4AD2-A740-8C174B1FFE3B) and [Exadata security controls](https://www.oracle.com/a/ocom/docs/engineered-systems/exadata/exadata-cloud-service-security.pdf).

## Establish dual-platform security governance

Security architecture requires coordination between Azure and Oracle Cloud Infrastructure (OCI) platforms because Oracle Database@Azure runs on OCI infrastructure colocated in Microsoft datacenters. Azure controls infrastructure provisioning and network connectivity while OCI manages database operations and individual node management.

1. **Define clear security ownership boundaries between Azure and OCI platforms.** Azure manages security policies for the underlying infrastructure including virtual networks, Azure Arc-enabled servers, and Defender for Cloud integration. Oracle controls database security configurations, transparent data encryption, and OCI-specific security features. This separation prevents conflicts while ensuring comprehensive coverage.

1. **Implement Azure Arc integration for unified security monitoring.** Onboard Oracle Database@Azure infrastructure to [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to enable centralized security management through [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction). Azure Arc integration provides security visibility and threat protection without interfering with OCI management operations or database performance. For detailed implementation guidance, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md).

1. **Align security policies across platforms without conflicts.** Follow [Azure Policy best practices](/azure/azure-arc/servers/policy-reference) for Azure Arc-enabled servers while maintaining Oracle's [security configuration standards](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-oracle-database-security.html). Security policies must complement rather than override existing Oracle security configurations to maintain operational integrity.

## Implement network security controls

Network security provides the frontline of defense through Azure virtual network integration and network security groups (NSGs). Oracle Database@Azure integrates into Azure virtual networks through subnet delegation without default internet access.

1. **Configure NSGs with Oracle-specific considerations.** NSG support depends on network features configuration. When you use NSGs on Azure-delegated subnets, review security rules configured on the Oracle (OCI) side to prevent conflicts that cause access problems or operational disruptions. For complete network planning and NSG configuration guidance, see [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md).

1. **Secure access through predefined port controls.** Oracle Database@Azure uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). These ports are inaccessible from other subnets by default because NSGs within OCI manage them. Only open required ports for secure communication following the [principle of least privilege](/entra/identity-platform/secure-least-privileged-access).

1. **Enable outbound internet access through secure channels when required.** Configure network address translation (NAT) or use a proxy like [Azure Firewall](/azure/firewall/overview) or a network virtual appliance if outbound internet access is necessary. For more information, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan).

## Deploy data encryption and key management

Data protection requires encryption at rest and comprehensive key management strategies. Oracle Database@Azure provides built-in TDE capabilities with default encryption for immediate protection and Azure Key Vault integration for centralized key management.

1. **Use default transparent data encryption for immediate protection.** Oracle Database@Azure enables data-at-rest encryption by default at the database layer. This secures the container database (CDB$ROOT) and pluggable databases using Oracle-managed AES-128 keys stored locally in a wallet within the VM cluster file system. For more information, see [Manage tablespace encryption](https://docs.oracle.com/iaas/exadatacloud/doc/exa-conf-db-features.html#GUID-A7949087-DF56-4EF0-A32B-9465BBC7EE0F).

1. **Integrate Azure Key Vault for centralized key management with private connectivity.** Azure Key Vault provides centralized TDE master key storage within Azure security boundaries while maintaining compliance with Azure governance policies. This integration enables unified key management across your Azure environment, reduces operational complexity, and supports Azure-native security controls including role-based access control (RBAC) and audit logging. For complete implementation guidance including network setup, Private Endpoint connectivity configuration, identity configuration, and validation procedures, see [Azure Key Vault integration for Oracle Exadata Database@Azure](oracle-azure-key-vault-integration-exadata.md).

1. **Ensure high availability for key management infrastructure.** Azure Key Vault provides built-in service resilience with automatic replication within regions and asynchronous replication to paired regions where supported. Consider multi-region Azure Key Vault failover strategies here: [Reliability in Azure Key Vault](/azure/reliability/reliability-key-vault).

1. **Establish secure backup encryption practices.** Database backups encrypt with the same primary encryption keys by default. Store encryption keys and database backups in separate environments to enhance security and minimize data compromise risk during disaster recovery scenarios. Retain old encryption keys for the duration of backup retention periods to enable restoration operations when performing point-in-time recovery from long-term backups.

## Enable Defender for Cloud integration

Defender for Cloud provides comprehensive threat protection and security monitoring for Oracle Database@Azure through Azure Arc integration. This security layer complements Oracle's native security controls with Microsoft's threat intelligence and automated response capabilities.

1. **Deploy Defender for servers on Azure Arc-enabled infrastructure.** Enable [Microsoft Defender for servers](/azure/defender-for-cloud/plan-defender-for-servers) on Azure Arc-enabled Oracle Database@Azure infrastructure for comprehensive threat protection. This integration provides advanced threat detection, vulnerability assessment, and automated incident response capabilities. For Defender for servers capabilities, see [Defender for servers features and benefits](/azure/defender-for-cloud/defender-for-servers-overview).

1. **Configure security baselines and compliance monitoring.** Use [Microsoft cloud security benchmark](/security/benchmark/azure/introduction) to complement Oracle security configurations without conflicts. Implement security baselines by following the guidance in [Establish security baseline](/azure/well-architected/security/establish-baseline) to maintain consistent security posture across hybrid Oracle deployments.

1. **Implement automated threat detection and response.** Establish alert correlation processes by using [Defender workflow automations](/azure/defender-for-cloud/workflow-automations) and [manage and respond to security alerts](/azure/defender-for-cloud/manage-respond-alerts). Configure automated response playbooks for common threat scenarios while respecting Oracle database operations and maintenance windows.

1. **Deploy vulnerability management with Oracle considerations.** Implement [Defender vulnerability assessment](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management) with scheduling aligned to Oracle maintenance windows. For remediation processes, see [Remediate machine vulnerability findings](/azure/defender-for-cloud/remediate-vulnerability-findings-vm) while ensuring compatibility with Oracle grid infrastructure patches.

1. **Integrate with Security Information and Event Management (SIEM) for comprehensive security operations.** Optionally, integrate with [Microsoft Sentinel](/azure/sentinel/overview) for SIEM capabilities to correlate security events across Azure and Oracle platforms for unified threat visibility.

## Manage encryption keys and operational security

Operational security requires rigorous key management, secure agent deployment, and workload isolation strategies. These practices maintain security integrity while enabling necessary monitoring and management operations.

1. **Establish key rotation and life cycle management processes.** Implement rigorous key rotation processes to maintain security and compliance standards when you use customer-managed encryption keys. Azure Key Vault supports key rotation policies that enable automated rotation for cryptographic keys at specified intervals. Define rotation schedules for encryption keys, configure rotation policies through Azure Key Vault, and maintain audit trails for all key life cycle events through Azure Monitor and Azure Policy. For more information about Azure Key Vault key rotation capabilities, see [Configure cryptographic key auto-rotation in Azure Key Vault](/azure/key-vault/keys/how-to-configure-key-rotation).

1. **Plan transition from local wallet to Azure Key Vault.** Use a wallet stored locally in the software keystore for proof of concept or pilot deployments. Plan the transition to Azure Key Vault integration following the implementation guidance in [Azure Key Vault integration for Oracle Exadata Database@Azure](oracle-azure-key-vault-integration-exadata.md). This transition enables centralized key management, improved security controls, and simplified operational procedures.

1. **Deploy security agents with infrastructure considerations.** Install non-Microsoft or Oracle agents on Oracle Database@Azure in locations where database or grid infrastructure patches don't interfere with agent operations. Ensure agents don't modify or compromise the database operating system kernel to maintain Oracle support and system stability.

1. **Implement workload isolation for security boundaries.** Deploy VM clusters in separate virtual networks to achieve security isolation at the workload level, especially when different teams access multiple databases on the same infrastructure. This isolation prevents lateral movement between environments and maintains clear security boundaries. For more information, see [Resource organization for Oracle Database@Azure](oracle-resource-organization-oracle-database-azure.md).

## Next steps

Implement the Oracle Database@Azure security framework through the following complementary guidance areas:

- [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Business continuity and disaster recovery (BCDR) for Oracle Database@Azure](oracle-disaster-recovery-oracle-database-azure.md)

For Microsoft security guidance:

- [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction)
- [Azure Arc-enabled servers](/azure/azure-arc/servers/overview)
- [Azure security design area](../../ready/landing-zone/design-area/security.md)