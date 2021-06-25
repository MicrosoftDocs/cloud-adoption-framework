---
title: Frequently Asked Questions about Azure Enterprise Scale Analytics and AI
description: Frequently Asked Questions about Enterprise Scale Analytics and AI
author: abdale
ms.author: hamoodaleem  # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Frequently Asked Questions

The following are common questions asked about Enterprise Scale Analytics and AI.

<!-- 
## Data Management Landing Zone

### Topic Name (e.g., Data Integrations)

#### Question 1

[Answer here]

#### Question 2

[Answer here]
-->

## Data Landing Zone

### Storage Accounts

#### Why do I need three separate storage accounts? Can't I just have one with 3 containers for each layer (raw, refined, curated)?

Most data analytics patterns today exist with the 3 layers (raw, refined, and curated). Although they can be kept in the same storage, when it comes to large scale implementations this creates issues with exceeding the number of allowed RBAC & ACL permissions that are available within a single storage account. By separating them most implementations can avoid this issue. With the evolution of technology it may change, as the refined/curated pieces are collapsed into other products such as Synapse and Databricks (under SQL Analytics).

### Databricks

#### Should we deploy a databricks workspace per product?

The recommendation is to use the shared product databricks workspace inside the landing zone.

This decision has been made to reduce the management overhead for the (data) platform ops team. Databricks has a set of stand-alone policies which aren't integrated into the Azure policies. In a large environment the setup of additional databricks workspaces creates additional management overhead (maintaining policies, updating supported hive version, updating ADB versions, enforcing external hive metastore, etc.). Therefore, there is no way how a central platform team can enforce certain settings within any of the databricks workspaces. For this reason, we are recommending to have shared workspaces for product teams in the landing zones, where the data platform Ops teams can then define the necessary cluster policies and init scripts etc.

We are recommending to use Vnet Peering between Landing Zones and Private Endpoints. For Databricks we have to use Vnet injection. As there is direct line of sight to all endpoints, there are no connectivity issues.
