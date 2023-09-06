---
title: Manage and monitor Oracle workloads on Azure IaaS
description: Learn how to manage and monitor Oracle workloads on Azure IaaS
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

# Manage and monitor Oracle workloads on Azure IaaS

Monitoring and managing Oracle and underlying VMs on Azure is the key to maintaining your workload performance and free from failures. Strong practices described in this article must be followed to ensure you have highly available & reliable workload-based business operations on Azure as a possibility.

## Monitor Oracle database on Azure IaaS

Proper management and monitoring are critical to the success of Oracle on Azure IaaS. This enterprise-scale scenario outlines important recommendations for the design of your environment. More guidance is available in the [Azure enterprise-scale landing zone for management and monitoring](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management). Following the guidance, this article explains key design considerations and best practices around monitoring and management of your Oracle workload deployments on Microsoft Azure virtual machine (VM). Since Oracle is a mission-critical and high-performance workload, the guidance on the Azure landing zone design areas should also be included in your design. Monitoring Oracle workload on Azure VM to discover failures and abnormalities of infrastructure are two key things to ensure your mission critical workload runs healthy.

## Monitoring Oracle Databases on Azure IaaS

> [!NOTE]
> The first step of monitoring is to set up general Azure VM monitoring and define threshold for the metrics. After configuring the general Azure VM monitoring, the next step is to set up Oracle specified monitoring adapted to your environment.

### Log Monitoring by Azure Monitor

Oracle workload on Azure IaaS, you need to monitor VM and Oracle Database on Azure VM. Azure Monitor provides numerous ways to monitor log of the VM and Oracle workload.

The first step of monitoring for you is to set up general Azure VM monitoring.

