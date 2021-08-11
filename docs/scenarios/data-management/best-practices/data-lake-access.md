---
title: Access control in Azure Data Lake Storage
description: Learn about access control and data lake configurations in Azure Data Lake Storage Gen2. This article describes using role-based access control and access control lists.
author: mboswell
ms.author: mboswell
ms.date: 08/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Access control and data lake configurations in Azure Data Lake Storage

Use this article is to help assess and understand the access control mechanisms in Azure Data Lake Storage Gen2. These mechanisms include role-based access control (Azure RBAC) and access control lists (ACLs). This article addresses the following issues:

- How access is evaluated between Azure RBAC and access control lists (ACLs)
- How to configure access control using either or both of these mechanisms
- How to apply these access control mechanisms to data lake implementation patterns

You need a basic knowledge of storage containers, security groups, Azure RBAC, and ACLs. To frame the discussion, we reference a generic data lake structure of raw, enriched, and curated zones.

## Using the built-in Azure RBAC roles

Azure Storage has two layers of access: service management and data. Subscriptions and storage accounts are accessed through the service management layer. Containers, blobs, and other data resources are accessed through the data layer. For example, if you want a list of storage accounts from Azure, send a request to the management endpoint. If you want a list of file systems, folders, or files in a storage account, send a request to a service endpoint.

Roles can contain permissions for management or data layer access. The Reader role grants read-only access to management layer resources but not read access to data.

Roles such as owner, contributor, reader, and Storage Account Contributor permit a security principal to manage a storage account. They don't provide access to the data in that account. Only roles explicitly defined for data access permit a security principal to access data. These roles, except for reader, can obtain access to the storage keys to access data.

### Built-in management roles

The following are the built-in management roles.

