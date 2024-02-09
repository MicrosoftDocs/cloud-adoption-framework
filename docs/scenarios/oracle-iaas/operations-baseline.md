---
title: Operations baseline for Oracle workloads on Azure IaaS
description: Learn how to manage and monitor Oracle workloads Azure Virtual Machines  landing zone accelerator.
author: bamajeed
ms.author: bamajeed
ms.reviewer: jhaessler
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Operations Baseline for Oracle on Azure IaaS

This article builds on considerations and recommendations defined in the Azure landing zone article [Design area: Management for Azure environments](../../ready/landing-zone/design-area/management.md). The guidance in this article will help you explore how to operationally maintain an Oracle on Azure IaaS platform on an Azure enterprise estate, with centralized management and monitoring at the platform level.

This article presents critical recommendations for Oracle on Azure IaaS operations teams to maintain Oracle systems within the Azure platform. Because Oracle is a mission-critical and high-performance workload, you should include guidance on the Azure landing zone design areas in your design. Such recommendations include how to design suitable level of business continuity and disaster recovery and how to successfully manage and monitor Oracle on Azure Virtual Machines landing zone accelerator. This enterprise-scale scenario outlines important recommendations for the design of your environment. 

An architecture that meets business continuity and disaster recovery (BCDR) objectives provides the solid foundation on top of which you can build a successful management and monitoring capabilities to discover failures and abnormalities and to ensure the health of your mission critical workloads. BCDR approaches for Oracle on Azure IaaS workloads are covered in detail in [this article](./oracle-disaster-recovery-oracle-landing-zone.md). For the rest of this article the focus is on monitoring and diagnostics of your Oracle workload on Azure IaaS.

For Oracle workloads on Azure IaaS, first you can make use of the Azure platform native monitoring capabilities to monitor the virtual machines and storage components such as managed disks and Azure NetApp Files. Then you can use Oracle specified monitoring and diagnostics tools to make sure that your databases are operating at the required levels.

## Monitor Oracle workloads using Azure Monitor

When you have critical applications and business processes that rely on Azure resources, you want to monitor those resources for their availability, performance, and operation. Azure Monitor is a full-stack monitoring service that provides a complete set of features to monitor your Azure resources.

### Azure VM metrics and Logs monitoring

Oracle workloads on Azure Virtual Machines can benefit from the Azure monitor capabilities to monitor both the performance metrics and the logs emitted from the virtual machines. For example, VM Insights provides a quick and easy method for getting started monitoring the workloads on your virtual machines. You can also set up more detailed metrics monitoring and logs collection. Here are some links that gives you a starting point for your VM monitoring:

1. Enable Virtual Machine [insights](/azure/azure-monitor/vm/vminsights-enable-portal).
2. Deploy AMA (Azure Monitoring Agent) and configure [DCR](/azure/azure-monitor/essentials/data-collection-rule-overview) (Data Collection Rule).
3. Collect [custom logs](/azure/azure-monitor/agents/data-collection-text-log?tabs=portal).

### Monitor Managed Disk Metrics

If you're storing Oracle database files in Azure managed disks, you should monitor the performance related metrics for managed disks. Suitable managed disk SKUs for Oracle databases are Premium SSD, Premium SSD v2, and Ultra disk.
Data disk performance metrics are important because the Oracle database files are stored on the managed disks. Consider the cumulative IOPS and throughput of data disks when disk striping technologies are used such as Oracle Automatic Storage Management (classic deployment model) or Linux Logical Volume Manager (LVM).

The Oracle administrator should monitor disk performance metrics related to IO like the following metrics:

    - OS Disk IOPS Consumed Percentage
    - Data Disk IOPS Consumed Percentage
    - Data Disk Read Bytes/Sec
    - Data Disk Write Bytes/Sec
    - Disk Queue Depth

