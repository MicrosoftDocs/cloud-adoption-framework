---
title: Authentication for cloud-scale analytics in Azure
description: Learn about authentication techniques for cloud-scale analytics in Azure, including user, application, and service-to-service authentication.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authentication for cloud-scale analytics in Azure

Authentication is the process of verifying the identity of the user or application. A single source identity provider is preferred, which handles identity management and authentication. This provider is known as a directory service. It provides methods for storing directory data and making this data available to network users and administrators.

Any data lake solution should use and integrate with an existing directory service. For most organizations, the directory service for all identity-related services is Active Directory. It's the primary and centralized database for all service and user accounts.

In the cloud, Microsoft Entra ID is a centralized identity provider and the preferred source for identity management. Delegating authentication and authorization to Microsoft Entra ID enables scenarios such as conditional access policies that require a user to be in a specific location. It supports multifactor authentication to increase the level of access security. Data services should be configured with Microsoft Entra ID integration whenever possible.

For data services that don't support Microsoft Entra ID, you should perform authentication using an access key or token. You should store the access key in a key management store, such as Azure Key Vault.

Authentication scenarios for cloud-scale analytics are:

- **User authentication**: Users authenticate through Microsoft Entra ID using their credentials.
- **Application-to-service authentication**: Applications authenticate using service principals.
- **Service-to-service authentication**: Azure resources authenticate using managed identities, which are automatically managed by Azure.

## Authentication scenarios

### User authentication

Users who connect to a data service or resource must present a credential. This credential proves that users are who they claim to be. Then they can access the service or resource. Authentication also allows the service to know the identity of the users. The service decides what a user can see and do after the identity is verified.

Azure Data Lake Storage Gen2, Azure SQL Database, Azure Synapse Analytics, and Azure Databricks support Microsoft Entra ID integration. The interactive user authentication mode requires users to provide credentials in a dialog box.

> [!IMPORTANT]
> Don't hard-code user credentials into an application for authentication purposes.

### Service-to-service authentication

Even when a service accesses another service without human interaction, it must present a valid identity. This identity proves the service's authenticity, allowing the accessed service to determine the permitted actions.

For service-to-service authentication, the preferred method for authenticating Azure services is **managed identities**. Managed identities for Azure resources allow for authentication to any service that supports Microsoft Entra authentication without any explicit credentials. For more information, see [What are managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

Managed identities are service principals, which can only be used with Azure resources. For example, a managed identity can be created directly for an Azure Data Factory instance. This managed identity, registered with Microsoft Entra ID as an object, represents the Data Factory instance. This identity can then be used to authenticate to any service, such as Data Lake Storage, without any credential in the code. Azure takes care of the credentials that are used by the service instance. The identity can grant authorization to Azure service resources, such as a folder in the Azure Data Lake Storage. When you delete this Data Factory instance, Azure cleans up the identity in Microsoft Entra ID.

#### Benefits of using managed identities

Managed identities should be used to authenticate an Azure service to another Azure service or resource. They provide the following benefits:

- A managed identity represents the service for which it's created. It doesn't represent an interactive user.
- Managed identity credentials are maintained, managed, and stored in Microsoft Entra ID. There's no password for a user to keep.
- With managed identities, the client services don't use passwords.
- The system-assigned managed identity is deleted when the service instance is deleted.

These benefits mean that the credential is better protected and security compromise is less likely.

### Application-to-service authentication

Another access scenario involves an application, such as a mobile or web application, accessing an Azure service. The application must present its identity, which must then be verified.

An Azure **service principal** is the alternative for applications and services that don't support managed identities to authenticate to Azure resources. It's an identity created specifically for applications, hosted services, and automated tools to access Azure resources. The roles assigned to the service principal control its access. For security reasons, it's recommended to use service principals with automated tools or applications instead of allowing them to sign in with a user identity. For more information, see [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals).

#### Difference between managed identity and service principal

| Service principal | Managed identity |
|-------------------|------------------|
| A security identity manually created in Microsoft Entra ID for use by applications, services, and tools to access specific Azure resources. | A special type of service principal. It's an automatic identity that is created when an Azure service is created. |
| Used by any application or service and isn't tied to a specific Azure service. | Represents an Azure service instance itself. It can't be used to represent other Azure services. |
| Has an independent lifecycle. You must delete it explicitly. | Is deleted automatically when the Azure service instance is deleted. |
| Password-based or certificate-based authentication. | No explicit password to be provided for authentication. |

> [!NOTE]
> Both managed identities and service principals are created and maintained only in Microsoft Entra ID.

## Best practices for authentication in cloud-scale analytics

In cloud-scale analytics, ensuring robust and secure authentication practices is paramount. Best practices for authentication across various layers, including databases, storage, and analytics services. By using Microsoft Entra ID, organizations can enhance security with features such as multifactor authentication (MFA) and conditional access policies.

|Layer|Service|Recommendations|
|-------------|----------|----------|
|Databases|Azure SQL DB, SQL MI, Synapse, MySQL, PostgreSQL, etc.|Use Microsoft Entra ID for authentication with databases such as [PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication), [Azure SQL](/azure/azure-sql/database/authentication-aad-overview), and [MySQL](/azure/mysql/concepts-azure-ad-authentication). |
|Storage|Azure Data Lake Storage (ADLS)|Use Microsoft Entra ID for authentication for security principals (user, group, service principal, or managed identity) with ADLS over shared key or SAS as it allows for enhanced security through its support for multifactor authentication (MFA) and conditional access policies.|
|Storage|ADLS from Azure Databricks|Connect to ADLS [using Unity Catalog](/azure/databricks/connect/unity-catalog/) instead of direct storage-level access by creating a [storage credential using a managed identity](/azure/databricks/connect/unity-catalog/storage-credentials#create-a-storage-credential-using-a-managed-identity) and an [external location](/azure/databricks/connect/unity-catalog/external-locations).|
|Analytics|Azure Databricks|Use SCIM to [sync users and groups from Microsoft Entra ID](/azure/databricks/admin/users-groups/scim/). To access Databricks resources using REST APIs, [use OAuth with a Databricks service principal](/azure/databricks/dev-tools/auth/#what-authentication-approach-should-i-choose).|

> [!IMPORTANT]
> Allowing Azure Databricks users direct storage-level access to ADLS bypasses Unity Catalog’s permissions, audits, and security features, including access control and monitoring. To fully secure and govern data, access to data stored in ADLS for Azure Databricks workspace users should be managed through Unity Catalog.

## Next steps

[Authorization for cloud-scale analytics in Azure](./secure-authorization.md)