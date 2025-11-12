# Oracle Autonomous Database on Azure with Customer-Managed Encryption Keys

This repository contains step-by-step guides for configuring Oracle Database@Azure Autonomous Database Serverless (ODAA ADBS) with customer-managed encryption keys using Azure Key Vault and Azure Managed HSM over private endpoints.

## Overview

Oracle Database@Azure Autonomous Database supports customer-managed encryption keys stored in Azure Key Vault or Azure Managed HSM. For enhanced security, these services can be configured to be accessible only through private endpoints, eliminating public internet exposure.

## Scenarios Covered

### Scenario 1: Azure Key Vault with Private Endpoints
Configure ODAA Autonomous Database to use customer-managed encryption keys from Azure Key Vault with private endpoint connectivity.

- **Guide**: [scenario-1-keyvault-private-endpoint.md](./scenario-1-keyvault-private-endpoint.md)
- **Use Case**: Standard encryption key management with private network access
- **Security Level**: High
- **Complexity**: Medium

### Scenario 2: Azure Managed HSM with Private Endpoints
Configure ODAA Autonomous Database to use customer-managed encryption keys from Azure Managed HSM with private endpoint connectivity.

- **Guide**: [scenario-2-managed-hsm-private-endpoint.md](./scenario-2-managed-hsm-private-endpoint.md)
- **Use Case**: FIPS 140-3 Level 3 validated HSM for highly sensitive data
- **Security Level**: Very High
- **Complexity**: Medium-High

## Prerequisites

Before starting either scenario, ensure you have:

### Azure Requirements
- Active Azure subscription
- Owner or Contributor permissions on the subscription
- Azure CLI installed and configured
- Access to Azure portal

### Oracle Cloud Infrastructure (OCI) Requirements
- Oracle Database@Azure subscription
- Access to OCI Console
- Familiarity with Oracle Autonomous Database

### Networking Requirements
- Virtual Network (VNet) with available address space
- Delegated subnet for Oracle Database@Azure
- Understanding of Private DNS Zones
- Advanced networking features enabled in your Azure region ([Check supported regions](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan#advanced-network-features))

### Knowledge Requirements
- Basic understanding of Azure networking concepts
- Familiarity with DNS resolution
- Basic SQL knowledge for database configuration

## Architecture Overview

Both scenarios follow a similar architecture pattern:

```
┌─────────────────────────────────────────────────────────────┐
│                      Azure Virtual Network                   │
│                                                              │
│  ┌──────────────────┐         ┌──────────────────┐         │
│  │   Delegated      │         │  Azure Key Vault │         │
│  │    Subnet        │◄───────►│   or Managed HSM │         │
│  │                  │ Private │                  │         │
│  │  ┌────────────┐  │Endpoint │                  │         │
│  │  │   ODAA     │  │         │  Private         │         │
│  │  │   ADBS     │  │         │  Endpoint        │         │
│  │  └────────────┘  │         │                  │         │
│  └──────────────────┘         └──────────────────┘         │
│                                                              │
│  ┌──────────────────────────────────────────────┐          │
│  │      Private DNS Zones                       │          │
│  │  - privatelink.vaultcore.azure.net          │          │
│  │  - vault.azure.net (Key Vault)              │          │
│  │  OR                                          │          │
│  │  - privatelink.managedhsm.azure.net         │          │
│  │  - managedhsm.azure.net (Managed HSM)       │          │
│  └──────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## Security Features

Both scenarios implement:

- **Zero public internet exposure**: All traffic routed through Azure backbone network
- **Private DNS resolution**: Ensures services resolve to private IP addresses
- **Customer-managed encryption keys**: Full control over encryption key lifecycle
- **Azure RBAC integration**: Fine-grained access control using Azure AD principals
- **Network isolation**: Resources communicate only within defined network boundaries

## Getting Started

1. Review the [Prerequisites](#prerequisites) section
2. Choose your scenario:
   - For standard encryption requirements: [Scenario 1 - Azure Key Vault](./scenario-1-keyvault-private-endpoint.md)
   - For FIPS 140-3 Level 3 compliance: [Scenario 2 - Managed HSM](./scenario-2-managed-hsm-private-endpoint.md)
3. Follow the step-by-step guide
4. Refer to [troubleshooting.md](./troubleshooting.md) if you encounter issues

## Common Issues

For troubleshooting guidance, see [troubleshooting.md](./troubleshooting.md), which covers:
- DNS resolution issues
- Private endpoint connectivity problems
- Authentication and authorization errors
- Encryption key configuration issues

## Additional Resources

### Oracle Documentation
- [Oracle Database@Azure Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/)
- [Encryption Keys with Azure Key Vault](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/encryption-keys-azure-key-vault.html)
- [Managing Encryption Keys](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-encrypt-set-rotate-keys.html)

### Microsoft Documentation
- [Azure Key Vault Private Link](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)
- [Managed HSM Private Link](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/private-link)
- [Azure Private DNS Zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview)
- [Oracle Database@Azure Networking](https://learn.microsoft.com/en-us/azure/oracle/oracle-db/oracle-database-network-plan)

## Contributing

Contributions to improve these guides are welcome. Please ensure all documentation follows best practices and is tested before submission.

## License

These guides are provided as-is for educational and deployment purposes.
