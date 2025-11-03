---
title: Azure Key Vault Integration for Oracle Exadata Database@Azure
description: Guidance for integrating Azure Key Vault with Oracle Exadata Database@Azure for centralized TDE key management
author: sihbher
ms.author: gereyeso
ms.date: 11/03/2025
ms.reviewer: sihbher
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Exadata Database@Azure

Integrate Azure Key Vault with Oracle Exadata Database@Azure to centralize Transparent Data Encryption (TDE) master encryption key management within Azure security boundaries. This integration enables enterprise security requirements, regulatory compliance, and standardized key management practices across Azure resources while maintaining Oracle Exadata's performance capabilities.

Azure Key Vault integration provides centralized key management, Azure-native governance, unified monitoring, and simplified compliance through consolidated security controls. Choose between Azure Key Vault Standard, Premium (HSM-backed), or Managed HSM tiers based on security requirements and compliance mandates such as FIPS 140-3 Level 3 validation.

> [!IMPORTANT]
> For complete technical implementation procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault). This article provides strategic planning guidance and architectural decision frameworks to complement the technical documentation.

## Plan Azure Key Vault integration architecture

Define your Azure Key Vault integration architecture based on security requirements, compliance mandates, and operational considerations. These architectural decisions impact security posture, operational complexity, and long-term maintenance.

1. **Select Azure Key Vault service tier aligned with security and compliance requirements.** Choose between Standard (software-based keys), Premium (HSM-backed keys), or Managed HSM (dedicated HSM cluster) based on regulatory compliance mandates and security requirements. Premium and Managed HSM both provide FIPS 140-3 Level 3 validation for organizations with stringent compliance requirements. Standard tier provides FIPS 140-2 Level 1 validation and suits development and test environments with moderate security needs. For detailed tier comparison and selection guidance, see [About Azure Key Vault](/azure/key-vault/general/overview).

2. **Determine connectivity model based on network security architecture.** Evaluate public endpoint connectivity versus private endpoint connectivity through Azure Private Link. Public endpoint connectivity delivers faster implementation with Azure firewall restrictions and supports most security requirements. Private endpoint connectivity provides enhanced security isolation by routing all traffic through Azure's private network without internet exposure, meeting zero-trust network requirements. Review [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features) to understand advanced networking prerequisites for private endpoint implementations.

3. **Establish key management strategy and operational procedures.** Define key rotation schedules aligned with security policies, typically annual or event-driven rotation. Plan backup encryption key management considering that database backups encrypt with current master keys. Establish disaster recovery procedures ensuring standby Oracle Exadata environments can access encryption keys during failover scenarios. Document key lifecycle management processes including creation, rotation, retention, and decommissioning procedures.

4. **Deploy Azure Key Vault in same region as Oracle Exadata Database@Azure.** Colocation minimizes network latency for TDE operations and ensures optimal database startup and transaction processing performance. Cross-region key access introduces latency that can impact database availability during startup sequences and failover operations. Regional deployment also supports data residency requirements and compliance with geographic data sovereignty mandates.

## Prepare environment and validate prerequisites

Complete foundational requirements before implementing Azure Key Vault integration. Prerequisites validation prevents implementation delays and configuration failures.

1. **Confirm Oracle Exadata Database@Azure deployment completion and operational status.** Verify virtual machine cluster operates correctly in delegated subnet within Azure virtual network with administrative access to both Azure Portal and OCI Console. Working database deployment is required because Azure Key Vault integration builds upon existing Oracle infrastructure. For deployment verification procedures, see [Onboard Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database).

2. **Provision Azure Key Vault and generate encryption keys following security best practices.** Create Azure Key Vault in same Azure region as Oracle Exadata Database@Azure deployment. Generate RSA encryption key (minimum 2048-bit) for TDE master key storage. Configure appropriate access policies and enable diagnostic logging for security monitoring. For complete provisioning procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 1](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-1-create-and-prepare-a-key-vault).

3. **Establish outbound connectivity for Azure Arc registration.** Configure outbound connectivity to Azure public endpoints through Azure NAT Gateway, Azure Firewall, or network virtual appliance. Oracle Identity Connector requires Microsoft Entra ID public endpoint access during initial setup for Azure Arc agent authentication and registration. Without connectivity, Oracle Identity Connector creation fails and prevents Azure Key Vault integration. For connectivity requirements, see [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements).

