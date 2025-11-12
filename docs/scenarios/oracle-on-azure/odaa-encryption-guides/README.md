# Oracle Database@Azure Autonomous Database Encryption Guides

This repository contains step-by-step guides for configuring customer-managed encryption keys for Oracle Database@Azure (OD@A) Autonomous Database Serverless using Azure Key Vault and Azure Managed HSM over private endpoints.

## Scenarios

### 1. [OD@A Autonomous Database + Azure Key Vault + Private Endpoints](./01-keyvault-private-endpoint.md)
This guide covers the configuration of customer-managed encryption keys using Azure Key Vault with private endpoint connectivity for enhanced security.

**Key Features:**
- Private network connectivity between OD@A and Azure Key Vault
- Customer-managed encryption keys (CMEK)
- Network isolation using Private DNS zones
- Vault Access Policy permission model

### 2. [OD@A Autonomous Database + Azure Managed HSM + Private Endpoints](./02-managed-hsm-private-endpoint.md)
This guide covers the configuration of customer-managed encryption keys using Azure Managed HSM with private endpoint connectivity for FIPS 140-3 Level 3 validated security.

**Key Features:**
- FIPS 140-3 Level 3 validated Hardware Security Module
- Private network connectivity between OD@A and Managed HSM
- Customer-managed encryption keys (CMEK)
- Network isolation using Private DNS zones
- Enhanced security for sensitive workloads

## Prerequisites

Before starting either scenario, ensure you have:

1. **Azure Requirements:**
   - Active Azure subscription
   - Appropriate permissions (Owner or Contributor) on the subscription
   - Azure CLI 2.25.0 or later installed
   - A Virtual Network with a delegated subnet for Oracle Database

2. **OCI/Oracle Database@Azure Requirements:**
   - Access to Oracle Cloud Infrastructure (OCI) Console
   - Oracle Database@Azure subscription
   - Advanced networking feature support in your Azure region ([check supported regions](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan#advanced-network-features))

3. **Access Requirements:**
   - Access to create and manage Azure Key Vault or Managed HSM resources
   - Access to create Private Endpoints and Private DNS Zones
   - Access to connect to Oracle Database@Azure Autonomous Database as ADMIN

## Architecture Overview

Both scenarios follow a similar architecture pattern:

```
┌─────────────────────────────────────────────────────────┐
│                    Azure Virtual Network                │
│                                                          │
│  ┌────────────────────┐         ┌──────────────────┐   │
│  │  OD@A Autonomous   │◄────────┤ Private Endpoint │   │
│  │    Database        │         └────────┬─────────┘   │
│  │  (Delegated Subnet)│                  │             │
│  └────────────────────┘                  │             │
│                                           │             │
│                        ┌─────────────────▼──────────┐  │
│                        │ Private DNS Zone           │  │
│                        │ - privatelink.vaultcore.   │  │
│                        │   azure.net (Key Vault)    │  │
│                        │ - privatelink.managedhsm.  │  │
│                        │   azure.net (Managed HSM)  │  │
│                        └────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                                │
                                │ Private Link
                                │
                     ┌──────────▼──────────┐
                     │ Azure Key Vault or  │
                     │ Azure Managed HSM   │
                     │ (CMK Storage)       │
                     └─────────────────────┘
```

## Important Notes

- **Network Requirements:** Advanced networking features must be enabled in your Azure region
- **DNS Configuration:** Private DNS zones are critical for routing traffic through private endpoints
- **Security:** Both scenarios disable public access to ensure all traffic flows through private endpoints
- **Testing:** Each guide includes optional validation steps to verify private endpoint connectivity

## Troubleshooting

Common issues and solutions are documented in each scenario guide under the "Troubleshooting" section.

## References

### Oracle Documentation
- [Oracle Autonomous Database Serverless Encryption Keys](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-encrypt-set-rotate-keys.html)
- [Azure Key Vault Integration](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)

### Microsoft Documentation
- [Azure Key Vault Private Link Integration](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)
- [Azure Managed HSM Private Link Integration](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/private-link)
- [Oracle Database@Azure Network Planning](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)

## Support

For issues specific to:
- **Oracle Database@Azure:** Contact Oracle Support
- **Azure Services:** Contact Microsoft Support
- **This Guide:** Open an issue in this repository
