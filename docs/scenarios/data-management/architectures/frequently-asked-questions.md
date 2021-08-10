---
title: Frequently asked questions about Azure enterprise-scale for analytics and AI
description: Frequently asked questions about enterprise-scale analytics and AI
author: abdale
ms.author: hamoodaleem
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Frequently asked questions

The following are common questions asked about enterprise-scale for analytics and AI.

## Storage accounts

### Why do I need three separate storage accounts? Can't I just have one with three containers for each layer (raw, refined, and curated)?

Most data analytics patterns today exist with the three layers of raw, refined, and curated. Although they can be kept in the same storage, when it comes to large-scale implementations it creates issues with exceeding the number of allowed role-based access control (RBAC) and access control list (ACL) permissions that are available within a single storage account. When you use separate storage accounts, most implementations can avoid this issue.

## Databricks

### Should we deploy an Azure Databricks workspace per product?

The recommendation is to use the shared product **Azure Databricks Analytics and Data Science workspace** inside the landing zone.

This decision has been made to reduce the management overhead for the data platform operations team. Azure Databricks has a set of stand-alone policies that aren't integrated into the Azure policies. In a large environment, the setup of more Azure Databricks workspaces creates more management overhead. For example, maintaining policies and supported Apache Hive versions, updating ADB versions, and enforcing external Apache Hive metastore. There's no way a central platform team can enforce certain settings within any of the databricks workspaces. We recommend having shared workspaces for product teams in the landing zones, where the data platform ops teams can then define the necessary cluster policies and init scripts.

We recommends to use VNet peering between landing zones and private endpoints. For Azure Databricks, use VNet injection. As there's direct line of sight to all endpoints, there are no connectivity issues.
