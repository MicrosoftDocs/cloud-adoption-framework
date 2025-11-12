# Troubleshooting Guide for ODAA ADBS with Azure Key Management

This guide provides solutions to common issues encountered when configuring Oracle Autonomous Database with Azure Key Vault or Managed HSM over private endpoints.

## Table of Contents
1. [Principal Authentication Errors](#principal-authentication-errors)
2. [DNS Resolution Issues](#dns-resolution-issues)
3. [Private Endpoint Connectivity](#private-endpoint-connectivity)
4. [Encryption Key Configuration Errors](#encryption-key-configuration-errors)
5. [Network and Firewall Issues](#network-and-firewall-issues)
6. [Permission and Access Issues](#permission-and-access-issues)
7. [Database Restart Issues](#database-restart-issues)

## Principal Authentication Errors

### Error: ORA-20000: Failed to create the azure application - ORA-27465: invalid value for attribute password

**Problem:** This error occurs when calling `DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH` with incorrect parameters.

**Root Cause:** Including the `azure_tenantid` parameter or other incorrect parameters in the `params` JSON object for ODAA Autonomous Database.

**Solution:**

```sql
-- INCORRECT (causes the error)
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN',
        params   => JSON_OBJECT('azure_tenantid' value 'cacf72a7-6dab-4eb7-891b-effb028de1a3'));
END;
/

-- CORRECT (do not include params or azure_tenantid)
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/
```

**Key Points:**
- For Oracle Database@Azure (ODAA) Autonomous Database, do **NOT** include the `params` parameter
- The `azure_tenantid` parameter is not needed for ODAA ADBS
- The procedure will automatically create the Azure service principal with the correct configuration

**Verification:**
```sql
-- Verify the principal was created successfully
SELECT cloud_identity, cloud_identity_id, status 
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';

-- Expected output should show status as 'ENABLED'
```

### Error: ORA-20000: Principal already exists

**Problem:** Attempting to create a principal that already exists.

**Solution:**

```sql
-- Check existing principals
SELECT * FROM USER_CLOUD_IDENTITIES WHERE provider = 'AZURE';

-- If you need to recreate, first disable
BEGIN
    DBMS_CLOUD_ADMIN.DISABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/

-- Then recreate
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/
```

### Error: Unable to retrieve Azure Principal ID

**Problem:** The principal ID is not visible in the query results.

**Solution:**

```sql
-- Use the correct query to extract the principal ID
SELECT 
    cloud_identity,
    cloud_identity_id,
    JSON_VALUE(cloud_identity_properties, '$.azure_principal_id') as azure_principal_id,
    status
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';

-- If still not visible, check if the properties are stored differently
SELECT cloud_identity_properties 
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';
```

**Alternative Method:**
Search for the principal in Azure AD:
```bash
# List service principals with ADBS in the name
az ad sp list --filter "startswith(displayName,'ADBS_APP')" --query "[].{Name:displayName, ObjectId:id}" --output table

# The pattern is usually: ADBS_APP_OC<ID>1_AUTONOMOUSDATABASE_OC1_IAD_<DATABASE_NAME>
```

## DNS Resolution Issues

### Issue: Key Vault/HSM Resolves to Public IP

**Problem:** When testing connectivity, the service resolves to a public IP address instead of the private IP.

**Symptoms:**
```sql
-- nslookup returns public IP instead of 10.x.x.x
```

**Solution Steps:**

1. **Verify Private DNS Zones in OCI:**
```
# Check that both zones exist:
- privatelink.vaultcore.azure.net (for Key Vault)
  OR
- privatelink.managedhsm.azure.net (for Managed HSM)

AND

- vault.azure.net (for Key Vault)
  OR
- managedhsm.azure.net (for Managed HSM)
```

2. **Verify A Records:**
```
# Each zone should have an A record:
- Record name: <your-vault-or-hsm-name>
- Record type: A
- IP address: <private-ip> (e.g., 10.0.2.4)
```

3. **Verify Private View:**
```
# Ensure the private view is linked to the correct VCN
# The VCN name should match your ADBS VCN
```

4. **Check Azure Private DNS Zone:**
```bash
# Verify the private DNS zone exists in Azure
az network private-dns zone show --resource-group <RG> --name privatelink.vaultcore.azure.net

# Check A record exists
az network private-dns record-set a show --resource-group <RG> --zone-name privatelink.vaultcore.azure.net --name <KV_NAME>

# Verify VNet link
az network private-dns link vnet list --resource-group <RG> --zone-name privatelink.vaultcore.azure.net --output table
```

### Issue: DNS Resolution Works in Azure but Not in ADBS

**Problem:** DNS resolves correctly from Azure VMs but not from ADBS.

**Solution:**

1. Verify the database is configured for private endpoint resolution:
```sql
SELECT property_name, property_value 
FROM DATABASE_PROPERTIES 
WHERE property_name = 'ROUTE_OUTBOUND_CONNECTIONS';
```

Expected: `ENFORCE_PRIVATE_ENDPOINT`

2. If not set correctly:
```sql
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
```

3. Restart the database for changes to take effect.

## Private Endpoint Connectivity

### Error: Private Endpoint Connection in Pending State

**Problem:** Private endpoint connection shows "Pending" status.

**Solution:**

```bash
# For Key Vault
az keyvault private-endpoint-connection list --vault-name <KV_NAME> --resource-group <RG> --output table

# Approve the connection
az keyvault private-endpoint-connection approve --vault-name <KV_NAME> --resource-group <RG> --name <CONNECTION_NAME>

# For Managed HSM
az keyvault private-endpoint-connection list --hsm-name <HSM_NAME> --resource-group <RG> --output table

# Approve the connection
az keyvault private-endpoint-connection approve --hsm-name <HSM_NAME> --resource-group <RG> --name <CONNECTION_NAME>
```

### Issue: Cannot Connect via Private Endpoint

**Problem:** Connection fails even though private endpoint is approved.

**Checklist:**

1. **Verify Private Endpoint Status:**
```bash
az network private-endpoint show --name <PE_NAME> --resource-group <RG> --query provisioningState
```
Expected: "Succeeded"

2. **Check Network Interface:**
```bash
# Get NIC ID
PE_NIC_ID=$(az network private-endpoint show --name <PE_NAME> --resource-group <RG> --query 'networkInterfaces[0].id' --output tsv)

# Verify private IP
az network nic show --ids $PE_NIC_ID --query 'ipConfigurations[0].privateIPAddress' --output tsv
```

3. **Verify Subnet Configuration:**
```bash
# Check if subnet has private endpoint network policies enabled (should be disabled)
az network vnet subnet show --name <SUBNET_NAME> --vnet-name <VNET_NAME> --resource-group <RG> --query privateEndpointNetworkPolicies
```

4. **Test from Azure VM:**
Create a VM in the same VNet and test connectivity:
```bash
# From the VM
nslookup <kv-name>.vault.azure.net
# Should resolve to private IP (10.x.x.x)

# Test HTTPS connectivity
curl -v https://<kv-name>.vault.azure.net/
```

## Encryption Key Configuration Errors

### Error: ORA-28417: password-based keystore is not open

**Problem:** Encryption wallet is not open or configured correctly.

**Solution:**

```sql
-- Check wallet status
SELECT * FROM V$ENCRYPTION_WALLET;

-- If wallet is closed, check the encryption key configuration
SELECT * FROM DBA_ENCRYPTED_COLUMNS;
```

### Error: Cannot Access Encryption Key

**Problem:** ADBS cannot access the encryption key from Key Vault/HSM.

**Troubleshooting Steps:**

1. **Verify Key Permissions:**
```bash
# For Key Vault
az keyvault show --name <KV_NAME> --query properties.enableRbacAuthorization

# If RBAC is enabled, verify role assignments
az role assignment list --scope <KEY_VAULT_RESOURCE_ID> --assignee <PRINCIPAL_ID> --output table

# If using access policies, verify policies
az keyvault show --name <KV_NAME> --query properties.accessPolicies
```

2. **Verify Key Exists and is Enabled:**
```bash
# For Key Vault
az keyvault key show --vault-name <KV_NAME> --name <KEY_NAME> --query attributes.enabled

# For Managed HSM
az keyvault key show --hsm-name <HSM_NAME> --name <KEY_NAME> --query attributes.enabled
```

3. **Check Key Version:**
```bash
# List all versions
az keyvault key list-versions --vault-name <KV_NAME> --name <KEY_NAME> --output table

# Verify you're using an enabled version
```

4. **Test Access from ADBS:**
```sql
-- Grant network ACL
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host => '<kv-name>.vault.azure.net',
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

-- Test connectivity
SET SERVEROUTPUT ON;
DECLARE
    req UTL_HTTP.REQ;
    resp UTL_HTTP.RESP;
BEGIN
    req := UTL_HTTP.BEGIN_REQUEST('https://<kv-name>.vault.azure.net/healthstatus');
    resp := UTL_HTTP.GET_RESPONSE(req);
    DBMS_OUTPUT.PUT_LINE('Status: ' || resp.status_code);
    UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

### Error: Key URI Format Invalid

**Problem:** Incorrect key URI format when configuring encryption.

**Correct Format:**
- Key Vault: `https://<vault-name>.vault.azure.net/`
- Managed HSM: `https://<hsm-name>.managedhsm.azure.net/`

**Note:** 
- Include the trailing slash
- Do not include the key name or version in the URI
- Use only the base URI

## Network and Firewall Issues

### Issue: Public Access Still Enabled

**Problem:** Key Vault/HSM is accessible from the public internet.

**Solution:**

```bash
# For Key Vault
az keyvault update --name <KV_NAME> --resource-group <RG> --public-network-access Disabled

# For Managed HSM
az keyvault update-hsm --hsm-name <HSM_NAME> --resource-group <RG> --default-action Deny

# Verify
az keyvault show --name <KV_NAME> --query properties.publicNetworkAccess
az keyvault show --hsm-name <HSM_NAME> --query properties.networkAcls.defaultAction
```

### Issue: Firewall Blocking Legitimate Traffic

**Problem:** Overly restrictive firewall rules.

**Solution:**

```bash
# Allow trusted Azure services (if needed)
az keyvault update --name <KV_NAME> --resource-group <RG> --bypass AzureServices

# For Managed HSM
az keyvault update-hsm --hsm-name <HSM_NAME> --resource-group <RG> --bypass AzureServices

# Add specific IP ranges (only if absolutely necessary)
az keyvault network-rule add --name <KV_NAME> --resource-group <RG> --ip-address <IP_ADDRESS>
```

## Permission and Access Issues

### Error: Forbidden (403) when accessing Key Vault

**Problem:** ADBS principal lacks necessary permissions.

**Solution:**

**For Key Vault with Access Policies:**
```bash
# Grant necessary permissions
az keyvault set-policy --name <KV_NAME> --object-id <PRINCIPAL_ID> --key-permissions get unwrapKey wrapKey --secret-permissions get
```

**For Key Vault with RBAC:**
```bash
# Assign appropriate role
az role assignment create --assignee <PRINCIPAL_ID> --role "Key Vault Crypto User" --scope <KEY_VAULT_RESOURCE_ID>
```

**For Managed HSM:**
```bash
# Managed HSM always uses RBAC
az role assignment create --assignee <PRINCIPAL_ID> --role "Managed HSM Crypto User" --scope <HSM_RESOURCE_ID>
```

**Verification:**
```bash
# List role assignments
az role assignment list --assignee <PRINCIPAL_ID> --output table

# For Key Vault access policies
az keyvault show --name <KV_NAME> --query properties.accessPolicies
```

### Error: Principal Not Found in Azure AD

**Problem:** Cannot find the ADBS service principal in Azure AD.

**Solution:**

1. **Search by pattern:**
```bash
# ADBS principals follow a pattern
az ad sp list --filter "startswith(displayName,'ADBS_APP')" --query "[].{Name:displayName, ObjectId:id}" --output table
```

2. **Check from ADBS:**
```sql
-- Get the principal ID from ADBS
SELECT JSON_VALUE(cloud_identity_properties, '$.azure_principal_id') as principal_id
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';
```

3. **Verify with object ID:**
```bash
az ad sp show --id <OBJECT_ID>
```

## Database Restart Issues

### Issue: Database Won't Start After Configuration Changes

**Problem:** Database fails to start after enabling private endpoint resolution.

**Troubleshooting:**

1. **Check Database Status:**
```bash
# From OCI Console, check the lifecycle state and any error messages
```

2. **Verify Configuration:**
```sql
-- After database starts (if possible), check the setting
SELECT property_name, property_value 
FROM DATABASE_PROPERTIES 
WHERE property_name = 'ROUTE_OUTBOUND_CONNECTIONS';
```

3. **Revert if Necessary:**
```sql
-- If the database starts, you can revert the setting
ALTER DATABASE PROPERTY SET route_outbound_connections = 'public_endpoint';

-- Then fix the DNS configuration before re-enabling
```

4. **Check Private DNS Configuration:**
- Verify all DNS zones are created
- Verify A records point to correct private IPs
- Verify zones are linked to the correct VCN

### Issue: Database Restart Takes Too Long

**Problem:** Database restart exceeds expected time (>10 minutes).

**Action:**

1. Wait for up to 15 minutes
2. Check OCI Console for any error messages
3. If timeout occurs, open a support ticket with Oracle
4. Include:
   - Database OCID
   - Timestamp of restart attempt
   - Configuration changes made
   - Any error messages

## Diagnostic Queries

### Check Overall Configuration

```sql
-- Check database properties
SELECT property_name, property_value 
FROM DATABASE_PROPERTIES 
WHERE property_name IN (
    'ROUTE_OUTBOUND_CONNECTIONS',
    'TDE_CONFIGURATION'
);

-- Check cloud identities
SELECT * FROM USER_CLOUD_IDENTITIES WHERE provider = 'AZURE';

-- Check encryption wallet status
SELECT * FROM V$ENCRYPTION_WALLET;

-- Check network ACLs
SELECT host, lower_port, upper_port, privilege 
FROM DBA_HOST_ACES 
WHERE lower_port = 443;
```

### Test Connectivity

```sql
-- Test HTTPS connectivity to Key Vault/HSM
SET SERVEROUTPUT ON;
DECLARE
    req UTL_HTTP.REQ;
    resp UTL_HTTP.RESP;
    target_url VARCHAR2(200) := 'https://<your-kv-or-hsm>.vault.azure.net/';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Testing connection to: ' || target_url);
    
    req := UTL_HTTP.BEGIN_REQUEST(target_url);
    UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Oracle-Test');
    
    resp := UTL_HTTP.GET_RESPONSE(req);
    DBMS_OUTPUT.PUT_LINE('HTTP Status: ' || resp.status_code);
    DBMS_OUTPUT.PUT_LINE('Reason: ' || resp.reason_phrase);
    
    FOR i IN 1..UTL_HTTP.GET_HEADER_COUNT(resp) LOOP
        UTL_HTTP.GET_HEADER(resp, i, target_url, target_url);
        DBMS_OUTPUT.PUT_LINE(i || ': ' || target_url);
    END LOOP;
    
    UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
    WHEN UTL_HTTP.END_OF_BODY THEN
        UTL_HTTP.END_RESPONSE(resp);
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Connection established');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
END;
/
```

## Common Error Messages and Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| ORA-27465: invalid value for attribute password | Incorrect parameters in ENABLE_PRINCIPAL_AUTH | Remove params parameter |
| ORA-28417: password-based keystore is not open | Wallet not configured | Configure encryption key properly |
| Connection timeout | DNS not resolving | Check DNS zones and A records |
| 403 Forbidden | Insufficient permissions | Grant appropriate RBAC role or access policy |
| Connection refused | Firewall blocking | Verify firewall rules and private endpoint |
| Name not resolved | DNS configuration missing | Create DNS zones and A records |
| Invalid key URI | Wrong URI format | Use base URI only (with trailing slash) |

## Getting Help

### Collect Diagnostic Information

Before contacting support, collect:

1. **Azure Resources:**
```bash
# Export resource information
az keyvault show --name <KV_NAME> --resource-group <RG> > keyvault-config.json
az network private-endpoint show --name <PE_NAME> --resource-group <RG> > private-endpoint-config.json
az network private-dns zone show --resource-group <RG> --name privatelink.vaultcore.azure.net > dns-zone-config.json
```

2. **ADBS Configuration:**
```sql
-- Export configuration
SET ECHO ON;
SET PAGESIZE 1000;
SPOOL adbs_config.txt;

SELECT * FROM DATABASE_PROPERTIES WHERE property_name LIKE '%OUTBOUND%';
SELECT * FROM USER_CLOUD_IDENTITIES WHERE provider = 'AZURE';
SELECT * FROM V$ENCRYPTION_WALLET;

SPOOL OFF;
```

3. **Network Configuration:**
- VNet topology diagram
- Subnet configurations
- NSG rules (if applicable)
- Private DNS zone screenshots

### Support Channels

- **Oracle Support:** For ADBS-specific issues
- **Microsoft Azure Support:** For Key Vault/HSM and networking issues
- **Community Forums:** 
  - Oracle Cloud Community
  - Microsoft Tech Community

## Prevention Tips

1. **Document Everything:**
   - Keep a record of all resource names, IDs, and IP addresses
   - Document the order of operations
   - Save configuration values

2. **Test Before Production:**
   - Test in a development environment first
   - Validate all configurations
   - Test failover scenarios

3. **Use Infrastructure as Code:**
   - Use Terraform or Bicep for repeatable deployments
   - Version control your configurations
   - Automate testing

4. **Monitor Continuously:**
   - Set up alerts for key operations
   - Monitor encryption key access
   - Track database availability

5. **Regular Audits:**
   - Review access permissions monthly
   - Audit network configurations
   - Verify encryption key rotation

## Additional Resources

- [Oracle ADBS Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/)
- [Azure Key Vault Troubleshooting](https://learn.microsoft.com/en-us/azure/key-vault/general/troubleshooting)
- [Private Link Diagnostics](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-diagnostics)
- [Managed HSM Best Practices](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/best-practices)
