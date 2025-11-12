# Prerequisites

This guide outlines all prerequisites required before implementing customer-managed encryption keys with Oracle Autonomous Database and Azure Key Vault.

## Azure Requirements

### 1. Region Support

**Critical**: Advanced networking features must be supported in your Azure region for Oracle Database@Azure.

Verify region support at: https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan#advanced-network-features

Supported regions include (as of documentation date):
- East US
- West US
- West Europe
- UK South
- And others - check the link above for the complete list

### 2. Azure Subscription

- Active Azure subscription with sufficient permissions
- Ability to create resources in the selected region
- Quota available for:
  - Virtual Networks
  - Private Endpoints
  - Key Vault or Managed HSM
  - Oracle Database@Azure resources

### 3. Azure Permissions

Required Azure RBAC roles:
- **Network Contributor** or higher - For VNET and subnet configuration
- **Key Vault Contributor** - For Key Vault management
- **Private DNS Zone Contributor** - For DNS zone management
- **Oracle Database@Azure Administrator** - For Oracle resources

### 4. Network Infrastructure

#### Virtual Network Configuration

```bash
# Example: VNET with delegated subnet for Oracle
az network vnet create \
  --name odaa-vnet \
  --resource-group odaa-rg \
  --address-prefix 10.0.0.0/16 \
  --location eastus

# Create delegated subnet for Oracle Autonomous Database
az network vnet subnet create \
  --name oracle-delegated-subnet \
  --vnet-name odaa-vnet \
  --resource-group odaa-rg \
  --address-prefixes 10.0.1.0/24 \
  --delegations Oracle.Database/networkAttachments
```

Requirements:
- VNET with sufficient address space
- Dedicated subnet with delegation to `Oracle.Database/networkAttachments`
- Subnet must have at least /28 CIDR range
- NSG rules allowing required traffic

#### Private DNS Zone

The following Private DNS zones will be created automatically or manually:
- `privatelink.vaultcore.azure.net` - For Key Vault private endpoints
- `privatelink.managedhsm.azure.net` - For Managed HSM (Scenario 2 only)

## Oracle Database@Azure Requirements

### 1. Oracle Autonomous Database

- Oracle Autonomous Database Serverless instance deployed in Azure
- Database must be configured with:
  - **Access Type**: Managed private virtual network IP only
  - **Virtual Network**: Same VNET as Key Vault
  - **Subnet**: Delegated subnet for Oracle

### 2. OCI Console Access

- Access to OCI console through Azure portal
- Ability to navigate to Oracle resources from Azure
- Understanding of OCI Private DNS Views

### 3. Database Connectivity

- Network connectivity to database (private endpoint or appropriate routing)
- SQL*Plus, SQL Developer, or another SQL client
- ADMIN credentials for the Autonomous Database

## Key Vault Requirements

### For Scenario 1: Azure Key Vault

#### Key Vault Configuration
```bash
# Create Key Vault with network restrictions
az keyvault create \
  --name mykeyvault \
  --resource-group odaa-rg \
  --location eastus \
  --enable-purge-protection true \
  --enable-rbac-authorization false
```

Requirements:
- Key Vault Standard or Premium tier
- Purge protection enabled (recommended for production)
- Support for RSA keys (2048, 3072, or 4096 bits)

#### Supported Key Types
According to Oracle documentation, supported key configurations:
- **Algorithm**: RSA
- **Key Size**: 2048, 3072, or 4096 bits
- **Key Type**: RSA or RSA-HSM

### For Scenario 2: Managed HSM

Requirements:
- Azure Key Vault Managed HSM instance
- Premium SKU with FIPS 140-2 Level 3 validated HSMs
- Initial activation and security domain configuration completed
- Support for RSA keys (2048, 3072, or 4096 bits)

Refer to: https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/overview

## Software and Tools

### Required Tools

1. **Azure CLI** (version 2.50.0 or later)
   ```bash
   # Install or update Azure CLI
   az upgrade
   
   # Verify version
   az version
   ```

2. **SQL Client** (one of the following)
   - SQL*Plus (comes with Oracle Instant Client)
   - SQL Developer
   - Azure Data Studio with Oracle extension
   - Any JDBC/ODBC compatible client

3. **Oracle Instant Client** (for SQL*Plus)
   - Download from Oracle website
   - Version compatible with your database version

### Optional but Recommended

1. **Azure PowerShell** (alternative to Azure CLI)
   ```powershell
   # Install Azure PowerShell
   Install-Module -Name Az -Repository PSGallery -Force
   
   # Verify installation
   Get-Module -Name Az -ListAvailable
   ```

2. **OCI CLI** (for advanced OCI operations)
   ```bash
   # Installation varies by platform
   # Refer to: https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm
   ```

## Knowledge Prerequisites

### Azure Knowledge

- Understanding of Azure Virtual Networks and subnets
- Familiarity with Azure Private Link and Private Endpoints
- Basic knowledge of Azure Private DNS Zones
- Understanding of Azure Key Vault concepts
- Experience with Azure RBAC

### Oracle Knowledge

- Familiarity with Oracle Autonomous Database
- Understanding of Oracle Database security concepts
- Basic SQL and PL/SQL knowledge
- Understanding of Oracle Cloud Infrastructure (OCI) basics

## Networking Prerequisites

### DNS Resolution

Understanding of DNS resolution for private endpoints:
- How Private DNS Zones work in Azure
- DNS resolution flow for private endpoints
- OCI Private DNS Views and zones

### Network Connectivity

- VNET-to-VNET connectivity (if applicable)
- ExpressRoute or VPN configuration (for on-premises access)
- Network Security Group (NSG) configuration
- Route tables and User-Defined Routes (UDR)

## Security Prerequisites

### Azure Entra ID (formerly Azure AD)

- Understanding of Service Principals and Managed Identities
- Ability to create and manage application registrations
- Knowledge of Azure RBAC and Key Vault access policies

### Encryption Key Management

- Understanding of customer-managed keys (CMK) vs Microsoft-managed keys
- Key rotation concepts and best practices
- Backup and disaster recovery considerations for keys

## Pre-Deployment Checklist

Before proceeding with deployment, verify:

- [ ] Azure region supports advanced networking for Oracle Database@Azure
- [ ] VNET with delegated subnet is created and configured
- [ ] Required Azure permissions are in place
- [ ] Oracle Autonomous Database is deployed with private network access
- [ ] SQL client is installed and tested
- [ ] Azure CLI is installed and authenticated
- [ ] Understanding of private endpoints and DNS resolution
- [ ] Backup and recovery strategy for existing data (if upgrading existing DB)
- [ ] Testing environment is available (strongly recommended)

## Next Steps

Once all prerequisites are met, proceed to:
- **[Scenario 1: Azure Key Vault with Private Endpoints](./02-scenario-1-keyvault.md)**
- **[Scenario 2: Managed HSM with Private Endpoints](./03-scenario-2-managed-hsm.md)**

## Additional Resources

### Microsoft Documentation
- [Azure Private Endpoint DNS Configuration](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns)
- [Azure Key Vault Best Practices](https://learn.microsoft.com/en-us/azure/key-vault/general/best-practices)
- [Oracle Database@Azure Network Planning](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)

### Oracle Documentation
- [Oracle Autonomous Database Networking](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-network-connectivity.html)
- [Managing Encryption Keys](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-encrypt-set-rotate-keys.html)
