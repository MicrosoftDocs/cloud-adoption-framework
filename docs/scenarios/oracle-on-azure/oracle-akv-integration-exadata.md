---
title: Azure Key Vault Integration for Oracle Exadata Database@Azure
description: Configure Azure Key Vault to manage TDE encryption keys for Oracle Exadata Database@Azure
author: sihbher
ms.author: sihbher
ms.reviewer: sihbher
ms.date: 2025-10-22
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Exadata Database@Azure

This article provides guidance for configuring Azure Key Vault to store and manage Oracle Transparent Data Encryption (TDE) master encryption keys for Oracle Exadata Database@Azure deployments. Azure Key Vault integration enables centralized key management within Azure security boundaries while maintaining Oracle Exadata's performance capabilities and supporting Azure-native governance policies. For comprehensive implementation procedures, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

Oracle Exadata Database@Azure uses Azure Arc-enabled servers and Oracle Identity Connector to establish secure communication with Azure Key Vault. The integration supports both public endpoint connectivity (default configuration) and private endpoint connectivity (enhanced security isolation through Azure Private Link). This approach standardizes key management practices across Azure resources while meeting enterprise security and compliance requirements. For Azure Arc architecture details, see [Azure Arc-enabled servers overview](/azure/azure-arc/servers/overview).

## Verify prerequisites and prepare environment for integration

Complete foundational requirements before implementing Azure Key Vault integration with Oracle Exadata Database@Azure. These prerequisites ensure successful configuration and avoid implementation delays.

1. **Confirm Oracle Exadata Database@Azure deployment completion.** Verify your Oracle Exadata Database@Azure virtual machine cluster operates correctly in a delegated subnet within an Azure virtual network. Ensure you have administrative access to both the Azure portal and OCI Console for configuration tasks. For complete deployment procedures, see [Onboard Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database).

2. **Provision Azure Key Vault with TDE-compatible encryption keys.** Create Azure Key Vault in the same Azure region as your Oracle Exadata Database@Azure deployment to minimize latency. Generate at least one RSA encryption key (2048-bit minimum) for TDE master key storage. Select appropriate service tier (Standard, Premium, or Managed HSM) based on your security and compliance requirements. For complete Key Vault setup procedures, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

3. **Configure outbound internet connectivity for Azure Arc registration.** Establish outbound connectivity to Azure public endpoints through Azure NAT Gateway, Azure Firewall, or network virtual appliance. Oracle Identity Connector requires access to Microsoft Entra ID public endpoints during initial setup. This connectivity enables Azure Arc agent installation on Exadata virtual machines for secure communication with Azure services.

4. **Validate required Azure permissions for identity and resource management.** Ensure you have Azure Owner or Contributor role on the subscription or resource group where Key Vault resides. Verify Microsoft Entra ID User Administrator role (or equivalent) permissions for creating security groups and managing service principals. These permissions support Oracle Identity Connector configuration and Azure Key Vault access management.

## Select connectivity model based on security requirements

Choose the Azure Key Vault connectivity approach that aligns with your organization's security architecture and compliance needs. Oracle Exadata Database@Azure supports both public endpoint and private endpoint connectivity models.

1. **Evaluate public endpoint connectivity for standard security implementations.** Public endpoint connectivity uses Azure Key Vault's standard internet-accessible endpoints with firewall-based access controls. This approach provides faster implementation with minimal networking complexity while maintaining Azure-native security controls. Use public endpoints when your security requirements accept internet-based connectivity with firewall restrictions and when you need rapid deployment without advanced networking dependencies.

2. **Implement private endpoint connectivity for enhanced security isolation.** Private endpoint connectivity routes all TDE key operations through Azure Private Link, ensuring traffic remains within Azure's private network infrastructure without internet exposure. This approach requires advanced networking features enabled in your Azure region and additional DNS configuration through OCI Private Views. Choose private endpoints when you have zero-trust network requirements, regulatory compliance mandating private connectivity, or existing Private Link-based architecture that requires consistency.

