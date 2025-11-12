# Scenario 2: ODAA Autonomous Database + Azure Managed HSM + Private Endpoints

This guide provides step-by-step instructions for integrating Oracle Autonomous Database Serverless (ADBS) with Azure Managed HSM using Private Endpoints for FIPS 140-3 Level 3 validated cryptographic key protection.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Architecture Overview](#architecture-overview)
3. [Step 1: Create Virtual Network and Subnets](#step-1-create-virtual-network-and-subnets)
4. [Step 2: Provision Oracle Autonomous Database](#step-2-provision-oracle-autonomous-database)
5. [Step 3: Create Azure Managed HSM with Private Endpoint](#step-3-create-azure-managed-hsm-with-private-endpoint)
6. [Step 4: Configure Private DNS Zones](#step-4-configure-private-dns-zones)
7. [Step 5: Create Service Principal](#step-5-create-service-principal)
8. [Step 6: Configure Managed HSM Role Assignments](#step-6-configure-managed-hsm-role-assignments)
9. [Step 7: Configure ADBS for Private Endpoint Resolution](#step-7-configure-adbs-for-private-endpoint-resolution)
10. [Step 8: Configure ADBS Encryption Key](#step-8-configure-adbs-encryption-key)
11. [Testing and Validation](#testing-and-validation)

## Prerequisites

- Azure subscription with Contributor or Owner access
- Azure CLI version 2.25.0 or later installed
- Oracle Cloud Infrastructure (OCI) console access
- SQL client (SQL*Plus or SQL Developer)
- Azure region that supports ODAA advanced networking
- **Important:** At least 3 authorized users required for Managed HSM security domain activation

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
│  │  │ (10.0.1.10)  │  │        │  │ (10.0.2.5) │  │   │
│  │  └──────────────┘  │        │  └────────────┘  │   │
│  └────────────────────┘        └───────────────────┘   │
│                                          │              │
└──────────────────────────────────────────┼──────────────┘
                                           │
                       Private Link Connection
                                           │
                                  ┌────────▼────────┐
                                  │  Azure Managed  │
                                  │      HSM        │
                                  │  (Private IP)   │
                                  │  FIPS 140-3 L3  │
                                  └─────────────────┘
```

## Key Differences from Key Vault

| Feature | Key Vault | Managed HSM |
|---------|-----------|-------------|
| **Security Level** | Software/HSM-backed | FIPS 140-3 Level 3 certified HSMs |
| **Key Custody** | Shared HSMs | Single-tenant HSMs |
| **Activation** | Immediate | Requires security domain with quorum |
| **Cost** | Lower (~$1/month) | Higher (~$4/hour) |
| **Use Case** | Standard encryption | Regulatory compliance, high security |
| **Access Control** | Access Policies or RBAC | RBAC only (local) |

## Step 1: Create Virtual Network and Subnets

### 1.1 Set Environment Variables

```bash
# Set your configuration
RESOURCE_GROUP="rg-odaa-managedhsm-demo"
LOCATION="eastus"
VNET_NAME="vnet-odaa-hsm"
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
   - **Resource Group:** Select `rg-odaa-managedhsm-demo`
   - **Database Name:** `adbhsmdemo`
   - **Workload Type:** Transaction Processing
   - **Admin Password:** Set a strong password (save it securely)

### 2.2 Configure Networking

1. In the **Networking** tab:
   - **Access Type:** Select "Managed private virtual network IP only"
   - **Virtual Network:** Select `vnet-odaa-hsm`
   - **Subnet:** Select `subnet-oracle-delegated`
   - **Require mutual TLS (mTLS) authentication:** Check if needed

2. Click **Review + Create** → **Create**

### 2.3 Note the Database Information

After provisioning completes, note:
- Database OCID
- Connection strings
- VCN Name (will be used for DNS configuration)

## Step 3: Create Azure Managed HSM with Private Endpoint

### 3.1 Set Managed HSM Variables

```bash
HSM_NAME="hsm-odaa-demo-$RANDOM"
KEY_NAME="odaa-hsm-encryption-key"
```

### 3.2 Create Managed HSM

```bash
# Get your user object ID for initial administrator
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)

# Create Managed HSM
az keyvault create --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --administrators $USER_OBJECT_ID --retention-days 7

echo "Managed HSM created. This will take 15-20 minutes to provision."
echo "HSM Name: $HSM_NAME"
```

**Note:** Managed HSM provisioning takes significantly longer than Key Vault (15-20 minutes).

### 3.3 Wait for HSM Provisioning

```bash
# Monitor provisioning status
az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query properties.provisioningState -o tsv

# Wait until status is "Succeeded"
```

### 3.4 Create Private Endpoint for Managed HSM

```bash
# Get Managed HSM resource ID
HSM_ID=$(az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query id -o tsv)

# Create Private Endpoint
az network private-endpoint create --name pe-managedhsm --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --subnet $PE_SUBNET --private-connection-resource-id $HSM_ID --group-id managedhsm --connection-name connection-managedhsm --location $LOCATION
```

### 3.5 Create Private DNS Zone for Managed HSM

```bash
# Create Private DNS Zone
az network private-dns zone create --resource-group $RESOURCE_GROUP --name "privatelink.managedhsm.azure.net"

# Link DNS Zone to VNet
az network private-dns link vnet create --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --name dns-link-managedhsm --virtual-network $VNET_NAME --registration-enabled false
```

### 3.6 Create DNS Records for Private Endpoint

```bash
# Get Private Endpoint NIC ID
NIC_ID=$(az network private-endpoint show --name pe-managedhsm --resource-group $RESOURCE_GROUP --query 'networkInterfaces[0].id' -o tsv)

# Get Private IP Address
PRIVATE_IP=$(az network nic show --ids $NIC_ID --query 'ipConfigurations[0].privateIPAddress' -o tsv)

# Create A record in Private DNS Zone
az network private-dns record-set a add-record --resource-group $RESOURCE_GROUP --zone-name "privatelink.managedhsm.azure.net" --record-set-name $HSM_NAME --ipv4-address $PRIVATE_IP

echo "Managed HSM Private IP: $PRIVATE_IP"
```

### 3.7 Activate Managed HSM Security Domain

**CRITICAL:** Managed HSM requires activation with a security domain before use.

#### 3.7.1 Download Security Domain Activation Tool

```bash
# Download from Microsoft
# https://github.com/Azure-Samples/managed-hsm-security-domain
git clone https://github.com/Azure-Samples/managed-hsm-security-domain.git
cd managed-hsm-security-domain
```

#### 3.7.2 Generate Security Domain Quorum Keys

You need at least 3 key pairs. Generate them on secure, isolated machines:

```bash
# Generate 3 key pairs (run on 3 different secure machines if possible)
openssl req -newkey rsa:2048 -nodes -keyout sd-key1.key -x509 -days 365 -out sd-cert1.cer
openssl req -newkey rsa:2048 -nodes -keyout sd-key2.key -x509 -days 365 -out sd-cert2.cer
openssl req -newkey rsa:2048 -nodes -keyout sd-key3.key -x509 -days 365 -out sd-cert3.cer

# IMPORTANT: Store these keys in secure locations
# Keys should be distributed to different trusted administrators
```

#### 3.7.3 Download Security Domain

```bash
# Set minimum quorum (at least 2 of 3 keys needed for recovery)
QUORUM=2

# Download security domain
az keyvault security-domain download --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-cert1.cer ./sd-cert2.cer ./sd-cert3.cer --sd-quorum $QUORUM --security-domain-file ${HSM_NAME}-sd.json
```

**CRITICAL:** Store the security domain file and keys securely. You need these for disaster recovery.

### 3.8 Verify HSM is Activated

```bash
az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query properties.statusMessage -o tsv
```

Expected output: "Managed HSM is activated"

### 3.9 Configure HSM Firewall

```bash
# Initially allow all networks for configuration
az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Allow

# Later, restrict to private endpoints only
# az keyvault update-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --default-action Deny --bypass AzureServices
```

### 3.10 Create Encryption Key in Managed HSM

```bash
# Get HSM URI
HSM_URI=$(az keyvault show --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --query properties.hsmUri -o tsv)

# Create RSA 4096 key
az keyvault key create --hsm-name $HSM_NAME --name $KEY_NAME --kty RSA-HSM --size 4096 --ops encrypt decrypt wrapKey unwrapKey

echo "HSM URI: $HSM_URI"
echo "Key Name: $KEY_NAME"
```

### 3.11 Get Key Details

```bash
# Get Key Version
KEY_VERSION=$(az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME --query key.kid -o tsv | awk -F'/' '{print $NF}')

echo "Key Version: $KEY_VERSION"
```

## Step 4: Configure Private DNS Zones

### 4.1 Gather DNS Information from Azure

```bash
# Get the FQDN of Managed HSM
HSM_FQDN="${HSM_NAME}.managedhsm.azure.net"

echo "Managed HSM FQDN: $HSM_FQDN"
echo "Managed HSM Name: $HSM_NAME"
echo "Private IP: $PRIVATE_IP"
echo "DNS Zone: privatelink.managedhsm.azure.net"
```

### 4.2 Configure DNS in OCI

1. In Azure Portal, navigate to your ADBS instance
2. Click **Go to OCI** button
3. In OCI Console, note the **VCN Name** from the database information page
4. Navigate to **Networking → DNS Management → Private Views**
5. Search for the Private View with the same name as your VCN
6. Click on the Private View

### 4.3 Create First Private DNS Zone (privatelink.managedhsm.azure.net)

1. Click on **Private zones** tab
2. Click **Create zone**
3. Enter zone details:
   - **Zone Name:** `privatelink.managedhsm.azure.net`
   - **Compartment:** Same as your ADBS
4. Click **Create**

### 4.4 Add A Record to First Zone

1. Navigate to the created zone: `privatelink.managedhsm.azure.net`
2. Click **Records** tab
3. Click **Manage records**
4. Click **Add record**
5. Enter record details:
   - **Record Type:** A
   - **Name:** Your HSM name (e.g., `hsm-odaa-demo-12345`)
   - **Address:** Private IP address (e.g., `10.0.2.5`)
   - **TTL:** 3600
6. Click **Add answer**
7. Click **Review changes**
8. Click **Publish changes**

### 4.5 Create Second Private DNS Zone (managedhsm.azure.net)

1. Return to Private zones tab
2. Click **Create zone**
3. Enter zone details:
   - **Zone Name:** `managedhsm.azure.net`
   - **Compartment:** Same as your ADBS
4. Click **Create**

### 4.6 Add A Record to Second Zone

1. Navigate to the created zone: `managedhsm.azure.net`
2. Click **Records** tab
3. Click **Manage records**
4. Click **Add record**
5. Enter record details:
   - **Record Type:** A
   - **Name:** Your HSM name (e.g., `hsm-odaa-demo-12345`)
   - **Address:** Private IP address (e.g., `10.0.2.5`)
   - **TTL:** 3600
6. Click **Add answer**
7. Click **Review changes**
8. Click **Publish changes**

## Step 5: Create Service Principal

### 5.1 Create Service Principal

```bash
# Create service principal
SP_OUTPUT=$(az ad sp create-for-rbac --name "sp-odaa-managedhsm" --skip-assignment)

# Extract values
APP_ID=$(echo $SP_OUTPUT | jq -r '.appId')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenant')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.password')

echo "Application ID: $APP_ID"
echo "Tenant ID: $TENANT_ID"
echo "Client Secret: $CLIENT_SECRET"

# Save these values securely!
```

### 5.2 Store Service Principal Credentials

```bash
# Store in environment variables for later use
export AZURE_CLIENT_ID=$APP_ID
export AZURE_TENANT_ID=$TENANT_ID
export AZURE_CLIENT_SECRET=$CLIENT_SECRET
```

## Step 6: Configure Managed HSM Role Assignments

**Important:** Managed HSM uses local RBAC, not Azure AD RBAC.

### 6.1 Assign Crypto User Role

```bash
# Assign Managed HSM Crypto User role to service principal
az keyvault role assignment create --hsm-name $HSM_NAME --role "Managed HSM Crypto User" --assignee $APP_ID --scope /keys
```

### 6.2 Verify Role Assignment

```bash
# List role assignments
az keyvault role assignment list --hsm-name $HSM_NAME
```

### 6.3 Test Service Principal Access

```bash
# Login with service principal
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID

# Test key access
az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME

# Logout and login back with your user account
az logout
az login
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
sqlplus admin@adbhsmdemo_high
```

### 7.2 Enable Network ACL for Managed HSM

```sql
-- Allow ADMIN user to connect to Managed HSM
BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => '${HSM_NAME}.managedhsm.azure.net',
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

### 8.1 Test Connectivity to Managed HSM (Optional)

```sql
-- Test DNS resolution and connectivity
SET SERVEROUTPUT ON;
DECLARE
  req UTL_HTTP.REQ;
  resp UTL_HTTP.RESP;
  value VARCHAR2(1024);
BEGIN
  req := UTL_HTTP.BEGIN_REQUEST('https://${HSM_NAME}.managedhsm.azure.net/healthstatus');
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
   - **Vault Type:** Azure Managed HSM
   - **Vault URI:** `https://${HSM_NAME}.managedhsm.azure.net`
   - **Key Name:** `${KEY_NAME}`
   - **Service Principal Client ID:** `$APP_ID`
   - **Service Principal Tenant ID:** `$TENANT_ID`
   - **Service Principal Secret:** `$CLIENT_SECRET`
6. Click **Save**

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

Expected output:
```
WRL_TYPE             STATUS
-------------------- --------------------
AZURE_MANAGEDHSM     OPEN
```

## Testing and Validation

### Test 1: Verify DNS Resolution

From a VM in the same VNet:

```bash
nslookup ${HSM_NAME}.managedhsm.azure.net
```

Expected output should show the private IP address (10.0.2.5).

### Test 2: Verify Database Encryption

```sql
-- Check encryption status
SELECT * FROM V$ENCRYPTED_TABLESPACES;

-- Verify wallet is open
SELECT WRL_TYPE, STATUS FROM V$ENCRYPTION_WALLET;
```

### Test 3: Verify HSM Key Properties

```bash
# Get key properties
az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME

# Verify key is HSM-backed
az keyvault key show --hsm-name $HSM_NAME --name $KEY_NAME --query key.kty -o tsv
```

Expected output: `RSA-HSM`

### Test 4: Test Key Operations

```bash
# Test encrypt/decrypt operations
echo "test data" > plaintext.txt

# Encrypt
az keyvault key encrypt --hsm-name $HSM_NAME --name $KEY_NAME --algorithm RSA-OAEP --value "dGVzdCBkYXRh" --data-type base64 --query result -o tsv > encrypted.txt

# Decrypt
az keyvault key decrypt --hsm-name $HSM_NAME --name $KEY_NAME --algorithm RSA-OAEP --value $(cat encrypted.txt) --data-type base64 --query result -o tsv | base64 -d
```

### Test 5: Test Key Rotation

```bash
# Create a new key version
az keyvault key create --hsm-name $HSM_NAME --name $KEY_NAME --kty RSA-HSM --size 4096

# Rotate encryption key in ADBS via OCI Console
```

### Test 6: Verify Security Domain Backup

```bash
# Verify you can still access security domain file
ls -l ${HSM_NAME}-sd.json

# Verify certificates are available
ls -l sd-*.cer sd-*.key
```

## Disaster Recovery Testing

### Test Security Domain Recovery

**WARNING:** This test should be done in a separate test environment.

```bash
# Simulate disaster: Delete HSM
az keyvault delete-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP

# Restore HSM
az keyvault create --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --administrators $USER_OBJECT_ID

# Upload security domain with quorum keys
az keyvault security-domain upload --hsm-name $HSM_NAME --sd-wrapping-keys ./sd-key1.key ./sd-key2.key --sd-file ${HSM_NAME}-sd.json
```

## Compliance and Auditing

### Enable Diagnostic Logging

```bash
# Create Log Analytics workspace
WORKSPACE_NAME="law-odaa-hsm"
az monitor log-analytics workspace create --resource-group $RESOURCE_GROUP --workspace-name $WORKSPACE_NAME --location $LOCATION

# Get workspace ID
WORKSPACE_ID=$(az monitor log-analytics workspace show --resource-group $RESOURCE_GROUP --workspace-name $WORKSPACE_NAME --query id -o tsv)

# Enable diagnostic settings for Managed HSM
az monitor diagnostic-settings create --name hsm-diagnostics --resource $HSM_ID --workspace $WORKSPACE_ID --logs '[{"category": "AuditEvent", "enabled": true}]' --metrics '[{"category": "AllMetrics", "enabled": true}]'
```

### Query Audit Logs

```bash
# Query key access logs
az monitor log-analytics query --workspace $WORKSPACE_ID --analytics-query "AzureDiagnostics | where ResourceType == 'VAULTS' and Category == 'AuditEvent' | project TimeGenerated, OperationName, CallerIPAddress, ResultType | order by TimeGenerated desc"
```

## Cleanup (Optional)

To remove all resources:

```bash
# Backup security domain before deletion
cp ${HSM_NAME}-sd.json ${HSM_NAME}-sd-backup-$(date +%Y%m%d).json

# Soft delete HSM (can be recovered within retention period)
az keyvault delete-hsm --hsm-name $HSM_NAME --resource-group $RESOURCE_GROUP

# Purge HSM (permanent deletion)
# az keyvault purge-hsm --hsm-name $HSM_NAME --location $LOCATION

# Delete Resource Group
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Delete Service Principal
az ad sp delete --id $APP_ID
```

## Cost Optimization

### Managed HSM Costs
- **Managed HSM:** ~$4/hour (~$2,880/month)
- **Private Endpoint:** ~$7/month
- **Total:** ~$2,887/month

### Cost Reduction Strategies
1. Use Managed HSM only for production environments
2. Use Key Vault (Premium) for development/testing
3. Share Managed HSM across multiple databases
4. Consider Reserved Capacity if available

## Security Best Practices

1. **Security Domain:**
   - Store security domain keys in separate physical locations
   - Use hardware security tokens for key storage
   - Test recovery procedures annually

2. **Access Control:**
   - Use separate service principals for each environment
   - Implement least privilege access
   - Rotate service principal secrets every 90 days

3. **Monitoring:**
   - Enable Azure Monitor diagnostics
   - Set up alerts for failed key operations
   - Review audit logs weekly

4. **Network Security:**
   - Disable public access after configuration
   - Use Network Security Groups on subnets
   - Implement Azure Firewall for additional protection

5. **Key Management:**
   - Document key rotation procedures
   - Implement automated key rotation
   - Maintain key inventory and metadata

## Compliance Certifications

Azure Managed HSM is certified for:
- FIPS 140-3 Level 3
- Common Criteria EAL4+
- PCI DSS
- SOC 2 Type 2
- ISO 27001
- HIPAA/HITECH

**Important:** Verify current certification status at:
https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/compliance

## Next Steps

1. Implement automated key rotation
2. Set up multi-region replication (when available)
3. Configure backup and disaster recovery procedures
4. Integrate with Azure Security Center
5. Implement Azure Policy for compliance enforcement

## Additional Notes

### Performance Considerations
- Managed HSM operations are slightly slower than Key Vault (~10-20ms additional latency)
- First key operation after database restart may take longer
- Consider connection pooling for high-throughput applications

### Managed HSM Limitations
- Single-region deployment (multi-region coming)
- Maximum 500 keys per HSM
- Maximum 5,000 operations per second per key
- Private endpoint required for production use

## Related Guides

- [Scenario 1: Key Vault + Private Endpoints](./scenario1-keyvault-private-endpoint.md)
- [Troubleshooting Guide](./troubleshooting.md)
