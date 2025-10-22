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

This article provides guidance for configuring Azure Key Vault to store and manage Oracle Transparent Data Encryption (TDE) master encryption keys for Oracle Exadata Database@Azure deployments. Azure Key Vault integration enables centralized key management within Azure security boundaries while maintaining Oracle Exadata's performance capabilities and supporting Azure-native governance policies.

Oracle Exadata Database@Azure uses Azure Arc-enabled servers and Oracle Identity Connector to establish secure communication with Azure Key Vault. The integration supports both public endpoint connectivity (default configuration) and private endpoint connectivity (enhanced security isolation through Azure Private Link). This approach standardizes key management practices across Azure resources while meeting enterprise security and compliance requirements.

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

1. **Create Private Endpoint in the delegated subnet.** Navigate to your Key Vault networking settings in Azure Portal and create a Private Endpoint targeting the vault sub-resource. Select the same virtual network and delegated subnet where your Oracle Exadata Database@Azure deployment resides. Azure automatically creates a network interface with a private IP address in your subnet. For detailed Private Endpoint creation procedures, see [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service).

2. **Record Private Endpoint configuration details for OCI DNS setup.** Navigate to the Private Endpoint resource in Azure Portal and access the DNS configuration section. Document the following information required for OCI DNS configuration:
   - Private Endpoint FQDN: `<keyvault-name>.privatelink.vaultcore.azure.net`
   - Private IP address (example: `10.0.0.4`)
   - Key Vault name without domain suffix (example: `mykeyvault`)

3. **Disable public network access to enforce private-only connectivity.** Navigate to Key Vault networking settings and disable public access. This configuration ensures all key operations from Oracle Database@Azure traverse the Private Endpoint path exclusively. Complete Private Endpoint validation before disabling public access to prevent configuration lockout.

### Configure OCI Private DNS zones for Key Vault resolution

Oracle Database@Azure resolves DNS queries through OCI Private Views. Create matching DNS zones to enable private Key Vault name resolution from database instances.

1. **Identify the OCI Private View for your deployment.** Navigate to the Oracle Database@Azure resource in Azure Portal and select "Go to OCI" to access the OCI Console. Note the Virtual Cloud Network (VCN) name assigned to your deployment (format: `VCN-multicloudnetworklink[timestamp]`). In OCI Console, navigate to Networking → DNS Management → Private Views and locate the Private View matching your VCN name.

