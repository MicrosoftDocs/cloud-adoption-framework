---
title: Manage and Monitor Oracle Workloads on Azure Virtual Machines Landing Zone Accelerator
description: Learn how to manage and monitor Oracle workloads on Azure Virtual Machines by using the landing zone accelerator. Optimize the health and performance of your deployments.
author: jessiehaessler
ms.author: jhaessler
ms.reviewer: ramakoni
ms.date: 06/24/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator

This article describes how to successfully manage and monitor Oracle on Azure Virtual Machines landing zone accelerator. This enterprise-scale scenario outlines important recommendations for the design of your environment. For more information, see [Management for Azure environments](../../ready/landing-zone/design-area/management.md).

This article describes key design considerations and best practices for how to manage your Oracle workload deployments on Virtual Machines landing zone accelerator. Because Oracle is a mission-critical and high-performance workload, you should include the guidance on the Azure landing zone design areas in your planning. To ensure the health of your mission-critical workloads, it's crucial to monitor Oracle workloads on Virtual Machines for failures and abnormalities.

## Monitor Oracle databases on Virtual Machines landing zone accelerator

The first step of monitoring is to set up general Azure virtual machine (VM) monitoring and define thresholds for key metrics. After you configure general VM and managed disk monitoring, the next step is to set up Oracle monitoring that's tailored to your environment.

### Log monitoring by Azure Monitor

To monitor an Oracle workload on Virtual Machines landing zone accelerator, you need to monitor VMs, attached managed disks, or applied storage accounts, such as Azure NetApp Files and Oracle Database on Virtual Machines. Azure Monitor provides several ways to monitor VM logs and managed disks for your Oracle workload.

The first step is to set up general VM and managed disk monitoring.

1. Enable [VM insights](/azure/azure-monitor/vm/vminsights-enable-portal).

1. Deploy Azure Monitor Agent and configure [data collection rules](/azure/azure-monitor/essentials/data-collection-rule-overview).

1. Collect [custom logs](/azure/azure-monitor/agents/data-collection-text-log?tabs=portal).

1. Monitor managed disk metrics.

    If you store Oracle database files in Azure managed disks, monitor the performance-related metrics for managed disks. Suitable managed disk SKUs for Oracle databases are Premium SSD, Premium SSD v2, and Ultra disk.

    Data disk performance metrics are important because the Oracle database files are stored on the managed disks. Consider the cumulative input/output operations per second (IOPS) and throughput of data disks when you use disk striping technologies, such as Oracle Automatic Storage Management or Linux Logical Volume Manager.

    > [!NOTE]
    > You can choose Non-Volatile Memory Express (NVMe)-based storage when required by your workload. NVMe is a high-performance storage protocol designed for flash storage, which provides low latency and high throughput. For most workloads that use an Oracle Database that's hosted on a compute node with NVMe storage, we recommend a block size of 128K.
    >
    > The block size refers to the amount of data that's read or written in a single input/output (I/O) operation. It plays a crucial role in how to determine storage performance, throughput, and latency. Keep in mind that the maximum throughput you can configure depends on the data size and disk type that you provision.

### Azure VM and managed disk metrics

The following table lists the performance metrics that the Oracle administrator should monitor.

| Name                                            | Thresholds (Severity) |
| ----------------------------------------------  | --------------------- |
| Percentage CPU > 95%                            | 95 (1)                |
| Percentage CPU >= 85%                           | 85 (1)                |
| Percentage CPU >= 75%                           | 75 (2)                |
| VmAvailabilityMetric < 1                        | < 1 (0)               |
| OS disk bandwidth consumed percentage > 95%     | 95 (1)                |
| OS disk bandwidth consumed percentage > 90%     | 90 (1)                |
| Available memory bytes < 500,000,000              | < 500,000,000 (1)       |
| VM cached bandwidth consumed percentage > 95%   | 95 (1)                |
| VM cached bandwidth consumed percentage > 85%   | 85 (2)                |
| VM cached bandwidth consumed percentage > 75%   | 75 (2)                |
| VM uncached bandwidth consumed percentage > 95% | 95 (1)                |
| VM uncached bandwidth consumed percentage > 85% | 85 (2)                |
| VM uncached bandwidth consumed percentage > 75% | 75 (2)                |
| Data disk IOPS consumed percentage > 95%        | 95 (1)                |
| Data disk IOPS consumed percentage > 85%        | 85 (2)                |
| Data disk IOPS consumed percentage > 75%        | 75 (2)                |
| Data disk read bytes > 95                       | 95 (1)                |
| Data disk read bytes > 85                       | 85 (2)                |
| Data disk read bytes > 75                       | 75 (2)                |
| Data disk writes bytes > 95                     | 95 (1)                |
| Data disk writes bytes > 85                     | 85 (2)                |
| Data disk writes bytes > 75                     | 75 (2)                |

> [!NOTE]
> In the **Severity** category, **0** has the highest severity and **2** has the lowest severity.

When you monitor disk metrics, it's important to ensure that you don't exceed the database VM limits. The specific limits for managed disks are detailed in the technical specifications for each VM SKU. For more information, see [Sizes for VMs in Azure](/azure/virtual-machines/sizes). When you select the appropriate VM SKU, refer to the table and column **Max uncached disk throughput: IOPS/MB/s** to see how multiple managed disks attached to the VM can cumulatively provide higher combined IOPS and throughput. If the database I/O requirements during peak load exceed the maximum uncached disk throughput of the VM, the VM's I/O operations might be throttled. If there's insufficient IOPS or storage throughput per disk, throttling might occur at both the VM and disk levels.

For more information, see [Disk metrics](/azure/virtual-machines/disks-metrics).

### Monitor Azure NetApp Files metrics

