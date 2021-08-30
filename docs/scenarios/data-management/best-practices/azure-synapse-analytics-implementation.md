---
title: Enterprise-scale for analytics and AI Azure Synapse pattern
description: Learn how to implement Azure Synapse Analytics with enterprise-scale for analytics and AI.
author: mboswell
ms.author: mboswell
ms.date: 08/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Synapse Analytics implementation

Azure Synapse Analytics is the provisioned, integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse Analytics brings together:

- The best of SQL technologies used in enterprise data warehousing.
- Spark technologies used for big data.
- Pipelines for data integration and extract, transform, and load (ETL) or extract, load, and transform (ELT).

Azure Synapse studio is a tool in Azure Synapse that provides a unified experience for management, monitoring, coding, and security. Synapse studio has deep integration with other Azure services like Power BI, Azure Cosmos DB, and Azure Machine Learning.

> [!NOTE]
> This section aims to describe prescribed configurations which are specific to enterprise-scale for analytics and AI. It's a compliment to the official [Azure Synapse Analytics documentation](/azure/synapse-analytics/).

## Overview

During the initial setup of a [data landing zone](../architectures/data-landing-zone.md), you can deploy a single Azure Synapse Analytics workspace for use by all analysts and data scientists. You can create more workspaces for specific data integrations or data products.

Use Azure SQL Database pools, formerly SQL data warehouse, as the data store for both enriched and curated data. This data store serves the data science team's need for feature datasets and datasets for analytical requirements. Azure Databricks can connect to these SQL pools and update the data, which is in the SQL pools.

Azure SQL Database on-demand is a serverless query service that's used by data scientists and engineers to run queries against files in the storage accounts.

> [!TIP]
> You might need additional Azure Synapse Analytics workspaces if your data integration needs to provide access to the golden source with row- and column-level security. You can provide these workspaces with Azure Synapse pools. Data products teams might require their own workspace for creating data products and a separate workspace that's only for product teams with scoped development access.

## Azure Synapse Analytics setup

The first step in the deployment Azure Synapse Analytics is to set up an Azure Synapse workspace.

As you need an Azure Data Lake Storage account, we recommend using a dedicated container on the workspace data lake account. This container is used as primary storage to store Spark metadata.

We recommend Azure Databricks for premium big data processing and data science capabilities.

### Azure Synapse Analytics networking

A data landing zone creates workspaces with an [Azure Synapse Analytics managed virtual network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet). Communication with Azure Synapse happens through the three endpoints it exposes: SQL pool, SQL on-demand, and the development endpoint.

At the network level, enterprise-scale for analytics and AI uses [synapse managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints). These endpoints ensure all of the traffic between the data landing zone virtual network and Azure Synapse workspaces moves entirely over the Microsoft backbone network.

### Azure Synapse data access control

Use access control lists with [Azure Active Directory (Azure AD) pass-through in Azure Synapse Analytics](/azure/synapse-analytics/sql/active-directory-authentication#azure-ad-pass-through-in-azure-synapse-analytics) to manage access to the files in the data lake.

We recommend row-level security and column-level security to restrict the data access on the tables in synapse SQL pool using security policy. Row-level security and column-level security is used at the database level and in addition to the database roles.

For example, row-level security ensures that users in a specific data integration or data product only see their own data. Even if the table contains data for the entire enterprise.

You can combine row-level security with column-level security to restrict access to columns with sensitive data. This way, both row-level security and column-level security apply the access restriction logic at the database tier rather than the application tier. The permission is evaluated every time data access is attempted from any tier.

> [!TIP]
> We recommend that features such as Azure Defender for SQL, data classification, data encryption, and dynamic data masking are available for SQL pool to support data protection and limit sensitive data exposure.

### Azure Synapse data access control in Azure Data Lake

When deploying an Azure Synapse Analytics workspace, you need an AzureData Lake Storage account from the subscription or by manually using the storage account URL. The specified storage account is set as **primary** for the deployed Azure Synapse workspace to store its data. Azure Synapse stores data in a container that includes Apache Spark tables and Spark application logs in a folder called **/synapse/{workspacename}**. It also has a container for managing any libraries that you choose to install.

During the Azure Synapse workspace deployment through [Azure portal](https://ms.portal.azure.com/), you can either provide an existing storage account or create a new one. The provided storage account is set as the primary storage account for the Azure Synapse workspace. For either account option, the deployment process automatically grants the Azure Synapse workspace identity data access to the specified Data Lake Storage account using the Storage Blob Data Contributor role. If the deployment of Azure Synapse workspace happens outside of the Azure portal, you need to manually add an Azure Synapse workspace identity to the Storage Blob Data Contributor role later. We recommend assigning the role Storage Blob Data Contributor on the file system level to follow the least privilege principle.

It's also possible to manually specify the storage account URL. However, you need to contact the storage account owner and ask them to grant the workspace identity access manually using the **Storage Blob Data Contributor.**

The Azure Synapse workspace identity permission context is used when executing pipelines, workflows, and notebooks through jobs. If any of the jobs read or write to the workspace primary storage, the workspace identity uses the read/write permissions granted through the **Storage Blog Data Contributor**.

Use the Storage Blob Data Contributor role to grant read/write/delete permissions to Blob Storage resources like folders and files.

Storage Account permissions are required when using Azure Synapse workspaces interactively and for development. You can provide read/write permissions to other users or groups on the primary storage account after it's been deployed. However, the account requires you to grant access permissions by using the Storage Blob Data Contributor role or access control lists directly to the user or groups. When users sign in to the Azure Synapse workspace to execute scripts or for development, the user's context permissions are used to allow read/write permissions on the primary storage.

## Next steps

- [High availability for Azure Synapse Analytics](../../../migrate/azure-best-practices/analytics/azure-synapse.md)
