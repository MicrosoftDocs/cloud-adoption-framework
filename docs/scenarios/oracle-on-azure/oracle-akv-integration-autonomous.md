---
title: Azure Key Vault Integration for Oracle Autonomous Database@Azure
description: Configure Azure Key Vault to manage TDE encryption keys for Oracle Autonomous Database@Azure using service principal authentication with step-by-step guidance.
author: gereyeso
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 2025-10-22
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Key Vault integration for Oracle Autonomous Database@Azure

Azure Key Vault provides centralized Transparent Data Encryption (TDE) key management for Oracle Autonomous Database@Azure through Azure Active Directory service principal authentication. This integration simplifies key lifecycle management while maintaining compliance with Azure governance policies. Organizations can consolidate encryption key management across Azure services while leveraging Autonomous Database's self-managing capabilities.

This article provides implementation guidance for configuring Azure Key Vault as the TDE master encryption key store for Oracle Autonomous Database@Azure using service principal authentication and built-in Oracle Cloud Infrastructure (OCI) integration. The guidance addresses service principal setup, Key Vault access configuration, and database encryption procedures.

## Prerequisites and environment preparation

Validate your environment meets these prerequisites before implementing Azure Key Vault integration. Oracle Autonomous Database@Azure uses service principal authentication, which requires different configuration than Exadata deployments and does not require Private Endpoint setup.

1. **Provision Oracle Autonomous Database@Azure instance in commercial Azure region.** Azure Key Vault integration for Autonomous Database is supported only in Azure commercial regions. Azure Government, Azure China, and other sovereign clouds are not currently supported. Verify your Autonomous Database deployment targets a supported commercial region. For region availability, see [Oracle Database@Azure regions](/azure/oracle/oracle-db/oracle-database-regions).

2. **Verify Azure Active Directory access for service principal creation.** Azure Key Vault integration creates an Azure service principal automatically during database configuration. Ensure you have permissions to register applications in Azure Active Directory (Microsoft Entra ID) or coordinate with your Azure AD administrator to perform service principal operations. Record your Azure Active Directory tenant ID, which is required during configuration. For tenant ID location, see [How to find your Azure Active Directory tenant ID](/entra/fundamentals/how-to-find-tenant).

3. **Select appropriate Azure Key Vault service tier.** Autonomous Database@Azure supports Azure Key Vault Standard (software-protected keys for development/test) and Premium (HSM-protected keys for production). Managed HSM is not supported with Autonomous Database's service principal authentication model. Choose Standard for non-production workloads and Premium for production databases requiring hardware-backed key protection. For tier comparison, see [About Azure Key Vault](/azure/key-vault/general/overview).

4. **Understand cross-region Data Guard limitations.** Azure Key Vault integration is not supported for Autonomous Database instances configured with cross-region Autonomous Data Guard standby databases. If your architecture requires cross-region disaster recovery, use Oracle-managed wallet or OCI Vault for TDE key management instead. For Data Guard configuration options, see [Business continuity and disaster recovery for Autonomous Database@Azure](oracle-disaster-recovery-oracle-database-azure-autonomous.md).

## Configure Azure Key Vault and encryption keys

Create Azure Key Vault and generate TDE master encryption keys that Autonomous Database will access through service principal authentication. This configuration establishes the key storage infrastructure without requiring Private Endpoint setup.

1. **Create Azure Key Vault in the same region as Autonomous Database.** Provision Key Vault in the same Azure region where your Autonomous Database@Azure instance deploys to minimize latency and maintain data residency compliance. During creation, select either Standard or Premium tier based on your security requirements. Configure access control using the Vault Access Policy model, as Azure RBAC is not currently supported for Autonomous Database service principal authentication. For Key Vault creation steps, see [Quickstart: Create a key vault using Azure Portal](/azure/key-vault/general/quick-create-portal).

2. **Generate RSA encryption key for TDE master key.** Create an RSA key within Key Vault to serve as the TDE master encryption key. Autonomous Database@Azure supports RSA 2048-bit, 3072-bit, and 4096-bit key sizes. Select key size based on your organizational security standards, balancing encryption strength against minimal performance impact. Enable key operations: Get, Wrap Key, and Unwrap Key to support TDE encryption operations. For supported key specifications, see [Manage Master Encryption Keys in Azure Key Vault](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html).