4. **Verify Azure permissions for identity and resource management.** Ensure Azure Owner or Contributor role on subscription or resource group where Key Vault resides. Confirm Microsoft Entra ID User Administrator role permissions for creating security groups and managing service principals. Insufficient permissions cause Oracle Identity Connector setup failures requiring administrative intervention. For detailed permission requirements, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Prerequisites](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#prerequisites).

## Implement private endpoint connectivity (optional)

Configure private endpoint connectivity when security requirements mandate network traffic isolation through Azure Private Link. This configuration eliminates internet exposure for TDE key operations.

> [!IMPORTANT]
> Private endpoint connectivity requires advanced networking features and additional DNS configuration. Follow official Microsoft procedures for complete implementation:
> - [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service)
> - [Use Azure Private Link to securely connect servers to Azure Arc](/azure/azure-arc/servers/private-link-security)  
> - [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513)

1. **Verify advanced networking feature availability in your Azure region.** Confirm your region supports advanced networking for Oracle Database@Azure before implementing private endpoint connectivity. Attempting implementation without advanced networking features results in deployment failures. For feature availability verification, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features).

2. **Configure Azure Key Vault private endpoint with DNS integration.** Establish private endpoint for Azure Key Vault ensuring DNS resolution works correctly from Oracle Exadata Database@Azure delegated subnet. Private endpoint setup requires DNS configuration on both Azure and OCI sides following split DNS model. For implementation procedures, see [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service).

3. **Configure Azure Arc Private Link scope (when requiring private Arc connectivity).** Set up Private Link scope and private endpoint for Azure Arc if Oracle Identity Connector requires private connectivity. Ensure DNS resolution properly configured and endpoints reachable from Oracle Exadata Database@Azure. For configuration procedures, see [Use Azure Private Link to securely connect servers to Azure Arc](/azure/azure-arc/servers/private-link-security).

4. **Validate DNS configuration follows Oracle Database@Azure split DNS requirements.** Oracle Database@Azure requires DNS configuration on both Azure and OCI sides. Verify private endpoint DNS resolution works correctly from delegated subnet where Oracle Exadata Database@Azure resides. For DNS setup guidance, see [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513).

## Configure Oracle Identity Connector and Azure Arc integration

Establish Oracle Identity Connector to enable secure communication between Oracle Exadata Database@Azure and Azure Key Vault through Azure Arc-enabled servers. This connector automatically registers database virtual machines as Azure Arc resources with managed identity authentication.

> [!TIP]
> For complete technical procedures including token generation, connector creation, and permission configuration, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 3](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-3-set-up-the-oracle-identity-connector).

1. **Generate Azure access token and configure Oracle Identity Connector.** Obtain Azure access token using account with Owner or Contributor permissions. Create Oracle Identity Connector in OCI Console providing Azure tenant ID and access token. For private endpoint configurations, specify Private Link scope name to enable private Arc connectivity. The connector automatically installs Azure Arc agents on database virtual machines and registers them as Azure Arc-enabled servers.

2. **Verify Azure Arc server registration and managed identity creation.** Confirm Oracle Exadata Database@Azure virtual machines appear as Azure Arc-enabled servers in Azure Portal under Azure Arc → Servers. Each database node receives system-assigned managed identity for Azure service authentication. Verify all expected virtual machines successfully registered before proceeding with permission configuration.

3. **Configure Azure RBAC permissions for Key Vault access.** Create Microsoft Entra ID security group and assign Key Vault Crypto Officer and Key Vault Reader roles at Key Vault scope. Add Azure Arc server managed identity principal IDs to security group to grant Key Vault access permissions. This group-based approach simplifies permission management across multiple database nodes. For RBAC configuration procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 2](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-2-configure-microsoft-entra-id-permissions-for-key-vault-access).

## Enable Azure Key Vault integration and configure databases

Complete Azure Key Vault integration enabling at cluster level and configure individual databases for TDE key management. These configuration steps apply to both public and private endpoint connectivity models.

> [!TIP]
> For detailed step-by-step procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-4-enable-azure-key-vault-integration-on-vm-cluster).

1. **Enable Azure Key Vault at VM cluster level before configuring databases.** Cluster-level enablement installs required Oracle library on all cluster virtual machines making Azure Key Vault available as key management option without automatically switching existing databases. This prevents individual database configuration failures and ensures consistent functionality across database instances. For enablement procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 4](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-4-enable-azure-key-vault-integration-on-vm-cluster).

