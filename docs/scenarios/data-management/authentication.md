---
title: "'data management and analytics' authentication"
description: data management and analytics' authentication
author: mboswell
ms.author: mboswell
ms.date: 06/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Authentication

Authentication is the process of verifying the identity of the user or application that accesses the system. In principle, a single source of identity provider which handles identity management and authentication is preferred. This is known as a directory service which provides the methods for storing directory data and making this data available to network users and administrators. Any data lake solution should look to leverage and integrate with the directory service that's already in use
as much as possible. For most organizations, Active Directory (AD) is the directory for all identity-related services. It's the primary and centralized database for all service and user accounts.

In the cloud, Azure AD is a centralized identify provider and it is the preferred source for identity management. Delegating authentication and authorization to it enables scenarios such as conditional access policies that require a user to be in a specific location, and the use of multi-factor authentication that increases the level of access security. All data lake data store services must be configured with Azure Active Directory (Azure AD or AAD) integration when possible.

For data services which do not support Azure AD, the access key or token may be used for authentication given the client stores the access key in a key management store such as Azure Key Vault.

Authentication Scenarios for the construction set are:

1. User authentication
1. Application and Service-to-Service Authentication

## User Authentication

Any users who connect to a data service or resource must be required to present a credential to prove that they are who they claim they are before they can gain access to the service or resource. Authentication also allows the service to know the identity of the users so that it can dictates what users can see and do after their identities are verified.

Azure Data Lake Storage Gen 2 (ADLS Gen 2) as well as Azure SQL Database (SQL DB) and Azure Synapse do support Azure AD integration to require users accessing data to present their own credentials to Azure AD. The interactive user authentication mode requires users to interactively provide credentials on the popup logon user interface.

>[!IMPORTANT]
>Do not hardcode user credentials into an application for authentication purpose.

## Application and Service-to-Service Authentication

This is the authentication flow when requests are not associated with a specific user, or there is no user available to enter credentials.

### Service-to-Service

Even in the scenario which a service is accessing another service directly without human interactions, the accessor service must still present its valid identity to the service being accessed to prove that the accessor service is the real one and the service being accessed can use this identity to dictate what the accessor service and do.

For service-to-service authentication, [Managed identities](/azure/active-directory/managed-identities-azure-resources/overview) is the preferred method of authenticating the Azure services.

The managed identities for Azure resources feature allow for authentication to any service that supports Azure AD authentication
without any explicit credentials. Authentication process for managed identities is very implicit because it's between Azure services only.

Managed identities are, in fact, service principals *(also described later in this section)* which are locked to only be used with Azure resources. For example, a managed identity can be created directly for an Azure Data Factory instance. This automatically managed identity is an object registered to Azure AD and it represents this specific data factory. This identity can then be used to authenticate to any service such as Data Lake Storage without any credential in the code. Azure
takes care of rolling the credentials that are used by the service instance. Later, this managed identity can be used to grant authorization to Azure service resources such as a folder in the Azure Data Lake Storage. When this specific data factory instance is deleted, Azure automatically cleans up the identity in Azure AD; There will be no existence of the identity in Azure AD to be worried about.

#### Benefits of using managed identities

Managed identities provide the following benefit and protection and they should be used to authenticate an Azure service to another Azure service
or resource.

1. A Managed identity represents the specific service for which it is created. It does not represent an interactive user. Neither is it meant to be used by an interactive user.
1. Managed identity credentials are maintained, managed and stored within Azure AD. There's no explicit password to be maintained by a user.
1. With managed identities, explicit passwords are not needed in the client service. Using the data factory example mentioned earlier, when a data factory's linked service is configured to use data factory's managed identity to authenticate to ADLS Gen 2 storage account, there is no need to specify a password or a client secret. In fact, there is no password or client secret to be specified anyway.
1. The system-assigned managed identity is deleted when the service instance is deleted.

The above benefits mean the credential is more protected and security comprise is less likely.

### Application-to-Service

In addition to human users accessing an Azure service, an Azure service accessing another Azure service, another access is scenario is an application such as a mobile Web application accessing an Azure service. Regardless of who is accessing an Azure service, the accessor must provide its identity and that identity must be verified before it can be allowed access.

In the previous section which discusses about service-to-service authentication, the scenario requires that Azure can support the managed identity for the accessor service, for the accessor service which doesn't have managed identity, it can be treated as if it's an application and use an Azure Service Principal that is described in this section as the identity to access another Azure service.

[An Azure Service Principal](/azure/active-directory/develop/app-objects-and-service-principals)
is the alternative for application and services which do not support managed identities to authenticate to Azure resources. An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. This access is restricted by the roles assigned to the service principal; thus, allowing control over which resources can be accessed and at which level. For security reasons, it's always recommended to use service principals with automated tools or application rather than allowing them to log in with a user identity.

**Note:** Both managed identities and service principals are created and maintain in Azure AD only.

### Difference Between Managed Identity and Service Principal

