---
title: Database restore points for Azure Synapse Analytics
description: Learn how to use Azure Synapse Analytics features to address database restore and disaster recovery requirements.
author: v-hanki
ms.author: brblanch
ms.date: 06/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Database restore points for Azure Synapse Analytics

One of the key benefits of a modern cloud-based infrastructure such as Microsoft Azure is that features for database restore points and disaster recovery (DR) are built in and simple to implement and customize. These facilities are often lower in cost than the equivalent functionality within an on-premises environment. Using these built-in functions also means that the backup and recovery mechanisms in the existing data warehouse don't need to be migrated.

The following sections describe the standard Azure Synapse Analytics features that address requirements for database restore points and disaster recovery.

## Database restore points

Azure Synapse Analytics uses database snapshots to provide database restore points for the warehouse. A data warehouse snapshot creates a restore point that can be used to recover or copy a data warehouse to a previous state. Because Azure Synapse Analytics is a distributed system, a data warehouse snapshot consists of many files that are located in Azure Storage. Snapshots capture incremental changes from the data stored in your data warehouse.

Azure Synapse Analytics automatically takes snapshots throughout the day to create restore points that are available for seven days. This retention period can't be changed. Azure Synapse Analytics supports an eight-hour recovery point objective (RPO). You can restore a data warehouse in the primary region from any one of the snapshots taken in the past seven days.

The service also supports user-defined restore points. Manually triggering snapshots can create restore points of a data warehouse before and after large modifications. This capability ensures that restore points are logically consistent. Logical consistency provides additional data protection against workload interruptions or user errors for quick recovery time.

## Disaster recovery

In addition to the snapshots described earlier, Azure Synapse Analytics performs a standard geo-backup once per day to a paired datacenter. The RPO for a geo-restore is 24 hours. The dedicated SQL pool is backed up. You can restore the geo-backup to a server in any other region where Azure Synapse Analytics is supported. A geo-backup ensures that a data warehouse can be restored in case the restore points in the primary region are not available.

For more details about database backup and recovery, see [Backup and restore in Azure Synapse Dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/backup-and-restore).