3. **Verify advanced networking feature availability for private endpoint scenarios.** Confirm your Azure region supports advanced networking features for Oracle Database@Azure before selecting private endpoint connectivity. Advanced networking enables Private Link integration and additional security capabilities beyond standard configurations. For feature availability and configuration requirements, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features).

## Configure private endpoint connectivity for enhanced security (optional)

Implement private endpoint connectivity when your security requirements mandate network traffic isolation through Azure Private Link. Skip this section if you selected public endpoint connectivity.

> [!IMPORTANT]
> Private endpoint connectivity requires advanced networking features enabled in your Azure region. Verify feature availability by following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features) before proceeding.

### Establish Azure Key Vault Private Endpoint

Create secure private connectivity between Oracle Exadata Database@Azure and Azure Key Vault through Private Endpoint configuration.

1. **Create Private Endpoint in the delegated subnet.** Navigate to your Key Vault networking settings in Azure Portal and create a Private Endpoint targeting the vault sub-resource. Select the same virtual network and delegated subnet where your Oracle Exadata Database@Azure deployment resides. Azure automatically creates a network interface with a private IP address in your subnet. For detailed Private Endpoint creation procedures, see [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service) and [Create a private endpoint](/azure/private-link/create-private-endpoint-portal).

2. **Record Private Endpoint configuration details for OCI DNS setup.** Navigate to the Private Endpoint resource in Azure Portal and access the DNS configuration section. Document the following information required for OCI DNS configuration:
   - Private Endpoint FQDN: `<keyvault-name>.privatelink.vaultcore.azure.net`
   - Private IP address (example: `10.0.0.4`)
   - Key Vault name without domain suffix (example: `mykeyvault`)

3. **Disable public network access to enforce private-only connectivity.** Navigate to Key Vault networking settings and disable public access. This configuration ensures all key operations from Oracle Database@Azure traverse the Private Endpoint path exclusively. Complete Private Endpoint validation before disabling public access to prevent configuration lockout.

### Configure OCI Private DNS zones for Key Vault resolution

Oracle Database@Azure resolves DNS queries through OCI Private Views. Create matching DNS zones to enable private Key Vault name resolution from database instances.

1. **Identify the OCI Private View for your deployment.** Navigate to the Oracle Database@Azure resource in Azure Portal and select "Go to OCI" to access the OCI Console. Note the Virtual Cloud Network (VCN) name assigned to your deployment (format: `VCN-multicloudnetworklink[timestamp]`). In OCI Console, navigate to Networking → DNS Management → Private Views and locate the Private View matching your VCN name.

