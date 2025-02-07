---
title: Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator
description: Learn how to manage and monitor Oracle workloads Azure Virtual Machines  landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/27/2023
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator

This article describes how to successfully manage and monitor Oracle on Azure Virtual Machines landing zone accelerator. This enterprise-scale scenario outlines important recommendations for the design of your environment. More guidance is available in the [Azure enterprise-scale landing zone for management and monitoring](../../ready/landing-zone/design-area/management.md).

Following the guidance, this article further explains key design considerations and best practices for managing your Oracle workload deployments on Microsoft Azure Virtual Machine  landing zone accelerator. Since Oracle is a mission-critical and high-performance workload, the guidance on the Azure landing zone design areas should also be included in your planning. Monitoring Oracle workload on Azure Virtual Machines to discover failures and abnormalities is critical to ensuring the health of your mission critical workloads.

## Monitor Oracle databases on Azure Virtual Machines landing zone accelerator

The first step of monitoring is to set up general Azure Virtual Machine monitoring and define threshold for the metrics. After you configure the general Azure Virtual Machine and managed Disk monitoring, the next step is to set up Oracle specified monitoring adapted to your environment.

### Log monitoring by Azure monitor

To monitor an Oracle workload on the [Azure Virtual Machines landing zone accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-landing-zone-accelerator), you need to monitor Virtual Machine, attached managed Disks, or applied storage account, such as Azure NetApp Files and Oracle Database on Azure Virtual Machine. Therefore Azure Monitor provides numerous ways to monitor log of the Virtual Machine and managed disks for your Oracle workload.

The first step is to set up general Azure Virtual Machine and Managed disk monitoring.

1. Enable Virtual Machine [insights](/azure/azure-monitor/vm/vminsights-enable-portal)
2. Deploy AMA (Azure Monitoring Agent) and configure [DCR](/azure/azure-monitor/essentials/data-collection-rule-overview) (Data Collection Rule)
3. Collect [custom logs](/azure/azure-monitor/agents/data-collection-text-log?tabs=portal).
4. Monitor Managed Disk Metrics:

    If you're storing Oracle database files in Azure managed disks, you should monitor the performance related metrics for managed disks. Suitable managed disk SKUs for Oracle databases are Premium SSD, Premium SSD v2, and Ultra disk.
    Data disk performance metrics are important because the Oracle database files are stored on the managed disks. Consider the cumulative IOPS and throughput of data disks when disk striping technologies are used such as Oracle Automatic Storage Management (classic deployment model) or Linux Logical Volume Manager (LVM).

    > [!NOTE]
    > When provisioning a virtual machine with NVMe storage, the maximum throughput per disk is 1,200 Mbps. If higher throughput is required, consider provisioning multiple disks to meet your performance needs and configure them in a RAID-0 array. For optimal performance, use a block size of 128 KB for NVMe storage.

### Azure virtual machine and managed disk metrics

The Oracle administrator should monitor disk performance metrics, such as the following:

| Name                                           | Thresholds (Severity) | 
| ---------------------------------------------- | ----------------------- | 
| Percentage CPU > 95                            | 95 (1)                  | 
| Percentage CPU >= 85                           | 85 (1)                  | 
| Percentage CPU >= 75                           | 75 (2)                  | 
| VmAvailabilityMetric < 1                       | < 1 (0)                 | 
| OS Disk Bandwidth Consumed Percentage > 95     | 95 (1)                  | 
| OS Disk Bandwidth Consumed Percentage > 90     | 90 (1)                  | 
| Available Memory Bytes < 500000000             | < 500000000 (1)         | 
| VM cached Bandwidth Consumed Percentage > 95   | 95 (1)                  | 
| VM cached Bandwidth Consumed Percentage > 85   | 85 (2)                  | 
| VM cached Bandwidth Consumed Percentage > 75   | 75 (2)                  | 
| VM uncached Bandwidth Consumed Percentage > 95 | 95 (1)                  | 
| VM uncached Bandwidth Consumed Percentage > 85 | 85 (2)                  | 
| VM uncached Bandwidth Consumed Percentage > 75 | 75 (2)                  | 
| Data Disk IOPS Consumed Percentage > 95        | 95 (1)                  | 
| Data Disk IOPS Consumed Percentage > 85        | 85 (2)                  | 
| Data Disk IOPS Consumed Percentage > 75        | 75 (2)                  | 
| Data Disk Read Bytes > 95     | 95 (1)                  | 
| Data Disk Read Bytes > 85     | 85 (2)                  | 
| Data Disk Read Bytes > 75     | 75 (2)                  | 
| Data Disk Writes Bytes > 95     | 95 (1)                  | 
| Data Disk Writes Bytes > 85     | 85 (2)                  | 
| Data Disk Writes Bytes > 75     | 75 (2)                  | 

 In Severity please note that '0' has the highest severity while '2' has a lower severity.

When monitoring disk metrics, it's important to ensure that the database Virtual Machine limits aren't exceeded. The specific limits for managed disks are detailed in the technical specifications for each VM SKU. For more information about VM specifications, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

When selecting the appropriate VM SKU, refer to the table and column **Max uncached disk throughput: IOPS/MBps** to see how multiple managed disks attached to the Virtual Machine can cumulatively provide higher combined IOPS and throughput. If the database I/O requirements during peak load exceed the Virtual Machine's maximum uncached disk throughput, the Virtual Machine's I/O operations may be throttled. Additionally, if there's insufficient IOPS or storage throughput per disk, throttling could occur at both the virtual machine and disk levels.

For more information about Disk performance related metrics, see [Disk metrics - Azure Virtual Machines](/azure/virtual-machines/disks-metrics).


**Monitor Azure NetApp Files (ANF) metrics**

If the database files are stored in Azure NetApp Files (ANF) volumes, monitor ANF allocated storage, actual storage usage, volume IOPS, throughput, and latency. For detailed information on how to monitor Azure NetApp Files and related performance metrics, refer to the following articles:

 - [Ways to monitor Azure NetApp Files](/azure/azure-netapp-files/monitor-azure-netapp-files)

 - [Metrics for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-metrics)

While monitoring ANF metrics, it's also important to monitor the Virtual Machine’s network bandwidth to ensure its limit isn't exceeded. Since ANF volumes are mounted over the network using the NFS protocol, they aren't restricted by the cumulative I/O throughput limits of any Virtual Machine instance type. Instead, ANF is only limited by the network bandwidth of the database Virtual Machine series. The specific limit for NFS-mounted storage is detailed in the column named "Max network bandwidth (Mbps)". For examples, see the VM series technical specification [Edv5 and Edsv5-series](/azure/virtual-machines/edv5-edsv5-series).

### Configure the alerts for Azure virtual machine metrics

