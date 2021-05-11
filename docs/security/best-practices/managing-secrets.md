---
title: Security Title
description: Security Description
author: petpipe-msft
ms.author: pepiper
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Managing secrets in a secure way

Managing company sensitive secrets, keys and certificates aligns with a critical process in improving your security posture. Below are several security best practices on managing each of these sensitive assets and additionally, some of these best practices may align with your compliance or attestation requirements.

Before continuing, it is highly recommended the process of documenting the following items within your organization so your alignment with these best practices can be put into action smoothly:

1. Limitations and Exceptions: Understand and document how various security configurations have direct effect to performance and cost. Ensure your documentation aligns with your overall business requirements.  Next, review each business requirement to ensure all stakeholders agree and accept the overhead and complexities various security requirements will place on your secrets management implementation.
2. Identify your compliance / attestation requirements. For example: CIS, NIST, HIPAA HITRUST, CMMC, PBMM, FIPS, etc. With respect to implementation, do note that several of these compliance requirements may be implemented through built-in governance policy-based rulesets within Azure services. For example, there are various security controls in Azure Policy that can be applied to Azure Key Vault.
3. Identify the personas and their access requirements to the various Azure services. For example, developers and applications may only require read access to the secrets stored to Azure Key Vault within a development environment. On the other hand, operators or administrators will require full management access to all Azure Key Vaults within each environment.
4. The overall "observability" methodology used by your organization to ensure your logging, monitoring, auditing, and alerting configurations are aligned with business requirements.

The following illustration is a high-level logical representation of these processes:

![picture alt](./../media/managing-secrest-hl_process.svg "Managing Secrets high-level process")

## Anticipating limitations and exceptions

Anticipating exceptions to the best practices found below will be difficult and these exceptions may occur within various phases of your cloud journey.  Ensuring exceptions and their risks to the business are documented and accepted across all stakeholders.  Each Azure service will have limitations, quotas, etc. documented that may affect to your Azure workload. Review each of these service limits that your workload will be composed of to ensure they are documented and align with stakeholder expectations.  

