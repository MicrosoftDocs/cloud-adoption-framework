---
title: Encryption and key management in Azure
description: Learn about encryption and key management as part of an Azure landing zone
author: Zimmergren
ms.author: pnp
ms.date: 01/04/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Encryption and key management in Azure

Encryption is a vital step toward ensuring data privacy, compliance, and data residency in Microsoft Azure. It's also one of the most important security concerns of many enterprises. This section covers design considerations and recommendations for encryption and key management.

## Design considerations

- Set subscription and scale limits as they apply to Azure Key Vault.

   Key Vault has transaction limits for keys and secrets. To [throttle transactions](/azure/key-vault/general/overview-throttling) per vault for a certain period of time, see [Azure limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

   Key Vault serves a security boundary because access permissions for keys, secrets, and certificates are at the vault level. Key Vault access policy assignments grant permissions separately to keys, secrets, or certificates. They don't support granular, object-level permissions like a specific key, secret, or certificate [key management](/azure/security/fundamentals/data-encryption-best-practices).

- Isolate application-specific and workload-specific secrets and shared secrets, as necessary, to [control access](/azure/key-vault/general/best-practices).

- Optimize Premium SKUs where HSM-protected (Hardware Security Module) keys are required.

   Underlying HSMs are FIPS 140-2 Level 2 compliant. Manage Azure dedicated HSM for FIPS 140-2 Level 3 compliance by considering the supported scenarios.

- Manage key rotation and secret expiration.

- Use [Key Vault certificates](/azure/key-vault/certificates/about-certificates) to manage certificate procurement and signing. Set alerting, notifications, and automated certificate renewals.

- Set disaster recovery requirements for keys, certificates, and secrets.

- Set Key Vault service replication and failover capabilities. Set [availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance).

- Monitor key, certificate, and secret usage.

  Detect unauthorized access by using a key vault or Azure Monitor Log Analytics workspace. For more information, see [Monitoring and alerting for Azure Key Vault](/azure/key-vault/general/alert).

- Delegate Key Vault instantiation and privileged access. For more information, see [Azure Key Vault security](/azure/key-vault/general/security-features).

- Set requirements for using customer-managed keys for native encryption mechanisms, such as Azure Storage encryption:

  - [Customer-managed keys](/azure/storage/common/customer-managed-keys-configure-key-vault)
  - Whole-disk encryption for virtual machines (VMs)
  - Data-in-transit encryption
  - Data-at-rest encryption

## Design recommendations

- Use a federated Azure Key Vault model to avoid transaction scale limits.

- Azure RBAC is the recommended authorization system for the Azure Key Vault data plane. See [Azure role-based access control (Azure RBAC) vs. access policies (legacy)](/azure/key-vault/general/rbac-access-policy) for more information.

- Provision Azure Key Vault with the soft delete and purge policies enabled to allow retention protection for deleted objects.

- Follow a least-privilege model by limiting the authorization to permanently delete keys, secrets, and certificates to specialized custom Microsoft Entra roles.

- Automate the certificate management and renewal process with public certificate authorities to ease administration.

- Establish an automated process for key and certificate rotation.

- Enable firewall and virtual network service endpoints on the vault to control access to the key vault.

- Use the platform-central Azure Monitor Log Analytics workspace to audit key, certificate, and secret usage within each instance of Key Vault.

- Delegate Key Vault instantiation and privileged access, and use Azure Policy to enforce a consistent compliant configuration.

- Default to Microsoft-managed keys for principal encryption functionality, and use customer-managed keys when required.

- Don't use centralized instances of Key Vault for application keys or secrets.

- To avoid secret sharing across environments, don't share Key Vault instances between applications.
