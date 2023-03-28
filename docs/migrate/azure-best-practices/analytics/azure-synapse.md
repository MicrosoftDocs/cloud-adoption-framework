---
title: Database-restore points for Azure Synapse Analytics
description: Learn how to use Azure Synapse Analytics features to address database-restore and disaster recovery requirements.
author: v-hanki
ms.author: martinek
ms.date: 9/16/2022
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Database-restore points for Azure Synapse Analytics

Azure Synapse Analytics makes it simple to create database-restore points and disaster recovery (DR). The following sections describe the standard Azure Synapse Analytics features that address requirements for database-restore points and disaster recovery.

## Database-restore points

Azure Synapse Analytics uses database snapshots to provide database-restore points for the warehouse. A data warehouse snapshot creates a restore point that can be used to recover or copy a data warehouse to a previous state. Because Azure Synapse Analytics is a distributed system, a data warehouse snapshot consists of many files that are located in Azure Storage. Snapshots capture incremental changes from the data stored in your data warehouse.

Azure Synapse Analytics automatically takes snapshots throughout the day to create restore points that are available for seven days. This retention period can't be changed. Azure Synapse Analytics supports an eight-hour recovery point objective (RPO). You can restore a data warehouse in the primary region from any one of the snapshots taken in the past seven days.

The service also supports user-defined restore points. Manually triggering snapshots can create restore points of a data warehouse before and after large modifications. This capability ensures that restore points are logically consistent. Logical consistency provides extra data protection against workload interruptions or user errors for quick recovery time.

## Disaster recovery

In addition to the snapshots described earlier, Azure Synapse Analytics performs a standard geo-backup once per day to a paired datacenter. The RPO for a geo-restore is 24 hours. The dedicated SQL pool is backed up. Dedicated SQL pool (formerly SQL DW) refers to the enterprise data warehousing features that are available in Azure Synapse Analytics. You can restore the geo-backup to a server in any other region where Azure Synapse Analytics is supported. A geo-backup ensures that a data warehouse can be restored in case the restore points in the primary region aren't available.

For more information, see:

- [Backup and restore in Azure Synapse Dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/backup-and-restore)
- [Dedicated SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is)
