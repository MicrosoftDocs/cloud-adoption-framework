---
title: Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator
description: Learn how to manage and monitor Oracle workloads Azure Virtual Machines  landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/27/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator

This article describes how to successfully manage and monitor Oracle on Azure Virtual Machines landing zone accelerator. This enterprise-scale scenario outlines important recommendations for the design of your environment. More guidance is available in the [Azure enterprise-scale landing zone for management and monitoring](../../ready/landing-zone/design-area/management.md).

Following the guidance, this article further explains key design considerations and best practices for managing your Oracle workload deployments on Microsoft Azure Virtual Machine  landing zone accelerator. Since Oracle is a mission-critical and high-performance workload, the guidance on the Azure landing zone design areas should also be included in your planning. Monitoring Oracle workload on Azure Virtual Machines to discover failures and abnormalities is critical to ensuring the health of your mission critical workloads.

## Monitor Oracle databases on Azure Virtual Machines landing zone accelerator

The first step of monitoring is to set up general Azure Virtual Machine monitoring and define threshold for the metrics.  After you configure the general Azure Virtual Machine monitoring, the next step is to set up Oracle specified monitoring adapted to your environment.

### Log monitoring by Azure monitor

Oracle workload on Azure Virtual Machines landing zone accelerator, you need to monitor Virtual Machine and Oracle Database on Azure Virtual Machine. Azure Monitor provides numerous ways to monitor log of the Virtual Machine and Oracle workload.

The first step of monitoring for you is to set up general Azure Virtual Machine monitoring.

