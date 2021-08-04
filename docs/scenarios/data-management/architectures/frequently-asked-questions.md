---
title: Frequently Asked Questions about Azure enterprise-scale for analytics and AI
description: Frequently Asked Questions about Enterprise Scale Analytics and AI
author: abdale
ms.author: hamoodaleem  # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Frequently Asked Questions

The following are common questions asked about enterprise-scale for analytics and AI.

<!-- 
## Data Management Landing Zone

### Topic Name (e.g., Data Integrations)

#### Question 1

[Answer here]

#### Question 2

[Answer here]
-->

## Data landing zone

### Storage accounts

#### Why do I need three separate storage accounts? Can't I just have one with three containers for each layer (raw, refined, and curated)?

Most data analytics patterns today exist with the three layers (raw, refined, and curated). Although they can be kept in the same storage, when it comes to large-scale implementations it creates issues with exceeding the number of allowed role-based access control (RBAC) and ACL permissions that are available within a single storage account. When you use separate storage accounts, most implementations can avoid this issue.

### Databricks

#### Should we deploy an Azure Databricks workspace per product?

The recommendation is to use the shared product **Azure Databricks Analytics and Data Science workspace** inside the landing zone.

This decision has been made to reduce the management overhead for the data platform operations team. Azure Databricks has a set of stand-alone policies that aren't integrated into the Azure policies. In a large environment, the setup of more Azure Databricks workspaces creates more management overhead. For example, maintaining policies and supported hive versions, updating ADB versions, and enforcing external hive metastore. There's no way a central platform team can enforce certain settings within any of the databricks workspaces. We recommend having shared workspaces for product teams in the landing zones, where the data platform Ops teams can then define the necessary cluster policies and init scripts.

We recommendS to use Vnet Peering between landing zones and Private Endpoints. For Azure Databricks, use Vnet injection. As there's direct line of sight to all endpoints, there are no connectivity issues.