While monitoring the disk metrics, it's important to ensure that the database Virtual Machine limits aren't exceeded. Virtual Machine limits specific to managed disks are detailed in the technical specifications for the individual VM SKUs. For more information, see  [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

While selecting the appropriate VM SKU, use the table and column **Max uncached disk throughput: IOPS/MBps** to see how multiple managed disks attached to the Virtual Machine can cumulatively provide a higher combined IOPS and throughput. Note if the database IO requirements during peak load are higher than the Virtual Machine max uncached disk throughput, the Virtual Machine IO operations can be throttled. Alternatively, if there's insufficient IOPS and/or storage throughput per disk, throttling can occur at the disk level.

For more information about Disk performance related metrics, see [Disk metrics - Azure Virtual Machines](/azure/virtual-machines/disks-metrics).

### Monitor Azure NetApp Files (ANF) metrics 

If the database files are stored in Azure NetApp Files (ANF) volumes, you should monitor ANF metrics for allocated storage, actual storage usage, volume IOPS, throughput and latency. Refer to the following articles to understand ways to monitor Azure NetApp Files and related performance metrics.

- [Monitor Azure NetApp Files](/azure/azure-netapp-files/monitor-azure-netapp-files)

- [Metrics for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-metrics)

While monitoring ANF metrics, it's also important to monitor the Virtual Machine’s network bandwidth to ensure its limit isn't exceeded. ANF volume is mounted over the network using NFS protocol, it isn't restricted by the cumulative Virtual Machines IO throughput limits on any Virtual Machine instance type. Instead, ANF is only restricted by the network bandwidth on the database Virtual Machine series. The Virtual Machine limit specific to NFS-mounted storage is specified in the column named “Max network bandwidth (Mbps)”. For examples, see the VM series technical specification [Edv5 and Edsv5-series](/azure/virtual-machines/edv5-edsv5-series).

### Configure the alerts for Azure virtual machine metrics

Alerts in Azure Monitor identify unhealthy resources and informs the monitoring team in order to take the necessary corrective action. When you create a new Azure virtual machine (VM), you can enable a set of recommended alert rules for a common set of metrics. This initial set of common metrics includes CPU percentage and available memory. For more information, see [Enable recommended alert rules for Azure VM](/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended). You can also configure Advanced [metric alert rules](/azure/azure-monitor/alerts/alerts-dynamic-thresholds) if you would like advanced machine learning algorithms to learn the behavior of your infrastructure.

The following are some of the important disk related metrics that should also be monitored. If thresholds are exceeded, it's recommended that an alert is issued.  

|Alert Rule Name |Condition |
|:---|:---|
|OS Disk IOPS Consumed Percentage | OS Disk IOPS Consumed Percentage > 95 |
|Data Disk IOPS Consumed Percentage | Data Disk IOPS Consumed Percentage > 95 |
|Data Disk Read Bytes/Second | Adjust to system performance trends|
|Data Disk Write Bytes/Second | Adjust to system performance trends|
|Disk Queue Depth | Adjust to system performance trends |
  
### Monitor related Azure services

A typical Oracle workload on Azure IaaS would include other Azure services which also need to be monitored in order to make sure that the overall solution is healthy. Such services include Azure Virtual Network, Azure Backup and potentially other services.

[Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) is a critical component that the Oracle workload on Azure IaaS depends on, for example for High Availability and BCDR using Data Guard and Golden Gate and for the performance of the applications that depend on the Oracle database. To set up your Azure virtual network monitoring see [Monitoring Azure virtual network data reference](/azure/virtual-network/monitor-virtual-network-reference).

Azure Backup can be used to take disk snapshots of virtual machine disks, which include the Oracle Database files and the Oracle fast recovery area. By using Azure Backup, you can take full disk snapshots that are suitable as backups and are stored in a Recovery Services vault. Azure Backup also provides application-consistent backups, which ensure that more fixes aren't required to restore the data. Application-consistent backups work with both file system and Oracle Automatic Storage Management (ASM) databases. Azure Backup can be monitored and alerts can be set up against its metrics as explained in [Monitor at scale by using Azure monitor](/azure/backup/backup-azure-monitoring-use-azuremonitor).

### Oracle workload monitoring by Oracle Enterprise Manager cloud control

Oracle Enterprise Manager is an Oracle integrated enterprise management product. It provides the monitoring features of events, incidents, metrics against the target Oracle workloads.

- [Manual](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Download](https://www.oracle.com/enterprise-manager/downloads/cloud-control-downloads.html)
- [Monitoring Best Practices](https://blogs.oracle.com/observability/post/monitoring-best-practices-white-paper-for-enterprise-manager-13c-now-available)

Oracle Enterprise Manager can be deployed on a separate Virtual Machine to monitor, maintain, and manage Oracle environments. Oracle Enterprise Manager text logs can be loaded to Log Analytics and used with Azure Monitor for a single pane of glass monitoring.

## Oracle diagnostic tools

Oracle provides a number of native tools to help you explore and analyze your database performance. For example you can use the built-in Automatic Workload Repository (AWR) which collects, processes and maintains performance statistics of the database. See [Gathering database statistics](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-9D3A3890-8E68-48C5-84D0-DB0A8D93C53A).

For environments where the AWR is not running you can use Statspack. The Statspack package is a set of SQL, PL/SQL, and SQL*Plus scripts that allow the collection, automation, storage, and viewing of performance data. Statspack stores the performance statistics permanently in Oracle tables, which can later be used for reporting and analysis. The data collected can be analyzed using Statspack reports, which includes an instance health and load summary page, high resource SQL statements, and the traditional wait events and initialization parameters. For more information see [DIAGNOSING PERFORMANCE USING STATSPACK](https://www.oracle.com/technetwork/database/performance/statspack-129989.pdf) and [Performance tuning with STATSPACK](https://www.oracle.com/technetwork/database/performance/statspack-tuning-otn-new-128500.pdf)