2. **Register Azure Key Vault in OCI Console to establish service connection.** Registration creates association between Key Vault and Oracle Identity Connector enabling databases to discover and access encryption keys. Without registration, databases cannot authenticate with Azure Key Vault causing TDE operation failures. For registration procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 5](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-5-register-the-key-vault-in-oci-optional-as-needed).

3. **Configure database TDE to use Azure Key Vault for new or existing databases.** For new databases, select Azure Key Vault as key management option during creation and choose registered vault and key. For existing databases, migrate from Oracle Wallet to Azure Key Vault through database encryption settings. Migration re-encrypts TDE wallet without database shutdown. For configuration procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 6](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-6-configure-an-oracle-database-to-use-azure-key-vault).

4. **Validate database encryption configuration and Key Vault integration.** Verify database details page shows Azure Key Vault as key management method with correct key name. Perform standard database operations on encrypted tablespaces ensuring TDE operations execute transparently without errors. For validation procedures, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Step 7](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-7-verify-the-integration-and-security).

## Establish operational management procedures

Implement standardized operational procedures for key lifecycle management, monitoring, and disaster recovery to maintain secure and reliable Azure Key Vault integration.

1. **Implement key rotation procedures aligned with security policies.** Establish key rotation schedules (typically annual or event-driven) and execute rotations through OCI Console or API rather than directly in Azure. Always initiate rotation from Oracle side coordinating with Azure to ensure database awareness of new key versions. For rotation procedures and best practices, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Ongoing management](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#ongoing-management).

2. **Configure monitoring and alerting for key access and integration health.** Enable Azure Key Vault diagnostic logging and configure Log Analytics workspace integration. Monitor wrap/unwrap key operations from Azure Arc server managed identities to confirm successful database key access. For private endpoint configurations, configure alerts for Private Endpoint connection state changes and network interface health. For monitoring configuration, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault).

3. **Plan disaster recovery considering key management dependencies.** Ensure disaster recovery sites can access encryption keys during failover scenarios by registering Key Vault with standby cluster's Oracle Identity Connector. Test switchover and failover operations to validate standby database can open with Azure Key Vault keys independently. For DR planning guidance, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Disaster recovery](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#disaster-recovery).

4. **Maintain backup encryption key retention aligned with backup retention policies.** Retain old encryption key versions for duration of backup retention periods to enable point-in-time recovery from long-term backups. Store encryption keys and database backups in separate environments to minimize data compromise risk during disaster recovery scenarios. Don't immediately delete old key versions as they may be needed to restore historical backups.

## Troubleshoot integration issues

Address common Azure Key Vault integration issues focusing on private endpoint connectivity challenges unique to Oracle Exadata Database@Azure implementations.

> [!TIP]
> For comprehensive troubleshooting guidance including authorization errors, Azure Arc connectivity issues, and token expiration problems, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Troubleshooting](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems).

### Common integration challenges

**Private endpoint DNS resolution failures**: Verify DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) exist in OCI Private View with correct A records pointing to private endpoint IP address. Execute nslookup test from delegated subnet to confirm resolution. See [Private endpoint DNS configuration](/azure/private-link/private-endpoint-dns) and [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513).

**Private endpoint connectivity timeouts**: Test network connectivity from delegated subnet to private endpoint IP address. Confirm private endpoint connection approved in Azure Portal. Validate OCI Private Views DNS zone configuration. See [Troubleshoot private endpoint connectivity](/azure/private-link/troubleshoot-private-endpoint-connectivity).

**Azure Arc registration failures through private endpoint**: Configure Private Link scope for Azure Arc following Microsoft requirements. Verify DNS resolution for Azure Arc endpoints through private connectivity. Ensure Azure Arc private endpoint properly configured. See [Azure Arc Private Link configuration](/azure/azure-arc/servers/private-link-security).

**Advanced networking prerequisite failures**: Confirm advanced networking enabled for Oracle Database@Azure following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). Verify delegated subnet has available IP addresses for private endpoint network interface.

## Next steps

- [Security for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Business continuity and disaster recovery for Oracle Database@Azure](oracle-disaster-recovery-oracle-database-azure.md)
- [Integrate Oracle Exadata Database@Azure with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)