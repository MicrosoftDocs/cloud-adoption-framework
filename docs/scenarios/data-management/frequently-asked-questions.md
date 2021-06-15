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

### Topic Name (e.g., Data Domains)

#### Question 1

[Answer here]

#### Question 2

[Answer here]
-->

## Data Landing Zone

### Storage Accounts

#### Why do I need three separate storage accounts? Can't I just have one with 3 containers for each layer (raw, refined, curated)?

Most data analytics patterns today exist with the 3 layers (raw, refined, and curated). Although they can be kept in the same storage, when it comes to large scale implementations this creates issues with exceeding the number of allowed RBAC & ACL permissions that are available within a single storage account. By separating them most implementations can avoid this issue. With the evolution of technology it may change, as the refined/curated pieces are collapsed into other products such as Synapse and Databricks (under SQL Analytics).
