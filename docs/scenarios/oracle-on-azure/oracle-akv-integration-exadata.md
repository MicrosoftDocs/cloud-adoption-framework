---
title: Azure Key Vault Integration for Oracle Exadata Database@Azure
description: Configure Azure Key Vault to manage TDE encryption keys for Oracle Exadata Database@Azure
author: sihbher
ms.author: gereyeso
ms.reviewer: sihbher
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Exadata Database@Azure

This article provides prescriptive guidance for integrating Azure Key Vault with Oracle Exadata Database@Azure to centralize TDE master encryption key management within Azure security boundaries. Implement Azure Key Vault integration to meet enterprise security requirements, achieve regulatory compliance, and standardize key management practices across your Azure resources. This integration maintains Oracle Exadata's performance capabilities while enabling Azure-native governance and monitoring.

Configure Oracle Identity Connector and Azure Arc-enabled servers to establish secure communication between Oracle Exadata Database@Azure and Azure Key Vault. Choose between public endpoint connectivity (default configuration) and private endpoint connectivity (enhanced security isolation through Azure Private Link) based on your organization's security requirements. This approach eliminates Oracle Wallet management complexity while providing enterprise-grade key lifecycle management. For comprehensive implementation procedures, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

## Verify prerequisites and prepare environment for integration

Complete foundational requirements before implementing Azure Key Vault integration with Oracle Exadata Database@Azure. These prerequisites ensure successful configuration and avoid implementation delays.

1. **Confirm Oracle Exadata Database@Azure deployment completion.** Verify your Oracle Exadata Database@Azure virtual machine cluster operates correctly in a delegated subnet within an Azure virtual network. A working database deployment is required because Azure Key Vault integration builds upon the existing Oracle infrastructure and networking configuration. Ensure you have administrative access to both the Azure portal and OCI Console for configuration tasks. For complete deployment procedures, see [Onboard Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database).

2. **Provision Azure Key Vault in the same Azure region as your database deployment.** Create Azure Key Vault in the same Azure region as your Oracle Exadata Database@Azure deployment to minimize latency and ensure optimal TDE performance. Network latency between different regions can impact database startup times and transaction processing when retrieving encryption keys. Generate at least one RSA encryption key (2048-bit minimum) for TDE master key storage. Select appropriate service tier (Standard, Premium, or Managed HSM) based on your security and compliance requirements. For complete Key Vault setup procedures, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

3. **Establish outbound internet connectivity for Azure Arc registration.** Configure outbound connectivity to Azure public endpoints through Azure NAT Gateway, Azure Firewall, or network virtual appliance. Oracle Identity Connector requires access to Microsoft Entra ID public endpoints during initial setup to authenticate and register Azure Arc agents. Without this connectivity, the Oracle Identity Connector creation will fail and prevent Azure Key Vault integration. This connectivity enables Azure Arc agent installation on Exadata virtual machines for secure communication with Azure services.

4. **Verify Azure permissions for identity and resource management before beginning configuration.** Ensure you have Azure Owner or Contributor role on the subscription or resource group where Key Vault resides. Verify Microsoft Entra ID User Administrator role (or equivalent) permissions for creating security groups and managing service principals. Insufficient permissions will cause Oracle Identity Connector setup failures and require administrative intervention to resolve. These permissions support Oracle Identity Connector configuration and Azure Key Vault access management.

## Select connectivity model based on security requirements

Choose the Azure Key Vault connectivity approach that aligns with your organization's security architecture and compliance needs. Oracle Exadata Database@Azure supports both public endpoint and private endpoint connectivity models.

1. **Use public endpoint connectivity for standard security implementations.** Public endpoint connectivity delivers faster implementation with minimal networking complexity while maintaining Azure-native security controls. This approach reduces implementation time by eliminating advanced networking dependencies and complex DNS configurations. Select public endpoints when your security requirements accept internet-based connectivity with firewall restrictions and when you need rapid deployment without additional infrastructure setup.

