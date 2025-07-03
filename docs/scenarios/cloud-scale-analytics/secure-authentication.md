---
title: Authentication for Cloud-Scale Analytics in Azure
description: Learn about authentication techniques for cloud-scale analytics in Azure, including user, application, and service-to-service authentication.
author: mboswell
ms.author: mboswell
ms.date: 02/04/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authentication for cloud-scale analytics in Azure

Authentication is the process of verifying the identity of a user or application. We recommend that you use a single-source identity provider to handle identity management and authentication. This provider is known as a *directory service*. It provides ways to store directory data and makes this data available to network users and administrators.

Any data lake solution should use and integrate with an existing directory service. For most organizations, the directory service for all identity-related services is Microsoft Entra ID. It's the primary and centralized database for all service and user accounts.

In the cloud, Microsoft Entra ID is a centralized identity provider and the preferred source for identity management. Delegate authentication and authorization to Microsoft Entra ID to use capabilities such as Conditional Access policies that require a user to be in a specific location. Microsoft Entra ID also supports multifactor authentication, which increases the level of access security. You should configure data services by integrating Microsoft Entra ID whenever possible.

If your data services don't support Microsoft Entra ID, you should perform authentication by using an access key or token. You should store the access key in a key management store, such as Azure Key Vault.

Authentication scenarios for cloud-scale analytics are:

- **User authentication.** In this scenario, Microsoft Entra ID authenticates users by using their credentials.
- **Service-to-service authentication.** In this scenario, Azure resources authenticate services by using managed identities, which Azure automatically manages.
- **Application-to-service authentication.** In this scenario, applications authenticate services by using service principals.

## Authentication scenarios

The following sections describe each of the authentication scenarios: user authentication, service-to-service authentication, and application-to-service authentication.

### User authentication

Users who connect to a data service or resource must present a credential. This credential proves that users are who they claim to be. Then they can access the service or resource. Authentication also allows the service to know the identity of the users. The service decides what a user can see and do after the identity is verified.

Azure Data Lake Storage, Azure SQL Database, and Azure Databricks support Microsoft Entra ID integration. The interactive user authentication mode requires users to provide credentials in a dialog box.

> [!IMPORTANT]
> Don't hard-code user credentials into an application for authentication purposes.

### Service-to-service authentication

When a service accesses another service without human interaction, it must present a valid identity. This identity proves the service's authenticity and allows the service that it accesses to determine what actions are permitted.

In service-to-service authentication scenarios, we recommend that you use managed identities for authenticating Azure services. Managed identities for Azure resources allow for authentication to any service that supports Microsoft Entra authentication without any explicit credentials. For more information, see [What are managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview).

Managed identities are service principals that can only be used with Azure resources. For example, you can create a managed identity for an Azure Data Factory instance. Microsoft Entra ID registers this managed identity as an object that represents the Data Factory instance. You can then use this identity to authenticate to any service, such as Data Lake Storage, without any credentials in the code. Azure manages the credentials that the service instance uses. The identity can authenticate Azure service resources, such as a folder in Data Lake Storage. When you delete the Data Factory instance, Azure deletes the identity in Microsoft Entra ID.

#### Benefits of using managed identities

Use managed identities to authenticate an Azure service to another Azure service or resource. Managed identities provide the following benefits:

- A managed identity represents the service for which it's created. It doesn't represent an interactive user.
- Managed identity credentials are maintained, managed, and stored in Microsoft Entra ID. There's no password for a user to keep.
- When you use managed identities, the client services don't use passwords.
- The system-assigned managed identity is deleted when the service instance is deleted.

These benefits mean that credentials are better protected and security compromise is less likely.

### Application-to-service authentication

Another access scenario is when an application, such as a mobile or web application, accesses an Azure service. The application must present its identity, which must then be verified.

An Azure service principal is the alternative option for applications and services that don't support managed identities to authenticate to Azure resources. A service principal is an identity that's created specifically for applications, hosted services, and automated tools to access Azure resources. The roles assigned to the service principal control its access. For security reasons, we recommend that you use service principals with automated tools or applications instead of allowing them to sign in with a user identity. For more information, see [Application and service principal objects in Microsoft Entra ID](/entra/identity-platform/app-objects-and-service-principals).

#### Differences between managed identities and service principals

| Service principal | Managed identity |
|-------------------|------------------|
| A security identity that you manually create in Microsoft Entra ID for applications, services, and tools that need to access specific Azure resources. | A special type of service principal. It's an automatic identity that's created when an Azure service is created. |
| Used by any application or service and isn't tied to a specific Azure service. | Represents an Azure service instance itself. It can't be used to represent other Azure services. |
| Has an independent lifecycle. You must delete it explicitly. | Is deleted automatically when the Azure service instance is deleted. |
| Password-based or certificate-based authentication. | No explicit password needs to be provided for authentication. |

> [!NOTE]
> Both managed identities and service principals are created and maintained only in Microsoft Entra ID.

## Best practices for authentication in cloud-scale analytics

In cloud-scale analytics, implementing robust and secure authentication practices is paramount. Best practices for authentication apply to various layers of a solution, including databases, storage, and analytics services. By using Microsoft Entra ID, organizations can improve security by using features such as multifactor authentication and Conditional Access policies.

|Layer|Service|Recommendation|
|-------------|----------|----------|
|Databases|- SQL Database<br><br>- SQL Managed Instance<br><br>- Azure Database for MySQL<br><br>- Azure Database for PostgreSQL|Use Microsoft Entra ID for authentication with databases such as [Azure Database for PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication), [Azure SQL](/azure/azure-sql/database/authentication-aad-overview), and [Azure Database for MySQL](/azure/mysql/flexible-server/concepts-azure-ad-authentication). |
|Storage|Data Lake Storage|Use Microsoft Entra ID for authentication for security principals, such as user, group, and service principals or managed identities, with Data Lake Storage instead of a shared key or shared access signatures. This approach helps improve security because it supports multifactor authentication and Conditional Access policies.|
|Storage|Data Lake Storage from Azure Databricks|Connect to Data Lake Storage by using [Unity Catalog](/azure/databricks/connect/unity-catalog/) instead of direct storage-level access by creating a [storage credential that uses a managed identity](/azure/databricks/connect/unity-catalog/storage-credentials#create-a-storage-credential-using-a-managed-identity) and an [external location](/azure/databricks/connect/unity-catalog/external-locations).|
|Analytics|Azure Databricks|Use the System for Cross-domain Identity Management to [sync users and groups from Microsoft Entra ID](/azure/databricks/admin/users-groups/scim/). To access Azure Databricks resources by using REST APIs, [use OAuth with an Azure Databricks service principal](/azure/databricks/dev-tools/auth/#what-authentication-approach-should-i-choose).|

> [!IMPORTANT]
> Giving Azure Databricks users direct storage-level access to Data Lake Storage bypasses Unity Catalog's permissions, audits, and security features, including access control and monitoring. To better secure and govern data, Unity Catalog should manage access to data that's stored in Data Lake Storage for Azure Databricks workspace users.

## Next step

[Authorization for cloud-scale analytics in Azure](./secure-authorization.md)