1. Alerts in Azure Monitor help identify unhealthy resources. When you create a new Azure virtual machine (VM), you can enable a set of recommended alert rules for common metrics. This initial set includes metrics such as CPU percentage and available memory. For more information, see [Enable recommended alert rules for Azure VM](/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended). Additionally, you can configure Advanced [metric alert rules](/azure/azure-monitor/alerts/alerts-dynamic-thresholds) if you require situational monitoring.

 Microsoft Azure offers [AMBA (Azure Monitor Baseline Alerts)](https://azure.github.io/azure-monitor-baseline-alerts/welcome/). It refers to a feature that helps in monitoring and alerting based on predefined baseline metrics. These alerts are designed to notify users about unusual or critical changes in their Azure resources, performance, or security posture.
 
1. Managed disk related metrics should also be monitored. If thresholds are exceeded, it's recommended that an alert is issued.  
  
### Monitor related Azure services

 The following table lists other typical solution components that should be monitored to some extent or other.

|Azure Services |Description |URL |
|:-----------------|:-------------------|:-------------|
|Azure Virtual Network |Oracle database on Azure Virtual Machines landing zone accelerator uses virtual network for Availability Set, Availability Zone, HA, and BCDR by using Oracle Data Guard and Golden Gate. | [Azure virtual network overview](/azure/virtual-network/virtual-networks-overview) <br> [Monitoring Azure virtual network data reference](/azure/virtual-network/monitor-virtual-network-reference)
| Azure Backup |Azure Backup can be monitored. In addition an alert can be set.| [Monitor at scale by using Azure monitor](/azure/backup/backup-azure-monitoring-use-azuremonitor) <br> Monitor the Oracle database "alert log" file on the database VM for lines starting with the following format:<br> status – AzBackup – script – version: message <br> - where: status = “INFO”, “WARN”, or “FAIL” <br> - AzBackup (boilerplate text) <br> - script = “pre-script" or “post-script"<br> - version = version number in decimal format <br> message = free-format text <br>Example:  INFO - AzBackup pre-script v1.02: BEGIN BACKUP |
|Oracle database on a Virtual Machine |Database "alert log" file, OS console messages file | - Database "alert log" file is typically located in the subdirectory "$ORACLE_BASE/diag/rdbms/$ORA_DBNAME/$ORACLE_SID/trace" on the database Virtual Machine<br> - OS console log located at "/var/log/messages" |

### Oracle workload monitoring by Oracle Enterprise Manager Cloud Control

Oracle Enterprise Manager is an Oracle integrated enterprise management product. It offers monitoring of events, incidents, and metrics related to target Oracle workloads.

- [Manual](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Download](https://www.oracle.com/enterprise-manager/downloads/cloud-control-downloads.html)
- [Download](https://blogs.oracle.com/observability/post/monitoring-best-practices-white-paper-for-enterprise-manager-13c-now-available)

### Azure monitor and alerts

Utilize Azure Monitor to collect telemetry data and gain insights into the health, performance, and availability of your Azure resources. Oracle Enterprise Manager can be deployed on a separate Virtual Machine to monitor, maintain, and manage Oracle environments. Oracle Enterprise Manager text logs can be loaded to Log Analytics and used with Azure Monitor for a single pane of glass monitoring.

## Oracle diagnostic tools

|Approach & Option |Description |URL  |
|:---------------|:---------------|:-------------|
|AWR (Automatic Workload Repository)  |AWR provides the monitoring features to collect, process, and maintain performance statistics for problem detection and self-tuning. This monitoring helps you to realize historical analytics and identify the problems. |[Gathering database statistics](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-9D3A3890-8E68-48C5-84D0-DB0A8D93C53A)|
|Statspack |Statspack gathers Oracle database instance statistics even in environments where AWR and ADDM aren't running. Statspack includes the summary and details of database statistics, and wait events, system statistics, etc. For more information, see the following links.  |[Performance tuning with STATSPACK, part I](https://www.oracle.com/technetwork/database/performance/statspack-129989.pdf) <br>  [Performance tuning with STATSPACK, part II](https://www.oracle.com/technetwork/database/performance/statspack-tuning-otn-new-128500.pdf) |
|Oracle Enterprise Manager Diagnostics and Tuning  |The Oracle Diagnostics Pack provides automatic performance diagnostic and advanced system monitoring functionality. The Oracle Tuning Pack provides database administrators with expert performance management for the Oracle environment, including SQL tuning and storage optimizations. |[Diagnostics and Tuning packs](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.5/performance.html)  |

## Next steps

- [Strategic impact of Oracle on Azure landing zone accelerator](oracle-landing-zone-strategy.md)  
- [Plan for Oracle on Azure landing zone accelerator](oracle-landing-zone-plan.md)  
- [Oracle on Azure landing zone accelerator](introduction-oracle-landing-zone.md)
- [Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator](oracle-disaster-recovery-oracle-landing-zone.md)
