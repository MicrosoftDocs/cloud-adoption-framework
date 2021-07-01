---
title: Azure Enterprise Scale Analytics and AI Teams Data Lake Access
description: Understanding access control and data lake configurations in ADLS Gen2
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 06/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Understanding access control and data lake configurations in ADLS Gen2

Whilst the end goal of this article is to help the reader assess and understand the access control mechanisms in Azure Data Lake Storage (ADLS) Gen2, namely RBAC and ACLs, they will also learn.

- How access is evaluated between these two mechanisms
- How to configure access control using RBAC or ACLs or both
- How these access control mechanisms can be applied to different data lake implementation patterns and the associated design considerations

The topics covered assume a basic knowledge of storage containers, security groups, RBAC and ACLs. To frame the discussion a generic data lake structure of raw, cleansed and curated layers is referenced. This is one of many possible approaches but not necessarily the correct structure for your organisation. Additionally, the examples use an over simplified representation of folder structures to illustrate the point but is not necessarily a reflection of reality. When a path such as:-

```text
/raw/data_asset
```

is referenced, in reality this may be a more complex structure with "self-documenting" metadata embedded in the path that lead to the files, e.g.:

```text
/datalake/raw/internal/datasource/entity/YYYY/MM/DD/*
```

For further ideas on data lake structure and design there are a number of online resources such as this [TechNet article](https://cloudblogs.microsoft.com/industry-blog/en-gb/technetuk/2020/04/09/building-your-data-lake-on-azure-data-lake-storage-gen2-part-1/).

To guide the reader through the process of creating a data lake and configuring access control, step-by-step portal instructions have been provided, along with sample code to support "LakeOps". All code samples are written in Python and use the Azure APIs instead of the associated SDK. The reason is twofold: a.) it can be adapted to any other programming language or utility (such as cUrl or Postman) which supports REST APIs and b.) SDK availability or operation support at the time of writing. The code is provided "as is" and can be run locally if Python 3.6 is installed, or using various options in Azure such as Azure Notebooks, Azure Databricks or even Azure DevOps. If you are new to the Azure REST APIs, please refer to the following [documentation](/rest/api/azure/) to help you get started.

