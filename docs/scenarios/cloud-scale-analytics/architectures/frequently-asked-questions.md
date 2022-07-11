---
title: Frequently asked questions about cloud-scale analytics
description: Explore frequently asked questions about cloud-scale analytics.
author: abdale
ms.author: hamoodaleem
ms.date: 02/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Frequently asked questions about cloud-scale analytics

The following are common questions asked about cloud-scale analytics.

## Storage accounts

### Why do I need three separate storage accounts? Can't I just have one with three containers for each layer (raw, refined, and curated)?

Most data analytics patterns today exist with the three layers of raw, refined, and curated. Although they can be kept in the same storage, when it comes to large-scale implementations it creates issues with exceeding the number of allowed role-based access control (RBAC) and access control list (ACL) permissions that are available within a single storage account. When you use separate storage accounts, most implementations can avoid this issue.

Other reasons are discussed in [Overview of Azure Data Lake Storage for cloud-scale analytics](../best-practices/data-lake-overview.md).

## Databricks

### Should we deploy an Azure Databricks workspace per product?

The recommendation is to use the shared product **Azure Databricks analytics and data science workspace** inside the landing zone.

This decision has been made to reduce the management overhead for the data platform operations team. Azure Databricks has a set of stand-alone policies that aren't integrated into the Azure policies. In a large environment, the setup of more Azure Databricks workspaces creates more management overhead. For example, maintaining policies and supported Apache Hive versions, updating ADB versions, and enforcing external Apache Hive metastore. There's no way a central platform team can enforce certain settings within any of the Databricks workspaces. We recommend having shared workspaces for product teams in the landing zones, where the data platform ops teams can then define the necessary cluster policies and initialization scripts.

We recommend to use VNet peering between landing zones and private endpoints. For Azure Databricks, use VNet injection. As there's direct line of sight to all endpoints, there are no connectivity issues.

## Next steps

[The ingest process with cloud-scale analytics in Azure](../best-practices/data-ingestion.md)
