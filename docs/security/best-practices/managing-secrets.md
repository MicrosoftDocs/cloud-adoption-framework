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

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "managing secrets in a secure way" question at the CAF level

- *There's a clear guidance or requirement on what type of keys (PMK - Platform Managed Keys vs. CMK - Customer Managed Keys) should be used for this workload.*
- *Passwords and secrets are...*
- *Access model for keys and secrets is defined for this workload. Permissions to keys and secrets have to be controlled with a access model.*
- *A clear responsibility / role concept for managing keys and secrets is defined for this workload.Central SecOps team should provide guidance on how keys and secrets are managed (governance), application DevOps team is responsible to manage the application related keys and secrets.*
- *Secret/key rotation procedures are in place. In the situation where a key or secret becomes compromised, it is important to be able to quickly act and generate new versions. Key rotation reduces the attack vectors and should be automated and executed without any human interactions.*
- *Expiry dates of SSL/TLS certificates are monitored and there are renewal processes in place.*

# Managing secrets in a secure way

Managing company sensitive secrets, keys and certificates aligns with a critical process in improving your security posture. Below are several security best practices that align with managing each of these sensitive assets and addtionally, some of these best practices may align with compliance or attestation requirements.

Before continuing, it is highly recommended the process of documenting the following within your organization so your alignment with these best practices can be put into action smoothly:

1. Exceptions: Understand and document how various security configurations have direct impact to performance and cost. Ensure your documentation aligns with your overall business requirements.  Next, review each business requirements to ensure all stakeholders agree and accept the overhead and complexities various security requirements will place on your secrets management implementation.
2. Identify your compliance / attestation requirements. For example: CIS, NIST, HIPAA HITRUST, CMMC, PBMM, FIPS, etc. With respect to implementation, do note that several of these compliance requirements may have built-in rulesets within Azure Policy. For example, there are various Security controls by Azure Policy that can be applied to Azure Key Vault.
3. Identify the personas, their access requirements. For example, developers and applications may only require read access. On the other hand, operators or administrators will require full management access.
4. The overall "observability" methodology used by your organization to ensure your logging, monitoring, auditing, and alerting configurations are aligned with business requirements.


## Anticipating exceptions

Anticipating exceptions to the best practices found below will be difficult and these exceptions may occur within various phases of your cloud journey.  Ensuring exceptions and their risks to the business are documented and accepted across all stakeholders.  The overall best practice to each and every exception encountered is: *mitigate as much as possible to ensure your risks are minimized*. If each risk can not be mitigated, ensure your "observability" methodology will enable you to identify any security breaches as early as possible with the information that will support your *time to be notified* / *time to detection* (also known as *MTTD*), *root cause analysis* and *compromise recovery* (also known as *MTTR*) processes.
## External Configuration Store cloud design pattern

The majority of these best practices across your enterprise and workloads deployed to the cloud will leverage some secret store. Understanding the External Configuration Store cloud design pattern will not only provide context, it will provide insights to various issues and considerations.

For example, there are rare exceptions to the security best practice of using Azure Key Vault for storing secrects, such as connection strings. These exceptions may be revealed during the development implementation phase when conducting performance and load testing. Ensure your business stakeholders state that performance is critical to the workload.

Understanding alternatives to using Azure Key Vault and adhering to the External Configuration Store deisgn pattern will ensure alignment with best practices and compliance requirements.  An alternative may be to have secrets stored closer to the application compute layer, for example, Azure App Services Application settings that will only be accessed by designated and approved personas.

## Further Reading

