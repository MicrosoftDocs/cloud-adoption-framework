---
title: Management recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to manage AI workloads on Azure infrastructure (IaaS).
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Management recommendations for AI workloads on Azure infrastructure (IaaS)

This article provides management recommendations for organizations running AI workloads on Azure infrastructure (IaaS). Effective management of AI workloads on Azure requires continuous monitoring, optimization practices, and a strong backup and recovery strategy. These efforts minimize downtime and ensure reliability in AI operations.

## Monitor AI infrastructure

Monitoring AI infrastructure involves tracking and evaluating the performance, health, and availability of all components in an AI deployment on Azure IaaS. Proactive monitoring allows organizations to detect and resolve potential issues before they affect operations.

- *Ensure monitoring by default.* Deploy the required Azure Monitor agents for virtual machines and Azure Virtual Machine Scale Sets, including Azure Arc connected servers. Connect them to the central Log Analytics workspace in the management subscription. Consider using [Azure Monitor Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/welcome/) (AMBA).

- *Use Azure Update Manager.* You can monitor Windows and Linux update compliance across your machines in Azure and on-premises/on other cloud platforms (connected by [Azure Arc](/azure/azure-arc/)) from a single pane of management. You can also use Update Manager to make real-time updates or schedule them within a defined maintenance window.

- *Monitor virtual machines.* [Monitor](/azure/virtual-machines/monitor-vm) virtual machine (VM) host data (physical host) and VM guest data (operating system and application). Consider using [VM Insights](/azure/azure-monitor/vm/vminsights-enable-overview) to simplify the onboarding, access predefined performance charts, and utilize dependency mapping. Track Spot VM evictions and maintenance events to manage interruptions effectively. [Learn more about scheduled events](/azure/virtual-machines/linux/scheduled-events).

- *Monitor networks.* [Monitor and diagnose](/azure/network-watcher/network-watcher-overview) networking issues without logging into your VMs. Get real-time performance information at the packet level. Troubleshoot performance issues with the [Performance Diagnostics tool](/troubleshoot/azure/virtual-machines/windows/performance-diagnostics). [Track](/azure/network-watcher/network-insights-overview) topology, health, and metrics for all deployed network resources.

- *Monitor storage.* Monitor the performance of storage, such as local SSDs, [attached disks](/azure/virtual-machines/disks-metrics), file shares, and [Azure storage accounts](/azure/azure-monitor/insights/storage-insights-overview).

- *Use orchestrator monitoring capabilities (if applicable).* Consider using the built-in monitoring capabilities of orchestrators like Azure CycleCloud, Azure Batch, and Azure Kubernetes Service (AKS). Follow the guidance for the orchestrator you chose:

    - *Azure CycleCloud or Azure CycleCloud Workspace for Slurm:* Track CPU, disk, and network metrics. Store data from Azure CycleCloud clusters to Log Analytics and create custom metrics dashboards. For more information, see [Monitoring Azure CycleCloud](/azure/cyclecloud/concepts/monitoring). [Node Health Checks](https://github.com/Azure/azurehpc-health-checks#Configuration) are a set of automated tests to ensure that your HPC/AI hardware is healthy. You can run this check in Azure CycleCloud as part of cluster deployment or separately using the GitHub repo instructions. Ensure that you pay attention to the compatibility matrix in the documentation. Run where appropriate to ensure that you identify any unhealthy nodes before running your AI workloads.

    - *Azure Batch:* Collect job and task metrics such as active tasks, task duration, job start time, duration, task start time. Also collect pool metrics, such as idle nodes, running nodes, CPU usage, Disk I/O. For more information, see [Azure Batch monitoring](/azure/batch/monitor-batch).

    - [*Azure Kubernetes Service*](/azure/architecture/reference-architectures/containers/aks-gpu/gpu-aks). Use Azure Monitor for containers. Monitor pod performance, node health, and resource utilization. Set up alerts and custom dashboards.

## Manage business continuity and disaster recovery

Managing business continuity and disaster recovery for AI applications on Azure ensures that organizations can recover quickly from disruptions. By implementing strategies such as real-time replication, automated recovery, and regular backups, organizations safeguard their AI infrastructure against data loss and operational downtime.

- *Use Azure Site Recovery.* Site Recovery uses real-time replication and recovery automation to replicate workloads across regions. Built-in platform capabilities for VM workloads meet low RPO and RTO requirements. You can use Site Recovery to run recovery drills without affecting production workloads. You can also use Azure Policy to enable replication and to audit VM protection.

- *Use orchestrator capabilities (if applicable)*. Use your orchestrator to recover failed compute nodes. For example, configure Azure Batch to automatically [retry tasks](/azure/batch/best-practices#pool-allocation-failures) if there's failure.

- *Schedule backups.* Determine if you need to backup incremental changes to datasets and models daily or weekly. Backups could also include databases or entire datasets.

- *Ensure data compliance.* Make sure your backup strategy complies with data protection regulations. Comply with data residency requirements and store backups in appropriate geographic locations.

- *Create snapshots.* You can use the capabilities of your scheduler to take snapshots. For example, [CycleCloud](/azure/cyclecloud/how-to/backup-and-restore) can take point-in-time snapshots of the underlying application datastore as recovery points.

## Next step

> [!div class="nextstepaction"]
> [Secure IaaS AI](./security.md)
