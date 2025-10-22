---
title: Azure Key Vault Integration for Oracle Exadata Database@Azure
description: Configure Azure Key Vault with private endpoint connectivity to manage TDE encryption keys for Oracle Exadata Database@Azure.
author: sihbher
ms.author: sihbher
ms.reviewer: sihbher
ms.date: 2025-10-22
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Exadata Database@Azure

Azure Key Vault provides centralized Transparent Data Encryption (TDE) key management for Oracle Exadata Database@Azure through private endpoint connectivity. This integration maintains database performance while meeting Azure-native security and compliance requirements. Organizations can standardize key management practices across Azure resources while leveraging Oracle Exadata's high-performance database capabilities.

This article provides guidance for configuring Azure Key Vault as the TDE master encryption key store for Oracle Exadata Database@Azure using private endpoints and Oracle Cloud Infrastructure (OCI) Private DNS integration. The guidance focuses specifically on Private Endpoint configuration and OCI DNS zone setup required for Exadata deployments.


## Prerequisites and environment preparation

Before implementing Azure Key Vault integration with Private Endpoints for Oracle Exadata Database@Azure, ensure your environment meets these specific prerequisites:

1. **Enable advanced networking features for Oracle Database@Azure.** Advanced networking must be enabled in your Azure region to support Private Endpoint connectivity. For feature availability and enablement procedures, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#advanced-networking-features).

2. **Complete Azure Key Vault provisioning and key creation.** Provision Azure Key Vault in the same region as your Oracle Database@Azure deployment and create a TDE-compatible encryption key. For complete Key Vault setup procedures including service tier selection, key generation, and access policy configuration, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

3. **Verify Oracle Database@Azure onboarding completion.** Ensure your Oracle Exadata Database@Azure deployment is fully operational before configuring Key Vault integration. For onboarding procedures and validation steps, see [Onboard Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database).

4. **Confirm administrative access to Azure Portal and OCI Console.** Implementation requires Contributor role access in Azure for Key Vault and Private Endpoint configuration, plus administrative access to OCI Console for DNS zone management and database encryption settings.

## Configure Azure Key Vault with private endpoint

Establish secure private connectivity between Oracle Exadata Database@Azure and Azure Key Vault through Private Endpoint configuration. This section focuses on the Private Endpoint setup specific to Oracle Database@Azure integration.

> [!NOTE]
> For comprehensive Azure Key Vault setup including key creation, access policies, and basic configuration, see [Manage Oracle Transparent Data Encryption with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault) before proceeding with Private Endpoint configuration.

1. **Create Private Endpoint in the delegated subnet.** Navigate to your Key Vault networking settings and create a Private Endpoint targeting the vault sub-resource. Select the same virtual network and delegated subnet where your Oracle Exadata Database@Azure deployment resides. Azure automatically creates a network interface with a private IP address in your subnet. For Private Endpoint creation procedures, see [Create a private endpoint](/azure/private-link/create-private-endpoint-portal).

2. **Record Private Endpoint DNS configuration details.** After Private Endpoint creation, navigate to the Private Endpoint resource in Azure Portal and access the DNS configuration blade. Record the following information required for OCI DNS configuration:
   - Private Endpoint FQDN (format: `<keyvault-name>.privatelink.vaultcore.azure.net`)
   - Private IP address (example: `10.0.0.4`)
   - Key Vault name without domain suffix (example: `mykeyvault`)

3. **Disable public network access to enforce private-only connectivity.** Navigate to Key Vault networking settings and select "Disable public access." This ensures all key operations from Oracle Database@Azure traverse the Private Endpoint path exclusively. Only disable public access after completing Private Endpoint validation to prevent configuration lockout.

## Configure Private DNS zones in OCI infrastructure

Oracle Database@Azure resolves DNS queries through OCI Private Views within the virtual cloud network. Create matching DNS zones in the OCI infrastructure to enable private Key Vault name resolution from database instances without internet routing.

1. **Identify the OCI Private View for your deployment.** Navigate to the Oracle Database@Azure resource in Azure Portal and select "Go to OCI" to access the OCI Console. On the database information page, note the VCN name assigned to your deployment (format: `VCN-multicloudnetworklink[timestamp]`). In OCI Console, navigate to Networking → DNS Management → Private Views and locate the Private View matching your VCN name. This view manages DNS resolution for your database infrastructure.