3. **Record Key Vault URI and key name for database configuration.** Navigate to your Key Vault Overview page in Azure Portal and copy the Vault URI (format: `https://<keyvault-name>.vault.azure.net/`). Then navigate to the Keys section and copy the name of the key created for TDE. Record both values as they are required during Autonomous Database encryption configuration. These identifiers connect Autonomous Database to the specific Key Vault and key for encryption operations.

4. **Configure Key Vault network access for service principal connectivity.** Autonomous Database@Azure accesses Key Vault through public endpoints using service principal authentication. In Key Vault networking settings, ensure "Public network access" is enabled with either "Allow access from all networks" or configure firewall rules that permit connections from Azure services. Private Endpoint is not required and not used in the Autonomous Database integration model.

## Configure service principal authentication in Autonomous Database

Enable Azure Active Directory service principal authentication in Autonomous Database to allow secure access to Azure Key Vault. This procedure creates the identity used for TDE key operations.

1. **Obtain Azure Active Directory tenant ID from Azure Portal.** Navigate to Azure Active Directory (Microsoft Entra ID) in Azure Portal and access the Overview page. Locate and copy your Directory (tenant) ID, which is a GUID format identifier. This tenant ID associates the service principal with your organization's Azure Active Directory. For tenant ID location, see [How to find your Azure Active Directory tenant ID](/entra/fundamentals/how-to-find-tenant).

2. **Connect to Autonomous Database as ADMIN user.** Establish a SQL connection to your Autonomous Database instance using SQL*Plus, SQL Developer, or Oracle Cloud Infrastructure SQL worksheet. Authenticate as the ADMIN user, which has privileges to configure service principal authentication. Ensure your connection is stable before executing configuration procedures.

