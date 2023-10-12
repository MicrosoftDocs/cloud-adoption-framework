---
title: Manage secrets
description: Learn about best practices for managing secrets securely.
author: petpipe-msft
ms.author: martinek
ms.date: 04/04/2021
ms.topic: conceptual
ms.custom: internal
---

# Manage secrets in a secure way

Proper management of secrets, keys, certificates, and private keys for certificates is critical to system security. This article provides best practices for managing these assets. Some of the practices might also align with your compliance and attestation requirements.

Microsoft recommends that you do the following to prepare for implementing best practices:

1. Understand and document how various security configurations affect performance and cost. Ensure that your documentation aligns with your business requirements.
1. For each business requirement, ensure that all stakeholders accept the overhead and complexities that the requirement places on the implementation of secrets management.
1. Document your compliance and attestation requirements, for example, requirements that are suggested or mandated by:
    1. The Center for Internet Security (CIS)
    1. The National Institute of Standards and Technology (NIST)
    1. The Health Insurance Portability and Accountability Act of 1996 (HIPAA)
    1. The HITRUST CSF
    1. The Cybersecurity Maturity Model Certification (CMMC)
    1. Canadian Centre for Cyber Security
    1. Federal Information Processing standards (FIPS).
1. Determine whether compliance requirements can be implemented by using built-in governance policy-based rule sets in Azure services. For example, there are various security controls in Azure Policy that can be applied to Azure Key Vault.
1. Identify the personas and the access that they require to the various Azure services. For example, developers and applications might require only read access to the secrets stored in Key Vault in a development environment. On the other hand, operators or administrators require full management access to key vaults.
1. Identify the overall *observability methodology* that your organization uses to ensure that logging, monitoring, auditing, and alerting configurations align with business requirements.

The following illustration is a high-level logical representation of these processes:

![High-level process for managing secrets](../media/manage-secrets-high-level-process.svg)

## Anticipate limitations and exceptions

Exceptions to best practices can occur in various phases of a cloud journey. Anticipating them is difficult. When you discover one, fix it if possible. Otherwise, document it and get acceptance from stakeholders. Each Azure service has limitations or quotas that are documented. Note the limitations and quotas that apply to your workload and set stakeholder expectations.

There might be other limitations and exceptions that require documentation and require alignment with your business requirements. For example, when you perform a backup of keys, secrets, and certifications, there's a limit on the number of [object versions allowed](/azure/key-vault/general/service-limits) in Key Vault.

> [!IMPORTANT]
> The best practice to apply for each exception encountered is: *mitigate as much as possible to ensure that your risks are minimized*. If a risk can't be mitigated, ensure that your *observability methodology* makes it possible for you to identify any nefarious activities as early as possible with the information that supports your:
>
> - Mean time to be notified and to acknowledge (MTTA)
> - Mean time to detect (MTTD)
> - Mean time to recover (MTTR)

## External Configuration Store pattern

Most of the best practices for workloads that are deployed to the cloud use a store for holding secrets. An understanding of the External Configuration Store cloud design pattern provides insights into various issues and considerations that can affect your workload architectural design.

For example, there are rare exceptions to the security best practice of using Key Vault to store secrets, such as connection strings. These exceptions are sometimes revealed when you do performance and load testing during implementation. Ensure that your business stakeholders state that performance is critical to the workload.

Understand the alternatives to using Key Vault and adhere to the External Configuration Store design pattern to align with best practices and compliance requirements. One alternative to Key Vault is to store secrets closer to the compute layer of the application. An example is Azure App Service application settings that are accessed only by designated and approved personas for the connections that require quick response.

> [!IMPORTANT]
> Reasons for implementing the External Configuration Store cloud design pattern are:
>
> - To align with your business and compliance requirements
> - To ensure adherence to the least privilege security model
> - Implement observability, for example: logging, monitoring, and alerting

> [!IMPORTANT]
> If you use Key Vault:
>
> - Implement the security baseline for Key Vault
> - Enable [Microsoft Defender for Key Vault](/azure/security-center/defender-for-key-vault-introduction)
> - Enable logging for Key Vault

For more information, see:

- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits)
- [External Configuration Store pattern](/azure/architecture/patterns/external-configuration-store)
- [Separation of Duty (SOD)](https://csrc.nist.gov/glossary/term/Separation_of_Duty)
- [Details of the NIST SP 800-53 Rev. 4 Regulatory Compliance built-in initiative](/azure/governance/policy/samples/nist-sp-800-53-r4)
- [Azure security baseline for Key Vault](/security/benchmark/azure/baselines/key-vault-security-baseline?context=/azure/key-vault/general/context/context)
- [Authentication in Azure Key Vault](/azure/key-vault/general/authentication)
- [Azure Policy Regulatory Compliance controls for Azure Key Vault](/azure/key-vault/security-controls-policy)
- [Azure Key Vault logging](/azure/key-vault/general/logging?tabs=Vault)

## Manage keys in a secure way

There are different types of keys that are used in the various Azure services:

- Keys that are cryptographic, such as keys for encryption-at-rest and encryption-in-transit.
- Keys that are used for connectivity, such as tokens for authentication and authorization for various Azure services.

### Cryptographic keys: Encryption-at-rest

For an overview of encryption in Azure, see [Azure encryption overview](/azure/security/fundamentals/encryption-overview).

There are two types of keys that are used for encryption-at-rest:

- Platform-managed keys (PMK)
- Customer-managed keys (CMK), also known as bring-your-own-key (BYOK) keys

As mentioned earlier, document your various business requirements. For example, what are your encryption-at-rest requirements with respect to key management? Ask yourself: *Are there any limitations or exceptions that I need to be aware of?*

Some Azure services, because of limitations or exceptions, don't support CMK. Validate and document these items with your business stakeholders for all the Azure services that you use.

> [!IMPORTANT]
> When CMK isn't required, use PMK for operational simplicity. With PMK, the platform manages the keys, including rotation.

If your business requires CMK for encryption-at-rest, document the various Azure services that support CMK and their limitations and release status, such as preview or general availability (GA). For example, Azure Monitor supports CMK and the documents disclose any limitations.

> [!IMPORTANT]
> - When you use CMK, your should frequently rotate the keys that the Azure services use.
> - If backups are encrypted with CMK, ensure that your key rotation makes it possible to restore backups as needed.
> - If your compliance requirements specify that backups be held for several years, ensure that the keys that were used to encrypt the backups are available and can successfully restore these backups.

For more information about encryption keys, see:

- [Azure Monitor customer-managed key](/azure/azure-monitor/logs/customer-managed-keys?tabs=portal)
- [Customer-managed keys for Azure Storage encryption](/azure/storage/common/customer-managed-keys-overview)
- [Replicate machines with CMK enabled disks](/azure/site-recovery/azure-to-azure-how-to-enable-replication-cmk-disks)
- [Configure customer-managed keys for your Azure Cosmos DB account with Azure Key Vault](/azure/cosmos-db/how-to-setup-cmk)

### Other security-based cloud design patterns

Two cloud design patterns address security best practices for keys (used as tokens) and secrets. Consider these patterns as you design your workloads. They are:

- **Valet key pattern:** Use a token that allows clients restricted direct access to a specific resource, in order to offload data transfer from the application.

- **Command and query responsibility segregation (CQRS) pattern:** Separate read and update operations for a data store. Implementing CQRS in your application can maximize the performance, scalability, and security of the application. An application that implements CQRS can better evolve over time. The CQRS pattern also prevents update commands from causing merge conflicts at the domain level.

> [!IMPORTANT]
> For each of your workloads, identify various established cloud design patterns that address each of the problem domains to ensure alignment with your business security requirements.

For more information, see:

- [Valet Key pattern](/azure/architecture/patterns/valet-key)
- [CQRS pattern](/azure/architecture/patterns/cqrs)

### Connectivity keys

The other types of keys are used for various Azure services for connectivity or tokens. Examples are Azure Storage and Azure Service Bus access keys.

There are limitations or exceptions for the keys of various Azure services. Understanding and aligning with your business requirements validates the best choice or practice. For example, Azure Storage has support for shared access policies, shared access signatures, Microsoft Entra ID, and so on.

Azure Storage has many options for authorizing access to data. They're described in [Authorize access to data in Azure Storage](/azure/storage/common/authorize-data-access?toc=/azure/storage/blobs/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Understand the options and evaluate them based on your business requirements,

Many Azure services support managed identities for authentication.  For more information, see [What are managed identities for Azure resources?](/azure/active-directory/managed-identities-azure-resources/overview).

> [!IMPORTANT]
> Use Microsoft Entra managed identities when you can. If you can't, because
it's not suitable for your use cases or not supported by an Azure service that you use,  follow a least privilege security model—use stored access policies or shared-access signatures (SAS) with explicit access and time-bound values.

If an Azure service doesn't support the use of a stored access signature, maybe it has the following policy features instead: manage, send, listen. For example, Azure Service Bus, Azure Event Hubs, and [Azure IoT Hub](/azure/iot-hub/iot-hub-devguide-security) have these types of security access policies and also use Microsoft Entra ID.

> [!IMPORTANT]
> Following a least privilege security model when defining and configuring a policy means that access to information and resources is given only to programs and users that have a legitimate purpose for accessing it.

Several Azure services use a key to allow an invocation to be performed. For example, non-anonymous function apps have an access code (also known as a key).

> [!IMPORTANT]
> Ensure that the keys that are used for invocation have a defined purpose. Create several keys for their intended purpose and renew or regenerate the keys frequently and whenever a key is compromised.

Lastly, various Azure services have features that support key rotation. Understanding [shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility)  supports your documentation for various workloads.

> [!IMPORTANT]
> In each of your workloads, periodically rotate your connection string keys for each of the Azure services. Use automation and an external configuration store, such as Key Vault,  to minimize disruption. When not using an external configuration store, each of these Azure services have two keys that you can use to minimize disruption during your maintenance window.

For more information about keys that are used for invocation or in connection strings, see:

- [Define a stored access policy](/rest/api/storageservices/define-stored-access-policy)
- [Manage storage account keys with Key Vault and the Azure CLI (legacy)](/azure/key-vault/secrets/overview-storage-keys)
- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](/azure/storage/common/storage-sas-overview)
- [Azure Policy Regulatory Compliance controls for Azure Service Bus Messaging](/azure/service-bus-messaging/security-controls-policy)
- [Azure.Security.KeyVault.Administration samples for .NET](/samples/azure/azure-sdk-for-net/azuresecuritykeyvaultadministration-samples)
- [Configure customer-managed keys for encrypting Azure Service Bus data at rest](/azure/service-bus-messaging/configure-customer-managed-key)
- [Automate the rotation of a secret for resources that use one set of authentication credentials](/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of a secret for resources that have two sets of authentication credentials](/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli)