2. **Implement private endpoint connectivity for enhanced security isolation.** Private endpoint connectivity prevents internet exposure by routing all TDE key operations through Azure Private Link within Azure's private network infrastructure. This approach meets zero-trust security requirements and regulatory compliance standards that mandate private connectivity. Choose private endpoints when you have zero-trust network requirements, regulatory compliance mandating private connectivity, or existing Private Link-based architecture that requires consistency for operational standardization.

3. **Verify advanced networking feature availability before selecting private endpoint connectivity.** Confirm your Azure region supports advanced networking features for Oracle Database@Azure before selecting private endpoint connectivity. Private endpoint connectivity requires advanced networking features that are not available in all regions, and attempting implementation without these features will result in deployment failures. Advanced networking enables Private Link integration and additional security capabilities beyond standard configurations. For feature availability and configuration requirements, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features).

## Configure private endpoint connectivity for enhanced security (optional)

Implement private endpoint connectivity when your security requirements mandate network traffic isolation through Azure Private Link. Skip this section if you selected public endpoint connectivity.

> [!IMPORTANT]
> Private endpoint connectivity requires advanced networking features enabled in your Azure region and additional DNS configuration not covered in this article. Follow the official Microsoft procedures for complete implementation.

1. **Configure Azure Key Vault private endpoint connectivity.** Configure a private endpoint with Domain Name System (DNS) for Azure Key Vault and ensure Oracle Exadata Database@Azure can reach it. Private endpoint setup eliminates internet exposure for all TDE key operations by routing traffic through Azure Private Link. For complete private endpoint creation and DNS configuration procedures, see [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service).

2. **Configure Private Link scope for Azure Arc (when using Azure Arc private connectivity).** Set up Private Link scope and private endpoint for Azure Arc if you require private connectivity for the Oracle Identity Connector. Ensure DNS resolution is properly configured and endpoints are reachable from Oracle Exadata Database@Azure. For Azure Arc Private Link configuration procedures, see [Use Azure Private Link to securely connect servers to Azure Arc](/azure/azure-arc/servers/private-link-security).

3. **Verify DNS configuration follows Oracle Database@Azure split DNS model.** Oracle Database@Azure follows a split DNS model requiring DNS configuration on both Azure and OCI sides. Ensure private endpoint DNS resolution works correctly from the delegated subnet where Oracle Exadata Database@Azure resides. For comprehensive DNS setup guidance, see [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513).

## Establish Oracle Identity Connector for Azure Arc integration

Configure Oracle Identity Connector to enable secure communication between Oracle Exadata Database@Azure and Azure Key Vault through Azure Arc-enabled servers. This connector automatically registers database virtual machines as Azure Arc resources and establishes managed identity authentication.