3. **Execute DBMS_CLOUD_ADMIN procedure to enable Azure service principal.** Run the following PL/SQL block to configure service principal authentication, replacing `<your_tenant_id>` with the Azure AD tenant ID recorded earlier:

   ```sql
   BEGIN
     DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
       provider => 'AZURE',
       params => JSON_OBJECT('azure_tenantid' value '<your_tenant_id>')
     );
   END;
   /
   ```

   This procedure creates an Azure application registration automatically in your Azure Active Directory tenant. The service principal represents your Autonomous Database instance when accessing Azure Key Vault. For DBMS_CLOUD_ADMIN documentation, see [Enable Azure service principal authentication](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html#GUID-8C004DD3-CBCE-4F0D-A5FB-42D3C32BB5DE).

4. **Verify service principal creation in Azure Active Directory.** Return to Azure Portal and navigate to Azure Active Directory → App registrations → All applications. Search for an application with name pattern matching your Autonomous Database instance identifier. Confirm the application exists and note its Application (client) ID. This automatic creation confirms successful ENABLE_PRINCIPAL_AUTH execution and establishes the identity for Key Vault access.

## Grant Azure Key Vault access to Autonomous Database service principal

Configure Key Vault access policies to allow the Autonomous Database service principal to perform TDE key operations. This step completes the trust relationship between database and key storage.

1. **Locate the Autonomous Database service principal in Azure Key Vault access configuration.** Navigate to your Key Vault in Azure Portal and select "Access policies" from the left menu. Click "+ Create" to add a new access policy. In the Principal selection step, search for the service principal created automatically during ENABLE_PRINCIPAL_AUTH execution (typically matches your Autonomous Database name or identifier). Select the service principal to grant access.

2. **Configure key permissions for TDE operations.** In the access policy creation wizard, configure the following key permissions required for TDE encryption:
   - **Get**: Allows database to retrieve key metadata
   - **Wrap Key**: Enables encryption of database encryption key with master key
   - **Unwrap Key**: Enables decryption of database encryption key with master key
   
   No secret or certificate permissions are required for TDE operations. These three key permissions provide minimum required access following least-privilege principles. For access policy configuration guidance, see [Assign a Key Vault access policy](/azure/key-vault/general/assign-access-policy).

3. **Review and create the access policy.** Verify the access policy configuration shows the correct service principal and the three key permissions (Get, Wrap Key, Unwrap Key). Complete the wizard to create the access policy. The policy takes effect immediately, granting the Autonomous Database service principal the ability to access encryption keys for TDE operations.

4. **Validate service principal has successful Key Vault access.** Test the access policy by executing a test key operation from the Autonomous Database. The validation occurs during the next section when configuring database encryption. Failed key access generates error messages in the database alert log, indicating permission problems that require access policy review and correction.

## Configure Autonomous Database to use Azure Key Vault for encryption

Associate Azure Key Vault with Autonomous Database TDE configuration through the OCI Console encryption management interface. This procedure can be performed during initial database creation or as a migration from Oracle-managed wallet.

1. **Access Autonomous Database encryption management page in OCI Console.** Navigate to your Autonomous Database instance in OCI Console and locate the "Manage encryption key" option in the database details page. This interface provides encryption key lifecycle management including initial configuration and key rotation. The interface displays current encryption status and available key management options.

2. **Select Azure Key Vault as encryption key management provider.** On the Manage encryption key page, select "Encrypt using a customer-managed key" option. From the Key type dropdown, choose "Microsoft Azure" as the key management provider. This selection reveals Azure-specific configuration fields for Key Vault URI and key name.

3. **Enter Key Vault URI and key name from Azure configuration.** In the Vault URI field, paste the Key Vault URI recorded during Key Vault setup (format: `https://<keyvault-name>.vault.azure.net/`). In the Key name field, enter the name of the encryption key created in Key Vault. Ensure both values are accurate as incorrect values prevent successful TDE configuration. The interface validates connectivity to Key Vault before accepting configuration.

4. **Save configuration and monitor database lifecycle state.** Click Save to apply the encryption configuration. The Autonomous Database Lifecycle state changes to "Updating" while OCI orchestrates the encryption key migration. This process re-encrypts the database encryption key (DEK) with the Azure Key Vault master key. Operation typically completes within 5-10 minutes depending on database size. Monitor progress in OCI Console.

5. **Verify Azure Key Vault configuration in database details.** After the update completes and Lifecycle state returns to "Available," review the database Information page. Under the Encryption section, confirm "Customer-managed key (Microsoft Azure)" appears as the encryption key management option. The Vault URI and Key name should display, indicating successful Azure Key Vault integration. This information confirms OCI control plane successfully tracks the Key Vault association.

## Validate encryption operations and connectivity

Comprehensive validation ensures TDE operations function correctly with Azure Key Vault before transitioning to production use. Test both key access and database encryption functionality.

1. **Verify database encryption status after configuration.** Connect to your Autonomous Database as ADMIN user and query encryption status:

   ```sql
   SELECT * FROM V$ENCRYPTION_WALLET;
   ```

   The query should show wallet type as "Azure Key Vault" and status as "OPEN," indicating successful TDE integration with Azure Key Vault. If status shows "CLOSED" or errors occur, review access policy permissions and Key Vault connectivity.

2. **Test read and write operations on encrypted data.** Execute standard SQL operations (INSERT, UPDATE, SELECT) against tables in encrypted tablespaces. TDE encryption and decryption occur transparently without application code changes. Successful data operations confirm proper Key Vault integration and key accessibility. If operations fail with ORA-28374 error ("protected by master key not found"), verify Key Vault URI and key name configuration accuracy.

3. **Monitor Azure Key Vault access logs for database operations.** In Azure Portal, navigate to Key Vault Monitoring section and enable diagnostic settings to send logs to Log Analytics workspace. Query logs for Wrap Key and Unwrap Key operations initiated by the Autonomous Database service principal. Successful operations in Key Vault access logs correlate with database encryption activity, providing audit trail for compliance requirements. For Key Vault monitoring setup, see [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault).

4. **Validate automatic service principal credential refresh.** Azure service principals use time-limited credentials that Autonomous Database automatically refreshes through Azure Active Directory integration. Monitor service principal authentication over several days to confirm automatic refresh occurs without database administrator intervention. Failed credential refresh manifests as Key Vault access denied errors in database alert logs, requiring service principal reconfiguration.

## Implement key rotation and operational procedures

Establish procedures for ongoing encryption key management including key rotation, backup encryption handling, and monitoring. These procedures maintain security compliance while ensuring database availability.

1. **Implement encryption key rotation procedures.** Azure Key Vault supports creating new key versions without changing the key name or URI. To rotate the TDE master encryption key, create a new key version in Azure Key Vault, then update the Autonomous Database configuration through OCI Console "Manage encryption key" page. Select the same Key Vault but choose a different key or newer key version. OCI orchestrates online key rotation without database downtime or application disruption. Schedule key rotation according to security policies, typically annually or after security incidents.

2. **Configure backup encryption with customer-managed keys.** Autonomous Database automatic backups encrypt using the same TDE master encryption key from Azure Key Vault. Ensure backup retention policies align with key retention policies in Key Vault. Maintain key availability for the duration of backup retention to enable point-in-time recovery. For backup encryption details, see [Backup and Recovery for Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/backup-recovery.html).

3. **Establish monitoring for service principal and Key Vault availability.** Configure Azure Monitor alerts for Key Vault operations including failed key access attempts, disabled keys, or service principal authentication failures. Create action groups that notify database administrators when key-related issues occur. Proactive monitoring prevents database outages caused by key accessibility or authentication problems. For alert configuration, see [Create metric alerts for Azure Key Vault](/azure/key-vault/general/alert).

4. **Document limitations and alternative configurations for unsupported scenarios.** Record that Azure Key Vault integration is not supported for cross-region Autonomous Data Guard standby databases or in Azure Government/sovereign clouds. Document alternative key management options (Oracle-managed wallet, OCI Vault) for these scenarios. Maintain runbooks for migrating between key management providers if architecture requirements change.

## Troubleshoot common integration issues

Address frequent configuration problems encountered during Azure Key Vault integration with Oracle Autonomous Database@Azure. These solutions resolve the most common implementation and operational issues.

| Issue | Root Cause | Resolution |
|-------|------------|------------|
| ENABLE_PRINCIPAL_AUTH fails with tenant ID error | Incorrect Azure Active Directory tenant ID format or insufficient Azure AD permissions | Verify tenant ID is correct GUID format from Azure AD Overview page. Confirm executing user has permissions to register applications in Azure Active Directory. Coordinate with Azure AD administrator if permissions are lacking. |
| Service principal not appearing in Azure AD App registrations | ENABLE_PRINCIPAL_AUTH execution failed silently or Azure AD synchronization delay | Check database alert log for PL/SQL execution errors. Wait 2-3 minutes for Azure AD synchronization. Re-execute ENABLE_PRINCIPAL_AUTH if service principal does not appear. |
| Database shows "Key not found" error after configuration | Incorrect Key Vault URI or key name in configuration, or key deleted from Key Vault | Verify Vault URI includes `https://` prefix and trailing slash. Confirm key name exactly matches Key Vault key without version suffix. Navigate to Key Vault in Azure Portal and verify key exists and is enabled. |
| Key Vault access denied errors in database alert log | Service principal lacks required access policy permissions in Key Vault | Review Key Vault access policies and confirm service principal has Get, Wrap Key, and Unwrap Key permissions. Verify access policy is saved and active. Test key access from Azure Portal using service principal credentials. |
| Cannot configure Azure Key Vault in commercial region | Autonomous Database deployed in unsupported region (Government, China, sovereign cloud) | Verify database is deployed in Azure commercial region. Azure Key Vault integration for Autonomous Database is only supported in commercial Azure regions. Redeploy database to commercial region or use alternative key management (Oracle wallet, OCI Vault). |
| Encryption configuration fails during Lifecycle "Updating" state | Network connectivity issues to Azure Key Vault public endpoint or Key Vault firewall blocking Autonomous Database IP ranges | Verify Key Vault allows public network access or firewall permits connections from Azure services. Check Azure service health for Key Vault outages. Review database alert log for detailed error messages and connectivity timeouts. |
| Cross-region Data Guard configuration prevents Azure Key Vault selection | Known limitation: Azure Key Vault not supported with cross-region Autonomous Data Guard | Remove cross-region Data Guard standby configuration before configuring Azure Key Vault, or use Oracle-managed wallet/OCI Vault for TDE with Data Guard. Document limitation in architecture decisions. |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Key Management | [Azure Key Vault](/azure/key-vault/general/overview) | Centralized TDE master encryption key storage and lifecycle management |
| Identity | [Azure Active Directory](/entra/fundamentals/whatis) | Service principal authentication for database-to-Key Vault operations |
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Key Vault access logging and operational metrics tracking |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security posture management and compliance monitoring |
| Database Management | OCI Console | Configuration interface for Autonomous Database encryption settings |

## Related resources

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Business continuity and disaster recovery for Autonomous Database@Azure](oracle-disaster-recovery-oracle-database-azure-autonomous.md)
- [Azure Key Vault best practices](/azure/key-vault/general/best-practices)
- [Manage Master Encryption Keys in Azure Key Vault](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)
