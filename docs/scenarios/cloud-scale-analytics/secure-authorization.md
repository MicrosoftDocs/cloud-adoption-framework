---
title: Authorization for cloud-scale analytics in Azure
description: Learn about data management and role-based access control for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authorization for cloud-scale analytics in Azure

Authorization is the act of granting an authenticated party permission to perform an action. The key principle of **access control** is giving users only the amount of access they need to do their jobs and only allowing certain actions at a particular scope. Role-based security corresponds to access control and is used by many organizations to control access based on defined roles or job functions versus individual users. Users are then assigned one or more security roles, each of which is given authorized permissions to perform specific tasks.

When you use Microsoft Entra ID as the centralized identity provider, authorization to access data services, and storage can be granted per user or per application and is based on a Microsoft Entra identity.

## Data service authorization

**Azure Role-Based Access Control (RBAC)** and **Access Control Lists (ACLs)** play crucial roles in managing access and ensuring security. Azure RBAC and ACLs both require the user (or application) to have an identity in Microsoft Entra ID. In cloud-scale analytics, RBAC is effective for databases and Azure Data Lake Storage, while ACLs are used primarily in Azure Data Lake Storage to provide fine-grained access control at the file and directory levels. ACLs complement RBAC by offering more detailed permissions within the storage hierarchy.

Azure RBAC offers built-in roles like “Owner,” “Contributor,” and “Reader,” but you can also create custom roles tailored to specific needs. The following built-in roles are fundamental for all Azure resource types, including Azure data services:

| Role | Description |
|---|---|
| **Owner** | This role has full access to the resource and can manage everything about the resource, including the right to grant access to it. |
| **Contributor** | This role can manage the resource but can't grant access to it. |
| **Reader** | This role can view the resource and information about it (except for sensitive information like access keys or secrets), but they can't make any changes to the resource. |

> [!NOTE]
> Some services have specific RBAC roles like Storage Blob Data Contributor or Data Factory Contributor, which means that specific RBAC roles should be used for these services. RBAC is an additive model where adding role assignments is an active permission. RBAC also supports *deny* assignments that take precedence over *role* assignments.

> [!TIP]
> When planning an access control strategy, it is recommended to grant users only the amount of access they need to perform their jobs and only allow certain actions at a particular scope.

### Access control in Azure Databases

RBAC in Azure databases revolves around roles, scopes, and permissions. Azure provides several built-in roles tailored for database management, such as SQL Server Contributor, which allows management of SQL servers and databases, and SQL DB Contributor, which permits management of SQL databases but not the server itself. Additionally, custom roles can be created with specific permissions to meet unique requirements.

Roles can be assigned at different scopes, including the subscription level, where roles apply to all resources within the subscription; the resource group level, where roles apply to all resources within the specified resource group; and the resource level, where roles can be assigned directly to individual databases or servers, providing precise control. Permissions define the actions a role can perform, such as read, write, delete, or manage security settings, and these permissions are grouped into roles to simplify management.

In **Azure SQL Database**, roles can be assigned to users, groups, or applications to control access. For example, a database administrator might be assigned the "SQL Server Contributor" role to manage the server and databases. Roles like "SQL DB Contributor" allow users to create, update, and delete databases, while the "SQL Security Manager" role focuses on security configurations.

For **Azure Cosmos DB**, roles can be assigned to manage access to Cosmos DB accounts, databases, and containers. Built-in roles like "Cosmos DB Account Reader" and "Cosmos DB Account Contributor" provide varying levels of access.

In **Azure Database for MySQL, PostgreSQL, and MariaDB**, you can assign roles to manage database servers and individual databases. Roles like "Contributor" and "Reader" can be used to control access.

For more information, see [Azure built-in roles for Databases](/azure/role-based-access-control/built-in-roles/databases).

### Access control in Azure Data Lake Storage

