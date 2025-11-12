# Scenario 1: Oracle Autonomous Database with Azure Key Vault and Private Endpoints

This guide provides step-by-step instructions to configure Oracle Database@Azure Autonomous Database Serverless (ODAA ADBS) to use customer-managed encryption keys from Azure Key Vault with private endpoint connectivity.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Step 1: Provision Oracle Autonomous Database](#step-1-provision-oracle-autonomous-database)
3. [Step 2: Create Azure Key Vault with Private Endpoint](#step-2-create-azure-key-vault-with-private-endpoint)
4. [Step 3: Create Encryption Key](#step-3-create-encryption-key)
5. [Step 4: Configure Network Security](#step-4-configure-network-security)
6. [Step 5: Configure Private DNS Zones in OCI](#step-5-configure-private-dns-zones-in-oci)
7. [Step 6: Create and Configure ADBS Principal](#step-6-create-and-configure-adbs-principal)
8. [Step 7: Grant Key Vault Access](#step-7-grant-key-vault-access)
9. [Step 8: Enable Private Endpoint Resolution](#step-8-enable-private-endpoint-resolution)
10. [Step 9: Configure Customer-Managed Encryption](#step-9-configure-customer-managed-encryption)
11. [Step 10: Validation](#step-10-validation)

## Prerequisites

### Required Information
- Azure Subscription ID
- Resource Group name
- Virtual Network name and address space
- Azure region with advanced networking support
- Azure AD Tenant ID

### Tools
- Azure CLI 2.50.0 or later
- SQL client (SQL*Plus, SQL Developer, or similar)
- Access to Azure Portal
- Access to OCI Console

### Permissions
- Azure: Owner or Contributor on subscription
- OCI: Administrator access to ADBS

## Step 1: Provision Oracle Autonomous Database

### 1.1 Create Resource Group

```bash
# Set variables
RESOURCE_GROUP="rg-odaa-encryption-demo"
LOCATION="eastus"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION
```

### 1.2 Create Virtual Network

```bash
# Set VNet variables
VNET_NAME="vnet-odaa-demo"
VNET_ADDRESS="10.0.0.0/16"
ADBS_SUBNET="subnet-adbs-delegated"
ADBS_SUBNET_ADDRESS="10.0.1.0/24"
KV_SUBNET="subnet-keyvault"
KV_SUBNET_ADDRESS="10.0.2.0/24"

# Create VNet
az network vnet create --name $VNET_NAME --resource-group $RESOURCE_GROUP --address-prefix $VNET_ADDRESS --location $LOCATION

# Create delegated subnet for ADBS
az network vnet subnet create --name $ADBS_SUBNET --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes $ADBS_SUBNET_ADDRESS --delegations "Oracle.Database/networkAttachments"

# Create subnet for Key Vault private endpoint
az network vnet subnet create --name $KV_SUBNET --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes $KV_SUBNET_ADDRESS
```

### 1.3 Create Autonomous Database via Azure Portal

1. Navigate to Azure Portal
2. Search for "Oracle Database@Azure - Autonomous Database"
3. Click "+ Create"
4. **Basics tab:**
   - Select your subscription and resource group
   - Database name: `adb-encryption-demo`
   - Workload type: Select based on requirements (OLTP recommended for testing)
   - Configure admin credentials

5. **Networking tab:**
   - Access type: Select "Managed private virtual network IP only"
   - Virtual network: Select `vnet-odaa-demo`
   - Subnet: Select `subnet-adbs-delegated`
   - Require mutual TLS (mTLS) authentication: Check if required

6. Review and create the database
7. Wait for provisioning to complete (approximately 2-5 minutes)

### 1.4 Note the VCN Name

Once the database is created:
1. Go to the ADBS resource in Azure Portal
2. Click "Go to OCI" button
3. In OCI Console, note the VCN name (example: `VCN-multicloudnetworklink20250605145841`)
4. This will be needed for DNS configuration

## Step 2: Create Azure Key Vault with Private Endpoint

### 2.1 Create Key Vault

```bash
# Set Key Vault variables
KV_NAME="kv-odaa-demo-$RANDOM"
echo "Key Vault Name: $KV_NAME"

# Create Key Vault
az keyvault create --name $KV_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --enable-purge-protection true --retention-days 90 --sku standard
```

### 2.2 Create Private Endpoint for Key Vault

```bash
# Set private endpoint variables
PE_NAME="pe-keyvault"
PE_CONNECTION="pe-connection-keyvault"

# Get Key Vault resource ID
KV_ID=$(az keyvault show --name $KV_NAME --resource-group $RESOURCE_GROUP --query id --output tsv)

# Create private endpoint
az network private-endpoint create --name $PE_NAME --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet $KV_SUBNET --private-connection-resource-id $KV_ID --group-id vault --connection-name $PE_CONNECTION --location $LOCATION

# Create Private DNS Zone for Key Vault
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.vaultcore.azure.net"

# Link Private DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --name "dns-link-kv" --virtual-network $VNET_NAME --registration-enabled false

# Get private endpoint NIC ID
PE_NIC_ID=$(az network private-endpoint show --name $PE_NAME --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' --output tsv)

# Get private IP address
PRIVATE_IP=$(az network nic show --ids $PE_NIC_ID --query 'ipConfigurations[0].privateIPAddress' --output tsv)
echo "Key Vault Private IP: $PRIVATE_IP"

# Create DNS A record
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.vaultcore.azure.net" --record-set-name $KV_NAME --ipv4-address $PRIVATE_IP
```

### 2.3 Gather Key Vault Information

```bash
# Get Key Vault URI
KV_URI=$(az keyvault show --name $KV_NAME --resource-group $RESOURCE_GROUP --query properties.vaultUri --output tsv)
echo "Key Vault URI: $KV_URI"

# Get Key Vault FQDN
KV_FQDN="${KV_NAME}.vault.azure.net"
echo "Key Vault FQDN: $KV_FQDN"
```

## Step 3: Create Encryption Key

### 3.1 Create RSA Key

```bash
# Set key variables
KEY_NAME="adbs-encryption-key"

# Create RSA-HSM key (recommended for production)
az keyvault key create --vault-name $KV_NAME --name $KEY_NAME --kty RSA-HSM --size 2048 --ops encrypt decrypt wrapKey unwrapKey --protection hsm

# Get key identifier
KEY_ID=$(az keyvault key show --vault-name $KV_NAME --name $KEY_NAME --query key.kid --output tsv)
echo "Key ID: $KEY_ID"
```

**Supported Key Types:**
- Key type: RSA or RSA-HSM
- Key size: 2048, 3072, or 4096 bits

## Step 4: Configure Network Security

### 4.1 Disable Public Access to Key Vault

```bash
# Disable public network access
az keyvault update --name $KV_NAME --resource-group $RESOURCE_GROUP --public-network-access Disabled
```

**Note:** After this step, Key Vault is only accessible via the private endpoint.

## Step 5: Configure Private DNS Zones in OCI

### 5.1 Access OCI Console

1. From Azure Portal, navigate to your ADBS resource
2. Click "Go to OCI" button
3. Log in to OCI Console

### 5.2 Navigate to Private Views

1. In OCI Console, go to: **Networking** > **DNS Management** > **Private Views**
2. Search for the Private View matching your VCN name (noted in Step 1.4)
3. Click on the Private View

### 5.3 Create Private DNS Zones

You need to create two private zones:

#### Zone 1: privatelink.vaultcore.azure.net

```
# In OCI Console:
1. Click "Private zones" tab
2. Click "Create zone"
3. Enter the following:
   - Zone name: privatelink.vaultcore.azure.net
   - Zone type: Primary
   - Create in compartment: (select your compartment)
4. Click "Create"
```

#### Zone 2: vault.azure.net

```
# In OCI Console:
1. Click "Create zone" again
2. Enter the following:
   - Zone name: vault.azure.net
   - Zone type: Primary
   - Create in compartment: (select your compartment)
3. Click "Create"
```

### 5.4 Add DNS Records

For **each** of the two zones created above, add an A record:

```
# For privatelink.vaultcore.azure.net:
1. Click on the zone name
2. Go to "Records" tab
3. Click "Manage records"
4. Click "Add record"
5. Enter:
   - Record type: A
   - Name: <YOUR_KV_NAME> (e.g., kv-odaa-demo-12345)
   - TTL: 300
   - RDATA: <PRIVATE_IP> (e.g., 10.0.2.4)
6. Click "Add record"
7. Click "Review changes"
8. Click "Publish changes"

# Repeat the same process for vault.azure.net zone
```

## Step 6: Create and Configure ADBS Principal

### 6.1 Connect to ADBS

Connect to your Autonomous Database as ADMIN user using your preferred SQL client.

### 6.2 Enable Principal Authentication

```sql
-- Get your Azure Tenant ID first from Azure Portal or CLI
-- az account show --query tenantId --output tsv

BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        username => 'ADMIN');
END;
/
```

**Important Notes:**
- Do **not** include the `azure_tenantid` parameter - it's not required for ADBS
- The procedure will create an Azure service principal automatically
- This may take 1-2 minutes to complete

### 6.3 Retrieve Principal Information

```sql
-- Check if principal was created successfully
SELECT cloud_identity, cloud_identity_id, status 
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';

-- Get the service principal object ID
SELECT JSON_VALUE(cloud_identity_properties, '$.azure_principal_id') as principal_id
FROM USER_CLOUD_IDENTITIES 
WHERE provider = 'AZURE';
```

Save the `principal_id` output - you'll need it for granting Key Vault access.

## Step 7: Grant Key Vault Access

### 7.1 Get the Principal ID

From Step 6.3, you should have the Azure principal ID. If you need to retrieve it again:

```bash
# Replace with your ADBS database name
ADBS_NAME="adb-encryption-demo"

# The principal name follows the pattern: ADBS_APP_OC<ID>
# You can find it in Azure AD or the output from Step 6.3
```

### 7.2 Grant Access Policy (Vault Access Policy Model)

```bash
# Set variables from Step 6.3
PRINCIPAL_ID="<YOUR_PRINCIPAL_ID>"

# Grant Key Vault permissions
az keyvault set-policy --name $KV_NAME --object-id $PRINCIPAL_ID --key-permissions get unwrapKey wrapKey --secret-permissions get
```

### 7.3 Grant Access Policy (Azure RBAC Model)

If using Azure RBAC instead of access policies:

```bash
# Assign Key Vault Crypto User role
az role assignment create --assignee $PRINCIPAL_ID --role "Key Vault Crypto User" --scope "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$KV_NAME"
```

## Step 8: Enable Private Endpoint Resolution

### 8.1 Connect to ADBS as ADMIN

### 8.2 Configure Outbound Connection Routing

```sql
-- Enable private endpoint resolution
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
```

### 8.3 Restart the Database

The database must be restarted for this change to take effect.

**From OCI Console:**
1. Navigate to your ADBS resource
2. Click "More Actions"
3. Select "Stop"
4. Wait for the database to stop completely
5. Click "Start"
6. Wait for the database to become available

**Estimated restart time:** 2-5 minutes

## Step 9: Configure Customer-Managed Encryption

### 9.1 Gather Required Information

You'll need:
- Key Vault URI: `https://<KV_NAME>.vault.azure.net/`
- Key Name: `adbs-encryption-key`
- Key Version: (get from Azure Portal or CLI)

```bash
# Get key version
KEY_VERSION=$(az keyvault key show --vault-name $KV_NAME --name $KEY_NAME --query key.kid --output tsv | rev | cut -d'/' -f1 | rev)
echo "Key Version: $KEY_VERSION"
```

### 9.2 Set Encryption Key via OCI Console

1. Navigate to your ADBS resource in OCI Console
2. Click "Manage encryption key"
3. Select "Encrypt using a customer-managed key"
4. Enter the following:
   - **Key Source:** Azure Key Vault
   - **Vault URI:** `https://<KV_NAME>.vault.azure.net/`
   - **Key name:** `adbs-encryption-key`
   - **Key version:** (from step 9.1)
5. Click "Save"

### 9.3 Monitor the Update

The database will enter "Updating" state while the encryption key is being applied. This process typically takes 5-10 minutes.

## Step 10: Validation

### 10.1 Verify Private Endpoint Resolution (Optional)

Connect to ADBS as ADMIN and run:

```sql
-- Grant network ACL for testing
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host => '<KV_NAME>.vault.azure.net',
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

-- Test DNS resolution and connectivity
SET SERVEROUTPUT ON;
DECLARE
    req UTL_HTTP.REQ;
    resp UTL_HTTP.RESP;
    name VARCHAR2(256);
    value VARCHAR2(1024);
BEGIN
    req := UTL_HTTP.BEGIN_REQUEST('https://<KV_NAME>.vault.azure.net/healthstatus');
    UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Mozilla/4.0');
    resp := UTL_HTTP.GET_RESPONSE(req);
    
    FOR i IN 1..UTL_HTTP.GET_HEADER_COUNT(resp) LOOP
        UTL_HTTP.GET_HEADER(resp, i, name, value);
        DBMS_OUTPUT.PUT_LINE(name || ': ' || value);
    END LOOP;
    
    UTL_HTTP.END_RESPONSE(resp);
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Private endpoint resolution confirmed');
EXCEPTION
    WHEN UTL_HTTP.END_OF_BODY THEN
        UTL_HTTP.END_RESPONSE(resp);
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Private endpoint resolution confirmed');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        RAISE;
END;
/
```

**Expected output:** The connection should succeed and show the private IP address in the response headers.

### 10.2 Verify Encryption Key

```sql
-- Check encryption key configuration
SELECT * FROM V$ENCRYPTION_WALLET;

-- Verify customer-managed key is active
SELECT * FROM DBA_ENCRYPTED_COLUMNS;
```

### 10.3 Check Database Status

In OCI Console:
1. Navigate to your ADBS resource
2. Verify "Lifecycle State" shows "Available"
3. Verify "Encryption key" section shows "Customer-managed key"
4. Check that the Key Vault URI and key name are correct

## Cleanup (Optional)

To remove all resources created in this guide:

```bash
# Delete Resource Group (this removes all resources)
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Clean up OCI resources through OCI Console:
# - Terminate ADBS instance
# - Remove Private DNS zones (if no longer needed)
```

## Next Steps

- Set up key rotation policy
- Configure backup and restore procedures
- Implement monitoring and alerting
- Review security best practices
- Test disaster recovery procedures

## References

- [Oracle ADBS Encryption with Azure Key Vault](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)
- [Azure Key Vault Private Link](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)
- [Oracle Database@Azure Networking](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)
