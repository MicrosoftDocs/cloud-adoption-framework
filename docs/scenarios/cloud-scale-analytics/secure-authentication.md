---
title: Authentication for cloud-scale analytics in Azure
description: Learn about authentication techniques for cloud-scale analytics in Azure, including user, application, and service-to-service authentication.
author: mboswell
ms.author: mboswell
ms.date: 02/14/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authentication for cloud-scale analytics in Azure

Authentication is the process of verifying the identity of the user or application. A single source identity provider is preferred, which handles identity management and authentication. This provider is known as a directory service. It provides methods for storing directory data and making this data available to network users and administrators.

Any data lake solution should use and integrate with the directory service that's already in use. For most organizations, Active Directory is the directory service for all identity-related services. It's the primary and centralized database for all service and user accounts.

In the cloud, Microsoft Entra ID is a centralized identity provider and the preferred source for identity management. Delegating authentication and authorization to Microsoft Entra ID enables scenarios such as conditional access policies that require a user to be in a specific location. It supports multifactor authentication to increase the level of access security. Configure data lake data store services with Microsoft Entra integration when possible.

For data services that don't support Microsoft Entra ID, use access key or token for authentication. The client should store the access key in a key management store such as Azure Key Vault.

Authentication scenarios for cloud-scale analytics are:

- User authentication
- Application and service-to-service authentication

## User authentication

Users who connect to a data service or resource must present a credential. This credential proves that users are who they claim. Then they can access the service or resource. Authentication also allows the service to know the identity of the users. The service decides what a user can see and do after the identity is verified.

Azure Data Lake Storage Gen2, Azure SQL Database, and Azure Synapse support Microsoft Entra integration. The interactive user authentication mode requires users to provide credentials in a dialog box.

> [!IMPORTANT]
> Do not hard-code user credentials into an application for authentication purpose.

## Application and service-to-service authentication

These requests aren't associated with a specific user or there's no user available to enter credentials.

### Service-to-service authentication

Even if a service accesses another service without human interactions, the service must present a valid identity. This identity proves that the service is real. The accessed service can use the identity to decide what the service can do.

For service-to-service authentication, the preferred method for authenticating Azure services is managed identities. Managed identities for Azure resources allow for authentication to any service that supports Microsoft Entra authentication without any explicit credentials. For more information, see [What are managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

Managed identities are service principals, which can only be used with Azure resources. For example, a managed identity can be created directly for an Azure Data Factory instance. This managed identity is an object registered to Microsoft Entra ID. It represents this Data Factory instance. This identity can then be used to authenticate to any service, such as Data Lake Storage, without any credential in the code. Azure takes care of the credentials that are used by the service instance. The identity can grant authorization to Azure service resources, such as a folder in the Azure Data Lake Storage. When you delete this Data Factory instance, Azure cleans up the identity in Microsoft Entra ID.

#### Benefits of using managed identities

Managed identities should be used to authenticate an Azure service to another Azure service or resource. They provide the following benefits:

- A managed identity represents the service for which it's created. It doesn't represent an interactive user.
- Managed identity credentials are maintained, managed, and stored in Microsoft Entra ID. There's no password for a user to keep.
- With managed identities, the client services don't use passwords.
- The system-assigned managed identity is deleted when the service instance is deleted.

These benefits mean that the credential is better protected and security compromise is less likely.

### Application-to-service authentication

Another access scenario is an application, such as a mobile web application, accessing an Azure service. Whoever is accessing an Azure service, the accessor must provide its identity and that identity must be verified.

An Azure service principal is the alternative for applications and services that don't support managed identities to authenticate to Azure resources. An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. This access is restricted by the roles assigned to the service principal. For security reasons, we recommend using service principals with automated tools or applications rather than allowing them to sign in with a user identity. For more information, see [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals).

> [!NOTE]
> Both managed identities and service principals are created and maintained only in Microsoft Entra ID.

### Difference between managed identity and service principal

| Service principal | Managed identity |
|-------------------|------------------|
| A security identity manually created in Microsoft Entra ID for use by applications, services, and tools to access specific Azure resources. | A special type of service principal. It's an automatic identity that is created when an Azure service is created. |
| Can be used by any application or service. It isn't tied to a specific Azure service. | Represents an Azure service instance itself. It cannot be used to represent other Azure services. |
| Has an independent lifecycle. You must delete it explicitly. | Is deleted automatically when the Azure service instance is deleted. |
| Password-based or certificate-based authentication. | No explicit password to be provided for authentication. |

## Database authentication and permissions

Cloud-scale analytics probably contains polyglot storage. Examples include PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics.

- [Use Microsoft Entra ID for authentication with PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Microsoft Entra authentication with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics](/azure/azure-sql/database/authentication-aad-overview)
- [Use Microsoft Entra ID for authenticating with MySQL](/azure/mysql/concepts-azure-ad-authentication)

We recommend that you use Microsoft Entra groups to secure database objects instead of individual Microsoft Entra user accounts. Use these Microsoft Entra groups to authenticate users and protects database objects. Similar to the data lake pattern, you could use your data application onboarding to create these groups.

> [!NOTE]
> Data applications can store sensitive data products in Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics pools. For more information, see [Sensitive data](./secure-data-privacy.md#sensitive-data-personal-data).

## Azure Data Lake security in cloud-scale analytics

To control access to data in the data lake, we recommend using access control list (ACL) at the level of files and folders. Azure Data Lake also adopts a POSIX-like access control list model. POSIX (portable operating system interface) is a family of standards for operating systems. One standard defines a simple but powerful permission structure for accessing files and folders. POSIX has been adopted widely for network file shares and Unix computers.

Similar to Azure RBAC general practices, the following rules should apply to ACL:

- **Manage access using groups.** Assign access to Microsoft Entra groups and manage membership of groups for ongoing access management. See [Access control and data lake configurations in Azure Data Lake Storage](best-practices/data-lake-access.md).

- **Least privilege.** In most cases, users should have only read permission to the folders and files they need in the data lake. A managed identity or service principal, such as the one used by Azure Data Factory, has read, write, and execute permissions. Data users shouldn't have access to the storage account container.

- **Align with data partitioning scheme.** ACL and data partition design must align to ensure effective data access control. For more information, see [[Data lake partitioning](../cloud-scale-analytics/architectures/data-standardization.md#data-lake-partitioning)].

## Next steps

[Data management and role-based access control for cloud-scale analytics in Azure](./secure-analytics-role-based-access-control.md)
