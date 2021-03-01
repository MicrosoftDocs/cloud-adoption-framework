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
\
**General disclaimer: DO NOT COPY - UNDER DEVELOPMENT - MS INTERNAL ONLY** \
&nbsp;

# Azure Synapse Analytics Integration

**Azure Synapse** is the provisioned, integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse brings together the best of **SQL** technologies used in enterprise data warehousing, **Spark** technologies used for big data, and **Pipelines** for data integration and ETL/ELT. **Synapse Studio** provides a unified experience for management, monitoring, coding, and security. Synapse has deep integration with other Azure services such as **Power BI**, **CosmosDB**, and **Azure Machine Learning**.

This section aims to describe prescribed configurations which are specific to the Enterprise Scale Analytic and AI solution pattern. It is a compliment to the official [Azure Synapses Documentation](https://docs.microsoft.com/azure/synapse-analytics/).

## Overview

During the initial setup of a Data Landing Zone, a single Azure Synapse Analytics workspace will be deployed for use by all analysts and data scientists. Additional workspaces can be optionally created for specific Domains or Data Products.

SQL Pools, formerly SQL DW, can be used as the data store for both enriched and curated data, which can serve for feature datasets needed by data science teams and for the datasets required for the analytical requirements. Azure Databricks can connect to these SQL Pools and update the data which resides inside the SQL Pools.

SQL On-Demand is a serverless query service that will be used by the data scientists and engineers to run queries against files in the storage accounts.

>[!TIP]
>Additional Azure Synapse Analytics workspaces may be needed if the Domain needs to provide access to the golden source with row- and column-level security, which can be provided by Azure Synapse Pools. Data Products teams might require their own workspace for creating Data Products and a separate workspace that allow only the product teams scoped development access.

## Azure Synapse Analytics Setup

The first step in the deployment Azure Synapse Analytics is to set up an Azure Synapse workspace.

As an Azure Data Lake Gen 2 storage account is required and is used as primary storage to store Spark metadata, we recommend using the Enriched and Curated ADLS storage account created in the Data Landing Zone.

For premium big data processing and data science capabilities, we recommend Azure Databricks.

### Azure Synapse Networking

A Data Landing Zone will create workspaces with a [Azure Synapse Analytics Managed Virtual Network](https://docs.microsoft.com/azure/synapse-analytics/security/synapse-workspace-managed-vnet). Communication with Synapse will be through the three endpoints it exposes: SQL Pool, SQL On-Demand, and the Development Endpoint.

At the network level, the Enterprise Scale Analytics and AI solution pattern uses [Synapse Managed private endpoints](https://docs.microsoft.com/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) to ensure all the traffic between Data Landing Zone vNet and Azure Synapse Workspace(s) traverses entirely over the Microsoft backbone network.

### Azure Synapse Data Access Control

[Azure AD pass-through in Azure Synapse Analytics](https://docs.microsoft.com/azure/synapse-analytics/sql/active-directory-authentication#azure-ad-pass-through-in-azure-synapse-analytics) should use Access Control Lists to manage the access to the files in the data lake.

At the database level, in addition to the database roles, we recommend Row-Level Security (RLS) and Column-Level Security to restrict the data access on the tables in Synapse SQL Pool using security policy.

For example, RLS is a great way to ensure users in a specific Domain or Data Product see only their own data even if the table contains data for all the enterprise.

By combining RLS with Column-Level Security (CLS) to restrict access to columns with sensitive data, both RLS and CLS apply the access restriction logic at the database tier rather than the application tier. The permission is evaluated every time the data access is attempted from any tier.

>[!TIP]
>We highly recommend that features such as Azure Defender for SQL, Data Classification, Data Encryption, and Dynamic Data Masking are available for SQL Pool to support the data protection and limit sensitive data exposure.

## Log Feedback to Enterprise Scale Analytics v-team

[Log Feedback for this page](https://github.com/Azure/enterprise-scale-analytics/issues/new?title=&body=%0A%0A%5BEnter%20feedback%20here%5D%0A%0A%0A---%0A%23%23%23%23%20Document%20Details%0A%0A%E2%9A%A0%20*Do%20not%20edit%20this%20section.%20It%20is%20required%20for%20Solution%20Engineering%20%E2%9E%9F%20GitHub%20issue%20linking.*%0A%0A*%20Content%3A%2003-datalandingzones%20%E2%9E%9F%2003-synapse.md)

>[Previous](03-databricks.md)
>[Next](05-domains.md)