2. **Create privatelink.vaultcore.azure.net Private DNS zone.** Within your identified Private View, create a new private zone named `privatelink.vaultcore.azure.net` to match the Azure-created zone. This zone handles resolution for the Private Endpoint FQDN. Set zone type to Primary and associate it with your OCI compartment. For OCI DNS zone creation procedures, see [Managing Private Views](https://docs.oracle.com/iaas/Content/DNS/Tasks/managingprivateviews.htm) and [Private endpoint DNS configuration](/azure/private-link/private-endpoint-dns).

3. **Create vault.azure.net Private DNS zone.** Create a second private zone named `vault.azure.net` within the same Private View. This zone enables the database to resolve the standard Key Vault FQDN to the private IP address. The dual-zone configuration supports both direct Private Endpoint access and standard Azure Key Vault SDK calls from Oracle Database@Azure.

4. **Add A records in both DNS zones pointing to Private Endpoint IP.** In each DNS zone, create an A record using your Key Vault name (without domain suffix) as the record name. Set the record value to the Private Endpoint private IP address documented during Azure configuration. For example, if your Key Vault is named `my-keyvault` with Private Endpoint IP `10.0.0.4`, create A record `my-keyvault` → `10.0.0.4` in both zones.

5. **Publish DNS changes to activate configuration.** After adding A records, review changes and select "Publish changes" in OCI Console to activate the DNS configuration. Allow 2-5 minutes for DNS record propagation across OCI infrastructure before proceeding to Oracle Identity Connector configuration.

## Establish Oracle Identity Connector for Azure Arc integration

Configure Oracle Identity Connector to enable secure communication between Oracle Exadata Database@Azure and Azure Key Vault through Azure Arc-enabled servers. This connector automatically registers database virtual machines as Azure Arc resources and establishes managed identity authentication.

1. **Generate Azure access token for Azure Arc registration.** Obtain an Azure access token using the Azure CLI with an account that has Owner or Contributor permissions on the subscription or resource group where Oracle Database@Azure resides. Execute `az account get-access-token` and record the `accessToken` value and your Azure tenant ID. The access token authorizes Oracle Identity Connector to register Azure Arc agents on your behalf. For access token requirements and troubleshooting, see [azcmagent connect reference](/azure/azure-arc/servers/azcmagent-connect#access-token).

2. **Create Oracle Identity Connector in OCI Console.** Navigate to your Exadata VM cluster resource in OCI Console and locate the Multicloud information section. Select "Create" for Identity connector and complete the form with your Azure tenant ID and access token. For private endpoint configurations, specify the Private Link scope name under Advanced options to enable private connectivity for Azure Arc communication.

3. **Verify Azure Arc server registration completion.** After connector creation, confirm that Oracle Database@Azure virtual machines appear as Azure Arc-enabled servers in Azure Portal under Azure Arc → Servers. Each database node creates a separate Azure Arc resource with a system-assigned managed identity for Azure service authentication.

4. **Configure Microsoft Entra ID permissions for Key Vault access.** Create a Microsoft Entra ID security group and assign Key Vault Crypto Officer and Key Vault Reader roles to the group at the Key Vault scope. Add the Azure Arc server managed identity principal IDs to this security group to grant Key Vault access permissions. This approach simplifies permission management across multiple database nodes. For role-based access control configuration, see [Azure Key Vault RBAC guide](/azure/key-vault/general/rbac-guide) and [Key Vault built-in roles](/azure/role-based-access-control/built-in-roles#key-vault-crypto-service-encryption-user).

For complete Oracle Identity Connector setup procedures including token generation, connector creation, and permission configuration, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-3-set-up-the-oracle-identity-connector).

## Enable Azure Key Vault integration and configure database encryption

Complete the final configuration steps to enable Azure Key Vault for TDE key management and configure database encryption. These procedures apply to both public and private endpoint connectivity models.

1. **Enable Azure Key Vault key management on the VM cluster.** Navigate to your Exadata VM cluster details page in OCI Console and locate the Multicloud information section. Select "Enable" for Azure key store to install the required Oracle library on cluster VMs. This cluster-level setting makes Azure Key Vault available as a key management option for databases without automatically switching existing databases. For detailed procedures, see [Enable Azure Key Vault integration](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-4-enable-azure-key-vault-integration-on-vm-cluster).

2. **Register Azure Key Vault in OCI Console.** Navigate to Database Multicloud Integrations → Microsoft Azure Integration → Azure Key Vaults and select "Register Azure key vaults." Choose your compartment and identity connector, then select "Discover" to list available Key Vaults. Select your Key Vault from the discovered list and complete registration. Registration creates the association between your Key Vault and Oracle Identity Connector for database access.

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

Address frequent configuration problems that occur during Azure Key Vault integration with Oracle Exadata Database@Azure.


> [!TIP]
> For comprehensive troubleshooting of Oracle Database@Azure TDE with Azure Key Vault, see [Integrate Oracle Exadata Database@Azure with Azure Key Vault - Troubleshooting common problems](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems).

### Common issues (all connectivity models)

| Issue | Root Cause | Resolution | Official References |
|-------|------------|------------|-------------------|
| Database fails to open with ORA-28374 error | Database cannot access Key Vault keys or key URI incorrect | Verify Key Vault registration in OCI Console. Confirm managed identity has correct permissions. Check Key Vault firewall rules allow database access. | [Common errors for TDE with customer-managed keys](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems), [Troubleshoot Azure Key Vault access denied errors](/azure/key-vault/general/troubleshooting-access-issues) |
| Key Vault access denied errors in Oracle logs (ORA-28417) | Managed identity lacks sufficient permissions or RBAC role not configured | Verify managed identity has "Key Vault Crypto Service Encryption User" role assigned in Azure RBAC. Fix RBAC assignments and retry key management operation. | [Authorization errors troubleshooting](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems), [Azure Key Vault RBAC guide](/azure/key-vault/general/rbac-guide) |
| Azure Arc connector appears disconnected | Network connectivity issues or Azure Arc agent status problems | Check VM connectivity to `login.microsoftonline.com` and Key Vault endpoint. Verify Azure Arc agent status using `sudo systemctl status azuremeeting`. Test DNS resolution if using Private Link. | [Azure Arc connector problems](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems), [Azure Arc agent troubleshooting](/azure/azure-arc/servers/troubleshoot-agent-onboard) |
| Oracle Identity Connector token expiration during setup | Azure access token expired before connector creation completed | Generate fresh Azure access token using `az account get-access-token` and submit connector form within token validity period (typically minutes). | [Token expiration during connector setup](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#troubleshooting-common-problems), [Azure access tokens](/azure/azure-arc/servers/azcmagent-connect#access-token) |

### Private endpoint specific issues

| Issue | Root Cause | Resolution | Official References |
|-------|------------|------------|-------------------|
| Private endpoint DNS resolution failure | DNS zones missing in OCI Private Views or incorrect A records | Verify both DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) exist in OCI Private View with correct A records pointing to private endpoint IP. Execute nslookup test from delegated subnet. | [Private endpoint DNS configuration](/azure/private-link/private-endpoint-dns), [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513) |
| Cannot create private endpoint to Key Vault | Advanced networking not enabled or insufficient delegated subnet IP space | Confirm advanced networking enabled following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). Verify delegated subnet has available IP addresses for private endpoint network interface. | [Advanced networking features](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features), [Private endpoint network requirements](/azure/private-link/private-endpoint-overview#network-security-of-private-endpoints) |
| Private endpoint connectivity timeout | Network routing or private endpoint connection not approved | Test network connectivity from delegated subnet to private endpoint IP address. Confirm private endpoint connection approved in Azure Portal. Validate OCI Private Views DNS zone configuration. | [Troubleshoot private endpoint connectivity](/azure/private-link/troubleshoot-private-endpoint-connectivity), [Private endpoint connection states](/azure/private-link/private-endpoint-overview#private-endpoint-properties) |
| Azure Arc registration fails through private endpoint | Private Link scope not configured or DNS resolution issues for Azure Arc endpoints | Configure Private Link scope for Azure Arc following Microsoft requirements. Verify DNS resolution for Azure Arc endpoints through private connectivity. Ensure Azure Arc private endpoint properly configured. | [Azure Arc Private Link configuration](/azure/azure-arc/servers/private-link-security), [Azure Arc connectivity requirements](/azure/azure-arc/servers/network-requirements) |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Key Management | [Azure Key Vault](/azure/key-vault/general/overview) | Secure storage and lifecycle management for TDE master encryption keys |
| Network Security | [Azure Private Link](/azure/private-link/private-link-overview) | Private connectivity from Oracle Database@Azure to Key Vault (optional) |
| DNS Management | OCI Private Views | DNS resolution for private Key Vault endpoints (private endpoint connectivity only) |
| Identity | [Azure Active Directory](/entra/fundamentals/whatis) | Service principal authentication for database-to-Key Vault operations |
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Key Vault access logging and operational metrics |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security posture management and threat detection |

## Related resources

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Core network design for Oracle Database@Azure](core-network-design.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)
- [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault)
- [Azure Key Vault integration with Autonomous Database@Azure](oracle-akv-integration-autonomous.md)