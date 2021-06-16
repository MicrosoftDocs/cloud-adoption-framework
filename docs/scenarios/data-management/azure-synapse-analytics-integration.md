---
title: Azure Enterprise Scale Analytics and AI Azure Synapse Pattern
description: Enterprise Scale Analytics and AI Azure Synapse Pattern
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Synapse Analytics Integration

Azure Synapse Analytics is the provisioned, integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse Analytics brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, and pipelines for data integration and ETL/ELT. Synapse Studio provides a unified experience for management, monitoring, coding, and security. Synapse has deep integration with other Azure services such as Power BI, Cosmos DB, and Azure Machine Learning.

> [!NOTE]
> This section aims to describe prescribed configurations which are specific to the Enterprise Scale Analytic and AI solution pattern. It is a compliment to the official [Azure Synapse Analytics Documentation](/azure/synapse-analytics/).

## Overview

During the initial setup of a [Data Landing Zone](data-landing-zone.md), a single Azure Synapse Analytics workspace may be deployed for use by all analysts and data scientists. Additional workspaces can be optionally created for specific Data Integrations or Data Products.

SQL Pools, formerly SQL DW, can be used as the data store for both enriched and curated data, which can serve for feature datasets needed by data science teams and for the datasets required for the analytical requirements. Azure Databricks can connect to these SQL Pools and update the data which resides inside the SQL Pools.

SQL On-Demand is a serverless query service that will be used by the data scientists and engineers to run queries against files in the storage accounts.

>[!TIP]
>Additional Azure Synapse Analytics workspaces may be needed if the Data Integration needs to provide access to the golden source with row- and column-level security, which can be provided by Azure Synapse Pools. Data Products teams might require their own workspace for creating Data Products and a separate workspace that allow only the product teams scoped development access.

## Azure Synapse Analytics Setup

The first step in the deployment Azure Synapse Analytics is to set up an Azure Synapse workspace.

As an Azure Data Lake Gen 2 storage account is required and is used as primary storage to store Spark metadata, we recommend using the Enriched and Curated ADLS storage account created in the Data Landing Zone.

For premium big data processing and data science capabilities, we recommend Azure Databricks.

### Azure Synapse Analytics Networking

A Data Landing Zone will create workspaces with a [Azure Synapse Analytics Managed Virtual Network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet). Communication with Synapse will be through the three endpoints it exposes: SQL Pool, SQL On-Demand, and the Development Endpoint.

At the network level, the Enterprise Scale Analytics and AI solution pattern uses [Synapse Managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) to ensure all the traffic between Data Landing Zone vNet and Azure Synapse Workspace(s) traverses entirely over the Microsoft backbone network.

### Azure Synapse Data Access Control

