---
title: Use Azure Synapse Analytics with cloud-scale analytics
description: Learn how to use Azure Synapse Analytics with cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 12/03/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Use Azure Synapse Analytics with cloud-scale analytics

Azure Synapse Analytics is the provisioned, integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse Analytics brings together:

- The best SQL technologies used in enterprise data warehousing.
- Spark technologies used for big data.
- Pipelines for data application (source-aligned) and extract, transform, and load (ETL) or extract, load, and transform (ELT).

Azure Synapse studio is a tool in Azure Synapse that provides a unified experience for management, monitoring, coding, and security. Synapse studio has deep integration with other Azure services like Power BI, Azure Cosmos DB, and Azure Machine Learning.

> [!NOTE]
> This section aims to describe prescribed configurations which are specific to cloud-scale analytics. It's a compliment to the official [Azure Synapse Analytics documentation](/azure/synapse-analytics/).

## Overview

During the initial setup of a [data landing zone](../architectures/data-landing-zone.md), you can deploy a single Azure Synapse Analytics workspace for use by all analysts and data scientists. You can create more workspaces for specific data integrations or data products.

You might need extra Azure Synapse Analytics workspaces if your data product needs to provide access to the [standardized data](../../cloud-scale-analytics/architectures/data-standardization.md) with row-level and column-level security. You can provide these workspaces with Azure Synapse pools. Data products teams might require their own workspace for creating data products and a separate workspace that's only for product teams with scoped development access.

## Azure Synapse Analytics setup

The first step in the deployment Azure Synapse Analytics is to set up an Azure Synapse workspace which is [connected to an Microsoft Purview account](/azure/synapse-analytics/catalog-and-governance/quickstart-connect-azure-purview).

### Azure Synapse Analytics networking

A data landing zone creates workspaces with an [Azure Synapse Analytics managed virtual network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet). Communication with Azure Synapse happens through the three endpoints it exposes: SQL pool, SQL on-demand, and the development endpoint.

At the network level, cloud-scale analytics uses [synapse managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints). These endpoints ensure all of the traffic between the data landing zone virtual network and Azure Synapse workspaces moves entirely over the Microsoft backbone network.

### Azure Synapse data access control

Use access control lists with [Microsoft Entra pass-through in Azure Synapse Analytics](/azure/synapse-analytics/sql/active-directory-authentication#azure-ad-pass-through-in-azure-synapse-analytics) to manage access to the files in the data lake.

For data where you need to restrict columns and rows returned, we recommend row-level and column-level security to restrict the data access on the tables in Azure Synapse SQL dedicated or serverless pool. Row-level security and column-level security is implemented at the database level and in addition to the database roles.

For example, row-level security ensures that users in a specific data application (source-aligned) or data product only see their own data. Even if the table contains data for the entire enterprise.

You can combine row-level security with column-level security to restrict access to columns with sensitive data. This way, both row-level security and column-level security apply the access restriction logic at the database tier rather than the application tier. The permission is evaluated every time data access is attempted from any tier.

> [!NOTE]
> Azure Synapse serverless SQL pool supports [Column-level security](/azure/synapse-analytics/sql-data-warehouse/column-level-security) for views and not for external tables. In case of external tables one can create a logical view on top of the external table and than apply Column-level security. In case of Row-level security, custom views can be used as a workaround. 

For more information, see [Azure Synapse Analytics data access control](data-lake-access.md#azure-synapse-analytics-data-access-control).

### Azure Synapse data access control in Azure Data Lake

When deploying an Azure Synapse Analytics workspace, you need an Azure Data Lake Storage account from the subscription or by manually using the storage account URL. The specified storage account is set as **primary** for the deployed Azure Synapse workspace to store its data. Azure Synapse stores data in a container that includes Apache Spark tables and Spark application logs in a folder called `/synapse/{workspaceName}`. It also has a container for managing any libraries that you choose to install.

> [!TIP]
> We recommend using a dedicated container on the [Development layer or data lake three](../../cloud-scale-analytics/best-practices/data-lake-zones.md#development-layer-or-data-lake-three) account. This container is used as primary storage to store Spark metadata.

Refer to [Azure Synapse Analytics data access control](data-lake-access.md#azure-synapse-analytics-data-access-control) for recommendations on how to set up data access.

