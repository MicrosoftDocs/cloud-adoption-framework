---
title: "High availability for Azure Synapse"
description: Use Azure Synapse features to address high availability and disaster recovery requirements.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# High availability for Azure Synapse

One of the key benefits of a modern cloud-based infrastructure such as Microsoft Azure is that features for high availability and disaster recovery are built-in and simple to implement and customize. These facilities are also usually lower cost than the equivalent functionality within an on-premises environment. Using these built-in functions also means that the backup and recovery mechanisms in the existing legacy data warehouse need not be migrated.

The sections below describe the standard Azure Synapse features which address high availability and disaster recovery requirements.

## High availability (HA)

Azure Synapse uses database snapshots to provide high availability of the warehouse. A data warehouse snapshot creates a restore point which can be used to recover or copy a data warehouse to a previous state. Since Azure Synapse is a distributed system, a data warehouse snapshot consists of many files that are located in Azure storage. Snapshots capture incremental changes from the data stored in your data warehouse.

Azure Synapse automatically takes snapshots throughout the day creating restore points that are available for seven days. This retention period cannot be changed. Azure Synapse supports an eight-hour recovery point objective (RPO). A data warehouse can be restored in the primary region from any one of the snapshots taken in the past seven days.

User-defined restore points are also supported, allowing manual triggering of snapshots to create restore points of a data warehouse before and after large modifications. This capability ensures that restore points are logically consistent, which provides additional data protection in case of any workload interruptions or user errors for quick recovery time.

## Disaster recovery (DR)

As well as the snapshots described above, Azure Synapse also performs as standard a geo-backup once per day to a paired data center. The RPO for a geo-restore is 24 hours. You can restore the geo-backup to a server in any other region where Azure Synapse is supported. A geo-backup ensures that a data warehouse can be restored in case the restore points in the primary region are not available.