- [External Configuration Store pattern](https://docs.microsoft.com/azure/architecture/patterns/external-configuration-store)
- [Understanding Separation of Duty concept within NIST](https://csrc.nist.gov/glossary/term/Separation_of_Duty)
- [Leveraging Azure Policy's NIST SP 800-53 R4 controls that includes Separation of Duties](https://docs.microsoft.com/azure/governance/policy/samples/nist-sp-800-53-r4)
- [Start with the Azure Key Vault Security baseline](https://docs.microsoft.com/security/benchmark/azure/baselines/key-vault-security-baseline?context=/azure/key-vault/general/context/context)
- [Review and validate against the Azure Key Vault authentication fundamentals](https://docs.microsoft.com/azure/key-vault/general/authentication)
- [Leveraging Security controls by Azure Policy to your Azure Key Vault](https://docs.microsoft.com/azure/key-vault/security-controls-policy)
- [Observability using Azure Key logging](https://docs.microsoft.com/azure/key-vault/general/logging?tabs=Vault) 

## Key management in a secure way

There are different types of "keys" that can be used within various Azure services:

- Keys used for encryption-at-rest and/or encryption-in-transit (NOTE: This section will focus on encryption-at-rest)
- Keys used for connectivity to various Azure services
### **Keys used for encryption**

The two types of keys for encryption-at-rest are: PMK - Platform-Managed Keys vs. CMK - Customer-Managed Keys

As mentioned earlier to the documentation of your various business requirements, what are your encryption-at-rest requirements with respect to key management.  Ask yourself: *Are there any exceptions that I need to be made aware of?*

Do note that you may find various exceptions to various Azure services may not support Customer-Managed Keys (CMK). Validate these exceptions with your business stakeholders for each Azure service within your workload.

PMK - Platform-Managed Keys
CMK - Customer-Managed Keys

**Best practice**: Use *Platform-Managed Keys* due to operational simplicity when *Customer-Managed Keys* are not required as they are managed and rotated by the platform.

If your business requires Customer Managed Keys for encryption-at-rest, ensure you document the various Azure services that support this and their limitations or their release status, such as Preview or GA. For example, Azure Monitor supports customer-managed keys and the documents any limitations.

[!IMPORTANT]
**Best practice**: Using customer-managed keys? Rotate your keys on a frequent interval for each of the Azure services within your workloads.  If backups are encrypted with your CMKs, ensure your key rotation allows these backups to be restored successfully.
### Further Reading: Keys used for encryption

- [Azure Monitor customer-managed key](https://docs.microsoft.com/azure/azure-monitor/logs/customer-managed-keys?tabs=portal)
- [Customer-managed keys for Azure Storage encryption](https://docs.microsoft.com/azure/storage/common/customer-managed-keys-overview)
- [Replicate machines with CMK enabled disks](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-how-to-enable-replication-cmk-disks)
- [Configure customer-managed keys for your Azure Cosmos account with Azure Key Vault](https://docs.microsoft.com/azure/cosmos-db/how-to-setup-cmk)

### **Keys used to invocate or within connection strings**

The other type of "keys" are used for various Azure services for connectivity, for example, Azure Storage or Azure Service Bus access keys.

Do note there are exceptions and understanding these exceptions and aligning with your business requirements and/or use-cases will validate the best choice / practice below. For example, 

Azure Storage has support for shared access policies, shared access signatures, Azure AD, etc.  Understanding each of these [options](https://docs.microsoft.com/azure/storage/common/storage-auth?toc=/azure/storage/blobs/toc.json) and documenting them to your business requirements will guide you through this decision process.

Additionally, many Azure services support managed identities for authentication.  [What are Managed identities?](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)

**Best practice**: Use Azure AD managed identities when your use cases support the capabilities of managed identities for the various Azure services your solution will be composed of.

**Best practice**: If Azure AD managed identities is not suitable for your use cases nor available to an Azure service, following a "least-privelege model" by using stored access policies and/or signatures (also known as "SAS") with explicit access and  time-bound values.

Several Azure services may not have the features to use a stored access signature; however, these services may have the following policy features: manage, read, write. For example, Azure Service Bus topics and/or queues have these types of security access policies in addition to using Azure Active Directory.

**Best practice**: Following a "least-privelege model", when defining and configuring a policy will only provide the necessary operations needed.

Several Azure serices leverage a key to allow an invocation to be performed. For example, non-anonymous Azure functions have an access code (also known as a key).

**Best practice**: Ensure the keys used for invocation have a defined purpose. Create several keys for their intended purpose and renew or regenerate these keys on a frequent interval or when the key is compromised.

Lastly, variuous Azure services have features that allow the connect... ? 

### Further Reading: Keys used to invocate or within connection strings

- [Define a stored access policy on Azure Storage](https://docs.microsoft.com/rest/api/storageservices/define-stored-access-policy)
- [Manage storage account keys with Key Vaule and the Azure CLI](https://docs.microsoft.com/azure/key-vault/secrets/overview-storage-keys)
- [Grant limited access to Azure Storage resources using shared access signatures](https://docs.microsoft.com/azure/storage/common/storage-sas-overview)
- [Azure Policy Regulatory Compliance controls for Azure Service Bus](https://docs.microsoft.com/azure/service-bus-messaging/security-controls-policy)
- [Samples: Azure.Security.KeyVault.Administration using .NET](https://docs.microsoft.com/samples/azure/azure-sdk-for-net/azuresecuritykeyvaultadministration-samples/)

## Secrets management in a secure way

Secrets store sensitive information and are typcially contain password or fully qualified connection strings.

*Passwords and secrets are managed outside of application artifacts, using tools like Azure Key Vault. API keys, database connection string and passwords need to be stored in a secure store and not within the application code or configuration. This simplifies operational tasks like key rotation as well as improving overall security.*

### Further Reading

- [Azure Service Bus authentication and authorization](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-authentication-and-authorization)
- [Microsoft's TechCommunity: Azure Architecture on managing and rotating secrets with Azure Key Vault, pt 1](https://techcommunity.microsoft.com/t5/azure-architecture-blog/managing-and-rotating-secrets-with-azure-key-vault-managed/ba-p/1800612)
- [Automate the rotation of secret for resources that use one set of authentation credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation)
- [Automate the rotation of secret for resources that use two sets of authentation credentials](https://docs.microsoft.com/en-us/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli)

## Renewing certificats

...Expiry dates of SSL/TLS certificates are monitored and there are renewal processes in place

### Further reading
- [Renew your Azure Key Vault certificates](https://docs.microsoft.com/en-us/azure/key-vault/certificates/overview-renew-certificate)




*********************************************
NOTE: sweep through and validate these items.

- *Access model for keys and secrets is defined for this workload. Permissions to keys and secrets have to be controlled with a access model.*
- *A clear responsibility / role concept for managing keys and secrets is defined for this workload.Central SecOps team should provide guidance on how keys and secrets are managed (governance), application DevOps team is responsible to manage the application related keys and secrets.