1. Enable VM [insights](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-enable-portal)
2. Deploy AMA (Azure Monitoring Agent) and configure [DCR](https://learn.microsoft.com/azure/azure-monitor/essentials/data-collection-rule-overview) (Data Collection Rule)
3. Collect [custom logs].(https://learn.microsoft.com/azure/azure-monitor/agents/data-collection-text-log?tabs=portal)
4. Monitor Managed Disk Metrics:

>[!IMPORTANT]
>If you're storing Oracle database files in Azure managed disks, you should monitor the performance related metrics for managed disks. The types of storage suitable for Oracle databases are Premium SSD, Premium SSD v2, and Ultra disk. 
>Data disk performance metrics are important because the Oracle database files are stored on the managed disks. Consider the cumulative IOPS and throughput of data disks when disk striping technologies are used such as Oracle Automatic Storage Management (ASM) or Linux Logical Volume Manager (LVM).   
>Azure managed disk metrics
>The Oracle administrator should monitor disk performance metrics related to IO like the following:
>
>- OS Disk IOPS Consumed Percentage
>- Data Disk IOPS Consumed Percentage
>- Data Disk Read Bytes/Sec
>- Data Disk Write Bytes/Sec
>- Disk Queue Depth
>
>While monitoring the disk metrics, it's important to ensure that the database VM limits are not exceeded. VM limits specific to managed disks is detailed in the [Edsv5-series](https://learn.microsoft.com/azure/virtual-machines/edv5-edsv5-series#edsv5-series) section and table. Use the table and column **Max un cached disk throughput: IOPS/MBps** to see how multiple managed disks attached to the VM can cumulatively provide a higher combined IOPS and throughput. Note if the database IO requirements during peak load are higher than the VM max un cached disk throughput, the VM IO operations can be throttled. Alternatively, if there is insufficient IOPS and/or storage throughput per disk, throttling may happen at the disk level. 
> Refer to [Disk metrics - Azure virtual machines](https://learn.microsoft.com/azure/virtual-machines/disks-metrics) for more information about Disk performance related metrics.

5. Monitor Azure NetApp Files (ANF) metrics   
If the database files are stored in Azure NetApp Files (ANF) volumes, you should monitor ANF metrics for allocated storage, actual storage usage, volume IOPS, throughput and latency. Refer to the following articles to understand ways to monitor Azure NetApp Files and related performance metrics.

- [Ways to monitor Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/monitor-azure-netapp-files)
- [Metrics for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-metrics)

While monitoring ANF metrics, it's also important to monitor the VM’s network bandwidth and to ensure its limit isn't exceeded. ANF volume is mounted over the network using NFS protocol, ANF isn't restricted by the cumulative VM’s IO throughput limits on any VM instance type. Instead, ANF is restricted only by the network bandwidth on the database VM series. The VM limit specific to NFS-mounted storage is specified in the column named “Max network bandwidth (Mbps)”. See examples in the VM series technical specification [Edv5 and Edsv5-series](https://learn.microsoft.com/azure/virtual-machines/edv5-edsv5-series).

### Configure the alerts for Azure virtual machine metrics

1. Recommended alert rules for Azure virtual machines    

Alerts in Azure Monitor identify when a resource isn't healthy. When you create a new Azure virtual machine (VM), you can enable a set of recommended alert rules that  provide you with initial monitoring for a common set of metrics including CPU percentage and available memory. Learn about how to [Enable recommended alert rules for Azure VM](https://learn.microsoft.com/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended). You can also configure Advanced [metric alert rules](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-dynamic-thresholds) if you need more situational.

Recently, an initiative developed as an easy way to deploy alert rules. The purpose of this project is to focus on [monitoring for Azure Landing Zone](https://github.com/Azure/alz-monitor) as a common set of Azure resources/services that are configured in a similar way across organizations. 

2. Configure other recommended alert rules for Oracle Database as IaaS on Azure

| **Alert Rule Name** | **Condition** |
|---|---|
| OS Disk IOPS Consumed Percentage | OS Disk IOPS Consumed Percentage > 95 |
| Data Disk IOPS Consumed Percentage | Data Disk IOPS Consumed Percentage > 95 |
| Data Disk Read Bytes/Second | |
| Data Disk Write Bytes/Second | |
| Disk Queue Depth | |
  
### Monitor related Azure services
| | | |
|---|---|---|
| | | <https://learn.microsoft.com/azure/virtual-network/monitor-virtual-network><https://learn.microsoft.com/azure/virtual-network/monitor-virtual-network-reference><br> |
| | | |
| | | |

- _status_ = “INFO”, “WARN”, or “FAIL”
- _AzBackup_ (boilerplate text)
- _script_ = “pre-script" or “post-script"
- _version_ = version number in decimal format
- _message_ = free-format text

- Example:  INFO - AzBackup pre-script v1.02: BEGIN BACKUP
- Database “alert log” file is typically located in the subdirectory “$ORACLE_BASE/diag/rdbms/$ORA_DBNAME/$ORACLE_SID/trace” on the database VM.
- OS console log located at “/var/log/messages”

### Oracle workload monitoring by Oracle Enterprise Manager cloud control

Oracle Enterprise Manager is an Oracle integrated enterprise management product. It provides the monitoring features of events, incidents, metrics against the target Oracle workloads.

- [Manual](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Download](https://www.oracle.com/enterprise-manager/downloads/cloud-control-downloads.html)
- [Download](https://blogs.oracle.com/observability/post/monitoring-best-practices-white-paper-for-enterprise-manager-13c-now-available)

### Azure monitor and alerts

Utilize Azure Monitor to collect telemetry data and gain insights into the health, performance, and availability of your Azure resources. Oracle Enterprise Manager can be deployed on a separate VM to monitor, maintain, and manage Oracle environments. Oracle Enterprise Manager text logs can be loaded to Log Analytics and used with Azure Monitor for a single pane of glass monitoring.

## Oracle diagnostic tools

| | | |
|---|---|---|
| | | |
| | | |

- **Approach and options**
- Performance tuning with STATSPACK, part I:  <https://www.oracle.com/technetwork/database/performance/statspack-129989.pdf>
- Performance tuning with STATSPACK, part II:  https://www.oracle.com/technetwork/database/performance/statspack-tuning-otn-new-128500.pdf

## Next steps

Learn about design considerations for Oracle on Azure IaaS business continuity and disaster recovery in an enterprise-scale scenario.

[**Business continuity and disaster recovery for Oracle on Azure IaaS**](https://microsofteur.sharepoint.com/:w:/t/DataMod/EV0lkrFLXaNGnSkrAz8gLToB7fnA5hCCqhg0vA1zV7Do2g?e=TgAFlf)