2. **Create privatelink.vaultcore.azure.net Private DNS zone.** Within your identified Private View, create a new private zone named `privatelink.vaultcore.azure.net` to match the Azure-created zone. This zone handles resolution for the Private Endpoint FQDN. Set zone type to Primary and associate it with your OCI compartment. For OCI DNS zone creation procedures, see [Managing Private Views](https://docs.oracle.com/iaas/Content/DNS/Tasks/managingprivateviews.htm).

3. **Create vault.azure.net Private DNS zone for public FQDN resolution.** Create a second private zone named `vault.azure.net` within the same Private View. This zone enables the database to resolve the standard Key Vault FQDN to the private IP address, allowing Oracle's TDE integration to function correctly without requiring code changes. The dual-zone configuration supports both direct Private Endpoint access and standard Azure Key Vault SDK calls.

4. **Add A records in both DNS zones pointing to Private Endpoint IP.** In each DNS zone created above, add an A record using your Key Vault name (without domain suffix) as the record name. Set the record value to the Private Endpoint private IP address recorded during Azure configuration. For example, if your Key Vault is named `my-keyvault` with Private Endpoint IP `10.0.0.4`, create A record `my-keyvault` → `10.0.0.4` in both zones. This configuration ensures both FQDNs (`my-keyvault.vault.azure.net` and `my-keyvault.privatelink.vaultcore.azure.net`) resolve to the private address.

5. **Publish DNS changes and validate record propagation.** After adding A records, review changes and select "Publish changes" in OCI Console to activate the DNS configuration. Allow 2-5 minutes for DNS record propagation across OCI infrastructure. Validation of DNS resolution from database instances is covered in the verification section below.

## Configure identity and access for Key Vault operations

Oracle Exadata Database@Azure requires service principal authentication to access Azure Key Vault for TDE operations.

> [!NOTE]
> For complete service principal creation and Azure Key Vault access policy configuration procedures, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault#configure-the-database). This section focuses only on Private Endpoint-specific access configuration.

1. **Verify Private Endpoint connection approval status.** After service principal configuration, navigate to Key Vault networking settings and confirm the Private Endpoint appears under "Private endpoint connections" with "Approved" status. This ensures the database service principal can access Key Vault through the private network path.

2. **Validate that firewall rules do not block private endpoint access.** If your Key Vault uses selected networks (not disabled public access), verify the Private Endpoint is explicitly allowed. Private Endpoints bypass firewall rules by default, but validation prevents connectivity issues during initial testing.

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

> [!NOTE]
> For complete Azure Key Vault registration in OCI Console and database encryption configuration procedures, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault). The procedures are identical whether using public endpoints or Private Endpoints; the Private Endpoint enforcement configured in the previous section ensures all connectivity uses the private path transparently.

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

Establish procedures for ongoing key management operations specific to Private Endpoint configurations.

1. **Monitor Private Endpoint connectivity health.** Configure Azure Monitor alerts for Private Endpoint connection state changes and network interface health. Private Endpoint connectivity issues can prevent database access to encryption keys. For monitoring configuration, see [Monitor Private Link](/azure/private-link/private-link-overview#logging-and-monitoring).

2. **Maintain DNS zone consistency during infrastructure changes.** When making changes to Private Endpoint IP addresses or Key Vault configurations, immediately update corresponding A records in both OCI DNS zones (`privatelink.vaultcore.azure.net` and `vault.azure.net`). DNS inconsistencies can cause key operation failures and database startup issues.

3. **Document Private Endpoint disaster recovery procedures.** Include Private Endpoint and OCI DNS zone configuration in your disaster recovery documentation. Ensure procedures cover recreating Private Endpoints and DNS zones during regional failover scenarios. For general key lifecycle management including key rotation and backup encryption, see [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).

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
- [Core network design for Oracle Database@Azure](core-network-design.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)
- [Manage Oracle TDE with Azure Key Vault](/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault)
- [Azure Key Vault integration with Autonomous Database@Azure](oracle-akv-integration-autonomous.md)