>[!NOTE]
>Creating security groups requires necessary permissions to your Azure Active Directory (AAD) tenant or the Microsoft Graph API. In some organizations this level of access can be difficult to obtain, therefore to follow the steps in this article it may be easier to use a [free account](https://azure.microsoft.com/free/), or personal account with a [Visual Studio subscription](/visualstudio/subscriptions/vs-azure) or ask your Azure Administrator to create a new AAD tenant and [add a subscription](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory) to the new directory.

## Understanding the built-in RBAC roles

Azure Storage has two layers of access: service management and data. Subscriptions and storage accounts are accessed through the management layer. Containers, blobs, and other data resources are accessed through the data layer. For example, if you want to get a list of your storage accounts from Azure, you send a request to the management endpoint. If you want a list of file systems (containers), folders or files in a storage account, you send a request to the appropriate service endpoint.

RBAC roles can contain permissions for management or data layer access. The Reader role, for example, grants read-only access to management layer resources but not read access to any of the data.

Roles such as Owner, Contributor, Reader and Storage Account Contributor permit a security principal to manage a storage account, but do not provide access to the data within that account. Only roles explicitly defined for data access permit a security principal to access data,  however, the aforementioned roles (excluding Reader) can obtain access to the storage keys which can be used in various client tools to access the data.

### Built-in Management Roles

- [Owner](/azure/role-based-access-control/built-in-roles#owner):Manage everything, including access to resources. This role will give you key access.
- [Contributor](/azure/role-based-access-control/built-in-roles#contributor): Manage everything, excluding access to resources. This role will give you key access.
- [Storage Account Contributor](/azure/role-based-access-control/built-in-roles#storage-account-contributor): Full management of storage accounts. **Note**: this role will give you key access.
- [Reader](/azure/role-based-access-control/built-in-roles#reader): Read and list resources. This role does not permit key access.

### Built-in Data Roles

- [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner): Full access to Azure Storage blob containers and data including setting of ownership and managing POSIX access control (ACLs)
- [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor): Read, write, and delete Azure Storage containers and blobs.
= [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader):  Read and list Azure Storage containers and blobs.

Storage Blob Data Owner is considered a super-user and is granted full access to all mutating operations, including setting the owner of a directory or file as well as ACLs for directories and files for which they are not the owner. Super-user access is the only authorized manner to change the owner of a resource.

>[!NOTE]
> RBAC assignments can take up to 5 minutes to propagate and take effect.

## How access is evaluated in ADLS

During security principal-based authorization, permissions will be evaluated in the following order as depicted in the diagram below and described in [the documentation](/azure/storage/blobs/data-lake-storage-access-control-model#how-permissions-are-evaluated):

- RBAC is evaluated first and takes priority over any ACL assignments.
- If the operation is fully authorized based on RBAC then ACLs are not evaluated at all.
- If the operation is not fully authorized then ACLs are evaluated.

>[!NOTE]
>The above permission model applies to ADLS only and not general purpose (blob) storage without HNS enabled which does not support ACLs.
>This description excludes [Shared Key and SAS authentication](/azure/storage/blobs/data-lake-storage-access-control) methods in which no identity is associated with the operation and assumes that the storage account is accessible via appropriate networking configuration. It also excludes scenarios in which the security principal has been assigned the Storage Blob Data Owner built-in role which provides *super-user* access.
>It is recommended to set `allowSharedKeyAccess` to false so that access can be audited by the identity.

:::image type="content" source="./images/how-access-evaluated.png" alt-text="How Access Is Evaluated" lightbox="./images/how-access-evaluated.png":::

See [here](/azure/storage/blobs/data-lake-storage-access-control#common-scenarios-related-to-permissions) for another example of what ACL based permissions are required for a given operation.

>[!NOTE]
>
> - ACLs apply only to security principals in the same tenant, including guest users.
> - Azure Databricks mount points can be created by any user with permissions to attach to a cluster. The mount point will be configured using service principal credentials or the AAD passthrough option, but at the time of creation permissions are not evaluated. Only when an operation is performed using the mount point will permissions be evaluated and any user who can attach to a cluster can attempt to use the mount point. Securing access to ADLS from Azure Databricks is covered in more detail [here](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks).
> - When creating a table definition in Databricks or Synapse, the user issuing the DDL needs to have read access to the underlying data.

## Configuring access to ADLS and Data Lake Storage Configurations

There are three possible approaches to implement access control in ADLS using RBAC or ACLs or a combination of both.

### Configure access using RBAC only

If container level access control is sufficient then RBAC assignments may offer a simpler management approach to securing data however be aware that role assignments are limited to 2000 per subscription therefore ACLs are recommended for a large number of restricted data assets or where more granular access control is required.

### Configure access using ACLs only (Recommended for Enterprise Scale Analytics and AI)

As per the [ADLS best practices](/azure/storage/blobs/data-lake-storage-best-practices#use-security-groups-versus-individual-users) it is recommended to assign access control entries to a security group rather than an individual user or service principal. When adding or removing users from the group no updates to ADLS are required and using groups also reduces the chance of exceeding the 32 access control entries per file or folder ACL. After the 4 default entries that leaves only 28 remaining for permission assignments.

However, even when using groups, a proliferation of access control entries may occur at top levels of the directory tree, particularly when very granular permissions with many different groups are required. In order for each group to obtain read access to the files contained in their folder, they will need execute permissions from root, which is the container level, all the way down to the folder they are trying to access. It is likely that the 32 access control entry limit will be reached in the root or levels close to root. An example of this scenario is depicted below:

![flat groups issue](./images/flat-groups-issue.png)

### Configure access using both RBAC and ACLs

Storage Blob Data Contributor/Reader only provides access to the data and not the storage account. It can be granted at the storage account or container level. When Storage Blob Data Contributor is assigned, ACLs __cannot__ be used to manage access. Where Storage Blob Data Reader is assigned, elevated write permissions can be granted using ACLs. Refer to the section above on [how access is evaluated in ADLS](#how-access-is-evaluated-in-adls).

This approach favours scenarios where most users need read access to but only a few need write access. The data lake zones could be different storage accounts and data assets could be different containers, or the data lake zones could be represented by containers and data assets represented by folders.

## Nested ACL Group Approaches

There are two possible solutions to this outlined below but the recommended approach is to make use of nested groups.

### Option 1: The Parent Execute Group

Where possible before files and folders are created, begin with a parent group which is assigned execute permissions to both default and access ACLs at the container level. Then add the groups requiring data access to the parent group. This technique is known as nesting groups, and from an ADLS authorization perspective, the member group inherits the permissions of the parent group, providing "global" execute permissions to all member groups. The member group in this case will not need execute permissions as these permissions will be inherited because it belongs to the parent group.  Additional nesting may provide greater flexibility and agility if the security groups that represent teams or automated jobs are added to the data access reader and writer groups.

![Nested Groups](./images/nested-groups.png)

### Option 2: The Other ACL entry (Recommended)

Another way to ensure that every part of the path from root to lowest level has execute permissions (--x) is to use the "Other" ACL entry set at the container/root, with defaults and access ACLs applied as shown in the first diagram below. This execute permission propagates down any subsequently added child folders until the depth/folder where the intended access group should have Read and Execute permissions (in the lowest part of the chain as depicted in the second image), which will grant that group access to read the data appropriately. This approach works similarly for write access.

![root_acl](./images/acl-other-root.png)

![folder_acl](./images/acl-other-lowest.png)

## Recommended Data Lake Zones Security

![Data Lake Zones Security](./images/adls-security-zones.png)

The recommended security pattern for each of the of the Data Lake Zones is:

- RAW should only allow access to data via SPNs
- Enriched should only allow access to data via SPNs
- Curated should allow access with both SPNs and UPNs.

## Summary of Data Lake Access

There is no single approach to managing data lake access that will suit everyone. One of the major benefits of a data lake is to democratize and provide friction-free access to data however in reality different organizations will have different levels of governance and control over their data. Some have a centralized team which manages access and the provisioning of AAD groups with rigorous internal controls. Some are more agile and have decentralized control. The approach chosen should meet the required level of governance but should not result in undue delays or friction in gaining access to data, otherwise the value of the data lake may be diminished, or even worse may result in silos, the very thing data lakes are designed to prevent.

![Data Lake Zones Security](./images/adls-security-zones.png)

The recommended security pattern for each of the of the Data Lake Zones is:

- RAW should only allow access to data via SPNs
- Enriched should only allow access to data via SPNs and UPNs
- Curated should allow access with both SPNs and UPNs.

### Example Scenario for using Azure AD Security Groups with *confidential or below* dataset

There are many different ways to set up groups. For example, imagine that you have a directory named **/LogData** which holds log data that is generated by your server. Azure Data Factory (ADF) ingests data into that folder. Specific users from the service engineering team will upload logs and manage other users of this folder, and the **Azure Databricks Analytics and Data Science Workspace** clusters could analyze logs from that folder.

To enable these activities, Integration Ops could create a `LogsWriter` group and a `LogsReader` group. You could then assign permissions as follows:

- Add the `LogsWriter` group to the ACL of the **/LogData** directory with `rwx` permissions.
- Add the `LogsReader` group to the ACL of the **/LogData** directory with `r-x` permissions.
- Add the service principal object or Managed Service Identity (MSI) for ADF to the `LogsWriters` group.
- Add users in the service engineering team to the `LogsWriter` group.
- Databricks would be configured for Azure AD Passthrough to the Azure Data Lake Store.

If a user in the service engineering team transfers to a different team, you could just remove them from the `LogsWriter` group. If you did not add that user to a group, but instead, you added a dedicated ACL entry for that user, you would have to remove that ACL entry from the **/LogData** directory. You would also have to remove the entry from all subdirectories and files in the entire directory hierarchy of the **/LogData** directory.

## Databases Authentication and Permissions

Other polyglot storage such as PostgreSQL, MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics are likely to be used in the Enterprise Scale Analytic construction set. They could be used by Data Integrations to store their Read Data Stores or by Data Products.

- [Use Azure Active Directory for authentication with PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Azure Active Directory authentication with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics](/azure/azure-sql/database/authentication-aad-overview)
- [Use Azure Active Directory for authenticating with MySQL](/azure/mysql/concepts-azure-ad-authentication)

It is recommended that Azure AD groups are used to secure database objects instead of individual Azure AD user accounts. These AD Azure Groups would be used to authenticate users and protects database objects. Similar to the data lake pattern, you could use your Data Integration or Data Products onboarding to create these groups within you Azure AD service.

>[!NOTE]
>Storing data inside an Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics Pools are one of the options for Data Integrations and Data Products to store [*sensitive (PII)* Data](data-privacy.md#sensitive-data).

## Azure Synapse Analytics Data Access Control in ADLS 2

When deploying an Azure Synapse workspace, a Data Lake Storage Gen 2 account is required from the subscription.
Azure Synapse Analytics leverages the primary storage account for several integration scenarios and stores data in a container, that includes Apache Spark tables, spark application logs under a folder called /synapse/{workspacename}. It also uses container for managing libraries that you choose to install.

During the Synapse workspace deployment through [Azure Portal](/features/azure-portal/), you have the option to either provide an existing storage account or create a new one. The provided storage account will be set as the **primary storage account** for the Synapse workspace.

For any of the two options selected, the deployment process automatically grants the Synapse workspace identity access to the specified Data Lake Storage Gen2 account, using the **Storage Blob Data Contributor** role.

If the deployment of Synapse workspace happens outside of the Azure Portal, you will have to add Synapse workspace identity to the **Storage Blob Data Contributor** role manually later. It is recommended to assign the role **Storage Blob Data Contributor** on the container level to follow the least privilege principle.  

When executing Pipelines, workflows, and notebooks through jobs, the Synapse workspace identity permission context is used . If any of the jobs read and/or write to the workspace primary storage, the workspace identity will use the read/write permissions granted through the **Storage Blog Data Contributor**.

 When users log into the Synapse workspace to execute scripts or for development, the user's context permissions are used to allow read/write access on the primary storage.

### Azure Synapse Analytics fine-grained data access control using ACLs

When setting-up Data Lake access control, some organizations require granular level access due to sensitive data stored that cannot be seen by some groups in the organization. Azure RBAC allows read and/or write at the storage account and container level only. With ACLs you can setup fine-grained access control at the folder and file level to allow read/write on subset of data for specific groups.

>[!NOTE]
>
> - Assigning Azure RBAC **Reader** role to groups in the Synapse workspace primary storage account is required to be able to list the storage account and containers when using Data Hub in Synapse Studio. When using Data Hub in Synapse Studio, users can browse folders and files before they start writing a query or spark code. Users also have some options available in Synapse Studio to help getting started with queries and reading the data using spark from a  file. These options include Select Top 100 rows, Create External Table, Load to a Dataframe, and create New Spark Table.

Refer to the [Assign Azure roles using the Azure portal - Azure RBAC | Microsoft Docs](/azure/role-based-access-control/role-assignments-portal) for detailed instructions on how assign Reader role on the storage account.

#### Granting Read Access on Azure Data Lake Storage Gen 2 using ACLs

The first step on this process, you will need to grant the appropriate ACL permissions at the **container level** in the Storage account for the required groups. To configure Azure Synapse Analytics data access control with ACLs, please refer to [Configure access using ACLs only (Recommended for Enterprise Scale Analytics and AI)](#configure-access-using-acls-only-recommended-for-enterprise-scale-analytics-and-ai)

#### Considerations when using Spark Tables in Synapse Spark Pool

When you use Spark Tables in Synapse Spark Pool, the following folder structure will be created automatically by Synapse workspace in the root of the container in the workspace primary storage.  

"synapse/workspaces/{workspacename}/**warehouse**"

If you plan to create spark tables in Synapse Spark Pool. It is required that you grant write permission on the **warehouse** folder for the group executing the command that creates the Spark Table. If the command is executed through triggered job in a pipeline, you will need to grant write permission to the Synapse workspace MSI.

Create Spark Table example

```python
df.write.saveAsTable("<tablename>")
```

## References

[How to set up access control for your Synapse workspace - Azure Synapse Analytics | Microsoft Docs](/azure/synapse-analytics/security/how-to-set-up-access-control?WT.mc_id=Portal-Microsoft_Azure_Synapse)