If the database files are stored in Azure NetApp Files volumes, monitor Azure NetApp Files allocated storage, storage usage, volume IOPS, throughput, and latency. For more information about how to monitor Azure NetApp Files and related performance metrics, see [Ways to monitor Azure NetApp Files](/azure/azure-netapp-files/monitor-azure-netapp-files) and [Metrics for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-metrics).

When you monitor Azure NetApp Files metrics, it's also important to monitor the VM's network bandwidth to ensure that its limit isn't exceeded. Because Azure NetApp Files volumes are mounted over the network by using the Network File System (NFS) protocol, they aren't restricted by the cumulative I/O throughput limits of any VM instance type. Instead, Azure NetApp Files is only limited by the network bandwidth of the database VM series. The specific limit for NFS-mounted storage is detailed in the column named **Max network bandwidth (MB/s)**. For more information about the technical specifications of the VM series, see [Edv5 and Edsv5-series](/azure/virtual-machines/edv5-edsv5-series).

### Configure the alerts for Azure VM metrics

Alerts in Azure Monitor can help you identify unhealthy resources. When you create a new VM, you can enable a set of recommended alert rules for common metrics. This initial set includes metrics such as CPU percentage and available memory. For more information, see [Enable recommended alert rules for VMs](/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended). You can also configure [advanced metric alert rules](/azure/azure-monitor/alerts/alerts-dynamic-thresholds) if you require situational monitoring.

Consider using [Azure Monitor Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/Overview/ALZ-Pattern/), which serves as a best practice collection of alerts for resources commonly deployed in Azure landing zones.

You should monitor managed disk-related metrics. If thresholds are exceeded, you should issue an alert.  
  
### Monitor related Azure services

 The following table lists other typical solution components that should be monitored in some capacity.

|Azure service |Description |More information |
|:---|:---|:---|
|Azure Virtual Network|Oracle database on Virtual Machines landing zone accelerator uses Virtual Network for availability set, availability zone, high availability, and business continuity and disaster recovery (BCDR) by using Oracle Data Guard and GoldenGate.| - [Virtual Network overview](/azure/virtual-network/virtual-networks-overview) <br><br> - [Monitoring Azure virtual network data reference](/azure/virtual-network/monitor-virtual-network-reference)
|Azure Backup|Monitor Backup and set an alert. Monitor the Oracle database alert log file on the database VM for lines that start with the following format: <br><br> `status – AzBackup – script – version: message` <br> Where: <br> - status = "INFO," "WARN," or "FAIL" <br> - AzBackup (boilerplate text) <br> - script = "pre-script" or "post-script"<br> - version = version number in decimal format <br> - message = free-format text <br><br> Example: `INFO - AzBackup pre-script v1.02: BEGIN BACKUP` | [Monitor at scale by using Azure Monitor Logs](/azure/backup/backup-azure-monitoring-use-azuremonitor) |
|Oracle database on a VM|Database alert log file and the OS console messages file. <br><br> - The database alert log file is typically located in the subdirectory `$ORACLE_BASE/diag/rdbms/$ORA_DBNAME/$ORACLE_SID/trace` on the database VM. <br><br> - OS console logs are located at `/var/log/messages`.| [Create an Oracle Database in an Azure VM](/azure/virtual-machines/workloads/oracle/oracle-database-quick-create) |

### Oracle workload monitoring by Oracle Enterprise Manager Cloud Control

Oracle Enterprise Manager is an Oracle integrated enterprise management product. It provides monitoring of events, incidents, and metrics related to target Oracle workloads.

- [Enterprise Manager Cloud Control](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Oracle Enterprise Manager downloads](https://www.oracle.com/enterprise-manager/downloads/cloud-control-downloads.html)
- [Monitoring best practices white paper for Enterprise Manager](https://blogs.oracle.com/observability/post/monitoring-best-practices-white-paper-for-enterprise-manager-13c-now-available)

### Azure Monitor and alerts

Use Azure Monitor to collect telemetry data and gain insights into the health, performance, and availability of your Azure resources. You can deploy Oracle Enterprise Manager on a separate VM to monitor, maintain, and manage Oracle environments. You can load Oracle Enterprise Manager text logs to Log Analytics and use them with Azure Monitor so that you can monitor all of these metrics in one place.

## Oracle diagnostic tools

| Approach and option| Description | More information  |
|-----|------|---|
| Automatic Workload Repository (AWR) | AWR has features for monitoring to collect, process, and maintain performance statistics for problem detection and self-tuning. These features help in historical analytics and problem identification. | [Gathering database statistics](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-9D3A3890-8E68-48C5-84D0-DB0A8D93C53A) |
| Statspack | Statspack gathers Oracle database instance statistics even in environments where AWR and Automatic Database Diagnostic Monitor aren't running. Statspack includes summaries and details of database statistics, wait events, and system statistics. | [Performance tuning with Statspack, part I](https://www.oracle.com/technetwork/database/performance/statspack-129989.pdf) <br><br> [Performance tuning with Statspack, part II](https://www.oracle.com/technetwork/database/performance/statspack-tuning-otn-new-128500.pdf) |
| Oracle Enterprise Manager diagnostics and tuning | The Oracle Diagnostics Pack provides automatic performance diagnostic and advanced system monitoring functionality. The Oracle Tuning Pack provides database administrators with expert performance management for the Oracle environment, including SQL tuning and storage optimizations. | [Diagnostics and tuning packs](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.5/performance.html) |

## Next steps

- [Strategic impact of Oracle on Azure landing zone accelerator](oracle-landing-zone-strategy.md)  
- [Plan for Oracle on Azure](oracle-landing-zone-plan.md)  
- [Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator](oracle-disaster-recovery-iaas.md)