| Service Principal                                                                                                               | Managed Identity                                                                                                                         |
|---------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| A security identity manually created in Azure AD for use by application, services and tools to access specific Azure Resources. | A managed identity is a special type of service principal. It is an automatic identity that gets created when Azure service is created.  |
| This identity can be used by any application, services. It does not tie to a specific Azure service.                            | This identity represents an Azure service instance itself and it cannot be used to represent other Azure services.                       |
| This identity has an independent lifecycle. It must be deleted explicitly.                                                      | When the Azure service instance is deleted, the identity is deleted.                                                                     |
| Password-based (secret-based) or certificate-based authentication                                                               | No explicit password to be provided for authentication.                                                                                  |

## Databases Authentication and Permissions

Polyglot storage such as PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics are likely to be used in the Enterprise Scale Analytic construction set. They could be used by Data Integrations to store their Read Data Stores or by Data Products.

- [Use Azure Active Directory for authentication with PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Azure Active Directory authentication with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics](/azure/azure-sql/database/authentication-aad-overview)
- [Use Azure Active Directory for authenticating with MySQL](/azure/mysql/concepts-azure-ad-authentication)

It is recommended that Azure AD groups are used to secure database objects instead of individual Azure AD user accounts. These AD Azure Groups would be used to authenticate users and protects database objects. Similar to the data lake pattern, you could use your Data Integration or Data Products onboarding to create these groups within you Azure AD service.

>[!NOTE]
>Storing data inside an Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics Pools are one of the options for Data Integrations and Data Products to store [Sensitive Data](data-privacy.md#sensitive-data).

## Azure Data Lake Security with Enterprise Scale Analytics

To control access to data in the data lake (ADLS Gen 2), we recommend using access control list (ACL) at the level of files and folders. ADLS Gen 2 also adopts POSIX-like access control list model. POSIX (Portable Operating System Interface) is the family of standards for operating systems, one of which defines a simple but yet powerful permission structure for accessing files and folders. POSIX has been adopted widely in network file shares and Unix computers.

Similar to RBAC general practices, the following rules should apply to ACL

- **Manage access using groups.** Assign access to Azure AD groups and manage membership of groups for on-going access management.
- **Least privilege.** In most cases, users should have only Read permission to the folders and files they need in the data lake while a managed identity or service principal such as the one used by Azure Data Factory will have Read, Write and Execute permissions. Data users should not have access to the storage account container.
- **Align with data partitioning scheme.** ACL and data partition design must align to ensure effective data access control. See [Data LakeData Partitioning](data-lake-services.md#data-lake-partitioning).

<!-- ### Enterprise Scale Analytics and AI authentication guidelines (to be updated)

| Data Service                                                                                                                            | Accessor                 | Authentication Provider                                       | Credential                     |
|-----------------------------------------------------------------------------------------------------------------------------------------|--------------------------|---------------------------------------------------------------|--------------------------------|
| ADLS Gen 2                                                                                                                              | User access              | Azure AD                                                      | User account in Azure AD       |
|                                                                                                                                         | Azure Data Factory (ADF) | Azure AD                                                      | ADF's managed identity         |
| Note: The managed identity must be granted at least the Storage Blob Data Contributor role in Access Control (IAM) of ADLS Gen 2.       |
|                                                                                                                                         | SQL DW or SQL DB         | Azure AD                                                      | SQL Server's managed identity  |
| Note: The managed identity must be granted at least the Storage Blob Data Contributor role in Access Control (IAM) of ADLS Gen 2.       |
|                                                                                                                                         | Azure Databricks         |
| (Interactive users)                                                                                                                     | Azure AD                 | For pass-through authentication, use user account in Azure AD |
|                                                                                                                                         | Azure Databricks         |
| (Jobs and shared access)                                                                                                                | Azure AD                 | Use Azure AD service principal                                |
| *There is no managed identity for Databricks                                                                                            |
| SQL DW or SQL DB                                                                                                                        |
| (If required)                                                                                                                           | User access              | Azure AD                                                      | User account in Azure AD       |
|                                                                                                                                         | Azure Data Factory (ADF) | Azure AD                                                      | ADF's managed identity         |
| Note: The ADF's managed identity must be granted at least the Storage Blob Data Contributor role in Access Control (IAM) of ADLS Gen 2. |
| Azure Databricks                                                                                                                        |
| (if required)                                                                                                                           | User access              | Azure AD                                                      | User account in Azure AD       |
|                                                                                                                                         | Azure Data Factory (ADF) | Azure AD                                                      | Use Azure AD service principal |
| *There is no managed identity for Databricks                                                                                            |

Need to add... and update...

- Azure Cosmos DB – Azure Cosmos DB does not support Azure AD authentication for access to database. Use Cosmos DB resource key to authenticate to Azure Cosmos DB.
- Azure Analysis Services – Azure Analysis Services is the tabular semantic data model database in the cloud. Use Azure AD to authenticate to Azure Analysis Services.
-->