There may be other limitations and exceptions that will require documentation and ensure alignment with your business requirements. For example, when performing a backup of keys, secrets and certifications and their number of [object versions allowed](https://docs.microsoft.com/azure/key-vault/general/service-limits) within Azure Key Vault. 

> **Key take away**: The overall best practice to each and every exception encountered is: *mitigate as much as possible to ensure your risks are minimized*. If each risk can not be mitigated, ensure your "observability" methodology will enable you to identify any nefarious activities as early as possible with the information that will support your:
> - *Time to be notified* and "time to ackowledge* (also known as *MTTA*)
> - *Time to detection* (also known as *MTTD*)
> - *Root cause analysis* and *compromise recovery* (also known as *MTTR*) processes.
## External Configuration Store cloud design pattern

Most of these best practices across your enterprise and workloads deployed to the cloud will use some secret store. Understanding the External Configuration Store cloud design pattern will not only provide context, it will provide insights to various issues and considerations that may affect your workload architectural design.

For example, there are rare exceptions to the security best practice of using Azure Key Vault for storing secrets, such as connection strings. These exceptions may be revealed during the development implementation phase when conducting performance and load testing. Ensure your business stakeholders state that performance is critical to the workload.

Understanding alternatives to using Azure Key Vault and adhering to the External Configuration Store design pattern will ensure alignment with best practices and compliance requirements.  An alternative may be to have secrets stored closer to the application's compute layer, for example, Azure App Services Application settings that will only be accessed by designated and approved personas for the connections that require lower latency.

## Further Reading

- [Azure subscription and service limits](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits)
- [External Configuration Store pattern](https://docs.microsoft.com/azure/architecture/patterns/external-configuration-store)
- [Understanding Separation of Duty concept within NIST](https://csrc.nist.gov/glossary/term/Separation_of_Duty)
- [Applying Azure Policy's NIST SP 800-53 R4 controls that includes Separation of Duties](https://docs.microsoft.com/azure/governance/policy/samples/nist-sp-800-53-r4)
- [Start with the Azure Key Vault Security baseline](https://docs.microsoft.com/security/benchmark/azure/baselines/key-vault-security-baseline?context=/azure/key-vault/general/context/context)
- [Review and validate against the Azure Key Vault authentication fundamentals](https://docs.microsoft.com/azure/key-vault/general/authentication)
- [Applying Security controls by Azure Policy to your Azure Key Vault](https://docs.microsoft.com/azure/key-vault/security-controls-policy)
- [Observability using Azure Key logging](https://docs.microsoft.com/azure/key-vault/general/logging?tabs=Vault) 

## Key management in a secure way

There are different types of "keys" that can be used within various Azure services:

- Keys used for encryption-at-rest and/or encryption-in-transit (**NOTE**: The following section will focus on encryption-at-rest)
- Keys used for connectivity to various Azure services

### **Keys used for encryption**

Read [the encryption security fundamentals](https://docs.microsoft.com/azure/security/fundamentals/encryption-overview) document for an encryption overview in Azure. 

The two types of keys for encryption-at-rest are: 

- Platform-Managed Keys, also known as PMK
- Customer-Managed Keys, also known as CMK or bring-your-own-key (BYOK)

As mentioned above, document your various business requirements, what are your encryption-at-rest requirements with respect to key management.  Ask yourself: *Are there any limitations or exceptions that I need to be made aware of?*

Do note that you may find various limitations or exceptions to various Azure services that may not support customer-managed keys (CMK). Validate and document these items with your business stakeholders for each Azure service within your workload.

>**Best practice**: When CMKs are not required, use PMKs due to operational simplicity as they are managed (including rotation) by the platform.

If your business requires customer-managed keys for encryption-at-rest, ensure you document the various Azure services that support this and their limitations or their release status, such as Preview or GA. For example, Azure Monitor supports customer-managed keys and the documents any limitations.

>**Best practice**: When using customer-managed keys, rotation of each key should be conducted on a frequent interval for each of the Azure services within your workloads.  
> - If backups are encrypted with your CMKs, ensure your key rotation allows these backups to be restored successfully.
> - If your compliance requirements need backups to be stored that span several years, ensure that the keys used to encrypt said backups are available and can successfully restore these backups.
### Further Reading: Keys used for encryption

- [Azure Monitor customer-managed key](https://docs.microsoft.com/azure/azure-monitor/logs/customer-managed-keys?tabs=portal)
- [Customer-managed keys for Azure Storage encryption](https://docs.microsoft.com/azure/storage/common/customer-managed-keys-overview)
- [Replicate machines with CMK enabled disks](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-how-to-enable-replication-cmk-disks)
- [Configure customer-managed keys for your Azure Cosmos account with Azure Key Vault](https://docs.microsoft.com/azure/cosmos-db/how-to-setup-cmk)

### Other security -based cloud design patterns

For the following sections on keys and secrets, there are several cloud design patterns that address security best practices and should be considered when designing your workloads. These patterns are:

- Valet Key pattern
 
*Use a token that provides clients with restricted direct access to a specific resource, in order to offload data transfer from the application.*

- Command and Query Responsibility Segregation (CQRS) pattern   

*The Command and Query Responsibility Segregation (CQRS) pattern separates read and update operations for a data store. Implementing CQRS in your application can maximize its performance, scalability, and security. The flexibility created by migrating to CQRS allows a system to better evolve over time and prevents update commands from causing merge conflicts at the domain level.*

> **Best practice:** For each of your workloads, identify various established cloud design patterns that address each of the problem domain(s) to ensure alignment with your business security requirements.

### Further Reading

- [Valet pattern](https://docs.microsoft.com/azure/architecture/patterns/valet-key)
- [CQRS pattern](https://docs.microsoft.com/azure/architecture/patterns/cqrs)
### **Keys used to invocate or within connection strings**

The other type of "keys" are used for various Azure services for connectivity, for example, Azure Storage or Azure Service Bus access keys.


Do note there are limitations and/or exceptions for the keys of various Azure services. Understanding and aligning with your business requirements will validate the best choice or practice below. For example, Azure Storage has support for shared access policies, shared access signatures, Azure AD, etc.

Understanding each of these [options](https://docs.microsoft.com/azure/storage/common/storage-auth?toc=/azure/storage/blobs/toc.json) and documenting them to your business requirements will guide you through this decision process.

Additionally, many Azure services support managed identities for authentication.  [What are Managed identities?](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)

>**Best practice**: 
> - Use Azure AD managed identities when your use cases support the capabilities of managed identities for the various Azure services your solution will be composed of.
> - If Azure AD managed identities is not suitable for your use cases nor available to an Azure service, following a "least-privelege model" by using stored access policies and/or signatures (also known as "SAS") with explicit access and  time-bound values.

Several Azure services may not have the features to use a stored access signature; however, these services may have the following policy features: manage, send, listen. For example, Azure Service Bus, Azure Event Hubs, [Azure IoT Hub](https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security) have these types of security access policies in addition to using Azure Active Directory.

> **Best practice**: Following a "least-privelege model", when defining and configuring a policy will only provide at the specified scope the necessary operations needed.

Several Azure services use a key to allow an invocation to be performed. For example, non-anonymous Azure functions have an access code (also known as a key).

> **Best practice**: Ensure the keys used for invocation have a defined purpose. Create several keys for their intended purpose and renew or regenerate these keys on a frequent interval or when the key is compromised.

Lastly, various Azure services have features that support key rotation.  Understanding [shared responsibility](https://docs.microsoft.com/azure/security/fundamentals/shared-responsibility) in the cloud will support your documentation for various workloads.

> **Best practice**: Within each of your workloads, periodically rotate your connection string keys for each of the Azure services.  Leverage automation and an external configuration store, such as Azure Key Vault so that there is minimized disruption.  When not using an external configuration store, each of these Azure services have two keys so that they can be used to minimize disruption during your maintenance window.

### Further Reading: Keys used to invocate or within connection strings

- [Define a stored access policy on Azure Storage](https://docs.microsoft.com/rest/api/storageservices/define-stored-access-policy)
- [Manage storage account keys with Key Vault and the Azure CLI](https://docs.microsoft.com/azure/key-vault/secrets/overview-storage-keys)
- [Grant limited access to Azure Storage resources using shared access signatures](https://docs.microsoft.com/azure/storage/common/storage-sas-overview)
- [Azure Policy Regulatory Compliance controls for Azure Service Bus](https://docs.microsoft.com/azure/service-bus-messaging/security-controls-policy)
- [Samples: Azure.Security.KeyVault.Administration using .NET](https://docs.microsoft.com/samples/azure/azure-sdk-for-net/azuresecuritykeyvaultadministration-samples/)
- [Managing CMKs with Azure Service Bus](https://docs.microsoft.com/azure/service-bus-messaging/configure-customer-managed-key)
- [Automate the rotation of secret for resources that use one set of augmentation credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of secret for resources that use two sets of authentication credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli)

## Secrets management in a secure way

Secrets store sensitive information and are typically passwords, credentials, or fully qualified connection strings.

Passwords and secrets are managed outside of application artifacts, using tools like Azure Key Vault. API keys, database connection strings, and passwords need to be stored in a secure store and not within the application code or configuration. Using a centrally managed external configuration store simplifies operational tasks like key rotation in addition to improving overall security.

Applying automation will improve operational efficiencies and using credentials for various automated runbooks will need to be aligned with your business requirements.  For example, a runbook within an Azure automation account that purges expired data from storage accounts will need to have credentials to perform said action.

> **Best practice**: Use an external configuration store, such as Azure Key Vault, to store sensitive information. For example, fully qualified connection strings or passwords. Where possible, automate rotation of secrets and store them in Azure Key Vault so that there is minimized disruption.
### Further Reading

- [Azure Service Bus authentication and authorization](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-authentication-and-authorization)
- [Microsoft's TechCommunity: Azure Architecture on managing and rotating secrets with Azure Key Vault, pt 1](https://techcommunity.microsoft.com/t5/azure-architecture-blog/managing-and-rotating-secrets-with-azure-key-vault-managed/ba-p/1800612)
- [Automate the rotation of secret for resources that use one set of authentication credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of secret for resources that use two sets of authentication credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli)
- [Using credentials in Azure Automation runbooks](https://docs.microsoft.com/azure/automation/shared-resources/credentials?tabs=azure-powershell)

## Renewing certificates

Certificates are used for encryption, authorize automation actions, device management, and many other functionalities.  Certificates are time bound and when they expire without a robust operational model, these expired certificates cause disruption to your workloads.

Note there are limitations and exceptions, such as authorizing automation actions within Azure Automation accounts when using Desired State Configuration (also known as DSC) and where these certificates are stored.

> **Best practice**: Aligining with the authorized persona(s), use a central storage of these certificates, such as Azure Key Vault, and ensure the expiry dates of SSL/TLS certificates are monitored and there are renewal processes in place that align with your business requirements.

### Further reading
- [About Azure Key Vault certificates](https://docs.microsoft.com/azure/key-vault/certificates/about-certificates)
- [Renew your Azure Key Vault certificates](https://docs.microsoft.com/azure/key-vault/certificates/overview-renew-certificate)
- [Manage certificates in Azure Automation](https://docs.microsoft.com/azure/automation/shared-resources/certificates?tabs=azure-powershell)
