---
title: Authorization for Cloud-Scale Analytics in Azure
description: Learn about the best practices, including data management and role-based access control, for authorization in cloud-scale analytics environments in Azure.
author: mboswell
ms.author: mboswell
ms.date: 01/31/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Authorization for cloud-scale analytics in Azure

Authorization is the act of granting an authenticated party permission to perform an action. The key principle of *access control* is to give users only the amount of access that they need to do their jobs and to only allow certain actions at a particular scope. Role-based security corresponds to access control. Many organizations use role-based security to control access based on defined roles or job functions instead of individual users. Users are assigned one or more security roles, and each role is given authorized permissions to perform specific tasks.

Microsoft Entra ID is a centralized identity provider that grants authorization to access data services and storage for each user or for each application based on a Microsoft Entra identity.

## Data service authorization

Azure role-based access control (RBAC) and access-control lists (ACLs) play crucial roles in managing access and ensuring security. Azure RBAC and ACLs both require the user or application to have an identity in Microsoft Entra ID. In cloud-scale analytics, RBAC is effective for databases and Azure Data Lake Storage. ACLs are used primarily in Data Lake Storage to provide fine-grained access control at the file and directory levels. ACLs complement RBAC by providing more detailed permissions within the storage hierarchy.

Azure RBAC provides built-in roles like *Owner*, *Contributor*, and *Reader*, but you can also create custom roles for specific needs. The following built-in roles are fundamental for all Azure resource types, including Azure data services:

| Role | Description |
|---|---|
| **Owner** | This role has full access to the resource and can manage everything about the resource, including the right to grant access to it. |
| **Contributor** | This role can manage the resource but can't grant access to it. |
| **Reader** | This role can view the resource and information, except for sensitive information like access keys or secrets, about the resource. They can't make any changes to the resource. |

> [!NOTE]
> Some services have specific RBAC roles like *Storage Blob Data Contributor* or *Data Factory Contributor*, so you should use these roles for these services. RBAC is an additive model in which adding role assignments is an active permission. RBAC also supports *deny* assignments that take precedence over *role* assignments.

> [!TIP]
> When you plan an access control strategy, we recommend that you grant users only the amount of access that they need to perform their jobs. You should also only allow certain actions at a particular scope.

### Access control in Azure databases

RBAC in Azure databases revolves around roles, scopes, and permissions. Azure provides several built-in roles for database management. One of those roles is *SQL Server Contributor*, which enables the management of SQL servers and databases. Another role is *SQL DB Contributor*, which permits the management of SQL databases but not of the server itself. Additionally, you can create custom roles that have specific permissions to meet unique requirements.

You can assign roles at different scopes, including:

- At the subscription level, where roles apply to all resources within the subscription.
- At the resource group level, where roles apply to all resources within the specified resource group.
- At the resource level, where you can assign roles directly to individual databases or servers. This approach gives you precise control. 

Permissions define the actions that a role can perform, such as read, write, delete, or security settings management. These permissions are grouped into roles to simplify management.

In **Azure SQL Database**, you can assign roles to users, groups, or applications to control access. For example, a database administrator might be assigned the *SQL Server Contributor* role to manage the server and databases. Roles like *SQL DB Contributor* allow users to create, update, and delete databases, while the *SQL Security Manager* role focuses on security configurations.

In **Azure Cosmos DB**, you can assign roles to manage access to Azure Cosmos DB accounts, databases, and containers. Built-in roles like *Cosmos DB Account Reader* and *Cosmos DB Account Contributor* provide varying levels of access.

In **Azure Database for MySQL** and **Azure Database for PostgreSQL**, you can assign roles to manage database servers and individual databases. You can use roles like *Contributor* and *Reader* to control access.

For more information, see [Azure built-in roles for databases](/azure/role-based-access-control/built-in-roles/databases).

### Access control in Data Lake Storage

Azure RBAC lets you grant coarse-grained access, such as read or write access, to all storage account data. ACLs let you grant fine-grained access, such as write access to a specific directory or file.

In many scenarios, you can use RBAC and ACLs together to provide comprehensive access control in Data Lake Storage. You can use RBAC to manage high-level access to data, which helps ensure that only authorized users can access the service. Then you can apply ACLs within the storage account to control access to specific files and directories, which improves security.

Azure attribute-based access control builds on Azure RBAC by adding role assignment conditions based on attributes in the context of specific actions. It essentially allows you to refine RBAC role assignments by adding conditions. For example, you can grant read or write access to all data objects in a storage account that have a specific tag.

The following roles permit a security principal to access data in a storage account.

| Role | Description |
|---|---|
| **Storage Blob Data Owner** | This role gives full access to blob storage containers and data. This access permits the security principal to set the owner of an item and to modify the ACLs of all items. |
| **Storage Blob Data Contributor** | This role gives read, write, and delete access to blob storage containers and blobs. This access doesn't permit the security principal to set the ownership of an item, but it can modify the ACL of items that the security principal owns. |
| **Storage Blob Data Reader** | This role can read and list blob storage containers and blobs. |

Roles such as *Owner*, *Contributor*, *Reader*, and *Storage Account Contributor* permit a security principal to manage a storage account, but they don't provide access to the data within that account. However, these roles, excluding *Reader*, can obtain access to the storage keys, which can be used in various client tools to access the data. For more information, see [Access control model in Data Lake Storage](/azure/storage/blobs/data-lake-storage-access-control-model).

### Access control in Azure Databricks

Azure Databricks provides access control systems for managing access within the Azure Databricks environment. These systems focus on securable objects and data governance. The three main access control systems within Azure Databricks are:

- **ACLs**, which you can use to configure permission to access workspace objects such as notebooks. For more information, see [Access control overview](/azure/databricks/security/auth/access-control/).
- **Account RBAC**, which you can use to configure permission to use account-level objects such as service principals and groups.
- **Unity Catalog**, which you can use to secure and govern data objects.

In addition to access control on objects, Azure Databricks provides built-in roles on the platform. You can assign roles to users, service principals, and groups. For more information, see [Admin roles and workspace entitlements](/azure/databricks/security/auth/#admin-roles-and-workspace-entitlements).

## Best practices for authorization in cloud-scale analytics

This guide discusses the best practices for implementing RBAC in cloud-scale analytics environments. It includes general RBAC principles, database access control, and data lake access control best practices to help ensure secure and efficient resource management.

### General RBAC best practices for cloud-scale analytics

The following best practices can help you get started with RBAC:

- **Use RBAC roles for service management and operations, and use service-specific roles for data access and workload-specific tasks.** Use RBAC roles on Azure resources to grant permission to security principals that need to perform resource management and operations tasks. Security principals that need to access data within storage don't require an RBAC role on the resource because they don't need to manage it. Instead, grant permission directly to data objects. For example, grant read access to a folder in Data Lake Storage, or grant contained database user and table permissions on a database in SQL Database.

- **Use built-in RBAC roles.** First, use the built-in RBAC Azure resource roles to manage services and assign operations roles to control access. Create and use custom roles for Azure resources only when built-in roles don't meet your specific needs.

- **Use groups to manage access.** Assign access to Microsoft Entra groups and manage group memberships for ongoing access management.

- **Consider subscription and resource group scopes.** In nonproduction environments, grant access at the resource group scope to separate service management and operations access needs instead of granting access to individual resources. This approach makes sense because, in nonproduction environments, developers and testers need to manage resources. For example, they might need to create an Azure Data Factory ingestion pipeline or a container in Data Lake Storage. 

   However, in production environments, you can grant access to individual resources for workload-specific tasks like data lake file system support and operations. This approach makes sense in production environments because users only need to use resources like viewing the status of a scheduled Data Factory ingestion pipeline or reading data files in Data Lake Storage.

- **Don't grant unnecessary access at the subscription scope.** The subscription scope covers all resources within the subscription.

- **Opt for least-privilege access.** Select the right and only role for the job.

### Database access control best practices

Implementing effective RBAC is crucial for maintaining security and manageability in your analytics environment. This section provides best practices for using Microsoft Entra groups and built-in roles and for avoiding direct user permissions to help ensure a streamlined and secure access management process.

Cloud-scale analytics environments typically contain multiple types of storage solutions, including PostgreSQL, MySQL, SQL Database, and Azure SQL Managed Instance.

- **Use Microsoft Entra groups instead of individual user accounts.** We recommend that you use Microsoft Entra groups to secure database objects instead of individual Microsoft Entra user accounts. Use Microsoft Entra groups to authenticate users and protect database objects. Similar to the data lake pattern, you can use your data application onboarding to create these groups.

- **Use built-in roles to manage access.** Create custom roles only if you need to meet specific requirements or if built-in roles grant too many permissions.

- **Refrain from assigning permissions to individual users.** Use roles, like database or server roles, consistently instead. Roles help with reporting and troubleshooting permissions. Azure RBAC only supports permission assignment via roles.

### Data Lake Storage access control best practices

In modern data environments, secure and efficient access control is paramount. Data Lake Storage provides robust mechanisms to manage access through ACLs. This section outlines the best practices for implementing RBAC in Data Lake Storage and applying ACLs, Microsoft Entra security groups, and the principle of least privilege to maintain a more secure and manageable data lake environment. Additionally, it highlights the importance of aligning ACLs with data partitioning schemes and using Unity Catalog for Azure Databricks users to help ensure comprehensive security and governance.

- **Use ACLs for fine-grained access control.** ACLs play an important role in defining access at a granular level. In Data Lake Storage, ACLs work with security principals to manage fine-grained access to files and directories.

- **Apply ACLs at the file and folder levels.** To control access to data in the data lake, we recommend that you use ACLs at the level of files and folders. Data Lake Storage also adopts an ACL model that's similar to the Portable Operating System Interface (POSIX). POSIX is a group of standards for operating systems. One standard defines a simple but powerful permission structure for accessing files and folders. POSIX is widely used for network file shares and Unix computers.

- **Use Microsoft Entra security groups as the assigned principal in an ACL entry.** Instead of directly assigning individual users or service principals, use this approach to add and remove users or service principals without the need to reapply ACLs to an entire directory structure. You can just add or remove users and service principals from the appropriate Microsoft Entra security group.

- **Assign access to Microsoft Entra groups and manage membership of groups for ongoing access management.** For more information, see [Access control model in Data Lake Storage](/azure/storage/blobs/data-lake-storage-access-control-model).

- **Apply the principle of least privilege to ACLs.** In most cases, users should only have **read** permission to the files and folders that they need in the data lake. Data users shouldn't have access to the storage account container.

- **Align ACLs with data partitioning schemes.** ACLs and data partition design must align to help ensure effective data access control. For more information, see [Data lake partitioning](../cloud-scale-analytics/architectures/data-standardization.md#data-lake-partitioning).

- **For Azure Databricks users, exclusively control access to data objects with Unity Catalog.** Granting direct storage-level access to external location storage in Data Lake Storage doesn't honor any permissions granted or audits maintained by Unity Catalog. Direct access bypasses auditing, lineage, and other security and monitoring features of Unity Catalog, including access control and permissions. Therefore, you shouldn't give Azure Databricks users direct storage-level access to Unity Catalog managed tables and volumes.

## Next step

[Secure cloud-scale analytics in Azure](./secure.md)