Azure RBAC lets you grant "coarse-grained" access to storage account data, such as read or write access to all of the data in a storage account. ACLs let you grant "fine-grained" access, such as write access to a specific directory or file.

In many scenarios, RBAC and ACLs are used together to provide comprehensive access control in ADLS. RBAC can be used to manage high-level access to data, ensuring that only authorized users can access the service itself. ACLs can then be applied within the storage account to control access to specific files and directories, providing an extra layer of security.

Azure Attribute-based access control (ABAC) builds on Azure RBAC by adding role assignment conditions based on attributes in the context of specific actions. It essentially allows you to refine RBAC role assignments by adding conditions. For example, you can grant read or write access to all data objects in a storage account that have a specific tag.

The following roles permit a security principal to access data in a storage account.

| Role | Description |
|---|---|
| **Storage Blob Data Owner** | Full access to Blob storage containers and data. This access permits the security principal to set the owner of an item and to modify the ACLs of all items. |
| **Storage Blob Data Contributor** | Read, write, and delete access to Blob storage containers and blobs. This access doesn't permit the security principal to set the ownership of an item, but it can modify the ACL of items owned by the security principal. |
| **Storage Blob Data Reader** | Read and list Blob storage containers and blobs. |

Roles such as Owner, Contributor, Reader, and Storage Account Contributor permit a security principal to manage a storage account but don't provide access to the data within that account. However, these roles (excluding Reader) can obtain access to the storage keys, which can be used in various client tools to access the data. For more information, see [Access control model in Azure Data Lake Storage](/azure/storage/blobs/data-lake-storage-access-control-model).

### Access control in Azure Databricks

Azure Databricks comes with access control systems designed for managing access within the Databricks environment, focusing on securable objects and data governance. The three main access control systems within Azure Databricks are:

- **Access control lists**: used to configure permission to access workspace objects such as notebooks. For more information, see [Access control lists](/azure/databricks/security/auth/access-control/).
- **Account role-based access control**: used to configure permission to use account-level objects such as service principals and groups.
- **Unity Catalog**: used to secure and govern data objects.

