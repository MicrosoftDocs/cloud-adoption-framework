---
title: Authentication for cloud-scale analytics in Azure
description: Learn about authentication techniques for cloud-scale analytics in Azure, including user, application, and service-to-service authentication.
author: mboswell
ms.author: mboswell
ms.date: 10/01/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authentication for cloud-scale analytics in Azure

Authentication is the process of verifying the identity of the user or application. A single source identity provider is preferred, which handles identity management and authentication. This provider is known as a directory service. It provides methods for storing directory data and making this data available to network users and administrators.

Any data lake solution should use and integrate with the directory service that's already in use. For most organizations, Active Directory is the directory service for all identity-related services. It's the primary and centralized database for all service and user accounts.

In the cloud, Microsoft Entra ID (formerly Azure AD) is a centralized identity provider and the preferred source for identity management. Delegating authentication and authorization to Microsoft Entra ID enables scenarios such as conditional access policies that require a user to be in a specific location. It supports multifactor authentication to increase the level of access security. Data services should be configured with Microsoft Entra integration whenever possible.

For data services that do not support Microsoft Entra ID, authentication should be performed using an access key or token. The client should store the access key in a key management store, such as Azure Key Vault.

Authentication scenarios for cloud-scale analytics are:

- **User authentication**: Users authenticate through Microsoft Entra ID using their credentials.
- **Application-to-service authentication**: Applications authenticate using service principals.
- **Service-to-service authentication**: Azure resources authenticate using managed identities, which are automatically managed by Azure.

## Authentication scenarios

### User authentication

Users who connect to a data service or resource must present a credential. This credential proves that users are who they claim. Then they can access the service or resource. Authentication also allows the service to know the identity of the users. The service decides what a user can see and do after the identity is verified.

Azure Data Lake Storage Gen2, Azure SQL Database, Azure Synapse Analytics, and Azure Databricks support Microsoft Entra integration. The interactive user authentication mode requires users to provide credentials in a dialog box.

> [!IMPORTANT]
> Do not hard-code user credentials into an application for authentication purpose.

### Service-to-service authentication

Even if a service accesses another service without human interaction, the service must present a valid identity. This identity proves that the service is real. The accessed service can use the identity to decide what the service can do.

