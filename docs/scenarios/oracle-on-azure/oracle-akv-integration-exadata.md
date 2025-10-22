---
title: Azure Key Vault Integration for Oracle Exadata Database@Azure
description: Configure Azure Key Vault with private endpoint connectivity to manage TDE encryption keys for Oracle Exadata Database@Azure with step-by-step implementation guidance.
author: gereyeso
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 2025-10-22
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Exadata Database@Azure

Azure Key Vault provides centralized Transparent Data Encryption (TDE) key management for Oracle Exadata Database@Azure through private endpoint connectivity. This integration maintains database performance while meeting Azure-native security and compliance requirements. Organizations can standardize key management practices across Azure resources while leveraging Oracle Exadata's high-performance database capabilities.

This article provides implementation guidance for configuring Azure Key Vault as the TDE master encryption key store for Oracle Exadata Database@Azure using private endpoints and Oracle Cloud Infrastructure (OCI) Private DNS integration. The guidance addresses network configuration, identity management, database setup, and operational procedures required for successful implementation.

## Prerequisites and environment preparation

Validate your environment meets these prerequisites before implementing Azure Key Vault integration. Oracle Exadata Database@Azure requires advanced networking features and specific network configurations to establish secure private connectivity to Azure Key Vault.

1. **Enable advanced networking features for Oracle Database@Azure.** Advanced networking must be enabled in your Azure region to support Private Endpoint connectivity between Oracle Database@Azure and Azure Key Vault. Verify feature availability and enable it following guidance in [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). This feature enables the private connectivity required for secure key operations without internet exposure.