2. **Create privatelink.vaultcore.azure.net Private DNS zone.** Within your identified Private View, create a new private zone named `privatelink.vaultcore.azure.net` to match the Azure-created zone. This zone handles resolution for the Private Endpoint FQDN. Set zone type to Primary and associate it with your OCI compartment. For OCI DNS zone creation procedures, see [Managing Private Views](https://docs.oracle.com/iaas/Content/DNS/Tasks/managingprivateviews.htm).

3. **Create vault.azure.net Private DNS zone.** Create a second private zone named `vault.azure.net` within the same Private View. This zone enables the database to resolve the standard Key Vault FQDN to the private IP address. The dual-zone configuration supports both direct Private Endpoint access and standard Azure Key Vault SDK calls from Oracle Database@Azure.

4. **Add A records in both DNS zones pointing to Private Endpoint IP.** In each DNS zone, create an A record using your Key Vault name (without domain suffix) as the record name. Set the record value to the Private Endpoint private IP address documented during Azure configuration. For example, if your Key Vault is named `my-keyvault` with Private Endpoint IP `10.0.0.4`, create A record `my-keyvault` → `10.0.0.4` in both zones.

5. **Publish DNS changes to activate configuration.** After adding A records, review changes and select "Publish changes" in OCI Console to activate the DNS configuration. Allow 2-5 minutes for DNS record propagation across OCI infrastructure before proceeding to database configuration.

### Configure database for private endpoint routing

Direct Oracle Database@Azure to route all outbound connections through private endpoints instead of public endpoints.

1. **Connect to Oracle database with administrative privileges.** Establish a SQL*Plus or SQL Developer connection to your Oracle database using the ADMIN credential with full administrative access.

2. **Configure database property for private endpoint routing.** Execute the following SQL command to direct the database to use private endpoints for all outbound connections:
   ```sql
   ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
   ```
   This setting directs the database to resolve all outbound FQDNs using the OCI Private DNS zones configured in the previous steps.

3. **Restart the Oracle database to apply configuration changes.** Navigate to OCI Console, locate your Oracle Database@Azure VM cluster, and select the database instance. Initiate a database restart from the lifecycle management options. Database restart typically completes within 5-10 minutes.

4. **Verify private endpoint enforcement after database restart.** After restart completes, reconnect as ADMIN and execute the following query to confirm configuration:
   ```sql
   SELECT PROPERTY_NAME, PROPERTY_VALUE 
   FROM DATABASE_PROPERTIES 
   WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS';
   ```
   The query should return `enforce_private_endpoint` as the property value, confirming successful private endpoint configuration.

### Validate Private Endpoint connectivity

Validate DNS resolution and connectivity before proceeding with Oracle Identity Connector configuration.

1. **Configure network ACL for connectivity validation.** Connect to your database as ADMIN and execute the following PL/SQL block to allow HTTPS connectivity for testing:
   ```sql
   BEGIN
     DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
       host => '<keyvault-name>.vault.azure.net',
       lower_port => 443,
       upper_port => 443,
       ace => xs$ace_type(
         privilege_list => xs$name_list('connect'),
         principal_name => 'ADMIN',
         principal_type => xs_acl.ptype_db
       )
     );
   END;
   /
   ```

2. **Execute connectivity health check.** Run the following PL/SQL block to validate database can reach Key Vault through the private endpoint:
   ```sql
   SET SERVEROUTPUT ON;
   BEGIN
     DECLARE
       req UTL_HTTP.REQ;
       resp UTL_HTTP.RESP;
     BEGIN
       req := UTL_HTTP.BEGIN_REQUEST('https://<keyvault-name>.vault.azure.net/healthstatus');
       UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Mozilla/4.0');
       resp := UTL_HTTP.GET_RESPONSE(req);
       DBMS_OUTPUT.PUT_LINE('Status: ' || resp.status_code);
       UTL_HTTP.END_RESPONSE(resp);
     END;
   END;
   /
   ```
   Successful response (HTTP 200) confirms the database resolves the Key Vault FQDN to the Private Endpoint IP and establishes HTTPS connectivity through the private path.

## Establish Oracle Identity Connector for Azure Arc integration

Configure Oracle Identity Connector to enable secure communication between Oracle Exadata Database@Azure and Azure Key Vault through Azure Arc-enabled servers. This connector automatically registers database virtual machines as Azure Arc resources and establishes managed identity authentication.

1. **Generate Azure access token for Azure Arc registration.** Obtain an Azure access token using the Azure CLI with an account that has Owner or Contributor permissions on the subscription or resource group where Oracle Database@Azure resides. Execute `az account get-access-token` and record the `accessToken` value and your Azure tenant ID. The access token authorizes Oracle Identity Connector to register Azure Arc agents on your behalf.

2. **Create Oracle Identity Connector in OCI Console.** Navigate to your Exadata VM cluster resource in OCI Console and locate the Multicloud information section. Select "Create" for Identity connector and complete the form with your Azure tenant ID and access token. For private endpoint configurations, specify the Private Link scope name under Advanced options to enable private connectivity for Azure Arc communication.

3. **Verify Azure Arc server registration completion.** After connector creation, confirm that Oracle Database@Azure virtual machines appear as Azure Arc-enabled servers in Azure Portal under Azure Arc → Servers. Each database node creates a separate Azure Arc resource with a system-assigned managed identity for Azure service authentication.

4. **Configure Microsoft Entra ID permissions for Key Vault access.** Create a Microsoft Entra ID security group and assign Key Vault Crypto Officer and Key Vault Reader roles to the group at the Key Vault scope. Add the Azure Arc server managed identity principal IDs to this security group to grant Key Vault access permissions. This approach simplifies permission management across multiple database nodes.

For complete Oracle Identity Connector setup procedures including token generation, connector creation, and permission configuration, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-3-set-up-the-oracle-identity-connector).

## Enable Azure Key Vault integration and configure database encryption

Complete the final configuration steps to enable Azure Key Vault for TDE key management and configure database encryption. These procedures apply to both public and private endpoint connectivity models.

1. **Enable Azure Key Vault key management on the VM cluster.** Navigate to your Exadata VM cluster details page in OCI Console and locate the Multicloud information section. Select "Enable" for Azure key store to install the required Oracle library on cluster VMs. This cluster-level setting makes Azure Key Vault available as a key management option for databases without automatically switching existing databases.

2. **Register Azure Key Vault in OCI Console.** Navigate to Database Multicloud Integrations → Microsoft Azure Integration → Azure Key Vaults and select "Register Azure key vaults." Choose your compartment and identity connector, then select "Discover" to list available Key Vaults. Select your Key Vault from the discovered list and complete registration. Registration creates the association between your Key Vault and Oracle Identity Connector for database access.

3. **Configure database to use Azure Key Vault for TDE.** For new databases, select "Azure Key Vault" as the key management option during database creation and choose your registered vault and key. For existing databases, navigate to the database details page, locate the Encryption section, and select "Change" to switch from Oracle Wallet to Azure Key Vault. Choose your registered vault and encryption key to complete the migration.

4. **Validate database encryption configuration.** Verify the database details page in OCI Console displays "Azure Key Vault" as the key management method with the correct key name listed. This confirmation indicates successful integration between the database and Azure Key Vault for TDE operations.

For complete Azure Key Vault registration procedures and database encryption configuration steps, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#step-5-register-the-key-vault-in-oci-optional-as-needed).

