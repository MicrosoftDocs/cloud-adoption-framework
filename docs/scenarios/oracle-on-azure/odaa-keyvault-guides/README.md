# Oracle Database@Azure (ODAA) with Azure Key Management Services

This repository provides step-by-step guides for integrating Oracle Autonomous Database Serverless (ADBS) on Azure with Azure key management services using Private Endpoints for enhanced security.

## Scenarios Covered

### Scenario 1: ODAA Autonomous Database + Azure Key Vault + Private Endpoints
Integration with Azure Key Vault for customer-managed encryption keys using private endpoint connectivity.

**Guide:** [scenario1-keyvault-private-endpoint.md](./scenario1-keyvault-private-endpoint.md)

### Scenario 2: ODAA Autonomous Database + Managed HSM + Private Endpoints
Integration with Azure Managed HSM for FIPS 140-3 Level 3 validated cryptographic key protection using private endpoint connectivity.

**Guide:** [scenario2-managed-hsm-private-endpoint.md](./scenario2-managed-hsm-private-endpoint.md)

## Prerequisites

### Azure Requirements
- Active Azure subscription
- Contributor or Owner role on the subscription
- Azure CLI installed (version 2.25.0 or later)
- Azure region with ODAA advanced networking support
- Existing or new Virtual Network with:
  - Delegated subnet for Oracle Database
  - Subnet for Private Endpoints
  - Private DNS Zone support

### Oracle Requirements
- Oracle Database@Azure subscription
- Oracle Cloud Infrastructure (OCI) console access
- SQL*Plus or SQL Developer for database connections
- Understanding of Oracle Autonomous Database operations

### Supported Regions for Advanced Networking
Verify your Azure region supports ODAA advanced networking features:
- [Oracle Database@Azure Network Planning](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan#advanced-network-features)

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                  Azure Virtual Network              │
│                                                     │
│  ┌──────────────────┐      ┌────────────────────┐ │
│  │ Delegated Subnet │      │  Private Endpoint  │ │
│  │  (Oracle ADBS)   │──────│    Subnet          │ │
│  └──────────────────┘      └────────────────────┘ │
│                                       │            │
│                                       │            │
└───────────────────────────────────────┼────────────┘
                                        │
                    Private Endpoint Connection
                                        │
                         ┌──────────────┴───────────────┐
                         │                              │
                    ┌────▼────────┐           ┌────────▼────────┐
                    │ Azure Key   │           │  Azure Managed  │
                    │   Vault     │           │      HSM        │
                    └─────────────┘           └─────────────────┘
```

## Important Notes

### Private Endpoint Resolution
ODAA Autonomous Database must be configured to enforce private endpoint resolution using:
```sql
ALTER DATABASE PROPERTY SET route_outbound_connections = 'enforce_private_endpoint';
```

### DNS Configuration
Two Private DNS Zones are required for proper name resolution:
1. **Key Vault:** `privatelink.vaultcore.azure.net` and `vault.azure.net`
2. **Managed HSM:** `privatelink.managedhsm.azure.net` and `managedhsm.azure.net`

### Supported Key Types
- **Key Vault:** RSA 2048, RSA 3072, RSA 4096
- **Managed HSM:** RSA 2048, RSA 3072, RSA 4096 (FIPS 140-3 Level 3)

## Security Considerations

1. **Network Isolation:** All traffic flows through Azure backbone via Private Endpoints
2. **Public Access:** Disable public access to Key Vault/HSM after configuration
3. **Access Policies:** Use least privilege principle for service principal permissions
4. **Audit Logging:** Enable Azure Monitor logging for all key operations
5. **Key Rotation:** Implement regular key rotation policies

## Getting Started

1. Review prerequisites and ensure you have required access
2. Choose your scenario (Key Vault or Managed HSM)
3. Follow the step-by-step guide for your selected scenario
4. Test connectivity and encryption key operations
5. Review troubleshooting guide if issues occur

## Troubleshooting

Common issues and solutions are documented in:
- [troubleshooting.md](./troubleshooting.md)

## Additional Resources

### Microsoft Documentation
- [Azure Key Vault Overview](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)
- [Azure Managed HSM Overview](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/overview)
- [Azure Private Link](https://learn.microsoft.com/en-us/azure/private-link/private-link-overview)
- [Oracle Database@Azure Documentation](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/)

### Oracle Documentation
- [Autonomous Database Encryption Keys](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-encrypt-set-rotate-keys.html)
- [Azure Key Vault Integration](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)

## License

This documentation is provided as-is for educational and reference purposes.

## Contributing

Contributions and feedback are welcome. Please ensure all code examples follow best practices and security guidelines.