2. **Validate delegated subnet configuration and available IP space.** Your Oracle Database@Azure delegated subnet requires sufficient IP address space to accommodate the Key Vault Private Endpoint in addition to database infrastructure. Review your subnet configuration and ensure at least one available IP address for the Private Endpoint. Consider future growth when planning subnet sizing to avoid reconfiguration later. For subnet planning guidance, see [Plan for IP address space for Oracle Exadata Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

3. **Verify Azure Key Vault service tier requirements.** Oracle Database@Azure supports all three Azure Key Vault tiers: Standard (software-protected keys for non-production), Premium (HSM-protected keys for production), and Managed HSM (FIPS 140-3 Level 3 validated HSMs for high-security requirements). Select the appropriate tier based on your security, compliance, and performance requirements. For tier comparison, see [About Azure Key Vault](/azure/key-vault/general/overview).

4. **Confirm access to both Azure Portal and OCI Console.** Implementation requires administrative access to both Azure Portal for creating Azure resources (Key Vault, Private Endpoint) and OCI Console for configuring DNS zones and database encryption settings. Ensure your credentials provide sufficient permissions on both platforms before beginning configuration. The [Contributor role](/azure/role-based-access-control/built-in-roles#contributor) on the Azure subscription provides minimum required permissions for Key Vault and Private Endpoint operations.

## Configure Azure Key Vault with private endpoint

Establish secure private connectivity between Oracle Exadata Database@Azure and Azure Key Vault through Private Endpoint configuration. This setup ensures all TDE key operations traverse private network paths without internet exposure while maintaining integration with Azure security controls.

1. **Create Azure Key Vault in the same region as Oracle Database@Azure.** Provision Key Vault in the same Azure region where your Oracle Exadata Database@Azure deployment resides to minimize latency and ensure compliance with data residency requirements. During creation, select your required service tier (Standard, Premium, or Managed HSM) and configure access control using either Azure role-based access control (RBAC) or Vault Access Policy model. For step-by-step Key Vault creation, see [Quickstart: Create a key vault using Azure Portal](/azure/key-vault/general/quick-create-portal).

2. **Generate TDE master encryption key with supported algorithm and size.** Create an RSA encryption key within Key Vault to serve as the TDE master encryption key. Oracle Database@Azure supports RSA 2048-bit, 3072-bit, and 4096-bit keys. Select key size based on your security requirements, noting that larger keys provide stronger encryption at the cost of slight performance impact. Enable key operations: Get, Wrap Key, and Unwrap Key to support TDE operations. For supported key specifications, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

3. **Create Private Endpoint in the delegated subnet.** Navigate to your Key Vault networking settings and create a Private Endpoint targeting the vault sub-resource. Select the same virtual network and delegated subnet where your Oracle Exadata Database@Azure deployment resides. This configuration establishes private connectivity between the database infrastructure and Key Vault. Azure automatically creates a network interface with a private IP address in your subnet for the Private Endpoint connection. For Private Endpoint creation steps, see [Create a private endpoint](/azure/private-link/create-private-endpoint-portal).

4. **Configure Azure Private DNS zone for initial setup.** During Private Endpoint creation, allow Azure to automatically create the Private DNS zone `privatelink.vaultcore.azure.net` with the appropriate A record pointing to the Private Endpoint's private IP address. Record the Key Vault FQDN and private IP address displayed in the Private Endpoint DNS configuration blade. These values are required for OCI DNS configuration in the next section. For Private Link integration details, see [Integrate Key Vault with Azure Private Link](/azure/key-vault/general/private-link-service).

5. **Disable public network access after Private Endpoint validation.** After completing Private Endpoint setup and recording necessary information, navigate to Key Vault networking settings and disable public network access to enforce private-only connectivity. This configuration ensures all key operations from Oracle Database@Azure traverse the private network path. Test Private Endpoint connectivity before disabling public access to prevent configuration lockout.

## Configure Private DNS zones in OCI infrastructure

Oracle Database@Azure resolves DNS queries through OCI Private Views within the virtual cloud network. Create matching DNS zones in the OCI infrastructure to enable private Key Vault name resolution from database instances without internet routing.

1. **Identify the OCI Private View for your deployment.** Navigate to the Oracle Database@Azure resource in Azure Portal and select "Go to OCI" to access the OCI Console. On the database information page, note the VCN name assigned to your deployment (format: `VCN-multicloudnetworklink[timestamp]`). In OCI Console, navigate to Networking → DNS Management → Private Views and locate the Private View matching your VCN name. This view manages DNS resolution for your database infrastructure.

2. **Create privatelink.vaultcore.azure.net Private DNS zone.** Within your identified Private View, create a new private zone named `privatelink.vaultcore.azure.net` to match the Azure-created zone. This zone handles resolution for the Private Endpoint FQDN. Set zone type to Primary and associate it with your OCI compartment. For OCI DNS zone creation procedures, see [Managing Private Views](https://docs.oracle.com/iaas/Content/DNS/Tasks/managingprivateviews.htm).

3. **Create vault.azure.net Private DNS zone for public FQDN resolution.** Create a second private zone named `vault.azure.net` within the same Private View. This zone enables the database to resolve the standard Key Vault FQDN to the private IP address, allowing Oracle's TDE integration to function correctly without requiring code changes. The dual-zone configuration supports both direct Private Endpoint access and standard Azure Key Vault SDK calls.

4. **Add A records in both DNS zones pointing to Private Endpoint IP.** In each DNS zone created above, add an A record using your Key Vault name (without domain suffix) as the record name. Set the record value to the Private Endpoint private IP address recorded during Azure configuration. For example, if your Key Vault is named `my-keyvault` with Private Endpoint IP `10.0.0.4`, create A record `my-keyvault` → `10.0.0.4` in both zones. This configuration ensures both FQDNs (`my-keyvault.vault.azure.net` and `my-keyvault.privatelink.vaultcore.azure.net`) resolve to the private address.

5. **Publish DNS changes and validate record propagation.** After adding A records, review changes and select "Publish changes" in OCI Console to activate the DNS configuration. Allow 2-5 minutes for DNS record propagation across OCI infrastructure. Validation of DNS resolution from database instances is covered in the verification section below.

## Configure identity and access for Key Vault operations

Oracle Exadata Database@Azure requires service principal authentication to access Azure Key Vault for TDE operations. Configure the database identity and grant appropriate Key Vault permissions to enable encryption key retrieval and management.

1. **Create ADBS service principal for Azure Key Vault authentication.** Connect to your Oracle database as ADMIN user using SQL*Plus, SQL Developer, or another SQL client. The database requires a configured principal identity to authenticate with Azure Key Vault. This configuration establishes the trust relationship between Oracle Database@Azure and Azure Active Directory for key operations. For complete service principal configuration procedures, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#configure-the-database).

2. **Grant Key Vault access using Azure RBAC or Access Policy model.** Navigate to your Key Vault in Azure Portal and configure access permissions for the database service principal. If using Azure RBAC, assign the "Key Vault Crypto Service Encryption User" role to the service principal, granting permissions to retrieve, wrap, and unwrap encryption keys. If using Access Policy model, create an access policy with Get, Wrap Key, and Unwrap Key key permissions. For access configuration guidance, see [Assign a Key Vault access policy](/azure/key-vault/general/assign-access-policy).

3. **Configure network ACL to allow requests from Private Endpoint.** In Key Vault networking settings, verify that the Private Endpoint created earlier is listed under "Private endpoint connections" with "Approved" status. If using Access Policy model with selected networks, add the delegated subnet's IP range to the firewall allowed IP addresses as a backup access path. This configuration ensures database connectivity during Private Endpoint maintenance or troubleshooting scenarios.

4. **Validate service principal authentication before database configuration.** Test the service principal's ability to authenticate with Key Vault by connecting to any VM in the delegated subnet and executing a test key operation using Azure CLI or SDK with the service principal credentials. Successful authentication confirms proper identity configuration before proceeding to database TDE setup. This validation prevents authentication errors during database encryption configuration.

## Enable private endpoint enforcement for database connectivity

Oracle Database@Azure requires explicit configuration to route all outbound connections, including Azure Key Vault requests, through private endpoints instead of default public endpoints. Configure this enforcement before associating Key Vault with TDE operations.

1. **Connect to Oracle database as ADMIN user with administrative privileges.** Establish a SQL*Plus or SQL Developer connection to your Oracle database using the ADMIN credential. This account has the necessary privileges to modify database-level properties that control network routing behavior. Ensure your connection is stable and authenticated before executing configuration commands.

2. **Execute ALTER DATABASE command to enforce private endpoint routing.** Run the following SQL command to configure the database to route all outbound connections through private endpoints:

   ```sql
   ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
   ```

   This setting directs the database to resolve all outbound FQDNs using the OCI Private DNS zones configured earlier, ensuring Azure Key Vault access occurs exclusively through the Private Endpoint. For more information about database properties, see [Oracle Database@Azure networking documentation](/azure/oracle/oracle-db/oracle-database-network-plan).

3. **Restart the Oracle database to apply network configuration changes.** Navigate to OCI Console, locate your Oracle Database@Azure VM cluster, and select the database instance. Initiate a database restart from the lifecycle management options. The restart applies the `enforce_private_endpoint` property change. Database restart typically completes within 5-10 minutes depending on database size and configuration. Monitor restart progress in OCI Console.

4. **Verify private endpoint enforcement after database restart.** After database restart completes, reconnect as ADMIN and execute a test query to confirm the property setting persists:

   ```sql
   SELECT PROPERTY_NAME, PROPERTY_VALUE 
   FROM DATABASE_PROPERTIES 
   WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS';
   ```

   The query should return `enforce_private_endpoint` as the property value, confirming successful configuration. If the value differs, repeat the ALTER DATABASE command and restart procedure.

## Register Azure Key Vault in OCI and configure database encryption

After establishing private network connectivity and identity configuration, register your Azure Key Vault with Oracle Cloud Infrastructure and configure your database to use it for TDE master encryption key storage.

1. **Register Azure Key Vault in OCI Console via Oracle Database@Azure interface.** Navigate to OCI Console through the "Go to OCI" link from your Azure Portal Oracle Database@Azure resource. Access the Key Management or Vault section and register your Azure Key Vault by providing the vault URI (format: `https://<keyvault-name>.vault.azure.net`) and the key name created earlier. OCI validates connectivity through the Private Endpoint before completing registration. This step establishes the trust relationship between OCI control plane and your Azure Key Vault.

2. **Configure IAM policies in OCI to allow Key Vault management.** Ensure your OCI tenant has the appropriate IAM policy to manage Azure Key Vault associations. Oracle recommends the policy: `allow any-user to manage oracle-db-azure-vaults in tenancy`. This policy enables the Exadata VM cluster resource to manage Key Vault associations. Your cloud administrator may have already configured this policy during initial Oracle Database@Azure setup. For IAM policy details, see [OCI Identity and Access Management documentation](https://docs.oracle.com/iaas/Content/Identity/Concepts/overview.htm).

3. **Create new database with Azure Key Vault encryption during provisioning.** When creating a new Oracle database on the Exadata VM cluster through OCI Console, access the Create Database wizard. In the Key Management or Encryption section, select "Azure Key Vault" from the dropdown instead of "Oracle-managed Wallet." Choose your registered Key Vault from the compartment list and select the specific key to use for TDE. Complete remaining database parameters (database name, character set, PDB configuration) and initiate creation. The database provisions with Azure Key Vault-managed TDE from initial startup.

4. **Migrate existing database from Oracle Wallet to Azure Key Vault.** For databases currently using local Oracle Wallet for TDE, navigate to the database details page in OCI Console and select "Manage Encryption Key." Select "Azure Key Vault" as the new key management option, choose your registered vault and key, and confirm the migration. OCI orchestrates the TDE key migration process, re-encrypting the database encryption key with the new Azure Key Vault master key. This operation completes online without database downtime. For migration procedures, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

## Validate connectivity and encryption functionality

Comprehensive validation ensures all components function correctly before transitioning to production use. Test both network connectivity and encryption operations to confirm successful Azure Key Vault integration.

1. **Validate Private Endpoint DNS resolution from database instance.** Optional but recommended: Configure network ACL to allow administrative connections to Key Vault from the delegated subnet temporarily. Connect to your database as ADMIN and execute the following PL/SQL block to test DNS resolution:

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

   Then execute a health check:

   ```sql
   SET SERVEROUTPUT ON;
   BEGIN
     DECLARE
       req UTL_HTTP.REQ;
       resp UTL_HTTP.RESP;
       value VARCHAR2(1024);
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

   Successful response (HTTP 200) confirms the database resolves the Key Vault FQDN to the Private Endpoint IP and can establish HTTPS connectivity. This validation confirms proper DNS zone configuration in OCI.

2. **Verify TDE operations use Azure Key Vault keys.** Connect to your database and attempt to read and write data to encrypted tablespaces. TDE operations should execute transparently without errors. If the database cannot access Azure Key Vault keys, you receive error ORA-28374 ("protected by master key not found") when opening the database. Successful data operations confirm proper TDE integration with Azure Key Vault.

3. **Confirm Key Vault integration in OCI Console.** Navigate to your database details page in OCI Console. The Encryption section should display "Customer-managed key (Microsoft Azure)" as the encryption key management option, with the vault URI and key name visible. This information indicates OCI control plane successfully tracks the Key Vault association and can manage key lifecycle operations.

4. **Monitor Key Vault access logs for database operations.** In Azure Portal, navigate to your Key Vault and access the Monitoring section. Enable diagnostic logging to send Key Vault access logs to Log Analytics workspace. Filter logs for wrap/unwrap key operations from the database service principal. Successful operations in Key Vault logs correlate with database encryption activity, providing audit trail for compliance requirements. For Key Vault monitoring setup, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault).

## Implement operational procedures for key lifecycle management

Establish procedures for ongoing key management operations including key rotation, backup encryption handling, and disaster recovery scenarios. These procedures ensure continuous database availability while maintaining security compliance.

1. **Implement master encryption key rotation procedures.** Azure Key Vault supports versioned keys, allowing creation of new key versions without changing the key name or URI. When rotating the TDE master encryption key, generate a new version in Azure Key Vault, then update the database configuration in OCI Console to reference the new key version. Oracle Database@Azure supports online key rotation without database restart. Schedule key rotation according to your security policies, typically annually or after security incidents. For key rotation guidance, see [Rotate an encryption key](/azure/key-vault/keys/how-to-configure-key-rotation).

2. **Configure backup encryption to use Key Vault keys.** Oracle database backups automatically encrypt using the same TDE master encryption key from Azure Key Vault. Ensure your backup retention policies align with key retention policies in Key Vault. Store backups and encryption keys in separate geographic locations to enhance disaster recovery capabilities. Retain old key versions in Key Vault for the duration of your backup retention period to enable restoration of archived backups.

3. **Establish key availability monitoring and alerting.** Configure Azure Monitor alerts for Key Vault operations including key access failures, disabled keys, or approaching key expiration dates. Create action groups that notify database administrators and security teams when key-related issues occur. Proactive monitoring prevents database outages caused by key accessibility problems. For monitoring configuration, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault).

4. **Document disaster recovery procedures for Key Vault unavailability.** Develop and test procedures for scenarios where Azure Key Vault becomes temporarily unavailable. Options include configuring automatic key caching in Oracle database, establishing cross-region Key Vault replication using Private Link, or maintaining emergency access to OCI Vault as a fallback. Document the process for identifying Key Vault outages and executing recovery procedures. Regularly test disaster recovery procedures to validate effectiveness.

## Troubleshoot common integration issues

Address frequent configuration problems that occur during Azure Key Vault integration with Oracle Exadata Database@Azure. These solutions resolve the most common issues encountered during implementation and operation.

| Issue | Root Cause | Resolution |
|-------|------------|------------|
| Database fails to open with ORA-28374 error | Private Endpoint DNS resolution failure or incorrect DNS zone configuration in OCI | Verify both DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`) exist in OCI Private View with correct A records. Execute nslookup test from delegated subnet to confirm resolution to private IP address. |
| Key Vault access denied errors in Oracle logs | Service principal lacks sufficient permissions or access policy not configured | Verify service principal has "Key Vault Crypto Service Encryption User" role assigned in Azure RBAC or access policy grants Get, Wrap Key, and Unwrap Key operations. Check Private Endpoint connection status is "Approved." |
| Cannot create Private Endpoint to Key Vault | Advanced networking features not enabled or insufficient IP space in delegated subnet | Confirm advanced networking enabled in region following [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features). Verify delegated subnet has available IP addresses for Private Endpoint NIC. |
| Outbound connectivity to Key Vault times out | Database not configured with `enforce_private_endpoint` property or database not restarted after property change | Execute `ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint'` and restart database from OCI Console. Verify property persists after restart using `SELECT PROPERTY_NAME, PROPERTY_VALUE FROM DATABASE_PROPERTIES`. |
| Key operations succeed but performance degraded | Network latency from suboptimal Private Endpoint routing or Key Vault tier selection | Verify Key Vault and Oracle Database@Azure deployed in same Azure region. Consider upgrading to Premium or Managed HSM tier for improved performance. Review Private Endpoint network path for additional network hops. |
| OCI Console shows Key Vault registered but database cannot access keys | Clock skew between Oracle database and Azure Active Directory or expired service principal credentials | Synchronize database server time using NTP. Verify service principal credentials have not expired in Azure Active Directory. Re-authenticate service principal and update database configuration. |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Key Management | [Azure Key Vault](/azure/key-vault/general/overview) | Secure storage and lifecycle management for TDE master encryption keys |
| Network Security | [Azure Private Link](/azure/private-link/private-link-overview) | Private connectivity from Oracle Database@Azure to Key Vault |
| DNS Management | OCI Private Views | DNS resolution for private Key Vault endpoints within database VCN |
| Identity | [Azure Active Directory](/entra/fundamentals/whatis) | Service principal authentication for database-to-Key Vault operations |
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Key Vault access logging and operational metrics |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security posture management and threat detection |

## Related resources

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)
- [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault)