## Validate Azure Key Vault integration and security

Confirm Azure Key Vault integration functions correctly and database encryption operations use Azure-managed keys.

1. **Verify database access and TDE operations.** Connect to your Oracle database and perform standard read and write operations on encrypted tablespaces. TDE operations should execute transparently without errors. If the database cannot access Azure Key Vault keys, error ORA-28374 ("protected by master key not found") appears when opening the database, indicating configuration issues requiring troubleshooting.

2. **Confirm Key Vault integration status in OCI Console.** Navigate to your database details page in OCI Console and locate the Encryption section. Verify the display shows "Customer-managed key (Microsoft Azure)" as the encryption key management option with the correct vault URI and key name. This confirmation indicates Oracle's control plane recognizes the database association with external key management.

3. **Monitor Azure Key Vault access logs for database operations.** Enable diagnostic logging in Azure Portal for your Key Vault and configure Log Analytics workspace integration. Filter logs for wrap/unwrap key operations from the Azure Arc server managed identity to confirm successful database key access. Review access patterns to ensure operations align with expected database activity. For Key Vault monitoring configuration, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault).

4. **Test database restart to validate key retrieval on startup.** Simulate a database restart to ensure the database can retrieve encryption keys from Azure Key Vault during startup without manual intervention. Shut down and restart the Oracle database from OCI Console. Successful database startup without errors confirms the integration provides reliable key access for operational scenarios including maintenance windows and failover events.

## Operational procedures

Establish procedures for ongoing key management operations and monitoring.

### Key lifecycle management

For general key lifecycle operations including key rotation, backup encryption, and disaster recovery procedures, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

### Private endpoint specific operations

When using private endpoint connectivity, implement these additional operational procedures:

1. **Monitor Private Endpoint connectivity health.** Configure Azure Monitor alerts for Private Endpoint connection state changes and network interface health. Private Endpoint connectivity issues can prevent database access to encryption keys. For monitoring configuration, see [Monitor Private Link](/azure/private-link/private-link-overview#logging-and-monitoring).

2. **Maintain DNS zone consistency during infrastructure changes.** When making changes to Private Endpoint IP addresses or Key Vault configurations, immediately update corresponding A records in both OCI DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`). DNS inconsistencies can cause key operation failures and database startup issues.

3. **Document Private Endpoint disaster recovery procedures.** Include Private Endpoint and OCI DNS zone configuration in your disaster recovery documentation. Ensure procedures cover recreating Private Endpoints and DNS zones during regional failover scenarios.

## Troubleshoot common integration issues

Address frequent configuration problems that occur during Azure Key Vault integration with Oracle Exadata Database@Azure.

### Common issues (all connectivity models)

| Issue | Root Cause | Resolution |
|-------|------------|------------|
| Database fails to open with ORA-28374 error | Database cannot access Key Vault keys or key URI incorrect | Verify Key Vault registration in OCI Console. Confirm service principal has correct permissions. Check Key Vault firewall rules allow database access. |
| Key Vault access denied errors in Oracle logs | Service principal lacks sufficient permissions or access policy not configured | Verify service principal has "Key Vault Crypto Service Encryption User" role assigned in Azure RBAC or access policy grants Get, Wrap Key, and Unwrap Key operations. |
| Key operations succeed but performance degraded | Network latency or suboptimal routing | Verify Key Vault and Oracle Database@Azure deployed in same Azure region. Consider upgrading to Premium or Managed HSM tier for improved performance. |
| OCI Console shows Key Vault registered but database cannot access keys | Clock skew between Oracle database and Azure Active Directory or expired service principal credentials | Synchronize database server time using NTP. Verify service principal credentials have not expired in Azure Active Directory. Re-authenticate service principal. |

### Private endpoint specific issues

| Issue | Root Cause | Resolution |
|-------|------------|------------|
| Database fails to open with ORA-28374 error (private endpoint) | Private Endpoint DNS resolution failure or incorrect DNS zone configuration in OCI | Verify both DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) exist in OCI Private View with correct A records. Execute nslookup test from delegated subnet to confirm resolution to private IP address. |
| Cannot create Private Endpoint to Key Vault | Advanced networking features not enabled or insufficient IP space in delegated subnet | Confirm advanced networking enabled in region following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). Verify delegated subnet has available IP addresses for Private Endpoint NIC. |
| Outbound connectivity to Key Vault times out (private endpoint) | Database not configured with correct outbound routing property or database not restarted after property change | Execute `ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint'` and restart database from OCI Console. Verify property persists after restart using `SELECT PROPERTY_NAME, PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS'`. |
| Oracle Identity Connector creation fails | Invalid Azure access token or insufficient permissions | Generate fresh Azure access token using `az account get-access-token` and verify account has Owner or Contributor role on subscription or resource group. Ensure Microsoft.HybridCompute resource provider is registered in Azure subscription. |

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