1. **Generate Azure access token for Azure Arc registration.** Obtain an Azure access token using the Azure CLI with an account that has Owner or Contributor permissions on the subscription or resource group where Oracle Database@Azure resides. Execute `az account get-access-token` and record the `accessToken` value and your Azure tenant ID. The access token authorizes Oracle Identity Connector to register Azure Arc agents on your behalf. For access token requirements and troubleshooting, see [azcmagent connect reference](/azure/azure-arc/servers/azcmagent-connect#access-token).

2. **Create Oracle Identity Connector in OCI Console.** Navigate to your Exadata VM cluster resource in OCI Console and locate the Multicloud information section. Select "Create" for Identity connector and complete the form with your Azure tenant ID and access token. For private endpoint configurations, specify the Private Link scope name under Advanced options to enable private connectivity for Azure Arc communication.

3. **Verify Azure Arc server registration completion.** After connector creation, confirm that Oracle Database@Azure virtual machines appear as Azure Arc-enabled servers in Azure Portal under Azure Arc → Servers. Each database node creates a separate Azure Arc resource with a system-assigned managed identity for Azure service authentication.

4. **Configure Microsoft Entra ID permissions for Key Vault access.** Create a Microsoft Entra ID security group and assign Key Vault Crypto Officer and Key Vault Reader roles to the group at the Key Vault scope. Add the Azure Arc server managed identity principal IDs to this security group to grant Key Vault access permissions. This approach simplifies permission management across multiple database nodes. For role-based access control configuration, see [Azure Key Vault RBAC guide](/azure/key-vault/general/rbac-guide) and [Key Vault built-in roles](/azure/role-based-access-control/built-in-roles#key-vault-crypto-officer).

For complete Oracle Identity Connector setup procedures including token generation, connector creation, and permission configuration, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-3-set-up-the-oracle-identity-connector).

## Enable Azure Key Vault integration and configure database encryption

Complete the final configuration steps to enable Azure Key Vault for TDE key management and configure database encryption. These procedures apply to both public and private endpoint connectivity models.

1. **Enable Azure Key Vault key management on the VM cluster before configuring individual databases.** This cluster-level setting installs the required Oracle library on all cluster VMs and makes Azure Key Vault available as a key management option without automatically switching existing databases. Enabling at the cluster level prevents individual database configuration failures and ensures consistent functionality across all database instances. Navigate to your Exadata VM cluster details page in OCI Console and locate the Multicloud information section. Select "Enable" for Azure key store to install the required Oracle library on cluster VMs. For detailed procedures, see [Enable Azure Key Vault integration](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-4-enable-azure-key-vault-integration-on-vm-cluster).

2. **Register Azure Key Vault in OCI Console to establish the connection between Oracle and Azure services.** Registration creates the association between your Key Vault and Oracle Identity Connector, enabling databases to discover and access encryption keys. Without registration, databases cannot authenticate with Azure Key Vault and TDE operations will fail. Navigate to Database Multicloud Integrations → Microsoft Azure Integration → Azure Key Vaults and select "Register Azure key vaults." Choose your compartment and identity connector, then select "Discover" to list available Key Vaults. Select your Key Vault from the discovered list and complete registration.

3. **Configure database to use Azure Key Vault for TDE.** For new databases, select "Azure Key Vault" as the key management option during database creation and choose your registered vault and key. For existing databases, navigate to the database details page, locate the Encryption section, and select "Change" to switch from Oracle Wallet to Azure Key Vault. Choose your registered vault and encryption key to complete the migration.

4. **Validate database encryption configuration.** Verify the database details page in OCI Console displays "Azure Key Vault" as the key management method with the correct key name listed. This confirmation indicates successful integration between the database and Azure Key Vault for TDE operations.

For complete Azure Key Vault registration procedures and database encryption configuration steps, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-5-register-the-key-vault-in-oci-optional-as-needed).

## Validate Azure Key Vault integration and security

Confirm Azure Key Vault integration functions correctly and database encryption operations use Azure-managed keys.

1. **Verify database access and TDE operations.** Connect to your Oracle database and perform standard read and write operations on encrypted tablespaces. TDE operations should execute transparently without errors. If the database cannot access Azure Key Vault keys, error ORA-28374 ("protected by master key not found") appears when opening the database, indicating configuration issues requiring troubleshooting.

2. **Confirm Key Vault integration status in OCI Console.** Navigate to your database details page in OCI Console and locate the Encryption section. Verify the display shows "Customer-managed key (Microsoft Azure)" as the encryption key management option with the correct vault URI and key name. This confirmation indicates Oracle's control plane recognizes the database association with external key management.

3. **Monitor Azure Key Vault access logs for database operations.** Enable diagnostic logging in Azure Portal for your Key Vault and configure Log Analytics workspace integration. Filter logs for wrap/unwrap key operations from the Azure Arc server managed identity to confirm successful database key access. Review access patterns to ensure operations align with expected database activity. For Key Vault monitoring configuration, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault) and [Azure Key Vault logging](/azure/key-vault/general/logging).