- [Owner](/azure/role-based-access-control/built-in-roles#owner): Manage everything, including access to resources. This role provides key access.
- [Contributor](/azure/role-based-access-control/built-in-roles#contributor): Manage everything, except access to resources. This role provides key access.
- [Storage Account Contributor](/azure/role-based-access-control/built-in-roles#storage-account-contributor): Full management of storage accounts. This role provides key access.
- [Reader](/azure/role-based-access-control/built-in-roles#reader): Read and list resources. This role doesn't provide key access.

### Built-in data roles

The following are the built-in data roles.

- [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner): Full access to Azure Storage blob containers and data, including setting of ownership and managing POSIX access control.
- [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor): Read, write, and delete Azure Storage containers and blobs.
- [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader): Read and list Azure Storage containers and blobs.

Storage Blob Data Owner is a super-user and is granted full access to all mutating operations. These operations include setting the owner of a directory or file and ACLs for directories and files for which they aren't the owner. Super-user access is the only authorized manner to change the owner of a resource.

> [!NOTE]
> Azure RBAC assignments can take up to five minutes to propagate and take effect.

## How access is evaluated

During security principal-based authorization, permissions are evaluated in the following order. See the following diagram for more detail.

- Azure RBAC is evaluated first and takes priority over any ACL assignments.
- If the operation is fully authorized based on RBAC, ACLs aren't evaluated at all.
- If the operation isn't fully authorized, ACLs are evaluated.

For more information, see [How permissions are evaluated](/azure/storage/blobs/data-lake-storage-access-control-model#how-permissions-are-evaluated).

> [!NOTE]
> This permission model applies to Azure Data Lake Storage only. It doesn't apply to general purpose, or blob, storage without hierarchical namespace enabled.
> This description excludes shared key and SAS authentication methods. It also excludes scenarios in which the security principal has been assigned the Storage Blob Data Owner built-in role, which provides super-user access.
> We recommend you set `allowSharedKeyAccess` to false so that access can be audited by identity.

:::image type="content" source="../images/how-access-evaluated.png" alt-text="This diagram provides a flow chart that describes how access is evaluated." lightbox="../images/how-access-evaluated.png":::

For more information about what ACL-based permissions are required for a given operation, see [Access control lists in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control#common-scenarios-related-to-permissions).

> [!NOTE]
>
> - Access control lists apply only to security principals in the same tenant, including guest users.
> - Any user with permissions to attach to a cluster can create Azure Databricks mount points. The mount point is configured using service principal credentials or the Azure AD passthrough option. At the time of creation, permissions are not evaluated. Permissions are evaluated when an operation uses the mount point. Any user who can attach to a cluster can attempt to use the mount point.
> - When creating a table definition in Azure Databricks or Azure Synapse Analytics, the user needs to have read access to the underlying data.

## Configuring access to Azure Data Lake Storage

Implement access control in Azure Data Lake Storage using Azure RBAC, ACLs, or a combination of both.

### Configure access using Azure RBAC only

If container-level access control is sufficient, Azure RBAC assignments offer a simple management approach to securing data. Access control lists are recommended for a large number of restricted data assets or where granular access control is required.

### Configure access using ACLs only

We recommend the access control lists configuration for enterprise-scale for analytics and AI.

We recommend that you assign access control entries to a security group rather than an individual user or service principal. For more information, see [Use security groups versus individual users](/azure/storage/blobs/data-lake-storage-best-practices#use-security-groups-versus-individual-users). When adding or removing users from the group, no updates to Data Lake Storage are required. Using groups also reduces the chance of exceeding the 32 access control entries per file or folder ACL. After the four default entries, there are only 28 remaining for permission assignments.

Even using groups, you may have many access control entries at top levels of the directory tree. This situation can happen when granular permissions for different groups are required.

![Diagram shows several security groups requiring access to three datasets.](../images/flat-groups-issue.png)

### Configure access using both Azure RBAC and access control lists

The Storage Blob Data Contributor/Reader permission provides access to the data and not the storage account. It can be granted at the storage account level or container level. If Storage Blob Data Contributor is assigned, ACLs cannot be used to manage access. Where Storage Blob Data Reader is assigned, elevated write permissions can be granted using ACLs. For more information, see [How access is evaluated](#how-access-is-evaluated).

This approach favors scenarios where most users need read access but only a few users need write access. The data lake zones could be different storage accounts and data assets could be different containers. The data lake zones could be represented by containers and data assets represented by folders.

## Nested access control list group approaches

There are two approaches for nested ACL groups.

### Option 1: the parent execute group

Before you create files and folders, begin with a parent group. Assign that group run permissions to both default and access ACLs at the container level. Then add the groups that require data access to the parent group.

This technique called nesting groups. The member group inherits the permissions of the parent group, which provides global run permissions to all member groups. The member group doesn't need run permissions because these permissions are inherited. More nesting may provide greater flexibility and agility. Add security groups that represent teams or automated jobs to the data access reader and writer groups.

![Diagram shows nested groups, where global execute includes data assets for readers and writers, which includes analysis team and engineering jobs respectively.](../images/nested-groups.png)

### Option 2: the access control list other entry

The recommended approach is to use the ACL other entry set at the container or root. Specify defaults and access ACLs as shown in the following screen. This approach ensures that every part of the path from root to lowest level has run permissions.

![Screen capture shows the manage access dialog box with other highlighted and access and default selected.](../images/acl-other-root.png)

This run permission propagates down any added child folders. The permission propagates to the depth where the intended access group needs permissions to read and run. This level is in the lowest part of the chain, as shown image below. This approach grants group access to read the data. The approach works similarly for write access.

![Screen capture shows the manage access dialog box with businessgrp 1 highlighted and access and default selected.](../images/acl-other-lowest.png)

## Recommended data lake zones security

These usages are the recommended security patterns for each of the data lake zones:

- Raw should allow access to data only by using security principal names (SPNs).
- Enriched should allow access to data only by using security principal names (SPNs).
- Curated should allow access with both security principal names (SPNs) and user principal names (UPNs).

![Diagram summarizes the zone security patterns.](../images/adls-security-zones.png)

### Example scenario for using Azure AD security groups

There are many different ways to set up groups. For example, imagine that you have a directory named `/LogData` that holds log data that is generated by your server. Azure Data Factory ingests data into that folder. Specific users from the service engineering team upload logs and manage other users of this folder. The Azure Databricks analytics and data science workspace clusters could analyze logs from that folder.

To enable these activities, create a `LogsWriter` group and a `LogsReader` group. Assign the following permissions:

- Add the `LogsWriter` group to the ACL of the `/LogData` directory with `rwx` permissions.
- Add the `LogsReader` group to the ACL of the `/LogData` directory with `r-x` permissions.
- Add the service principal object or managed service identity (MSI) for Data Factory to the `LogsWriters` group.
- Add users in the service engineering team to the `LogsWriter` group.
- Azure Databricks would be configured for Azure AD passthrough to the Azure Data Lake store.

If a user in the service engineering team transfers to a different team, just remove that users from the `LogsWriter` group.

If you didn't add that user to a group, but instead, added a dedicated ACL entry for that user, you will need to remove that ACL entry from the `/LogData` directory. You will also need to remove the entry from all subdirectories and files in the entire directory hierarchy of the `/LogData` directory.

### Summary of Azure Data Lake access

No single approach to managing data lake access suits everyone. A major benefit of a data lake is to provide friction-free access to data. In practice, different organizations want different levels of governance and control over their data. Some organizations have a centralized team to manage access and provision groups under rigorous internal controls. Other organizations are more agile and have decentralized control. Choose the approach that meets your level of governance. Your choice shouldn't result in undue delays or friction in gaining access to data.

## Azure Synapse Analytics data access control

To deploy an Azure Synapse workspace, a Data Lake Storage Gen 2 account is required. Azure Synapse Analytics uses the primary storage account for several integration scenarios and stores data in a container. The container includes Apache Spark tables and application logs under a folder called **/synapse/{workspacename}**. The workspace also uses container for managing libraries that you choose to install.

During the workspace deployment through the [Azure portal](/azure/azure-portal/), provide an existing storage account or create a new one. The provided storage account is the primary storage account for the workspace. The deployment process grants the workspace identity access to the specified Data Lake Storage Gen2 account, using the **Storage Blob Data Contributor** role.

If you deploy the workspace outside of the Azure portal, add Azure Synapse Analytics workspace identity to the **Storage Blob Data Contributor** role manually. We recommend you assign the role **Storage Blob Data Contributor** on the container level to follow the least privilege principle.  

When running pipelines, workflows, and notebooks through jobs, the workspace identity permission context is used. If any of the jobs read or write to the workspace primary storage, the workspace identity uses the read/write permissions granted through the **Storage Blog Data Contributor**.

When users sign in to the workspace to run scripts or for development, the user's context permissions are used to allow read/write access on the primary storage.

### Azure Synapse Analytics fine-grained data access control using access control lists

When setting-up data lake access control, some organizations require granular level access. They may have sensitive data that cannot be seen by some groups in the organization. Azure RBAC allows read or write at the storage account and container level only. With ACLs, you can set up fine-grained access control at the folder and file level to allow read/write on subset of data for specific groups.

#### Considerations when using Spark tables

When you use Apache Spark tables in Spark pool, a warehouse folder is created. It's in the root of the container in the workspace primary storage:

```output
synapse/workspaces/{workspacename}/warehouse
```

If you plan to create Apache Spark tables in Azure Synapse Spark pool, grant write permission on the **warehouse** folder for the group running the command that creates the Spark table. If the command runs through triggered job in a pipeline, grant write permission to the workspace MSI.

This example creates a Spark table:

```python
df.write.saveAsTable("table01")
```

For more information, see [How to set up access control for your synapse workspace](/azure/synapse-analytics/security/how-to-set-up-access-control).

## Next steps

[Azure Databricks implementation](./azure-databricks-implementation.md)
