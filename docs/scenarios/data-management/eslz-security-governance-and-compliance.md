---
title: "Enterprise-Scale security, governance, and compliance for 'data management and analytics'"
description: Describe how this enterprise-scale scenario can improve security, governance, and compliance of 'data management and analytics'
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security, governance, and compliance for 'data management and analytics' Enterprise-Scale scenario

The Enterprise Analytics and AI solution pattern relies on a number of security features which can be enabled on Azure. They include Encryption, Role-Based Access Control, Access Control Lists, and Networking restrictions.

## Data-at-Rest Encryption

Data-at-Rest (DaR) encryption refers to the encryption of data as it persists in storage. DaR encryption is a critical security control by Microsoft as it addresses security risks related to direct physical access to storage media as the underlying data is not recoverable and cannot be changed without the underlying decryption key. This makes it an important layer in the defense-in-depth strategy of Microsoft data centers. In addition, there are often compliance and governance reasons to deploy DaR encryption.

There are multiple services that support DaR encryption, including Storage Accounts and SQL Databases. Additionally, each service may apply DaR encryption at different layers in the stack. Each specific service referenced in this document that has a specific DaR encryption requirement will be addressed in the relevant section. However, there are common concepts and models to be addressed that influence the design decisions of services throughout the Azure stack.

>[!IMPORTANT]
>All services which support Encryption at Rest should have it enabled by default.

## Networking

The Enterprise Scale Analytics and AI prescribed view is to use Private Endpoints for all PaaS services and no public IPs for any IaaS (Infrastructure-as-a-Service). See [Enterprise Scale Analytics and AI Networking](./eslz-network-topology-and-connectivity.md).

## Azure Defender

Azure Defender provides security alerts and advanced threat protection for virtual machines, SQL databases, containers, web applications, virtual networks, and more.

When you enable Azure Defender from the **Pricing and settings** area of Azure Security Center, the following Defender plans are all enabled simultaneously and provide comprehensive defenses for the compute, data, and service layers of your environment:

- [Azure Defender for servers](https://docs.microsoft.com/azure/security-center/defender-for-servers-introduction)
- [Azure Defender for App Service](https://docs.microsoft.com/azure/security-center/defender-for-app-service-introduction)
- [Azure Defender for Storage](https://docs.microsoft.com/azure/security-center/defender-for-storage-introduction)
- [Azure Defender for SQL](https://docs.microsoft.com/azure/security-center/defender-for-sql-introduction)
- [Azure Defender for Kubernetes](https://docs.microsoft.com/azure/security-center/defender-for-kubernetes-introduction)
- [Azure Defender for container registries](https://docs.microsoft.com/azure/security-center/defender-for-container-registries-introduction)
- [Azure Defender for Key Vault](https://docs.microsoft.com/azure/security-center/defender-for-key-vault-introduction)
- [Azure Defender for Resource Manager](https://docs.microsoft.com/azure/security-center/defender-for-resource-manager-introduction)
- [Azure Defender for DNS](https://docs.microsoft.com/azure/security-center/defender-for-dns-introduction)

Each of these plans is explained separately in the Security Center documentation.

>[!IMPORTANT]
>Where this Azure Defender is available for the PaaS Services, we recommend enabling this feature by default, especially for the Azure Data Lake Storage accounts. See [Introduction to Azure Defender](https://docs.microsoft.com/azure/security-center/azure-defender) and [Configure Azure Defender for Storage](https://docs.microsoft.com/azure/storage/common/azure-defender-storage-configure?tabs=azure-security-center) for further details.

## Advanced Threat Protection

Advanced Threat Protection is part of the Advanced Data Security offering, which is a unified package for advanced security capabilities. Advanced Threat Protection can be accessed and managed via the Azure portal. The feature is available for General Purpose and Memory Optimized servers.

Where Advanced Threat Protection is available for the PaaS Services, we recommend enabling this feature by default.

## Azure Data Lake Gen 2 RBAC and ACLs

Azure Data Lake Gen 2 is the predominant polyglot storage within the Enterprise Scale Analytics and AI pattern. Three data lake accounts are provisioned per Data Landing Zone.

It is important to understand how Enterprise Scale Analytics and AI uses Active Directory identities to secure data in the data lake accounts. This section outlines the core terms required for the solution pattern, but for an in-depth explanation, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control).

Azure Data Lake Storage Gen2 supports access control models that combine both Azure RBAC (Role-based access control) and ACLs (Access control lists) to manage access to the data. You can find more information about the [Data Lake Storage Access Control](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control).

In addition to managing access using Azure Active Directory identities for RBAC and ACLs, Azure Data Lake Storage Gen2 also supports using SAS tokens and shared keys for managing access to data in your storage account.

>[!IMPORTANT]
>We recommend [Prevent Shared Key authorization for an Azure Storage account (preview)](https://docs.microsoft.com/azure/storage/common/shared-key-authorization-prevent) for the Data Landing Zone Data Lakes.

**RBAC** lets you assign roles to security principals (a user, group, service principal, or managed identity in Azure Active Directory), and these roles are associated with sets of permissions to the data in your file system. RBAC can help manage roles related to control plane operations (such as adding other users, assigning roles, managing encryption settings and firewall rules, etc.) or for data plane operations (such as creating file systems, reading and writing data etc.).

RBAC is essentially scoped to top-level resources, either storage accounts or file systems in Azure Data Lake Storage Gen2. You can also apply RBAC across resources at a resource group or subscription level.

**ACLs** let you manage a specific set of permissions for a security principal to a much narrower scope, such as a file or a directory in Azure Data Lake Storage Gen2. There are [two types of ACLs](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control#types-of-acls): *access ACLs* and *default ACLs*.

- Access ACLs control access to an object. Files and directories both have access ACLs.
- Default ACLs are templates of ACLs associated with a directory that determine the access ACLs for any child items that are created under that directory. Files do not have default ACLs.

Both access ACLs and default ACLs have the same structure.

### RBAC and ACLs Considerations

|Consideration  |RBAC  |ACLs  |
|---------|---------|---------|
|Scope|Storage accounts, file systems. Cross-resource RBAC at subscription or resource group level.|Files, directories |
|Limits|2,000 RBAC entries in a subscription | 32 ACLs (effectively 28 ACLs) per file, 32 ACLs (effectively 28 ACLs) per folder, default, and access ACLs each |
|Supported levels of permission|[Built-in RBAC](https://docs.microsoft.com/azure/storage/common/storage-auth-aad-rbac-portal#rbac-roles-for-blobs-and-queues) or [custom RBAC](https://docs.microsoft.com/azure/role-based-access-control/custom-roles)|[ACL permissions](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-access-control#levels-of-permission)|

The table above gives an overview of how ACLs and RBAC can be used to manage permissions to the data in your Azure Data Lake Storage Gen2 accounts. At a high level, use RBAC to manage coarse-grained permissions that apply to storage accounts or file systems, and use ACLs to manage fine-grained permissions that apply to files and directories.

>[!CAUTION]
>For every subdomain dataset two Azure AD Security Groups should be created: one for Read and Write and the other for Read-only.\
\
If the dataset is non-sensitive, Users Principal Names(UPNs) and Service Principal object can be added to these groups. If the dataset is SENSITIVE, we would recommend that only Service Principal object and/or Managed Service Identity (MSI) be added to these groups. Please see [Data Privacy](eslz-data-privacy.md) for further details on our sensitive data security pattern.

Resist the opportunity to directly assign individual users or service principals to ACLs. Using an Azure AD Security Group structure will allow you to add and remove users or service principals without the need to reapply ACLs to an entire directory structure. Instead, you can just add or remove users and service principals from the appropriate Azure AD security group.

#### Data Lake Zones Security

![Data Lake Zones Security](./images/adlssecurityzones.png)

The recommended security pattern for each of the of the Data Lake Zones is:

- RAW should only allow access to data via SPNs
- Enriched should only allow access to data via SPNs
- Curated should allow access with both SPNs and UPNs.

#### Example Scenario for using Azure AD Security Groups with Non-Sensitive dataset

There are many different ways to set up groups. For example, imagine that you have a directory named **/LogData** which holds log data that is generated by your server. Azure Data Factory (ADF) ingests data into that folder. Specific users from the service engineering team will upload logs and manage other users of this folder, and the **Azure Databricks Analytics and Data Science Workspace** clusters could analyze logs from that folder.

To enable these activities, the Domain could create a `LogsWriter` group and a `LogsReader` group. You could then assign permissions as follows:

- Add the `LogsWriter` group to the ACL of the **/LogData** directory with `rwx` permissions.
- Add the `LogsReader` group to the ACL of the **/LogData** directory with `r-x` permissions.
- Add the service principal object or Managed Service Identity (MSI) for ADF to the `LogsWriters` group.
- Add users in the service engineering team to the `LogsWriter` group.
- Databricks would be configured for Azure AD Passthrough to the Azure Data Lake Store.

If a user in the service engineering team transfers to a different team, you could just remove them from the `LogsWriter` group. If you did not add that user to a group, but instead, you added a dedicated ACL entry for that user, you would have to remove that ACL entry from the **/LogData** directory. You would also have to remove the entry from all subdirectories and files in the entire directory hierarchy of the **/LogData** directory.

## Databases Authentication and Permissions

Other polyglot storage such as PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics are likely to be used in the Enterprise Scale Analytic solution pattern. They could be used by Domains to store their Read Data Stores or by Data Product Teams.

- [Use Azure Active Directory for authentication with PostgreSQL](https://docs.microsoft.com/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Azure Active Directory authentication with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics](https://docs.microsoft.com/azure/azure-sql/database/authentication-aad-overview)
- [Use Azure Active Directory for authenticating with MySQL](https://docs.microsoft.com/azure/mysql/concepts-azure-ad-authentication)

It is recommended that Azure AD groups are used to secure database objects instead of individual Azure AD user accounts. These AD Azure Groups would be used to authenticate users and protects database objects. Similar to the data lake pattern, you could use your Domain or Data Products onboarding to create these groups within you Azure AD service.

>[!NOTE]
>Storing data inside an Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics Pools are one of the options for domains to store [Sensitive Data](eslz-data-privacy.md#sensitive-data).
