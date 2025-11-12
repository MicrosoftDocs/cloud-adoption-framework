# Scenario 2: Oracle Autonomous Database with Azure Managed HSM and Private Endpoints

This guide provides step-by-step instructions to configure Oracle Database@Azure Autonomous Database Serverless (ODAA ADBS) to use customer-managed encryption keys from Azure Managed HSM with private endpoint connectivity.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Step 1: Provision Oracle Autonomous Database](#step-1-provision-oracle-autonomous-database)
3. [Step 2: Create Azure Managed HSM with Private Endpoint](#step-2-create-azure-managed-hsm-with-private-endpoint)
4. [Step 3: Activate and Create Encryption Key](#step-3-activate-and-create-encryption-key)
5. [Step 4: Configure Network Security](#step-4-configure-network-security)
6. [Step 5: Configure Private DNS Zones in OCI](#step-5-configure-private-dns-zones-in-oci)
7. [Step 6: Create and Configure ADBS Principal](#step-6-create-and-configure-adbs-principal)
8. [Step 7: Grant Managed HSM Access](#step-7-grant-managed-hsm-access)
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
- Three security principals for HSM activation (emails or object IDs)

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
RESOURCE_GROUP="rg-odaa-hsm-demo"
LOCATION="eastus"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION
```

### 1.2 Create Virtual Network

```bash
# Set VNet variables
VNET_NAME="vnet-odaa-hsm-demo"
VNET_ADDRESS="10.0.0.0/16"
ADBS_SUBNET="subnet-adbs-delegated"
ADBS_SUBNET_ADDRESS="10.0.1.0/24"
HSM_SUBNET="subnet-hsm"
HSM_SUBNET_ADDRESS="10.0.2.0/24"

# Create VNet
az network vnet create --name $VNET_NAME --resource-group $RESOURCE_GROUP --address-prefix $VNET_ADDRESS --location $LOCATION

# Create delegated subnet for ADBS
az network vnet subnet create --name $ADBS_SUBNET --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes $ADBS_SUBNET_ADDRESS --delegations "Oracle.Database/networkAttachments"

# Create subnet for HSM private endpoint
az network vnet subnet create --name $HSM_SUBNET --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --address-prefixes $HSM_SUBNET_ADDRESS
```

### 1.3 Create Autonomous Database via Azure Portal

1. Navigate to Azure Portal
2. Search for "Oracle Database@Azure - Autonomous Database"
3. Click "+ Create"
4. **Basics tab:**
   - Select your subscription and resource group
   - Database name: `adb-hsm-demo`
   - Workload type: Select based on requirements (OLTP recommended for testing)
   - Configure admin credentials

5. **Networking tab:**
   - Access type: Select "Managed private virtual network IP only"
   - Virtual network: Select `vnet-odaa-hsm-demo`
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

## Step 2: Create Azure Managed HSM with Private Endpoint

### 2.1 Create Managed HSM

```bash
# Set Managed HSM variables
HSM_NAME="hsm-odaa-demo-$RANDOM"
echo "Managed HSM Name: $HSM_NAME"

# Get current user object ID (will be the initial administrator)
ADMIN_OBJECT_ID=$(az ad signed-in-user show --query id --output tsv)

# Create Managed HSM (takes 15-20 minutes)
az keyvault create --resource-group $RESOURCE_GROUP --name $HSM_NAME --location $LOCATION --sku premium --hsm-name $HSM_NAME --administrators $ADMIN_OBJECT_ID --retention-days 90
```

**Note:** Managed HSM creation is a long-running operation. It typically takes 15-20 minutes.

### 2.2 Wait for Provisioning

```bash
# Check provisioning status
az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query properties.provisioningState --output tsv
```

Wait until the status shows "Succeeded".

### 2.3 Create Private Endpoint for Managed HSM

```bash
# Set private endpoint variables
PE_NAME="pe-hsm"
PE_CONNECTION="pe-connection-hsm"

# Get Managed HSM resource ID
HSM_ID=$(az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query id --output tsv)

# Create private endpoint
az network private-endpoint create --name $PE_NAME --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet $HSM_SUBNET --private-connection-resource-id $HSM_ID --group-id managedhsm --connection-name $PE_CONNECTION --location $LOCATION

# Create Private DNS Zone for Managed HSM
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.managedhsm.azure.net"

# Link Private DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --name "dns-link-hsm" --virtual-network $VNET_NAME --registration-enabled false

# Get private endpoint NIC ID
PE_NIC_ID=$(az network private-endpoint show --name $PE_NAME --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' --output tsv)

# Get private IP address
PRIVATE_IP=$(az network nic show --ids $PE_NIC_ID --query 'ipConfigurations[0].privateIPAddress' --output tsv)
echo "Managed HSM Private IP: $PRIVATE_IP"

# Create DNS A record
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --record-set-name $HSM_NAME --ipv4-address $PRIVATE_IP
```

### 2.4 Gather Managed HSM Information

```bash
# Get Managed HSM URI
HSM_URI=$(az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query properties.hsmUri --output tsv)
echo "Managed HSM URI: $HSM_URI"

# Get Managed HSM FQDN
HSM_FQDN="${HSM_NAME}.managedhsm.azure.net"
echo "Managed HSM FQDN: $HSM_FQDN"
```

## Step 3: Activate and Create Encryption Key

### 3.1 Understand Security Domain

Managed HSM requires activation through a security domain before use. This involves:
- Generating a security domain (encrypted backup of HSM keys)
- Requires at least 3 RSA key pairs
- Implements M-of-N quorum for recovery (e.g., 2 of 3)

### 3.2 Download Security Domain

```bash
# Install the managed HSM CLI extension if not already installed
az extension add --name keyvault-preview

# Generate RSA keys for security domain (requires openssl)
# Generate 3 key pairs

openssl req -newkey rsa:2048 -nodes -keyout sd-key1.key -x509 -days 365 -out sd-cert1.cer -subj "/CN=SD1"
openssl req -newkey rsa:2048 -nodes -keyout sd-key2.key -x509 -days 365 -out sd-cert2.cer -subj "/CN=SD2"
openssl req -newkey rsa:2048 -nodes -keyout sd-key3.key -x509 -days 365 -out sd-cert3.cer -subj "/CN=SD3"

# Download security domain (requires 2 of 3 keys for recovery)
az keyvault security-domain download --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-cert1.cer ./sd-cert2.cer ./sd-cert3.cer --sd-quorum 2 --security-domain-file ${HSM_NAME}-SD.json
```

**Important:** Store the security domain file and private keys securely. They are required for disaster recovery.

### 3.3 Create RSA Key in Managed HSM

```bash
# Set key variables
KEY_NAME="adbs-encryption-key"

# Create RSA key
az keyvault key create --hsm-name $HSM_NAME --name $KEY_NAME --kty RSA-HSM --size 2048 --ops encrypt decrypt wrapKey unwrapKey

# Get key identifier
KEY_ID=$(az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME --query key.kid --output tsv)
echo "Key ID: $KEY_ID"
```

**Supported Key Types:**
- Key type: RSA-HSM (HSM-backed)
- Key size: 2048, 3072, or 4096 bits
- Operations: encrypt, decrypt, wrapKey, unwrapKey

## Step 4: Configure Network Security

### 4.1 Configure Managed HSM Firewall

```bash
# Deny all public access and allow private endpoints only
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Deny

# Optionally allow trusted Azure services
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Deny --bypass AzureServices
```

**Note:** After this step, Managed HSM is only accessible via the private endpoint (and trusted Azure services if bypass is enabled).

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

#### Zone 1: privatelink.managedhsm.azure.net

```
# In OCI Console:
1. Click "Private zones" tab
2. Click "Create zone"
3. Enter the following:
   - Zone name: privatelink.managedhsm.azure.net
   - Zone type: Primary
   - Create in compartment: (select your compartment)
4. Click "Create"
```

#### Zone 2: managedhsm.azure.net

```
# In OCI Console:
1. Click "Create zone" again
2. Enter the following:
   - Zone name: managedhsm.azure.net
   - Zone type: Primary
   - Create in compartment: (select your compartment)
3. Click "Create"
```

### 5.4 Add DNS Records

For **each** of the two zones created above, add an A record:

```
# For privatelink.managedhsm.azure.net:
1. Click on the zone name
2. Go to "Records" tab
3. Click "Manage records"
4. Click "Add record"
5. Enter:
   - Record type: A
   - Name: <YOUR_HSM_NAME> (e.g., hsm-odaa-demo-12345)
   - TTL: 300
   - RDATA: <PRIVATE_IP> (e.g., 10.0.2.4)
6. Click "Add record"
7. Click "Review changes"
8. Click "Publish changes"

# Repeat the same process for managedhsm.azure.net zone
```

## Step 6: Create and Configure ADBS Principal

### 6.1 Connect to ADBS

Connect to your Autonomous Database as ADMIN user using your preferred SQL client.

### 6.2 Enable Principal Authentication

```sql
-- Enable Azure principal authentication for ADMIN
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

Save the `principal_id` output - you'll need it for granting Managed HSM access.

## Step 7: Grant Managed HSM Access

### 7.1 Understand Managed HSM RBAC

Managed HSM uses Azure RBAC for access control. Common roles:
- **Managed HSM Crypto Officer**: Can manage keys
- **Managed HSM Crypto User**: Can use keys for cryptographic operations
- **Managed HSM Administrator**: Full control

### 7.2 Grant Crypto User Role

```bash
# Set variables from Step 6.3
PRINCIPAL_ID="<YOUR_PRINCIPAL_ID>"

# Get Managed HSM scope
HSM_SCOPE=$(az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query id --output tsv)

# Assign Managed HSM Crypto User role
az role assignment create --assignee $PRINCIPAL_ID --role "Managed HSM Crypto User" --scope $HSM_SCOPE
```

### 7.3 Grant Key-Specific Permissions (Optional)

For more granular control, assign permissions at the key level:

```bash
# Get key scope
KEY_SCOPE="${HSM_SCOPE}/keys/${KEY_NAME}"

# Assign role for specific key
az role assignment create --assignee $PRINCIPAL_ID --role "Managed HSM Crypto User" --scope $KEY_SCOPE
```

### 7.4 Verify Role Assignment

```bash
# List role assignments
az role assignment list --scope $HSM_SCOPE --assignee $PRINCIPAL_ID --output table
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
- Managed HSM URI: `https://<HSM_NAME>.managedhsm.azure.net/`
- Key Name: `adbs-encryption-key`
- Key Version: (get from Azure Portal or CLI)

```bash
# Get key version
KEY_VERSION=$(az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME --query key.kid --output tsv | rev | cut -d'/' -f1 | rev)
echo "Key Version: $KEY_VERSION"
```

### 9.2 Set Encryption Key via OCI Console

1. Navigate to your ADBS resource in OCI Console
2. Click "Manage encryption key"
3. Select "Encrypt using a customer-managed key"
4. Enter the following:
   - **Key Source:** Azure Key Vault (use this even for Managed HSM)
   - **Vault URI:** `https://<HSM_NAME>.managedhsm.azure.net/`
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
        host => '<HSM_NAME>.managedhsm.azure.net',
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
    req := UTL_HTTP.BEGIN_REQUEST('https://<HSM_NAME>.managedhsm.azure.net/');
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
4. Check that the Managed HSM URI and key name are correct

### 10.4 Test Key Operations

```bash
# Verify key can be accessed
az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME

# List key versions
az keyvault key list-versions --hsm-name $HSM_NAME --name $KEY_NAME --output table
```

## Key Rotation

### Manual Key Rotation

```bash
# Create new key version
az keyvault key rotate --hsm-name $HSM_NAME --name $KEY_NAME

# Get new key version
NEW_KEY_VERSION=$(az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME --query key.kid --output tsv | rev | cut -d'/' -f1 | rev)
echo "New Key Version: $NEW_KEY_VERSION"
```

Then update the ADBS configuration in OCI Console with the new key version.

### Automatic Key Rotation Policy

```bash
# Set rotation policy (rotate every 90 days)
az keyvault key rotation-policy update --hsm-name $HSM_NAME --name $KEY_NAME --value '{
  "lifetimeActions": [
    {
      "trigger": {
        "timeAfterCreate": "P90D"
      },
      "action": {
        "type": "Rotate"
      }
    }
  ],
  "attributes": {
    "expiryTime": "P2Y"
  }
}'
```

## Cleanup (Optional)

To remove all resources created in this guide:

```bash
# Important: Backup security domain before deletion if needed for recovery

# Delete Resource Group (this removes all resources)
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Clean up OCI resources through OCI Console:
# - Terminate ADBS instance
# - Remove Private DNS zones (if no longer needed)
```

## Security Best Practices

1. **Security Domain Management:**
   - Store security domain file in multiple secure locations
   - Distribute private keys among trusted individuals
   - Use M-of-N quorum (e.g., 3 of 5) for large organizations

2. **Key Management:**
   - Enable key rotation policy
   - Use separate keys for different environments
   - Implement key versioning strategy

3. **Network Security:**
   - Never enable public access after initial setup
   - Use NSGs to further restrict traffic
   - Monitor network traffic for anomalies

4. **Access Control:**
   - Use least-privilege principle for role assignments
   - Regularly audit role assignments
   - Enable Azure AD Conditional Access

5. **Monitoring:**
   - Enable diagnostic logging for Managed HSM
   - Set up alerts for key operations
   - Monitor ADBS encryption status

## Differences from Key Vault

| Feature | Key Vault | Managed HSM |
|---------|-----------|-------------|
| FIPS Certification | FIPS 140-2 Level 2 | FIPS 140-3 Level 3 |
| Dedicated HSM | No (multi-tenant) | Yes (single-tenant) |
| Security Domain | N/A | Required |
| Price | Lower | Higher |
| Access Control | Access Policies or RBAC | RBAC only |
| Activation | Immediate | Requires security domain |
| Backup | Automatic | Manual (security domain) |

## Next Steps

- Configure security domain rotation schedule
- Set up backup and restore procedures
- Implement monitoring and alerting
- Review compliance requirements
- Test disaster recovery procedures
- Plan for key rotation automation

## References

- [Oracle ADBS Encryption with Azure Key Vault](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)
- [Azure Managed HSM Overview](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/overview)
- [Managed HSM Private Link](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/private-link)
- [Managed HSM Best Practices](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/best-practices)
- [Oracle Database@Azure Networking](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)