## Manage your secrets in a secure way

Secrets are sensitive information such as passwords, credentials, and fully qualified connection strings.

Passwords and secrets are managed outside of application artifacts by using tools like Key Vault. API keys, database connection strings, and passwords need to be stored in a secure store and not in the application code or configuration. Using a centrally managed external configuration store simplifies operational tasks like key rotation and improves overall security.

Applying automation improves operational efficiencies. Using credentials for various automated runbooks needs to be aligned with your business requirements. For example, a runbook in an Azure Automation account that purges expired data from storage accounts needs to have credentials to perform that action.

> [!IMPORTANT]
> Use an external configuration store like Key Vault to store sensitive information such as fully qualified connection strings or passwords. Where possible, automate rotation of secrets and store them in Key Vault to minimize disruption.

For more information, see:

- [Service Bus authentication and authorization](/azure/service-bus-messaging/service-bus-authentication-and-authorization)
- [Managing and Rotating Secrets with Azure Key Vault, Managed Services, and some automation – Part 1](https://techcommunity.microsoft.com/t5/azure-architecture-blog/managing-and-rotating-secrets-with-azure-key-vault-managed/ba-p/1800612)
- [Automate the rotation of a secret for resources that use one set of authentication credentials](/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of a secret for resources that have two sets of authentication credentials](/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli)
- [Manage credentials in Azure Automation](/azure/automation/shared-resources/credentials?tabs=azure-powershell)

## Renew certificates

Certificates are used for encryption, authorizing automation actions, device management, and many other tasks. Certificates are time bound. When they expire without a robust operational model, they disrupt your workloads.

There are limitations and exceptions, such as:

- Authorizing automation actions in Azure Automation accounts when using Desired State Configuration (DSC)
- Certificate storage location

> [!IMPORTANT]
> Align with the authorized personas, use central storage of these certificates, such as Key Vault, and ensure the expiry dates of SSL/TLS certificates are monitored and that there are renewal processes in place that align with your business requirements.

For more information, see:

- [About Azure Key Vault certificates](/azure/key-vault/certificates/about-certificates)
- [Renew your Azure Key Vault certificates](/azure/key-vault/certificates/overview-renew-certificate)
- [Manage certificates in Azure Automation](/azure/automation/shared-resources/certificates?tabs=azure-powershell)

## Next steps

> [!div class="nextstepaction"]
> [Securing the pipeline and CI/CD workflow](secure-devops.md)
