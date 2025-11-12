# Oracle Database@Azure Autonomous Database with Azure Key Vault and Private Endpoints

This guide provides step-by-step instructions for configuring Oracle Database@Azure (OD@A) Autonomous Database Serverless with customer-managed encryption keys stored in Azure Key Vault, accessed through private endpoints for enhanced security.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Architecture Overview](#architecture-overview)
3. [Step 1: Provision OD@A Autonomous Database](#step-1-provision-oda-autonomous-database)
4. [Step 2: Provision Azure Key Vault with Private Endpoint](#step-2-provision-azure-key-vault-with-private-endpoint)
5. [Step 3: Create Encryption Key](#step-3-create-encryption-key)
6. [Step 4: Disable Public Access to Key Vault](#step-4-disable-public-access-to-key-vault)
7. [Step 5: Gather Private DNS Zone Information](#step-5-gather-private-dns-zone-information)
8. [Step 6: Configure Private DNS Zones in OCI](#step-6-configure-private-dns-zones-in-oci)
9. [Step 7: Create Autonomous Database Principal](#step-7-create-autonomous-database-principal)
10. [Step 8: Grant Key Vault Access to Database Principal](#step-8-grant-key-vault-access-to-database-principal)
11. [Step 9: Configure Private Endpoint Resolution](#step-9-configure-private-endpoint-resolution)
12. [Step 10: Apply Customer-Managed Encryption Key](#step-10-apply-customer-managed-encryption-key)
13. [Validation and Testing](#validation-and-testing)
14. [Troubleshooting](#troubleshooting)

## Prerequisites

### Azure Requirements
- Azure subscription with Owner or Contributor permissions
- Azure CLI 2.25.0 or later
- Azure region with Advanced Networking support ([supported regions](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan#advanced-network-features))
- Existing Virtual Network with a delegated subnet

### OCI/Oracle Requirements
- Access to OCI Console
- Oracle Database@Azure subscription
- SQL client (SQL*Plus, SQL Developer, or similar)

### Supported Key Configurations
- **Key Type:** RSA or RSA-HSM
- **Key Size:** 2048, 3072, or 4096 bits
- Reference: [Oracle Key Requirements](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)

## Architecture Overview

```
┌───────────────────────────────────────────────────────────────┐
│                     Azure Virtual Network                     │
│                                                                │
│  ┌──────────────────────────┐       ┌────────────────────┐   │
│  │ OD@A Autonomous Database │◄──────┤ Private Endpoint   │   │
│  │ (Delegated Subnet)       │       │ (10.0.0.4)         │   │
│  │ - Private DNS Resolution │       └──────────┬─────────┘   │
│  │ - route_outbound =       │                  │             │
│  │   enforce_private_       │                  │             │
│  │   endpoint               │                  │             │
│  └──────────────────────────┘                  │             │
│                                                 │             │
│                              ┌─────────────────▼──────────┐  │
│                              │ Private DNS Zones         │  │
│                              │ 1. privatelink.vaultcore. │  │
│                              │    azure.net              │  │
│                              │ 2. vault.azure.net        │  │
│                              │    A Record: <vault-name> │  │
│                              │    → 10.0.0.4             │  │
│                              └───────────────────────────┘  │
└───────────────────────────────────────────────────────────────┘
                                   │
                                   │ Private Link
                                   │
                        ┌──────────▼───────────┐
                        │ Azure Key Vault      │
                        │ - Public Access: OFF │
                        │ - CMK Storage        │
                        │ - Access Policy      │
                        └──────────────────────┘
```

## Step 1: Provision OD@A Autonomous Database

### Using Azure Portal

1. Navigate to the Azure Portal
2. Search for "Oracle Database"
3. Click **+ Create** → **Oracle Autonomous Database**
4. Configure the **Basics** tab:
   - **Subscription:** Select your subscription
   - **Resource Group:** Create new or select existing
   - **Database Name:** Enter a unique name
   - **Display Name:** Enter a display name
   - **Workload Type:** Select appropriate workload (Data Warehouse or Transaction Processing)
   - **Admin Credentials:** Set ADMIN password

5. Configure the **Networking** tab:
   - **Access Type:** Select "Managed private virtual network IP only"
   - **Virtual Network:** Select your VNet
   - **Subnet:** Select the delegated subnet
   - **Require mutual TLS (mTLS) authentication:** Check if required

6. Review and create the database

**Note:** The database will take approximately 5-10 minutes to provision.

### Using Azure CLI

```bash
# Set variables
SUBSCRIPTION_ID="<your-subscription-id>"
RESOURCE_GROUP="<your-resource-group>"
LOCATION="<azure-region>"
ADB_NAME="<your-adb-name>"
VNET_NAME="<your-vnet-name>"
SUBNET_NAME="<your-subnet-name>"
ADMIN_PASSWORD="<strong-password>"

# Create Autonomous Database
az oracle autonomous-database create \
  --resource-group $RESOURCE_GROUP \
  --name $ADB_NAME \
  --location $LOCATION \
  --subnet-id "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/$VNET_NAME/subnets/$SUBNET_NAME" \
  --admin-password $ADMIN_PASSWORD \
  --compute-model ECPU \
  --data-storage-size-in-tbs 1 \
  --db-workload OLTP
```

## Step 2: Provision Azure Key Vault with Private Endpoint

### Using Azure Portal

1. Navigate to Azure Portal → **Key Vaults** → **+ Create**

2. **Basics Tab:**
   - **Subscription:** Select your subscription
   - **Resource Group:** Same as Autonomous Database
   - **Key Vault Name:** Enter unique name (e.g., "odaa-encryption-kv")
   - **Region:** Same as Autonomous Database
   - **Pricing Tier:** Standard or Premium

3. **Access Configuration Tab:**
   - **Permission Model:** Select "Vault access policy"

4. **Networking Tab:**
   - **Enable public access:** Check (temporarily, we'll disable later)
   - **Public Access:** Select "All networks"
   - Click **+ Create a private endpoint**

5. **Create Private Endpoint:**
   - **Name:** Enter name (e.g., "odaa-kv-pe")
   - **Region:** Same as Key Vault
   - **Virtual Network:** Select the same VNet as Autonomous Database
   - **Subnet:** Select a subnet (can be different from ADB subnet)
   - **Integrate with private DNS zone:** Yes (will create privatelink.vaultcore.azure.net)
   - Click **OK**

6. Click **Review + Create** → **Create**

### Using Azure CLI

```bash
# Set variables
KV_NAME="<your-key-vault-name>"
PE_NAME="${KV_NAME}-pe"
PE_CONNECTION_NAME="${KV_NAME}-pe-connection"

# Create Key Vault
az keyvault create \
  --resource-group $RESOURCE_GROUP \
  --name $KV_NAME \
  --location $LOCATION \
  --enable-rbac-authorization false \
  --public-network-access Enabled

# Create Private Endpoint
az network private-endpoint create \
  --resource-group $RESOURCE_GROUP \
  --name $PE_NAME \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME \
  --private-connection-resource-id "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$KV_NAME" \
  --group-id vault \
  --connection-name $PE_CONNECTION_NAME \
  --location $LOCATION

# Get Private Endpoint Private IP
PE_PRIVATE_IP=$(az network private-endpoint show \
  --resource-group $RESOURCE_GROUP \
  --name $PE_NAME \
  --query 'customDnsConfigs[0].ipAddresses[0]' \
  --output tsv)

echo "Private Endpoint IP: $PE_PRIVATE_IP"
```

## Step 3: Create Encryption Key

### Using Azure Portal

1. Navigate to your Key Vault
2. Select **Keys** from the left menu
3. Click **+ Generate/Import**
4. Configure the key:
   - **Options:** Generate
   - **Name:** Enter key name (e.g., "odaa-cmek")
   - **Key Type:** RSA or RSA-HSM
   - **RSA Key Size:** 2048, 3072, or 4096
   - **Enabled:** Yes
   - Leave other options as default
5. Click **Create**

### Using Azure CLI

```bash
# Set variables
KEY_NAME="odaa-cmek"
KEY_SIZE=2048

# Create key
az keyvault key create \
  --vault-name $KV_NAME \
  --name $KEY_NAME \
  --kty RSA \
  --size $KEY_SIZE \
  --ops encrypt decrypt wrapKey unwrapKey

# Get key identifier
KEY_ID=$(az keyvault key show \
  --vault-name $KV_NAME \
  --name $KEY_NAME \
  --query 'key.kid' \
  --output tsv)

echo "Key ID: $KEY_ID"
```

## Step 4: Disable Public Access to Key Vault

### Using Azure Portal

1. Navigate to your Key Vault
2. Select **Networking** from the left menu
3. Under **Firewalls and virtual networks:**
   - Select **Disable public access**
4. Click **Apply**
5. Click **Save**

**Important:** After disabling public access, the Key Vault is only accessible through the Private Endpoint.

### Using Azure CLI

```bash
# Disable public network access
az keyvault update \
  --resource-group $RESOURCE_GROUP \
  --name $KV_NAME \
  --public-network-access Disabled
```

## Step 5: Gather Private DNS Zone Information

You need to collect three pieces of information:

1. **Key Vault FQDN:** `<key-vault-name>.vault.azure.net`
2. **Private Endpoint IP Address:** (e.g., 10.0.0.4)
3. **Private DNS Zone Name:** `privatelink.vaultcore.azure.net`

### Using Azure Portal

1. Navigate to your Key Vault
2. Select **Networking** → **Private endpoint connections**
3. Click on the private endpoint name
4. Select **DNS configuration** from the left menu
5. Note the following:
   - **FQDN:** (e.g., mykeyvault.vault.azure.net)
   - **IP Address:** (e.g., 10.0.0.4)

6. Navigate to **Private DNS Zones** in Azure Portal
7. Find the zone named `privatelink.vaultcore.azure.net`
8. Click on it and select **Recordsets**
9. Note the **A Record name** (should match your Key Vault name)

### Using Azure CLI

```bash
# Get Private Endpoint details
az network private-endpoint show \
  --resource-group $RESOURCE_GROUP \
  --name $PE_NAME \
  --query '{IP:customDnsConfigs[0].ipAddresses[0], FQDN:customDnsConfigs[0].fqdn}' \
  --output table

# Get Private DNS Zone name
az network private-dns zone list \
  --resource-group $RESOURCE_GROUP \
  --query "[?contains(name, 'privatelink.vaultcore')].name" \
  --output tsv
```

**Save these values - you'll need them for OCI configuration:**
- Key Vault Name: `<your-key-vault-name>`
- Private IP: `<private-endpoint-ip>`
- DNS Zone: `privatelink.vaultcore.azure.net`

## Step 6: Configure Private DNS Zones in OCI

### Access OCI Console

1. In Azure Portal, navigate to your Autonomous Database
2. Click **Go to OCI** button
3. This will open the OCI Console

### Identify VCN Name

1. In the OCI Console, on the Autonomous Database details page
2. Note the **VCN Name** (e.g., VCN-multicloudnetworklink20250605145841)

### Navigate to Private Views

1. In OCI Console, navigate to **Networking** → **DNS Management** → **Private Views**
2. Search for the Private View with the same name as your VCN
3. Click on the Private View name

### Create Private DNS Zones

You need to create **TWO** private zones:

#### Zone 1: privatelink.vaultcore.azure.net

1. Click on **Private zones** tab
2. Click **Create zone**
3. Configure:
   - **Zone name:** `privatelink.vaultcore.azure.net`
   - **Create in compartment:** Select your compartment
4. Click **Create**

5. After creation, click on the zone name
6. Click on **Records** tab → **Manage records**
7. Click **Add record**:
   - **Record type:** A
   - **Name:** `<your-key-vault-name>` (without domain)
   - **Address:** `<private-endpoint-ip>` (e.g., 10.0.0.4)
   - **TTL:** 3600
8. Click **Add answer**
9. Click **Review changes** → **Publish changes**

#### Zone 2: vault.azure.net

1. Return to Private zones tab
2. Click **Create zone**
3. Configure:
   - **Zone name:** `vault.azure.net`
   - **Create in compartment:** Select your compartment
4. Click **Create**

5. After creation, click on the zone name
6. Click on **Records** tab → **Manage records**
7. Click **Add record**:
   - **Record type:** A
   - **Name:** `<your-key-vault-name>` (without domain)
   - **Address:** `<private-endpoint-ip>` (e.g., 10.0.0.4)
   - **TTL:** 3600
8. Click **Add answer**
9. Click **Review changes** → **Publish changes**

### Verification

Both zones should now contain an A record pointing your Key Vault name to the private IP address.

## Step 7: Create Autonomous Database Principal

The Autonomous Database needs a service principal in Azure to authenticate with Key Vault.

### Connect to Autonomous Database

Use SQL*Plus, SQL Developer, or any SQL client to connect as ADMIN user.

### Execute Principal Creation

```sql
-- Enable principal authentication with Azure
-- Replace <azure-tenant-id> with your Azure AD Tenant ID
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
        provider => 'AZURE',
        params   => JSON_OBJECT('azure_tenantid' value '<azure-tenant-id>'));
END;
/
```

**To find your Azure Tenant ID:**

```bash
# Using Azure CLI
az account show --query 'tenantId' --output tsv
```

Or in Azure Portal:
1. Navigate to **Azure Active Directory** / **Microsoft Entra ID**
2. Overview page shows **Tenant ID**

### Verify Principal Creation

```sql
-- Query to verify the principal was created
SELECT * FROM DBA_APPLICATION_ROLES WHERE NAMESPACE='AZURE';
```

### Get Principal Name

```sql
-- Get the application ID for the Azure service principal
SELECT APPLICATION_ID 
FROM DBA_APPLICATION_ROLES 
WHERE NAMESPACE='AZURE' 
  AND ROLE_NAME LIKE 'ADBS_APP_%';
```

Save the **APPLICATION_ID** - this is the Service Principal you'll grant access to in Azure.

## Step 8: Grant Key Vault Access to Database Principal

### Using Azure Portal

1. Navigate to your Key Vault
2. Select **Access configuration** from the left menu
3. Click **Go to access policies**
4. Click **+ Create**

5. **Permissions tab:**
   - **Key permissions:**
     - Get
     - List
     - Unwrap Key
     - Wrap Key
     - Decrypt
     - Encrypt
   - **Secret permissions:** (None required)
   - **Certificate permissions:** (None required)
   - Click **Next**

6. **Principal tab:**
   - Search for the Application ID from Step 7
   - Select the principal
   - Click **Next**

7. **Application (optional) tab:**
   - Leave blank
   - Click **Next**

8. **Review + create:**
   - Review permissions
   - Click **Create**

### Using Azure CLI

```bash
# Set the principal/application ID from Step 7
PRINCIPAL_ID="<application-id-from-step-7>"

# Grant Key Vault permissions
az keyvault set-policy \
  --name $KV_NAME \
  --resource-group $RESOURCE_GROUP \
  --object-id $PRINCIPAL_ID \
  --key-permissions get list unwrapKey wrapKey decrypt encrypt
```

## Step 9: Configure Private Endpoint Resolution

By default, Autonomous Database resolves services using public endpoints. You must explicitly configure it to use private endpoints.

### Connect to Database as ADMIN

```sql
-- Force Autonomous Database to use private endpoint resolution only
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
```

### Restart the Database

The change requires a database restart to take effect.

#### Using OCI Console

1. Navigate to your Autonomous Database in OCI Console
2. Click **More Actions** → **Stop**
3. Wait for the database to stop
4. Click **Start**
5. Wait for the database to be available

#### Using OCI CLI

```bash
# Set variables
ADB_OCID="<your-adb-ocid>"

# Stop database
oci db autonomous-database stop \
  --autonomous-database-id $ADB_OCID

# Wait for stop to complete (check status)
oci db autonomous-database get \
  --autonomous-database-id $ADB_OCID \
  --query 'data."lifecycle-state"'

# Start database
oci db autonomous-database start \
  --autonomous-database-id $ADB_OCID
```

## Step 10: Apply Customer-Managed Encryption Key

### Using OCI Console

1. Navigate to your Autonomous Database in OCI Console
2. Click **Manage encryption key**
3. Select **Encrypt using a customer-managed key**
4. Fill in the required information:
   - **Vault Type:** Azure
   - **Azure Tenant ID:** Your Azure tenant ID
   - **Key Vault URI:** `https://<key-vault-name>.vault.azure.net`
   - **Key Name:** The key name created in Step 3
   - **Key Version:** (Optional) Leave blank for latest version
5. Click **Save**

The database will enter **UPDATING** state while the encryption key is being changed.

### Using OCI CLI

```bash
# Set variables
KEY_VAULT_URI="https://${KV_NAME}.vault.azure.net"
TENANT_ID="<your-azure-tenant-id>"

# Update database with customer-managed key
oci db autonomous-database update \
  --autonomous-database-id $ADB_OCID \
  --customer-contacts '[{"email":"admin@example.com"}]' \
  --kms-key-id "${KEY_VAULT_URI}/keys/${KEY_NAME}" \
  --wait-for-state AVAILABLE
```

## Validation and Testing

### Optional: Test Private Endpoint Connectivity

You can verify that the database is resolving Key Vault through the private endpoint.

#### Grant Network ACL Access

```sql
-- Connect as ADMIN and allow outbound HTTPS to Key Vault
BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => '<key-vault-name>.vault.azure.net',
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

#### Send Health Check Request

```sql
SET SERVEROUTPUT ON;

BEGIN
  DECLARE
    req UTL_HTTP.REQ;
    resp UTL_HTTP.RESP;
    name VARCHAR2(256);
    value VARCHAR2(1024);
  BEGIN
    req := UTL_HTTP.BEGIN_REQUEST('https://<key-vault-name>.vault.azure.net/healthstatus');
    UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Mozilla/4.0');
    resp := UTL_HTTP.GET_RESPONSE(req);
    
    FOR i IN 1..UTL_HTTP.GET_HEADER_COUNT(resp) LOOP
      UTL_HTTP.GET_HEADER(resp, i, name, value);
      DBMS_OUTPUT.PUT_LINE(name || ': ' || value);
    END LOOP;
    
    LOOP
      UTL_HTTP.READ_LINE(resp, value, TRUE);
      DBMS_OUTPUT.PUT_LINE(value);
    END LOOP;
    
    UTL_HTTP.END_RESPONSE(resp);
  EXCEPTION
    WHEN UTL_HTTP.END_OF_BODY THEN
      UTL_HTTP.END_RESPONSE(resp);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
      RAISE;
  END;
END;
/
```

**Expected Result:** The response should show the request is being resolved from the private IP address (e.g., 10.0.0.4), confirming private endpoint connectivity.

### Verify Encryption Key Configuration

```sql
-- Query to check encryption configuration
SELECT * FROM V$ENCRYPTION_WALLET;

-- Check encryption key details
SELECT * FROM DBA_CLOUD_CONFIG WHERE CONFIG_NAME LIKE '%ENCRYPTION%';
```

## Troubleshooting

### Issue: Principal Creation Fails with ORA-27465

**Error:**
```
ORA-20000: Failed to create the azure application - ORA-27465: invalid value for attribute password
```

**Possible Causes:**
1. Azure Tenant ID is incorrect
2. Network connectivity issues between OD@A and Azure AD
3. Insufficient permissions in Azure AD

**Solutions:**

1. **Verify Tenant ID:**
   ```bash
   # Get your correct Tenant ID
   az account show --query 'tenantId' --output tsv
   ```

2. **Check Network Connectivity:**
   ```sql
   -- Test if database can reach Azure AD endpoints
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
   ```

3. **Alternative Principal Creation Method:**
   
   If automatic creation fails, manually create an Azure AD application:

   ```bash
   # Create Azure AD application
   APP_NAME="odaa-${ADB_NAME}-principal"
   
   az ad app create \
     --display-name $APP_NAME \
     --sign-in-audience AzureADMyOrg
   
   # Get Application ID
   APP_ID=$(az ad app list \
     --display-name $APP_NAME \
     --query '[0].appId' \
     --output tsv)
   
   # Create Service Principal
   az ad sp create --id $APP_ID
   
   # Get Object ID
   OBJECT_ID=$(az ad sp list \
     --filter "appId eq '$APP_ID'" \
     --query '[0].id' \
     --output tsv)
   
   echo "Application ID: $APP_ID"
   echo "Object ID: $OBJECT_ID"
   ```

   Then manually register this principal with the database:

   ```sql
   -- Use the manually created Application ID
   BEGIN
       DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
           provider => 'AZURE',
           params   => JSON_OBJECT(
               'azure_tenantid' value '<tenant-id>',
               'azure_applicationid' value '<app-id>'
           )
       );
   END;
   /
   ```

### Issue: Cannot Access Key Vault After Disabling Public Access

**Problem:** After disabling public access, you cannot manage keys through Azure Portal.

**Solution:** 
- Access Key Vault from a VM in the same VNet, or
- Temporarily enable public access from your IP:
  ```bash
  # Add your IP to allowed list
  MY_IP=$(curl -s ifconfig.me)
  
  az keyvault network-rule add \
    --resource-group $RESOURCE_GROUP \
    --name $KV_NAME \
    --ip-address $MY_IP
  ```

### Issue: DNS Resolution Not Working

**Problem:** Database cannot resolve Key Vault FQDN to private IP.

**Verification:**
1. Check Private DNS zones exist in OCI
2. Verify A records are correctly configured
3. Ensure VCN is linked to Private View

**Solution:**
- Review Step 6 and ensure both DNS zones are created
- Verify A record names match exactly (no extra domains)
- Check TTL values are reasonable (3600 seconds)

### Issue: Key Vault Access Denied

**Problem:** Database cannot access keys in Key Vault.

**Check Access Policy:**
```bash
# List access policies
az keyvault show \
  --resource-group $RESOURCE_GROUP \
  --name $KV_NAME \
  --query 'properties.accessPolicies[].[objectId,permissions]'
```

**Solution:**
- Verify the Service Principal has correct permissions (Step 8)
- Ensure permissions include: get, list, unwrapKey, wrapKey, decrypt, encrypt

### Issue: Private Endpoint Not Working

**Verify Private Endpoint Status:**
```bash
# Check private endpoint connection state
az network private-endpoint show \
  --resource-group $RESOURCE_GROUP \
  --name $PE_NAME \
  --query '{ProvisioningState:provisioningState, ConnectionState:privateLinkServiceConnections[0].privateLinkServiceConnectionState}' \
  --output table
```

**Expected:**
- ProvisioningState: Succeeded
- ConnectionState.status: Approved

## Additional Resources

- [Oracle Documentation: Azure Key Vault Integration](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)
- [Microsoft Documentation: Key Vault Private Link](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)
- [Oracle Database@Azure Network Planning](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)

## Next Steps

- [Configure Azure Managed HSM for enhanced security](./02-managed-hsm-private-endpoint.md)
- Implement key rotation procedures
- Set up monitoring and alerting for key access
- Configure backup and disaster recovery

---

**Last Updated:** November 2025  
**Tested with:** Oracle Autonomous Database 19c, Azure Key Vault (Standard/Premium)
