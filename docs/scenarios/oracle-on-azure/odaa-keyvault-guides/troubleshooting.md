# Troubleshooting Guide: ODAA with Azure Key Management Services

This guide provides solutions to common issues encountered when integrating Oracle Autonomous Database Serverless (ADBS) with Azure Key Vault or Managed HSM using Private Endpoints.

## Table of Contents
1. [Service Principal and Authentication Issues](#service-principal-and-authentication-issues)
2. [Private Endpoint Connectivity Issues](#private-endpoint-connectivity-issues)
3. [DNS Resolution Problems](#dns-resolution-problems)
4. [Key Access and Permission Issues](#key-access-and-permission-issues)
5. [Database Configuration Issues](#database-configuration-issues)
6. [Managed HSM Specific Issues](#managed-hsm-specific-issues)
7. [Performance Issues](#performance-issues)
8. [Diagnostic Tools and Commands](#diagnostic-tools-and-commands)

## Service Principal and Authentication Issues

### Issue 1: ORA-27465: invalid value for attribute password

**Error Message:**
```
ORA-20000: Failed to create the azure application - ORA-27465: invalid value for attribute password
```

**Cause:**
Oracle's automatic service principal creation fails due to:
1. Network access to Azure AD endpoints is blocked
2. Azure AD restrictions prevent app registration
3. Missing permissions in Azure AD

**Solution 1: Verify Azure AD Endpoint Access**

```sql
-- Test connectivity to Azure AD
BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => 'login.microsoftonline.com',
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

-- Test connection
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
BEGIN
  req := UTL_HTTP.BEGIN_REQUEST('https://login.microsoftonline.com/');
  resp := UTL_HTTP.GET_RESPONSE(req);
  DBMS_OUTPUT.PUT_LINE('Status: ' || resp.status_code);
  UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Details: ' || UTL_HTTP.get_detailed_sqlerrm);
END;
/
```

If connection fails, verify that `route_outbound_connections` is NOT set to `enforce_private_endpoint` for Azure AD access.

**Solution 2: Create Service Principal Manually (Recommended)**

Instead of using `DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH`, create the service principal manually:

```bash
# Create service principal
az ad sp create-for-rbac --name "sp-odaa-keyvault" --role "Key Vault Crypto Service Encryption User" --scopes /subscriptions/{subscription-id}/resourceGroups/{rg-name}

# Note the output values:
# - appId (Client ID)
# - password (Client Secret)
# - tenant (Tenant ID)
```

Then configure in ADBS via OCI Console instead of using the automatic procedure.

**Solution 3: Check Azure AD Permissions**

Verify your Azure AD permissions:
```bash
# Check if you can create app registrations
az ad app list --query "[0]" --output table

# If this fails, you need "Application Developer" role or higher in Azure AD
```

### Issue 2: Service Principal Authentication Fails

**Error Message:**
```
ORA-20000: Authentication failed with Azure Key Vault
```

**Diagnostic Steps:**

```bash
# Test service principal login
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID

# Test key access
az keyvault key show --vault-name $KEYVAULT_NAME --name $KEY_NAME

# Check service principal status
az ad sp show --id $APP_ID
```

**Solutions:**

1. **Verify Client Secret:**
```bash
# Client secret may have expired. Create new one:
az ad sp credential reset --id $APP_ID
```

2. **Check Access Policies:**
```bash
# For Key Vault
az keyvault show --name $KEYVAULT_NAME --query properties.accessPolicies

# For Managed HSM
az keyvault role assignment list --hsm-name $HSM_NAME
```

3. **Verify Service Principal Hasn't Been Deleted:**
```bash
az ad sp show --id $APP_ID
# If not found, recreate service principal
```

## Private Endpoint Connectivity Issues

### Issue 3: Cannot Reach Key Vault/HSM via Private Endpoint

**Symptoms:**
- Timeout errors when accessing Key Vault/HSM
- Connection refused errors
- Public IP returned instead of private IP

**Diagnostic Steps:**

```sql
-- Test from ADBS
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
BEGIN
  req := UTL_HTTP.BEGIN_REQUEST('https://your-keyvault.vault.azure.net/healthstatus');
  resp := UTL_HTTP.GET_RESPONSE(req);
  DBMS_OUTPUT.PUT_LINE('Status: ' || resp.status_code);
  UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

**Solution 1: Verify Private Endpoint Configuration**

```bash
# Check private endpoint status
az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP --query provisioningState

# Verify connection state
az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP --query privateLinkServiceConnections[0].privateLinkServiceConnectionState.status
```

Expected status: "Approved"

**Solution 2: Verify Private Endpoint IP**

```bash
# Get private endpoint IP
NIC_ID=$(az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' -o tsv)
PRIVATE_IP=$(az network nic show --ids $NIC_ID --query 'ipConfigurations[0].privateIPAddress' -o tsv)

echo "Private Endpoint IP: $PRIVATE_IP"

# Verify from a VM in the same VNet
nslookup your-keyvault.vault.azure.net
```

**Solution 3: Check Subnet Configuration**

```bash
# Ensure private endpoint policies are disabled on subnet
az network vnet subnet update --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $PE_SUBNET --disable-private-endpoint-network-policies true
```

## DNS Resolution Problems

### Issue 4: DNS Returns Public IP Instead of Private IP

**Symptoms:**
- nslookup returns public IP address
- Connection goes to public endpoint instead of private

**Diagnostic Steps:**

From a VM in the VNet:
```bash
# Check DNS resolution
nslookup your-keyvault.vault.azure.net

# Check if private DNS zone is linked
az network private-dns link vnet list --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net
```

**Solution 1: Verify Private DNS Zone Configuration**

```bash
# Check if Private DNS Zone exists
az network private-dns zone show --resource-group $RESOURCE_GROUP --name privatelink.vaultcore.azure.net

# Check if VNet is linked
az network private-dns link vnet show --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net --name dns-link-keyvault

# Verify A record exists
az network private-dns record-set a list --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net
```

**Solution 2: Re-create Private DNS Integration**

```bash
# Delete and recreate Private DNS Zone link
az network private-dns link vnet delete --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net --name dns-link-keyvault --yes

az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net --name dns-link-keyvault --virtual-network $VNET_NAME --registration-enabled false
```

**Solution 3: Verify DNS Configuration in OCI**

For ADBS to resolve private endpoints, two DNS zones are required in OCI:

**For Key Vault:**
- `privatelink.vaultcore.azure.net`
- `vault.azure.net`

**For Managed HSM:**
- `privatelink.managedhsm.azure.net`
- `managedhsm.azure.net`

Steps to verify:
1. Navigate to OCI Console → DNS Management → Private Views
2. Find the Private View matching your VCN name
3. Verify both zones exist with correct A records
4. Verify A records point to correct private IP addresses

### Issue 5: DNS Resolution Works in Azure but Not from ADBS

**Cause:**
OCI Private DNS Zones not configured correctly

**Solution:**

1. **Verify VCN Name:**
```bash
# From Azure Portal, get VCN name from ADBS properties
# In OCI Console, navigate to the Private View with this exact name
```

2. **Verify A Records:**
```bash
# A records must be created in BOTH DNS zones
# Example for Key Vault named "kv-demo-12345" with private IP 10.0.2.4:

# Zone 1: privatelink.vaultcore.azure.net
# Record: kv-demo-12345 → 10.0.2.4

# Zone 2: vault.azure.net  
# Record: kv-demo-12345 → 10.0.2.4
```

3. **Publish Changes:**
- Always click "Review changes" and "Publish changes" in OCI DNS Management
- Changes may take 2-3 minutes to propagate

## Key Access and Permission Issues

### Issue 6: Access Denied to Key Vault Key

**Error Message:**
```
ORA-20000: Access denied to key in Azure Key Vault
```

**Diagnostic Steps:**

```bash
# Check access policies
az keyvault show --name $KEYVAULT_NAME --query properties.accessPolicies

# Test service principal access
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID
az keyvault key show --vault-name $KEYVAULT_NAME --name $KEY_NAME
```

**Solution 1: Grant Required Permissions**

For Key Vault:
```bash
# Grant key permissions
az keyvault set-policy --name $KEYVAULT_NAME --spn $APP_ID --key-permissions get unwrapKey wrapKey list

# Verify permissions
az keyvault show --name $KEYVAULT_NAME --query "properties.accessPolicies[?objectId=='$APP_ID']"
```

For Managed HSM:
```bash
# Assign Crypto User role
az keyvault role assignment create --hsm-name $HSM_NAME --role "Managed HSM Crypto User" --assignee $APP_ID --scope /keys

# Verify role assignment
az keyvault role assignment list --hsm-name $HSM_NAME --assignee $APP_ID
```

**Solution 2: Verify Key Permissions**

Required permissions:
- **Minimum:** get, wrapKey, unwrapKey
- **Recommended:** get, list, wrapKey, unwrapKey, encrypt, decrypt

### Issue 7: Key Operations Timeout

**Symptoms:**
- Key wrap/unwrap operations timeout
- Database encryption operations hang

**Diagnostic Steps:**

```bash
# Test key operation latency
time az keyvault key encrypt --vault-name $KEYVAULT_NAME --name $KEY_NAME --algorithm RSA-OAEP --value "dGVzdA==" --data-type base64
```

**Solutions:**

1. **Verify Private Endpoint Connectivity:**
```bash
# From a VM in the VNet
curl -I https://your-keyvault.vault.azure.net
```

2. **Check Network Path:**
```bash
# Traceroute to verify traffic stays within Azure
traceroute your-keyvault.vault.azure.net
```

3. **Increase Timeout Settings:**
```sql
-- In ADBS, increase network timeout if needed
ALTER SYSTEM SET TCP.INVITED_NODES='*';
```

## Database Configuration Issues

### Issue 8: Private Endpoint Resolution Not Working

**Error Message:**
```
ORA-20000: Cannot resolve Key Vault address to private IP
```

**Diagnostic Steps:**

```sql
-- Check route_outbound_connections setting
SELECT PROPERTY_NAME, PROPERTY_VALUE 
FROM DATABASE_PROPERTIES 
WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS';
```

**Solution 1: Enable Private Endpoint Resolution**

```sql
-- Set property
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';

-- Restart database (required)
-- Use Azure Portal or OCI Console to restart
```

**Solution 2: Verify After Restart**

```sql
-- Reconnect after restart
SELECT PROPERTY_NAME, PROPERTY_VALUE 
FROM DATABASE_PROPERTIES 
WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS';

-- Test connectivity
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
BEGIN
  req := UTL_HTTP.BEGIN_REQUEST('https://your-keyvault.vault.azure.net/healthstatus');
  resp := UTL_HTTP.GET_RESPONSE(req);
  DBMS_OUTPUT.PUT_LINE('Status: ' || resp.status_code);
  DBMS_OUTPUT.PUT_LINE('Private endpoint resolution is working');
  UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

### Issue 9: Database Won't Start After Configuration

**Symptoms:**
- Database stuck in "Starting" state
- Database fails to start after key configuration

**Diagnostic Steps:**

Check database alerts in OCI Console or Azure Portal.

**Solutions:**

1. **Revert to Oracle-Managed Keys:**
```bash
# Via OCI Console:
# 1. Navigate to ADBS → Customer-Managed Encryption Keys
# 2. Click "Manage encryption key"
# 3. Select "Encrypt using an Oracle-managed key"
# 4. Click Save
```

2. **Verify Key Vault Accessibility:**
```bash
# Ensure Key Vault is accessible
az keyvault show --name $KEYVAULT_NAME

# Verify private endpoint
az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP
```

3. **Check Service Principal:**
```bash
# Verify service principal exists and is valid
az ad sp show --id $APP_ID

# Test authentication
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID
```

## Managed HSM Specific Issues

### Issue 10: Managed HSM Not Activated

**Error Message:**
```
The managed HSM is in an unactivated state
```

**Solution:**

```bash
# Check HSM status
az keyvault show --hsm-name $HSM_NAME --query properties.statusMessage

# If not activated, download and upload security domain
# Generate quorum certificates
openssl req -newkey rsa:2048 -nodes -keyout sd-key1.key -x509 -days 365 -out sd-cert1.cer
openssl req -newkey rsa:2048 -nodes -keyout sd-key2.key -x509 -days 365 -out sd-cert2.cer
openssl req -newkey rsa:2048 -nodes -keyout sd-key3.key -x509 -days 365 -out sd-cert3.cer

# Download security domain
az keyvault security-domain download --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-cert1.cer ./sd-cert2.cer ./sd-cert3.cer --sd-quorum 2 --security-domain-file ${HSM_NAME}-sd.json
```

### Issue 11: Managed HSM Firewall Blocks Access

**Symptoms:**
- Firewall rules block access even with private endpoint
- Unable to perform key operations

**Solution:**

```bash
# Allow trusted services bypass
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --bypass AzureServices

# Or temporarily allow all networks for troubleshooting
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Allow

# After troubleshooting, re-enable firewall
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Deny --bypass AzureServices
```

### Issue 12: Security Domain Recovery Fails

**Error Message:**
```
Security domain upload failed: Invalid quorum
```

**Solution:**

```bash
# Verify you have the correct number of keys (at least equal to quorum)
# Example: If quorum is 2, you need at least 2 keys

# Upload security domain with correct keys
az keyvault security-domain upload --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-key1.key ./sd-key2.key --sd-file ${HSM_NAME}-sd.json

# Verify HSM is activated
az keyvault show --hsm-name $HSM_NAME --query properties.statusMessage
```

## Performance Issues

### Issue 13: Slow Key Operations

**Symptoms:**
- Key wrap/unwrap operations take >1 second
- Database operations slow after enabling customer-managed keys

**Diagnostic Steps:**

```bash
# Measure key operation latency
time az keyvault key encrypt --vault-name $KEYVAULT_NAME --name $KEY_NAME --algorithm RSA-OAEP --value "dGVzdA==" --data-type base64

# For Managed HSM
time az keyvault key encrypt --hsm-name $HSM_NAME --name $KEY_NAME --algorithm RSA-OAEP --value "dGVzdA==" --data-type base64
```

**Solutions:**

1. **Verify Private Endpoint Latency:**
```bash
# From VM in VNet, test latency
ping -c 10 your-keyvault.vault.azure.net
```

2. **Check Network Hops:**
```bash
# Ensure traffic stays within Azure backbone
traceroute your-keyvault.vault.azure.net
```

3. **Optimize Key Size:**
- Use RSA 2048 or 3072 instead of 4096 if performance is critical
- RSA 4096 is recommended but slower

4. **Review SKU:**
- Key Vault Premium is faster than Standard
- Managed HSM has higher latency than Key Vault (expected)

## Diagnostic Tools and Commands

### Network Diagnostics from ADBS

```sql
-- Test DNS resolution and HTTPS connectivity
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
  name VARCHAR2(256);
  value VARCHAR2(1024);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Testing connection to Key Vault...');
  
  -- Test connection
  req := UTL_HTTP.BEGIN_REQUEST('https://your-keyvault.vault.azure.net/healthstatus');
  UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Oracle-ADB-Test');
  resp := UTL_HTTP.GET_RESPONSE(req);
  
  DBMS_OUTPUT.PUT_LINE('HTTP Status: ' || resp.status_code);
  DBMS_OUTPUT.PUT_LINE('HTTP Reason: ' || resp.reason_phrase);
  
  -- Print response headers
  DBMS_OUTPUT.PUT_LINE('Response Headers:');
  FOR i IN 1..UTL_HTTP.GET_HEADER_COUNT(resp) LOOP
    UTL_HTTP.GET_HEADER(resp, i, name, value);
    DBMS_OUTPUT.PUT_LINE(name || ': ' || value);
  END LOOP;
  
  UTL_HTTP.END_RESPONSE(resp);
  DBMS_OUTPUT.PUT_LINE('Connection successful!');
  
EXCEPTION
  WHEN UTL_HTTP.END_OF_BODY THEN
    UTL_HTTP.END_RESPONSE(resp);
    DBMS_OUTPUT.PUT_LINE('Connection successful (no body)');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Details: ' || UTL_HTTP.get_detailed_sqlerrm);
END;
/
```

### Azure Network Diagnostics

```bash
# Check private endpoint connectivity
az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP

# Verify DNS configuration
az network private-dns zone show --resource-group $RESOURCE_GROUP --name privatelink.vaultcore.azure.net
az network private-dns record-set a list --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net

# Test from Azure VM
# Install on VM first: apt-get install dnsutils curl
nslookup your-keyvault.vault.azure.net
curl -I https://your-keyvault.vault.azure.net

# Check service principal
az ad sp show --id $APP_ID
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID
az keyvault key list --vault-name $KEYVAULT_NAME
```

### Database Diagnostics

```sql
-- Check encryption status
SELECT * FROM V$ENCRYPTION_WALLET;
SELECT * FROM V$ENCRYPTED_TABLESPACES;
SELECT * FROM V$ENCRYPTION_KEYS ORDER BY CREATION_TIME DESC;

-- Check database properties
SELECT PROPERTY_NAME, PROPERTY_VALUE 
FROM DATABASE_PROPERTIES 
WHERE PROPERTY_NAME LIKE '%ROUTE%' OR PROPERTY_NAME LIKE '%ENCRYPT%';

-- Check network ACLs
SELECT HOST, LOWER_PORT, UPPER_PORT 
FROM DBA_NETWORK_ACLS 
JOIN DBA_NETWORK_ACL_PRIVILEGES USING (ACL);
```

### Logging and Monitoring

```bash
# Enable Key Vault diagnostics
WORKSPACE_ID=$(az monitor log-analytics workspace show --resource-group $RESOURCE_GROUP --workspace-name $WORKSPACE_NAME --query id -o tsv)

az monitor diagnostic-settings create --name keyvault-diagnostics --resource $KEYVAULT_ID --workspace $WORKSPACE_ID --logs '[{"category": "AuditEvent", "enabled": true}]' --metrics '[{"category": "AllMetrics", "enabled": true}]'

# Query logs
az monitor log-analytics query --workspace $WORKSPACE_ID --analytics-query "AzureDiagnostics | where ResourceType == 'VAULTS' and Category == 'AuditEvent' | where TimeGenerated > ago(1h) | project TimeGenerated, OperationName, ResultType, CallerIPAddress | order by TimeGenerated desc"
```

## Common Error Reference

| Error Code | Description | Solution |
|------------|-------------|----------|
| ORA-20000 | Generic cloud error | Check inner error message |
| ORA-27465 | Invalid password attribute | Create service principal manually |
| ORA-28354 | Encryption wallet error | Check wallet status and key access |
| 403 Forbidden | Access denied to Key Vault | Verify access policies/role assignments |
| 404 Not Found | Key Vault or key not found | Check resource names and existence |
| Timeout | Network connectivity issue | Check private endpoint and DNS |

## Getting Additional Help

### Azure Support
1. Open Azure Portal → Help + Support
2. Create new support request
3. Select "Technical" issue type
4. Choose relevant service (Key Vault, Managed HSM, or Oracle Database)

### Oracle Support
1. Log in to My Oracle Support
2. Create Service Request
3. Select product: Oracle Database@Azure
4. Provide diagnostic output from this guide

### Useful Log Locations

**Azure:**
- Key Vault/Managed HSM: Azure Monitor → Diagnostic Settings
- Private Endpoint: Network Watcher → Connection Monitor

**Oracle:**
- Alert Log: Via OCI Console or SQL*Plus
- Trace Files: Available through Oracle Support

## Prevention Best Practices

1. **Test in Non-Production First:**
   - Always test private endpoint configuration in dev/test environment
   - Validate DNS resolution before deploying to production

2. **Document Configuration:**
   - Keep record of all resource IDs, IP addresses, and service principal details
   - Document DNS zone configurations

3. **Implement Monitoring:**
   - Set up Azure Monitor alerts for Key Vault access failures
   - Monitor ADBS alert logs for encryption errors

4. **Regular Testing:**
   - Test key operations monthly
   - Verify backup and restore procedures quarterly
   - Test disaster recovery procedures annually

5. **Keep Credentials Secure:**
   - Store service principal secrets in Azure Key Vault
   - Rotate secrets every 90 days
   - Use separate service principals for each environment

## Appendix: Quick Diagnostic Checklist

Use this checklist when troubleshooting:

- [ ] Private endpoint exists and is in "Approved" state
- [ ] Private endpoint has correct private IP address
- [ ] Private DNS zone exists and is linked to VNet
- [ ] Private DNS zone has correct A records
- [ ] OCI Private DNS zones exist with correct names
- [ ] OCI Private DNS zones have correct A records pointing to private IP
- [ ] Service principal exists and is not expired
- [ ] Service principal has required permissions
- [ ] ADBS has `route_outbound_connections = enforce_private_endpoint`
- [ ] ADBS has network ACL for Key Vault/HSM
- [ ] Key Vault/HSM public access is disabled (after configuration)
- [ ] Key exists and is enabled in Key Vault/HSM
- [ ] Can connect to Key Vault/HSM from VM in same VNet
- [ ] DNS resolution returns private IP from ADBS
- [ ] (Managed HSM only) Security domain is activated
