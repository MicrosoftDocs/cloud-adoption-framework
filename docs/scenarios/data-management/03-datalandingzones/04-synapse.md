---
title: Enterprise Scale Analytics and AI Azure Synapse Pattern
description: Enterprise Scale Analytics and AI Azure Synapse Pattern
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Synapse Analytics Integration

**Azure Synapse** is the provisioned integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse brings together the best of **SQL** technologies used in enterprise data warehousing, **Spark** technologies used for big data, and **Pipelines** for data integration and ETL/ELT. **Synapse Studio** provides a unified experience for management, monitoring, coding, and security. Synapse has deep integration with other Azure services such as **Power BI**, **CosmosDB**, and **AzureML**.

This section aims to describe pre-scribed configurations which are specific to the Enterprise Scale Analytic and AI. It is a compliment to the official [Azure Synapses Documentation](https://docs.microsoft.com/azure/synapse-analytics/).

## Overview

During the initial setup of a Data Landing Zone a single Azure Synapse Analytics will be deployed for use by all analysts and data scientists. Additional ones can be optionally setup for specific Domains or Data Products.

SQL Pools, formally SQL DW, can be used as the data store for both enriched and curated data which can serve for feature data sets needed by data science team and for the data sets required for the analytical requirements. Azure Databricks can connect to these SQL Pools and update the data which resides inside the SQL Pools.

SQL On-Demand is a serverless query service that will be used by the data scientists and engineers to run queries against files in the storage account.

>[!TIP]
>Reasons for setting up additional Azure Synapse Analytics are that the Domain needs to provide access to there golden source with row and column level security and use Azure Synapse Pools to achieve this. Data Products teams might require there own Azure Synapse Analytics for creating there Data Products and a separate instance of Azure Synapse Analytics allow only the product teams scoped development access.

## Azure Synapse Analytics Setup

The first step in the deployment Azure Synapse Analytics is to set up a Azure Synapse workspace.

As an Azure Data Lake Gen 2 storage account is required and is used as primary storage to store Spark metadata, we recommend using the Enriched and Curated ADLS storage account created in the Data Landing Zone.

For premium big data processing and data science capabilities, we recommend Azure Databricks.

### Azure Synapse Networking

A Data Landing Zone will create workspaces with a [Azure Synapse Analytics Managed Virtual Network](https://docs.microsoft.com/azure/synapse-analytics/security/synapse-workspace-managed-vnet). Communication, with Synapse, will be through the three endpoints it exposes. SQL Pool, SQL On-Demand, and the Development Endpoint.

At the network level, the Enterprise Scale Analytics and AI will use [Synapse Managed private endpoints](https://docs.microsoft.com/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) to ensure all the traffic between Data Landing Zone vNet and Azure Synapse Workspace(s) traverses entirely over the Microsoft backbone network.

### Azure Synapse Data Access Control

[Azure AD pass-through in Azure Synapse Analytics](https://docs.microsoft.com/azure/synapse-analytics/sql/active-directory-authentication#azure-ad-pass-through-in-azure-synapse-analytics) should use Access Control Lists to manage the access to the files in the data lake.

At the database level, in addition to the database roles, we recommend Row Level and Column Security (RLS) to restrict the data access on the tables in Synapse SQL Pool using security policy.

For example, RLS is a great way to ensure a specific Domain or Data Product users only see their own data even if the table contains data for all the Business.

By combining RLS with column level security (CLS) to restrict access to columns with sensitive data. Both RLS and CLS apply the access restriction logic at the database tier rather than the application tier. The permission is evaluated every time the data access is attempted from any tier.

>[!TIP]
>We highly recommend that Features such as Azure Defender for SQL, Data Classification, Data Encryption, Dynamic Data Masking are available for SQL Pool to support the data protection and limit sensitive data exposure.

>[!div class="step-by-step"]
>[Previous](03-databricks.md)
>[Next](05-domains.md)
