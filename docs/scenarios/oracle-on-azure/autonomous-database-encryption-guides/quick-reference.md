# Quick Reference Guide

This quick reference provides essential commands and configuration snippets for both Azure Key Vault and Managed HSM scenarios.

## Table of Contents
- [Key Differences: Key Vault vs Managed HSM](#key-differences-key-vault-vs-managed-hsm)
- [Azure CLI Commands](#azure-cli-commands)
- [SQL Commands](#sql-commands)
- [DNS Configuration](#dns-configuration)
- [Common Values](#common-values)

## Key Differences: Key Vault vs Managed HSM

| Feature | Azure Key Vault | Azure Managed HSM |
|---------|----------------|-------------------|
| **FIPS Certification** | FIPS 140-2 Level 2 | FIPS 140-3 Level 3 |
| **Tenancy** | Multi-tenant | Single-tenant (dedicated) |
| **Price** | Pay-per-operation | Fixed monthly cost (higher) |
| **Provisioning Time** | < 1 minute | 15-20 minutes |
| **Activation Required** | No | Yes (security domain) |
| **Access Control** | Access Policies or RBAC | RBAC only |
| **Private DNS Zone** | privatelink.vaultcore.azure.net | privatelink.managedhsm.azure.net |
| **Second DNS Zone** | vault.azure.net | managedhsm.azure.net |
| **URI Format** | https://{name}.vault.azure.net/ | https://{name}.managedhsm.azure.net/ |
| **Best For** | General encryption needs | Regulatory compliance (FIPS 140-3) |

## Azure CLI Commands

### Common Setup

```bash
# Login to Azure
az login

# Set subscription
az account set --subscription <SUBSCRIPTION_ID>

# Set common variables
RESOURCE_GROUP="rg-odaa-demo"
LOCATION="eastus"
VNET_NAME="vnet-odaa"
```

### Key Vault Commands

```bash
# Create Key Vault
KV_NAME="kv-demo-$RANDOM"
az keyvault create --name $KV_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --enable-purge-protection true --retention-days 90

# Create Private Endpoint
az network private-endpoint create --name pe-keyvault --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet subnet-keyvault --private-connection-resource-id $(az keyvault show --name $KV_NAME --query id --output tsv) --group-id vault --connection-name pe-connection-kv --location $LOCATION

# Create DNS Zone
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.vaultcore.azure.net"

# Link DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --name "dns-link-kv" --virtual-network $VNET_NAME --registration-enabled false

# Get Private IP
PRIVATE_IP=$(az network nic show --ids $(az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' --output tsv) --query 'ipConfigurations[0].privateIPAddress' --output tsv)

# Create DNS A Record
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --record-set-name $KV_NAME --ipv4-address $PRIVATE_IP

# Create Key
az keyvault key create --vault-name $KV_NAME --name adbs-encryption-key --kty RSA-HSM --size 2048 --ops encrypt decrypt wrapKey unwrapKey

# Disable Public Access
az keyvault update --name $KV_NAME --resource-group $RESOURCE_GROUP --public-network-access Disabled

# Grant Access (Access Policy)
az keyvault set-policy --name $KV_NAME --object-id <PRINCIPAL_ID> --key-permissions get unwrapKey wrapKey

# Grant Access (RBAC)
az role assignment create --assignee <PRINCIPAL_ID> --role "Key Vault Crypto User" --scope $(az keyvault show --name $KV_NAME --query id --output tsv)

# List Keys
az keyvault key list --vault-name $KV_NAME --output table

# Get Key Version
az keyvault key show --vault-name $KV_NAME --name adbs-encryption-key --query key.kid --output tsv
```

### Managed HSM Commands

```bash
# Create Managed HSM
HSM_NAME="hsm-demo-$RANDOM"
ADMIN_ID=$(az ad signed-in-user show --query id --output tsv)
az keyvault create --resource-group $RESOURCE_GROUP --name $HSM_NAME --location $LOCATION --sku premium --hsm-name $HSM_NAME --administrators $ADMIN_ID --retention-days 90

# Wait for provisioning (15-20 minutes)
az keyvault show --hsm-name $HSM_NAME --query properties.provisioningState --output tsv

# Create Private Endpoint
az network private-endpoint create --name pe-hsm --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet subnet-hsm --private-connection-resource-id $(az keyvault show --hsm-name $HSM_NAME --query id --output tsv) --group-id managedhsm --connection-name pe-connection-hsm --location $LOCATION

# Create DNS Zone
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.managedhsm.azure.net"

# Link DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --name "dns-link-hsm" --virtual-network $VNET_NAME --registration-enabled false

# Get Private IP
PRIVATE_IP=$(az network nic show --ids $(az network private-endpoint show --name pe-hsm --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' --output tsv) --query 'ipConfigurations[0].privateIPAddress' --output tsv)

# Create DNS A Record
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --record-set-name $HSM_NAME --ipv4-address $PRIVATE_IP

# Generate Security Domain Keys
openssl req -newkey rsa:2048 -nodes -keyout sd-key1.key -x509 -days 365 -out sd-cert1.cer -subj "/CN=SD1"
openssl req -newkey rsa:2048 -nodes -keyout sd-key2.key -x509 -days 365 -out sd-cert2.cer -subj "/CN=SD2"
openssl req -newkey rsa:2048 -nodes -keyout sd-key3.key -x509 -days 365 -out sd-cert3.cer -subj "/CN=SD3"

# Download Security Domain
az keyvault security-domain download --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-cert1.cer ./sd-cert2.cer ./sd-cert3.cer --sd-quorum 2 --security-domain-file ${HSM_NAME}-SD.json

# Create Key
az keyvault key create --hsm-name $HSM_NAME --name adbs-encryption-key --kty RSA-HSM --size 2048 --ops encrypt decrypt wrapKey unwrapKey

# Configure Firewall
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Deny --bypass AzureServices

# Grant Access (RBAC only)
az role assignment create --assignee <PRINCIPAL_ID> --role "Managed HSM Crypto User" --scope $(az keyvault show --hsm-name $HSM_NAME --query id --output tsv)

# List Keys
az keyvault key list --hsm-name $HSM_NAME --output table

# Get Key Version
az keyvault key show --hsm-name $HSM_NAME --name adbs-encryption-key --query key.kid --output tsv
```

### Network Commands

```bash
# Create VNet
az network vnet create --name $VNET_NAME --resource-group $RESOURCE_GROUP --address-prefix 10.0.0.0/16 --location $LOCATION

# Create Delegated Subnet for ADBS
az network vnet subnet create --name subnet-adbs --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes 10.0.1.0/24 --delegations "Oracle.Database/networkAttachments"

# Create Subnet for Private Endpoint
az network vnet subnet create --name subnet-keyvault --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes 10.0.2.0/24

# List Private Endpoints
az network private-endpoint list --resource-group $RESOURCE_GROUP --output table

# Show Private Endpoint
az network private-endpoint show --name <PE_NAME> --resource-group $RESOURCE_GROUP

# List Private Endpoint Connections
az keyvault private-endpoint-connection list --vault-name $KV_NAME --resource-group $RESOURCE_GROUP --output table
az keyvault private-endpoint-connection list --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --output table

# Approve Private Endpoint Connection
az keyvault private-endpoint-connection approve --vault-name $KV_NAME --resource-group $RESOURCE_GROUP --name <CONNECTION_NAME>
```

### Verification Commands

```bash
# Get Key Vault URI
az keyvault show --name $KV_NAME --query properties.vaultUri --output tsv

# Get Managed HSM URI
az keyvault show --hsm-name $HSM_NAME --query properties.hsmUri --output tsv

# Check Public Access
az keyvault show --name $KV_NAME --query properties.publicNetworkAccess --output tsv
az keyvault show --hsm-name $HSM_NAME --query properties.networkAcls.defaultAction --output tsv

# List Role Assignments
az role assignment list --assignee <PRINCIPAL_ID> --output table

# Check Private DNS Zone
az network private-dns zone show --resource-group $RESOURCE_GROUP --name privatelink.vaultcore.azure.net

# List DNS Records
az network private-dns record-set a list --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net --output table
```

## SQL Commands

### Enable Azure Principal Authentication

```sql
-- CORRECT: For ODAA Autonomous Database
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/
```

### Verify Principal

```sql
-- Check principal status
SELECT 
    cloud_identity,
    cloud_identity_id,
    status,
    JSON_VALUE(cloud_identity_properties, '$.azure_principal_id') as azure_principal_id
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';
```

### Configure Private Endpoint Resolution

```sql
-- Enable private endpoint resolution
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';

-- Verify setting
SELECT property_name, property_value 
FROM DATABASE_PROPERTIES 
WHERE property_name = 'ROUTE_OUTBOUND_CONNECTIONS';
```

### Network ACL Configuration

```sql
-- Grant network access for testing
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host => '<your-kv-or-hsm>.vault.azure.net',
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

### Test Connectivity

```sql
-- Test HTTPS connection
SET SERVEROUTPUT ON;
DECLARE
    req UTL_HTTP.REQ;
    resp UTL_HTTP.RESP;
BEGIN
    req := UTL_HTTP.BEGIN_REQUEST('https://<your-kv>.vault.azure.net/healthstatus');
    UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Mozilla/4.0');
    resp := UTL_HTTP.GET_RESPONSE(req);
    DBMS_OUTPUT.PUT_LINE('HTTP Status: ' || resp.status_code);
    UTL_HTTP.END_RESPONSE(resp);
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Connection established');
EXCEPTION
    WHEN UTL_HTTP.END_OF_BODY THEN
        UTL_HTTP.END_RESPONSE(resp);
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Connected via private endpoint');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
```

### Verify Encryption

```sql
-- Check encryption wallet status
SELECT * FROM V$ENCRYPTION_WALLET;

-- Check encrypted columns
SELECT * FROM DBA_ENCRYPTED_COLUMNS;

-- Check database properties
SELECT property_name, property_value 
FROM DATABASE_PROPERTIES 
WHERE property_name LIKE '%ENCRYPT%' OR property_name LIKE '%TDE%';
```

### Disable Principal (if needed)

```sql
-- Disable principal authentication
BEGIN
    DBMS_CLOUD_ADMIN.DISABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/
```

## DNS Configuration

### OCI Private DNS Zones

For **Key Vault**, create these zones in OCI:
1. `privatelink.vaultcore.azure.net`
2. `vault.azure.net`

For **Managed HSM**, create these zones in OCI:
1. `privatelink.managedhsm.azure.net`
2. `managedhsm.azure.net`

### A Record Configuration

For each zone, create an A record:

```
Record Name: <your-kv-or-hsm-name>
Record Type: A
TTL: 300
IP Address: <private-ip-from-azure-private-endpoint>
```

### Testing DNS Resolution

From a VM in the same VNet:

```bash
# Should resolve to private IP (10.x.x.x)
nslookup <kv-name>.vault.azure.net
nslookup <hsm-name>.managedhsm.azure.net

# Test with dig
dig <kv-name>.vault.azure.net

# Test HTTPS
curl -v https://<kv-name>.vault.azure.net/
```

## Common Values

### Supported Key Types

| Parameter | Value |
|-----------|-------|
| Key Type | RSA, RSA-HSM |
| Key Size | 2048, 3072, 4096 bits |
| Operations | encrypt, decrypt, wrapKey, unwrapKey |

### URIs

| Service | URI Format | Example |
|---------|-----------|---------|
| Key Vault | https://{name}.vault.azure.net/ | https://kv-demo-12345.vault.azure.net/ |
| Managed HSM | https://{name}.managedhsm.azure.net/ | https://hsm-demo-12345.managedhsm.azure.net/ |

### Private DNS Zones

| Service | Primary Zone | Secondary Zone |
|---------|--------------|----------------|
| Key Vault | privatelink.vaultcore.azure.net | vault.azure.net |
| Managed HSM | privatelink.managedhsm.azure.net | managedhsm.azure.net |

### RBAC Roles

| Role | Purpose | Scope |
|------|---------|-------|
| Key Vault Crypto User | Use keys for wrap/unwrap | Key Vault |
| Key Vault Crypto Officer | Manage keys | Key Vault |
| Managed HSM Crypto User | Use keys for crypto operations | Managed HSM |
| Managed HSM Crypto Officer | Manage keys | Managed HSM |
| Managed HSM Administrator | Full control | Managed HSM |

## Troubleshooting Quick Checks

### Check 1: Principal Exists

```sql
SELECT COUNT(*) FROM USER_CLOUD_IDENTITIES WHERE provider = 'AZURE';
```
Expected: 1

### Check 2: Private Endpoint Approved

```bash
az keyvault private-endpoint-connection list --vault-name $KV_NAME --resource-group $RESOURCE_GROUP --query "[].properties.privateLinkServiceConnectionState.status" --output tsv
```
Expected: "Approved"

### Check 3: DNS Resolution

```bash
# Should return private IP (10.x.x.x)
az network private-dns record-set a show --resource-group $RESOURCE_GROUP --zone-name privatelink.vaultcore.azure.net --name $KV_NAME --query aRecords[0].ipv4Address --output tsv
```

### Check 4: Public Access Disabled

```bash
az keyvault show --name $KV_NAME --query properties.publicNetworkAccess --output tsv
```
Expected: "Disabled"

### Check 5: Private Endpoint Resolution Enabled

```sql
SELECT property_value FROM DATABASE_PROPERTIES WHERE property_name = 'ROUTE_OUTBOUND_CONNECTIONS';
```
Expected: "ENFORCE_PRIVATE_ENDPOINT"

## Additional Resources

- **Full Guides:**
  - [Scenario 1: Azure Key Vault](./scenario-1-keyvault-private-endpoint.md)
  - [Scenario 2: Managed HSM](./scenario-2-managed-hsm-private-endpoint.md)
  - [Troubleshooting Guide](./troubleshooting.md)

- **Official Documentation:**
  - [Oracle ADBS](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/)
  - [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/)
  - [Azure Managed HSM](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/)
  - [Azure Private Link](https://learn.microsoft.com/en-us/azure/private-link/)
