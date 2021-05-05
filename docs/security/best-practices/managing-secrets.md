---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
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

Managing company sensitive secrets, keys and certificates aligns with a critical security step in improving your security posture. Below, you will find several best practices that align with each of these sensitive assets and addtionally, some of these best practices may align with compliance or attestation requirements.

Before continuing, document the following within your organization so your alignment with these best practices can be put into action smoothly:

1. Exceptions: Understand and document how security impacts performance and cost are aligned with your overall business requirements.  Ensure you have reviewed each business requirements to ensure all stakeholders agree and accept the overhead and complexities various security requirements will place on your secrets management implementation.
2. Identify your compliance / attestation requirements. For example: NIST, HIPAA HITRUST, CMMC, PBMM, etc. With respect to implementation, do note that several of these compliance requirements may have built-in rulesets within Azure Policy. For example, there are various Security controls by Azure Policy that can be applied to Azure Key Vault.
3. Identify the personas, their access requirements. For example, developers and applications may only require read access. On the other hand, operators or administrators will require full management access.
4. The overall "observability" methodology used by your organization that will ensure your logging, monitoring, auditing, and alerting configurations are aligned.


## Anticipating exceptions

Anticipating exceptions to the best practices found below will be difficult and these exceptions may occur within various phases of your cloud journey.  Ensuring exceptions and their risks to the business are documented and accepted across all stakeholders.  The overall best practice to each and every exception encountered is: mitigate as much as possible to ensure your risks are minimized. If each risk can not be mitigated, ensure your "observability" methodology will enable you to identify any security breaches as early as possible with the information that will support your compromise recovery processes.
## External Configuration Store cloud design pattern

The majority of these best practices across your enterprise and workloads deployed to the cloud will leverage some secret store. Understanding the External Configuration Store cloud design pattern will not only provide context, it will provide insights to various issues and considerations.

For example, there are rare exceptions to the security best practice of using Azure Key Vault for storing secrects, such as connection strings. These exceptions may be revealed during the development implementation phase when conducting performance and load testing. Ensure your business stakeholders state that performance is critical to the workload.

## Further Reading

- [External Configuration Store pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/external-configuration-store)
- [Understanding Separation of Duty concept within NIST SP 800-192](https://csrc.nist.gov/glossary/term/Separation_of_Duty)
- [Azure Key Vault - Security controls by Azure Policy](https://docs.microsoft.com/en-us/azure/key-vault/security-controls-policy) 

## Key management in a secure way

There are different types of "keys" that can be used within various Azure services.

Keys used for encryption and keys used for connetivity to various Azure services.
### Keys used for encryption

The two types of keys for encryption are:  (PMK - Platform Managed Keys vs. CMK - Customer Managed Keys)

*Different approaches can be used by the workload team. Decisions are often driven by security, compliance and specific data classification requirements. Understanding these requirements is important to determine which key types are best suitable (MMK - Microsoft-managed Keys, CMK - Customer-managed Keys or BYOK - Bring Your Own Key).*

### Further Reading

x

### Keys used within connection strings

The other types of keys are used for various Azure services for connectivity, for example, Azure Storage access keys.



## Secrets management in a secure way

Secrets store sensitive information and are typcially contain password or fully qualified connection strings.

*Passwords and secrets are managed outside of application artifacts, using tools like Azure Key Vault.API keys, database connection string and passwords need to be stored in a secure store and not within the application code or configuration. This simplifies operational tasks like key rotation as well as improving overall security.*

### Further Reading

- [Azure Service Bus authentication and authorization](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-authentication-and-authorization)