4. **Test database restart to validate key retrieval on startup.** Simulate a database restart to ensure the database can retrieve encryption keys from Azure Key Vault during startup without manual intervention. Shut down and restart the Oracle database from OCI Console. Successful database startup without errors confirms the integration provides reliable key access for operational scenarios including maintenance windows and failover events.

## Establish operational procedures for ongoing management

Implement standardized procedures for key lifecycle management and monitoring to maintain secure and reliable Azure Key Vault integration.

1. **Implement key lifecycle management procedures.** Establish standardized processes for key rotation, backup encryption key management, and disaster recovery scenarios. For complete key lifecycle procedures including rotation schedules, backup considerations, and disaster recovery planning, see [Manage Oracle TDE with Azure Key Vault - Ongoing management](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#ongoing-management).

2. **Monitor Private Endpoint connectivity health (private endpoint configurations only).** Configure Azure Monitor alerts for Private Endpoint connection state changes and network interface health when using private endpoint connectivity. Private Endpoint connectivity issues can prevent database access to encryption keys and require immediate attention. For monitoring configuration procedures, see [Monitor Private Link](/azure/private-link/private-link-overview#logging-and-monitoring) and [Troubleshoot private endpoint connectivity problems](/azure/private-link/troubleshoot-private-endpoint-connectivity).

3. **Maintain DNS zone consistency during infrastructure changes (private endpoint configurations only).** Update corresponding A records in both OCI DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) immediately when making changes to Private Endpoint IP addresses or Key Vault configurations. DNS inconsistencies can cause key operation failures and database startup issues. Include Private Endpoint and OCI DNS zone configuration procedures in your disaster recovery documentation.

## Troubleshoot common integration issues

Address configuration problems specific to private endpoint connectivity with Oracle Exadata Database@Azure and Azure Key Vault. Private endpoint implementations introduce unique DNS resolution and networking challenges that require specialized troubleshooting approaches beyond standard connectivity issues.

> [!TIP]
> For comprehensive troubleshooting of Oracle Database@Azure TDE with Azure Key Vault, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Troubleshooting common problems](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems).

### Private endpoint specific issues

| Issue | Root Cause | Resolution | Official References |
|-------|------------|------------|-------------------|
| Private endpoint DNS resolution failure | DNS zones missing in OCI Private Views or incorrect A records | Verify both DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) exist in OCI Private View with correct A records pointing to private endpoint IP. Execute nslookup test from delegated subnet. | [Private endpoint DNS configuration](/azure/private-link/private-endpoint-dns), [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513) |
| Cannot create private endpoint to Key Vault | Advanced networking not enabled or insufficient delegated subnet IP space | Confirm advanced networking enabled following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). Verify delegated subnet has available IP addresses for private endpoint network interface. | [Advanced networking features](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features), [Private endpoint network requirements](/azure/private-link/private-endpoint-overview#network-security-of-private-endpoints) |
| Private endpoint connectivity timeout | Network routing or private endpoint connection not approved | Test network connectivity from delegated subnet to private endpoint IP address. Confirm private endpoint connection approved in Azure Portal. Validate OCI Private Views DNS zone configuration. | [Troubleshoot private endpoint connectivity](/azure/private-link/troubleshoot-private-endpoint-connectivity), [Private endpoint connection states](/azure/private-link/private-endpoint-overview#private-endpoint-properties) |
| Azure Arc registration fails through private endpoint | Private Link scope not configured or DNS resolution issues for Azure Arc endpoints | Configure Private Link scope for Azure Arc following Microsoft requirements. Verify DNS resolution for Azure Arc endpoints through private connectivity. Ensure Azure Arc private endpoint properly configured. | [Azure Arc Private Link configuration](/azure/azure-arc/servers/private-link-security), [Azure Arc connectivity requirements](/azure/azure-arc/servers/network-requirements) |

## Related resources

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Core network design for Oracle Database@Azure](core-network-design.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)
- [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault)