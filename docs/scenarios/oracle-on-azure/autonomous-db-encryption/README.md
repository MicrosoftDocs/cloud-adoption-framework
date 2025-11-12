# Oracle Autonomous Database with Azure Key Management Solutions

This repository provides step-by-step guides for implementing customer-managed encryption keys with Oracle Database@Azure Autonomous Database Serverless (ODAA ADBS) using Azure key management solutions over private endpoints.

## Scenarios Covered

### Scenario 1: Azure Key Vault with Private Endpoints
Configure Oracle Autonomous Database to use customer-managed encryption keys stored in Azure Key Vault, accessible only through private endpoints within your virtual network.

**[Go to Scenario 1 Guide →](./02-scenario-1-keyvault.md)**

### Scenario 2: Azure Key Vault Managed HSM with Private Endpoints
Configure Oracle Autonomous Database to use customer-managed encryption keys stored in Azure Key Vault Managed HSM (Hardware Security Module), accessible only through private endpoints.

**[Go to Scenario 2 Guide →](./03-scenario-2-managed-hsm.md)**

## Architecture Overview

```
┌─────────────────────────────────────────────────┐
│           Azure Virtual Network                 │
│                                                 │
│  ┌────────────────┐      ┌──────────────────┐ │
│  │ Oracle         │      │  Azure Key Vault  │ │
│  │ Autonomous DB  │◄────►│  (Private        │ │
│  │                │      │   Endpoint)       │ │
│  └────────────────┘      └──────────────────┘ │
│         │                         │            │
│         │    Private DNS Zones    │            │
│         │  - vault.azure.net      │            │
│         │  - privatelink.         │            │
│         │    vaultcore.azure.net  │            │
│         └─────────────────────────┘            │
└─────────────────────────────────────────────────┘
```

## Key Features

- **Enhanced Security**: All communication between Oracle Autonomous Database and Azure Key Vault occurs over private endpoints
- **Network Isolation**: Encryption keys never traverse the public internet
- **Compliance**: Meets regulatory requirements for key management and data encryption
- **Customer Control**: Full control over encryption key lifecycle, rotation, and access policies

## Prerequisites

Before starting with either scenario, review the [Prerequisites Guide](./01-prerequisites.md) to ensure:
- Your Azure region supports advanced networking features for Oracle Database@Azure
- Required Azure and OCI permissions are in place
- Network infrastructure is properly configured

## Documentation References

### Oracle Documentation
- [Oracle Autonomous Database Encryption Keys](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-encrypt-set-rotate-keys.html)
- [Using Azure Key Vault with Oracle Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)

### Microsoft Documentation
- [Azure Key Vault Private Link Integration](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)
- [Azure Private Endpoint DNS Configuration](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns)
- [Azure Key Vault Managed HSM](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/)

## Getting Started

1. **Review Prerequisites**: Start with [01-prerequisites.md](./01-prerequisites.md)
2. **Choose Your Scenario**: 
   - [Scenario 1: Azure Key Vault](./02-scenario-1-keyvault.md) - Standard Key Vault with private endpoints
   - [Scenario 2: Managed HSM](./03-scenario-2-managed-hsm.md) - HSM-backed keys for enhanced security
3. **Troubleshooting**: If you encounter issues, consult [04-troubleshooting.md](./04-troubleshooting.md)

## Important Notes

- Advanced networking features must be enabled in your Azure region
- Database restart is required when changing encryption key configurations
- Private DNS zone configuration is critical for proper name resolution
- Testing in a non-production environment is strongly recommended

## Support and Contributions

For issues or questions:
- Consult the [Troubleshooting Guide](./04-troubleshooting.md)
- Review Oracle and Microsoft official documentation
- Open an issue in this repository

## License

This documentation is provided as-is for educational and reference purposes.