1. Enable Virtual Machine [insights](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-enable-portal)
2. Deploy AMA (Azure Monitoring Agent) and configure [DCR](https://learn.microsoft.com/azure/azure-monitor/essentials/data-collection-rule-overview) (Data Collection Rule)
3. Collect [custom logs](https://learn.microsoft.com/azure/azure-monitor/agents/data-collection-text-log?tabs=portal).
4. Monitor Managed Disk Metrics:

    If you're storing Oracle database files in Azure managed disks, you should monitor the performance related metrics for managed disks. Suitable managed disk SKUs for Oracle databases are Premium SSD, Premium SSD v2, and Ultra disk.
    Data disk performance metrics are important because the Oracle database files are stored on the managed disks. Consider the cumulative IOPS and throughput of data disks when disk striping technologies are used such as Oracle Automatic Storage Management (classic deployment model) or Linux Logical Volume Manager (LVM).

    ### Azure managed disk metrics

    The Oracle administrator should monitor disk performance metrics related to IO like the following metrics:

    - OS Disk IOPS Consumed Percentage
    - Data Disk IOPS Consumed Percentage
    - Data Disk Read Bytes/Sec
    - Data Disk Write Bytes/Sec
    - Disk Queue Depth

    While monitoring the disk metrics, it's important to ensure that the database Virtual Machine limits aren't exceeded. Virtual Machine limits specific to managed disks are detailed in the technical specifications for the individual VM SKUs. For more information, see  [Sizes for virtual machines in Azure](https://learn.microsoft.com/azure/virtual-machines/sizes) for more details.

    Selecting the appropriate VM SKU, use the table and column **Max uncached disk throughput: IOPS/MBps** to see how multiple managed disks attached to the Virtual Machine can cumulatively provide a higher combined IOPS and throughput. Note if the database IO requirements during peak load are higher than the Virtual Machine max uncached disk throughput, the Virtual Machine IO operations can be throttled. Alternatively, if there's insufficient IOPS and/or storage throughput per disk, throttling may happen at the disk level.

    For more information about Disk performance related metrics, see [Disk metrics - Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/disks-metrics).

5. Monitor Azure NetApp Files (ANF) metrics. If the database files are stored in Azure NetApp Files (ANF) volumes, you should monitor ANF metrics for allocated storage, actual storage usage, volume IOPS, throughput and latency. Refer to the following articles to understand ways to monitor Azure NetApp Files and related performance metrics.

    - [Ways to monitor Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/monitor-azure-netapp-files)

    - [Metrics for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-metrics)

    While monitoring ANF metrics, it's also important to monitor the Virtual Machine’s network bandwidth to ensure its limit isn't exceeded. ANF volume is mounted over the network using NFS protocol, it isn't restricted by the cumulative Virtual Machines IO throughput limits on any Virtual Machine instance type. Instead, ANF is only restricted by the network bandwidth on the database Virtual Machine series. The Virtual Machine limit specific to NFS-mounted storage is specified in the column named “Max network bandwidth (Mbps)”. For examples, see the VM series technical specification [Edv5 and Edsv5-series](https://learn.microsoft.com/azure/virtual-machines/edv5-edsv5-series).

### Configure the alerts for Azure virtual machine metrics

1. Alerts in Azure Monitor identify unhealthy resources. When you create a new Azure virtual machine (VM), you can enable a set of recommended alert rules for a common set of metrics. This initial set of common metrics includes CPU percentage,  or available memory. For more information, see [Enable recommended alert rules for Azure VM](https://learn.microsoft.com/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended). You can also configure Advanced [metric alert rules](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-dynamic-thresholds) if you need more situational.

    Recently, an initiative developed as an easy way to deploy alert rules. The purpose of this project is to focus on [monitoring for Azure Landing Zone](https://aka.ms/amba/alz/wiki) as a common set of Azure resources/services that are configured in a similar way across organizations.

2. The following disk related metrics should also be monitored. If thresholds are exceeded, it's recommended that an alert is issued.  

    | **Alert Rule Name** | **Condition** |
    |---|---|
    | OS Disk IOPS Consumed Percentage | OS Disk IOPS Consumed Percentage > 95 |
    | Data Disk IOPS Consumed Percentage | Data Disk IOPS Consumed Percentage > 95 |
    | Data Disk Read Bytes/Second | Adjust to system performance trends|
    | Data Disk Write Bytes/Second | Adjust to system performance trends|
    | Disk Queue Depth | Adjust to system performance trends |
  
### Monitor related Azure services

 The following table lists a number of other typical solution components that should be monitored to some extent or other.

|Azure Services |Description |URL |
|:-----------------|:-------------------|:-------------|
|Azure Virtual Network |Oracle database on Azure Virtual Machines landing zone accelerator uses virtual network for Availability Set, Availability Zone, HA, and BCDR by using Oracle Data Guard and Golden Gate. | [Azure virtual network overview](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) <br> [Monitoring Azure virtual network data reference](https://learn.microsoft.com/azure/virtual-network/monitor-virtual-network-reference) |
| Azure Backup |Azure Backup can be monitored and can be set the alert.| [Monitor at scale by using Azure monitor](https://learn.microsoft.com/azure/backup/backup-azure-monitoring-use-azuremonitor) <br> Monitor the Oracle database “alert log” file on the database VM for lines starting with the following format:<br> status – AzBackup – script – version: message <br> - where: status = “INFO”, “WARN”, or “FAIL” <br> - AzBackup (boilerplate text) <br> - script = “pre-script" or “post-script"<br> - version = version number in decimal format <br> message = free-format text <br>Example:  INFO - AzBackup pre-script v1.02: BEGIN BACKUP |
|Azure database Virtual Machine |Database “alert log” file, OS console messages file | - Database “alert log” file is typically located in the subdirectory “$ORACLE_BASE/diag/rdbms/$ORA_DBNAME/$ORACLE_SID/trace” on the database Virtual Machine<br> - OS console log located at “/var/log/messages” |

### Oracle workload monitoring by Oracle Enterprise Manager cloud control

Oracle Enterprise Manager is an Oracle integrated enterprise management product. It provides the monitoring features of events, incidents, metrics against the target Oracle workloads.

- [Manual](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Download](https://www.oracle.com/enterprise-manager/downloads/cloud-control-downloads.html)
- [Download](https://blogs.oracle.com/observability/post/monitoring-best-practices-white-paper-for-enterprise-manager-13c-now-available)

### Azure monitor and alerts

Utilize Azure Monitor to collect telemetry data and gain insights into the health, performance, and availability of your Azure resources. Oracle Enterprise Manager can be deployed on a separate Virtual Machine to monitor, maintain, and manage Oracle environments. Oracle Enterprise Manager text logs can be loaded to Log Analytics and used with Azure Monitor for a single pane of glass monitoring.

## Oracle diagnostic tools

|Approach & Option |Description |URL  |
|:---------------|:---------------|:-------------|
|AWR(Automatic Workload Repository)  |AWR provides the monitoring features to collect, process, and maintain performance statistics for problem detection and self-tuning. This monitoring helps you to realize historical analytics and identify the problems. |[Gathering database statistics](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-9D3A3890-8E68-48C5-84D0-DB0A8D93C53A)|
|Statspack |Statspack gathers Oracle database instance statistics even in environments where AWR and ADDM aren't running. Statspack includes the summary and details of database statistics, and wait events, system statistics, etc. For more detail, see the following link   |Performance tuning with STATSPACK, part I:  https://www.oracle.com/technetwork/database/performance/statspack-129989.pdf   Performance tuning with STATSPACK, part II:  https://www.oracle.com/technetwork/database/performance/statspack-tuning-otn-new-128500.pdf |

## Next steps

- [Strategic impact of Oracle on Azure landing zone accelerator](oracle-landing-zone-strategy.md)  
- [Plan for Oracle on Azure landing zone accelerator](oracle-landing-zone-plan.md)  
- [Oracle on Azure landing zone accelerator](introduction-oracle-landing-zone.md)

- [Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator](oracle-disaster-recovery-oracle-landing-zone.md)