For service-to-service authentication, the preferred method for authenticating Azure services is **managed identities**. Managed identities for Azure resources allow for authentication to any service that supports Microsoft Entra authentication without any explicit credentials. For more information, see [What are managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

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

An Azure **service principal** is the alternative for applications and services that don't support managed identities to authenticate to Azure resources. An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. This access is restricted by the roles assigned to the service principal. For security reasons, we recommend using service principals with automated tools or applications rather than allowing them to sign in with a user identity. For more information, see [Application and service principal objects in Microsoft Entra ID](/azure/active-directory/develop/app-objects-and-service-principals).

#### Difference between managed identity and service principal

| Service principal | Managed identity |
|-------------------|------------------|
| A security identity manually created in Microsoft Entra ID for use by applications, services, and tools to access specific Azure resources. | A special type of service principal. It's an automatic identity that is created when an Azure service is created. |
| Can be used by any application or service. It isn't tied to a specific Azure service. | Represents an Azure service instance itself. It cannot be used to represent other Azure services. |
| Has an independent lifecycle. You must delete it explicitly. | Is deleted automatically when the Azure service instance is deleted. |
| Password-based or certificate-based authentication. | No explicit password to be provided for authentication. |

> [!NOTE]
> Both managed identities and service principals are created and maintained only in Microsoft Entra ID.

## Database authentication and access control

Cloud-scale analytics probably contains polyglot storage. Examples include PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics.

### Use Microsoft Entra ID for authentication with databases

We recommend using Microsoft Entra ID for authentication with databases:

- [Use Microsoft Entra ID for authentication with PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Microsoft Entra authentication with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics](/azure/azure-sql/database/authentication-aad-overview)
- [Use Microsoft Entra ID for authenticating with MySQL](/azure/mysql/concepts-azure-ad-authentication)

### Use Microsoft Entra groups instead of invdividual user accounts

We recommend that you use Microsoft Entra groups to secure database objects instead of individual Microsoft Entra user accounts. Use these Microsoft Entra groups to authenticate users and protects database objects. Similar to the data lake pattern, you could use your data application onboarding to create these groups.

> [!NOTE]
> Data applications can store sensitive data products in Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics pools. For more information, see [Sensitive data](./secure-data-privacy.md#sensitive-data-personal-data).

## Data Lake authentication and access control

Azure Data Lake Storage (ADLS) supports several methods of authentication to ensure secure access. Here are the main ones:

- Microsoft Entra ID based authentication for [security principals](/azure/role-based-access-control/overview#security-principal) (user, group, service principal, or managed identity)
- Shared Key Authorization: Uses an account key to authenticate access to the storage account.
- Shared Access Signatures (SAS): Provides temporary access to resources with specific permissions and time constraints.

### Use Microsoft Entra ID for authentication with ADLS

We recommend using Microsoft Entra ID for authentication with ADLS over shared key or SAS as it allows for enhanced security through its support for Mulfti-Factor Authentication (MFA) and conditional access policies. Additionally, there is no need to manage or rotate keys reducing risk of key exposure.

### Use Access Control Lists (ACLs) for fine-grained access control

While primarily used for authorization, ACLs also play a role in defining access at a granular level. In Azure Data Lake Storage (ADLS) Gen2, ACLs work in conjunction with security principals to manage fine-grained access to files and directories.

#### Apply ACLs at file and folder level

To control access to data in the data lake, we recommend using access control lists (ACLs) at the level of files and folders. Azure Data Lake also adopts a POSIX-like access control list model. POSIX (portable operating system interface) is a family of standards for operating systems. One standard defines a simple but powerful permission structure for accessing files and folders. POSIX has been adopted widely for network file shares and Unix computers.

#### Use Microsoft Entra security groups as the assigned principal in an ACL entry

Resist the opportunity to directly assign individual users or service principals. Using this structure will allow you to add and remove users or service principals without the need to reapply ACLs to an entire directory structure. Instead, you can just add or remove users and service principals from the appropriate Microsoft Entra security group. 

Assign access to Microsoft Entra groups and manage membership of groups for ongoing access management. See [Access control and data lake configurations in Azure Data Lake Storage](best-practices/data-lake-access.md).

#### Apply the principle of least privilege to ACLs

In most cases, users should have only **read** permission to the files and folders they need in the data lake. Data users should not have access to the storage account container.

#### Align ACLs with data partitioning scheme

ACLs and data partition design must align to ensure effective data access control. For more information, see [Data lake partitioning](../cloud-scale-analytics/architectures/data-standardization.md#data-lake-partitioning).

### Connect to ADLS using Unity Catalog in Azure Databricks

Cloud-scale analytics data landing zone(s) may contain one or more Azure Databricks workspaces. Access to data stored in ADLS for users of Azure Databricks workspaces should be managed using Unity Catalog in order to fully secure and govern the data.

Unity Catalog is a tool provided by Databricks to manage access to cloud object storage securely. It offers a suite of features that enable secure connections to cloud storage, allowing users to ingest raw data into a lakehouse, create and read managed tables, register or create external tables, and read and write unstructured data.

> [!IMPORTANT]
> Allowing Azure Databricks users direct storage-level access to ADLS bypasses Unity Catalog’s permissions, audits, and security features, including access control and monitoring. For more information, see [Connect to cloud object storage using Unity Catalog](/azure/databricks/connect/unity-catalog/).

#### Create a storage credential and external location to connect to ADLS

Unity Catalog manages access to cloud storage with two object types:

- **Storage Credential**: Authenticates and authorizes access to data. Access is controlled by Unity Catalog policies. If a user lacks access, the request fails. Use an Azure managed identity or a service principal to authorize access to your storage container. Managed identities are preferred as they allow Unity Catalog to access storage accounts with network rules and eliminate the need to manage and rotate secrets. For more information, see [Create a storage credential using a managed identity](/azure/databricks/connect/unity-catalog/storage-credentials#create-a-storage-credential-using-a-managed-identity).
- **External Location**: Combines a cloud storage path with a storage credential. An external location references storage in an Azure Data Lake Storage Gen2 storage container. For more information, see [Create an external location to connect cloud storage to Azure Databricks](/azure/databricks/connect/unity-catalog/external-locations).

#### Control access to data and objects in Unity Catalog

In Unity Catalog, metadata is registered in a metastore, which is the top-level container for metadata about data and AI assets and their permissions. Initially, users have no access to data in a metastore. Azure Databricks account admins, workspace admins, and metastore admins have default privileges for managing Unity Catalog. For more information, see [Admin privileges in Unity Catalog](/azure/databricks/data-governance/unity-catalog/manage-privileges/admin-privileges).

Each securable object has an owner with full privileges, including granting access to others. Privileges can be granted by a metastore admin, the object owner, or the owner of the catalog or schema containing the object. Account admins can also grant privileges directly on a metastore. For more information, see [Manage Unity Catalog object ownership](/azure/databricks/data-governance/unity-catalog/manage-privileges/ownership).

## Azure Databricks authentication and access control

Azure Databricks identities include:

- Users: Recognized by email addresses.
- Service Principals: For jobs, automated tools, and systems such as scripts, apps, and CI/CD platforms.
- Groups: Collections of identities for managing access. There are account groups and workspace-local groups.

To manage identities in Azure Databricks, you need the account admin, workspace admin, or manager role on a service principal or group. For more information, see [Who can manage identities in Azure Databricks?](/azure/databricks/admin/users-groups/#who-can-manage-identities-in-azure-databricks).

### Authentication in Azure Databricks

Available by default for Azure Databricks accounts and workspaces, **single sign-on with Microsoft Entra ID** supports multi-factor authentication and conditional access, allowing administrators to control sign-in conditions.

#### Use SCIM to sync users and groups from Microsoft Entra ID

SCIM (System for Cross-domain Identity Management) automates user provisioning by syncing users and groups from Microsoft Entra ID to Azure Databricks. It simplifies onboarding by creating users and groups with the correct access levels. When a user leaves or no longer needs access, admins can remove them in Microsoft Entra ID, which also removes their Azure Databricks account, ensuring consistent offboarding and preventing unauthorized access. For more information, see [Sync users and groups from Microsoft Entra ID](/azure/databricks/admin/users-groups/scim/).

#### Use OAuth for secure API authentication

Azure Databricks OAuth provides secure credentials and fine-grained permissions for workspace resources and operations. Databricks recommends using OAuth access tokens over PATs for better security and convenience. For more information, see [Authenticate access to Azure Databricks with a service principal using OAuth](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/oauth-m2m).

### Access control in Azure Databricks

In Azure Databricks, you can use access control lists (ACLs) to configure permission to access workspace objects such as notebooks and SQL Warehouses. All workspace admin users can manage access control lists, as can users who have been given delegated permissions to manage access control lists. For more information on access control lists, see Access control lists. For more information, see [Access control lists](/azure/databricks/security/auth/access-control/).

## Next steps

[Data management and role-based access control for cloud-scale analytics in Azure](./secure-analytics-role-based-access-control.md)