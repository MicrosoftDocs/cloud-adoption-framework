# Scenario 1: ODAA Autonomous Database + Azure Key Vault + Private Endpoints

This guide provides step-by-step instructions for integrating Oracle Autonomous Database Serverless (ADBS) with Azure Key Vault using Private Endpoints for customer-managed encryption keys.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Architecture Overview](#architecture-overview)
3. [Step 1: Create Virtual Network and Subnets](#step-1-create-virtual-network-and-subnets)
4. [Step 2: Provision Oracle Autonomous Database](#step-2-provision-oracle-autonomous-database)
5. [Step 3: Create Azure Key Vault with Private Endpoint](#step-3-create-azure-key-vault-with-private-endpoint)
6. [Step 4: Configure Private DNS Zones](#step-4-configure-private-dns-zones)
7. [Step 5: Create Service Principal](#step-5-create-service-principal)
8. [Step 6: Configure Key Vault Access Policies](#step-6-configure-key-vault-access-policies)
9. [Step 7: Configure ADBS for Private Endpoint Resolution](#step-7-configure-adbs-for-private-endpoint-resolution)
10. [Step 8: Configure ADBS Encryption Key](#step-8-configure-adbs-encryption-key)
11. [Testing and Validation](#testing-and-validation)

## Prerequisites

- Azure subscription with Contributor or Owner access
- Azure CLI version 2.25.0 or later installed
- Oracle Cloud Infrastructure (OCI) console access
- SQL client (SQL*Plus or SQL Developer)
- Azure region that supports ODAA advanced networking

Verify your Azure CLI installation:
```bash
az --version
az login
```

## Architecture Overview

```
┌──────────────────────────────────────────────────────────┐
│            Azure Virtual Network (10.0.0.0/16)           │
│                                                          │
│  ┌────────────────────┐        ┌───────────────────┐   │
│  │  Delegated Subnet  │        │ Private Endpoint  │   │
│  │   (10.0.1.0/24)    │        │   Subnet          │   │
│  │                    │        │  (10.0.2.0/24)    │   │
│  │  ┌──────────────┐  │        │  ┌────────────┐  │   │
│  │  │ Oracle ADBS  │──┼────────┼──│ Private EP │  │   │
│  │  │ (10.0.1.10)  │  │        │  │ (10.0.2.4) │  │   │
│  │  └──────────────┘  │        │  └────────────┘  │   │
│  └────────────────────┘        └───────────────────┘   │
│                                          │              │
└──────────────────────────────────────────┼──────────────┘
                                           │
                       Private Link Connection
                                           │
                                  ┌────────▼────────┐
                                  │  Azure Key      │
                                  │  Vault          │
                                  │  (Private IP)   │
                                  └─────────────────┘
```

## Step 1: Create Virtual Network and Subnets

### 1.1 Set Environment Variables

```bash
# Set your configuration
RESOURCE_GROUP="rg-odaa-keyvault-demo"
LOCATION="eastus"
VNET_NAME="vnet-odaa"
VNET_ADDRESS="10.0.0.0/16"
DELEGATED_SUBNET="subnet-oracle-delegated"
DELEGATED_SUBNET_ADDRESS="10.0.1.0/24"
PE_SUBNET="subnet-private-endpoints"
PE_SUBNET_ADDRESS="10.0.2.0/24"
```

### 1.2 Create Resource Group

```bash
az group create --name $RESOURCE_GROUP --location $LOCATION
```

### 1.3 Create Virtual Network

```bash
az network vnet create --resource-group $RESOURCE_GROUP --name $VNET_NAME --address-prefixes $VNET_ADDRESS --location $LOCATION
```

### 1.4 Create Delegated Subnet for Oracle

```bash
az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $DELEGATED_SUBNET --address-prefixes $DELEGATED_SUBNET_ADDRESS --delegations Oracle.Database/networkAttachments
```

### 1.5 Create Private Endpoint Subnet

```bash
az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $PE_SUBNET --address-prefixes $PE_SUBNET_ADDRESS
```

## Step 2: Provision Oracle Autonomous Database

### 2.1 Create ADBS through Azure Portal

1. Navigate to Azure Portal → Search for "Oracle Autonomous Database"
2. Click **Create**
3. Fill in the basic information:
   - **Subscription:** Select your subscription
   - **Resource Group:** Select `rg-odaa-keyvault-demo`
   - **Database Name:** `adbdemo`
   - **Workload Type:** Transaction Processing or Data Warehouse
   - **Admin Password:** Set a strong password (save it securely)

### 2.2 Configure Networking

1. In the **Networking** tab:
   - **Access Type:** Select "Managed private virtual network IP only"
   - **Virtual Network:** Select `vnet-odaa`
   - **Subnet:** Select `subnet-oracle-delegated`
   - **Require mutual TLS (mTLS) authentication:** Check if needed

2. Click **Review + Create** → **Create**

### 2.3 Note the Database Information

After provisioning completes, note:
- Database OCID
- Connection strings
- VCN Name (will be used for DNS configuration)

## Step 3: Create Azure Key Vault with Private Endpoint

### 3.1 Set Key Vault Variables

```bash
KEYVAULT_NAME="kv-odaa-demo-$RANDOM"
KEYVAULT_SKU="premium"
KEY_NAME="odaa-encryption-key"
```

### 3.2 Create Key Vault

```bash
az keyvault create --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku $KEYVAULT_SKU --enable-rbac-authorization false
```

**Note:** Initially create with public access to allow key creation through Azure Portal.

### 3.3 Create Private Endpoint for Key Vault

```bash
# Get Key Vault resource ID
KEYVAULT_ID=$(az keyvault show --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP --query id -o tsv)

# Create Private Endpoint
az network private-endpoint create --name pe-keyvault --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet $PE_SUBNET --private-connection-resource-id $KEYVAULT_ID --group-id vault --connection-name connection-keyvault --location $LOCATION
```

### 3.4 Create Private DNS Zone for Key Vault

```bash
# Create Private DNS Zone
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.vaultcore.azure.net"

# Link DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --name dns-link-keyvault --virtual-network $VNET_NAME --registration-enabled false
```

### 3.5 Create DNS Records for Private Endpoint

```bash
# Get Private Endpoint NIC ID
NIC_ID=$(az network private-endpoint show --name pe-keyvault --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' -o tsv)

# Get Private IP Address
PRIVATE_IP=$(az network nic show --ids $NIC_ID --query 'ipConfigurations[0].privateIPAddress' -o tsv)

# Create A record in Private DNS Zone
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --record-set-name $KEYVAULT_NAME --ipv4-address $PRIVATE_IP

echo "Key Vault Private IP: $PRIVATE_IP"
```

### 3.6 Create Encryption Key

```bash
# Create RSA 4096 key (recommended for production)
az keyvault key create --vault-name $KEYVAULT_NAME --name $KEY_NAME --kty RSA --size 4096 --ops encrypt decrypt wrapKey unwrapKey
```

**Note:** Supported key types for Oracle ADBS:
- RSA 2048
- RSA 3072  
- RSA 4096 (recommended)

### 3.7 Get Key Details

```bash
# Get Key Vault URI
KEYVAULT_URI=$(az keyvault show --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP --query properties.vaultUri -o tsv)

# Get Key Version
KEY_VERSION=$(az keyvault key show --vault-name $KEYVAULT_NAME --name $KEY_NAME --query key.kid -o tsv | awk -F'/' '{print $NF}')

echo "Key Vault URI: $KEYVAULT_URI"
echo "Key Name: $KEY_NAME"
echo "Key Version: $KEY_VERSION"
```

### 3.8 Disable Public Access

After creating the key, disable public network access:

```bash
az keyvault update --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP --public-network-access Disabled
```

## Step 4: Configure Private DNS Zones

### 4.1 Gather DNS Information from Azure

```bash
# Get the FQDN of Key Vault
KEYVAULT_FQDN="${KEYVAULT_NAME}.vault.azure.net"

echo "Key Vault FQDN: $KEYVAULT_FQDN"
echo "Key Vault Name: $KEYVAULT_NAME"
echo "Private IP: $PRIVATE_IP"
echo "DNS Zone: privatelink.vaultcore.azure.net"
```

### 4.2 Configure DNS in OCI

1. In Azure Portal, navigate to your ADBS instance
2. Click **Go to OCI** button
3. In OCI Console, note the **VCN Name** from the database information page
4. Navigate to **Networking → DNS Management → Private Views**
5. Search for the Private View with the same name as your VCN
6. Click on the Private View

### 4.3 Create First Private DNS Zone (privatelink.vaultcore.azure.net)

1. Click on **Private zones** tab
2. Click **Create zone**
3. Enter zone details:
   - **Zone Name:** `privatelink.vaultcore.azure.net`
   - **Compartment:** Same as your ADBS
4. Click **Create**

### 4.4 Add A Record to First Zone

1. Navigate to the created zone: `privatelink.vaultcore.azure.net`
2. Click **Records** tab
3. Click **Manage records**
4. Click **Add record**
5. Enter record details:
   - **Record Type:** A
   - **Name:** Your Key Vault name (e.g., `kv-odaa-demo-12345`)
   - **Address:** Private IP address (e.g., `10.0.2.4`)
   - **TTL:** 3600
6. Click **Add answer**
7. Click **Review changes**
8. Click **Publish changes**

### 4.5 Create Second Private DNS Zone (vault.azure.net)

1. Return to Private zones tab
2. Click **Create zone**
3. Enter zone details:
   - **Zone Name:** `vault.azure.net`
   - **Compartment:** Same as your ADBS
4. Click **Create**

### 4.6 Add A Record to Second Zone

1. Navigate to the created zone: `vault.azure.net`
2. Click **Records** tab
3. Click **Manage records**
4. Click **Add record**
5. Enter record details:
   - **Record Type:** A
   - **Name:** Your Key Vault name (e.g., `kv-odaa-demo-12345`)
   - **Address:** Private IP address (e.g., `10.0.2.4`)
   - **TTL:** 3600
6. Click **Add answer**
7. Click **Review changes**
8. Click **Publish changes**

## Step 5: Create Service Principal

### Option A: Manual Service Principal Creation (Recommended)

#### 5.1 Create Service Principal

```bash
# Create service principal with Key Vault access
SP_OUTPUT=$(az ad sp create-for-rbac --name "sp-odaa-keyvault" --role "Key Vault Crypto Service Encryption User" --scopes /subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$KEYVAULT_NAME)

# Extract values
APP_ID=$(echo $SP_OUTPUT | jq -r '.appId')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenant')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.password')

echo "Application ID: $APP_ID"
echo "Tenant ID: $TENANT_ID"
echo "Client Secret: $CLIENT_SECRET"

# Save these values securely!
```

#### 5.2 Store Service Principal Credentials

```bash
# Store in environment variables for later use
export AZURE_CLIENT_ID=$APP_ID
export AZURE_TENANT_ID=$TENANT_ID
export AZURE_CLIENT_SECRET=$CLIENT_SECRET
```

### Option B: Oracle Automatic Principal Creation

If you prefer Oracle to create the service principal automatically:

```sql
-- Connect to ADBS as ADMIN
BEGIN
  DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
    provider => 'AZURE',
    params => JSON_OBJECT('azure_tenantid' value 'your-tenant-id')
  );
END;
/
```

**Note:** This may fail with ORA-27465 if network access to Azure AD is not properly configured. See troubleshooting guide.

## Step 6: Configure Key Vault Access Policies

### 6.1 Grant Access Policy to Service Principal

```bash
# Grant key permissions to service principal
az keyvault set-policy --name $KEYVAULT_NAME --spn $APP_ID --key-permissions get unwrapKey wrapKey list

# Verify access policy
az keyvault show --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP --query properties.accessPolicies
```

### 6.2 Test Service Principal Access

```bash
# Get access token
TOKEN=$(az account get-access-token --resource https://vault.azure.net --query accessToken -o tsv)

# Test key access
curl -X GET "$KEYVAULT_URI/keys/$KEY_NAME?api-version=7.4" -H "Authorization: Bearer $TOKEN"
```

## Step 7: Configure ADBS for Private Endpoint Resolution

### 7.1 Connect to ADBS

Download wallet and connect using SQL*Plus or SQL Developer:

```bash
# Download wallet from Azure Portal or OCI Console
# Extract wallet files
# Set TNS_ADMIN environment variable
export TNS_ADMIN=/path/to/wallet

# Connect as ADMIN
sqlplus admin@adbdemo_high
```

### 7.2 Enable Network ACL for Key Vault

```sql
-- Allow ADMIN user to connect to Key Vault
BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => '${KEYVAULT_NAME}.vault.azure.net',
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

### 7.3 Enable Private Endpoint Resolution

```sql
-- Force ADBS to use private endpoints
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
```

### 7.4 Restart Database

This setting requires a database restart:

1. In Azure Portal or OCI Console, navigate to your ADBS
2. Click **Stop**
3. Wait for database to stop completely
4. Click **Start**
5. Wait for database to be available

### 7.5 Verify Setting

After restart, verify the setting:

```sql
SELECT PROPERTY_NAME, PROPERTY_VALUE 
FROM DATABASE_PROPERTIES 
WHERE PROPERTY_NAME = 'ROUTE_OUTBOUND_CONNECTIONS';
```

Expected output:
```
PROPERTY_NAME                PROPERTY_VALUE
---------------------------- ---------------------------
ROUTE_OUTBOUND_CONNECTIONS   ENFORCE_PRIVATE_ENDPOINT
```

## Step 8: Configure ADBS Encryption Key

### 8.1 Test Connectivity to Key Vault (Optional)

```sql
-- Test DNS resolution and connectivity
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
  value VARCHAR2(1024);
BEGIN
  req := UTL_HTTP.BEGIN_REQUEST('https://${KEYVAULT_NAME}.vault.azure.net/healthstatus');
  UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Oracle-ADB');
  resp := UTL_HTTP.GET_RESPONSE(req);
  
  DBMS_OUTPUT.PUT_LINE('Response Status: ' || resp.status_code);
  
  LOOP
    UTL_HTTP.READ_LINE(resp, value, TRUE);
    DBMS_OUTPUT.PUT_LINE(value);
  END LOOP;
  
  UTL_HTTP.END_RESPONSE(resp);
EXCEPTION
  WHEN UTL_HTTP.END_OF_BODY THEN
    UTL_HTTP.END_RESPONSE(resp);
    DBMS_OUTPUT.PUT_LINE('Connection successful - Private endpoint is working');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

### 8.2 Configure Customer-Managed Encryption Key

#### Via OCI Console:

1. Navigate to your ADBS in OCI Console
2. Under **Resources**, click **Customer-Managed Encryption Keys**
3. Click **Manage encryption key**
4. Select **Encrypt using a customer-managed key**
5. Fill in the details:
   - **Vault Type:** Azure Key Vault
   - **Vault URI:** `https://${KEYVAULT_NAME}.vault.azure.net`
   - **Key Name:** `${KEY_NAME}`
   - **Service Principal Client ID:** `$APP_ID`
   - **Service Principal Tenant ID:** `$TENANT_ID`
   - **Service Principal Secret:** `$CLIENT_SECRET`
6. Click **Save**

#### Via SQL:

```sql
-- Alternative: Configure via SQL
BEGIN
  DBMS_CLOUD_ADMIN.UPDATE_MASTER_KEY(
    provider => 'AZURE_VAULT',
    credential_name => 'AZURE_KEY_VAULT_CRED',
    params => JSON_OBJECT(
      'vault_uri' value 'https://${KEYVAULT_NAME}.vault.azure.net',
      'key_name' value '${KEY_NAME}',
      'tenant_id' value '${TENANT_ID}',
      'client_id' value '${APP_ID}',
      'client_secret' value '${CLIENT_SECRET}'
    )
  );
END;
/
```

### 8.3 Monitor Encryption Key Update

The database will transition to **UPDATING** state. Monitor the progress:

1. In Azure Portal or OCI Console, check the ADBS state
2. Update typically takes 5-10 minutes
3. Database will return to **AVAILABLE** state when complete

### 8.4 Verify Encryption Key

```sql
-- Verify encryption key configuration
SELECT * FROM V$ENCRYPTION_WALLET;

-- Check key rotation history
SELECT * FROM V$ENCRYPTION_KEYS ORDER BY CREATION_TIME DESC;
```

## Testing and Validation

### Test 1: Verify DNS Resolution

From a VM in the same VNet:

```bash
nslookup ${KEYVAULT_NAME}.vault.azure.net
```

Expected output should show the private IP address (10.0.2.4).

### Test 2: Verify Database Encryption

```sql
-- Check encryption status
SELECT * FROM V$ENCRYPTED_TABLESPACES;

-- Verify wallet is open
SELECT WRL_TYPE, STATUS FROM V$ENCRYPTION_WALLET;
```

Expected output:
```
WRL_TYPE             STATUS
-------------------- --------------------
AZURE_VAULT          OPEN
```

### Test 3: Test Key Rotation

```bash
# Create a new key version
az keyvault key create --vault-name $KEYVAULT_NAME --name $KEY_NAME --kty RSA --size 4096

# Rotate encryption key in ADBS
# Execute via OCI Console or SQL
```

### Test 4: Verify Private Endpoint Traffic

```sql
-- Check network statistics
SELECT * FROM V$SESSION WHERE PROGRAM LIKE '%DBMS_CLOUD%';
```

### Test 5: Test Backup and Restore

```sql
-- Create manual backup
BEGIN
  DBMS_CLOUD_ADMIN.CREATE_MANUAL_BACKUP(
    backup_name => 'test_backup_with_cmek'
  );
END;
/
```

## Cleanup (Optional)

To remove all resources:

```bash
# Delete Resource Group (removes all resources)
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Delete Service Principal
az ad sp delete --id $APP_ID
```

## Next Steps

1. Implement key rotation policies
2. Enable Azure Monitor logging for Key Vault
3. Set up alerts for key access and modifications
4. Configure backup retention policies
5. Review and implement disaster recovery procedures

## Additional Notes

### Performance Considerations
- Private endpoint adds minimal latency (<5ms typical)
- Initial encryption key operation may take longer (first access)
- Subsequent operations are cached

### Security Best Practices
- Rotate service principal secrets every 90 days
- Enable soft-delete and purge protection on Key Vault
- Use Azure RBAC instead of access policies when possible
- Monitor key usage with Azure Monitor
- Implement network security groups on subnets

### Cost Considerations
- Private Endpoint: ~$7/month per endpoint
- Key Vault Premium: ~$1/month + $0.03 per 10,000 operations
- ADBS: Based on OCPU and storage configuration

## Related Guides

- [Scenario 2: Managed HSM + Private Endpoints](./scenario2-managed-hsm-private-endpoint.md)
- [Troubleshooting Guide](./troubleshooting.md)