[Azure AD pass-through in Azure Synapse Analytics](/azure/synapse-analytics/sql/active-directory-authentication#azure-ad-pass-through-in-azure-synapse-analytics) should use Access Control Lists to manage the access to the files in the data lake.

At the database level, in addition to the database roles, we recommend Row-Level Security (RLS) and Column-Level Security to restrict the data access on the tables in Synapse SQL Pool using security policy.

For example, RLS is a great way to ensure users in a specific Data Integration or Data Product see only their own data even if the table contains data for all the enterprise.

By combining RLS with Column-Level Security (CLS) to restrict access to columns with sensitive data, both RLS and CLS apply the access restriction logic at the database tier rather than the application tier. The permission is evaluated every time the data access is attempted from any tier.

>[!TIP]
>We highly recommend that features such as Azure Defender for SQL, Data Classification, Data Encryption, and Dynamic Data Masking are available for SQL Pool to support the data protection and limit sensitive data exposure.

### Azure Synapse Data Access Control in Azure Data Lake Gen2

When deploying an Azure Synapse workspace, a Data Lake Storage Gen 2 account is required from the subscription or manually using the storage account URL. The specified storage account will be set as **primary** for the deployed Azure Synapse workspace to store its data. Azure Synapse stores data in a container, that includes Apache Spark tables, spark application logs under a folder called `/synapse/{workspacename}`. It also uses container for managing libraries that you choose to install.

During the Synapse workspace deployment through [Azure Portal](https://azure.microsoft.com/en-us/features/azure-portal/) you have the option to either provide an existing storage account or create a new one. The provided storage account will be set as the **primary storage account** for the Synapse workspace. For any of the two options selected, the deployment process automatically grants the Synapse workspace identity data access to the specified Data Lake Storage Gen2 account, using the **Storage Blob Data Contributor** role. If the deployment of Synapse workspace happens outside of the Azure Portal, you will have to add Synapse workspace identity to the **Storage Blob Data Contributor** role manually later. It is recommended to assign the role **Storage Blob Data Contributor** on the file system level to follow the least privilege principle. 

It is also possible to manually specify the storage account URL. However, in this case, you will need to contact the storage account owner, and ask them to grant the workspace identity access manually using the **Storage Blob Data Contributor.**

The Synapse workspace identity permission context is used when executing Pipelines, workflows, and notebooks through jobs. If any of the jobs read and/or write to the workspace primary storage, the workspace identity will use the read/write permissions granted through the **Storage Blog Data Contributor**.

**Storage Blob Data Contributor** role is used to grant read/write/delete permissions to Blob storage resources such as folder and files.

**Storage Account permissions are required when using Synapse workspace interactively and for development.** To allow read and write access to other users or groups on the primary storage account after it has been deployed, it will require you to grant access permissions using the **Storage Blob Data Contributor role** or **Access Control Lists** directly to the user or groups. When users log into the Synapse workspace to execute scripts or for development, the user's context permissions are used to allow read/write access on the primary storage.

#### Fine-grained data access control using Access Control Lists

When setting-up Data Lake access control, some organizations require granular level access due to sensitive data stored that cannot be seen by some users or groups. Using Azure RBAC, it is only possible to give read and/or write at the container level. For example, assigning a user or group to Storage Blob Data Contributor role will allow read/write access to all folders in that container. With ACLs you can setup fine-grained access control at the folder and file level to allow read/write on the data that users or groups need access.

Before you start implementing fined-grained access with ACLs, is important to understand how ACLs permissions are evaluated.

1. Azure Role assignments are evaluated first and take priority over any ACL assignments.
2. If the operation is fully authorized based on Azure role assignment, then ACLs are not evaluated at all.
3. If the operation is not fully authorized, then ACLs are evaluated.

<!-- increase image size -->
:::image type="content" source="./images/rbac-acls-evaluation.png" alt-text="RBAC ACLs Evaluation" lightbox="./images/rbac-acls-evaluation.png":::

Please refer to the [Access control model for Azure Data Lake Storage Gen2 | Microsoft Docs](/azure/storage/blobs/data-lake-storage-access-control-model#how-permissions-are-evaluated) for more information.

To setup ACLs in Data Lake Storage Gen 2, you can use one of the following methods:  

- **Azure CLI**  
    - For detailed instructions on how to use **Azure CLI** to grant ACLs permissions in ADLS Gen2 refer to [Use Azure CLI to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-cli)

- **PowerShell**  
    - For detailed instructions on how to use **PowerShell** to grant ACLs permissions in ADLS Gen2 refer to [Use PowerShell to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-powershell)

- **Azure Storage Explorer**  
    - For details instructions on how to use and install, refer to [Get started with Storage Explorer | Microsoft Docs.](/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows)

> [!TIP]
> Consider using **Azure CLI** or **PowerShell** for automation to achieve better scalability when a large amount of folders and files are expected in the ACLs setup process.
> 
#### Granting Azure RBAC Reader on the Storage Account

Assigning Azure RBAC Reader role to users or groups in the Synapse workspace primary storage account is required for them to be able to list the storage account and containers when using Data Hub in Synapse Studio.

Using Data Hub in Synapse Studio, users can browse folders and files before they start writing a query or spark code. Users also have some options available in Synapse Studio to help getting started with queries and reading the data from spark from a specific file. These options include Select Top 100 rows, Create External Table, Load to a Dataframe, New Spark Table.

Refer to the [Assign Azure roles using the Azure portal - Azure RBAC | Microsoft Docs](/azure/role-based-access-control/role-assignments-portal) for detailed instructions on how assign Reader role on the storage account.

#### Granting Read Access on Azure Data Lake Storage Gen 2 using ACLs

The first step on this process, you will need to grant the appropriate ACL permissions for users or groups at the **container level** in the Storage account. There are situations where a user or group cannot read the folders or files in the container root. However, they can be granted read/write permissions in child folders of the root. In this case, It will be still required the users or groups to have *execute* permissions on the parent folders, including the root, to traverse these folders which the identity does not have read/write access.

Please go through the following steps to get started.

1. Open Azure Storage Explorer, right click on storage container you want to setup fined-grained access with ACLs and choose Manage Access Control Lists. 

    ![Container Level ACLs](./images/acl-read-1.png)

2. Click in Add to include users or groups that you want to grant permissions.

    ![Manage Access Window](./images/acl-read-2.png)

3. In **Search for a user, group, or service principal.** Type the name of the user of group and click search. The users or groups should show-up. Select the user or group and choose **Add**.

    ![Add Entity](./images/acl-read-3.png)

After adding the user or group. Select the identity added in the previous step. In Permission for: <name of user or group> check the option **Access**, followed by **Read** and **Execute** options on the right-hand side.

As per [ADLS Best Practices](/azure/storage/blobs/data-lake-storage-best-practices#use-security-groups-versus-individual-users), it is strongly recommended to assign **Azure Active Directory security groups** instead of assigning individual users to directories and files. Using Security Groups, adding or removing users from the group does not requires updates to ADLS, consequently reduces the chance of exceeding the 32 access control entries per file or folder ACL.

It is important to notice the informative message **"Read and Write permissions will only work for an entity if the entity also has execute permissions on all parent directories, including the container (root directory)"** It means that you will also need to grant Execute permissions on all parent folders, including the container which is the root directory, when granting read or write in a sub directory.

![Manage Read Access User 1](./images/acl-read-4.png)

**Granting permissions automatically to new children of the directory using the Default*** **option.**

If you want to grant ACLs permissions automatically for new children of the directory, use the option **Default*** and select the required permissions read, write, or execute.  

![Manage Access Default](./images/acl-read-5.png)

After granting permission at the container level, repeat the same steps for any subfolder you want to give access to users or groups.

#### Granting Write Access on Azure Data Lake Storage Gen 2 using ACLs

Select the folder you want to give users or groups write permission and choose **Manage ACLs.**

![Manage ACLs](./images/acl-write-1.png)

If you want to grant ACLs permissions automatically for new children of the directory, use the option **Default*** and select the appropriate permissions **Read/write** and **execute.**  As mentioned in the Granting Read Access on ADLS Gen 2 section, this option will automatically propagate parent folder permissions to newly created children's items, such as folder and files.

After selecting the appropriate permissions, click **OK** to close.

![Manage Write Access](./images/acl-write-2.png)

Repeat the same steps for any additional folders and subfolder you may want to grant access to users or groups.

#### Propagate ACLs permissions to children objects  

When granting ACLs permissions to folders that already contain child objects such as folder and files, you may need to use the option **Propagate Access Control Lists option.** This option enables propagation of ACLs from the parent folder to its child objects. It is important to understand that ACLs propagation is not easily reversible. You will need to evaluate case by case to ensure you are propagating the correct ACL permissions to the right security group. If you use this option at the container level, it will propagate the permissions from the container level to all sub-folders within the container.

To propagate ACL permissions, right-click on the parent folder you desire to propagate the ACL permissions. This action will propagate permissions for all users to the existing child objects from the parent folder you are performing the action. 

![Propagate Access](./images/acl-propagate-1.png)

In Propagate Access Control Lists, choose How to handle failures depending on the desired behavior you want in case of failures. You can choose from the two options: **Continue on Failure** or **Quit on failure.**

Check the box I understand that propagating ACLs cannot be easily reversable and click OK. 

![Manage Access](./images/acl-propagate-2.png)

#### Considerations when using Spark Tables in Synapse Spark Pool

When you use Spark Tables in Synapse Spark Pool, the following folder structure will be created automatically by Synapse workspace in the root of the container in the workspace primary storage.  

```text
synapse/workspaces/{workspacename}/warehouse
```

If you plan to create spark tables in Synapse Spark Pool. It is required that you grant write permission on the **warehouse** folder for the users or group executing the command that creates the Spark Table. If the command is executed through triggered job in a pipeline, you will need to grant write permission to the Synapse workspace identity.

#### Create Spark Table example 

```python
df.write.saveAsTable("<tablename>")
```

## References

[How to set up access control for your Synapse workspace - Azure Synapse Analytics | Microsoft Docs](/azure/synapse-analytics/security/how-to-set-up-access-control?WT.mc_id=Portal-Microsoft_Azure_Synapse)