In addition to access control on objects, there are built-in roles on the Azure Databricks platform. Users, service principals, and groups can be assigned roles. For more information, see [Databricks admin roles](/azure/databricks/security/auth/#access-control-overview).

## Best practices for authorization in cloud-scale analytics

This guide provides best practices for implementing role-based access control (RBAC) in cloud-scale analytics environments. It covers general RBAC principles, database access control, and data lake access control best practices to ensure secure and efficient management of resources.

### General RBAC best practices for cloud-scale analytics

The following best practices can help you to get started with RBAC:

- **Use RBAC roles for service management and operations, and use service-specific roles for data access and workload-specific tasks**: Use RBAC roles on Azure resources for granting permission to security principals that need to perform resource management and operations tasks. Security principals that need to access data within storage don't require an RBAC role on the resource because they don't need to manage it. Instead, grant permission to data objects directly. For example, grant read access to a folder in Azure Data Lake Storage Gen2 or a contained database user and table permission on a database in Azure SQL Database.

- **Use built-in RBAC roles**: First, use the built-in RBAC Azure resource roles to manage services and assign operations roles to control access. Create and use custom roles for Azure resources only when built-in roles don't meet specific needs.

- **Use groups to manage access**: Assign access to Microsoft Entra groups and manage group memberships for ongoing access management.

- **Subscription and resource group scopes**: In nonproduction environments, it often makes sense to grant access at the resource group scope to separate service management and operations access needs versus granting access to individual resources. The reason is that in nonproduction environments, developers, and testers need to manage resources like creating an Azure Data Factory ingestion pipeline or creating a container in Data Lake Storage Gen2. However, in production environments, you can grant access to individual resources for workload-specific tasks like data lake file system support and operations. The reason is that, while in production, users only need to use resources like viewing the status of a scheduled Data Factory ingestion pipeline or reading data files in Data Lake Storage Gen2.

- **Don't grant unnecessary access at the subscription scope**: The subscription scope covers all resources within the subscription.

- **Opt for least-privilege access**: Select the right and only role for the job.

### Database access control best practices

Implementing effective role-based access control (RBAC) is crucial for maintaining security and manageability in your analytics environment. This section provides best practices for using Microsoft Entra groups, built-in roles, and avoiding direct user permissions to ensure a streamlined and secure access management process.

Cloud-scale analytics probably contain polyglot storage. Examples include PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics.

- **Use Microsoft Entra groups instead of individual user accounts**: We recommend that you use Microsoft Entra groups to secure database objects instead of individual Microsoft Entra user accounts. Use these Microsoft Entra groups to authenticate users and protect database objects. Similar to the data lake pattern, you could use your data application onboarding to create these groups.
- **Use built-in roles to manage access**: Create custom roles only if necessary to meet specific requirements or when built-in roles grant too many permissions.
- **Refrain from assigning permissions to individual users**: Use roles (database or server roles) consistently instead. Roles help greatly with reporting and troubleshooting permissions. (Azure RBAC only supports permission assignment via roles.)

> [!NOTE]
> Data applications can store sensitive data products in Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics pools. For more information, see [Sensitive data](./secure-data-privacy.md).

### Data Lake access control best practices

In modern data environments, ensuring secure and efficient access control is paramount. Azure Data Lake Storage (ADLS) Gen2 provides robust mechanisms to manage access through Access Control Lists (ACLs). This section outlines best practices for implementing role-based access control in ADLS Gen2, applying ACLs, Microsoft Entra security groups, and the principle of least privilege to maintain a secure and manageable data lake environment. Additionally, it highlights the importance of aligning ACLs with data partitioning schemes and using Unity Catalog for Azure Databricks users to ensure comprehensive security and governance.

- **Use Access Control Lists (ACLs) for fine-grained access control**: ACLs play an important role in defining access at a granular level. In Azure Data Lake Storage (ADLS) Gen2, ACLs work with security principals to manage fine-grained access to files and directories.
- **Apply ACLs at the file and folder level**: To control access to data in the data lake, we recommend using access control lists (ACLs) at the level of files and folders. Azure Data Lake also adopts a POSIX-like access control list model. POSIX (portable operating system interface) is a family of standards for operating systems. One standard defines a simple but powerful permission structure for accessing files and folders. POSIX is adopted widely for network file shares and Unix computers.
- **Use Microsoft Entra security groups as the assigned principal in an ACL entry**: Resist the opportunity to directly assign individual users or service principals. Using this structure allows you to add and remove users or service principals without the need to reapply ACLs to an entire directory structure. Instead, you can just add or remove users and service principals from the appropriate Microsoft Entra security group.
- **Assign access** to Microsoft Entra groups and manage membership of groups for ongoing access management. See [Access control and data lake configurations in Azure Data Lake Storage](best-practices/data-lake-access.md).
- **Apply the principle of least privilege to ACLs**: In most cases, users should have only **read** permission to the files and folders they need in the data lake. Data users shouldn't have access to the storage account container.
- **Align ACLs with data partitioning schemes**: ACLs and data partition design must align to ensure effective data access control. For more information, see [Data lake partitioning](../cloud-scale-analytics/architectures/data-standardization.md#data-lake-partitioning).
- **For Azure Databricks users, exclusively control access to data objects with Unity Catalog**: Granting direct storage-level access to external location storage in Azure Data Lake Storage Gen2 doesn't honor any permissions granted or audits maintained by Unity Catalog. Direct access bypasses auditing, lineage, and other security and monitoring features of Unity Catalog, including access control and permissions. Therefore, Azure Databricks end users shouldn't be given direct storage-level access to Unity Catalog managed tables and volumes.

## Next steps

[Provision security for cloud-scale analytics in Azure](./security-provisioning.md)